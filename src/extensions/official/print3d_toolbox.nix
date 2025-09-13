{ lib, pkgs }:
let
  name = "print3d_toolbox";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/print3d_toolbox.git";
    rev = "ec7914d9c5b3222806a54a2bb32ea1619659654f";
    sha256 = "0ympblvvzfgp2qg5sq4f3g3rxr076qgcpxnrgjqs2qzqipc12hy9";
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
