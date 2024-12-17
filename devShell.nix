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
            prefix = "set -euox pipefail";
            rebuild-cmd = cmd: ''
              ${prefix}
              ${pkgs.nh}/bin/nh os ${cmd} . "$@";'';
          in
          [
            pkgs.nh
            (pkgs.writeShellScriptBin "switch" (rebuild-cmd "switch"))
            (pkgs.writeShellScriptBin "boot" (rebuild-cmd "boot"))
            (pkgs.writeShellScriptBin "test" (rebuild-cmd "test"))
            (pkgs.writeShellScriptBin "build" (rebuild-cmd "build"))
            (pkgs.writeShellScriptBin "check" ''nix flake check . "$@"'')
            (pkgs.writeShellScriptBin "recdiff" ''
              ${prefix}
              nixos-rebuild build --flake . "$@" && ${pkgs.nix-diff}/bin/nix-diff /run/current-system result --character-oriented --context 10 && rm result
            '')
            (pkgs.writeShellScriptBin "deploy" ''
              ${prefix}
              nixos-rebuild switch --flake .#"$1" --target-host "$1" --use-remote-sudo --use-substitutes
            '')
            inputs.agenix.packages.${system}.default
            pkgs.commitizen
          ];
      };
    };
}
