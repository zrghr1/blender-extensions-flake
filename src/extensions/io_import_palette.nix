{ lib, pkgs }:
let
  name = "io_import_palette";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_import_palette.git";
    rev = "6c7465f474be61058edcd67dd7eb6d3574df06bf";
    sha256 = "6c7465f474be61058edcd67dd7eb6d3574df06bf";
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
