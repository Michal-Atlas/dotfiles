{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../modules/user.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.firewall.enable = false;
  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi"];

  # Make it use predictable interface names starting with eth0
  boot.kernelParams = ["net.ifnames=0"];

  networking.useDHCP = true;
  services.sshd.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/qv0YkGGjOuT2u8cbO6K0L7kkhg8xGEwxpGRUjKv89gNcCVOkTqVQCylUSQ4oKGWxRBieCulVYBl2FpjximdRS0MVNWfWQVTAA2v6jss7/0X1/SJgjCZTahabTN2nU3pCMiBBFwmNgcA3msZGvLw3wVBkWzb9PIPLDQ1AvaLwtYxlcDhxcoUk8Td98HDPHhfXTcLtZraZ64U0hRS+lux3pGuaIpzBsX4eIVtNpZbF06W2E0rnTirDCsUXQJsX+T+QCYo7TxX0dV3aFhe7qP9N7Q3stWmgfohkUb/u7OPLcbh+ICVLSFs8XCeYreeNI0SagoJ+ON4dwZwdKmvUzU+x ssh-key-2024-03-11"
  ];
  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "24.05";
  programs.zsh.enable = true;

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/1FC5-9E05";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ba398682-9547-45a5-858a-aad7620c10a3";
    fsType = "ext4";
  };
}
