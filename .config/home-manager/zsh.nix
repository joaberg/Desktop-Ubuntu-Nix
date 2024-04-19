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
        #clipboard = "terminal";
        clipboard = "external";
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
          { on = [ "<Esc>" ]; run = "escape"; desc = "Exit visual mode, clear selected, or cancel search"; }
          { on = [ "q" ]; run = "quit"; desc = "Exit the process"; }
          { on = [ "Q" ]; run = "quit --no-cwd-file"; desc = "Exit the process without writing cwd-file"; }
          { on = [ "<C-q>" ]; run = "close"; desc = "Close the current tab, or quit if it is last tab"; }
          { on = [ "<C-z>" ]; run = "suspend"; desc = "Suspend the process"; }

          # Navigation
          { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
          { on = [ "J" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
          { on = [ "<C-u>" ]; run = "arrow -50%"; desc = "Move cursor up half page"; }
          { on = [ "<C-d>" ]; run = "arrow 50%"; desc = "Move cursor down half page"; }
          { on = [ "<C-b>" ]; run = "arrow -100%"; desc = "Move cursor up one page"; }
          { on = [ "<C-f>" ]; run = "arrow 100%"; desc = "Move cursor down one page"; }
          { on = [ "h" ]; exec = [ "leave" "escape --visual --select" ]; desc = "Go back to the parent directory"; }
          { on = [ "l" ]; exec = [ "enter" "escape --visual --select" ]; desc = "Enter the child directory"; }
          { on = [ "H" ]; run = "back"; desc = "Go back to the previous directory"; }
          { on = [ "L" ]; run = "forward"; desc = "Go forward to the next directory"; }
          { on = [ "<A-k>" ]; run = "peek -5"; desc = "Peek up 5 units in the preview"; }
          { on = [ "<A-j>" ]; run = "peek 5"; desc = "Peek down 5 units in the preview"; }
          { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "<Left>" ]; run = "leave"; desc = "Go back to the parent directory"; }
          { on = [ "<Right>" ]; run = "enter"; desc = "Enter the child directory"; }
          { on = [ "g" "g" ]; run = "arrow -99999999"; desc = "Move cursor to the top"; }
          { on = [ "G" ]; run = "arrow 99999999"; desc = "Move cursor to the bottom"; }

          # Selection
          { on = [ "<Space>" ]; exec = [ "select --state=none" "arrow 1" ]; desc = "Toggle the current selection state"; }
          { on = [ "v" ]; run = "visual_mode"; desc = "Enter visual mode (selection mode)"; }
          { on = [ "V" ]; run = "visual_mode --unset"; desc = "Enter visual mode (unset mode)"; }
          { on = [ "<C-a>" ]; run = "select_all --state=true"; desc = "Select all files"; }
          { on = [ "<C-r>" ]; run = "select_all --state=none"; desc = "Inverse selection of all files"; }

          # Operation
          { on = [ "o" ]; run = "open"; desc = "Open the selected files"; }
          { on = [ "O" ]; run = "open --interactive"; desc = "Open the selected files interactively"; }
          { on = [ "<Enter>" ]; run = "open"; desc = "Open the selected files"; }
          { on = [ "<C-Enter>" ]; run = "open --interactive"; desc = "Open the selected files interactively"; }
          { on = [ "y" ]; exec = [ "yank" "escape --visual --select" ]; desc = "Copy the selected files"; }
          { on = [ "x" ]; exec = [ "yank --cut" "escape --visual --select" ]; desc = "Cut the selected files"; }
          { on = [ "p" ]; run = "paste"; desc = "Paste the files"; }
          { on = [ "P" ]; run = "paste --force"; desc = "Paste the files (overwrite if the destination exists)"; }
          { on = [ "-" ]; run = "link"; desc = "Symlink the absolute path of files"; }
          { on = [ "_" ]; run = "link --relative"; desc = "Symlink the relative path of files"; }
          { on = [ "d" ]; exec = [ "remove" "escape --visual --select" ]; desc = "Move the files to the trash"; }
          { on = [ "D" ]; exec = [ "remove --permanently" "escape --visual --select" ]; desc = "Permanently delete the files"; }
          { on = [ "a" ]; run = "create"; desc = "Create a file or directory (ends with / for directories)"; }
          { on = [ "r" ]; run = "rename"; desc = "Rename a file or directory"; }
          { on = [ ";" ]; run = "shell"; desc = "Run a shell command"; }
          { on = [ ":" ]; run = "shell --block"; desc = "Run a shell command (block the UI until the command finishes)"; }
          { on = [ "." ]; run = "hidden toggle"; desc = "Toggle the visibility of hidden files"; }
          { on = [ "s" ]; run = "search fd"; desc = "Search files by name using fd"; }
          { on = [ "S" ]; run = "search rg"; desc = "Search files by content using ripgrep"; }
          { on = [ "<C-s>" ]; run = "search none"; desc = "Cancel the ongoing search"; }
          { on = [ "z" ]; run = "jump zoxide"; desc = "Jump to a directory using zoxide"; }
          { on = [ "Z" ]; run = "jump fzf"; desc = "Jump to a directory, or reveal a file using fzf"; }

          # Linemode
          { on = [ "m" "s" ]; run = "linemode size"; desc = "Set linemode to size"; }
          { on = [ "m" "p" ]; run = "linemode permissions"; desc = "Set linemode to permissions"; }
          { on = [ "m" "m" ]; run = "linemode mtime"; desc = "Set linemode to mtime"; }
          { on = [ "m" "n" ]; run = "linemode none"; desc = "Set linemode to none"; }

          # Copy
          { on = [ "c" "c" ]; run = "copy path"; desc = "Copy the absolute path"; }
          { on = [ "c" "d" ]; run = "copy dirname"; desc = "Copy the path of the parent directory"; }
          { on = [ "c" "f" ]; run = "copy filename"; desc = "Copy the name of the file"; }
          { on = [ "c" "n" ]; run = "copy name_without_ext"; desc = "Copy the name of the file without the extension"; }

          # Find
          { on = [ "/" ]; run = "find --smart"; }
          #{ on = [ "?" ]; run = "find --previous --smart"; }
          { on = [ "n" ]; run = "find_arrow"; }
          { on = [ "N" ]; run = "find_arrow --previous"; }

          # Sorting
          { on = [ "," "a" ]; run = "sort alphabetical --dir_first"; desc = "Sort alphabetically"; }
          { on = [ "," "A" ]; run = "sort alphabetical --reverse --dir_first"; desc = "Sort alphabetically (reverse)"; }
          { on = [ "," "c" ]; run = "sort created --dir_first"; desc = "Sort by creation time"; }
          { on = [ "," "C" ]; run = "sort created --reverse --dir_first"; desc = "Sort by creation time (reverse)"; }
          { on = [ "," "m" ]; run = "sort modified --dir_first"; desc = "Sort by modified time"; }
          { on = [ "," "M" ]; run = "sort modified --reverse --dir_first"; desc = "Sort by modified time (reverse)"; }
          { on = [ "," "n" ]; run = "sort natural --dir_first"; desc = "Sort naturally"; }
          { on = [ "," "N" ]; run = "sort natural --reverse --dir_first"; desc = "Sort naturally (reverse)"; }
          { on = [ "," "s" ]; run = "sort size --dir_first"; desc = "Sort by size"; }
          { on = [ "," "S" ]; run = "sort size --reverse --dir_first"; desc = "Sort by size (reverse)"; }

          # Tabs
          { on = [ "t" ]; run = "tab_create --current"; desc = "Create a new tab using the current path"; }
          { on = [ "1" ]; run = "tab_switch 0"; desc = "Switch to the first tab"; }
          { on = [ "2" ]; run = "tab_switch 1"; desc = "Switch to the second tab"; }
          { on = [ "3" ]; run = "tab_switch 2"; desc = "Switch to the third tab"; }
          { on = [ "4" ]; run = "tab_switch 3"; desc = "Switch to the fourth tab"; }
          { on = [ "5" ]; run = "tab_switch 4"; desc = "Switch to the fifth tab"; }
          { on = [ "6" ]; run = "tab_switch 5"; desc = "Switch to the sixth tab"; }
          { on = [ "7" ]; run = "tab_switch 6"; desc = "Switch to the seventh tab"; }
          { on = [ "8" ]; run = "tab_switch 7"; desc = "Switch to the eighth tab"; }
          { on = [ "9" ]; run = "tab_switch 8"; desc = "Switch to the ninth tab"; }
          { on = [ "[" ]; run = "tab_switch -1 --relative"; desc = "Switch to the previous tab"; }
          { on = [ "]" ]; run = "tab_switch 1 --relative"; desc = "Switch to the next tab"; }
          { on = [ "{" ]; run = "tab_swap -1"; desc = "Swap the current tab with the previous tab"; }
          { on = [ "}" ]; run = "tab_swap 1"; desc = "Swap the current tab with the next tab"; }

          # Tasks
          { on = [ "w" ]; run = "tasks_show"; desc = "Show the tasks manager"; }

          # Goto
          { on = [ "g" "h" ];       run = "cd ~"; desc = "Go to the home directory"; }
          { on = [ "g" "c" ];       run = "cd ~/.config"; desc = "Go to the config directory"; }
          { on = [ "g" "d" ];       run = "cd ~/Downloads"; desc = "Go to the downloads directory"; }
          { on = [ "g" "t" ];       run = "cd /tmp"; desc = "Go to the temporary directory"; }
          { on = [ "g" "<Space>" ]; run = "cd --interactive"; desc = "Go to a directory interactively"; }

          # Help
          #{ on = [ "~" ]; run = "help"; desc = "Open help"; }
          { on = [ "?" ]; run = "help"; desc = "Open help"; }

        ];

        tasks.keymap = [
          { on = [ "<Esc>" ]; run = "close"; desc = "Hide the task manager"; }
          { on = [ "<C-q>" ]; run = "close"; desc = "Hide the task manager"; }
          { on = [ "w" ]; run = "close"; desc = "Hide the task manager"; }
          { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "<Enter>" ]; run = "inspect"; desc = "Inspect the task"; }
          { on = [ "x" ]; run = "cancel"; desc = "Cancel the task"; }
          #{ on = [ "~" ]; run = "help"; desc = "Open help"; }
          { on = [ "?" ]; run = "help"; desc = "Open help"; }

        ];

        select.keymap = [
          { on = [ "<C-q>" ]; run = "close"; desc = "Cancel selection"; }
          { on = [ "<Esc>" ]; run = "close"; desc = "Cancel selection"; }
          { on = [ "<Enter>" ]; run = "close --submit"; desc = "Submit the selection"; }
          { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
          { on = [ "J" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
          { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
          #{ on = [ "~" ]; run = "help"; desc = "Open help"; }
          { on = [ "?" ]; run = "help"; desc = "Open help"; }
        ];

        input.keymap = [
          { on = [ "<C-q>" ]; run = "close"; desc = "Cancel input"; }
          { on = [ "<Enter>" ]; run = "close --submit"; desc = "Submit the input"; }
          { on = [ "<Esc>" ]; run = "escape"; desc = "Go back the normal mode, or cancel input"; }
          { on = [ "<Backspace>" ]; run = "backspace"; desc = "Backspace"; }

          # Mode
          { on = [ "i" ]; run = "insert"; desc = "Enter insert mode"; }
          { on = [ "a" ]; run = "insert --append"; desc = "Enter append mode"; }
          { on = [ "v" ]; run = "visual"; desc = "Enter visual mode"; }
          { on = [ "V" ]; exec = [ "move -999" "visual" "move 999" ]; desc = "Enter visual mode and select all"; }

          # Navigation
          { on = [ "h" ]; run = "move -1"; desc = "Move cursor left"; }
          { on = [ "l" ]; run = "move 1"; desc = "Move cursor right"; }
          { on = [ "0" ]; run = "move -999"; desc = "Move to the BOL"; }
          { on = [ "$" ]; run = "move 999"; desc = "Move to the EOL"; }
          { on = [ "I" ]; exec = [ "move -999" "insert" ]; desc = "Move to the BOL, and enter insert mode"; }
          { on = [ "A" ]; exec = [ "move 999" "insert --append" ]; desc = "Move to the EOL, and enter append mode"; }
          { on = [ "<Left>" ]; run = "move -1"; desc = "Move cursor left"; }
          { on = [ "<Right>" ]; run = "move 1"; desc = "Move cursor right"; }
          { on = [ "b" ]; run = "backward"; desc = "Move to the beginning of the previous word"; }
          { on = [ "w" ]; run = "forward"; desc = "Move to the beginning of the next word"; }
          { on = [ "e" ]; run = "forward --end-of-word"; desc = "Move to the end of the next word"; }

          # Deletion
          { on = [ "d" ]; run = "delete --cut"; desc = "Cut the selected characters"; }
          { on = [ "D" ]; exec = [ "delete --cut" "move 999" ]; desc = "Cut until the EOL"; }
          { on = [ "c" ]; run = "delete --cut --insert"; desc = "Cut the selected characters, and enter insert mode"; }
          { on = [ "C" ]; exec = [ "delete --cut --insert" "move 999" ]; desc = "Cut until the EOL, and enter insert mode"; }
          { on = [ "x" ]; exec = [ "delete --cut" "move 1 --in-operating" ]; desc = "Cut the current character"; }

          # Yank/Paste
          { on = [ "y" ]; run = "yank"; desc = "Copy the selected characters"; }
          { on = [ "p" ]; run = "paste"; desc = "Paste the copied characters after the cursor"; }
          { on = [ "P" ]; run = "paste --before"; desc = "Paste the copied characters before the cursor"; }

          # Undo/Redo
          { on = [ "u" ]; run = "undo"; desc = "Undo the last operation"; }
          { on = [ "<C-r>" ]; run = "redo"; desc = "Redo the last operation"; }

          # Help
          #{ on = [ "~" ]; run = "help"; desc = "Open help"; }
          { on = [ "?" ]; run = "help"; desc = "Open help"; }
        ];

        completion.keymap = [
          { on = [ "<C-q>" ]; run = "close"; desc = "Cancel completion"; }
          { on = [ "<Tab>" ]; run = "close --submit"; desc = "Submit the completion"; }
          { on = [ "<A-k>" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<A-j>" ]; run = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }
          #{ on = [ "~" ]; run = "help"; desc = "Open help"; }
          { on = [ "?" ]; run = "help"; desc = "Open help"; }
        ];

        help.keymap = [
          { on = [ "<Esc>" ]; run = "escape"; desc = "Clear the filter, or hide the help"; }
          { on = [ "q" ]; run = "close"; desc = "Exit the process"; }
          { on = [ "<C-q>" ]; run = "close"; desc = "Hide the help"; }

          # Navigation
          { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
          { on = [ "K" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }
          { on = [ "J" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
          { on = [ "<Up>" ]; run = "arrow -1"; desc = "Move cursor up"; }
          { on = [ "<Down>" ]; run = "arrow 1"; desc = "Move cursor down"; }

          # Filtering
          { on = [ "/" ]; run = "filter"; desc = "Apply a filter for the help items"; }
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
        autosuggestion.enable = true;
        
        #enableCompletion = true;

        shellAliases = {
            ll = "lsd -latr";
            l = "lsd";
            x = "exit";
            m = "micro";
            cat = "bat -p";
            ssh="TERM=xterm-256color ssh";
            ripdrag = "ripdrag $(fzf)";
            home-manager-update = "nix-channel --update && nix flake update ~/.config/home-manager/ && nix profile upgrade '.*' --impure && home-manager switch";
            home-manager-cleanup = "nix-collect-garbage &&  home-manager expire-generations \"-1 days\" && nix-store --optimise";
            #nixos-update= "sudo nix-channel --update; sudo nix-env --install --attr nixpkgs.nix nixpkgs.cacert; sudo systemctl daemon-reload; sudo systemctl restart nix-daemon";
            nixos-upgrade= "sudo nixos-rebuild switch --upgrade";
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

			# needed for warp-terminal bug
			export WGPU_BACKEND=gl 
			            
            # Launch neofetch
            # fastfetch
            

            '';
           
    };

    # This is a workaround. By default most systems launch bash. This will make zsh start when bash is launched. Usefull if you dont have root access.
    #programs.bash.enable = true;
    #programs.bash.initExtra = ''
    #    $HOME/.nix-profile/bin/zsh
    #'';

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
