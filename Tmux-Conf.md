

# Selection (keep)
  # disable "release mouse drag to copy and exit copy-mode", ref: https://github.com/tmux/tmux/issues/140
  unbind-key -T copy-mode-vi MouseDragEnd1Pane
  
  # since MouseDragEnd1Pane neither exit copy-mode nor clear selection now,
  # let single click do selection clearing for us.
  bind-key -T copy-mode-vi MouseDown1Pane select-pane\; send-keys -X clear-selection
  
  # this line changes the default binding of MouseDrag1Pane, the only difference
  # is that we use `copy-mode -eM` instead of `copy-mode -M`, so that WheelDownPane
  # can trigger copy-mode to exit when copy-mode is entered by MouseDrag1Pane
  bind -n MouseDrag1Pane if -Ft= '#{mouse_any_flag}' 'if -Ft= \"#{pane_in_mode}\" \"copy-mode -eM\" \"send-keys -M\"' 'copy-mode -eM'

# Interact with system clipboard
  set -g set-clipboard on
  bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xsel -i --clipboard"
  bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xsel -i --clipboard"

# history limit, scrool back buffer
  set-option -g history-limit 50000
  If a "line" really is just the characters within it, then we can assume 128 bytes is a reasonable line size in memory. If I'm willing to commit 32 MB to scroll back for a single pane (which suits me, I don't use many panes), then I could increase my history limit to roughly 2 ** (25 - 7) = 256K or 250 thousand lines

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
