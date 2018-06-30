% Practical Vim book notes



I   [MODES](#i-modes) <br>
II  [FILES](#ii-files) <br>
III [GETTING AROUND FASTER](#iii-getting-around-faster) <br>
IV  [REGISTERS](#iv-registers) <br>
V   [PATTERNS](#v-patterns) <br>

### 1. The Vim Way 
```
Tip 1. Meet the Dot Command
Tip 2. Don’t Repeat Yourself
    set nrformats=      " will cause Vim to treat all numerals as decimal,
                        " regardless of whether they are padded with zeros.
Tip 3. Take One Step Back, Then Three Forward
Tip 4. Act, Repeat, Reverse
Tip 5. Find and Replace by Hand
Tip 6. Meet the Dot Formula
```


# I MODES

### 2. Normal Mode 
```
Tip 7. Pause with Your Brush Off the Page
Tip 8. Chunk Your Undos
Tip 9. Compose Repeatable Changes
Tip 10. Use Counts to Do Simple Arithmetic
Tip 11. Don’t Count If You Can Repeat
Tip 12. Combine and Conquer
```

### 3. Insert Mode 
```
Tip 13. Make Corrections Instantly from Insert Mode
Tip 14. Get Back to Normal Mode
Tip 15. Paste from a Register Without Leaving Insert Mode
    i<C-[>              " Like <ESC>
    i<C-O>              " Insert escape mode
                        " Make one command and go back. ex: <C-O>zz
    Maps Caps Lock to behave a ctrl in system
        See h linux.txt
Tip 16. Do Back-of-the-Envelope Calculations in Place
Tip 17. Insert Unusual Characters by Character Code
Tip 18. Insert Unusual Characters by Digraph
Tip 19. Overwrite Existing Text with Replace Mode
    gR and gr           " Treat tab as spaces
                        " of |tabstop| characters
```

### 4. Visual Mode 
```
Tip 20. Grok Visual Mode
    v_<C-g>             " Toogle visual-select mode
Tip 21. Define a Visual Selection
Tip 22. Repeat Line-Wise Visual Commands
Tip 23. Prefer Operators to Visual Commands Where Possible
    When a Visual mode command is repeated, it
    affects the same range of text (see :h visual-repeat)
Tip 24. Edit Tabular Data with Visual-Block Mode
    <C-v>jjjj
    x.....              " To delete some columns
    gv                  " Can gv a deleted <C-v>
    R|
Tip 25. Change Columns of Text
Tip 26. Append After a Ragged Visual Block
    `i` and `a` not working " They are text obj
    use `I` and `A`
```

### 5. Command-Line Mode 
```
Tip 27. Meet Vim’s Command Line
    d :[range]delete [x]      " Delete specified lines [into register x]
    y :[range]yank [x]        " Yank specified lines [into register x]
    p :[line]put [x]          " Put the text from register x after the specified line
    t :[range]copy {address}  " Copy the specified lines to below the line specified
                            " by {address}
    m :[range]move {address}  " Move the specified lines to below the line specified
                            " by {address}
    j :[range]join            " Join the specified lines
    :[range]normal {commands} " Execute Normal mode {commands} on each speci-
                              " fied line (shortcut norm)
    s :[range]substitute/{pat-tern}/{string}/[flags]
                            " Replace occurrences of {pattern} with {string} on
                            " each specified line
    g :[range]global/{pattern}/[cmd]
                            " Execute the Ex command [cmd] on all spe
    ed -> em -> en -> ex    " em = editor for mortal
    -> vi (form :visual)
    -> vim 
Tip 28. Execute a Command on One or More Consecutive Lines
Tip 29. Duplicate or Move Lines Using ‘:t’ and ‘:m’ Commands
    :/<html>/+1,/<\/html>/-1p
    `@:`                    " Repeat ex command
Tip 30. Run Normal Mode Commands Across a Range
Tip 31. Repeat the Last Ex Command
    Before executing the specified Normal mode command on each line, Vim
        moves the cursor to the beginning of the line
    :normal .               " for simple repeats or
    :normal @q              " for more complex tasks
Tip 32. Tab-Complete Your Ex Commands
    :h wildmenu
    <Tab> , <C-n> , or <Right>
    <S-Tab> , <C-p> , or <Left>
Tip 33. Insert the Current Word at the Command Prompt
    <C-r><C-w>              " copies the word under the
                            " cursor and inserts it at the command-line prompt
    <C-r><C-a>              " WORD
Tip 34. Recall Commands from History
    cnoremap <C-p> <Up>     " To filter the command histroy 
    cnoremap <C-n> <Down>   " by the prefix of cmdline
    q/
    q:
    :<C-f>

Tip 35. Run Commands in the Shell
    :h cmdline-special      " Like % for current file
    :write !sh              " Each line executed in shell
    :h reaname-files        " For and example
    !{motion}               " Go to cmdmode prepopulate with lines of motion

    :shell                  " Start a shell (return to Vim by typing exit )
    :!{cmd}                 " Execute {cmd} with the shell
    :read !{cmd}            " Execute {cmd} in the shell and insert its standard output
                            " below the cursor
    :[range]write !{cmd}    " Execute {cmd} in the shell with [range] lines as
                            " standard input
    :[range]!{filter}       " Filter the specified [range] through external program {filter}
```


# II FILES

### 6. Manage Multiple Files 
```
Tip 36. Track Open Files with the Buffer List
Tip 37. Group Buffers into a Collection with the Argument List
Tip 38. Manage Hidden Files
Tip 39. Divide Your Workspace into Split Windows
Tip 40. Organize Your Window Layouts with Tab Pages Open Files and Save Them to Disk
    {N}gt                   " goto tab N
    <C-w>T                  " window -> tab
```

### 7. Open Files and Save Them to Disk 
```
Tip 41. Open a File by Its Filepath Using ‘:edit’
Tip 42. Open a File by Its Filename Using ‘:find’
    :edit %:h<Tab>
Tip 43. Explore the File System with netrw
    <C-^>                   " Flip window to see Dir explorer (tooggle)
    ftp, scp, crul, wget supported
Tip 44. Save Files to Nonexistent Directories
    :e a/b/c/d/e/test.txt   " Create buffer, warning user
    :!mkdir -p %:h          " Create intermediate directories
    :write
Tip 45. Save a File as the Super User
```


# III GETTING AROUND FASTER

### 8. Navigate Inside Files with Motions 
```
    :h motions
Tip 46. Keep Your Fingers on the Home Row
Tip 47. Distinguish Between Real Lines and Display Lines
    the pattern: j , k , 0 , and $ all interact with real lines, while prefixing
    any of these with g tells Vim to act on display lines instead.
Tip 48. Move Word-Wise
    ea
    gea
Tip 49. Find by Character
Tip 50. Search to Navigate
Tip 51. Trace Your Selection with Precision Text Objects
Tip 52. Delete Around, or Change Inside
Tip 53. Mark Your Place and Snap Back to It
    ``      " Position before the last jump within current file
    `.      " Location of last change
    `^      " Location of last insertion
    `[      " Start of last change or yank
    `]      " End of last change or yank
    `<      " Start of last visual selection
    `>      " End of last visual selection
Tip 54. Jump Between Matching Parentheses
```

### 9. Navigate Between Files with Jumps 
```
Tip 55. Traverse the Jump List
    H / M / L Jump to top/middle/bottom of screen
Tip 56. Traverse the Change List
    g; and g,               " traverse backward and forward through the change list
    gi                      " Insert at last insertion `^i
Tip 57. Jump to the Filename Under the Cursor
    :suffixesadd            " To add a suffix vim will put to the files
                            " without suffix for gf
    :set path?              " for gf and :find
    <C-]>                   " Jump to tag
Tip 58. Snap Between Files Using Global Marks
    Try to get into a habit of setting a global mark before using any commands
    that interact with the quickfix list, such as :grep , :vimgrep , and :make
    . The same goes for the commands that interact with the buffer and
    argument lists, such as :args {arglist} and :argdo
```


# IV REGISTERS

### 10. Copy and Paste 
```
Tip 59. Delete, Yank, and Put with Vim’s Unnamed Register
    xp  " Transpose the next two characters.
Tip 60. Grok Vim’s Registers
    :delete c
    :put c
Tip 61. Replace a Visual Selection with a Register
    When we use the p command in Visual mode, Vim replaces the selection with
    the contents of the specified register
Tip 62. Paste from a Register
    {start} |I like chips and fish.
    `fc`      I like |chips and fish.
    de      I like |and fish.
    mm      I like |and fish.
    ww      I like and |fish.
    ve      I like and |fish.
    p       I like and |chips.
    `m      I like |and chips.
    P       I like fish |and chips.
    gp and gP   " leave the cursor positioned at the end of the pasted text
                " instead of at the beginning
Tip 63. Interact with the System Clipboard
    GVim is able to discern when text is pasted from the clipboard and adjust its
        behavior accordingly, but when Vim runs inside a terminal this information
        is not available. The ‘paste’ option allows us to manually warn Vim that we’re
        about to use the system paste command. When the ‘paste’ option is enabled,
        Vim turns off all Insert mode mappings and abbreviations and resets a host
        of options, including ‘autoindent’ (look up :h 'paste' for the full list).
        That allows us to safely paste from the system clipboard with no surprises. 
    Avoid Toggling ‘paste’ by Putting from the Plus Register
```

### 11. Macros 
```
Tip 64. Record and Execute a Macro
Tip 65. Normalize, Strike, Abort
    The golden rule is this: when recording a macro, ensure that every command
        is repeatable.
    Where am I, where have I come from, and where am I going?
Tip 66. Play Back with a Count
Tip 67. Repeat a Change on Contiguous Lines
    :'<,'>normal @a
Tip 68. Append Commands to a Macro
Tip 69. Act Upon a Collection of Files
    :args
    :first, :last, :prev, and :next
    :argdo normal @a
Tip 70. Evaluate an Iterator to Number Items in a List
    i<C-r>=i>CR>    " insert the value stored in variable i
Tip 71. Edit the Contents of a Macro
    The :put command, on the other hand, always pastes below the
        current line, whether the specified register contains a line-wise or a
        character-wise set of text.
    "add  " Bad: contains the new line
    "ay$  " Good: 
    :let @a=substitute(@a, '\~', 'vU', 'g')
```

# V PATTERNS

### 12. Matching Patterns and Literals 
```
Tip 72. Tune the Case Sensitivity of Search Patterns
Tip 73. Use the \v Pattern Switch for Regex Searches
Tip 74. Use the \V Literal Switch for Verbatim Searches
Tip 75. Use Parentheses to Capture Submatches
Tip 76. Stake the Boundaries of a Word
    g* and g# variants perform the same searches without word delimiters.
Tip 77. Stake the Boundaries of a Match
Tip 78. Escape Problem Characters
    When searching backward, the ? symbol acts as the search field
        terminator.  That means we don’t have to escape / characters
    call escape(@u, '/\'), which would prefix each / and \ character with a
        backslash. If we were searching backward, we could instead call
        escape(@u, '?\').
    =escape(@u, getcmdtype().'\')
```

### 13. Search 
```
Tip 79. Meet the Search Command
Tip 80. Highlight Search Matches
    :noh
    nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
Tip 81. Preview the First Match Before Execution
Tip 82. Count the Matches for the Current Pattern
    :%s///gn
Tip 83. Offset the Cursor to the End of a Search Match
    //e <CR> 
Tip 84. Operate on a Complete Search Match
Tip 85. Create Complex Patterns by Iterating upon Search History
Tip 86. Search for the Current Visual Selection
```

### 14. Substitution 
```
Tip 87. Meet the Substitute Command
Tip 88. Find and Replace Every Match in a File
Tip 89. Eyeball Each Substitution
Tip 90. Reuse the Last Search Pattern
Tip 91. Replace with the Contents of a Register
    :%s//\=@0/g
Tip 92. Repeat the Previous Substitute Command
    g& is like :%s//~/&        "Replace in all file 

    :&& The :&& command requires some explanation, since the first and second
        & symbols have different meanings. The first one forms the :& Ex
        command, which repeats the last :substitute command (see :h :& ),
        while the second one indicates that the flags from the previous :s
        command should be reused.
    :%&& = g&
    & The & command is a synonym for :s, which repeats the last
        substitution. Unfortunately, if any flags were used, the & command
        disregards them, meaning that the outcome could be quite different
        from the previous substitution.  Making & trigger the :&& command is
        more useful. It preserves flags and therefore produces more consistent
        results. These mappings fix the & command in Normal mode and create a
        Visual mode equivalent:
        nnoremap & :&&<CR>
        xnoremap & :&&<CR>
Tip 93. Rearrange CSV Fields Using Submatches
Tip 94. Perform Arithmetic on the Replacement
    :%s//\=submatch(0)-1/g
Tip 95. Swap Two or More Words
Tip 96. Find and Replace Across Multiple Files
    :args **/*.txt
    :set hidden
    :argdo %s//Practical/ge   " the e flag to the substitute command will
                              " suppress these error messages
    :vimgrep /<C-r>// **/*.txt
    The author made a vimL snippet for :quickfixdo
```vim
        command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
        function! QuickfixFilenames()
        let buffer_numbers = {}
        for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
        endfor
        return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
        endfunction
   ```
```

### 15. Global Commands 
```
Tip 97. Meet the Global Command
    :vglobal (mnemonic: invert).
Tip 98. Delete Lines Containing a Pattern
Tip 99. Collect TODO Items in a Register
Tip 100. Alphabetize the Properties of Each Rule in a CSS File
    `:g/{/sil .+1,/}/-1 >`
```

# VI TOOLS

### 16. Index and Navigate Source Code with ctags 
```
Tip 101. Meet ctags
    Keywords Are Addressed by Pattern, Not by Line Number
    The specification for the tags file format states that the address
        could be any Ex command
    ctags uses the search command to address each keyword (if you’re not
        convinced that search is an Ex command, try entering :/pattern).
Tip 102. Configure Vim to Work with ctags
    The |tags| option specifies where Vim should look to find a tags file 
    tags=./tags,tags
    With these settings, Vim looks for a tags file in the directory of the
        current file and in the working directory.
    :!ctags -R
    In “Effortless Ctags with Git,” Tim Pope demonstrates how to set up hooks
        for the post-commit , post-merge, and post-checkout events.
Tip 103. Navigate Keyword Definitions with Vim’s Tag Navigation Commands
    Also, these Ex commands can accept a regular expression when used in
            the form :tag /{pattern} or :tjump /{pattern}
    <C-]>               Jump to the first tag that matches the word under the cursor
    <C-t>
    g<C-]>              Prompt user to select from multiple matches for the word
                            under the cursor. If only one match exists, jump to it
                            without prompting.
    :tag {keyword}      Jump to the first tag that matches {keyword}
    :tjump {keyword}    Prompt user to select from multiple matches for {keyword}.
                            If only one match exists, jump to it without prompting.
    :pop or <C-t>       Reverse through tag history
    :tag                Advance through tag history
    :tnext              Jump to next matching tag
    :tprev              Jump to previous matching tag
    :tfirst             Jump to first matching tag
    :tlast              Jump to last matching tag
    :tselect            Prompt user to choose an item from the tag match list
```

### 17. Compile Code and Navigate Errors with the Quickfix List 
```
Tip 104. Compile Code Without Leaving Vim
:compiler nodelint      " Set Up ‘makeprg’ and ‘errorformat’ with a Single
                        " Command
Tip 105. Browse the Quickfix List
Tip 106. Recall Results from a Previous Quickfix List
Tip 107. Customize the External Compiler
```

### 18. Search Project-Wide with grep, vimgrep, and Others 
```
Tip 108. Call grep Without Leaving Vim
Tip 109. Customize the grep Program
Tip 110. Grep with Vim’s Internal Search Engine
    :vim[grep][!] /{pattern}/[g][j] {file} ...
    When multiple matches are on the same line, the presence of the g flag
        creates a match for each one of them. Without it, only a single record
        is created for the entire line. By default, Vim will jump straight to
        the first match, but you can prevent this by including the j flag.a
    The * wildcard will match any file in a directory. The ** wildcard matches
        any file in the specified directory or any of its subdirectories.
        Additionally, we can use the ## symbol, which is expanded to represent
        the names of each file in the argument list
```

### 19. Dial X for Autocompletion 
```
Tip 111. Meet Vim’s Keyword Autocompletion
Tip 112. Work with the Autocomplete Pop-Up Menu
    :h infercase
    <C-n>    Use the next match from the word list (next match)
    <C-p>    Use the previous match from the word list (previous match)
    <Down>   Select the next match from the word list
    <Up>     Select the previous match from the word list
    <C-y>    Accept the currently selected match (yes)
    <C-e>    Revert to the originally typed text (exit from autocompletion)
    <C-h> (and <BS>) Delete one character from current match
    <C-l>    Add one character from current match
    {char}   Stop completion and insert {char}
    <C-n><C-p> to filter to word list
Tip 113. Understand the Source of Keywords
    Vim understands the C way of including files, but it can be taught to
        follow the corresponding directives in other languages by tweaking the
        |include| setting. This should be from a plugin
    set include?
    :set complete-=i
Tip 114. Autocomplete Words from the Dictionary
Tip 115. Autocomplete Entire Lines
Tip 116. Autocomplete Filenames
    :cd -   " switches to the previous working directory
            " like in the shell   
Tip 117. Autocomplete with Context Awareness
```

### 20. Find and Fix Typos with Vim’s Spell Checker 
```
Tip 118. Spell Check Your Work
    [s      " jump backward and forward between flagged words
    ]s
    z=      " list sugested words
    zg      " Add current word to spell file
    zw      " Remove current word from spell file
    zug     " Revert zg or zw command for current word
Tip 119. Use Alternate Spelling Dictionaries
    |spellfile|
Tip 120. Add Words to the Spell File
    2zg to add it to my list of Vim terminology
    1zg to add it to the default word list.
Tip 121. Fix Spelling Errors from Insert Mode
    <C-x>s
```
