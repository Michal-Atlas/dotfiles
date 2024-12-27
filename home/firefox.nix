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
        tree-style-tab
        ublock-origin
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
        userChrome = ''
          @-moz-document url(about:home), url(about:newtab) {
            body::before {
              content: "";
              z-index: -1;
              position: fixed;
              top: 0;
              left: 0;
              background: #f9a no-repeat url(${
                builtins.fetchurl {
                  url = "https://wallpapers.com/images/hd/d-gray-man-seu3ez22l0pv05ho.jpg";
                  sha256 = "sha256:1g5pa6mk1kz5yyjh20y3s5hlxfh0sm24x3m33yj9593f6rha8h8r";
                }
              }) center;
              width: 100vw;
              height: 100vh;
            }
          }      
        '';
        settings = {
          "extensions.autoDisableScopes" = 0;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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
        ExtensionSettings =
          {
            "*".installation_mode = "blocked";
          }
          // builtins.listToAttrs (
            builtins.map (pkg: {
              name = pkg.addonId;
              value = {
                install_url = pkg.src.url;
                installation_mode = "force_installed";
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
