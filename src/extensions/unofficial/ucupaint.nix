{ lib, pkgs }:
let
  name = "ucupaint";
  repo =  pkgs.fetchFromGitHub {
    owner = "ucupumar";
    repo = "${name}";
    rev = "484edd6037ce781c0e1b5cf4599012a9f9121aa6";
    sha256 = "0s2c3f90j4y2p1km4r897ysj09ssxb3by0d1vkhgq6alp6ln3k7m";
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
