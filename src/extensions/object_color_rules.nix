{ lib, pkgs }:
let
  name = "object_color_rules";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "562b1a349d78b0a8677b1681d1af4d00e6e36c78";
    sha256 = "562b1a349d78b0a8677b1681d1af4d00e6e36c78";
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
