#!/usr/bin/env zsh

set -euo pipefail

NAME="$1"
REV="$2"
OUTPUT_FILE="./src/extensions/${NAME}.nix"
URL="https://projects.blender.org/extensions/${NAME}"

echo "Fetching repo..."

JSON_OUTPUT=$(nix-shell -p nix-prefetch-git --command "nix-prefetch-git $URL 2> /dev/null")

echo "Getting full rev and sha256 file..."

FULLREV=$(echo "$JSON_OUTPUT" | jq -r  ".rev")
SHA256=$(echo "$JSON_OUTPUT" | jq -r  ".sha256")

echo "Preparing file..."

NIX_TEMPLATE=$(cat << 'EOF'
{ lib, pkgs }:
let
  name = "@@NAME@@";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/@@NAME@@.git";
    rev = "@@FULLREV@@";
    sha256 = "@@SHA256@@";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo}/source $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
EOF
)

NIX_FILE=$(echo "$NIX_TEMPLATE" | \
  sed "s|@@NAME@@|${NAME}|g" | \
  sed "s|@@FULLREV@@|${FULLREV}|g" | \
  sed "s|@@SHA256@@|${SHA256}|g"
)

echo "Writing file..."

echo "$NIX_FILE" > "$OUTPUT_FILE"

git add "${OUTPUT_FILE}"
git commit -m "Add ${NAME}"

echo "Done!"
