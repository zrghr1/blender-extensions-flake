{ lib, pkgs }:
let
  name = "paint_palette";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/paint_palette.git";
    rev = "ec48daa9955b994dae2f458db36ae53d9fba00e7";
    sha256 = "ec48daa9955b994dae2f458db36ae53d9fba00e7";
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
