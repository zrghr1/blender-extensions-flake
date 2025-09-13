{ lib, pkgs }:
let
  name = "node-arrange";
  repo =  pkgs.fetchFromGitHub {
    owner = "Leonardo-Pike-Excell";
    repo = "${name}";
    rev = "a3823f4418c040019127dabf221cca1cb95c1637";
    sha256 = "1455ymgfm3x4j11dbllfmm2wlq4897sk3izdrblap8br6201jw7j";
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
