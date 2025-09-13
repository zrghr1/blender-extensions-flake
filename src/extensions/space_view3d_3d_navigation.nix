{ lib, pkgs }:
let
  name = "space_view3d_3d_navigation";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_3d_navigation.git";
    rev = "8917d5a8064960cef71797d97c1101b3ae5c642f";
    sha256 = "8917d5a8064960cef71797d97c1101b3ae5c642f";
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
