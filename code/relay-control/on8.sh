#!/usr/bin/env bash
set -euo pipefail

# Turn ON both relays on a USB HID relay controlled by `usbrelay`.
#
# Usage:
#   ./on.sh                 # auto-detect first 2-channel device
#   ./on.sh MyRelayPrefix   # explicitly specify device prefix
#
# Notes:
# - `usbrelay` must be installed and in PATH (e.g., `sudo apt install usbrelay`).
# - The device prefix is the part before `_1`/`_2` shown by `usbrelay`.
#   Example `usbrelay` output:  MyRelay_1=0  MyRelay_2=1

if ! command -v usbrelay >/dev/null 2>&1; then
  echo "Error: 'usbrelay' is not installed or not in PATH." >&2
  echo "Install it (e.g., Debian/Ubuntu): sudo apt-get install usbrelay" >&2
  exit 127
fi


SPK1=1
SPK2=2
SPK3=3
SPK4=4
SPK5=5
SPK6=6
DMX=7
MOTORS=8

usbrelay "6QMBS_$DMX"=1 > /dev/null
sleep 0.5
usbrelay "6QMBS_$SPK1"=1 > /dev/null
usbrelay "6QMBS_$SPK2"=1 > /dev/null
usbrelay "6QMBS_$SPK3"=1 > /dev/null
usbrelay "6QMBS_$SPK4"=1 > /dev/null
usbrelay "6QMBS_$SPK5"=1 > /dev/null
usbrelay "6QMBS_$SPK6"=1 > /dev/null
sleep 0.5
usbrelay "6QMBS_$MOTORS"=1 > /dev/null
sleep 0.2

usbrelay
