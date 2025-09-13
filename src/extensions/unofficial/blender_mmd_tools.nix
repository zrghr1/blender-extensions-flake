{ lib, pkgs }:
let
  name = "blender_mmd_tools";
  repo =  pkgs.fetchFromGitHub {
    owner = "MMD-Blender";
    repo = "${name}";
    rev = "7b0ee93f929b15cb61f36972d5abd91c1f4d2cd7";
    sha256 = "1wlb5g0f3f1png5ixh4ad0ynnrnhkkrcp1qc3cxp1dh1jfjci17s";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo}/mmd_tools $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
