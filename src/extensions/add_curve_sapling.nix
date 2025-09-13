{ lib, pkgs }:
let
  name = "add_curve_sapling";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/add_curve_sapling.git";
    rev = "e101d5bb17564221453c711b7d4f420346b4f57d";
    sha256 = "0d8ar7dlhpl6ick6fpif482bm5j92648plbbgr3iamfya4zc96m2";
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
