{pkgs, ...}: {
  users = {
    groups.plugdev = {};
    users.michal_atlas = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Michal Atlas";
      hashedPassword = "$y$j9T$BJgm2ampHrpbLgQhzXNw4.$xppBStrecndUWp4AHAdAt3vZ7.XHmuXvNTL3WgJ0NyC";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "kvm"
        "transmission"
        "plugdev"
        "adbusers"
      ];
      openssh.authorizedKeys.keys = with builtins; (map (f: readFile ../keys/${f}) (attrNames (readDir ../keys)));
    };
    mutableUsers = false;
    users.root.hashedPassword = "$y$j9T$BJgm2ampHrpbLgQhzXNw4.$xppBStrecndUWp4AHAdAt3vZ7.XHmuXvNTL3WgJ0NyC";
  };
}
