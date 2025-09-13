{ lib, pkgs }:
let
  name = "materials_utils";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/materials_utils.git";
    rev = "699761cf542a5750d43a06e3608cc03a63bc5cf5";
    sha256 = "0kpjgfxlw442rvbzim3j2vdz98q2vynnbmpgi6fqr7vg50z6nk7c";
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
