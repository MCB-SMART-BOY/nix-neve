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
            sha256 = "ad7f242887684d3a2d197b3b7d9253f30d132e85799ba41f50c1e8033150615d";
          };
          "aarch64-linux" = {
            target = "aarch64-unknown-linux-gnu";
            sha256 = "053a8aa644ff4dd46770b242490d64d758ff90ccdfba29592123e50ee114dc3c";
          };
          "x86_64-darwin" = {
            target = "x86_64-apple-darwin";
            sha256 = "ba9ada390c1e62d26e078d622542492b4f555f9e044ca39611958f500da717bd";
          };
          "aarch64-darwin" = {
            target = "aarch64-apple-darwin";
            sha256 = "8d04b4dd5addbcd90ab064abe3ac2e465037e448cdeac8e147d932890349e40d";
          };
        };

        platformInfo = platformMap.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "1.1.1";

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
