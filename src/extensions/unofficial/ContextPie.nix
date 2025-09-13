{ lib, pkgs }:
let
  name = "ContextPie";
  repo =  pkgs.fetchFromGitHub {
    owner = "bastianlstrube";
    repo = "${name}";
    rev = "1c13d4bc1ad6940dff03b6f1ed11ae3e8bd22f96";
    sha256 = "1bld9kll43zlz8allygy7w8hzycicsv81a3rlvgdw78f9ys6pnw7";
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
