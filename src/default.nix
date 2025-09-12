{ config, lib, pkgs, ... }:
let 
  utils = import ./extension-utils.nix { inherit lib pkgs; };

  blenderPackage = config.programs.blender.package;
  blenderVersion = lib.versions.majorMinor blenderPackage.version;
  blenderConfigDir = ".config/blender/${blenderVersion}/extensions/user_default";

  resolvedExtensions = map (ext:
    let resolved = utils.resolveExtension ext;
    in builtins.trace "Resolved extension: ${toString resolved.name}" resolved
  ) config.programs.blender.extensions;

  blenderExtensionDir = pkgs.symlinkJoin {
    name = "blender-extensions";
    paths = map (ext: ext.package) resolvedExtensions;
  };

  pythonScript = pkgs.writeText "configure_blender.py" ''
    import bpy

    ${lib.concatStringsSep "\n\n" (map (ext: ext.toPython) resolvedExtensions)}

    bpy.ops.wm.save_userpref()

    quit()
  '';
in 
{
  options.programs.blender = {
    enable = lib.mkEnableOption "Enable Blender";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.blender;
      description = "Blender package to use";
    };
    extensions = lib.mkOption {
      type = lib.types.listOf (lib.types.oneOf [
        lib.types.str
        lib.types.attrs
      ]);
      default = [];
      description = "List of blender extensions: builtins or Github specs";
    };
  };

  config = lib.mkIf config.programs.blender.enable {
    home.packages = [ blenderPackage ];
    home.file."${blenderConfigDir}".source = blenderExtensionDir;
    home.activation.applyBlenderPrefs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.blender}/bin/blender --background --factory-startup --python '${pythonScript}'
    '';
  };
}
