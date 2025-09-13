{ lib, pkgs }:
let
  name = "object_scatter";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/object_scatter.git";
    rev = "886bd21c392fafe3908fdd6988535f3657e84fee";
    sha256 = "16lzhp2s8f03fdy7h9h59wadnhwps4203849wnpm03kgpqv0760r";
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
