{ lib, pkgs }:
let
  name = "io_export_paper_model";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/io_export_paper_model.git";
    rev = "fb13f8ed5b55472e06b5e20e8299059ae6363b51";
    sha256 = "fb13f8ed5b55472e06b5e20e8299059ae6363b51";
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
