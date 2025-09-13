{ lib, pkgs }:
let
  name = "Auto_Reload_Blender_addon";
  repo =  pkgs.fetchFromGitHub {
    owner = "samytichadou";
    repo = "Auto_Reload_Blender_addon";
    rev = "ad18cb65abadf61322fb498216c7b2c9c4fc38de";
    sha256 = "1krq6klm4c8m2hzv7539rjwm62dhkd687z30idxwynym9ibvhi8n";
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
