{ lib, pkgs }:
let
  name = "object_skinify";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/object_skinify.git";
    rev = "0fe31e02ea9d86f70fee9a9cf97b719af0454b0e";
    sha256 = "127iv2jli4c66ysq1g66nizm61h7vpsgrng6y3aqky52mh2fbnh4";
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
