{ flake, ... }:
let
  GtoBString = g: builtins.toString (g * 1024 * 1024 * 1024);
in
{
  nix = {
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
    };
    optimise.automatic = true;
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
    };
  };
}
