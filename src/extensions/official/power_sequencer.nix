{ lib, pkgs }:
let
  name = "power_sequencer";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/power_sequencer.git";
    rev = "d67aeb2c170af7addda99c57e06da06313e5f8c9";
    sha256 = "0wjgpy0phkchhmischpkyf6xxpzdf1w29ifn09qgvmhy6wvfiki9";
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
