{ lib, pkgs }:
let
  name = "object_edit_linked";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/object_edit_linked.git";
    rev = "734ceb379be60482c592fee1109e953f666a32c4";
    sha256 = "0zfxaqfch7d9nbqp5cdz4jzcrvz8c6w70nsksfa9mcgijs90r8g8";
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
