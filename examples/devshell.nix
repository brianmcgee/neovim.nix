#
# Example devshell that drops a project-specific nvim into the shell PATH.
#
# Copy this into your project, adjust the languages, and add it to your
# flake's `devShells.<system>.default` (or wherever you keep your shell).
#
# In your flake.nix add the input:
#
#   inputs.brian-nvim.url = "github:brianmcgee/neovim";
#
{
  inputs,
  pkgs,
  system,
  ...
}:
let
  nvim = inputs.brian-nvim.lib.mkNvim {
    base = inputs.brian-nvim.packages.${system}.default;

    # Pre-built language fragments. Each adds whatever the language needs
    # (plugins, LSP server, treesitter grammar) in one go.
    modules = [
      inputs.brian-nvim.modules.nixvim.go
    ];

    # Or pull grammars in a la carte by name. Combine with `modules` freely.
    grammars = [
      "json"
      "yaml"
      "toml"
    ];
  };
in
pkgs.mkShell {
  packages = [ nvim ];
}
