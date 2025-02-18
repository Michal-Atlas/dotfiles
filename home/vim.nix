_: {
  programs.nixvim = {
    enable = true;
    # performance.byteCompileLua.enable = true;
    defaultEditor = true;
    keymaps = [
      {
        action = "<cmd>w<CR><cmd>!nix fmt %:p<CR>";
        key = "<C-M-l>";
        mode = "n";
        options.desc = "Format given file with Nix";
      }
    ];
    opts = {
      # keep-sorted start
      autochdir = true;
      autoindent = true;
      autoread = true;
      number = true;
      relativenumber = true;
      scrolloff = 6;
      showmatch = true;
      undofile = true;
      # keep-sorted end
    };
    vimAlias = true;
    viAlias = true;
  };
}
