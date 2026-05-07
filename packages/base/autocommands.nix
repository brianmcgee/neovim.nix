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
