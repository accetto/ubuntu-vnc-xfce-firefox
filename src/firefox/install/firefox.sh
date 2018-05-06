#!/bin/bash
### every exit != 0 fails the script
set -e
set -u

echo "Installing Firefox"
apt-get update 
apt-get install -y firefox
apt-get clean -y
