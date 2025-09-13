{ lib, pkgs }:
let
  name = "MolecularNodes";
  repo =  pkgs.fetchFromGitHub {
    owner = "BradyAJohnston";
    repo = "${name}";
    rev = "af54ff1f566f47ccb94bb36d9b693715da0773f8";
    sha256 = "1ld1612ndk02xkp39jv56b999in53wf8cn8gxzahl7qz4c0d99hq";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo}/molecularnodes $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
