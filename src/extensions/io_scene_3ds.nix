{ lib, pkgs }:
let
  name = "mesh_looptools";
  version = "2.9.0";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_scene_3ds.git";
    rev = "189812454e59ca066caa8193043250162626f5be";
    sha256 = "0yx5ck1rnri20d1s40f0c6n1gd26zpdxbx30sxnvd6s5g2sy94hd";
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
