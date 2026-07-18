{ pkgs, ... }:

let
  # Evita abrir una segunda instancia de Hyprlock.
  lockCommand = ''
    ${pkgs.procps}/bin/pgrep -x hyprlock > /dev/null \
      || ${pkgs.hyprlock}/bin/hyprlock
  '';

  loginctl = "${pkgs.systemd}/bin/loginctl";
in
{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        # Responde a solicitudes D-Bus como:
        # loginctl lock-session
        lock_cmd = lockCommand;

        # Garantiza que la sesión esté bloqueada antes de suspender.
        before_sleep_cmd = "${loginctl} lock-session";

        # Evita tener que presionar una tecla adicional después de despertar.
        after_sleep_cmd = "hyprctl dispatch dpms on";

        # Respetar inhibidores de vídeo, presentaciones y aplicaciones.
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        ignore_wayland_inhibit = false;

        # Esperar hasta que el locker confirme que la sesión está protegida.
        inhibit_sleep = 3;
      };

      listener = [
        # Bloquear después de 10 minutos.
        {
          timeout = 600;
          on-timeout = "${loginctl} lock-session";
        }

        # Apagar pantallas 2 minutos después del bloqueo.
        {
          timeout = 720;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
