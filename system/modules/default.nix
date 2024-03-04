{ config, ... }: {
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
  ];
  system.stateVersion = "22.11";
  time.timeZone = "Europe/Prague";

  programs.mtr.enable = true;
  programs.zsh.enable = true;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    enableSSHSupport = true;
  };
  services.guix-binary = {
    enable = true;
    extraArgs = [ "--discover=yes" ];
    publish.enable = true;
  };
  boot.kernel.sysctl."net.core.rmem_max" = 2500000;
}
