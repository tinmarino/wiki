```text

.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:.

Rowan Crawford's ASCII Art Tutorial

.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:.

From: dljar1@giaeb.cc.monash.edu.au (Dwayne Jarvis)

Date: 21 Apr 94 16:45:44 GMT

----------------------------------------------------------------------------
                   ..ASCII GRAPHICAL TECHNIQUES V1.0..
                           By  Rowan Crawford.

        All text and art copyright (c) 1994 Sumaleth Productions.
----------------------------------------------------------------------------

CONTENTS:   1.  Intro                           ____           _  ..
            2.  Line art                 dHHA  /^  |T AHHHHHA (_) : .
            3.  Small/sig art           dHPHH Y  __jj HP"  IH .-. I::
            4.  Solid art              dHP HH l__  \\ H  HHHH | | HI:
            5.  3 Dimensional art     dHHHHHH |    // Hb.  IH | | HHI
            6.  Conclusion           dHP   HH l___//  UHHHHHU l_j UHU
            7.  Quick plug

1. Intro

    Producing pictures from ascii is such a strange idea, and yet the results
    can sometimes be quite impressive. Although there are a many different
    forms of ascii art, they all use basically the same ideas to produce
    the end result.

    The techniques I use are based around a few simple rules. These rules
    help me make decisions about which character to use, and where to place
    it. Of course they aren't strict rules, but they make a good foundation
    upon which to build a picture.

    This is not intended as the "definitive" guide to ascii creation, but is
    instead simply an analysis of how I approach the subject.

2. Line Art

    Line art is where you represent a picture by just it's outlines and

    details. Comic art is good material for this type of work since you have
    a definite outline to work from. However, any picture can be reproduced
    just by defining it's various boundaries.

    There are many standard characters which can be applied to this form
    of ascii art. These are the most obvious ones:

    / \ | - _ + ( ) < > , . ~ ^ " V X T Y I l L : ` ' ! j J 7

    Start by finding an area of the picture which is fairly simple. From
    there, work your way around the perimeter creating an outline using
    just these "basic" ascii characters:

    / \ | - _ ( )

    Try to get proportions correct at this stage, because it IS important,
    and the later you leave it the harder it is to correct. You can also
    draw in some of the larger details at this stage, which may help get the
    proportions correct.

    Once you're happy with that, it's time to go over the whole thing and
    work on the anti-aliasing. I like to have *every* line connect up,
    leaving no large gaps such as:

    ~~~~~~~~________

    If I come across an area which has no "ultimate" choice of characters,
    I may decide to add an extra detail there. For example, "near" vertical
    lines are virtually impossible in ascii. Here's some options:

                   |         |        |        |        |
                   |         l        l.       \        l
                    |         I       `|        Y       `L
                    |         |        |        |        |

                 START       ^----------OPTIONS----------^

    As you can see, none of them produce the "perfect" results I'd like.
    In this case, I would try adding some form of detail in there thus
    removing the problem. It doesn't always work, but it's worth a try.

    Near-horizontal lines are much easier (thankfully). Using these
    chars: ( ~"-.,_ ) you can quite easily produce a reasonably decent
    line. The previous (horizontal) example would become:
    __
      "~~"----..,___

    Or at least something to that effect. I usually get very "nit-picky"
    and arrange the comma just before an underscore since it sits down
    one pixel lower than the full-stop ("."). I also like to carefully
    select between the " and ~ since they each have their own distinct
    properties. Avoid using this technique at angles around 30 degrees
    (looks a bit odd), and very slight angles (because it results in a
    long line of dots, and that doesn't look good).

    Actually, the selection of the picture is very important in determining
    how the resulting pic will look. You also have the option of changing
    certain parts of the pic, so that they work better in the ascii format.
    For example, instead of trying to do a near-vertical line, just make it
    perfectly vertical.

    Curves also play an important role in ascii art. Although the standard
    ascii character set does not directly support curves (apart from "(" and
    ")" of course :), you can get some nice curves with a little bit of work.
    Here's the most often used chars for curve creation:

    / \ - _ ~ " . , ' ` ! I l Y

    And here's a couple of sample curves to demonstrate the idea:
                     ___
                 .-~"   "~-.                           /
                /           \                      _.-~
               Y             Y                   ,^
               |             |                  /
               l             !                 /
                \           /             __.-~
                 "-.,___,.-"

                   CIRCLE                SUBTLE CURVATURES

    Some people wouldn't like the use of "Y" and "^", but to me, the
    advantages outweigh the negative aspects. Also note the use of "l" and
    "!" to make the transition from vertical to angled less pronounced.

    I also consider the choice between "." an "," important because it
    affects the smoothness of the line. For example, in the part on the
    above curve: _.- :it looks like a "," may have been a better choice:

                      /             But as you can see here, using the
                  _,-~              comma has altered the flow of the
                ,^                  line somewhat. It now appears as
               /                    more of a "step" rather than an
              /                     angled line.
          _,-~

        CURVE USING COMMA

    Intersections require yet another strategy. Often you'll find that one
    line must join onto another at a place where the join isn't neat:

        "-._ /         "-._ /           Here the incoming line should join
            /              7            onto the main part halfway through
           /              /             a "/". That's where you can use some
                                        other chars. In this example, a "7"
     INTERSECTION        FIX            would work well, as seen in the
                                        example to the left.

    You could also try "Z" "X" "T" "Y" as a replacement, but it depends
    entirely on what is happening around that point as to which char works
    the best. Other chars which work well in these situations are "K" "<" ">"
    "r" "L" "j" "J" and "I" because they all point in at least 3 directions.

    After practice, the anti-aliasing can be done as you are drawing the
    main outline. Not that it really makes any difference.

    That basically covers the outline techniques. The smaller details are
    the next, and final, step. Adding details isn't always necessary, but
    it will be in most cases. Eyes, noses, finger nails, switches, knobs,
    handles, plus a host of other things are usually confined to just one
    or two character spaces, so the choice of chars is quite important.

    Eyes are a common example. You have quite a few different characters
    available which work well as eyes, but it's up to you to decide which
    work best. You need to decide what "emotion" you want to portray, and
    then find an appropriate character.

    As some examples, I have used two "6"'s for a kangaroo, a "bd" combo
    for a horse, a pair of "r"'s for a giraffe and: -=b- :as the eye of
    an eagle. In each case, I tried many different combinations until I
    was happy with the selection:
              .
          /\ /|            .  ,       ___,A.A_  __       _____
         ((.Y(!            |\/|       \   ,   7"_/      /     ~"-.
          \ |/             bd "n.      ~"T(  r r)      Y   -=b-. _)
          /  6~6,         /   _,"n       | \    Y      l      c"~o \
          \ _    +-.     <co>'\          |  ~\ .|       \_.-~"~--.  )
           \`-=--^-'      ~~             |   |`-'                 )/
            \ \                                                   '

    Other details are equally important, and the same technique is used.
    Just trying different combinations of characters until a "solution"
    is found. Sometimes there is no optimum arrangement, so you either
    have to live with it, or rearrange things just enough to give you a
    fresh angle of attack.
              ____
           .-~. /_"-._       This T-Rex head demonstrates how you can use
          / /_ "~o\  :Y      the character shapes to an advantage. The "L"
         / : \~x.  ` ')      at the bottom joins three connections together
           |  Y< ~-.__j      quite well, as does the "Y" at the back of the
         : l  l<  /.-~       mouth. These are things too look out for when
         l /~\ \<|Y          creating a picture, and by using the chars in
          '.-~\ \L|          such a fashion, you can usually get quite a lot
               "--'          of detail into a small area.

3. Small/Signature Art

    Smaller artwork requires a slightly different approach than the large
    pieces. Due to the smaller area, you aren't always able to recreate
    a picture perfectly, so a different frame of mind is needed.

    Take, for example, the kangaroo head above. The back of the neck should
    of course be curved, but this was not possible with only two characters.
    In smaller pics however, it's not always necessary to be that detailed,
    it is more important to focus on making the object immediately
    identifiable.

    Small ascii pictures usually start from a simple motif or idea. The way
    certain characters fit together often creates the idea, and once an idea
    is found, you have a base to work from.
            ___
          {~._.~}      This little koala pic is a good example of how a
           ( Y )       relatively simple collection of characters can
          ()~*~()      produce a very "familiar" result. Some experimenting
          (_)-(_)      was done with the eyes, "bow tie" and the bottom "-",
                       with these being chosen simply because they worked the
    best. Different "eye" characters produced different emotional feelings
    (which is how the "Koala Collection" came about), but the simple "."
    resulted in the most familiar appearance.

    Remember, shape is the most important aspect of small ascii art. There
    are so many different shaped ascii characters available that there
                                  is bound to be one which fits the needs
              _ .                 of the picture. This example is a "mini"
           __CL\H--.              Millennium Falcon. Since I'd already
          L__/_\H' \\--_-         drawn a bigger one, I knew exactly what
           __L_(=): ]-_ _-- -     shape it needed to be, and what features
          T__\ /H. //---- -       it needed to make it look like the Falcon.
             ~^-H--'
                "                 Picking out the main features is a good
                                  step, and then find chars which closely
    resemble them. The blasters on top of the Falcon were well emulated by
    the "=" for example. The combination of "CL" worked perfectly as the
    cockpit, as did a simple ":" for the distinctive markings on it's back.

    Simplicity is the key in small art, but that doesn't necessarily make
    things any easier. Many things simply cannot be successfully drawn in
    small sizes, so a touch of planning can sometimes help.

4. Solid Art

    Solid ascii art differs from line art in that the resulting image is
    more of a "silhouette" rather than an outline.

    By using a "heavy" character such as: W M H 8 :you build up a basic
    silhouette (filled in outline), and then use other characters to anti-
    alias (smoothen) the image.

    "W" and "M" are the darkest characters in most character sets, but they
    do vary quite a lot and are a bit too bottom/top heavy which ruins the
    effect somewhat. "H" and "8" also produce patterns of similar darkness,
    but result in two different "looks". The "H" is more stark and rigid,
    whereas the "8" produces a more "bubbly" appearance (which prints up
    quite well apparently).

            WWWWWWWW       MMMMMMMM       HHHHHHHH       88888888
            WWWWWWWW       MMMMMMMM       HHHHHHHH       88888888
            WWWWWWWW       MMMMMMMM       HHHHHHHH       88888888
            WWWWWWWW       MMMMMMMM       HHHHHHHH       88888888

    I originally used "M" and "W" since they worked well with the font I once
    used, but now I use "H" because I like its consistency. Other people
    prefer "8", so it's really just a matter of personal taste. Indeed,
    remapping an image from one type into another is quite simple, and should
    not affect the picture at all.

    Different effects can be created by varying the chosen texture over
    various sections of the picture (shading). The choice of character can
    also be based on the subject matter, for example, if money were involved
    the obvious choice would be a "$". Try to avoid using "*" though, as it
    looks a bit cheesy (imho).

    Once the basic shape is defined with the chosen character, the anti-
    aliasing process is next. The most used chars are:

    d b P F 9 V T Y A U _ , . - * ^ ~ " ` ' n a o l L j J k [ ] ( ) : \ / | !

    Each character has a purpose based on its shape, although there are
    cases where no character will produce perfect results. In these cases,
    you either have to make do as best you can, or remodel that particular
    area of the picture, thus giving you a fresh approach.

    Going back to the earlier "curve" examples, here they are in solid form:

                  .adAHHHAbn.                           JHH
                 dHHHHHHHHHHHb                      _.adHHH
                dHHHHHHHHHHHHHb                   ,AHHHHHHH
                HHHHHHHHHHHHHHH                  dHHHHHHHHH
                VHHHHHHHHHHHHHP                 JHHHHHHHHHH
                 YHHHHHHHHHHHP              _.adHHHHHHHHHHH
                  "^YUHHHUP^"              HHHHHHHHHHHHHHHH
                      "~"
                    SPHERE                   CURVED HILL

    It's important to get a good understanding of how best to use the
    characters. The basic forms are as follows:

          _,.aomdAHAbmon.,_     For the upper curves.

            "~^*YUHUP*^~"       For the lower curves.

    The characters: d b P :are all extremely useful, but there is no
    equivalent character for bottom/left. There is, however, four chars
    available which do a decent job: T Y V 9 .The 9 works well for *some*
    char sets, but generally it has a big hook at the bottom so isn't
    quite so useful.

    Notice how I've used "A" and "U" to smoothen the transistion from "H"
    to "d"/"b" (and "Y"/"P" respectively) even though the effect is quite
    subliminal. A minor detail, but it does help. I don't often use "_"
    in these types of pics because of the way it touches the top of the
    "H". It does come in handy sometimes though.

    Side curves require more of an "on the spot" approach. The chars:
    l [ ] : j i :all come in handy when trying to smoothen out vertical
    curves, and I've also seen "(" and ")" used (although I wouldn't use
    them myself). Consistency in contrast is very important.

    Adding details using the solid ascii technique is a bit harder than
    in line art because there isn't the same number of possible choices
    for each position. The letters: a n o :are all very useful because
    they are nice "solid" chars which only occupy the bottom half of the
    character space, but there is no good alternative for the top half.

             dHF^^^      See how the bottom arm fits in with the solid
            dHP          appearance of the main part, yet the "^" (which
           dHBooan       is the closest char available) doesn't look so
                         beefy. Even the "^" varies across different char
    sets, so that leaves just: " ~ : which are of no use at all. In that
    particular case, it is necessary to expand the picture by one line:

              anpoan     Note the use of the "p" to make the effect just
             dHP         that little bit more effective. An "r" could also
            dHP          work well at the end of each arm. Purely cosmetic
           dHBooan       though. Note that if you're using "M" or "W", then
                         "m" and "w" can be used to keep it consistent.

    Details aren't always as simple as that example though (unfortunately).

                   HHHH              aann               .aoon.
           HHHHHHHHHHHHH      aanndHHHHHHP"     "^vaondAHHHHHP"
                HHHHHHH         "~^YHHHHH           "~^SHHHHH
              HHHHHHHHHH          dHHHHHHb          .adHHHHHHh,
                   HHHHHH           ~^VHHHP             ~^VHHHP
                     HH                YHP                 "VP

                 START            HALF WAY           FINISHED

    The different steps can be seen here. Starting by roughing out the shape
    (a wizards head incidentally) using the chosen character. Next, go over
    all the edges making all the obvious replacements. That means using:
    d P b Y V a n :plus the occasional: " ~ :if there's an obvious place for
    it. Just enough to give it some shape.

    The final stage requires a bit more work. Start with "A" and "U"/"V",
    and then the rest is purely experimentation. The "S" was chosen because
    it seemed to have the right shape, although there are many chars which
    could really go there.

    The curve section at the back required quite a lot of work. An "a" seems
    to be the best opposite of "n", and for long stretches, I like to use
    some "o"'s in there just to mix it up a bit. The: "^ :piece at the end
    was an obvious combination, so it was just a matter of finding a char
    to connect the "a" to the "^". As it turned out, "v" was custom made
    for that position.

          WMHI:    .:IHb.      I     Smooth shading can be created by using
          MH[:   .adAHHHI:.   :H     different chars to fade out at the edges,
          HI:  .:IHHHHHI:'  .jIH     instead of the anti-aliasing (which
          Y:     `:YHHI:' .:|IHM     produces hard edges).

    Good "outer" characters are:    . , : ; ' `
    For the transition from solid to outer edge:   I H A U V T Y | i j d b
    n a o [ ]   :or basically anything that produces the desired effect.

    Both line and solid techniques can be combined together, resulting in
    a "comic book" look and feel. Each form of ascii art works well in
    certain circumstances, so why not use this to your advantage. Line art
    for the various outlines and small details, and solid art for large
    dark areas.

5. 3 Dimensional Art

    3D ascii art is basically an extension of SIRDS, where you can create
    the illusion of depth on a flat surface. This is achieved by producing
    two slightly different versions of the one picture, and placing them
    a certain distance apart.

                .                 .   Focus Point
               / \
              /   \               x   Where the image appears
             /  x  \
           ---     ---            __  The original pictures on the screen
           /         \
          /           \           /\  Where your eyes are looking
         /             \
        O               O         OO  Your eyes

            PLAN VIEW

    Although the scale and angles are a bit off, the basic principle can
    be seen from the above diagram (seen looking down). The two versions
    of the picture are located on the screen, but you don't look there.
    You need to focus on a point *past* the screen which produces a third
    image at "x".

    This resulting image occurs because of the way eyes work. They can only
    focus on one "depth" at a time, and anything either further away or
    closer becomes blurred. These "blurs" are just two different views of
    the one object produced by the two eyes seeing different things.

    Try this: stand three feet from a wall. Now hold two fingers up about
    one foot from your face, and about 1.5 centimeters apart. Look between
    your fingers, and focus onto the wall. Keep focus on the wall, but
    look into the foreground at your fingers. You should see a ghost image
    from both fingers converging into the center. The trick is to make the
    two ghost images overlap each other resulting in (hopefully) one solid
    image. This image should appear at a different level than the originals:

                           |  |                |  |  |
                           |  |                |  |  |

                       TWO FINGERS         RESULTING IMAGE

    The results from this experiment won't be 100% perfect since your two
    fingers are likely to be different, but it is a good way to understand
    the concept. With a little practice, you should be able to focus on real
    3D pictures without too much effort.

       ---  ---   Note that if you cross your eyes instead of using the
         \  /     above technique, you actually see the picture in reverse.
          \/      This diagram shows the effect from above, and the resulting
          /\      image will appear where the lines cross over. Since most
         /  \     stereograms (STARE-eograms?) are created to go into the
        /    \    screen, looking at them this way will produce an incorrect
       O      O   vision (and is somewhat harder on the eyes).

    That's the hard part out of the way, now a bit about how to create them.
    Getting back to the little koala example (which is a perfect size for
    this type of work), lets bring him into 3 dimensions.

             X         X          Here I have placed two koalas 10 chars
            ___       ___         apart from each other. Generally, a good
          {~._.~}   {~._.~}       distance would be between 7 and 15 chars,
           ( Y )     ( Y )        although you can use any distance you like.
          ()~*~()   ()~*~()       Values outside those bounds tend to be
          (_)-(_)   (_)-(_)       difficult to focus on however.

    The distance determines how much the resulting image sits "into" the
    screen. If the distance is 0 (ie. no separation), the image is neutral
    which means it appears -at- the screen. As the distance is increased,
    the resulting image appears further -into- the screen.

    By having many koalas laid out across the screen (all separated by the
    same distance), the effect becomes slightly easier to focus on. Any
    extra layers should then be added across the whole picture, with the
    result being quite effective.

    The picture is quite boring so far, with just one layer of 3D being
    created, so the next thing to do is to add another layer or two.
    The "tried and tested" approach is to add a "pole" in front of him,
    and since we want it -in front- of the existing layer, each pole
    should be 9 chars apart:
     _        _        _        _        _        _        _        _
    (_)      (_)      (_)      (_)      (_)      (_)      (_)      (_)
     H___     H ___    H  ___   H   ___  H    ___ H     ___H      __H
    {H._.~}   H~._.~}  H{~._.~} H {~._.~}H  {~._.~H   {~._.H}   {~._H~}
     H Y )    H( Y )   H ( Y )  H  ( Y ) H   ( Y )H    ( Y H     ( YH)
    (H~*~()   H)~*~()  H()~*~() H ()~*~()H  ()~*~(H   ()~*~H)   ()~*H()
    (H)-(_)   H_)-(_)  H(_)-(_) H (_)-(_)H  (_)-(_H   (_)-(H)   (_)-H_)
     H        H        H        H        H        H        H        H
    ~"~~~~~~~~"~~~~~~~~"~~~~~~~~"~~~~~~~~"~~~~~~~~"~~~~~~~~"~~~~~~~~"~~

    Notice that since the pole is to appear in front of the koala, it
    actually replaces the koala where they overlap. Here's the same pic
    except the pole appears behind the koala:
          _          _          _          _          _          _
         (_)        (_)        (_)        (_)        (_)        (_)
      ___ H     ___  H    ___   H   ___    H  ___     H ___      H___
    {~._.~}   {~._.~}H  {~._.~} H {~._.~}  H{~._.~}   {~._.~}   {~._.~}
     ( Y )H    ( Y ) H   ( Y )  H  ( Y )   H ( Y )    H( Y )     ( Y )
    ()~*~()   ()~*~()H  ()~*~() H ()~*~()  H()~*~()   ()~*~()   ()~*~()
    (_)-(_)   (_)-(_)H  (_)-(_) H (_)-(_)  H(_)-(_)   (_)-(_)   (_)-(_)
          H          H          H          H          H          H
    ~~~~~~"~~~~~~~~~~"~~~~~~~~~~"~~~~~~~~~~"~~~~~~~~~~"~~~~~~~~~~"~~~~~

    Now, since the pole is to appear behind the koala, its chars do not
    write over the koala where they overlap. The poles here are 11 chars
    apart, so appear one "step" behind the koala. All layers are built like
    this, and of course I could have the poles both behind and in front of
    the koala in the same picture. Here's a multi-layer example:
          _               _
       .-~ \           .-~ \
      /     \  _      /     \ _
      ~x    .-~_)_    ~x   .-~_)_        This picture has 3 distinct layers:
        ~>x".-~   ~-.   ~x".-~   ~-.     the hat, head and face. There are
         ( /         \  ( /         \    many other examples of 3D ascii
          T  o  o     Y  T o  o      Y   around, plus there are programs
          l   <       !  l  <        !   available for the easy creation
           \  .__/   /    \  ._/    /    of SIRDS.
            "-.___.-'      "-.___.-'

    A quick examination of the above picture shows that the head (circle),
    part of the hat and a part of the mouth are all 15 characters apart.
    The rest of the face is just 14 chars apart, and the top section of
    the hat is 16 chars apart.

    Note that all this information is from pure observation, so it may not
    be 100% accurate.

6. Conclusion

    Perhaps there's more to ascii art than
    meets the eye? Before writing this, I                   .
    had no idea just how much thought goes              /\ /l
    into creating ascii pictures, and I                ((.Y(!
    imagine that I haven't even begun to                \ |/
    cover it all.                                       /  6~6,
                                                        \ _    +-.
    Analyzing the work of other people is                \`-=--^-'
    a great way to learn what works, and                  \ \
    what doesn't. Analyzing "art" may seem               _/  \
    like a strange concept, but it does                 (  .  Y
    open your awareness to the art form, and            /"\ `--^--v--.
    it's a great way to learn the various              / _ `--"T~\/~\/
    techniques. I hope that you have found            / " ~\.  !
    my ideas about ascii interesting.           _    Y      Y./'
                                               Y^|   |      |~~7
    In the end however, it's up to the         | l   |     / ./'
    individual artist to work the way they     | `L  | Y .^/~T
    want to, and not necessarily the way       |  l  ! | |/| |   -Row
    someone else would do it. Finding          | .`\/' | Y | !
    your own style is all part of the fun,     l  "~   j l j_L______
    and perhaps this text will aid people       \,____{ __"~ __ ,\_,\_
    in finding that style.                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    :D

to Rowan Crawford's ASCII Art

.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:._.:*~*:.

```
