{ lib, pkgs }:
let
  name = "magic_uv";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/magic_uv.git";
    rev = "269480450448ddf765185ca26cc1fdcb0ef28ba9";
    sha256 = "269480450448ddf765185ca26cc1fdcb0ef28ba9";
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
