{ lib, pkgs }:
let
  name = "NodeEditorSwitcher";
  repo =  pkgs.fetchFromGitHub {
    owner = "Victor-IX";
    repo = "NodeEditorSwitcher";
    rev = "4cf87eeb4b8e6d804edea3c42eab04fa12276f05";
    sha256 = "1phhd6mqkcrcmfkqi3058j5nqx4mh99lnj9hl5rs5k9gpajgiyb6";
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
