_: {
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "armv7l-linux"
    "i686-linux"
    "riscv64-linux"
  ];
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
          if (action.id == "org.libvirt.unix.manage")
             return polkit.Result.YES;
    });
  '';
}
