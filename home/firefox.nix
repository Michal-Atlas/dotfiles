{ pkgs, config, ... }:
# https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.gnome-browser-connector ];
    profiles."default".extensions = with config.nur.repos.rycee.firefox-addons; [
      ublock-origin
      auto-tab-discard
      awesome-rss
      # copywebtables
      # headingsmap
      ipfs-companion
      old-reddit-redirect
      (buildFirefoxXpiAddon rec {
        pname = "progtest-theme";
        version = "1.2.0";
        addonId = "${pname}@keombre";
        url = "https://github.com/keombre/${pname}/releases/download/v${version}/${pname}s-v${version}-firefox.xpi";
        sha256 = "sha256-er6Apr8wG8VS0znkzadqngGic6Kgf95WPttyMzC2aR4=";
        meta = { };
      })
      proton-pass
      proton-vpn
      react-devtools
      search-by-image
      simple-translate
      tree-style-tab
      wayback-machine
      zotero-connector
      geminize
    ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "newtab";
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on
      SearchBar = "unified";
      Preferences = {
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.formfill.enable" = lock-false;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.urlbar.suggest.searches" = lock-false;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };
    };
  };
}
