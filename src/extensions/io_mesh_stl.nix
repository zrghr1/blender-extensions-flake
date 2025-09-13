{ lib, pkgs }:
let
  name = "io_mesh_stl";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_mesh_stl.git";
    rev = "d58d17d7b9fae51c1f37e0188122a7c81034266c";
    sha256 = "18gcybc6b1x3w837awl2xaxcb3p7lmfpwgwc2ci1nq2npvkfr9bf";
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
