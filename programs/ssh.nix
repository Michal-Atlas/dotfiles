_: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      dam = {
        user = "atlas";
        hostname = "the-dam.org";
        identityFile = "/home/michal_atlas/.ssh/the-dam";
      };
    };
  };
}
