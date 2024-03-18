{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      lightline.enable = true;
      nix.enable = true;
      vim-slime.enable = true;
      vimtex.enable = true;
      markdown-preview.enable = true;
      # direnv.enable = true;
      which-key.enable = true;
      auto-save.enable = true;
      cursorline.enable = true;
      lsp.servers = {
        nixd = {
          enable = true;
          settings.formatting.command = "${pkgs.alejandra}/bin/alejandra";
        };
      };
      nvim-autopairs.enable = true;
    };
    options = {
      relativenumber = true;
      autoread = true;
      autoindent = true;
      showmatch = true;
      scrolloff = 6;
    };
  };
  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;
}
