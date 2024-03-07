_: {
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autocd = true;
    history.ignoreDups = true;
    localVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
      GRIM_DEFAULT_DIR = "~/tmp";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      EDITOR = "code";
    };
  };
}
