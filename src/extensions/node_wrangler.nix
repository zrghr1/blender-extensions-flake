{ lib, pkgs }:
let
  name = "node_wrangler";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/node_wrangler.git";
    rev = "3697b44db4861f0cf9453e019aecc25673046309";
    sha256 = "0q2a3ykzi13fa7k9ix75mybvvc7c2a16li0nldbrdyd9q5ha1zp1";
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
