{ lib, pkgs }:
let
  name = "add_mesh_extra_objects";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/add_mesh_extra_objects.git";
    rev = "b4f555b7e7d20168eb01c7daf69e45765a59c381";
    sha256 = "1j9cw56ipl0wdcny1p9nyxd6l2dx43iq81lc2j7f3r0h5ciybwra";
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
