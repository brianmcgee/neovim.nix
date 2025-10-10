{ modules, ... }:
{
  imports = with modules; [
    barbar
    catppuccin
    claude
    colorizer
    comment
    floaterm
    gitsigns
    harpoon
    lazygit
    lsp
    lualine
    markdown-preview
    neorg
    neo-tree
    oil
    snacks
    startify
    telescope
    treesitter
    trim
  ];

  plugins = {
    # lazy loading
    lz-n.enable = true;

    nvim-autopairs.enable = true;
  };
}
