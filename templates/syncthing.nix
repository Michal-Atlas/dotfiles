{ ... }: {
  services.syncthing = {
    enable = true;
    user = "michal_atlas";
    dataDir =
      "/home/michal_atlas/Documents"; # Default folder for new synced folders
    configDir =
      "/home/michal_atlas/.config/syncthing"; # Folder for Syncthing's settings and keys
    overrideDevices =
      true; # overrides any devices added or deleted through the WebUI
    overrideFolders =
      true; # overrides any folders added or deleted through the WebUI
    relay.enable = false;
    devices = {
      "nox" = {
        id = "JBRYVQP-2GYSCCK-2M37T6I-KSETJHC-UY7ZUQ5-GW56FMG-LDRDFQC-YUH5EAY";
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
