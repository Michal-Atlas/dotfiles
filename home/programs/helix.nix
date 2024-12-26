_: {
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape.insert = "bar";
        file-picker.hidden = false;
        whitespace.render.tab = "all";
        indent-guides.render = true;
        soft-wrap.enable = true;
        cursorline = true;
        auto-save = true;
        bufferline = "multiple";
        color-modes = true;
      };
      keys.normal = {
        space.space = "file_picker";
      };
    };
    languages = {
      language-server.ucm = {
        command = "ncat";
        args = [
          "localhost"
          "5757"
        ];
      };
      language = [
        {
          name = "unison";
          language-servers = [ "ucm" ];
        }
        {
          name = "nix";
          formatter.command = "alejandra";
        }
      ];
    };
  };
}
