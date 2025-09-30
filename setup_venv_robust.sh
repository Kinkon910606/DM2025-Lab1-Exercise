#!/bin/bash
# Robust Virtual Environment Setup Script for DM2025-Lab1-Exercise
# Handles network issues and provides multiple installation methods

set -e  # Exit on any error

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_NAME="dm2025-lab1-venv"
VENV_PATH="$PROJECT_DIR/$VENV_NAME"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== DM2025 Lab1 Exercise Virtual Environment Setup (Robust) ===${NC}"
echo -e "Project directory: ${YELLOW}$PROJECT_DIR${NC}"
echo -e "Virtual environment: ${YELLOW}$VENV_PATH${NC}"
echo ""

# Check Python version
PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
echo -e "Current Python version: ${YELLOW}$PYTHON_VERSION${NC}"

# Check if Python version meets requirements (>=3.9)
if python3 -c "import sys; exit(0 if sys.version_info >= (3, 9) else 1)"; then
    echo -e "${GREEN}✓ Python version meets minimum requirements (>=3.9)${NC}"
else
    echo -e "${RED}✗ Python version must be >= 3.9${NC}"
    exit 1
fi

# Create virtual environment
echo ""
echo -e "${BLUE}Creating virtual environment...${NC}"
if [ -d "$VENV_PATH" ]; then
    echo -e "${YELLOW}Virtual environment already exists at $VENV_PATH${NC}"
    read -p "Do you want to remove it and create a new one? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$VENV_PATH"
        echo -e "${GREEN}Removed existing virtual environment${NC}"
    else
        echo -e "${YELLOW}Using existing virtual environment${NC}"
    fi
fi

if [ ! -d "$VENV_PATH" ]; then
    python3 -m venv "$VENV_PATH"
    echo -e "${GREEN}✓ Virtual environment created at $VENV_PATH${NC}"
fi

# Activate virtual environment
echo ""
echo -e "${BLUE}Activating virtual environment...${NC}"
source "$VENV_PATH/bin/activate"

# Upgrade pip
echo -e "${BLUE}Upgrading pip...${NC}"
pip install --upgrade pip --timeout 60 || {
    echo -e "${YELLOW}Warning: Could not upgrade pip due to network issues${NC}"
    echo -e "${YELLOW}You can upgrade pip later with: pip install --upgrade pip${NC}"
}

# Define dependency list
DEPENDENCIES=(
    "jupyter>=1.1.1"
    "matplotlib>=3.9.4"
    "nltk>=3.9.1"
    "numpy>=2.0.2"
    "pami>=2025.7.3.1"
    "pandas>=2.3.2"
    "plotly>=6.3.0"
    "scikit-learn>=1.6.1"
    "seaborn>=0.13.2"
    "umap-learn>=0.5.9.post2"
    "wordcloud>=1.9.3"
)

# Function to install with retry and timeout
install_package() {
    local package=$1
    local retries=3
    local timeout=120
    
    for ((i=1; i<=retries; i++)); do
        echo -e "${BLUE}Installing $package (attempt $i/$retries)...${NC}"
        if pip install "$package" --timeout $timeout; then
            echo -e "${GREEN}✓ Successfully installed $package${NC}"
            return 0
        else
            echo -e "${YELLOW}⚠ Failed to install $package (attempt $i/$retries)${NC}"
            if [ $i -eq $retries ]; then
                echo -e "${RED}✗ Failed to install $package after $retries attempts${NC}"
                return 1
            fi
            sleep 5  # Wait before retry
        fi
    done
}

# Install dependencies
echo ""
echo -e "${BLUE}Installing dependencies...${NC}"
FAILED_PACKAGES=()

for package in "${DEPENDENCIES[@]}"; do
    if ! install_package "$package"; then
        FAILED_PACKAGES+=("$package")
    fi
done

# Summary
echo ""
echo -e "${BLUE}=== Installation Summary ===${NC}"

if [ ${#FAILED_PACKAGES[@]} -eq 0 ]; then
    echo -e "${GREEN}✓ All dependencies installed successfully!${NC}"
else
    echo -e "${YELLOW}⚠ Some packages failed to install:${NC}"
    for package in "${FAILED_PACKAGES[@]}"; do
        echo -e "  ${RED}✗ $package${NC}"
    done
    echo ""
    echo -e "${YELLOW}You can try installing them manually later:${NC}"
    for package in "${FAILED_PACKAGES[@]}"; do
        echo -e "  pip install $package"
    done
fi

echo ""
echo -e "${BLUE}=== Setup Complete ===${NC}"
echo ""
echo -e "To activate the virtual environment in the future:"
echo -e "  ${GREEN}source $VENV_PATH/bin/activate${NC}"
echo ""
echo -e "To deactivate the virtual environment:"
echo -e "  ${GREEN}deactivate${NC}"
echo ""
echo -e "To run Jupyter notebook:"
echo -e "  ${GREEN}source $VENV_PATH/bin/activate && jupyter notebook${NC}"
echo ""
echo -e "Current Python path: ${YELLOW}$(which python)${NC}"
echo -e "Current pip path: ${YELLOW}$(which pip)${NC}"

# Show installed packages if any were successful
if [ ${#FAILED_PACKAGES[@]} -lt ${#DEPENDENCIES[@]} ]; then
    echo ""
    echo -e "${BLUE}Installed packages:${NC}"
    pip list --format=columns 2>/dev/null || echo "Could not list packages"
fi

echo ""
echo -e "${BLUE}Manual installation commands (if needed):${NC}"
echo "source $VENV_PATH/bin/activate"
for package in "${FAILED_PACKAGES[@]}"; do
    echo "pip install $package"
done