{ lib, pkgs }:
let
  name = "add_curve_extra_objects";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/add_curve_extra_objects.git";
    rev = "b1d368c78d817f48027e9ff734ba2c3781b336b3";
    sha256 = "b1d368c78d817f48027e9ff734ba2c3781b336b3";
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
