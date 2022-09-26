#!/usr/bin/env bash
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

if ! grep 'pam_tid.so' /etc/pam.d/sudo > /dev/null; then
    sudo sed -i '' '2i\
auth       optional       /opt/local/lib/pam/pam_reattach.so \
auth       sufficient     pam_tid.so
    ' /etc/pam.d/sudo
fi
