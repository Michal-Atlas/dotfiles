{pkgs, ...}: {
  programs.thunderbird = {
    enable = true;
    profiles."default".isDefault = true;
  };
  accounts.email.accounts = {
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
      };
    };
    "ctu" = let
      user = "zacekmi2";
      domain = "cvut.cz";
    in {
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
}
