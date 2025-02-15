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
    plugins = {
      # keep-sorted start
      auto-save.enable = true;
      cursorline.enable = true;
      direnv.enable = true;
      haskell-scope-highlighting.enable = true;
      lightline.enable = true;
      lsp-signature.enable = true;
      markdown-preview.enable = true;
      neogit.enable = true;
      nix.enable = true;
      nvim-autopairs.enable = true;
      project-nvim.enable = true;
      rustaceanvim.enable = true;
      telescope.enable = true;
      tmux-navigator.enable = true;
      treesitter.enable = true;
      vim-slime.enable = true;
      vimtex.enable = true;
      which-key.enable = true;
      # keep-sorted end
    };
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
