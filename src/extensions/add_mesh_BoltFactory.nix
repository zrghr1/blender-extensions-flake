{ lib, pkgs }:
let
  name = "add_mesh_BoltFactory";
  version = "0.6.0";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/add_mesh_BoltFactory.git";
    rev = "0956a4e01dc67202f562564a5ca62ab0fcc6664c";
    sha256 = "028mrddya19h2rs7ccgcx9xjykg0vvq4dbraqfgh1irywfi69gpv";
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
