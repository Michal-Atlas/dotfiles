{
  enable = true;
  enableVteIntegration = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;
  enableCompletion = true;
  autocd = true;
  history.ignoreDups = true;
  initExtra = ''
    set -o emacs
    function cheat { curl "cheat.sh/$@" }

    GUIX_PROFILE="/home/michal_atlas/.config/guix/current"
    . "$GUIX_PROFILE/etc/profile"
  '';
  localVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    GRIM_DEFAULT_DIR = "~/tmp";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    EDITOR = "$EDITOR -c -nw";
  };
}
