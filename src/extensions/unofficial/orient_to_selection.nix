{ lib, pkgs }:
let
  name = "jlampel";
  repo =  pkgs.fetchFromGitHub {
    owner = "orient_to_selection";
    repo = "${name}";
    rev = "5eb5d89b8a884ef4238e6f1b247a82620e5ee4b4";
    sha256 = "06rwrjbvjab40dqic4ii719bvwnaa0pfb44izb54zwz384c3xc2d";
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
