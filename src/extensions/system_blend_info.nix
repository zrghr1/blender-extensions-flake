{ lib, pkgs }:
let
  name = "system_blend_info";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/system_blend_info.git";
    rev = "56c39b893543ecd5dac4eb03430466bf30aa1634";
    sha256 = "0a17jjsj6kci3ywaqinsih37lh9npc2gqjfgza1k4q33y8a7g3xr";
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
