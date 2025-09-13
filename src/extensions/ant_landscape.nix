{ lib, pkgs }:
let
  name = "ant_landscape";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/ant_landscape.git";
    rev = "4cdcc8374651724a149ee38b2124ae377c0de72c";
    sha256 = "4cdcc8374651724a149ee38b2124ae377c0de72c";
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
