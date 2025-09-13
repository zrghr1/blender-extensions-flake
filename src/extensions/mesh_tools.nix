{ lib, pkgs }:
let
  name = "mesh_tools";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/mesh_tools.git";
    rev = "adc3900be9e0483a08fc222605697273c0383393";
    sha256 = "adc3900be9e0483a08fc222605697273c0383393";
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
