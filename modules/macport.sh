#!/usr/bin/env bash
#
# Ports to be installed
ports=(
    nmap
    kubectl-1.24
    minikube
    tmux
    alacritty
    skhd
    yabai
    colima
    docker
    yt-dlp
    pam-reattach
)

# Do not modify after this line

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# Installing apps
for port in "${ports[@]}"; do
    echo "Installing $port"
    sudo /opt/local/bin/port -N install "$port"
done
