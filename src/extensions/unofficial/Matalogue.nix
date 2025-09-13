{ lib, pkgs }:
let
  name = "Matalogue";
  repo =  pkgs.fetchFromGitHub {
    owner = "gregzaal";
    repo = "Matalogue";
    rev = "bbcb353e56e24f68f50e7497d6498885dca0b75b";
    sha256 = "1v1vp8k18yfdpjp3g3v2zdxl9snfpgdpj5ma7jmvpriah5smdim9";
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
