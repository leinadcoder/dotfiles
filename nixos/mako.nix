{ ... }:

{
  # Mako is the notification daemon for the Wayland session.
  # This config follows the same dark/blue visual direction as the Qtile theme.
  home.file.".config/mako/config".text = ''
font=JetBrainsMono Nerd Font 10

background-color=#0f101aee
text-color=#e4e4e4
border-color=#057ba6
progress-color=over #0F94D2

width=360
height=120
margin=12
padding=12
border-size=1
border-radius=6
icons=1
max-icon-size=48

anchor=top-right
layer=overlay

default-timeout=5000
ignore-timeout=0

[urgency=low]
border-color=#04385e
default-timeout=3000

[urgency=normal]
border-color=#057ba6
default-timeout=5000

[urgency=high]
border-color=#ffbca2
default-timeout=0
'';
}
