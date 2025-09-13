{ lib, pkgs }:
let
  name = "Colorista";
  repo =  pkgs.fetchFromGitHub {
    owner = "AIGODLIKE";
    repo = "${name}";
    rev = "27d7181aac4aac2beafc3115b6a89f128e691d08";
    sha256 = "16wb82isscx23yay3b7qgqq4n8zab1awdlqvvc9b7y9n9jy56k4g";
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
