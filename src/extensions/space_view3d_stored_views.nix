{ lib, pkgs }:
let
  name = "space_view3d_stored_views";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_stored_views.git";
    rev = "436d7860894b4d0504576f42d5a91f6d71983c94";
    sha256 = "436d7860894b4d0504576f42d5a91f6d71983c94";
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
