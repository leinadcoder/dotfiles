{ ... }:

let
  theme = import ./theme.nix;
  c = theme.colors;
in
{
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      show-icons: true;
      icon-theme: "${theme.icons.theme}";
      font: "${theme.fonts.interface} 11";
      terminal: "ghostty";
      drun-display-format: "{name}";
      display-drun: "";
      display-run: "";
      display-window: "";
      sidebar-mode: false;
    }

    @theme "deep-blue"
  '';

  xdg.configFile."rofi/deep-blue.rasi".text = ''
    * {
      background: ${c.surfaceAlpha};
      background-alt: ${c.surfaceElevated};
      foreground: ${c.foreground};
      foreground-muted: ${c.foregroundMuted};
      selected: ${c.accentSoft};
      accent: ${c.accentActive};
      urgent: ${c.urgent};
      border-color: ${c.border};
      spacing: 0;
    }

    window {
      width: 40%;
      location: center;
      anchor: center;
      border: 1px;
      border-color: @border-color;
      border-radius: 12px;
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
      border: 1px;
      border-color: @border-color;
      border-radius: 9px;
      padding: 13px 15px;
      children: [prompt, entry];
      spacing: 10px;
    }

    prompt {
      enabled: true;
      background-color: transparent;
      text-color: @accent;
      padding: 0 4px 0 0;
    }

    entry {
      background-color: transparent;
      placeholder: "Start typing…";
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
  '';
}
