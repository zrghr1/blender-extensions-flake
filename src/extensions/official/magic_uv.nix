{ lib, pkgs }:
let
  name = "magic_uv";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/magic_uv.git";
    rev = "269480450448ddf765185ca26cc1fdcb0ef28ba9";
    sha256 = "1ra53fs1mijh04yngag1m9wd89j893ash1k8mjwi0cpcfxnnzhzn";
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
