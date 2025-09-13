{ lib, pkgs }:
let
  name = "UniV";
  repo =  pkgs.fetchFromGitHub {
    owner = "Oxicid";
    repo = "${name}";
    rev = "f30f402e1a9d90a2865074fe778511765a54a1c6";
    sha256 = "1ivagazhd743ps5fafc69cf2q5w6b2vbkj9ddn69w0pnlf1vyma0";
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
