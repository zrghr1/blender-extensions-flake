{ lib, pkgs }:
let
  name = "add_mesh_discombobulator";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/add_mesh_discombobulator.git";
    rev = "d81aa601f3885d17436608f3c5be7c14bc77cfcc";
    sha256 = "d81aa601f3885d17436608f3c5be7c14bc77cfcc";
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
