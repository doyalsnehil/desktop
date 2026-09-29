#!/bin/bash
set -e
echo "Installing SwayOSD..."
sudo pacman -Sy --noconfirm swayosd
echo "Starting the OSD daemon natively..."
systemd-run --user --unit=swayosd-daemon bash -c "pkill -x swayosd-server; swayosd-server"
echo "Done! Try pressing your volume and brightness keys!"
