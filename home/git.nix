{
  enable = true;
  userName = "Michal Atlas";
  userEmail = "michal_atlas+git@posteo.net";
  extraConfig = {
    filter.lfs = {
      clean = "git-lfs clean -- %f";
      smudge = "git-lfs smudge -- %f";
      process = "git-lfs filter-process";
      required = true;
    };
    user.signingKey = "3EFBF2BBBB29B99E";
    commit.gpgSign = true;
    sendEmail = {
      smtpServer = "posteo.de";
      smtpServerPort = 587;
      smtpEncryption = "tls";
      smtpUser = "michal_atlas@posteo.net";
    };
  };
  delta.enable = true;
}
