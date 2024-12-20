{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [ catppuccin ];
      baseIndex = 1;
      clock24 = true;
      mouse = true;
      prefix = "C-Space";
      tmuxp.enable = true;
      keyMode = "vi";
    };
    fzf.tmux.enableShellIntegration = true;
  };
}
