{ lib, pkgs }:
let
  name = "space_view3d_math_vis";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/space_view3d_math_vis.git";
    rev = "cd81f3d09ba6fa4d446a11afeb4a63ae7a4917f8";
    sha256 = "0zirhpffm8yvvgndrw0g5rk7852ccy8d6zrvr0jj17hblipf87d5";
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
