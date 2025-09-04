sudo tee /etc/udev/rules.d/90-usb-relay.rules >/dev/null <<'EOF'
# Permit access to the USB device itself
SUBSYSTEM=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05df", MODE:="0660", GROUP="dialout"

# Permit access to its hidraw interface (what most libs use)
KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05df", MODE="0660", GROUP="dialout"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger
# unplug / replug the relay
sudo usermod -aG dialout "$USER"
# log out/in (or `newgrp dialout`) so your shell picks up the group

### OPTION 2 (actually easier)

sudo apt-get update
sudo apt-get install usbrelay

usbrelay 
BITFT_1=1
BITFT_2=1

## turn both relays ON
usbrelay BITFT_1=1
usbrelay BITFT_2=1

## turn both relays OFF
usbrelay BITFT_1=0
usbrelay BITFT_2=0

