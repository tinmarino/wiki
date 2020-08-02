
# -c start-directory -n window-name
bind-key t \
    if-shell 'tmux list-windows -F "##{window_name}" | grep "TODO"' {
      select-window -t TODO
    } {
      if-shell 'tmux show-environment -g TMUX_WINDOW_TO_DO && tmux has-session -t "$TMUX_WINDOW_TO_DO" > /dev/null' {
        display-message "HAS $TMUX_WINDOW_TO_DO" ;\
        link-window -s $TMUX_WINDOW_TO_DO
      } {
        display-message "NOT" ;\
        new-window -c "$HOME/wiki/todo" -n TODO "vi -c\"call Windex(2)\"" ;\
        move-window -t 9 ;\
        run-shell "tmux set-environment -g TMUX_WINDOW_TO_DO "#S:#W""
      }
    }
