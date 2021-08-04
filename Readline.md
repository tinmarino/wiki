% Readline

# Complete

* $1 name of the command whose arguments are being completed,
* $2 word being completed
* $3 is the word preceding the word being completed

# Other

```bash
# Now useless, cares of setting at least latin-1 encoding
# French characters
stty cs8 -istrip -parenb
bind 'set convert-meta off'
bind 'set meta-flag on'
bind 'set output-meta on'
```


* <C-X><C-E> : dit current line with vim
$ echo -e "\e[?1000;1006;1015h" # Enable
$ echo -e "\e[?1000;1006;1015l" # Disable
$ bind '"\e[<":"echo totot is happy"'
$ bind -m emacs  -x '"\C-h":"echo totot is happy"'


man console_codes
echo -e "\e[?1000h" # h-> Enable = Report 
echo -e "\e[?1000l" # l-> Disable = Stop

9 -> X10 mouse reporting, for compatibility with X10's xterm, reports on button press.
1000 -> X11 mouse reporting, reports on button press and release.
1001 -> highlight reporting, useful for reporting mouse highlights.
1002 -> button movement reporting, reports movement when a button is pressed.
1003 -> all movement reporting, reports all movements.
	
1006 -> report back as decimal values (xterm, many other terminal emulators, but not urxvt)
1015 -> report back as decimal values (urxvt, xterm, other terminal emulators, some applications find it complex to parse)
1005 -> report back encoded as utf-8 (xterm, urxvt, broken in several ways)
	
bind -f ~/.inputrc
	Reload inputrc
	C-x C-f
bind -p : print current binding
bind -P : same but readable
bind -l : list acaimable functions
C-v : quoted insertion


# Mouse and xterm
echo -ne "\033[4;7H" # cursor x 4; y 7 (from left top = 1;1)


* History with the current command head
in inputrc
"\C-p": history-search-backward            # arrow up
"\C-n": history-search-forward             # arrow down
"\e[A": history-search-backward            # arrow up
"\e[B": history-search-forward             # arrow down

|              |   |
| ---          | ------------------------------------------------- |
| `<Up>`       | Previously used commands in the current session. |
| `<Down>`     |   |
| `<C-Left>`   | Jumps between arguments in the command. |
| `<C-Right>`  |   |
| `<C-A>`      | Move cursor to beginning of the current line.= |
| `<C-E>`      | Move cursor to the end of the current line. |
| `<C-U>`      | Delete all the line from the start of the line to the current cursor position. |
| `<C-H>`      | Same as backspace. |
| `<C-Z>`      | Suspends the current running command. |
| `<C-K>`      | Delete all the line from the current cursor position to end of line. |
| `<C-W>`      | Delete the word before the current cursor position. |
| `<C-D>`      | On a blank line is the same as the exit command. Otherwise, it deletes the character in front of the cursor. |
| `<C-R>`      | Search command history. |
| `<C-C>`      | Stop the current running command. |
| `<C-S-C>`    | Copy. |
| `<C-S-V>`    | Paste. |
| `<S-Insert>` |   |
| `<Tab>`      | Command completion. |

| `<A-t>` | transpose 2 words |
| `<A-b>` | Back 1 word       |
| `<A-l>` | Lower 1 word      |


From:
https://help.gnome.org/users/gnome-terminal/stable/adv-keyboard-shortcuts.html.en
http://www.catonmat.net/download/readline-emacs-editing-mode-cheat-sheet.pdf



*   CAPS -> CTRL

setxkbmap -option caps:ctrl_modifier



