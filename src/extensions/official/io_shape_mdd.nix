{ lib, pkgs }:
let
  name = "io_shape_mdd";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_shape_mdd.git";
    rev = "b0d0b02821e66bbe0f89e53e2ec4323f74765249";
    sha256 = "0clibxb4nzsgb2wyg8dks50qd3bqhw4g8vyr4d9bznfdn5il5p48";
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
