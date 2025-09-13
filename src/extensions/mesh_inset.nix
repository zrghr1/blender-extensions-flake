{ lib, pkgs }:
let
  name = "mesh_inset";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "16373bffeae37c4899d579ebfe71f7fc60bcbd85";
    sha256 = "16373bffeae37c4899d579ebfe71f7fc60bcbd85";
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
