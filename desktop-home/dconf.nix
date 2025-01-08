_: {
  dconf.settings = {
    "org/gabmus/gfeeds" = {
      show-read-items = false;
      show-empty-feeds = false;
      refresh-on-startup = true;
      feeds = builtins.toJSON {
        "https://www.smbc-comics.com/comic/rss" = { };
        "https://xkcd.com/rss.xml" = { };
        "https://the-dam.org/rss.xml" = { };
        "https://fsf.org/blogs/RSS" = { };
        "https://blog.tecosaur.com/tmio/rss.xml" = { };
        "https://guix.gnu.org/feeds/blog.atom" = { };
        "https://vkc.sh/feed/" = { };
      };
    };
  };
}
