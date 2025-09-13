{ lib, pkgs }:
let
  name = "RightMouseNavigation";
  repo =  pkgs.fetchFromGitHub {
    owner = "SpectralVectors";
    repo = "${name}";
    rev = "0f877eb3cbd37bd333ff45f7130922b1a935d669";
    sha256 = "163kjsl9smmjkixvkxx26wabm978gwds6dvv280b7ia0njyjkf7r";
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
