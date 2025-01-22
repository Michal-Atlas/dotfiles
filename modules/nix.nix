{ flake, ... }:
let
  GtoBString = g: builtins.toString (g * 1024 * 1024 * 1024);
in
{
  nix = {
    channel.enable = false;
    settings = {
      trusted-users = [
        "root"
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
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d --max-freed 0";
    };
  };
  nixpkgs = {
    overlays = with flake.inputs; [
      emacs-overlay.overlays.default
      unison-nix.overlay
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
