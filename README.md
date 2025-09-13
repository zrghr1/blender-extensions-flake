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
 
- [Simple Deform Helper](https://extensions.blender.org/add-ons/simple-deform-helper/) - `simple_deform_helper`
- [ND](https://extensions.blender.org/add-ons/nd/) - `nd`
- [Mio3 UV](https://extensions.blender.org/add-ons/mio3-uv/) - `mio3_uv`
- [Ucupaint](https://extensions.blender.org/add-ons/ucupaint/) - `ucupaint`
- [Place Helper](https://extensions.blender.org/add-ons/placehelper/) - `PlaceHelper`
- [EdgeFlow](https://extensions.blender.org/add-ons/edgeflow/) - `EdgeFlow`
- [UniV](https://extensions.blender.org/add-ons/univ/) - `UniV`
- [Orient and Origin to Selected](https://extensions.blender.org/add-ons/orient-and-origin-to-selected/) - `orient_to_selection`
- [Node Pie](https://extensions.blender.org/add-ons/nodepie/) - `node_pie`
- [Node Arrange](https://extensions.blender.org/add-ons/node-arrange/) - `node-arrange`
- [MMD Tools](https://extensions.blender.org/add-ons/mmd-tools/) - `blender_mmd_tools`
- [Modern Primitive](https://extensions.blender.org/add-ons/modern-primitive/) - `modern-primitive`
- [POPOTI Align Helper](https://extensions.blender.org/add-ons/popoti-align-helper/) - `popoti_align_helper`
- [Bool Tool](https://extensions.blender.org/add-ons/bool-tool/) - `bool-tool`
- [Right Mouse Navigation](https://extensions.blender.org/add-ons/right-mouse-navigation/) - `RightMouseNavigation`
- [Screencast Keys](https://extensions.blender.org/add-ons/screencast-keys/) - `Screencast-Keys`
- [Hot Node](https://extensions.blender.org/add-ons/hot-node/) - `hot_node`
- [Context Pie](https://extensions.blender.org/add-ons/contextpie/) - `ContextPie`
- [Molecular Nodes](https://extensions.blender.org/add-ons/molecularnodes/) - `MolecularNodes`
- [Colorista](https://extensions.blender.org/add-ons/colorista/) - `Colorista`
- [Gizmodal Ops](https://extensions.blender.org/add-ons/blenderdefender-gizmodalops/) - [Gizmodal-Ops]
