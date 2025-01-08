{
  flake,
  pkgs,
  ...
}:
{
  imports = [
    # keep-sorted begin
    ./graphics.nix
    ./virtualization.nix
    ./interfacing.nix
    ./boot.nix
    ./fonts.nix
    ./sound.nix
    ./hyprland.nix
    ./steam.nix
    ./storage
    ./stylix.nix
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
  programs.spicetify =
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
}
