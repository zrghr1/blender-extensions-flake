{ lib, pkgs }:
let
  name = "amaranth";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/amaranth.git";
    rev = "f3dcf92d365f34cd9fdb09763fc2edf1d091107d";
    sha256 = "15f346nhq3mfywqa9r3jx06jnk516k62g3li6njg08ip5kx86y10";
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
