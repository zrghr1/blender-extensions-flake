# Blender with Extension support
This flake provides support for blenders extensions in home-manager.

## Usage
Add this to your flake inputs
```nix
inputs = {
    blender-extensions.url = "github:zrghr1/blender-extensions-flake";
    ...
};
```
Then in your home.nix add
```nix
imports = [
    inputs.blender-extensions.homeModules.blender-extensions
];

programs.blender = {
    enable = true;
    extensions = [
        # You can add any of the built in extensions of this flake like this
        # The name of each extension is the name of its repository
        "mesh_looptools"
        "greasepencil_tools"
    ];
}
```
## How it works
In essence this flake is just a wrapper for installing blender extensions into `~/.config/blender/<version>/extensions/user_default`. This directory is used for extensions downloaded outside of [Blenders extension repository](https://extensions.blender.org/add-ons/). These extensions are then enabled by running a python script with blender running in the background during home-manager automation. This might make activation time a bit longer due to python, but I haven't noticed any difference yet.
## Supported extensions
- Most extensions from [here](https://projects.blender.org/extensions) (Excluding themes)
