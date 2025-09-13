{ lib, pkgs }:
let
  name = "development_iskeyfree";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/development_iskeyfree.git";
    rev = "fc6e5727be96de2758ae809b045c2dd0bd55180b";
    sha256 = "fc6e5727be96de2758ae809b045c2dd0bd55180b";
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
