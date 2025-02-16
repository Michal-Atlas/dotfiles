_: {
  programs.nixvim = {
    enable = true;
    # performance.byteCompileLua.enable = true;
    defaultEditor = true;
    keymaps = [
      {
        action = "<cmd>!nix fmt %:p<CR>";
        key = "<C-M-l>";
        mode = "n";
        options.desc = "Format given file with Nix";
      }
    ];
    opts = {
      number = true;
      relativenumber = true;
      autoread = true;
      autochdir = true;
      autoindent = true;
      showmatch = true;
      scrolloff = 6;
    };
    vimAlias = true;
    viAlias = true;
  };
}
