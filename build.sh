#!/bin/bash

# Install Flutter
echo "Installing Flutter..."
curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.10.0-stable.tar.xz -o flutter.tar.xz
tar xf flutter.tar.xz
export PATH="$PATH:`pwd`/flutter/bin"

# Verify Flutter installation
flutter --version
flutter doctor

# Get dependencies
echo "Getting Flutter dependencies..."
flutter pub get

# Build for web
echo "Building Flutter web app..."
flutter build web --release --web-renderer html

echo "Build completed!"