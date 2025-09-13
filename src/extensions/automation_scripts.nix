{ lib, pkgs }:
let
  name = "automation_scripts";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/automation_scripts.git";
    rev = "7da732433b41cbf46fea4cbe7ce14acf2eb889e4";
    sha256 = "0jwzy99y9qsyl3fzjd6n1721byq6mixffhhia1ij9jd32xpv8rdc";
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
