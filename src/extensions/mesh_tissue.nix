{ lib, pkgs }:
let
  name = "mesh_tissue";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/mesh_tissue.git";
    rev = "6dbf07e3f7f68181362168509c8b0c7d23a58153";
    sha256 = "1yg08vw49mvx7asja03nv3shyxpyak29ngshwg7nbf9vi8grdsg7";
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
