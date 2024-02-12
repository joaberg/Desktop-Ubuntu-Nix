{ config, pkgs, ... }:
# https://rycee.gitlab.io/home-manager/options.html

# Config inspiration: https://git.project-insanity.org/onny/nixos-lappy/-/blob/master/home.nix
# Nix on Ubuntu https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/

# Updates:
# cd .config/home-manager && nix flake update



{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "joakim";
  home.homeDirectory = "/home/joakim";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # used by obsidian
  ];

  # Need this to get some env correct.
  targets.genericLinux.enable = true;

imports = [
    ./zsh.nix # zsh config
	  ./hyprland.nix # Hyprland desktop config
  ];

  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

#    xdg-desktop-portal-hyprland

	
#    openh264
#    nordic # Nord themes GTK/KDE
	

#    socat
    #######
    xfce.thunar # file manager
    xfce.thunar-archive-plugin
    gvfs # lib needed by thunar
    xfce.xfconf # needed by thunar
    zathura # pdf viewer

    vivaldi # browser
    termius  # terminal 
    obsidian # notes # Currently using unsecure version of electron 25.9.0
    spotify # music
    wine   # windows emulator
    vscode
    #pavucontrol # sound control settings
    mattermost-desktop
    discord
    libreoffice
    #gscan2pdf # scanner tool
	  wireshark   #packet sniffer
    ### Gaming 
	 #warzone2100
   #gamescope
    #steam 
    openttd # game
    ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/joakim/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "micro";
    
  };

  	# Let Home Manager install and manage itself.
  	programs.home-manager.enable = true;

	# Will make the font cache update when needed.
	fonts.fontconfig.enable = true;

 



  
 services = {
 	syncthing.enable = true; 	# Sync tool

 };


programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      # https://github.com/dracula/foot/blob/master/foot.ini
      # options: https://codeberg.org/dnkl/foot/src/branch/master/foot.ini
      main = {
        #term = "xterm-256color";
        term = "foot";
        font = "iosevka:size=10, MesloLGS NF:size=10";
        selection-target = "both"; # One of none, primary, clipboard or both. Default: primary.
      };

      colors = {
        # Dracula theme
        # alpha=1.0
        #background = "282a36";
        background = "101014";
        foreground = "f8f8f2";

        ## Normal/regular colors (color palette 0-7)
        regular0 = "21222c";  # black
        regular1 = "ff5555";  # red
        regular2 = "50fa7b";  # green
        regular3 = "f1fa8c";  # yellow
        regular4 = "bd93f9";  # blue
        regular5 = "ff79c6";  # magenta
        regular6 = "8be9fd";  # cyan
        regular7 = "f8f8f2";  # white

        ## Bright colors (color palette 8-15)
        bright0 = "6272a4";   # bright black
        bright1 = "ff6e6e";   # bright red
        bright2 = "69ff94";   # bright green
        bright3 = "ffffa5";   # bright yellow
        bright4 = "d6acff";   # bright blue
        bright5 = "ff92df";   # bright magenta
        bright6 = "a4ffff";   # bright cyan
        bright7 = "ffffff";   # bright white

        ## Misc colors
        selection-foreground = "ffffff";
        selection-background = "44475a";
        # jump-labels=<regular0> <regular3>          # black-on-yellow
        # scrollback-indicator=<regular0> <bright4>  # black-on-bright-blue
        # search-box-no-match=<regular0> <regular1>  # black-on-red
        # search-box-match=<regular0> <regular3>     # black-on-yellow
        urls = "8be9fd";
      };

    };

  

  };

programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka";
      font_size = "10";
      enable_audio_bell = "no";
    };

    extraConfig = ''
          # https://draculatheme.com/kitty
          #
          # Installation instructions:
          #
          #  cp dracula.conf ~/.config/kitty/
          #  echo "include dracula.conf" >> ~/.config/kitty/kitty.conf
          #
          # Then reload kitty for the config to take affect.
          # Alternatively copy paste below directly into kitty.conf

          foreground            #f8f8f2
          #background            #282a36
          background            #101014
          selection_foreground  #ffffff
          selection_background  #44475a

          url_color #8be9fd

          # black
          color0  #21222c
          color8  #6272a4

          # red
          color1  #ff5555
          color9  #ff6e6e

          # green
          color2  #50fa7b
          color10 #69ff94

          # yellow
          color3  #f1fa8c
          color11 #ffffa5

          # blue
          color4  #bd93f9
          color12 #d6acff

          # magenta
          color5  #ff79c6
          color13 #ff92df

          # cyan
          color6  #8be9fd
          color14 #a4ffff

          # white
          color7  #f8f8f2
          color15 #ffffff

          # Cursor colors
          cursor            #f8f8f2
          cursor_text_color background

          # Tab bar colors
          active_tab_foreground   #282a36
          active_tab_background   #f8f8f2
          inactive_tab_foreground #282a36
          inactive_tab_background #6272a4

          # Marks
          mark1_foreground #282a36
          mark1_background #ff5555

          # Splits/Windows
          active_border_color #f8f8f2
          inactive_border_color #6272a4

    '';

  };
  

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "iosevka";
        size = 10;
      };
      colors = {
        primary = {
          /*background = "#282a36"; 
          background = "#070709";*/
          background = "#101014";
          foreground = "#f8f8f2";
          bright_foreground = "#ffffff";
        };
        cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        vi_mode_cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        search = {
          matches = {
            foreground = "#44475a";
            background = "#50fa7b";
          };
          focused_match = {
            foreground = "#44475a";
            background = "#ffb86c";
          };
        };
        footer_ba = {
          background = "#282a36";
          foreground = "#f8f8f2";
        };
        hints = {
          start = {
            foreground = "#282a36";
            background = "#f1fa8c";
          };
          end = {
            foreground = "#f1fa8c";
            background = "#282a36";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        selection = {
          text = "CellForeground";
          background = "#44475a";
        };
        normal = {
          black = "#21222c";
          red = "#ff5555";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#bd93f9";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#f8f8f2";
        };
        bright = {
          black = "#6272a4";
          red = "#ff6e6e";
          green = "#69ff94";
          yellow = "#ffffa5";
          blue = "#d6acff";
          magenta = "#ff92df";
          cyan = "#a4ffff";
          white = "#ffffff";
        };
      };
    };

  };
 



  
}
