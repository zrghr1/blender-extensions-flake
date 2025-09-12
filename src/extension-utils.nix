{ lib, pkgs }:
let
  extensionsPath = ./extensions;

  # All .nix files in extensionsPath
  extensionFiles = builtins.readDir extensionsPath;

  # Import and register extensions 
  registry = 
    lib.mapAttrs'
      (filename: _type:
        let
          name = lib.removeSuffix ".nix" filename;
        in
          lib.nameValuePair name (import (extensionsPath + "/${filename}") { inherit lib pkgs; })
      )
      (lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) extensionFiles);

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
