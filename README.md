# Blender with Extension support
---
This flake provides support for blenders extensions in home-manager. Do note that this flake currently only supports a few extensions, but I'll add more them bit by bit

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
        "mesh_looptools"
        "greasepencil_tools"
    ];
}
```
