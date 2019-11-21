* [Vim Menu](Vim-Menu)

### Not clearing screen after leaving (for git diff)

By default VIM, when terminating, sends the string configured with the option t_te to the hosting terminal to tell it to clear the screen. To avoid it just :set t_te= to send nothing to the terminal and avoid screen clearing. See :help term form more information about terminal capabilities.
