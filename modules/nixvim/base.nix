{ modules, ... }:
{
  imports = with modules; [
    barbar
    catppuccin
    claudecode
    colorizer
    comment
    floaterm
    gitsigns
    git-worktree
    harpoon
    lazygit
    lsp
    lualine
    markdown-preview
    neorg
    neo-tree
    nix-injections
    oil
    snacks
    startify
    telescope
    treesitter
    treesitter-textobjects
    trim
    which-key
    zellij-nav
  ];

  plugins = {
    # lazy loading
    lz-n.enable = true;

    nvim-autopairs.enable = true;
  };
}
