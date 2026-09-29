#!/bin/bash
set -e

echo -e "\n\033[1;36m[1/4]\033[0m Installing SDDM and Qt6 UI dependencies..."
sudo pacman -Sy --noconfirm --needed sddm qt6-5compat qt6-declarative qt6-svg

echo -e "\n\033[1;36m[2/4]\033[0m Installing SDDM Astronaut Theme from AUR..."
yay -S --noconfirm --needed sddm-astronaut-theme

echo -e "\n\033[1;36m[3/4]\033[0m Swapping Display Managers (Disabling greetd, Enabling sddm)..."
sudo systemctl disable greetd.service || true
sudo systemctl enable sddm.service

echo -e "\n\033[1;36m[4/4]\033[0m Configuring Auto-Login and injecting the Astronaut Theme..."
sudo mkdir -p /etc/sddm.conf.d

# Force Auto-Login into Hyprland
sudo tee /etc/sddm.conf.d/autologin.conf > /dev/null <<EOL
[Autologin]
User=$USER
Session=hyprland
EOL

# Apply the Astronaut Theme
sudo tee /etc/sddm.conf.d/theme.conf > /dev/null <<EOL
[Theme]
Current=sddm-astronaut-theme
EOL

echo -e "\n\033[1;32mSUCCESS!\033[0m Everything is flawlessly configured."
echo "Your system will now auto-login via SDDM, skipping the double-password hassle."
echo "If you ever manually log out, you will be greeted by the gorgeous Astronaut theme!"
