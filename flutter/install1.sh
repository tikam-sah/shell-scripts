#!/bin/bash

# Function to display messages
echo_message() {
    echo "=================================================="
    echo "$1"
    echo "=================================================="
}

# Define the Flutter installation directory
FLUTTER_DIR="/opt/flutter"

# Check if Flutter is already installed
if [ ! -d "$FLUTTER_DIR" ]; then
    # Download and install Flutter
    sudo git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_DIR
else
    echo "Flutter is already installed at $FLUTTER_DIR."
fi


# Add Flutter to PATH
if ! grep -q 'export PATH="$PATH:/opt/flutter/bin"' ~/.bashrc; then
    echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc
    source ~/.bashrc
    echo "Flutter has been added to your PATH."
fi

# Move the extracted folder
echo_message "Moving cmdline-tools to /opt..."
sudo mv extract/cmdline-tools ~/Android/Sdk/

#export PATH="$PATH:/opt/flutter/bin"


# Install Android command-line tools
cd ~/Android/Sdk/cmdline-tools/latest/bin
./sdkmanager --install "cmdline-tools;latest"

# Install required packages for Linux development
sudo apt install -y clang cmake ninja-build pkg-config

# Installing Nano 
sudo apt install nano 

# libgtk
sudo apt install libgtk-3-dev

# Adding sdk path 
echo export ANDROID_SDK_ROOT=~/Android/Sdk
echo export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
echo  export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
echo  export PATH="$PATH:$ANDROID_SDK_ROOT/tools"
source ~/.bashrc

# Accept Android licenses
flutter doctor --android-licenses
#  /opt/flutter/bin/flutter doctor --android-licenses

# Verify installation
flutter doctor

# Run Flutter Doctor
# echo "Running Flutter Doctor..."
# /opt/flutter/bin/flutter doctor

echo "Flutter installation completed! Run 'flutter doctor' for setup."




#sudo apt update
#sudo apt install libmpv1


