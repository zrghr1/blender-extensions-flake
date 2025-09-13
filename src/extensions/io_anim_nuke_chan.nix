{ lib, pkgs }:
let
  name = "io_anim_nuke_chan";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_anim_nuke_chan.git";
    rev = "954b95fd350724d8ae339a54da560497f3c091ca";
    sha256 = "0j529h5mnzmc401v2asnzpgnsavvxz3kr819lxh07fx1cixpk4gz";
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
