{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = builtins.fetchurl {
      url = "https://www.gnu.org/graphics/techy-gnu-tux-bivouac-large.jpg";
      sha256 = "sha256:13934pa275b6s27gja545bwic6fzhjb2y6x5bvpn30vmyva09rm0";
    };
    polarity = "dark";
    targets = {
      grub.enable = true;
      gtk.enable = true;
      nixos-icons.enable = true;
      spicetify.enable = true;
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
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
