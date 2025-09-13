{ lib, pkgs }:
let
  name = "blender_id";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/blender_id.git";
    rev = "51eee9397801792636fba1447de40a44dceaa7bb";
    sha256 = "51eee9397801792636fba1447de40a44dceaa7bb";
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
