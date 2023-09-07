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
  ];
  system.stateVersion = "22.11";
  time.timeZone = "Europe/Prague";

  programs.mtr.enable = true;
  programs.zsh.enable = true;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };
}
