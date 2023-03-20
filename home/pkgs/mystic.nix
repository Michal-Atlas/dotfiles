pkgs:
with pkgs;
stdenv.mkDerivation (
  let version = "0.3";
  in {
    buildInputs = [ autoconf automake readline texinfo ];
    pname = "mystic";
    inherit version;
    src = fetchFromSourcehut {
      owner = "~michal_atlas";
      repo = "mystic";
      rev = "v${version}";
      sha256 = "sha256-1492bbgYfgbiRd3ahUFlaFFHrk1Scx+oTIjQamQ+m5o=";
    };
    preConfigurePhases = [ "autogen" ];
    autogen = "./autogen.sh";
  }
)
