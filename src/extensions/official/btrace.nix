{ lib, pkgs }:
let
  name = "btrace";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/btrace.git";
    rev = "65887b999a9a6a153c341120676883fefb76e1d9";
    sha256 = "0y2l4hbfdhj42m7jwpkd3ymwd45nlz6519l3hmgimwk1wl04j2w1";
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
