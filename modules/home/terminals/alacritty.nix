{...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        opacity = 0.8;
        dimensions = {
          columns = 120;
          lines = 30;
        };
      };

      scrolling.history = 50000;

      font = {
        size = 13.0;
        normal = {
          family = "Hack Nerd Font"; # ← era "hack"
          style = "Regular";
        };
        bold = {
          family = "Hack Nerd Font"; # ← era "hack"
          style = "Bold";
        };
        italic = {
          family = "Hack Nerd Font"; # ← era "hack"
          style = "Italic";
        };
        bold_italic = {
          family = "Hack Nerd Font"; # ← era "monospace"
          style = "Bold Italic";
        };
      };
      colors = {
        primary = {
          background = "#222222";
          foreground = "#F9F9F9";
        };
        normal = {
          black = "#3f3f3f";
          red = "#cc0000";
          green = "#4e9a06";
          yellow = "#c4a000";
          blue = "#94bff3";
          magenta = "#85678f";
          cyan = "#06989a";
          white = "#dcdccc";
        };
        bright = {
          black = "#545454";
          red = "#fc5454";
          green = "#8ae234";
          yellow = "#fce94f";
          blue = "#94bff3";
          magenta = "#b294bb";
          cyan = "#93e0e3";
          white = "#ffffff";
        };
      };

      keyboard.bindings = [
        {
          key = "F11";
          action = "ToggleFullscreen";
        }
      ];
    };
  };
}
