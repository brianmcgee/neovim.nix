{
  colorschemes.catppuccin = {
    enable = true;
    settings = {

      flavour = "mocha";

      disable_underline = true;
      term_colors = true;

      styles = {
        booleans = [
          "bold"
          "italic"
        ];
        conditionals = [ "bold" ];
      };
      integrations = {
        cmp = true;
        gitsigns = true;
        nvimtree = true;
        treesitter = true;
        notify = false;
        mini = {
          enabled = true;
          indentscope_color = "";
        };
      };
    };

  };
}
