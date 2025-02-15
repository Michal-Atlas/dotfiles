_: {
  programs.nixvim.plugins = {
    web-devicons.enable = true;
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
}
