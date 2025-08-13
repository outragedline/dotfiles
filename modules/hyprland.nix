{ pkgs, ... }:

let
  mainMod = "SUPER";
in
{

  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
    pavucontrol
    rofi-wayland
    alacritty
    wl-clipboard
    pamixer
    playerctl
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
    brave
    bluetui

    # eww
    brightnessctl
    socat
    jq
    inotify-tools
  ];

  nixpkgs.config.allowUnfree = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  services.network-manager-applet.enable = true;
  services.dunst.enable = true;
  programs.eww = {
    enable = true;
    configDir = ../home/eww;
  };

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
      exec-once = sh ${../home/eww/launch.sh}
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

        animation = [
          "workspaces, 1, 4, default, slidevert"
        ];
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
