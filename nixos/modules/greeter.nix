{ config, lib, pkgs, username, ... }:

# Login screen: greetd -> Hyprland (greeter-only config) -> regreet.
# kanshi runs inside the greeter with the same profiles as the user session,
# so the laptop screen is already off at login when an external is connected,
# and regreet is a single window, so the prompt appears on one monitor only.

let
  theme = import ../theme.nix;
  c = theme.colors;
  hyprland = config.programs.hyprland.package;
  xkb = config.services.xserver.xkb;

  renderOutput = o:
    lib.concatStringsSep " " (
      [ "output" (builtins.toJSON o.criteria) ]
      ++ lib.optional (o ? status) o.status
      ++ lib.optionals (o ? mode) [ "mode" o.mode ]
      ++ lib.optionals (o ? position) [ "position" o.position ]
      ++ lib.optionals (o ? scale) [ "scale" (toString o.scale) ]
    );

  renderProfile = p: ''
    profile ${p.profile.name} {
    ${lib.concatMapStrings (o: "  ${renderOutput o}\n") p.profile.outputs}}
  '';

  background = ../local-themes/pixie-deep-blue/assets/sddm-deep-blue.jpg;

  # regreet has no avatar widget; the CSS paints this pre-cropped circle
  # as a background image above the greeting label.
  avatar = pkgs.runCommand "greeter-avatar.png" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
    magick ${../local-themes/pixie-deep-blue/assets/avatar-deep-blue.png} \
      -resize 256x256^ -gravity center -extent 256x256 \
      \( -size 256x256 xc:black -fill white -draw "circle 128,128 128,0" \) \
      -alpha off -compose CopyOpacity -composite png:$out
  '';

  regreetStateSeed = pkgs.writeText "regreet-state.toml" ''
    last_user = "${username}"

    [user_to_last_sess]
    ${username} = "Hyprland"
  '';
in
{
  services.greetd = {
    enable = true;
    settings.default_session.command =
      "${pkgs.dbus}/bin/dbus-run-session ${hyprland}/bin/Hyprland --config /etc/greetd/hyprland.conf";
  };

  # Preselect Hyprland on first boot; C only copies when the file is missing,
  # so regreet keeps updating it afterwards.
  systemd.tmpfiles.settings."11-regreet-state"."/var/lib/regreet/state.toml" = {
    C.argument = "${regreetStateSeed}";
    z = {
      mode = "0644";
      user = config.services.greetd.settings.default_session.user;
      group = "greeter";
    };
  };

  environment.etc."greetd/kanshi.conf".text =
    lib.concatMapStringsSep "\n" renderProfile (import ../display-profiles.nix);

  environment.etc."greetd/hyprland.conf".text = ''
    monitor = , preferred, auto, 1

    env = XCURSOR_THEME,Adwaita
    env = XCURSOR_SIZE,20

    exec-once = ${pkgs.kanshi}/bin/kanshi --config /etc/greetd/kanshi.conf
    exec-once = ${pkgs.swaybg}/bin/swaybg --image ${background} --mode fill
    exec-once = ${lib.getExe config.programs.regreet.package}; ${hyprland}/bin/hyprctl dispatch exit

    input {
      kb_layout = ${xkb.layout}
      kb_variant = ${xkb.variant}
    }

    general {
      gaps_in = 0
      gaps_out = 0
      border_size = 0
    }

    decoration {
      rounding = 0
      blur {
        enabled = false
      }
      shadow {
        enabled = false
      }
    }

    animations {
      enabled = false
    }

    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      force_default_wallpaper = 0
      background_color = rgb(${lib.removePrefix "#" c.background})
    }

    ecosystem {
      no_update_news = true
      no_donation_nag = true
    }
  '';

  programs.regreet = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = theme.icons.theme;
    };

    font = {
      package = pkgs.noto-fonts;
      name = theme.fonts.interface;
      size = 14;
    };

    settings = {
      background = {
        path = "${background}";
        fit = "Cover";
      };
      GTK.application_prefer_dark_theme = true;
      commands = {
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };
    };

    extraCss = ''
      window {
        background-color: ${c.background};
      }

      label {
        color: ${c.foreground};
      }

      frame.background > grid > label:first-child {
        padding-top: 144px;
        background-image: url("file://${avatar}");
        background-size: 128px 128px;
        background-position: center top;
        background-repeat: no-repeat;
      }

      frame {
        background-color: ${c.surfaceRgba};
        border: 1px solid ${c.border};
        border-radius: 16px;
      }

      entry {
        min-height: 40px;
        padding: 0 12px;
        background-color: ${c.surfaceElevated};
        color: ${c.foreground};
        border: 1px solid ${c.border};
        border-radius: 12px;
        box-shadow: none;
        outline: none;
      }

      entry:focus-within {
        border-color: ${c.accentActive};
        box-shadow: inset 0 0 0 1px ${c.accentActive};
      }

      button {
        min-height: 36px;
        padding: 0 14px;
        background-image: none;
        background-color: ${c.surfaceElevated};
        color: ${c.foreground};
        border: 1px solid ${c.border};
        border-radius: 10px;
        box-shadow: none;
      }

      button:hover {
        background-color: ${c.surfaceHover};
      }

      button.suggested-action {
        background-color: ${c.accent};
        border-color: ${c.accentActive};
      }

      button.suggested-action:hover {
        background-color: ${c.accentActive};
      }

      button.destructive-action {
        color: ${c.urgent};
      }

      popover > contents,
      popover > arrow {
        background-color: ${c.surface};
        border: 1px solid ${c.border};
      }

      popover row:hover,
      popover row:selected {
        background-color: ${c.accentSoft};
      }
    '';
  };
}
