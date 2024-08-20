{ lib, ... }:
{
  services.syncthing = {
    enable = true;
    user = "michal_atlas";
    configDir = "/home/michal_atlas/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    relay.enable = false;
    openDefaultPorts = true;
    settings = {
      options = {
        maxSendKbps = lib.mkDefault 0;
        limitBandwidthInLan = true;
        urAccepted = 1;
        natEnabled = false;
      };
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
          id = "GPPPAYX-ZR5DCE5-SPIVZIP-YGHHSBT-U2KT7VR-G4UWHLL-75T7C27-3ADY6AM";
        };
        "gandr" = {
          id = "JGO3NNE-E4X4T7G-B554VB5-OONG7W3-INQHL7E-XAK2HED-3TNSV3S-6IXV2AQ";
        };
      };
      folders =
        with builtins;
        (listToAttrs (
          map
            (name: {
              name = "${name}";
              value = {
                path = "/home/michal_atlas/${name}";
                devices = [
                  "nox"
                  "hydra"
                  "dagon"
                  "leviathan"
                  "gandr"
                ];
              };
            })
            [
              "cl"
              "Pictures"
              "Music"
              "Documents"
              "Sync"
              "Zotero"
            ]
        ));
    };
  };
}
