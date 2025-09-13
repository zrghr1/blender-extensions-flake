{ lib, pkgs }:
let
  name = "io_coat3D";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_coat3D.git";
    rev = "8b39ba497d29bc961d6eab3beb21d384ec48fd2a";
    sha256 = "1clfpqii2csn77417ffar0ir9gsyfkmab9fn9sjfi4nxhpmpnpp1";
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
