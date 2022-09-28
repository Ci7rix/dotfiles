#!/usr/bin/env bash

# Do not modify after this line

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# Getting newest Xcodes version available url
downloadURL=$(curl -L --silent --fail "https://api.github.com/repos/RobotsAndPencils/xcodes/releases/latest" | awk -F '"' "/browser_download_url/ && /.zip\"/ { print \$4; exit }")

# Installing Xcodes utility
tmp_dir=$(mktemp -d)
echo "Created temp dir to $tmp_dir"
curl -L -o "$tmp_dir"/Xcodes.zip "$downloadURL"
echo "Downloaded Xcodes utility"
ditto -x -k "$tmp_dir"/Xcodes.zip "$tmp_dir"
echo "Installing Xcodes utility"

# Installing Xcode
sudo "$tmp_dir"/xcodes install --latest --experimental-unxip --empty-trash