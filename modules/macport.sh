#!/usr/bin/env bash
#
# Ports to be installed
ports=(
    nmap
    kubectl-1.26
    minikube
    tmux
    alacritty
    skhd
    yabai
    colima
    docker
    docker-compose
    yt-dlp
    pam-reattach
    tree
    minicom
    iperf3
    zsh
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

case $(uname -r | cut -d '.' -f 1) in
    22)
        archiveName="Ventura.pkg"
        ;;
    21)
        archiveName="Monterey.pkg"
        ;;
    20)
        archiveName="BigSur.pkg"
        ;;
    19)
        archiveName="Catalina.pkg"
        ;;
    *)
        echo "macOS 10.14 or earlier not supported."
        exit 1
        ;;
esac

# MacPorts recipe name
packageID=org.macports.MacPorts
# Getting installed MacPorts version
installedVersion=$(if [ -x /opt/local/bin/port ]; then /opt/local/bin/port version | awk '{print $2}' | cat; else echo "0"; fi)
# Getting newest MacPorts version available
appNewVersion=$(curl -L --silent --fail "https://api.github.com/repos/macports/macports-base/releases/latest" | grep tag_name | cut -d '"' -f 4 | sed 's/[^0-9\.]//g')
# Getting newest MacPorts version available url
downloadURL=$(curl -L --silent --fail "https://api.github.com/repos/macports/macports-base/releases/latest" | awk -F '"' "/browser_download_url/ && /$archiveName\"/ { print \$4; exit }")

# Checking if local version is the latest
if [[ $installedVersion = "$appNewVersion" ]]; then
    echo "No update needed, found packageID $packageID installed, version $installedVersion."
else
    echo "Version mismatch or not found using packageID $packageID"
    tmp_dir=$(mktemp -d)
    echo "Created temp dir to $tmp_dir"
    curl -L -o "$tmp_dir"/MacPorts.pkg "$downloadURL"
    echo "Downloaded MacPorts"
    sudo installer -verbose -dumplog -pkg "$tmp_dir"/MacPorts.pkg -target /
    echo "Insallomator version $appNewVersion installed"
fi

# Installing apps
for port in "${ports[@]}"; do
    echo "Installing $port"
    sudo /opt/local/bin/port -q install --allow-failing "$port"
done
