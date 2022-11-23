#!/bin/bash

echo "Hi, this script is going to prepare your machine to get the project adriana running."
echo
echo "It's going to:"
echo "1. install homebrew"
echo "2. install flutter via homebrew"
echo "3. clone adriana github repository on $HOME/dev/flutter directory"
echo "4. run the flutter tests of the project"
echo
echo "After that, you'll find the source code on $HOME/dev/flutter/adriana"
echo
read -n 1 -r -s -p $'Press RETURN to continue or CONTROL+C to abort...\n'

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask flutter

brew tap homebrew/cask-versions
brew install --cask temurin11
brew install --cask android-commandlinetools
brew install --cask android-platform-tools
sdkmanager "build-tools;30.0.3" "platform-tools" "emulator" "system-images;android-30;google_apis;x86_64" "platforms;android-30"

# https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae
sdkmanager --install "system-images;android-25;google_apis;x86"
echo "no" | avdmanager --verbose create avd --force --name "generic_4.4" --package "system-images;android-25;google_apis;x86" --tag "google_apis" --abi "x86"

mkdir -p ~/dev/flutter
cd ~/dev/flutter
git clone https://github.com/acamargo/adriana.git

cd adriana
flutter test
