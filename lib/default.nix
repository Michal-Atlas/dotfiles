rec {
  emacsConfigFile = ../files/emacs.el;
  mkEmacsPackage =
    {
      package,
      pkgs,
      configFile ? emacsConfigFile,
      ...
    }:
    let
      atlas-emacs = pkgs.emacsWithPackagesFromUsePackage {
        defaultInitFile = true;
        alwaysEnsure = true;
        config = configFile;
        inherit package;
        extraEmacsPackages = _: [ ];
      };
    in
    atlas-emacs;
  zfsMounts = builtins.mapAttrs (
    _: device: {
      fsType = "zfs";
      inherit device;
    }
  );
  btrfsMount = dev: subvol: {
    device = dev;
    options = [
      "subvol=${subvol}"
      "noatime"
      "compress=zstd"
    ];
    fsType = "btrfs";
  };
}
