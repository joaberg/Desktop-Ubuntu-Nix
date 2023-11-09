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

## Additional changes

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

## Optional
### Pipewire / Wireplumber
22.04 uses pulseaudio instead of pipewire. Change to pipewire by following this quick guide.
https://ubuntuhandbook.org/index.php/2022/04/pipewire-replace-pulseaudio-ubuntu-2204/amp/  
https://gist.github.com/the-spyke/2de98b22ff4f978ebf0650c90e82027e  

### Battery tuning
```
sudo apt install powertop
sudo powertop --auto-tune
```


## Notes
### Cursor
Had an issue of a missing cursor in foot terminal.  
Solved it by changing cursor theme with this script:  
https://github.com/Lassebq/gtk-theme

 ### Bluetooth headset
 Had a problem with my bluetooth headset not switching on the microphone when i went into Teams meetings.  
 This will make Bluez automatic profile switching trigger on defined application inputs  
 
 ~/.config/wireplumber/policy.lua.d/10-default-policy.lua  
 or /usr/share/wireplumber/policy.lua.d/10-default-policy.lua  

```lua
bluetooth_policy.policy = {
  -- Whether to store state on the filesystem.
  ["use-persistent-storage"] = true,

  -- Whether to use headset profile in the presence of an input stream.
  ["media-role.use-headset-profile"] = true,

  -- Application names correspond to application.name in stream properties.
  -- Applications which do not set media.role but which should be considered
  -- for role based profile switching can be specified here.
  ["media-role.applications"] = { "Chromium input", "Firefox", "Google Chrome input", "ZOOM VoiceEngine" },
}
```

changed this line to include Edge, which i use for Teams:  
(You can see the input names in pavucontrol/Recording)  
```lua 
["media-role.applications"] = { "Chromium input", "Firefox", "Google Chrome input", "ZOOM VoiceEngine", "Microsoft Edge input" },
```
