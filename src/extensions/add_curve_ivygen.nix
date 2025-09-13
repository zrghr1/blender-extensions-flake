{ lib, pkgs }:
let
  name = "add_curve_ivygen";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "dd2fdea1f6189c5c0fef4603fb9782c4775a7276";
    sha256 = "dd2fdea1f6189c5c0fef4603fb9782c4775a7276";
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
