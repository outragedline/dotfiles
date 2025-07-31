{ pkgs, ... }:

{
  home.packages = with pkgs; [
    taplo
    zellij
    btop
    lazygit
    dust
    p7zip
    rustup
    fd
    clang
    bear
    eza
    nil
    nixd
    bat
    lazygit
  ];

  home.sessionVariables = {
    EDITOR = "helix";
    VISUAL = "helix";
  };

  home.sessionPath = [
    "~/.local/bin"
    "~/.cargo/bin"
  ];

  programs.git = {
    enable = true;
    userName = "outragedline";
    userEmail = "outragedline@proton.me";
    signing = {
      signByDefault = true;
      key = "734D5FE03B99B29F";
    };
  };

  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      buffer_editor = "helix";
    };
    envFile.text = ''
      $env.PROMPT_COMMAND = { || $"($env.PWD | path basename)" }
      $env.PROMPT_COMMAND_RIGHT = ""
    '';
    shellAliases = {
      la = "ls -la";
      cat = "bat";
      yz = "yazi";
      lg = "lazygit";
      mkd = "mkdir";
    };
  };

  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = true;
      };
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        line-number = "relative";
        cursorline = true;
        end-of-line-diagnostics = "hint";
        indent-heuristic = "tree-sitter";

        lsp = {
          display-inlay-hints = true;
        };

        file-picker = {
          hidden = false;
          git-global = false;
        };

        soft-wrap = {
          enable = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
        };

        inline-diagnostics = {
          cursor-line = "warning";
        };
      };

      keys = {
        normal = {
          y = "yank_joined_to_clipboard";
          p = [ "paste_clipboard_after" ];
          P = [ "replace_selections_with_clipboard" ];
          d = [
            "yank_joined_to_clipboard"
            "delete_selection"
          ];
          z = "move_next_word_start";
          "C-s" = ":write";
          w = "move_next_sub_word_start";
          b = "move_prev_sub_word_start";
          e = "move_next_sub_word_end";
        };

        select = {
          y = "yank_joined_to_clipboard";
          p = [ "replace_selections_with_clipboard" ];
          P = [ "replace_selections_with_clipboard" ];
          d = [
            "yank_joined_to_clipboard"
            "delete_selection"
          ];
          c = [
            "trim_selections"
            "change_selection"
          ];
          w = "extend_next_sub_word_start";
          b = "extend_prev_sub_word_start";
          e = "extend_next_sub_word_end";
        };

        insert = {
          "C-space" = "completion";
        };
      };
    };

    languages = {
      language = [
        {
          name = "toml";
          formatter = {
            command = "taplo";
            args = [
              "fmt"
              "-"
            ];
          };
          auto-format = true;
        }
        {
          name = "nix";
          formatter = {
            command = "nixfmt";
            args = [ "%sh{pwd}/%{buffer_name}" ];
          };
          auto-format = true;
        }
      ];
    };
  };

}
