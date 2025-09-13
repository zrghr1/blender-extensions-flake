{ lib, pkgs }:
let
  name = "timeline-buttons";
  repo =  pkgs.fetchFromGitHub {
    owner = "BlenderBoi/timeline-buttons";
    repo = "timeline-buttons";
    rev = "6d7ae4e227fc86a73f880383fda21d17b950e120";
    sha256 = "0hwc86dmsxmvyxlg0di6fnd0nynqbifbsz2azyi21zd361l1fsdn";
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
