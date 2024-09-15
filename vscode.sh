#!/bin/bash

# Update the package list
sudo apt update

# Install prerequisites
sudo apt install -y wget apt-transport-https software-properties-common

# Import the Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Add the Visual Studio Code repository
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Update the package list again
sudo apt update

# Install Visual Studio Code
sudo apt install -y code

# Print installation success message
echo "Visual Studio Code installation complete."
