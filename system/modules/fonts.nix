{ pkgs, ... }: {
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
        "IBMPlexMono"
        "Iosevka"
        "Terminus"
        "NerdFontsSymbolsOnly"
      ];
    })
    font-awesome
  ];
}
