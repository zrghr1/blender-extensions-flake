{ lib, pkgs }:
let
  name = "io_anim_camera";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_anim_camera.git";
    rev = "631049b1ec6d944359cc59760d586877575c6fa3";
    sha256 = "009y4m47nrbcd8nj31d2zin6mqxn6dhvs6y5dsri2yldzsyrhacw";
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
