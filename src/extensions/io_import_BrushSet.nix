{ lib, pkgs }:
let
  name = "io_import_BrushSet";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_import_BrushSet.git";
    rev = "f4e9d97039c688e09fc9137c664321512d400b45";
    sha256 = "1fdbr4grppjayamikl4irac3w503a1i4rqxqs18wv4crw1dwiwab";
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
