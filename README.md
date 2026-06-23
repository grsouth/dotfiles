# dotfiles

Arch Linux dotfiles for a Hyprland setup with Waybar, Rofi, Alacritty, Starship, and Zsh.

## Dependencies

These are the packages/tools referenced by the tracked configs and scripts.

- Dotfile management:
  - `stow`

- Hyprland session:
  - `hyprland`
  - `hyprpaper`
  - `hyprpolkitagent`
  - `polkit`
  - `udiskie`
  - `xdg-utils`
  - `xdg-desktop-portal`
  - `xdg-desktop-portal-hyprland`
  - `xdg-desktop-portal-gtk`

- Bar, launcher, and notifications:
  - `waybar`
  - `rofi`
  - `swaync`
  - `libnotify`
  - `pavucontrol`
  - `papirus-icon-theme`

- Desktop applications:
  - `alacritty`
  - `thunar`
  - `vivaldi`
  - `micro`

- Shell and prompt:
  - `zsh`
  - `starship`
  - `fzf`
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
  - `eza`
  - `bat`

- Audio and media controls:
  - `pipewire`
  - `pipewire-pulse`
  - `wireplumber`
  - `playerctl`

- Screenshot, clipboard, and script utilities:
  - `grim`
  - `slurp`
  - `wl-clipboard`
  - `jq`
  - `which`

- Fonts:
  - `ttf-jetbrains-mono-nerd`
  - `ttf-firacode-nerd`

- Optional or separately installed tools referenced by configs:
  - `hyprwhspr` is expected separately; Waybar and Hyprland reference files under `/usr/lib/hyprwhspr/...`.
  - `hyprtoolkit` has a tracked config in `hypr/.config/hypr/hyprtoolkit.conf`.
  - `hypridle` has a tracked config, but it is not currently autostarted by `hyprland.conf`.
  - `hyprshutdown` is used only if present; the shutdown keybind falls back to `hyprctl dispatch exit`.

SwayNC replaces other notification daemons. If `dunst` is installed and running, disable or mask `dunst.service` so SwayNC can own `org.freedesktop.Notifications`.

