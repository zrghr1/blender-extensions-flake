{ lib, pkgs }:
let
  name = "space_clip_editor_refine_solution";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_clip_editor_refine_solution.git";
    rev = "0a0339b2f363547b36c4e51bc4c3ffdf3ddd2ee8";
    sha256 = "0a0339b2f363547b36c4e51bc4c3ffdf3ddd2ee8";
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
