{ lib, pkgs }:
let
  name = "render_povray";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "3ade27345478bc96191e74f5827b45fe746d06f1";
    sha256 = "1vsp62vfax8h9l32672yc5b762z1zdn3a4miblp3hxiay11543wv";
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
