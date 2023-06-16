let
  system = with builtins; [
    # Hydra
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBQsWWv3hN8w+taUpQrjD3a2heZRQ/zTPbuFTyVBw7K"
    (readFile ./keys/hydra.pub)

    # Dagon
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7IMFEW/rBArkvZjJapotIjvCDUoYRUC0epinux/CIb"
    (readFile ./keys/dagon.pub)
  ];
in
{
  "secrets/fit-vpn.age".publicKeys = system;
  "secrets/fit-mount.age".publicKeys = system;
}
