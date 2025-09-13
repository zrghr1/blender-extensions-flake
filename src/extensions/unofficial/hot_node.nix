{ lib, pkgs }:
let
  name = "hot_node";
  repo =  pkgs.fetchFromGitHub {
    owner = "Trantor2098";
    repo = "${name}";
    rev = "de39a53f6816ad7d2ad4a2cde48fb7c407fa4d6b";
    sha256 = "1q8pnygrf517iablv4ddr0a6h080ylkrzb6k2954hzksm3c7grxq";
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
