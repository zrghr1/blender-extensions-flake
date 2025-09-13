{ lib, pkgs }:
let
  name = "animation_animall";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/animation_animall.git";
    rev = "97a8e2a72b28098ffc90e18755f3fa293b7b0042";
    sha256 = "1rzda56dwy9pxfhblbq3lk7nnv6h8vy1ykwn4ff6mqifi97vkzis";
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
