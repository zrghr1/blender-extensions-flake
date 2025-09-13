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
 
- `simple_deform_helper` [Simple Deform Helper](https://extensions.blender.org/add-ons/simple-deform-helper/) 
- `nd` [ND](https://extensions.blender.org/add-ons/nd/) 
- `mio3_uv` [Mio3 UV](https://extensions.blender.org/add-ons/mio3-uv/) 
- `ucupaint` [Ucupaint](https://extensions.blender.org/add-ons/ucupaint/) 
- `PlaceHelper` [Place Helper](https://extensions.blender.org/add-ons/placehelper/) 
- `EdgeFlow` [EdgeFlow](https://extensions.blender.org/add-ons/edgeflow/) 
- `UniV` [UniV](https://extensions.blender.org/add-ons/univ/) 
- `orient_to_selection` [Orient and Origin to Selected](https://extensions.blender.org/add-ons/orient-and-origin-to-selected/) 
- `node_pie` [Node Pie](https://extensions.blender.org/add-ons/nodepie/) 
- `node-arrange` [Node Arrange](https://extensions.blender.org/add-ons/node-arrange/)
- `blender_mmd_tools` [MMD Tools](https://extensions.blender.org/add-ons/mmd-tools/) 
- `modern-primitive` [Modern Primitive](https://extensions.blender.org/add-ons/modern-primitive/)
- `popoti_align_helper` [POPOTI Align Helper](https://extensions.blender.org/add-ons/popoti-align-helper/) 
- `bool-tool` [Bool Tool](https://extensions.blender.org/add-ons/bool-tool/)
- `RightMouseNavigation` [Right Mouse Navigation](https://extensions.blender.org/add-ons/right-mouse-navigation/) 
- `Screencast-Keys` [Screencast Keys](https://extensions.blender.org/add-ons/screencast-keys/)
- `hot_node` [Hot Node](https://extensions.blender.org/add-ons/hot-node/) 
- `ContextPie` [Context Pie](https://extensions.blender.org/add-ons/contextpie/) 
- `MolecularNodes` [Molecular Nodes](https://extensions.blender.org/add-ons/molecularnodes/) 
- `Colorista` [Colorista](https://extensions.blender.org/add-ons/colorista/) 
- `Gizmodal-Ops` [Gizmodal Ops](https://extensions.blender.org/add-ons/blenderdefender-gizmodalops/)
- `NodeEditorSwitcher` [Node Editor Switcher](https://extensions.blender.org/add-ons/node-editor-switcher/)
- `Bbrush` [Bbrush](https://extensions.blender.org/add-ons/bbrush/)
- `simple_renaming` [Simple Renaming](https://extensions.blender.org/add-ons/simple-renaming-panel/) 
- `Blender-Asset-Creation-Toolset` [ACT: Game Asset Creation Toolset](https://extensions.blender.org/add-ons/act-game-asset-creation-toolset/)
- `UVToolkit` [UVToolkit](https://extensions.blender.org/add-ons/uv-toolkit/)
- `copy-object-name-to-data` [Copy Object Name to Data](https://extensions.blender.org/add-ons/copy-object-name-to-data/)
- `timeline-buttons` [Timeline Buttons](https://extensions.blender.org/add-ons/timeline-buttons/)
- `Auto_Reload_Blender_addon` [Auto Reload](https://extensions.blender.org/add-ons/auto-reload/)
- `Matalogue` [Matalogue](https://extensions.blender.org/add-ons/matalogue/)
- `Noise-Nodes` [Noise Nodes](https://extensions.blender.org/add-ons/noise-nodes/)
- `blender-Universal_Multi_Importer` [Universal Multi Importer](https://extensions.blender.org/add-ons/universal-multi-importer/)
- `io_scene_max` [Import Autodesk MAX (.max)](https://extensions.blender.org/add-ons/io-scene-max/)
- `node-quick-maths` [Node Quick Maths](https://extensions.blender.org/add-ons/node-quick-maths/)
- `T3D-GN-Presets` [T3D GN Presets](https://extensions.blender.org/add-ons/t3d-gn-presets/)
