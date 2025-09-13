{ lib, pkgs }:
let
  name = "Screencast-Keys";
  repo =  pkgs.fetchFromGitHub {
    owner = "nutti";
    repo = "${name}";
    rev = "36c2850e485d5a3c3b445e14b328a946d65a1374";
    sha256 = "0vvx6wn9xaz40nscy84rqxdap5bimllph33fh8idps1a9myvcc6j";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo}/src/screencast_keys $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
