{ lib, pkgs }:
let
  name = "Bbrush";
  repo =  pkgs.fetchFromGitHub {
    owner = "AIGODLIKE";
    repo = "Bbrush";
    rev = "8b7a165db22c0fc376fab8e4abca3fc46a1b774b";
    sha256 = "0948j7h1d5qyzb7hl3ghrvxfl6s52yaax68xd5zkkvz02jcd2yyp";
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
