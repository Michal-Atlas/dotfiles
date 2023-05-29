{ ... }: {
  services.cjdns = {
    enable = true;
    addExtraHosts = true;
    UDPInterface = {
      bind = "0.0.0.0:43211";
      connectTo."45.32.152.232:5078" = {
        publicKey = "08bz912l989nzqc21q9x5qr96ns465nd71f290hb9q40z94jjw60.k";
        peerName = "sssemil.k";
        password = "v277jzr7r3jgk0vk1389b2c3h0gy98t";
        login = "default-login";
        hostname = "h.rwfr.k";
      };
    };
  };
}
