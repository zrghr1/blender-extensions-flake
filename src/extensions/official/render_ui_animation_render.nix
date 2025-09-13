{ lib, pkgs }:
let
  name = "render_ui_animation_render";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/render_ui_animation_render.git";
    rev = "06e9e85e9505be679feb1cbc3747eafbfe05f764";
    sha256 = "1k5lw9d3zhgnwix3vfaysbrgqx9w8w3qw5l0qcds8hx1grnrxap1";
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
