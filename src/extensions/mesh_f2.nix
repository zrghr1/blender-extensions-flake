{ lib, pkgs }:
let
  name = "mesh_f2";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/mesh_f2.git";
    rev = "5b416f9d278df11413866a67bdaa8550346d974e";
    sha256 = "5b416f9d278df11413866a67bdaa8550346d974e";
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
