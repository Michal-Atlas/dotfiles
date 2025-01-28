{
  pkgs,
  lib,
  ...
}:
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
  programs.firefox =
    let
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        (buildFirefoxXpiAddon rec {
          pname = "progtest-theme";
          version = "1.2.0";
          addonId = "${pname}@keombre";
          url = "https://github.com/keombre/${pname}/releases/download/v${version}/${pname}s-v${version}-firefox.xpi";
          sha256 = "sha256-er6Apr8wG8VS0znkzadqngGic6Kgf95WPttyMzC2aR4=";
          meta = { };
        })
        (buildFirefoxXpiAddon rec {
          pname = "accumulate";
          version = "0.1.11resigned1";
          addonId = "{61e10dd2-44fa-4cdc-a264-5cf23cee66ae}";
          url = "https://addons.mozilla.org/firefox/downloads/file/4273844/${pname}-${version}.xpi";
          sha256 = "sha256-/I/K3e7YZ0Y1KkUX9ZyRZa7hR2lrvVT43whLkjjomKQ=";
          meta = { };
        })
        (buildFirefoxXpiAddon rec {
          pname = "10ten_ja_reader";
          version = "1.22.0";
          addonId = "{59812185-ea92-4cca-8ab7-cfcacee81281}";
          url = "https://addons.mozilla.org/firefox/downloads/file/4371439/${pname}-${version}.xpi";
          sha256 = "sha256-1vMZe34zg/JyO5N22T4D/lFeXGEPnAcj2WGLENPMS/E=";
          meta = { };
        })
        (buildFirefoxXpiAddon rec {
          pname = "query_amo";
          version = "0.1";
          addonId = "queryamoid@kaply.com";
          url = "https://github.com/mkaply/queryamoid/releases/download/v${version}/${pname}_addon_id-${version}-fx.xpi";
          sha256 = "sha256-8qFfB41cUWRO6yHI2uFRYp56tA7SwLvDdsbEm4ThGks=";
          meta = { };
        })
        # keep-sorted start
        auto-tab-discard
        awesome-rss
        geminize
        ipfs-companion
        old-reddit-redirect
        proton-pass
        proton-vpn
        react-devtools
        search-by-image
        simple-translate
        ublock-origin
        untrap-for-youtube
        wayback-machine
        zotero-connector
        # keep-sorted end
      ];
    in
    {
      enable = lib.mkDefault true;
      nativeMessagingHosts = [ pkgs.gnome-browser-connector ];
      profiles."default" = {
        inherit extensions;
        settings = {
          "extensions.autoDisableScopes" = 0;
          "sidebar.verticalTabs" = true;
          "reader.toolbar.vertical" = true;
        };
        search = {
          default = "DuckDuckGo";
          force = true;
          engines = {
            "DuckDuckGo".metaData.alias = "@ddg";
            "NixOS Wiki" = {
              urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
              iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
          };
        };
      };
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        PasswordManagerEnabled = false;
        TranslateEnabled = true;
        UserMessaging.SkipOnboarding = true;
        UseSystemPrintDialog = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionUpdate = true;
        ExtensionSettings = builtins.listToAttrs (
          builtins.map (pkg: {
            name = pkg.addonId;
            value = {
              install_url = pkg.src.url;
              installation_mode = "force_installed";
              updates_disabled = false;
            };
          }) extensions
        );
        DisablePocket = true;
        DisableFirefoxAccounts = false;
        DisableAccounts = false;
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
