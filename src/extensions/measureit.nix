{ lib, pkgs }:
let
  name = "measureit";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/measureit.git";
    rev = "e483282a1b0e3a43c7dc4a554a3b1fc0cc471edc";
    sha256 = "e483282a1b0e3a43c7dc4a554a3b1fc0cc471edc";
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
