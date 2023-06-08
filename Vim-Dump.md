From deleted copy_tmux.sh

```vim
#!/usr/bin/env bash
# Yank here or in ssh section inteligently
#
# From: https://github.com/samoshkin/tmux-config/blob/master/tmux/yank.sh
# Blog: https://medium.com/hackernoon/tmux-in-practice-copy-text-from-remote-session-using-ssh-remote-tunnel-and-systemd-service-dd3c51bca1fa

_copy_to_terminal.sh "$@"
exit 0


################################################
#     THE END                                  #
#                                              #
# This is not executed, seems overkill for now #
################################################



is_app_installed() {
  type "$1" &>/dev/null
}

# get data either form stdin or from file
buf=$(cat "$@")

# Get some info
copy_backend_remote_tunnel_port=$(tmux show-option -gvq "@copy_backend_remote_tunnel_port")
copy_use_osc52_fallback=$(tmux show-option -gvq "@copy_use_osc52_fallback")

# Resolve copy backend: pbcopy (OSX), reattach-to-user-namespace (OSX), xclip/xsel (Linux)
copy_backend=""
if [ -n "${copy_backend_remote_tunnel_port-}" ] \
    && (netstat -f inet -nl 2>/dev/null || netstat -4 -nl 2>/dev/null) \
      | grep -q "[.:]$copy_backend_remote_tunnel_port"; then
  copy_backend="nc localhost $copy_backend_remote_tunnel_port"
elif is_app_installed pbcopy; then
  copy_backend="pbcopy"
elif is_app_installed reattach-to-user-namespace; then
  copy_backend="reattach-to-user-namespace pbcopy"
elif [ -n "${DISPLAY-}" ] && is_app_installed xsel; then
  copy_backend="xsel -i --clipboard"
elif [ -n "${DISPLAY-}" ] && is_app_installed xclip; then
  copy_backend="xclip -i -f -selection primary | xclip -i -selection clipboard"
fi
#echo "Port $copy_backend_remote_tunnel_port"
#echo "Backend $copy_backend"

# if copy backend is resolved, copy and exit
if [ -n "$copy_backend" ]; then
  printf "%s" "$buf" | eval "$copy_backend"
  exit;
fi


# If no copy backends were eligible, decide to fallback to OSC 52 escape sequences
# Note, most terminals do not handle OSC
if [ "$copy_use_osc52_fallback" == "off" ]; then
  exit;
fi

#resolve target terminal to send escape sequence
#if we are on remote machine, send directly to SSH_TTY to transport escape sequence
#to terminal on local machine, so data lands in clipboard on our local machine
pane_active_tty=$(tmux list-panes -F "#{pane_active} #{pane_tty}" | awk '$1=="1" { print $2 }')
target_tty="${SSH_TTY:-$pane_active_tty}"
```







---

"~/wiki/wiki/Vim-Trash.md" [New]
Error detected while processing function vimwiki#base#follow_link[83]..vimwiki#base#open_link[35]..vimwiki#base#edit_file[35]..function vimwiki#base#follow
_link[83]..vimwiki#base#open_link[35]..vimwiki#base#edit_file[23]..BufNewFile Autocommands for "*.md"..function <SNR>27_setup_new_wiki_buffer[19]..vimwiki#
u#ft_set[9]..FileType Autocommands for "*"..Syntax Autocommands for "*"..function <SNR>9_SynSet[25]..script /home/mtourneb/.vim/pack/bundle/opt/wiki/syntax
/vimwiki.vim[514]..function vimwiki#base#nested_syntax[26]..script /home/mtourneb/.vim/syntax/sh.vim[24]../home/mtourneb/.vim/pack/bundle/opt/wiki/syntax/v
imwiki.vim[514]..function vimwiki#base#nested_syntax[26]..script /usr/local/share/vim/vim90/syntax/vim.vim:
line  848:
E403: syntax sync: Line continuations pattern specified twice
Press ENTER or type command to continue
