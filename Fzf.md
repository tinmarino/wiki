Cache filesystem
https://unix.stackexchange.com/questions/78726/find-ls-caching
  
# CTRL-J / CTRL-K (or CTRL-N / CTRL-P) to move cursor up and down
# Enter key to select the item, CTRL-C / CTRL-G / ESC to exit
# On multi-select mode (-m), TAB and Shift-TAB to mark multiple items
# Emacs style key bindings
# Mouse: scroll, click, double-click; shift-click and shift-scroll on multi-select mode

* forgit_log=glo
* forgit_diff=gd
* forgit_add=ga
* forgit_reset_head=grh
* forgit_ignore=gi
* forgit_restore=gcf
* forgit_clean=gclean
* forgit_stash_show=gss

```sh
set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden'
```
