{ lib, pkgs }:
let
  name = "lighting_tri_lights";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "b03df7c678704021ddc5178495fe42c4c5989e6a";
    sha256 = "b03df7c678704021ddc5178495fe42c4c5989e6a";
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
