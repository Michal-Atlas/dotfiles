let
  hydra_sys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF6rO8GNLDKtnA9X5EEY8u7GE5KXqhwNVCIvN1ltkWqE root@hydra";
  hydra_user = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKTYuh5bYyuSHU1FlW//z1oW1fd64CNQV+Rxq4nPZdtf5+qUgP2IujebxdxDMOubYcBAKweDNpp2V4aDd7Y9OH7UaeuH3ZWs5qbLUqHurOdt30e1tcUZWMqvGQ1BLlm29T+XIdn37aaBv+sMcfMP7ziNIMl8CujM1+apN35qjrBEZHs0Eyue5ymt7C7ClcpC2iHJVk68xkdfNsGOhUkuD5o6KiQF9yFWOU21XqoQqBUYkburFWBEPTGxWtKQItz7nXW/+RbmEhmrT/FuVd5+bzK1rR52Fv5MEbfiV92OntoY4T7gigDR0JBC30aXK2BXBp3yBeaEBGodiSa52/y1kDH2qqRqs1Kz7oP2X34INi6rA5muhDGn2Qg9uwu5Qt1jUkLx+cOv7vdVmvcOFCpgYgdjnC0ETEsEyrDlZumWIAavEZniMw283KkaSYCMdDJlwOcSyVaY2LU4MuPWHUhlx4ot3Hh/m8UGNWwv4zcLr5DxQh6O8d9UIc3oCOgVv0ozM= michal_atlas@hydra";
  hydra = [
    hydra_user
    hydra_sys
  ];
  leviathan_user = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1V8JQosSQmV/bJ6nWbJnQKLtiSWSGaBLVWMLYq3diDoKGOnNeS83ES3v1kxPT+F/XIye8B9fzpgLvtWC2Ofl8wpNNsURuTILXc53ei1uCGEvLAg2bwmeCSUtgjV6hH8/PTfCFY2Kne9klq3oY6m8gPxzOjCQa++ihWlat4uLD+E/L1nasy1nf9Nro58iPBu0fT5kw1mr9P4Fxy20pm8LhoEwXYL7BkMs6bNpmB9PgDPRAVcoHdZLCkfkTGMz4XfqTjz5Eliq4Mr8t2/rhR4l/u33kMuSHvI/9OdTCsce3Xymqf6tQizAQJu8bWyb5IWWGqlIld/J6edujvCGnUixxLFqiEznpb9DvwFOT1nhAmNh0fx5c6qYUDlREr7qILcnjjJZnmM5RYzzFKwjp2Ds2mQtic1eQL1huNjuS0AsM1t7lEeqIZwHUxAOxDQgZwXdzVFTTpXJ5SFHUiYMdmHdiHOamXZd96WdCtWJJVWQ1fHPRJTu6DeTCQxg27KTFaT8= michal_atlas@dagon";
  leviathan_sys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeRsf+S2t9H6agvuMDIUUwFxJ0SiIdkUar0/Rh1ijxZ root@leviathan";
  leviathan = [
    leviathan_sys
    leviathan_user
  ];
in
{
  "secrets/fit/vpn".publicKeys = hydra ++ leviathan;
  "secrets/fit/mount".publicKeys = hydra ++ leviathan;
}
