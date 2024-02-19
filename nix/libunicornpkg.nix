{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "unicornpkg";
  version = "1.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "unicornpkg";
    repo = "libunicornpkg";
    rev = "v${version}";
    hash = "sha256-ZwJvGdkmEEsKpyaj1Ird1FQRaqwD+tYLkyMiVJ3PkIo=";
  };

  buildInputs = [ pkgs.findutils pkgs.perl ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp -r $src/unicorn $out/lib/unicorn

    runHook postInstall
  '';
}
