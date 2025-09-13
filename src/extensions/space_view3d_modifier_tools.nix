{ lib, pkgs }:
let
  name = "space_view3d_modifier_tools";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_modifier_tools.git";
    rev = "2bc411dc6e856f32fac98eae086abfeb5b7306fc";
    sha256 = "0i1gjlqspcx8zjcdrj25p2fm2v7n5j3nmgz8mgk8l1vj4nq5bnd5";
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
