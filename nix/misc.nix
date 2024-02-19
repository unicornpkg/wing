{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  name = "wing-misc";

  dontUnpack = true;

  installPhase = let
    unicornpkgMainRepo = "https://raw.githubusercontent.com/unicornpkg/unicornpkg-main/main/";
    semverPackageInstallRecord = ''{
  pkgType = "com.github",
  name = "semver",
  instdat = {
    repo_ref = "v1.2.1",
    filemaps = {
      [ "semver.lua" ] = "/lib/semver.lua",
    },
    repo_owner = "kikito",
    repo_name = "semver.lua",
  },
  unicornSpec = "v1.0.0",
  version = "1.2.1",
  desc = "Library for manipulating Semantic Versioning version numbers",
}'';
  in ''
    mkdir -p $out/etc/unicorn/remotes $out/etc/unicorn/packages/installed

    # setup remotes properly
    echo "${unicornpkgMainRepo}" > $out/etc/unicorn/remotes/40_unicornpkg_main.txt

    # mark the semver package as properly installed
    echo "${semverPackageInstallRecord}" > $out/etc/unicorn/packages/installed/semver
  '';
}
