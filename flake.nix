{
  description = "A pure functional language for system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        platformMap = {
          "x86_64-linux" = {
            target = "x86_64-unknown-linux-gnu";
            sha256 = "6784dea68212bdd1a93063d1ccc19dfb488cef0daa4a5251289d17e25f4318cb";
          };
          "aarch64-linux" = {
            target = "aarch64-unknown-linux-gnu";
            sha256 = "f60ee39554dd9b682c94f7f85a7605727b15a64cb843e5acb6f93802322c76f1";
          };
          "x86_64-darwin" = {
            target = "x86_64-apple-darwin";
            sha256 = "3a773957f426ab47506c5623d58fb567b0b90b2012c81f77b3f79cc6631559dd";
          };
          "aarch64-darwin" = {
            target = "aarch64-apple-darwin";
            sha256 = "76df9c262803a1f8c1ab846e69d23042878d96e636a10de189f884eb00673976";
          };
        };

        platformInfo = platformMap.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "0.6.4";

          src = pkgs.fetchurl {
            url = "https://github.com/MCB-SMART-BOY/Neve/releases/download/v${version}/neve-${platformInfo.target}.tar.gz";
            sha256 = platformInfo.sha256;
          };

          sourceRoot = ".";

          installPhase = ''
            mkdir -p $out/bin
            cp neve $out/bin/
          '';

          meta = with pkgs.lib; {
            description = "A pure functional language for system configuration and package management";
            homepage = "https://github.com/MCB-SMART-BOY/Neve";
            license = licenses.mpl20;
            platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
          };
        };
      }
    );
}
