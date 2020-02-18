# Interface
 Ctrl key and right click button


Install the xorg-xrdb package. 

xrdb -query -all
xrdb -merge ~/.Xresources

# Escape

* enable windows operation: `echo VT100.allowWindowOps: true | xrdb -merge`
* resize (line,col): `printf '\e[8;50;100t'`
* move to top left: `printf '\e[3;0;0t'`
* zoom: `printf '\e[9;1t'`
* to front: `printf '\e[5t'`


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
