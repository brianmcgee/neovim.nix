_: {
  # Build a customised nvim by extending a base nvim package.
  #
  # `base` is required and must be a nixvim-built nvim with an `.extend`
  # method. Internally we pass `perSystem.self.default`. Downstream:
  #
  #   inputs.brian-nvim.lib.mkNvim {
  #     base = inputs.brian-nvim.packages.${system}.default;
  #     modules = [ inputs.brian-nvim.modules.nixvim.go ];
  #     grammars = [ "yaml" "toml" ];
  #   }
  mkNvim =
    {
      base,
      modules ? [ ],
      grammars ? [ ],
    }:
    base.extend (
      { config, ... }:
      {
        imports = modules;

        plugins.treesitter.grammarPackages = map (
          g: if builtins.isString g then config.plugins.treesitter.package.builtGrammars.${g} else g
        ) grammars;
      }
    );
}
