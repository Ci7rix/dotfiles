#! /bin/zsh

# Ports to be installed
ports=(
    nmap
    kubectl
    minikube
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
for port in $ports; do
    echo "Installing $port"
    sudo port -N install $port
done