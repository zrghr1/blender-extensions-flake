{ lib, pkgs }:
let
  name = "space_view3d_brush_menus";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_brush_menus.git";
    rev = "34b28a1d4d9d3764d98ca1b2003ef4c96a39f5d0";
    sha256 = "1r0ll3jvdlqjczprxfacczw5qy13rkzg1dql4nwm3zblzblk2rli";
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
