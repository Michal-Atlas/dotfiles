{ pkgs, ... }:
{
  programs = {
    fzf.tmux.enableShellIntegration = true;
    tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      mouse = true;
      disableConfirmationPrompt = true;
      # focusEvents = true;
      historyLimit = 100000;
      newSession = true;
      # shortcut = "f";
      sensibleOnTop = true;
      plugins = with pkgs.tmuxPlugins; [
        extrakto
        better-mouse-mode
      ];
    };
  };
}
