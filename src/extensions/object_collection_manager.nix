{ lib, pkgs }:
let
  name = "object_collection_manager";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/${name}.git";
    rev = "fd55d530c92b9a4f270533ee8534fd31215949a5";
    sha256 = "0x74qh285gk29d92v65wnzyayqpfq0mv1z1xrxwcgr8p75bl3f3x";
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
