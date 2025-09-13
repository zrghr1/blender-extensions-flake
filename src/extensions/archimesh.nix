{ lib, pkgs }:
let
  name = "archimesh";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/archimesh.git";
    rev = "99dfe7dda39a3503fb776a5aa80b9e4dc48c3e55";
    sha256 = "99dfe7dda39a3503fb776a5aa80b9e4dc48c3e55";
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
