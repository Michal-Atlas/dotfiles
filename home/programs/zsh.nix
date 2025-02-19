{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#545454,underline";
    };
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autocd = true;
    history = {
      ignoreAllDups = true;
      extended = true;
      save = 100000;
      size = 100000;
    };
    localVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
      GRIM_DEFAULT_DIR = "~/tmp";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
    initExtra = ''
      setopt interactivecomments
    '';
    loginExtra = ''
      if [ -z "''${WAYLAND_DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 2 ]; then
        dbus-run-session Hyprland
      fi
    '';
    defaultKeymap = "viins";
    plugins = with pkgs; [
      {
        name = "fzf-tab";
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
        src = zsh-fzf-tab;
      }
      {
        name = "auto-notify";
        file = "auto-notify.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-auto-notify";
          rev = "0.10.1";
          hash = "sha256-l5nXzCC7MT3hxRQPZv1RFalXZm7uKABZtfEZSMdVmro=";
        };
      }
    ];
  };
}
