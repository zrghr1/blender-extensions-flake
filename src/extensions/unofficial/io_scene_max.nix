{ lib, pkgs }:
let
  name = "io_scene_max";
  repo =  pkgs.fetchFromGitHub {
    owner = "nrgsille76";
    repo = "io_scene_max";
    rev = "52f04d3887506122f3ba0f70955a09c55a70197a";
    sha256 = "0namqnslk0whcplqspyrg51gvb1wsk5slihd05hbhd0xa1wimzdb";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo} $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
