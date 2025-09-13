{ lib, pkgs }:
let
  name = "popoti_align_helper";
  repo =  pkgs.fetchFromGitHub {
    owner = "AIGODLIKE";
    repo = "${name}";
    rev = "c1aa1732e15d1c41c27a2e471d982e95c13dcc22";
    sha256 = "1hj2i7mg3gnisn9wykj7k17cwh8cg5q4agzb6gb7g8rrmnnbiv5i";
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
