_: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./graphics.nix
    ./interfacing.nix
    ./networking
    ./nix.nix
    ./sound.nix
    ./steam.nix
    ./storage
    ./user.nix
    ./virtualization.nix
    ./cachix.nix
    ./fit-mount.nix
    ./zfs.nix
  ];
  system.stateVersion = "22.11";
  time.timeZone = "Europe/Prague";

  programs = {
    mtr.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld.enable = true;
    nix-index-database.comma.enable = true;
  };
  services = {
    pcscd.enable = true;
    guix = {
      enable = true;
      gc = {
        enable = true;
        extraArgs = [ "--delete-generations=1w" ];
      };
      publish.enable = true;
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
}
