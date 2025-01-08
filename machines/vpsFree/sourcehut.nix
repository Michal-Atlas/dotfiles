{
  pkgs,
  config,
  ...
}:
let
  domain = "michal-atlas.cz";
in
{
  networking.firewall.allowedTCPPorts = [
    25
  ];

  services = {
    nginx.virtualHosts = {
      "${domain}" = {
        enableACME = true;
      };
      "lists.${domain}".useACMEHost = "${domain}";
      "meta.${domain}".useACMEHost = "${domain}";
    };
    sourcehut = {
      enable = false;
      postfix.enable = true;
      redis.enable = true;
      postgresql.enable = true;
      nginx.enable = true;
      meta.enable = true;
      lists.enable = true;
      settings = {
        "sr.ht" = rec {
          global-domain = "${domain}";
          origin = "https://${global-domain}";
          network-key = "/etc/sourcehut/network.key";
          service-key = "/etc/sourcehut/service.key";
        };
        "lists.sr.ht".allow-new-lists = true;
        webhooks.private-key = "/etc/sourcehut/webhook.key";
        "lists.sr.ht" = {
          oauth-client-id = "1";
          oauth-client-secret = "/etc/sourcehut/service.key";
        };
        mail = {
          pgp-key-id = "0xEABFB7431162183B";
          pgp-pubkey = "/etc/sourcehut/mail.pub";
          pgp-privkey = "/etc/sourcehut/mail.priv";
          smtp-from = "Our Team Tests <me+srht@michal-atlas.cz>";
          smtp-host = "localhost";
          smtp-port = 25;
          smtp-auth = "none";
          smtp-encryption = "insecure";
        };
      };

    };
    opendkim =
      let
        cfg = config.services.opendkim;
      in
      {
        enable = false;
        domains = "csl:lists.${domain}";
        selector = "lists";
        settings = rec {
          Syslog = "yes";
          Logwhy = "yes";
          # OversignHeaders = "From";
          # RemoveOldSignatures = "yes";
          Selector = cfg.selector;
          KeyFile = "${cfg.keyPath}/${cfg.selector}.private";
          KeyTable = "refile:${builtins.toFile "dkim_key_table" ''
            keyname lists.michal-atlas.cz:${cfg.selector}:${KeyFile}
          ''}";
          SigningTable = builtins.toFile "dkim_signing_table" ''
            * keyname
          '';
        };
        inherit (config.services.postfix) user;
      };
    postfix = {
      enable = true;
      relayDomains = [ "hash:/var/lib/mailman/data/postfix_domains" ];
      sslCert = config.security.acme.certs."${domain}".directory + "/full.pem";
      sslKey = config.security.acme.certs."${domain}".directory + "/key.pem";
      config = {
        transport_maps = [ "hash:/var/lib/mailman/data/postfix_lmtp" ];
        local_recipient_maps = [ "hash:/var/lib/mailman/data/postfix_lmtp" ];
      };
      extraConfig = ''
        milter_default_action = accept
        milter_protocol = 6
        smtpd_milters = ${config.services.opendkim.socket}
        non_smtpd_milters = $smtpd_milters
      '';
      origin = "lists.${domain}";
      domain = "lists.${domain}";
      hostname = "lists.${domain}";
    };
  };
  # systemd.services.opendkim.serviceConfig.ExecStart =
  #   let
  #     cfg = config.services.opendkim;
  #   in
  #   lib.mkForce "${pkgs.opendkim}/bin/opendkim -f -l -p ${cfg.socket} -x ${cfg.configFile}";
  environment.systemPackages = with pkgs; [ sourcehut.coresrht ];
  security.acme.certs."${domain}" = {
    # server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    extraDomainNames = [
      "meta.${domain}"
      "lists.${domain}"
    ];
  };
}
