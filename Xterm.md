# Interface
 Ctrl key and right click button


Install the xorg-xrdb package. 

xrdb -query -all
xrdb -merge ~/.Xresources

# Escape

* Copy to clipboard: `printf '\e]52;c;%s\007' $(printf 'test 3' | base64)`
  * With mux: set -g set-clipboard on
* enable windows operation: `echo VT100.allowWindowOps: true | xrdb -merge`
* resize (line,col): `printf '\e[8;50;100t'`
* move to top left: `printf '\e[3;0;0t'`
* zoom: `printf '\e[9;1t'`
* to front: `printf '\e[5t'`
* Color: 	`echo -e "Default \e[33mYellow\e[0mnormal"`

```
echo -e "\e[30mBlack"
echo -e "\e[31mRed"
echo -e "\e[32mGreen"
echo -e "\e[33mYellow"
echo -e "\e[34mBlue"
echo -e "\e[35mMagenta"
echo -e "\e[36mCyan"
echo -e "\e[37mLight gray"
echo -e "\e[39mDefault"
echo -e "\e[90mDark gray"
echo -e "\e[91mLight red"
echo -e "\e[92mLight green"
echo -e "\e[93mLight yellow"
echo -e "\e[94mLight blue"
echo -e "\e[95mLight magenta"
echo -e "\e[96mLight cyan"
echo -e "\e[97mWhite"
```

From: https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
```
╔══════════╦════════════════════════════════╦═════════════════════════════════════════════════════════════════════════╗
║  Code    ║             Effect             ║                                   Note                                  ║
╠══════════╬════════════════════════════════╬═════════════════════════════════════════════════════════════════════════╣
║ 0        ║  Reset / Normal                ║  all attributes off                                                     ║
║ 1        ║  Bold or increased intensity   ║                                                                         ║
║ 2        ║  Faint (decreased intensity)   ║  Not widely supported.                                                  ║
║ 3        ║  Italic                        ║  Not widely supported. Sometimes treated as inverse.                    ║
║ 4        ║  Underline                     ║                                                                         ║
║ 5        ║  Slow Blink                    ║  less than 150 per minute                                               ║
║ 6        ║  Rapid Blink                   ║  MS-DOS ANSI.SYS; 150+ per minute; not widely supported                 ║
║ 7        ║  [[reverse video]]             ║  swap foreground and background colors                                  ║
║ 8        ║  Conceal                       ║  Not widely supported.                                                  ║
║ 9        ║  Crossed-out                   ║  Characters legible, but marked for deletion.  Not widely supported.    ║
║ 10       ║  Primary(default) font         ║                                                                         ║
║ 11–19    ║  Alternate font                ║  Select alternate font `n-10`                                           ║
║ 20       ║  Fraktur                       ║  hardly ever supported                                                  ║
║ 21       ║  Bold off or Double Underline  ║  Bold off not widely supported; double underline hardly ever supported. ║
║ 22       ║  Normal color or intensity     ║  Neither bold nor faint                                                 ║
║ 23       ║  Not italic, not Fraktur       ║                                                                         ║
║ 24       ║  Underline off                 ║  Not singly or doubly underlined                                        ║
║ 25       ║  Blink off                     ║                                                                         ║
║ 27       ║  Inverse off                   ║                                                                         ║
║ 28       ║  Reveal                        ║  conceal off                                                            ║
║ 29       ║  Not crossed out               ║                                                                         ║
║ 30–37    ║  Set foreground color          ║  See color table below                                                  ║
║ 38       ║  Set foreground color          ║  Next arguments are `5;<n>` or `2;<r>;<g>;<b>`, see below               ║
║ 39       ║  Default foreground color      ║  implementation defined (according to standard)                         ║
║ 40–47    ║  Set background color          ║  See color table below                                                  ║
║ 48       ║  Set background color          ║  Next arguments are `5;<n>` or `2;<r>;<g>;<b>`, see below               ║
║ 49       ║  Default background color      ║  implementation defined (according to standard)                         ║
║ 51       ║  Framed                        ║                                                                         ║
║ 52       ║  Encircled                     ║                                                                         ║
║ 53       ║  Overlined                     ║                                                                         ║
║ 54       ║  Not framed or encircled       ║                                                                         ║
║ 55       ║  Not overlined                 ║                                                                         ║
║ 60       ║  ideogram underline            ║  hardly ever supported                                                  ║
║ 61       ║  ideogram double underline     ║  hardly ever supported                                                  ║
║ 62       ║  ideogram overline             ║  hardly ever supported                                                  ║
║ 63       ║  ideogram double overline      ║  hardly ever supported                                                  ║
║ 64       ║  ideogram stress marking       ║  hardly ever supported                                                  ║
║ 65       ║  ideogram attributes off       ║  reset the effects of all of 60-64                                      ║
║ 90–97    ║  Set bright foreground color   ║  aixterm (not in standard)                                              ║
║ 100–107  ║  Set bright background color   ║  aixterm (not in standard)                                              ║
╚══════════╩════════════════════════════════╩═════════════════════════════════════════════════════════════════════════╝
```

## Send to other

echo -en "\e]11;red\a" > /dev/pts/23

get the 23 with command
1. ps (desired shell)
2. who (other shell)


* ~.Xdefaults, ~/.Xresources, /etc/X11/app-defaults/XTerm 


## defautl conf

```conf
xterm*VT100.geometry:     80x25
xterm*faceName:           Courier:style=Regular:size=10
xterm*dynamicColors:      true
xterm*utf8:               2
xterm*eightBitInput:      true
xterm*saveLines:          512
xterm*scrollKey:          true
xterm*scrollTtyOutput:    false
xterm*scrollBar:          true
xterm*rightScrollBar:     true
xterm*jumpScroll:         true
xterm*multiScroll:        true
xterm*toolBar:            false
```

## Wonderfull conf

```conf
! From https://www.computerhope.com/unix/uxrdb.htm
*dialog*value*background: white
*Dialog*Label*font:    -adobe-helvetica-bold-r-*-*-12-*-*-*-*-*-*-*
*MenuButton*font:      -adobe-helvetica-medium-r-*-*-12-*-*-*-*-*-*-*
*MenuButton*background:        grey80
*MenuButton*foreground:        black
*Label.font:           -adobe-helvetica-medium-r-*-*-10-*-*-*-*-*-*-*
*Label*shadowWidth:    1
*SmeBSB.font:          -adobe-helvetica-bold-r-*-*-12-*-*-*-*-*-*-*
*SimpleMenu*font:      -adobe-helvetica-medium-r-*-*-10-*-*-*-*-*-*-*
*OptionMenu*font:      -adobe-helvetica-medium-r-*-*-10-*-*-*-*-*-*-*
*Command.font:         -linotype-helvetica-bold-r-narrow-*-12-*-*-*-*-*-*-*
*Toggle.font:          -adobe-helvetica-bold-o-*-*-12-*-*-*-*-*-*-*
*Form.background:      grey70
*TransientShell*Dialog.background: grey70
*Scrollbar.Foreground: grey80
*Scrollbar.Background: grey50
*Scrollbar*cursorName: top_left_arrow
*Scrollbar*width:      16
*shapeStyle:           Rectangle
*XlwMenu.shadowThickness: 1
*shadowWidth:          1
xterm*scrollbar.background: grey40
xterm*foreground: grey90
xterm*background: grey25
xterm*cursorColor: white
xterm*visualbell: on
rxvt*color12: steelblue
rxvt*color15: white
rxvt*color9: rgb:ff/7f/5f
rxvt*foreground: grey90
rxvt*background: grey10
rxvt*cursorColor: white
rxvt*font: lucidasanstypewriter-12
rxvt*loginShell: false
rxvt*saveLines: 1024
rxvt*title: shell
rxvt*geometry: 80x2
xman*topBox: false
xman*background: lightsteelblue
xman*foreground: black
xcalc*Command.font: -adobe-helvetica-bold-r-*-*-10-*-*-*-*-*-*-*
xcalc*customization: -color
```

## Exmple dump

```conf
*VT100.allowWindowOps: true
*VT100.allowTitleOps: true
*VT100.allowFontOps: true

*vt100.allowWindowOps: true
*vt100.allowTitleOps: true
*vt100.allowFontOps: true

xterm*VT100*geometry: 94x28
xterm*font: -misc-fixed-medium-r-normal--20-200-75-75-c-100-iso8859-1
xterm*background: black
xterm*foreground: lightblue
xterm*loginShell: true
xterm*scrollBar: true
xterm*rightScrollBar: true
xterm*title: XTerm
xterm*iconName: XTerm
xterm*saveLines: 50000
xterm*jumpScroll: true
xterm*scrollTtyOutput: false
xterm*scrollKey: true
xterm*alwaysUseMods: true
xterm*metaSendsEscape: true
xterm*utf8Title: true 


xterm*Font: -adobe-courier-bold-r-normal--12-*
xterm*background: White
xterm*vt100.geometry: 80x45+0+0
xterm*foreground:    Black
xterm.titleBar: true
xterm.titleFont: Rom14
xterm*cursorColor:   Red
xterm*fullCursor:    true
xterm*scrollBar:     true
xterm*saveLines:     1000
xterm*loginShell:    true
xterm*fontMenu*font1*Label: Unreadable
xterm*VT100*font1:           nil2
*VT100.allowWindowOps: true
*VT100.allowTitleOps: true
*VT100.allowFontOps: true

! Use a nice truetype font and size by default... 
xterm*faceName: DejaVu Sans Mono Book
xterm*faceSize: 11

! Every shell is a login shell by default (for inclusion of all necessary environment variables)
xterm*loginshell: true

! I like a LOT of scrollback...
xterm*savelines: 16384

! double-click to select whole URLs :D
xterm*charClass: 33:48,36-47:48,58-59:48,61:48,63-64:48,95:48,126:48

! DOS-box colours...
xterm*foreground: rgb:a8/a8/a8
xterm*background: rgb:00/00/00
xterm*color0: rgb:00/00/00
xterm*color1: rgb:a8/00/00
xterm*color2: rgb:00/a8/00
xterm*color3: rgb:a8/54/00
xterm*color4: rgb:00/00/a8
xterm*color5: rgb:a8/00/a8
xterm*color6: rgb:00/a8/a8
xterm*color7: rgb:a8/a8/a8
xterm*color8: rgb:54/54/54
xterm*color9: rgb:fc/54/54
xterm*color10: rgb:54/fc/54
xterm*color11: rgb:fc/fc/54
xterm*color12: rgb:54/54/fc
xterm*color13: rgb:fc/54/fc
xterm*color14: rgb:54/fc/fc
xterm*color15: rgb:fc/fc/fc

! right hand side scrollbar...
xterm*rightScrollBar: true
xterm*ScrollBar: true

! stop output to terminal from jumping down to bottom of scroll again
xterm*scrollTtyOutput: false
```
