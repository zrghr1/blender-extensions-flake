{ lib, pkgs }:
let
  name = "Noise-Nodes";
  repo =  pkgs.fetchFromGitHub {
    owner = "haseebahmed295";
    repo = "Noise-Nodes";
    rev = "ed6a4477c76858d0e48a8000a07f96585951bcbb";
    sha256 = "0ik1jbpxk2ncpflyk7anpj25cswrq5f0a9s1mr5z1cpxf1apilpz";
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
