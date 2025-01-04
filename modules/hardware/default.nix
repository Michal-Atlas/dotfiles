{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./graphics.nix
    ./virtualization.nix
    ./interfacing.nix
    ./boot.nix
    ./fonts.nix
    ./sound.nix
  ];
  options = {
    hardware.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.hardware.enable {
    networking.firewall.allowedTCPPorts = [
      # chromecast start
      5353
      8009
      8010
      53292
      # chromecast end
    ];
    services = {
      pcscd.enable = true;
      protonmail-bridge = {
        enable = true;
        path = with pkgs; [ gnome-keyring ];
      };
    };
    boot.kernel.sysctl."net.core.wmem_max" = 2500000;
    hardware = {
      xpadneo.enable = true;
      xone.enable = true;
      bluetooth = {
        enable = true;
        settings.General.Experimental = true;
      };
    };
    services.nginx = {
      enable = true;
      virtualHosts."127.0.0.1" = {
        listen = [
          {
            port = 8091;
            addr = "127.0.0.1";
          }
        ];
        locations = {
          "/".proxyPass = "http://127.0.0.1:3000";
          "/api".proxyPass = "http://127.0.0.1:8090";
        };
      };
    };
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
          package = the-neue-black;
          name = "TheNeue-Black";
        };
        monospace = {
          package = fira-code;
          name = "Fira Code";
        };
        # sizes = {
        #   desktop = 8;
        #   applications = 12;
        # };
      };
    };
  };
}
