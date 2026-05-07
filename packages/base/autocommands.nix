{
  autoCmd = [
    # Vertically center document when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }

    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = [
        "markdown"
      ];
      command = "setlocal spell spelllang=en";
    }

    # Match nixfmt's 2-space indentation for Nix files (the project-wide
    # default is 4, which suits prettier-formatted languages).
    {
      event = "FileType";
      pattern = "nix";
      command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
    }

    # Trigger autoread checks so externally modified files reload promptly.
    # 'autoread' alone only acts when Neovim is otherwise prompted; checktime
    # forces the check on focus/buffer entry and while idle.
    {
      event = [
        "FocusGained"
        "BufEnter"
        "CursorHold"
        "CursorHoldI"
      ];
      command = "if mode() !~ '\\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif";
    }

    # Notify when a buffer was reloaded due to an external change
    {
      event = "FileChangedShellPost";
      command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None";
    }
  ];
}
