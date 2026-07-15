# Guía de instalación: NixOS + Hyprland

Esta guía instala NixOS en un **NVMe dedicado**, con arranque **UEFI**, sin dual boot, sin hibernación y sin partición swap.

Configuración objetivo:

- Hostname: `coder`
- Usuario: `leinad`
- Teclado: `us` con variante internacional `intl`
- Escritorio: Hyprland
- Terminal: Ghostty
- Navegador: Firefox
- Login manager: greetd + tuigreet
- Audio: PipeWire
- Barra: Waybar
- Launcher: Rofi
- Notificaciones: Mako

> ⚠️ Los pasos de particionado borran el disco indicado. Antes de ejecutar comandos destructivos, confirma muy bien el nombre del disco.

---

## 1. Arrancar desde el USB de NixOS

Arranca la laptop desde el USB de instalación de NixOS en modo **UEFI**.

Confirma que estás en UEFI:

```bash
ls /sys/firmware/efi/efivars
```

Si el directorio existe y muestra contenido, arrancaste correctamente en modo UEFI.

---

## 2. Conectarse a internet

### Opción A: Ethernet

Normalmente no requiere pasos adicionales.

Verifica conexión:

```bash
ping -c 3 nixos.org
```

### Opción B: Wi-Fi con `iwctl`

```bash
iwctl
```

Dentro de `iwctl`:

```text
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect NOMBRE_DE_TU_RED
exit
```

Verifica conexión:

```bash
ping -c 3 nixos.org
```

> Si tu interfaz no se llama `wlan0`, usa el nombre que aparece en `device list`.

---

## 3. Identificar el disco

Lista los discos disponibles:

```bash
lsblk
```

Para este documento asumimos que el NVMe es:

```text
/dev/nvme0n1
```

La estructura final será:

```text
/dev/nvme0n1
├── p1  EFI   1 GB    /boot
└── p2  root  resto   /
```

No crearemos partición swap porque no se requiere hibernación. Si después necesitas swap, se puede agregar como swap file.

---

## 4. Particionar el disco

> ⚠️ Este paso borra el disco `/dev/nvme0n1`.

Abre `parted`:

```bash
parted /dev/nvme0n1
```

Dentro de `parted`:

```text
mklabel gpt
mkpart ESP fat32 1MiB 1025MiB
set 1 esp on
mkpart primary ext4 1025MiB 100%
quit
```

Verifica:

```bash
lsblk
```

Deberías ver algo parecido a:

```text
nvme0n1
├─nvme0n1p1
└─nvme0n1p2
```

---

## 5. Formatear particiones

Formatea la partición EFI:

```bash
mkfs.fat -F 32 -n BOOT /dev/nvme0n1p1
```

Formatea la partición root:

```bash
mkfs.ext4 -L nixos /dev/nvme0n1p2
```

---

## 6. Montar particiones

Monta root:

```bash
mount /dev/disk/by-label/nixos /mnt
```

Crea y monta `/boot`:

```bash
mkdir -p /mnt/boot
mount /dev/disk/by-label/BOOT /mnt/boot
```

Verifica:

```bash
lsblk
```

---

## 7. Generar `hardware-configuration.nix`

```bash
nixos-generate-config --root /mnt
```

Esto creará:

```text
/mnt/etc/nixos/hardware-configuration.nix
```

Ese archivo es específico de la laptop real y no viene incluido en este paquete.

---

## 8. Copiar la configuración del proyecto

Primero, entra al directorio de configuración generado:

```bash
cd /mnt/etc/nixos
```

Ahora copia los archivos de este proyecto a `/mnt/etc/nixos`.

Si tienes el ZIP en otro USB, monta ese USB y copia el contenido. Ejemplo general:

```bash
unzip /ruta/al/nixos-config.zip -d /tmp
cp /tmp/nixos-config/*.nix /mnt/etc/nixos/
cp /tmp/nixos-config/README.md /mnt/etc/nixos/
cp /tmp/nixos-config/INSTALL.md /mnt/etc/nixos/
```

Confirma que `hardware-configuration.nix` siga existiendo:

```bash
ls /mnt/etc/nixos/hardware-configuration.nix
```

La carpeta debería contener al menos:

```text
flake.nix
configuration.nix
hardware-configuration.nix
system-packages.nix
home.nix
packages.nix
hyprland.nix
keybindings.nix
waybar.nix
rofi.nix
ghostty.nix
theme.nix
autostart.nix
mako.nix
hyprpaper.nix
```

---

## 9. Revisar configuración antes de instalar

Desde `/mnt/etc/nixos`, revisa que el flake vea la configuración:

```bash
nix flake show /mnt/etc/nixos
```

La salida debería incluir una configuración llamada:

```text
nixosConfigurations.coder
```

---

## 10. Instalar NixOS

Ejecuta:

```bash
nixos-install --flake /mnt/etc/nixos#coder
```

Al final, el instalador pedirá asignar contraseña para `root`.

---

## 11. Asignar contraseña al usuario `leinad`

Después de instalar, antes de reiniciar, entra al sistema instalado:

```bash
nixos-enter --root /mnt
```

Asigna contraseña al usuario:

```bash
passwd leinad
```

Sal del entorno:

```bash
exit
```

---

## 12. Reiniciar

Desmonta y reinicia:

```bash
umount -R /mnt
reboot
```

Retira el USB cuando la laptop reinicie.

---

## 13. Primer inicio

Deberías ver `tuigreet`.

Inicia sesión con:

```text
Usuario: leinad
Sesión/comando: Hyprland
```

Si `tuigreet` recuerda el comando configurado, solo ingresa usuario y contraseña.

---

## 14. Primeros comandos útiles

Reconstruir después de editar configuración:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#coder
```

Actualizar entradas del flake:

```bash
cd /etc/nixos
sudo nix flake update
sudo nixos-rebuild switch --flake /etc/nixos#coder
```

Ver generaciones del sistema:

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

Limpiar generaciones antiguas:

```bash
sudo nix-collect-garbage -d
```

---

## 15. Wallpaper inicial

`hyprpaper.nix` espera un wallpaper en:

```text
/home/leinad/Pictures/wallpapers/nixos-hyprland.jpg
```

Crea la carpeta:

```bash
mkdir -p ~/Pictures/wallpapers
```

Copia ahí una imagen con ese nombre o ajusta la ruta en `hyprpaper.nix`.

---

## 16. Notas de troubleshooting

### No aparece Hyprland en el login

Verifica que en `configuration.nix` exista:

```nix
programs.hyprland.enable = true;
```

Luego reconstruye:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#coder
```

### No funciona internet después de instalar

Verifica NetworkManager:

```bash
systemctl status NetworkManager
```

Conéctate por terminal:

```bash
nmtui
```

### No aparece la barra

Ejecuta manualmente:

```bash
waybar
```

Si muestra errores, revisar `waybar.nix`.

### No abre Ghostty, Firefox o Rofi

Confirma que estén instalados:

```bash
which ghostty
which firefox
which rofi
```

Si falta alguno, revisa `packages.nix` y reconstruye.

### Teclado sin acentos

La configuración esperada es:

```nix
layout = "us";
variant = "intl";
```

y en Hyprland:

```nix
kb_layout = "us";
kb_variant = "intl";
```

Después reconstruye y reinicia sesión.

---

## 17. Pendiente futuro

Cuando la instalación base esté funcionando, conviene reorganizar el repo a una estructura más formal:

```text
nixos-config/
├── flake.nix
├── hosts/
│   └── coder/
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── system-packages.nix
└── home/
    └── leinad/
        ├── home.nix
        ├── packages.nix
        ├── hyprland.nix
        ├── keybindings.nix
        ├── waybar.nix
        ├── rofi.nix
        ├── ghostty.nix
        ├── theme.nix
        ├── autostart.nix
        ├── mako.nix
        └── hyprpaper.nix
```

Por ahora usamos estructura plana para facilitar la primera instalación.
