{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "unicornpkg-cli";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "unicornpkg";
    repo = "cli";
    rev = "v${version}";
    hash = "sha256-AaLbe07GbKP7/WhGB1R2TE3TxNMwcgQsr/wXVioqAMQ=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/usr/share/help

    # executables
    cp $src/hoof/init.lua $out/bin/hoof.lua
    cp $src/unicorntool/init.lua $out/bin/unicorntool.lua

    # help files
    cp $src/hoof/help.txt $out/usr/share/help/hoof.txt
    cp $src/unicorntool/help.txt $out/usr/share/help/unicorntool.txt

    runHook postInstall
  '';
}
