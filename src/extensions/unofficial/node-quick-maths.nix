{ lib, pkgs }:
let
  name = "node-quick-maths";
  repo =  pkgs.fetchFromGitHub {
    owner = "zeptofine";
    repo = "node-quick-maths";
    rev = "0b0a0172cde9a9465b8924f5a99943b19c5c532d";
    sha256 = "0qxsqv3iiymrq5lmcqszifdsig0gmwf735i3f41yn88xhi9pwpcn";
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
