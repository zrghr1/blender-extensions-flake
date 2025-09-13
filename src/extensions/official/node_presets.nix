{ lib, pkgs }:
let
  name = "node_presets";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/node_presets.git";
    rev = "e953e6e1aa2a783e7f848b8941bc56bbe04fd12c";
    sha256 = "0dg1dwwdgkn8mq8jhm48m52yzv5h3q6hg466vbw6c7rqn81k4c7g";
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
