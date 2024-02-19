{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "semver.lua";
  version = "1.2.1";

  src = pkgs.fetchFromGitHub {
    owner = "kikito";
    repo = "semver.lua";
    rev = "v${version}";
    hash = "sha256-S0Rn6/FR/Dt+GtHZtEv1Ad1/6B4Abep6IBot887BRuc=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp $src/semver.lua $out/lib/semver.lua

    runHook postInstall
  '';
}
