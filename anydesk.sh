#!/bin/bash

# Update the package list
sudo apt update

# Install dependencies
sudo apt install -y wget gnupg

# Download AnyDesk Debian package signing key
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -

# Add AnyDesk repository to the sources list
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list

# Update the package list again
sudo apt update

# Install AnyDesk
sudo apt install -y anydesk

# Print installation success message
echo "AnyDesk installation complete."
