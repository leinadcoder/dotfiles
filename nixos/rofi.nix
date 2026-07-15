{ ... }:

{
  # Rofi configuration for the Hyprland desktop.
  # The package itself is installed from packages.nix as rofi-wayland.
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      show-icons: true;
      icon-theme: "Papirus-Dark";
      font: "JetBrainsMono Nerd Font 10";
      terminal: "ghostty";
      drun-display-format: "{icon} {name}";
      display-drun: "";
      display-run: "";
      display-window: "";
      sidebar-mode: false;
    }

    @theme "powertoys-run"
  '';

  xdg.configFile."rofi/powertoys-run.rasi".text = ''
     * {
       background: #202020dd;
       background-alt: #2b2b2bee;
       background-soft: #252525cc;
       foreground: #f2f2f2;
       foreground-muted: #a6a6a6;
       selected: #3a3a3acc;
       accent: #0078d4;
       urgent: #ffb4a9;

       border-color: #ffffff22;
       spacing: 0;
     }

     window {
       width: 42%;
       location: center;
       anchor: center;
       border: 1px;
       border-color: @border-color;
       border-radius: 14px;
       background-color: @background;
       padding: 12px;
     }

     mainbox {
       background-color: transparent;
       children: [inputbar, message, listview];
       spacing: 8px;
     }

     inputbar {
       background-color: @background-alt;
       text-color: @foreground;
       border-radius: 10px;
       padding: 14px 16px;
       children: [prompt, entry];
       spacing: 10px;
     }

     prompt {
       enabled: true;
       background-color: transparent;
       text-color: @accent;
       padding: 0px 4px 0px 0px;
     }

     entry {
       background-color: transparent;
       placeholder: "Start typing...";
       placeholder-color: @foreground-muted;
       text-color: @foreground;
       cursor-color: @foreground;
       cursor: text;
     }

     message {
       background-color: transparent;
       text-color: @urgent;
       padding: 6px;
     }

     listview {
       background-color: transparent;
       columns: 1;
       lines: 7;
       cycle: true;
       dynamic: true;
       layout: vertical;
       fixed-height: true;
       spacing: 4px;
       scrollbar: false;
     }

     element {
       background-color: transparent;
       text-color: @foreground;
       border-radius: 8px;
       padding: 10px 12px;
       spacing: 12px;
     }

     element selected {
       background-color: @selected;
       text-color: @foreground;
     }

     element-icon {
       size: 24px;
       background-color: transparent;
     }

     element-text {
       background-color: transparent;
       text-color: inherit;
       vertical-align: 0.5;
     }

     element selected element-text {
       text-color: @foreground;
     }

     element selected element-icon {
       background-color: transparent;
     }
  '';

  xdg.configFile."rofi/qtile-blue.rasi".text = ''
    * {
      background: #0f101a;
      background-alt: #323445;
      foreground: #e4e4e4;
      selected: #0F94D2;
      active: #f1ffff;
      urgent: #ffbca2;

      border-color: #057ba6;
      spacing: 0;
    }

    window {
      width: 40%;
      location: center;
      anchor: center;
      border: 1px;
      border-color: @border-color;
      border-radius: 10px;
      background-color: @background;
      padding: 16px;
    }

    mainbox {
      background-color: @background;
      children: [inputbar, message, listview];
      spacing: 10px;
    }

    inputbar {
      background-color: @background-alt;
      text-color: @foreground;
      border-radius: 8px;
      padding: 10px 12px;
      children: [prompt, entry];
      spacing: 8px;
    }

    prompt {
      text-color: @selected;
    }

    entry {
      placeholder: "Buscar";
      placeholder-color: #615f5f;
      text-color: @foreground;
      cursor: text;
    }

    message {
      background-color: @background;
      text-color: @urgent;
      padding: 4px;
    }

    listview {
      background-color: @background;
      columns: 1;
      lines: 8;
      cycle: true;
      dynamic: true;
      layout: vertical;
      fixed-height: true;
      spacing: 4px;
      scrollbar: false;
    }

    element {
      background-color: transparent;
      text-color: @foreground;
      border-radius: 8px;
      padding: 8px 10px;
      spacing: 10px;
    }

    element selected {
      background-color: @selected;
      text-color: @active;
    }

    element-icon {
      size: 22px;
      background-color: transparent;
    }

    element-text {
      background-color: transparent;
      text-color: inherit;
      vertical-align: 0.5;
    }
  '';
}
