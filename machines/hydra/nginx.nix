_: {
  services.nginx = {
    enable = true;
    virtualHosts."gallery" = {
      listen = [
        {
          port = 6942;
          addr = "127.0.0.1";
        }
      ];
      http2 = true;
      locations."/".root = "/DISKB/gallery/_build";
    };
  };
}
