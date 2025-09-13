{ lib, pkgs }:
let
  name = "action_to_scene_range";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/action_to_scene_range.git";
    rev = "f638503e4a6a9a9d58f247aae1617f5ce0b24fcf";
    sha256 = "1yb38qyjq9clbi7dv7f606pa7pqyavvljg88rxlpmpywgzwpx69z";
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
