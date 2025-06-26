{
  description = "tockloader";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            config.segger-jlink.acceptLicense = true;
            config.permittedInsecurePackages = [
              "segger-jlink-qt4-810"
            ];
          };
        in
        {
          packages.default = pkgs.callPackage ./default.nix { };
          devShells.default = import ./shell.nix { inherit pkgs; };
          formatter = pkgs.nixpkgs-fmt;
        }
      );
}
