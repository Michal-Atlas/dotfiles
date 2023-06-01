_: {
  services.i2pd = {
    enable = true;
    yggdrasil.enable = true;
    enableIPv6 = true;
    proto = { http.enable = true; httpProxy.enable = true; };
  };
}
