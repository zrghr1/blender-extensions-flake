{ lib, pkgs }:
let
  name = "precision_drawing_tools";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/precision_drawing_tools.git";
    rev = "4f7eaa2b3b06dafb5b321cd1904608964d4eac51";
    sha256 = "1r68jfxqbfy7q4946z2fcfn9r987knjzslirnby68c44fbpqn91y";
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
