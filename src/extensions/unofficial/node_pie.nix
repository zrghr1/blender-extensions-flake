{ lib, pkgs }:
let
  name = "node_pie";
  repo =  pkgs.fetchFromGitHub {
    owner = "strike-digital";
    repo = "${name}";
    rev = "694a6484da444c7ba22df90b2a3596275db9c656";
    sha256 = "04ykfqhxxj3gsayd79nv0ja2v6b2fr4rd9q3cflm9lbixnvaz4qb";
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
