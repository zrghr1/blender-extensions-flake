# Blender with Extension support
This flake provides support for blenders extensions in home-manager.

> [!WARNING]
> During home-manager activation this module runs `blender --factory-startup` to run a python script to enable extensions. This resets your preferences in blender. If you want to avoid this, you can disable `programs.blender.autoEnableExtensions`.
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
## Supported extensions
- Most extensions from [here](https://projects.blender.org/extensions) (Excluding themes)
