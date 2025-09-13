{ lib, pkgs }:
let
  name = "mesh_bsurfaces";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/mesh_bsurfaces.git";
    rev = "687156d04a95e3ff6de77a7fc286f860e3e4226e";
    sha256 = "687156d04a95e3ff6de77a7fc286f860e3e4226e";
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
