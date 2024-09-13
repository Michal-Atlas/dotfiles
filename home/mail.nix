{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      settings = {
        "mail.default_send_format" = 1;
      };
    };
  };
  accounts.email.accounts = {
    "proton" = rec {
      address = "me@michal-atlas.cz";
      userName = address;
      realName = "Michal Atlas";
      thunderbird.enable = true;
      imap = {
        host = "localhost";
        port = 1143;
        tls.useStartTls = true;
      };
      smtp = {
        inherit (imap) host;
        port = 1025;
        tls.useStartTls = true;
      };

    };
    "posteo" = rec {
      address = "michal_atlas@posteo.net";
      primary = true;
      userName = address;
      realName = "Michal Atlas";
      passwordCommand = "${pkgs.pass}/bin/pass -c ${imap.host}/${address}";
      thunderbird.enable = true;
      imap = {
        host = "posteo.de";
        port = 993;
      };
      smtp = {
        inherit (imap) host;
        port = 465;
      };
    };
    "ctu" =
      let
        user = "zacekmi2";
        domain = "cvut.cz";
      in
      {
        flavor = "outlook.office365.com";
        address = "${user}@fit.${domain}";
        userName = "${user}@${domain}";
        realName = "Michal Žáček";
        thunderbird = {
          enable = true;
          settings = id: {
            "mail.smtpserver.smtp_${id}.authMethod" = 10;
            "mail.server.server_${id}.authMethod" = 10;
          };
        };
        passwordCommand = "${pkgs.pass}/bin/pass -c ${domain}/${user}";
      };
  };
  systemd.user.services.protonmail-bridge = {
    Unit.Description = "Protonmail Bridge";
    Install.WantedBy = [ "graphical-session.target" ];
    Service.ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
  };
}
