{ lib, pkgs }:
let
  name = "simple_renaming";
  repo =  pkgs.fetchFromGitHub {
    owner = "Weisl";
    repo = "simple_renaming";
    rev = "a921f6f7c678d87e8a678554a1903b403bb81330";
    sha256 = "0x5628hsqsdy2gbgdpl2lnr2i7xhnrjz3y5y2kllpk156kb4zwkp";
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
