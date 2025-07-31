{ pkgs, ... }:

let
  mainMod = "SUPER";
  wallpapers = ./wallpapers;
in
{
  home.file.".config/wallpapers" = {
    source = wallpapers;
    recursive = true;
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    pavucontrol
    rofi-wayland
    nwg-look
    alacritty
    wl-clipboard
    pamixer
    playerctl
    brightnessctl
    swww
    git-lfs
    networkmanagerapplet
    nerd-fonts.jetbrains-mono
    fastfetch
    waypaper
    grimblast
    telegram-desktop
    discord
    obs-studio
    qbittorrent
    ueberzugpp
    spotify
    catppuccin-cursors.mochaSapphire
    gemini-cli
    gruvbox-gtk-theme
    papirus-icon-theme
    brave
    bluetui
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  services.network-manager-applet.enable = true;
  services.dunst.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "gtk2";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    extraConfig = ''
      exec-once = waypaper --random --backend swww --folder ~/.config/wallpapers
      exec-once = ${pkgs.kdePackages.polkit-kde-agent-1}
      exec-once = waybar
    '';

    settings = {
      monitor = [ ",1920x1080@60,0x0,1" ];

      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 1;
        resize_on_border = true;
        "col.active_border" = "rgba(6CB6D9aa)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        blur = {
          enabled = true;
          size = 4;
          passes = 2;
        };
      };

      animations = {
        enabled = true;
      };

      input = {
        kb_layout = "br";
        follow_mouse = true;
        scroll_method = "2fg";
        touchpad = {
          natural_scroll = false;
          "tap-to-click" = true;
          middle_button_emulation = true;
        };
        sensitivity = 0;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      windowrule = [
        "opaque,class:mpv"
        "float,title:^(Open file)$"
        "float,class:org.pulseaudio.pavucontrol"
        "float,class:waypaper"
        "float,class:org.kde.polkit-kde-authentication-agent-1"
      ];

      bind = [
        ", Print, exec, grimblast --cursor --notify --freeze copysave output"
        "ALT,Print, exec,grimblast --cursor --notify --freeze copysave active"
        "SHIFT,Print, exec, grimblast --notify --freeze copysave area"

        "${mainMod}, Return, exec,alacritty"
        "${mainMod}, B, exec, brave"
        "${mainMod}, T, exec, Telegram"
        "${mainMod}, D, exec, rofi -show drun"

        "${mainMod} SHIFT, Q, killactive,"
        "${mainMod}, F, fullscreen,"
        "${mainMod}, Space, togglefloating,"
        "${mainMod}, P, pin,"
        "${mainMod}, S, togglesplit,"
        "${mainMod}, O, exec, sleep 1 && hyprctl dispatch dpms on"
        "${mainMod} SHIFT, O, exec, sleep 1 && hyprctl dispatch dpms off"

        "${mainMod}, left, movefocus, l"
        "${mainMod}, right, movefocus, r"
        "${mainMod}, up, movefocus, u"
        "${mainMod}, down, movefocus, d"
        "${mainMod}, h, movefocus, l"
        "${mainMod}, j, movefocus, d"
        "${mainMod}, k, movefocus, u"
        "${mainMod}, l, movefocus, r"

        ",XF86AudioMicMute, exec, pamixer --default-source -t"
        ",XF86AudioMute, exec,pamixer -t"
        ",XF86AudioRaiseVolume, exec,  pamixer -i 10"
        ",XF86AudioLowerVolume, exec, pamixer -d 10"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl brightnessctl set 10%-"

        "${mainMod}, X, togglespecialworkspace,"
        "${mainMod} SHIFT, X, movetoworkspace, special"

        "${mainMod} CTRL, left, workspace, -1"
        "${mainMod} CTRL, right, workspace, +1"
        "${mainMod} CTRL, h, workspace, -1"
        "${mainMod} CTRL, l, workspace, +1"

        "${mainMod} SHIFT, left, movewindow, l"
        "${mainMod} SHIFT, right, movewindow, r"
        "${mainMod} SHIFT, up, movewindow, u"
        "${mainMod} SHIFT, down, movewindow, d"
        "${mainMod} SHIFT, h, movewindow, l"
        "${mainMod} SHIFT, j, movewindow, d"
        "${mainMod} SHIFT, k, movewindow, u"
        "${mainMod} SHIFT, l, movewindow, r"

      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = toString (i + 1);
            key = if ws == "10" then "0" else ws;
          in
          [
            "${mainMod}, ${key}, workspace, ${ws}"
            "${mainMod} SHIFT, ${key}, movetoworkspace, ${ws}"
            "${mainMod} CTRL, ${key}, movetoworkspacesilent, ${ws}"
          ]
        ) 10
      ));

      # Bind mouse buttons
      bindm = [
        "${mainMod}, mouse:272, movewindow"
        "${mainMod} SHIFT, mouse:272, resizewindow"
        "${mainMod}, mouse:273, resizewindow"
      ];

    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "memory"
          "cpu"
          "temperature"
          "backlight"
          "pulseaudio"
          "battery"
        ];

        tray = {
          "icon-size" = 17;
          spacing = 10;
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          "format-icons" = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          "on-scroll-up" = "brightnessctl set 1%+";
          "on-scroll-down" = "brightnessctl set 1%-";
          "min-length" = 6;
        };

        battery = {
          states = {
            good = 80;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          "format-charging" = " ";
          "format-plugged" = " ";
          "format-alt" = "{time} {icon}";
          "format-icons" = [
            "󰁺 CHARGE NOW"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          "tooltip-format" = "{capacity}%";
        };

        clock = {
          timezone = "America/Sao_Paulo";
          format = "  {:%H:%M %d/%m}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };

        cpu = {
          interval = 5;
          format = " {usage}%";
        };

        memory = {
          interval = 5;
          format = " {used:0.1f}G/{total:0.1f}G";
        };

        temperature = {
          "thermal-zone" = 2;
          "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
          format = "{temperatureC}°C";
        };

        pulseaudio = {
          format = "{format_source} | {icon} {volume}%";
          "format-muted" = "{format_source} | 󰝟";
          "format-source" = "";
          "format-source-muted" = "";
          "on-click" = "pamixer -t";
          "on-click-right" = "pamixer --default-source -t";
          "on-click-middle" = "pavucontrol";
          "scroll-step" = 1;
          "max-volume" = 200;
          "format-icons" = {
            headphone = "";
            "hands-free" = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };
      };
    };
    style = ''
      /*
      *
      * Catppuccin Mocha palette
      * Maintainer: rubyowo
      *
      */

      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        font-size: 12px;
        padding-top: 1px;
        padding-bottom: 0px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: #cdd6f4;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 10px;
        border-width: 2px;
        border-style: solid;
        border-color: #11111b;
      }

      #workspaces button {
        padding: 5px;
        color: #45475a;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: #cdd6f4;
      }

      #workspaces button.focused {
        color: @text;
        background: #eba0ac;
        border-radius: 10px;
      }

      #workspaces button.urgent {
        color: #11111b;
        background: #a6e3a1;
        border-radius: 10px;
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        border-radius: 10px;
      }

      #clock,
      #battery,
      #pulseaudio,
      #cpu,
      #memory,
      #temperature,
      #workspaces,
      #tray,
      #backlight {
        background: #1e1e2e;
        padding: 0px 10px;
        margin: 3px 0px;
      }

      #tray {
        border-radius: 10px;
        margin-right: 4px;
        font-size: 19px;
      }

      #workspaces {
        background: #1e1e2e;
        border-radius: 10px;
        padding-right: 0px;
        padding-left: 5px;
        margin-left: 5px;
      }

      #cpu {
        background: #1e1e2e;
        padding: 0px 10px;
        margin: 3px 0px;
        color: #f5c2e7;
      }

      #clock {
        color: #f9e2af;
        border-radius: 10px;
        margin-right: 5px;
        /* padding-right: 5px */
      }


      #pulseaudio {
        color: @lavender;
      }

      #memory {
        color: #7dc4e4;
        border-bottom-left-radius: 10px;
        border-top-left-radius: 10px;
      }

      #battery {
        color: @lavender;
        /*border-radius: 0 10px 10px 0;*/
        /*margin-right: 5px;*/
      }

      #backlight {
        color: @lavender;
      }
    '';
  };
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
  home.stateVersion = "25.05";
}
