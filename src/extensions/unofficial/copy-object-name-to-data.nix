{ lib, pkgs }:
let
  name = "copy-object-name-to-data";
  repo =  pkgs.fetchFromGitHub {
    owner = "Xury46";
    repo = "copy-object-name-to-data";
    rev = "59834b222dc6c458550cf1c9cad9c54846ba8d01";
    sha256 = "16yaz12l963kjkbvqi8ihhvkk8p0hg27phw11hmcvqcnl1inj8cf";
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
