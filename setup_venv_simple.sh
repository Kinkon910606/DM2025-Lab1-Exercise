#!/bin/bash
# Simple Virtual Environment Setup Script for DM2025-Lab1-Exercise
# This script creates a new virtual environment and installs dependencies directly

set -e  # Exit on any error

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_NAME="dm2025-lab1-venv"
VENV_PATH="$PROJECT_DIR/$VENV_NAME"

echo "=== DM2025 Lab1 Exercise Virtual Environment Setup (Simple) ==="
echo "Project directory: $PROJECT_DIR"
echo "Virtual environment: $VENV_PATH"
echo ""

# Check Python version
PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
echo "Current Python version: $PYTHON_VERSION"

# Check if Python version meets requirements (>=3.9)
if python3 -c "import sys; exit(0 if sys.version_info >= (3, 9) else 1)"; then
    echo "✓ Python version meets minimum requirements (>=3.9)"
else
    echo "✗ Python version must be >= 3.9"
    exit 1
fi

# Create virtual environment
echo ""
echo "Creating virtual environment..."
if [ -d "$VENV_PATH" ]; then
    echo "Virtual environment already exists at $VENV_PATH"
    read -p "Do you want to remove it and create a new one? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$VENV_PATH"
        echo "Removed existing virtual environment"
    else
        echo "Using existing virtual environment"
    fi
fi

if [ ! -d "$VENV_PATH" ]; then
    python3 -m venv "$VENV_PATH"
    echo "✓ Virtual environment created at $VENV_PATH"
fi

# Activate virtual environment
echo ""
echo "Activating virtual environment..."
source "$VENV_PATH/bin/activate"

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install dependencies directly
echo ""
echo "Installing dependencies..."
pip install jupyter>=1.1.1 \
            matplotlib>=3.9.4 \
            nltk>=3.9.1 \
            numpy>=2.0.2 \
            pami>=2025.7.3.1 \
            pandas>=2.3.2 \
            plotly>=6.3.0 \
            scikit-learn>=1.6.1 \
            seaborn>=0.13.2 \
            umap-learn>=0.5.9.post2 \
            wordcloud>=1.9.3

echo "✓ Dependencies installed successfully"

echo ""
echo "=== Setup Complete ==="
echo ""
echo "To activate the virtual environment in the future, run:"
echo "source $VENV_PATH/bin/activate"
echo ""
echo "To deactivate the virtual environment, run:"
echo "deactivate"
echo ""
echo "To run Jupyter notebook:"
echo "source $VENV_PATH/bin/activate && jupyter notebook"
echo ""
echo "Current Python path: $(which python)"
echo "Current pip path: $(which pip)"
echo ""
echo "Installed packages:"
pip list --format=columns