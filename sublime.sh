#!/bin/bash

# Define the Sublime Text repository URL and the GPG key URL
SUBLIME_REPO_URL="https://download.sublimetext.com/"
GPG_KEY_URL="https://download.sublimetext.com/sublimehq-pub.gpg"

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

# Install GPG key for the Sublime Text repository
echo "Adding Sublime Text GPG key..."
wget -qO - "$GPG_KEY_URL" | sudo apt-key add -

# Add the Sublime Text repository
echo "Adding Sublime Text repository..."
echo "deb https://download.sublimetext.com/ apt/stable/ contrib" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Update package list again to include the Sublime Text repository
echo "Updating package list..."
sudo apt-get update

# Install Sublime Text
echo "Installing Sublime Text..."
sudo apt-get install -y sublime-text

echo "Sublime Text installation completed."

# Launch Sublime Text (optional)
read -p "Do you want to launch Sublime Text now? (y/n) " launch_sublime

if [ "$launch_sublime" == "y" ]; then
    sublime-text &
fi
