#!/bin/bash

# Update package list and install prerequisites
sudo apt update
sudo apt install -y wget gpg

# Import the Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft-archive-keyring.gpg

# Add the Visual Studio Code repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

# Update package list again
sudo apt update

# Install Visual Studio Code
sudo apt install -y code

echo "Visual Studio Code has been installed successfully!"
