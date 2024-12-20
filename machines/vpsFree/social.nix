{
  config,
  ...
}:
{
  networking.firewall.allowedTCPPorts = [
    config.services.writefreely.settings.server.gopher_port
  ];
  services = {
    writefreely = {
      enable = true;
      admin.name = "root";
      host = "text.${config.networking.domain}";
      acme.enable = true;
      nginx = {
        enable = true;
        forceSSL = true;
      };
      settings = {
        server.gopher_port = 70;
        app = {
          single_user = true;
          federation = true;
        };
      };
    };
    mastodon = {
      #      enable = true;
      localDomain = "social.${config.networking.domain}";
      configureNginx = true;
      streamingProcesses = 2;
      smtp.fromAddress = "noreply@social.michal-atlas.cz";
      extraConfig.SINGLE_USER_MODE = "true";
    };
    pixelfed = {
      enable = true;
      domain = "pixel.${config.networking.domain}";
      redis.createLocally = true;
      database.createLocally = true;
      settings.PF_OPTIMIZE_IMAGES = false;
      secretFile = "/var/lib/pixelfed/secrets";
      nginx = {
        enableACME = true;
        forceSSL = true;
      };
      maxUploadSize = "50M";
    };
    nginx.virtualHosts = {
      "tube.michal-atlas.cz" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://hydra:9000";
          extraConfig = ''
            client_max_body_size 2G;
          '';
        };
      };
    };
  };
}
