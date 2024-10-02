#!/bin/bash

# Function to display messages
echo_message() {
    echo "=================================================="
    echo "$1"
    echo "=================================================="
}

# Define the files to extract
FILE1="android-studio-2024.2.1.9-linux.tar.gz"
FILE2="flutter_linux_3.24.3-stable.tar.xz"
FILE3="commandlinetools-linux-11076708_latest.zip"

# Create directories for extracted files
mkdir -p extract

# Extract each file
for FILE in "$FILE1" "$FILE2" "$FILE3"; do
    case "$FILE" in
        *.tar.gz)
            echo "Extracting $FILE..."
            tar -xzf "$FILE" -C extract
            ;;
        *.tar.xz)
            echo "Extracting $FILE..."
            tar -xf "$FILE" -C extract
            ;;
        *.zip)
            echo "Extracting $FILE..."
            unzip "$FILE" -d extract
            ;;
        *)
            echo "Unsupported file type: $FILE"
            ;;
    esac
done

mkdir -p extract/cmdline-tools/latest
mv bin/ latest/
mv lib/ latest/

echo "Extraction completed!"

# Update package list and install dependencies
echo_message "Installing Dependencies..."
sudo apt update
sudo apt install -y openjdk-11-jdk wget unzip


# Update and upgrade the package lists
echo "Updating package lists..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Install required packages
echo "Installing required packages for flutter..."
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa

echo "All done!"

# Move the extracted folder
echo_message "Moving Android Studio to /opt..."
sudo mv extract/android-studio /opt/

# Move the extracted folder
echo_message "Moving Flutter to /opt..."
sudo mv extract/flutter /opt/

# Start Android Studio to complete setup
echo_message "Starting Android Studio for the first time..."
/opt/android-studio/bin/studio.sh &

# Create a desktop entry
echo_message "Creating a desktop entry..."
cat <<EOL | sudo tee /usr/share/applications/android-studio.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Exec=/opt/android-studio/bin/studio.sh
Icon=/opt/android-studio/bin/studio.png
Categories=Development;IDE;
Terminal=false
EOL

echo_message "Installation completed! You can launch Android Studio from your application menu."
