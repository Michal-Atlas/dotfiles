{ pkgs, ... }:
with pkgs.nur.repos.rycee.firefox-addons;
[
  ublock-origin
  tree-style-tab
  translate-web-pages
  search-by-image
  keepassxc-browser
  auto-tab-discard
  streetpass-for-mastodon
]
