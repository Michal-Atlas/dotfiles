{
  pkgs,
  ...
}:
{
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
      fira
      fira-code
      fira-code-symbols
      jetbrains-mono
      mplus-outline-fonts.githubRelease
      noto-fonts
    ];
  };
}
