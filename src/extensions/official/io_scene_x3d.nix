{ lib, pkgs }:
let
  name = "io_scene_x3d";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_scene_x3d.git";
    rev = "e956bd8beaa6ac33d7e7efb7419f15b9291c4dba";
    sha256 = "1wxlkcjc7dy06jknfdsc1cfmzvkbzd2xbfl7jisdkfz8k5ifd4q3";
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
