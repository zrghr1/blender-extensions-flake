{ lib, pkgs }:
let
  name = "UVToolkit";
  repo =  pkgs.fetchFromGitHub {
    owner = "oRazeD";
    repo = "UVToolkit";
    rev = "c461aa30e1f9a90101b2b4b466336cfac565ad13";
    sha256 = "0dlbbg5gfqgcvnwwqmd21nc9hd0z4ajqlgqmvj2ybwbglqv8kdxs";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo} $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
