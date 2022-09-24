#! /bin/zsh

# Apps to be installed
apps=(
    macports
    firefoxpkg_intl
    cyberduck
    appcleaner
    logitechoptions
    maccyapp
    suspiciouspackage
    theunarchiver
    microsoftvisualstudiocode
    suspiciouspackage
    vlc
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

# Installomator recipe name
packageID=com.scriptingosx.Installomator
# Getting installed Installomator version
installedVersion="$(pkgutil --pkg-info-plist ${packageID} 2>/dev/null | grep -A 1 pkg-version | tail -1 | sed -E 's/.*>([0-9.]*)<.*/\1/g')"
# Getting newest Installomator version available
appNewVersion=$(curl -L --silent --fail "https://api.github.com/repos/Installomator/Installomator/releases/latest" | grep tag_name | cut -d '"' -f 4 | sed 's/[^0-9\.]//g')
# Getting newest Installomator version available url
downloadURL=$(curl -L --silent --fail "https://api.github.com/repos/Installomator/Installomator/releases/latest" | awk -F '"' "/browser_download_url/ && /.pkg\"/ { print \$4; exit }")

# Checking if local version is the latest
if [[ $installedVersion = $appNewVersion ]]; then
    echo "No update needed, found packageID $packageID installed, version $installedVersion."
else
    echo "Version mismatch or not found using packageID $packageID"
    tmp_dir=$(mktemp -d)
    echo "Created temp dir to $tmp_dir"
    curl -L -o $tmp_dir/Installomator.pkg $downloadURL
    echo "Downloaded Installomator"
    sudo installer -verbose -dumplog -pkg $tmp_dir/Installomator.pkg -target /
    echo "Insallomator version $appNewVersion installed"
fi

# Installing apps
for app in $apps; do
    sudo /usr/local/Installomator/Installomator.sh $app
done
