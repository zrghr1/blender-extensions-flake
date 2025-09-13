{ lib, pkgs }:
let
  name = "system_property_chart";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/system_property_chart.git";
    rev = "88ba0ca8b589844c25ffd1137ec94c43be41a14b";
    sha256 = "88ba0ca8b589844c25ffd1137ec94c43be41a14b";
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
