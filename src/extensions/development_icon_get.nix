{ lib, pkgs }:
let
  name = "development_icon_get";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/development_icon_get.git";
    rev = "12fe30547c548f35b2900f45fe631a01e0883707";
    sha256 = "0vbkjp9yp8r8h34cdmr7112dih4gsgk3jjvihp2d1i4paqkqdgbk";
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
