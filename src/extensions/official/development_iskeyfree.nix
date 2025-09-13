{ lib, pkgs }:
let
  name = "development_iskeyfree";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/development_iskeyfree.git";
    rev = "fc6e5727be96de2758ae809b045c2dd0bd55180b";
    sha256 = "03sqi5p0w2j4djmpgfpq2i5y9jki4ffaig2qy368mw4lc88yw5gq";
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
