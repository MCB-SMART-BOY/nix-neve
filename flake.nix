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
            sha256 = "ab1d70dc486115a2ed2d2c75a2ee8f4085ee94a55f6db6f85e6c4de6086a1c2c";
          };
          "aarch64-linux" = {
            target = "aarch64-unknown-linux-gnu";
            sha256 = "7bde332766e97198be60eafeb502fc81bf986e4eb5b98af9f84de1ac8ea2f71c";
          };
          "x86_64-darwin" = {
            target = "x86_64-apple-darwin";
            sha256 = "ce7d93d8b29b2898bd6958dfc67549ec1ad37c1c054e9844cca4eca34380c053";
          };
          "aarch64-darwin" = {
            target = "aarch64-apple-darwin";
            sha256 = "1be1ff1446f6e18b2ebbb10c11a7d1e5ec6e14086db36af4ede461a6207e6bde";
          };
        };

        platformInfo = platformMap.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "0.6.2";

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
