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
            sha256 = "324b0b098d7a2f60c44d2e7bef7d88da8f8067519c04af3bd78561fe3fadb294";
          };
          "aarch64-linux" = {
            target = "aarch64-unknown-linux-gnu";
            sha256 = "e3f2493682df57a7eb916cc15fca2aff8db23d653756796f13160b692fd9dfa6";
          };
          "x86_64-darwin" = {
            target = "x86_64-apple-darwin";
            sha256 = "be568a0938df0331a0bc6ab41a0fa5c11290d1b9c3fa24e1df8fc3f0060daee9";
          };
          "aarch64-darwin" = {
            target = "aarch64-apple-darwin";
            sha256 = "fd2708779876414039651dfe94a944013bca48b44639117615b07f588a8bfade";
          };
        };

        platformInfo = platformMap.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "0.7.0";

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
