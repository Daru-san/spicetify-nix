{
  pkgs,
  inputs,
  ...
}: let
  # Import the spicetify package set
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  # Import the module from your inputs
  imports = [inputs.spicetify-nix.homeManagerModule];
  # configure spicetify :)
  programs.spicetify = {
    # Enable the module and install your spiced spotify
    enable = true;

    # Your spicetify theme
    theme = spicePkgs.themes.Sleek;
    colorScheme = "BladeRunner";

    # Specify your spotify package (incase you may want to use overrides)
    spotifyPackage = pkgs.spotify;

    enabledCustomApps = with spicePkgs.apps; [
      new-releases
      lyrics-plus
      localFiles
      marketplace
    ];

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      bookmark
      history
      keyboardShortcut
      adblock
    ];
  };

  xdg.desktopEntries = {
    spotify = {
      name = "Spiced Spotify";
      exec = "spotify";
      icon = "spotify";
      type = "Application";
    };
  };
}
