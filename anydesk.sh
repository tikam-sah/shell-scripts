#!/bin/bash

# Define the URL for the latest AnyDesk Debian package
ANYDESK_URL="https://download.anydesk.com/linux/anydesk_amd64.deb"

# Define the filename for the downloaded package
DEB_FILE="anydesk_latest.deb"

# Update package list
echo "Updating package list..."
sudo apt update

# Download the AnyDesk Debian package
echo "Downloading AnyDesk..."
wget -O $DEB_FILE $ANYDESK_URL

# Check if wget succeeded
if [ $? -ne 0 ]; then
    echo "Failed to download AnyDesk package. Exiting."
    exit 1
fi

# Install AnyDesk
echo "Installing AnyDesk..."
sudo dpkg -i $DEB_FILE

# Check if dpkg succeeded
if [ $? -ne 0 ]; then
    echo "Failed to install AnyDesk. Fixing dependencies..."
    sudo apt-get install -f
    if [ $? -ne 0 ]; then
        echo "Failed to fix dependencies. Exiting."
        exit 1
    fi
fi

# Clean up
echo "Cleaning up..."
rm $DEB_FILE

echo "AnyDesk installation completed!"
