% GNU screen cheat


## Getting in test

|                  |                                              |
| ---              | ---                                          |
| screen -S <name> | start a new screen session with session name |
| screen -ls       | list running sessions/screens                |
| screen -x        | attach to a running session                  |
| screen -dRR      | the “ultimate attach”                        |

 (Attaches to a screen session.  If the session is attached elsewhere, 
detaches that other display.  If no session exists, creates one.  If 
multiple sessions exist, uses the first one.)

## Escape key

All screen commands are prefixed by an escape key, by default `C-a` (that's
Control-a, sometimes written `^a`).  To send a literal `C-a` to the programs
in screen, use `C-a a`. This is useful when working with screen within screen.
For example `C-a a n` will move screen to a new window on the screen within
screen.

## Getting out

|                |                                                            |
| ---            | ---                                                        |
| ```C-a d   ``` | Detach                                                     |
| ```C-a D D ``` | Detach and logout (quick exit)                             |
| ```C-a \   ``` | Exit screen = exit all program in screen (not recommended) |
| ```C-a C-\ ``` | Force-exit screen = not recommended                        |
| ```C-a c   ``` | Getting out of the screen session                          |

## Window management

|                       |                                      |
| ---                   | ---                                  |
| ```C-a C-a      ```   | Change to last-visited active window |
| ```C-a <n>      ```   | Change to window by number           |
| ```C-a ' <n or t> ``` | Change to window by number or name   |
| ```C-a n        ```   | Change to next window in list        |
| ```C-a p        ```   | Change to previous window in list    |
| ```C-a "        ```   | See window list                      |
| ```C-a w        ```   | Show window bar                      |
| ```C-a k        ```   | Kill current window                  |
| ```C-a \        ```   | Kill all windows                     |
| ```C-a A        ```   | Rename current window                |

## Split screen

|          |                                         |
| ---      | ---                                     |
| C-a S    | Split display horizontally              |
| C-a      | Split display vertically                |
| or C-a V | (for the vanilla vertical screen patch) |
| C-a tab  | Jump to next display region             |
| C-a X    | Remove current region                   |
| C-a Q    | Remove all regions but the current one  |

## Clipboard and navigation

|       |                          |
| ---   | ---                      |
| C-a [ | Freely navigate buffer   |
| space | Toggle selection to copy |
| C-a ] | Paste                    |

## Help

| ---   | ---      |
| C-a ? | See help |
The man page is the complete reference.

## Scripting

To any session name,
```bash
# send a command to a named session
screen -S name -X command		
# create a new window and run ping example.com
screen -S name -X screen ping example.com		
# stuff characters into the input buffer
# using bash to expand a newline character
screen -S name [-p page] -X stuff $'quit\r'		

A full example:
# run bash within screen
screen -AmdS bash_shell bash
# run top within that bash session
screen -S bash_shell -p 0 -X stuff $'top\r'
# ... some time later
# stuff 'q' to tell top to quit
screen -S bash_shell -X stuff 'q'
# stuff 'exit\n' to exit bash session
screen -S bash_shell -X stuff $'exit\r'
```

## Misc

|         |                                                    |
| ---     | ---                                                |
| C-a C-l | Redraw window                                      |
| C-a M   | Monitor window for activity                        |
| C-a _   | Monitor window for silence                         |
| C-a C-v | Enter digraph (for producing non-ASCII characters) |
| C-a x   | Lock (password protect) session                    |
| C-a :   | Enter screen command                               |
| C-a H   | Enable logging in the screen session               |

## Scrollback-buffer

In copy mode, one can navigate the scrollback buffer in various ways:

|         |                           |
| ---     | ---                       |
| C-u     | Half page up              |
| C-d     | Half page down            |
| C-b     | Back                      |
| C-f     | Forward                   |
| h/j/k/l | Cursor left/down/up/right |


from http://aperiodic.net/screen/quick_reference
