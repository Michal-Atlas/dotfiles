_: {
  nix = {
    buildMachines = [{
      hostName = "hydra";
      system = "x86_64-linux";
      # if the builder supports building for multiple architectures, 
      # replace the previous line by, e.g.,
      # systems = ["x86_64-linux" "aarch64-linux"];
      maxJobs = 12;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
      sshUser = "michal_atlas";
      sshKey = "/home/michal_atlas/.ssh/id_rsa";
    }];
    distributedBuilds = true;
    extraOptions = "	builders-use-substitutes = true\n";
  };
}
