{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
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
      fira-code
      fira-mono
      fira-code-symbols
      jetbrains-mono
      mplus-outline-fonts.githubRelease
      noto-fonts
    ];
  };
}
