{ pkgs, config, ... }:
{
  programs.zsh.enable = true;
  users = {
    groups.plugdev = { };
    users = {
      michal_atlas = {
        isNormalUser = true;
        linger = true;
        uid = 1000;
        subUidRanges = [
          {
            count = 64000;
            startUid = 1000001;
          }
        ];
        subGidRanges = [
          {
            count = 64000;
            startGid = 1000001;
          }
        ];
        shell = pkgs.zsh;
        description = "Michal Atlas";
        hashedPassword = "$y$j9T$BJgm2ampHrpbLgQhzXNw4.$xppBStrecndUWp4AHAdAt3vZ7.XHmuXvNTL3WgJ0NyC";
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "kvm"
          "plugdev"
          "adbusers"
          "podman"
          "dialout"
          "video"
          config.services.kubo.group
        ];
        openssh.authorizedKeys.keys =
          with builtins;
          [
            "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBG/E3kHQNwdu1YQpARofBF/dSNKasoVDc04m4Aip3nrRSKR1YJtJWUmlOtW5YAU2vKt80Iwve1kEeffge3P+Ugw="
          ]
          ++ (map (f: readFile ../keys/${f}) (attrNames (readDir ../keys)));
      };
      david = {
        isNormalUser = true;
        uid = 1002;
        shell = pkgs.bashInteractive;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICdenk+u4qOiOnmZfN/Ro8V00B0C8tQOEFacRLna7qn9 dav@David3En"
        ];
      };
    };
    mutableUsers = false;
    users.root.hashedPassword = "$y$j9T$BJgm2ampHrpbLgQhzXNw4.$xppBStrecndUWp4AHAdAt3vZ7.XHmuXvNTL3WgJ0NyC";
  };
}
