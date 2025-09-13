{ lib, pkgs }:
let
  name = "io_mesh_atomic";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_mesh_atomic.git";
    rev = "07d61acf41780f2c211af8cc6e83694ffed2fb18";
    sha256 = "07d61acf41780f2c211af8cc6e83694ffed2fb18";
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
