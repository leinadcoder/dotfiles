# kanshi display profiles, shared by the user session (home.nix) and the
# login screen (modules/greeter.nix) so both lay out the monitors the same way.
#
# kanshi applies the FIRST profile whose outputs match exactly what is
# connected, so specific monitors go before the generic "*" profiles.
# Profiles sharing the same outputs ("<name>-only" / "<name>-extended")
# are switched at runtime with Super+F1 / Super+F2 (see keybindings.nix).
# TODO: add lg-only / lg-extended (match by description, 3840x2160 @ 1.5)
# and list them in the display-profile script in keybindings.nix.
[
  {
    profile.name = "dual-2k";
    profile.outputs = [
      {
        criteria = "eDP-1";
        status = "disable";
      }
      {
        criteria = "Xiaomi Corporation Mi Monitor 6306110019873";  # currently DP-1
        status = "enable";
        mode = "2560x1440@60Hz";
        position = "2560,0";
        scale = 1.0;
      }
      {
        criteria = "Xiaomi Corporation Mi Monitor 6306110020303";  # currently HDMI-A-1
        status = "enable";
        mode = "2560x1440@60Hz";
        position = "0,0";
        scale = 1.0;
      }
    ];
  }

  # ---------- Single Xiaomi 2K (either unit) ----------
  {
    profile.name = "xiaomi-only";
    profile.outputs = [
      {
        criteria = "eDP-1";
        status = "disable";
      }
      {
        criteria = "Xiaomi Corporation Mi Monitor *";
        status = "enable";
        mode = "2560x1440@60Hz";
        position = "0,0";
        scale = 1.0;
      }
    ];
  }

  {
    profile.name = "xiaomi-extended";
    profile.outputs = [
      {
        criteria = "eDP-1";
        status = "enable";
        mode = "1920x1080@60Hz";
        position = "0,0";
        scale = 1.0;
      }
      {
        criteria = "Xiaomi Corporation Mi Monitor *";
        status = "enable";
        mode = "2560x1440@60Hz";
        position = "1920,0";
        scale = 1.0;
      }
    ];
  }

  # ---------- Any unknown external monitor (preferred mode) ----------
  {
    profile.name = "external-only";
    profile.outputs = [
      {
        criteria = "eDP-1";
        status = "disable";
      }
      {
        criteria = "*";
        status = "enable";
        position = "0,0";
      }
    ];
  }

  {
    profile.name = "external-extended";
    profile.outputs = [
      {
        criteria = "eDP-1";
        status = "enable";
        position = "0,0";
        scale = 1.0;
      }
      {
        criteria = "*";
        status = "enable";
        position = "1920,0";
      }
    ];
  }

  {
    profile.name = "laptop";
    profile.outputs = [
      {
        criteria = "eDP-1";
        status = "enable";
        mode = "1920x1080@60Hz";
        position = "0,0";
        scale = 1.0;
      }
    ];
  }

  {
    profile.name = "fallback";
    profile.outputs = [
      { criteria = "*"; status = "enable"; }
    ];
  }
]
