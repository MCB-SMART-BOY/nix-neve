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
            sha256 = "df8021e53846ec76c06b0539e0ab6bcdf0a0366b2070deae6ec362a8c78169e9";
          };
          "aarch64-linux" = {
            target = "aarch64-unknown-linux-gnu";
            sha256 = "df8021e53846ec76c06b0539e0ab6bcdf0a0366b2070deae6ec362a8c78169e9";
          };
          "x86_64-darwin" = {
            target = "x86_64-apple-darwin";
            sha256 = "df8021e53846ec76c06b0539e0ab6bcdf0a0366b2070deae6ec362a8c78169e9";
          };
          "aarch64-darwin" = {
            target = "aarch64-apple-darwin";
            sha256 = "df8021e53846ec76c06b0539e0ab6bcdf0a0366b2070deae6ec362a8c78169e9";
          };
        };

        platformInfo = platformMap.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "neve";
          version = "3.3.1";

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
