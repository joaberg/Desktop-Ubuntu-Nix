{ config, pkgs, ... }:
# https://rycee.gitlab.io/home-manager/options.html


with pkgs.lib; {
    
    home.packages = with pkgs; [
        fzf # Fuzzy finder
        peco # dependency of enhancd
        zf # dependency of enhancd
        meslo-lgs-nf # Nerdfont 
        iosevka # Font
        jetbrains-mono # Font
       	git # Needed by zsh / zplug
        fastfetch # a faster neofetch alternative
        lsd # ls deluxe
        htop # system monitor
        btop # system monitor
        tldr  # short  man /help
        helix # Modern vim / neovim, hx command
        du-dust # Disk usage tool, dust command
        fd # Find tool
        ripgrep # grep tool, rg command
        bat # Better cat
        
       
    ];



    # Will make the font cache update when needed.
	fonts.fontconfig.enable = true;



###
# Micro (editor)
###
    programs.micro = {
      enable = true;
      settings = {
        clipboard = "terminal";
        #clipboard = "external";
        colorscheme = "dracula-tc";
        keymenu = true;
      };
    };


###
# Yazi (filemanager)
###
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

###
# Starship prompt
###
programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableIonIntegration = false;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = ''
          [](blue)[ ](bg:blue fg:black)$username$hostname[](bg:purple fg:blue)$directory[](purple) 
          $character
      '';

      username = {
        show_always = true;
        style_user = "bg:blue fg:black";
        style_root = "bg:blue fg:red";
        format = "[$user]($style)";
      };
      directory = {
        format = "[$path]($style)";
        style = "bg:purple fg:black";
        truncate_to_repo = false;
      };
    hostname = {      
      ssh_only = true;
      format = "[ 🌏 ](bg:blue fg:white)[$hostname](bg:blue fg:white)";
      disabled = false;
    };
      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
      };
      directory.substitutions = {
        "Documents" = "📄 ";
        "Downloads" = "📥 ";
        "Music" = "🎜 ";
        "Pictures" = "📷 ";
      };

    };

};

###
# ZSH
###
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        
        #enableCompletion = true;

        shellAliases = {
            ll = "lsd -latr";
            l = "lsd";
            x = "exit";
            m = "micro";
            vim = "hx";
            cat = "bat -p";
            #ssh="TERM=xterm-256color ssh";
            ripdrag = "ripdrag $(fzf)";
            home-manager-update = "nix-channel --update && nix flake update ~/.config/home-manager/ && home-manager switch";
            home-manager-cleanup = "nix-collect-garbage &&  home-manager expire-generations \"-1 days\" && nix-store --optimise";
            backup_syncthing = "rsync -avz --delete ~/Documents ~/Downloads ~/Desktop ~/Backup/$(hostname)";
            snippet-nix-install-zsh = "curl -H \"Cache-Control: no-cache\" -sSL https://raw.githubusercontent.com/joaberg/server-zsh-nix/main/install.sh | bash";
            snippet-nix-update-zsh = "curl -H \"Cache-Control: no-cache\" -sSL https://raw.githubusercontent.com/joaberg/server-zsh-nix/main/update.sh | bash";
            snippet-sshkey = "[ -d .ssh ] || ssh-keygen -q -t ed25519 -a 32 -f ~/.ssh/id_ed25519 -P \"\" ; grep -q \"AAAAC3NzaC1lZDI1NTE5AAAAINp6BOKX6XDOSLye9Vc2y4wbovNtvqFKas73TKgCOqIQ\" ~/.ssh/authorized_keys || echo \"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINp6BOKX6XDOSLye9Vc2y4wbovNtvqFKas73TKgCOqIQ joakim\" >> ~/.ssh/authorized_keys";
            snippet-uninstall_nix = "/nix/nix-installer uninstall";
        };


        history = {
            size = 10000;
            path = "${config.xdg.dataHome}/zsh/history";
        };

        zplug = {
            enable = true;
            plugins = [
                # List fo plugins: https://github.com/unixorn/awesome-zsh-plugins
            # { name = "b4b4r07/enhancd"; }
            { name = "sunlei/zsh-ssh"; } # ssh manager (cli> ssh <space> <tab>)
            { name = "chisui/zsh-nix-shell"; } # Makes the nix-shell command be zsh instead of bash.
            { name = "zsh-users/zsh-syntax-highlighting"; }
            { name = "dracula/zsh"; tags = [ as:theme depth:1 ]; } 
            ];
        };

        initExtra = ''
            # Other Zsh configurations go here
            
            #Override language
            LC_ALL="en_US.UTF-8"

            # User specific environment
            if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
            then
                PATH="$HOME/.local/bin:$HOME/bin:$PATH"
            fi
            export PATH
                   
            #Functions
	          # sudo function/alias
            sud() {
              # Launch a shell with sudo permissions, but still use your users shell etc.
                if [ $# -eq 0 ]; then
                  sudo -H -u root env "HOME=$HOME" "USER=$USER" $HOME/.nix-profile/bin/zsh -i
                else
                  sudo env "HOME=$HOME" "USER=$USER" $HOME/.nix-profile/bin/zsh -c "$*"
                fi
                }

            # FZF Dracula colors
            export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

            
            # Launch neofetch
            fastfetch
            

            '';
           
    };

    # This is a workaround. By default most systems launch bash. This will make zsh start when bash is launched. Usefull if you dont have root access.
    programs.bash.enable = true;
    programs.bash.initExtra = ''
        $HOME/.nix-profile/bin/zsh
    '';

###
# SKIM
###

    programs.skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'lsd --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };    
    

###
# Zoxide
###
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

###
# Zellij terminal multiplexer
###

    programs.zellij = {
        enable = true;
        enableZshIntegration = false;
        settings = {
          theme = "dracula";
          scrollback_editor = "~/.nix-profile/bin/micro";
          #default_shell = "~/.nix-profile/bin/zsh";
          #copy_clipboard = "primary"; 
                 
        };
    };





}
