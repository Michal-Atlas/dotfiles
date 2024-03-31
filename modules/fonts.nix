{pkgs, ...}: {
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "Hack"
        "IBMPlexMono"
        "Iosevka"
        "Terminus"
        "NerdFontsSymbolsOnly"
      ];
    })
    font-awesome
    source-code-pro
    fira-code
    fira-mono
    dejavu_fonts
    dina-font
    fira-code-symbols
    jetbrains-mono
    liberation_ttf
    mplus-outline-fonts.githubRelease
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-han-sans
  ];
}
