{
  plugins.zellij-nav.enable = true;

  # <C-h/j/k/l> navigates between nvim splits and zellij panes.
  # Bound in both normal and terminal mode so terminals (claude, floaterm,
  # lazygit) don't trap navigation.
  keymaps =
    let
      mkNav = key: cmd: [
        {
          mode = "n";
          key = "<C-${key}>";
          action = "<CMD>ZellijNavigate${cmd}<CR>";
          options.silent = true;
          options.desc = "Navigate ${cmd}";
        }
        {
          mode = "t";
          key = "<C-${key}>";
          action = "<C-\\><C-n><CMD>ZellijNavigate${cmd}<CR>";
          options.silent = true;
          options.desc = "Navigate ${cmd}";
        }
      ];
    in
    (mkNav "h" "Left")
    ++ (mkNav "j" "Down")
    ++ (mkNav "k" "Up")
    ++ (mkNav "l" "Right");
}
