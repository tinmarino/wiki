```text

.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:.

Normand Veilleux's ASCII Art Tutorial

.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:.

From: Normand Veilleux <nveilleu@emr1.emr.ca>

Date: Tue, 11 Jan 1994 12:18:52 -0500 (EST)

Several people have asked me how I do what I do (smoothing out
pictures,  etc.)  First, I would like to say that I am a complete
beginner myself.  I had no drawing experience before Dec 11, 1993.
At that time someone posted an ascii picture of Meriday (a
professionally drawn nude, I think).  I found that picture a lot
more appealing than the GIFs I have seen or the mainframe pictures
from my University years.  Those tend to be hard the eyes from
close up.

Anyway, when someone else posted another nude that (I'm guessing
here) was a cleaned up GIF.  I immediately saw there was lots of
room for improvement and I decided to give it a try.  The only
tools I had at my disposal were a PC with WordPerfect.  The big
advantage I saw with WP was that I could toggle between a normal
view of the picture and a reduced version since WP allowed me to
view a full page of text at once on the screen.

In reduced format the text is actually transferred in graphics so
that an '8' would actually appear as a black square.  This gave the
picture a rough look; the edges were all jagged.  But, by
experimenting with various character changes I soon realized that
I could smooth out those jagged edges.  I spent a lot of time
flipping back and forth between the normal and the reduced views.

Oh, one thing I forgot to mention.  When I changed the font from
"Courrier 10" to "Line Printer 16.67 cpi" for the LaserJet printer,
I noticed that the jagged flaws appeared even more pronounced.
This is why you'll see me mention once in a while that "the
drawings I post are at their best when printed with 'Line Printer
16.67 cpi' font or equivalent."  They were worked on using that
font.  They still look very good in a regular font
though.  That's the beauty of it all.

I still do the same thing now, only a little faster.  It is a time
consuming process and I see potential to automate some, if not a
large portion of it.  I have asked a few people on the NET if they
knew of any software that could lighten or darken an ascii picture,
reduce or enlarge it, etc.  So far, no luck.

I took a 15 hour bus ride (double it for the return trip) during
the Christmas holidays up to Kapuskasing where my parents live.  So
I had some time to think about things.  I came up with pseudocode
for a program to lighten and darken a picture automatically.  That
is, if the picture is dark, it will lighten it and vice versa
without any cumbersome parameters of any sort.  It's extremely
simple when you think about it for 3 to 4 hours.  I haven't had the
chance to program any of it yet but given a week or two it will be
implemented.

I also wrote pseudocode for flipping a picture horizontally, and
for reducing and enlarging one.  These were not quite as simple but
it looks like it can work.  If any of you out there know of
programs that do just that already please let me know ASAP.  You'll
save me a lot of time.

Thank's a million.

I hope these "tips" have entertained as much as enlightened you.
Like a person I use to listen to on radio often said "When I learn
something during the day I go to bed at night less ignorant."

And so it has been for me a joy to learn how to draw.



From: Nveilleu@emr1.emr.ca (Normand Veilleux)
Date: Sat Jan 08 16:08:26 CST 1994


I have received a few requests to explain the "logic" behind the
smoothing.  So far I have only explained what tools I use to create
it (flipping back and forth from normal to reduced view in
WordPerfect).  I will try to give here the same explanation I gave
the first student who asked.  Since I did not save that discussion
this one will be slightly different.

The whole thing is visual as you could have guessed.  So, the best
way I know to show you what I mean is by giving an example:


     Take this                     Doesn't this
     for example                   look smoother?

      8                              8
      88                             Yb
       88                             Yb
        888                            Y8a,
          88888                         `"Y888


BTW, that reminds me of a quote I saw not too long ago:  "A truly
wise person does not play leapfrog with a rhinoceros"  :-)

I consider the "smoothing problem" as nothing more than a "weight
distribution problem".  By shifting up the pixel density of an 8
with characters such as P, Y, ", etc., where necessary, and by
shifting down the pixel density of an 8 with characters such as b,
d, a, etc., where necessary, the graphic takes on a smoother look.

May sound simple when it's explained like that but I don't know
where to start to program it.  I'll start with easier stuff first,
like flipping a picture horizontally.  That's kids stuff.  I used
a semi-manual technique when I had to flip my ascii face around.
The picture I had drawn was a mirror image, so it had to be flipped
to look right.  I created two small macros (less than 10 commands
each) in WordPerfect which did the bulk of the work.  After that
all I needed to do was about 20 global search and replaces.  It
took about 5 - 10 minutes total.  It would have taken hours to
retype it in reverse or to write a program to do it.

Since I don't have access to a scanner, but I sometimes want to
take a picture from paper and draw it in ascii I developed a GRID
technique to help me out.  Anyone who wants to give it a try needs
to create the grid electronically and then print it.  Here is how
it works.  Start with the following grid:

1.2.3.4.5.
2.A.B.C.D.
3.E.F.G.H.
4.I.J.K.L.
5.M.N.O.P.

The dots can actually be replaced by spaces, so create the grid
using your preference.

Then, copy the whole grid horizontally until you fill all the width
of the paper size you want to use.  And then, copy this new grid as
many times as needed to fill the length of the page.  You will end
up with something along these lines (with spaces):


1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
2 A B C D 2 A B C D 2 A B C D
3 E F G H 3 E F G H 3 E F G H
4 I J K L 4 I J K L 4 I J K L
5 M N O P 5 M N O P 5 M N O P
1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
2 A B C D 2 A B C D 2 A B C D
3 E F G H 3 E F G H 3 E F G H
4 I J K L 4 I J K L 4 I J K L
5 M N O P 5 M N O P 5 M N O P


Now, get a printed copy of that grid and put it aside for a bit.

BTW, this technique works best with pictures that are about 1/4 of
an 8 1/2 x 11 piece of paper.  Larger pictures can also be done but
are cumbersome and time consuming.  That is how I created three
ascii pictures so far:  the hand that showed "that close", the ying
yang, and my own face.  The toughest thing about the face was to
draw it on paper first.

At this stage you need to find a picture that is reasonably simple
in terms of complexity :-)  In other words not too detailed; the
coarser the better.  Something taken from a colouring book would
probably be an excellent choice (although I have not used any
myself yet).  You may need to "modify" the picture so that it will
also "cooperate" to the process (especially if taken from a
photograph or other source).

With a photocopier, enlarge or reduce the picture so that it is
close to the best size (as stated above).  Then, use a wide black
marker to "highlight" the lines and contours (this may not be
necessary if the picture came from a colouring book).  If there is
a background image that you want to remove, just cut and tape white
paper over those areas or just cut out the undesired areas.  This
is important since the "junk" you would otherwise leave in would
eventually interfere with the grid.

When the lines are all really dark and just about all the
background has been removed you can photocopy the new picture on
the grid.  You may have to experiment a few times to get the
picture to come out the same as the original on an upside up grid.

When you have such an image you can now bring up the electronic
grid.  Work at it from left to right and from top to bottom.  Put
your word processor on typeover and space over the characters of
the first line until you get to a character that is partially or
completely covered by a dark line on the paper grid.  Use the 1 to
5 and the A to P to locate the correct position.  When you get to
such a character, try to find a character that resembles the shape
of the line and type that in.  Ex: '8' for a character that is
totally covered, 'a' for a character that has the bottom half
covered, etc.  This is actually starting the smoothing process at
the same time you are converting from paper to screen.  Remember
that shading complicates things unnecessarily, so ignore it
completely.

Repeat this process for all the lines of the grid until the picture
is completely transferred to electronic form.  You don't need to be
an artist do this.  You just need to have some time on your hands.

Of course at this point the ascii picture is still slightly rough,
but at least you have the right proportions, etc.  Now you could
try to smooth it out by using the "weight distribution" technique
described above and perhaps a printed version of one of the ascii
pictures I have smoothed (for concrete examples).

It may sound very complicated at first, but just to give you an
example, the ying yang I did (a few people informed me that I had
forgotten the eyes):

            .,ad88888888baa,
        ,d8P"""        ""9888ba.
     .a8"          ,ad88888888888a
    aP'          ,88888888888888888a
  ,8"           ,88888888888888888888,
 ,8'            (888888888( )888888888,
,8'             `8888888888888888888888
8)               `888888888888888888888,
8                  "8888888888888888888)
8                   `888888888888888888)
8)                    "8888888888888888
(b                     "88888888888888'
`8,        (8)          8888888888888)
 "8a                   ,888888888888)
   V8,                 d88888888888"
    `8b,             ,d8888888888P'
      `V8a,       ,ad8888888888P'  Normand
         ""88888888888888888P"     Veilleux
              """"""""""""

took just over half an hour using that technique.  I hope a few of
you will be interested enough to try it out.  If you do, let us
know how it goes.


EXPERIMENT:    Would someone with access to a scanner and the
               GIF2ASC program (or an OCR) try the following:
               take a picture from a colouring book, scan it and
               then convert it to ascii.  Alternatively, tell your
               scanner that what you are scanning is text, if you
               have an OCR.  I am under the impression that the
               results would be quite presentable.  Of course,
               sometimes theory and practice differ considerably.
               Please post your findings.



From: Normand Veilleux <nveilleu@emr1.emr.ca>
Date: 27 Jun 1994 20:26:35 -0500



I have seen several ascii versions of the Mona Lisa circulating in
alt.ascii-art but I was not happy with any of them.  They all
appeared to be converted GIFs and even the best one, which was
distinctly superior to all the others, only looked decent when I
stood back at least 5 feet from it.  It also had the drawback of
being stretched vertically.  So I decided to make my own.

I also wanted to take this opportunity to give a concrete example
of how the special grid technique that I use, accelerates and
simplifies the creation of many ASCII drawings.  I wanted to
explain, as much as possible, what was involved in drawing by
"hand" the ASCII version of a relatively complex picture while
starting from scratch.

I have described the grid technique in a previous post (in Jan.
'94), but a recapitulation is necessary before going any further. 
Basically, the grid was nothing more than a series of characters
that filled up the area taken by the drawing.  I realized that the
characters composing the grid would be more useful if they were
chosen to help pinpoint where a particular portion of the drawing
was located within the grid.

There was many ways of doing this, but I opted for the following
rectangle (10 x 5 characters):

1.2.3.4.5.
2.A.B.C.D.
3.E.F.G.H.
4.I.J.K.L.
5.M.N.O.P.

This rectangle was then replicated horizontally and vertically
until an area the size of an 8.5" x 11" page was filled up.  I
later decided to replace the periods by spaces to "lighten" the
grid.  This created an electronic grid which looked like this:

1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4
2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C
3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G
4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K
5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O
1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4
2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C
3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G
4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K
5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O

The characters 1 to 5 produced horizontal and vertical guidelines. 
With these guidelines, I could quickly locate the approximate area
of the grid that I wanted to work on.  To pinpoint the exact
location, I relied on the letters A to P which appeared only once
inside each rectangle.

Of course, the electronic grid alone was not very useful until I
could somehow relate it to the drawing.  To do so, I printed out
the grid and then photocopied it on an acetate for reusability. 
Then, whenever I wanted to work on a picture, I taped a photocopy
of it to the back of the acetate and brought up the electronic grid
on the screen.  By the intermediary of the grid, I automatically
had a relationship between the picture on paper and the screen.

TIP: If you ever print a grid on an acetate, make sure to cover the
     acetate with clear tape afterwards to prevent your fingers
     from eroding the toner.  I learned the hard way.


Now, back to Mona.  You may find the discussion a little difficult
to follow at times without a picture, so either find a copy of the
Mona Lisa or print out this file.

In search of a decent reproduction of the Mona Lisa I went to the
closest library and found an excellent example on page 25 of the
book "Leonard de Vinci" published by McGraw-Hill in 1974.  The
picture measured about 9.5" x 12" and was in full colour.

Next, I photocopied the picture.  The lowest darkness setting gave
the best result, but was still a little bit too dark in certain
areas to distinguish some of the lines.  Before addressing that
problem, I decided to cut the photocopy so that the resulting
picture could fit in 55 lines by 78 columns.  This was
approximately double the height of the head and was wide enough to
show a large portion of both shoulders.

To make the barely discernable lines more visible, I highlighted
them with a blue pen.  I made sure to draw those lines about one
sixteenth of an inch thick so they would be clearly visible. 
Experience had taught me that very fine lines were often too
difficult to distinguish from a dark background once the grid was
superimposed on the picture.  The affected lines were:  the lines
between veil and hair, hair and background, chin and throat, and
the lines on each side of the face and on each side of the arched
garment extending to her left shoulder (referred to as the shawl in
the rest of this document).  While I was at it, I also highlighted
the contours of the lips, nose and eyes in the same manner.  I then
taped the touched up photocopy behind the acetate which had the
grid.

The next step was to load the electronic version of the grid in my
favourite word processor (WordPerfect).  Before starting work, I
decided to represent the dark areas of the picture with an "8" (I'm
sure you guessed that), the shawl with an "I" and the veil with an
"8" if it was covering any hair and with an "I" if it was not (or
to show its border in the hair).  I chose those characters since
they contrasted very well:  it was easy to distinguish a line of
I's in an area filled with 8's.

Then, I determined which character of the acetate corresponded to
the top of her left shoulder and located that character on the
electronic grid.  While holding the acetate in my left hand and
marking my position on it with my thumb, I delimited the contour
(only one character wide) around the bottom of the picture (counter
clockwise) up to her right shoulder by replacing the characters of
the grid with 8's except for the ends of the shawl which needed
I's.

I then continued up the picture, line by line, while overwriting
the grid's characters with spaces until I got to the first
character delimiting the border of Mona's hair or veil, as
determined from the acetate.  At that point, I typed one of four
characters: "8", "d", "`" or "," depending on which one
corresponded best to the dark portion of the picture at that
location on the acetate.  I then typed two more 8's and a space;
just enough to define the contour.  Of course, when I was in the
area where the veil was the first thing to be reached I used I's
instead of 8's.

I repeated that process for each line until I reached the top of
the head.  There, I decided to follow the inside line of the hair
while going down the right side of the picture.  So, I first
started by defining the hair line on the forehead and filling the
top of the head with 8's.  Then, starting at the inside line for
the hair I typed 8's until I reached the other side of the hair and
then added a "b" or a "," if necessary.  I also made sure to drop
an "I" along the way at the exact location where I had shown the
veil to start covering the hair (it was a blue line on the
photocopy).  I continued this, line by line, until I reached the
top of the shawl.

So, half an hour after loading the grid I was at this stage:

                                  _______
                           _,,ad8888888888bba,_
                        ,8888888888888888888888888,
                      ,888888888888888888888888888888,
                    ,8888888888888888888888888888888888,
                   d88888PP"""""""YY888888888888888888888,
                 ,88  A B C D 2 A B C D 2 ""Y8888888888888,
                ,II 3 E F G H 3 E F G H 3 E  IIII8888888888,
               ,II  4 I J K L 4 I J K L 4 I J `888III8888888,
             ,II  P 5 M N O P 5 M N O P 5 M N  `888888I888888,
            ,II 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4  `888888I8888b
           ,II  C D 2 A B C D 2 A B C D 2 A B C D 8888888I8888,
           II8  G H 3 E F G H 3 E F G H 3 E F G H `8888888I888b
           II8  K L 4 I J K L 4 I J K L 4 I J K L  88888888I888
           II8  O P 5 M N O P 5 M N O P 5 M N O P  88888888I888,
           II8  4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 ,888888888I88b
          ,II B C D 2 A B C D 2 A B C D 2 A B C D 8888888888I888
          II8 F G H 3 E F G H 3 E F G H 3 E F G H 8888888888I888,
         ,II  J K L 4 I J K L 4 I J K L 4 I J K L 8888888888I888b
         II8  N O P 5 M N O P 5 M N O P 5 M N O P 88888888888I888
         II8  3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 88888888888I888,
         II8  B C D 2 A B C D 2 A B C D 2 A B C D 88888888888I888b
         II8  F G H 3 E F G H 3 E F G H 3 E F G H 88888888888I8888,
         II8  J K L 4 I J K L 4 I J K L 4 I J K L 88888888888I8888b
         II8  N O P 5 M N O P 5 M N O P 5 M N O P 88888888888I88888
         II8  3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 88888888888I88888
         `II  B C D 2 A B C D 2 A B C D 2 A B C D 88888888888I88888
          II8 F G H 3 E F G H 3 E F G H 3 E F G H 8888888888I888888,
          `II J K L 4 I J K L 4 I J K L 4 I J K L 8888888888I888888b
           `II  O P 5 M N O P 5 M N O P 5 M N O P 8888888888I8888888
            `II 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 `888888888I8888888,
             II8  D 2 A B C D 2 A B C D 2 A B C D  888888888I88888888,
            ,II G H 3 E F G H 3 E F G H 3 E F G H  `88888888I888888888,
            II8 K L 4 I J K L 4 I J K L 4 I J K L 4 88888888I8888888888,
            II8 O P 5 M N O P 5 M N O P 5 M N O P 5 88888888I888888888888,
           ,II  4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 `8888888I88888888888888,
           II8  C D 2 A B C D 2 A B C D 2 A B C D 2  8888888I888888888888888b
          ,II F G H 3 E F G H 3 E F G H 3 E F G H 3 ,8888888I8888888888888888
         ,88  J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J I
      ,88 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N I
    ,88 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 I
  ,88 C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B I
 ,88  G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F I
d88 J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J I
8 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N 8
8 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 8
8 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B 8
8 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F 8
8 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J 8
8 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N O P 5 M N 8
8 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 8
8 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B C D 2 A B 8
8 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F G H 3 E F 8
8 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J K L 4 I J 8
8888888888888888888888888888888IIIIIIIIIIIIII88888888888888888888888888888888

Here, it seemed appropriate to fill in the shawl with I's which
automatically led to filling in the bottom right corner with 8's
and adding my name.  I then completed the small portion of hair at
the top of the shawl.  Then, I defined the upper portion of the
garment, beside the veil, and filled in the section below that with
8's.  Next, I filled the rest of the hair (on the left side of the
picture) with 8's while defining the hair's inside line.  I also
filled in, with spaces, the area of skin from the top of the
garment up to the throat.  Next, I drew the veil on the forehead
and filled in the rest of the forehead with spaces.  And finally I
smoothed all the lines drawn so far, leaving the face for last.

So, after one hour of work I was at this stage:

                                  _______
                           _,,ad8888888888bba,_
                        ,ad88888I888888888888888ba,
                      ,88888888I88888888888888888888a,
                    ,d888888888I8888888888888888888888b,
                   d88888PP"""" ""YY88888888888888888888b,
                 ,d88"'__,,--------,,,,._ ""Y8888888888888,
                ,8II-'"                  "```IIII8888888888,
               ,I88'                          `Y88III8888888,
             ,II88I                            `Y88888I888888,
            ,II888'                              `888888I8888b
           ,II8888                                Y888888I8888,
           II88888                                `8888888I888b
           II88888, 4 I J K L 4 I J K L 4 I J K L  88888888I888
           II88888I 5 M N O P 5 M N O P 5 M N O P  88888888I888,
           II88888' 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 ,888888888I88I
          ,II88888  2 A B C D 2 A B C D 2 A B C D d888888888I888
          III88888, 3 E F G H 3 E F G H 3 E F G H 8888888888I888,
         ,III88888I 4 I J K L 4 I J K L 4 I J K L 8888888888I888I
         III888888I 5 M N O P 5 M N O P 5 M N O P 88888888888I888
         II88888888,  2 3 4 5 1 2 3 4 5 1 2 3 4 5 88888888888I888,
         II88888888I  A B C D 2 A B C D 2 A B C D 88888888888I888b
         ]I888888888, E F G H 3 E F G H 3 E F G H 88888888888I8888,
         II888888888I I J K L 4 I J K L 4 I J K L 88888888888I8888I
         II8888888888b  N O P 5 M N O P 5 M N O P 88888888888I88888
         II888888888888a  4 5 1 2 3 4 5 1 2 3 4 5 88888888888I88888
         `II8888888888888b, D 2 A B C D 2 A B C D 88888888888I88888
          II888888888888888ba,_ E F G H 3 E F G H 8888888888I888888,
          `II88888888888888888b I J K L 4 I J K L I888888888I888888b
           `II88888888888888888 M N O P 5 M N O P I888888888I8888888
            `II8888888888888888                   `888888888I8888888,
             II8888888888888888,                   Y88888888I8888888b,
            ,II8888888888888888b                   `88888888I88888888b,
            II888888888888888P"I                    88888888I8888888888,
            II888888888888P"   `                    Y8888888I88888888888b,
           ,II888888888P"                           `8888888I8888888888888b,
           II888888888'                              8888888I888888888888888b
          ,II888888888                              ,8888888I8888888888888888
         ,d88888888888                              d888888I8888888888IIIIIII
      ,ad888888888888I                              8888888I8888IIIIIIIIIIIII
    ,d888888888888888'                              888888IIIIIIIIIIIIIIIIIII
  ,d888888888888P'8P'                               Y888IIIIIIIIIIIIIIIIIIIII
 ,8888888888888,  "                                 ,IIIIIIIIIIIIIIIIIIIIIIII
d888888888888888,                                ,IIIIIIIIIIIIIIIIIIIIIIIIIII
888888888888888888a,      _                    ,IIIIIIIIIIIIIIIIIIII888888888
888888888888888888888ba,_d'                  ,IIIIIIIIIIIIIIIII88888888888888
8888888888888888888888888888bbbaaa,,,______,IIIIIIIIIIIIIII888888888888888888
88888888888888888888888888888888888888888IIIIIIIIIIIIIII888888888888888888888
8888888888888888888888888888888888888888IIIIIIIIIIIIII88888888888888888888888
888888888888888888888888888888888888888IIIIIIIIIIIIII888888888888888888888888
8888888888888888888888888888888888888IIIIIIIIIIIIII88888888888888888888888888
88888888888888888888888888888888888IIIIIIIIIIIIII8888888888888888888888888888
8888888888888888888888888888888888IIIIIIIIIIIIII88888888888888888 Normand  88
88888888888888888888888888888888IIIIIIIIIIIIII8888888888888888888 Veilleux 88
8888888888888888888888888888888IIIIIIIIIIIIII88888888888888888888888888888888

I found the shawl to be much too pale in comparison to the rest of
the garment, so I tried replacing the I's with darker characters
such as M, H, A, etc.   Unfortunately, even though I could see the
difference on the screen reasonably well, I could not see any
difference between those characters and the surrounding 8's when I
used the reduced view feature of WordPerfect.  I have been using
this feature to view an entire page at a time on the screen.  It's
only when I tried a 'Z' that I was able to distinguish between the
two characters in the reduced view.  So, 'Z' had my vote.

I then worked on the face for about half an hour, defining the
mouth, nose, eyes, etc.  I tried my preferred style first, but it
looked awful so I tried line draw instead without any more success. 
Nothing seemed to work, so I reverted back to my preferred style of
ASCII drawing and to be true to it I did not add any shading to the
face.

This was how the picture looked at that stage:

                                  _______
                           _,,ad8888888888bba,_
                        ,ad88888I888888888888888ba,
                      ,88888888I88888888888888888888a,
                    ,d888888888I8888888888888888888888b,
                   d88888PP"""" ""YY88888888888888888888b,
                 ,d88"'__,,--------,,,,._ ""Y8888888888888,
                ,8II-'"                  "```IIII8888888888,
               ,I88'                          `Y88III8888888,
             ,II88I                            `Y88888I888888,
            ,II888'                              `888888I8888b
           ,II8888                                Y888888I8888,
           II88888                                `8888888I888b
           II88888,   .aag,    ,gaaP""             88888888I888
           II88888I    ___"b  d"    ____           88888888I888,
           II88888'  <^I88>I  I   <^I888'         ,888888888I88I
          ,II88888  . `""" I  I    `""" .         d888888888I888
          III88888,  ````     b     ''''          8888888888I888,
         ,III88888I                               8888888888I888I
         III888888I        ,   \,                 88888888888I888
         II88888888,      I'    "I                88888888888I888,
         II88888888I      `"baad"'               ,88888888888I888b
         ]I888888888,                           ,P88888888888I8888,
         II888888888I    "Y88bd888P"          ,d" 88888888888I8888I
         II8888888888b     `"""""          _,8"  ,88888888888I88888
         II888888888888a                _,P"'   ,d88888888888I88888
         `II8888888888888b,          _,d"'    ,aP"88888888888I88888
          II888888888888888ba,__,,ad""    _,aP"   8888888888I888888,
          `II88888888888888888b"ba,,,,aadP"'      I888888888I888888b
           `II88888888888888888  `""""'           I888888888I8888888
            `II8888888888888888                   `888888888I8888888,
             II8888888888888888,                   Y88888888I8888888b,
            ,II8888888888888888b                   `88888888I88888888b,
            II888888888888888P"I                    88888888I8888888888,
            II888888888888P"   `                    Y8888888I88888888888b,
           ,II888888888P"                           `8888888I8888888888888b,
           II888888888'                              8888888I888888888888888b
          ,II888888888                              ,8888888I8888888888888888
         ,d88888888888                              d888888I8888888888ZZZZZZZ
      ,ad888888888888I                              8888888I8888ZZZZZZZZZZZZZ
    ,d888888888888888'                              888888IZZZZZZZZZZZZZZZZZZ
  ,d888888888888P'8P'                               Y888ZZZZZZZZZZZZZZZZZZZZZ
 ,8888888888888,  "                                 ,ZZZZZZZZZZZZZZZZZZZZZZZZ
d888888888888888,                                ,ZZZZZZZZZZZZZZZZZZZZZZZZZZZ
888888888888888888a,      _                    ,ZZZZZZZZZZZZZZZZZZZZ888888888
888888888888888888888ba,_d'                  ,ZZZZZZZZZZZZZZZZZ88888888888888
8888888888888888888888888888bbbaaa,,,______,ZZZZZZZZZZZZZZZ888888888888888888
88888888888888888888888888888888888888888ZZZZZZZZZZZZZZZ888888888888888888888
8888888888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888
888888888888888888888888888888888888888ZZZZZZZZZZZZZZ888888888888888888888888
8888888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888888
88888888888888888888888888888888888ZZZZZZZZZZZZZZ8888888888888888888888888888
8888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888 Normand  88
88888888888888888888888888888888ZZZZZZZZZZZZZZ8888888888888888888 Veilleux 88
8888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888888888888


Since I could not seem to improve the face, I decided to try and
experiment with shading to see if that could help.  Well, it did
not turn out the way I thought it would: the shading was too pale. 
So I ended up losing half an hour to get to this stage:

                                  _______
                           _,,ad8888888888bba,_
                        ,ad88888I888888888888888ba,
                      ,88888888I88888888888888888888a,
                    ,d88888888I88888888888888888888888b,
                   d88888PP""" """YY88888888888888888888b,
                 ,d88"'__,,--------,,,;:::""Y8888888888888,
                ,8II:'"              .,:.":::IIII8888888888,
               ,I88:.                 ...::::::Y88III8888888,
             ,II88I:.                   :..:::::Y88888I888888,
            ,II888'..                  :.:...:::::888888I8888b
           ,II8888.                        .::::::Y888888I8888,
           II88888:                        .:::::::8888888I888b
           II88888;   .aag,    ,gaaP""... .:.::::::88888888I888
           II88888I:::::::"b  d":::::;;::, :..:::::88888888I888,
           II88888'::<^I88>I  I::.<^I888'   ..:.::;888888888I88I
          ,II88888  . `""" I  I:.. `""" .   ..:.::d888888888I888
          III88888,  ````     b;.   ''''   ..:.:::8888888888I888,
         ,III88888I            :.         ..:.::::8888888888I888I
         III888888I        ,   :,         :::.::::88888888888I888
         II88888888;:     I'    "I       :.:.:::::88888888888I888,
         II88888888I:.    `"baad":       .:::.::::88888888888I888b
         ]I888888888;:.:.    :.:..:.:: ..:.:.:::::88888888888I8888,
         II888888888I:. ."Y88bd888P"   ..::.::::::88888888888I8888I
         II8888888888b::.  `""""'.:.:.:.::.::::::;88888888888I88888
         II888888888888a:.   :::::.:. .:,aP:::::;d88888888888I88888
         `II8888888888888b;.    ..::.;aP":::::;aP:88888888888I88888
          II888888888888888ba,__,,aP"::::::;aP::::8888888888I888888,
          `II88888888888888888b"ba;;;;aadP":::::::I888888888I888888b
           `II88888888888888888 .:::::::::::::::::I888888888I8888888
            `II8888888888888888  .::::::::::::::..`888888888I8888888,
             II8888888888888888,   ..::.:::::.:..  Y88888888I8888888b,
            ,II8888888888888888b      .::..:..     `88888888I88888888b,
            II888888888888888P"I        ..:.        88888888I8888888888,
            II888888888888P"::.`                    Y8888888I88888888888b,
           ,II888888888P".:::                       `8888888I8888888888888b,
           II888888888'                              8888888I888888888888888b


Later, I decided to give line drawing another chance and started
working on the face with no shading.  I managed to get a decent
looking nose in about 5 minutes so I continued and slowly but
surely the rest of the face took on a new look that was much better
than anything obtained so far.  It took about half an hour of trial
and error to get to this:

                                  _______
                           _,,ad8888888888bba,_
                        ,ad88888I888888888888888ba,
                      ,88888888I88888888888888888888a,
                    ,d888888888I8888888888888888888888b,
                   d88888PP"""" ""YY88888888888888888888b,
                 ,d88"'__,,--------,,,,._ ""Y8888888888888,
                ,8II-'"                  "```IIII8888888888,
               ,I88'                          `Y88III8888888,
             ,II88I                            `Y88888I888888,
            ,II888'                              `888888I8888b
           ,II8888                                Y888888I8888,
           II88888                                `8888888I888b
           II88888,    ---.      ..-----           88888888I888
           II88888I   _,,_ `.  .'   _,,_           88888888I888,
           II88888'  <'(@@> |  |   <'(@@>         ,888888888I88I
          ,II88888    `"""  |  |    `"""          d888888888I888
          III88888,            `                  8888888888I888,
         ,III88888I                               8888888888I888I
         III888888I        ,   ',                 88888888888I888
         II88888888,      (_    _)                88888888888I888,
         II88888888I        `--'                 ,88888888888I888b
         ]I888888888,                           ,P88888888888I8888,
         II888888888I    "Y88bd888P"          ,d" 88888888888I8888I
         II8888888888b     `"""""          _,8"  ,88888888888I88888
         II888888888888a                _,P"'   ,d88888888888I88888
         `II8888888888888b,          _,d"'    ,aP"88888888888I88888
          II888888888888888ba,__,,ad""    _,aP"   8888888888I888888,
          `II88888888888888888b"ba,,,,aadP"'      I888888888I888888b
           `II88888888888888888  `""""'           I888888888I8888888
            `II8888888888888888                   `888888888I8888888,
             II8888888888888888,                   Y88888888I8888888b,
            ,II8888888888888888b                   `88888888I88888888b,
            II888888888888888P"I                    88888888I8888888888,
            II888888888888P"   `                    Y8888888I88888888888b,
           ,II888888888P"                           `8888888I8888888888888b,
           II888888888'                              888888I8888888888888888b
          ,II888888888                              ,888888I88888888888888888
         ,d88888888888                              d888888I8888888888ZZZZZZZ
      ,ad888888888888I                              8888888I8888ZZZZZZZZZZZZZ
    ,d888888888888888'                              888888IZZZZZZZZZZZZZZZZZZ
  ,d888888888888P'8P'                               Y888ZZZZZZZZZZZZZZZZZZZZZ
 ,8888888888888,  "                                 ,ZZZZZZZZZZZZZZZZZZZZZZZZ
d888888888888888,                                ,ZZZZZZZZZZZZZZZZZZZZZZZZZZZ
888888888888888888a,      _                    ,ZZZZZZZZZZZZZZZZZZZZ888888888
888888888888888888888ba,_d'                  ,ZZZZZZZZZZZZZZZZZ88888888888888
8888888888888888888888888888bbbaaa,,,______,ZZZZZZZZZZZZZZZ888888888888888888
88888888888888888888888888888888888888888ZZZZZZZZZZZZZZZ888888888888888888888
8888888888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888
888888888888888888888888888888888888888ZZZZZZZZZZZZZZ888888888888888888888888
8888888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888888
88888888888888888888888888888888888ZZZZZZZZZZZZZZ8888888888888888888888888888
8888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888 Normand  88
88888888888888888888888888888888ZZZZZZZZZZZZZZ8888888888888888888 Veilleux 88
8888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888888888888


I decided to consider this the final unshaded version.

Now, the question remained: would it be worthwhile to add in the
shading?  I showed the unshaded version of the picture to a friend
who is a graphic designer.  It didn't take him long to mention
shading as the next step.  I showed him the first attempt
(displayed above) and admitted that I had no idea how to improve
it.  He suggested using a printed copy of my unshaded picture and
drawing the shading on it first, before attempting to draw it on
the computer.

Well, that almost discouraged me right there.  Drawing simple stuff
on paper was not a problem, but when it came to shading I didn't
have a clue how it could be done.  He helped by pointing out that
I could start by drawing the outer edge of the faintest shading as
though it were a regular object.  I could then define another line
that would represent the "middle ground" of the shading.  He
suggested not to use more than 2 or 3 different levels of shading. 
So off to the drawing board I went.

I did not keep all the stages of the shading, but suffice to say
that it took about twice as much time then all the rest of the
picture.  This was the final result of the shaded version:

                                  _______
                           _,,ad8888888888bba,_
                        ,ad88888I888888888888888ba,
                      ,88888888I88888888888888888888a,
                    ,d888888888I8888888888888888888888b,
                   d88888PP"""" ""YY88888888888888888888b,
                 ,d88"'__,,--------,,,,.;ZZZY8888888888888,
                ,8IIl'"                ;;l"ZZZIII8888888888,
               ,I88l;'                  ;lZZZZZ888III8888888,
             ,II88Zl;.                  ;llZZZZZ888888I888888,
            ,II888Zl;.                .;;;;;lllZZZ888888I8888b
           ,II8888Z;;                 `;;;;;''llZZ8888888I8888,
           II88888Z;'                        .;lZZZ8888888I888b
           II88888Z; _,aaa,      .,aaaaa,__.l;llZZZ88888888I888
           II88888IZZZZZZZZZ,  .ZZZZZZZZZZZZZZ;llZZ88888888I888,
           II88888IZZ<'(@@>Z|  |ZZZ<'(@@>ZZZZ;;llZZ888888888I88I
          ,II88888;   `""" ;|  |ZZ; `"""     ;;llZ8888888888I888
          II888888l            `;;          .;llZZ8888888888I888,
         ,II888888Z;           ;;;        .;;llZZZ8888888888I888I
         III888888Zl;    ..,   `;;       ,;;lllZZZ88888888888I888
         II88888888Z;;...;(_    _)      ,;;;llZZZZ88888888888I888,
         II88888888Zl;;;;;' `--'Z;.   .,;;;;llZZZZ88888888888I888b
         ]I888888888Z;;;;'   ";llllll;..;;;lllZZZZ88888888888I8888,
         II888888888Zl.;;"Y88bd888P";;,..;lllZZZZZ88888888888I8888I
         II8888888888Zl;.; `"PPP";;;,..;lllZZZZZZZ88888888888I88888
         II888888888888Zl;;. `;;;l;;;;lllZZZZZZZZW88888888888I88888
         `II8888888888888Zl;.    ,;;lllZZZZZZZZWMZ88888888888I88888
          II8888888888888888ZbaalllZZZZZZZZZWWMZZZ8888888888I888888,
          `II88888888888888888b"WWZZZZZWWWMMZZZZZZI888888888I888888b
           `II88888888888888888;ZZMMMMMMZZZZZZZZllI888888888I8888888
            `II8888888888888888 `;lZZZZZZZZZZZlllll888888888I8888888,
             II8888888888888888, `;lllZZZZllllll;;.Y88888888I8888888b,
            ,II8888888888888888b   .;;lllllll;;;.;..88888888I88888888b,
            II888888888888888PZI;.  .`;;;.;;;..; ...88888888I8888888888,
            II888888888888PZ;;';;.   ;. .;.  .;. .. Y8888888I88888888888b,
           ,II888888888PZ;;'                        `8888888I8888888888888b,
           II888888888'                              888888I8888888888888888b
          ,II888888888                              ,888888I88888888888888888
         ,d88888888888                              d888888I8888888888ZZZZZZZ
      ,ad888888888888I                              8888888I8888ZZZZZZZZZZZZZ
    ,d888888888888888'                              888888IZZZZZZZZZZZZZZZZZZ
  ,d888888888888P'8P'                               Y888ZZZZZZZZZZZZZZZZZZZZZ
 ,8888888888888,  "                                 ,ZZZZZZZZZZZZZZZZZZZZZZZZ
d888888888888888,                                ,ZZZZZZZZZZZZZZZZZZZZZZZZZZZ
888888888888888888a,      _                    ,ZZZZZZZZZZZZZZZZZZZZ888888888
888888888888888888888ba,_d'                  ,ZZZZZZZZZZZZZZZZZ88888888888888
8888888888888888888888888888bbbaaa,,,______,ZZZZZZZZZZZZZZZ888888888888888888
88888888888888888888888888888888888888888ZZZZZZZZZZZZZZZ888888888888888888888
8888888888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888
888888888888888888888888888888888888888ZZZZZZZZZZZZZZ888888888888888888888888
8888888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888888
88888888888888888888888888888888888ZZZZZZZZZZZZZZ8888888888888888888888888888
8888888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888 Normand  88
88888888888888888888888888888888ZZZZZZZZZZZZZZ8888888888888888888 Veilleux 88
8888888888888888888888888888888ZZZZZZZZZZZZZZ88888888888888888888888888888888

As you can see, the grid system that I have been working with since
January '94 allows to very quickly transfer the large details from
paper to screen while keeping the proportions of the original
picture.  This eliminates a lot of the time-consuming
experimentation otherwise required to get the right proportions. 
You can't go wrong with the grid:  the characters that compose it
allow you to "see" where you should start and where you should
stop.  The skills required to use it are fairly simple as well,
although they do need to be practiced.  One thing the grid cannot
do though, is eliminate the experimentation needed for the
finishing touch:  the smaller details, the smoothing, the shading,
etc.


     ---<-<@    ---<-<@   ---<-<@    ---<-<@   ---<-<@

A big thank you goes to Rowan Crawford who spent time revising an
earlier draft of this document and who provided many useful
suggestions to improve its contents.



The pictures I post are at their best when printed with a
'Line Printer 16.67 cpi' font or equivalent.


    ___        _______
  ,88888,    ,d88888888a
 ,88" `Y8,  ,88"'   `"Y8i     ,ggggg,   ,ggggg,   ,ggg,,ggg,,ggg,
 I8b,  `8b ,88'       d8I    dP"  "Y8ggg8""""8I  ,8" "8P" "8P" "8,
 `Y8P   88.88'       ,88'   i8'    ,8I       8I  I8   8I   8I   8I
        (8V8'        d8P    I8,   ,d8'       Y8,,dP   8I   8I   Yb,
        (88P        ,8P     `Y8888P"         `Y88P'   8I   8I   `Y8ba
        d88         d8'
       ,88'        ,8P                 _,,ggdd888bbgg,,_
       d8P         I8I            _,gd8888P"""""""""Y8888bg,_
      ,88          I8b       _,gd88P"""'               `"""Y88bg,_
      88'          `Y8b,__,gd8P""'      Normand Veilleux     `""Y8bg,_
     d8P            `Y88888P"'        nveilleu@emr1.emr.ca       `"Y88ba


To Normand Veilleux's ASCII Art

.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:.

```
