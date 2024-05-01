{source, ...}:
with source; {
  # CUSTOMAPPS ----------------------------------------------------------------
  localFiles = {
    name = "localFiles";
    src = localFilesSrc;
    appendName = false;
  };

  betterLibrary = {
    name = "betterLibrary";
    src = "${betterLibrarySrc}/CustomApps";
    appendName = true;
  };

  library = {
    name = "library";
    src = spicetifyLibrarySrc;
    appendName = false;
  };

  statistics = {
    name = "stats";
    src = spicetifyStatsSrc;
    appendName = false;
  };

  marketplace = {
    name = "marketplace";
    src = marketplaceSrc;
    appendName = false;
  };

  nameThatTune = {
    name = "nameThatTune";
    src = nameThatTuneSrc;
    appendName = false;
  };

  official = {
    new-releases = {
      src = "${officialSrc}/CustomApps";
      name = "new-releases";
      appendName = true;
    };
    reddit = {
      src = "${officialSrc}/CustomApps";
      name = "reddit";
      appendName = true;
    };
    lyrics-plus = {
      src = "${officialSrc}/CustomApps";
      name = "lyrics-plus";
      appendName = true;
    };
  };
}
