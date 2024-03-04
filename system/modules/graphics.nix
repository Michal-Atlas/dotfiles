{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = "michal_atlas";
      };
    };
    desktopManager.gnome.enable = true;

    layout = "us,cz";
    xkbVariant = ",ucw";
    xkbOptions = "grp:caps_switch,lv3:ralt_switch,compose:rctrl-altgr";
  };
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd = {
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
    # https://nixos.wiki/wiki/AMD_GPU
    tmpfiles.rules =
      [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  };
  programs.dconf.enable = true;
  hardware.opengl = {
    driSupport = true;
    # For 32 bit applications
    driSupport32Bit = true;
    extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime amdvlk ];
    # For 32 bit applications
    # Only available on unstable
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk libva ];
    setLdLibraryPath = true;
  };
}
