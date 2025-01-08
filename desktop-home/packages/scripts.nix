{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "bootstrap-eduroam" ''
      ${python3.withPackages (py: [ py.dbus-python ])}/bin/python ${
        builtins.fetchurl {
          name = "cateduroam.py";
          url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=2904&device=linux&generatedfor=user&openroaming=0";
          sha256 = "sha256:00cn00c6b6q2wclz4r0x3z9bas6860bjygv0kgpdw3amrzzxsc09";
        }
      }
    '')
  ];
}
