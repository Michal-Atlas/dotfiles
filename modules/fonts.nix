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
  ];
}
