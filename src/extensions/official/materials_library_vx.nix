{ lib, pkgs }:
let
  name = "materials_library_vx";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/materials_library_vx.git";
    rev = "4331d6043e431cf0772842b003c04114c9637d8e";
    sha256 = "1gdk1mq1nfq2fzahjczc8616ihx9njaxfrjsp3ljy3zv83gj944z";
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
