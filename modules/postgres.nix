_: {
  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "michal_atlas"
      "tjv"
    ];
    ensureUsers = [
      {
        name = "michal_atlas";
        ensureDBOwnership = true;
        ensureClauses = {
          superuser = true;
          login = true;
        };
      }
    ];
  };
}
