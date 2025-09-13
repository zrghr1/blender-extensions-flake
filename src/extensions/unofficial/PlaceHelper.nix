{ lib, pkgs }:
let
  name = "PlaceHelper";
  repo =  pkgs.fetchFromGitHub {
    owner = "AIGODLIKE";
    repo = "PlaceHelper";
    rev = "b6603da8c841709c7053381def3b666a5ae1fda5";
    sha256 = "0jm0nbr2xd2czd0gn4psy9sppxpgmsqdyy28j7q3pnd9l316sxzi";
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
