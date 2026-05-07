#
# Syntax-aware motions via nvim-treesitter-textobjects.
#
# Upstream refactored this plugin so keymaps are no longer set through the
# `nvim-treesitter.configs.setup({ textobjects = ... })` table; they must be
# wired against `require('nvim-treesitter-textobjects.<module>')` directly.
# Hence the helper below and the use of nixvim's top-level `keymaps` option.
#
{ ... }:
let
  mkMoveKey = key: fn: query: desc: {
    mode = [
      "n"
      "x"
      "o"
    ];
    inherit key;
    action.__raw = "function() require('nvim-treesitter-textobjects.move').${fn}('${query}', 'textobjects') end";
    options = {
      silent = true;
      inherit desc;
    };
  };
in
{
  plugins.treesitter-textobjects.enable = true;

  # The shipped queries/nix/textobjects.scm only covers lambdas, parameters
  # and conditionals. Add `(binding)` as @assignment so `]a` / `[a` jump
  # between `name = value;` attribute bindings.
  extraFiles."after/queries/nix/textobjects.scm".text = ''
    ;; extends

    (binding) @assignment.outer
    (binding expression: (_) @assignment.inner)
    (binding attrpath: (_) @assignment.lhs)
  '';

  keymaps = [
    (mkMoveKey "]m" "goto_next_start" "@function.outer" "Next function start")
    (mkMoveKey "[m" "goto_previous_start" "@function.outer" "Prev function start")
    (mkMoveKey "]M" "goto_next_end" "@function.outer" "Next function end")
    (mkMoveKey "[M" "goto_previous_end" "@function.outer" "Prev function end")

    (mkMoveKey "]a" "goto_next_start" "@assignment.outer" "Next assignment start")
    (mkMoveKey "[a" "goto_previous_start" "@assignment.outer" "Prev assignment start")
    (mkMoveKey "]A" "goto_next_end" "@assignment.outer" "Next assignment end")
    (mkMoveKey "[A" "goto_previous_end" "@assignment.outer" "Prev assignment end")
  ];
}
