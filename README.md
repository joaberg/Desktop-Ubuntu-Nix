# Desktop-Ubuntu-Nix
My configs for Ubuntu LTS base, with Nix and home-manager on top, and Hyprland desktop.


Check install notes first, then look at the conf files for inspiration, dont copy everything blind, specially home.nix and flake.nix

## TODO
Some stuff that needs to be fixed.
- [ ] Screensharing, havent got this working. Looks like xdg-desktop-portal-hyprland is working. Suspect it could be an issue with pipewire or wireplumber. obs-studio does not find pipewire support.
- [ ] Swaylock, unclock will fail.


## Cheatsheet
List of keybindings and commands for tools I use.

### Hyprland
**SUPER + F2** - Clipboard history  
**SUPER + B** - exec, vivaldi browser  
**SUPER + T** - exec, termius-app  
**SUPER + O** - exec, obsidian notes  
**SUPER + Print** - screenshot  
**SUPER + F** - Fake Fullscreen  
**SUPER + SHIFT + F** - Fullscreen  
**SUPER + Enter/Return** - Kitty terminal  
**SUPER + Q** - Killactive window  
**SUPER + N** - Thunar filemanager  
**SUPER + D** - Quick launcher  
**SUPER + G** - Window, togglefloating  
**SUPER + P** - Window, pseudo mode  
**SUPER + J** - Window, togglesplit  
**SUPER + <arrow>** - Switch focus  
**SUPER + SHIFT + <arrow>** - Move to desktop/monitor  

### Yazi file manager
Using the ya function will let you navigate.  
So when you quite yazi, the shell will be in the directory yazi was in.
>ya

Full keybinds here:  
https://yazi-rs.github.io/docs/usage/quick-start  

**<Space>** -	Toggle selection of highlighted file/directory  
**o** -	Open the selected files  
**y** -	Copy the selected files  
**x** -	Cut the selected files  
**p** -	Paste the files  
**P** -	Paste the files (overwrite if the destination exists)  
**k** -	Paste the files (follow the symlinks)  
**K** -	Paste the files (overwrite + follow)  
**d** -	Move the files to the trash  
**D** -	Permanently delete the files  
**a** -	Create a file or directory (end with "/" for directories)  
**r** -	Rename a file or directory  
**;** -	Run a shell command  
**:** -	Run a shell command (block the UI until the command finishes)  
**.** -	Toggle the visibility of hidden files  
**s** -	Search files by name using fd  
**S** -	Search files by content using ripgrep  
**<Ctrl-s>** -	Cancel the ongoing search  
**z** -	Jump to a directory using zoxide  
**Z** -	Jump to a directory, or reveal a file using fzf  
**, ⇒ a** -	Sort alphabetically  
**, ⇒ A** -	Sort alphabetically (reverse)  
**, ⇒ m** -	Sort by modified time  
**, ⇒ M** -	Sort by modified time (reverse)  
**, ⇒ s** -	Sort by size  
**, ⇒ S** -	Sort by size (reverse)  


### Zellij 
**Ctrl+p w** - Open/close a floating pane.  
**Ctrl+p f** - Put active pane in fullscreen.  
**Ctrl+s e** - Add the terminal scrollback to an editor. Can also fuzzy search it first, and then save it to a file for later. Great for troubleshooting.  
**Alt + <arrow>** - Switch focused pane


### Zoxide
Use instead of cd.
>z dirname


## Gallery
![image](https://github.com/joaberg/Desktop-Ubuntu-Nix/assets/58996735/64d1e5c3-50d2-4ca3-b43f-11e2b15371a3)
![image](https://github.com/joaberg/Desktop-Ubuntu-Nix/assets/58996735/7e7669d3-7a7d-4cdf-9d0e-8cd66a1f2139)


