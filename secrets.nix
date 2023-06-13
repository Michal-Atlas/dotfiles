let
  system = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBQsWWv3hN8w+taUpQrjD3a2heZRQ/zTPbuFTyVBw7K"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKTYuh5bYyuSHU1FlW//z1oW1fd64CNQV+Rxq4nPZdtf5+qUgP2IujebxdxDMOubYcBAKweDNpp2V4aDd7Y9OH7UaeuH3ZWs5qbLUqHurOdt30e1tcUZWMqvGQ1BLlm29T+XIdn37aaBv+sMcfMP7ziNIMl8CujM1+apN35qjrBEZHs0Eyue5ymt7C7ClcpC2iHJVk68xkdfNsGOhUkuD5o6KiQF9yFWOU21XqoQqBUYkburFWBEPTGxWtKQItz7nXW/+RbmEhmrT/FuVd5+bzK1rR52Fv5MEbfiV92OntoY4T7gigDR0JBC30aXK2BXBp3yBeaEBGodiSa52/y1kDH2qqRqs1Kz7oP2X34INi6rA5muhDGn2Qg9uwu5Qt1jUkLx+cOv7vdVmvcOFCpgYgdjnC0ETEsEyrDlZumWIAavEZniMw283KkaSYCMdDJlwOcSyVaY2LU4MuPWHUhlx4ot3Hh/m8UGNWwv4zcLr5DxQh6O8d9UIc3oCOgVv0ozM="
  ];
in
{
  "secrets/fit-vpn.age".publicKeys = system;
  "secrets/fit-mount.age".publicKeys = system;
}
