{ lib, pkgs }:
let
  name = "Blender-Asset-Creation-Toolset";
  repo =  pkgs.fetchFromGitHub {
    owner = "mrven";
    repo = "Blender-Asset-Creation-Toolset";
    rev = "920c526efebe6bc3058517f00cffa6643cf7accd";
    sha256 = "0dj5scf7v1id4ljgfbna7yj72m5jvbfzl64l6310vs4pcppf03zd";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo}/ACT_2025_1_Bl420 $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
