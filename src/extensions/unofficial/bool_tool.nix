{ lib, pkgs }:
let
  name = "btrace";
  repo =  pkgs.fetchFromGithub {
    owner = "nickberckley";
    repo = "bool_tool";
    rev = "8461e5b7ccd4d2301c5567de9d17102304e2edbe";
    sha256 = "1fns2vh4gl23ivas3krjd7i9qwh3r8w6d25kbscrqnahj2vqllmf";
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
