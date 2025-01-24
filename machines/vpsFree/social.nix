{
  flake,
  config,
  ...
}:
{
  services = {
    mastodon = {
      enable = true;
      localDomain = "social2.${config.networking.domain}";
      configureNginx = true;
      streamingProcesses = 2;
      smtp.fromAddress = "noreply@social.michal-atlas.cz";
      extraConfig.SINGLE_USER_MODE = "true";
    };
    gotosocial = {
      enable = true;
      settings = {
        host = "social.${config.networking.domain}";
        port = 6523;
      };
    };
    nginx.virtualHosts =
      let
        defaults = flake.self.lib.nginxDefaults;
      in
      with config.services.gotosocial;
      {
        "${settings.host}" = defaults // {
          locations."/" = {
            proxyWebsockets = true;
            proxyPass = "http://${settings.bind-address}:${toString settings.port}";
          };
        };
      };
  };
}
