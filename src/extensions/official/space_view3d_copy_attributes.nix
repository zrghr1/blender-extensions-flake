{ lib, pkgs }:
let
  name = "space_view3d_copy_attributes";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_copy_attributes.git";
    rev = "5edd30f73091492b02c006cf883fff9c0d37c19a";
    sha256 = "1fggp3pnd5d14vfwzw6wgl2wzj3xf9szhjp36fzjzp2xsadb55my";
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
