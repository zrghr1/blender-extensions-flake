{ lib, pkgs }:
let
  name = "real_snow";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "bc82dc67a2043ccb329dc8d56b0eb2430090c104";
    sha256 = "bc82dc67a2043ccb329dc8d56b0eb2430090c104";
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
