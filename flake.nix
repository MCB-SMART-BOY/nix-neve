{
  description = "A standalone language for system configuration, builds, and shell automation";

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
            sha256 = "a49f3fa97de75c7fa671f7efe22fdeb9ffdd7a56afde0cb145bb5e3fc76feaab";
          };
          "aarch64-linux" = {
            target = "aarch64-unknown-linux-gnu";
            sha256 = "a49f3fa97de75c7fa671f7efe22fdeb9ffdd7a56afde0cb145bb5e3fc76feaab";
          };
          "x86_64-darwin" = {
            target = "x86_64-apple-darwin";
            sha256 = "a49f3fa97de75c7fa671f7efe22fdeb9ffdd7a56afde0cb145bb5e3fc76feaab";
          };
          "aarch64-darwin" = {
            target = "aarch64-apple-darwin";
            sha256 = "a49f3fa97de75c7fa671f7efe22fdeb9ffdd7a56afde0cb145bb5e3fc76feaab";
          };
        };

        platformInfo = platformMap.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "3.4.1";

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
            description = "A standalone language for system configuration, builds, and shell automation";
            homepage = "https://github.com/MCB-SMART-BOY/Neve";
            license = licenses.mpl20;
            platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
          };
        };
      }
    );
}
