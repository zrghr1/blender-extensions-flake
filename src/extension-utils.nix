{ lib, pkgs }:
let
  officialPath = ./extensions/official;
  unofficialPath = ./extensions/unofficial;

  officialFiles = lib.mapAttrs' ( name: type:
    lib.nameValuePair "${officialPath}/${name}" type
  ) builtins.readDir officialPath;

  unofficialFiles = lib.mapAttrs' ( name: type:
    lib.nameValuePair "${unofficialPath}/${name}" type
  ) builtins.readDir unofficialPath;

  extensionFiles = officialFiles // unofficialFiles;

  # Import and register extensions 
  registry = 
    lib.mapAttrs'
      (filepath: _type:
        let
          filename = baseNameOf filepath;
          name = lib.removeSuffix ".nix" filename;
        in
          lib.nameValuePair (import filepath {inherit lib pkgs;})
      )
      (lib.filterAttrs (path: type: type == "regular" && lib.hasSuffix ".nix" path) extensionFiles);

  resolveExtension = extension:
    if lib.isString extension then
      registry.${extension} or (throw "Unknown blender extension '${extension}'")
    else if lib.isAttrs extension && extension.type == "github" then
      {
        name = extension.name;
        package = pkgs.fetchFromGithub {
          inherit (extension) owner repo rev sha256;
        };
      }
    else if lib.isAttrs extension && extension.type == "official" then
      let
        url = "https://projects.blender.org/extensions/${extension.name}.git";
      in
      {
        name = extension.name;
        package = pkgs.fetchgit {
          inherit url;
          rev = extension.rev;
          sha256 = extension.sha256;
        };
      }
    else
      extension;
in
{
  inherit registry resolveExtension;
}
