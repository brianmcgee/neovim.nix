{ config, ... }:
{
  plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      # Tiny core: enough grammars to comfortably edit this flake itself.
      # Language-specific grammars are added by `mkNvim`'s `grammars` argument.
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        lua
        markdown
        markdown_inline
        nix
        vim
        vimdoc
      ];

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      folding.enable = true;
    };

    hmts.enable = true;
  };
}
