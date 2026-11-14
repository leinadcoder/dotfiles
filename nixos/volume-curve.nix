{ pkgs }:

# `winvol`: volume control with a Windows-like curve.
#
# PipeWire/PulseAudio percentages are cubic (vol^3), which is far quieter at
# the low end than Windows' slider. This maps a "Windows percent" W to the
# system volume L as  L = (W/100)^exponent, so stepping W by 2% feels like
# Windows and waybar shows the Windows-scale number. pavucontrol and other
# apps keep showing the raw system percentage.
#
# Fitted from phone recordings (Windows 18% ~= Linux 35%). Raise the exponent
# toward 1.0 to make low percentages quieter, lower it to make them louder.
#
# Usage: winvol up [step] | down [step] | get | status | watch
let
  exponent = "0.62";
in
pkgs.writeShellApplication {
  name = "winvol";
  runtimeInputs = [ pkgs.pulseaudio pkgs.gawk pkgs.jq pkgs.coreutils ];
  text = ''
    A=${exponent}

    # Raw sink volume of the first channel (65536 = 100%).
    raw() { pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR == 1 { print $3; exit }'; }

    to_win() {
      awk -v r="$1" -v a="$A" 'BEGIN {
        l = r / 65536
        if (l <= 0) { print 0; exit }
        printf "%d", 100 * exp(log(l) / a) + 0.5
      }'
    }

    to_raw() {
      awk -v w="$1" -v a="$A" 'BEGIN {
        if (w <= 0) { print 0; exit }
        printf "%d", 65536 * exp(a * log(w / 100)) + 0.5
      }'
    }

    get() { to_win "$(raw)"; }

    step() {
      local dir=$1 s=''${2:-2} w new
      w=$(get)
      new=$(( (w + s / 2) / s * s + dir * s ))
      (( new < 0 )) && new=0
      (( new > 100 )) && new=100
      pactl set-sink-volume @DEFAULT_SINK@ "$(to_raw "$new")"
    }

    status() {
      local r w sys muted sink info icon tip text class=""
      r=$(raw)
      w=$(to_win "$r")
      sys=$(( (r * 100 + 32768) / 65536 ))
      muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{ print $2 }')
      sink=$(pactl get-default-sink)
      info=$(pactl --format=json list sinks | jq -r --arg n "$sink" \
        '.[] | select(.name == $n) | "\(.active_port // "")|\(.properties["device.form_factor"] // "")"')

      case "$info" in
        *headphone*|*headset*|*hands-free*) icon="" ;;
        *)
          if   (( w < 34 )); then icon=""
          elif (( w < 67 )); then icon=""
          else icon=""; fi ;;
      esac

      if [ "$muted" = "yes" ]; then
        text="󰖁"; class="muted"
      else
        text="$icon  $w%"
      fi

      tip=$(printf 'Volume: %s%% (Windows scale)\nSystem: %s%%\nClick for quick controls' "$w" "$sys")
      jq -cn --arg text "$text" --arg class "$class" --argjson p "$w" --arg tip "$tip" \
        '{text: $text, class: $class, percentage: $p, tooltip: $tip}'
    }

    # Print status now and on every sink/default-device change (for waybar).
    watch() {
      while true; do
        status
        pactl subscribe 2>/dev/null | while read -r line; do
          case "$line" in
            *" on sink #"*|*" on server"*) status ;;
          esac
        done
        sleep 1
      done
    }

    case "''${1:-}" in
      up)     step 1 "''${2:-2}" ;;
      down)   step -1 "''${2:-2}" ;;
      get)    get ;;
      status) status ;;
      watch)  watch ;;
      *) echo "usage: winvol up [step] | down [step] | get | status | watch" >&2; exit 2 ;;
    esac
  '';
}
