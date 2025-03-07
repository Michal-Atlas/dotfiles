{
  flake,
  pkgs,
  ...
}:
{
  imports = [
    # keep-sorted start
    ./boot.nix
    ./ctu.nix
    ./fonts.nix
    ./graphics.nix
    ./hyprland.nix
    ./interfacing.nix
    ./sound.nix
    ./steam.nix
    ./storage
    ./stylix.nix
    ./virtualization.nix
    # keep-sorted end
  ];
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
    avahi = {
      enable = true;
      nssmdns4 = true;
      ipv6 = true;
    };
    locate = {
      enable = true;
      package = pkgs.plocate;
      localuser = null;
    };
    zfs = {
      autoScrub.enable = true;
      autoSnapshot = {
        enable = true;
        flags = "-k -p --utc";
      };
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
  programs = {
    spicetify =
      let
        spicePkgs = flake.inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          #keep-sorted start
          history
          phraseToPlaylist
          playNext
          popupLyrics
          sectionMarker
          shuffle
          skipStats
          songStats
          volumePercentage
          wikify
          #keep-sorted end
        ];
      };
    sniffnet.enable = true;
  };
}
