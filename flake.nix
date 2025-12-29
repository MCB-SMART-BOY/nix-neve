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
            sha256 = "2f03f2043c8559b2f160ac6d1d654f600744fa08a546de57e7fc51aaae15e561";
          };
          "aarch64-linux" = {
            target = "aarch64-unknown-linux-gnu";
            sha256 = "979209fef16aa200770f076aeb86b0a2ee41249d307c3486556d2572c7c32353";
          };
          "x86_64-darwin" = {
            target = "x86_64-apple-darwin";
            sha256 = "eb7b6c819cbf878e385ca998ca29e7f83ecc86c214f04e35d368117ac8cda07f";
          };
          "aarch64-darwin" = {
            target = "aarch64-apple-darwin";
            sha256 = "93a08339b81a95e2f24cca2c2e2536a0350d017b4553cde6e360c35e98f9d8c6";
          };
        };
        
        platformInfo = platformMap.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "0.5.0";

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