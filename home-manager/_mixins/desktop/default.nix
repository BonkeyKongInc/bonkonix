{ desktop, pkgs, lib, ... }:

let
  kitty_light_theme = "AtomOneLight";
  kitty_dark_theme = "Doom_One";
in
{
  imports = [
    (./. + "/${desktop}.nix")
  ];

  home = {
    packages = with pkgs; [
      element-desktop
    ];
  };

  programs = {
    kitty = {
      enable = true;

      extraConfig = ''
        include ~/.config/kitty/theme-current.conf
      '';

      settings = {
        font_family = "Iosevka NF";
        font_size = 13;

        scrollback_lines = 10000;
        placement_strategy = "center";

        repaint_delay = 1;
        input_delay = 1;
        sync_to_monitor = "no";
        enable_audio_bell = "no";
        hide_window_decorations = "yes";
        allow_remote_control = "yes";
      };

      keybindings = {
        "kitty_mod+equal" = "change_font_size all +1.0";
        "kitty_mod+minus" = "change_font_size all -1.0";
        "ctrl+f11" = "toggle_fullscreen";
      };
    };
  };

  # -------------------------
  # 🎨 THEMES (managed by Nix)
  # -------------------------
  home.file.".config/kitty/themes/dark.conf".source =
    "${pkgs.kitty-themes}/share/kitty-themes/themes/${kitty_dark_theme}.conf";

  home.file.".config/kitty/themes/light.conf".source =
    "${pkgs.kitty-themes}/share/kitty-themes/themes/${kitty_light_theme}.conf";

  # -------------------------
  # 🌗 ACTIVE THEME POINTER
  # -------------------------
  #  home.file.".config/kitty/theme-current.conf".text = ''
  #    include ~/.config/kitty/themes/dark.conf
  #  '';

  # -------------------------
  # 🧠 STATE FILE
  # -------------------------

  # -------------------------
  # ⚡ TOGGLE (no kitty @, no rebuild dependency)
  # -------------------------
  home.file.".local/bin/toggle-theme" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      STATE="$HOME/.config/theme-mode"
      KITTY="$HOME/.config/kitty"
      BAT="$HOME/.config/bat"

      current=$(cat "$STATE" 2>/dev/null)

      if [[ "$current" == "light" ]]; then
          ln -sf "$KITTY/themes/dark.conf" "$KITTY/theme-current.conf"
          echo '--theme="1337"' > "$BAT/config"
          echo "dark" > "$STATE"
      else
          ln -sf "$KITTY/themes/light.conf" "$KITTY/theme-current.conf"
          echo '--theme="light"' > "$BAT/config"
          echo "light" > "$STATE"
      fi

      pkill -USR1 kitty
    '';
  };
  home.activation.createThemeMode = lib.hm.dag.entryAfter ["writeBoundary"] ''
  if [ ! -f "$HOME/.config/theme-mode" ]; then
    echo "dark" > "$HOME/.config/theme-mode"
  fi
  if [ ! -f "$HOME/.config/bat/config" ]; then
    mkdir "$HOME/.config/bat"
    echo '--theme="1337" > "$HOME/.config/bat/config'
  fi
  '';
}
