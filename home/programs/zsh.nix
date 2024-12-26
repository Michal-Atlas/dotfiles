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
      ZSH_TMUX_UNICODE = true;
      ZSH_TMUX_AUTOSTART = true;
    };
    initExtra = ''
      setopt interactivecomments
    '';
    defaultKeymap = "emacs";
    plugins = with pkgs; [
      {
        name = "fzf-tab";
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
        src = zsh-fzf-tab;
      }
      {
        name = "tmux-plugin-omz";
        file = "plugins/tmux/tmux.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "f733dc340b2a1c5b2e61a4da7de790b2f557175f";
          hash = "sha256-67DSpgD5v9RIahW3SYhL9AtOToYfKMt2xrCFZSh3arI";
        };
      }
    ];
    # prezto = {
    #   enable = true;
    #   terminal.autoTitle = true;
    #   tmux = {
    #     autoStartLocal = true;
    #     autoStartRemote = true;
    #   };

    # };
  };
}
