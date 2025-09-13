{ lib, pkgs }:
let
  name = "mesh_inset";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/mesh_inset.git";
    rev = "16373bffeae37c4899d579ebfe71f7fc60bcbd85";
    sha256 = "1hzrnmp3kxig9z95nj97lhgdmvzrip4fbwkywnqdf3pzfg8bz4yv";
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
