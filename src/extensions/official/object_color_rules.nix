{ lib, pkgs }:
let
  name = "object_color_rules";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/object_color_rules.git";
    rev = "562b1a349d78b0a8677b1681d1af4d00e6e36c78";
    sha256 = "0vi40vigdhvglwq555g20x04pasa8b6h7i3a266qs7dhdr4p72x7";
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
