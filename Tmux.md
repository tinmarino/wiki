% Tmux : TerminalMultiplexer

# Get help

    tmux list-keys
    tmux list-commands
    tmux info
    tmux source-file ~/.tmux.conf

# Tips

tmux list-keys | grep "send-keys -X cancel"


# tmux cheat sheet

(C-x means ctrl+x, M-x means alt+x)


## Prefix key

The default prefix is C-b. If you (or your muscle memory) prefer C-a, you need to add this to `~/.tmux.conf`:

    # remap prefix to Control + a
    set -g prefix C-a
    # bind 'C-a C-a' to type 'C-a'
    bind C-a send-prefix
    unbind C-b

I'm going to assume that C-a is your prefix.


## Sessions, windows, panes

Session is a set of windows, plus a notion of which window is current.

Window is a single screen covered with panes. (Once might compare it to a ‘virtual desktop’ or a ‘space’.)

Pane is a rectangular part of a window that runs a specific command, e.g. a shell.


## Getting help

Display a list of keyboard shortcuts:

    C-a ?

Navigate using Vim or Emacs shortcuts, depending on the value of `mode-keys`. Emacs is the default, and if you want Vim shortcuts for help and copy modes (e.g. j, k, C-u, C-d), add the following line to `~/.tmux.conf`:

    setw -g mode-keys vi

Any command mentioned in this list can be executed as `tmux something` or `C-a :something` (or added to `~/.tmux.conf`).


## Managing sessions

Creating a session:

    tmux new-session -s work

Create a new session that shares all windows with an existing session, but has its own separate notion of which window is current:

    tmux new-session -s work2 -t work

Attach to a session:

    tmux attach -t work

Detach from a session: `C-a d`.

Switch between sessions:

    C-a (          previous session
    C-a )          next session
    C-a L          ‘last’ (previously used) session
    C-a s          choose a session from a list

Other:

    C-a $          rename the current session
    C-a


## Managing windows

Create a window:

    C-a c          create a new window

Switch between windows:

    C-a 1 ...      switch to window 1, ..., 9, 0
    C-a 9
    C-a 0
    C-a p          previous window
    C-a n          next window
    C-a l          ‘last’ (previously used) window
    C-a w          choose window from a list

Switch between windows with a twist:

    C-a M-n        next window with a bell, activity or
                   content alert
    C-a M-p        previous such window


Other:

    C-a ,          rename the current window
    C-a &          kill the current window


## Managing split panes

Creating a new pane by splitting an existing one:

    C-a "          split vertically (top/bottom)
    C-a %          split horizontally (left/right)

Switching between panes:

    C-a left       go to the next pane on the left
    C-a right      (or one of these other directions)
    C-a up
    C-a down
    C-a o          go to the next pane (cycle through all of them)
    C-a ;          go to the ‘last’ (previously used) pane

Moving panes around:

    C-a {          move the current pane to the previous position
    C-a }          move the current pane to the next position
    C-a C-o        rotate window ‘up’ (i.e. move all panes)
    C-a M-o        rotate window ‘down’
    C-a !          move the current pane into a new separate
                   window (‘break pane’)
    C-a :move-pane -t :3.2
                   split window 3's pane 2 and move the current pane there

Resizing panes:

    C-a M-up, C-a M-down, C-a M-left, C-a M-right
                   resize by 5 rows/columns
    C-a C-up, C-a C-down, C-a C-left, C-a C-right
                   resize by 1 row/column

Applying predefined layouts:

    C-a M-1        switch to even-horizontal layout
    C-a M-2        switch to even-vertical layout
    C-a M-3        switch to main-horizontal layout
    C-a M-4        switch to main-vertical layout
    C-a M-5        switch to tiled layout
    C-a space      switch to the next layout


Other:

    C-a x          kill the current pane
    C-a q          display pane numbers for a short while


## Other config file settings

Force a reload of the config file on C-a r:

    unbind r
    bind r source-file ~/.tmux.conf

Some other settings that I use:

    setw -g xterm-keys on
		
		
### .tmux.conf
set-option -g allow-rename off
set -g status-bg cyan
set-option -g prefix C-a
unbind C-b 

### key bindings
tmux may be controlled from an attached client by using a key combination of a prefix key, ‘C-b’ (Ctrl-b) by default, followed by a command key.

* ? List all key bindings.
---
* tmux new -s name_instance --> new session called “name_instance”.
* d detach from the tmux session.
* tmux ls --> list existing tmux sessions.
* tmux new -s name_instance_two -d --> new session instance in the background.
* tmux attach --> if we only have one session running.
* tmux attach -t name_instance--> attach to the session name_instance.
* tmux kill-session -t name_instance --> killing sessions
---
* [ enter copy mode and move the cursor to where we want to start selecting text.
* SPACE and move the cursor to the end of the text and press ENTER (the selected text gets copied into a paste buffer)
* ] paste the contents we just capture (the current buffer)
* = Lists all paste buffers and pastes selected buffer contents
* h , j , k , and l Moves the cursor left, down, up, and right respectively.
* w Moves the cursor forward one word at a time.
* b Moves the cursor backward one word at a time.
* f followed by any character Moves to the next occurrence of the specified character.
* F followed by any character Moves to the previous occurrence of the specified character.
* CTRL - b Scrolls up one page.
* CTRL - f Scrolls down one page.
* g Jumps to the top of the buffer.
* G Jumps to the bottom of the buffer.
* ? Starts a search backward through the buffer.
* / Starts a search forward through the buffer.
---
* " Split the current pane into two, top and bottom.
* % Split the current pane into two, left and right.
* o Select the next pane in the current window.
* x Kill the current pane.
* C-o Rotate the panes in the current window forwards.
* ! Break the current pane out of the window.
* ; Move to the previously active pane.
* q Briefly display pane indexes.
* { Swap the current pane with the previous pane.
* } Swap the current pane with the next pane.
---
* $ Rename the current session.
* tmux new -s \<session-name> (if you get some error related to $TMUX us this command - TMUX= tmux new-session -s \<session-name>)
* d Detach from the current session.
* tmux list-sessions | tmux ls
* tmux attach -t \<session-name> re-attach a session
* tmux kill-session -t \<session-name>
---
* c Create a new window.
* , Rename the current window.
* w Choose from a list of windows interactively.
* l Move to the previously selected window.
* n Change to the next window.
* p Change to the previous window.
* & Kill the current window.
* ' Prompt for a window index to select.
* f Prompt to search for text in open windows.
* i Display some information about the current window.
* 0 to 9 Select windows 0 to 9.
---
* : Enter the tmux command prompt.
* C-b Send the prefix key (C-b) through to the application.
* C-z Suspend the tmux client.
* \# List all paste buffers.
* ( Switch the attached client to the previous session.
* ) Switch the attached client to the next session.
* \- Delete the most recently copied buffer of text.
* . Prompt for an index to move the current window.
* = Choose which buffer to paste interactively from a list.
* D Choose a client to detach.
* L Switch the attached client back to the last session.
* [ Enter copy mode to copy text or view the history.
* ] Paste the most recently copied buffer of text.
* r Force redraw of the attached client.
* m Mark the current pane (see select-pane -m).
* M Clear the marked pane.
* s Select a new session for the attached client interactively.
* t Show the time.
* z Toggle zoom state of the current pane.
* ~ Show previous messages from tmux, if any.
* Page Up Enter copy mode and scroll one page up.
* Up, Down, Left, Right Change to the pane above, below, to the left, or to the right of the current pane.
* M-1 to M-5 Arrange panes in one of the five preset layouts: even-horizontal, even-vertical, main-horizontal, main-vertical, or tiled.
* Space Arrange the current window in the next preset layout.
* M-n Move to the next window with a bell or activity marker.
* M-o Rotate the panes in the current window backwards.
* M-p Move to the previous window with a bell or activity marker.
* C-Up, C-Down, C-Left, C-Right Resize the current pane in steps of one cell.
* M-Up, M-Down, M-Left, M-Right Resize the current pane in steps of five cells.

Key bindings may be changed with the bind-key and unbind-key commands.
>>>>>>> Content
