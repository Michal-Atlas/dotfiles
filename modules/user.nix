{ pkgs, config, ... }:
{
  users = {
    groups.plugdev = { };
    users = {
      michal_atlas = {
        isNormalUser = true;
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
          config.services.kubo.group
        ];
        openssh.authorizedKeys.keys =
          with builtins;
          (map (f: readFile ../keys/${f}) (attrNames (readDir ../keys)));
        linger = true;
      };
      david = {
        isNormalUser = true;
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
