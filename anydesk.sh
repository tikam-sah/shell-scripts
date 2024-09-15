#!/bin/bash

# Define the URL for the AnyDesk Debian package
ANYDESK_URL="https://download.anydesk.com/linux/anydesk_6.3.1-1_amd64.deb"

# Define the filename for the downloaded package
DEB_FILE="anydesk.deb"

# Update package list
echo "Updating package list..."
sudo apt update

# Download the AnyDesk Debian package
echo "Downloading AnyDesk..."
wget -O $DEB_FILE $ANYDESK_URL

# Install AnyDesk
echo "Installing AnyDesk..."
sudo dpkg -i $DEB_FILE

# Fix any missing dependencies
echo "Fixing dependencies..."
sudo apt-get install -f

# Clean up
echo "Cleaning up..."
rm $DEB_FILE

echo "AnyDesk installation completed!"
