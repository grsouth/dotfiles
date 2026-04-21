# dotfiles

Arch Linux dotfiles for a Hyprland setup with Waybar, Rofi, Alacritty, Starship, and Zsh.

## Dependencies


```sh
sudo pacman -S \
  hyprland hyprpaper hyprpolkitagent waybar rofi alacritty zsh starship \
  fzf zsh-autosuggestions zsh-syntax-highlighting eza bat grim slurp \
  wl-clipboard pipewire wireplumber playerctl polkit xdg-utils \
  thunar vivaldi micro pavucontrol papirus-icon-theme \
  ttf-jetbrains-mono-nerd ttf-firacode-nerd
```

This config also expects `hyprwhspr` to be installed separately. Waybar and Hyprland reference files under `/usr/lib/hyprwhspr/...`.

