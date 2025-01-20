_: {
  programs.ssh = {
    enable = true;
    matchBlocks =
      let
        tmuxBlock.extraOptions.RequestTTY = "yes";
      in
      {
        hydra = tmuxBlock;
        leviathan = tmuxBlock;
        vorpal = tmuxBlock;
        dam = {
          user = "atlas";
          hostname = "the-dam.org";
          identityFile = "/home/michal_atlas/.ssh/the-dam";
        };
        fray1 = {
          user = "zacekmi2";
          hostname = "fray1.fit.cvut.cz";
          extraOptions = {
            ControlMaster = "auto";
            HostKeyAlgorithms = "+ssh-rsa";
          };
        };
      };
  };
}
