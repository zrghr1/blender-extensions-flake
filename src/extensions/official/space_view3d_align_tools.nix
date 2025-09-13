{ lib, pkgs }:
let
  name = "space_view3d_align_tools";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_align_tools.git";
    rev = "f911bd84260292f3e578b2df715fceb75141efb4";
    sha256 = "0rsmbv4kpivnmxagax2qwj8gmw3pg0dy3jysa33x0z7bq23dw772";
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
