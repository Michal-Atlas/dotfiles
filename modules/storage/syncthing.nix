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
          id = "N6RYEYH-E6J5LR4-6STY5F3-LDQ7NXN-RKKWP7F-MW4HAG5-RXSSJMT-DJ6WZQQ";
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
              ];
            };
          })
          ["cl" "Documents" "Sync" "Zotero"])
      );
    };
  };
}
