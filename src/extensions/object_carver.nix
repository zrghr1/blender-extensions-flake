{ lib, pkgs }:
let
  name = "object_carver";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/object_carver.git";
    rev = "8b14a8f931a6e5236950ea71e60da69e1ecdd8a7";
    sha256 = "8b14a8f931a6e5236950ea71e60da69e1ecdd8a7";
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
