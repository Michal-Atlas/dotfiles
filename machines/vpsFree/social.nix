{
  config,
  ...
}:
{
  services = {
    mastodon = {
      enable = true;
      localDomain = "social.${config.networking.domain}";
      configureNginx = true;
      streamingProcesses = 2;
      smtp.fromAddress = "noreply@social.michal-atlas.cz";
      extraConfig.SINGLE_USER_MODE = "true";
    };
    nginx.virtualHosts."tube.michal-atlas.cz" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://hydra:9000";
        extraConfig = ''
          proxy_set_header Host tube.${config.networking.domain};
        '';
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
      };
    };
  };
}
