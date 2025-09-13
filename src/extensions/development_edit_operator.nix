{ lib, pkgs }:
let
  name = "development_edit_operator";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/development_edit_operator.git";
    rev = "66795fc4c9b721820d634bbd8ac875a7e2d2eb04";
    sha256 = "66795fc4c9b721820d634bbd8ac875a7e2d2eb04";
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
