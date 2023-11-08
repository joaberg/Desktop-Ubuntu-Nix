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
    keymap = {
      # https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap.toml
        manager.keymap = [
          { on = [ "<Esc>" ]; exec = "escape"; desc = "Exit visual mode, clear selected, or cancel search"; }
          { on = [ "q" ]; exec = "quit"; desc = "Exit the process"; }
          { on = [ "Q" ]; exec = "quit --no-cwd-file"; desc = "Exit the process without writing cwd-file"; }
          { on = [ "<C-q>" ]; exec = "close"; desc = "Close the current tab, or quit if it is last tab"; }
          { on = [ "<C-z>" ]; exec = "suspend"; desc = "Suspend the process"; }

          # Navigation
          { on = [ "k" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "j" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "K" ]; exec = "arrow -5"; desc = "Move cursor up 5 lines"; }
          { on = [ "J" ]; exec = "arrow 5"; desc = "Move cursor down 5 lines"; }
          { on = [ "<C-u>" ]; exec = "arrow -50%"; desc = "Move cursor up half page"; }
          { on = [ "<C-d>" ]; exec = "arrow 50%"; desc = "Move cursor down half page"; }
          { on = [ "<C-b>" ]; exec = "arrow -100%"; desc = "Move cursor up one page"; }
          { on = [ "<C-f>" ]; exec = "arrow 100%"; desc = "Move cursor down one page"; }
          { on = [ "h" ]; exec = [ "leave" "escape --visual --select" ]; desc = "Go back to the parent directory"; }
          { on = [ "l" ]; exec = [ "enter" "escape --visual --select" ]; desc = "Enter the child directory"; }
          { on = [ "H" ]; exec = "back"; desc = "Go back to the previous directory"; }
          { on = [ "L" ]; exec = "forward"; desc = "Go forward to the next directory"; }
          { on = [ "<A-k>" ]; exec = "peek -5"; desc = "Peek up 5 units in the preview"; }
          { on = [ "<A-j>" ]; exec = "peek 5"; desc = "Peek down 5 units in the preview"; }
          { on = [ "<Up>" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "<Left>" ]; exec = "leave"; desc = "Go back to the parent directory"; }
          { on = [ "<Right>" ]; exec = "enter"; desc = "Enter the child directory"; }
          { on = [ "g" "g" ]; exec = "arrow -99999999"; desc = "Move cursor to the top"; }
          { on = [ "G" ]; exec = "arrow 99999999"; desc = "Move cursor to the bottom"; }

          # Selection
          { on = [ "<Space>" ]; exec = [ "select --state=none" "arrow 1" ]; desc = "Toggle the current selection state"; }
          { on = [ "v" ]; exec = "visual_mode"; desc = "Enter visual mode (selection mode)"; }
          { on = [ "V" ]; exec = "visual_mode --unset"; desc = "Enter visual mode (unset mode)"; }
          { on = [ "<C-a>" ]; exec = "select_all --state=true"; desc = "Select all files"; }
          { on = [ "<C-r>" ]; exec = "select_all --state=none"; desc = "Inverse selection of all files"; }

          # Operation
          { on = [ "o" ]; exec = "open"; desc = "Open the selected files"; }
          { on = [ "O" ]; exec = "open --interactive"; desc = "Open the selected files interactively"; }
          { on = [ "<Enter>" ]; exec = "open"; desc = "Open the selected files"; }
          { on = [ "<C-Enter>" ]; exec = "open --interactive"; desc = "Open the selected files interactively"; }
          { on = [ "y" ]; exec = [ "yank" "escape --visual --select" ]; desc = "Copy the selected files"; }
          { on = [ "x" ]; exec = [ "yank --cut" "escape --visual --select" ]; desc = "Cut the selected files"; }
          { on = [ "p" ]; exec = "paste"; desc = "Paste the files"; }
          { on = [ "P" ]; exec = "paste --force"; desc = "Paste the files (overwrite if the destination exists)"; }
          { on = [ "-" ]; exec = "link"; desc = "Symlink the absolute path of files"; }
          { on = [ "_" ]; exec = "link --relative"; desc = "Symlink the relative path of files"; }
          { on = [ "d" ]; exec = [ "remove" "escape --visual --select" ]; desc = "Move the files to the trash"; }
          { on = [ "D" ]; exec = [ "remove --permanently" "escape --visual --select" ]; desc = "Permanently delete the files"; }
          { on = [ "a" ]; exec = "create"; desc = "Create a file or directory (ends with / for directories)"; }
          { on = [ "r" ]; exec = "rename"; desc = "Rename a file or directory"; }
          { on = [ ";" ]; exec = "shell"; desc = "Run a shell command"; }
          { on = [ ":" ]; exec = "shell --block"; desc = "Run a shell command (block the UI until the command finishes)"; }
          { on = [ "." ]; exec = "hidden toggle"; desc = "Toggle the visibility of hidden files"; }
          { on = [ "s" ]; exec = "search fd"; desc = "Search files by name using fd"; }
          { on = [ "S" ]; exec = "search rg"; desc = "Search files by content using ripgrep"; }
          { on = [ "<C-s>" ]; exec = "search none"; desc = "Cancel the ongoing search"; }
          { on = [ "z" ]; exec = "jump zoxide"; desc = "Jump to a directory using zoxide"; }
          { on = [ "Z" ]; exec = "jump fzf"; desc = "Jump to a directory, or reveal a file using fzf"; }

          # Linemode
          { on = [ "m" "s" ]; exec = "linemode size"; desc = "Set linemode to size"; }
          { on = [ "m" "p" ]; exec = "linemode permissions"; desc = "Set linemode to permissions"; }
          { on = [ "m" "m" ]; exec = "linemode mtime"; desc = "Set linemode to mtime"; }
          { on = [ "m" "n" ]; exec = "linemode none"; desc = "Set linemode to none"; }

          # Copy
          { on = [ "c" "c" ]; exec = "copy path"; desc = "Copy the absolute path"; }
          { on = [ "c" "d" ]; exec = "copy dirname"; desc = "Copy the path of the parent directory"; }
          { on = [ "c" "f" ]; exec = "copy filename"; desc = "Copy the name of the file"; }
          { on = [ "c" "n" ]; exec = "copy name_without_ext"; desc = "Copy the name of the file without the extension"; }

          # Find
          { on = [ "/" ]; exec = "find --smart"; }
          #{ on = [ "?" ]; exec = "find --previous --smart"; }
          { on = [ "n" ]; exec = "find_arrow"; }
          { on = [ "N" ]; exec = "find_arrow --previous"; }

          # Sorting
          { on = [ "," "a" ]; exec = "sort alphabetical --dir_first"; desc = "Sort alphabetically"; }
          { on = [ "," "A" ]; exec = "sort alphabetical --reverse --dir_first"; desc = "Sort alphabetically (reverse)"; }
          { on = [ "," "c" ]; exec = "sort created --dir_first"; desc = "Sort by creation time"; }
          { on = [ "," "C" ]; exec = "sort created --reverse --dir_first"; desc = "Sort by creation time (reverse)"; }
          { on = [ "," "m" ]; exec = "sort modified --dir_first"; desc = "Sort by modified time"; }
          { on = [ "," "M" ]; exec = "sort modified --reverse --dir_first"; desc = "Sort by modified time (reverse)"; }
          { on = [ "," "n" ]; exec = "sort natural --dir_first"; desc = "Sort naturally"; }
          { on = [ "," "N" ]; exec = "sort natural --reverse --dir_first"; desc = "Sort naturally (reverse)"; }
          { on = [ "," "s" ]; exec = "sort size --dir_first"; desc = "Sort by size"; }
          { on = [ "," "S" ]; exec = "sort size --reverse --dir_first"; desc = "Sort by size (reverse)"; }

          # Tabs
          { on = [ "t" ]; exec = "tab_create --current"; desc = "Create a new tab using the current path"; }
          { on = [ "1" ]; exec = "tab_switch 0"; desc = "Switch to the first tab"; }
          { on = [ "2" ]; exec = "tab_switch 1"; desc = "Switch to the second tab"; }
          { on = [ "3" ]; exec = "tab_switch 2"; desc = "Switch to the third tab"; }
          { on = [ "4" ]; exec = "tab_switch 3"; desc = "Switch to the fourth tab"; }
          { on = [ "5" ]; exec = "tab_switch 4"; desc = "Switch to the fifth tab"; }
          { on = [ "6" ]; exec = "tab_switch 5"; desc = "Switch to the sixth tab"; }
          { on = [ "7" ]; exec = "tab_switch 6"; desc = "Switch to the seventh tab"; }
          { on = [ "8" ]; exec = "tab_switch 7"; desc = "Switch to the eighth tab"; }
          { on = [ "9" ]; exec = "tab_switch 8"; desc = "Switch to the ninth tab"; }
          { on = [ "[" ]; exec = "tab_switch -1 --relative"; desc = "Switch to the previous tab"; }
          { on = [ "]" ]; exec = "tab_switch 1 --relative"; desc = "Switch to the next tab"; }
          { on = [ "{" ]; exec = "tab_swap -1"; desc = "Swap the current tab with the previous tab"; }
          { on = [ "}" ]; exec = "tab_swap 1"; desc = "Swap the current tab with the next tab"; }

          # Tasks
          { on = [ "w" ]; exec = "tasks_show"; desc = "Show the tasks manager"; }

          # Goto
          { on = [ "g" "h" ];       exec = "cd ~"; desc = "Go to the home directory"; }
          { on = [ "g" "c" ];       exec = "cd ~/.config"; desc = "Go to the config directory"; }
          { on = [ "g" "d" ];       exec = "cd ~/Downloads"; desc = "Go to the downloads directory"; }
          { on = [ "g" "t" ];       exec = "cd /tmp"; desc = "Go to the temporary directory"; }
          { on = [ "g" "<Space>" ]; exec = "cd --interactive"; desc = "Go to a directory interactively"; }

          # Help
          #{ on = [ "~" ]; exec = "help"; desc = "Open help"; }
          { on = [ "?" ]; exec = "help"; desc = "Open help"; }

        ];

        tasks.keymap = [
          { on = [ "<Esc>" ]; exec = "close"; desc = "Hide the task manager"; }
          { on = [ "<C-q>" ]; exec = "close"; desc = "Hide the task manager"; }
          { on = [ "w" ]; exec = "close"; desc = "Hide the task manager"; }
          { on = [ "k" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "j" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "<Up>" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "<Enter>" ]; exec = "inspect"; desc = "Inspect the task"; }
          { on = [ "x" ]; exec = "cancel"; desc = "Cancel the task"; }
          #{ on = [ "~" ]; exec = "help"; desc = "Open help"; }
          { on = [ "?" ]; exec = "help"; desc = "Open help"; }

        ];

        select.keymap = [
          { on = [ "<C-q>" ]; exec = "close"; desc = "Cancel selection"; }
          { on = [ "<Esc>" ]; exec = "close"; desc = "Cancel selection"; }
          { on = [ "<Enter>" ]; exec = "close --submit"; desc = "Submit the selection"; }
          { on = [ "k" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "j" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "K" ]; exec = "arrow -5"; desc = "Move cursor up 5 lines"; }
          { on = [ "J" ]; exec = "arrow 5"; desc = "Move cursor down 5 lines"; }
          { on = [ "<Up>" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          #{ on = [ "~" ]; exec = "help"; desc = "Open help"; }
          { on = [ "?" ]; exec = "help"; desc = "Open help"; }
        ];

        input.keymap = [
          { on = [ "<C-q>" ]; exec = "close"; desc = "Cancel input"; }
          { on = [ "<Enter>" ]; exec = "close --submit"; desc = "Submit the input"; }
          { on = [ "<Esc>" ]; exec = "escape"; desc = "Go back the normal mode, or cancel input"; }

          # Mode
          { on = [ "i" ]; exec = "insert"; desc = "Enter insert mode"; }
          { on = [ "a" ]; exec = "insert --append"; desc = "Enter append mode"; }
          { on = [ "v" ]; exec = "visual"; desc = "Enter visual mode"; }
          { on = [ "V" ]; exec = [ "move -999" "visual" "move 999" ]; desc = "Enter visual mode and select all"; }

          # Navigation
          { on = [ "h" ]; exec = "move -1"; desc = "Move cursor left"; }
          { on = [ "l" ]; exec = "move 1"; desc = "Move cursor right"; }
          { on = [ "0" ]; exec = "move -999"; desc = "Move to the BOL"; }
          { on = [ "$" ]; exec = "move 999"; desc = "Move to the EOL"; }
          { on = [ "I" ]; exec = [ "move -999" "insert" ]; desc = "Move to the BOL, and enter insert mode"; }
          { on = [ "A" ]; exec = [ "move 999" "insert --append" ]; desc = "Move to the EOL, and enter append mode"; }
          { on = [ "<Left>" ]; exec = "move -1"; desc = "Move cursor left"; }
          { on = [ "<Right>" ]; exec = "move 1"; desc = "Move cursor right"; }
          { on = [ "b" ]; exec = "backward"; desc = "Move to the beginning of the previous word"; }
          { on = [ "w" ]; exec = "forward"; desc = "Move to the beginning of the next word"; }
          { on = [ "e" ]; exec = "forward --end-of-word"; desc = "Move to the end of the next word"; }

          # Deletion
          { on = [ "d" ]; exec = "delete --cut"; desc = "Cut the selected characters"; }
          { on = [ "D" ]; exec = [ "delete --cut" "move 999" ]; desc = "Cut until the EOL"; }
          { on = [ "c" ]; exec = "delete --cut --insert"; desc = "Cut the selected characters, and enter insert mode"; }
          { on = [ "C" ]; exec = [ "delete --cut --insert" "move 999" ]; desc = "Cut until the EOL, and enter insert mode"; }
          { on = [ "x" ]; exec = [ "delete --cut" "move 1 --in-operating" ]; desc = "Cut the current character"; }

          # Yank/Paste
          { on = [ "y" ]; exec = "yank"; desc = "Copy the selected characters"; }
          { on = [ "p" ]; exec = "paste"; desc = "Paste the copied characters after the cursor"; }
          { on = [ "P" ]; exec = "paste --before"; desc = "Paste the copied characters before the cursor"; }

          # Undo/Redo
          { on = [ "u" ]; exec = "undo"; desc = "Undo the last operation"; }
          { on = [ "<C-r>" ]; exec = "redo"; desc = "Redo the last operation"; }

          # Help
          #{ on = [ "~" ]; exec = "help"; desc = "Open help"; }
          { on = [ "?" ]; exec = "help"; desc = "Open help"; }
        ];

        completion.keymap = [
          { on = [ "<C-q>" ]; exec = "close"; desc = "Cancel completion"; }
          { on = [ "<Tab>" ]; exec = "close --submit"; desc = "Submit the completion"; }
          { on = [ "<A-k>" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<A-j>" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "<Up>" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          #{ on = [ "~" ]; exec = "help"; desc = "Open help"; }
          { on = [ "?" ]; exec = "help"; desc = "Open help"; }
        ];

        help.keymap = [
          { on = [ "<Esc>" ]; exec = "escape"; desc = "Clear the filter, or hide the help"; }
          { on = [ "q" ]; exec = "close"; desc = "Exit the process"; }
          { on = [ "<C-q>" ]; exec = "close"; desc = "Hide the help"; }

          # Navigation
          { on = [ "k" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "j" ]; exec = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "K" ]; exec = "arrow -5"; desc = "Move cursor up 5 lines"; }
          { on = [ "J" ]; exec = "arrow 5"; desc = "Move cursor down 5 lines"; }
          { on = [ "<Up>" ]; exec = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; exec = "arrow 1"; desc = "Move cursor down"; }

          # Filtering
          { on = [ "/" ]; exec = "filter"; desc = "Apply a filter for the help items"; }
        ];

    };
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
            ssh="TERM=xterm-256color ssh";
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
