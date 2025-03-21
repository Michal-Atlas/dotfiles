{ config, flake, ... }:
let
  GtoBString = g: builtins.toString (g * 1024 * 1024 * 1024);
in
{
  nix = {
    channel.enable = false;
    settings = {
      trusted-users = [
        "root"
        "nix-ssh"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      min-free = GtoBString 30;
      max-free = GtoBString 50;
      min-free-check-interval = 60 * 60;
      auto-optimise-store = true;
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d --max-freed 0";
    };
    sshServe = {
      enable = true;
      inherit (config.users.users.michal_atlas.openssh.authorizedKeys) keys;
      write = true;
    };
  };
  nixpkgs = {
    overlays = with flake.inputs; [
      emacs-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        # OPENRA
        "dotnet-sdk-6.0.428"
        "dotnet-runtime-6.0.36"
      ];
    };
  };
}
