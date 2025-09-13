{ lib, pkgs }:
let
  name = "mesh_looptools";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "c6490da1eb0c33bec195daba2fb46e152fa54ff8";
    sha256 = "061ivmnmmr4561p8xb3jk2llcxssvd4sf0a74csqyjgfi4phx1n1";
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
