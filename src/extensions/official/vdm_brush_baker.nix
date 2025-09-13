{ lib, pkgs }:
let
  name = "vdm_brush_baker";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/vdm_brush_baker.git";
    rev = "8f96c642d26334fb1813200524a59ec9856ff5a2";
    sha256 = "17f3dalv1k2gwyy2h21ifwm58ii6ib8m6yaygp33g39d3y5zqdzx";
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
