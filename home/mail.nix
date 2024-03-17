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
      address = "${user}@fit.${domain}";
      userName = "${user}@${domain}";
      imap = {
        host = "outlook.office365.com";
        port = 993;
      };
      realName = "Michal Žáček";
      smtp = {
        host = "smtp.office365.com";
        tls.useStartTls = true;
        port = 587;
      };
      thunderbird.enable = true;
      passwordCommand = "${pkgs.pass}/bin/pass -c ${domain}/${user}";
    };
  };
}
