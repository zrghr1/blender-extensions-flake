{ lib, pkgs }:
let
  name = "nd";
  repo =  pkgs.fetchFromGitHub {
    owner = "hugemenace";
    repo = "${name}";
    rev = "d38fc995091da89e5544f3fdb304f0bdd1026124";
    sha256 = "0m2bs9hijcsq8fqph9hii8rcb6riyvy5m94bmg4vhiv7f89k7yc6";
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
