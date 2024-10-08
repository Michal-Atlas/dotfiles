{ inputs, ... }:
{
  perSystem =
    {
      system,
      pkgs,
      config,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        shellHook = config.pre-commit.installationScript;
        nativeBuildInputs =
          let
            rebuild-cmd = cmd: ''${pkgs.nh}/bin/nh os ${cmd} . "$@";'';
          in
          [
            pkgs.nh
            (pkgs.writeShellScriptBin "switch" (rebuild-cmd "switch"))
            (pkgs.writeShellScriptBin "boot" (rebuild-cmd "boot"))
            (pkgs.writeShellScriptBin "test" (rebuild-cmd "test"))
            (pkgs.writeShellScriptBin "build" (rebuild-cmd "build"))
            (pkgs.writeShellScriptBin "check" ''nix flake check . "$@"'')
            (pkgs.writeShellScriptBin "recdiff" ''
              nixos-rebuild build --flake . "$@" && ${pkgs.nix-diff}/bin/nix-diff /run/current-system result && rm result
            '')
            inputs.agenix.packages.${system}.default
            pkgs.commitizen
            (pkgs.writeShellScriptBin "bootstrap-eduroam" ''
              ${pkgs.python3.withPackages (py: [ py.dbus-python ])}/bin/python ${
                builtins.fetchurl {
                  name = "cateduroam.py";
                  url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=2904&device=linux&generatedfor=user&openroaming=0";
                  sha256 = "sha256:0nrpqal4lxfs264r68fx9285vv4wkzc0r4ipza7sizazvawxm4i9";
                }
              }
            '')
          ];
      };
    };
}
