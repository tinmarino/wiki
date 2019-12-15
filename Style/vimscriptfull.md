
---
version: Revision 1.1
authors: Nate Soares\
Joshua Hoak\
David Barnett\
---





This is the in-depth vimscript guide. If you\'re just a casual user
looking to write a plugin, the [abbreviated style
guide](vimscriptguide.html) is for you.

This rather rotund guide dives into justifications and clarifications.
It provides an idealized set of rules that are rather too draconian to
push on casual scripters.

It\'s for users who want to know why certain decisions were made in the
abbreviated guide and who want to learn a thing or two about using
vimscript safely.

Fair warning: Vimscript is a maddening abyss. When you gaze into it, it
gazes also into you. Proceed with caution.

Vim is highly configurable. Users can change many of the default
settings, including the case sensitivity, the regular expression rules,
the substitution rules, and more. In order for your vimscript to work
for all users, follow these guidelines:

-   Always prefix regular expressions with one of `\m`, `\v`, `\M`, or
    `\V` (prefer tersity)
    -   Users can change the global \"magic level\" of regular
        expressions. This changes how atoms are parsed in regular
        expressions, including `.`, `*`, and `{`.
    -   Even if your regular expression does not contain characters
        which are affected by the `magic` setting you must prefix it
        with one of the magic control atoms. This future-proofs your
        regular expression against other devs modifying it and
        forgetting to add the control atom.
    -   If you have no opinion about what type of regular expression to
        use, prefer the one which makes your regular expression most
        concise.
-   Avoid using `:s[ubstitute]` in scripts.
    -   `:substitute` moves the cursor.
    -   `:substitute` outputs an error message when the match does not
        exist.
    -   The meaning of the `g` flag depends upon the `gdefault` setting.
        If you do use `:substitute` you must save `gdefault`, set it to
        `0` or `1`, perform the substitution, and then restore it.
    -   Script authors who want a safe way to replace text in the buffer
        are encouraged to use `maktaba#buffer#Replace`.
-   Always use case-explicit operators for strings (`=~#` and `=~?`,
    never `=~`).
    -   This also applies to `!~ == != > >= <` and `<=`
    -   This only applies for strings. `==` and `>=` are fine for
        numbers, but `==#` and `>=#` must be used for strings.
    -   The behavior of `=~` and friends is dependant upon the
        `ignorecase` setting.
    -   You may break this rule when you explicitly want to obey the
        user\'s `ignorecase` setting. Be prepared to justify your
        reasoning.
-   When using regular expressions as arguments to functions, prepend
    them with `\c` or `\C`.
    -   This forces case to be either explicitly matched or ignored.
    -   This is recommended, but not required, when comparing regexes
        with operators that specify case sensitivity (`=~#`, etc.).
    -   This rule applies when your regexes are matching syntax,
        external APIs, external messages, and most other cases.
    -   It does not apply when matching text in the buffer. When
        matching text in the buffer you should honor the `ignorecase`
        setting.
    -   You may also ignore this rule any time that you explicitly want
        to honor the `ignorecase` setting. Be prepared to justify your
        reasoning.
-   Always use `normal!` instead of `normal`.
    -   If you forgo the `!` the command will use the user\'s key
        mappings and you have literally no idea what your macro will do.
-   Always use the `noremap` family of commands.
    -   Your plugins generally shouldn\'t introduce mappings, but if
        they do, the `map` command respects the users existing mappings
        and could do anything.
-   When using `catch`, match the error code rather than the error text.
    -   The error text may be locale-dependant.
    -   See `:help error-messages`.

In general, guard all commands and functions against user settings.

-   Line continuations: **Yes**
    -   Plugins that support vi compatibility mode must save and restore
        compatibility options as described in the **Errata section** so
        line continuations work properly.
-   Exceptions: **Yes, with caution**
    -   Always use an error code in thrown exception messages.
    -   Prefer the `maktaba#error` codes found in `maktaba`.
    -   Fall back to the vim error codes. See `:help error-messages`.
    -   Generate custom error messages using `maktaba#error#Message`.
-   Global Variables: **As configuration only**
    -   See the plugin guide.
-   Messaging: **As little as possible.**
    -   Loud scripts are annoying.
    -   Message the user when an error has occured.
    -   Message the user when an operation which takes a long time has
        begun work.
    -   Avoid messaging otherwise.
-   Type checking: **Use strict and explicit checks where possible.**
    -   Vimscript has unsafe, unintuitive behavior when dealing with
        some types. For instance, `0 == 'foo'` evaluates to true.
    -   Use strict comparison operators where possible. When comparing
        against a string literal, use the `is#` operator. Otherwise,
        prefer `maktaba#value#IsEqual` or check `type()` explicitly.
    -   Check variable types explicitly before using them. Use functions
        from `maktaba#ensure`, or check `maktaba#value` or `type()` and
        throw your own errors.
    -   Use `:unlet` for variables that may change types, particularly
        those assigned inside loops.
-   FuncRefs: **No in most cases.**
    -   FuncRefs have inconsistently enforced naming restrictions.
        (Functions can have names that FuncRefs can not.)
    -   FuncRefs have inconsistent ability to be reassigned (in Vim 7.2
        and before you must unlet a FuncRef before assigning it).
    -   In most instances where a FuncRef is needed a string works just
        as well: just pass the string that you would use to make the
        FuncRef.
    -   Consider using `maktaba#function` instead to create and
        manipulate handles to functions.
-   Python: **Sparingly**
    -   Hurts code reuse since python code embedded in python plugins is
        awkward to share between plugins.
    -   Using python introduces python language version dependencies,
        which are likely to get stale.
    -   Exception: It\'s reasonable to use python for plugin
        functionality that needs to do work in the background, as
        vimscript can not do this.
-   Ruby: **No**
    -   We can not assume ruby interoperability.
    -   You shouldn\'t depend upon the version of the ruby language that
        the user has installed.
-   Lua: **No**
    -   For the same reasons an Ruby.
-   Dict Functions: **Encouraged**
    -   Vimscript can attach functions to dictionaries. Such functions
        have access to the `self` parameter which access the dict state.
    -   Use these where you would use a class in python.
    -   Do not over-use this feature; it is not necessary for helper
        functions or API functions, only for encapsulated objects.

All other language features are fair game.

-   Provided functionality should be packed into modular plugins.
    -   Every function in your plugin should be specific to your plugin.
    -   General utility functions should be abstracted into library
        plugins.
    -   Manage dependencies with `maktaba`.
-   `plugin-names-like-this`
    -   Plugin names should be descriptive and concise.
-   Each plugin must consist of one directory (or code repository),
    sharing a name with the plugin (with a \"vim-\" prefix or \".vim\"
    suffix if desired).
-   Plugin metadata should be declared in the addon-info.json format
    (see the [VAM
    documentation](https://github.com/MarcWeber/vim-addon-manager/blob/master/doc/vim-addon-manager-additional-documentation.txt)
    for details).
-   Functions should go in the `autoload/` subdirectory of your plugin.
    -   This allows them to be late-loaded, which speeds up startup
        time.
    -   This helps vim enforce namespacing conventions.
-   Each file in the `plugin/` or `instant/` directory should begin with
    the boilerplate let \[s:plugin, s:enter\] =
    maktaba\#plugin\#Enter(expand(\'\<sfile\>:p\')) if !s:enter finish
    endif (This prevents re-entry and allows users to selectively
    disable functionality.)
-   User configuration should be via plugin flags defined in
    `instant/flags.vim`.
    -   Define flags with
        `call s:plugin.Flag('FLAGNAME', DEFAULT_VALUE)`.
    -   Users can configure these flags using the `:Glaive` command (see
        [glaive](https://github.com/google/glaive)).
-   Commands, autocommands, mappings, and settings changes should occur
    either in the `plugin/` or the `ftplugin/` subdirectories.
    -   All commands should be defined in `plugin/commands.vim` or
        `ftplugin/` files.
    -   Autocommands should be defined in `plugin/autocmds.vim`, inside
        an augroup.
    -   Mappings should be defined in `plugin/mappings.vim` and will be
        disabled unless explicitly enabled by users.
    -   If the plugin configures any standard vim settings, those should
        be configured in `plugin/settings.vim` or
        `instant/settings.vim`.
-   Avoid using the `after/` subdirectory.
    -   `after/` should be reserved for the user.
    -   It is difficult for the user to add their own overrides when
        plugins use `after/`.

Separate library-providing plugins from command-providing plugins.

Many plugins provide either user functionality (commands, autocommands,
etc) or an API (of autoloaded functions) but not both. This separation
is encouraged, as it allows other plugins to pull in a library without
also pulling in commands, setting changes, and other plugin
functionality that affects the end user.

Don\'t clobber user settings. Provide as much configurability as
possible: that\'s what Vim\'s all about.

-   Use maktaba flags for plugin configuration. Users can configure them
    using the `:Glaive` command.
-   Check if configuration variables exist before setting them. if
    !exists(\'g:myplugin\_option\') let g:myplugin\_option = 1 endif

Follow google-wide style conventions. Mimic google python style when in
doubt.

Use [vimdoc](https://github.com/google/vimdoc).

Provide help files generated by
[vimdoc](https://github.com/google/vimdoc). Write documentation in .vim
files in conformance with the vimdoc standards and include fields like
\"description\" and \"author\" in the addon-info.json file (see the [VAM
documentation](https://github.com/MarcWeber/vim-addon-manager/blob/master/doc/vim-addon-manager-additional-documentation.txt)).

Follow google-wide conventions.

-   Use two spaces for indents.
-   Do not use tabs.
-   Use spaces around operators except for arguments to commands.
    -   Using spaces around operators for commands is often invalid
        syntax. This is inconsistently enforced by vimscript. To be
        safe, always omit whitespace around arguments to commands.
    -   let s:variable = \"concatenated \" . \"strings\" command
        -range=% MyCommand let s:variable=\"concatenated \".\"strings\"
        command -range = % MyCommand
-   Do not introduce trailing whitespace.
    -   You need not go out of your way to remove it.
-   Restrict lines to 80 columns wide.
-   Indent continued lines by two tabs (four spaces).
-   Do not waste whitespace aligning common segments of similar
    commands. It is both difficult and expensive to maintain.
    -   command -bang MyCommand call myplugin\#foo() command MyCommand2
        call myplugin\#bar() command -bang MyCommand call
        myplugin\#foo() command MyCommand2 call myplugin\#bar()

```{=html}
<!-- -->
```
-   Prefer line continuations on semantic boundaries.
    -   command SomeLongCommand \\ call some\#function() command
        SomeLongCommand call \\ some\#function()
    -   Use your best judgement.
-   Place one space after the backslash denoting a line continuation.
    -   When continuing a multi-line command a pipe can be substituted
        for this space as necessary, as follows: autocommand BufEnter
        \<buffer\> \\ if !empty(s:var) \\\| call some\#function()
        \\\|else \\\| call some\#function(s:var) \\\|endif
-   Do not continue multi-line commands when you can avoid it. Prefer
    function calls.

```{=html}
<!-- -->
```
-   Place a space after the `"` before the comment text.
    -   \" I am a line comment. call call(s:my\_function)
-   Do not use inline comments.
    -   Some commands treat them as comments and others as unclosed
        quotes. There are many edge cases. It\'s difficult to get right
        and difficult to maintain.
    -   Where you would use an inline comment, put a line comment on the
        line above.
-   When leaving blank lines in comments, include the quote in the blank
    line.
    -   \" I am one continuous \" \" comment block

`plugin-names-like-this`, `FunctionNamesLikeThis`,
`CommandNamesLikeThis`, `augroup_names_like_this`,
`variable_names_like_this`.

Prefix all variables with their scope.

-   `variable_names_like_this`
    -   FuncRef variables count as functions and should be named like
        functions.
    -   This (pathological) convention is enforced by vim itself.
-   Prefix global variables with `g:`
    -   Vimscript allows you to create global variables without
        prefixing them.
    -   It is very bad practice to introduce non-prefixed global
        variables into scope.
    -   Global variables should only be used for plugin configuration.
    -   This does not apply to functions defined in `autoload`
        directories.
-   Prefix script-local variables with `s:`
    -   This prevents namespace collisions between plugins.
    -   This also applies to script-local functions.
-   Prefix function arguments with `a:`
    -   This is enforced by vim itself.
-   Prefix function-local variables with `l:`
    -   This is not enforced by vimscript but is good practice.
    -   It helps you remember that all other variables must be prefixed
        with scope.
    -   `l:` disambiguates between function-local and vim-predefined
        variables. For example, `count` refers to `v:count`, not
        `l:count`.
    -   It future proofs your scripts against the introduction of new
        vim-predefined variables.
-   Prefix pre-defined vim variables with `v:`
    -   This is not enforced by vimscript but is good practice.
    -   It provides context as to where the (undeclared) variable is
        coming from.
    -   It reminds you that the variable can not be assigned to.
-   Prefix buffer-local variables with `b:`
    -   This is useful for plugins that keep per-buffer state.

Prefer single quotes.

Prefer single quoted strings. Specifically, in order of precedence:

-   Always use single quotes for regular expressions.
    -   `'\s*'` is not the same as `"\s*"`
    -   Single quotes will prevent the need for excessive backslashes.
    -   Double single quotes escape to one single quote in single quoted
        strings: `'example ('')'` represents the string `example (')`
-   If your string requires escape characters (`\n`, `\t`, etc.) use
    double quotes.
    -   Escapes can not be expressed in single quoted strings.
    -   Remember that `'\n'` in a regex does not represent a newline,
        but rather \"\\n\". You only need to use double quotes when you
        want to embed the represented character itself (e.g. a newline)
        in the string.
-   If your string contains no escapes nor single quotes, use single
    quoted strings.
    -   Most strings in vimscript are regexes, so this provides maximum
        consistency.
-   If your non-regex string contains single quotes but no double
    quotes, use double quotes.
    -   Don\'t bother escaping strings if you don\'t have to.
    -   This is similar to the python string rules.
-   If your string contains both single and double quotes, use whichever
    quoting style requires less escaping.
    -   Break ties in favor of single quotes.

Prefer long names. Set settings locally.

-   Prefer long names of built in settings (i.e. `tabstop` over `ts`).
-   Set local settings unless you explicitly want to set global
    settings.
    -   Use `setlocal` and `&l:` instead of `set` and `&`.

Vim plugins should provide any or all of the following: **Commands,**
**Autocommands,** **Functions,** **Statusline Flags, and** **Mappings.**

-   Define in `plugin/commands.vim`.
-   CommandNamesLikeThis.
-   Prefer semantic names to a unified prefix.
-   Do not use `[!]`
-   Extract logic into functions.

```{=html}
<!-- -->
```
-   `CommandNamesLikeThis`
-   Commands should be defined in one block with no whitespace between
    them.
    -   Name commands semantically at the expense of a common prefix.
    -   command WhitespaceFixTrailing command WhitespaceFixIndentation
        command FixTrailingWhitespace command FixIndentation
-   Use `command` without a bang.
    -   This notifies users to command name conflicts immediately at
        startup.
    -   Command name collisions are an error and should not fail
        silently.
    -   Plugins are guarded against re-entry, so a single vim session
        should never attempt to re-define defined commands.
-   Do not put logic in commands.
    -   Delegate to functions instead.
    -   Pass non-argument command parameters (`<bang>`, `<register>`,
        etc.) before argument parameters (`<f-args>`, etc.).
    -   Otherwise variable-length argument functions are difficult to
        implement.
-   Do not autoload commands.
    -   Autoloaded commands will not be available until after a function
        in the same file is called.
    -   Commands intended to be used in the .vimrc should be defined in
        a `instant/commands.vim` file in plugins using maktaba, or
        explicitly installed via an autoload function in non-maktaba
        plugins.

```{=html}
<!-- -->
```
-   Pass `<bang>` to functions with `'<bang>' == '!'`.
    -   The function should receive a boolean parameter, not a string.

```{=html}
<!-- -->
```
-   Define in `plugin/autocmds.vim`.
-   Use augroups.
-   augroup\_names\_like\_this.
-   Clear the augroup first.
-   Extract logic into functions.

```{=html}
<!-- -->
```
-   All autocommands should be defined in the `plugin/autocmds.vim`
    file.
    -   This allows users to disable your autocommands with
        `Glaive myplugin !plugin[autocmds]`.
-   Declare all autocommands in an `augroup` block.
    -   This allows your autocommands to be cleared with `autocmd!`.
    -   If your plugin only has one `augroup`, the `augroup` name should
        be the same as your plugin name, with underscores in place of
        any hyphens.
    -   Otherwise `augroup` names should start with your plugin name
        followed by an underscore.
-   Do not put logic in autocommands.
    -   Delegate to functions instead.
-   When creating a new `augroup`, clear it with `autocmd!`
    -   This allows your plugins to be re-enterable.

```{=html}
<!-- -->
```
-   FunctionNamesLikeThis.
-   Autoload all functions.
-   Prefix script-local functions with `s:`
-   Use `[!]`.
-   Use `[abort]`.

```{=html}
<!-- -->
```
-   `FunctionNamesLikeThis`
-   Prefix all script-local functions with `s:`
-   Do not provide global functions. Use autoloaded functions instead.
-   Place two blank lines between top-level functions.
-   Declare all functions with `abort`.
    -   If you do not do this, the function\'s behavior depends upon
        whether it is called within a `try..endtry` block somewhere on
        the stack.
    -   The `abort` keyword forces the function to act consistently.
    -   Without it, the function may (or may not) attempt to continue
        execution after an error occurs.
-   Use `function!` with a bang.
    -   This allows developers to re-source their scripts and have the
        functions reloaded without complaint.
    -   Function names should never collide because functions should
        always be either script-local or defined in an `autoload`
        directory.
    -   Failing to use a bang in any function in an autoload file will
        lead to cryptic errors if vim tries to re-source the file (e.g.,
        if you refer to an nonexistent autoload function).
-   Use `...` for optional arguments, not for lists of arguments.
    -   Vimscript functions take at most 20 arguments.
    -   Lists have no such length restriction.
    -   Your function is likely to break when given too many arguments
        if you use `...` for a list of arguments.
-   Throw exceptions rather than printing errors.
    -   Printed errors can not be caught.
    -   Top-level functions expecting errors may catch them and print
        error messages, but even those should throw their own errors
        when they choke.

```{=html}
<!-- -->
```
-   Provide opt-in key mappings in `plugin/mappings.vim`.
-   `<Plug>` mappings can be defined in `plugin/plugs.vim` (unlike
    mappings.vim, plugs.vim is opt-out).

```{=html}
<!-- -->
```
-   Define key mappings in `plugin/mappings.vim`, using
    `maktaba#plugin#MapPrefix` to get a prefix.
    -   Mappings defined in the special `plugin/mappings.vim` file will
        be disabled by default (by the standard `maktaba#plugin#Enter()`
        boilerplate).
    -   Users can enable key mappings with
        `Glaive myplugin plugin[mappings]`.
-   Make all mappings with `<unique>`.
    -   This will inform the user when they have a mapping conflict
        instead of silently clobbering their existing mappings.
-   You may provide pseudo-mappings using `<Plug>` and your plugin\'s
    name in `plugin/plugs.vim` (separate from standard key mappings).
    -   `<Plug>` is a sequence which can not be typed.
    -   You can do something like
        `noremap <Plug>namespace#MappingName                   some_key_sequence`
        and then users can do
        `noremap <leader>x                   <Plug>namespace#MappingName`
        to take advantage of your pseudo-mapping.
    -   Pseudo-mappings should **not** be in `plugin/mappings.vim` or
        they will be disabled by default.
    -   Such pseudo-mappings should be named `<Plug>` followed by your
        plugin name, a pound sign, and a unique mapping name (CamelCased
        like a function).
-   Always use the `noremap` family of commands. Never use the `map`
    family.
    -   `map` depends upon the user\'s existing mappings, and could do
        anything.
-   Only use `noremap` for commands that both make a motion and take a
    range.
    -   `noremap` makes mappings in normal, visual, and operator-pending
        modes.
    -   If you don\'t want all these use `nnoremap` `onoremap` or
        `vnoremap` explicitly.
-   Always use `<SID>` in place of `s:` when accessing script locals in
    mappings.
    -   Using `s:` will often fail as the mapping attempts to type a
        literal s and colon.

Declare dependencies in addon-info.json and use `maktaba`.

Declaring dependencies in addon-info.json allows conformant plugin
managers (like VAM) to ensure dependencies are installed. See the [VAM
documentation](https://github.com/MarcWeber/vim-addon-manager/blob/master/doc/vim-addon-manager-additional-documentation.txt)
for details.

Calling `maktaba#library#Require` from dependent code at runtime ensures
that dependencies have been installed and that they don\'t include
unsafe non-library files.

Use `<plugin-name>#status#Status()` or its finer-grained variants to
provide statusline flags.

Following is a convention for exposing statusline flags to the user. A
plugin should never modify the user\'s statusline except for when that
is the only purpose of the plugin (powerline, etc.).

-   Provide the `Info`{.green}, `Alert`{.yellow}, `Warning`{.orange},
    and `Error`{.red} functions under the `<plugin-name>#status`
    namespace.
-   `Info`{.green} should provide information about the state of the
    buffer.
    -   Example: The current git branch.
-   `Alert`{.yellow} should provide a quiet reminder that the buffer is
    non-standard.
    -   Example: The readonly setting is on.
-   `Warning`{.orange} should provide a warning about the current state
    of the buffer.
    -   Example: The file has been edited elsewhere.
-   `Error`{.red} should bring to attention a loud issue with the
    buffer.
    -   Example: The file does not pass the syntax checker.
-   By following these conventions, users can easily build up their own
    statusline customizing the verbosity and colors to their tastes.
-   All functions should take no arguments and should return either
    empty strings or strings enclosed by square brackets, e.g.
    `[Google]`. For example:
    -   A trailing whitespace plugin might return `[$]` if the file
        contains trailing whitespace
    -   A prose writing plugin might return `[write]` if vim is in
        writing mode.
-   Consider providing the `<plugin-name>#status#Status` function.
    -   It should return the first non-empty of `Error`, `Warning`,
        `Alert`, or `Info`.
    -   This is useful for users who want only the most relevant flag
        and do not have a colored statusline.

These are commands which can only be used by a limited number of
plugins, and should not in general be used by yours.

-   Do not use `:match :2match` or `:3match`
    -   These are reserved for the user and for vim itself.
    -   Use `matchadd()` to create a matchlevel unique to your plugin.
-   Do not use `echoerr`.
    -   `echoerr` does not print the red error message that you might
        think it does.
    -   `echoerr` prints an error message as well as context about the
        code where `echoerr` was called.
    -   `echoerr` is best suited for debugging.
    -   Use `echohl` in tandem with `echomsg` if you want the red error
        bar.
-   Use `echomsg` instead of `echo`.
    -   `echomsg` messages can be reviewed with the `:messages` command.
    -   `echo` messages disappear permanently on redraw, which can be
        very annoying to users who failed to read the message in time.

Lay out `plugin/` files in the following sections, if applicable,
separated by two blank lines:

-   Declaration of script constants
-   Declaration of configuration variables
-   Other declarations (commands in `commands.vim` file, autocommands in
    `autocmds.vim` file, etc.)

Lay out `autoload/` files in the following sections, if applicable,
separated by two blank lines:

-   `maktaba#library#Require` calls
-   Script-local variables
-   Script-local functions
-   Private autoloaded functions
-   Public autoloaded functions

This is recommended convention and is not enforced.

Use the following shortcuts:

-   `catch` over `catch /.*/`
-   `return` over `return 0` when the return value has no semantic
    purpose.

This section plumbs some of the darker corners of vimscript, explaining
the language pathologies that you wish you didn\'t have to know.

If you don\'t support vi-compatibility mode, fail gracefully.

When `compatible` is set, many vim features are not available. The vim
feature which most commonly affects vimscript authors is line
continuations.

If you want your plugin to work in vim with vi compatibility on, you
will need to save the compatibility options at the beginning of each
plugin file, clear them, and restore them at the end of each plugin
file. See `:help use-cpo-save` for details.

Plugins that depend on maktaba generally don\'t need to worry about
compatible mode since maktaba currently just disables it, printing a
warning.

Revision 1.1

Nate Soares\
Joshua Hoak\
David Barnett\
