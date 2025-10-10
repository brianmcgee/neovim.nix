{ pkgs, ... }:
let
  package = pkgs.vimUtils.buildVimPlugin {
    name = "vim-go";
    src = pkgs.fetchFromGitHub {
      owner = "fatih";
      repo = "vim-go";
      rev = "v1.29";
      hash = "sha256-goN/0mOExk3rPm6Z5cpnCOMM47K6lK4zBqwin1lnjgk=";
    };
  };
in
{

  extraPlugins = [ package ];

  extraConfigLua = ''

  '';

  plugins.lsp.servers.gopls.enable = true;

  lsp.servers.gopls.enable = true;
}
