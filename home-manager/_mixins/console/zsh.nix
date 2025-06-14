{ pkgs, desktop, darkmode, ... }:
let
  get_xterm_export = _desktop:
    if desktop == null then ''export TERM=xterm-256color'' else '''';

  fzf_light_mode_theme = ''
    export FZF_DEFAULT_OPTS="--color=light"
  '';
  fzf_dark_mode_theme = ''
    export FZF_DEFAULT_OPTS=" \
      --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
      --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
      --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
  '';
  fzf_theme = if darkmode then fzf_dark_mode_theme else fzf_light_mode_theme;

  ls_colors_bright_mode_hack =
    if darkmode then ""
    else ''
      # ls_colors_bright_mode_hack
      export LS_COLORS='fi=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:'
      LS_COLORS+='pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32'
      export LSCOLORS='ExGxDxDxCxDxDxFxFxexEx'
      zstyle ':completion:*' list-colors '=(#b)(--[^ ]#)(*)=38;5;220;1=38;5;216'
    '';

in
{
  home = {
    packages = with pkgs; [
      zsh-fzf-tab
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-z
    ];

  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "history-substring-search"
        "last-working-dir"
      ];
    };
    initExtra = ''
      alias ws="cd ~/dev/"
      alias c="cd"
      alias ..="cd .."
      alias v="nvim"
      alias v.="nvim ."
      alias l="exa -la --git --icons"
      alias cat='bat'
      alias less='bat'
      alias sysc="sudo systemctl"
      alias ff="find . -name"
      alias r2c="r2 -e asm.cpu=cortex"
      alias rgi="rg --no-ignore --iglob !tags "
      alias sshno='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

      alias rr="rax2 -r"

      alias markdown_preview="grip -b"

      alias tm='tmux'
      # PX4 aliases
      alias buildpx4="./Tools/docker_run.sh 'make px4_fmu-v5_multicopter'"
      alias buildpx4_x1="./Tools/docker_run.sh 'make cubepilot_cubeorange_default'"
      alias buildpx4io="./Tools/docker_run.sh 'make px4io_update'"
      alias buildpx4all="./Tools/docker_run.sh 'make px4io_update' && ./Tools/docker_run.sh 'make px4_fmu-v5_multicopter'"
      alias loadpx4="./Tools/px_uploader.py build/px4_fmu-v5_multicopter/px4_fmu-v5_multicopter.px4 --port /dev/ttyACM0"
      alias loadpx4_x1="./Tools/px_uploader.py build/cubepilot_cubeorange_default/cubepilot_cubeorange_default.px4 --port /dev/ttyACM0"
      alias pidgains='python ~/dev/tool_pid_summarizer/main.py'
      alias pj='~/apps/PlotJuggler/build/bin/plotjuggler'
      alias autlog="cd ~/dev/AirolitUlogTool/ && .venv/bin/python main.py"
      alias mavsh='~/dev/px4_logger_tester/.venv/bin/python ~/dev/px4_logger_tester/mavlink_shell.py'

      alias pvenv="./.venv/bin/python"
      alias nv.="nvim ."
      alias bp='btop'

      # NIX aliases
      alias ns='nix-shell --command "zsh"'
      alias nd='nix develop'

      # GIT aliases
      alias gka="gitk --all &"
      alias gito="git log --oneline --graph --color --all --decorate --pretty"
      alias gltags="git tag --merged HEAD --sort=-taggerdate"
      alias gitol="git log --oneline --graph --color --ancestry-path=HEAD --decorate --pretty"
      alias lasttag='git describe --tags --abbrev=0'
      alias gs="git status"
      alias gc="git commit -m"
      alias gsd="git diff --submodule=diff | v -c 'set ft=diff' -c 'set buftype=nofile'"
      alias gre="git restore"

      #Kicad alias
      alias makekicad="python ~/dev/AirolitKicadProjectGenerator/generate.py"

      bindkey -v
      # bindkey ii vi-cmd-mode
      # Appends every command to the history file once it is executed
      setopt inc_append_history
      # Taking care of history
      setopt share_history

      setopt EXTENDED_HISTORY
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_SPACE
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_BEEP

      # Accpept suggestions with space
      bindkey '^ ' forward-word 
      bindkey '^o' autosuggest-accept
      bindkey '^H' backward-kill-word
      # Reloads the history whenever you use it
      setopt share_history

      # fzf keybindings
      # fd - cd to selected directory
      fzvv() {
          local file
          file=$(rg --files --no-ignore | fzf)
          if [ -f $file ]; then
            print -s "nvim $file"
            fc -R =(print "nvim $file")
            nvim "$file"
          fi
      }

      fzkk() {
        zle -I  # Clear ZLE input buffer

        vared -p 'What would you like to do?: ' -c tmp

        local path="dev"
        case "$options" in
          h) path="" ;;
          w) path="Downloads" ;;
        esac
        echo "this is my tmp $tmp"
        # Use fzf with explicit input/output from the TTY
        local file
        file=$(rg --files --no-ignore --no-messages "$HOME/$path" 2>/dev/null | fzf --height=40% < /dev/tty > /dev/tty)

        if [[ -n "$file" && -f "$file" ]]; then
          echo "Opening: $file" > /dev/tty
          xdg-open "$file"
        fi

        zle reset-prompt  # Fix terminal prompt issues
      }
     fzkk-widget() {
        zle -I                      # clear terminal input buffer
        fzkk                        # run the actual function
        zle reset-prompt            # redraw prompt so terminal works cleanly
      }

      fdd() {
        local dir
          dir=$(find ''${1:-.} -path '*/\.*' -prune \
                          -o -type d -print 2> /dev/null | fzf +m --header="$2") 
          echo "$dir"
      }
      fzf_cd() {
        dir=$(fdd / "Go to dir")
        if [[ -n $dir && -d $dir ]]; then
          cd $dir
        fi
      }
      fzf_prog() {
        compgen -c | grep -E '^[a-zA-Z]' | grep -v '[.:]' | sort -u | fzf --header=$1
      }
      fzf_file() {
        file=$(rg --files --no-ignore --no-messages $1| \
        fzf --header="Searching for file in $1 " \
        --with-nth=4.. --delimiter=/)
        echo $file
      }
      fzf_nvim() {
        local base_dir
        local file
        local count=0

        base_dir=$(fdd "/home/patrik/" "Choose base dir")
        if [[ -z $base_dir ]]; then
          return
        fi
        file=$(fzf_file $base_dir)
        if [[ -n "$file" && -f "$file" ]]; then
          local mimetype
          mimetype=$(xdg-mime query filetype "$file")
          local app
          if [[ -z mimetype ]]; then
            app=$(fzf_prog "File has no associated app")
          else 
            local default_app
            default_app=$(xdg-mime query default "$mimetype")
              if [[ -n "$default_app" ]]; then
                if [[ "$default_app" == *neovim* ]]; then
                  nvim $file
                else
                  xdg-open "$file" 
                fi
              else
                app=$(fzf_prog "File has no associated app")
              fi
          fi
          if [[ -n $app ]]; then
            $app $file
          fi
        fi
        if [[ -z $file ]]; then
          app=$(fzf_prog "Choose app to open with and reselect file?")
          if [[ -n $app ]]; then
            file=$(fzf_file $base_dir "to open with $app")
            if [[ -n $file ]]; then
              $app $file
            fi
            
          fi
        fi

        #zle reset-prompt            # redraw prompt so terminal works cleanly

      }

      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi
      jlc2sym() {
        easyeda2kicad --full --lcsc_id=$1 --output="$PWD/airolit_eda_library/kicad/airolit"
      }


      zle -N gcam_bind
      zle -N fdd
      zle -N fzf_nvim
      zle -N fzkk
      zle -N fzf_cd
      bindkey "^S" gcam_bind
      bindkey "^T" fzvv
      bindkey "^A" fzf_nvim
      bindkey '^G' fzf_cd
      bindkey '^F' fzf-file-widget
      bindkey "^P" up-line-or-search
      bindkey "^N" down-line-or-search
      #bindkey -s "^M" '\e' 

      mkdir -p ~/.history
      # Patch history to a shared directory
      HISTFILE=~/.history/.zsh_history

      # armcompiler6 gdb helper
      function axf_dbg()
      {
          gdb_cmd="gdb-multiarch -ex 'target remote localhost:2331'"
          hex_file=''${1%.*}.hex
          gdb_cmd="$gdb_cmd -ex 'set confirm off'"
          gdb_cmd="$gdb_cmd -ex 'load'"
          gdb_cmd="$gdb_cmd -ex 'monitor SWO EnableTarget 120000000 6000000 1 0'"
          gdb_cmd="$gdb_cmd -ex 'monitor reset'"
          gdb_cmd="$gdb_cmd -ex 'add-symbol-file $1'"
          gdb_cmd="$gdb_cmd -ex 'set \$pc=&Reset_Handler'"
          gdb_cmd="$gdb_cmd -ex 'c'"
          gdb_cmd="$gdb_cmd $hex_file"
          # Start gdb
          eval ''${gdb_cmd}
      }

      # "docker build"
      function db()
      {
          docker_image=$1
          shift
          dcmd="docker run --rm --user 1000:1000 --privileged \
              -w /workspace -v $PWD:/workspace \
              $docker_image /bin/sh -c \"$@\""
          eval ''${dcmd}
      }

      # start working in a docker container
      function ds()
      {
          docker_image=$1
          dcmd="docker run --rm -it \
          --group-add $(stat -c '%g' /var/run/docker.sock) \
          -v /home/ripxorip/dev/workspace:/home/ripxorip/dev/workspace \
          -v /var/run/docker.sock:/var/run/docker.sock \
          -v /home/ripxorip/.history:/home/ripxorip/.history \
          --privileged=true --name $1 \
          $docker_image \
          /bin/zsh -c \
          \"cd ~/.dot && git pull && \
          cd ~/dev/wiki && git pull && \
          cd ~/dev/workspace && \
          /bin/zsh\""
          eval ''${dcmd}
      }

      function stfu()
      {
          "$@" &> /dev/null < /dev/null &
      }

      function ulg2pile() 
      {
        nix develop ~/dev/ulog2param -c bash -c "ulog_params "$1" > params_temp && python ~/dev/ulog2param/patch_params.py params_temp > $(basename "$1" | sed 's/ulg/params/') │  && rm params_temp"
      }

      function gkr()
      {
        gitk --remotes="$1" &
      }

      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

      export PICO_SDK_PATH=~/dev/pico-sdk

      ${fzf_theme}
      ${ls_colors_bright_mode_hack}

      source ~/.nix-profile/share/fzf-tab/fzf-tab.plugin.zsh
      source ~/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ~/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ~/.nix-profile/share/zsh-z/zsh-z.plugin.zsh

      ${get_xterm_export(desktop)}
      eval "$(starship init zsh)"
    '';
  };
}
