#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install prerequisites
echo "Installing prerequisites..."
sudo apt install -y software-properties-common

# Add the deadsnakes PPA to get the latest Python version
echo "Adding deadsnakes PPA..."
sudo add-apt-repository -y ppa:deadsnakes/ppa

# Update package list again
echo "Updating package list..."
sudo apt update

# Install Python 3 (latest version from the deadsnakes PPA)
echo "Installing Python 3..."
sudo apt install -y python3

# Install pip for Python 3
echo "Installing pip for Python 3..."
sudo apt install -y python3-pip

# Verify installations
echo "Verifying Python and pip installations..."
python3 --version
pip3 --version

echo "Python and pip installation completed!"
