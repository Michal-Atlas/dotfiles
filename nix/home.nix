{ self, config, pkgs, ... }:
let
  lib = pkgs.lib;
  inputs = self.inputs;
in {
  home = {
    username = "michal_atlas";
    homeDirectory = "/home/michal_atlas";
    stateVersion = "23.05";
    packages = with pkgs; [
      jetbrains.idea-ultimate
      discord
      spot
      telegram-desktop
      zotero
      insomnia
    ];
  };
  programs.home-manager.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
  };
  nix = {
    package = pkgs.nix;
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    settings = { experimental-features = [ "nix-command" "flakes" ]; };
  };
}
