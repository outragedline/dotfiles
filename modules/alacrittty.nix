{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 9;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Light";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };
      mouse.hide_when_typing = true;
      window = {
        title = "Alacritty";
        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };
        dimensions = {
          columns = 200;
          lines = 40;
        };
      };
      colors = {
        primary = {
          background = "#1d2021";
          foreground = "#d4be98";
        };
        normal = {
          black = "#32302f";
          red = "#ea6962";
          green = "#a9b665";
          yellow = "#d8a657";
          blue = "#7daea3";
          magenta = "#d3869b";
          cyan = "#89b482";
          white = "#d4be98";
        };
        bright = {
          black = "#32302f";
          red = "#ea6962";
          green = "#a9b665";
          yellow = "#d8a657";
          blue = "#7daea3";
          magenta = "#d3869b";
          cyan = "#89b482";
          white = "#d4be98";
        };
      };
    };
  };
}
