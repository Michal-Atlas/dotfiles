{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes = {
      catppuccin = {
        enable = true;
        transparentBackground = true;
      };
    };
    plugins = {
      lightline.enable = true;
      nix.enable = true;
      neogit.enable = true;
      vim-slime.enable = true;
      vimtex.enable = true;
      markdown-preview.enable = true;
      # direnv.enable = true;
      project-nvim.enable = true;
      which-key.enable = true;
      auto-save.enable = true;
      cursorline.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
      tmux-navigator.enable = true;
      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            settings.formatting.command = "${pkgs.alejandra}/bin/alejandra";
          };
          hls.enable = true;
          bashls.enable = true;
          ccls.enable = true;
          lua-ls.enable = true;
          # prolog-ls.enable = true;
          pyright.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          texlab.enable = true;
          zls.enable = true;
        };
      };
      nvim-autopairs.enable = true;
    };
    options = {
      number = true;
      relativenumber = true;
      autoread = true;
      autochdir = true;
      autoindent = true;
      showmatch = true;
      scrolloff = 6;
    };
    extraPlugins = with pkgs.vimPlugins; [
      haskell-tools-nvim
    ];
  };
  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;
}
