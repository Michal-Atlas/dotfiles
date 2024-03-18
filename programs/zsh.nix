_: {
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    enableAutosuggestions = true;
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
  };
}
