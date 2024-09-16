#!/bin/bash

# Check if a project directory name was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <project>"
    exit 1
fi

PROJECT_NAME=$1

# Create project directory
mkdir $PROJECT_NAME
cd $PROJECT_NAME

# Create virtual environment
python3 -m venv env

# Activate virtual environment
source env/bin/activate

# Install example package
pip install requests

# Print success message
echo "Virtual environment setup complete and 'requests' installed."
