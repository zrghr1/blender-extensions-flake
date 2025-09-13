{ lib, pkgs }:
let
  name = "animation_add_corrective_shape_key";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/animation_add_corrective_shape_key.git";
    rev = "edcf6d943589ab9cc2a3c59a66480a090606c56d";
    sha256 = "edcf6d943589ab9cc2a3c59a66480a090606c56d";
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
