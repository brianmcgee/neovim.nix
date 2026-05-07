{ pkgs, ... }:
{
  plugins.snacks = {
    enable = true;

    # snacks ships its own treesitter overlay queries (e.g. queries/lua/highlights.scm
    # with `;; extends`). On the modular nvim-treesitter the per-grammar packages own
    # those exact paths, so buildEnv refuses to merge them. Move the overlays into
    # `after/queries/` where Neovim merges them at runtime without colliding.
    package = pkgs.vimPlugins.snacks-nvim.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        if [ -d queries ]; then
          mkdir -p after
          mv queries after/queries
        fi
      '';
    });
  };
}
