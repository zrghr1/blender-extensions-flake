{ lib, pkgs }:
let
  name = "add_mesh_geodesic_domes";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/add_mesh_geodesic_domes.git";
    rev = "fe98588e0a489172ed47c164ffca2c5cb110fcb9";
    sha256 = "fe98588e0a489172ed47c164ffca2c5cb110fcb9";
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
