{ lib, pkgs }:
let
  name = "space_view3d_pie_menus";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "8186983f1cbce8347d496ce6436a577ac8cf91e8";
    sha256 = "0i564pvn0d0jsqcij58pi6zn4flnfd1q2c0gcds1nqnmlzmzkyr0";
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
