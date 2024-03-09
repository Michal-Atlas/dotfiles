{
  self,
  inputs,
  ...
}: {
  perSystem = {
    system,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = let
        rebuild-cmd = cmd: ''nixos-rebuild ${cmd} --flake . "$@";'';
        sudo-rebuild-cmd = cmd: "sudo ${rebuild-cmd cmd}";
      in [
        (pkgs.writeShellScriptBin "recon" (sudo-rebuild-cmd "switch"))
        (pkgs.writeShellScriptBin "recboot" (sudo-rebuild-cmd "boot"))
        (pkgs.writeShellScriptBin "check" "nix flake check \"$@\";")
        (pkgs.writeShellScriptBin "build" (rebuild-cmd "build"))
        inputs.agenix.packages.${system}.default
        (pkgs.writeShellScriptBin "recdiff" ''
          build "$@" && ${pkgs.nix-diff}/bin/nix-diff /run/current-system result && rm result
        '')
        pkgs.commitizen
      ];
      inherit (self.checks.${system}.pre-commit-check) shellHook;
    };
  };
}
