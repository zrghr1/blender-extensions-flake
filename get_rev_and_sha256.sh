#!/usr/bin/env zsh

set -euo pipefail

REPO="$1"
URL="https://github.com/${REPO}"

echo "Fetching repo..."

JSON_OUTPUT=$(nix-shell -p nix-prefetch-git --command "nix-prefetch-git $URL 2> /dev/null")

echo "Getting full rev and sha256 file..."

REV=$(echo "$JSON_OUTPUT" | jq -r  ".rev")
SHA256=$(echo "$JSON_OUTPUT" | jq -r  ".sha256")

echo ${REV}
echo ${SHA256}

