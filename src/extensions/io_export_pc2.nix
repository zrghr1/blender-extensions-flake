{ lib, pkgs }:
let
  name = "io_export_pc2";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_export_pc2.git";
    rev = "ce3981338d639b4d070c4574551d3267c7812b2d";
    sha256 = "ce3981338d639b4d070c4574551d3267c7812b2d";
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
