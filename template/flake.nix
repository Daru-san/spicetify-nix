{
  description = "My home-manager configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:daru-san/spicetify-nix";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # home manager use our nixpkgs and not its own
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # You may not have to do this if you only use x86_64
    systems = ["x86_64-linux" "aarch64-linux"];
    genSystems = nixpkgs.lib.genAttrs systems;
    pkgs = genSystems (system: import nixpkgs {inherit system;});

    # State username and hostname
    user = "username";
    hostname = "hostname";

    # Your NixOS version
    stateVersion = "24.05";
  in {
    # Your home-manager configuration
    homeConfigurations = genSystems (system: {
      "${user}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs.${system};
        extraSpecialArgs = {inherit inputs outputs user stateVersion;};
        modules = [
          ./home.nix # your home.nix
        ];
      };
    });
  };
}
