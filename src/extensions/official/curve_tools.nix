{ lib, pkgs }:
let
  name = "curve_tools";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/curve_tools.git";
    rev = "6a8882d7e209a1b443ea4554c3a958a1d37bef36";
    sha256 = "0z50qay4csmd0zbr3sj8528d4vdkxq6kq582cihcgxa4bph5vcli";
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
