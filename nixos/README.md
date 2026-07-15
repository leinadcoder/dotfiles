# NixOS + Hyprland configuration

Configuración base generada para el host `coder` y el usuario `leinad`.

## Contenido

- `flake.nix`: entrada principal del sistema.
- `configuration.nix`: configuración base de NixOS.
- `system-packages.nix`: herramientas de sistema.
- `home.nix`: punto de entrada de Home Manager.
- `packages.nix`: aplicaciones de usuario.
- `hyprland.nix`: configuración principal de Hyprland.
- `keybindings.nix`: atajos migrados desde Qtile.
- `waybar.nix`: barra superior.
- `rofi.nix`: launcher.
- `ghostty.nix`: terminal.
- `theme.nix`: paleta centralizada.
- `autostart.nix`: procesos de inicio de sesión.
- `mako.nix`: notificaciones.
- `hyprpaper.nix`: wallpaper.

## Pendiente durante instalación

El archivo `hardware-configuration.nix` no está incluido porque debe generarse en la laptop real con:

```bash
nixos-generate-config --root /mnt
```

Después se debe copiar o mantener junto a `configuration.nix`, porque `configuration.nix` lo importa.
