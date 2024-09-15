#!/bin/bash

# Define the URL for the Google Chrome Debian package
CHROME_DEB_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install wget if it's not already installed
if ! command_exists wget; then
    echo "Installing wget..."
    sudo apt-get install -y wget
fi

# Download the Google Chrome Debian package
echo "Downloading Google Chrome..."
wget -q "$CHROME_DEB_URL" -O google-chrome-stable_current_amd64.deb

# Install the Google Chrome package
echo "Installing Google Chrome..."
sudo dpkg -i google-chrome-stable_current_amd64.deb

# Fix any dependency issues
echo "Fixing dependencies..."
sudo apt-get install -f -y

# Optionally, add the Google Chrome repository
read -p "Do you want to add the Google Chrome repository for future updates? (y/n) " add_repo

if [ "$add_repo" == "y" ]; then
    echo "Adding Google Chrome repository..."
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo apt-get update
fi

# Clean up
echo "Cleaning up..."
rm google-chrome-stable_current_amd64.deb

echo "Google Chrome installation completed."

# Launch Google Chrome (optional)
read -p "Do you want to launch Google Chrome now? (y/n) " launch_chrome

if [ "$launch_chrome" == "y" ]; then
    google-chrome &
fi
