{ lib, pkgs }:
let
  name = "curve_simplify";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/curve_simplify.git";
    rev = "585906a99662630e341d2a66cb0cad3ac716730a";
    sha256 = "585906a99662630e341d2a66cb0cad3ac716730a";
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
