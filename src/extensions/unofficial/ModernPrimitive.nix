{ lib, pkgs }:
let
  name = "ModernPrimitive";
  repo =  pkgs.fetchFromGitHub {
    owner = "degarashi";
    repo = "ModernPrimitive";
    rev = "fb272a07d2208684c3e1c30e5c9fa9c0dfd72e62";
    sha256 = "1l9zv7mzx1vmxzp6yyq8l2jdjy69lyash43aja1f2sqah5p2lhdy";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo} $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
