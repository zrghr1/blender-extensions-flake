{ lib, pkgs }:
let
  officialPath = ./extensions/official;
  unofficialPath = ./extensions/unofficial;

  # All .nix files in extensionsPath
  officialFiles = builtins.readDir officialPath;
  unofficialFiles = builtins.readDir unofficialPath;

  # Import and register extensions 
  officialRegistry = 
    lib.mapAttrs'
      (filename: _type:
        let
          name = lib.removeSuffix ".nix" filename;
        in
          lib.nameValuePair name (import (officialPath + "/${filename}") { inherit lib pkgs; })
      )
      (lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) officialFiles);

  unofficialRegistry = 
    lib.mapAttrs'
      (filename: _type:
        let
          name = lib.removeSuffix ".nix" filename;
        in
          lib.nameValuePair name (import (unofficialPath + "/${filename}") { inherit lib pkgs; })
      )
      (lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) unofficialFiles);

  registry = officialRegistry // unofficialRegistry;

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
