_: {
  services.syncthing = {
    enable = true;
    user = "michal_atlas";
    configDir =
      "/home/michal_atlas/.config/syncthing";
    overrideDevices =
      true;
    overrideFolders =
      true;
    relay.enable = false;
    devices = {
      "nox" = {
        id = "TR36KZQ-QLRVK4R-UYME5BV-ECD4KSB-NQBQLVW-654IVPP-BO34P75-ICPNOAL";
      };
      "hydra" = {
        id = "4F77KY2-XKLI7OD-J5GX6RH-VLFWIZA-M45YSV2-C2PNRGE-4GCE5Y5-ZLSTHQP";
      };
      "dagon" = {
        id = "UOVQXCK-LGQ7OA5-YQUBF67-QHTENZK-KEEGPET-PLZZQFZ-BPSZRCJ-LVEBTAD";
      };
    };
    folders = with builtins;
      (listToAttrs
        (map
          (name:
            {
              name = "${name}";
              value = {
                path = "/home/michal_atlas/${name}";
                devices = [
                  "nox"
                  "hydra"
                  "dagon"
                ];
              };
            })
          [ "cl" "Documents" "Sync" "Zotero" ])
      );
  };
}
