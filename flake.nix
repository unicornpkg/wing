{
  description = "A flake for building my Hugo website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    devenv.url = "github:cachix/devenv";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, devenv, flake-utils, ... } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.libunicornpkg = import ./nix/libunicornpkg.nix { inherit pkgs; };
        packages.cli = import ./nix/cli.nix { inherit pkgs; };
        packages.misc = import ./nix/misc.nix { inherit pkgs; };
        packages.root = pkgs.stdenv.mkDerivation rec {
          name = "unicornpkg-root-fs";
          dontUnpack = true; # no src attribute
          installPhase = ''
            mkdir $out
            cp -r ${self.packages.${system}.libunicornpkg} $out
            cp -r ${self.packages.${system}.cli} $out
            cp -r ${self.packages.${system}.misc} $out
          '';
        };
        defaultPackage = self.packages.${system}.root;
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.hugo ];
          inherit inputs pkgs;
          modules = [
            ({ pkgs, ... }: {
              # This is your devenv configuration
              packages = [ ];
            })
          ];
        };
      });
}

