{ lib, pkgs }:
let
  name = "EdgeFlow";
  repo =  pkgs.fetchFromGitHub {
    owner = "BenjaminSauder";
    repo = "EdgeFlow";
    rev = "9d8f6918f26b33c8627f51af7f38cd26a44802d8";
    sha256 = "0kyb7m6rbvcwablk07jpdvpvvc19lknvwfb0ansywlcizfqw5q1b";
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
