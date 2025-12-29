{
  description = "A pure functional language for system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "0.4.1";

          src = pkgs.fetchurl {
            url = "https://github.com/MCB-SMART-BOY/Neve/releases/download/v${version}/neve-x86_64-unknown-linux-gnu.tar.gz";
            sha256 = "ac11f01320378f8850bb55b0c83cde88fe0b0b1855d28869b6bbe42778867a36";
          };

          sourceRoot = ".";

          installPhase = '
            mkdir -p $out/bin
            cp neve $out/bin/
          ';

          meta = with pkgs.lib; {
            description = "A pure functional language for system configuration and package management";
            homepage = "https://github.com/MCB-SMART-BOY/Neve";
            license = licenses.mpl20;
            platforms = platforms.linux;
          };
        };
      }
    );
}
