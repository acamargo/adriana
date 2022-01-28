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

mkdir -p ~/dev/flutter
cd ~/dev/flutter
git clone https://github.com/acamargo/adriana.git

cd adriana
flutter test
