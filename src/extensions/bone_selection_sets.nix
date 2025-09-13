{ lib, pkgs }:
let
  name = "bone_selection_sets";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/bone_selection_sets.git";
    rev = "27b42e9aae0901c758275967ac8a92bff39e950f";
    sha256 = "27b42e9aae0901c758275967ac8a92bff39e950f";
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
