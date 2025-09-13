{ lib, pkgs }:
let
  name = "curve_assign_shapekey";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/curve_assign_shapekey.git";
    rev = "98254d9b3954f1f6100f4fef22a99f2f32029032";
    sha256 = "0q65iiiiixpk2bgbl30msc31q6xnyk4d973lk3wfwjhjna1lj83p";
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
