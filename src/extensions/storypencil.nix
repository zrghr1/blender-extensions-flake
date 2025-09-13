{ lib, pkgs }:
let
  name = "storypencil";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/storypencil.git";
    rev = "a4bd61bfc448ec28ecf7b3aefd6dff77d4c54bf6";
    sha256 = "a4bd61bfc448ec28ecf7b3aefd6dff77d4c54bf6";
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
