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
        (pkgs.writeShellScriptBin "bootstrap-eduroam" ''
          ${pkgs.python3.withPackages (py: [
            py.dbus-python
          ])}/bin/python ${builtins.fetchurl {
            name = "cateduroam.py";
            url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=2904&device=linux&generatedfor=user&openroaming=0";
            sha256 = "sha256:0nrpqal4lxfs264r68fx9285vv4wkzc0r4ipza7sizazvawxm4i9";
          }}
        '')
      ];
      inherit (self.checks.${system}.pre-commit-check) shellHook;
    };
  };
}
