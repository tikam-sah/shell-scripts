#!/bin/bash

# Update package list and install required dependencies
echo "Updating package list and installing dependencies..."
sudo apt update
sudo apt install -y apt-transport-https ca-certificates wget

# Import Sublime Text GPG key
echo "Adding Sublime Text GPG key..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# Add the Sublime Text APT repository
echo "Adding Sublime Text APT repository..."
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Update package list again to include the new repository
echo "Updating package list..."
sudo apt update

# Install Sublime Text
echo "Installing Sublime Text..."
sudo apt install -y sublime-text

# Confirmation message
echo "Sublime Text installation is complete!"

# Optionally, you can open Sublime Text immediately
# echo "Launching Sublime Text..."
# sublime-text
