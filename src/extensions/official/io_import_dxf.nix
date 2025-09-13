{ lib, pkgs }:
let
  name = "io_import_dxf";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_import_dxf.git";
    rev = "fe53f891b814d6172eabc33c0aad2f02b1698718";
    sha256 = "1cps73dnl05mvi39csmahhyx107q5hbp55dn2hkp5hri5g4azzxs";
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
