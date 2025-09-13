{ lib, pkgs }:
let
  name = "Gizmodal-Ops";
  repo =  pkgs.fetchFromGitHub {
    owner = "BlenderDefender";
    repo = "Gizmodal-Ops";
    rev = "12ad5b8e6d29d8e21cb7389ff3d7a437e851dedd";
    sha256 = "0rjk5b9jk301lghi3k7j0azjf08rb5gd21sq1afzd70qslmwdvv6";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo} $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
