{ lib, pkgs }:
let
  name = "space_view3d_spacebar_menu";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_spacebar_menu.git";
    rev = "8d48fce359af6a83fe4ef72d6566252c7071f31c";
    sha256 = "8d48fce359af6a83fe4ef72d6566252c7071f31c";
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
