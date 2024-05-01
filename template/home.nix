{
  pkgs,
  lib,
  username,
  stateVersion,
  ...
}: {
  imports = [./spicetify.nix];

  # assume you're not using nixOS
  targets.genericLinux.enable = true;

  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };

  # Enable unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # If you'd rather only have spotify
  nixpkgs.config.allowUnfreePredicate = pkgs:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];

  home.packages = with pkgs; [
    # put packages you want to install here
    firefox
  ];
}
