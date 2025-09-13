{ lib, pkgs }:
let
  name = "object_fracture_cell";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/object_fracture_cell.git";
    rev = "4500a267f868bc99c35207930c9d2ee6e8f314c6";
    sha256 = "02q27926cc43jfl86r2pns9jyrnwp3db0p1i06kxyl2ndndhlcsj";
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
