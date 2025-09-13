{ lib, pkgs }:
let
  name = "mio3_uv";
  repo =  pkgs.fetchFromGitHub {
    owner = "mio3io";
    repo = "${name}";
    rev = "c3e763e23fb3aefe5e7db0ee8180f8008e84cf48";
    sha256 = "0p8p0ack6kz3lnfbnjj290p58yx4pzscsz5p3sfcbh0scmg8jq2f";
  };
  package = pkgs.runCommand "blender-extension-${name}" {} ''
    mkdir -p $out
    cp -r ${repo} $out/${name}
  '';
in
{
  inherit name package;
  toPython = ''
    bpy.ops.preferences.addon_enable(module="bl_ext.user_default.${name}")
  '';
}
