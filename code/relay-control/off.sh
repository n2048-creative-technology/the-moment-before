#!/usr/bin/env bash
set -euo pipefail

# Turn OFF both relays on a USB HID relay controlled by `usbrelay`.
#
# Usage:
#   ./off.sh                 # auto-detect first 2-channel device
#   ./off.sh MyRelayPrefix   # explicitly specify device prefix
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

PREFIX="${1:-}"

if [[ -z "$PREFIX" ]]; then
  # Auto-detect a 2-channel device prefix from `usbrelay` output
  mapfile -t LINES < <(usbrelay)
  if ((${#LINES[@]} == 0)); then
    echo "No USB relay devices found by 'usbrelay'." >&2
    exit 1
  fi

  declare -A HAS1=()
  declare -A HAS2=()

  for line in "${LINES[@]}"; do
    if [[ "$line" =~ ^([A-Za-z0-9._:-]+)_(1|2)= ]]; then
      prefix="${BASH_REMATCH[1]}"
      chan="${BASH_REMATCH[2]}"
      if [[ "$chan" == "1" ]]; then
        HAS1["$prefix"]=1
      else
        HAS2["$prefix"]=1
      fi
    fi
  done

  for p in "${!HAS1[@]}"; do
    if [[ -n "${HAS2[$p]+x}" ]]; then
      PREFIX="$p"
      break
    fi
  done

  if [[ -z "$PREFIX" ]]; then
    echo "Could not detect a 2-channel device."
    echo "Specify prefix explicitly, e.g.: ./on.sh MyRelay"
    exit 1
  fi
fi

echo "Turning ON both relays for '$PREFIX'..."
usbrelay "${PREFIX}_1=0" "${PREFIX}_2=0"
echo "Done."

