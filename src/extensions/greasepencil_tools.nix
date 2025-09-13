{ lib, pkgs }:
let
  name = "greasepencil_tools";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "72171b0d79acf284a33413c2e18577ee49b269cf";
    sha256 = "16a5igji8xcvw2mzw5q2qrf1jc7d02dnlhismy0pc0jz6jq8wkcv";
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
