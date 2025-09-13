{ lib, pkgs }:
let
  name = "system_demo_mode";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/system_demo_mode.git";
    rev = "407fa11aafbd26cf58192343535b2f4d5b3f6225";
    sha256 = "407fa11aafbd26cf58192343535b2f4d5b3f6225";
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
