#!/bin/bash

# This script should be called from the root directory

# Default arguments
ENV_NAME=".conda"
PYTHON_VERSION="3.12"

# Function to display usage
usage() {
  echo "Usage: $0 [-n env_name] [-p python_version] [-h]"
  echo "  -n env_name        Name of the conda environment (default: .conda)"
  echo "  -p python_version  Python version to use (default: 3.10.15)"
  echo "  -h                 Display this help message"
  exit 1
}

# Parse command line arguments
while getopts "n:p:h" opt; do
  case $opt in
    n) ENV_NAME="$OPTARG" ;;
    p) PYTHON_VERSION="$OPTARG" ;;
    h) usage ;;
    *) usage ;;
  esac
done

# Path to conda.sh - this is usually in your Anaconda or Miniconda installation
# This is necessary for activating the environment
CONDA_BASE=$(conda info --base)
source "$CONDA_BASE/etc/profile.d/conda.sh"

# Create the environment
conda create -n "$ENV_NAME" -y python="$PYTHON_VERSION" htop make gcc
conda activate "$ENV_NAME"

# Install Python dependencies
make deps
