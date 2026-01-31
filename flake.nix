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
            sha256 = "97ae473288b824be7b4157d9c1eddc867b6467ff25fd2ed41e430451a6253076";
          };
          "aarch64-linux" = {
            target = "aarch64-unknown-linux-gnu";
            sha256 = "30ff7c258eb6b207b3c02778b7957795aa0980b66594458ad75e09daf7d55f9d";
          };
          "x86_64-darwin" = {
            target = "x86_64-apple-darwin";
            sha256 = "659022822ec8611335e58090b03bd27b52506618cdeea4cdabf61d153963f8a7";
          };
          "aarch64-darwin" = {
            target = "aarch64-apple-darwin";
            sha256 = "5d8a304a97b98ab4b1ff52b410c28f817103427ed7929f671b8b9272dba4d44a";
          };
        };

        platformInfo = platformMap.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "1.0.0";

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
