{
  config,
  ...
}:
{
  services = {
    mastodon = {
      #      enable = true;
      localDomain = "social.${config.networking.domain}";
      configureNginx = true;
      streamingProcesses = 2;
      smtp.fromAddress = "noreply@social.michal-atlas.cz";
      extraConfig.SINGLE_USER_MODE = "true";
    };
  };
}
