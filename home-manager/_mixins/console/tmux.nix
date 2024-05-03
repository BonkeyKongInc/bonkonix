{ pkgs, darkmode, ... }: {
  programs.tmux = {
    enable = true;

    plugins = [
      pkgs.tmuxPlugins.resurrect
    ];

    # Replaces ~/.tmux.conf
    extraConfig = ''
        bind-key r source-file ~/.config/tmux/tmux.conf

        #bind -n M-h select-pane -L
        #bind -n M-l select-pane -R
        #bind -n M-k select-pane -U
        #bind -n M-j select-pane -D
        set-window-option -g mode-keys vi
        set -g base-index 1
        setw -g pane-base-index 1
        set -g status-keys vi
        set -s escape-time 0
        set -g mouse on
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        set-option -g status on
        set-option -g status-interval 1
        set-option -g status-justify left
        set-option -g status-position bottom
        set-option -g status-style fg=colour136,bg=colour235
        set-option -g status-left-length 20
        set-option -g status-left-style default
        set-option -g status-left "#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r)#[default]"
        set-option -g status-right-length 140
        set-option -g status-right-style default
        set-option -g status-right "#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) "
        set-option -ag status-right "#[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d ' ' | cut -f 1 -d ',') "
        set-option -ag status-right " #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d"
        #source "/usr/lib/python3.10/site-packages/powerline/bindings/tmux/powerline.conf"
        #source "/usr/lib/python3.11/site-packages/powerline/bindings/tmux/powerline.conf"
        #source /usr/share/powerline/bindings/tmux/powerline.conf
        # Other examples:
        # set -g @plugin 'github_username/plugin_name'
        # set -g @plugin 'github_username/plugin_name#branch'
        # set -g @plugin 'git@github.com:user/plugin'
        # set -g @plugin 'git@bitbucket.com:user/plugin'
        set -g @plugin 'tmux-plugins/tmux-resurrect'
        #run-shell ~/apps/tmux-resurrect/resurrect.tmux
        #run '~/.tmux/plugins/tpm/tpm'


    '';
  };
}
