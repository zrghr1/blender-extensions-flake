{ lib, pkgs }:
let
  name = "add_curve_sapling";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "e101d5bb17564221453c711b7d4f420346b4f57d";
    sha256 = "e101d5bb17564221453c711b7d4f420346b4f57d";
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
