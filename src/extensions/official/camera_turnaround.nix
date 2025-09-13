{ lib, pkgs }:
let
  name = "camera_turnaround";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/camera_turnaround.git";
    rev = "0a0f13b93e6fb9f2cd6838dff842f63c1fcc7c6b";
    sha256 = "0h0h24ijcp8pvb3q15dmr4d4cng26n8zfxyp9fsd8gqmfymxcxvh";
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
