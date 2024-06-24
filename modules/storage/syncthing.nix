_: {
  services.syncthing = {
    enable = true;
    user = "michal_atlas";
    configDir = "/home/michal_atlas/.config/syncthing";
    overrideDevices =
      true;
    overrideFolders =
      true;
    relay.enable = false;
    openDefaultPorts = true;
    settings = {
      options.urAccepted = 1;
      devices = {
        "nox" = {
          id = "AU5JJKW-3SMX2RX-SESG5T3-GN2IL4B-EWCQEXP-GCMDTCY-5W27SMJ-76I4DQL";
        };
        "hydra" = {
          id = "4F77KY2-XKLI7OD-J5GX6RH-VLFWIZA-M45YSV2-C2PNRGE-4GCE5Y5-ZLSTHQP";
        };
        "dagon" = {
          id = "PBSLXD7-PGPCQBF-AEY4BGJ-HN63PWK-NOXVRKN-62A3AQB-MMWOHOO-VEW3SQN";
        };
        "leviathan" = {
          id = "IFCUV77-3KPKXMM-DYSXMFI-5QCWU4D-7IJWAXI-MH3RNUP-P64MWDY-O5UEPAI";
        };
      };
      folders = with builtins; (
        listToAttrs
        (map
          (name: {
            name = "${name}";
            value = {
              path = "/home/michal_atlas/${name}";
              devices = [
                "nox"
                "hydra"
                "dagon"
                "leviathan"
              ];
            };
          })
          ["cl" "Documents" "Sync" "Zotero"])
      );
    };
  };
}
