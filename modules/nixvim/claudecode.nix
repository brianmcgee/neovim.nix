{ pkgs, ... }:
let
  claudecode = pkgs.vimUtils.buildVimPlugin {
    name = "claudecode.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "coder";
      repo = "claudecode.nvim";
      rev = "v0.3.0";
      hash = "sha256-sOBY2y/buInf+SxLwz6uYlUouDULwebY/nmDlbFbGa8=";
    };
  };
in
{
  extraPlugins = [ claudecode ];

  # The plugin shells out to the `claude` CLI; ensure it is on nvim's PATH.
  extraPackages = [ pkgs.claude-code ];

  extraConfigLua = ''
    require("claudecode").setup({})
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>cc";
      action = "<CMD>ClaudeCode<CR>";
      options.desc = "Claude: toggle";
    }
    {
      mode = "n";
      key = "<leader>cf";
      action = "<CMD>ClaudeCodeFocus<CR>";
      options.desc = "Claude: focus";
    }
    {
      mode = "n";
      key = "<leader>cr";
      action = "<CMD>ClaudeCode --resume<CR>";
      options.desc = "Claude: resume picker";
    }
    {
      mode = "n";
      key = "<leader>cC";
      action = "<CMD>ClaudeCode --continue<CR>";
      options.desc = "Claude: continue last";
    }
    {
      mode = "n";
      key = "<leader>cb";
      action = "<CMD>ClaudeCodeAdd %<CR>";
      options.desc = "Claude: add buffer to context";
    }
    {
      mode = "v";
      key = "<leader>cs";
      action = "<CMD>ClaudeCodeSend<CR>";
      options.desc = "Claude: send selection";
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "<CMD>ClaudeCodeDiffAccept<CR>";
      options.desc = "Claude: accept diff";
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = "<CMD>ClaudeCodeDiffDeny<CR>";
      options.desc = "Claude: deny diff";
    }
  ];
}
