## Ubnuntu

Installed 22.04 regular Ubuntu with minimal install, and encrypted disk / LVM.
Need this setup for work, because of Microsoft Intune support.



## Determinate Nix Installer

Follow guide here:
https://zero-to-nix.com/start/install
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```


Install Home Manager:
https://github.com/nix-community/home-manager#installation
https://nixos.wiki/wiki/Home_Manager

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# This will generate a `flake.nix` and a `home.nix` file in `~/.config/home-manager`, creating the directory if it does not exist.
nix run home-manager/master -- init --switch 
```

seatd
```sh
sudo apt install seatd
sudo usermod -a -G video $USER
reboot
```


remove conflicting packages:
```sh
sudo apt remove xdg-desktop-portal-gnome
```

nixGL is needed to start Hyprland
```sh
nix profile install github:guibou/nixGL --impure
```

Start Hyprland:
```sh
nixGL Hyprland
```


Change Login Manager from GDM to SDDM, works better with Hyprland:
`sudo apt install sddm`

Create desktop file:
/usr/share/wayland-sessions/hyprland.desktop

```
[Desktop Entry]
Name=Hyprland
Comment=Hyprland Wayland session
Exec=nixGL Hyprland
Type=Application
```

Optional:
22.04 uses pulseaudio instead of pipewire. Change to pipewire by following this quick guide.
https://ubuntuhandbook.org/index.php/2022/04/pipewire-replace-pulseaudio-ubuntu-2204/amp/

