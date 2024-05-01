{
  description = "A nix flake that provides a home-manager module to configure spicetify with.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    {
      homeManagerModules = {
        spicetify = (import ./module.nix) {isNixOSModule = false;};
        default = self.homeManagerModules.spicetify;
      };

      nixosModules = {
        spicetify = import ./module.nix {isNixOSModule = true;};
        default = self.nixosModules.spicetify;
      };

      # nice aliases
      homeManagerModule = self.homeManagerModules.default;
      nixosModule = self.nixosModules.default;

      templates.default = {
        path = ./template;
        description = "A basic home-manager configuration which installs spicetify with the Sleek theme.";
      };
    }
    // flake-utils.lib.eachSystem
    (
      let
        inherit (flake-utils.lib) system;
      in [
        system.aarch64-linux
        system.x86_64-linux
      ]
    )
    (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      libs = pkgs.callPackage ./lib {};

      packages = {
        spicetify = pkgs.callPackage ./pkgs {};
        default = self.packages.${system}.spicetify;
      };

      checks = {
        all-tests = pkgs.callPackage ./tests {};
        minimal-config = pkgs.callPackage ./tests/minimal-config.nix {};
        all-for-theme = pkgs.callPackage ./tests/all-for-theme.nix {};
        apps = pkgs.callPackage ./tests/apps.nix {};
        default = self.checks.${system}.all-tests;
        all-exts-and-apps =
          builtins.mapAttrs
          (_: value: self.checks.${system}.all-for-theme value)
          (builtins.removeAttrs
            (pkgs.callPackage ./pkgs {}).themes
            ["override" "overrideDerivation"]);
      };

      formatter = pkgs.alejandra;
    });
}
