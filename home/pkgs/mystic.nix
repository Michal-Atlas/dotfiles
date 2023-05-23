pkgs:
with pkgs;
stdenv.mkDerivation (
  let version = "0.3.1";
  in {
    buildInputs = [ autoconf automake readline texinfo ];
    pname = "mystic";
    inherit version;
    src = fetchFromSourcehut {
      owner = "~michal_atlas";
      repo = "mystic";
      rev = "v${version}";
      sha256 = "sha256-MrM6Hul0CGZCwd4Mz+EQYA1I3TqysXKWekTz0jd/rV8=";
    };
    preConfigurePhases = [ "autogen" ];
    autogen = "./autogen.sh";
  }
)
