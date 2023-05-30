{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ../templates/yggdrasil.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  users.users."michal_atlas" = {
    group = "users";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "root";
  };
}
