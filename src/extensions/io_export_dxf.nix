{ lib, pkgs }:
let
  name = "io_export_dxf";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_export_dxf.git";
    rev = "94ae076ce3d3930505408b6f466830e650f8f022";
    sha256 = "94ae076ce3d3930505408b6f466830e650f8f022";
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
