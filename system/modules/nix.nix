{ self, nur, emacs-overlay, atlas-overlay, guix-overlay, ... }: {
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = with self.inputs; [
      nur.overlay
      emacs-overlay.overlays.default
      (import ../../overlays/atlas-emacs.nix)
      atlas-overlay.overlays.x86_64-linux.default
      guix-overlay.overlays.default
    ];
  };
}
