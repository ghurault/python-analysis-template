#!/bin/bash

# Default virtual environment name and location
VENV_NAME=".venv"
VENV_LOCATION="."

# Check if a custom name is provided
if [ ! -z "$1" ]; then
  VENV_NAME="$1"
fi

# Check if a custom location is provided
if [ ! -z "$2" ]; then
  VENV_LOCATION="$2"
fi

# Full path to the virtual environment
VENV_PATH="$VENV_LOCATION/$VENV_NAME"

# Check if the virtual environment already exists
if [ -d "$VENV_PATH" ]; then
  read -p "The virtual environment '$VENV_PATH' already exists. Do you want to delete it and create a new one? (y/n): " choice
  if [ "$choice" != "y" ]; then
    echo "Exiting without creating a new virtual environment."
    exit 0
  else
    rm -rf "$VENV_PATH"
  fi
fi

# Create the virtual environment
python -m venv "$VENV_PATH"

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

echo "Virtual environment '$VENV_NAME' is ready."
