#! /bin/bash

# Default arguments
VENV_NAME=".venv"
VENV_LOCATION="."
PYTHON_PATH="python"

# Function to display usage
usage() {
  echo "Usage: $0 [-n venv_name] [-l location] [-p python_path] [-h]"
  echo "  -n venv_name    Name of the virtual environment (default: .venv)"
  echo "  -l location     Location to create the virtual environment (default: current directory)"
  echo "  -p python_path  Path to the Python interpreter (default: python)"
  echo "  -h              Display this help message"
  exit 1
}

# Parse command line arguments
while getopts "n:l:p:h" opt; do
  case $opt in
    n) VENV_NAME=$OPTARG ;;
    l) VENV_LOCATION=$OPTARG ;;
    p) PYTHON_PATH=$OPTARG ;;
    h) usage ;;
    *) usage ;;
  esac
done

# Full path to the virtual environment
VENV_PATH="$VENV_LOCATION/$VENV_NAME"

# Check if the virtual environment already exists
if [ -d "$VENV_PATH" ]; then
  read -rp "The virtual environment '$VENV_PATH' already exists. Do you want to delete it and create a new one? (y/n): " choice
  if [ "$choice" != "y" ]; then
    echo "Exiting without creating a new virtual environment."
    exit 0
  else
    rm -rf "$VENV_PATH"
  fi
fi

# Create the virtual environment
$PYTHON_PATH -m venv "$VENV_PATH"

# Check the operating system and activate the virtual environment accordingly
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
  source "$VENV_PATH/bin/activate"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
  source "$VENV_PATH/Scripts/activate"
else
  echo "Unsupported OS"
  exit 1
fi

# Upgrade pip
python -m pip install --upgrade pip

# Install packages from requirements.txt
if [ -f "requirements.txt" ]; then
  pip install -r requirements.txt
else
  echo "requirements.txt not found. No packages installed."
fi

# Install local package
pip install -e .[all]

echo "Virtual environment '$VENV_NAME' is ready."
