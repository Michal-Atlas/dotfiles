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
      };
    };
  };
}
