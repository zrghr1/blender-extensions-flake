{ lib, pkgs }:
let
  name = "add_curve_ivygen";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/add_curve_ivygen.git";
    rev = "dd2fdea1f6189c5c0fef4603fb9782c4775a7276";
    sha256 = "1dvncj79623wa0vdpjry4q7ywil0n2wk2jghzyhl9m11rrzhzccc";
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
