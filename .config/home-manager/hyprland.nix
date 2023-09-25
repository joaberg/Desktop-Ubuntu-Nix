{ config, pkgs, inputs, ... }:
# https://rycee.gitlab.io/home-manager/options.html


with pkgs.lib; {
    
    home.packages = with pkgs; [

        # Waybar stuff:
        font-awesome # Needed for waybar icons
        networkmanagerapplet
        brightnessctl # Commandline brightness controll
        wttrbar # For weather info
        blueberry # Bluetooth config tool
        playerctl # For music controll
        swappy # Screenshot edit tool 
        sway-contrib.grimshot # Screenshot tool


        # Hyprland stuff
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
        xdg-desktop-portal
        hyprkeys
        hyprland-protocols

        nwg-launchers
        nwg-bar
        wofi
        nwg-drawer
        swaybg
        wlsunset
        swaylock-effects
        swayidle
        hyprpaper
        wl-clipboard
        clipman # wayland clipboard manager
        hyprpicker
        swaynotificationcenter      
        wayshot # screenshot tool (not in use)
          
        qt6.qtwayland
        adwaita-qt6
        polkit
        hicolor-icon-theme
        gtk-layer-shell
        slurp
    ];

# Fix for some XDG path issues:
  xdg.enable=true;
  xdg.mime.enable=true;
  targets.genericLinux.enable=true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications"  "${config.home.homeDirectory}/.nix-profile/share/" ];



 
 services = {
 	mako = {
 		enable = true;
		defaultTimeout = 10000;
 	};
 };

################################################
#Below are configs for:
# Hyprland
# Waybar
# Swaylock
################################################


################################################
############# Hyprland config
################################################
  wayland.windowManager.hyprland = {
      #extraConfig = builtins.readFile ./configs/hyprland/hyprland.conf;
      enable = true;
      xwayland.enable = true;
      systemdIntegration = true;
      

      extraConfig = ''

            ###########################################################
            #
            #     Monitors
            #
            ##########################################################
            # See https://wiki.hyprland.org/Configuring/Monitors/


            #Main config
            # laptop monitor:
            monitor=eDP-1,1920x1080@60,860x1440,1
            # Every other undefined monitor. This is configured to be above the laptop.
            monitor=,3440x1440@100,0x0,1



            ###########################################################
            #
            #     KeyBinds
            #
            ##########################################################

            # See https://wiki.hyprland.org/Configuring/Keywords/ for more
            $mainMod = SUPER 
            #Keybind info menu:
            bind = $mainMod, F1, exec, ~/.config/hypr/keybind
            bind = $mainMod, F2, exec, clipman pick -t wofi #F1Menu
            #################################
            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            bind = $mainMod, B, exec, vivaldi #F1Menu
            bind = $mainMod, T, exec, termius-app #F1Menu
            bind = $mainMod, O, exec, obsidian #F1Menu
            bind = $mainMod, L, exec, swaylock --clock --indicator --screenshots --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %e.%m.%Y" --timestr "%k:%M" #F1Menu
            bind = $mainMod, Print , exec , grim #F1Menu 
            bind = $mainMod, G, togglefloating  #F1Menu
            bind = $mainMod, F, fullscreen, 1  #F1Menu
            bind = $mainMod SHIFT, F, fullscreen  #F1Menu
            bind = $mainMod, 36, exec, alacritty
            bind = $mainMod, Q, killactive, 
            bind = $mainMod SHIFT, E, exec, nwgbar #F1Menu 
            bind = $mainMod, N, exec, thunar #F1Menu
            bind = $mainMod SHIFT, 65, togglefloating, #F1Menu
            bind = $mainMod, D, exec, wofi -i -G --show drun --allow-images #F1Menu
            bind = $mainMod SHIFT, D, exec, nwg-drawer #F1Menu
            bind = $mainMod, P, pseudo, # dwindle #F1Menu
            bind = $mainMod, J, togglesplit, # dwindle #F1Menu
            ##################################

            # Move focus with mainMod + arrow keys
            bind = $mainMod, left, workspace, r-1
            bind = $mainMod, right, workspace, r+1
            bind = $mainMod SHIFT, left, movetoworkspace, r-1
            bind = $mainMod SHIFT, right, movetoworkspace, r+1
            bind = $mainMod,up, focusmonitor, u
            bind = $mainMod,down, focusmonitor, d
            bind = $mainMod SHIFT,up, movecurrentworkspacetomonitor, u
            bind = $mainMod SHIFT,down, movecurrentworkspacetomonitor, d

            # Switch workspaces with mainMod + [0-9]
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10

            # Scroll through existing workspaces with mainMod + scroll
            bind = $mainMod, mouse_down, workspace, e+1
            bind = $mainMod, mouse_up, workspace, e-1

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow

            bind = ,232,exec,brightnessctl -c backlight set 5%-
            bind = ,233,exec,brightnessctl -c backlight set +5%

            # set volume (laptops only and may or may not work on PCs)
            bind = ,122, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
            bind = ,123, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
            bind = ,121, exec, pactl set-sink-volume @DEFAULT_SINK@ 0%

        #	$screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"
        #	bind = $mainMod, S, exec, $screenshotarea #F1Menu
        #	bind = , Print, exec, grimblast --notify --cursor copysave output
        #	bind = ALT, Print, exec, grimblast --notify --cursor copysave screen

            #######################
            # for resizing window
            # will switch to a submap called resize
            bind=$mainMod,R,submap,resize #F1Menu
            # will start a submap called "resize"
            submap=resize
            # sets repeatable binds for resizing the active window
            binde=,right,resizeactive,10 0
            binde=,left,resizeactive,-10 0
            binde=,up,resizeactive,0 -10
            binde=,down,resizeactive,0 10
            # use reset to go back to the global submap
            bind=,escape,submap,reset 
            # will reset the submap, meaning end the current one and return to the global one
            submap=reset
            #######################

            # to move window
            #bind = $mainMod SHIFT,up, movewindow, u
            #bind = $mainMod SHIFT,down, movewindow, d
            #bind = $mainMod SHIFT,left, movewindow, l
            #bind = $mainMod SHIFT,right, movewindow, r


            ###########################################################
            #
            #     Settings
            #
            ##########################################################



            # Source a file (multi-file configs)
        #	source = ~/.config/hypr/mocha.conf

            # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
            input {
                kb_layout = no
                kb_variant =
                kb_model =
                kb_options =
                kb_rules =

                numlock_by_default = true

                follow_mouse = 1

                touchpad {
                    natural_scroll = yes
                    clickfinger_behavior  = true 
                }

                sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            }

            general {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                gaps_in = 5
                gaps_out = 10
                border_size = 2
                col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
                col.inactive_border = rgba(595959aa)

                layout = dwindle
            }

            decoration {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more

                active_opacity = 0.8
                inactive_opacity = 0.7


                rounding = 10
                blur {
                    enabled = yes
                    size = 5
                    passes = 3
                    new_optimizations = on
                }
                drop_shadow = yes
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            }

            animations {
                enabled = yes

                # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            dwindle {
                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = yes # you probably want this
            }

            master {
                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                new_is_master = true
            }

            gestures {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
                workspace_swipe = on
            }
            misc {
                disable_hyprland_logo = true
            }
            # Example per-device config
            # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
            device:epic mouse V1 {
                sensitivity = -0.5
            }







            ###########################################################
            #
            #     Window Rules
            #
            ##########################################################
            # Example windowrule v1
            # windowrule = float, ^(kitty)$
            # Example windowrule v2
            # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
            # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


            windowrule = opacity 0.85 override 0.85 override,^(thunar)$ 
            windowrulev2 = float,class:^(thunar)$

            windowrule = opacity 0.85 override 0.85 override,^(catfish)$ 
            
            windowrulev2 = opacity 1.0 override 1.0 override,class:^(vivaldi-stable)$
            windowrulev2 = opacity 1.0 1.0, floating:1,class:^(vivaldi-stable)$


            windowrulev2 = opacity 1.0 override 1.0 override,class:^(Microsoft-edge)$
            windowrulev2 = tile,class:^(Microsoft-edge)$
            windowrulev2 = opacity 1.0 override 1.0 override,class:^(TradingView)$

        #	windowrulev2 = nomaxsize,class:^(terminal.exe)$

        #	windowrulev2 = monitor eDP-1,class:^(terminal.exe)$


            windowrulev2 = opacity 1.0 override 1.0 override,title:^(.*Picture in picture.*)$

            #windowrulev2 = opacity 1 override 1 override, tile ,title:^(.*Spotify.*)$
            windowrule = tile,title:^(spotify)$


            #window rules with evaluation
            #windowrulev2 = opacity 0.85 0.85,floating:1
            windowrulev2 = opacity 1 1,floating:1


            # other blurings
            blurls = wofi
            blurls = gtk-layer-shell # for nwg-drawer
            #blurls = waybar


            ###########################################################
            #
            #     Startup
            #
            ##########################################################



            # Execute your favorite apps at launch
            # exec-once = waybar & hyprpaper & vivaldi

            #status bar
            exec-once = waybar

            #Background
            #exec-once = wpaperd
            #exec-once = swaybg -m fill -i /usr/share/wallpapers/garuda-wallpapers/Malefor.jpg
            #exec-once = swaybg -m fill -i /home/joakim/Sync/dragons_flyin.png
            #exec-once = swaybg -m fill -i /home/joakim/.config/home-manager/configs/hyprland/keWFARyN-wallha.com.png
            exec-once = swaybg -m fill -i /home/joakim/.nix-profile/share/hyprland/wall_anime_8K.png
            
            #idle. Lock after 10 min. Turn off monitor after 30 min
        #	exec-once = swayidle -w timeout 600 'swaylock --clock --indicator --screenshots --effect-scale 0.4 --effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %e.%m.%Y" --timestr "%k:%M"' timeout 1800 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'


            #executions which i am not certainly sure that will work for every one yeah they are also not that much important but if work then setup will become great!!
            #exec-once = mako
            exec-once = xrandr --output eDP-1 --primary # Workaround for issues with wine windows.
            #exec-once = /usr/lib/polkit-kde-authentication-agent-1
            
            # This will make sure that xdg-desktop-portal-hyprland can get the required variables on startup.
            #exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
            #exec-once = /usr/lib/xdg-desktop-portal-hyprland

            exec-once = nm-applet --indicator # Network manager applet in waybar
            exec-once = wl-paste -t text --watch clipman store --no-persist  # Copy history, accessible via "SUPER + F2"





      '';
  }; 

 
################################################
############# Waybar config
################################################
 programs = {
	 waybar = {
         enable = true;
         style = ''
            * {
                color: #00B6EC;
                border: 0;
                border-radius: 0;
                padding: 0 0;
                font-family:"MesloLGS NF", "DejaVu Sans", "Iosevka", "Font Awesome 5 Free";
                font-size: 17px;
                margin-right: 2px;
                margin-left: 2px;
                padding-bottom:1px;
                
            }

            window#waybar {
                background: rgba(0, 0, 0, 0.36);
                background-color: transparent;
                /*border-radius: 10px 10px 10px 10px;*/
                
            }

            .modules-left {
                background: rgba(0,0,0,0.36);
                border-radius: 0px 0px 10px 0px;
            }
            .modules-center {
                background: rgba(0,0,0,0.36);

                padding: 0px 10px;
                border-radius: 0px 0px 10px 10px;
            }
            .modules-right > * > * {
                background: rgba(0,0,0,0.36);
                border-radius: 0px 0px 0px 0px;
                padding: 0px 2px;
                margin: 0px;
            }

            #clock {
                background-color: transparent;
            }

            #tray {
                background: rgba(0, 0, 0, 0.36);
                border-radius: 0px 0px 0px 10px;
                margin: 0px;
            }

            #custom-power {
                background: rgba(0, 0, 0, 0.36);
                border-radius: 0px 0px 10px 0px;
                margin: 0px;
            }


            @keyframes rgb_background {
                0% {
                    background-color: #ff0000;
                }
                17% {
                    background-color: #ffff00;
                }
                33% {
                    background-color: #00ff00;
                }
                50% {
                    background-color: #00ffff;
                }
                67% {
                    background-color: #0000ff;
                }
                83% {
                    background-color: #ff00ff;
                }
                100% {
                    background-color: #ff0000;
                }
            }
            @keyframes rgb_border_bottom {
                0% {
                    box-shadow: inset 0px -3px #ff0000;
                }
                17% {
                    box-shadow: inset 0px -3px #ffff00;
                }
                33% {
                    box-shadow: inset 0px -3px #00ff00;
                }
                50% {
                    box-shadow: inset 0px -3px #00ffff;
                }
                67% {
                    box-shadow: inset 0px -3px #0000ff;
                }
                83% {
                    box-shadow: inset 0px -3px #ff00ff;
                }
                100% {
                    box-shadow: inset 0px -3px #ff0000;
                }
            }
            @keyframes rgb_border_right {
                0% {
                    box-shadow: inset -3px -3px #ff0000;
                }
                17% {
                    box-shadow: inset -3px -3px #ffff00;
                }
                33% {
                    box-shadow: inset -3px -3px #00ff00;
                }
                50% {
                    box-shadow: inset -3px -3px #00ffff;
                }
                67% {
                    box-shadow: inset -3px -3px #0000ff;
                }
                83% {
                    box-shadow: inset -3px -3px #ff00ff;
                }
                100% {
                    box-shadow: inset -3px -3px #ff0000;
                }
            }

            #workspaces button,
            #taskbar button {
                transition-duration: 0ms;
                border-radius: 0px;
                margin: 0px;
                border: none;
                padding: 2px 10px;
            }
            #taskbar button:last-child {
                border-radius: 0px 0px 10px 0px;
            }
            #workspaces button.active,
            #taskbar button.active {
                animation-name: rgb_border_bottom;
                animation-duration: 5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                box-shadow: inset 0px -3px #7857ff;
            }
            #taskbar button.active:last-child {
                animation-name: rgb_border_right;
                animation-duration: 5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                box-shadow: inset -3px -3px #7857ff;
            }
            #workspaces button.active:hover,
            #taskbar button.active:hover {
                animation-name: rgb_background;
                animation-duration: 5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000,
                    1px 1px 0 #000;
                box-shadow: inset 0px -3px #af99ff;
            }
            #taskbar button.active:last-child:hover {
                box-shadow: inset -3px -3px #af99ff;
            }

         '';


##################### Settings ######################
# https://github.com/Alexays/Waybar/wiki/Module:-Hyprland
		 settings = [{
		    "layer" = "top";
		 	"position" = "top";
		 	"mod" = "dock";
		 	"gtk-layer-shell" = true;
		 	"modules-left" = [
		 	    	"custom/launcher"
		 	        "custom/weather"
		 	        "hyprland/workspaces"
		 	        /*"wlr/taskbar"*/
		 	        "custom/spotify"
                
		 	];
		 	"modules-center" = ["clock"];
		 	"modules-right" = [
		 	        "tray"
		 	        "custom/grimshot"
		 	        "idle_inhibitor"
		 	        "custom/updates"
		 	        "cpu"
		 	        "memory"
		 	        "battery"
		 	        "backlight"
		 	        "pulseaudio"
		 	        "pulseaudio#microphone"
		 	        "network"
					"bluetooth"
		 	        "custom/power"
		 	];
		 	
		 	"hyprland/window" = {
		 	        "format"= " {} ";
		 	};
		 	
		 	"custom/spotify" = {
		 		    "exec" = "/usr/bin/python3 ~/.config/home-manager/configs/waybar/scripts/mediaplayer.py --player spotify";
		 		    "format"= " {}   ";
		 		    "return-type" = "json";
		 		    "on-click" = "playerctl play-pause";
		 		    "on-scroll-up" = "playerctl next";
		 		    "on-scroll-down" = "playerctl previous";
		 	};
		 	
		 	
		 	"custom/grimshot" = {
		 			"format" = "  ";
		 	        "tooltip"= false;
		 	        "on-click"= "grimshot --notify save output - | swappy -f -";
		 	        "on-click-middle"= "grimshot --notify save window - | swappy -f -";
		 	        "on-click-right"= "grimshot --notify save area - | swappy -f -";
		 	};
		 	
		 	
		 	"hyprland/workspaces" = {
		 	        "all-outputs"= true;
		 	        "on-click"= "activate";
		 	        "persistent_workspaces"= {
		 	            "1"= ["DP-5"];
		 	            "2"= ["DP-5"];
		 	            "3"= ["eDP-1"];
		 	            "4"= ["eDP-1"];
		 	            "5"= [];
		 	            "6"= [];
		 	            "7"= [];
		 	            "8"= [];
		 	            "9"= [];
		 	            "10"= [];
		 	        };
		 	};
		 	
		 	"custom/updates" = {
                    # add "%sudo ALL=NOPASSWD:/usr/bin/apt-get" to the sudoers file.
                    "exec"="(sudo apt-get update > /dev/null && sudo apt-get --just-print upgrade | grep -c ^Inst) || echo 0";
		 	    	"exec-if"= "exit 0";
		 	    	"on-click"= "alacritty -e zsh -c 'sudo apt upgrade && echo -e \"\n\n\033[31mRemember to also run home-manager-update\nPress Enter to close\033[0m\" && read'";
		 	        "interval"= 14400; # every 4h
		 	        "format"= "  {} ";
		 	};
		 	
		 	"network" = {
		 	        "format"= " ⚠ Disabled ";
		 	        "format-wifi" = "  {essid}";
		 	        "format-ethernet" = "  {ifname}: {ipaddr}/{cidr} ";
		 	        "format-disconnected"= " ⚠ Disconnected ";
		 	        "on-click"= "nm-connection-editor";
		 	};
		 	
		 	"cpu" = {
		 		"format" = "  {usage: >3}% ";
		 	    "on-click"= "alacritty -e htop";
		 	};
		 	
		 	"memory" = {
		 		"format" = "  {: >3}% ";
		 	    "on-click"= "alacritty -e htop";
		 	};
		 	  
		 	"custom/weather" = {
		 	        "tooltip" = true;
		 	        "format" = " {} ° ";
		 	        "interval" = 30;
					"exec" = "wttrbar --location 'Larvik, Norway'";
		 	        "return-type" = "json";
		 	};
		 	
		 	"custom/power" = {
		 			"format" = "  ";
		 	       	"on-click"= "nwg-bar";
		 	      	"tooltip"= false;
		 	};
		 	
		 	"idle_inhibitor" = {
		 	        "format"= " {icon} ";
		 	        "format-icons"= {
		 	            "activated"= "";
		 	            "deactivated"= "";
		 	        };
		 	};
		 	
		 	"custom/launcher" = {
		 	        "format" = "    ";
		 	    	"on-click" = "exec nwg-drawer -c 7 -is 70 -spacing 23";
		 	    	"tooltip" = false;
		 	};
		 	
		 	"tray" = {
		 	        "icon-size" = 10;
		 	        "spacing" = 5;
		 	};
		 	
		 	"clock" = {
		 			"format" = "{: %H:%M    %d/%m}";
		 	       	"tooltip-format" = "<tt><small>{calendar}</small></tt>";
		 	       	"calendar" = {
                    	"mode"          = "year";
                    	"mode-mon-col"  = 3;
                    	"weeks-pos"     = "right";
                    	"on-scroll"     = 1;
                    	"on-click-right"= "mode";
                    	"format" = {
                              "months" =     "<span color='#ffead3'><b>{}</b></span>";
                              "days" =       "<span color='#ecc6d9'><b>{}</b></span>";
                              "weeks" =      "<span color='#99ffdd'><b>W{}</b></span>";
                              "weekdays" =   "<span color='#ffcc66'><b>{}</b></span>";
                              "today" =      "<span color='#ff6699'><b><u>{}</u></b></span>";
                        };
                    };
        			"actions" =  {
                    			"on-click-right" = "mode"; 
                    			"on-click-forward" = "tz_up"; 
                    			"on-click-backward" = "tz_down";
                    			"on-scroll-up" = "shift_up";
                    			"on-scroll-down" = "shift_down";
                    };
		 	};
		 	
		 	"backlight" = {
		 	        "device" = "intel_backlight";
		 	        "format" = " {icon} {percent}% ";
		 	        "format-icons" = ["" "" ""];
		 	        "on-scroll-up" = "brightnessctl set 1%+";
		 	        "on-scroll-down" = "brightnessctl set 1%-";
		 	        "min-length" = 6;
		 	};
		 	
		 	"battery" = {
		 	        "states" = {
		 	            "good" = 95;
		 	            "warning" = 30;
		 	            "critical" = 20;
		 	        };
		 	        "format" = " {icon}  {capacity}% ";
		 	        "format-charging" = "  {capacity}%";
        			"format-plugged" = "  {capacity}%";
		 	        "format-alt" = "{time} {icon}";
		 	        "format-icons" = ["" "" "" "" ""];
		 	};
		 	
		 	"pulseaudio" = {
		 	        "format" = " {icon} {volume}% ";
		 	        "tooltip" = false;
		 	        "format-muted" = " Muted";
                    "ignored-sinks"= ["ThinkPad Thunderbolt 3 Dock USB Audio Analog Stereo"];
		 	        #"on-click" = "pamixer -t";
                    "on-click" = "pavucontrol";
		 	        #"on-scroll-up" = "pamixer -i 5";
                    "on-scroll-up" = "amixer -D pulse sset Master 5%+";
		 	        #"on-scroll-down" = "pamixer -d 5";
                    "on-scroll-down" = "amixer -D pulse sset Master 5%-";
		 	        "scroll-step" = 5;
		 	        "format-icons" = {
		 	            "headphone" = "";
		 	            "hands-free" = "";
		 	            "headset" = "";
		 	            "phone" = "";
		 	            "portable" = "";
		 	            "car" = "";
		 	            "default" = ["" "" ""];
		 	        };
		 	};
		 	"bluetooth"= {
    				"format"= "  ";
    				"format-off"= "  ";
    				"on-click"= "blueberry";
    				"tooltip-format"= "{status}";
			};

		 	"pulseaudio#microphone" = {
		 	        "format" = "{format_source}";
		 	        "format-source" = " {volume}%";
        			"format-source-muted" = " Muted";
		 	        #"on-click" = "pamixer --default-source -t";
		 	        "on-click" = "amixer set Capture toggle";
		 	        #"on-scroll-up" = "pamixer --default-source -i 5";
		 	        "on-scroll-up" = "amixer set Capture 5%+";
		 	        #"on-scroll-down" = "pamixer --default-source -d 5";
		 	        "on-scroll-down" = "amixer set Capture 5%-";
		 	        "scroll-step" = 5;
		 	};
		 	
		 		
		 }];
		 

       };






  };

################################################
############# Swaylock config
################################################

 programs.swaylock.settings = {
    color = "000000f0";
    font-size = "24";
    indicator-idle-visible = false;
    indicator-radius = 100;
    indicator-thickness = 20;
    inside-color = "00000000";
    inside-clear-color = "00000000";
    inside-ver-color = "00000000";
    inside-wrong-color = "00000000";
    key-hl-color = "79b360";
    line-color = "000000f0";
    line-clear-color = "000000f0";
    line-ver-color = "000000f0";
    line-wrong-color = "000000f0";
    ring-color = "ffffff50";
    ring-clear-color = "bbbbbb50";
    ring-ver-color = "bbbbbb50";
    ring-wrong-color = "b3606050";
    text-color = "ffffff";
    text-ver-color = "ffffff";
    text-wrong-color = "ffffff";
    show-failed-attempts = true;
  };
 

    
}
