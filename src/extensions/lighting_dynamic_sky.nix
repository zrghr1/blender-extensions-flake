{ lib, pkgs }:
let
  name = "lighting_dynamic_sky";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/lighting_dynamic_sky.git";
    rev = "99616b66f6dcc87b5148f78df5e4cbd8bcd3947d";
    sha256 = "99616b66f6dcc87b5148f78df5e4cbd8bcd3947d";
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
