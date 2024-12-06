#!/bin/bash

# Function to display messages
echo_message() {
    echo "=================================================="
    echo "$1"
    echo "=================================================="
}

# Set URLs for downloads
ANDROID_STUDIO_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.9/android-studio-2024.2.1.9-linux.tar.gz"
COMMAND_LINE_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz"

# Download Android Studio
echo "Downloading Android Studio..."
wget "$ANDROID_STUDIO_URL" -O android-studio-linux.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download Android Studio."
    exit 1
fi

# Download Command Line Tools
echo "Downloading Command Line Tools..."
wget "$COMMAND_LINE_TOOLS_URL" -O commandlinetools.zip
if [ $? -ne 0 ]; then
    echo "Failed to download Command Line Tools."
    exit 1
fi

# Download Flutter
echo "Downloading Flutter..."
wget "$FLUTTER_URL" -O flutter_linux.tar.xz
if [ $? -ne 0 ]; then
    echo "Failed to download Flutter."
    exit 1
fi

# After download process
echo "Download completed! Now proceeding to extract files..."



# Define the files to extract
FILE1="android-studio-linux.tar.gz"
FILE2="flutter_linux.tar.xz"
FILE3="commandlinetools.zip"

#FILE1="android-studio-2024.2.1.9-linux.tar.gz"
#FILE2="flutter_linux_3.24.3-stable.tar.xz"
#FILE3="commandlinetools-linux-11076708_latest.zip"

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

# Install required packages for android
echo "Install the following prerequisite packages for Android Studio"
sudo apt-get install libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64

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
