{ lib, pkgs }:
let
  name = "simple_deform_helper";
  repo =  pkgs.fetchFromGitHub {
    owner = "AIGODLIKE";
    repo = "${name}";
    rev = "2366929e68bbbce80c1dfb51959075dde316aa66";
    sha256 = "1bxfnr23lb9rvm2ylvkijcrj265pd41c7vsknvgfghxncd9aqmqp";
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
