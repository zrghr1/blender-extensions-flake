{ lib, pkgs }:
let
  name = "space_view3d_modifier_tools";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_modifier_tools.git";
    rev = "2bc411dc6e856f32fac98eae086abfeb5b7306fc";
    sha256 = "2bc411dc6e856f32fac98eae086abfeb5b7306fc";
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
