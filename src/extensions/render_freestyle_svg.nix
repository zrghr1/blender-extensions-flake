{ lib, pkgs }:
let
  name = "render_freestyle_svg";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/render_freestyle_svg.git";
    rev = "869a352ad658cefb298518ece0a9c221362e4471";
    sha256 = "869a352ad658cefb298518ece0a9c221362e4471";
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
