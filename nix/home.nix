{
  self,
  config,
  pkgs,
  ...
}: let
  lib = pkgs.lib;
  inputs = self.inputs;
in {
  home = {
    username = "michal_atlas";
    homeDirectory = "/home/michal_atlas";
    stateVersion = "23.05";
    packages = with pkgs; [
      discord
      jetbrains.idea-ultimate
      teams-for-linux
      zotero
    ];
  };
  programs.home-manager.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
    permittedInsecurePackages = ["electron-24.8.6" "zotero-6.0.27"];
  };
  nix = {
    package = pkgs.nix;
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    settings = {experimental-features = ["nix-command" "flakes"];};
  };
}
