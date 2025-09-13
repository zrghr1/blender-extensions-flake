{ lib, pkgs }:
let
  name = "render_copy_settings";
  repo =  pkgs.fetchgit {
    url = "https://projects.blender.org/extensions/render_copy_settings.git";
    rev = "db8265d23cd3fdc484a2546a8612d8354af92742";
    sha256 = "0damyxwy41bkyb6p1wfak73460jgi1dij873z81w5rjf87cl8in9";
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
