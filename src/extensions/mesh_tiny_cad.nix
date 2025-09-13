{ lib, pkgs }:
let
  name = "mesh_tiny_cad";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/mesh_tiny_cad.git";
    rev = "e6b06771e5a8742ac29b32742ad8a6c4223f3ac5";
    sha256 = "e6b06771e5a8742ac29b32742ad8a6c4223f3ac5";
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
