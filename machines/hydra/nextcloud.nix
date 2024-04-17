{
  config,
  pkgs,
  ...
}: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud28;
    ensureUsers = {
      michal_atlas = {
        email = "michal_atlas@posteo.net";
        passwordFile = "/etc/nextcloud-user-pass";
      };
    };

    hostName = "cloud.michal-atlas.cz";
    https = true;
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    extraApps = {
      inherit
        (config.services.nextcloud.package.packages.apps)
        contacts
        calendar
        tasks
        previewgenerator
        phonetrack
        onlyoffice
        notes
        music
        maps
        gpoddersync
        cookbook
        bookmarks
        twofactor_nextcloud_notification
        ;
    };
    extraAppsEnable = true;
    configureRedis = true;
    maxUploadSize = "8G";
  };
  systemd.services.phpfpm-nextcloud = {
    postStart = ''
      php ${pkgs.nextcloud28}/occ db:add-missing-indices
    '';
    path = with pkgs; [config.services.nextcloud.phpPackage config.services.nextcloud.package];
  };
  systemd.services."cloud-pagekite" = {
    wantedBy = ["multi-user.target"];
    wants = ["nginx.target"];
    script = ''${pkgs.python3}/bin/python ${builtins.fetchurl {
        url = "https://pagekite.net/pk/pagekite.py";
        sha256 = "sha256:06ycpssr8jsavq83h0bz5wgmxs6cwja5h9mnipaixrkqr9glv53h";
      }} --optfile=${config.age.secrets.kite.path} 443 https://cloud.michal-atlas.cz'';
  };
  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    enableACME = true;
  };
  security.acme = {
    acceptTerms = true;
    certs = {
      ${config.services.nextcloud.hostName}.email = "michal_atlas+le@posteo.net";
    };
  };
}
