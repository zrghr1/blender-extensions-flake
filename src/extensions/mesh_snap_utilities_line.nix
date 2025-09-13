{ lib, pkgs }:
let
  name = "mesh_snap_utilities_line";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/mesh_snap_utilities_line.git";
    rev = "27f311cef13bda28feda09a0e012088fa64c4ece";
    sha256 = "27f311cef13bda28feda09a0e012088fa64c4ece";
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
