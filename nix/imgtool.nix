{ pkgs }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "imgtool-rs";
  version = "unstable-2023-05-22";

  src = pkgs.fetchFromGitHub {
    owner = "walksanatora";
    repo = "imgtool-rs";
    rev = "7cf5b59fefdcd21f29781bcf8a2b91a00acddf78";
    hash = "sha256-J95kBKVvHHyHwj4yZ0ySYUgEcg9Q0XalwMuBX85pD/g=";
  };

  cargoHash = "sha256-8DRuC3LWCfNqifVXN8Kbf1kB3uf0zx9GWPOzpnD1KlQ=";

  nativeBuildInputs = [
    pkgs.pkg-config
  ];
}
