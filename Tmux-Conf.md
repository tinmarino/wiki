# remap prefix from 'C-b' to 'C-q'
	unbind C-b
	set -g prefix C-q

# Enable mouse mode (tmux 2.1 and above)
	set -g mouse on

# split panes using | and -
	bind | split-window -h
	bind - split-window -v
	bind _ split-window -v
	unbind '"'
	unbind %

# reload config file
	bind r source-file ~/.tmux.conf

# don't rename windows automatically
	set-option -g allow-rename off

# trigger copy mode by
	bind -n M-Up copy-mode

# Do not copy selection and cancel copy mode on drag end event
# Prefer iTerm style selection: select, then mouse click to copy to buffer
unbind -T copy-mode-vi MouseDragEnd1Pane
bind -T copy-mode-vi MouseDown1Pane select-pane \;\
  send-keys -X copy-pipe "pbcopy" \;\
  send-keys -X clear-selection

# Paste with p
bind p paste-buffer
bind C-p choose-buffer

# So I don't have escape up pb on vi
set-option -s escape-time 0

# New window same path
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
