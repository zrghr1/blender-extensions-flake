{ lib, pkgs }:
let
  name = "T3D-GN-Presets";
  repo =  pkgs.fetchFromGitHub {
    owner = "Tams3d";
    repo = "T3D-GN-Presets";
    rev = "5c811a8d44a4356e72b05f1202c4a125c626fd86";
    sha256 = "12hp7d5xvf9y4bz460ipqgp6wxhcj3aycxgwg10jfiadylp5wpcg";
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
