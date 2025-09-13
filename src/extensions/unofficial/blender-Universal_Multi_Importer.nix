{ lib, pkgs }:
let
  name = "blender-Universal_Multi_Importer";
  repo =  pkgs.fetchFromGitHub {
    owner = "Tilapiatsu";
    repo = "blender-Universal_Multi_Importer";
    rev = "42f65c4268a931705e5b4181fe0726f2deb211db";
    sha256 = "1v7v912xzhlcibkapwqgrg08j41x99cyzxx8ghc22lpzjhpwp25c";
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
