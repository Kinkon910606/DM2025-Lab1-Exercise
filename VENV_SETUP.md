# Virtual Environment Setup for DM2025-Lab1-Exercise

This document provides terminal commands to create a new virtual environment and install dependencies from `pyproject.toml`.

## Quick Start (Automated)

Use the provided setup script:

```bash
# Make script executable (if not already)
chmod +x setup_venv.sh

# Run the setup script
./setup_venv.sh
```

## Manual Setup (Step by Step)

### 1. Create Virtual Environment

```bash
# Create a new virtual environment
python3 -m venv dm2025-lab1-venv

# Activate the virtual environment
source dm2025-lab1-venv/bin/activate
```

### 2. Upgrade pip

```bash
# Upgrade pip to latest version
pip install --upgrade pip
```

### 3. Install Dependencies

```bash
# Install project dependencies from pyproject.toml
pip install -e .
```

## Alternative: Using uv (if available)

If you have `uv` installed:

```bash
# Create virtual environment with uv
uv venv dm2025-lab1-venv

# Activate the environment
source dm2025-lab1-venv/bin/activate

# Install dependencies
uv pip install -e .
```

## Daily Usage Commands

### Activate Environment
```bash
source dm2025-lab1-venv/bin/activate
```

### Deactivate Environment
```bash
deactivate
```

### Install Additional Packages
```bash
pip install package_name
```

### List Installed Packages
```bash
pip list
```

### Run Jupyter Notebook
```bash
# After activating the environment
jupyter notebook
```

### Run the Main Script
```bash
# After activating the environment
python main.py
```

## Troubleshooting

### Python Version Issues
This project requires Python >= 3.9 and < 3.13. Check your version with:
```bash
python3 --version
```

### Virtual Environment Already Exists
If you need to recreate the environment:
```bash
rm -rf dm2025-lab1-venv
python3 -m venv dm2025-lab1-venv
source dm2025-lab1-venv/bin/activate
pip install --upgrade pip
pip install -e .
```

### Permission Issues
If you get permission errors:
```bash
chmod +x setup_venv.sh
```

## Project Dependencies

The project includes the following main dependencies:
- jupyter >= 1.1.1
- matplotlib >= 3.9.4
- nltk >= 3.9.1
- numpy >= 2.0.2
- pami >= 2025.7.3.1
- pandas >= 2.3.2
- plotly >= 6.3.0
- scikit-learn >= 1.6.1
- seaborn >= 0.13.2
- umap-learn >= 0.5.9.post2

All dependencies are automatically installed when you run `pip install -e .`