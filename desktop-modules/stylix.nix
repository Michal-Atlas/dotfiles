{
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;
    image = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Michaelangel007/vim_cheat_sheet/refs/heads/master/vim_cheat_sheet_for_programmers_print_150dpi.png";
      sha256 = "sha256:1llk3w5q51gzwa88i5q2lssmcx1v39csj14h4qqhiax0kfb9ah6j";
    };
    polarity = "dark";
    targets = {
      gtk.enable = true;
      nixos-icons.enable = true;
      spicetify.enable = true;
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
    fonts = with pkgs; {
      serif = {
        package =
          pkgs.runCommand "coelacanth-font"
            {
              src = texlivePackages.coelacanth.tex;
            }
            ''
              install -D $src/fonts/opentype/public/coelacanth/* -t $out/share/fonts/opentype
            '';
        name = "Coelacanth";
      };
      sansSerif = {
        package = jetbrains-mono;
        name = "Jetbrains Mono";
      };
      monospace = {
        package = fira-code;
        name = "Fira Code";
      };
    };
  };
}
