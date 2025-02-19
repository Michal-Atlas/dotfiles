{ pkgs, ... }:
{
  home.packages = with pkgs; [ pyright ];
  programs.nixvim = {
    extraConfigLua = ''
      vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      });
    '';
    plugins = {
      # keep-sorted start
      auto-save.enable = true;
      cursorline.enable = true;
      direnv.enable = true;
      haskell-scope-highlighting.enable = true;
      lastplace.enable = true;
      lightline.enable = true;
      lsp-lines.enable = true;
      lsp-signature.enable = true;
      lsp-status.enable = true;
      markdown-preview.enable = true;
      neogit.enable = true;
      nix.enable = true;
      nvim-autopairs.enable = true;
      project-nvim.enable = true;
      rustaceanvim.enable = true;
      tmux-navigator.enable = true;
      treesitter.enable = true;
      vim-slime.enable = true;
      vimtex.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      # keep-sorted end
      lsp-format = {
        enable = true;
        settings.tex.exclude = [ "all" ];
      };
      telescope = {
        enable = true;
        extensions = {
          # keep-sorted start
          manix.enable = true;
          undo.enable = true;
          # keep-sorted end
        };
      };
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          hls = {
            enable = true;
            installGhc = true;
          };
          bashls.enable = true;
          # keep-sorted start
          ccls.enable = true;
          lua_ls.enable = true;
          nixd.enable = true;
          pyright.enable = true;
          texlab.enable = true;
          zls.enable = true;
          # keep-sorted end
        };
      };
    };
  };
}
