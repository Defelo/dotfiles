# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# reload config file (change file location to your the tmux.conf you want to use)
bind r source-file ~/.tmux.conf

# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# switch panes using Ctrl-vimarrow without prefix
bind -n C-h select-pane -L
bind -n C-l select-pane -R
bind -n C-k select-pane -U
bind -n C-j select-pane -D

# don't rename windows automatically
set-option -g allow-rename off

set -g default-terminal "screen-256color"

# copy to system clipboard
#bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
