---
title: Software_engineering <- StackExchange top 100
category: software_engineering
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: Which hashing algorithm is best for uniqueness and speed? (score [630764](https://stackoverflow.com/q/49550) in 2013)

#### Question
Which hashing algorithm is best for uniqueness and speed? Example (good) uses include hash dictionaries.   

I know there are things like <a href="http://en.wikipedia.org/wiki/SHA-2">SHA-256</a> and such, but these algorithms are <strong>designed</strong> to be <strong>secure</strong>, which usually means they are slower than algorithms that are less <em>unique</em>. I want a hash algorithm designed to be fast, yet remain fairly unique to avoid collisions.   

#### Answer accepted (score 2468)
I tested some different algorithms, measuring speed and number of collisions.  

I used three different key sets:  

<ul>
<li><a href="http://www.sitopreferito.it/html/all_english_words.html" rel="noreferrer">A list of 216,553 English words</a> (in lowercase)</li>
<li>The numbers `"1"` to `"216553"` (think ZIP codes, and <a href="http://blogs.msdn.com/b/ericlippert/archive/2003/09/19/arrrrr-cap-n-eric-be-learnin-about-threadin-the-harrrrd-way.aspx" rel="noreferrer">how a poor hash took down msn.com</a>)</li>
<li>216,553 "random" (i.e. <a href="http://www.ietf.org/rfc/rfc4122.txt" rel="noreferrer">type 4 uuid</a>) GUIDs</li>
</ul>

For each corpus, the number of collisions and the average time spent hashing was recorded.  

I tested:  

<ul>
<li><a href="http://www.cse.yorku.ca/~oz/hash.html" rel="noreferrer">DJB2</a></li>
<li><a href="http://www.cse.yorku.ca/~oz/hash.html" rel="noreferrer">DJB2a</a> (variant using `xor` rather than `+`)</li>
<li><a href="http://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function" rel="noreferrer">FNV-1</a> (32-bit)</li>
<li><a href="http://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function" rel="noreferrer">FNV-1a</a> (32-bit)</li>
<li><a href="http://www.cse.yorku.ca/~oz/hash.html" rel="noreferrer">SDBM</a></li>
<li>CRC32</li>
<li><a href="http://en.wikipedia.org/wiki/MurmurHash" rel="noreferrer">Murmur2</a> (32-bit)</li>
<li><a href="http://landman-code.blogspot.ca/2008/06/superfasthash-from-paul-hsieh.html" rel="noreferrer">SuperFastHash</a></li>
</ul>

<h5>Results</h2>

Each result contains the average hash time, and the number of collisions  

```
Hash           Lowercase      Random UUID  Numbers
=============  =============  ===========  ==============
Murmur            145 ns      259 ns          92 ns
                    6 collis    5 collis       0 collis
FNV-1a            152 ns      504 ns          86 ns
                    4 collis    4 collis       0 collis
FNV-1             184 ns      730 ns          92 ns
                    1 collis    5 collis       0 collis▪
DBJ2a             158 ns      443 ns          91 ns
                    5 collis    6 collis       0 collis▪▪▪
DJB2              156 ns      437 ns          93 ns
                    7 collis    6 collis       0 collis▪▪▪
SDBM              148 ns      484 ns          90 ns
                    4 collis    6 collis       0 collis**
SuperFastHash     164 ns      344 ns         118 ns
                   85 collis    4 collis   18742 collis
CRC32             250 ns      946 ns         130 ns
                    2 collis    0 collis       0 collis
LoseLose          338 ns        -             -
               215178 collis
```

<strong>Notes</strong>:  

<ul>
<li>The <a href="http://www.cse.yorku.ca/~oz/hash.html" rel="noreferrer">LoseLose algorithm</a> (where hash = hash+character) is truly <strong><em>awful</em></strong>. Everything collides into the same 1,375 buckets</li>
<li>SuperFastHash is fast, with things looking pretty scattered; by my goodness the <em>number</em> collisions. I'm hoping <a href="http://landman-code.blogspot.ca/2008/06/superfasthash-from-paul-hsieh.html" rel="noreferrer">the guy who ported it got something wrong; it's pretty bad</a></li>
<li>CRC32 is <em>pretty good</em>. Slower, and a 1k lookup table</li>
</ul>

<h5>Do collisions actually happen?</h2>

Yes. I started writing my test program to see if hash collisions <em>actually</em> happen - and are not just a theoretical construct. They do indeed happen:  

<strong>FNV-1 collisions</strong>  

<ul>
<li>`creamwove` collides with `quists`</li>
</ul>

<strong>FNV-1a collisions</strong>  

<ul>
<li>`costarring` collides with `liquid`</li>
<li>`declinate` collides with `macallums`</li>
<li>`altarage` collides with `zinke`</li>
<li>`altarages` collides with `zinkes`</li>
</ul>

<strong>Murmur2 collisions</strong>  

<ul>
<li>`cataract` collides with `periti`</li>
<li>`roquette` collides with `skivie`</li>
<li>`shawl` collides with `stormbound`</li>
<li>`dowlases` collides with `tramontane`</li>
<li>`cricketings` collides with `twanger`</li>
<li>`longans` collides with `whigs`</li>
</ul>

<strong>DJB2 collisions</strong>  

<ul>
<li>`hetairas` collides with `mentioner`</li>
<li>`heliotropes` collides with `neurospora`</li>
<li>`depravement` collides with `serafins`</li>
<li>`stylist` collides with `subgenera`</li>
<li>`joyful` collides with `synaphea`</li>
<li>`redescribed` collides with `urites`</li>
<li>`dram` collides with `vivency`</li>
</ul>

<strong>DJB2a collisions</strong>  

<ul>
<li>`haggadot` collides with `loathsomenesses`</li>
<li>`adorablenesses` collides with `rentability`</li>
<li>`playwright` collides with `snush`</li>
<li>`playwrighting` collides with `snushing`</li>
<li>`treponematoses` collides with `waterbeds`</li>
</ul>

<strong>CRC32 collisions</strong>  

<ul>
<li>`codding` collides with `gnu`</li>
<li>`exhibiters` collides with `schlager`</li>
</ul>

<strong>SuperFastHash collisions</strong>  

<ul>
<li>`dahabiah` collides with `drapability`</li>
<li>`encharm` collides with `enclave`</li>
<li>`grahams` collides with `gramary`</li>
<li>...snip 79 collisions...</li>
<li>`night` collides with `vigil`</li>
<li>`nights` collides with `vigils`</li>
<li>`finks` collides with `vinic`</li>
</ul>

<h5>Randomnessification</h2>

The other subjective measure is how randomly distributed the hashes are. Mapping the resulting HashTables shows how evenly the data is distributed. All the hash functions show good distribution when mapping the table linearly:  

<img src="https://i.stack.imgur.com/bmYSu.png" alt="Enter image description here">  

Or as a <a href="http://en.wikipedia.org/wiki/Hilbert_curve" rel="noreferrer"><em>Hilbert Map</em></a> (<a href="http://xkcd.com/195/" rel="noreferrer">XKCD is always relevant</a>):  

<img src="https://i.stack.imgur.com/N8r3K.png" alt="Enter image description here">  

Except when hashing number strings (`"1"`, `"2"`, ..., `"216553"`) (for example, <a href="http://blogs.msdn.com/b/ericlippert/archive/2003/09/19/arrrrr-cap-n-eric-be-learnin-about-threadin-the-harrrrd-way.aspx" rel="noreferrer">zip codes</a>), where patterns begin to emerge in most of the hashing algorithms:  

<strong>SDBM</strong>:  

<img src="https://i.stack.imgur.com/1JuXp.jpg" alt="Enter image description here">  

<strong>DJB2a</strong>:  

<img src="https://i.stack.imgur.com/0WjPn.jpg" alt="Enter image description here">  

<strong>FNV-1</strong>:  

<img src="https://i.stack.imgur.com/0f4L3.jpg" alt="Enter image description here">  

All except <strong>FNV-1a</strong>, which still look pretty random to me:  

<img src="https://i.stack.imgur.com/wEvjm.jpg" alt="Enter image description here">  

In fact, <strong>Murmur2</strong> seems to have even better randomness with `Numbers` than `FNV-1a`:  

<img src="https://i.stack.imgur.com/JYwBf.png" alt="Enter image description here">  

<blockquote>
  <em>When I look at the `FNV-1a` "number" map, I <strong>think</strong> I see subtle vertical patterns. With Murmur I see no patterns at all. What do you think?</em>  
</blockquote>

<hr>

The extra <strong>`*`</strong> in the table denotes how bad the randomness is. With `FNV-1a` being the best, and <strong>`DJB2x`</strong> being the worst:  

```
      Murmur2: .
       FNV-1a: .
        FNV-1: ▪
         DJB2: ▪▪
        DJB2a: ▪▪
         SDBM: ▪▪▪
SuperFastHash: .
          CRC: ▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪
     Loselose: ▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪
                                        ▪
                                 ▪▪▪▪▪▪▪▪▪▪▪▪▪
                        ▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪
          ▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪▪
```

I originally wrote this program to decide if I even had to <em>worry</em> about collisions: I do.  

And then it turned into making sure that the hash functions were sufficiently random.  

<h5>FNV-1a algorithm</h2>

The FNV1 hash comes in variants that return 32, 64, 128, 256, 512 and 1024 bit hashes.  

The <a href="http://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function" rel="noreferrer">FNV-1a algorithm</a> is:  

```
hash = FNV_offset_basis
for each octetOfData to be hashed
    hash = hash xor octetOfData
    hash = hash * FNV_prime
return hash
```

Where the constants `FNV_offset_basis` and `FNV_prime` depend on the return hash size you want:  

```
Hash Size  
===========
32-bit
    prime: 2^24 + 2^8 + 0x93 = 16777619
    offset: 2166136261
64-bit
    prime: 2^40 + 2^8 + 0xb3 = 1099511628211
    offset: 14695981039346656037
128-bit
    prime: 2^88 + 2^8 + 0x3b = 309485009821345068724781371
    offset: 144066263297769815596495629667062367629
256-bit
    prime: 2^168 + 2^8 + 0x63 = 374144419156711147060143317175368453031918731002211
    offset: 100029257958052580907070968620625704837092796014241193945225284501741471925557
512-bit
    prime: 2^344 + 2^8 + 0x57 = 35835915874844867368919076489095108449946327955754392558399825615420669938882575126094039892345713852759
    offset: 9659303129496669498009435400716310466090418745672637896108374329434462657994582932197716438449813051892206539805784495328239340083876191928701583869517785
1024-bit
    prime: 2^680 + 2^8 + 0x8d = 5016456510113118655434598811035278955030765345404790744303017523831112055108147451509157692220295382716162651878526895249385292291816524375083746691371804094271873160484737966720260389217684476157468082573
    offset: 1419779506494762106872207064140321832088062279544193396087847491461758272325229673230371772250864096521202355549365628174669108571814760471015076148029755969804077320157692458563003215304957150157403644460363550505412711285966361610267868082893823963790439336411086884584107735010676915
```

See <a href="http://www.isthe.com/chongo/tech/comp/fnv/index.html#FNV-param" rel="noreferrer">the main FNV page</a> for details.  

All my results are with the 32-bit variant.  

<h5>FNV-1 better than FNV-1a?</h2>

No. FNV-1a is all around better. There was more collisions with FNV-1a when using the English word corpus:  

```
Hash    Word Collisions
======  ===============
FNV-1   1
FNV-1a  4
```

Now compare lowercase and uppercase:  

```
Hash    lowercase word Collisions  UPPERCASE word collisions
======  =========================  =========================
FNV-1   1                          9
FNV-1a  4                          11
```

In this case FNV-1a isn't <em>"400%"</em> worse than FN-1, only 20% worse.  

I think the more important takeaway is that there are two classes of algorithms when it comes to collisions:  

<ul>
<li><strong>collisions rare</strong>: FNV-1, FNV-1a, DJB2, DJB2a, SDBM</li>
<li><strong>collisions common</strong>: SuperFastHash, Loselose</li>
</ul>

And then there's the how evenly distributed the hashes are:  

<ul>
<li><strong>outstanding distribution:</strong> Murmur2, FNV-1a, SuperFastHas</li>
<li><strong>excellent distribution:</strong> FNV-1</li>
<li><strong>good distribution:</strong> SDBM, DJB2, DJB2a</li>
<li><strong>horrible distribution:</strong> Loselose</li>
</ul>

<hr>

<strong>Update</strong>  

Murmur? <em>Sure, why not</em>  

<hr>

<strong>Update</strong>  

@whatshisname wondered how a <strong>CRC32</strong> would perform, added numbers to the table.  

CRC32 is <em>pretty good</em>. Few collisions, but slower, and the overhead of a 1k lookup table.  

<em>Snip all erroneous stuff about CRC distribution - my bad</em>  

<hr>

Up until today I was going to use FNV-1a as my <em>de facto</em> hash-table hashing algorithm. But now I'm switching to Murmur2:  

<ul>
<li>Faster</li>
<li>Better <em>randomnessification</em> of all classes of input</li>
</ul>

And I really, <em>really</em> hope there's something wrong with the <a href="http://landman-code.blogspot.ca/2008/06/superfasthash-from-paul-hsieh.html" rel="noreferrer">`SuperFastHash` algorithm I found</a>; it's too bad to be as popular as it is.  

<strong>Update:</strong> From <a href="http://code.google.com/p/smhasher/wiki/MurmurHash3" rel="noreferrer">the MurmurHash3 homepage on Google</a>:  

<blockquote>
  (1) - SuperFastHash has very poor collision properties, which have been documented elsewhere.  
</blockquote>

So I guess it's not just me.  

<strong>Update:</strong> I realized why `Murmur` is faster than the others. MurmurHash2 operates on four bytes at a time. Most algorithms are <em>byte by byte</em>:  

```
for each octet in Key
   AddTheOctetToTheHash
```

This means that as keys get longer Murmur gets its chance to shine.  

<hr>

<strong>Update</strong>  

<h5><a href="http://blogs.msdn.com/b/oldnewthing/archive/2012/05/23/10309199.aspx" rel="noreferrer">GUIDs are designed to be unique, not random</a></h2>

A timely post by Raymond Chen reiterates the fact that <em>"random"</em> GUIDs are not meant to be used for their randomness. They, or a subset of them, are unsuitable as a hash key:  

<blockquote>
  Even the Version 4 GUID algorithm is not guaranteed to be unpredictable, because the algorithm does not specify the quality of the random number generator. <a href="http://en.wikipedia.org/wiki/Globally_unique_identifier" rel="noreferrer">The Wikipedia article for GUID contains primary research which suggests</a> that future and previous GUIDs can be predicted based on knowledge of the random number generator state, since the generator is not cryptographically strong.  
</blockquote>

Randomess is not the same as collision avoidance; which is why it would be a mistake to try to invent your own "hashing" algorithm by taking some subset of a "random" guid:  

```
int HashKeyFromGuid(Guid type4uuid)
{
   //A "4" is put somewhere in the GUID.
   //I can't remember exactly where, but it doesn't matter for
   //the illustrative purposes of this pseudocode
   int guidVersion = ((type4uuid.D3 & 0x0f00) >> 8);
   Assert(guidVersion == 4);

   return (int)GetFirstFourBytesOfGuid(type4uuid);
}
```

<strong>Note</strong>: Again, I put <em>"random GUID"</em> in quotes, because it's the "random" variant of GUIDs. A more accurate description would be `Type 4 UUID`. But nobody knows what type 4, or types 1, 3 and 5 are. So it's just easier to call them "random" GUIDs.  

<h5>All English Words mirrors</h1>

<ul>
<li><a href="https://web.archive.org/web/20070221060514/http://www.sitopreferito.it/html/all_english_words.html" rel="noreferrer">https://web.archive.org/web/20070221060514/http://www.sitopreferito.it/html/all_english_words.html</a></li>
<li><a href="https://drive.google.com/file/d/0B3BLwu7Vb2U-dEw1VkUxc3U4SG8/view?usp=sharing" rel="noreferrer">https://drive.google.com/file/d/0B3BLwu7Vb2U-dEw1VkUxc3U4SG8/view?usp=sharing</a></li>
</ul>

#### Answer 2 (score 59)
If you are wanting to create a hash map from an unchanging dictionary, you might want to consider perfect hashing <a href="https://en.wikipedia.org/wiki/Perfect_hash_function">https://en.wikipedia.org/wiki/Perfect_hash_function</a> - during the construction of the hash function and hash table, you can guarantee, for a given dataset, that there will be no collisions.  

#### Answer 3 (score 34)
<a href="http://www.cse.yorku.ca/~oz/hash.html">Here</a> is a list of hash functions, but the short version is:  

<blockquote>
  If you just want to have a good hash function, and cannot wait, `djb2` is one of the best string hash functions i know. It has excellent distribution and speed on many different sets of keys and table sizes  
</blockquote>

```
unsigned long
hash(unsigned char *str)
{
    unsigned long hash = 5381;
    int c;

    while (c = *str++)
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */

    return hash;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: Why isn't Java used for modern web application development? (score [591436](https://stackoverflow.com/q/102090) in 2011)

#### Question
As a professional Java programmer, I've been trying to understand - why the hate toward Java for modern web applications?  

I've noticed a trend that out of modern day web startups, a relatively small percentage of them appears to be using Java (compared to Java's overall popularity).  When I've asked a few about this, I've typically received a response like, "I hate Java with a passion."  But no one really seems to be able to give a definitive answer.  

I've also heard this same web startup community refer negatively to Java developers - more or less implying that they are slow, not creative, old.  

As a result, I've spent time working to pick up Ruby/Rails, basically to find out what I'm missing.  But I can't help thinking to myself, "I could do this much faster if I were using Java," primarily due to my relative experience levels.    

But also because I haven't seen anything critical "missing" from Java, preventing me from building the same application.  

<em>Which brings me to my question(s)</em>:  

Why is Java not being used in modern web applications?    

<ul>
<li><p>Is it a weakness of the language?  </p></li>
<li><p>Is it an unfair stereotype of Java because it's been around so long (it's been unfairly associated with its older technologies, and doesn't receive recognition for its "modern" capabilities)? </p></li>
<li><p>Is the negative stereotype of Java developers too strong? (Java is just no longer "cool")</p></li>
<li><p>Are applications written in other languages really faster to build, easier to maintain, and do they perform better?</p></li>
<li><p>Is Java only used by big companies who are too slow to adapt to a new language?</p></li>
</ul>

#### Answer accepted (score 174)
Modern day startups need to hit the market as soon as possible. They don't need to spend about six months in order to release their Java web application.    

Twitter for example was built using Rails/Ruby but once it became unscalable, they migrated to the JVM.  

Not to mention that the development process isn't productive: code -> compile -> deploy while it is in frameworks like (Rails/Django/Grails): run testing server -> code -> change things and see what happens.  

The good news is that <a href="http://www.zeroturnaround.com/jrebel/">JRebel</a>  lets you see code changes instantly.  

#### Answer 2 (score 136)
In my experience, Java for web applications is overkill for small applications. A simple blog with one database table hold blog entries, for example, could be done in something much simpler.   

I have usually seen Java do much better in much larger web applications (think banks and insurance companies) that communicate with a number of other systems (such as mainframe back-ends and databases and peer web-services background batch-processing systems... all in the same application).  

From what I've seen, the architecture of a JavaEE web application is just usually more than is needed for small/simple web applications.  

#### Answer 3 (score 135)
I programmed java web apps for 10 years before I switched to python, 4+ years ago. I feel that I'm much more productive using python and can get much more done in a shorter period of time, and to be honest, I'm much happier when I develop in python. Here are some of the reasons why I think python is better then Java based on my personal experience, your milage may very.  

<h5>Web Frameworks:</h2>

When I first start programming web apps in Java, Struts just came out, and it wasn't great, but it was the best thing available. I created a bunch of struts apps, and a few in other frameworks along the way. Whenever a new framework came out (Tapestry, Wicket, GWT, stripe, grails, AppFuse, Play, RichFaces, Spring, etc), I would try it out and see if it was any better, and most times it was only a little better, and sometimes not better at all. I do have to say the play framework is a step in the right direction.  

<h5>Batteries not included:</h2>

One of the most annoying parts of Java was the fact that most of the libraries that you use were not included in java itself, you had to include a ton of 3rd party libs from places like apache commons. If you use something like hibernate with any other large library, you end up in Jar dependency hell, where hibernate needs one version of a jar, and something else needs another version. If you load the jar files in the wrong order, you are out of luck. You need to depend on tools like maven, and ivy to manage your dependencies, and this just brings in more dependencies into your project which results in projects being huge. I had some war files 100MB+ war files for the simplest web apps.  

<h5>Too many options:</h2>

For some reason there seems to be way too many different ways to do the same thing in Java. There are over 38 different web frameworks for java according to wikipedia ( <a href="http://en.wikipedia.org/wiki/Comparison_of_web_application_frameworks#Java">http://en.wikipedia.org/wiki/Comparison_of_web_application_frameworks#Java</a> ) and 23 different ORM's ( <a href="http://en.wikipedia.org/wiki/List_of_object-relational_mapping_software#Java">http://en.wikipedia.org/wiki/List_of_object-relational_mapping_software#Java</a> ) just to name a couple of examples. If you look at other languages they have a more reasonable number. Some people think that having lots of options is a good thing, but it isn't it leads to a lot of wasted effort in the developer community, everyone is reinventing the same wheel, and if you are a new person to the language you have too many option to pick from.  

<h5>App servers:</h2>

Java web applications are really heavy, and require a lot of resources to run. They are especially memory hungry. Like any piece of software they can be tuned to reduce their resource footprint, but compared to other languages their out of the box setup is horrible. In my past I have used weblogic, websphere, Jboss, tomcat, and jetty. I only used the first three when I was forced to use EJB's, but even if you aren't using EJB's they were large app servers and sometimes hard to configure and get running correctly. Tomcat and Jetty are much better and easier to setup, but are still resource hogs.   

<h5>App Hosting:</h2>

If you aren't running your own server it is real hard to find shared hosting for your java apps at a reasonable price. The main reason is because java apps require much more memory compared to other languages, so it doesn't make sense for a shared hosting provider to spend their valuable RAM running a java site, when they could run 5 php sites in the same place. That means there are less providers offering java hosting, which in turn means higher costs to run your website.  

<h5>Development Time:</h2>

When I developing in java, I found myself much slower then what I can do in python. I would need to make a change, compile, redeploy and then test, and this slows down the iterative process. I know there are ways to make this faster, but even at it's best, I felt much slower then what I can do in python.   

There is also a lot less boilerplate code to do the same thing in python, so I spend less time developing the code as well.  

Java just feels over engineered in a lot of parts, A lot of the API's and interfaces are just way to complicated for what you want to do. And everyone and their brother thinks they are a java architect and this results in big complicated systems that are hard to use and develop with.   

<h5>IDE:</h2>

When I was developing in Java, I felt stuck to the IDE, I was lost without it. IntelliJ is the best IDE's on the market, and it was hard switching to python because there wasn't anything like it for python. So instead of an IDE, I just used textmate, which is just a normal text editor. It was hard at first, but because it was just a text editor, it was a really fast and responsive application. I could open my whole project in a few seconds, whereas when I want to open a project in an IDE it could take a minute or more, with a machine with a ton of RAM. The makers of IntelliJ came out with a python editor called pycharm, I bought it when it first came out, and it is great. But what I realized is that I don't need an IDE for python, I'm fine with a text editor. When I go back to working on Java web apps which I have to do from time to time, I try to use the text editor, but I haven't quite mastered that yet. I personally need the IDE for Java more because If I mess up something it takes longer to recompile and redeploy, which slows me down.   

<h5>ORM:</h2>

When I first started using Hibernate as an ORM, I thought it was great, it had it's problems, and it wasn't perfect, but it was better then what I was doing before. I was happy with it, until I did an application with Django's ORM on a python project, and that opened up my eyes, that is how an ORM is supposed to work. After that project I went back to hibernate, and I just felt disappointed, and longed for going back to Django's ORM. Another great python ORM is sqlalchemy, which is similar to Django's ORM, but a little different. I have limited experience with ROR's ORM, but from what I remember, it was pretty good as well.  

<h5>Templates:</h2>

The web templating systems in Java aren't that good, and I think I have tried them all (tiles, freemarker, velocity, etc). Most of them offer only basic functionality and are a pain to work with. On the Python side, my two favorites are Django templates and Jinja2, they have everything that I could need in a templating engine, and are really easy to use.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: Tabs versus spaces—what is the proper indentation character for everything, in every situation, ever? (score [581649](https://stackoverflow.com/q/57) in 2011)

#### Question
The coding standards for the code hosted in drupal.org suggest to use two spaces to indent the code; other sites suggest to use tabs to indent the code.  

What is the proper indentation character for everything, and in every situation? Please explain the answer you give.  

#### Answer accepted (score 129)
<strong>Spaces</strong>  

<p>A tab could be a different number of columns 
depending on your environment, but a space is always one column. </p>

In terms of how many spaces (or tabs) constitutes indentation, it's more important to be consistent throughout your code than to use any specific tab stop value.  

#### Answer 2 (score 249)
<strong>Tabs</strong>  

Now, of course, consistency matters more than either one, and a good IDE makes the differences negligible.  That said, the point of this thread is to be a holy war, so:  

I prefer tabs:  

<ul>
<li>They're a character specifically meant for indentation</li>
<li>They allow developers with different preferences in indentation size to change how it's the code looks without changing the code (separation of data and presentation for the proverbial win!)</li>
<li>It's impossible to half-indent something with tabs.  So when you copy code from some website that used 3 spaces into your 4-space indented file, you don't have to deal with misalignment.</li>
</ul>

#### Answer 3 (score 117)
Use tabs to indent the start of the line, <strong>one</strong> tab per indent level, and let everyone pick how wide they want that to be.  

Use spaces if you're lining up characters <em>within</em> a line, so they always line up regardless of tab size.  

<p>And find and punch all the early software authors who let this stupid thing become an issue in the first place.<br>
<em>(Seriously, why is this even something that's discussed? Next you'll be telling me you also want to use multiple characters for line breaks!)</em></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: What are the differences between server-side and client-side programming? (score [547074](https://stackoverflow.com/q/171203) in 2015)

#### Question
<blockquote>
  <p>I've seen questions (mainly on Stack Overflow), which lack this basic
  knowledge. The point of this question is to provide good information
  for those seeking it, and those referencing to it.</p>
</blockquote>

In the context of web programming, what are the differences between Server-side programming and Client-side programming? Which languages belong to which, and when do you use each of them?  

#### Answer accepted (score 123)
<h5>Background</h1>

Web development is all about communication. In this case, communication between two (2) parties, over the HTTP protocol:  

<ul>
<li>The <strong>Server</strong> - This party is responsible for <strong>serving</strong> pages.</li>
<li>The <strong>Client</strong> - This party <em>requests</em> pages from the <strong>Server</strong>, and displays them to the user. In most cases, the client is a <strong>web browser</strong>.

<ul>
<li>The <strong>User</strong> - The user <em>uses</em> the <strong>Client</strong> in order to surf the web, fill in forms, watch videos online, etc.</li>
</ul></li>
</ul>

Each side's programming, refers to code which runs at the specific machine, the server's or the client's.  

<h5>Basic Example</h1>

<ol>
<li>The <strong>User</strong> opens his web browser (the <strong>Client</strong>).</li>
<li>The <strong>User</strong> browses to <a href="http://google.com" rel="noreferrer">http://google.com</a>.</li>
<li>The <strong>Client</strong> (on the behalf of the <strong>User</strong>), sends a request to <a href="http://google.com" rel="noreferrer">http://google.com</a> (the <strong>Server</strong>), for their home page.</li>
<li>The <strong>Server</strong> then acknowledges the request, and replies the client with some meta-data (called <em>headers</em>), followed by the page's source.</li>
<li>The <strong>Client</strong> then receives the page's source, and <em>renders</em> it into a human viewable website.</li>
<li>The <strong>User</strong> types <kbd>Stack Overflow</kbd> into the search bar, and presses <kbd>Enter</kbd></li>
<li>The <strong>Client</strong> submits that data to the <strong>Server</strong>.</li>
<li>The <strong>Server</strong> processes that data, and replies with a page matching the search results.</li>
<li>The <strong>Client</strong>, once again, renders that page for the <strong>User</strong> to view.</li>
</ol>

<h5>Programming</h1>

<h5>Server-side Programming</h2>

Server-side programming, is the general name for the kinds of programs which are run on the <strong>Server</strong>.  

<h5>Uses</h3>

<ul>
<li>Process user input.</li>
<li>Compiles pages.</li>
<li>Structure web applications.</li>
<li>Interact with permanent storage (SQL, files).</li>
</ul>

<h5>Example Languages</h3>

<ul>
<li>PHP</li>
<li>Python</li>
<li>ASP.Net in C#, C++, or Visual Basic.</li>
<li>Nearly any language (C++, C#, Java). These were not designed specifically for the task, but are now often used for application-level web services.</li>
</ul>

<h5>Client-side programming</h2>

Much like the server-side, Client-side programming is the name for all of the programs which are run on the <strong>Client</strong>.  

<h5>Uses</h3>

<ul>
<li>Make interactive webpages.</li>
<li>Make stuff happen dynamically on the web page.</li>
<li>Interact with temporary storage, and local storage (Cookies, localStorage).</li>
<li>Send requests to the server, and retrieve data from it.</li>
<li>Provide a remote service for client-side applications, such as software registration, content delivery, or remote multi-player gaming.</li>
</ul>

<h5>Example languages</h3>

<ul>
<li>JavaScript (primarily)</li>
<li>HTML*</li>
<li>CSS*</li>
<li>Any language running on a client device that interacts with a remote service is a client-side language.</li>
</ul>

<sub>*HTML and CSS aren't really "programming languages" per-se. They are markup syntax by which the <strong>Client</strong> renders the page for the <strong>User</strong>.</sub>  

#### Answer 2 (score 27)
<strong>In layman's words:</strong>  

Here I will talk only about web programming.  

<strong>Client side</strong> programming has mostly to do with the user interface, with which the user interacts. In web development it's the browser, in the user's machine, that runs the code, and it's mainly done in <strong>javascript, flash,</strong> etc. This code must run in a variety of browsers.  

<strong>Its main tasks are:</strong>  

<ul>
<li>validating input (Validation must be done in the server. A redundant validation in the client could be used to avoid server calls when speed is very critical.)</li>
<li>animation </li>
<li>manipulating UI elements</li>
<li>applying styles</li>
<li>some calculations are done when you don't want the page to refresh so often</li>
</ul>

The <strong>person in charge</strong> of front end programming <strong>must know</strong>:  

<ul>
<li>javascript</li>
<li>css</li>
<li>HTML</li>
<li>basic graphic design</li>
<li>Ajax</li>
<li>maybe Flash</li>
<li>some 3rd party javascript libraries like JQuery</li>
<li>UI design</li>
<li>information design, etc.</li>
</ul>

<strong>Server side</strong> programming has to do with generating dynamic content. It runs on servers. Many of these servers are "headless". Most web pages are not static, they search a database in order to show the user updated personalized information. This sides interacts with the back end, like say, the database.  

This programming can be done in a lot of languages:  

<ul>
<li>PHP</li>
<li>Java and jsp</li>
<li>asp </li>
<li>Perl</li>
<li>Python</li>
<li>Ruby on Rails, etc.</li>
</ul>

This code has to do with:  

<ul>
<li>Querying the database</li>
<li>Encode the data into html</li>
<li>Insert and update information onto the database</li>
<li>Business rules and calculations</li>
</ul>

The person in charge of server side programming must know:  

<ul>
<li>some of the languages mentioned above </li>
<li>HTML</li>
<li>SQL, </li>
<li>linux/unix shell scripting</li>
<li>OOP</li>
<li>business rules, etc.</li>
</ul>

#### Answer 3 (score 14)
Other answers have focused on <strong>what</strong> is client-side and server-side programming: what languages are mostly used, what tasks have to be accomplished, etc.  

This is absolutely right, but I miss a bit of focus on <strong>what are the differences</strong> between both types of programming, in the context of web programming.  Let me try to address that.  

<h5>Security and permissions</h2>

In client-side programming, you do not have access to the full system, because of security concerns.  The user does not necessarily trust each and every piece of code that is downloaded from the web and executed on his machine, and this is the main design goal of the client-side environment (the browser and JavaScript engine): to provide an isolated environment where client code can execute but cannot access anything outside the allowed scope.  

In server-side programming, it is good practice to also limit the access of each application to the underlying system, but this is much less enforced on you, since in the end, you or your company are in control of that system.  This 'isolated cage' design is <strong>not</strong> built-in into the server-side programming tools and languages, but is accomplished through installation setup (using dedicated users with restricted permissions, choosing ports that require or do not require root permissions, etc).  

<h5>Deployment and platform</h2>

In server-side programming, deployment has to happen from outside your code, using some kind of tool (even if it is `make install` or a `git clone`), and this deployment is usually manual &mdash; or at least, it is expected to happen in a semi-supervised way.  The system (meaning the OS) on which you deploy is usually uniform across a number of machines, but it can be heavily customized to your needs.  

In client-side programming, deployment happens from your server-side code, which serves the clients automatically and without supervision.  The underlying system (meaning mainly the browser) can be very different across a much larger number of machines.  In order to make deployment feasible at all, standards have to be kept, and there is a much stronger trend to a single language and environment.  

This is why copying server-side code from one machine to another can take weeks, while client-side code is usually trivial to execute in different machines.  

<h5>State and secondary effects</h2>

(Disclaimer: this is by far the most subjective point of all.  Probably there are many wrong aspects to my argumentation.  It is just an interesting hypothesis, in my view. )  

In server-side programming, state is a much bigger concern, meaning how to retrieve and update data at the request of the user with the possibility of conflicts due to concurrency.  Even if most of this complexity is offloaded to a database server, it is the server-side code's responsibility to allow the database to keep its guarantees on data integrity by using its interface correctly (e.g. not use a cache for updates that are never seen by the DB), while it is also a goal of the server-side code not to overload the database with work and keep the user waiting for response.  

In client-side programming, presenting the results to the user is a much bigger concern, and this implies secondary effects (mostly printing to the screen).  This is not to say that there is no state involved (e.g. cookies), only that the main goal of the code is to actually interface with the user, and this cannot happen without secondary effects.  

This is why client-side programming usually requires (at some point) looking at the screen with a demo, to check that all colors and layout are right, while server-side programming can happen almost exclusively in a text-oriented environment, where automated tests check that the logic is still doing what it is supposed to do.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: How to detect the encoding of a file? (score [500153](https://stackoverflow.com/q/187169) in )

#### Question
On my filesystem (Windows 7) I have some text files (These are SQL script files, if that matters).  

When opened with <a href="http://notepad-plus-plus.org/">Notepad++</a>, in the "Encoding" menu some of them are reported to have an encoding of "UCS-2 Little Endian" and some of "UTF-8 without BOM".  

What is the difference here? They all seem to be perfectly valid scripts. How could I tell what encodings the file have without Notepad++?  

#### Answer accepted (score 97)
Files generally indicate their encoding with a file header. There are many examples <a href="http://www.garykessler.net/library/file_sigs.html">here</a>. However, even reading the header <strong>you can never be sure what encoding a file is really using</strong>.  

For example, a file with the first three bytes `0xEF,0xBB,0xBF` is <em>probably</em> a UTF-8 encoded file. However, it might be an ISO-8859-1 file which happens to start with the characters `ï»¿`. Or it might be a different file type entirely.  

Notepad++ does its best to guess what encoding a file is using, and most of the time it gets it right. Sometimes it does get it wrong though - that's why that 'Encoding' menu is there, so you can override its best guess.  

For the two encodings you mention:  

<ul>
<li>The "UCS-2 Little Endian" files are UTF-16 files (based on what I understand from the info <a href="http://www.unicode.org/faq/basic_q.html#14">here</a>) so <em>probably</em> start with `0xFF,0xFE` as the first 2 bytes. From what I can tell, Notepad++ describes them as "UCS-2" since it doesn't support certain facets of UTF-16. </li>
<li>The "UTF-8 without BOM" files don't have any header bytes. That's what the "without BOM" bit means.</li>
</ul>

#### Answer 2 (score 18)
You cannot. If you could do that, there would not be so many web sites or text files with “random gibberish” out there. That's why the encoding is usually sent along with the payload as meta data.  

In case it's not, all you can do is a “smart guess” but the result is often ambiguous since the same byte sequence might be valid in several encodings.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Why do game developers prefer Windows? (score [465664](https://stackoverflow.com/q/60544) in 2011)

#### Question
Is it that DirectX is easier or better than OpenGL, even if OpenGL is cross-platform? Why do  we not see real powerful games for Linux like there are for Windows?  

#### Answer accepted (score 1154)
Many of the answers here are really, really good. But the <a href="http://www.opengl.org/">OpenGL</a> and <a href="http://msdn.microsoft.com/en-us/library/windows/desktop/ff476080%28v=vs.85%29.aspx">Direct3D (D3D)</a> issue should probably be addressed. And that requires... a history lesson.  

And before we begin, I know far more about <a href="http://en.wikipedia.org/wiki/Opengl">OpenGL</a> than I do about <a href="http://en.wikipedia.org/wiki/Direct3D">Direct3D</a>. I've never written a line of D3D code in my life, and I've written tutorials on OpenGL. So what I'm about to say isn't a question of bias. It is simply a matter of history.  

<h5>Birth of Conflict</h2>

One day, sometime in the early 90's, Microsoft looked around. They saw the <a href="http://en.wikipedia.org/wiki/Snes">SNES</a> and <a href="http://en.wikipedia.org/wiki/Sega_Genesis">Sega Genesis</a> being awesome, running lots of action games and such. And they saw <a href="http://en.wikipedia.org/wiki/DOS">DOS</a>. Developers coded DOS games like console games: direct to the metal. Unlike consoles however, where a developer who made an SNES game knew what hardware the user would have, DOS developers had to write for multiple possible configurations. And this is rather harder than it sounds.  

And Microsoft had a bigger problem: Windows. See, Windows wanted to own the hardware, unlike DOS which pretty much let developers do whatever. Owning the hardware is necessary in order to have cooperation between applications. Cooperation is exactly what game developers <em>hate</em> because it takes up precious hardware resources they could be using to be awesome.  

In order to promote game development on Windows, Microsoft needed a uniform API that was low-level, ran on Windows without being slowed down by it, and most of all <em>cross-hardware</em>. A single API for all graphics, sound, and input hardware.  

Thus, <a href="http://en.wikipedia.org/wiki/DirectX">DirectX</a> was born.  

3D accelerators were born a few months later. And Microsoft ran into a spot of trouble. See, DirectDraw, the graphics component of DirectX, only dealt with 2D graphics: allocating graphics memory and doing bit-blits between different allocated sections of memory.  

So Microsoft purchased a bit of middleware and fashioned it into Direct3D Version 3. It was <em>universally</em> reviled. And with good reason; looking at D3D v3 code is like staring into the Ark of the Covenant.  

Old John Carmack at Id Software took one look at that trash and said, "Screw that!" and decided to write towards another API: OpenGL.  

See, another part of the many-headed-beast that is Microsoft had been busy working with SGI on an OpenGL implementation for Windows. The idea here was to court developers of typical GL applications: workstation apps. CAD tools, modelling, that sort of thing. Games were the farthest thing on their mind. This was primarily a Windows NT thing, but Microsoft decided to add it to Win95 too.  

As a way to entice workstation developers to Windows, Microsoft decided to try to bribe them with access to these newfangled 3D graphics cards. Microsoft implemented the Installable Client Driver protocol: a graphics card maker could override Microsoft's software OpenGL implementation with a hardware-based one. Code could automatically just use a hardware OpenGL implementation if one was available.  

In the early days, consumer-level videocards did not have support for OpenGL though. That didn't stop Carmack from just porting Quake to OpenGL (GLQuake) on his SGI workstation. As we can read from the GLQuake readme:  

<blockquote>
  <p>Theoretically, glquake will run on any compliant OpenGL that supports the
   texture objects extensions, but unless it is very powerfull hardware that
   accelerates everything needed, the game play will not be acceptable.  If it
   has to go through any software emulation paths, the performance will likely
   by well under one frame per second.</p>
  
  <p>At this time (march ’97), the only standard opengl hardware that can play
   glquake reasonably is an intergraph realizm, which is a VERY expensive card.
   3dlabs has been improving their performance significantly, but with the
   available drivers it still isn’t good enough to play.  Some of the current
   3dlabs drivers for glint and permedia boards can also crash NT when exiting
   from a full screen run, so I don’t recommend running glquake on 3dlabs
   hardware.</p>
  
  <p>3dfx has provided an opengl32.dll that implements everything glquake needs,
   but it is not a full opengl implementation.  Other opengl applications are
   very unlikely to work with it, so consider it basically a “glquake driver”.</p>
</blockquote>

<p>This was the birth of the miniGL drivers. These evolved into full OpenGL implementations eventually, as hardware became powerful enough to implement most OpenGL functionality in hardware. nVidia was the first to offer a full OpenGL implementation. Many other vendors struggled, which is one reason why developers preferred Direct3D: they were compatible on a wider range of hardware.
Eventually only nVidia and ATI (now AMD) remained, and both had a good OpenGL implementation.</p>

<h5>OpenGL Ascendant</h2>

Thus the stage is set: Direct3D vs. OpenGL. It's really an amazing story, considering how bad D3D v3 was.  

The OpenGL Architectural Review Board (ARB) is the organization responsible for maintaining OpenGL. They issue a number of extensions, maintain the extension repository, and create new versions of the API. The ARB is a committee made of many of the graphics industry players, as well as some OS makers. Apple and Microsoft have at various times been a member of the ARB.  

3Dfx comes out with the Voodoo2. This is the first hardware that can do multitexturing, which is something that OpenGL couldn't do before. While 3Dfx was strongly against OpenGL, NVIDIA, makers of the next multitexturing graphics chip (the TNT1), loved it. So the ARB issued an extension: GL_ARB_multitexture, which would allow access to multitexturing.  

Meanwhile, Direct3D v5 comes out. Now, D3D has become an actual <em>API</em>, rather than something a cat might vomit up. The problem? No multitexturing.  

Oops.  

Now, that one wouldn't hurt nearly as much as it should have, because people didn't use multitexturing much. Not directly. Multitexturing hurt performance quite a bit, and in many cases it wasn't worth it compared to multi-passing. And of course, game developers love to ensure that their games works on older hardware, which didn't have multitexturing, so many games shipped without it.  

D3D was thus given a reprieve.  

Time passes and NVIDIA deploys the GeForce 256 (not GeForce GT-250; the very first GeForce), pretty much ending competition in graphics cards for the next two years. The main selling point is the ability to do vertex transform and lighting (T&amp;L) in hardware. Not only that, NVIDIA loved OpenGL so much that their T&amp;L engine effectively <em>was</em> OpenGL. Almost literally; as I understand, some of their registers actually took OpenGL enumerators <em>directly</em> as values.  

Direct3D v6 comes out. Multitexture at last but... no hardware T&amp;L. OpenGL had <em>always</em> had a T&amp;L pipeline, even though before the 256 it was implemented in software. So it was very easy for NVIDIA to just convert their software implementation to a hardware solution. It wouldn't be until D3D v7 until D3D finally had hardware T&amp;L support.  

<h5>Dawn of Shaders, Twilight of OpenGL</h2>

Then, GeForce 3 came out. And a lot of things happened at the same time.  

Microsoft had decided that they weren't going to be late again. So instead of looking at what NVIDIA was doing and then copying it after the fact, they took the astonishing position of going to them and talking to them. And then they fell in love and had a little console together.  

A messy divorce ensued later. But that's for another time.  

What this meant for the PC was that GeForce 3 came out simultaneously with D3D v8. And it's not hard to see how GeForce 3 influenced D3D 8's shaders. The pixel shaders of Shader Model 1.0 were <em>extremely</em> specific to NVIDIA's hardware. There was no attempt made whatsoever at abstracting NVIDIA's hardware; SM 1.0 was just whatever the GeForce 3 did.  

When ATI started to jump into the performance graphics card race with the Radeon 8500, there was a problem. The 8500's pixel processing pipeline was more powerful than NVIDIA's stuff. So Microsoft issued Shader Model 1.1, which basically was "Whatever the 8500 does."  

That may sound like a failure on D3D's part. But failure and success are matters of degrees. And <em>epic</em> failure was happening in OpenGL-land.  

NVIDIA loved OpenGL, so when GeForce 3 hit, they released a slew of OpenGL extensions. <em>Proprietary</em> OpenGL extensions: NVIDIA-only. Naturally, when the 8500 showed up, it couldn't use any of them.  

See, at least in D3D 8 land, you could run your SM 1.0 shaders on ATI hardware. Sure, you had to write new shaders to take advantage of the 8500's coolness, but at least your code <em>worked</em>.  

In order to have shaders of <em>any</em> kind on Radeon 8500 in OpenGL, ATI had to write a number of OpenGL extensions. <em>Proprietary</em> OpenGL extensions: ATI-only. So you needed an NVIDIA codepath and an ATI codepath, just to have <em>shaders</em> at all.  

Now, you might ask, "Where was the OpenGL ARB, whose job it was to keep OpenGL current?" Where many committees often end up: off being stupid.  

See, I mentioned ARB_multitexture above because it factors deeply into all of this. The ARB seemed (from an outsider's perspective) to want to avoid the idea of shaders altogether. They figured that if they slapped enough configurability onto the fixed-function pipeline, they could equal the ability of a shader pipeline.  

So the ARB released extension after extension. Every extension with the words "texture_env" in it was yet another attempt to patch this aging design. Check the registry: between ARB and EXT extensions, there were <em>eight</em> of these extensions made. Many were promoted to OpenGL core versions.  

Microsoft was a part of the ARB at this time; they left around the time D3D 9 hit. So it is entirely possible that they were working to sabotage OpenGL in some way. I personally doubt this theory for two reasons. One, they would have had to get help from other ARB members to do that, since each member only gets one vote. And most importantly two, the ARB didn't need Microsoft's help to screw things up. We'll see further evidence of that.  

Eventually the ARB, likely under threat from both ATI and NVIDIA (both active members) eventually pulled their head out long enough to provide actual assembly-style shaders.  

Want something even stupider?  

Hardware T&amp;L. Something OpenGL had <em>first</em>. Well, it's interesting. To get the maximum possible performance from hardware T&amp;L, you need to store your vertex data on the GPU. After all, it's the GPU that actually wants to use your vertex data.  

In D3D v7, Microsoft introduced the concept of Vertex Buffers. These are allocated swaths of GPU memory for storing vertex data.  

Want to know when OpenGL got their equivalent of this? Oh, NVIDIA, being a lover of all things OpenGL (so long as they are proprietary NVIDIA extensions), released the vertex array range extension when the GeForce 256 first hit. But when did the ARB decide to provide similar functionality?  

<em>Two years later</em>. This was <em>after</em> they approved vertex and fragment shaders (pixel in D3D language). That's how long it took the ARB to develop a cross-platform solution for storing vertex data in GPU memory. Again, something that hardware T&amp;L <em>needs</em> to achieve maximum performance.  

<h5>One Language to Ruin Them All</h2>

So, the OpenGL development environment was fractured for a time. No cross-hardware shaders, no cross-hardware GPU vertex storage, while D3D users enjoyed both. Could it get worse?  

You... you could say that. Enter <strong><a href="http://en.wikipedia.org/wiki/3D_Labs">3D Labs</a></strong>.  

Who are they, you might ask? They are a defunct company whom I consider to be the true killers of OpenGL. Sure, the ARB's general ineptness made OpenGL vulnerable when it should have been owning D3D. But 3D Labs is perhaps the single biggest reason to my mind for OpenGL's current market state. What could they have possibly done to cause that?  

They designed the OpenGL Shading Language.  

See, 3D Labs was a dying company. Their expensive GPUs were being marginalized by NVIDIA's increasing pressure on the workstation market. And unlike NVIDIA, 3D Labs did not have any presence in the mainstream market; if NVIDIA won, they died.  

Which they did.  

So, in a bid to remain relevant in a world that didn't want their products, 3D Labs showed up to a Game Developer Conference wielding presentations for something they called "OpenGL 2.0". This would be a complete, from-scratch rewrite of the OpenGL API. And that makes sense; there was a <em>lot</em> of cruft in OpenGL's API at the time (note: that cruft still exists). Just look at how texture loading and binding work; it's semi-arcane.  

Part of their proposal was a shading language. Naturally. However, unlike the current cross-platform ARB extensions, their shading language was "high-level" (C is high-level for a shading language. Yes, really).  

Now, Microsoft was working on their own high-level shading language. Which they, in all of Microsoft's collective imagination, called... the High Level Shading Language (HLSL). But their was a fundamentally different approach to the languages.  

The biggest issue with 3D Labs's shader language was that it was built-in. See, HLSL was a language Microsoft defined. They released a compiler for it, and it generated Shader Model 2.0 (or later shader models) assembly code, which you would feed into D3D. In the D3D v9 days, HLSL was never touched by D3D directly. It was a nice abstraction, but it was purely optional. And a developer always had the opportunity to go behind the compiler and tweak the output for maximum performance.  

The 3D Labs language had <em>none</em> of that. You gave the driver the C-like language, and it produced a shader. End of story. Not an assembly shader, not something you feed something else. The actual OpenGL object representing a shader.  

What this meant is that OpenGL users were open to the vagaries of developers who were just getting the hang of compiling assembly-like languages. Compiler bugs ran <em>rampant</em> in the newly christened OpenGL Shading Language (GLSL). What's worse, if you managed to get a shader to compile on multiple platforms correctly (no mean feat), you were still subjected to the <em>optimizers</em> of the day. Which were not as optimal as they could be.  

While that was the biggest flaw in GLSL, it wasn't the only flaw. By <em>far</em>.  

In D3D, and in the older assembly languages in OpenGL, you could mix and match vertex and fragment (pixel) shaders. So long as they communicated with the same interface, you could use any vertex shader with any compatible fragment shader. And there were even levels of incompatibility they could accept; a vertex shader could write an output that the fragment shader didn't read. And so forth.  

GLSL didn't have any of that. Vertex and fragment shaders were fused together into what 3D Labs called a "program object". So if you wanted to share vertex and fragment programs, you had to build multiple program objects. And this caused the second biggest problem.  

See, 3D Labs thought they were being clever. They based GLSL's compilation model on C/C++. You take a .c or .cpp and compile it into an object file. Then you take one or more object files and link them into a program. So that's how GLSL compiles: you compile your shader (vertex or fragment) into a shader object. Then you put those shader objects in a program object, and link them together to form your actual program.  

While this did allow potential cool ideas like having "library" shaders that contained extra code that the main shaders could call, what it meant in practice was that shaders were compiled <em>twice</em>. Once in the compilation stage and once in the linking stage. NVIDIA's compiler in particular was known for basically running the compile twice. It didn't generate some kind of object code intermediary; it just compiled it once and threw away the answer, then compiled it again at link time.  

So even if you want to link your vertex shader to two different fragment shaders, you have to do a lot more compiling than in D3D. Especially since the compiling of a C-like language was all done <em>offline</em>, not at the beginning of the program's execution.  

There were other issues with GLSL. Perhaps it seems wrong to lay the blame on 3D Labs, since the ARB did eventually approve and incorporate the language (but nothing else of their "OpenGL 2.0" initiative). But it was their idea.  

And here's the really sad part: 3D Labs was <em>right</em> (mostly). GLSL is not a vector-based shading language the way HLSL was at the time. This was because 3D Labs's hardware was scalar hardware (similar to modern NVIDIA hardware), but they were ultimately right in the direction many hardware makers went with their hardware.  

They were right to go with a compile-online model for a "high-level" language. D3D even switched to that eventually.  

The problem was that 3D Labs were right at the wrong <em>time</em>. And in trying to summon the future too early, in trying to be future-proof, they cast aside the <em>present</em>. It sounds similar to how OpenGL always had the possibility for T&amp;L functionality. Except that OpenGL's T&amp;L pipeline was still <em>useful</em> before hardware T&amp;L, while GLSL was a liability before the world caught up to it.  

GLSL is a good language <em>now</em>. But for the time? It was horrible. And OpenGL suffered for it.  

<h5>Falling Towards Apotheosis</h2>

While I maintain that 3D Labs struck the fatal blow, it was the ARB itself who would drive the last nail in the coffin.  

This is a story you may have heard of. By the time of OpenGL 2.1, OpenGL was running into a problem. It had a <em>lot</em> of legacy cruft. The API wasn't easy to use anymore. There were 5 ways to do things, and no idea which was the fastest. You could "learn" OpenGL with simple tutorials, but you didn't really learn the OpenGL API that gave you real performance and graphical power.  

So the ARB decided to attempt another re-invention of OpenGL. This was similar to 3D Labs's "OpenGL 2.0", but better because the ARB was behind it. They called it "Longs Peak."  

What is so bad about taking some time to improve the API? This was bad because Microsoft had left themselves vulnerable. See, <em>this</em> was at the time of the Vista switchover.  

With Vista, Microsoft decided to institute some much-needed changes in display drivers. They forced drivers to submit to the OS for graphics memory virtualization and various other things.  

While one can debate the merits of this or whether it was actually possible, the fact remains this: Microsoft deemed D3D 10 to be Vista (and above) only. Even if you had hardware that was <em>capable</em> of D3D 10, you couldn't run D3D 10 applications without also running Vista.  

You might also remember that Vista... um, let's just say that it didn't work out well. So you had an underperforming OS, a new API that only ran on that OS, and a fresh generation of hardware that <em>needed</em> that API and OS to do anything more than be faster than the previous generation.  

However, developers <em>could</em> access D3D 10-class features via OpenGL. Well, they could if the ARB hadn't been busy working on Longs Peak.  

Basically, the ARB spent a good year and a half to two years worth of work to make the API better. By the time OpenGL 3.0 actually came out, Vista adoption was up, Win7 was around the corner to put Vista behind them, and most game developers didn't care about D3D-10 class features anyway. After all, D3D 10 hardware ran D3D 9 applications just fine. And with the rise of PC-to-console ports (or PC developers jumping ship to console development. Take your pick), developers didn't need D3D 10 class features.  

Now, if developers had access to those features earlier via OpenGL on WinXP machines, then OpenGL development might have received a much-needed shot in the arm. But the ARB missed their opportunity. And do you want to know the worst part?  

Despite spending two precious years attempting to rebuild the API from scratch... they <em>still</em> failed and just reverted back to the status quo (except for a deprecation mechanism).  

So not only did the ARB miss a <em>crucial</em> window of opportunity, they didn't even get done the task that made them miss that chance. Pretty much epic fail all around.  

And that's the tale of OpenGL vs. Direct3D. A tale of missed opportunities, gross stupidity, willful blindness, and simple foolishness.  

#### Answer 2 (score 133)
I found it strange that everybody's focusing on user base, when the question is 'game developers', not 'game editors'.  

For me, as a developer, Linux is a bloody mess. There are so many versions, desktop managers, UI kits, etc... If I don't want to distribute my work as open source, where the user can (try to) recompile so it fits his unique combination of packages, libraries and settings, it's a <strong>nightmare</strong>!  

On the other hand, Microsoft is providing (most of the time) incredible backward compatibility and platform stability. It is possible to target whole range of machines with one closed-source installer, for instance computers running Windows XP, Vista and 7, 32 and 64 bits flavors, without proper DX or VC redistributables installed, etc...  

One last thing, <strong>PLEASE EVERYBODY ON THE INTERNET STOP COMPARING OPENGL AND DIRECTX!</strong> Either compare Direct3D vs OpenGL or <em>don't do this</em>. DirectX provides input support, sound support, movie playing, etc etc that OpenGL doesn't.  

#### Answer 3 (score 88)
<p>It's because there are more Windows users on the planet than Linux and Mac. The truth is that people make things for whichever has the biggest market.<br>
The same goes with mobile phones: Android and iPhone have awesome games but Windows Mobile and Symbian don't...</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: What technical details should a programmer of a web application consider before making the site public? (score [457892](https://stackoverflow.com/q/46716) in 2017)

#### Question
What things should a programmer implementing the technical details of a web application consider before making the site public?  If <a href="https://softwareengineering.stackexchange.com/users/37/jeff-atwood">Jeff Atwood</a> can forget about <a href="http://www.codinghorror.com/blog/archives/001167.html" rel="nofollow noreferrer">HttpOnly cookies</a>, <a href="http://www.codinghorror.com/blog/archives/001174.html" rel="nofollow noreferrer">sitemaps</a>, <em>and</em> <a href="http://www.codinghorror.com/blog/archives/001171.html" rel="nofollow noreferrer">cross-site request forgeries</a> <em>all in the same site</em>, what important thing could I be forgetting as well?  

I'm thinking about this from a web developer's perspective, such that someone else is creating the actual design and content for the site.  So while usability and content may be more important than the platform, you the programmer have little say in that.  What you do need to worry about is that your implementation of the platform is stable, performs well, is secure, and meets any other business goals (like not cost too much, take too long to build, and rank as well with Google as the content supports).    

Think of this from the perspective of a developer who's done some work for intranet-type applications in a fairly trusted environment, and is about to have his first shot and putting out a potentially popular site for the entire big bad world wide web.  

Also, I'm looking for something more specific than just a vague "web standards" response.  I mean, HTML, JavaScript, and CSS over HTTP are pretty much a given, especially when I've already specified that you're a professional web developer.  So going beyond that, <em>Which</em> standards?  In what circumstances, and why?  <strong>Provide a link to the standard's specification.</strong>  

#### Answer accepted (score 2645)
The idea here is that most of us should <em>already</em> know <em>most</em> of what is on this list.  But there just might be one or two items you haven't really looked into before, don't fully understand, or maybe never even heard of.  

<strong>Interface and User Experience</strong>  

<ul>
<li>Be  aware that browsers implement standards inconsistently and make sure your site works reasonably well across all major browsers.  At a minimum test against a recent <a href="https://en.wikipedia.org/wiki/Gecko_%28layout_engine%29" rel="noreferrer">Gecko</a> engine (<a href="http://firefox.com/" rel="noreferrer">Firefox</a>), a WebKit engine (<a href="http://www.apple.com/safari/" rel="noreferrer">Safari</a> and some mobile browsers), <a href="http://www.google.com/chrome" rel="noreferrer">Chrome</a>, your supported <a href="https://en.wikipedia.org/wiki/Internet_Explorer" rel="noreferrer">IE browsers</a> (take advantage of the <a href="http://www.microsoft.com/Downloads/details.aspx?FamilyID=21eabb90-958f-4b64-b5f1-73d0a413c8ef&amp;displaylang=en" rel="noreferrer">Application Compatibility VPC Images</a>), and <a href="http://www.opera.com/" rel="noreferrer">Opera</a>. Also consider how <a href="http://www.browsershots.org" rel="noreferrer">browsers render your site</a> in different operating systems.</li>
<li>Consider how people might use the site other than from the major browsers: cell phones, screen readers and search engines, for example. &mdash; Some accessibility info: <a href="http://www.w3.org/WAI/" rel="noreferrer">WAI</a> and <a href="http://www.section508.gov/" rel="noreferrer">Section508</a>, Mobile development: <a href="http://mobiforge.com/" rel="noreferrer">MobiForge</a>.</li>
<li>Staging: How to deploy updates without affecting your users.  Have one or more test or staging environments available to implement changes to architecture, code or sweeping content and ensure that they can be deployed in a controlled way without breaking anything. Have an automated way of then deploying approved changes to the live site. This is most effectively implemented in conjunction with the use of a version control system (git, Subversion, etc.) and an automated build mechanism (Ant, NAnt, etc.).</li>
<li>Don't display unfriendly errors directly to the user.</li>
<li>Don't put users' email addresses in plain text as they will get spammed to death.</li>
<li>Add the attribute `rel="nofollow"` to user-generated links <a href="https://en.wikipedia.org/wiki/Nofollow" rel="noreferrer">to avoid spam</a>.</li>
<li><a href="http://www.codinghorror.com/blog/archives/001228.html" rel="noreferrer">Build well-considered limits into your site</a> - This also belongs under Security.</li>
<li>Learn how to do <a href="https://en.wikipedia.org/wiki/Progressive_enhancement" rel="noreferrer">progressive enhancement</a>.</li>
<li><a href="https://en.wikipedia.org/wiki/Post/Redirect/Get" rel="noreferrer">Redirect after a POST</a> if that POST was successful, to prevent a refresh from submitting again.</li>
<li>Don't forget to take accessibility into account.  It's always a good idea and in certain circumstances it's a <a href="http://www.section508.gov/" rel="noreferrer">legal requirement</a>.  <a href="http://www.w3.org/WAI/intro/aria" rel="noreferrer">WAI-ARIA</a> and <a href="http://www.w3.org/TR/WCAG20/" rel="noreferrer">WCAG 2</a> are good resources in this area.</li>
<li>Read <a href="http://www.sensible.com/dmmt.html" rel="noreferrer">Don't Make Me Think</a>.</li>
</ul>

<strong>Security</strong>  

<ul>
<li>It's a lot to digest but the <a href="http://www.owasp.org/index.php/Category:OWASP_Guide_Project" rel="noreferrer">OWASP development guide</a> covers Web Site security from top to bottom.</li>
<li>Know about Injection especially <a href="https://en.wikipedia.org/wiki/SQL_injection" rel="noreferrer">SQL injection</a> and how to prevent it.</li>
<li>Never trust user input, nor anything else that comes in the request (which includes cookies and hidden form field values!).</li>
<li>Hash passwords using <a href="https://security.stackexchange.com/q/21263/396">salt</a> and use different salts for your rows to prevent rainbow attacks. Use a slow hashing algorithm, such as bcrypt (time tested) or scrypt (even stronger, but newer) (<a href="http://www.tarsnap.com/scrypt.html" rel="noreferrer">1</a>, <a href="http://it.slashdot.org/comments.pl?sid=1987632&amp;cid=35149842" rel="noreferrer">2</a>), for storing passwords. (<a href="http://codahale.com/how-to-safely-store-a-password/" rel="noreferrer">How To Safely Store A Password</a>). The <a href="https://security.stackexchange.com/q/7689/396">NIST also approves of PBKDF2 to hash passwords</a>", and it's <a href="https://security.stackexchange.com/a/2136/396">FIPS approved in .NET</a> (more info <a href="https://security.stackexchange.com/questions/211/how-to-securely-hash-passwords">here</a>). <em>Avoid</em> using MD5 or SHA family directly.</li>
<li><a href="https://stackoverflow.com/questions/1581610/how-can-i-store-my-users-passwords-safely/1581919#1581919">Don't try to come up with your own fancy authentication system</a>. It's such an easy thing to get wrong in subtle and untestable ways and you wouldn't even know it until <em>after</em> you're hacked.</li>
<li>Know the <a href="https://www.pcisecuritystandards.org/" rel="noreferrer">rules for processing credit cards</a>. (<a href="https://stackoverflow.com/questions/51094/payment-processors-what-do-i-need-to-know-if-i-want-to-accept-credit-cards-on-m">See this question as well</a>)</li>
<li>Use <a href="http://www.mozilla.org/projects/security/pki/nss/ssl/draft302.txt" rel="noreferrer">SSL/TLS</a>/<a href="https://en.wikipedia.org/wiki/Session_hijacking#Prevention" rel="noreferrer">HTTPS</a> for any sites where sensitive data is entered (like credentials, Personally Identifiable Information, credit card info). <a href="https://letsencrypt.org" rel="noreferrer">Let's Encrypt</a> is a free certificate authority which can help.</li>
<li><a href="https://en.wikipedia.org/wiki/Session_hijacking#Prevention" rel="noreferrer">Prevent session hijacking</a>.</li>
<li>Avoid <a href="https://en.wikipedia.org/wiki/Cross-site_scripting" rel="noreferrer">cross site scripting</a> (XSS).</li>
<li>Avoid <a href="https://en.wikipedia.org/wiki/Cross-site_request_forgery" rel="noreferrer">cross site request forgeries</a> (CSRF).</li>
<li>Avoid <a href="https://en.wikipedia.org/wiki/Clickjacking" rel="noreferrer">Clickjacking</a>.</li>
<li>Keep your system(s) up to date with the latest patches.</li>
<li>Make sure your database connection information is secured.</li>
<li>Keep yourself informed about the latest attack techniques and vulnerabilities affecting your platform.</li>
<li>Read <a href="https://code.google.com/archive/p/browsersec/" rel="noreferrer">The Google Browser Security Handbook</a>.</li>
<li>Read <a href="https://rads.stackoverflow.com/amzn/click/com/0470170778" rel="noreferrer" rel="nofollow noreferrer">The Web Application Hacker's Handbook</a>.</li>
<li>Consider <a href="https://en.wikipedia.org/wiki/Principle_of_least_privilege" rel="noreferrer">The principle of least privilege</a>. Try to run your app server <a href="https://security.stackexchange.com/questions/47576/do-simple-linux-servers-really-need-a-non-root-user-for-security-reasons">as non-root</a>. (<a href="http://tomcat.apache.org/tomcat-8.0-doc/security-howto.html#Non-Tomcat_settings" rel="noreferrer">tomcat example</a>)</li>
<li>Put `rel="noopener noreferrer"` on all user-provided links with `target="_blank"` to prevent JavaScript on the destination page from redirecting your page to somewhere else, such as a fake login page. <a href="https://dev.to/phishing" rel="noreferrer">More Info</a></li>
<li>Consider using a <a href="https://csp.withgoogle.com/docs/index.html" rel="noreferrer">strict Content Security Policy</a>.</li>
</ul>

<strong>Performance</strong>  

<ul>
<li>Implement caching if necessary, understand and use <a href="http://www.mnot.net/cache_docs/" rel="noreferrer">HTTP caching</a> properly as well as <a href="http://www.w3.org/TR/2011/WD-html5-20110525/offline.html" rel="noreferrer">HTML5 Manifest</a>.</li>
<li>Optimize images - don't use a 20 KB image for a repeating background.</li>
<li>Compress content for speed, see <a href="https://www.smashingmagazine.com/2016/10/next-generation-server-compression-with-brotli/" rel="noreferrer">brotli</a>, <a href="http://developer.yahoo.com/performance/rules.html#gzip" rel="noreferrer" title="gzip content">gzip/deflate</a> (<strike><a href="https://stackoverflow.com/questions/1574168/gzip-vs-deflate-zlib-revisited">deflate is better</a></strike>).</li>
<li>Combine/concatenate multiple stylesheets or multiple script files to reduce the number of browser connections and improve gzip ability to compress duplications between files.</li>
<li>Take a look at the <a href="http://developer.yahoo.com/performance/" rel="noreferrer">Yahoo Exceptional Performance</a> site, lots of great guidelines, including improving front-end performance and their <a href="http://developer.yahoo.com/yslow/" rel="noreferrer">YSlow</a> tool (requires Firefox, Safari, Chrome or Opera). Also, <a href="https://developers.google.com/speed/docs/best-practices/rules_intro" rel="noreferrer">Google page speed</a> (use with <a href="https://developers.google.com/speed/pagespeed/insights_extensions" rel="noreferrer">browser extension</a>) is another tool for performance profiling, and it optimizes your images too.</li>
<li><strike>Use <a href="http://alistapart.com/articles/sprites" rel="noreferrer">CSS Image Sprites</a> for small related images like toolbars (see the "minimize HTTP requests" point)</strike></li>
<li>Use <a href="https://24ways.org/2014/an-overview-of-svg-sprite-creation-techniques/" rel="noreferrer">SVG image sprites</a> for small related images like toolbars. SVG coloring is bit tricky. You can read about it <a href="http://tympanus.net/codrops/2015/07/16/styling-svg-use-content-css/" rel="noreferrer">here</a>.</li>
<li>Busy web sites should consider <a href="http://developer.yahoo.com/performance/rules.html#split" rel="noreferrer">splitting components across domains</a>.  Specifically...</li>
<li>Static content (i.e. images, CSS, JavaScript, and generally content that doesn't need access to cookies) should go in a separate domain <em><a href="http://blog.stackoverflow.com/2009/08/a-few-speed-improvements/">that does not use cookies</a></em>, because all cookies for a domain and its subdomains are sent with every request to the domain and its subdomains.  One good option here is to use a Content Delivery Network (CDN), but consider the case where that CDN may fail by including alternative CDNs, or local copies that can be served instead.</li>
<li>Minimize the total number of HTTP requests required for a browser to render the page.</li>
<li>Choose a <a href="http://garann.github.io/template-chooser/" rel="noreferrer">template engine</a> and render/pre-compile it using task-runners like gulp or grunt</li>
<li>Make sure there’s a `favicon.ico` file in the root of the site, i.e. `/favicon.ico`. <a href="http://mathiasbynens.be/notes/rel-shortcut-icon" rel="noreferrer">Browsers will automatically request it</a>, even if the icon isn’t mentioned in the HTML at all. If you don’t have a `/favicon.ico`, this will result in a lot of 404s, draining your server’s bandwidth.</li>
</ul>

<strong>SEO (Search Engine Optimization)</strong>  

<ul>
<li>Use "search engine friendly" URLs, i.e. use `example.com/pages/45-article-title` instead of `example.com/index.php?page=45`</li>
<li>When using `#` for dynamic content change the `#` to `#!` and then on the server `$_REQUEST["_escaped_fragment_"]` is what googlebot uses instead of `#!`. In other words, `./#!page=1` becomes `./?_escaped_fragments_=page=1`. Also, for users that may be using FF.b4 or Chromium, `history.pushState({"foo":"bar"}, "About", "./?page=1");` Is a great command. So even though the address bar has changed the page does not reload. This allows you to use `?` instead of `#!` to keep dynamic content and also tell the server when you email the link that we are after this page, and the AJAX does not need to make another extra request.</li>
<li>Don't use links that say <a href="https://ux.stackexchange.com/questions/12100/why-shouldnt-we-use-the-word-here-in-a-textlink">"click here"</a>. You're wasting an SEO opportunity and it makes things harder for people with screen readers.</li>
<li>Have an <a href="http://www.sitemaps.org/" rel="noreferrer">XML sitemap</a>, preferably in the default location `/sitemap.xml`.</li>
<li>Use <a href="http://googlewebmastercentral.blogspot.com/2009/02/specify-your-canonical.html" rel="noreferrer">`<link rel="canonical" ... />`</a> when you have multiple URLs that point to the same content, this issue can also be addressed from <a href="http://www.google.com/webmasters/" rel="noreferrer">Google Webmaster Tools</a>.</li>
<li>Use <a href="http://www.google.com/webmasters/" rel="noreferrer">Google Webmaster Tools</a> and <a href="http://www.bing.com/toolbox/webmaster" rel="noreferrer">Bing Webmaster Tools</a>.</li>
<li>Install <a href="http://www.google.com/analytics/" rel="noreferrer">Google Analytics</a> right at the start (or an open source analysis tool like <a href="http://piwik.org/" rel="noreferrer">Piwik</a>).</li>
<li>Know how <a href="https://en.wikipedia.org/wiki/Robots_exclusion_standard" rel="noreferrer">robots.txt</a> and search engine spiders work.</li>
<li>Redirect requests (using `301 Moved Permanently`) asking for `www.example.com` to `example.com` (or the other way round) to prevent splitting  the google ranking between both sites.</li>
<li>Know that there can be badly-behaved spiders out there.</li>
<li>If you have non-text content look into Google's sitemap extensions for video etc. There is some good information about this in <a href="https://stackoverflow.com/questions/72394/what-should-a-developer-know-before-building-a-public-web-site#167608">Tim Farley's answer</a>.</li>
</ul>

<strong>Technology</strong>  

<ul>
<li>Understand <a href="http://www.ietf.org/rfc/rfc2616.txt" rel="noreferrer">HTTP</a> and things like GET, POST, sessions, cookies, and what it means to be "stateless".</li>
<li>Write your <a href="http://www.w3.org/TR/xhtml1/" rel="noreferrer">XHTML</a>/<a href="http://www.w3.org/TR/REC-html40/" rel="noreferrer">HTML</a> and <a href="http://www.w3.org/TR/CSS2/" rel="noreferrer">CSS</a> according to the <a href="http://www.w3.org/TR/" rel="noreferrer">W3C specifications</a> and make sure they <a href="http://validator.w3.org/" rel="noreferrer">validate</a>.  The goal here is to avoid browser quirks modes and as a bonus make it much easier to work with non-traditional browsers like screen readers and mobile devices.</li>
<li>Understand how JavaScript is processed in the browser.</li>
<li>Understand how JavaScript, style sheets, and other resources used by your page are loaded and consider their impact on <em>perceived</em> performance. It is now widely regarded as appropriate to <a href="https://developer.yahoo.com/blogs/ydn/high-performance-sites-rule-6-move-scripts-bottom-7200.html" rel="noreferrer">move scripts to the bottom</a> of your pages with exceptions typically being things like analytics apps or HTML5 shims.</li>
<li>Understand how the JavaScript sandbox works, especially if you intend to use iframes.</li>
<li>Be aware that JavaScript can and will be disabled, and that AJAX is therefore an extension, not a baseline.  Even if most normal users leave it on now, remember that <a href="http://noscript.net/" rel="noreferrer">NoScript</a> is becoming more popular, mobile devices may not work as expected, and Google won't run most of your JavaScript when indexing the site.</li>
<li>Learn the <a href="http://www.bigoakinc.com/blog/when-to-use-a-301-vs-302-redirect/" rel="noreferrer">difference between 301 and 302 redirects</a> (this is also an SEO issue).</li>
<li>Learn as much as you possibly can about your deployment platform.</li>
<li>Consider using a <a href="https://stackoverflow.com/questions/11578819/css-reset-what-exactly-does-it-do">Reset Style Sheet</a> or <a href="http://necolas.github.com/normalize.css/" rel="noreferrer">normalize.css</a>.</li>
<li>Consider JavaScript frameworks (such as <a href="http://jquery.com/" rel="noreferrer">jQuery</a>, <a href="http://mootools.net/" rel="noreferrer">MooTools</a>, <a href="http://www.prototypejs.org/" rel="noreferrer">Prototype</a>, <a href="http://dojotoolkit.org" rel="noreferrer">Dojo</a> or <a href="http://developer.yahoo.com/yui/3/" rel="noreferrer">YUI 3</a>), which will hide a lot of the browser differences when using JavaScript for DOM manipulation.</li>
<li>Taking perceived performance and JS frameworks together, consider using a service such as the <a href="http://developers.google.com/speed/libraries/devguide" rel="noreferrer">Google Libraries API</a> to load frameworks so that a browser can use a copy of the framework it has already cached rather than downloading a duplicate copy from your site.</li>
<li>Don't reinvent the wheel. Before doing ANYTHING search for a component or example on how to do it. There is a 99% chance that someone has done it and released an OSS version of the code.</li>
<li>On the flipside of that, don't start with 20 libraries before you've even decided what your needs are. Particularly on the client-side web where it's almost always ultimately more important to keep things lightweight, fast, and flexible.</li>
</ul>

<strong>Bug fixing</strong>  

<ul>
<li>Understand you'll spend 20% of your time coding and 80% of it maintaining, so code accordingly.</li>
<li>Set up a good error reporting solution.</li>
<li>Have a system for people to contact you with suggestions and criticisms.</li>
<li>Document how the application works for future support staff and people performing maintenance.</li>
<li>Make frequent backups! (And make sure those backups are functional) Have a restore strategy, not just a backup strategy.</li>
<li>Use a version control system to store your files, such as <a href="http://subversion.apache.org/" rel="noreferrer">Subversion</a>, <a href="http://mercurial.selenic.com/" rel="noreferrer">Mercurial</a> or <a href="http://git-scm.org" rel="noreferrer">Git</a>.</li>
<li>Don't forget to do your Acceptance Testing.  Frameworks like <a href="http://seleniumhq.org/" rel="noreferrer">Selenium</a> can help. Especially if you fully automate your testing, perhaps by using a Continuous Integration tool, such as <a href="http://jenkins-ci.org/" rel="noreferrer">Jenkins</a>.</li>
<li>Make sure you have sufficient logging in place using frameworks such as <a href="http://logging.apache.org/log4j/" rel="noreferrer">log4j</a>, <a href="http://logging.apache.org/log4net/" rel="noreferrer">log4net</a> or <a href="http://log4r.rubyforge.org/" rel="noreferrer">log4r</a>. If something goes wrong on your live site, you'll need a way of finding out what.</li>
<li>When logging make sure you capture both handled exceptions, and unhandled exceptions. Report/analyse the log output, as it'll show you where the key issues are in your site.</li>
</ul>

<strong>Other</strong>  

<ul>
<li>Implement both server-side and client-side monitoring and analytics (one should be proactive rather than reactive).</li>
<li>Use services like UserVoice and Intercom (or any other similar tools) to constantly keep in touch with your users.</li>
<li>Follow <a href="http://nvie.com/about/" rel="noreferrer">Vincent Driessen</a>'s <a href="http://nvie.com/posts/a-successful-git-branching-model/" rel="noreferrer">Git branching model</a></li>
</ul>

Lots of stuff omitted not necessarily because they're not useful answers, but because they're either too detailed, out of scope, or go a bit too far for someone looking to get an overview of the things they should know. Please feel free to edit this as well, I probably missed some stuff or made some mistakes.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Why do programmers use or recommend Mac OS X? (score [453691](https://stackoverflow.com/q/51670) in 2012)

#### Question
I've worked on both Mac and Windows for awhile. However, I'm still having a hard time understanding why programmers enthusiastically choose Mac OS X over Windows and Linux?   

I know that there are programmers who prefer Windows and Linux, but I'm asking the programmers who would just use Mac OS X and nothing else, because they think Mac OS X is the greatest fit for programmers.  

Some might argue that Mac OS X got the beautiful UI and is nix based, but Linux can do that. Although Windows is not nix based, you can pretty much develop on any platform or language, except Cocoa/Objective-C.  

<p>Is it the applications that are only available on Mac OS X? Does that really make it worth it?<br/>
Is it to develop iPhone apps?<br/>
Is it because you need to upgrade Windows every 2 years (less backwards compatible)?<br/></p>

I understand why people, who are working in multimedia/entertainment industry, would use Mac OS X. However, I don't see what strong merits Mac OS X has over Windows. If you develop daily on Mac and prefer Mac over anything else, can you give me a merit that Mac has over Windows/Linux? Maybe something you can do on Mac that cannot be done in Windows/Linux with the same level of ease?  

I'm not trying to do another Mac vs. Windows here. I tried to find things that can be done on Mac but not on Windows with the same level of ease, but I couldn't. So, I'm asking for some help.  

#### Answer 2 (score 74)
I've been using MacOS X for about half a year on my dev machine and I definitely wound <strong>not recommend</strong> it to developer, other than iPhone/OSX developers (they don't have a choice, do they?).   

I've <a href="https://help.ubuntu.com/community/MactelSupportTeam/AppleIntelInstallation"><strong>replaced OSX with Ubuntu</strong></a>. Apparently I'm not the only one <a href="http://dywypi.org/2012/02/back-on-linux.html">switching from OSX back to Linux</a>.   

All the tools you take for granted in Linux are either non-existent or painful to get to work on OSX:  

<ul>
<li>installing open source software: if you're lucky there's <a href="http://www.macports.org/">MacPort</a> for it. Installing MacPorts feels like Linux 15 years ago. It downloads the package and compiles it. No binary packages. Want Qt? Reserve 5 hours for compilation. If you're not lucky, there is no MacPort for software you're looking for. Then you have to download source and compile it (welcome to 1980's). Sometimes  compilation instructions for OSX 10.5 will work on 10.6, sometimes they won't. </li>
<li>to make things more interesting, there are other alternatives to MacPorts, like <a href="http://mxcl.github.com/homebrew/">Homebrew</a> and previously <a href="http://www.finkproject.org/">Fink</a>. They are not compatible at all with each other, and using more than one of them at time guarantees total chaos and rendering your OSS unusable. </li>
<li>multi-screen support: hey, looking for your IDE's menu? it's on main screen, not the one you're working on. You can get lame "solution" for that, called <a href="http://blog.boastr.net/?page_id=79"><strong>SecondBar</strong></a>. It will be ugly, unresponsive and at times will display bunch of "N/A" instead of menu. But it's OSX so who'd care about ergonomy when you can have eyecandy. I mean, if you'd like interface designed about ppl who care about HCI, you'd choose Linux or Win7 anyway.  (<strong>Update</strong>: this seems to be finally fixed in Mavericks, even though last 2 years I've been told numerous times that it would contradict <em>"the Mac way"</em>).</li>
<li>decent terminal: you have few choices, the default Terminal.app, the iTerm and dozen others. None of them has full feature set (comparing to default consoles in Linux), each of them has at least one of the problems (like messed up line wrapping, no tab support or problems with UTF-8).</li>
<li>GCC 4.2 is included... but wait, why doesn't it understand GCC 4.2 x86_64 flags like `-march=native`? As pointed by Jano, it's <a href="http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33144">a bug</a>. OSX only bug, to be exact. But on OSX, unlike on Linux, you cannot expect Apple to actually backport the fix and release it in software update. So you're back to square one &mdash; OSX is a niche system, and it makes your life as developer harder, while mainstream systems, like Linux, make it easier.  </li>
<li>any software that uses X11? OSX now has X11 support. With look &amp; feel totally  inconsistent with the rest of the UI. Fugly.</li>
<li>want to see normal UNIX directory structure in Finder? No way, that's like magic, a normal user cannot be allowed to see that... You can of course activate that with few cryptic commands executed from CLI. I mean, having <em>"show hidden files"</em> checkbox like in Windows would be just too confusing for macusers...</li>
<li>up to date Java &mdash; sorry, you can't have that, <a href="http://www.theregister.co.uk/2010/10/21/apple_threatens_to_kill_java_on_the_mac/">Apple hates Java</a> and will do anything to prove it inferior technology. Which means keeping it obsolete and not applying any updates. Even if it means <a href="http://arstechnica.com/apple/news/2012/04/mac-trojan-exploits-unpatched-java-vulnerability-no-password-needed.ars">exposing their users to trojans</a>. </li>
<li><em>"security? we don't need no stinking security!"</em>. MacOS X is <strong>the least secure</strong> of all mainstream OSes (including home editions of Windows). It has fallen victim of hackers <a href="http://goo.gl/siHEM">year</a>, <a href="http://goo.gl/o7LpE">after year</a>, <a href="http://goo.gl/ELBul">after year</a> and <a href="http://goo.gl/kaC95">it's still the case</a>. Also the myth of OSX not having viruses is not true for <a href="http://www.symantec.com/security_response/writeup.jsp?docid=2006-021614-4006-99">at least 5 years</a> now. And it doesn't get better for third party products either: </li>
</ul>

<blockquote>
  <p><a href="http://www.theregister.co.uk/2011/05/06/skype_for_mac_critical_vulnerability/">Mac users running Skype are vulnerable</a>
  to self-propagating exploits that
  allow an attacker to gain unfettered
  system access [...] Skype's other
  clients, e.g. Windows and Linux, are
  not susceptible to this vulnerability.</p>
</blockquote>

Update: OSX's security seems to go from bad <a href="http://www.zdnet.com/blog/security/apple-security-blunder-exposes-lion-login-passwords-in-clear-text/11963">to worse</a>   

<blockquote>
  <p>With the latest Lion security update, Mac OS X 10.7.3, Apple has
  accidentally turned on a debug log file outside of the encrypted area
  that <strong>stores the user’s password in clear text</strong>.</p>
</blockquote>

#### Answer 3 (score 67)
<blockquote>
  <strong>Disclaimer for comments:</strong> I use what I've determined to be best for <em>me</em>. Those reasons are what I've listed here.  Finding the "greatest fit for programmers" in all situations is impossible, and I don't think anyone bases their choice on thinking they've found it.  
</blockquote>

It's a Unix-based OS with a great user interface installed on great hardware.  Hardware that is getting ever-cheaper as Apple grows and uses their buying power to secure lower and lower prices of great components.  

I use Mac because:  

<ul>
<li><strong>Unix-based OS</strong>
<ul>
<li>Terminal is a bash shell with all the standard Unix utilities</li>
<li><strong>Built-in SSH!!</strong></li>
<li>Comes preloaded with software that works great with Unix: SVN, PHP, Apache2, etc.</li>
<li>I find a Unix filesystem so much more comfortable to use in development.</li>
</ul></li>
<li><strong>Great UI</strong> - In my humble opinion, you can't beat the usability of a Mac.  I love the Mac-specific apps I use daily - Mail, Adium, Textmate</li>
<li><strong>Great OS</strong> - Can't beat the install of (most) Applications - drag and drop.  The `/Library` folder is well organized and easy to find what I need if I have to dig into preferences, copy an application's support files, install a new Preference Pane.  Speaking of System Preferences - another great feature of Mac.</li>
<li><strong>Great support for other apps</strong> - IntelliJ IDEA is as good on a Mac as anywhere. Skype. Chrome. Firefox. Adobe suite.</li>
<li><strong>Great hardware</strong> - I work on a $1200 13" Macbook Pro (external 24" monitor at desk). Cheaper than my coworkers on high-end Windows desktops and I'm not running into processing issues or memory issues (none of us really are these days). And you just can't beat the quality of an Apple laptop (developing on laptops is a different question but I can't live without one - wire-free for meetings, private Skype calls, or taking my work home exactly as I left it. And 10 hour battery life!).</li>
<li>Lastly, I don't develop on any Microsoft-stack technologies, so I don't feel limited there.</li>
</ul>

<hr>

I don't think there are any things I <em>can't</em> do on Windows. The above is a list of things that, as a sum, just make Mac the preferred option. If you are looking for singular things, there are a few tasks that I feel I can simply do more easily on Mac:  

<ul>
<li>(As mentioned above, probably the biggest) Terminal > Putty + Cygwin + Powershell</li>
<li>Migrate everything to a new computer</li>
<li>Uninstall applications or install multiple versions of applications (browsers, usually)</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: When to use C over C++, and C++ over C? (score [452169](https://stackoverflow.com/q/113295) in 2012)

#### Question
I've been introduced to Computer Science for a little over a year now, and from my experience it seems that C and C++ are both considered to be "ultrafast" languages, whereas others such as Python and such scripting languages are <em>usually</em> deemed somewhat slower.  

But I've also seen many cases where a software project or even a small one would interleave files where a certain number n of those files would be written in C, and a certain number m of those files would be written in C++.  

(I also noticed that C++ files almost always have corresponding headers, while C files not so much). But my main point of inquiry is to get a general sense of intuition on when it is appropriate to use C over C++, and when it is better to use C++ over C. Other than the facts that (1) C++ is object-oriented whereas C is not, and (2) the syntaxes are very similar, and C++ was intentionally created to resemble C in many ways, I am not sure what their differences are. It seems to me that they are (almost) perfectly interchangeable in many domains.  

So it would be appreciated if someone could clear up the situation! Thanks  

#### Answer accepted (score 184)
You pick C when   

<ul>
<li>you need portable assembler (which is what C is, really) for whatever reason, </li>
<li>your platform doesn't provide C++ (a C compiler is much easier to implement), </li>
<li>you need to interact with other languages that can only interact with C (usually the lowest common denominator on any platform) and your code consists of little more than the interface, not making it worth to lay a C interface over C++ code, </li>
<li>you hack in an Open Source project (many of which, for <a href="https://softwareengineering.stackexchange.com/questions/103897/is-the-c-programming-language-still-used/103904#103904">various reasons</a>, stick to C), </li>
<li>you don't know C++. </li>
</ul>

In all other cases you should pick C++.   

#### Answer 2 (score 88)
There are a few reasons to prefer C. The main one is that it tends to be more difficult to produce truly tiny executables with C++. For really small systems, you're rarely writing a lot of code anyway, and the extra ROM space that would be needed for C++ rather than C can be significant.  

I should also add, however, that for <em>really</em> tiny systems, C has problems for exactly the same reason, and assembly language is nearly the only reasonable choice. The range of system sizes within which C really makes sense is quite small, and shrinking constantly (though I'll admit, fairly slowly).  

Another time/reason to use C is to provide a set of functions that you can bind to from essentially any other language. You <em>can</em> write these functions in C++ by defining them as `extern "C"` functions, <em>but</em> doing so restricts those functions to presenting an essentially C-life "face" to the world -- classes, overloaded functions, templates, and member functions, etc., need not apply. This doesn't necessarily restrict development to C though -- it's perfectly reasonable to use any and all manner of C++ features <em>internally</em>, as long as the external interface looks like C.  

At the same time, I have to say that @Toll's answers (for one obvious example) have things just about backwards in most respects. Reasonably written C++ will generally be at least as fast as C, and often at least a little faster. Readability is generally much better, if only because you don't get buried in an avalanche of all the code for even the most trivial algorithms and data structures, all the error handling, etc.  

Templates don't "fix a problem with the language's type system", they simply add a number of fundamental capabilities almost completely absent from C and/or C++ without templates. One of the original intents was to provide for type-safe containers, but in reality they go far beyond that -- essentially none of which C provides at all.  

Automated tools are mostly a red herring as well -- while it's true that writing a C parser is less work than writing a C++ parser, the reality is that it makes virtually no difference in the end. Very few people are willing or able to write a usable parser for either one. As such, the reasonable starting point is Clang either way.  

<p>As it happens, C and C++ are fairly frequently used together on the same projects, maintained by the same people. This allows something that's otherwise quite rare: a <a href="http://www.cs.ucr.edu/~neamtiu/pubs/icse11bhattacharya.pdf">study</a> that directly, objectively compares the maintainability of code written in the two languages by people who are equally competent overall (i.e., the exact same people). At least in the linked study, one conclusion was clear and unambiguous: "We found
that using C++ instead of C results in improved software quality and reduced maintenance effort..."</p>

#### Answer 3 (score 24)
The differences between C and C++ have already been enumerated in detail <a href="https://softwareengineering.stackexchange.com/questions/16390/what-are-the-fundamental-differences-between-c-and-c">here</a>.  While sometimes people may have legitimate reasons for choosing one or the other (C++ for OOP or C when they feel like C++'s extra features introduce undesirable overhead, for example), in my experience it usually just comes down to preference.  What do the people working on this file know better and like better?  I believe this is the reason most of the time, since it's true that these languages both tackle performance critical applications.  

(Side-note: Check out <a href="http://thread.gmane.org/gmane.comp.version-control.git/57643/focus=57918" rel="nofollow noreferrer">Linus Torvads' rant</a> on why he prefers C to C++.  I don't necessarily agree with his points, but it gives you insight into why people might choose C over C++.  Rather, people that agree with him might choose C for these reasons.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How is Python used in the real world? (score [382165](https://stackoverflow.com/q/129859) in 2016)

#### Question
I'm looking to get a job as a Python programmer. I know the basics of the language and have created a few games with it using <a href="http://pygame.org">pygame</a>. I've also started to experiment with <a href="https://www.djangoproject.com/">Django</a>.  

However, looking at the job market, it doesn't seem very many Python jobs are web-related. On the desktop side of things, it doesn't seem like very many companies use the popular GUI libraries like <a href="http://www.riverbankcomputing.co.uk/software/pyqt/intro">pyQt</a> or <a href="http://wxpython.org/">wxPython</a>.  

How are companies actually using Python? What areas should one focus on to land a job as a Python programmer?  

#### Answer accepted (score 48)
The thing about interpreted languages is companies that don't want to give their source code away don't use it in delivered software, so almost all the jobs you will see are web related.  You might have better luck searching for specific frameworks like Django.  If there's an open source project written in python you like, you might apply to a company that sponsors it.  

It usually won't make it into the job description, but it's almost an underground among programmers who use languages like C++ to use python when they have a choice, for one-off utilities, in-house applications, or things like automated test scripts that aren't shipped with their official product.  

Some high-end software like Maya uses python for scripting, so that might be another route to pursue.    

#### Answer 2 (score 21)
I've used python at my current and my previous job for creating automated testing frameworks, for writing automated tests, and for writing desktop applications used by our testers. In my previous job they also used python for a lot of other internal tools, build scripts, system monitoring and logging tools and so on.  

Python and other dynamic languages may not always be used to create the product, but they often power the tools that build the product. Don't just look for companies that sell products based on python, look for companies that have smart internal systems groups that aren't required to use compiled languages. I've built a very long career almost entirely with dynamic languages like python, perl, ruby and Tcl and have loved every minute of it.   

#### Answer 3 (score 14)
It is worth pointing out this <a href="http://python.org/about/success/">page on python success stories over at python.org</a>. It has   

<blockquote>
  41 real-life Python success stories, classified by application domain.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: What is the difference between these senior software engineer titles? (score [378017](https://stackoverflow.com/q/46366) in 2016)

#### Question
I'm currently a senior research software engineer at a large company and am being offered a "senior staff engineer" position somewhere else. I am not sure if the new position's title conveys a sideways move or an advancement.  

So, all other things being roughly equal (salary, domain of expertise, etc.), what is the external difference between these software engineer titles (in general and regardless of any particular company, if possible):  

<ul>
<li>senior engineer</li>
<li>senior research engineer</li>
<li>senior staff engineer</li>
<li>member of technical staff</li>
<li>principal engineer</li>
</ul>

<p>Edit:
Let me elaborate on "member of technical staff" since it's kind of uncommon. I think it's a high title, commonly associated with research. I know that Oracle, VMWare, and the old Bell Labs have these titles. See: <a href="http://en.wikipedia.org/wiki/Member_of_Technical_Staff">Member of Technical Staff</a> . I know what it means, but I don't know how it stacks up against the other titles, which is why I asked.</p>

#### Answer 2 (score 132)
"So all things being equal" They're not. These titles are not equivalent.  

I would rank them like this, highest to lowest:  

<ul>
<li>Principal Engineer</li>
<li>Senior Staff Engineer</li>
<li>Staff Engineer</li>
<li>Senior Engineer / Senior Research Engineer</li>
</ul>

In general, "senior" implies depth of experience and maturity to work independently with less direct guidance in day to day activities.  An engineer can expect to receive assignments or tasks and external prioritization.  A Senior Engineer should expect to identify and prioritize such tasks for themselves.  

A Senior Engineer is typically someone with deep knowledge of a technology or product line and experience with multiple release cycles.  

A Senior Research Engineer sounds like someone who is not as involved in production cycles but is more focused on algorithms or long term strategic work.  

"Member of the Technical Staff" does not imply any seniority or programming experience.  A receptionist can be a Member of the Technical Staff.  

A Staff Engineer typically has deep experience with and contributes to multiple technologies and product lines across a company.  

A Senior Staff Engineer does all the staff engineer stuff, plus works more in a leadership role across multiple product lines or technologies. Senior staff should also be thinking ahead for strategic planning and execution.  

A Principal Engineer is often the top of the technical ladder in many companies, or just short of "Technical Fellow" or "Chief Scientist". Principals are also called architects in various fashions.  Principal Engineers are responsible for macro scale architecture of a software technology or product line, and providing guidance and oversight to multiple development teams working on different products or technologies to ensure that the technologies interoperate or connect to each other appropriately.  

These are my opinions not as an HR manager but as an engineer who as worked in (and helped define) all of these roles.  

#### Answer 3 (score 34)
The only way to know for sure is to get a job description (list of responsibilities, expected skills) for each position. The qualifiers on these titles seem arbitrary and will vary from company to company.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How to describe your skill levels in the CV? (score [368476](https://stackoverflow.com/q/85339) in 2016)

#### Question
What are possible/standard words to describe your skill levels in different programming languages in your CV? I currently use these three:  

<ul>
<li>expert</li>
<li>advanced</li>
<li>beginner</li>
</ul>

I do not consider myself an expert in any programming language, so I classify all my skills as either beginner or advanced. However, I would like to differentiate more. I am especially looking for something between <em>advanced</em> and <em>expert</em>. Any suggestions? Or should I not even bother to differentiate any more detailed?  

#### Answer 2 (score 17)
I would split them into two groups:  

<strong>Working knowledge</strong>  

// Here goes a list of the technologies you have worked with and feel comfortable using. You can make use of them right now if asked (with all the help there is of course).  

<strong>Basic knowledge</strong>  

// List of the things you have played with or have a basic understanding of their purpose. You can't make practical use of them without studying them in deep first.  

That's pretty much the basic dichotomy your employer would understand and would hardly ask for more. Unless an expert level with some technology is asked for specifically.  

#### Answer 3 (score 15)
I don't explicitly indicate my skills and experience with each technology or tool on my resume. Instead, when I provide descriptions of each job and my duties as well as my personal and academic projects, I also mention the core technologies that I've used in support of that position. Every place that I've applied to either asked for a cover letter or provided an application form, which I used to enumerate specific skills that I had (focusing on those relevant to the job description that I was applying to) and described my level of experience with each one.  

There are two problems that I see with listing your skills explicitly.  

First, you have to tailor your resume even more for each job that you apply to. In order to save space, you are going to want to focus on the skills that are listed in the job description plus anything else that you feel is relevant. You can't possibly list every skill you have - I know that for me, it would take up way too much space. As you gain experience and knowledge, it'll only become harder to choose what to enumerate.  

Second, how do you define "expert", "advanced", and "beginner"? Where do you draw the line? Things that I think a beginner should know might be something that you consider to be advanced. Using such ambiguous words doesn't give me any information about you as a candidate for a position. On top of that, languages (or any skill) cover a lot of areas. I could be an expert Java Swing developer, but have no knowledge of Java networking and limited threading knowledge. Am I a beginner, advanced, or expert at Java? Your work experience will let me know what aspects of the language you have used and for how long.  

I honestly don't think it's about the skills that you have, but rather what you are capable of learning and contributing to the project, team, and organization. That's the approach I've taken and it appears to have worked quite well for me - I've obtained two six-month co-ops, three summer internships, a TA position, and a full-time job (pending paperwork) with this approach.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: For what reasons  should I choose C# over Java and C++? (score [360796](https://stackoverflow.com/q/125712) in 2011)

#### Question
C# seems to be popular these days. I heard that syntactically it is almost the same as Java. Java and C++ have existed for a longer time. For what reasons should I choose C# over Java and C++?  

#### Answer 2 (score 76)
The question should be "Which language is better suited for modern, typical application development?".  

Edit: I addressed some of the comments below. A small remark: consider that when you have a lot of things natively, as idioms, it's a big difference than implementing or downloading and using them yourself every time. Almost everything can be implemented in any of these languages. The question is - what the languages natively provide you with.  

So off the top of my head (some arguments apply to both languages)...  

<h5>C# is better than C++ in that:</h3>

<ul>
<li>It has <em>native</em>  garbage-collection.</li>
<li>It allows you to treat class-methods' signatures as free functions (i.e. ignoring the statically typed `this` pointer argument), and hence create more dynamic and flexible relationships between classes. <strong>edit</strong> if you don't know what this means, then try assigning a member method returning void and accepting void to a `void (*ptr)()` variable. C# delegates carry the `this` pointer with them, but the user doesn't always have to care about that. They can just assign a `void()` method of any class to any other `void()` delegate.</li>
<li>It has a huge standard library with so much useful stuff that's well-implemented and easy to use.</li>
<li>It allows for both managed and native code blocks.</li>
<li>Assembly versioning easily remedy DLL hell problems.</li>
<li>You can set classes, methods and fields to be assembly-internal (which means they are accessible from anywhere within the DLL they're declared in, but not from other assemblies).</li>
</ul>

<h5>C# is better than Java in that:</h3>

<ul>
<li>Instead of a lot of noise (EJB, private static class implementations, etc) you get elegant and friendly native constructs such as Properties and Events.</li>
<li>You have real generics (not the bad casting joke that Java calls generics), and you can perform reflection on them.</li>
<li>It supports native resource-management idioms (the `using` statement). Java 7 is also going to support this, but C# has had it for a way longer time.</li>
<li>It doesn't have checked exceptions :) (debatable whether this is good or bad)</li>
<li>It's deeply integrated with Windows, if that's what you want.</li>
<li>It has Lambdas and LINQ, therefore supporting a small amount of functional programming.</li>
<li>It allows for both generic covariance and contravariance explicitly.</li>
<li>It has dynamic variables, if you want them.</li>
<li>Better enumeration support, with the `yield` statement.</li>
<li>It allows you to define new value (or non-reference) types.</li>
</ul>

<h5>Edit - Addressing comments</h3>

<ul>
<li>I didn't say C++ doesn't support native RAII. I said Java doesn't have it (you have to explicitly do a try/finally). C++ has auto pointers which are great for RAII, and (if you know what you're doing) can also substitute garbage-collection.</li>
<li>I didn't say anything about <em>emulating</em> free functions. But for example if you need to access a field by a `this` pointer, and bind the method that does it to a generic function pointer (i.e. not in the same class), then there's simply no native way to do it. In C#, you get the for free. You don't even have to know how it works.</li>
<li>By "treating member methods as free functions" I meant that you can't, for example, natively bind a member method to a free function signature, because the member method "secretly" needs the `this` pointer.</li>
<li>The `using` statement, obviously along with IDisposable wrappers, is a great example of RAII. See <a href="http://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization#Closure_blocks">this link</a>. Consider that you don't need RAII as much in C# as you do in C++, because you have the GC. For the specific times you do need it, you can explicitly use the `using` statement. Another little reminder: freeing memory is an expensive procedure. GC have their performance advantage in a lot of cases (especially when you have lots of memory). Memory won't get leaked, and you won't be spending a lot of time on deallocating. What's more, allocation is faster as well, since you don't allocate memory every time, only once in a while. Calling `new` is simply incrementing a last-object-pointer.</li>
<li>"C# is worse in that it has garbage collection". This is indeed subjective, but as I stated at the top, for most modern, typical application development, garbage collection is one hell of an advantage.<br>
In C++, your choices are either to manually manage your memory using `new` and `delete`, which empirically always leads to errors here and there, or (with C++11) you can use auto pointers natively, but keep in mind that they add <em>lots and lots of noise</em> to the code. So GC still has an edge there.</li>
<li>"Generics are way weaker than templates" - I just don't know where you got that from. Templates might have their advantages, but in my experience constraints, generic parameter type-checking, contravariance and covariance are much stronger and elegant tools. The strength in templates is that they let you play with the language a bit, which might be cool, but also causes lots of headaches when you want to debug something. So all in all, templates have their nice features, but I find generics more practical and clean.</li>
</ul>

#### Answer 3 (score 30)
<h5>The Environment</h1>

<h5>.NET Framework and Windows clients</h3>

Windows is the dominating Operating System on client computers. The best GUI frameworks for Windows applications is Winforms and WPF together with <strong>.NET Framework</strong>. The best programming language to work with the <strong>.NET Framework</strong> and it's APIs is <strong>C#</strong>. Java is not an alternative for this. And C++ is an older language without automatic memory management. C# is similar to C++ but has automatic memory management and you don't have to work with pointers, which make you more productive. C++ can still be the best option for some cases, but not for form-intensive database applications that is common in business.  

<h5>IIS and Windows Server</h3>

If you are used to work in the Windows environment and with C#, you will need the least investment to learn IIS for server programming and  Windows Server for basic administration.  

<h5>Active Directory and Windows Server</h3>

If you are developing software that is going to be deployed in company networks, it's likely that they use an Windows centered environment using a Windows Server with Active Directory. In such an environment it's easist to integrate and deploy an solution made in <strong>C#</strong> and <strong>.NET Framework</strong>.  

Personally, I'm a Java developer, not a C# developer, but I work with the web. I would switch to C# if I were developing network applications for Windows network. But I prefer Java for Linux based web servers. I would choose C++ for embedded systems were I don't won't many dependecies.  

Yes, <strong>C#</strong> is a better language with more modern features than C++ and Java, but that is <strong>not</strong> the most important thing for choosing <strong>C#</strong>.  

<h5>Summary</h2>

The environment for your software is most important for choosing <strong>C#</strong>. If you work in an environment with <strong>Windows clients, Windows servers, Active Directory, IIS</strong> and maybe <strong>SQL Server</strong> then <strong>C#</strong> is the far best language with the <strong>.NET Framework</strong>.  

If you work in a Unix environment with e.g. web services, Java would be my choice. And if you work with embedded systems or have to integrate with hardware devices <strong>C++</strong> would be a good choice.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: When should you call yourself a senior developer? (score [356666](https://stackoverflow.com/q/25564) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://softwareengineering.stackexchange.com/questions/14914/whats-the-difference-between-entry-level-jr-sr-developers">Whats the difference between Entry Level/Jr/Sr developers?</a>  </p>
</blockquote>



I'm curious what senior developer means because apparently the definition doesn't mean what I thought it would. I keep seeing these teens at 22-23 years old who call themselves senior X developer or senior Y developer. To me, a senior must have 10 years or so experience in programming to call himself 'senior'. I've seen a lot of these teens here (hence the question). Am I wrong? Why?  

#### Answer accepted (score 423)
You can call yourself a Senior when:  

<ul>
<li>You can handle the entire software development life cycle, end to end</li>
<li>You lead others, or others look to you for guidance. </li>
<li>You can self manage your projects</li>
</ul>

Software development is a curious creature unlike other fields.  

<blockquote>
  Sometimes, a fresh punk out of college can run circles around veterans who have 20+ years of "experience". Programming is a bizarre world where <strong>code is king</strong>.    
</blockquote>

Some achieve the above in 2 years or less, others take 10 years.  

#### Answer 2 (score 238)
When I hear “Senior Developer” I think of someone who has mastered programming. I think of a person who can design, code and test a system. They can talk to system architecture or component design. They understand and use design patterns.  This person can anticipate the performance bottlenecks, but knows not to pre-optimize. This person will leverage asynchronous programming, queuing, caching, logging, security and persistence when appropriate. When asked they can give a detail explanation of their choice and the pros and cons. In most cases they have mastered object oriented programming and design, this not an absolute other languages such as Javascript, F#, Scheme are powerful and are not object oriented. They are adept in risk management and most important of all they can communicate the before mentioned to their peers.  

<p>What is mastery? There is a generally accepted idea, that to master ANY one skill it takes 10,000 hours of repetition for the human body and mind to grasp and internalize a skill. This is written to at length in Malcolm GladWell’s book <a href="http://rads.stackoverflow.com/amzn/click/0316017922" rel="noreferrer">Outliers</a>.
When the original author talked about mastering a field, he was refering to reach the top of a highly competitive field would take 10,000 hours. </p>

Some examples of in Malcolm GladWell’s Outliers are:  

<strong>Mozart</strong> his first concerto at the young age of 21. Which at first seems young, but he has been writing music since he was 11 years old.  

<strong>The Beatles</strong> were initially shunned. They were told they did not have the mustard and should consider a different line of work. They spend 3 years in Germany playing about 1200 times at different venues, each time being 5 to 8 hours in length. They re-emerged as the Beatles we know and love today.  

And lastly, <strong>Bill Gates</strong> at age 20 dropped out of Harvard to found Microsoft. To some this might seem foolish, but considered at 20 he had spent nearly half of his young life programming. In 1975, only maybe 50 people in the world had the experience he did. His experience gave him the foresight to see the future in Microsoft.  

Peter Norvig also discusses the 10,000 hours rule in his essay “<a href="http://norvig.com/21-days.html" rel="noreferrer">Teach Yourself Programming in Ten Years</a>”.   

In the book <a href="http://rads.stackoverflow.com/amzn/click/0452267560" rel="noreferrer">Mastery</a> by George Leonard, great detail is given on how to master a skill. One must practice the skill over and over and over again. The more the repetition, the more you become aware of the differences in each repetition. Only with this insight can you become better.  

The software industry’s titles (Junior, Mid-Level and Seniors) are misleading and inconsistent from organization to organization. I’ve worked with companies, who defined a Senior Developer as someone with 5 years or more of experience. There is no mention to the quality of the experience, just that they sat in front of a computer for 5 years. In working with these folks, many of them had not yet grasp object oriented programming -- yet they were considered Senior Developers.   

There must be a better more objective way to measure the skill set of a software engineer. <a href="http://fullof.bs/john-haugeland/" rel="noreferrer">John Haugeland</a> posted a computer programmer’s skills matrix. It’s an objective way to measure a <a href="http://www.indiangeek.net/wp-content/uploads/Programmer%20competency%20matrix.htm" rel="noreferrer">programmer’s skill level</a>, which otherwise is left to gut feeling.  

When looking at software engineers I see 4 tiers of skills: Luminary, Senior, Mid-Level and Junior.  

<strong>Luminary (10+ years)</strong> is one who has mastered a skill and has set about improving their respective discipline. Some examples include: <a href="http://blogs.tedneward.com/" rel="noreferrer">Ted Neward</a>, <a href="http://blog.objectmentor.com/" rel="noreferrer">Uncle Bob Martin</a>, Donald Knuth, <a href="http://ayende.com/blog/" rel="noreferrer">Oren Eini</a>, <a href="http://norvig.com/" rel="noreferrer">Peter Norvig</a>, Linus Torvalds. Luminaries change based on your skill-set.  

<strong>Senior (7 to 10+ years, Level 3)</strong>  is one who has spent the last 10,000 hours programing in a specific genre. There is a strong understanding of design patterns, They leverage asynchronous programming, queuing, caching, logging, security and persistence when appropriate.   

It’s very possible that a Senior will never reach Luminary. Luminaries are often found speaking and writing. They are actively trying to impact their discipline.  

<strong>Mid-Level (4 to 6 years, Level 2)</strong> is one who understands day to day programming. They work independently and create robust solutions. However they have yet to experience creating or maintaining large or complex systems. In general Mid-Level developers are great with component level development.  

<strong>Junior (1 to 3 years, Level 1)</strong> is one who understands the basics of programming. They either have a degree in software engineering or computer science or they are self taught. Their code is continually reviewed. Guidance is given in regards to algorithms, maintainability and structure.  

#### Answer 3 (score 111)
<em>"When should you call yourself a senior developer?"</em> - <strong>When I started to mentor junior developers.</strong>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: I'm graduating with a Computer Science degree but I don't feel like I know how to program (score [340953](https://stackoverflow.com/q/43528) in 2019)

#### Question
I'm graduating with a Computer Science degree but I see websites like Stack Overflow and search engines like Google and don't know where I'd even begin to write something like that. During one summer I did have the opportunity to work as a iPhone developer, but I felt like I was mostly gluing together libraries that other people had written with little understanding of the mechanics happening beneath the hood.  

I'm trying to improve my knowledge by studying algorithms, but it is a long and painful process. I find algorithms difficult and at the rate I am learning a decade will have passed before I will master the material in the book. Given my current situation, I've spent a month looking for work but my skills (C, Python, Objective-C) are relatively shallow and are not so desirable in the local market, where C#, Java, and web development are much higher in demand. That is not to say that C and Python opportunities do not exist but they tend to demand 3+ years of experience I do not have. My <a href="http://en.wikipedia.org/wiki/Grade_%28education%29" rel="nofollow noreferrer">GPA</a> is OK (3.0) but it's not high enough to apply to the large companies like IBM or return for graduate studies.  

Basically I'm graduating with a Computer Science degree but I don't feel like I've learned how to program. I thought that joining a company and programming full-time would give me a chance to develop my skills and learn from those more experienced than myself, but I'm struggling to find work and am starting to get really frustrated.  

I am going to cast my net wider and look beyond the city I've grown up in, but what have other people in similar situation tried to do? I've worked hard but don't have the confidence to go out on my own and write my own app. (That is, become an indie developer in the iPhone app market.) If nothing turns up I will need to consider upgrading and learning more popular skills or try something marginally related like IT, but given all the effort I've put in that feels like copping out.  

#### Answer 2 (score 533)
Best way to learn to program is to write programs.  

Two suggestions :  

<ul>
<li>develop a game</li>
<li>develop a web site</li>
</ul>

Algorithms, while useful, and should be understood, actually play second fiddle to software design. TDD / Design Patterns / Architecture / Refactoring / Unit Testing / The process of putting code together / etc tend to be far more important skills.  

Also, far better to do this in your own time.  Don't wait to work this stuff out on the job.  I find the people who tend to do better are the ones who early in their careers put the effort in to develop their skills in their own time.  Usually because they are genuinely passionate about software development  

<ul>
<li>One more thing is to "<strong>Read books and samples</strong>" and don't be ashamed to ask. If you want to learn you should ask :)</li>
</ul>

#### Answer 3 (score 388)
<blockquote>
  I felt like I was mostly gluing together libraries that other people had written  
</blockquote>

While I understand why you feel like this wasn't "real programming", the truth is that integration work makes up a significant percentage of the typical workload for a corporate programmer.  Your experience might be a little more valuable than you think :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: What does 'stage' mean in git? (score [308343](https://stackoverflow.com/q/119782) in 2019)

#### Question
I find git hard to understand as I could not find the meaning of the words used for the actions. I have checked the dictionary for the meaning of 'stage' and none of the meanings were related to source control concepts.  

What does 'stage' mean in the context of git?  

#### Answer 2 (score 311)
To <em>stage</em> a file is simply to prepare it finely for a commit. Git, with its index allows you to commit only certain parts of the changes you've done since the last commit. Say you're working on two features - one is finished, and one still needs some work done. You'd like to make a commit and go home (5 o'clock, finally!) but wouldn't like to commit the parts of the second feature, which is not done yet. You stage the parts you know belong to the first feature, and commit. Now your commit is your project with the first feature done, while the second is still in work-in-progress in your working directory.  

<img src="https://i.stack.imgur.com/zLTpo.png" alt="">  

#### Answer 3 (score 139)
Since everyone so far has answered it the "formal" way, let me do this with alternatives to enhance learning with the power of metaphors.   

So the <em>staging area</em> is like:  

<ul>
<li>a cache of files that you want to commit</li>
<li>not a series of tubes but actually a dump truck, ready to move the work you load it with, in to the repository</li>
<li>a magical place where selected files will be turned into stone with your wizardry and can be magically transported to the repository at your whim</li>
<li>the yellow brick road for the files to go happily to the repository (or fall off if you want to revert)</li>
<li>the fictional place at the sea port where files are received a pair of cement shoes and then thrown into the repository sea</li>
<li>the receptions desk at the library, you put the files there for the librarian to prepare for filing into the library</li>
<li>a box where you put things in before shoving it under your bed, where your bed is a repository of boxes you've previously have shoved in</li>
<li>the loading bay of files before it goes into the repository warehouse with the power loader</li>
<li>the filter of an electric drip coffee maker, if the files are like the coffee powder, then the committed files are the brewed coffee</li>
<li>the Scrooge McDuck's office next to the vault, the files are like the coins before they go into the vault of his massive Money Bin</li>
<li>the pet store, once you bring a pet home you're committed</li>
</ul>

It's <strong>magical</strong>!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How do I create my own programming language and a compiler for it (score [301798](https://stackoverflow.com/q/84278) in 2011)

#### Question
I am thorough with programming and have come across languages including BASIC, FORTRAN, COBOL, LISP, LOGO, Java, C++, C, MATLAB, Mathematica, Python, Ruby, Perl, JavaScript, Assembly and so on. I can't understand how people create programming languages and devise compilers for it. I also couldn't understand how people create OS like Windows, Mac, UNIX, DOS and so on. The other thing that is mysterious to me is how people create libraries like OpenGL, OpenCL, OpenCV, Cocoa, MFC and so on. The last thing I am unable to figure out is how scientists devise an assembly language and an assembler for a microprocessor. I would really like to learn all of these stuff and I am 15 years old. I always wanted to be a computer scientist someone like Babbage, Turing, Shannon, or Dennis Ritchie.  

<hr>

I have already read Aho's Compiler Design and Tanenbaum's OS concepts book and they all only discuss concepts and code in a high level. They don't go into the details and nuances and how to devise a compiler or operating system. I want a concrete understanding so that I can create one myself and not just an understanding of what a thread, semaphore, process, or parsing is. I asked my brother about all this. He is a SB student in EECS at MIT and hasn't got a clue of how to actually create all these stuff in the real world. All he knows is just an understanding of Compiler Design and OS concepts like the ones that you guys have mentioned (i.e. like Thread, Synchronization, Concurrency, memory management, Lexical Analysis, Intermediate code generation and so on)  

#### Answer 2 (score 407)
Basically, your question is "how are computer chips, instruction sets, operating systems, languages, libraries, and applications designed and implemented?"  That's a multi-billion dollar worldwide industry employing millions of people, many of whom are specialists. You might want to focus your question a bit more.  

That said, I can take a crack at:  

<blockquote>
  I can't understand how people create programming languages and devise compilers for it.  
</blockquote>

It is surprising to me, but lots of people do look at programming languages as magical. When I meet people at parties or whatever, if they ask me what I do I tell them that I design programming languages and implement the compilers and tools, and it is surprising the number of times people -- professional programmers, mind you -- say "wow, I never thought about it, but yeah, someone has to design those things".  It's like they thought that languages just spring up wholly formed with tool infrastructures around them already.  

They don't just appear. Languages are designed like any other product: by carefully making a series of tradeoffs amongst competing possibilities. The compilers and tools are built like any other professional software product: by breaking the problem down, writing one line of code at a time, and then testing the heck out of the resulting program.  

Language design is a huge topic. If you're interested in designing a language, a good place to start is by thinking about what the deficiencies are in a language that you already know. Design decisions often arise from considering a design defect in another product.  

Alternatively, consider a domain that you are interested in, and then design a domain-specific language (DSL) that specifies solutions to problems in that domain. You mentioned LOGO; that's a great example of a DSL for the "line drawing" domain. Regular expressions are a DSL for the "find a pattern in a string" domain. LINQ in C#/VB is a DSL for the "filter, join, sort and project data" domain. HTML is a DSL for the "describe the layout of text on a page" domain, and so on. There are lots of domains that are amenable to language-based solutions. One of my favourites is Inform7, which is a DSL for the "text-based adventure game" domain; it is probably the highest-level serious programming language I've ever seen. Pick a domain you know something about and think about how to use language to describe problems and solutions in that domain.  

Once you have sketched out what you want your language to look like, try to write down <em>precisely</em> what the rules are for determining what is a legal and illegal program. Typically you'll want to do this at three levels:   

<ol>
<li><em>lexical</em>: what are the rules for words in the language, what characters are legal, what do numbers look like, and so on.</li>
<li><em>syntactic</em>: how do words of the language combine into larger units? In C# larger units are things like expressions, statements, methods, classes, and so on.</li>
<li><em>semantic</em>: given a syntactically legal program, how do you figure out what the program <em>does</em>?</li>
</ol>

Write down these rules <em>as precisely as you possibly can</em>. If you do a good job of that then you can use that as the basis for writing a compiler or interpreter. Take a look at the C# specification or the ECMAScript specification to see what I mean; they are chock-full of very precise rules that describe what makes a legal program and how to figure out what one does.  

One of the best ways to get started writing a compiler is by writing a <strong>high-level-language-to-high-level-language</strong> compiler. Write a compiler that takes in strings in your language and spits out strings in C# or JavaScript or whatever language you happen to know; let the compiler for that language then take care of the heavy lifting of turning it into runnable code.   

I write a blog about the design of C#, VB, VBScript, JavaScript and other languages and tools; if this subject interests you, check it out. <a href="http://blogs.msdn.com/ericlippert">http://blogs.msdn.com/ericlippert</a> (historical) and <a href="http://ericlippert.com">http://ericlippert.com</a> (current)  

In particular you might find this post interesting; here I list most of the tasks that the C# compiler performs for you during its semantic analysis. As you can see, there are a lot of steps. We break the big analysis problem down into a series of problems that we can solve individually.  

<a href="http://blogs.msdn.com/b/ericlippert/archive/2010/02/04/how-many-passes.aspx">http://blogs.msdn.com/b/ericlippert/archive/2010/02/04/how-many-passes.aspx</a>  

Finally, if you're looking for a job doing this stuff when you're older then consider coming to Microsoft as a college intern and trying to get into the developer division. That's how I ended up with my job today!  

#### Answer 3 (score 127)
You might find <a href="http://compilers.iecc.com/crenshaw/">Lets Build a Compiler</a> by Jack Crenshaw an interesting introduction to writing compilers and assembly language.  

The author kept it very simple and focussed on building actual functionality.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Relationship between C#, .NET, ASP, ASP.NET etc (score [291920](https://stackoverflow.com/q/44810) in )

#### Question
I'm really unclear on the difference between C#, C#.NET and the same for ASP and other '.NET' languages.  

From what I understand, .NET is a library/framework of... things. I think they're essentially access to Windows data such as form elements etc, but that doesn't seem to apply for ASP.NET.  

In addition, I see people calling themselves '.NET' developers. Does this mean they're fluent in C#, ASP and other languages?  

Finally, I never see C# without .NET attached. Is C# tied that closely to .NET as to be unusable without it?  

In summary: what exactly does .NET provide? How does it relate to C# and ASP etc? What does 'a .NET developer' mean? And finally, why do you never see C# without .NET?  

[As an aside, I realise these are multiple questions, but I think they are very inter-related (or at least that is the impression that browsing Programmers / SO etc has given me)].  

#### Answer accepted (score 172)
I understand your confusion, believe me I have the same perspective when it comes to the Java world! Anyway I'll attempt to break your questions down and tackle them one by one... as well as add some other points in that will hopefully help clarify what's going on:  

<ol>
<li>C# and C#.NET are the same thing... C#</li>
<li>.NET is, as you say, a library of code that .NET languages can talk to.</li>
<li>.NET languages come in different flavours such as: C#.NET, VB.NET, Managed C++, F#.</li>
<li>.NET languages compile to CIL (<a href="http://en.wikipedia.org/wiki/Common_Intermediate_Language">Common Intermediate Language</a>) which means they all start "talking" the same language and can therefore interoperate.</li>
<li>ASP.NET is the portion of the .NET library used for making web sites. There are other subsections of ASP.NET like WebForms (the old way of making web pages) or the rapidly maturing MVC library that are worth looking at too.</li>
<li>Forms (old tech) or the new WPF (Windows Presentation Foundation) are the technologies you'd typically use in .NET to create what you know as traditional desktop applications.</li>
</ol>

One final thing I'd like to finish on is the difference between library and framework. In recent years these two terms have been used as those synonymous, however that is not the case. The easiest way I can think to differentiate the two is:  

<ul>
<li>A library contains many pieces of functionality that you may pick and choose from i.e. using one piece of technology doesn't mean you're locked into the rest. This means freedom, however you will have more work cut out for you.</li>
<li>A framework however very much sets out how you will be working. It provides a workflow that for better or worse is hard to change. This means rapid development/prototyping, but if significant changes are made in the future it may be impossible (or very time consuming) to implement them.</li>
</ul>

The project you're working on will depend on which choice you make.  

#### Answer 2 (score 23)
.NET is an application development framework - it contains numerous libraries containing a range of functionality.  

C# is a language created for use with .NET. It's not the only .NET-compatible language - other options include VB.NET, F#, Managed C++, IronRuby, and IronPython. You write code in the language of your choice to use the functionality in the .NET framework.  

ASP.NET is an extension of .NET that helps you with writing web-based applications and websites. Much of the overall framework is available (or useful, in the case of e.g. WinForms) in this context.  

[Classic] ASP is an older web framework, also from Microsoft. Despite the similar names, ASP and ASP.NET are quite different under the hood. One notable difference is that your only language options for ASP are VBScript and JScript. ASP is an older and outdated technology, do not trouble yourself with it.  

#### Answer 3 (score 14)
First off, .Net is a bytecode framework, similar to Java bytecode. .Net however is only BYTECODE. There isn't a ".Net" official language. The two main languages targetting .Net are C# and VB.Net. ASP.Net is an extension to the provided .Net library to enable applications written in C# or VB.Net(or other .Net targetted languages) to work as a website.  

Developers who say they know .Net usually mean they know C# or VB.Net, or both, and can easily learn whichever one they don't know(C# and VB.Net are extremely similar languages aside from general syntax)  

Lastly, ASP IS NOT the same as ASP.Net. They have huge differences  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Where can I find programming puzzles and challenges? (score [279626](https://stackoverflow.com/q/756) in 2016)

#### Question
I'm trying to find places where I can hone my craft outside the context of school or work. Are there places online, or books available, where I can access lists of programming puzzles or challenges?  

#### Answer accepted (score 293)
<strong><em>Moderator note:</strong> this is intended to be a canonical list; please check to see if your suggestion has already been added to the answer. If it hasn't, edit the answer to add yours, preferably with an explanation or reason why you're suggesting it.</em>  

<h5>On Stack Exchange</h3>

Pick a tag, follow the new questions posted, and try to solve them. If you find a good one, bookmark it for later use:  

<ul>
<li><a href="http://stackoverflow.com">Stack Overflow</a></li>
<li><a href="https://codereview.meta.stackexchange.com/questions/tagged/community-challenge">Code Review Community Challenges</a></li>
<li><a href="http://codegolf.stackexchange.com">Programming Puzzles and Code Golf</a></li>
<li><a href="http://www.ideserve.co.in/" rel="noreferrer">Solve algorithmic and datatypes problems</a></li>
</ul>

<h5>Books</h3>

<ul>
<li><a href="https://rads.stackoverflow.com/amzn/click/1453792996" rel="noreferrer"><em>Algorithms for Interviews</em></a> by Adnan Aziz</li>
<li><a href="https://rads.stackoverflow.com/amzn/click/0984782850" rel="noreferrer"><em>Cracking the Coding Interview (6th Edition)</em></a> by Gayle Laakmann</li>
<li><a href="https://rads.stackoverflow.com/amzn/click/0387001638" rel="noreferrer"><em>Programming Challenges</em></a> by Steven S. Skiena</li>
<li><a href="https://rads.stackoverflow.com/amzn/click/0321751043" rel="noreferrer"><em>The Art of Computer Programming</em></a> by Donald E. Knuth</li>
</ul>

<h5>Communities and Blogs</h3>

<ul>
<li><a href="http://groups.google.com/group/algogeeks/topics" rel="noreferrer">Algorithm Geeks Google Group</a></li>
<li><a href="http://www.codekata.com/" rel="noreferrer">CodeKata</a></li>
<li><a href="http://forum.lessthandot.com/viewforum.php?f=102" rel="noreferrer">LessThanDot's Programmer Puzzles forum</a></li>
<li><a href="http://thedailywtf.com/Series/Bring_Your_Own_Code.aspx" rel="noreferrer">The Daily WTF's Bring Your Own Code series</a></li>
<li><a href="http://www.reddit.com/r/dailyprogrammer" rel="noreferrer">/r/dailyprogrammer</a></li>
</ul>

<h5>Game sites and ongoing contests</h3>

<ul>
<li><a href="http://www.codingame.com/" rel="noreferrer">Codingame</a> - fun games (solo and multiplayer) to practice your coding skills. Supports 25+ programming languages.</li>
<li><a href="http://www.codechef.com/" rel="noreferrer">CodeChef</a></li>
<li><a href="https://codecombat.com/" rel="noreferrer">Code Combat</a> - Javascript and Python solo and multiplayer games in the style of a strategy game.</li>
<li><a href="http://www.hacker.org/challenge/about.php" rel="noreferrer">Hacker.org Challenge</a> — "The hacker.org challenges are a series of puzzles, tricks, tests, and brainteasers designed to probe the depths your hacking skills. To master this series you will need to crack cryptography, write clever code, and dissect the impenetrable; and in the process you will enrich your understanding of the world of hacking."</li>
<li><a href="http://www.pexforfun.com/" rel="noreferrer">Pex for fun</a> — game from Microsoft research where you duel against other programmers</li>
<li><a href="http://www.rankk.org/" rel="noreferrer">Rankk</a> — "You start with the easy levels and progress to the intermediate and hard levels by solving the minimum number of required challenges at each level. The journey to the top is an arduous yet rewarding one. You need to be sufficiently determined and persevering to go far. Only a few are expected to reach the apex and attain Geb."</li>
<li><a href="http://www.topcoder.com/" rel="noreferrer">TopCoder</a> </li>
<li><a href="http://code.google.com/codejam/contests.html" rel="noreferrer">Google Code Jam</a>—algorithmic puzzles</li>
</ul>

<h5>Language specific</h3>

<ul>
<li><p><a href="http://4clojure.com/" rel="noreferrer">4Clojure</a> (Clojure) — "4Clojure is a resource to help fledgling clojurians learn the language through interactive problems. The first few problems are easy enough that even someone with no prior experience should find the learning curve forgiving. See 'Help' for more information."</p></li>
<li><p><a href="https://sites.google.com/site/prologsite/prolog-problems" rel="noreferrer">Prolog Problems</a> (Prolog) — "The purpose of this problem collection is to give you the opportunity to practice your skills in logic programming. Your goal should be to find the most elegant solution of the given problems. Efficiency is important, but logical clarity is even more crucial. Some of the (easy) problems can be trivially solved using built-in predicates. However, in these cases, you learn more if you try to find your own solution."</p></li>
<li><p><a href="http://www.pythonchallenge.com/" rel="noreferrer">Python Challenge</a> (Python) — "Python Challenge is a game in which each level can be solved by a bit of (Python) programming."</p></li>
<li><p><a href="http://www.rubyquiz.com/" rel="noreferrer">Ruby Quiz</a> (Ruby) - "Ruby Quiz is a weekly programming challenge for Ruby programmers in the spirit of the Perl Quiz of the Week. A new Ruby Quiz is sent to the Ruby Talk mailing list each Friday."</p></li>
<li><p><a href="http://www.ioccc.org/" rel="noreferrer">IOCCC</a> (C) - "A contest to write the most obscure/obfuscated C program. (Fun to try to understand the previous year's entries, or to submit a new one.)"</p></li>
<li><p><a href="http://www.underhanded-c.org/" rel="noreferrer">Underhanded C Contest</a> (C) - "contest to turn out code that is malicious, but passes a rigorous inspection, and looks like an honest mistake. (Try to understand previous year's entries, and learn to find similar mistakes in other people's code)"</p></li>
<li><p><a href="https://checkio.org" rel="noreferrer">CheckiO</a> - Python programming challenges. Custom "Missions" can be created by members.</p></li>
</ul>

<h5>Online judges / automatic assessment</h3>

<ul>
<li><a href="http://codingbat.com/" rel="noreferrer">Codingbat</a> has lots of coding challenges ranging from warm-ups to Harder recursion problems. It is available in Java and Python.</li>
<li><a href="http://www.cyber-dojo.org/" rel="noreferrer">Cyber-dojo</a> has a nice variety of <em>katas</em> and supports a good selection of languages. It is intended to support doing <a href="http://jonjagger.blogspot.com/2011/02/deliberate-practice.html" rel="noreferrer">deliberate practice</a> of <a href="http://en.wikipedia.org/wiki/Test-driven_development" rel="noreferrer">TDD</a>, but could be used for personal development too.</li>
<li><a href="http://www.leetcode.com/onlinejudge" rel="noreferrer">LeetCode</a></li>
<li><a href="http://poj.org/" rel="noreferrer">Peking University JudgeOnline for ACIP/ICPC</a></li>
<li><a href="http://www.spoj.pl/problems/classical/" rel="noreferrer">Sphere Online Judge</a></li>
<li><a href="http://uva.onlinejudge.org/" rel="noreferrer">University of Valladolid Online Judge</a></li>
<li><a href="https://www.codewars.com/" rel="noreferrer">Codewars</a> — Training with code challenges.</li>
<li><a href="http://rosalind.info/" rel="noreferrer">Rosalind</a> algorithms and bioinformatics</li>
<li><a href="http://quizful.com" rel="noreferrer">Quizful</a> - interactive programming quizzes in "Duolingo style".
This site looks fun and has a good set of questions, at least in Java. Plus, as they say, it has adaptive learning algorithm, that makes learning more effective.</li>
<li><a href="http://exercism.io/" rel="noreferrer">exercism</a> - Challenges in more than 30 languages that will be evaluated automatically.</li>
</ul>

<h5>Problem lists and contest archives</h3>

<ul>
<li><a href="http://acm.hit.edu.cn/judge/ProblemIndex.php" rel="noreferrer">ACM/ICPC Problem Index @ HIT</a> — List of problems from the <a href="http://en.wikipedia.org/wiki/ACM_International_Collegiate_Programming_Contest" rel="noreferrer">ACM International Collegiate Programming Contest</a></li>
<li><a href="http://www.algorithmist.com/index.php/Main_Page" rel="noreferrer">Algorithmist</a> — Includes lists of algorithms and other puzzle sites</li>
<li><a href="http://www.careercup.com/" rel="noreferrer">Career Cup</a> — Collects community-subumitted interview questions from various tech companies</li>
<li><a href="http://www.ecoo.org/index.php?option=com_content&amp;task=view&amp;id=31&amp;Itemid=61" rel="noreferrer">Educational Computing Organization of Ontairo's past computer programming puzzles</a></li>
<li><a href="http://www.facebook.com/careers/puzzles.php" rel="noreferrer">Engineering Puzzles at Facebook</a> — Puzzles provided for the purposes of evaluating potential hires</li>
<li><a href="http://code.google.com/codejam/contests.html" rel="noreferrer">Google Code Jam contest archives</a></li>
<li><a href="http://www.boundvariable.org/task.shtml" rel="noreferrer">Ninth Annual ICFP Programming Contest Task archive</a></li>
<li><a href="http://domino.research.ibm.com/comm/wwwr_ponder.nsf/pages/index.html" rel="noreferrer">Ponder this at IBM Research</a> — Puzzles provided for the purposes of evaluating potential hires</li>
<li><a href="http://programmingpraxis.com/" rel="noreferrer">Programming Praxis</a></li>
<li><a href="http://projecteuler.net/index.php" rel="noreferrer">Project Euler</a></li>
<li><a href="http://rosettacode.org/wiki/Main_Page" rel="noreferrer">Rosetta Code</a></li>
<li><a href="http://community.topcoder.com/tc?module=MatchList" rel="noreferrer">TopCoder Match List</a></li>
<li><a href="http://www.ioinformatics.org/index.shtml" rel="noreferrer">International Olympiad in Informatics</a> - yearly contents for teams of students. (<a href="http://www.ioinformatics.org/contest/prev.shtml" rel="noreferrer">previous year's problem sets</a>)</li>
</ul>

<h5>Security oriented</h3>

<ul>
<li><a href="http://smashthestack.org/" rel="noreferrer">Smashthestack</a></li>
<li><a href="http://community.corest.com/~gera/InsecureProgramming/" rel="noreferrer">gera's insecure programming challenges</a></li>
<li><a href="http://bright-shadows.net/" rel="noreferrer">TheBlacksheep</a> various challenges, security and programming themed.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: What does the Spring framework do? Should I use it?  Why or why not? (score [279134](https://stackoverflow.com/q/92393) in 2012)

#### Question
So, I'm starting a brand-new project in Java, and am considering using Spring.  Why am I considering Spring?  Because lots of people tell me I should use Spring!  Seriously, any time I've tried to get people to explain what exactly Spring is or what it does, they can never give me a straight answer.  I've checked the intros on the SpringSource site, and they're either really complicated or really tutorial-focused, and none of them give me a good idea of why I should be using it, or how it will make my life easier.  Sometimes people throw around the term "dependency injection", which just confuses me even more, because I think I have a different understanding of what that term means.  

Anyway, here's a little about my background and my app :  

Been developing in Java for a while, doing back-end web development.  Yes, I do a ton of unit testing.  To facilitate this, I typically make (at least) two versions of a method : one that uses instance variables, and one that only uses variables that are passed in to the method.  The one that uses instance variables calls the other one, supplying the instance variables.  When it comes time to unit test, I use Mockito to mock up the objects and then make calls to the method that doesn't use instance variables.  This is what I've always understood "dependency injection" to be.  

My app is pretty simple, from a CS perspective.  Small project, 1-2 developers to start with.  Mostly CRUD-type operations with a a bunch of search thrown in.  Basically a bunch of RESTful web services, plus a web front-end and then eventually some mobile clients.  I'm thinking of doing the front-end in straight HTML/CSS/JS/JQuery, so no real plans to use JSP.  Using Hibernate as an ORM, and Jersey to implement the webservices.  

I've already started coding, and am really eager to get a demo out there that I can shop around and see if anyone wants to invest.  So obviously time is of the essence.  I understand Spring has quite the learning curve, plus it looks like it necessitates a whole bunch of XML configuration, which I typically try to avoid like the plague.  But if it can make my life easier and (especially) if make it can make development and testing faster, I'm willing to bite the bullet and learn Spring.  

So please.  Educate me.  Should I use Spring?  Why or why not?  

#### Answer accepted (score 108)
<blockquote>
  What does the Spring framework do? Should I use it? Why or why not?  
</blockquote>

Spring is a framework that helps you to "wire" different components together. It is most useful in cases where you have a lot of components and you might decide to combine them in different ways, or wish to make it easy to swap out one component for another depending on different settings or environments.  

<blockquote>
  This is what I've always understood "dependency injection" to be.  
</blockquote>

I would suggest a different definition:   

"Design your objects so that they rely on an outside force to supply them with what they need, with the expectation that these <em>dependencies</em> are always <em>injected</em> before anybody asks them to start doing their usual jobs."  

Compare that against: "Each object is responsible for going out and finding everything and everybody it needs as it starts up."  

<blockquote>
  it looks like it necessitates a whole bunch of XML configuration  
</blockquote>

Well, most of the XML (or annotation-based) stuff is telling Spring stuff like:  

<ul>
<li>When someone asks for "HammerStore", I want you to create an instance of `example.HammerStore` and return it. Cache the instance for next time, since there only needs to be one store.</li>
<li>When someone asks for "SomeHammer", I want you to ask yourself for a "HammerStore", and return the result of the store's `makeHammer()` method. Do <em>not</em> cache this result.</li>
<li>When someone asks for "SomeWrench", I want you to create an instance of `example.WrenchImpl`, Use the configuration setting `gaugeAmount` and put it into the instance's `setWrenchSize()` property. Do not cache the result.</li>
<li>When someone asks for "LocalPlumber", I want to you create an instance of `example.PlumberImpl`. Put the string "Pedro" into its `setName()` method, put a "SomeHammer" into its `setHammer()` method, and put a "SomeWrench" into its `setWrench()` method. Return the result, and cache the result for later since we only need one plumber.</li>
</ul>

In this way, Spring lets your connect components, label them, control their  lifecycles/caching, and alter behavior based on configuration.  

<blockquote>
  To facilitate [testing] I typically make (at least) two versions of a method : one that uses instance variables, and one that only uses variables that are passed in to the method.   
</blockquote>

That sounds like a lot of overhead for not a lot of benefit for me. Instead, make your instance variables have <a href="http://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html" rel="noreferrer">`protected` or package visibility</a>,  and locate the unit tests inside the same `com.mycompany.whatever` package. That way you can inspect and change the instance variables whenever you want during testing.  

#### Answer 2 (score 65)
<strong>First, what is dependency injection?</strong>  

Simple. You have a class, it has a private field (set to null) and you declare a public setter that provides the value for that field. In other words, the dependency of the class (the field) is being injected by an external class (via the setter). That's it. Nothing magical.  

<strong>Second, Spring can be used without XML (or very little)</strong>  

<p>If you dive in with Spring 3.0.5.GA or higher then you can use the dependency injection support from JDK6+. This means that you can wire up dependencies using
the `@Component` and `@Resource` annotations.</p>

<strong>Why use Spring at all?</strong>  

Obviously, dependency injection promotes very easy unit testing since all your classes have setters for the important dependencies and these can be easily mocked using your favourite mocking framework to provide the required behaviour.   

That aside, Spring also provides a lot of templates which act as base classes to make using the JEE standard technologies a breeze to work with. For example, the JdbcTemplate works well with JDBC, the JpaTemplate does good things with JPA, JmsTemplate makes JMS pretty straightforward. The RestTemplate is simply awesome in it's simplicity. For example:  

```
RestTemplate restTemplate = new RestTemplate();
MyJaxbObject o = restTemplate.getForObject("https://secure.example.org/results/{param1}?param2={param2}",MyJaxbObject.class,"1","2");
```

and you're done. The parameters are injected and you just need to provide JAXB annotations for MyJaxbObject. That should take no time at all if you've auto-generated them from an XSD using the Maven JAXB plugin. Note that there was no casting going on there, nor was there a need to declare a marshaller. It's all done for you.   

I could burble on forever about the wonders of Spring, but maybe the best thing to do is try out a simple code spike where you attempt to wire up a RESTful web service to pump out data from an injected DAO that supports transactions.   

#### Answer 3 (score 28)
First of all, your understanding of dependency injection is not fundamentally wrong, but quite different from what most people mean when they use the term. What you describe is a rather strange and unconventional way to achieve testability. I'd advise you to move away from it, as other developers will be rather puzzled by that kind of code.  

Dependency injection as it's generally understood (and implemented by Spring) means that the dependencies a class has (e.g. a JDBC Datasource) are not fetched by the class itself, but "injected" by a container when the instance is created. So you don't have have two versions of every method that uses the Datasource; instead, you have one dependency injection configuration where the "real" Datasource is injected and one where a mock is injected. Or, if the injection happens via the constructor or a getter, test code can do the injection explicitly.  

Second, Spring is not just dependency injection, though that's its core functionality. It also provides declarative transactions, job scheduling, authentication, and a bunch of other functionality (including a fully-fledged MVC web framework) that you may need. There are other frameworks that provide the same functionality, but other than Spring, only Java EE has them all integrated.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Is it OK to have multiple asserts in a single unit test? (score [272914](https://stackoverflow.com/q/7823) in 2019)

#### Question
In the comment to <a href="http://www.owenpellegrin.com/blog/testing/how-do-you-solve-multiple-asserts/" rel="noreferrer">this great post</a>, Roy Osherove mentioned the <a href="http://rauchy.net/oapt/" rel="noreferrer">OAPT</a> project that is designed to run each assert in a single test.   

The following is written on the project's home page:  

<blockquote>
  <p><strong>Proper unit tests should fail for
  exactly one reason,</strong> that’s why you
  should be using one assert per unit
  test.</p>
</blockquote>

And, also, Roy wrote in comments:  

<blockquote>
  <p>My guideline is usually that you test
  one logical CONCEPT per test. you can
  have multiple asserts on the same
  <em>object</em>. they will usually be the same concept being tested.</p>
</blockquote>

I think that, there are some cases where multiple assertions are needed (e.g. <a href="http://xunitpatterns.com/Guard%20Assertion.html" rel="noreferrer">Guard Assertion</a>), but in general I try to avoid this. What is your opinion? Please provide a real world example where multiple asserts are really <em>needed</em>.  

#### Answer accepted (score 237)
I don't think it's necessarily a <strong>bad thing</strong>, but I do think we should <strong>strive towards only having single asserts</strong> in our tests.  This means you write a lot more tests and our tests would end up testing only one thing at a time.  

Having said that, I would say maybe half of my tests actually only have one assert.  I think it only becomes a <strong>code (test?) smell</strong> when you have about five or more asserts in your test.  

<a href="http://www.owenpellegrin.com/blog/testing/how-do-you-solve-multiple-asserts/">How do you solve multiple asserts?</a>  

#### Answer 2 (score 297)
Tests should fail for one reason only, but that doesn't always mean that there should be only one `Assert` statement. IMHO it is more important to hold to the "<a href="http://c2.com/cgi/wiki?ArrangeActAssert">Arrange, Act, Assert</a>" pattern.   

The key is that you have only one action, and then you inspect the results of that action using asserts. But it is "Arrange, Act, Assert, <em>End of test</em>". If you are tempted to continue testing by performing another action and more asserts afterwards, make that a separate test instead.  

I am happy to see multiple assert statements that form parts of testing the same action. e.g.  

```
[Test]
public void ValueIsInRange()
{
  int value = GetValueToTest();

  Assert.That(value, Is.GreaterThan(10), "value is too small");
  Assert.That(value, Is.LessThan(100), "value is too large");
} 
```

or  

```
[Test]
public void ListContainsOneValue()
{
  var list = GetListOf(1);

  Assert.That(list, Is.Not.Null, "List is null");
  Assert.That(list.Count, Is.EqualTo(1), "Should have one item in list");
  Assert.That(list[0], Is.Not.Null, "Item is null");
} 
```

You <em>could</em> combine these into one assert, but that's a different thing from insisting that you <em>should</em> or <em>must</em>. There is no improvement from combining them.  

e.g. The first one <em>could</em> be   

```
Assert.IsTrue((10 < value) && (value < 100), "Value out of range"); 
```

But this is not better - the error message out of it is less specific, and it has no other advantages. I'm sure you can think of other examples where combining two or three (or more) asserts into one big boolean condition makes it harder to read, harder to alter and harder to work out why it failed. Why do this just for the sake of a rule?  

<strong>NB</strong>: The code that I am writing here is C# with NUnit, but the principles will hold with other languages and frameworks. The syntax may be very similar too.  

#### Answer 3 (score 85)
I have never thought that more than one assert was a bad thing.  

I do it all the time:  

```
public void ToPredicateTest()
{
    ResultField rf = new ResultField(ResultFieldType.Measurement, "name", 100);
    Predicate<ResultField> p = (new ConditionBuilder()).LessThanConst(400)
                                                       .Or()
                                                       .OpenParenthesis()
                                                       .GreaterThanConst(500)
                                                       .And()
                                                       .LessThanConst(1000)
                                                       .And().Not()
                                                       .EqualsConst(666)
                                                       .CloseParenthesis()
                                                       .ToPredicate();
    Assert.IsTrue(p(ResultField.FillResult(rf, 399)));
    Assert.IsTrue(p(ResultField.FillResult(rf, 567)));
    Assert.IsFalse(p(ResultField.FillResult(rf, 400)));
    Assert.IsFalse(p(ResultField.FillResult(rf, 666)));
    Assert.IsFalse(p(ResultField.FillResult(rf, 1001)));

    Predicate<ResultField> p2 = (new ConditionBuilder()).EqualsConst(true).ToPredicate();

    Assert.IsTrue(p2(new ResultField(ResultFieldType.Confirmation, "Is True", true)));
    Assert.IsFalse(p2(new ResultField(ResultFieldType.Confirmation, "Is False", false)));
}
```

Here I use multiple asserts to make sure complex conditions can be turned into the expected predicate.  

I am only testing one unit (the `ToPredicate` method), but I am covering everything I can think of in the test.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How to write a very basic compiler (score [271581](https://stackoverflow.com/q/165543) in 2014)

#### Question
Advanced compilers like `gcc` compile codes into machine readable files according to the language in which the code has been written (e.g. C, C++, etc). In fact, they interpret the meaning of each codes according to library and functions of the corresponding languages. Correct me if I'm wrong.  

I wish to better understand compilers by writing a very basic compiler (probably in C) to compile a static file (e.g. Hello World in a text file). I tried some tutorials and books, but all of them are for practical cases. They deal with compiling dynamic codes with meanings connected with the corresponding language.  

How can I write a basic compiler to convert a static text into a machine readable file?  

The next step will be introducing variables into the compiler; imagine that we want to write a compiler which compile only some functions of a language.  

Introducing practical tutorials and resources is highly appreciated :-)  

#### Answer accepted (score 326)
<h5>Intro</h2>

A typical compiler does the following steps:  

<ul>
<li>Parsing: the source text is converted to an abstract syntax tree (AST). </li>
<li>Resolution of references to other modules (C postpones this step till linking).</li>
<li>Semantic validation: weeding out syntactically correct statements that make no sense, e.g. unreachable code or duplicate declarations.</li>
<li>Equivalent transformations and high-level optimization: the AST is transformed to represent a more efficient computation with the same semantics. This includes e.g. early calculation of common subexpressions and constant expressions, eliminating excessive local assignments (see also <a href="https://en.wikipedia.org/wiki/Static_single_assignment_form" rel="noreferrer">SSA</a>), etc.</li>
<li>Code generation: the AST is transformed into linear low-level code, with jumps, register allocation and the like. Some function calls can be inlined at this stage, some loops unrolled, etc.</li>
<li>Peephole optimization: the low-level code is scanned for simple local inefficiencies which are eliminated.</li>
</ul>

Most modern compilers (for instance, gcc and clang) repeat the last two steps once more. They use an intermediate low-level but platform-independent language for initial code generation. Then that language is converted into platform-specific code (x86, ARM, etc) doing roughly the same thing in a platform-optimized way. This includes e.g. the use of vector instructions when possible, instruction reordering to increase branch prediction efficiency, and so on.  

After that, object code is ready for linking. Most native-code compilers know how to call a linker to produce an executable, but it's not a compilation step per se. In languages like Java and C# linking may be totally dynamic, done by the VM at load time.  

<h5>Remember the basics</h2>

<ul>
<li>Make it work</li>
<li>Make it beautiful</li>
<li>Make it efficient</li>
</ul>

This classic sequence applies to all software development, but bears repetition.  

Concentrate on the first step of the sequence. Create the simplest thing that could possibly work.   

<h5>Read the books!</h2>

Read the <a href="https://rads.stackoverflow.com/amzn/click/com/0321486811" rel="noreferrer" rel="nofollow noreferrer">Dragon Book</a> by Aho and Ullman. This is classic and is still quite applicable today.  

<a href="https://rads.stackoverflow.com/amzn/click/com/0471976970" rel="noreferrer" rel="nofollow noreferrer">Modern Compiler Design</a> is also praised.  

If this stuff is too hard for you right now, read some intros on parsing first; usually parsing libraries include intros and examples.  

Make sure you're comfortable working with graphs, especially trees. These things is the stuff programs are made of on the logical level.  

<h5>Define your language well</h2>

Use whatever notation you want, but make sure you have a complete and consistent description of your language. This includes both syntax and semantics.  

It's high time to write snippets of code in your new language as test cases for the future compiler.  

<h5>Use your favorite language</h2>

It's totally OK to write a compiler in Python or Ruby or whatever language is easy for you. Use simple algorithms you understand well. The first version does not have to be fast, or efficient, or feature-complete. It only needs to be correct enough and easy to modify.  

It's also OK to write different stages of a compiler in different languages, if needed.  

<h5>Prepare to write a lot of tests</h3>

Your entire language should be covered by test cases; effectively it will be <em>defined</em> by them. Get well-acquainted with your preferred testing framework. Write tests from day one. Concentrate on 'positive' tests that accept correct code, as opposed to detection of incorrect code.   

Run all the tests regularly. Fix broken tests before proceeding. It would be a shame to end up with an ill-defined language that cannot accept valid code.  

<h5>Create a good parser</h2>

<a href="http://en.wikipedia.org/wiki/Comparison_of_parser_generators" rel="noreferrer">Parser generators are many</a>. Pick whatever you want. You may also write your own parser from scratch, but it only worth it if syntax of your language is <em>dead</em> simple.  

The parser should detect and report syntax errors. Write a lot of test cases, both positive and negative; reuse the code you wrote while defining the language.  

Output of your parser is an abstract syntax tree.  

If your language has modules, the output of the parser may be the simplest representation of 'object code' you generate. There are plenty of simple ways to dump a tree to a file and to quickly load it back.  

<h5>Create a semantic validator</h2>

Most probably your language allows for syntactically correct constructions that may make no sense in certain contexts. An example is a duplicate declaration of the same variable or passing a parameter of a wrong type. The validator will detect such errors looking at the tree.  

The validator will also resolve references to other modules written in your language, load these other modules and use in the validation process. For instance, this step will make sure that the number of parameters passed to a function from another module is correct.  

Again, write and run a lot of test cases. Trivial cases are as indispensable at troubleshooting as smart and complex.  

<h5>Generate code</h2>

Use the simplest techniques you know. Often it's OK to directly translate a language construct (like an `if` statement) to a lightly-parametrized code template, not unlike an HTML template.  

Again, ignore efficiency and concentrate on correctness.  

<h5>Target a platform-independent low-level VM</h3>

I suppose that you ignore low-level stuff unless you're keenly interested in hardware-specific details. These details are gory and complex.  

Your options:  

<ul>
<li>LLVM: allows for efficient machine code generation, usually for x86 and ARM.</li>
<li>CLR: targets .NET, mostly x86/Windows-based; has a good JIT.</li>
<li>JVM: targets Java world, quite multiplatform, has a good JIT.</li>
</ul>

<h5>Ignore optimization</h2>

<p>Optimization is hard. Almost always optimization is premature.
Generate inefficient but correct code. Implement the whole language before you try to optimize the resulting code.</p>

Of course, trivial optimizations are OK to introduce. But avoid any cunning, hairy stuff before your compiler is stable.  

<h5>So what?</h2>

If all this stuff is not too intimidating for you, please proceed! For a simple language, each of the steps may be simpler than you might think.  

Seeing a 'Hello world' from a program that your compiler created might be worth the effort.  

#### Answer 2 (score 27)
Jack Crenshaw's <a href="http://www.compilers.iecc.com/crenshaw/">Let's Build a Compiler</a>, while unfinished, is an eminently readable introduction and tutorial.  

Nicklaus Wirth's <a href="http://rads.stackoverflow.com/amzn/click/0201403536">Compiler Construction</a> is a very good textbook on the basics of simple compiler construction.  He focuses on top-down recursive descent, which, let's face it, is a LOT easier than lex/yacc or flex/bison.  The original PASCAL compiler that his group wrote was done this way.  

Other people have mentioned the various Dragon books.  

#### Answer 3 (score 16)
I'd actually start off with writing a compiler for <a href="https://en.wikipedia.org/wiki/Brainfuck">Brainfuck</a>. It's a fairly obtuse language to program in but it only has 8 instructions to implement. It's about as simple as you can possibly get and there are equivalent C instructions out there for the commands involved if you find the syntax off-putting.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Relationship between user story, feature, and epic? (score [267356](https://stackoverflow.com/q/182158) in 2017)

#### Question
As someone who's still new to agile, I'm not sure I completely understand the relationship or difference between user story, feature, and epic.  

According to this <a href="https://stackoverflow.com/questions/1707820/what-is-the-difference-between-a-user-story-and-a-feature-in-agile-terminology">question</a>, a feature is a collection of stories.  One of the answers suggests that a feature is actually an epic. So are features and epics considered the same thing, that is basically a collection of related user stories?  

Our project manager insists that there's a hierarchical structure:  

Epic -> Features -> User stories  

And that basically all user stories must fall within this structure.  Therefore all user stories must fall under an umbrella feature and all features must fall under an epic.  

To me, that sounds awkward.  Can someone please clarify how user stories, features, and epics are related?  Or is there an article that clearly outlines the differences?  

#### Answer 2 (score 94)
They are very generic term actually. There is many way to interpret them, varying in the literature and how people see them. Take everything I say with a huge grain of salt.  

Usually, an Epic comprise a very global and not very well defined functionality in your software. It is very broad. It will usually be broken down into smaller user story or feature when you try to make sense of it and making them fit in an agile iteration. Example :  

<p><strong>Epic</strong><br>
- Allow the customer to manage its own account via the Web</p>

Feature and User Story are more specific functionality, that you can easily test with acceptance tests. It is often recommended that they be granular enough to fit in a single iteration.  

Features usually tend to describe what your software do :  

<p><strong>Feature</strong><br>
- Editing the customer information via the web portal</p>

User stories tend to express what the user want to do :  

<p><strong>User story</strong><br>
As bank clerk,<br>
I want to be able to modify the customer information<br>
so that I can keep it up to date.</p>

I don't think there is really a hierarchy between the two, but you can have one if you want or if it fit how you work. A user story can be a specific justification for a feature, or a specific way to do it. Or it can be the other way around. A feature can be a way to realize a user story. Or they can denote the same thing. You can use both : User stories to define what bring business value and feature to describe constraint of the software.  

<p><strong>User story</strong>: as a customer, I want to pay with the most popular credits cards<br>
<strong>Feature</strong> support the GOV-TAX-02 XML API of the government.</p>

There is also the question of scenario, which are usually a way a Feature/User story will be executed. They usually map cleanly to a specific acceptance test. For example  

<p><strong>Scenario</strong> : <em>Withdrawing money</em><br>
Given I have 2000$ in my bank account<br>
When I withdraw 100$<br>
Then I receive 100$ in cash<br>
And my balance is 1900$</p>

That is how we define those terms <em>where I work</em>. Those definitions are far from a mathematical definition or a standardized term. Its like the difference between a right wing politician or a left wing politician. It depend where you live. In Canada, what is considered right wing may be considered left-wing in the United State. It's very variable.  

Seriously, I wouldn't worry too much about it. The important is that everyone on the team agree on a definition so you can understand each other. Some method like scrum tend to define them more formally, but pick what work for you and leave the rest. After all, isn't agile about <strong>Individuals and interactions over processes and tools</strong> and <strong>Working software over comprehensive documentation</strong>?  

#### Answer 3 (score 36)
<strong>Epic</strong>:   A very large user story that is eventually broken down into smaller stories.  

<strong>User story:</strong> A very high-level definition of a requirement, containing just enough information so that the developers can produce a reasonable estimate of the effort to implement it.  

<a href="http://www.telerik.com/agile-project-management-tools/agile-resources/vocabulary.aspx">http://www.telerik.com/agile-project-management-tools/agile-resources/vocabulary.aspx</a>  

<strong>Feature</strong>: A distinguishing characteristic or capability of a software application or library (e.g., performance, portability, or functionality).  

<a href="http://en.wikipedia.org/wiki/Software_feature">http://en.wikipedia.org/wiki/Software_feature</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: Why aren't more desktop apps written with Qt? (score [267249](https://stackoverflow.com/q/88685) in 2011)

#### Question
As far as I know and have understood in my experience with Qt, it's a very good and easy to learn library. It has a very well designed API and is cross-platform, and these are just two of the many features that make it attractive. I'm interested to know why more programmers don't use Qt. Is there a deficiency which speaks against it? Which feature makes other libraries better than Qt? Is the issue related to licensing?  

#### Answer accepted (score 177)
I don't really intend this to be a bashing answer, but these are the reasons I do not personally use Qt. There are plenty of good things to say about it -- namely that the API works most of the time, and that it does seamlessly bridge platforms. But I do not use Qt, because:  

<ol>
<li>In some cases, it just doesn't look like native programs look. Designing a single UI for all platforms inherently is not going to look right when moved from machine to machine, for various visual styling reasons. For example, on Mac machines, split bars are usually relatively thick, and buttons are small and rounded with icons. On Windows machines, split bars are typically narrow, and buttons are more textual, with more square designs. Just because you can write one UI for every platform does not mean that you should for most applications.</li>
<li>Qt is not a C++ library. It requires a separate compilation step, which makes the build process much more complicated when compared with most other libraries.</li>
<li>As a result of (2), C++ IDEs and tools can flag Qt expressions as errors, because they do not understand Qt's specifics. This almost forces use of QtCreator or a textual only editor like `vim`.</li>
<li>Qt is a large amount of source, which must be present and preinstalled on any machine you use before compiling. This can make setting up a build environment much more tedious.</li>
<li>It's available only under LGPL, which makes it difficult to use single-binary-deployment when one needs to release under a more restrictive or less restrictive license.</li>
<li>It produces extremely large compiled binaries when compared with similarly written "plain ol' native applications" (excepting of course applications written for KDE).</li>
</ol>

#### Answer 2 (score 115)
As people say, each tool fits to each problem and situation...  

<p>But if you're C++ programmer, Qt is your framework.
No rival.  </p>

<p>We develop a complex medical imaging commercial application,
and Qt holds on.</p>

<p>I don't say that the 'cons' that people say about it are false,
but I have the feeling that they don't have tried Qt for a long time
(its continously improving on each new version...)
And,
mostly all of the issues they comment are not a problem if you take care.</p>

<p>UI platform inconsistency:
 only if you use the UI widgets 'as they are', with no customization or custom art.</p>

<p>Qt preprocessor overload:
 Only if you abuse of signal-slot mechanism, or QObject inheritance, 
when there is no really need.</p>

By the way, We still write applications in C#.NET, and been doing it for a long time. So I think I have enouch perspective.  

As I said, each tool for each situation,  

but Qt is with no doubt a consistent and useful framework.  

#### Answer 3 (score 36)
Of all the things I don't like about Qt, the fact that it doesn't play well with templates bugs me the most.  You can't do this:  

```
template < typename T >
struct templated_widget : QWidget
{
  Q_OBJECT;

public signals:
  void something_happened(T);
};
```

It also doesn't play well with the preprocessor.  You can't do this:  

```
#define CREATE_WIDGET(name,type) \
struct name ## _widget : QWidget \
{ \
  Q_OBJECT; \
\
public signals: \
  void something_happened(type); \
}
```

That, mixed with the fact that everything that responds to a signal has to be a Q_OBJECT, makes Qt hard to work in for a C++ programmer.  People used to Java or Python style programming probably fair better actually.  

I actually spent a lot of time and effort researching and devising a way to gain type safety back and connect a Qt signal to any functor object: <a href="http://crazyeddiecpp.blogspot.com/2011/01/quest-for-sane-signals-in-qt-step-1.html">http://crazyeddiecpp.blogspot.com/2011/01/quest-for-sane-signals-in-qt-step-1.html</a>  

The kind of thing I want to do there is basic, everyday C++ development made next to impossible by the Qt moc...which itself is entirely unnecessary now days, if it ever actually was.  

Frankly though, I'm stuck with it because if you want to do automated UI testing, Qt is pretty much the only game in town short of MFC...which is so 1980 (it sucks working in that shit really hard).  Some might say WX but it's got even more serious problems.  GTKmm would have been my first choice but since it's all owner drawn and doesn't do accessibility...can't be driven by industry standard testing software.  Qt is hard enough in that regard (<em>barely</em> works when you modify the accessibility plugin).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: What's the difference between Entry Level/Jr/Sr developers? (score [265689](https://stackoverflow.com/q/14914) in 2017)

#### Question
Other than title and pay, what is the difference?   

<ul>
<li><p>What different responsibilities do they have. </p></li>
<li><p>How knowledgeable/experienced are they?</p></li>
<li><p>What is the basic measure to determine where a developer fits into this basic structure?</p></li>
</ul>

#### Answer accepted (score 341)
This will vary but this is how I see it at a place large enough to have distinctions between types of programmers.  

I would say entry level and Junior are the same thing. They are just out of school and have less than two years of work experience. They are assigned the least complex tasks and should be supervised fairly closely. Generally they know about 10% of what they think they know. Usually they have not been through the whole development cycle and so often make some very naive choices if given the opportunity to choose. Sadly many of them don't actually care what the requirement is, they want to build things their way. They often have poor debugging skills.  

Intermediate level is where many programmers fall. They have more than two years experience and generally less than ten, although some can stay at this level their whole careers. They can produce working code with less supervision as long as they are assigned to relatively routine tasks. They are not generally tasked with high level design or highly complicated tasks that require an in-depth level of knowledge. They may be tasked with the design of a piece of the application though, especially as they are in the zone to become a senior developer.  They are good at maintenance tasks or tasks where they can focus on just their piece of the puzzle, but are not usually expected to consider the application as a whole unless working with senior developers or being prepped for promotion to senior. They can usually do a decent job of troubleshooting and debugging, but they have to really slog through to get the hard ones. They do not yet have enough experience to see the patterns in the problems that point them to the probable place they are occurring. But they are gaining those skills and rarely need to ask for debugging help. They have probably been through the whole development cycle at least once and seen the results of design problems and are learning how to avoid them in the future. Usually they tend to be more likely to take a requirement at face value and not push it back when it has obvious problems or gaps.  They have learned enough to know what they don't know and are starting to gain that knowledge. They are the workhorses of the programming world, they deliver probably 80-90% of the routine code and maybe 10% of the very difficult stuff.   

No one who is senior level even needs to ask this question. They are experts in their chosen technology stacks. They are given the hard tasks (the ones nobody knows how to solve) and often get design responsibilties. They often work independently because they have a proven track record of delivering the goods. They are expected to mentor Junior and intermediate developers. Often they are amazing troubleshooters. They have run into those same problems before and have a very good idea of where to look first. Seniors often mentor outside the workplace as well. They generally have at least ten years of experience and have almost always been on at least one death march and know exactly why some things are to be avoided. They know how to deliver a working product and meet a deadline. They know what corners can be cut and what corners should never be cut. They know at least one and often several languages at the expert level. They have seen a lot of "hot new technologies" hit the workplace and disappear, so they tend to be a bit more conservative about jumping on the bandwagon for the next exciting new development tool (but not completely resistant to change - those would be the older Intermediate developers who never make the leap to Senior). They understand their job is to deliver working software that does what the users want, not to play with fun tools. They are often pickier about where they will work because they can be and because they have seen first hand how bad some places can be. They seek out the places that have the most interesting tasks to do. Often they know more about their company's products than anyone else even if they have been there only a few months. They know they need more than programming knowledge and are good at getting knowledge about the business domain they support as well. They are often aware of issues that juniors never consider and intermediates often don't think about such as regulatory and legal issues in the business domain they support. They can and will push back a requirement because they know what the problems with it will be and can explain the same to the laymen.   

#### Answer 2 (score 43)
Entry Level - must give them explicit instructions, check everything they do, little or no design responsibility, no analysis responsibility  

Junior - less explicit instructions, less checking, some minor design and analysis responsibility; helps the entry-level people find the compiler and use the repository  

Senior - major design and analysis responsibility, is expected to correct oversights on his/her own, little/no checking, little/no instructions; helps the junior-level people learn/improve analysis and design skills  

#### Answer 3 (score 16)
Really, I think it just comes down to how long you have been on the job. If you have 10 years experience you are a senior dev, if you are a graduate then you are probably entry level. I have seen many 'senior' dev's who could hardly code and didn't really know what they were doing and many junior dev's who were fantastic.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: Is learning C# as a first language a mistake? (score [260003](https://stackoverflow.com/q/100488) in 2017)

#### Question
I know there are similar questions on here, which I've read, but I recently read this post by Joel Spolsky:   

<a href="https://softwareengineering.stackexchange.com/questions/96504/how-can-i-teach-a-bright-person-with-no-programming-experience-how-to-program/96506#96506">How can I teach a bright person, with no programming experience, how to program?</a>  

And it got me thinking about my way of learning and whether it might actually be harmful in the long run.  

I've dabbled with various languages but C# is my first serious one, I've read "Head First C#" and created a few projects. But after reading the post above I've found it a bit disheartening that I may be going about it all wrong, obviously I respect Joel's opinion which is what has thrown me a bit.  

I've started reading "Code" as recommended in the reading list and I'm finding it pretty hard going, although enjoyable. I feel like it's taken the shine off of my "noobish hacking about" in Visual Studio.   

So now I'm unsure as to what path I should take? Should I take a step back and follow Joel's advice and start reading?   

I guess my main aim is just to become a good programmer, like everyone else, but I don't want to be going into bad practice by learning a .NET language when someone who's opinion I respect thinks that it is harmful.   

Thoughts?  

#### Answer accepted (score 80)
<blockquote>
  <p>I've dabbed with various languages but C# is my first serious one,
  I've read "Head First C#" and created a few projects. But after
  reading the post above I've found it a bit disheartening that I may be
  going about it all wrong, obviously I respect Joel's opinion which is
  what has thrown me a bit.</p>
</blockquote>

I respect Joel's opinions too, but they are just that: <strong>opinions</strong>. There's absolutely nothing wrong with using C# as a starting language.  

The biggest advice I can give you, or anyone doing <strong>any</strong> programming (even if they're starting in vanilla C!) is to <strong>not be stagnant, and don't be religious</strong>. I don't care <strong>what</strong> programming language you're starting with, or how pure or righteous that language is - in this day and age you cannot afford to sit in only world of programming.  

For example, I started programming with PHP3 back when I was a teenager. I built some small web apps and a few web sites with it; I thought that I was a genius programmer and that I could do <em>anything</em> with PHP3, and frowned on people who were all about ASP or BASIC. Boy, was I wrong.  

I didn't start to truly blossom as a developer until I began expanding my horizons and studying other programming languages and concepts. During high school I learned some RealBASIC, and then later Visual Basic. After business school, when I became a professional developer, I started learning C# and Javascript in earnest.  

Now, don't misunderstand me here - I'm <strong>not</strong> advocating that you try to be a Jack of All Trades. At heart, and in trade, I'm still a PHP programmer. PHP is my bread and butter, and I know it inside and out. However, my PHP skills didn't become what they were just doing PHP. Here are some highly important concepts that I didn't grasp from PHP, despite working in it professionaly.  

<ul>
<li>Javascript: Closures</li>
<li>jQuery (yes, separate): the DOM and Ajax</li>
<li>Visual Basic: Objected-oriented programming</li>
<li>C#: Generics and closures</li>
<li>Ruby (on Rails): The power of MVC design</li>
</ul>

I could go on, and so could many others on this site as well, for days. Even though I'm a PHP programmer I was able to bring all of these other wonderful concepts back with me into the work I do every day.  

What's my point? Learn C#. Become a <strong>master</strong> of C# - you'll have a long, successful career and you'll probably accomplish some amazing things. But <strong>don't</strong> pigeon-hole yourself. Journey, and taste other languages and environments and concepts.  

#### Answer 2 (score 21)
<blockquote>
  when someone who's opinion I respect thinks that it is harmful.  
</blockquote>

This reminds me of a story involving Richard Feynman. A student at Caltech asked the eminent cosmologist Michael Turner what his "bias" was in favoring a type of particle as a candidate to comprise the dark matter, and Feynman snapped and said "Why do you want to know <em>his</em> bias? Form your own!...Don't pay attention to authorities, think for yourself."  

Programmers come from all walks of life. Java is taught in many high schools and colleges today, yet it hadn't even been <em>invented</em> when Joel Spolsky was in school. There is no "one true path" when it comes to becoming a good programmer. There are certainly some classics like SICP that most programmers stumble across at some point, but there's no hard and fast standard. The main thing is to start somewhere, and focus on building concepts. A great programmer once said something like:  

<blockquote>
  Bad programmers focus on code, good programmers focus on algorithms.  
</blockquote>

I think C# is a fine language to start with, but I warn you to be wary of Visual Studio. It is a tremendous IDE, but if you drag a `DropDownList` and bind a `GridView` to a `ObjectDataSource` and use a `Button` control to make a `DropDownList` based search, then most of the work is done by the IDE and you're not really programming. Take advantage of the IDEs tools, but always try to build concepts and develop knowledge.   

#### Answer 3 (score 7)
I'm just a junior, but with all humility and respect for those infinitely more experienced, I have to confess that I don't get this attitude either.  

One programmer commented below Joel's answer: "<em>as someone who has had to bang his head on the desk over "programmers" who came highly recommended for their C# abilities, but <strong>couldn't do simple things like</strong> implement a very well documented base class, <strong>find memory leaks in c and c++ programs</strong>"</em>...  

But why must finding memory leaks in C++ apps be simple for someone who <strong>never claimed</strong> to know C++? :) I don't understand. It's like criticizing a psychologist for lack of dentist skills. I'm surely not a good programmer, but I feel this is not because I don't know C++ - it's because I don't know well enough the framework and languages which I <strong>am</strong> using.  

<em>"couldn't do simple things like implement a very well documented base class (...) or simply figure out a problem on their own or learn a new idea at even a moderate pace"</em>   

OK, but - correlation doesn't mean causation, and what makes us assume that their lack of general programming skills - which I don't doubt - is a <strong>result</strong> of their language choice?  

Or an effect of C# being their <strong>first</strong> language of choice, for that matter?   

I can see other plausible explanations (perhaps C# is just trendy, and hence it attracts a lot of novices... most people for whom C# is the first language have not been programming very long <strong>at all</strong>, and that is more of a handicap in its own right than never programming in some other language... etc., etc.).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: Is initializing a char[] with a string literal bad practice? (score [255356](https://stackoverflow.com/q/183842) in 2015)

#### Question
I was reading a thread titled <a href="http://forums.codeguru.com/showthread.php?438515-strlen-vs-sizeof">"strlen vs sizeof" on CodeGuru</a>, and <a href="http://forums.codeguru.com/showthread.php?438515-strlen-vs-sizeof#post1648276">one of the replies</a> states that  "it's anyways [sic] bad practice to initialie [sic] a `char` array with a string literal."  

Is this true, or is that just his (albeit an "elite member") opinion?  

<hr>

Here is the original question:  

```
#include <stdio.h>
#include<string.h>
main()
{
    char string[] = "october";
    strcpy(string, "september");

    printf("the size of %s is %d and the length is %d\n\n", string, sizeof(string), strlen(string));
    return 0;
}
```

<blockquote>
  right. the size should be the length plus 1 yes?  
  
  this is the output  
  
  `the size of september is 8 and the length is 9`  
  
  size should be 10 surely. its like its calculating the sizeof string before it is changed by strcpy but the length after.  
  
  Is there something wrong with my syntax or what?  
</blockquote>

<hr>

Here is <a href="http://forums.codeguru.com/showthread.php?438515-strlen-vs-sizeof#post1648276">the reply</a>:  

<blockquote>
  It's anyways bad practice to initialie a char array with a string literal. So always do one of the following:  
</blockquote>

```
const char string1[] = "october";
char string2[20]; strcpy(string2, "september");
```

#### Answer accepted (score 59)
<blockquote>
  It's anyways bad practice to initialie a char array with a string literal.  
</blockquote>

The author of that comment never really justifies it, and I find the statement puzzling.    

In C (and you've tagged this as C), that's pretty much the only way to <em>initialize</em> an array of `char` with a string value (initialization is different from assignment).  You can write either  

```
char string[] = "october";
```

or  

```
char string[8] = "october";
```

or  

```
char string[MAX_MONTH_LENGTH] = "october";
```

In the first case, the size of the array is taken from the size of the initializer.  String literals are stored as arrays of `char` with a terminating 0 byte, so the size of the array is 8 ('o', 'c', 't', 'o', 'b', 'e', 'r', 0).  In the second two cases, the size of the array is specified as part of the declaration (8 and `MAX_MONTH_LENGTH`, whatever that happens to be).    

What you <em>cannot</em> do is write something like  

```
char string[];
string = "october";
```

or  

```
char string[8];
string = "october";
```

etc.  In the first case, the declaration of `string` is <em>incomplete</em> because no array size has been specified and there's no initializer to take the size from.  In both cases, the `=` won't work because a) an array expression such as `string` may not be the target of an assignment and b) the `=` operator isn't defined to copy the contents of one array to another anyway.    

By that same token, you can't write  

```
char string[] = foo;
```

where `foo` is another array of `char`.  This form of initialization will only work with string literals.    

<strong>EDIT</strong>  

I should amend this to say that you can also initialize arrays to hold a string with an array-style initializer, like  

```
char string[] = {'o', 'c', 't', 'o', 'b', 'e', 'r', 0};
```

or   

```
char string[] = {111, 99, 116, 111, 98, 101, 114, 0}; // assumes ASCII
```

but it's easier on the eyes to use string literals.    

<strong>EDIT<sup>2</sup></strong>  

In order to assign the <em>contents</em> of an array outside of a declaration, you would need to use either `strcpy/strncpy` (for 0-terminated strings) or `memcpy` (for any other type of array):  

```
if (sizeof string > strlen("october"))
  strcpy(string, "october");
```

or  

```
strncpy(string, "october", sizeof string); // only copies as many characters as will
                                           // fit in the target buffer; 0 terminator
                                           // may not be copied, but the buffer is
                                           // uselessly completely zeroed if the
                                           // string is shorter!
```

#### Answer 2 (score 10)
The only problem I recall is assigning string literal to `char *`:  

```
char var1[] = "september";
var1[0] = 'S'; // Ok - 10 element char array allocated on stack
char const *var2 = "september";
var2[0] = 'S'; // Compile time error - pointer to constant string
char *var3 = "september";
var3[0] = 'S'; // Modifying some memory - which may result in modifying... something or crash
```

For example take this program:  

```
#include <stdio.h>

int main() {
  char *var1 = "september";
  char *var2 = "september";
  var1[0] = 'S';
  printf("%s\n", var2);
}
```

This on my platform (Linux) crashes as it tries to write to page marked as read-only. On other platforms it might print 'September' etc.  

That said - initialization by literal makes the specific amount of reservation so this won't work:  

```
char buf[] = "May";
strncpy(buf, "September", sizeof(buf)); // Result "Sep"
```

But this will  

```
char buf[32] = "May";
strncpy(buf, "September", sizeof(buf));
```

<hr>

As last remark - I wouldn't use `strcpy` at all:  

```
char buf[8];
strcpy(buf, "very long string very long string"); // Oops. We overwrite some random memory
```

While some compilers can change it into safe call `strncpy` is much safer:  

```
char buf[1024];
strncpy(buf, something_else, sizeof(buf)); // Copies at most sizeof(buf) chars so there is no possibility of buffer overrun. Please note that sizeof(buf) works for arrays but NOT pointers.
buf[sizeof(buf) - 1] = '\0';
```

#### Answer 3 (score 6)
One thing that neither thread brings up is this:  

```
char whopping_great[8192] = "foo";
```

vs.  

```
char whopping_great[8192];
memcpy(whopping_great, "foo", sizeof("foo"));
```

The former will do something like:  

```
memcpy(whopping_great, "foo", sizeof("foo"));
memset(&whopping_great[sizeof("foo")], 0, sizeof(whopping_great)-sizeof("foo"));
```

The latter only does the memcpy.  The C standard insists that if any part of an array is initialized, it all is.  So in this case, it's better to do it yourself.  I think that may have been what treuss was getting at.  

For sure  

```
char whopping_big[8192];
whopping_big[0] = 0;
```

is better than either:  

```
char whopping_big[8192] = {0};
```

or   

```
char whopping_big[8192] = "";
```

p.s. For bonus points, you can do:  

```
memcpy(whopping_great, "foo", (1/(sizeof("foo") <= sizeof(whopping_great)))*sizeof("foo"));
```

to throw a compile time divide by zero error if you're about to overflow the array.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Should curly braces appear on their own line? (score [255317](https://stackoverflow.com/q/2715) in 2011)

#### Question
Should curly braces be on their own line or not? What do you think about it?  

```
if (you.hasAnswer()) {
    you.postAnswer();
} else {
    you.doSomething();
}
```

or should it be  

```
if (you.hasAnswer())
{
    you.postAnswer();
}
else
{
    you.doSomething();
}
```

or even  

```
if (you.hasAnswer())
    you.postAnswer();
else
    you.doSomething();
```

Please be constructive! Explain why, share experiences, back it up with facts and references.  

#### Answer accepted (score 88)
When I was a student I used to put curly braces on the same line, so that there are fewer lines, and the code gets printed on fewer pages. Looking at a single bracket character printed as the only thing in a line is annoying. (environment,paper wastage)  

But when coding large applications, allowing some lines with only braces in them are affordable, considering the 'grouping' feeling it gives.  

Whichever style you choose, be <strong>consistent</strong> so that it does not become an overhead for your own brain to process multiple styles in <strong>related pieces of code</strong>. In different scenarios (like above) i would say it is okay to use different styles, it's easier to 'switch context' at a high level.  

#### Answer 2 (score 247)
<strong>You should never do the 3rd method.</strong>   

Skimping on braces might save you a few keystrokes the first time, but the next coder who comes along, adds something to your else clause without noticing the block is missing braces is going to be in for a lot of pain.   

Write your code for other people.   

#### Answer 3 (score 203)
For a long time I argued that they were of equal worth, or so <strong>very close to equal</strong> that the possible gain by making the right choice was far, far, below the <strong>cost of arguing</strong> about it.   

Being <strong>consistent is important</strong>, though. So I said let's flip a coin and get on to writing code.  

I've seen programmers resist change like this before. Get over it! I've switched many times in my career. I even use different styles in my C# than in my PowerShell.   

A few years ago I was working on a team (~20 developers) that decided to ask for input, and then make a decision, and then enforce that across all the code base. We'd have 1 week to decide.  

Lots of groans &amp; eye-rolling. Lots of "I like my way, because it's better" but no substance.   

As we were studying the finer points of the question, someone asked how to deal with this issue in brace-on-the-same-line style:  

```
void MyFunction(
    int parameterOne,
    int parameterTwo) {
    int localOne,
    int localTwo
}
```

Note that it's not immediately obvious where the parameter list ends, and the body begins. Compare to:  

```
void MyFunction(
    int parameterOne,
    int parameterTwo) 
{
    int localOne,
    int localTwo
}
```

We did some reading on how folks around the world had dealt with this problem, and found the pattern of adding a blank line after the open brace:  

```
void MyFunction(
    int parameterOne,
    int parameterTwo) {

    int localOne,
    int localTwo
}
```

If you're going to make a visual break, you may as well do it with a brace. Then your visual breaks become consistent, too.  

<strong>Edit</strong>: Two alternatives to the 'extra blank line' solution when using K&amp;R:  

1/ Indent the function arguments differently from the function body  

2/ Put the first argument on the same line as the function name and align further arguments on new lines to that first argument  

Examples:  

1/  

```
void MyFunction(
        int parameterOne,
        int parameterTwo) {
    int localOne,
    int localTwo
}
```

2/  

```
void MyFunction(int parameterOne,
                int parameterTwo) {
    int localOne,
    int localTwo
}
```

<strong>/Edit</strong>  

I still argue that consistency is more important than other considerations, but if we don't have an <strong>established precedent</strong>, then brace-on-next-line is the way to go.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: When do you use float and when do you use double (score [254887](https://stackoverflow.com/q/188721) in 2016)

#### Question
Frequently in my programming experience I need to make a decision whether I should use float or double for my real numbers. Sometimes I go for float, sometimes I go for double, but really this feels more subjective. If I would be confronted to defend my decision, I would probably not give sound reasons.  

When do you use float and when do you use double? Do you always use double, only when memory constraints are present you go for float? Or you use always float unless the precision requirement requires you to use double? Are there some substantial differences regarding computational complexity of basic arithemtics between float and double? What are the pros and cons of using float or double? And have you even used long double?  

#### Answer accepted (score 187)
The default choice for a floating-point type should be `double`. This is also the type that you get with floating-point literals without a suffix or (in C) standard functions that operate on floating point numbers (e.g. `exp`, `sin`, etc.).  

`float` should only be used if you need to operate on a lot of floating-point numbers (think in the order of thousands or more) and analysis of the algorithm has shown that the reduced range and accuracy don't pose a problem.  

`long double` can be used if you need more range or accuracy than `double`, and if it provides this on your target platform.  

In summary, `float` and `long double` should be reserved for use by the specialists, with `double` for "every-day" use.  

#### Answer 2 (score 42)
There is rarely cause to use float instead of double in code targeting modern computers.  The extra precision reduces (but does not eliminate) the chance of rounding errors or other imprecision causing problems.  

The main reasons I can think of to use float are:  

<ol>
<li>You are storing large arrays of numbers and need to reduce your
program's memory consumption. </li>
<li>You are targeting a system that doesn't natively support double-precision floating point.  Until    recently, many graphics cards only supported single precision
floating points.  I'm sure there are plenty of low-power and
embedded processors that have limited floating point support too. </li>
<li>You are targeting hardware where single-precision is faster
than double-precision, and your application makes heavy use of
floating point arithmetic.  On modern Intel CPUs I believe all
floating point calculations are done in double precision, so you
don't gain anything here. </li>
<li>You are doing low-level optimization,
for example using special CPU instructions that operate on multiple
numbers at a time.</li>
</ol>

So, basically, double is the way to go unless you have hardware limitations or unless analysis has shown that storing double precision numbers is contributing significantly to memory usage.  

#### Answer 3 (score 10)
Use `double` for all your calculations and temp variables.  Use `float` when you need to maintain an array of numbers - `float[]` (if precision is sufficient), and you are dealing with over tens of thousands of `float` numbers.  

Many/most math functions or operators convert/return `double`, and you don't want to cast the numbers back to `float` for any intermediate steps.  

<p>E.g.
If you have an input of 100,000 numbers from a file or a stream and need to sort them, put the numbers in a `float[]`.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: What's the difference between an API and an SDK? (score [247977](https://stackoverflow.com/q/101873) in 2014)

#### Question
I was looking through various APIs and SDKs, when I realized that I couldn't really tell the difference between something called an <a href="http://en.wikipedia.org/wiki/API">API</a> and something called an <a href="http://en.wikipedia.org/wiki/Software_development_kit">SDK</a>.  

Both of them are, conceptually, a way for your program to interface with and control the resources provided by another piece of software, whether that other software is a web service, an end-user app, an OS service or daemon, or a kernel device driver.  

So, what is the semantic difference between an SDK and an API?  

#### Answer accepted (score 175)
I think it rather falls along the lines of "All SDKs are/contain APIs but not all APIs are SDKs".   

An SDK seems to be a complete set of APIs that allow you to perform most any action you would need to for creating applications. In addition an SDK may include other tools for developing for the platform/item that it is for.  

An API on the other hand is just a series of related methods that may be good for a specific purpose.   

As an example, the JDK (Java Development Kit) contains the API as well as the compilers, runtimes, and other miscellaneous tools. The Java API is simply all the libraries that make up the core language that you can work with out of the box.   

#### Answer 2 (score 85)
<ul>
<li>API = Application Programming Interface</li>
<li>SDK = Software Development Kit</li>
</ul>

So the real difference is, that an API is no more or less than an interface to "some service", while an SDK is a set of tools/components/classes for a specific purpose. An SDK in fact presents you with an API to interface with. But you might use an API without having the underlying components, for example when the API is provided through a web service.   

Examples of APIs:  

<ul>
<li><a href="http://download.oracle.com/javase/1,5.0/docs/api/">Java API</a></li>
<li><a href="https://developers.google.com/maps/documentation/javascript/tutorial">Google Maps API</a></li>
<li><a href="http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/index.html">Flash Player API</a></li>
</ul>

Examples of SDKs:  

<ul>
<li><a href="http://en.wikipedia.org/wiki/Java_Development_Kit">JDK</a></li>
<li><a href="http://code.google.com/webtoolkit/">GWT</a></li>
<li><a href="http://flex.apache.org/">Flex SDK</a></li>
</ul>

#### Answer 3 (score 24)
API → documented interface (at a certain point in time, and for a certain audience. Documentation might be incomplete and/or unavailable to the general public and this might be on purpose, but this does not dimish the fact it was meant to be documented for third parties to use it.)  

SDK → interface documentation ( + examples &amp; tools )  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: Why do business analysts and project managers get higher salaries than programmers? (score [243445](https://stackoverflow.com/q/45776) in 2016)

#### Question
We have to admit that programming is much more difficult than creating documentation or even creating Gantt chart and asking progress to programmers. So for us that are naives, knowing that programming is generally more difficult, why do business analysts and project managers get higher salary than programmers? What is it that makes their job a high paying job when even at most times programmers are the ones that go home late?   

<strong>UPDATE</strong>  

Excuse my ignorance, from some of the response it seems that the reason why BAs and PMs gets higher salary because they are the ones that usually responsible for the mess programmers make. But at the end of the day, it is programmers that get their hands dirty to fix the mess and work harder. So it still does not make sense.  

#### Answer accepted (score 389)
<strong>Whether project managers get higher salaries than programmers and business analysts at all exist as a class depends squarely on the software world you live in.</strong>  

<a href="https://softwareengineering.stackexchange.com/questions/45776/why-do-business-analysts-and-project-managers-get-higher-salaries-than-programmer/45780#45780">A simple answer</a> to this question would be "because in our societies, we still think the salary is bound to the position in the hierarchy." But this answer whilst reflecting the fact that people are paid based on their perceived value doesn't explain why PM and BA are on top of the hierarchy in many software organisations and why the management goes for hierarchy in the first place as a structure of choice for software project team. These are the two questions that seems to be really worthy asking.    

Broadly speaking there are two categories of software making organisations. I will call them Widget Factories and Film Crews.  

Widget Factories are born out of management school of thought revolving around <a href="http://en.wikipedia.org/wiki/Theory_X_and_theory_Y" rel="nofollow noreferrer">motivation Theory X</a> proposed by McGregor: rank employees are lazy and require constant control and supervision, jobs are held in the name of a pay check, managers are always able to do their subordinates' jobs to the higher or, at least, same standard. This thinking lands to a natural idea that the entire team can easily be replaced with and represented by the manager alone - after all everyone else on the team is either easilly replacable or there just to enhance manager's ability to complete tasks. Hence the hierarchy as a structure and rather horizontal job roles.  

Widget Factory management operates on the assumption that software can be manufactured out of a specification prepared by a business analyst through a clearly defined process run under the close supervision of a project manager. The manufacturing is taken care of by staffing the project with enough qualified yet interchangeable programming and testing resources. Work is driven by a prearranged budget based on the initial business case prepared by PM and BA.  

Management that runs a Widget Factory is easy to spot just by paying attention to the way these people talk. They are likely to be on about resources (including when referring to team members), processes, operating efficiency, uniformity, repeatability, strict control over use of resources, clear-cut job roles and defined process inputs and outputs. They'd casually mention the actual factory metaphor when trying to convey the image of the ideal software development operation as they see it.  

Then there are Film Crews. They are based on the notion that people are intelligent, self-motivated, work really hard and enjoy their jobs as much as kids enjoy playing. Film Crews recognise that due to specialisation individual contributor abilities may by far surpass the abilities of people organising, co-ordinating and directing the work. Since manager can no longer substitute for everyone the hierarchical structure just doesn't work that well - people have to co-operate within a much flatter and complex formation to get things done. Jobs roles themselves tend to be much more vertical - start to finish - and involve a broader variety of skills. This management thinking is underpinned by <a href="http://en.wikipedia.org/wiki/Theory_X_and_theory_Y" rel="nofollow noreferrer">McGregor's Theory Y</a>.  

A director of a Film Crew knows that her vision for a piece of software can only come true should she be able to assemble a great crew, fascinate the imaginations and help the team to gel and work together. Her role is to inspire, guard the vision, provide direction and focus the efforts. Every single person matters because "director" believes that software results from combination of worldviews and abilities of all participants and a unique way the group carries out the work together. Everyone recognises from the onset the importance of getting the stars to join the crew – star performers increase every chance for success. Vision drives budget and attracts funding.  

<strong>When it comes to compensation</strong> Widget Factories deem that the most value is derived from the work done by project manager and business analyst who reside on the top of the hierarchy and have to be compensated accordingly, the rest of the team doesn’t matter that much as long as they’ve got the right qualifications to convert requirements into working code. PM and BA work hard to maintain their position on top of the pack by restricting free access to the sources of project information to the rest of the team. Without formal access to the primary info sources the team struggles to make any value judgements or come up with good solutions, programmers are relegated to taking orders from above and working on the problem as defined by PM and BA. This situation further reinforces the Widget Factory notion that programmers are akin to factory shop floor workers only capable of mechanically carrying out though technically complicated, but nonetheless standard tasks.  

In a stark contrast Film Crew acts as a more egalitarian formation; members are given unrestricted access to primary information, encouraged to form value judgements and are free to select a course of actions to fulfil and contribute to the vision. Leadership structure is based on ability rather than a specific role within the team. Compensation reflects how desirable getting a specific person to take part in the project, it often tied to the perception of how much more valuable the end result will become if that person can be convinced to devote their energy to creating that piece of software.  In this environment the role of a project manager becomes less prominent as he is unlikely to be the creative leader; the role comes down mostly to administrative support and external relations. Business analyst’s duties are partly replaced by the role of visionary (I called her earlier “a director”) and partly absorbed by other team members.   

Now, it won’t come as a surprise that most in-house software development teams and some consultancies are run as Widget Factories relying on a process to produce consistently boring software; it is these environments where project managers and business analysts are routinely paid more than programmers based on the assumption that they bring the most value with the environment structured accordingly making it difficult for programmers to prove the management wrong.  

Successful software companies tend to adopt Film Crew viewpoint, any other philosophy would hinder their ability to attract great people that they rely on so much to produce great software. It’s unlikely you’d ever see a business analyst role in that setting and project managers are less prominent and routinely get paid less than great programmers.  

#### Answer 2 (score 276)
Because in our societies, we still think the salary is <strong>bound to the position in the hierarchy</strong>.  

The analysts or project managers are higher in the hierarchy, so they should be paid more.  

Let me tell you a real story that illustrate why this is a problem.  

<blockquote>
  A good friend started as a programmer in a big hospital. Thanks to his hard work and dedication, he quickly became Oracle DBA, which was a critical position in a company where data is both sensitive and valuable.  
  
  The hospital worked with levels. Levels are bound to your position in the hierarchy, legacy and diplomas.  
  
  My friend got a proposal to become DBA in another company that didn't use salary levels. His salary could be increased a lot. Because he liked and respected the hospital he worked for, he decided to talk to the boss, asking for an increase.  
  
  The boss refused. It was impossible because of the levels and the unions would not let that happen.  
  
  My friend left.  
  
  The hospital eventually hired an external consultant (not bound to levels) and posted a job on their website. The consultant did not know anything about the infrastructure in place, so his learning curve was huge. The hospital lost lots of money because of that.  
  
  The hospital did lose a lot more. The external consultant was paid as much as 5 times what my friend asked for, and they couldn't find a qualified employee to replace him.  
  
  That was almost three years ago. My friend is still at his new place and climbing the hierarchy ladder very fast doing what he loves.  
  
  The hospital is still paying 5 times more.  
</blockquote>

<strong>IMHO, salary should be relative to the value you provide to the company</strong>.  

<strong>UPDATE</strong>: When you move higher in the hierarchy, there is the leverage effect occurring. So in fact, you are paid for the value you bring. But brilliant programmers that are 10x more productive should be paid 10x more, regardless their position in that hierarchy (usually at the very bottom). That's what I wanted to highlight.  

#### Answer 3 (score 84)
They take more <strong>risks</strong> than programmers do. They have to make decisions based on whatever information we gave them, and then face the stakeholder's harsh criticism when their expectations aren't met. Part of the pay package compensates for this risk.  

Another factor may be the years of experience needed to prepare a project manager who can plan, estimate and mitigate properly. In some sense, a nuanced project manager is <strong>trained through failures, making it an expensive-to-acquire skill</strong>. Once reached the level of seniority, a company may not be willing to let go of such valuable personnel.  

Edit:  

There are more kinds of risks than financial or physical harm. For example, consider the risk of being reprimanded by the manager or the customer. Although no actual harm is done, it is still undesirable enough that we adapt our behaviors in order to avoid this kind of outcome. However, managers have to make good decisions all the time, and has to balance different kinds of risks in the interest of the company, not according to personal preference.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: When to favor ASP.NET WebForms over MVC (score [242392](https://stackoverflow.com/q/95212) in 2013)

#### Question
I know that Microsoft has said   

<blockquote>
  ASP.NET MVC is not a replacement for WebForms.    
</blockquote>

And some developers say WebForms is faster to develop on than MVC.  But I believe speed of coding comes down to comfort level with the technology so I don't want any answers in that vein.  

Given that ASP.NET MVC gives a developer more control over their application, why isn't WebForms considered obsolete?  Alternatively, when should I favor WebForms over MVC for new development?    

#### Answer accepted (score 105)
Webforms vs. MVC seems to be a hot topic right now. Everyone I know touts MVC to be the next great thing. From my slight dabblings in it, it seems ok, but no I don't think it will be the end of webforms.   

My reasoning, and the reasoning as to why webforms would be chosen over MVC, has more to do with a business perspective rather than what one is better than the other.   

Time/money are the greatest reasons why webforms would be chosen over MVC.   

If most of your team knows webforms, and you don't have the time to get them up to speed on MVC, the code that will be produced may not be quality. Learning the basics of MVC then jumping in and doing that complex page that you need to do are very different things. The learning curve is high so you need to factor that into your budget.  

If you have a large website written all in webforms, you might be more inclined to make any new pages in webforms so that you don't have two very different types of pages in your site.   

I'm not saying it's an all or nothing approach here, but it does make your code harder to maintain if there is a split of both, especially if not everyone on the team is familiar with MVC.  

My company recently did three test pages with MVC. We sat down and designed them out. One issue we ran into is that most of our screens have the View and Edit functionality on the same page. We ended up needing more than one form on the page. No biggy, except then we wouldn't use our masterpage. We had to revamp that so that both the webforms pages and MVC pages could use the same masterpage for common look and feel. Now we have an extra layer of nesting.   

We needed to create a whole new folder structure for these pages so that it followed the proper MVC separation.  

I felt there were too many files for 3 pages, but that is my personal opinion.  

In my opinion, you would choose webforms over MVC if you don't have the time/money to invest in updating your site to use MVC. If you do a half arsed approach to this, it won't be any better than the webforms you have now. Worse, you could even be setting this technology up for failure in your company if it's messed up, as upper management might see it as something inferior to what they know.  

#### Answer 2 (score 189)
I developed ASP .Net WebForms applications for 3 years, and after one day of doing an MVC tutorial I was sold. MVC is almost ALWAYS the better solution. Why?  

<ul>
<li>The page lifecylce is simpler and more efficient</li>
<li>There is no such thing as controls besides html controls. You don't need to debug your output to see what ASP .Net is generating. </li>
<li>ViewModels give you immense power and obviate the need to do manual control binding and it eliminates many errors relating to binding. </li>
<li>You can have multiple forms on a page. This was a serious limitation of WebForms.</li>
<li>The web is stateless and MVC matches the architecture of the web more closely. Webforms introduces state and the bugs you have with it by introducing the ViewState. The ViewState is automatic and works in the background, so it doesn't always behave the way you want it to.</li>
<li>Web applications need to work with ajax these days. It's not acceptable to have full page loads any more. MVC makes ajax so so much better, easier and more efficient with JQuery. </li>
<li>Because you can have multiple forms on a page, and because the architecture is driven by calls to urls, you can do funky things like ajax load a different form, like an edit form into your current page using JQuery. Once you realise what this lets you do you can do amazing things easily.</li>
<li>ASP .Net WebForms is not only an abstraction over html, it is an extremely complex one. Sometimes you would get a weird bug and struggle with it for much longer than need be. In many cases you could actually see what it was doing wrong but you are unable to do anything about it. You end up doing weird workarounds.</li>
<li>WebForms does not make a good technology for designers. Designers often like working with html directly. In MVC it's a view, in WebForms it's half a day of work. </li>
<li>As the web platform is evolving fast WebForms wont keep up. It's not aware of new tags or features of HTML5, it will still render the same stuff unless you get (often) expensive 3rd party controls or wait for Microsoft to issue an update. </li>
<li>Controls in WebForms limit you in so many ways. In MVC you can just grab a JQuery library and integrate it into your templates. </li>
</ul>

I know some of the issues above have been addressed to some extent as WebForms evolves, but that was my original experience. All in all I would find it extremely hard to find a business case for WebForms unless a project is already using it.  

#### Answer 3 (score 80)
I emailed <a href="http://www.scottgu.com/">Scott Guthrie</a>, an <a href="http://weblogs.asp.net/scottgu/archive/2007/11/13/asp-net-mvc-framework-part-1.aspx">MVC expert</a> at Microsoft.  And probably the most qualified man to answer this question.  He was kind enough to reply:  

<blockquote>
  <p>"Different customers look for different programming approaches, and a
  lot love WebForms and think it is great.  Others love MVC and think it
  is great.  That is why we are investing in both.  "</p>
</blockquote>

So, to me this says that its not a technical issue.  Its more of a "soft issue", if you will. One of personal preference.  This is in line what several of you have said.  

Thanks for all the answers.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Difference between REST and CRUD (score [235227](https://stackoverflow.com/q/120716) in 2014)

#### Question
I learned REST and it feels a lot like CRUD (from what I have read about CRUD).  

I know they are different, and I wonder if thinking they are similar means I don't understand them.  

Is it that REST is a "superset" of CRUD?  Does everything CRUD does and more?  

#### Answer accepted (score 205)
Surprisingly, I don't see in the other answers what I consider the real difference between REST and CRUD: what each one manages.  

CRUD means the basic operations to be done in a data repository.  You directly handle records or data objects; apart from these operations, the records are passive entities.  Typically it's just database tables and records.  

REST, on the other hand, operates on resource representations, each one identified by an URL.  These are typically not data objects, but complex object abstractions.  

For example, a resource can be a user's comment. That means not only a record in a 'comment' table, but also its relationships with the 'user' resource, the post that comment is attached to, maybe another comment that it responds to.  

Operating on the comment isn't a primitive database operation, it can have significant side effects, like firing an alert to the original poster, or recalculating some game-like 'points', or updating some 'followers stream'.  

Also, a resource representation includes hypertext (check the <a href="http://en.wikipedia.org/wiki/HATEOAS" rel="noreferrer">HATEOAS</a> principle), allowing the designer to express relationships between resources, or guiding the REST client in an operation's workflow.  

In short, CRUD is a set primitive operations (mostly for databases and static data storages), while REST is a very high-level API style (mostly for web services and other 'live' systems).  

The first one manipulates basic data, the other interacts with a complex system.  

#### Answer 2 (score 100)
First of all, both are simply common initials; they're nothing to be afraid of.  

Now, CRUD is a simple term that was abbreviated because it's a common feature in many applications, and it's easier to say <em>CRUD</em>. It describes the 4 basic operations you can perform on data (or a resource). Create, Read, Update, Delete.  

<p>REST however, is a named practice (just like AJAX), not a technology in itself.
It encourages use of capabilities that have long been inherent in the HTTP protocol, but seldom used.</p>

When you have a URL (Uniform <strong>Resource Locator</strong>) and you point your browser to it by the address line, you're sending an <strong>HTTP request</strong>. Each HTTP request contains information that the server can use to know which <strong>HTTP response</strong> to send back to the client that issued the request.  

Each request contains a URL, so the server knows which <em>resource</em> you want to access, but it can also contain a <strong>method</strong>. A method describes what to <em>do</em> with that resource.  

But this "method" concept wasn't used very often.  

Usually, people would just link to pages via the GET method, and issue <em>any</em> type of updates (deletions, insertions, updates) via the POST method.  

And because of that you couldn't treat one <em>resource</em> (URL) as a true resource in itself. You had to have separate URLs for deletion, insertion or update of the same resource. For example:  

```
http://...com/posts/create- POST request  -> Goes to posts.create() method in the server
http://...com/posts/1/show- GET request  -> Goes to posts.show(1) method in the server
http://...com/posts/1/delete - POST request  -> Goes to posts.delete(1) method in the server
http://...com/posts/1/edit- POST request  -> Goes to posts.edit(1) method in the server
```

With REST, you create forms that are <em>smarter</em> because they use other HTTP methods aside of POST, and program your server to be able to distinguish between <em>methods</em>, not only URLS. So for example:  

```
http://...com/posts - POST request  -> Goes to posts.create() method in the server
http://...com/posts/1 - GET request  -> Goes to posts.show(1) method in the server
http://...com/posts/1 - DELETE request  -> Goes to posts.delete(1) method in the server
http://...com/posts/1 - PUT request  -> Goes to posts.edit(1) method in the server
```

<p>Remember, a single URL describes a single resource. A single post is a single resource.
With REST you treat resources the way they were meant to be treated. You're telling the server which resource you want to handle, and how to handle it.</p>

There are many other features to "RESTful architecture", which you can read about in Wikipedia, other articles or books, if you're interested. There isn't a whole lot more to CRUD itself, on the other hand.  

#### Answer 3 (score 20)
REST stands for "representational state transfer", which means it's all about communicating and modifying the state of some resource in a system.  

REST gets quite involved, because the theory behind REST gets into leveraging media, hypermedia, and an underlying protocol to manage information on a remote system.  

CRUD, on the other hand, is a mnemonic for the common operations you need for data in a database: Create Retrieve Update Delete. But it really doesn't get any deeper than that.  

So that's the answer to your question, but I'll mention the common mistake I see when REST and CRUD are discussed together. A lot of developers want to map REST to CRUD directly, because REST over HTTP provides for GET PUT POST and DELETE, while CRUD provides for CREATE RETRIEVE UPDATE DELETE. It's natural to want to map the REST verbs directly to CRUD operations.  

However, HTTP uses a "create or update" style, while CRUD separates create and update. That makes it impossible (!) to make a clean, general mapping between the two (!)  

GET and DELETE are easy... GET === RETRIEVE, and DELETE === DELETE.  

But per the HTTP spec, PUT is actually Create AND Update:  

<ul>
<li><p>Use PUT to create a brand new object when you know everything about it, including its identifier</p></li>
<li><p>Use PUT to update an object (usually with a complete representation of the object)</p></li>
</ul>

POST is the "processing" verb, and is considered the "append" verb:  

<ul>
<li><p>Use POST to append a new object to a collection -- that is, create a new object</p></li>
<li><p>POST is also used when none of the other verbs quite fit, as the HTTP spec defines it as the "data processing" verb</p></li>
<li><p>If your team is getting hung up on POST, remember that the entire WWW was built on GET and POST ;)</p></li>
</ul>

So while there is similarity between REST and CRUD, the mistake I see most teams make is to make an equivalence between the two. A team really needs to be careful when defining a REST API not to get too hung up on the CRUD mnemonic, because REST as a practice really has a lot of additional complexity that doesn't map cleanly to CRUD.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: Do you have to be good at math to be a good programmer? (score [232896](https://stackoverflow.com/q/89158) in )

#### Question
It seems that conventional wisdom suggests that good programmers are also good at math. Or that the two are somehow intrinsically linked. Many programming books I have read provide many examples that are solutions to math problems, or are somehow related to math as if these examples are what make sense to most people.  

So the question I would like to float is: do you have to be good at math to be a <strong>good</strong> programmer?  

#### Answer accepted (score 83)
I think it depends on what type of programming you want to do. As far as being a programmer in the business world goes, I would say that the answer is no. You can become a great programmer without knowing advanced mathematics. When you do end up having to deal with math, the formulas are usually defined in the business requirements so it only becomes a matter of implementing them in code.    

On the flip side, If you want to become a low-level programmer or say create 3D graphics engines, mathematics will play a huge role.  

#### Answer 2 (score 133)
I'm going against the grain and saying <strong>yes, you need a math mindset</strong>. Most people think of math as doing arithmetic or memorizing arcane formulas. This is like asking if you need perfect spelling or an extraordinary vocabulary to be a good writer.  

Writing is about communication, and math/programming is about the process of clear, logical thinking (in a way that you can't make mistakes; the equation doesn't balance, or the program doesn't compile). Specifically, that logical thinking manifests in:  

<ul>
<li>Ability to estimate / understand differences between numbers: O(n^2) vs O(lg(n)), intuitive sense of KB vs MB vs GB, how slow disk is compared to RAM. If you don't realize how tiny a KB is compared to a GB you'll be wasting time optimizing things that don't matter.</li>
<li>Functions / functional programming (is it any coincidence that the equation f(x) = x^2 is so similar to how you'd write that method? The words "algorithm" and "function" were around in the math world far before the first computer was born :-))</li>
<li>Basic algebra to create &amp; reorder your own equations, take averages, basic stats</li>
</ul>

So, I'll say you need a <a href="http://betterexplained.com/articles/how-to-develop-a-mindset-for-math/">math mindset</a>, being able to construct &amp; manipulate mental models of what your program is doing, rather than a collection of facts &amp; theorems. Certain fields like graphics or databases will have certain facts you need also, but to me that's not the essence of being "good at math".  

#### Answer 3 (score 53)
There are many different fields of programming and many of those don't require a particularly high standard of mathematical knowledge. You will never be able to write a 3D engine, but you will certainly be able to develop business and web applications. Let's face it - the most common mathematical operation in most computer programmes is incrementing a number by one.   

I'll quite happily admit I've never particularly liked maths or been good at it (I actually graduated with a degree in English Literature!) and have worked as a professional developer for over 12 years now. I develop mostly web applications, which rarely require that much maths. More important is the ability to think logically, be able to break problems down into chunks and have a wide understanding of the various technologies and frameworks involved.  

As a programmer you are much more likely to have to implement an <em>existing</em> algorithm than devise an entirely <em>new</em> one. Need to work out, say, compound interest? You don't need to figure it out yourself, just look-up the formula and apply it. Most of the problems have already been solved, you just need to know how to implement the solutions in your language of choice. That's not to say that being good at maths wouldn't be an <em>advantage</em>; it's just that it isn't totally <em>essential</em>.  

When I was at school in the mid 80's when home computers where not very common I often wrote programs to solve my maths homework. I often couldn't do it in my head, but I could apply whatever formula was required as a software routine. You don't need to be another Pythagoras to work out the longest side of a right-angled triangle, you simply need to be able to code up `a² + b² = h²` in your language of choice.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: So Singletons are bad, then what? (score [225857](https://stackoverflow.com/q/40373) in 2014)

#### Question
There has been a lot of discussion lately about the problems with using (and overusing) Singletons. I've been one of those people earlier in my career too. I can see what the problem is now, and yet, there are still many cases where I can't see a nice alternative - and not many of the anti-Singleton discussions really provide one.  

Here is a real example from a major recent project I was involved in:  

The application was a thick client with many separate screens and components which uses huge amounts of data from a server state which isn't updated too often. This data was basically cached in a Singleton "manager" object - the dreaded "global state". The idea was to have this one place in the app which keeps the data stored and synced, and then any new screens that are opened can just query most of what they need from there, without making repetitive requests for various supporting data from the server. Constantly requesting to the server would take too much bandwidth - and I'm talking thousands of dollars extra Internet bills per week, so that was unacceptable.  

Is there any other approach that could be appropriate here than basically having this kind of global data manager cache object? This object doesn't officially have to be a "Singleton" of course, but it does conceptually make sense to be one. What is a nice clean alternative here?  

#### Answer accepted (score 810)
It's important to distinguish here between <em>single instances</em> and the <a href="http://en.wikipedia.org/wiki/Singleton_pattern">Singleton design pattern</a>.  

<em>Single instances</em> are simply a reality.  Most apps are only designed to work with one configuration at a time, one UI at a time, one file system at a time, and so on.  If there's a lot of state or data to be maintained, then certainly you would want to have just one instance and keep it alive as long as possible.  

The Singleton <em>design pattern</em> is a very specific <em>type</em> of single instance, specifically one that is:  

<ul>
<li>Accessible via a global, static instance field;</li>
<li>Created either on program initialization or upon first access;</li>
<li>No public constructor (cannot instantiate directly);</li>
<li>Never explicitly freed (implicitly freed on program termination).</li>
</ul>

It is because of this specific design choice that the pattern introduces several potential long-term problems:  

<ul>
<li>Inability to use abstract or interface classes;</li>
<li>Inability to subclass;</li>
<li>High coupling across the application (difficult to modify);</li>
<li>Difficult to test (can't fake/mock in unit tests);</li>
<li>Difficult to parallelize in the case of mutable state (requires extensive locking);</li>
<li>and so on.</li>
</ul>

None of these symptoms are actually endemic to single instances, just the Singleton pattern.  

What can you do instead?  Simply don't use the Singleton pattern.  

Quoting from the question:  

<blockquote>
  The idea was to have this one place in the app which keeps the data stored and synced, and then any new screens that are opened can just query most of what they need from there, without making repetitive requests for various supporting data from the server. Constantly requesting to the server would take too much bandwidth - and I'm talking thousands of dollars extra Internet bills per week, so that was unacceptable.  
</blockquote>

This concept has a name, as you sort of hint at but sound uncertain of.  It's called a <a href="http://en.wikipedia.org/wiki/Cache">cache</a>.  If you want to get fancy you can call it an "offline cache" or just an offline copy of remote data.  

A cache does not need to be a singleton.  It <em>may</em> need to be a single instance if you want to avoid fetching the same data for multiple cache instances; but that does not mean you actually have to <em>expose everything to everyone</em>.  

The first thing I'd do is separate out the different <em>functional areas</em> of the cache into separate interfaces.  For example, let's say you were making the world's worst YouTube clone based on Microsoft Access:  

<pre>
                          MSAccessCache
                                ▲
                                |
              +-----------------+-----------------+
              |                 |                 |
         IMediaCache      IProfileCache      IPageCache
              |                 |                 |
              |                 |                 |
          VideoPage       MyAccountPage     MostPopularPage
</pre>

Here you have several <em>interfaces</em> describing the <em>specific</em> types of data a particular class might need access to - media, user profiles, and static pages (like the front page).  All of that is <em>implemented</em> by one mega-cache, but you design your individual classes to accept the interfaces instead, so they don't care what kind of an instance they have.  You initialize the physical instance once, when your program starts, and then just start passing around the instances (cast to a particular interface type) via constructors and public properties.  

This is called <a href="http://en.wikipedia.org/wiki/Dependency_injection">Dependency Injection</a>, by the way; you don't need to use Spring or any special IoC container, just so long as your general class design <em>accepts its dependencies from the caller</em> instead of <em>instantiating them on its own</em> or <em>referencing global state</em>.  

Why should you use the interface-based design?  Three reasons:  

<ol>
<li><p>It makes the code easier to read; you can clearly understand from the interfaces exactly <em>what data</em> the dependent classes depend on.</p></li>
<li><p>If and when you realize that Microsoft Access wasn't the best choice for a data back-end, you can replace it with something better - let's say SQL Server.</p></li>
<li><p>If and when you realize that SQL Server isn't the best choice for media <em>specifically</em>, you can break up your implementation <em>without affecting any other part of the system</em>.  That is where the real power of abstraction comes in.</p></li>
</ol>

If you want to take it one step further then you can use an IoC container (DI framework) like Spring (Java) or Unity (.NET).  Almost every DI framework will do its own lifetime management and specifically allow you to define a particular service <strong>as a single instance</strong> (often calling it "singleton", but that's only for familiarity).  Basically these frameworks save you most of the monkey work of manually passing around instances, but they are not strictly necessary.  <strong>You do not need any special tools in order to implement this design.</strong>  

For the sake of completeness, I should point out that the design above is really not ideal either.  When you are dealing with a cache (as you are), you should actually have an entirely separate <em>layer</em>.  In other words, a design like this one:  

<pre>
                                                        +--IMediaRepository
                                                        |
                          Cache (Generic)---------------+--IProfileRepository
                                ▲                       |
                                |                       +--IPageRepository
              +-----------------+-----------------+
              |                 |                 |
         IMediaCache      IProfileCache      IPageCache
              |                 |                 |
              |                 |                 |
          VideoPage       MyAccountPage     MostPopularPage
</pre>

The benefit of this is that you never even need to break up your `Cache` instance if you decide to refactor; you can change how Media is stored simply by feeding it an alternate implementation of `IMediaRepository`.  If you think about how this fits together, you will see that it still only ever creates one physical instance of a cache, so you never need to be fetching the same data twice.  

None of this is to say that every single piece of software in the world needs to be architected to these exacting standards of high cohesion and loose coupling; it depends on the size and scope of the project, your team, your budget, deadlines, etc.  But if you're asking what the best design is (to use in place of a singleton), then this is it.  

P.S. As others have stated, it's probably not the best idea for the dependent classes to be aware that they are using a <em>cache</em> - that is an implementation detail they simply should never care about.  That being said, the overall architecture would still look very similar to what's pictured above, you just wouldn't refer to the individual interfaces as <em>Caches</em>.  Instead you'd name them <em>Services</em> or something similar.  

#### Answer 2 (score 48)
In the case you give, it sounds like the use of a <em>Singleton is not the problem, but the symptom of a problem</em> - a larger, architectural problem.  

Why are the screens querying the cache object for data?  Caching should be transparent to the client.  There should be an appropriate abstraction for providing the data, and the implementation of that abstraction might utilize caching.  

The issue is likely that dependencies between parts of the system are not set up correctly, and this is probably systemic.  

Why do the screens need to have knowledge of where they get their data?  Why are the screens not provided with an object that can fulfill their requests for data (behind which a cache is hidden)?  Oftentimes the responsibility for creating screens is not centralized, and so there is no clear point of injecting the dependencies.    

Again, we are looking at large-scale architectural and design issues.  

Also, it is <em>very</em> important to understand that the <strong>lifetime</strong> of an object can be completely divorced from how the object is found for use.  

A cache will have to live throughout the application's lifetime (to be useful), so that object's lifetime is that of a Singleton.  

But the problem with Singleton (at least the common implementation of Singleton as a static class/property), is how other classes that use it go about finding it.  

With a static Singleton implementation, the convention is to simply use it wherever needed.  But that completely hides the dependency and tightly couples the two classes.  

If we <em>provide</em> the dependency to the class, that dependency is explicit and all the consuming class needs to have knowledge of is the contract available for it to use.  

#### Answer 3 (score 45)
I wrote a <a href="http://gameprogrammingpatterns.com/singleton.html">whole chapter</a> on just this question. Mostly in the context of games, but most of it should apply outside of games.  

<strong>tl;dr:</strong>  

The Gang of Four Singleton pattern does two things: give you convenience access to an object from anywhere, and ensure that only one instance of it can be created. 99% of the time, all you care about is the first half of that, and carting along the second half to get it adds unnecessary limitation.  

Not only that, but there are better solutions for giving convenient access. Making an object global is the nuclear option for solving that, and makes it way to easy to destroy your encapsulation. Everything that's bad about globals applies completely to singletons.  

If you're using it just because you have a lot of places in code that need to touch the same object, try to find a better way to give it to <em>just</em> those objects without exposing it to the entire codebase. Other solutions:  

<ul>
<li><p><strong>Ditch it entirely.</strong> I've seen lots of singleton classes that don't have any state and are just bags of helper functions. Those don't need an instance at all. Just make them static functions, or move them into one of the classes that the function takes as an argument. You wouldn't need a special `Math` class if you could just do `123.Abs()`.</p></li>
<li><p><strong>Pass it around.</strong> The simple solution if a method needs some other object is to just pass it in. There's nothing wrong with passing some objects around.</p></li>
<li><p><strong>Put it in the base class.</strong> If you have a lot of classes that all need access to some special object, and they share a base class, you can make that object a member on the base. When you construct it, pass in the object. Now the derived objects can all get it when they need it. If you make it protected, you ensure the object still stays encapsulated.</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: What is the job title hierarchy amongst software engineers? (score [221678](https://stackoverflow.com/q/117179) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://softwareengineering.stackexchange.com/questions/38265/what-does-the-suffix-after-software-engineer-developer-job-titles-mean-i-e-so">What does the suffix after software engineer/developer job titles mean? (i.e. Software Developer III)</a><br>
  <a href="https://softwareengineering.stackexchange.com/questions/39353/work-advancement-titles">work advancement titles</a>  </p>
</blockquote>



I've been struggling to understand job hierarchy in software engineering.  

The system is further complicated because of the lack of consistent naming conventions when assigning roles: for example, some companies just have a "senior software developer" position while others have Software Engineer I, Software Engineer II, Software Engineer III, and so on.  

Even in the top level positions, we have things like "Principal Software Engineer" vs. "Staff Software Engineer".  

What is the standard hierarchy for software engineers? Is there a generally accepted pecking order?  

#### Answer accepted (score 40)
Wikipedia gives a good overview of corporate titles and under the <a href="http://en.wikipedia.org/wiki/Corporate_title" rel="nofollow">hierarchy for Information Technology companies</a> you have the following:  

<ul>
<li>Chief Executive Officer 

<ul>
<li>Vice President 

<ul>
<li>Senior Project Manager / Senior Product Manager / Senior Software Architect 

<ul>
<li>Project Manager / Product Manager / Software Architect 

<ul>
<li>Project Lead / Senior Team Lead / Senior Technical Lead 

<ul>
<li>Module Lead / Team Lead / Technical Lead 

<ul>
<li>Senior Software Engineer / Senior QA Engineer 

<ul>
<li>Software Engineer / QA Engineer</li>
</ul></li>
</ul></li>
</ul></li>
</ul></li>
</ul></li>
</ul></li>
</ul></li>
</ul>

While each company will have it's own naming convention and resposibilities for a role, they do seem to fall within this basic hierarchy.  

Hope this helps you out some.  

#### Answer 2 (score 29)
There is no standard hierarchy of software job titles. Titles are peculiar to each company. If you have a question about a job title there's no point in asking anybody except that company.  

#### Answer 3 (score 9)
At Microsoft, the titles are:  

<ul>
<li>Software Development Engineer (two internal levels, 59 and 60)   </li>
<li>SDE II (61 and 62)   </li>
<li>Senior SDE (63 and 64)   </li>
<li>Principal SDE (65 and 66)</li>
</ul>

At Google, there are senior titles like Staff Software Engineer and Sr. Staff Software Engineer.  

At Apple, there are titles like Software Engineer I to Software Engineer V.  

See also: <a href="https://softwareengineering.stackexchange.com/questions/46366/what-is-the-difference-between-these-senior-software-engineer-titles">What is the difference between these senior software engineer titles?</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: What is the single most effective thing you did to improve your programming skills? (score [219472](https://stackoverflow.com/q/44177) in 2011)

#### Question
Looking back at my career and life as a programmer, there were plenty of different ways I improved my programming skills - reading code, writing code, reading books, listening to podcasts, watching screencasts and more.  

My question is: What is the most effective thing you have done that improved your programming skills? What would you recommend to others that want to improve?  

I do expect varied answers here and no single "one size fits all" answer - I would like to know what worked for different people.  

#### Answer 2 (score 753)
In no specific order...  

<ul>
<li><p><strong>Working with people far smarter than myself</strong></p></li>
<li><p><strong>Always listening to what others have to say, regardless if they're junior, intermediate, senior or guru.  job title doesn't mean anything.</strong></p></li>
<li><p>Learning other frameworks/languages, and seeing how they do things, and compare that to stuff that I already know</p></li>
<li><p>Reading about patterns, best practices, and then examining my old stuff and applying those patterns where necessary</p></li>
<li><p>Pair programming</p></li>
<li><p>Disagreeing with everything Joel says. ;)</p></li>
</ul>

#### Answer 3 (score 557)
<strong>Deciding <em>TO</em> be a 'Jack-of-all-Trades'</strong>  

Fairly early in my career, I was an expert with a particular database and programming language.  Unfortunately, that particular database lost the 'database wars', and I discovered that my career options were ... limited.  After that I consciously decided that I would never let myself become boxed in like that again.  So I studied everything I could get my hands on:  Windows, Unix, C, C++, Java, C#, Perl, Python, Access, SQL Server, Oracle, Informix, MySQL, etc.  Whatever tools and technologies are new or unusual, I became the 'go-to-guy' -- "Ask Craig, if he doesn't know it, he'll learn it."  As a result I've worked on all sorts of projects, from embedded systems for environmental telemetry to command and control systems for missile defense.  

The only problem I've ever had is with companies that insist on pidgeon-holing me into a specialty, when my specialty is being a generalist. <strong>[EDIT:</strong> Also known as a <a href="http://en.wikipedia.org/wiki/Polymath" rel="nofollow">Polymath</a> or Renaissance Man or multi-specialist.<strong>]</strong>  

Something to keep in mind ... what's the half-life of knowledge in high tech?  It tracks with Moore's Law:  half of everything you know will be obsolete in 18-24 months.  An expert who chooses the wrong discipline can easily be undermined by the press of technology; a generalist only has to add some more skills and remember the lessons of the past in applying those skills.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How to respond when you are asked for an estimate? (score [219326](https://stackoverflow.com/q/648) in 2018)

#### Question
We, as programmers, are constantly being asked 'How long will it take'?  

And you know, the situation is almost always like this:  

<ul>
<li>The requirements are unclear. Nobody has done an in depth analysis of all the implications.</li>
<li>The new feature will probably break some assumptions you made in your code and you start thinking immediately of all the things you might have to refactor. </li>
<li>You have other things to do from past assignments and you will have to come up with an estimate that takes that other work into account.</li>
<li>The 'done' definition is probably unclear: When will it be done? 'Done' as in just finished coding it, or 'done' as in "the users are using it"?</li>
<li>No matter how conscious you are of all these things, sometimes your "programmer's pride" makes you give/accept shorter times than you originally suppose it might take. Specially when you feel the pressure of deadlines and management expectations.</li>
</ul>

Many of these are organizational or cultural issues that are not simple and easy to solve, but in the end the reality is that you are being asked for an estimate and they expect you to give a reasonable answer. It's part of your job. You cannot simply say: I don't know.   

As a result, I always end up giving estimates that I later realize I cannot fulfill. It has happened countless of times, and I always promise it won't happen again. But it does.  

What is your personal process for deciding and delivering an estimate? What techniques have you found useful?  

#### Answer accepted (score 390)
From <a href="http://rads.stackoverflow.com/amzn/click/020161622X">The Pragmatic Programmer: From Journeyman to Master</a>:  

<blockquote>
  <strong>What to Say When Asked for an Estimate</strong>  
  
  You say "I'll get back to you."  
  
  You almost always get better results if you slow the process down and spend some time going through the steps we describe in this section. Estimates given at the coffee machine will (like the coffee) come back to haunt you.  
</blockquote>

In the section, the authors recommend the following process:  

<ul>
<li>Determine the accuracy that you need. Based on the duration, you can quote the estimate in different precision. Saying "5 to 6 months" is different than saying "150 days". If you slip a little into the 7th month, you're still pretty accurate. But if you slip into the 180th or 210th day, not so much.</li>
<li>Make sure you understand what is being asked. Determine the scope of the problem.</li>
<li>Model the system. A model might be a mental model, diagrams, or existing data records. Decompose this model and build estimates from the components. Assign values and error ranges (+/-) to each value.</li>
<li>Calculate the estimate based on your model.</li>
<li>Track your estimates. Record information about the problem you are estimating, your estimate, and the actual values.</li>
<li>Other things to include in your estimate are developing and documenting requirements or changes to requirements specifications, creating or updating design documents and specifications, testing (unit, integration, and acceptance), creating or updating user's manuals or READMEs with the changes. If 2 or more people working together, there's overhead of communication (phone calls, emails, meetings) and merging source code. If it's a long task, account for things like other work, time off (holidays, vacation, sick time), meetings, and other overhead tasks when picking a delivery date.</li>
</ul>

#### Answer 2 (score 171)
Software estimation is the most difficult single task in software engineering- a close second being requirements elicitation.  

There are a lot of tactics for creating them, all based on getting good requirements first.  But when your back's against the wall and they refuse to give you better details, Fake It:  

<ol>
<li>Take a good look at the requirements you have.</li>
<li>Make assumptions to fill in the gaps based on your best guess of what they want</li>
<li><strong>Write down <em>all</em> your assumptions</strong></li>
<li>Make them sit down, read, and agree to your assumptions (or, if you're lucky, get them to give in and give you real requirements).  </li>
<li>Now you have detailed requirements that you can estimate from.</li>
</ol>

It's like my mother used to threaten when I was a kid "Hurry up and pick out some clothes, or <em>I'll</em> pick them out for you!"  

#### Answer 3 (score 143)
I did development for a guy who was very adamant about wanting accurate estimates.  What we settled on, which worked very well, was this:  

<ul>
<li>I billed for all the time I spent estimating.  It came to around 20-25% of what I billed.</li>
<li>I did extremely detailed examination of the tasks.  No shooting from the hip.  I went into the code, figured out what lines needed to be changed, what other parts of the program it would affect, how much testing I'd have to do to ensure that things still worked.  I'd estimate each piece in units of .1 hours (6 minutes).</li>
<li>I sent him my estimate for each task along with that detailed breakdown.</li>
</ul>

20-25% of billing sounds like a lot.  

But he'd ask me to make change XYZ, thinking it'd take about 2 hours.  In 1 hour of detailed estimating, I'd determine it'd take 8.5 hours.  So he'd decide whether it was worth 8.5 hours of pay.  If not, then he saved 7.5 hours over what it would've cost him if I'd done it without an estimate.  

And if he <em>did</em> want to invest the 8.5 hours, the detail work I did for the estimate was work I'd have had to do anyway.  

I found that with this method I was able to bring most tasks in on time or even early, without having to heavily overestimate.  Because the time was broken down so minutely, I could tell early on if I was slipping.  If I hit roadblocks so that after 3 hours I could tell that my 8.5-hour task was going to take 12, I could talk to him about it before more time passed so he could reevaluate and yank the feature if he was concerned about the cost.  

Was he nickel-and-diming?  No, I looked at it as letting him apply his money where he saw the most benefit.  And I was glad to get experience in estimating, which I'd always been terrible at.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Aggregation vs Composition (score [218786](https://stackoverflow.com/q/61376) in 2014)

#### Question
I understand what composition is in OOP, but I am not able to get a clear idea of what Aggregation is. Can someone explain?  

#### Answer accepted (score 323)
Simple rules:  

<ol>
<li>A "owns" B = Composition : B has no meaning or purpose in the system without A</li>
<li>A "uses" B = Aggregation : B exists independently (conceptually) from A</li>
</ol>

Example 1:  

A Company is an aggregation of People.  A Company is a composition of Accounts.  When a Company ceases to do business its Accounts cease to exist but its People continue to exist.  

Example 2: (very simplified)  

A Text Editor owns a Buffer (composition).  A Text Editor uses a File (aggregation).  When the Text Editor is closed, the Buffer is destroyed but the File itself is not destroyed.  

#### Answer 2 (score 36)
From <a href="http://en.wikipedia.org/wiki/Object_composition" rel="nofollow noreferrer">http://en.wikipedia.org/wiki/Object_composition</a>  

<blockquote>
  Aggregation differs from ordinary composition in that it does not imply ownership. In composition, when the owning object is destroyed, so are the contained objects. In aggregation, this is not necessarily true. For example, a university owns various departments (e.g., chemistry), and each department has a number of professors. If the university closes, the departments will no longer exist, but the professors in those departments will continue to exist. Therefore, a University can be seen as a composition of departments, whereas departments have an aggregation of professors. In addition, a Professor could work in more than one department, but a department could not be part of more than one university.  
</blockquote>

So - while you have an ownership relationship with composition the owned object is also destroyed when the owner is - an aggregation (and the objects contained) can exist independently.  

--  

<p>Update:
Apologies - this answer is far too simplistic in hindsight.</p>

c.batt provides an excellent definition in his answer: <a href="https://softwareengineering.stackexchange.com/questions/61376/aggregation-vs-composition/61527#61527">Aggregation vs Composition</a>  

#### Answer 3 (score 20)
There is no single explanation.  Different authors mean different things by aggregation.  Most don't really mean anything specific by it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: What is MVC, really? (score [216456](https://stackoverflow.com/q/127624) in )

#### Question
As a serious programmer, how do you answer the question <strong>What is MVC?</strong>  

In my mind, MVC is sort of a nebulous topic &mdash; and because of that, if your audience is a learner, then you're free to describe it in general terms that are unlikely to be controversial.  

However, if you are speaking to a knowledgeable audience, especially an interviewer, I have a hard time thinking of a direction to take that doesn't risk a reaction of "well that's not right!...".  We all have different real-world experience, and I haven't truly met the same MVC implementation pattern twice.  

Specifically, there seem to be disagreements regarding strictness, component definition, separation of parts (what piece fits where), etc.  

So, <strong>how should I explain MVC</strong> in a way that is correct, concise, and uncontroversial?  

#### Answer accepted (score 156)
MVC is a software architecture - the structure of the system - that separates domain/application/business (whatever you prefer) logic from the rest of the user interface. It does this by separating the application into three parts: the model, the view, and the controller.  

The model manages fundamental behaviors and data of the application. It can respond to requests for information, respond to instructions to change the state of its information, and even to notify observers in event-driven systems when information changes. This could be a database, or any number of data structures or storage systems. In short, it is the data and data-management of the application.  

The view effectively provides the user interface element of the application. It'll render data from the model into a form that is suitable for the user interface.  

The controller receives user input and makes calls to model objects and the view to perform appropriate actions.  

All in all, these three components work together to create the three basic components of MVC.  

#### Answer 2 (score 136)
<strong>Analogy</strong>  

<strong>I explained MVC to my Dad like this:</strong>  

MVC (Model, View, Controller) is a pattern for organising code in an application to improve maintainability.   

Imagine a photographer with his camera in a studio. A customer asks him to take a photo of a box.  

The box is the <em>model</em>, the photographer is the <em>controller</em> and the camera is the <em>view</em>.  

Because the box does not <em>know</em> about the camera or the photographer, it is completely independent. This separation allows the photographer to walk around the box and point the camera at any angle to get the shot/view that he wants.  

Non-MVC architectures tend to be tightly integrated together. If the box, the controller  and the camera were one-and-the-same-object then, we would have to pull apart and then re-build both the box <em>and</em> the camera each time we wanted to get a new view. Also, taking the photo would always be like trying to take a selfie - and that's not always very easy.  

<hr>

<strong>Detailed Explanation</strong>  

It was only after reading the following maillist question/answer that I felt like I  understood MVC. Quote: <a href="https://mail.python.org/pipermail/python-list/2006-January/394968.html">https://mail.python.org/pipermail/python-list/2006-January/394968.html</a>  

<blockquote>
  bwaha wrote:  
  
  <blockquote>
    <p>The author refers to mvctree.py in wxPython as an example of MVC design.
    However I'm still too green so I find that particular example too complex
    and I'm not understanding the separation the author is recommending.</p>
  </blockquote>
  
  MVC is all about separation of concerns.  
  
  <p>The Model is responsible for managing the program's data (both private
  and client data). The View/Controller is responsible for providing the
  outside world with the means to interact with the program's client
  data.</p>
  
  <p>The Model provides an internal interface (API) to enable other parts
  of the program to interact with it. The View/Controller provides an
  external interface (GUI/CLI/web form/high-level IPC/etc.) to enable
  everything outwith the program to communicate with it.</p>
  
  <p>The Model is responsible for maintaining the integrity of the
  program's data, because if that gets corrupted then it's game over for
  everyone. The View/Controller is responsible for maintaining the
  integrity of the UI, making sure all text views are displaying
  up-to-date values, disabling menu items that don't apply to the
  current focus, etc.</p>
  
  <p>The Model contains no View/Controller code; no GUI widget classes, no
  code for laying out dialog boxes or receiving user input. The
  View/Controller contains no Model code; no code for validating URLs or
  performing SQL queries, and no original state either: any data held by
  widgets is for display purposes only, and merely a reflection of the
  true data stored in the Model.</p>
  
  <p>Now, here's the test of a true MVC design: the program should in
  essence be fully functional even without a View/Controller attached.
  OK, the outside world will have trouble interacting with it in that
  form, but as long as one knows the appropriate Model API incantations,
  the program will hold and manipulate data as normal.</p>
  
  <p>Why is this possible? Well, the simple answer is that it's all thanks
  to the low coupling between the Model and View/Controller layers.
  However, this isn't the full story. What's key to the whole MVC
  pattern is the <em>direction</em> in which those connection goes: ALL
  instructions flow <em>from</em> the View/Controller <em>to</em> the Model. The Model
  NEVER tells the View/Controller what to do.</p>
  
  <p>Why? Because in MVC, while the View/Controller is permitted to know a
  little about the Model (specifically, the Model's API), but the Model
  is not allowed to know anything whatsoever about the View/Controller.</p>
  
  Why? Because MVC is about creating a clear separation of concerns.  
  
  <p>Why? To help prevent program complexity spiralling out of control and
  burying you, the developer, under it. The bigger the program, the
  greater the number of components in that program. And the more
  connections exist between those components, the harder it is for
  developers to maintain/extend/replace individual components, or even
  just follow how the whole system works. Ask yourself this: when
  looking at a diagram of the program's structure, would you rather see
  a tree or a cat's cradle? The MVC pattern avoids the latter by
  disallowing circular connections: B can connect to A, but A cannot
  connect to B. In this case, A is the Model and B is the
  View/Controller.</p>
  
  <p>BTW, if you're sharp, you'll notice a problem with the 'one-way'
  restriction just described: how can the Model inform the
  View/Controller of changes in the Model's user data when the Model
  isn't even allowed to know that the View/Controller, never mind send
  messages to it? But don't worry: there is a solution to this, and it's
  rather neat even if it does seem a bit roundabout at first. We'll get
  back to that in a moment.</p>
  
  <p>In practical terms, then, a View/Controller object may, via the
  Model's API, 1. tell the Model to do things (execute commands), and 2.
  tell the Model to give it things (return data). The View/Controller
  layer
  <em>pushes instructions</em> to the Model layer and <em>pulls information</em> from the Model layer.</p>
  
  <p>And that's where your first MyCoolListControl example goes wrong,
  because the API for that class requires that information be <em>pushed</em>
  into it, so you're back to having a two-way coupling between layers,
  violating the MVC rules and dumping you right back into the cat's
  cradle architecture that you were [presumably] trying to avoid in the
  first place.</p>
  
  <p>Instead, the MyCoolListControl class should go with the flow, pulling
  the data it needs from the layer below, when it needs it. In the case
  of a list widget, that generally means asking how many values there
  are and then asking for each of those items in turn, because that's
  about the simplest and loosest way to do it and therefore keeps what
  coupling there is to a minimum. And if the widget wants, say, to
  present those values to the user in nice alphabetical order then
  that's its perogative; and its responsibility, of course.</p>
  
  <p>Now, one last conundrum, as I hinted at earlier: how do you keep the
  UI's display synchronised with the Model's state in an MVC-based
  system?</p>
  
  <p>Here's the problem: many View objects are stateful, e.g. a checkbox
  may be ticked or unticked, a text field may contain some editable
  text. However, MVC dictates that all user data be stored in the Model
  layer, so any data held by other layers for display purposes (the
  checkbox's state, the text field's current text) must therefore be a
  subsidiary copy of that primary Model data. But if the Model's state
  changes, the View's copy of that state will no longer be accurate and
  needs to be refreshed.</p>
  
  <p>But how? The MVC pattern prevents the Model pushing a fresh copy of
  that information into the View layer. Heck, it doesn't even allow the
  Model to send the View a message to say its state has changed.</p>
  
  <p>Well, almost. Okay, the Model layer isn't allowed to talk directly to
  other layers, since to do so would require it knows something about
  those layers, and MVC rules prevent that. However, if a tree falls in
  a forest and nobody's around to hear it, does it make a sound?</p>
  
  <p>The answer, you see, is to set up a notifications system, providing
  the Model layer with a place it can announce to no-one in particular
  that it has just done something interesting. Other layers can then
  post listeners with that notification system to listen for those
  announcements that they're actually interested in. The Model layer
  doesn't need to know anything about who's listening (or even if anyone
  is listening at all!); it just posts an announcement and then forgets
  about it. And if anyone hears that announcement and feels like doing
  something afterwards - like asking the Model for some new data so it
  can update its on-screen display - then great. The Model just lists
  what notifications it sends as part of its API definition; and what
  anyone else does with that knowledge is up to them.</p>
  
  <p>MVC is preserved, and everyone is happy. Your application framework
  may well provide a built-in notifications system, or you can write
  your own if not (see the 'observer pattern').</p>
  
  ...  
  
  <p>Anyway, hope that helps. Once you understand the motivations behind
  MVC, the reasons why things are done the way they are starts to make
  sense, even when - at first glance - they seem more complex than
  necessary.</p>
  
  Cheers,  
  
  has  
</blockquote>

#### Answer 3 (score 86)
<h5><strong>MVC is <em>mostly</em> a buzzword.</strong></h3>

It used to be considered a pattern, but its original 1979 definition has been dumbed-down, passed-on, misinterpreted, taken out-of-original-context. It's been ill-redefined to the point it starts resembling a religion, and while this certainly helps its cargo cultists defending it, <strong>its name doesn't associate anymore with a solid set of guidelines</strong>. As such, it cannot really be considered a pattern anymore.  

<p>MVC was never meant to describe web applications.<br>
Nor modern operating systems, nor languages.<br>
(some of whom actually made the 1979 definition redundant)</p>

It was made to. And it didn't work out.  

We now deal with an <strong>obscene web-mvc hybrid</strong> that, with its awful buzzword status, ill definition, and having <em>semi-illiterate-programmers</em> as a target demographic, makes a really bad publicity to software patterns in general.  



MVC, thus, became <em>separation of concerns</em> distilled for people who don't really want to think too much about it.  

<ul>
<li>The <strong>data</strong> model is handled  one way,</li>
<li>the <strong>view</strong> in another,</li>
<li>the rest is just named <strong><em>"controller"</em></strong> and left to the reader's discretion.</li>
</ul>



Web sites / web applications in the '90s did not really use to apply separation of concerns.  

<p>They were horrible botches of intermixed spaghetti code.<br>
UI changes, redesigns, and data rearrangements were incredibly hard, expensive, long, depressing, ill-fated.</p>

Web technologies like ASP, JSP and PHP make it <strong>too easy to intermix</strong> view concerns with data, and application concerns. Newcomers to the field usually emit inextricable code mudballs like in those old times.  

Thus, a growing number of people started repeating <em>"use MVC"</em> in endless loops on support forums. The number of people expanded to the point of including managers and marketers, (to some the term was already familiar, from those times in gui programming, in which the pattern made sense) and that became the behemoth of a buzzword we have to face now.  

<p>As it stands it's <em>common sense</em>, not <em>a methodology</em>.<br>
It's a <em>starting point</em>, not <em>a solution</em>.<br>
It's like telling people to <em>breathe</em> air, or <em>make crunches</em>, not <em>a cure for cancer</em>.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Can I use GPL software in a commercial application (score [215253](https://stackoverflow.com/q/47032) in 2018)

#### Question
I have 3 questions about the GPL here:  

<ol>
<li><p>If I use GPL software in my application, but don't modify or distribute it, do I have to release my application under the GPL?</p></li>
<li><p>What if I modify some software that my application uses. Then do I have to release my application under the GPL, or can I just supply the modified software under the GPLs terms.</p></li>
<li><p>And what if I use GPL software, but don't modify it, can I distribute it with my application?</p></li>
</ol>

My case in point is, I have a PHP framework which I use the GeSHi library to highlight some output.   

<ol>
<li><p>Because GeSHi is GPL, does my framework have to be GPL? </p></li>
<li><p>Can I modify GeSHi for particular use cases of my application if I supply the modifications back to the GeSHi maintainers?</p></li>
<li><p>Can I redistribute my framework with GeSHi?</p></li>
</ol>

#### Answer accepted (score 178)
<blockquote>
  <p>If I use GPL software in my
  application, but don't modify or
  distribute it, do I have to release my
  application under the GPL?</p>
</blockquote>

ANSWER: Your question is a little ambiguous. Two cases:  

(a) If you do not distribute YOUR APPLICATION, then the answer is No, because you did not distribute your application. For example if it was for internal use only in your company, then you have no obligation to do anything.  

(b) If you do distribute YOUR APPLICATION, and you used something GPL as part of your application (even if only linking at run-time to a library) - and even if you do not charge money - and even if you do not change that GPL s/w in any way - then you MUST make the source of YOUR APPLICATION available.  

Making source available does not mean download. IT might be that you must get a written request and you send a photocopy of a listing <em>(see comments: you can't actually send a listing. This was exaggeration to make a point)</em>. You are allowed to charge a "reasonable" handling / copying charge. But you can not escape the obligation to make your own source code available.  

<blockquote>
  <p>What if I modify some software that my
  application uses. Then do I have to
  release my application under the GPL,
  or can I just supply the modified
  software under the GPLs terms.</p>
</blockquote>

<p>ANSWER: See above. If you used GPL s/w, then you must make your source code available. This 
includes the modified GPL code.</p>

<blockquote>
  <p>And what if I use GPL software, but
  don't modify it, can I distribute it
  with my application?</p>
</blockquote>

ANSWER: See above. You can distribute it (the GPL code), provided you make your source available.  

<blockquote>
  <p>Because GeSHi is GPL, does my
  framework have to be GPL?</p>
</blockquote>

ANSWER: If you distribute your framework, then YES.  

<blockquote>
  <p>Can I modify GeSHi for particular use
  cases of my application if I supply
  the modifications back to the GeSHi
  maintainers?</p>
</blockquote>

ANSWER: You can if you want to. You don't have to. You could modify it, but when you distribute your application you are obliged to make your source available and also the source for the modifications you made to the library.  

<blockquote>
  <p>Can I redistribute my framework with
  GeSHi?</p>
</blockquote>

ANSWER: You can if you want to. If your application is not distributed with the GPL code and you make users download it separately to make use of it, then your case is a little bit more special and might provoke some argument, but the same principle will most likely ultimately apply: you must make your source available.  

If you want to avoid these problems then you need to use things with a different license or at the very least the LGPL which will allow run-time calling of libraries without the viral-spread of the GPL conditions back to your code.  

When in doubt you need legal advice. Any advice you get here (from me or anyone else)should be treated fairly carefully. Only a lawyer can give you proper legal advice.  

#### Answer 2 (score 12)
This very strongly seems to disagree if you are using it on a website, rather than re-distributing an executable.   

<em>You may copy, distribute and modify the software as long as you track changes/dates of in source files and keep modifications under GPL. You can distribute your application using a GPL library commercially, but you must also provide the source code. GPL v3 tries to close some loopholes in GPL v2.</em>  

Specifically  

<em>If you distribute this library in an executable, you must disclose your source code by providing it either alongside your distribution or list an accessible way (URL, physical copy) to obtain the source for 3 years. Does not apply if you serve through a web portal.</em>  

<a href="https://tldrlegal.com/license/gnu-general-public-license-v3-%28gpl-3%29">https://tldrlegal.com/license/gnu-general-public-license-v3-%28gpl-3%29</a>  

#### Answer 3 (score 2)
<strong>Disclaimer</strong>: I am not a lawyer and I haven't read either version of the GPL in a while, so this answer might be legally inaccurate.  

If you release/distribute software containing GPL'd components (such as statically linked libraries), your software must be covered by the GPL. (This is the impression given for version 2; version 3 may be different.)  

If you release/distribute software using LGPL'd libraries, your software doesn't need to be covered by the GPL, but the libraries must retain the LGPL.  

Modification of [L]GPL'd components <em>suggests</em> contribution back to the creator/maintainer. I'm not clear on how that affects your product's licensing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: What is the best way to include JavaScript file using script tag? (score [210278](https://stackoverflow.com/q/91242) in )

#### Question
I generally include JavaScript files using the script tag as below.  

```
<script type="text/javascript" src="somefile.js"></script>
```

I have seen some people using the language attribute as well.   

Now-a-days I find many people omitting the type attribute. I have started to get a feeling that if JavaScript is the default scripting language then even I should omit the type attribute. Would it be good to omit the type attribute? Would it cause any problems?  

#### Answer accepted (score 48)
Take a look at this as a reference (Book of Speed): <a href="http://www.bookofspeed.com/chapter3.html">http://www.bookofspeed.com/chapter3.html</a>  

Essentially the best way is to combine all your javascript into one file called something like all.min.js that is also minimized.  

Typically in HTML5 you would do something like:  

```
<script src="js/all.min.js"></script>
```

As you can see, <a href="http://dev.w3.org/html5/spec-author-view/the-script-element.html">you <strong>DO NOT</strong> need the type attribute in HTML5, but you do in other versions of HTML and XHTML</a>. The spec clarifies that if the content is other than "text/javascript" then you need to specify the type attribute, in HTML5.  

Some things to remember:  

<ul>
<li>Always <a href="http://labjs.com/">include it before the closing  tag</a>;</li>
<li>You should <a href="http://www.yuiblog.com/blog/2008/07/22/non-blocking-scripts/">load your scripts in a non-blocking pattern</a>.</li>
</ul>

Note:  

If you are going to specify another type other than `text/javascript` you would use one of the following:  

<ul>
<li>"application/ecmascript"</li>
<li>"application/javascript"</li>
<li>"application/x-ecmascript"</li>
<li>"application/x-javascript"</li>
<li>"text/ecmascript" "text/javascript"</li>
<li>"text/javascript1.0"</li>
<li>"text/javascript1.1"</li>
<li>"text/javascript1.2"</li>
<li>"text/javascript1.3"</li>
<li>"text/javascript1.4"</li>
<li>"text/javascript1.5"</li>
<li>"text/jscript"</li>
<li>"text/livescript"</li>
<li>"text/x-ecmascript"</li>
<li>"text/x-javascript"</li>
<li>"text/javascript;e4x=1"</li>
</ul>

The above list is from: <a href="http://dev.w3.org/html5/spec-author-view/the-script-element.html#scriptingLanguages">http://dev.w3.org/html5/spec-author-view/the-script-element.html#scriptingLanguages</a>  

Remember that you would not use the language attribute, only the type attribute.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Why is %s better than + for concatenation? (score [209495](https://stackoverflow.com/q/304445) in 2016)

#### Question
I understand that we should use `%s` to concatenate a string rather than `+` in Python.  

I could do any of:  

```
hello = "hello"
world = "world"

print hello + " " + world
print "%s %s" % (hello, world)
print "{} {}".format(hello, world)
print ' '.join([hello, world])
```

But why should I use anything other than the `+`? It's quicker to write concatenation with a simple `+`. Then if you look at the formatting string, you specify the types e.g. `%s` and `%d` and such. I understand it could be better to be explicit about the type.  

But then I read that using `+` for concatenation should be avoided even though it's easier to type. Is there a clear reason that strings should be concatenated in one of those other ways?  

#### Answer accepted (score 88)
<ol>
<li><p>Readability. The format string syntax is more readable, as it separates style from the data. Also, in Python, `%s` syntax will automatically coerce any non `str` types to `str`; while concatenation only works with `str`, and you can't concatenate `str` with `int`.</p></li>
<li><p>Performance. In Python `str` is immutable, so the left and right string have to be copied into the new string for every pair of concatenation. If you concatenate four strings of length 10, you will be copying (10+10) + ((10+10)+10) + (((10+10)+10)+10) = 90 characters, instead of just 40 characters. And things gets quadratically worse as the number and size of the string increases. Java optimizes this case some of the times by transforming the series of concatenation to use `StringBuilder`, but CPython doesn't.</p></li>
<li><p>For some use cases, the logging library provide an API that uses format string to create the log entry string lazily (`logging.info("blah: %s", 4)`). This is great for improved performance if the logging library decided that the current log entry will be discarded by a log filter, so it doesn't need to format the string.</p></li>
</ol>

#### Answer 2 (score 48)
Am I the only one who reads left to right?  

To me, using `%s` is like listening to German speakers, where I have to wait until the end of a very long sentence to hear what the verb is.  

Which of these is clearer at a quick glance?  

```
"your %s is in the %s" % (object, location)
```

or  

```
"your " + object + " is in the " + location  
```

#### Answer 3 (score 12)
An example clarifying readability argument:  

```
print 'id: ' + id + '; function: ' + function + '; method: ' + method + '; class: ' + class + ' -- total == ' + total

print 'id: %s; function: %s; method: %s; class: %s --total == %s' % \
   (id, function, method, class, total)
```

(Note that second example is not only more readable but also easier to edit, you can change the template on one line and list of variables on another)  

A separate issue is that %s code also converts to the string, otherwise you have to use str() call which is also less readable than a %s code.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: What's the difference between junior, middle, and senior developers? (score [209111](https://stackoverflow.com/q/136163) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://softwareengineering.stackexchange.com/questions/14914/whats-the-difference-between-entry-level-jr-sr-developers">Whats the difference between Entry Level/Jr/Sr developers?</a>  </p>
</blockquote>



There seems to be three common java programmer qualification levels:  

<ul>
<li>Junior</li>
<li>Middle</li>
<li>Senior</li>
</ul>

What makes a programmer  "junior", "middle", or "senior"? Does it mean the the programmer has a specific amount of certifications or job expertise? How do IT companies decide what title to give to a programmer?  

#### Answer 2 (score 32)
There will be as many answers to this question as there are programmers. But I judge them this way:  

<ul>
<li>A Junior developer will need near-constant help. Not only will they not know the business domain, but they may also struggle with the fundamentals of the language or the toolset. They don't know what they don't know, so without guidance, they will make frequent mistakes which, if not kept on top of, will derail the wider team.</li>
<li>A regular Developer has some experience under their belt. They will be independently productive and will be able to tackle most tasks on their own, or understand when they need to reach out for help.</li>
<li>A Senior Developer has even more experience and will be able to design solutions as well as completing tasks. However, they may need their proposed designs vetted before they start to implement, as they won't necessarily have an overall architectural vision. They will be able to mentor more junior members of the team.</li>
</ul>

But you should really head over to this <a href="https://softwareengineering.stackexchange.com/a/14972/6177">much better answer</a> to see what I ought to have written!  

#### Answer 3 (score 13)
You could tie it to the <a href="http://www.indiangeek.net/wp-content/uploads/Programmer%20competency%20matrix.htm">programmer's competency matrix</a> if you want to make it a "harder" metric. Titles are not set in stone; it's all HR speak. Convenient buzzwords to encapsulate characteristics that may not even be precisely defined if they are defined at all.  

To tie it to the PCM:  

Junior Developer: Rates at least an n^2 in most disciplines. Could rate n or log(n) in a few and can have a few 2^n and still be okay.  

Middle Developer: Majority n with a minority of n^2 and as few 2^n as possible. As many log(n)s as possible but will likely still be a minority.  

Senior Developer: Majority n with a strong minority or even slight majority in log(n) and as few n^2 and no 2^n.  

Legendary: Log(n) in everything possible with a few ns and nothing below that mark.  

Specialist: Log(n) in their specializations and experience appropriate otherwise.  

Obviously these would be "ideals" for each category. I doubt there are many that would fit the title who would truly measure fully to the standards.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Naming conventions: camelCase versus underscore_case ? what are your thoughts about it? (score [209041](https://stackoverflow.com/q/27264) in 2011)

#### Question
I've been using underscore_case for about 2 years and I recently switched to camelCase because of the new job (been using the later one for about 2 months and I still think underscore_case is better suited for large projects where there are alot of programmers involved, mainly because the code is easier to read).  

Now everybody at work uses camelCase because (so they say) the code looks more elegant .  

What are you're thoughts about camelCase or underscore_case  

p.s. please excuse my bad english  

<strong>Edit</strong>  

Some update first:   

<ul>
<li><p>platform used is PHP (but I'm not expecting strict PHP platform related answers , anybody can share their thoughts on which would be the best to use , that's why I came here in the first place)</p></li>
<li><p>I use camelCase just as everibody else in the team (just as most of you recomend)</p></li>
<li><p>we use Zend Framework which also recommends camelCase</p></li>
</ul>

Some examples (related to PHP) :  

<ul>
<li><p>Codeigniter framework recommends underscore_case , and honestly the code is easier to read .</p></li>
<li><p>ZF recomends camelCase and I'm not the only one who thinks ZF code is a tad harder to follow through.</p></li>
</ul>

So my question would be rephrased:  

<blockquote>
  Let's take a case where you have the platform Foo which doesn't recommend any naming conventions and it's the team leader's choice to pick one. You are that team leader, why would you pick camelCase or why underscore_case?   
</blockquote>

p.s. thanks everybody for the prompt answers so far  

#### Answer accepted (score 84)
I agree that it depends on the language you're using to some extent; code tends to look neater when your symbol names follow the same formatting regimen as the language's built-ins and stock libraries.  

But where there's a choice, I prefer underscores to camel case, for one simple reason: I find that style easier to read. Here's an example: which do you find more readable? This:  

```
aRatherLongSymbolName
```

or this:   

```
a_rather_long_symbol_name
```

I find the underscore version much easier to read. My brain can ignore the underscores much more easily than it can detect the lowercase/uppercase boundaries in camel case, especially where the boundaries are between glyphs that look similar to other glyphs of the opposite case, or numerals (`I/l`, `O/0`, `t/I`, etc). For example, this boolean variable stores a value indicating whether or not an Igloo has been built with proper planning permission (undoubtedly a common use case for us all):  

```
isIllicitIgloo
```

I find this version a <em>lot</em> easier to read:  

```
is_illicit_igloo
```

Perhaps even worse than a hard-to-read symbol name is an easy-to-misread symbol name. Good symbol names are self-documenting, which to me means that you should be able to read them and understand their meaning at a glance. (I'm sure we all read code print-outs in bed for pleasure, but occasionally we grok in haste, too.) I often find with camel case symbol names that it's easy to mis-read them and get the wrong impression of a symbol's semantics.  

#### Answer 2 (score 97)
I think you should use naming convention adopted by your platform. underscore_case will look weird in C# code, as camelCase in Ruby =)  

#### Answer 3 (score 20)
Based on a reply the reply of John Isaacks:  

<blockquote>
  "honestly the code is easier to read" Opinion or fact?  
</blockquote>

I decided to do some research, and found <a href="http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.158.9499">this paper</a>. What does science have to say on the subject?  

<ol>
<li>Camel casing has <strong>a larger probability of correctness</strong> than underscores. (odds are 51.5% higher)</li>
<li>On average, camel case took <strong>0.42 seconds longer</strong>, which is 13.5% longer.</li>
<li>Training has no statistically significant impact on how style influences correctness.</li>
<li>Those with <strong>more training were quicker</strong> on identifiers in the camel case style.</li>
<li>Training in one style, <strong>negatively impacts the find time</strong> for other styles.</li>
</ol>

In <a href="http://whathecode.wordpress.com/2011/02/10/camelcase-vs-underscores-scientific-showdown/">my blog post</a> on the subject I review the scientific paper, and make the following conclusion.  

Only the <strong>slowness of camel case</strong> <em>(2)</em> is really relevant for programming, dismissing the other points as irrelevant due to modern IDEs and a majority of camelCase users in the study. The discussion (along with a poll) can be found on the blog post.  

I'm curious how this article might change ones opinion. :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: What is the point of using DTO (Data Transfer Objects)? (score [208587](https://stackoverflow.com/q/171457) in 2012)

#### Question
What is the point of using <a href="https://en.wikipedia.org/wiki/Data_Transfer_Object">DTO</a> and is it an out dated concept? I use <a href="https://en.wikipedia.org/wiki/POJO">POJO</a>s in the view layer to transfer and persist data. Can these POJOs be considered as an alternative to DTOs?  

#### Answer 2 (score 115)
DTO is a pattern and it is implementation (POJO/POCO) independent. DTO says, since each call to any remote interface is expensive, response to each call should bring as much data as possible. So, if multiple requests are required to bring data for a particular task, data to be brought can be combined in a DTO so that only one request can bring all the required data. <a href="http://martinfowler.com/eaaCatalog/dataTransferObject.html">Catalog of Patterns of Enterprise Application Architecture</a> has more details.  

DTO's are a fundamental concept, not outdated.  

#### Answer 3 (score 59)
DTO as a concept (objects whose purpose is to collect data to be returned to the client by the server) is certainly not outdated.   

What <em>is</em> somewhat outdated is the notion of having DTOs that contain no logic at all, are used <em>only</em> for transmitting data and "mapped" from domain objects before transmission to the client, and there mapped to view models before passing them to the display layer. In simple applications, the domain objects can often be directly reused as DTOs and passed through directly to the display layer, so that there is only one unified data model. For more complex applications you don't want to expose the entire domain model to the client, so a mapping from domain models to DTOs is necessary. Having a separate view model that duplicates the data from the DTOs almost never makes sense.  

However, the reason why this notion is outdated rather than just plain wrong is that some (mainly older) frameworks/technologies require it, as their domain and view models are not POJOS and instead tied directly to the framework.   

Most notably, Entity Beans in J2EE prior to the EJB 3 standard were not POJOs and instead were proxy objects constructed by the app server - it was simply not possible to send them to the client, so you had no choice about haing a separate DTO layer - it was mandatory.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: What is the history of the use of "foo" and "bar" in source code examples? (score [206768](https://stackoverflow.com/q/69788) in 2012)

#### Question
Why do many code examples, especially tutorials, use the names "Foo" and "Bar" so often? It is almost a standard.  

For example:  

```
void foo(char* bar) {
  printf("%s", bar);
}
```

#### Answer 2 (score 65)
<em>Foo</em> and <em>bar</em> come from the US Army WWII acronym FUBAR, "F-ed Up Beyond All Recognition".  A whole family of these terms came into widespread use during the North African and Sicilian campaigns (1942-43).  Rick Atkinson's excellent <a href="http://www.liberationtrilogy.com/day_of_battle.htm" rel="nofollow noreferrer">Day of Battle: The War in Sicily and Italy, 1943-1944</a> gives a list of these.  For instance a JANFU is a "Joint Army Navy F Up", such as the incident on 11 July 1943 when the invasion fleet for <a href="http://en.wikipedia.org/wiki/Allied_invasion_of_Sicily" rel="nofollow noreferrer">Operation Husky</a> <a href="http://www.warwingsart.com/12thAirForce/316th.html" rel="nofollow noreferrer">shot down 23 Army Air Force C-47 transports</a> carrying paratroopers to reinforce the beachhead.   

Update: Wikipedia has a <a href="http://en.wikipedia.org/wiki/FUBAR" rel="nofollow noreferrer">list</a> of related acronyms that includes some the original WWII ones listed by Atkinson.  

Any programmer will understand the motivation for using <em>foo</em> and <em>bar</em> to name variables.  They certainly have been part of the C/UNIX culture from the start, and as @Walter Mitty points out, predated it.   

Update (10/5/2009): Here's Atkinson's description:  

<blockquote>
  Their pervasive "civilianness" made them wary of martial zeal.  "We were not romantics filled with cape-and-sword twaddle," wrote John Mason Brown, a Navy Reserve lieutenant headed to Sicily. "The last war was too near for that." Military life inflamed their ironic sensibilities and their skepticism.  A single crude acronym that captured the soldier's lowered expectations -- SNAFU, "situation normal, all fucked up" -- had expanded into a vocabulary of GI cynicism: SUSFU (situation unchanged, still fucked up); FUMTU (fucked up more than usual); JANFU (joint Army-Navy fuck-up); JAAFU (joint Anglo-American fuck-up); FUAFUP (fucked up and fucked up proper); and FUBAR (fucked up beyond all recognition) [Atkinson, p. 36].  
</blockquote>

Update (11/23/2011): @Hugo has a <a href="https://softwareengineering.stackexchange.com/q/80609/28473">fantastic list</a> of the non-military antecedents.  

#### Answer 3 (score 59)
I think it's the phonetic pronouncation of fubar.  

Which stands for:  

<ul>
<li>F*cked </li>
<li>Up </li>
<li>Beyond</li>
<li>All</li>
<li>Repair</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: What are the differences between class variables and instance variables in Java? (score [202841](https://stackoverflow.com/q/293478) in 2019)

#### Question
I'm very new to Java and want to understand the difference between class variables and instance variables.  

For example:  

```
class Bicycle { 
    static int cadence = 0; 
    int speed = 0; 
    int gear = 1; 
}
```

How are instance variables and class variables different from each other? Which variables here are class variables, and which are instance variables? How does this affect scope?  

#### Answer 2 (score 35)
They both are <em>member</em> variables, meaning that both are associated with a class. Now of course, there are differences between the two:  

<strong>Instance variables:</strong>  

These variables belong to the <em>instance of a class</em>, thus an object. And every instance of that class (object) has it's own copy of that variable. Changes made to the variable don't reflect in other instances of that class.  

```
public class Product {
    public int Barcode;
}
```

<strong>Class variables:</strong>  

These are also known as <em>static member variables</em> and there's only one copy of that variable that is shared with all instances of that class. If changes are made to that variable, all other instances will see the effect of the changes.  

```
public class Product {
    public static int Barcode;
}
```

<strong>Full example:</strong>  

```
// INSTANCE VARIABLE
public class Main {

    public static void main(String[] args) {

        Product prod1 = new Product();
        prod1.Barcode = 123456;

        Product prod2 = new Product();
        prod2.Barcode = 987654;

        System.out.println(prod1.Barcode);
        System.out.println(prod2.Barcode);
    }
}

public class Product {
    public int Barcode;
}
```

The output will be:  

<blockquote>
  123456  
  
  987654  
</blockquote>

Now, change the instance variable to a class variable by making it static:  

```
//CLASS VARIABLE
public class Main {

    public static void main(String[] args) {

        Product prod1 = new Product();
        prod1.setBarcode(123456);
        Product prod2 = new Product();
        prod2.setBarcode(987654);

        System.out.println(prod1.getBarcode());
        System.out.println(prod2.getBarcode());
    }
}

public class Product {

    public static int Barcode;

    public int getBarcode() {
        return Barcode;
    }

    public void setBarcode(int value){
        Barcode = value;
    }
}
```

I used non-static methods to get and set the value of `Barcode` to be able to call it from the object and not from the class. The output will be following:  

<blockquote>
  987654  
  
  987654  
</blockquote>

#### Answer 3 (score 6)
It is explained <a href="https://docs.oracle.com/javase/tutorial/java/javaOO/classvars.html" rel="noreferrer">here</a> (with an example `Bicycle` class with class variable `numberOfBicycles` and instance variables `cadence`, `speed`, `gear` &amp; `id`):  

<blockquote>
  Sometimes, you want to have variables that are common to all objects. This is accomplished with the `static` modifier. Fields that have the `static` modifier in their declaration are called static fields or class variables. They are associated with the class, rather than with any object. Every instance of the class shares a class variable, which is in one fixed location in memory. Any object can change the value of a class variable, but class variables can also be manipulated without creating an instance of the class.  
</blockquote>

A class variable (declared `static`) is a location common to all instances.   

In the example, `numberOfBicycles` is a class variable (since it is declared `static`). There is only one such variable (i.e. location) common to all instances and to the class. So if you modify `numberOfBicycles` in one method, other methods would see the new value (even for different `Bicycle` objects)  

In contrast `gear` &amp; `id` are <em>instance</em> variables (because their declaration has no `static` modifier). Every `Bicycle` object has its own one. If you modify `gear` for some `Bicycle` <em>a</em>, and if <em>b</em> is another instance, modifying `a.gear` has no effect on `b.gear`  

Each Java object is a distinct memory zone with some meta data (e.g. some reference to its class) and its own instance variables (perhaps inherited from a superclass). But the class variables are common to the class and shared by all instances.  

See also <a href="https://en.wikipedia.org/wiki/Object_%28computer_science%29" rel="noreferrer">Object (computer science)</a> &amp; <a href="https://en.wikipedia.org/wiki/Instance_variable" rel="noreferrer">Instance variable</a> wikipages.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: What is the Mars Curiosity Rover's software built in? (score [201533](https://stackoverflow.com/q/159637) in 2015)

#### Question
The <a href="http://www.nasa.gov/externalflash/mars/curiosity_news3.html">Mars Curiosity</a> rover has landed successfully, and one of the promo videos "7 minutes of terror" brags about there being 500,000 lines of code. It's a complicated problem, no doubt. But that is a lot of code, surely there was a pretty big programming effort behind it. Does anyone know anything about this project? I can only imagine it's some kind of embedded C.  

#### Answer accepted (score 506)
It's running <a href="http://compass.informatik.rwth-aachen.de/ws-slides/havelund.pdf" rel="noreferrer">2.5 million lines of C</a> on a <a href="https://en.wikipedia.org/wiki/RAD750" rel="noreferrer">RAD750 processor</a> manufactured by <a href="http://www.baesystems.com/home" rel="noreferrer">BAE</a>. The <a href="http://marsprogram.jpl.nasa.gov/msl/mission/rover/brains/" rel="noreferrer">JPL</a> has a bit more information but I do suspect many of the details are not publicized. It does appear that the testing scripts were written in Python.   

The underlying operating system is <a href="http://www.windriver.com/news/press/pr.html?ID=10901" rel="noreferrer">Wind River's</a> <a href="http://windriver.com/products/vxworks/" rel="noreferrer">VxWorks RTOS</a>. The <a href="http://windriver.com/products/product-overviews/PO_VE_6_9_Platform_0211.pdf" rel="noreferrer">RTOS</a> in question can be programmed in C, C++, Ada or Java. However, only C and C++ are standard to the OS, Ada and Java are supported by extensions. Wind River supplies a tremendous amount of detail as to the hows and whys of <a href="http://www.windriver.com/products/product-notes/PN_VE_6_9_Platform_0311.pdf" rel="noreferrer">VxWorks</a>.  

The underlying chipset is almost absurdly <a href="http://news.cnet.com/8301-11386_3-57491281-76/slow-but-rugged-curiositys-computer-was-built-for-mars/" rel="noreferrer">robust</a>. Its specs may not seem like much at first but it is allowed to have one and only one "bluescreen" every 15 years. Bear in mind, this is under bombardment from radiation that would kill a human many times over. In space, robustness wins out over speed. Of course, robustness like that comes at a cost. In this case, it's a cool $200,000 to $500,000.  

An Erlang programmer <a href="http://jlouisramblings.blogspot.com/2012/08/getting-25-megalines-of-code-to-behave.html" rel="noreferrer">talks</a> about the features of the computers and codebase on Curiosity.  

#### Answer 2 (score 175)
The code is based on that of MER (<a href="https://en.wikipedia.org/wiki/Spirit_(rover)" rel="nofollow noreferrer">Spirit</a> and <a href="https://en.wikipedia.org/wiki/Opportunity_(rover)" rel="nofollow noreferrer">Opportunity</a>), which were based off of their first lander, MPF (<a href="https://en.wikipedia.org/wiki/Sojourner_(rover)" rel="nofollow noreferrer">Sojourner</a>). It's 3.5 million lines of C (much of it autogenerated), running on an RA50 processor manufactured by <a href="https://en.wikipedia.org/wiki/BAE_Systems" rel="nofollow noreferrer">BAE</a> and the <a href="https://en.wikipedia.org/wiki/VxWorks" rel="nofollow noreferrer">VxWorks</a> operating system. Over a million lines were hand coded.  

The code is implemented as 150 separate modules, each performing a different function. Highly coupled modules are organized into components that abstract the modules they contain, and "specify either a specific function, activity, or behavior." These components are further organized into layers, and there are "no more than 10 top-level components."  

Source: Keynote talk by <a href="http://ai.jpl.nasa.gov/public/home/cichy/" rel="nofollow noreferrer">Benjamin Cichy</a> at <a href="http://flightsoftware.jhuapl.edu/fsw10.html" rel="nofollow noreferrer">2010 Workshop on Spacecraft Flight Software (FSW-10)</a>, <a href="http://win-dms-ms1.caltech.edu/five/Viewer/?peid=476727664f1b4d8390d3ab37670ababd" rel="nofollow noreferrer">slides, audio, and video</a> (starts with mission overview, architecture discussion at slide 80).  

<hr>

Someone on Hacker News asked "Not sure what means that most of the C code is auto generated. From what?"  

I'm not 100% sure, although there probably is a separate presentation in that year or a different year that describes their auto-generation process. I know that it was a popular topic in general at the FSW-11 conference.  

<a href="http://en.wikipedia.org/wiki/Simulink" rel="nofollow noreferrer">Simulink</a> is a possibility. It's a MATLAB component popular among mechanical engineers, and therefore most navigation &amp; control engineers, and allows them to 'code' and simulate things without thinking they're coding.  

Model-based programming is definitely a thing that the industry is slowly becoming aware of, but I don't know how well it's catching on at <a href="https://en.wikipedia.org/wiki/Jet_Propulsion_Laboratory" rel="nofollow noreferrer">JPL</a> or if they would have chosen to use it when the project started.  

The third and most likely possibility is for the communication code. With all space systems, you need to send commands to the flight software from the ground software, and receive telemetry from the flight software and process it with the ground software. Each command/telemetry packet is a heterogeneous data structure, and is is necessary that both sides are working from the exact same packet definition, and format the packet so it is correctly formatted on the one side, and parsed on the other side. This involves getting a whole lot of things right, including data type, size, and endianness (although the latter is usually a global thing; you could have multiple processors onboard with different endianness).  

But that's just the surface. You need lots of repetitive code on both sides to handle things like logging, command/telemetry validation, limit checking, and error handling. And then you can do more sophisticated things. Say you have a command to set a hardware register value, and that value is sent back in telemetry in a particular packet. You could generate ground software that monitors that telemetry point to ensure that when this register value is set, eventually the telemetry changes to reflect the change. And of course, some telemetry points are more important than others (e.g. the main bus current) and are designated to come down in multiple packets, which involves extra copying on the flight side and data de-duplication on the ground side.  

With all that, it's much easier (in my opinion) to write one collection of static text files (in XML, CSV, or some DSL/what-have-you), run them through a Perl/Python script, and presto! Code!  

I do not work at JPL, so I cannot provide any detail that is not in the video, with one exception. I've heard that the autogenerated C code is written by Python scripts, and the amount of autocoding in a project varies greatly depending on who the FSW lead is.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Is it a bad practice to store large files (10 MB) in a database? (score [199631](https://stackoverflow.com/q/150669) in 2012)

#### Question
I am currently creating a web application that allows users to store and share files, 1&nbsp;MB - 10&nbsp;MB in size.  

It seems to me that storing the files in a database will significantly slow down database access.  

Is this a valid concern? Is it better to store the files in the file system and save the file name and path in the database? Are there any best practices related to storing files when working with a database?  

I am working in PHP and MySQL for this project, but is the issue the same for most environments (<a href="http://en.wikipedia.org/wiki/Ruby_on_Rails">Ruby on Rails</a>, <a href="http://en.wikipedia.org/wiki/PHP">PHP</a>, <a href="http://en.wikipedia.org/wiki/.NET_Framework">.NET</a>) and databases (MySQL, <a href="http://en.wikipedia.org/wiki/PostgreSQL">PostgreSQL</a>).  

#### Answer accepted (score 139)
<strong>Reasons in favor of storing files in the database:</strong>  

<ol>
<li>ACID consistency including a rollback of an update which is complicated when the files are stored outside the database. This isn't to be glossed over lightly. Having the files and database in sync and able to participate in transactions can be very useful.</li>
<li>Files go with the database and cannot be orphaned from it.</li>
<li>Backups automatically include the file binaries.</li>
</ol>

<strong>Reason against storing files in the database:</strong>  

<ol>
<li>The size of a binary file differs amongst databases. On SQL Server, when not using the FILESTREAM object, for example, it is 2 GB. If users need to store files larger (like say a movie), you have to jump through hoops to make that magic happen.</li>
<li>Increases the size of the database. One general concept you should take to heart: <em>The level of knowledge required to maintain a database goes up in proportion to the size of the database.</em> I.e., large databases are more complicated to maintain than small databases. Storing the files in the database can make the database much larger. Even if say a daily full backup would have sufficed, with a larger database size, you may no longer be able to do that. You may have to consider putting the files on a different file group (if the database supports that), tweak the backups to separate the backup of the data from the backup of the files etc. None of these things are impossible to learn, but do add complexity to maintenance which means cost to the business. Larger databases also consume more memory as they try to stuff as much data into memory as possible.</li>
<li>Portability can be a concern if you use system specific features like SQL Server's `FILESTREAM` object and need to migrate to a different database system. </li>
<li>The code that writes the files to the database can be a problem. One company for whom I consulted not so many moons ago at some point connected a Microsoft Access frontend to their database server and used Access' ability to upload "anything" using its Ole Object control. Later they changed to use a different control which still relied on Ole. Much later someone changed the interface to store the raw binary. Extracting those Ole Object's was a new level of hell. When you store files on the file system, there isn't an additional layer involved to wrap/tweak/alter the source file. </li>
<li>It is more complicated to serve up the files to a website. In order to do it with binary columns, you have to write a handler to stream the file binary from the database. You can also do this even if you store file paths but you don't <em>have</em> to do this. Again, adding a handler is not impossible but adds complexity and is another point of failure.</li>
<li>You cannot take advantage of cloud storage. Suppose one day you want to store your files in an Amazon S3 bucket. If what you store in the database are file paths, you are afforded the ability to change those to paths at S3. As far as I'm aware, that's not possible in any scenario with any DBMS.</li>
</ol>

IMO, deeming the storage of files in the database or not as "bad" requires more information about the circumstances and requirements. Are the size and/or number of files always going to be small? Are there no plans to use cloud storage? Will the files be served up on a website or a binary executable like a Windows application?   

In general, my experience has found that storing paths is less expensive to the business even accounting for the lack of ACID and the possibility of orphans. However, that does not mean that the internet is not legion with stories of lack of ACID control going wrong with file storage but it does mean that in general that solution is easier to build, understand and maintain.  

#### Answer 2 (score 90)
In many cases, this is a bad idea. It will bloat the database files and cause several performance issues. If you stick the <a href="http://en.wikipedia.org/wiki/Binary_large_object">blobs</a> in a table with a large number of columns it's even worse.   

However! Some databases, like <a href="http://en.wikipedia.org/wiki/Microsoft_SQL_Server">SQL&nbsp;Server</a> have a FILESTREAM column type. In this case, your data is actually stored in a separate file on the database server and only an ID to the file is saved in the table. In this case I don't see much of a reason not to keep the data in the SQL server. The files are automatically included as part of the server backup, and the database and the files are never out of sync. The problem with Tony's suggestion of storing file names, is that the database and the filesystem can get out of sync. The database will claim a file exists when it's been deleted on disk. If a process is modifying the database and then crashes, the files and the database will not match (i.e. no <a href="http://en.wikipedia.org/wiki/ACID">ACID</a> with files outside of a database).   

#### Answer 3 (score 35)
Yes, it is a bad practice.   

Performance impact on the DB:  

<ul>
<li>if you do a `SELECT` with any BLOB column, you will <strong>always</strong> do a disk access, while without BLOBs you have a chance to get data straight from RAM (high throughput DB will be optimized to fit tables in RAM);</li>
<li>replication will be slow, replication delay high, as it will have to push BLOB to slaves. High replication delay will be causing all kinds of race conditions and other synchronization problems, unless you explicitly take that in account;</li>
<li>DB backups/restore will take lot longer;</li>
</ul>

Speed advantage &mdash; <strong>none</strong>! While some older filesystems would not handle well directories with millions of files, most modern have no problem at all and in fact use same kind of data structures as BDs (typically B-trees). For example ext4 (default Linux filesystem) uses <a href="http://en.wikipedia.org/wiki/Htree">Htree</a>.  

Conclusion: it will hinder your DB performance and will not improve file retrieval performance.  

Also, since you're talking about web application &mdash; serving static files directly from filesystem  using modern webserver, which can do <a href="http://www.kernel.org/doc/man-pages/online/pages/man2/sendfile.2.html">`sendfile()` syscall</a> is <strong>tremendous</strong> performance improvement. This is of course not possible if you're fetching files from DB. Consider for example <a href="http://nbonvin.wordpress.com/2011/03/14/apache-vs-nginx-vs-varnish-vs-gwan/">this benchmark</a>, showing <strong>Ngnix doing 25K req/s with 1000 concurrent</strong> connections on a low end laptop. That kind of load would fry any kind of DB.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: Game programming : C# or C++? (score [199419](https://stackoverflow.com/q/55040) in 2013)

#### Question
I've decided what I really want is to do game programming. So the question is, as a 18 years old who wants to learn self taught programming, what is the most suited programming language between C# and C++? (I should state that I don't care about Unix because I believe windows will be still the most used OS)   

I know the basics of C++, but none about C#. I know that C++ has more tutorials guides, dlls and stuff like that, while C# doesn't, but it's far easier to learn and to use for a single person to develop a program, but I've read even if the program is obfuscated it's easy to get the source of it.   

Well, I kinda want to focus on basic a lot first, I must say that I have a preference for C++ just because it feels more suitable to me, but I must consider that I work alone. So even if I like it, it may not be the best thing to do.   

I am really not sure of which one to go for, I've read a lot of threads on various websites and it looks like C# is becoming more popular than C++. But yeah, that said, I also specified I want to do game programming. So I need to know some better points than just "C# is easier because of .net memory handling while C++ isn't" because I couldn't just find it.  

#### Answer 2 (score 21)
I learn C++ by programming a game. That was a very enjoyable experience. I highly encourage you to do the same!  

However now I'm a C# programmer, I know I would have been a lot more productive if C# was available at the time.  

C# is the perfect choice for learning game development. It has everything you need to start from frameworks to books and the language is amazing.  

I've seen <a href="http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&amp;field-keywords=c%23+game+programming&amp;x=0&amp;y=0" rel="nofollow">dozens of books</a> specifically wrote on <strong>C# Game Programming</strong> and Microsoft is putting lot of efforts to improve his frameworks including <strong>DirectX</strong> and <strong>XNA</strong>.  

<strong>UPDATE</strong>: you may be interested by <a href="http://tirania.org/blog/archive/2011/Mar-07.html" rel="nofollow">this</a> as well. It's a recent blog post from <strong>Miguel de Icaza</strong>.  

<strong>UPDATE 2013-02-22</strong> Microsoft is planing to <a href="http://www.computerandvideogames.com/389018/microsoft-email-confirms-plan-to-cease-xna-support/" rel="nofollow">cease XNA support</a>.  

#### Answer 3 (score 12)
<p>Most game companies use C++, maybe with python scripts or other languages running in the background. Moreso because the bindings for OpenGL and DirectX are aimed at C++ (altho Im pretty sure you can do just as much Direct3d stuff in C#)
but ya for game programming, C++ is the MAIN language.</p>

Im going to give you a fair warning though (and don't let this deter you) but 3D graphics can get extremely complicated. The new Direct3D has made it a good bit easier than it used to be, but It still is a good bit of math (that can get pretty confusing) and just the libraries themselves can be confusing.  

I'd start with something very simple first. for 2d stuff SDL (Simple Directmedia Layer) is alot easier to use (for something like a top down game) once you get into 3D I PERSONALLY think OpenGL is easier to learn (but this is all opinion). MS has some nice Tutorials/Samples in their DirectX SDK documentation, so it's worth taking a look at. The Nehe tutorials although a bit outdated are still nice.  

but ya to answer your question, they are all done in C++ typically.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: What are the drawbacks of Python? (score [199011](https://stackoverflow.com/q/15468) in 2012)

#### Question
Python seems all the rage these days, and not undeservingly - for it is truly a language with which one almost enjoys being given a new problem to solve. But, as a <em>wise man</em> once said (calling him a <em>wise man</em> only because I've no idea as to who actually said it; not sure whether he was that wise at all), to really know a language one does not only know its syntax, design, etc., advantages but also its drawbacks. No language is perfect, some are just better than others.  

So, what would be in your opinion, objective drawbacks of Python.  

<em>Note: I'm not asking for a language comparison here (i.e. C# is better than Python because ... yadda yadda yadda) - more of an objective (to some level) opinion which language features are badly designed, whether, what are maybe some you're missing in it and so on. If must use another language as a comparison, but only to illustrate a point which would be hard to elaborate on otherwise (i.e. for ease of understanding)</em>  

#### Answer 2 (score 109)
I use Python somewhat regularly, and overall I consider it to be a very good language.  Nonetheless, no language is perfect.  Here are the drawbacks in order of importance to me personally:  

<ol>
<li><p>It's slow.  I mean really, really slow.  A lot of times this doesn't matter, but it definitely means you'll need another language for those performance-critical bits.</p></li>
<li><p>Nested functions kind of suck in that you can't modify variables in the outer scope.  <em>Edit:</em>  I still use Python 2 due to library support, and this design flaw irritates the heck out of me, but apparently it's fixed in Python 3 due to the <a href="http://docs.python.org/py3k/reference/simple_stmts.html#the-nonlocal-statement">nonlocal</a> statement.  Can't wait for the libs I use to be ported so this flaw can be sent to the ash heap of history for good.</p></li>
<li><p>It's missing a few features that can be useful to library/generic code and IMHO are simplicity taken to unhealthy extremes.  The most important ones I can think of are user-defined value types (I'm guessing these can be created with metaclass magic, but I've never tried), and ref function parameter.</p></li>
<li><p>It's far from the metal.  Need to write threading primitives or kernel code or something?  Good luck.</p></li>
<li><p>While I don't mind the lack of ability to catch <em>semantic</em> errors upfront as a tradeoff for the dynamism that Python offers, I wish there were a way to catch syntactic errors and silly things like mistyping variable names without having to actually run the code.</p></li>
<li><p>The documentation isn't as good as languages like PHP and Java that have strong corporate backings.</p></li>
</ol>

#### Answer 3 (score 66)
I hate that Python can’t distinguish between declaration and usage of a variable. You don’t need static typing to make that happen. It would just be nice to have a way to say “this is a variable that I deliberately declare, and I <em>intend</em> to introduce a new name, this is not a typo”.  

Furthermore, I usually use Python variables in a write-once style, that is, I treat variables as being immutable and don’t modify them after their first assignment. Thanks to features such as list comprehension, this is actually incredibly easy and makes the code flow more easy to follow.  

However, I can’t document that fact. Nothing in Python prevents me form overwriting or reusing variables.  

In summary, I’d like to have two keywords in the language: `var` and `let`. If I write to a variable not declared by either of those, Python should raise an error. Furthermore, `let` declares variables as read-only, while `var` variables are “normal”.  

Consider this example:  

```
x = 42    # Error: Variable `x` undeclared

var x = 1 # OK: Declares `x` and assigns a value.
x = 42    # OK: `x` is declared and mutable.

var x = 2 # Error: Redeclaration of existing variable `x`

let y     # Error: Declaration of read-only variable `y` without value
let y = 5 # OK: Declares `y` as read-only and assigns a value.

y = 23    # Error: Variable `y` is read-only
```

Notice that the types are still implicit (but `let` variables are for all intents and purposes statically typed since they cannot be rebound to a new value, while `var` variables may still be dynamically typed).  

Finally, all method arguments should automatically be `let`, i.e. they should be read-only. There’s in general no good reason to modify a parameter, except for the following idiom:  

```
def foo(bar = None):
    if bar == None: bar = [1, 2, 3]
```

This could be replaced by a slightly different idiom:  

```
def foo(bar = None):
    let mybar = bar or [1, 2, 3]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Why is 80 characters the 'standard' limit for code width? (score [198726](https://stackoverflow.com/q/148677) in 2012)

#### Question
Why is 80 characters the "standard" limit for code width? Why 80 and not 79, 81 or 100? What is the origin of this particular value?   

#### Answer accepted (score 734)
You can thank the IBM <a href="http://en.wikipedia.org/wiki/Punched_card" title="Wikipedia article about punched card">punch card</a> for this limit - it had 80 columns:  

<img src="https://i.stack.imgur.com/XvPKy.jpg" alt="IBM punch card">  

#### Answer 2 (score 250)
As <a href="https://softwareengineering.stackexchange.com/a/148678/22493">oded</a> mentioned, this common coding standard is a result of the IBM's 1928 <a href="http://en.wikipedia.org/wiki/Punched_card#IBM_80_column_punched_card_formats_and_character_codes" rel="noreferrer">80 column punched card format</a>, since many coding standards date back to a time when programs were written on punch cards, one card/line at a time, and even the transition to wider screens didn't alter the fact that code gets harder to read the wider it becomes.  

From the wikipedia page on <a href="http://en.wikipedia.org/wiki/Punched_card#Cultural_impact" rel="noreferrer">punched card</a>s:  

<blockquote>
  <h5>Cultural Impact</h3>
  
  <ul>
  <li>A legacy of the 80 column punched card format is that a display of 80 characters per row was a common choice in the design of character-based terminals. As of November 2011 some character interface defaults, such as the command prompt window's width in Microsoft Windows, remain set at 80 columns and some file formats, such as FITS, still use 80-character card images.</li>
  </ul>
</blockquote>

Now the question is, why did IBM chose 80 column cards in 1928, when <a href="http://en.wikipedia.org/wiki/Herman_Hollerith" rel="noreferrer">Herman Hollerith</a> had previously used <a href="http://en.wikipedia.org/wiki/Punched_card#Hollerith.27s_punched_card_formats" rel="noreferrer">24 and 45 column cards</a>?  

Although I can't find a definitive answer, I suspect that the choice was based on the typical number of <a href="http://en.wikipedia.org/wiki/Characters_per_line#History" rel="noreferrer">characters per line</a> of typewriters of the time.  

Most of the <a href="http://www.sciencemuseum.org.uk/onlinestuff/stories/typewriters.aspx" rel="noreferrer">historical typewriters</a> I've seen had a <a href="http://en.wikipedia.org/wiki/Platen" rel="noreferrer">platen</a> width of around 9 inches, which corresponds with the standardisation of paper sizes to around 8"-8.5" wide (see <a href="http://web.archive.org/web/20110927055537/http://www.afandpa.org/paper.aspx?id=511" rel="noreferrer">Why is the standard paper size in the U.S. 8 ½" x 11"?</a> and the <a href="http://en.wikipedia.org/wiki/ISO_216#History" rel="noreferrer">History of ISO216 <em>A series</em> paper standard</a>).  

Add a typical typewriter pitch of 10-12 characters per inch and that would lead to documents with widths of between 72 and 90 characters, depending on the size of the margins.  

As such, 80 characters per line would have represented a good compromise between hole pitch (small rectangular vs. larger round holes) and line length, while maintaining the same card size.  

<hr>

<sup>Incidentally, not everywhere specifies an 80 character line width in their coding standards. Where I work has a 132 character limit, which corresponds to the width of typical <em>wide</em> <a href="http://en.wikipedia.org/wiki/Line_printer" rel="noreferrer">line printers</a> of yore, a 12pt landscape A4 printout and the typical line width remaining in an editor window of Eclipse (maximised on a 1920x1200 screen) after Package Explorer and Outline views are taken into account.</sup>  

<sup>Even so, I still prefer 80 character wide code as it it makes it easier to compare three revisions of a file side-by-side without either scrolling sideways (always bad) or wrapping lines (which destroys code formatting). With 80 character wide code, you only need a 240 character wide screen (1920 pixels at 8 pixels per character) to see a full <a href="http://en.wikipedia.org/wiki/Merge_%28revision_control%29#Three-way_merge" rel="noreferrer">three-way-merge</a> (common ancestor, local branch and remote branch) comfortably on one screen.</sup>  

#### Answer 3 (score 59)
I'd say that's also because old terminals were (mostly) 80x24 characters in size: <a href="http://news.ycombinator.com/item?id=98177">Back in the days of 80x24 terminals...</a>  

EDIT:  

To answer more precisely and more thoroughly to the question, 80 characters is the current "universally accepted" limit to code width inside editors because 80x24 and 80x25 formats were the most common screen modes in early I/O terminals and personal computers (<a href="http://en.wikipedia.org/wiki/VT52">VT52</a> - thanks to Sandman4).  

This limit is still valid and somehow important IMHO for two main reasons: the default geometry that many Linux distros assign to newly spawned terminal windows is still 80x24 and many people use them <em>as-is</em>, without resizing. Moreover, kernel, real-time and embedded programmers often work in a "headless" environment without any window manager. Again, the default screen resolution is often 80x24 (or 80x25), and, in these situations, it may even be difficult to change this default setting.  

So if you are a kernel, real-time or embedded programmer you should force yourself to respect this limit, just to be a little more "friendly" towards any programmer that should read your code.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Is Perl still a useful, viable language? (score [198452](https://stackoverflow.com/q/115851) in 2012)

#### Question
I know it may have been asked before, but here goes nothing...  

Is Perl still something that would be considered useful? If someone was a new programmer (either completely new to programming or just a few month/years of experience) would Perl be something to be considered worthwhile to learn?  

Is Perl still used with frequency? Is it still popular?  

Or is Perl dying out compared to languages like Python, Ruby, PHP, ASP.NET, etc.?  

Basically it boils down to this:  

<ul>
<li>Is it still used/is it still used frequently? If yes, is it dying? If no, will it make a come back?</li>
<li>Is it something that would be worth learning?</li>
<li>How does it compare in demand to languages like Python in both popularity and usability/viability? Could languages like Python or Ruby be considered replacements for Perl?</li>
</ul>

Also, will newer versions of Perl really bring a large improvement to the Perl community, and perhaps bring Perl back to centerstage compared to other languages?  

EDIT:  

Okay, I suppose here's a better, reworded question:  

Is Perl still growing, or is it "dying"? Is it still a language worth learning and using? What projects does it really "shine" in compared to other languages? What makes Perl a language to choose? Essentially: is Perl growing obsolete compared to other languages, and if so, do you expect that to change, or to continue?  

And thank you to everyone who has answered so far, the discussion has been really interesting!  

#### Answer accepted (score 60)
First of all, it's always better to <strong>disambiguate</strong>.  

<blockquote>
  <p>Businesses talk about <strong>Perl 5</strong> when talking Perl, but on a far-far
  land, beyond <em>deep-thinking island</em>, the <em>design-by-committee</em> tribe is
  still cooking a hefty slab of <strong>Perl 6</strong> (and it's almost ready, with an
  engine written in Haskell and powered by <em>the tears of the gods</em>)</p>
</blockquote>

Ok, that said, what is <strong>Perl 5</strong> used for, today?  

<ul>
<li><p><strong>legacy web systems / intrawebs</strong> - some just won't die</p></li>
<li><p><strong>data mining / statistical analysis</strong> - the perl regex engine, even if <strong><em>slightly outdated</em></strong>, (`PCRE`, a spinned off library, <em>tops it up</em> in any possibile way and it's the default `PHP` engine) is still good for simple analysis</p></li>
<li><p><strong>UNIX system administration</strong> - Perl shall always be installed on UNIX.<br>
You can count on it being readily available even on Mac OS X.  </p></li>
<li><p><strong>network prototyping</strong> - many core network experts learned Perl when it was all the 
rage; and they still do their <em>proofs-of-concept</em> with it.</p></li>
<li><p><strong>security</strong> - many security experts, too, need <em>fast prototyping</em>. (and fast automated fixes) Perl can, and does, cover for that.</p></li>
</ul>

<p>The extensive <strong>CPAN</strong> collection is <strong>very handy</strong>, when dealing with prototypes.<br>
(Batteries may not be included, <em>but they're still right there, on the shelf</em>) </p>

Remember <strong>drawbacks</strong>, though:  

<ul>
<li><strong>Object support in Perl <em>sucks hard</em></strong>, you bless references and do unholy stuff in the name of objects, then wonder why you took all the trouble in the first place.</li>
<li>Reading other people's Perl is more than a craft, <strong>it's science</strong>, and a <strong>painful</strong> one, too.</li>
<li>Perl is nifty, it makes you think nifty, it makes you feel nifty, you become a <strong>programming rockstar</strong>. Now, think about getting up, and going to work in a <strong>office full of rockstars</strong>: it's a <em>"boat that rocks"</em> hard. Expect wild fluctuations.</li>
</ul>

#### Answer 2 (score 23)
In my opinion, after working with Perl again after a few years of nearly not using it, it is better than ever. Perl 5 has a lot of awesomeness in CPAN, even OO can be done right now. (Have a look at <em><a href="http://modernperlbooks.com/books/modern_perl/" rel="nofollow">Modern Perl</a></em>)  

Perl 5 is far from dead. Just have a look at some Perl websites and CPAN and on the horizon there is a whole new language - Perl 6.  

There are many ressources on the web, blogs and presentations about why it is not bad and why it has a bad reputation it doesn't deserve - just have look at those to get an understanding.  

#### Answer 3 (score 22)
The main thing Perl still has going for it is <a href="http://en.wikipedia.org/wiki/CPAN">CPAN</a> - there are so many pre-written modules that it's very easy to find something you need.  

That said, I would not learn Perl. Perl is a great language for people who know it already (like me), but <a href="http://en.wikipedia.org/wiki/Python_%28programming_language%29">Python</a> seems to be (from my outsider's perspective) a better language for doing the sort of quick and dirty file and text parsing stuff that Perl used to be the "go-to" language for.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: How do you unit test private methods? (score [195764](https://stackoverflow.com/q/100959) in )

#### Question
I am working on a java project. I am new to  unit testing. What is the best way to unit test private methods in java classes?  

#### Answer accepted (score 240)
You generally don't unit test private methods directly. Since they are private, consider them an implementation detail. Nobody is ever going to call one of them and expect it to work a particular way.   

You should instead test your public interface. If the methods that call your private methods are working as you expect, you then assume by extension that your private methods are working correctly.  

#### Answer 2 (score 118)
In general, I would avoid it. If your private method is so complex that it needs a separate unit test, it often means that it deserved its own class. This may encourage you to write it in a way which is reusable. You should then test the new class and call the public interface of it in your old class.  

On the other hand, sometimes factoring out the implementation details into separate classes leads to classes with complex interfaces, lots of data passing between the old and new class, or to a design which may look good from the OOP point of view, but does not match the intuitions coming from the problem domain (e.g. splitting a pricing model into two pieces just to avoid testing private methods is not very intuitive and may lead to problems later on when maintaining/extending the code). You don't want to have "twin classes" which are always changed together.  

When faced with a choice between encapsulation and testability, I'd rather go for the second. It's more important to have the correct code (i.e. produce the correct output) than a nice OOP design which doesn't work correctly, because it wasn't tested adequately. In Java, you can simply give the method "default" access and put the unit test in the same package. Unit tests are simply part of the package you're developing, and it's OK to have a dependency between the tests and the code which is being tested. It means that when you change the implementation, you may need to change your tests, but that's OK -- each change of the implementation requires re-testing the code, and if the tests need to be modified to do that, then you just do it.  

In general, a class may be offering more than one interface. There is an interface for the users, and an interface for the maintainers. The second one can expose more to ensure that the code is adequately tested. It doesn't have to be a unit test on a private method -- it could be, for example, logging. Logging also "breaks encapsulation", but we still do it, because it's so useful.  

#### Answer 3 (score 31)
Testing of private methods would depend on their complexity; some one line private methods wouldn't really warrant the extra effort of testing (this can also be said of public methods), but some private methods can be just as complex as public methods, and difficult to test through the public interface.  

My preferred technique is to make the private method package private, which will allow access to a unit test in the same package but it will still be encapsulated from all other code. This will give the advantage of testing the private method logic directly instead of having to rely on a public method test to cover all parts of (possibly) complex logic.   

If this is paired with the @VisibleForTesting annotation in the Google Guava library, you are clearly marking this package private method as visible for testing only and as such, it shouldn't be called by any other classes.  

Opponents of this technique argue that this will break encapsulation and open private methods to code in the same package. While I agree that this breaks encapsulation and does open private code to other classes, I argue that testing complex logic is more important than <em>strict</em> encapsulation and not using package private methods which are <em>clearly marked</em> as visible for testing only must be the responsibility of the developers using and changing the code base.  

Private method before testing:  

```
private int add(int a, int b){
    return a + b;
}
```

Package private method ready for testing:  

```
@VisibleForTesting
int add(int a, int b){
    return a + b;
}
```

Note: Putting tests in the same package is not equivalent to putting them in the same physical folder. Separating your main code and test code into separate physical folder structures is good practice in general but this technique will work as long as the classes are defined as in the same package.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: 'import module' vs. 'from module import function' (score [194189](https://stackoverflow.com/q/187403) in 2013)

#### Question
I have always been using this method:  

```
from sys import argv
```

and use `argv` with just <strong>argv</strong>. But there is a convention of using this:  

```
import sys
```

and using the argv by `sys.argv`  

The second method makes the code self documented and I <em>(really)</em> adhere to it. But the reason I prefer first method is it is fast because we are importing only the function that is needed rather than import the whole module (which contains more useless functions which python will waste time importing them). Note that I need just argv and all other functions from sys are useless to me.  

So my questions are. Does the first method really makes the script fast? Which method is preferred most? Why?  

#### Answer accepted (score 177)
Importing the module doesn't waste <em>anything</em>; the module is always <em>fully</em> imported (into the `sys.modules` mapping), so wether you use `import sys` or `from sys import argv` makes no odds.  

The only difference between the two statements is what name is bound; `import sys` binds the name `sys` to the module (so `sys` -> `sys.modules['sys']`), while `from sys import argv` binds a different name, `argv`, pointing straight at the attribute contained inside of the module (so `argv` -> `sys.modules['sys'].argv`). The rest of the `sys` module is still there, whether you use anything else from the module or not.  

There is also no performance difference between the two approaches. Yes, `sys.argv` has to look up two things; it has to look up `sys` in your global namespace (finds the module), then look up the attribute `argv`. And yes, by using `from sys import argv` you can skip the attribute lookup, since you already have a direct reference to the attribute. But the `import` statement still has to do that work, it looks up the same attribute when importing, and you'll only ever need to use `argv` <em>once</em>. If you had to use `argv` thousands of times in a loop it could perhaps make a difference, but in this specific case it really does not.  

The choice between one or the other then, should be based on <em>coding style</em> instead.  

In a <em>large</em> module, I'd certainly use `import sys`; code documentation matters, and using `sys.argv` somewhere in a large module makes it much clearer what you are referring to than just `argv` ever would.  

If the only place you use `argv` is in a `'__main__'` block to call a `main()` function, by all means use `from sys import argv` if you feel happier about that:  

```
if __name__ == '__main__':
    from sys import argv
    main(argv)
```

I'd still use `import sys` there myself. All things being equal (and they are, exactly, in terms of performance <em>and</em> number of characters used to write it), that is just easier on the eye for me.  

If you are importing something <em>else</em> altogether, then perhaps performance comes into play. But only if you use a specific name in a module <em>many times over</em>, in a critical loop for example. But then creating a local name (within a function) is going to be faster still:  

```
 import somemodule

 def somefunction():
      localname = somemodule.somefunctionorother
      while test:
          # huge, critical loop
          foo = localname(bar)
```

#### Answer 2 (score 43)
There are two reasons in favor of using `import module` rather than `from module import function`.  

First is the namespace. Importing a function into the global namespace risks name collisions.  

Second isn't that relevant to standard modules, but significant for you own modules,  especially during development. It's the option to `reload()` a module. Consider this:  

```
from module import func
...
reload(module)
# func still points to the old code
```

On the other hand  

```
import module
...
reload(module)
# module.func points to the new code
```

As for speed...  

<blockquote>
  <p>we are importing only the function that is needed rather than import
  the whole module (which contains more useless functions which python
  will waste time importing them)</p>
</blockquote>

Whether you import a module or import a function from a module, Python will parse the whole module. Either way the module is imported. "Importing a function" is nothing more than binding the function to a name. In fact `import module` is less work for interpreter than `from module import func`.  

#### Answer 3 (score 19)
In my opinion using regular `import` improves readability. When reviewing Python code I like seeing where the given function or class comes from right where it is used. It saves me from scrolling to the top of the module to get that info.  

As for the long module names I just use the `as` keyword and give them short aliases:  



```
import collections as col
import foomodule as foo
import twisted.internet.protocol as twip

my_dict = col.defaultdict()
foo.FooBar()
twip_fac = twip.Factory()
```

As an exception I always use the `from module import something` notation when I deal with the `__future__` module. You just can't do it another way when you want all strings to be unicode by default in Python 2, e.g.  



```
from __future__ import unicode_literals
from __future__ import print_function
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Do people in non-English-speaking countries code in English? (score [193191](https://stackoverflow.com/q/1483) in 2015)

#### Question
I've heard it said (by coworkers) that everyone "codes in English" regardless of where they're from. I find that difficult to believe, however I wouldn't be surprised if, for most programming languages, the supported character set is relatively narrow.  

Have you ever worked in a country where English is not the primary language?  

If so, what did their code look like?  

#### Answer 2 (score 88)
I'm from Canada, but live in the States now.  

It took me a while to get used to writing boolean variables with an "Is" prefix, instead of the "Eh" suffix that Canadians use when programming.  

For example:  

```
MyObj.IsVisible

MyObj.VisibleEh
```

#### Answer 3 (score 52)
I'm Italian and always use English, for names and comments. But many other Italian programmers use Italian language, or more often a strange English-Italian mix (something like `IsUtenteCopy`).  

A real life code sample:  

```
// Trovo la foto collegata al verbale
tblVerbali rsVerbale;
hr = rsVerbale.OpenByID(GetDBConn(), m_idVerbale);
if( FAILED(hr) )
    throw CErrorHR(hr);
hr = rsVerbale.MoveFirst();
if( S_OK != hr )
    throw CError(_T("Record del verbale non trovato."));
```

<hr>

By the way, the Visual Studio MFC wizard creates a skeleton application with localized comments:  

```
BOOL CMainFrame::PreCreateWindow(CREATESTRUCT& cs)
{
    if( !CMDIFrameWndEx::PreCreateWindow(cs) )
        return FALSE;
    // TODO: modificare la classe o gli stili Window modificando 
    //  la struttura CREATESTRUCT

    return TRUE;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Is there any reason to use C++ instead of C, Perl, Python, etc.? (score [192282](https://stackoverflow.com/q/29109) in 2015)

#### Question
As a Linux (server side) developer, I don't know where and why should I use C++.  

When I'm going for performance, the first and last choice is C.  

When "performance" isn't the main issue, programming languages like Perl and Python would be good choices.  

Almost all open source applications I know in this area have been written in C, Perl, Python, Bash script, <a href="http://en.wikipedia.org/wiki/AWK">AWK</a> or even PHP, but no one uses C++.  

I'm not discussing other areas like GUI or web applications, I'm just talking about Linux, CLI and daemons.  

Is there any satisfactory reason to use C++?  

#### Answer accepted (score 308)
<blockquote>
  When I'm going to performance, the first and last choice is C.  
</blockquote>

And that’s where you should back up. Now, I cannot, <em>at all</em>, speak for server development. Perhaps there is indeed no compelling reason to prefer C++ over the alternatives.  

But generally speaking, the reason to use C++ rather than other languages is indeed performance. The reason for that is that C++ offers a means of abstraction that has, unlike <em>all</em> other languages that I know, <em>no</em> performance overhead at runtime.  

This allows writing very efficient code that <em>still</em> has a very high abstraction level.  

Consider the usual abstractions: virtual functions, function pointers, and the PIMPL idiom. All of these rely on indirection that is at runtime resolved by pointer arithmetic. In other words, it incurs a performance cost (however small that may be).  

C++, on the other hand, offers an indirection mechanism that incurs <em>no</em> (performance) cost: templates. (This advantage is paid for with a (sometimes hugely) increased compile time.)  

Consider the example of a generic sort function.  

In C, the function `qsort` takes a function pointer that implements the logic by which elements are ordered relative to one another. Java’s `Arrays.sort` function comes in several variants; one of them sorts arbitrary objects and requires a `Comparator` object be passed to it that works much like the function pointer in C’s `qsort`. But there are several more overloads for the “native” Java types. And each of them has an own copy of the `sort` method – a horrible code duplication.  

Java illustrates a general dichotomy here: <strong>either you have code duplication or you incur a runtime overhead.</strong>  

In C++, the `sort` function works much like `qsort` in C, with one small but fundamental difference: the comparator that is passed into the function is a <em>template</em> parameter. That means that its call can be <em>inlined</em>. No indirection is necessary to compare two objects. In a tight loop (as is the case here) this can actually make a substantial difference.  

Not surprisingly, the C++ `sort` function outperforms C’s `sort` even if the underlying algorithm is the same. This is especially noticeable when the actual comparison logic is cheap.  

Now, I am <em>not</em> saying that C++ is a priori more efficient than C (or other languages), nor that it a priori offers a higher abstraction. What it does offer is an abstraction that is very high and incredibly cheap at the same time so that you often don’t need to choose between efficient and reusable code.  

#### Answer 2 (score 166)
I see way too many C programmers that hate C++. It took me quite some time (years) to slowly understand what is good and what is bad about it. I think the best way to phrase it is this:  

Less code, no run-time overhead, more safety.  

The less code we write, the better. This quickly becomes clear in all engineers that strive for excellence. You fix a bug in one place, not many - you express an algorithm once, and re-use it in many places, etc. Greeks even have a saying, traced back to the ancient Spartans: "to say something in less words, means that you are wise about it". And the fact of the matter, is that <em>when used correctly</em>, C++ allows you to express yourself in far less code than C, without costing runtime speed, while being more safe (i.e. catching more errors at compile-time) than C is.  

Here's a simplified example from my <a href="https://www.thanassis.space/renderer.html">renderer</a>: When interpolating pixel values across a triangle's scanline. I have to start from an X coordinate x1, and reach an X coordinate x2 (from the left to the right side of a triangle). And across each step, across each pixel I pass over, I have to interpolate values.  

When I interpolate the ambient light that reaches the pixel:  

```
  typedef struct tagPixelDataAmbient {
      int x;
      float ambientLight;
  } PixelDataAmbient;

  ...
  // inner loop
  currentPixel.ambientLight += dv;
```

When I interpolate the color (called "Gouraud" shading, where the "red", "green" and "blue" fields are interpolated by a step value at each pixel):  

```
  typedef struct tagPixelDataGouraud {
      int x;
      float red;
      float green;
      float blue;  // The RGB color interpolated per pixel
  } PixelDataGouraud;

  ...
  // inner loop
  currentPixel.red += dred;
  currentPixel.green += dgreen;
  currentPixel.blue += dblue;
```

When I render in "Phong" shading, I no longer interpolate  an intensity (ambientLight) or a color (red/green/blue) - I interpolate a normal vector (nx, ny, nz) and at each step, I have to re-calculate the lighting equation, based on the interpolated normal vector:  

```
  typedef struct tagPixelDataPhong {
      int x;
      float nX;
      float nY;
      float nZ; // The normal vector interpolated per pixel
  } PixelDataPhong;

  ...
  // inner loop
  currentPixel.nX += dx;
  currentPixel.nY += dy;
  currentPixel.nZ += dz;
```

<p>Now, the first instinct of C programmers would be "heck, write three functions that interpolate the values, and call them depending on the set mode".
First of all, this means that I have a type problem - what do I work with? Are my pixels PixelDataAmbient? PixelDataGouraud? PixelDataPhong? Oh, wait, the efficient C programmer says, use a union!</p>

```
  typedef union tagSuperPixel {
      PixelDataAmbient a;
      PixelDataGouraud g;
      PixelDataPhong   p;
  } SuperPixel;
```

..and then, you have a function...  

```
  RasterizeTriangleScanline(
      enum mode, // { ambient, gouraud, phong }
      SuperPixel left,
      SuperPixel right)
  {
      int i,j;
      if (mode == ambient) {
          // handle pixels as ambient...
          int steps = right.a.x - left.a.x;
          float dv = (right.a.ambientLight - left.a.ambientLight)/steps;
          float currentIntensity = left.a.ambientLight;
          for (i=left.a.x; i<right.a.x; i++) {
              WorkOnPixelAmbient(i, dv);
              currentIntensity+=dv;
          }
      } else if (mode == gouraud) {
          // handle pixels as gouraud...
          int steps = right.g.x - left.g.x;
          float dred = (right.g.red - left.g.red)/steps;
          float dgreen = (right.g.green - left.a.green)/steps;
          float dblue = (right.g.blue - left.g.blue)/steps;
          float currentRed = left.g.red;
          float currentGreen = left.g.green;
          float currentBlue = left.g.blue;
          for (j=left.g.x; i<right.g.x; j++) {
              WorkOnPixelGouraud(j, currentRed, currentBlue, currentGreen);
              currentRed+=dred;
              currentGreen+=dgreen;
              currentBlue+=dblue;
          }
...
```

Do you feel the chaos slipping in?  

First of all, one typo is all that is needed to crash my code, since the compiler will never stop me in the "Gouraud" section of the function, to actually access the ".a." (ambient) values. A bug not caught by the C type system (that is, during compilation), means a bug that manifests at run-time, and will require debugging. Did you notice that I am accessing `left.a.green` in the calculation of "dgreen"? The compiler surely didn't tell you so.  

Then, there is repetition everywhere - the `for` loop is there for as many times as there are rendering modes, we keep doing "right minus left divided by steps". Ugly, and error-prone. Did you notice I compare using "i" in the Gouraud loop, when I should have used "j"? The compiler is again, silent.  

What about the if/else/ ladder for the modes? What if I add a new rendering mode, in three weeks? Will I remember to handle the new mode in all the "if mode==" in all my code?  

Now compare the above ugliness, with this set of C++ structs and a template function:  

```
  struct CommonPixelData {
      int x;
  };
  struct AmbientPixelData : CommonPixelData {
      float ambientLight;
  };
  struct GouraudPixelData : CommonPixelData {
      float red;
      float green;
      float blue;  // The RGB color interpolated per pixel
  };
  struct PhongPixelData : CommonPixelData {
      float nX;
      float nY;
      float nZ; // The normal vector interpolated per pixel
  };

  template <class PixelData>
  RasterizeTriangleScanline(
      PixelData left,
      PixelData right)
  {
      PixelData interpolated = left;
      PixelData step = right;
      step -= left;
      step /= int(right.x - left.x); // divide by pixel span
      for(int i=left.x; i<right.x; i++) {
          WorkOnPixel<PixelData>(interpolated);
          interpolated += step;
      }
  }
```

Now look at this. We no longer make a union type-soup: we have specific types per each mode. They re-use their common stuff (the "x" field) by inheriting from a base class (`CommonPixelData`). And the template makes the compiler CREATE (that is, code-generate) the three different functions we would have written ourselves in C, but at the same time, being very strict about the types!  

Our loop in the template cannot goof and access invalid fields - the compiler will bark if we do.  

The template performs the common work (the loop, increasing by "step" in each time), and can do so in a manner that simply CAN'T cause runtime errors. The interpolation per type (`AmbientPixelData`, `GouraudPixelData`, `PhongPixelData`) is done with the `operator+=()` that we will add in the structs - which basically dictate <em>how</em> each type is interpolated.  

And do you see what we did with WorkOnPixel&lt;T>? We want to do different work per type? We simply call a template specialization:  

```
void WorkOnPixel<AmbientPixelData>(AmbientPixelData& p)
{
    // use the p.ambientLight field
}


void WorkOnPixel<GouraudPixelData>(GouraudPixelData& p)
{
    // use the p.red/green/blue fields
}
```

That is - the function to call, is decided based on the type. At compile-time!  

To rephrase it again:  

<ol>
<li>we minimize the code (via the template), re-using common parts,</li>
<li>we don't use ugly hacks, we keep a strict type system, so that the compiler can check us at all times.</li>
<li>and best of all: none of what we did has ANY runtime impact. This code will run JUST as fast as the equivalent C code - in fact, if the C code was using function pointers to call the various `WorkOnPixel` versions, the C++ code will be FASTER than C, because the compiler will inline the type-specific `WorkOnPixel` template specialization call!</li>
</ol>

Less code, no run-time overhead, more safety.  

Does this mean that C++ is the be-all and end-all of languages? Of course not. You still have to measure trade-offs. Ignorant people will use C++ when they should have written a Bash/Perl/Python script. Trigger-happy C++ newbies will create deep nested classes with virtual multiple inheritance before you can stop them and send them packing. They will use complex <a href="http://en.wikipedia.org/wiki/Boost_C%2B%2B_Libraries">Boost</a> meta-programming before realizing that this is not necessary. They will STILL use `char*`, `strcmp` and macros, instead of `std::string` and templates.  

But this says nothing more than... watch who you work with. There is no language to shield you from incompetent users (no, not even Java).  

Keep studying and using C++ - just don't overdesign.  

#### Answer 3 (score 79)
<a href="http://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization" rel="noreferrer">RAII</a> for the win baby.  

Seriously, deterministic destruction in C++ makes code much clearer and safer with no overhead whatsoever.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: If immutable objects are good, why do people keep creating mutable objects? (score [191286](https://stackoverflow.com/q/151733) in 2014)

#### Question
If immutable objects¹ are good, simple and offer benefits in concurrent programming why do programmers keep creating mutable objects²?  

I have four years of experience in Java programming and as I see it, the first thing people do after creating a class is generate getters and setters in the IDE (thus making it mutable). Is there a lack of awareness or can we get away with using mutable objects in most scenarios?  

<hr>

<p><sup>¹ <a href="http://en.wikipedia.org/wiki/Immutable_object">Immutable object</a> is an object whose state cannot be modified after it is created.<br>
² <a href="http://en.wikipedia.org/wiki/Mutable_object">Mutable object</a> is an object which can be modified after it is created.</sup></p>

#### Answer accepted (score 326)
Both mutable and immutable objects have their own uses, pros and cons.  

Immutable objects do indeed make life simpler in many cases. They are especially applicable for value types, where objects don't have an identity so they can be easily replaced. And they can make concurrent programming way safer and cleaner (most of the notoriously hard to find concurrency bugs are ultimately caused by mutable state shared between threads). However, for large and/or complex objects, creating a new copy of the object for every single change can be very costly and/or tedious. And for objects with a distinct identity, changing an existing objects is much more simple and intuitive than creating a new, modified copy of it.  

Think about a game character. In games, speed is top priority, so representing your game characters with mutable objects will most likely make your game run significantly faster than an alternative implementation where a new copy of the game character is spawned for every little change.  

Moreover, our perception of the real world is inevitably based on mutable objects. When you fill up your car with fuel at the gas station, you perceive it as the same object all along (i.e. its <em>identity</em> is maintained while its <em>state</em> is changing) - not as if the old car with an empty tank got replaced with consecutive new car instances having their tank gradually more and more full. So whenever we are modeling some real-world domain in a program, it is usually more straightforward and easier to implement the domain model using mutable objects to represent real-world entities.  

Apart from all these legitimate reasons, alas, the most probable cause why people keep creating mutable objects is inertia of mind, a.k.a. resistance to change. Note that most developers of today have been trained well before immutability (and the containing paradigm, functional programming) became "trendy" in their sphere of influence, and don't keep their knowledge up to date about new tools and methods of our trade - in fact, many of us humans positively <em>resist</em> new ideas and processes. "I have been programming like this for <em>nn</em> years and I don't care about the latest stupid fads!"  

#### Answer 2 (score 130)
I think you've all missed the most obvious answer.  Most developers create mutable objects because mutability is the default in imperative languages.  Most of us have better things to do with our time than to constantly modify code away from the defaults--more correct or not. And immutability is not a panacea any more than any other approach.  It makes some things easier but makes others much more difficult as some answers have already pointed out.  

#### Answer 3 (score 49)
<ol>
<li><p>There is a place for mutability.  <a href="http://www.infoq.com/minibooks/domain-driven-design-quickly">Domain driven design</a> principles provide a solid understanding of what should be mutable and what should be immutable.  If you think about it you will realize it is impractical to conceive of a system in which every change of state to an object requires the destruction and re-composition of it, and to every object that referenced it.  With complex systems this could easily lead to completely wiping and rebuilding the entire system's object graph</p></li>
<li><p>Most developers don't make anything where the performance requirements are significant enough that they need to focus on concurrency (or a lot of other issues that are universally considered good practice by the informed).  </p></li>
<li><p>There are some things you simply can't do with immutable objects, like have bidirectional relationships.  Once you set an association value on one object, it's identity changes.  So, you set the new value on the other object and it changes as well.  The problem is the first object's reference is no longer valid, because a new instance has been created to represent the object with the reference.  Continuing this would just result in infinite regressions.  I did a little case study after reading your question, here's what it looks like.  Do you have an alternative approach that allows such functionality while maintaining immutability?</p>

```
    public class ImmutablePerson { 

     public ImmutablePerson(string name, ImmutableEventList eventsToAttend)
     {
          this.name = name;
          this.eventsToAttend = eventsToAttend;
     }
     private string name;
     private ImmutableEventList eventsToAttend;

     public string Name { get { return this.name; } }

     public ImmutablePerson RSVP(ImmutableEvent immutableEvent){
         // the person is RSVPing an event, thus mutating the state 
         // of the eventsToAttend.  so we need a new person with a reference
         // to the new Event
         ImmutableEvent newEvent = immutableEvent.OnRSVPReceived(this);
         ImmutableEventList newEvents = this.eventsToAttend.Add(newEvent));
         var newSelf = new ImmutablePerson(name, newEvents);
         return newSelf;
     }
    }

    public class ImmutableEvent { 
     public ImmutableEvent(DateTime when, ImmutablePersonList peopleAttending, ImmutablePersonList peopleNotAttending){
         this.when = when;     
         this.peopleAttending = peopleAttending;
         this.peopleNotAttending = peopleNotAttending;
     }
     private DateTime when; 
     private ImmutablePersonList peopleAttending;
     private ImmutablePersonList peopleNotAttending;
     public ImmutableEvent OnReschedule(DateTime when){
           return new ImmutableEvent(when,peopleAttending,peopleNotAttending);
     }
     //  notice that this will be an infinite loop, because everytime one counterpart
     //  of the bidirectional relationship is added, its containing object changes
     //  meaning it must re construct a different version of itself to 
     //  represent the mutated state, the other one must update its
     //  reference thereby obsoleting the reference of the first object to it, and 
     //  necessitating recursion
     public ImmutableEvent OnRSVPReceived(ImmutablePerson immutablePerson){
           if(this.peopleAttending.Contains(immutablePerson)) return this;
           ImmutablePersonList attending = this.peopleAttending.Add(immutablePerson);
           ImmutablePersonList notAttending = this.peopleNotAttending.Contains( immutablePerson ) 
                                ? peopleNotAttending.Remove(immutablePerson)
                                : peopleNotAttending;
           return new ImmutableEvent(when, attending, notAttending);
     }
    }
    public class ImmutablePersonList
    {
      private ImmutablePerson[] immutablePeople;
      public ImmutablePersonList(ImmutablePerson[] immutablePeople){
          this.immutablePeople = immutablePeople;
      }
      public ImmutablePersonList Add(ImmutablePerson newPerson){
          if(this.Contains(newPerson)) return this;
          ImmutablePerson[] newPeople = new ImmutablePerson[immutablePeople.Length];
          for(var i=0;i<immutablePeople.Length;i++)
              newPeople[i] = this.immutablePeople[i];
          newPeople[immutablePeople.Length] = newPerson;
      }
      public ImmutablePersonList Remove(ImmutablePerson newPerson){
          if(immutablePeople.IndexOf(newPerson) != -1)
          ImmutablePerson[] newPeople = new ImmutablePerson[immutablePeople.Length-2];
          bool hasPassedRemoval = false;
          for(var i=0;i<immutablePeople.Length;i++)
          {
             hasPassedRemoval = hasPassedRemoval || immutablePeople[i] == newPerson;
             newPeople[i] = this.immutablePeople[hasPassedRemoval ? i + 1 : i];
          }
          return new ImmutablePersonList(newPeople);
      }
      public bool Contains(ImmutablePerson immutablePerson){ 
         return this.immutablePeople.IndexOf(immutablePerson) != -1;
      } 
    }
    public class ImmutableEventList
    {
      private ImmutableEvent[] immutableEvents;
      public ImmutableEventList(ImmutableEvent[] immutableEvents){
          this.immutableEvents = immutableEvents;
      }
      public ImmutableEventList Add(ImmutableEvent newEvent){
          if(this.Contains(newEvent)) return this;
          ImmutableEvent[] newEvents= new ImmutableEvent[immutableEvents.Length];
          for(var i=0;i<immutableEvents.Length;i++)
              newEvents[i] = this.immutableEvents[i];
          newEvents[immutableEvents.Length] = newEvent;
      }
      public ImmutableEventList Remove(ImmutableEvent newEvent){
          if(immutableEvents.IndexOf(newEvent) != -1)
          ImmutableEvent[] newEvents = new ImmutableEvent[immutableEvents.Length-2];
          bool hasPassedRemoval = false;
          for(var i=0;i<immutablePeople.Length;i++)
          {
             hasPassedRemoval = hasPassedRemoval || immutableEvents[i] == newEvent;
             newEvents[i] = this.immutableEvents[hasPassedRemoval ? i + 1 : i];
          }
          return new ImmutableEventList(newPeople);
      }
      public bool Contains(ImmutableEvent immutableEvent){ 
         return this.immutableEvent.IndexOf(immutableEvent) != -1;
      } 
    }
```
</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: Pros and Cons of Facebook's React vs. Web Components (Polymer) (score [190834](https://stackoverflow.com/q/225400) in 2015)

#### Question
What are the main benefits of Facebook's <a href="http://facebook.github.io/react/">React</a> over the upcoming <a href="http://w3c.github.io/webcomponents/explainer/">Web Components</a> spec and vice versa (or perhaps a more apples-to-apples comparison would be to Google's <a href="http://www.polymer-project.org/">Polymer</a> library)?  

According to <a href="https://www.youtube.com/watch?v=x7cQ3mrcKaY">this JSConf EU talk</a> and the React homepage, the main benefits of React are:  

<ul>
<li>Decoupling and increased cohesion using a component model</li>
<li>Abstraction, Composition and Expressivity</li>
<li>Virtual DOM &amp; Synthetic events (which basically means they completely re-implemented the DOM and its event system)
<ul>
<li>Enables modern HTML5 event stuff on IE 8</li>
<li>Server-side rendering</li>
<li>Testability</li>
<li>Bindings to SVG, VML, and `<canvas>`</li>
</ul></li>
</ul>

Almost everything mentioned is being integrated into browsers natively through Web Components except this virtual DOM concept (obviously). I can see how the virtual DOM and synthetic events can be beneficial today to support old browsers, but isn't throwing away a huge chunk of native browser code kind of like shooting yourself in the foot in the long term? As far as modern browsers are concerned, isn't that a lot of unnecessary overhead/reinventing of the wheel?  

Here are some things I <em>think</em> React is missing that Web Components will take care of for you. Correct me if I'm wrong.  

<ul>
<li>Native browser support (read "guaranteed to be faster")</li>
<li>Write script in a scripting language, write styles in a styling language, write markup in a markup language.</li>
<li>Style encapsulation using Shadow DOM
<ul>
<li>React instead has <a href="http://facebook.github.io/react/tips/inline-styles.html">this</a>, which requires writing CSS in JavaScript. Not pretty.</li>
</ul></li>
<li>Two-way binding</li>
</ul>

#### Answer 2 (score 664)
<strong>Update:</strong> <em>this answer seems to be pretty popular so I took some time to clean it up a little bit, add some new info and clarify few things that I thought were not clear enough. Please comment if you think anything else needs clarification or updates.</em>  

Most of your concerns are really a matter of opinion and personal preference but I'll try to answer as objectively as I can:  

<h5>Native vs. Compiled</h2>

<blockquote>
  <p>Write JavaScript in vanilla JavaScript, write CSS in CSS, write HTML
  in HTML.</p>
</blockquote>

Back in the day there were hot debates whether one should write <strong>native</strong> Assembly by hand or use a higher level language like C to make the compiler generate Assembly code for you. Even before that people refused to trust <strong>assemblers</strong> and preferred to write <strong>native machine code</strong> by hand (<a href="http://www.cs.utah.edu/~elb/folklore/mel.html" rel="noreferrer">and I'm not joking</a>).  

Meanwhile, today there are a lot of people who write HTML in <a href="http://haml.info/" rel="noreferrer">Haml</a> or <a href="http://jade-lang.com/" rel="noreferrer">Jade</a>, CSS in <a href="http://sass-lang.com/" rel="noreferrer">Sass</a> or <a href="http://lesscss.org/" rel="noreferrer">Less</a> and JavaScript in <a href="http://coffeescript.org/" rel="noreferrer">CoffeeScript</a> or <a href="http://www.typescriptlang.org/" rel="noreferrer">TypeScript</a>. It's there. It works. Some people prefer it, some don't.  

The point is that there is nothing fundamentally wrong in <strong>not</strong> writing JavaScript in vanilla JavaScript, CSS in CSS and HTML in HTML. It's really a matter of preference.  

<h5>Internal vs. External DSLs</h2>

<blockquote>
  <p> Style encapsulation using Shadow DOM
   React instead has this, which requires writing CSS in JavaScript. Not pretty.</p>
</blockquote>

Pretty or not, it is certainly expressive. JavaScript is a very powerful language, much more powerful than CSS (even including any of CSS preprocessors). It kind of depends on whether you prefer internal or external DSLs for those sorts of things. Again, a matter of preference.  

(Note: I was talking about the <a href="http://facebook.github.io/react/tips/inline-styles.html" rel="noreferrer">inline styles in React</a> that was referenced in the original question.)  

<h5>Types of DSLs - explanation</h2>

Update: Reading my answer some time after writing it I think that I need to explain what I mean here. DSL is a <a href="http://en.wikipedia.org/wiki/Domain-specific_language" rel="noreferrer">domain-specific language</a> and it can be either internal (using syntax of the host language like JavaScript - like for example React without JSX, or like the inline styles in React mentioned above) or it can be external (using a different syntax than the host language - like in this example would be inlining CSS (an external DSL) inside JavaScript).  

It can be confusing because some literature uses different terms than "internal" and "external" to describe those kinds of DSLs. Sometimes "embedded" is used instead of "internal" but the word "embedded" can mean different things - for example Lua <a href="http://www.lua.org/ddj.html" rel="noreferrer">is described</a> as "Lua: an extensible embedded language" where embedded has nothing to do with embedded (internal) DSL (in which sense it is quite the opposite - an external DSL) but it means that it is embedded in the same sense that, say, SQLite is an embedded database. There is even <a href="http://www.eluaproject.net/" rel="noreferrer">eLua</a> where "e" stands for "embedded" in a third sense - that it is meant for <a href="http://en.wikipedia.org/wiki/Embedded_system" rel="noreferrer">embedded systems</a>! That's why I don't like using the term "embedded DSL" because things like eLua can be "DSLs" that are "embedded" in two different senses while not being an "embedded DSL" at all!  

To make things worse some projects introduce even more confusion to the mix. Eg. <a href="http://flatironjs.org/#templating" rel="noreferrer">Flatiron templates</a> are described as "DSL-free" while in fact it is just a perfect example of an internal DSL with syntax like: `map.where('href').is('/').insert('newurl');`  

That having been said, when I wrote "JavaScript is a very powerful language, much more powerful than CSS (even including any of CSS preprocessors). It kind of depends on whether you prefer internal or external DSLs for those sorts of things. Again, a matter of preference." I was talking about those two scenarios:  

One:  

```
/** @jsx React.DOM */
var colored = {
  color: myColor
};
React.renderComponent(<div style={colored}>Hello World!</div>, mountNode);
```

Two:  

```
// SASS:
.colored {
  color: $my-color;
}
// HTML:
<div class="colored">Hello World!</div>
```

The first example uses what was described in the question as: "writing CSS in JavaScript. Not pretty." The second example uses Sass. While I agree that using JavaScript to write CSS may not be pretty (for some definitions of "pretty") but there is one advantage of doing it.  

I can have variables and functions in Sass but are they lexically scoped or dynamically scoped? Are they statically or dynamically typed? Strongly or weakly? What about the numeric types? Type coersion? Which values are truthy and which are falsy? Can I have higher-order functions? Recursion? Tail calls? Lexical closures? Are they evaluated in normal order or applicative order? Is there lazy or eager evaluation? Are arguments to functions passed by value or by reference? Are they mutable? Immutable? Persistent? What about objects? Classes? Prototypes? Inheritance?  

Those are not trivial questions and yet I have to know answers to them if I want to understand Sass or Less code. I already know those answers for JavaScript so it means that I already understand every internal DSL (like the inline styles in React) on those very levels so if I use React then I have to know only one set of answers to those (and many similar) questions, while when I use for eg. Sass and Handlebars then I have to know three sets of those answers and understand their implications.  

It's not to say that one way or the other is always better but every time you introduce another language to the mix then you pay some price that may not be as obvious at a first glance, and this price is complexity.  

I hope I clarified what I originally meant a little bit.  

<h5>Data binding</h2>

<blockquote>
  Two-way binding  
</blockquote>

This is a really interesting subject and in fact also a matter of preference. Two-way is not always better than one-way. It's a question of how do you want to model mutable state in your application. I always viewed two-way bindings as an idea somewhat contrary to the principles of functional programming but functional programming is not the only paradigm that works, some people prefer this kind of behavior and both approaches seem to work pretty well in practice. If you're interested in the details of the design decisions related to the modeling of the state in React then watch <a href="https://www.youtube.com/watch?v=x7cQ3mrcKaY" rel="noreferrer">the talk by Pete Hunt</a> (linked to in the question) and <a href="http://www.youtube.com/watch?v=XxVg_s8xAms" rel="noreferrer">the talk by Tom Occhino and Jordan Walke</a> who explain it very well in my opinion.  

<strong>Update:</strong> See also another talk by Pete Hunt: <a href="https://www.youtube.com/watch?v=e7A6EUe3XGM" rel="noreferrer">Be predictable, not correct: functional DOM programming</a>.  

<strong>Update 2:</strong> It's worth noting that many developers are arguing <strong>against</strong> bidirectional data flow, or two-way binding, some even call it an anti-pattern. Take for example the <a href="https://facebook.github.io/flux/" rel="noreferrer">Flux</a> application architecture that explicitly avoids the <a href="http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller" rel="noreferrer">MVC</a> model (that proved to be hard to scale for large Facebook and Instagram applications) in favor of a strictly unidirectional data flow (see the <a href="http://youtu.be/nYkdrAPrdcw" rel="noreferrer">Hacker Way: Rethinking Web App Development at Facebook</a> talk by Tom Occhino, Jing Chen and Pete Hunt for a good introduction). Also, a lot of critique against <a href="https://angularjs.org/" rel="noreferrer">AngularJS</a> (the most popular Web framework that is loosely based on the MVC model, known for two-way data binding) includes arguments against that bidirectional data flow, see:  

<ul>
<li><a href="http://ruoyusun.com/2013/05/25/things-i-wish-i-were-told-about-angular-js.html" rel="noreferrer">Things I Wish I Were Told About Angular.js</a> by Ruoyu Sun</li>
<li><a href="http://blog.dantup.com/2014/08/you-have-ruined-html/" rel="noreferrer">You have ruined HTML</a> by Danny Tuppeny</li>
<li><a href="http://larseidnes.com/2014/11/05/angularjs-the-bad-parts/" rel="noreferrer">AngularJS: The Bad Parts</a> by Lars Eidnes</li>
<li><a href="https://medium.com/este-js-framework/whats-wrong-with-angular-js-97b0a787f903" rel="noreferrer">What’s wrong with Angular.js</a> by Jeff Whelpley ("Two way databinding is an anti-pattern.")</li>
<li><a href="https://medium.com/@mnemon1ck/why-you-should-not-use-angularjs-1df5ddf6fc99" rel="noreferrer">Why you should not use Angular.js</a> by Egor Koshelko ("Two-way data binding is not how to handle events in principle.")</li>
</ul>

<strong>Update 3:</strong> Another interesting article that nicely explains some of the issues disscussed above is <a href="http://spoike.ghost.io/deconstructing-reactjss-flux/" rel="noreferrer">Deconstructing ReactJS's Flux - Not using MVC with ReactJS</a> by Mikael Brassman, author of <a href="https://github.com/spoike/refluxjs#readme" rel="noreferrer">RefluxJS</a> (a simple library for unidirectional data flow application architecture inspired by Flux).  

<strong>Update 4:</strong> <a href="http://emberjs.com/" rel="noreferrer">Ember.js</a> is currently going away from the two-way data binding and in future versions it will be one-way by default. See: <a href="http://vimeo.com/114571439" rel="noreferrer">The Future of Ember</a> talk by Stefan Penner from the Embergarten Symposium in Toronto on November 15th, 2014.  

<strong>Update 5:</strong> See also: <a href="https://twitter.com/pocztarski/status/553188861728526336" rel="noreferrer">The Road to Ember 2.0 RFC - interesting discussion in the pull request by Tom Dale</a>:  

<em>"When we designed the original templating layer, we figured that making all data bindings two-way wasn't very harmful: if you don't set a two-way binding, it's a de facto one-way binding!</em>  

<em>We have since realized (with some help from our friends at React), that components want to be able to hand out data to their children without having to be on guard for wayward mutations.</em>  

<em>Additionally, <strong>communication between components is often most naturally expressed as events or callbacks</strong>. This is possible in Ember, but <strong>the dominance of two-way data bindings often leads people down a path of using two-way bindings as a communication channel</strong>. Experienced Ember developers don't (usually) make this mistake, but it's an easy one to make."</em> [emphasis added]  

<h5>Native vs. VM</h2>

<blockquote>
  Native browser support (read "guaranteed to be faster")  
</blockquote>

Now finally something that is not a matter of opinion.  

Actually here it is exactly the other way around. Of course "native" code can be written in C++ but what do you think the JavaScript engines are written in?  

As a matter of fact the JavaScript engines are truly amazing in the optimizations that they use today - and not only V8 any more, also SpiderMonkey and even Chakra shines these days. And keep in mind that with JIT compilers the code is not only as native as it can possibly be but there are also run time optimization opportunities that are simply impossible to do in any statically compiled code.  

When people think that JavaScript is slow, they usually mean JavaScript that accesses the DOM. The DOM is slow. It is native, written in C++ and yet it is slow as hell because of the complexity that it has to implement.  

Open your console and write:  

```
console.dir(document.createElement('div'));
```

and see how many properties an empty `div` element that is not even attached to the DOM has to implement. These are only the <strong>first level</strong> properties that are "own properties" ie. not inherited from the prototype chain:  

<blockquote>
  align, onwaiting, onvolumechange, ontimeupdate, onsuspend, onsubmit, onstalled, onshow, onselect, onseeking, onseeked, onscroll, onresize, onreset, onratechange, onprogress, onplaying, onplay, onpause, onmousewheel, onmouseup, onmouseover, onmouseout, onmousemove, onmouseleave, onmouseenter, onmousedown, onloadstart, onloadedmetadata, onloadeddata, onload, onkeyup, onkeypress, onkeydown, oninvalid, oninput, onfocus, onerror, onended, onemptied, ondurationchange, ondrop, ondragstart, ondragover, ondragleave, ondragenter, ondragend, ondrag, ondblclick, oncuechange, oncontextmenu, onclose, onclick, onchange, oncanplaythrough, oncanplay, oncancel, onblur, onabort, spellcheck, isContentEditable, contentEditable, outerText, innerText, accessKey, hidden, webkitdropzone, draggable, tabIndex, dir, translate, lang, title, childElementCount, lastElementChild, firstElementChild, children, nextElementSibling, previousElementSibling, onwheel, onwebkitfullscreenerror, onwebkitfullscreenchange, onselectstart, onsearch, onpaste, oncut, oncopy, onbeforepaste, onbeforecut, onbeforecopy, webkitShadowRoot, dataset, classList, className, outerHTML, innerHTML, scrollHeight, scrollWidth, scrollTop, scrollLeft, clientHeight, clientWidth, clientTop, clientLeft, offsetParent, offsetHeight, offsetWidth, offsetTop, offsetLeft, localName, prefix, namespaceURI, id, style, attributes, tagName, parentElement, textContent, baseURI, ownerDocument, nextSibling, previousSibling, lastChild, firstChild, childNodes, parentNode, nodeType, nodeValue, nodeName  
</blockquote>

Many of them are actually nested objects - to see second level (own) properties of an empty native `div` in your browser, see <a href="http://jsfiddle.net/7rPvu/" rel="noreferrer">this fiddle</a>.  

I mean seriously, <strong>onvolumechange</strong> property on every single div node? Is it a mistake? Nope, it's just a legacy DOM Level 0 traditional event model version of one of the event handlers "that <strong>must</strong> be supported <strong>by all HTML elements</strong>, as both content attributes and IDL attributes" [emphasis added] in <a href="http://www.w3.org/TR/2010/WD-html5-20100624/webappapis.html#event-handlers-on-elements-document-objects-and-window-objects" rel="noreferrer">Section 6.1.6.2</a> of the HTML spec by W3C - no way around it.  

Meanwhile, these are the first level properties of a fake-DOM `div` in React:  

<blockquote>
  props, _owner, _lifeCycleState, _pendingProps, _pendingCallbacks, _pendingOwner  
</blockquote>

Quite a difference, isn't it? In fact this is the entire object serialized to JSON (<a href="http://jsfiddle.net/VW7wQ/" rel="noreferrer"><strong>LIVE DEMO</strong></a>), because hey you actually <strong>can</strong> serialize it to JSON as it doesn't contain any circular references - something unthinkable in the world of native DOM (<a href="http://jsfiddle.net/VW7wQ/" rel="noreferrer">where it would just throw an exception</a>):  

```
{
  "props": {},
  "_owner": null,
  "_lifeCycleState": "UNMOUNTED",
  "_pendingProps": null,
  "_pendingCallbacks": null,
  "_pendingOwner": null
}
```

This is pretty much the main reason why React can be faster than the native browser DOM - because it doesn't have to implement <a href="http://www.w3.org/DOM/DOMTR" rel="noreferrer">this mess</a>.  

See <a href="http://www.youtube.com/watch?v=1OeXsL5mr4g" rel="noreferrer">this presentation by Steven Luscher</a> to see what is faster: native DOM written in C++ or a fake DOM written entirely in JavaScript. It's a very fair and entertaining presentation.  

<strong>Update:</strong> <a href="http://emberjs.com/" rel="noreferrer">Ember.js</a> in future versions will use a virtual DOM heavily inspired by React to improve perfomance. See: <a href="http://vimeo.com/114571439" rel="noreferrer">The Future of Ember</a> talk by Stefan Penner from the Embergarten Symposium in Toronto on November 15th, 2014.  

To sum it up: features from Web Components like templates, data binding or custom elements will have a lot of advantages over React but until the document object model itself gets significantly simplified then performance will not be one of them.  

<h5>Update</h2>

Two months after I posted this answers there was some news that is relevant here. As <a href="https://twitter.com/pocztarski/status/488129657792106497" rel="noreferrer">I have just written on Twitter</a>, the lastest version of the <a href="https://atom.io/" rel="noreferrer">Atom</a> text editor written by GitHub in JavaScript uses Facebook's React to get better performance even though <a href="http://en.wikipedia.org/wiki/Atom_(text_editor)" rel="noreferrer">according to Wikipedia</a> "Atom is based on Chromium and written in C++" so it has full control of the native C++ DOM implementation (see <a href="http://blog.atom.io/2014/02/26/the-nucleus-of-atom.html" rel="noreferrer">The Nucleus of Atom</a>) <strong>and</strong> is guaranteed to have support for Web Components since it ships with its own web browser. It is just a very recent example of a real world project that could've used any other kind of optimization typically unavailable to Web applications and yet it has chosen to use React which is itself written in JavaScript, to achieve best performance, even though Atom was not built with React to begin with, so doing it was not a trivial change.  

<h5>Update 2</h2>

There is <a href="https://twitter.com/toddmparker/status/543589209018466305" rel="noreferrer">an interesting comparison by Todd Parker</a> using <a href="http://www.webpagetest.org/" rel="noreferrer">WebPagetest</a> to compare performance of <a href="http://todomvc.com/" rel="noreferrer">TodoMVC</a> examples written in Angular, Backbone, Ember, Polymer, CanJS, YUI, Knockout, React and Shoestring. This is the most objective comparison that I've seen so far. What is significant here is that all of the respective examples were written by experts in all of those frameworks, they are all <a href="https://github.com/tastejs/todomvc/tree/master/examples" rel="noreferrer">available on GitHub</a> and can be improved by anyone who thinks that some of the code could be optimized to run faster.  

<h5>Update 3</h2>

<a href="http://emberjs.com/" rel="noreferrer">Ember.js</a> in future versions will include a number of React's features that are discussed here (including a virtual DOM and unidirectional data binding, to name just a few) which means that the ideas that originated in React are already migrating into other frameworks. See: <a href="https://twitter.com/pocztarski/status/553188861728526336" rel="noreferrer">The Road to Ember 2.0 RFC - interesting discussion in the pull request by Tom Dale</a> (Start Date: 2014-12-03): "In Ember 2.0, we will be adopting a "virtual DOM" and data flow model that embraces the best ideas from React and simplifies communication between components."  

As well, <a href="http://angular-tips.com/blog/2015/06/why-will-angular-2-rock/" rel="noreferrer">Angular.js 2.0</a> is implementing a lot of the concepts discussed here.  

<h5>Update 4</h2>

I have to elaborate on few issues to answer this comment by Igwe Kalu:  

<blockquote>
  <p>"it is not sensible to compare React (JSX or the compilation output) to
  plain JavaScript, when React ultimately reduces to plain JavaScript.
  [...]
  Whatever strategy React uses for DOM insertion can be applied without
  using React. That said, it doesn't add any special benefits when
  considering the feature in question other than the convenience."
  (full comment <a href="https://softwareengineering.stackexchange.com/posts/comments/614171?noredirect=1">here</a>)</p>
</blockquote>

In case it wasn't clear enough, in part of my answer I am comparing the performance of operating directly on the <a href="http://www.w3.org/DOM/DOMTR" rel="noreferrer">native DOM</a> (implemented as host objects in the browser) vs. <a href="https://facebook.github.io/react/docs/glossary.html" rel="noreferrer">React's fake/virtual DOM</a> (implemented in JavaScript). The point I was trying to make is that the virtual DOM implemented in JavaScript <strong>can</strong> outperform the real DOM implemented in C++ and <strong>not</strong> that React can outperform JavaScript (which obviously wouldn't make much sense since it <strong>is</strong> written in JavaScript). My point was that "native" C++ code is not always guaranteed to be faster than "not-native" JavaScript. Using React to illustrate that point was just an example.  

But this comment touched an interesting issue. In a sense it is true that you don't need any framework (React, Angular or jQuery) for any reason whatsoever (like performance, portability, features) because you can always recreate what the framework does for you and reinvent the wheel - if you can justify the cost, that is.  

But - as Dave Smith nicely put it in <a href="https://medium.com/@djsmith42/how-to-miss-the-point-when-comparing-web-framework-performance-50ac0d8d9d71" rel="noreferrer">How to miss the point when comparing web framework performance</a>: "When comparing two web frameworks, the question is not <strong>can</strong> my app be fast with framework X. The question is <strong>will</strong> my app be fast with framework X."  

In <a href="https://stackoverflow.com/questions/5099949/what-are-some-empirical-technical-reasons-not-to-use-jquery/5100169#5100169">my 2011 answer to: What are some empirical technical reasons not to use jQuery</a> I explain a similar issue, that it is not impossible to write portable DOM-manipulation code without a library like jQuery, but that people rarely do so.  

When using programming languages, libraries or frameworks, people tend to use the most convenient or idiomatic ways of doing things, not the perfect but inconvenient ones. The true value of good frameworks is making easy what would otherwise be hard to do - and the secret is making the <strong>right things</strong> convenient. The result is still having exactly the same power at your disposal as the simplest form of lambda calculus or the most primitive Turing machine, but the relative expressiveness of certain concepts means that those very concepts tend to get expressed more easily or at all, and that the right solutions are not just possible but actually implemented widely.  

<h5>Update 5</h2>

<a href="https://aerotwist.com/blog/react-plus-performance-equals-what/" rel="noreferrer">React + Performance = ?</a> article by Paul Lewis from July 2015 shows an example where React is slower than vanilla JavaScript written by hand for  an infinite list of Flickr pictures, which is especially significant on mobile. This example shows that everyone should always test performance for specific use case and specific target platforms and devices.  

Thanks to <a href="https://twitter.com/KevinLozandier" rel="noreferrer">Kevin Lozandier</a> for <a href="https://twitter.com/KevinLozandier/status/654938647121252352" rel="noreferrer">bringing it to my attention</a>.  

#### Answer 3 (score 16)
<p>Polymer is awesome. React is awesome.
They are not the same thing. </p>

<strong>Polymer</strong> is a <em>library</em> for building backwards compatible web components.  

<strong>React</strong> is the V in MVC. It's the View, and nothing else. Not by itself at least.   

<strong>React is not a framework.</strong>  

React + Flux + Node + (Gulp or Grunt) is more comparable to a framework, but 3 of those things aren't part of react at all.  

There are many technologies, patterns, and architectural styles that react developers follow, but react itself is not a framework.  

It's sad that no one took the time to say the simplest possible thing, that they should not be compared. They have some overlap, but they are more different than the same.  

They both allow you to define web components, but in different ways. Beyond that they are very very different tools.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Why do we need private variables? (score [190625](https://stackoverflow.com/q/143736) in 2013)

#### Question
Why do we need private variables in classes?  

Every book on programming I've read says this is a private variable, this is how you define it but stops there.   

The wording of these explanations always seemed to me like we really have a crisis of trust in our profession. The explanations always sounded like other programmers are out to mess up our code. Yet, there are many programming languages that do not have private variables.   

<ol>
<li><p>What do private variables help prevent? </p></li>
<li><p>How do you decide if a particular property should be private or
not? If by default every field SHOULD be private then why are there
public data members in a class?  </p></li>
<li><p>Under what circumstances should a variable be made public?</p></li>
</ol>

#### Answer accepted (score 308)
It's not so much a matter of trust, but rather one of managing complexity.  

A public member can be accessed from outside the class, which for practical considerations means "potentially anywhere". If something goes wrong with a public field, the culprit can be anywhere, and so in order to track down the bug, you may have to look at quite a lot of code.  

A private member, by contrast, can only be accessed from inside the same class, so if something goes wrong with that, there is usually only one source file to look at. If you have a million lines of code in your project, but your classes are kept small, this can reduce your bug tracking effort by a factor of 1000.  

Another advantage is related to the concept of 'coupling'. A public member `m` of a class `A` that is used by another class `B` introduces a dependency: if you change `m` in `A`, you also have to check usages of `m` in `B`. Worse yet, nothing in class `A` tells you where `m` is being used, so again you have to search through the entire codebase; if it's a library you're writing, you even have to make sure code <em>outside</em> your project doesn't break because of your change. In practice, libraries tend to stick with their original method signatures as long as possible, no matter how painful, and then introduce a block of breaking changes with a major version update. With private members, by contrast, you can exclude dependencies right away - they can't be accessed from outside, so all dependencies are contained inside the class.  

In this context, "other programmers" include your future and past selves. Chances are you know <em>now</em> that you shouldn't do this thing X with your variable Y, but you're bound to have forgotten three months down the road when a customer urgently needs you to implement some feature, and you wonder why doing X breaks Y in obscure ways.  

So, as to when you should make things private: I'd say make everything private by default, and then expose only those parts that absolutely have to be public. The more you can make private, the better.  

#### Answer 2 (score 111)
Private variables help prevent people from depending on certain parts of your code. For example, say you want to implement some data structure. You want users of your data structure to not care <em>how</em> you implemented it, but rather just use the implementation through your well defined interface. The reason is that if no one is depending on your implementation, you can change it whenever you want. For example, you can change the back-end implementation to improve performance. Any other developers who depended on your implementations will break, while the interface users will be fine. Having the flexibility to change implementations without effecting the class users is a huge benefit that using private variables (and more broadly, <a href="http://en.wikipedia.org/wiki/Encapsulation_%28object-oriented_programming%29">encapsulation</a>) gives you.  

Also, it's not really a "trust crisis". If you make a piece of data public, you cannot ensure that no one is depending on it. It's often very convenient to depend on some implementation-specific variable, instead of going through the public interface, especially in the heat of a deadline. Further, developers won't always realize that they are depending on something that might change.  

So this sort of answers your other questions, I hope. All your implementation details should be private, and the public part should be a small, concise, well-defined interface for using your class.  

#### Answer 3 (score 25)
The keyword here is <a href="http://en.wikipedia.org/wiki/Encapsulation_%28object-oriented_programming%29">Encapsulation</a>. In OOP you want to use private variables in order to enforce proper encapsulation of your objects/classes.  

While other programmers are not out to get you, they do interact with your code. If you do not make a variable private, they may well refer to it in their own code without wanting to do any harm at all. However, if you need to get back to your class and change something, you no longer know who uses which variable and where. The goal of encapsulation is to make the external interface of the class explicit so that you know only these (typically) methods could have been used by others.  

<ol>
<li><p>Hence, private variables ensure that the corresponding variable remains in the defining class only. If you need to change it, the change is local to the class itself.</p></li>
<li><p>In traditional lanugages like C++ or Java, you usually make everything private and only accessible by corresponding getters and setters. No need to decide much really.</p></li>
<li><p>Sometimes, f.ex. in a C++ struct, you need a class only as a way to group several things together. For example, consider a Vector class which has an `x` and a `y` attribute only. In those cases, you may allow direct access to these attributes by declaring them public. In particular, you must not care if some code outside modifies an object of your class by directly writing new values into `x` or `y`.</p></li>
</ol>

As an additional point, notice that this matter is regarded slightly different in other languages. For example, languages that are strongly rooted in functional programming emphasize data immutability, i.e. data values cannot be changed at all. In such cases, you do not have to care what other programmers (or rather their code) do to your data. They simply cannot do anything that could affect your code, because all data is immutable.   

In those languages, you therefore get something called <a href="http://en.wikipedia.org/wiki/Uniform_access_principle">uniform access principle</a>, where one deliberatly does not distinguish methods like getters and setters, but provides direct access to the variable/function. So you may say that private declarations are quite a lot more popular in the object-oriented scenarios.  

This also shows how broadening your knowledge to include other fields makes you view existing concepts in a whole new way.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Difference between Web API and Web Service? (score [189237](https://stackoverflow.com/q/38691) in 2017)

#### Question
I have heard a lot about Web Services and Web APIs, is there any difference between them or are they the same?   

#### Answer accepted (score 86)
Web Services - that's standard defined by W3C, so they can be accessed semi-automatically or automatically (WSDL / UDDI). The whole thing is based on XML, so anyone can call it. And every aspect of the service is very well defined. There's parameters description standard, parameter passing standard, response standard, discovery standard, etc. etc. You could probably write 2000 pages book that'd describe the standard. There are even some "additional" standards for doing "standard" things, like authentication.  

Despite the fact that automatic invoking and discovery is barely working because clients are rather poor, and you have no real guarantee that any service can be called from any client.  

Web API is typically done as HTTP/REST, nothing is defined, output can be for eg. JSON/XML, input can be XML/JSON/or plain data. There are no standards for anything => no automatic calling and discovery. You can provide some description in text file or PDF, you can return the data in Windows-1250 instead of unicode, etc. For describing the standard it'd be 2 pages brochure with some simple info and you'll define everything else.  

Web is switching towards Web API / REST. Web Services are really no better than Web API. Very complicated to develop and they eat much more resources (bandwidth and RAM)... and because of all data conversions (REQUEST->XML->DATA->RESPONSE->XML->VALIDATION->CONVERSION->DATA) are very slow.  

Eg. In WebAPI you can pack the data, send it compressed and un-compress+un-pack on the client. In SOAP you could only compress HTML request.  

#### Answer 2 (score 20)
A web service allows for machine to machine communications over HTTP.  A web API is a subset of web services that use REST conventions (Summarizing the <a href="http://en.wikipedia.org/wiki/Web_service">Wikipedia article</a>).  The concepts definitely overlap.  I believe that there is still a link in most people's minds of web service -> SOAP/XML-RPC which can unnecessarily confuse matters.  

In the end, you'll have to ask a few questions to clarify what people mean.  Not everyone makes a distinction or uses the terms interchangeably.  

#### Answer 3 (score 6)
Web services is a defined architecture and approach to a problem domain as stated by the <a href="http://www.w3.org/TR/ws-arch/#id2260892">W3C</a>.  

<blockquote>
  <p>Web services provide a standard means
  of interoperating between different
  software applications, running on a
  variety of platforms and/or framework</p>
</blockquote>

Web API is a concept and abstracts the means on how the concept is implemented.  

In layman's terms...web API is to motor whereas WS is to <a href="http://en.wikipedia.org/wiki/BMW_N53">BMW N53</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: What's the difference between stateful and stateless? (score [187833](https://stackoverflow.com/q/101337) in 2011)

#### Question
The books and documentation on the MVC just heap on using the Stateful and Stateless terms. To be honest, i am just unable to grab the idea of it, what the books are talking about. They don't give an example to understand any of the either state, rather than just telling that HTTP is stateless and with ASP.NET MVC microsoft is going along with it. Am I missing some fundamental knowledge, as i can't understand what is stateful and why is stateful and same goes for stateless.  

A simple and short example that talks about a control like button or textbox can be simplify the understanding i suppose.    

#### Answer accepted (score 40)
Stateless means that HTTP doesn't have built in support for states; e.g. you can't store if a user has logged in or done something else.  

The most common solution is to use sessions to overcome that problem. This means that you have to be able to include a session identifier in each response or request. This is either done by creating a session cookie or by including the session identifier in all links.  

WebForms tries to make all that transparent (using ViewState) while MVC forces you to handle it manually.  

In your example you mentioned Buttons and TextBoxes. The easiest way to let them maintaining their state is simply to stop posting back the entire page. MVC got excellent support for ajax (through jQuery) and I suggest that you use ajax if you just want to do something on the current page.  

#### Answer 2 (score 108)
Stateless - There's no memory (state) that's maintained by the program  

Stateful - The program has a memory (state)  

To illustrate the concept of state I'll define a function which is <strong>stateful</strong> and one which is <strong>stateless</strong>  

<h5>Stateless</h2>

```
//The state is derived by what is passed into the function

function int addOne(int number)
{
    return number + 1;
}
```

<h5>Stateful</h2>

```
//The state is maintained by the function

private int _number = 0; //initially zero 

function int addOne()
{
    _number++;
    return _number;
}
```

As others have said http is inherently stateless.  So state must be built into your applications.  

Imagine a request over the web where you have a client browser communicating to a server process.  To maintain state over the stateless http protocol the browser will send typically send a session identifier to the server on each request.  For each request the server will be like "ah, its this guy".  State information can then be looked up in server side memory or in a database based on this session id.  

In a purely stateless environment you wouldn't need this session id. Each request would contain all the information the server would need to process. But many applications need to maintain state to keep track of whether or not a session is authenticated to view certain content or to keep track of what a user is doing. You wouldn't want to send user credentials over the wire for each request.  

#### Answer 3 (score 69)
stateless means there is no memory of the past.  Every transaction is performed as if it were being done for the very first time.  

statefull means that there is memory of the past.  Previous transactions are remembered and may affect the current transaction.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Is the C programming language still used? (score [185421](https://stackoverflow.com/q/103897) in 2016)

#### Question
I am a C# programmer, and most of my development is for websites along with a few Windows applications. As far as C goes, I haven't used it in a long time, as there was no need to. It came to me as a surprise when one of my friends said that she needs to learn C for testing jobs, while I was helping her learn C#.  

I figured that someone would only learn C for testing if there is development being done in C. From my knowledge, all development related to COM and hardware design is also done in C++. Therefore, learning C doesn't make sense if you need to use C++. I also don't believe in historic significance, so why waste time and money in learning C?      

Is C still used in any kind of new software development or anything else?  

#### Answer accepted (score 214)
C has the advantage that it is a relatively <strong><em>small language</em></strong>, which makes it <strong><em>easy to implement a C compiler</em></strong> (whereas a C++ compiler is a monster to write), and makes it <strong><em>easier to learn the language</em></strong>. Also see the <a href="https://www.tiobe.com/tiobe-index/" rel="noreferrer">TIOBE index</a>, according to which C slightly ahead of C++.   

In (IMO) decreasing order of justification, C is still used a lot for   

<ul>
<li><p>Embedded stuff<br>
It's way easier to port a C compiler to a small platform than it is to port a C++ compiler. Also, C advocates claim that C++ "does too much behind their backs". However, IMO that's FUD. </p></li>
<li><p>Systems programming<br>
Again, that's usually due to claims that it is easier to "know what the compiler is doing". However, many embedded programs would benefit from, e.g., templates and other C++ key features. </p></li>
<li><p>Open source software<br>
That's mostly an attitude problem, though: OSS has always preferred C over C++ (whereas it's the opposite in large parts of the industry). Torvalds' irrational hatred might actually be the most important reason for this <em>on Linux</em>. </p></li>
</ul>

#### Answer 2 (score 119)
C is used a lot in embedded hardware programming where resources are scarce.  

Linux kernel is written in C because, according to Linus Torvalds, <a href="http://lists-archives.com/git/629691-convert-builin-mailinfo-c-to-use-the-better-string-library.html" rel="noreferrer">C++ is a horrible language</a>.  

#### Answer 3 (score 94)
<strong>All</strong> of the modern languages I have seen may interact with C:  

<ul>
<li>C++</li>
<li>Java</li>
<li>C#</li>
<li>Python</li>
<li>Haskell</li>
<li>Objective C</li>
</ul>

The need to interact with C derives from:  

<ul>
<li>C having a simple ABI</li>
<li>C being around for a long time</li>
</ul>

It means that since those languages can communicate with C, they can:  

<ul>
<li>leverage its libraries</li>
<li>communicate with each other <em>through</em> C (for example, Clang is written in C++ but offers Python Bindings hooked on its C interface).</li>
</ul>

And I would bet that all of them rely on C for their runtimes (unless they went full assembly ? dubious).  

C is the <em>Lingua Franca</em> of the programming languages and one of the simplest (ABI-wise) not tied to a specific architecture (like assembly is), it'll take a major shift to get rid of it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Android development using C and C++ (score [181905](https://stackoverflow.com/q/127735) in 2016)

#### Question
I am a C, C++ developer. I am interested in mobile development. I want to know how can I develop Android apps using C and C++, I have <a href="http://android-developers.blogspot.com/2009/06/introducing-android-15-ndk-release-1.html">read</a> that they are providing a kit for C, C++ developers but it does not have all functions as of Java kit. Should I go for C/C++ development kit or it's better to learn java as they may not provide all the functionality in future?  

#### Answer accepted (score 33)
Short version : working with C++ on Android is possible and easier with each Android SDK/NDK version, but it's harder than working with Java.  

<hr>

Long version :  

For each version, Google adds more functionalities to Android Native Development Kit and makes it more and more independant on the Java code.   

Read <a href="http://developer.android.com/sdk/ndk/overview.html">http://developer.android.com/sdk/ndk/overview.html</a> for more details:  

<blockquote>
  <p>Write a native activity, which allows you to implement the lifecycle
  callbacks in native code. The Android SDK provides the NativeActivity
  class, which is a convenience class that notifies your native code of
  any activity lifecycle callbacks (onCreate(), onPause(), onResume(),
  etc). You can implement the callbacks in your native code to handle
  these events when they occur. Applications that use native activities
  must be run on Android 2.3 (API Level 9) or later. You cannot access
  features such as Services and Content Providers natively, so if you
  want to use them or any other framework API, you can still write JNI
  code to do so.</p>
</blockquote>

The problem is just that if you use the most recent NDK, you'll not be able to deploy and a lot of not-recent Android versions.  

Anyway even with previous NDK versions, you can have minimal Java code (for interacting with the OS) and the full application code in C++ or anything native.  

There are also efforts in helping native developers to work fully in C or C++ via IDE plugins like this Vs-Android that is a plugin for Visual Studio 201x hiding all the compilation and generation process from you : <a href="http://code.google.com/p/vs-android/">http://code.google.com/p/vs-android/</a>  

Also, if you plan do port your application to other OS, going with C++ for the core of your application (maybe with a scripting language on top) is a good idea. It's just more expensive on development time than other alternatives - for reasons specific to C++ and it's available dev tools implementations, for example too much compilation times can kill your effective productivity.  

That being said, that is not the most easy way to work on mobile apps.  

#### Answer 2 (score 8)
I would advise you to go for C++ if you have a firm plan to go into Game Development. But if not, you better go for Java. Here is a good primer for you on the official android website:  

<a href="http://android-developers.blogspot.com/2010/06/game-development-for-android-quick.html">Game Development for Android: A Quick Primer</a>  

NOTE: Please do read step 2 (Step Two: Pick a Language) of the tutorial.  

<p>If you do not know Java at all and like to develop apps on Android for the long term, it is essential to learn Java. There are great tutorials given on the official website. There is a nice book that you can grab for learning specifically for Android development:
Here it is: <a href="http://www.apress.com/9781430231561">Learn Java for Android Development</a></p>

#### Answer 3 (score 7)
<blockquote>
  Should I go for C/C++ development kit or it's better to learn java as they may not provide all the functionality in future?  
</blockquote>

The answer is both.  

<ul>
<li>If you are writing any applications where performance is a main
concern, they almost have to be in something other than java. (C/C++
is most popular) Games is the big ticket item, but there are others.</li>
<li>If you are doing any android development, you should also take the time to learn java to a reasonable level.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: Where did the notion of "one return only" come from? (score [181496](https://stackoverflow.com/q/118703) in 2017)

#### Question
I often talk to programmers who say "<em>Don't put multiple return statements in the same  method.</em>" When I ask them to tell me the reasons why, all I get is "<em>The coding standard says so.</em>" or "<em>It's confusing.</em>" When they show me solutions with a single return statement, the code looks uglier to me. For example:  



```
if (condition)
   return 42;
else
   return 97;
```

"<em>This is ugly, you have to use a local variable!</em>"  

```
int result;
if (condition)
   result = 42;
else
   result = 97;
return result;
```

How does this 50% code bloat make the program any easier to understand? Personally, I find it harder, because the state space has just increased by another variable that could easily have been prevented.  

Of course, normally I would just write:  

```
return (condition) ? 42 : 97;
```

But many programmers eschew the conditional operator and prefer the long form.  

Where did this notion of "one return only" come from? Is there a historical reason why this convention came about?  

#### Answer accepted (score 1121)
"Single Entry, Single Exit" was written when most programming was done in assembly language, FORTRAN, or COBOL.  It has been widely misinterpreted, because modern languages do not support the practices Dijkstra was warning against.  

"Single Entry" meant "do not create alternate entry points for functions".  In assembly language, of course, it is possible to enter a function at any instruction.  FORTRAN supported multiple entries to functions with the `ENTRY` statement:  

```
      SUBROUTINE S(X, Y)
      R = SQRT(X*X + Y*Y)
C ALTERNATE ENTRY USED WHEN R IS ALREADY KNOWN
      ENTRY S2(R)
      ...
      RETURN
      END

C USAGE
      CALL S(3,4)
C ALTERNATE USAGE
      CALL S2(5)
```

"Single Exit" meant that a function should only return <strong>to</strong> one place: the statement immediately following the call.  It did <strong>not</strong> mean that a function should only return <strong>from</strong> one place.  When <em>Structured Programming</em> was written, it was common practice for a function to indicate an error by returning to an alternate location.  FORTRAN supported this via "alternate return":  

```
C SUBROUTINE WITH ALTERNATE RETURN.  THE '*' IS A PLACE HOLDER FOR THE ERROR RETURN
      SUBROUTINE QSOLVE(A, B, C, X1, X2, *)
      DISCR = B*B - 4*A*C
C NO SOLUTIONS, RETURN TO ERROR HANDLING LOCATION
      IF DISCR .LT. 0 RETURN 1
      SD = SQRT(DISCR)
      DENOM = 2*A
      X1 = (-B + SD) / DENOM
      X2 = (-B - SD) / DENOM
      RETURN
      END

C USE OF ALTERNATE RETURN
      CALL QSOLVE(1, 0, 1, X1, X2, *99)
C SOLUTION FOUND
      ...
C QSOLVE RETURNS HERE IF NO SOLUTIONS
99    PRINT 'NO SOLUTIONS'
```

Both these techniques were highly error prone.  Use of alternate entries often left some variable uninitialized.  Use of alternate returns had all the problems of a GOTO statement, with the additional complication that the branch condition was not adjacent to the branch, but somewhere in the subroutine.  

#### Answer 2 (score 913)
This notion of <em>Single Entry, Single Exit</em> (SESE) comes from <strong><em>languages with explicit resource management</em></strong>, like C and assembly. In C, code like this will leak resources:  

```
void f()
{
  resource res = acquire_resource();  // think malloc()
  if( f1(res) )
    return; // leaks res
  f2(res);
  release_resource(res);  // think free()
}
```

In such languages, you basically have three options:   

<ul>
<li><p>Replicate the cleanup code.<br>
Ugh. Redundancy is always bad. </p></li>
<li><p>Use a `goto` to jump to the cleanup code.<br>
This requires the cleanup code to be the last thing in the function. (And this is why some argue that `goto` has its place. And it has indeed – in C.) </p></li>
<li><p>Introduce a local variable and manipulate control flow through that.<br>
The disadvantage is that control flow manipulated through syntax (think `break`, `return`, `if`, `while`) is much easier to follow than control flow manipulated through the state of variables (because those variables have no state when you look at the algorithm). </p></li>
</ul>

In assembly it's even weirder, because you can jump to any address in a function when you call that function, which effectively means you have an almost unlimited number of entry points to any function. (Sometimes this is helpful. Such thunks are a common technique for compilers to implement the `this` pointer adjustment necessary for calling `virtual` functions in multiple-inheritance scenarios in C++.)   

When you have to manage resources manually, exploiting the options of entering or exiting a function anywhere leads to more complex code, and thus to bugs. Therefore, a school of thought appeared that propagated SESE, in order to get cleaner code and less bugs.   

<hr>

However, when a language features exceptions, (almost) any function might be exited prematurely at (almost) any point, so you need to make provisions for premature return anyway. (I think `finally` is mainly used for that in Java and `using` (when implementing `IDisposable`, `finally` otherwise) in C#; C++ instead employs <a href="https://stackoverflow.com/q/712639/140719">RAII</a>.) Once you have done this, you <em>cannot</em> fail to clean up after yourself due to an early `return` statement, so what is probably the strongest argument in favor of SESE has vanished.   

That leaves readability. Of course, a 200 LoC function with half a dozen `return` statements sprinkled randomly over it is not good programming style and does not make for readable code. But such a function wouldn't be easy to understand without those premature returns either.  

In languages where resources are not or should not be managed manually, there is little or no value in adhering to the old SESE convention. OTOH, as I have argued above, <strong><em>SESE often makes code more complex</em></strong>. It is a dinosaur that (except for C) does not fit well into most of today's languages. Instead of helping the understandability of code, it hinders it.  

<hr>

Why do Java programmers stick to this? I don't know, but from my (outside) POV, Java took a lot of conventions from C (where they make sense) and applied them to its OO world (where they are useless or outright bad), where it now sticks to them, no matter what the costs. (Like the convention to define all your variables at the beginning of the scope.)  

Programmers stick to all kinds of strange notations for irrational reasons. (Deeply nested structural statements – "arrowheads" – were, in languages like Pascal, once seen as beautiful code.) Applying pure logical reasoning to this seems to fail to convince the majority of them to deviate from their established ways. The best way to change such habits is probably to teach them early on to do what's best, not what's conventional. You, being a programming teacher, have it in your hand. `:)`  

#### Answer 3 (score 81)
On the one hand, single return statements make logging easier, as well as forms of debugging that rely on logging. I remember plenty of times I had to reduce the function into single return just to print out the return value at a single point.  

```
  int function() {
     if (bidi) { print("return 1"); return 1; }
     for (int i = 0; i < n; i++) {
       if (vidi) { print("return 2"); return 2;}
     }
     print("return 3");
     return 3;
  }
```

On the other hand, you could refactor this into `function()` that calls `_function()` and logs the result.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: I've inherited 200K lines of spaghetti code -- what now? (score [178047](https://stackoverflow.com/q/155488) in 2013)

#### Question
I hope this isn't too general of a question; I could really use some seasoned advice.  

I am newly employed as the sole "SW Engineer" in a fairly small shop of scientists who have spent the last 10-20 years cobbling together a vast code base. (It was written in a virtually obsolete language: <a href="http://www.gensym.com/product/G2"><em>G2</em></a> -- think Pascal with graphics). The program itself is a physical model of a complex chemical processing plant; the team that wrote it have incredibly deep domain knowledge but little or no formal training in programming fundamentals. They've recently learned some hard lessons about the consequences of non-existant configuration management. Their maintenance efforts are also greatly hampered by the vast accumulation of undocumented "sludge" in the code itself. I will spare you the "politics" of the situation (there's <em>always</em> politics!), but suffice to say, there is not a consensus of opinion about what is needed for the path ahead.  

They have asked me to begin presenting to the team some of the principles of modern software development. They want me to introduce some of the industry-standard practices and strategies regarding coding conventions, lifecycle management, high-level design patterns, and source control. Frankly, it's a fairly daunting task and I'm not sure where to begin.   

Initially, I'm inclined to tutor them in some of the central concepts of <a href="http://rads.stackoverflow.com/amzn/click/020161622X"><em>The Pragmatic Programmer</em></a>, or Fowler's <a href="http://rads.stackoverflow.com/amzn/click/0201485672"><em>Refactoring</em></a> ("Code Smells", etc). I also hope to introduce a number of Agile methodologies. But ultimately, to be effective, I think I'm going to need to hone in on 5-7 core fundamentals; in other words, what are the most important principles or practices that they can realistically start implementing that will give them the most "bang for the buck".   

So that's my question: What would <em>you</em> include in your list of the most effective strategies to help straighten out the spaghetti (and prevent it in the future)?  

#### Answer accepted (score 465)
<h5>Foreword</h1>

<p>This is a daunting task indeed, and there's a lot of ground to
cover. So I'm humbly suggesting this as somewhat comprehensive guide
for your team, with pointers to appropriate tools and educational
material.</p>

<p><em><strong>Remember:</strong> These are <strong>guidelines</strong>, and that as such are meant to
adopted, adapted, or dropped based on circumstances.</em></p>

<p><em><strong>Beware:</strong> Dumping all this on a team at once would most likely
fail. You should try to cherry-pick elements that would give you the
best bang-for-sweat, and introduce them slowly, one at a time.</em></p>

<p><em><strong>Note:</strong> not all of this applies directly to Visual Programming
Systems like G2. For more specific details on how to deal with these,
see the <strong>Addendum</strong> section at the end.</em></p>

<hr>

<h5>Executive Summary for the Impatient</h1>

<ul>
<li>Define a <strong>rigid project structure</strong>, with:

<ul>
<li><strong>project templates</strong>,</li>
<li><strong>coding conventions</strong>,</li>
<li>familiar <strong>build systems</strong>,</li>
<li>and sets of <strong>usage guidelines</strong> for your infrastructure and tools.</li>
</ul></li>
<li>Install a good <strong>SCM</strong> and make sure they know how to use it.</li>
<li>Point them to good <strong>IDEs</strong> for their technology, and make sure they know how to use them.</li>
<li>Implement <strong>code quality checkers</strong> and <strong>automatic reporting</strong> in the build system.</li>
<li>Couple the build system to <strong>continuous integration</strong> and <strong>continuous inspection</strong> systems.</li>
<li>With the help of the above, identify <strong>code quality "hotspots"</strong> and <strong>refactor</strong>.</li>
</ul>

<em>Now for the long version... Caution, brace yourselves!</em>  

<hr>

<h5>Rigidity is (Often) Good</h1>

<p><em>This is a controversial opinion, as rigidity is often seen as a force
working against you. It's true for some phases of some projects. But
once you see it as a structural support, a framework that takes away
the guesswork, it greatly reduces the amount of wasted time and
effort. Make it work for you, not against you.</em></p>

<em>Rigidity</em> = <em>Process</em> / <em>Procedure</em>.  

<p>Software development needs good process and procedures for exactly the
same reasons that chemical plants or factories have manuals,
procedures, drills and emergency guidelines: preventing bad outcomes,
increasing predictability, maximizing productivity...</p>

<strong>Rigidity comes in moderation, though!</strong>  

<h5>Rigidity of the Project Structure</h2>

<p>If each project comes with its own structure, you (and newcomers) are
lost and need to pick up from scratch every time you open them. You
don't want this in a professional software shop, and you don't want
this in a lab either.</p>

<h5>Rigidity of the Build Systems</h2>

<p>If each project <strong>looks</strong> different, there's a good chance they also
<strong>build differently</strong>. A build shouldn't require too much research or
too much guesswork. You want to be able to do the canonical thing and
not need to worry about specifics: `configure; make install`, `ant`,
`mvn install`, etc...</p>

<p>Re-using the same build system and making it evolve over the time also
ensures a consistent level of quality.</p>

<p>You do need a quick `README` to point the project's specifics, and
gracefully guide the user/developer/researcher, if any.</p>

<p>This also greatly facilitates other parts of your build
infrastructure, namely:</p>

<ul>
<li><a href="http://en.wikipedia.org/wiki/Continuous_Integration" rel="nofollow noreferrer">continuous integration</a>,</li>
<li><a href="http://www.ibm.com/developerworks/java/library/j-ap08016/index.html" rel="nofollow noreferrer">continuous inspection</a>.</li>
</ul>

<p>So keep your build (like your projects) up to date, but make it
stricter over time, and more efficient at reporting violations and bad
practices.</p>

Do not reinvent the wheel, and reuse what you have already done.  

<strong>Recommended Reading:</strong>  

<ul>
<li><em><a href="http://rads.stackoverflow.com/amzn/click/0321336380" rel="nofollow noreferrer">Continuous Integration: Improving Software Quality and Reducing Risk</a></em> (Duval, Matyas, Glover, 2007)</li>
<li><em>Continuous Delivery: Release Sotware Releases through Build, Test and Deployment Automation</em> (Humble, Farley, 2010)</li>
</ul>

<h5>Rigidity in the Choice of Programming Languages</h2>

<p>You can't expect, especially in a research environment, to have all
teams (and even less all developers) use the same language and
technology stack. However, you can identify a set of "officially
supported" tools, and encourage their use. The rest, without a good
rationale, shouldn't be permitted (beyond prototyping).</p>

<p>Keep your tech stack simple, and the maintenance and breadth of
required skills to a bare minimum: a strong core.</p>

<h5>Rigidity of the Coding Conventions and Guidelines</h2>

<p>Coding conventions and guidelines are what allow you to develop both
an identity as a team, and a shared <em>lingo</em>. You don't want to err
into <em>terra incognita</em> every time you open a source file.</p>

<p>Nonsensical rules that make life harder or forbid actions explicity
to the extent that commits are refused based on single simple
violations are a burden. However:</p>

<ul>
<li><p>a well thought-out ground ruleset takes away a lot of the whining
and thinking: <strong>nobody</strong> should break under no circumstances;</p></li>
<li><p>and a set of recommended rules provide additional guidance.</p></li>
</ul>

<blockquote>
  <p><strong>Personal Approach:</strong> I am aggressive when it comes to coding
  conventions, some even say <em>nazi</em>, because I do believe in having a
  <em>lingua franca</em>, a recognizable style for my team. When crap code
  gets checked-in, it stands out like a cold sore on the face of an
  Hollywood star: it triggers a review and an action automatically.
  In fact, I've sometimes gone as far as to advocate the use of
  pre-commit hooks to reject non-conforming commits. As mentioned, it
  shouldn't be overly crazy and get in the way of productivity: it
  should drive it. Introduce these slowly, especially at the
  beginning. But it's way preferable over spending so much time fixing
  faulty code that you can't work on real issues.</p>
</blockquote>

Some languages even enforce this by design:  

<ul>
<li>Java was meant to reduce the amount of dull crap you can write with
it (though no doubt many manage to do it).</li>
<li><p>Python's block structure by indentation is another idea in this
sense.</p></li>
<li><p>Go, with its `gofmt` tool, which completely takes away any debate
and effort (<strong>and ego!!</strong>) inherent to style: run `gofmt` before
you commit.</p></li>
</ul>

<p>Make sure that <strong>code rot</strong> cannot slip through. <strong>Code
conventions</strong>, <strong>continuous integration</strong> and <strong>continuous
inspection</strong>, <strong>pair programming</strong> and <strong>code reviews</strong> are your
arsenal against this demon.</p>

<p>Plus, as you'll see below, <strong>code is documentation</strong>, and that's
another area where conventions encourage readability and clarity.</p>

<h5>Rigidity of the Documentation</h2>

<p>Documentation goes hand in hand with code. Code itself is
documentation. But there must be clear-cut instructions on how to
build, use, and maintain things.</p>

<p>Using a single point of control for documentation (like a WikiWiki or
DMS) is a good thing. Create spaces for projects, spaces for more
random banter and experimentation. Have all spaces reuse common rules
and conventions. Try to make it part of the team spirit.</p>

<p><em>Most of the advice applying to code and tooling also applies to
documentation.</em></p>

<h5>Rigidity in Code Comments</h3>

<p>Code comments, as mentioned above, are also documentation. Developers
like to express their feelings about their code (mostly pride and
frustration, if you ask me). So it's not unusual for them to express
these in no uncertain terms in comments (or even code), when a more
formal piece of text could have conveyed the same meaning with less
expletives or drama. It's OK to let a few slip through for fun and
historical reasons: it's also part of <strong>developing a team
culture</strong>. But it's very important that everybody knows what is
acceptable and what isn't, and that comment noise is just that:
<strong>noise</strong>.</p>

<h5>Rigidity in Commit Logs</h3>

<p>Commit logs are not an annoying and useless "step" of your SCM's
lifecycle: you DON'T skip it to get home on time or get on with the
next task, or to catch up with the buddies who left for lunch.  They
matter, and, like (most) good wine, the more time passes the more valuable
they become. So DO them right. I'm flabbergasted when I see co-workers
writing one-liners for giant commits, or for non-obvious hacks.</p>

<p>Commits are done for a reason, and that reason ISN'T always clearly
expressed by your code and the one line of commit log you
entered. There's more to it than that.</p>

<p><strong>Each line of code has a <em>story</em>, and a <em>history</em></strong>. The diffs can tell
its history, but you have to write its story.</p>

<blockquote>
  Why did I update this line? -> Because the interface changed.  
  
  <p>Why did the interface changed? -> Because the library L1 defining it
  was updated.</p>
  
  <p>Why was the library updated? -> Because library L2, that we need for
  feature F, depended on library L1.</p>
  
  And what's feature X? -> See task 3456 in issue tracker.  
</blockquote>

<p>It's not my SCM choice, and may not be the best one for your lab
either; but `Git` gets this right, and tries to force you to write
good logs more than most other SCMs systems, by using `short logs` and
`long logs`. Link the task ID (yes, you need one) and a leave a
generic summary for the `shortlog`, and expand in the long log: write
the changeset's <strong>story</strong>.</p>

<strong>It is a log:</strong> It's here to keep track and record updates.  

<blockquote>
  <p><strong>Rule of Thumb:</strong> If you were searching for something about this
  change later, is your log likely to answer your question?</p>
</blockquote>

<h5>Projects, Documentation and Code Are ALIVE</h3>

<p>Keep them in sync, otherwise they do not form that symbiotic entity
anymore. It works wonders when you have:</p>

<ul>
<li>clear commits logs in your SCM, w/ links to task IDs in your
issue tracker,</li>
<li>where this tracker's tickets themselves link to the changesets in
your SCM (and possibly to the builds in your CI system),</li>
<li>and a documentation system that links to all of these.</li>
</ul>

<strong>Code and documentation need to be cohesive</strong>.  

<h5>Rigidity in Testing</h2>

<blockquote>
  <strong>Rules of Thumb:</strong>  
  
  <ul>
  <li>Any new code shall come with (at least) unit tests.</li>
  <li>Any refactored legacy code shall come with unit tests.</li>
  </ul>
</blockquote>

Of course, these need:  

<ul>
<li>to actually test something valuable (or they are a waste of time
and energy),</li>
<li>to be well written and commented (just like any other code you check in).</li>
</ul>

<p>They are documentation as well, and they help to outline the contract
of your code. Especially if you use <a href="http://en.wikipedia.org/wiki/Test-driven_development" rel="nofollow noreferrer">TDD</a>. Even if you don't, you
need them for your peace of mind. They are your safety net when you
incorporate new code (maintenance or feature) and your watchtower
to guard against code rot and environmental failures.</p>

<p>Of course, you should go further and have <a href="http://en.wikipedia.org/wiki/Integration_testing" rel="nofollow noreferrer">integration tests</a>, and
<a href="http://en.wikipedia.org/wiki/Regression_testing" rel="nofollow noreferrer">regression tests</a> for each reproducible bug you fix.</p>

<h5>Rigidity in the Use of the Tools</h2>

<p>It's OK for the occasional developer/scientist to want to try some new
static checker on the source, generate a graph or model using another,
or implement a new module using a DSL. But it's best if there's a
canonical set of tools that <strong>all</strong> team members are expected to know
and use.</p>

Beyond that, let members use what they want, as long as they are ALL:  

<ul>
<li><strong>productive</strong>,</li>
<li><strong>NOT regularly requiring assistance</strong></li>
<li><strong>NOT regularly adjusting to your general infrastructure</strong>,</li>
<li><strong>NOT disrupting your infrastructure</strong> (by modifying common
areas like code, build system, documentation...),</li>
<li><strong>NOT affecting others' work</strong>,</li>
<li><strong>ABLE to timely perform any task requested</strong>.</li>
</ul>

If that's not the case, then enforce that they fallback to defaults.  

<hr>

<h5>Rigidity vs Versatility, Adaptability, Prototyping and Emergencies</h2>

<p>Flexibility can be good. Letting someone occasionally use a hack, a
quick-n-dirty approach, or a favorite pet tool to <strong>get the job done</strong>
is fine. <strong>NEVER</strong> let it become a habit, and <strong>NEVER</strong> let this code
become the actual codebase to support.</p>

<hr>

<h5>Team Spirit Matters</h1>

<h5>Develop a Sense of Pride in Your Codebase</h3>

<ul>
<li>Develop a sense of Pride in Code

<ul>
<li>Use wallboards

<ul>
<li>leader board for a continuous integration game</li>
<li>wallboards for issue management and defect counting</li>
</ul></li>
<li>Use an <a href="http://en.wikipedia.org/wiki/Issue_tracking_system" rel="nofollow noreferrer">issue tracker</a> / <a href="http://en.wikipedia.org/wiki/Bug_tracking_system" rel="nofollow noreferrer">bug tracker</a></li>
</ul></li>
</ul>

<h5>Avoid Blame Games</h3>

<ul>
<li>DO use Continuous Integration / Continuous Inspection games: it
fosters good-mannered and <a href="http://www.codinghorror.com/blog/2009/05/how-to-motivate-programmers.html" rel="nofollow noreferrer">productive competition</a>.</li>
<li>DO keep track defects: it's just good house-keeping.</li>
<li>DO <strong>identifying root causes</strong>: it's just future-proofing processes.</li>
<li>BUT DO NOT <a href="https://softwareengineering.stackexchange.com/questions/83038/who-is-responsible-for-defects-found-during-development">assign blame</a>: it's counter productive.</li>
</ul>

<h5>It's About the Code, Not About the Developers</h3>

<p>Make developers conscious of the quality of their code, BUT make them
see the code as a detached entity and not an extension of
themselves, which cannot be criticized.</p>

<p>It's a paradox: you need to encourage <a href="http://www.codinghorror.com/blog/2006/05/egoless-programming-you-are-not-your-job.html" rel="nofollow noreferrer">ego-less programming</a> for a
healthy workplace but to rely on ego for motivational purposes.</p>

<hr>

<h5>From Scientist to Programmer</h1>

<p>People who do not value and take pride in code do not produce good
code. For this property to emerge, they need to discover how valuable
and fun it can be. Sheer professionalism and desire to do good is not
enough: it needs passion. So you need to turn your scientists into
<strong>programmers</strong> (in the large sense).</p>

<p>Someone argued in comments that after 10 to 20 years on a project and
its code, anyone would feel attachment. Maybe I'm wrong but I assume
they're proud of the code's outcomes and of the work and its legacy,
not of the code itself or of the act of writing it.</p>

<p>From experience, most researchers regard coding as a necessity, or at
best as a fun distraction. They just want it to work. The ones who are
already pretty versed in it and who have an interest in programming
are a lot easier to persuade of adopting best practices and switching
technologies. You need to get them halfway there.</p>

<hr>

<h5>Code Maintenance is Part of Research Work</h1>

<p>Nobody reads crappy research papers. That's why they are
peer-reviewed, proof-read, refined, rewritten, and approved time and
time again until deemed ready for publication. The same applies to a
thesis <strong>and a codebase!</strong></p>

<p>Make it clear that constant refactoring and refreshing of a codebase
prevents code rot and reduces technical debt, and facilitates future
re-use and adaptation of the work for other projects.</p>

<hr>

<h5>Why All This??!</h1>

<p>Why do we bother with all of the above? For <strong>code quality</strong>. Or is it
<strong>quality code</strong>...?</p>

<p>These guidelines aim at driving your team towards this goal. Some
aspects do it by simply showing them the way and letting them do it
(which is much better) and others take them by the hand (but that's
how you educate people and develop habits).</p>

How do you know when the goal is within reach?  

<h5>Quality is Measurable</h2>

<p>Not always quantitatively, but it <strong>is measurable</strong>. As mentioned, you
need to develop a sense of pride in your team, and showing progress
and good results is key. Measure code quality regularly and show
progress between intervals, and how it matters. Do retrospectives to
reflect on what has been done, and how it made things better or worse.</p>

<p>There are great tools for <strong>continuous inspection</strong>. <a href="http://www.sonarsource.org/" rel="nofollow noreferrer">Sonar</a> being
a popular one in the Java world, but it can adapt to any technologies;
and there are many others. Keep your code under the microscope and
look for these pesky annoying bugs and microbes.</p>

<hr>

<h5>But What if My Code is Already Crap?</h1>

<p>All of the above is fun and cute like a trip to Never Land, but it's
not that easy to do when you already have (a pile of steamy and
smelly) crap code, and a team reluctant to change.</p>

Here's the secret: <strong>you need to start somewhere</strong>.  

<blockquote>
  <p><strong>Personal anecdote:</strong> In a project, we worked with a codebase
  weighing originally 650,000+ Java LOC, 200,000+ lines of JSPs,
  40,000+ JavaScript LOC, and 400+ MBs of binary dependencies.</p>
  
  <p>After about 18 months, it's 500,000 Java LOC <strong>(MOSTLY CLEAN)</strong>,
  150,000 lines of JSPs, and 38,000 JavaScript LOC, with dependencies
  down to barely 100MBs (and these are not in our SCM anymore!).</p>
  
  <strong>How did we do it?</strong> <em>We just did all of the above. Or tried hard.</em>  
  
  <p>It's a team effort, but we slowly <strong>inject</strong> in our process
  regulations and tools to monitor the heart-rate of our product,
  while hastily <strong>slashing</strong> away the "fat": crap code, useless
  dependencies... We didn't stop all development to do this: we have
  occasional periods of relative peace and quiet where we are free to
  go crazy on the codebase and tear it apart, but most of the time we
  do it all by defaulting to a "review and refactor" mode every chance
  we get: during builds, during lunch, during bug fixing sprints,
  during Friday afternoons...</p>
  
  <p>There were some big "works"... Switching our build
  system from a giant Ant build of 8500+ XML LOC to a
  multi-module Maven build was one of them. We then had:</p>
  
  <ul>
  <li>clear-cut modules (or at least it was already a lot better, and we
  still have big plans for the future),</li>
  <li>automatic dependency management (for easy maintenance and updates, and
  to remove useless deps),</li>
  <li>faster, easier and reproduceable builds,</li>
  <li>daily reports on quality.</li>
  </ul>
  
  <p>Another was the injection of "utility tool-belts", even though we
  were trying to reduce dependencies: Google Guava and Apache Commons
  slim down your code and and reduce surface for bugs in <strong>your</strong> code
  a lot.</p>
  
  <p>We also persuaded our IT department that maybe using our new tools
  (JIRA, Fisheye, Crucible, Confluence, Jenkins) was better than the
  ones in place. We still needed to deal with some we despised (QC,
  Sharepoint and SupportWorks...), but it was an overall improved
  experience, with some more room left.</p>
  
  <p>And every day, there's now a trickle of between one to dozens of
  commits that deal only with fixing and refactoring things. We
  occasionally break stuff (you need unit tests, and you better write
  them <strong>before</strong> you refactor stuff away), but overall the benefit
  for our morale AND for the product has been enormous. We get there
  one fraction of a code quality percentage at a time. <strong>And it's fun
  to see it increase!!!</strong></p>
</blockquote>

<p><em><strong>Note:</strong> Again, rigidity needs to be shaken to make room for new and
better things. In my anecdote, our IT department is partly right in
trying to impose <strong>some</strong> things on us, and wrong for others. Or maybe
they <strong>used to be right</strong>.  Things change. Prove that they are better
ways to boost your productivity. <strong>Trial-runs and prototypes</strong> are
here for this.</em></p>

<hr>

<h5>The Super-Secret Incremental Spaghetti Code Refactoring Cycle for Awesome Quality</h1>

```
       +-----------------+      +-----------------+
       |  A N A L Y Z E  +----->| I D E N T I F Y |
       +-----------------+      +---------+-------+
                ^                           |
                |                           v
       +--------+--------+      +-----------------+
       |    C L E A N    +<-----|      F I X      |
       +-----------------+      +-----------------+
```

Once you have some quality tools at your toolbelt:  

<ol>
<li><p><strong>Analyze</strong> your code with code quality checkers.</p>

Linters, static analyzers, or what have you.  </li>
<li><p><strong>Identify</strong> your <strong>critical</strong> hotspots AND <strong>low hanging fruits</strong>.</p>

<p>Violations have severity levels, and large classes with a large number
 of high-severity ones are a big red flag: as such, they appear as
 "hot spots" on radiator/heatmap types of views.</p></li>
<li><p><strong>Fix</strong> the hotspots first.</p>

<p>It maximizes your impact in a short timeframe as they have
 the highest business value. Ideally, critical violations should
 dealt with as soon as they appear, as they are potential security
 vulnerabilities or crash causes, and present a high risk of inducing a
 liability (and in your case, bad performance for the lab).</p></li>
<li><p><strong>Clean</strong> the low level violations with <strong>automated codebase sweeps</strong>.</p>

<p>It improves the <strong>signal-to-noise ratio</strong> so you are be able to
 see significant violations on your radar as they appear. There's often
 a large army of minor violations at first if they were never taken care
 of and your codebase was left loose in the wild. They do not present a
 real "risk", but they impair the code's readability and maintainability.
 Fix them either as you meet them while working on a task, or by large
 cleaning quests with automated code sweeps if possible. Do be
 careful with large auto-sweeps if you don't have a good test suite
 and integration system. Make sure to agree with co-workers
 the right time to run them to minimize the annoyance.</p></li>
<li><p><strong>Repeat</strong> until you are satisfied. </p>

<p>Which, ideally, you should never be, if this is still an
 active product: it will keep evolving.</p></li>
</ol>

<h5>Quick Tips for Good House-Keeping</h3>

<ul>
<li><p><strong>When in hotfix-mode</strong>, based on a customer support request:</p>

<ul>
<li>It's usually a best practice to <strong>NOT</strong> go around fixing other issues,
as you might introduce new ones unwillingly.</li>
<li>Go at it <strong>SEAL-style: get in, kill the bug, get out</strong>, and ship your
patch. It's a surgical and tactical strike.</li>
</ul></li>
<li><p><strong>But for all other cases</strong>, if you open a file, make it your duty to:</p>

<ul>
<li><em>definitely:</em> <strong>review</strong> it (take notes, file issue reports),</li>
<li><em>maybe:</em> <strong>clean</strong> it (style cleanups and minor violations),</li>
<li><em>ideally:</em> <strong>refactor</strong> it (reorganize large sections and their neigbors).</li>
</ul></li>
</ul>

<p>Just don't get sidetracked into spending a week from file to file and
ending up with a massive changeset of thousands of fixes spanning multiple
features and modules - it makes future tracking difficult. One issue in
code = one ticket in your tracker. Sometimes, a changeset can impact multiple
tickets; but if it happens too often, then you're probably doing something wrong.</p>

<hr>

<h5>Addendum: Managing Visual Programming Environments</h1>

<h5>The Walled Gardens of Bespoke Programming Systems</h2>

Multiple programming systems, like the OP's G2, are different beasts...  

<ul>
<li><p><strong>No Source "Code"</strong></p>

<p>Often they do not give you access to a textual representation of
your source "code": it might be stored in a proprietary binary
format, or maybe it does store things in text format but hides
them away from you. Bespoke graphical programming systems are
actually not uncommon in research labs, as they simplify the
automation of repetitive data processing workflows.</p></li>
<li><p><strong>No Tooling</strong></p>

<p>Aside from their own, that is. You are often constrained by their
programming environment, their own debugger, their own
interpreter, their own documentation tools and formats. They are
<strong>walled gardens</strong>, except if they eventually capture the interest
of someone motivated enough to reverse engineer their formats and
builds external tools - if the license permits it.</p></li>
<li><p><strong>Lack of Documentation</strong></p>

<p>Quite often, these are niche programming systems, which are used
in fairly closed environments. People who use them frequently sign NDAs
and never speak about what they do. Programming
communities for them are rare. So resources are scarce. You're
stuck with your official reference, and that's it.</p></li>
</ul>

<p>The ironic (and often frustrating) bit is that all the things these
systems do could obviously be achieved by using mainstream and general
purpose programming languages, and quite probably more
efficiently. But it requires a deeper knowledge of programming,
whereas you can't expect your biologist, chemist or physicist (to name
a few) to know enough about programming, and even less to have the
time (and desire) to implement (and maintain) complex systems, that
may or may not be long-lived. For the same reason we use DSLs, we have
these bespoke programming systems.</p>

<blockquote>
  <p><strong>Personal Anecdote 2:</strong> Actually, I worked on one of these
  myself. I didn't do the link with the OP's request, but my the
  project was a set of inter-connected large pieces of
  data-processing and data-storage software (primarily for
  bio-informatics research, healthcare and cosmetics, but also for
  business intelligence, or any domain implying the tracking of
  large volumes of research data of any kind and the preparation of
  data-processing workflows and ETLs). One of these applications was,
  quite simply, a visual IDE that used the usual bells and whistles:
  drag and drop interfaces, versioned project workspaces (using text
  and XML files for metadata storage), lots of pluggable drivers to
  heterogeneous datasources, and a visual canvas to design pipelines
  to process data from N datasources and in the end generate M
  transformed outputs, and possible shiny visualizations and complex
  (and interactive) online reports. Your typical bespoke visual
  programming system, suffering from a bit of NIH syndrome under the
  pretense of designing a system adapted to the users' needs.</p>
  
  <p>And, as you would expect, it's a nice system, quite flexible for its
  needs though sometimes a bit over-the-top so that you wonder "why
  not use command-line tools instead?", and unfortunately always
  leading in medium-sized teams working on large projects to a lot of
  different people using it with different "best" practices.</p>
</blockquote>

<h5>Great, We're Doomed! - What Do We Do About It?</h2>

<p>Well, in the end, all of the above still holds. If you cannot extract
most of the programming from this system to use more mainstream tools
and languages, you "just" need to adapt it to the constraints of your
system.</p>

<h5>About Versioning and Storage</h3>

<p>In the end, you can almost always <strong>version</strong> things, even with the
most constrained and walled environment. Most often than not, these
systems still come with their own versioning (which is unfortunately
often rather basic, and just offers to revert to previous versions
without much visibility, just keeping previous snapshots). It's not
exactly using differential changesets like your SCM of choice might,
and it's probably not suited for multiple users submitting changes
simultaneously.</p>

<p>But still, if they do provide such a functionality, maybe your
solution is to follow our beloved industry-standard guidelines above,
and to transpose them to this programming system!!</p>

<p>If the storage system is a database, it probably exposes export
functionalities, or can be backed-up at the file-system level. If it's
using a custom binary format, maybe you can simply try to version it
with a VCS that has good support for binary data. You won't have
fine-grained control, but at least you'll have your back sort of
covered against catastrophes and have a certain degree of disaster
recovery compliance.</p>

<h5>About Testing</h3>

<p>Implement your tests within the platform itself, and use external
tools and background jobs to set up regular backups. Quite probably,
you fire up these tests the same that you would fire up the programs
developed with this programming system.</p>

<p>Sure, it's a hack job and definitely not up to the standard of what is
common for "normal" programming, but the idea is to adapt to the
system while trying to maintain a semblance of professional software
development process.</p>

<h5>The Road is Long and Steep...</h3>

<p>As always with niche environments and bespoke programming systems, and
as we exposed above, you deal with strange formats, only a limited (or
totally inexistant) set of possibly clunky tools, and a void in place
of a community.</p>

<p><strong>The Recommendation:</strong> Try to implement the above guidelines outside
of your bespoke programming system, as much as possible. This ensures
that you can rely on "common" tools, which have proper support and
community drive.</p>

<p><strong>The Workaround:</strong> When this is not an option, try to retrofit this
global framework into your "box". The idea is to overlay this
blueprint of industry standard best practices on top of your
programming system, and make the best of it. The advice still applies:
define structure and best practices, encourage conformance.</p>

<p>Unfortunately, this implies that you may need to dive in and do a
tremendous amount of leg-work. So...</p>

<strong>Famous Last Words, and Humble Requests:</strong>  

<ul>
<li><strong>Document</strong> everything you do.</li>
<li><strong>Share</strong> your experience.</li>
<li><strong>Open Source</strong> any tool your write.</li>
</ul>

By doing all of this, you will:  

<ul>
<li>not only increase your chances of getting support from people in
similar situations,</li>
<li>but also provide help to other people, and foster discussion
around your technology stack.</li>
</ul>

<p>Who knows, you could be at the very beginning of a new vibrant
community of <em>Obscure Language X</em>. If there are none, start one!</p>

<ul>
<li>Ask questions on <a href="https://stackoverflow.com/">Stack Overflow</a>,</li>
<li>Maybe even write a proposal for a new StackExchange Site in the
<a href="http://area51.stackexchange.com/">Area 51</a>.</li>
</ul>

<p><strong>Maybe it's beautiful inside</strong>, but <strong>nobody has a clue</strong> so far, so
help <strong>take down this ugly wall</strong> and <strong>let others have a peek!</strong></p>

#### Answer 2 (score 101)
The very <strong>first step</strong> would be <strong>introduction of a Version Control System</strong> (SVN, Git, Mercurial, TFS, etc.). This is must to have for a project that will have re-factoring.  

<strong>Edit:</strong> regarding VSC - Every source control package can manage binaries, although with some limitations. Most of the tools in the market has the ability to use a custom difference viewer and editor, use this capability. <strong>Binary source files is not an excuse</strong> not to use version control.   

There is a similar post on how to <strong>deal with legacy code</strong>, it might be a good reference to follow - <a href="https://stackoverflow.com/q/4760074/1437962">Advice on working with legacy code</a>  

#### Answer 3 (score 43)
When I have to work with spaghetti code, the first thing I work on is <em>modularization</em>.  Find places where you can draw lines and extract (more or less) independent pieces of the codebase.  They probably won't be very small, due to a high degree of interconnectedness and coupling, but some module lines will emerge if you look for them.  

Once you have modules, then you're not faced with the daunting task of cleaning up an entire messy program anymore. Now, instead, you have several smaller independent messy modules to clean up.  Now pick a module and repeat on a smaller scale.  Find places where you can extract big functions into smaller functions or even classes (if G2 supports them).  

This is all a lot easier if the language has a sufficiently strong type system, because you can get the compiler to do a lot of the heavy lifting for you.  You make a change somewhere that will (intentionally) break compatibility, then try to compile.  The compile errors will lead you directly to the places that need to be changed, and when you stop getting them, you've found everything.  <strong>Then run the program and test everything!</strong>  Continuous testing is crucially important when refactoring.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Why are people making tables with divs? (score [175571](https://stackoverflow.com/q/277778) in 2015)

#### Question
In modern web development I'm coming across this pattern ever more often. It looks like this:  

```
<div class="table">
    <div class="row">
        <div class="cell"></div>
        <div class="cell"></div>
        <div class="cell"></div>
    </div>
</div>
```

And in CSS there is something like:  

```
.table { display: table; }
.row { display: table-row; }
.cell { display: table-cell; }
```

<sup>* (Class name are illustrative only; in real life those are normal class names reflecting what the element is about)</sup>  

I even recently tried doing this myself because... you know, everyone's doing it.  

But I still don't get it. Why are we doing this? If you need a table, then just make a blasted `<table>` and be done with it. Yes, even if it's for layout. That's what tables are for - laying out stuff in tabular fashion.  

The best explanation that I have is that by now everyone has heard the mantra of "don't use tables for layout", so they follow it blindly. But they still <em>need</em> a table for layout (because nothing else has the expanding capabilities of a table), so they make a `<div>` (because it's <strong>not</strong> a table!) and then add CSS that makes it a table anyway.  

For all the world this looks to me like putting arbitrary unnecessary obstacles in your way and then doing extra work to circumvent them.  

The original argument for moving away from tables for layout was that it's hard to modify a tabular layout afterwards. But modifying a "faux-table" layout is just as hard, and for the same reasons. In fact, in practice modifying a layout is always hard, and it's almost never enough to just change the CSS, if you want to do something more serious than minor tweaks. You <strong>will</strong> need to understand and change HTML structure for serious design changes. And tables don't make the job any harder or easier than divs.  

In fact, the only way I see that tables could make a layout difficult to modify, is if you <i>ab</i>used them and created an ungodly mess. You can do that with divs too.  

So... in an attempt to change this from a rant into a coherent question: what am I missing? What are the <strong>actual</strong> benefits of using a "faux-table" over a real one?  

<strong>About the duplicate link:</strong> This isn't a suggestion to use another tag or something. This is a question about using a `<table>` vs `display:table`.  

#### Answer accepted (score 120)
This is a common pattern for making responsive tables. Tabular data is tricky to display on mobiles since the page will either be zoomed in to read text, meaning tables go off the side of the page and the user has to scroll backwards and forwards to read the table, or the page will be zoomed out, usually meaning that the table is too small to be able to read.  

Responsive tables change layout on smaller screens - sometimes some columns are hidden or columns are amalgamated, e.g. name and email address might be separate on large screens, but collapse down into one cell on small screens so the information is readable without having to scroll.  

`<div>`s are used to create the tables instead of `<table>` tags for a couple of reasons. If `<table>` tags are used then you need to override the browser default styles and layout before adding your own code, so in this case `<div>` tags save on a lot of boilerplate CSS. Additionally, older versions of IE don't allow you to override default table styles, so using `<div>`s also smooths cross-browser development.  

There's a pretty good <a href="https://css-tricks.com/responsive-data-tables/">overview of responsive tables on CSS-Tricks</a>.  

Edit: I should point out that I'm not advocating this pattern - it falls into the divitis trap and isn't semantic - but this is why you'll find tables made from `div`s.  

#### Answer 2 (score 153)
The question is if the data is semantically a table (i.e. a set of data or units of information logically organized in two dimensions) or you just use the grid for visual layout, e.g. because you want a sidebar to expand or something like that.  

If your information is semantically a table, you use a `<table>`-tag. If you just want a grid for layout purposes, you use some other appropriate html elements and use `display:table` in the style sheet.  

<strong>When</strong> is data semantically a table? When the data is logically organized along two axes. If it makes sense with headers for the rows or columns, then you might have a semantic table. An example of something which is not semantically a table is presenting a text in columns like in a newspaper. This is not semantically a table, since you would still read it linearly, and no meaning would be lost if the presentation was removed.  

<hr>

OK, <strong>why</strong> not use `<table>` for everything rather than only for something that is semantically a table? Visually it is obviously the same (since the table element just have `display:element` in the default style sheet).   

The difference is that the semantic information can help alternative user agents. For example a screen reader might allow you to navigate in two dimensions in the table, and read the headers for a cell for both axes if you forget where you are. This would just be confusing if the table was not semantically a table but just used for visual layout.  

<p>The `<table>` versus `display:table` discussion is just a case of the more general principle of using semantic markup. 
See for example: <a href="https://softwareengineering.stackexchange.com/questions/164988/why-would-one-bother-marking-up-properly-and-semantically?lq=1">Why would one bother marking up properly and semantically?</a> or <a href="https://softwareengineering.stackexchange.com/questions/165618/why-is-semantic-markup-given-more-weight-for-search-engines?lq=1">Why is semantic markup given more weight for search engines?</a></p>

In some places you might actually be legally required to use semantic markup for accessibility reasons, and in any case there is no reason to purposefully make your page less accessible.   

Even if you don't care for disabled users, having presentation separate from content gives you benefits. E.g. your three column layout could be presented in a single columns on a mobile using an alternative stylesheet.  

#### Answer 3 (score 102)
Actually, I would say that the use of class names like "table" in your example demonstrates how people don't actually understand what they're doing when trying for semantic markup. They get marks for trying to show that the <a href="http://www.w3.org/html/wg/drafts/html/master/semantics.html#the-table-element">content is not tabular data</a>, but they lose marks for bad class names.  

```
<div class="table">
  <div class="row">
    <div class="cell"></div>
    <div class="cell"></div>
    <div class="cell"></div>
  </div>
</div>
```

All that this developer has done is replicate the original `<table>` markup with CSS class names. This means as soon as this layout is not a table, the class names are at odds.  

What this developer should have done is consider what information is in the table - is it a thumbnail gallery? Well, then:  

```
<div class="thumbnail-gallery">
  <div>
    <div class="thumbnail">
      <img src="" />
      Some text  
    </div>
    <div class="thumbnail">
      <img src="" />
      Some text  
    </div>
    <div class="thumbnail">
      <img src="" />
      Some text  
    </div>
  </div>
</div>
```

Now I can create some adaptive CSS:  

```
@media screen {
  .thumbnail-gallery {
    display: table;
    border-collapse: collapse;
    width: 100%;
  }

  .thumbnail-gallery > div {
    display: table-row;
  }

  .thumbnail-gallery .thumbnail {
    display: table-cell;
    border: 1px solid #333333;
  }
}

@media screen and (max-width: 640px) {
  /** reset all thumbnail gallery elements to display as block and fill screen **/
  .thumbnail-gallery,
  .thumbnail-gallery > div,
  .thumbnail-gallery .thumbnail {
    display: block;
    width: 100%;
  }
}
```

<strong>Why divs and not tables</strong>  

<a href="http://www.w3.org/html/wg/drafts/html/master/semantics.html#the-table-element">A table contains tabular data</a> - presentation of a table is inextricably linked to the structure of a table. Tabular data will always need to be in tabular form no matter where you put that content or on what screen/device you want it to display.  

A thumbnail gallery (or many other things, like a registration form, a menu, and more) is not tabular data. It may be presented like a table in some design layouts, but in other cases, like narrow phone screens, you want it using more traditional block layouts. Or perhaps you want to display thumbnails in a sidebar instead of in the main content area.   

Your choice is now to output different markup for the wide screen content (tables) and sidebar or narrow screen content (divs) - which means your server side scripts will have to be aware of where the content is going if you're building this programmatically - or you have your server side script output the same markup (because it shouldn't care where you're putting this) and use different CSS rules for the different situations.  

So, then you have a choice of always outputting tables, and then overriding the natural table display rules with block (which really should grind some gears in any developers head), or going with well labelled divs which allow more flexible approaches to styling.  

And <a href="https://www.google.com.au/webhp?sourceid=chrome-instant&amp;ion=1&amp;espv=2&amp;ie=UTF-8&amp;client=ubuntu#q=divs%20not%20tables">best practices for several years now</a> has been to avoid tables when not needing to present tabular data.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: What is the difference between writing test cases for BDD and TDD? (score [173162](https://stackoverflow.com/q/135218) in 2015)

#### Question
I have been learning writing test cases for BDD (Behavior Driven Development) using specflow. If I write comprehensive tests with BDD, is it necessary to write TDD (Test Driven Development) test separately? Is it necessary to write test cases for both TDD and BDD separately, or are they effectively the same thing?   

It seems to me that both are same, the only difference being that BDD test cases can be understood by non developers and testers.  

#### Answer accepted (score 213)
The difference between BDD and TDD is that BDD begins with a B and TDD begins with a T. But seriously, the gotcha with TDD is that too many developers focused on the "How" when writing their unit tests, so they ended up with very brittle tests that did nothing more than confirm that the system does what it does.  

BDD provides a new vocabulary and thus focus for writing a unit test. Basically it is a feature driven approach to TDD.   

#### Answer 2 (score 50)
Behavior Driven Development is an extension/revision of Test Driven Development.  Its purpose is to help the folks devising the system (i.e., the developers) identify appropriate tests to write -- that is, tests that reflect the behavior desired by the stakeholders.  The effect ends up being the same -- develop the test and then develop the code/system that passes the test.  The hope in BDD is that the tests are actually useful in showing that the system meets the requirements.  

<strong>UPDATE</strong>  

Units of code (individual methods) may be too granular to represent the behavior represented by the behavioral tests, but you should still test them with unit tests to guarantee they function appropriately.  If this is what you mean by "TDD" tests, then yes, you still need them.  

#### Answer 3 (score 26)
BDD utilizes something called a "Ubiquitous Language," a body of knowledge that can be understood by both the developer and the customer.  This ubiquitous language is used to shape and develop the requirements and testing needed, at the level of the customer's understanding.  

Within the confines of the requirements and testing dictated by BDD, you will use "ordinary" TDD to develop the software.  The unit tests so created will serve as a test suite for your implementing code, while the BDD tests will function more or less as acceptance tests for the customer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Designing a REST api by URI vs query string (score [172768](https://stackoverflow.com/q/270898) in )

#### Question
Let's say I have three resources that are related like so:  

```
Grandparent (collection) -> Parent (collection) -> and Child (collection)
```

The above depicts the relationship among these resources like so: Each grandparent can map to one or several parents. Each parent can map to one or several children. I want the ability to support searching against the child resource but with the filter criteria:  

<strong>If my clients pass me an id reference to a grandparent, I want to only search against children who are direct descendants of that grandparent.</strong>  

<strong>If my clients pass me an id reference to a parent, I want to only search against children who are direct descendants of my parent.</strong>  

I have thought of something like so:  

```
GET /myservice/api/v1/grandparents/{grandparentID}/parents/children?search={text}
```

and  

```
GET /myservice/api/v1/parents/{parentID}/children?search={text}
```

for the above requirements, respectively.  

But I could also do something like this:  

```
GET /myservice/api/v1/children?search={text}&grandparentID={id}&parentID=${id}
```

In this design, I could allow my client to pass me one or the other in the query string: either grandparentID or parentID, but not both.  

My questions are:  

1) Which API design is more RESTful, and why? Semantically, they mean and behave the same way. The last resource in the URI is "children", effectively implying that the client is operating on the children resource.  

2) What are the pros and cons to each in terms of understandability from a client's perspective, and maintainability from the designer's perspective.  

3) What are query strings really used for, besides "filtering" on your resource? If you go with the first approach, the filter parameter is embedded in the URI itself as a path parameter instead of a query string parameter.  

Thanks!  

#### Answer accepted (score 64)
<h5>First</h2>

As Per <a href="https://tools.ietf.org/html/rfc3986#section-3.4" rel="noreferrer">RFC 3986 §3.4 (Uniform Resource Identifiers § (Syntax Components)|Query</a>  

<blockquote>
  <strong>3.4 Query</strong>  
  
  <p>The query component contains non-hierarchical data that, along with
     data in the path component (Section 3.3), serves to identify a
     resource within the scope of the URI's scheme and naming authority
     (if any).</p>
</blockquote>

Query components are for retrieval of non-hierarchical data; there are few things more hierarchical in nature than a family tree!  Ergo <em>- regardless of whether you think it is "REST-y" or not-</em> in order to conform to the formats, protocols, and frameworks of and for developing systems on the internet, you must not use the query string to identify this information.  

REST has nothing to do with this definition.  

Before addressing your specific questions, your query parameter of "search" is poorly named.  Better would be to treat your query segment as a dictionary of key-value pairs.    

Your query string could be more appropriately defined as   

`?first_name={firstName}&last_name={lastName}&birth_date={birthDate}` etc.  

<h5>To answer your specific questions</h2>

<blockquote>
  1) Which API design is more RESTful, and why? Semantically, they mean and behave the same way. The last resource in the URI is "children", effectively implying that the client is operating on the children resource.  
</blockquote>

I don't think this is as clear cut as you seem to believe.  

None of these resource interfaces are RESTful.  The <strong>major</strong> precondition for the RESTful architectural style is that Application State transitions must be communicated from the server as hypermedia.  People have labored over the structure of URIs to make them somehow "RESTful URIs" but the formal literature regarding REST actually has very little to say about this. My personal opinion is that much of the meta-misinformation about REST was published with the intent of breaking old, bad habits. (Building a truly "RESTful" system is actually quite a bit of work. The industry glommed on to "REST" and back-filled some orthogonal concerns with nonsensical qualifications and restrictions. )  

What the REST literature does say is that if you are going to use HTTP as your application protocol, you must adhere to the formal requirements of the protocol's specifications and you cannot "make http up as you go and still declare that you are using http"; if you are going to use URIs for identifying your resources, you must adhere to the formal requirements of the specifications regarding URI/URLs.  

Your question is addressed directly by RFC3986 §3.4, which I have linked above.  The bottom line on this matter is that even though a conforming URI is insufficient to consider an API "RESTful", if you want your system to actually <em>be</em> "RESTful" and you are using HTTP and URIs, then you cannot identify hierarchical data through the query string because:  

<blockquote>
  <strong>3.4 Query</strong>  
  
  The query component contains non-hierarchical data  
</blockquote>

...it's as simple as that.  

<blockquote>
  2) What are the pros and cons to each in terms of understandability from a client's perspective, and maintainability from the designer's perspective.  
</blockquote>

The "pros" of the first two is that they are <em>on the right path</em>. The "cons" of the third one is that it appears to be flat out wrong.  

As far as your understandability and maintainability concerns, those are definitely subjective and depend on the comprehension level of the client developer and the design chops of the designer.  The URI specification is the definitive answer as to how URIs are supposed to be formatted.  Hierarchical data is supposed to be represented on the path and with path parameters.  Non-hierarchical data is supposed to be represented in the query.  The fragment is more complicated, because its semantics depend specifically upon the media type of the representation being requested.  So to address the "understandability" component of your question, I will attempt to translate exactly what your first two URIs are actually saying. Then, I will attempt to represent what you say you are trying to accomplish with valid URIs.  

<p><strong>Translation of your verbatim URIs to their semantic meaning</strong>
`/myservice/api/v1/grandparents/{grandparentID}/parents/children?search={text}`
This says for the parents of grandparents, find their child having `search={text}`
What you said with your URI is only coherent if searching for a grandparent's siblings.  With your "grandparents, parents, children" you found a "grandparent" went up a generation to their parents and then came back down to the "grandparent" generation by looking at the parents' children.  </p>

<p>`/myservice/api/v1/parents/{parentID}/children?search={text}`
This says that for the parent identified by {parentID}, find their child having `?search={text}` This is closer to correct to what you are wanting, and represents a parent->child relationship that can likely be used to model your entire API.  To model it this way, the burden is placed upon the client to recognize that if they have a "grandparentId", that there is a layer of indirection between the ID they have and the portion of the family graph they are wishing to see.  To find a "child" by "grandparentId", you can call your `/parents/{parentID}/children` service and then foreach child that is returned, search their children for your person identifier.</p>

<p><strong>Implementation of your requirements as URIs</strong>
If you want to model a more extensible resource identifier that can walk the tree, I can think of several ways you can accomplish that.</p>

<strong>1)</strong> The first one, I've already alluded to.  Represent the graph of "People" as a composite structure. Each person has a reference to the generation above it through its Parents path and to a generation below it through its Children path.   

<p>`/Persons/Joe/Parents/Mother/Parents` 
would be a way to grab Joe's maternal grandparents.</p>

<p>`/Persons/Joe/Parents/Parents` 
would be a way to grab all of Joe's grandparents.</p>

<p>`/Persons/Joe/Parents/Parents?id={Joe.GrandparentID}` 
would grab Joe's grandparent having the identifier you have in hand.</p>

and these would all make sense (note that there could be a performance penalty here depending on task by forcing a dfs on the server due to a lack of branch identification in the "Parents/Parents/Parents" pattern.)  You also benefit from having the ability to support any arbitrary number of generations.  If, for some reason, you desire to look up 8 generations, you could represent this as  

`/Persons/Joe/Parents/Parents/Parents/Parents/Parents/Parents/Parents/Parents?id={Joe.NotableAncestor}`  

but this leads into the second dominant option for representing this data: through a path parameter.  

<hr>

<strong>2)</strong> Use path parameters to "query the hierarchy"  You could develop the following structure to help ease the burden on consumers and still have an API that makes sense.  

To look back 147 generations, representing this resource identifier with path parameters allows you to do  

`/Persons/Joe/Parents;generations=147?id={Joe.NotableAncestor}`  

<p>To locate Joe from his Great Grandparent, you could look down the graph a known number of generations for Joe's Id.
`/Persons/JoesGreatGrandparent/Children;generations=3?id={Joe.Id}`</p>

The major thing of note with these approaches is that without further information in the identifier and request, you should expect that the first URI is retrieving a Person 147 generations up from Joe with the identifier of Joe.NotableAncestor. You should expect the second one to retrieve Joe.  Assume that what you actually want is for your calling client to be able to retrieve the entire set of nodes and their relationships between the root Person and the final context of your URI.  You could do that with the same URI (with some additional decoration) and setting an Accept of `text/vnd.graphviz` on your request, which is the IANA registered media type for the `.dot` graph representation.  With that, change the URI to  

`/Persons/Joe/Parents;generations=147?id={Joe.NotableAncestor.Id}#directed`  

<p>with an HTTP Request Header 
`Accept: text/vnd.graphviz` 
and you can have clients fairly clearly communicate that they want the directed graph of the generational hierarchy between Joe and 147 generations prior where that 147th ancestral generation contains a person identified as Joe's "Notable Ancestor."</p>

I'm unsure if text/vnd.graphviz has any pre-defined semantics for its fragment;I could find none in a search for instruction.  If that media type actually does have pre-defined fragment information, then its semantics should be followed to create a conforming URI.  But, if those semantics are not pre-defined, the URI specification states that the semantics of the fragment identifier are unconstrained and instead defined by the server, making this usage valid.  

<hr>

<blockquote>
  3) What are query strings really used for, besides "filtering" on your resource? If you go with the first approach, the filter parameter is embedded in the URI itself as a path parameter instead of a query string parameter.  
</blockquote>

<p>I believe I have already thoroughly beaten this to death, but query strings are not for "filtering" resources. They are for <em>identifying</em> your resource from non-hierarchical data. If you have drilled down your hierarchy with your path by going
`/person/{id}/children/` and you are wishing to identify a <em>specific</em> child or a <em>specific</em> set of children, you would use some attribute that applies to the set you are identifying and include it inside the query.</p>

#### Answer 2 (score 14)
This is where you get it wrong:  

<blockquote>
  If my clients pass me an id reference   
</blockquote>

In a REST systems, client should never be bothered with IDs. The only resource identifiers that the client should know about should be URIs. This is the principle of "uniform interface".  

Think about how clients would interact with your system. Say the user starts browsing through a list of grandparents, he picked one of grandparent's child, that brings him to `/grandparent/123`. If the client should be able to search the children of `/grandparent/123`, then according to "HATEOAS", whatever returned when you do a query on `/grandparent/123` should return a URL to the search interface. This URL should already have whatever data is needed to filter by the current grandparent embedded in it.  

Whether the link looks like `/grandparent/123?search={term}` or `/parent?grandparent=123&search={term}` or `/parent?grandparentTerm=someterm&someothergplocator=blah&search={term}` are inconsequential according to REST. Notice how all of those URLs have the same number of parameters, which is `{term}`, even though they use different criterias. You can switch between any of those URLs or you can mix them up depending on the specific grandparents and the client wouldn't break, because the logical relationship between the resources are the same even though the underlying implementation might differ significantly.  

If you had instead created the service such that it requires `/grandparent/{grandparentID}?search={term}` when you go one way but `/children?parent={parentID}&search={term}` a} when you go another way, that is too much coupling because the client would have to know to interpolate different things on different relations that are conceptually similar.  

Whether you actually go with `/grandparent/123?search={term}` or `/parent?grandparent=123&search={term}` is a matter of taste and whichever implementation is easier for you right now. The important thing is to not require the client to be modified if you change your URL strategy or if you use different strategies on different parents-children relations.  

#### Answer 3 (score 10)
I'm not sure why people think putting the ID values in the URL means its somehow a REST API, REST is about handling verbs, passing resources.   

So if you want to PUT a new user, you'd have to send a fair chunk of data and a POST http request is ideal, so although you might send the key (eg. user id), you'll send the user data (eg name, address) as POST data.  

Now it is a common idiom to put the resource identifier in the URI, but this is more convention than any form of canonical "its not REST if its not in the URI". Remember that <a href="http://www.ics.uci.edu/~fielding/pubs/dissertation/fielding_dissertation.pdf">the original thesis</a> of REST doesn't really mention http at all, its an idiom for handling data in a client-server, not something that is an extension to http (though, obviously, http is our primary form of implementing REST).  

For example, Fielding uses the request of an academic paper as an example. You want to retrieve the resource "Dr John's Paper on the drinking of beers", but you might also want the initial version, or the latest version, so the resource identifier might not be something that is easily referenced as a single ID that can be placed in the URI. REST allows for this and a stated intention behind it is:  

<blockquote>
  <p>REST relies instead on the author
  choosing a resource identifier that best fits the nature of the concept being identified</p>
</blockquote>

So there's nothing stopping you from using a static URI to retrieve your parents, passing in a search term in the query string to identify the exact user you're after. In this case, the 'resource' you're identifying is the set of grandparents (and so the URI contains 'grandparents' as part of the URI. REST includes the concept of 'control data' that is designed for determining which representation of your resource is to be retrieved - the example given in the these is cache control, but also version control - so my request for Dr John's excellent paper can be refined by passing the version as control data, not part of the URI.  

I think an example of REST interface that is not usually mentioned is <a href="http://cr.yp.to/smtp/mail.html">SMTP</a>. When constructing a mail message, you send verbs (FROM, TO etc) with the resource data for each part of the mail message. This is RESTful even though it doesn't use the http verbs, it uses its own set.  

So... whilst you do need to have some resource identification in your URI, it doesn't have to be your id reference. This can happily be sent as control data, in the query string or even in POST data. What you're really identifying in your REST API is that you're after a child, which you already have in your URI.   

So to my mind, reading the definition of REST, you're requesting a child resource, passing in control data (in the form of querystring) to determine which one you want returned. As a result, you cannot make a URI request for a grandparent or parent. You want <em>children</em> returned so the term parent/grandparent or id should definitely not be in such a URI. Children should be.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Is it bad practice to use <?= tag in PHP? (score [169049](https://stackoverflow.com/q/151661) in 2018)

#### Question
I've come across this PHP tag `<?=  ?>` recently and I am reluctant to use it, but it itches so hard that I wanted to have your take on it. I know it is bad practice to use short tags `<?  ?>` and that we should use full tags `<?php  ?>` instead, but what about this one : `<?=  ?>`?  

It would save some typing and it would be better for code readability, IMO. So instead of this:  

```
<input name="someVar" value="<?php echo $someVar; ?>">
```

I could write it like this, which is cleaner :  

```
<input name="someVar" value="<?= $someVar ?>">
```

Is using this operator frowned upon?  

#### Answer accepted (score 212)
<h5>History</h2>

Before the misinformation train goes too far out of the station, there are a bunch of things you need to understand about PHP short tags.  

The primary issue with PHP's short tags is that PHP managed to choose a tag (`<?`) that was used by another syntax, <strong>XML</strong>.  

With the option enabled, you weren't able to raw output the xml declaration without getting syntax errors:  

```
<?xml version="1.0" encoding="UTF-8" ?>
```

This is a big issue when you consider how common XML parsing and management is.  

<h5>What about `<?=`?</h2>

Although `<?` causes conflicts with xml, `<?=` <em>does not</em>. Unfortunately, the options to toggle it on and off were tied to <a href="http://www.php.net/manual/en/ini.core.php#ini.short-open-tag" rel="noreferrer">`short_open_tag`</a>, which meant that to get the benefit of the short echo tag (`<?=`), you had to deal with the issues of the short open tag (`<?`). The issues associated with the short open tag were much greater than the benefits from the short echo tag, so you'll find a million and a half recommendations to turn `short_open_tag` off, which you <em>should</em>.  

With PHP 5.4, however the short echo tag has been re-enabled separate from the `short_open_tag` option. I see this as a direct endorsement of the convenience of `<?=`, as there's nothing fundamentally wrong with it in and of itself.  

The problem is that you can't guarantee that you'll have `<?=` if you're trying to write code that could work in a wider range of PHP versions.  

<sub>ok, so now that that's all out of the way</sub>  

<h5>Should you use `<?=`?</h1>

<img src="https://i.stack.imgur.com/Bgkl8.png" alt="flowchart about whether or not to use the short echo tag">  



#### Answer 2 (score 29)
<em>Dusting off my PHP hat</em>  

I'd definitely favor the use of `<?= $someVar ?>` over the more verbose `echo` (simply personal preference). The <em>only</em> downside AFAIK is for users who are running pre-5.4.0, in which case `short_open_tag` must be enabled in <a href="http://www.php.net/manual/en/ini.core.php#ini.short-open-tag">php.ini</a>.  

Now having said that, if your project isn't OS, then it's a moot point. If it is, I'd either document the fact that `short_open_tag`s must be enabled, or use the more portable of the two solutions.  

#### Answer 3 (score 21)
You should definitely try to avoid short form tags, whether it's `<?` or `<?=`.   

The main technical reason is portability, you can never be sure that the short form tags will work for every given setup, as they can be turned off, lookup the `short_open_tag` directive. But you can always be absolutely certain that the long form will work everywhere.  

<blockquote>
  It would save some typing and it would be better for code readability, IMO.  
</blockquote>

That's also a bad habit. I can't really tell you what you find more readable, but I'm feverishly against using code readability as an excuse to save yourself a couple of keystrokes. If you are concerned about readability, you should go for a template engine, this:  

```
<input name="someVar" value="{someVar}">
```

is far more readable from both your examples.   

Lastly, it's worth noting that short form tags are explicitly discouraged by major PHP projects, for example <a href="http://pear.php.net/manual/en/standards.tags.php">PEAR</a> and <a href="http://framework.zend.com/manual/en/coding-standard.coding-style.html">Zend Framework</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Python file naming convention? (score [168191](https://stackoverflow.com/q/308972) in 2017)

#### Question
I've seen this part of PEP-8 <a href="https://www.python.org/dev/peps/pep-0008/#package-and-module-names">https://www.python.org/dev/peps/pep-0008/#package-and-module-names</a>  

I'm not clear on whether this refers to the file name of a module/class/package.  

If I had one example of each, should the filenames be all lower case with underscores if appropriate? Or something else?  

#### Answer accepted (score 159)
Quoting <a href="https://www.python.org/dev/peps/pep-0008/#package-and-module-names" rel="noreferrer">https://www.python.org/dev/peps/pep-0008/#package-and-module-names</a>:   

<blockquote>
  Modules should have short, all-lowercase names. Underscores can be used in the module name if it improves readability. Python packages should also have short, all-lowercase names, although the use of underscores is discouraged.  
</blockquote>

For <a href="https://www.python.org/dev/peps/pep-0008/#class-names" rel="noreferrer">classes</a>:  

<blockquote>
  Class names should normally use the CapWords convention.  
</blockquote>

And <a href="https://www.python.org/dev/peps/pep-0008/#function-and-variable-names" rel="noreferrer">function and (local) variable names</a> should be:  

<blockquote>
  lowercase, with words separated by underscores as necessary to improve readability  
</blockquote>

See <a href="https://softwareengineering.stackexchange.com/a/111882/195918">this answer</a> for the difference between a module, class and package:  

<blockquote>
  <ul>
  <li>A Python module is simply a Python source file, which can expose classes, functions and global variables.</li>
  <li>A Python package is simply a directory of Python module(s).</li>
  </ul>
</blockquote>

<hr>

<strong>So PEP 8 tells you that</strong>:  

<ul>
<li>modules (filenames) should have <em>short, all-lowercase names</em>, and they can contain underscores;</li>
<li>packages (directories) should have <em>short, all-lowercase names</em>, preferably without underscores;</li>
<li>classes should use the CapWords convention.</li>
</ul>

<hr>

PEP 8 tells that names should be <em>short</em>; <a href="https://stackoverflow.com/a/48721872/1771479">this answer</a> gives a good overview of what to take into account when creating variable names, which also apply to other names (for classes, packages, etc.):  

<blockquote>
  <ul>
  <li>variable names are not full descriptors;</li>
  <li>put details in comments;</li>
  <li>too specific name might mean too specific code;</li>
  <li>keep short scopes for quick lookup;</li>
  <li>spend time thinking about readability.</li>
  </ul>
</blockquote>

<hr>

To finish, a good overview of the naming conventions is given in the <a href="http://google.github.io/styleguide/pyguide.html#3164-guidelines-derived-from-guidos-recommendations" rel="noreferrer">Google Python Style Guide</a>.  

#### Answer 2 (score 0)
<a href="https://github.com/naming-convention/naming-convention-guides/tree/master/python" rel="nofollow noreferrer">Here</a> is a link for different types of Python name conventions.  

The style guide for Python is based on Guido’s naming convention recommendations.  

<a href="https://i.stack.imgur.com/Ty2F3.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/Ty2F3.png" alt="enter image description here"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: Summary of differences between Java versions? (score [167227](https://stackoverflow.com/q/193630) in 2013)

#### Question
What are the major differences in between Java version in terms of software development? Where can one find a summary of the most important changes related to programming?  

The Release Notes such as <a href="http://www.oracle.com/technetwork/java/javase/releasenotes-136954.html">http://www.oracle.com/technetwork/java/javase/releasenotes-136954.html</a> can be hard to read.   

For example there is new code structure "for each" in Java 1.5.  

#### Answer accepted (score 93)
This is a summary of <a href="https://en.wikipedia.org/wiki/Java_version_history" rel="noreferrer">the excellent Wikipedia article about the Java version history</a>. It is highly selective (and biased on what I know and use), otherwise it would simply turn out to be a copy of the article.  

The <strong>bold parts</strong> are what really brought the language forward as a whole. As you see, not every release has bold parts.  

<h5>Java 11</h2>

<sup><a href="https://www.jcp.org/en/jsr/detail?id=384" rel="noreferrer">JSR 384</a>, <a href="https://www.oracle.com/technetwork/java/javase/11-relnote-issues-5012449.html#NewFeature" rel="noreferrer">what's new</a></sup>  

Language changes:  

<ul>
<li><a href="http://openjdk.java.net/jeps/323" rel="noreferrer">Local-Variable Syntax for Lambda Parameters</a></li>
</ul>

Library changes:  

<ul>
<li><a href="http://openjdk.java.net/jeps/321" rel="noreferrer">JEP 321 Http Client</a> standardized</li>
</ul>

<h5>Java 10</h2>

<sup><a href="http://openjdk.java.net/projects/jdk/10/spec/" rel="noreferrer">JSR 383</a>, <a href="http://www.oracle.com/technetwork/java/javase/10-relnote-issues-4108729.html#NewFeature" rel="noreferrer">what's new</a></sup>  

Language changes:  

<ul>
<li><a href="http://openjdk.java.net/jeps/286" rel="noreferrer">Local variable type inference</a> (`var` keyword)</li>
</ul>

<h5>Java 9</h2>

<sup><a href="http://%3Csup%3E[JSR%20337][2],%20[what&#39;s%20new][3]%3C/sup%3E" rel="noreferrer">JSR 379</a>, <a href="https://docs.oracle.com/javase/9/whatsnew/toc.htm" rel="noreferrer">what's new</a></sup>  

Language changes:  

<ul>
<li><a href="http://openjdk.java.net/jeps/213" rel="noreferrer">further continuation of Project Coin</a> (small language improvements)</li>
</ul>

Library changes:  

<ul>
<li><strong><a href="http://openjdk.java.net/projects/jigsaw/spec/" rel="noreferrer">Java Platform Module System (jigsaw)</a></strong>

<ul>
<li>modularization of the platform itself</li>
<li>makes modules a first-class citizen meant to replace the messy classpath with modules with real dependency information</li>
</ul></li>
</ul>

Other changes:  

<ul>
<li>People seem to have gotten over the <em>1.x</em> naming convention, almost no one calls this "Java 1.9".</li>
</ul>

<h5>Java 8 (a.k.a 1.8)</h2>

<sup><a href="http://www.jcp.org/en/jsr/detail?id=337" rel="noreferrer">JSR 337</a>, <a href="http://www.oracle.com/technetwork/java/javase/8-whats-new-2157071.html" rel="noreferrer">what's new</a></sup>  

Language changes:  

<ul>
<li><strong><a href="https://en.wikipedia.org/wiki/Lambda_%28programming%29" rel="noreferrer">lambda expressions</a></strong> (<a href="http://www.jcp.org/en/jsr/detail?id=335" rel="noreferrer">JSR 335</a>, includes method handles)</li>
<li>continuation of Project Coin (small language improvements)</li>
<li>annotations on Java types</li>
</ul>

Library changes:  

<ul>
<li><a href="http://threeten.sourceforge.net/" rel="noreferrer">Improved Date and Time API</a></li>
</ul>

<h5>Java 7 (a.k.a 1.7)</h2>

<sup><a href="http://www.jcp.org/en/jsr/detail?id=336" rel="noreferrer">JSR 336</a>, <a href="http://www.oracle.com/technetwork/java/javase/jdk7-relnotes-418459.html" rel="noreferrer">features and enhancements</a></sup>  

Language changes:  

<ul>
<li>Project Coin (small changes)

<ul>
<li>`switch` on Strings</li>
<li><a href="http://docs.oracle.com/javase/7/docs/technotes/guides/language/try-with-resources.html" rel="noreferrer">try-with-resources</a></li>
<li><a href="http://docs.oracle.com/javase/7/docs/technotes/guides/language/type-inference-generic-instance-creation.html" rel="noreferrer">diamond operator</a></li>
</ul></li>
</ul>

Library changes:  

<ul>
<li><a href="http://docs.oracle.com/javase/tutorial/essential/io/fileio.html" rel="noreferrer">new abstracted file-system API (NIO.2)</a> (with support for virtual filesystems)</li>
<li>improved concurrency libraries</li>
<li>elliptic curve encryption</li>
<li>more incremental upgrades</li>
</ul>

Platform changes:  

<ul>
<li><a href="http://docs.oracle.com/javase/7/docs/technotes/guides/vm/multiple-language-support.html" rel="noreferrer">support for dynamic languages</a></li>
</ul>

<h5>Java 6 (a.k.a 1.6)</h2>

<sup><a href="http://www.jcp.org/en/jsr/detail?id=270" rel="noreferrer">JSR 270</a>. <a href="http://www.oracle.com/technetwork/java/javase/features-141434.html" rel="noreferrer">features and enhancements</a></sup>  

Mostly incremental improvements to existing libraries, no new language features (except for <a href="https://blogs.oracle.com/ahe/entry/override_snafu" rel="noreferrer">the `@Override` snafu</a>).  

<h5>Java 5 (a.k.a 1.5)</h2>

<sup><a href="http://jcp.org/en/jsr/detail?id=176" rel="noreferrer">JSR 176</a>, <a href="http://docs.oracle.com/javase/1.5.0/docs/relnotes/features.html" rel="noreferrer">features and enhancements</a></sup>  

Language Changes:  

<ul>
<li><a href="https://en.wikipedia.org/wiki/Generics_in_Java" rel="noreferrer"><strong>generics</strong></a> (that's the big one)</li>
<li><a href="https://en.wikipedia.org/wiki/Java_annotation" rel="noreferrer"><strong>annotations</strong></a></li>
<li>`enum` types</li>
<li>varargs, enhanced for loops (for-each)</li>
</ul>

Library changes:  

<ul>
<li>concurrency utilities in `java.util.concurrent`</li>
</ul>

<h5>Java 1.4</h2>

<sup><a href="http://www.jcp.org/en/jsr/detail?id=59" rel="noreferrer">JSR 59</a></sup>  

Language changes:  

<ul>
<li><a href="http://docs.oracle.com/javase/7/docs/technotes/guides/language/assert.html" rel="noreferrer">the `assert` keyword</a></li>
</ul>

Library changes:  

<ul>
<li><a href="https://en.wikipedia.org/wiki/Regular_expression" rel="noreferrer">regular expressions</a> support</li>
<li><a href="https://en.wikipedia.org/wiki/New_I/O" rel="noreferrer">NIO</a></li>
<li>integrated XML handling</li>
</ul>

<h5>Java 1.3</h2>

Mostly minor improvements, really.  

Platform changes:  

<ul>
<li>HotSpot JVM: improvement over the original JIT</li>
</ul>

<h5>Java 1.2</h2>

Language changes:  

<ul>
<li><a href="https://en.wikipedia.org/wiki/Strictfp" rel="noreferrer">the `strictfp` keyword</a></li>
</ul>

Library changes:  

<ul>
<li>a <strong>unified <a href="http://docs.oracle.com/javase/tutorial/collections/intro/index.html" rel="noreferrer">collections</a> system</strong></li>
<li><a href="https://en.wikipedia.org/wiki/Swing_%28Java%29" rel="noreferrer">Swing</a> as a new UI-System on top of AWT</li>
</ul>

Platform changes  

<ul>
<li>a real JIT, greatly improving speed</li>
</ul>

<h5>Java 1.1</h2>

Language changes:  

<ul>
<li>inner classes</li>
</ul>

Library changes:  

<ul>
<li>AWT event changes</li>
<li>JDBC, RMI</li>
<li>reflection</li>
</ul>

<h5>Java 1.0</h2>

Initial release, everything is new ;-)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Why doesn't HTTP have POST redirect? (score [166478](https://stackoverflow.com/q/99894) in 2011)

#### Question
HTTP redirects are done via HTTP codes 301, and 302 (maybe other codes also) and a header field known as "Location" which has the address of the new place to go.  However, browsers always send a "GET" request to that URL.  

However, many times you need to redirect your user to another domain via POST (bank payments for example).  This is a common scenario, and really a requirement.  Does anybody know why such a common requirement has been neglected in HTTP specification?  The workaround is to send a form (with parameters in hidden fields) with action set to the target location (the value of the <strong>Location</strong> header field) and use `setTimeout` to submit the form to the target location.  

#### Answer accepted (score 180)
In HTTP 1.1, there <strong>actually is a status code</strong> (<a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/307" rel="noreferrer">307</a>) which indicates that the request should be repeated using <strong>the same method and post data</strong>.   

As others have said, there is a <strong>potential for misuse</strong> here which may be why many frameworks stick to 301 and 302 in their abstractions. However, with <strong>proper understanding and responsible usage,</strong> you should be able to accomplish what you're looking for.   

Note that according to the <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html" rel="noreferrer">W3.org spec</a>, when the `METHOD` is not `HEAD` or `GET`, <strong>user agents should prompt the user</strong> before re-executing the request at the new location. You should also <strong>provide a note and a fallback mechanism</strong> for the user in case old user agents aren't sure what to do with a 307.   

Using this form:  

<pre class="lang-html prettyprint-override"><code>&lt;form action="Test307.aspx" method="post"&gt;
    &lt;input type="hidden" name="test" value="the test" /&gt;
    &lt;input type="submit" value="test" /&gt;    
&lt;/form&gt;
</code></pre>

And having Test307.aspx simply return 307 with the Location:<a href="http://google.com" rel="noreferrer">http://google.com</a>, Chrome 13 and Fiddler confirm that "test=the test" is indeed posted to Google. Of course the further response is a 405 since Google doesn't allow the POST, but it shows the mechanics.  

For more information see <a href="http://en.wikipedia.org/wiki/List_of_HTTP_status_codes" rel="noreferrer">List of HTTP status codes</a> and the <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html" rel="noreferrer">W3.org spec</a>.  

<blockquote>
  <p>307 Temporary Redirect (since HTTP/1.1) In this occasion, the request
  should be repeated with another URI, but future requests can still use
  the original URI.<a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html" rel="noreferrer">2</a> In contrast to 303, the request method should not
  be changed when reissuing the original request. For instance, a POST
  request must be repeated using another POST request.</p>
</blockquote>

#### Answer 2 (score 49)
I found a good explanation on this <a href="http://www.alanflavell.org.uk/www/post-redirect.html">page here</a>.  

<blockquote>
  <p>The simplest situations on the WWW are "idempotent" transactions, i.e
  those which can be repeated without causing any harm. These are
  typically "GET" transactions, either because they are retrieval of
  straightforward URL references (e.g href= or src= attributes in HTML),
  or because they are form submissions using the GET method. Redirecting
  a transaction of that kind is straightforward, and no questions asked:
  the client receives the redirection response, including a Location:
  header that specifies the new URL, and the client reacts to it by
  re-issuing the transaction to the new URL. There's a difference
  between the different 30x status codes associated with these
  redirections in their implied cacheability, but otherwise they are
  basically similar (301 and 302) in response to GET requests.</p>
  
  <p>POST transactions are different, since they are defined to be, in
  principle, non-idempotent (such as ordering a pizza, casting a vote or
  whatever) and mustn't be arbitrarily repeated.</p>
  
  <p>The HTTP protocol specifications are designed to take this distinction
  into account: the GET method is defined to be inherently idempotent,
  whereas the POST method is defined to be, at least potentially,
  non-idempotent; <strong>the specifications call for a number of precautions to
  be taken by client agents (such as browsers) for protecting users
  against inadvertently (re)submitting a POST transaction which they had
  not intended, or submitting a POST into a context which they would not
  have wanted.</strong></p>
</blockquote>

While I am not a fan of restricing users technically to prevent them from causing unwanted mayhem or doing unwanted harm to their applications, I can understand the point and it makes sense.   

#### Answer 3 (score 3)
GET (and a few other methods) are defined as 'SAFE' in the http spec (<a href="https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html" rel="nofollow noreferrer">RFC 2616</a>):  

<blockquote>
  <strong>9.1.1 Safe Methods</strong>  
  
  <p>Implementors should be aware that the software represents the user in
  their interactions over the Internet, and should be careful to allow
  the user to be aware of any actions they might take which may have an
  unexpected significance to themselves or others.</p>
  
  <p>In particular, the convention has been established that the GET and
  HEAD methods SHOULD NOT have the significance of taking an action
  other than retrieval. These methods ought to be considered "safe".
  This allows user agents to represent other methods, such as POST, PUT
  and DELETE, in a special way, so that the user is made aware of the
  fact that a possibly unsafe action is being requested.</p>
  
  <p>Naturally, it is not possible to ensure that the server does not
  generate side-effects as a result of performing a GET request; in
  fact, some dynamic resources consider that a feature. The important
  distinction here is that the user did not request the side-effects, so
  therefore cannot be held accountable for them. </p>
</blockquote>

This means that a GET request should never have any serious consequence for the user, beyond seeing something they might not want to see, but a POST request could change a resource that's important to them, or to other people.  

Although this has changed with JavaScript, traditionally there were different user interfaces - users could trigger GET requests by clicking links, but would have to fill in a form to trigger a POST request. I think the designers of HTTP were keen to maintain the distinction between safe and non-safe methods.  

I also don't think it should ever be necessary to redirect to a POST. Any action that needs to be carried out can presumably be done by calling a function within the server side code, or if it needs to happen on a different server then instead of sending a redirect containing a URL for the browser to POST to, the server could make a request to that server itself, acting like a proxy for the user.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: What is the difference between technical specifications and design documents? (score [164375](https://stackoverflow.com/q/179554) in 2012)

#### Question
What are technical specifications? Are they the same as design documents. If not, what is the difference and some examples?  

#### Answer accepted (score 33)
A <strong>software design document</strong> can be at the level of a system or component, and generally includes:  

<ul>
<li>relevant goals or requirements (functional and non-functional);</li>
<li>static structure (e.g., components, interfaces, dependencies);</li>
<li>dynamic behavior (how components interacts);</li>
<li>data models or external interfaces (external to the system/component described in the document); and</li>
<li>deployment considerations (e.g., runtime requirements, third-party components).</li>
</ul>

Note that all of these descriptions are at an abstract level. The purpose is to give the reader a broad general understanding of the system or component. There may be many levels of design documents (e.g., system- or component-level).  

A <strong>technical specification</strong> describes the minute detail of either all or specific parts of a design, such as:  

<ul>
<li>the signature of an interface, including all data types/structures required (input data types, output data types, exceptions);</li>
<li>detailed class models including all methods, attributes, dependencies and associations;</li>
<li>the specific algorithms that a component employs and how they work; and</li>
<li>physical data models including attributes and types of each entity/data type.</li>
</ul>

#### Answer 2 (score 7)
Technical specifications, at least in the form of a technical design, are <em>part</em> of the design documents, along with, for example, requirements lists, functional designs, user stories, graphics design mockups, usability studies, UML diagrams, business process diagrams, data model specifications, etc.  

Technical specifications of the type that you write after the fact, to document the finished product, are <em>not</em> generally part of the design documents, but they can be included in the set of design documents of a later version (for reference) or another product that relies on them.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: What is the difference between requirements and specifications? (score [163949](https://stackoverflow.com/q/121289) in )

#### Question
I've been tasked with developing requirements and specifications for a project our group is starting.  

I realized that I don't know the difference; a Google search just confused me more -- it seems some people say that specifications <em>are</em> requirements, but at a lower level.  

#### Answer accepted (score 129)
The sound-bite answer is that requirements are what your program should do, the specifications are how you plan to do it.   

Another way to look at it is that the requirements represent the application from the perspective of the user, or the business as a whole. The specification represents the application from the perspective of the technical team. Specifications and requirements roughly communicate the same information, but to two completely different audiences.  

#### Answer 2 (score 38)
Requirements document what is needed - they shouldn't specify the how, but the what.  

Specifications document how to achieve the requirements - they should specify the how.  

In many places these documents are not separate and are used interchangeably.  

#### Answer 3 (score 16)
I am a systems engineer in the aerospace field, where both terms are used extensively. The distinction is clear and not as complex as the others are making it.   

A <strong>specification</strong> is a document that specifies a system or product, e.g. a prime-item development specification for an F-14. There are lots of sections/content in a spec: requirements, definitions, reference documents, glossary, verification information, etc.   

A <strong>requirement</strong> is a single statement of something the product or system must do. A  spec may have hundreds of requirements in it. Old school methodology says the requirement statement must use the word "shall", to separate requirements from statements of facts, or definitions. (Not sure if the new-fangled agile kids keep to all this or not; the fastidiousness has it's use but is a little fussy at times.)   

<strong>So a spec is a document full of requirements, plus some other supporting and ancillary information.</strong>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: AGPL - what you can do and what you can't (score [159036](https://stackoverflow.com/q/107883) in )

#### Question
AGPL is a fairly new license that was meant to go GPL-over-networks. However, not being a lawyer, and actually not having read the whole license, I can't understand what exactly you can do freely and what not with AGPL.  

My uncertainty is fed by <a href="http://blog.mongodb.org/post/103832439/the-agpl">this post</a> about MongoDB (which is AGPL) and even more by the comments below.  

If we follow the comments it turns out that you can use AGPL libraries with your closed-source, commercial server-side software, as long as you don't modify the library. Is that the case? Or you have to distribute your entire application when you use an AGPL licensed library?  

The case with MongoDB is that it uses Apache license for the client code, which poses another question. What happens if you use AGPL software, but deploy it as a different application that your closed-source commercial one? For example, take <a href="http://itextpdf.com/">iText</a> - it is an AGPL library:  

<ul>
<li>if you use it and modify it, do you have to open-source your entire application or you have to redistribute only the changes in iText?</li>
<li>if you use it and <strong>don't</strong> modify it, do you have to open-source your entire application?</li>
<li>If you wrap iText in another application that you start as a separate process, but use it from your main application, should you open-source everything, or just the wrapper application? (The wrapper application will be HTTP-based API that will take pdf files and will return the results of using iText as JSON). Can this be used to circumvent the AGPL license?</li>
</ul>

Note: The question is about AGPLv3  

#### Answer 2 (score 40)
The AGPL is based on the GPL, not the LGPL. It does not contain any linking exceptions, and any work using AGPL code (linked or otherwise, modified or not) must also be AGPL licensed and distributed.  

Using separate processes <em>can</em> circumvent the (A)GPL, but this is murky ground. If your end application <strong>depends</strong> on the external process, such that it wouldn't function properly without it, then it would be considered a derived work of the AGPL software.   

In most cases where people use separate GPL applications in closed source programs, they provide the GPL work as an optional extension, or an alternative back-end to some other piece of code etc.  

The (A)GPL work cannot be distributed alongside the final application even as a separate app (eg, putting them into the same archive or repository), although it's fine to provide instructions on where to find the GPL work and how to use it with your app.  

#### Answer 3 (score 10)
AGPL is the same as GPL; therefore if your app is using AGPL code it has to be AGPL licensed.  

What AGPL does on top of GPL is the redefinition of user. For GPL programs running on your server, you are the user, for AGPL, the real users of the app are the users of your website or service. Therefore you are distributing the app if someone other than you is using it. And that of course implies all the standard GPL requirements.  

As for Mongo, I'm assuming that apps using it don't use it's code, only some API, which isn't AGPL licensed.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How do you organize your projects? (score [156583](https://stackoverflow.com/q/40394) in 2011)

#### Question
Do you have any particular style of organizing projects?  

For example, currently I'm creating a project for a couple of schools here in Bolivia, this is how I organized it:  

```
TutoMentor (Solution)
TutoMentor.UI   (Winforms project)
TutoMentor.Data (Class library project)
```

How exactly do you organize your project? Do you have an example of something you organized and are proud of? Can you share a screenshot of the Solution pane?  

In the UI area of my application, I'm having trouble deciding on a good schema to organize different forms and where they belong.   

<hr>

<strong>Edit:</strong>  

What about organizing different forms in the .UI project? Where/how should I group different form? Putting them all in root level of the project is a bad idea.  

#### Answer accepted (score 107)
When designing a project and laying out the architecture I start from two directions.  First I look at the project being designed and determine what buisness problems need to be solved.  I look at the people who will be using it and start with a crude UI design.  At this point I am ignoring the data and just looking at what the users are asking for and who will be using it.   

Once I have a basic understanding of what they are asking for I determine what the core data is that they will be manipulating and begin a basic database layout for that data.  Then I start to ask questions to define the business rules that surround the data.  

By starting from both ends independently I am able to lay out a project in a way that melds the two ends together.  I always try to keep the designs separate for as long as possible before melding them together, but keep in mind the requirements of each as I move forward.  

Once I have a good solid understanding of each end of the problem I begin to lay out the structure of the project that will be created to solve the problem.    

Once the basic layout of the project solution is created I look at the functionality of the project and set up a base set of namespaces that are used depending on the type of work being done.  This may be things like Account, Shopping Cart, Surveys, etc.    

Here is the basic solution layout that I always start with.  As the projects get better defined I refine it to meet the specific needs of each project.  Some areas may be merged with others and I may add a few special ones as needed.  

<strong>SolutionName</strong>  

```
.ProjectNameDocuments
    For large projects there are certain documents that need to be kept with
    it. For this I actually create a separate project or folder within the 
    solution to hold them.
.ProjectNameUnitTest
    Unit testing always depends on the project - sometimes it is just really 
    basic to catch edge cases and sometimes it is set up for full code 
    coverage.  I have recently added graphical unit testing to the arsenal.
.ProjectNameInstaller
    Some projects have specific installation requirements that need to be 
    handled at a project level.
.ProjectNameClassLibrary
    If there is a need for web services, APIs, DLLs or such.
.ProjectNameScripts (**Added 2/29/2012**)
    I am adding this because I just found a need for one in my current project.  
    This project holds the following types of scripts: SQL (Tables, procs, 
    views), SQL Data update scripts, VBScripts, etc.
.ProjectName
    .DataRepository 
        Contains base data classes and database communication.  Sometimes 
        also hold a directory that contains any SQL procs or other specific 
        code.  
    .DataClasses
        Contains the base classes, structs, and enums that are used in the 
        project.  These may be related to but not necessarily be connected
        to the ones in the data repository.
    .Services 
        Performs all CRUD actions with the Data, done in a way that the 
        repository can be changed out with no need to rewrite any higher 
        level code.
    .Business
        Performs any data calculations or business level data validation,
        does most interaction with the Service layer.
    .Helpers
        I always create a code module that contains helper classes.  These 
        may be extensions on system items, standard validation tools, 
        regular expressions or custom-built items.  
    .UserInterface
        The user interface is built to display and manipulate the data.  
        UI Forms always get organized by functional unit namespace with 
        additional folders for shared forms and custom controls.
```

#### Answer 2 (score 66)
<h5>I like dividing my projects into layers</h2>

That way it's easier to manage cyclic dependencies. I can guarantee that no project is importing the View project (layer) by mistake, for example. I also tend to break my layers in sub-layers. So all my solutions have a list of projects like this:  

<ul>
<li>Product.Core</li>
<li>Product.Model</li>
<li>Product.Presenter</li>
<li>Product.Persistence</li>
<li>Product.UI</li>
<li>Product.Validation</li>
<li>Product.Report</li>
<li>Product.Web</li>
</ul>

They are the bigger "building blocks" of my application. Then inside each project I organize in namespaces more logically but it varies a lot. For UI when creating a lot of forms I try to think in a spacial division and then create namespaces for each "space". Let's say there's a bunch of user preferences user controls and forms, I'd have a namespace called UserPreferences for them, and so on.  

#### Answer 3 (score 19)
<h5>Organizing Projects</h2>

I typically try to divide up my projects by namespace, like you say.  Each tier of an application, or component is its own project.  When it comes to how I decide how to break my solution up into projects, I focus on <em>reusability</em> and <em>dependencies</em> of those projects.  I think about how other members of my team will be using the project, and if other projects we create down the road may benefit from using some component of the system.  

For example, sometimes, just having this project, which has an entire set of frameworks (email, logging, etc) is sufficient:  

```
MyCompany.Frameworks
```

Other times, I may want to break out frameworks into pieces, so that they can be imported individually:  

```
MyCompany.Frameworks.Networking
MyCompany.Frameworks.Logging
MyCompany.Frameworks.SomeLOBFramework
```

<hr>

<h5>Organizing Forms</h2>

Organizing Forms under a UI project will really morph as your project expands.   

<ul>
<li><p><strong>Small</strong> - A simple <em>Forms</em> folder could suffice for a very small project.  Sometimes you can overengineer structures just like you can namespaces and make things way more complicated than they need to be.  </p></li>
<li><p><strong>Medium to Large</strong> - Here, I usually start dividing my forms into functional areas.  If I have one part of my app that has 3 forms to manage a user and some that keep keep track of soccer games and scores, then I'll have a <em>Forms > User</em> area and a <em>Forms > Games</em> area or something like that.  It really depends on the rest of the project, how many forms I have as to how fine-grained I break it up.</p></li>
</ul>

<strong>Remember, at the end of the day namespaces and folders are just there to help you organize and find things faster.</strong>  

<hr>

Really, it depends on your team, your projects, and what's easier for you.  I would suggest that in general, you make separate projects for each layer/component of your system, but there are always exceptions.  

<strong>For guidance on system architecture see <a href="http://msdn.microsoft.com/en-us/library/ee658116.aspx">Microsoft's Patterns and Practices site.</a></strong>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Is it better to return NULL or empty values from functions/methods where the return value is not present? (score [156372](https://stackoverflow.com/q/120355) in 2017)

#### Question
I am looking for a recommendation here.  I am struggling with whether it is better to return NULL or an empty value from a method when the return value is not present or cannot be determined.    

Take the following two methods as an examples:  

```
string ReverseString(string stringToReverse) // takes a string and reverses it.
Person FindPerson(int personID)    // finds a Person with a matching personID.
```

In `ReverseString()`, I would say return an empty string because the return type is string, so the caller is expecting that.  Also, this way, the caller would not have to check to see if a NULL was returned.  

In `FindPerson()`, returning NULL seems like a better fit.  Regardless of whether or not NULL or an empty Person Object (`new Person()`) is returned the caller is going to have to check to see if the Person Object is NULL or empty before doing anything to it (like calling `UpdateName()`).  So why not just return NULL here and then the caller only has to check for NULL.  

Does anyone else struggle with this?  Any help or insight is appreciated.  

#### Answer accepted (score 77)
StackOverflow has a good discussion about this exact topic in this <a href="https://stackoverflow.com/questions/1626597/should-functions-return-null-or-an-empty-object">Q&amp;A</a>. In the top rated question, kronoz notes:  

<blockquote>
  <p>Returning null is usually the best idea if you intend to indicate that
  no data is available.</p>
  
  <p>An empty object implies data has been returned, whereas returning null
  clearly indicates that nothing has been returned.</p>
  
  <p>Additionally, returning a null will result in a null exception if you
  attempt to access members in the object, which can be useful for
  highlighting buggy code - attempting to access a member of nothing
  makes no sense. Accessing members of an empty object will not fail
  meaning bugs can go undiscovered.</p>
</blockquote>

Personally, I like to return empty strings for functions that return strings to minimize the amount of error handling that needs to be put in place. However, you'll need to make sure that the group that your working with will follow the same convention - otherwise the benefits of this decision won't be achieved.  

However, as the poster in the SO answer noted, nulls should probably be returned if an object is expected so that there is no doubt about whether data is being returned.  

In the end, there's no single best way of doing things. Building a team consensus will ultimately drive your team's best practices.  

#### Answer 2 (score 82)
In all the code I write, I avoid returning `null` from a function.  I read that in <a href="http://www.amazon.ca/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882">Clean Code</a>.  

The problem with using `null` is that the person using the interface doesn't know if `null` is a possible outcome, and whether they have to check for it, because there's no `not null` reference type.  

In F# you can return an `option` type, which can be `some(Person)` or `none`, so it's obvious to the caller that they have to check.  

The analogous C# (anti-)pattern is the `Try...` method:  



```
public bool TryFindPerson(int personId, out Person result);
```

Now I know people have said they <em>hate</em> the `Try...` pattern because having an output parameter breaks the ideas of a pure function, but it's really no different than:  

```
class FindResult<T>
{
   public FindResult(bool found, T result)
   {
       this.Found = found;
       this.Result = result;
   }

   public bool Found { get; private set; }
   // Only valid if Found is true
   public T Result { get; private set;
}

public FindResult<Person> FindPerson(int personId);
```

...and to be honest you can assume that <em>every</em> .NET programmer knows about the `Try...` pattern because it's used internally by the .NET framework.  That means they <em>don't have to read the documentation</em> to understand what it does, which is more important to me than sticking to some purist's view of functions (understanding that `result` is an `out` parameter, not a `ref` parameter).  

So I'd go with `TryFindPerson` because you seem to indicate it's perfectly normal to be unable to find it.  

If, on the other hand, there's no logical reason that the caller would ever provide a `personId` that didn't exist, I would probably do this:  

```
public Person GetPerson(int personId);
```

...and then I'd throw an exception if it was invalid.  The `Get...` prefix implies that the caller knows it should succeed.  

#### Answer 3 (score 28)
You could try Martin Fowler's <a href="http://martinfowler.com/eaaCatalog/specialCase.html">Special Case pattern</a>, from <a href="http://rads.stackoverflow.com/amzn/click/0321127420">Paterns of Enterprise Application Architecture</a>:  

<blockquote>
  <p>Nulls are awkward things in object-oriented programs because they
  defeat polymorphism. Usually you can invoke foo freely on a variable
  reference of a given type without worrying about whether the item is
  the exact type or a sub-class. With a strongly typed language you can
  even have the compiler check that the call is correct. However, since
  a variable can contain null, you may run into a runtime error by
  invoking a message on null, which will get you a nice, friendly stack
  trace.</p>
  
  <p>If it's possible for a variable to be null, you have to remember to
  surround it with null test code so you'll do the right thing if a null
  is present. Often the right thing is same in many contexts, so you end
  up writing similar code in lots of places - committing the sin of code
  duplication.</p>
  
  <p>Nulls are a common example of such problems and others crop up
  regularly. In number systems you have to deal with infinity, which has
  special rules for things like addition that break the usual invariants
  of real numbers. One of my earliest experiences in business software
  was with a utility customer who wasn't fully known, referred to as
  "occupant." All of these imply altering the usual behavior of the
  type.</p>
  
  <p>Instead of returning null, or some odd value, return a Special Case
  that has the same interface as what the caller expects.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: How do I completely-self-study Computer Science? (score [155892](https://stackoverflow.com/q/152240) in 2017)

#### Question
Being a completely self taught programmer, I would like it if I could better myself by self-learning the computer science course taught to a typical CS grad.  

Finding different resources on internet has been easy, there is of course <strong>MIT open course ware</strong>, and there are Coursera courses from Stanford and other universities. There are numerous other open resources scattered around the Internet and some good books that are repeatedly recommended.  

I have been learning a lot, but my study is heavily fragmented, which really bugs me. I would love If somewhere, I could find a path I should follow and a stack I should limit myself to, so that I can be sure about what <strong><em>essential</em></strong> parts of computer science I have studied, and then systematically approach those I haven't.  

The problem with Wikipedia is it doesn't tell you what's essential but insists on being a complete reference.  

<strong>MIT open course ware</strong> for Computer science and Electrical Engg. has a huge list of courses also not telling you what courses are essential and what optional as per person's interest/requirement. I found no mention of an order in which one should study different subjects.  

What I would love is to create a list that I can follow, like this dummy one  

```
SUBJECTS                                                        DONE

Introduction to Computer Science                                  *
Introduction to Algorithms                                        *
Discrete Mathematics                   
Adv. Discrete Mathematics
Data structures                                                   *
Adv. Algorithms
...
```

As you can clearly see, I have little idea of what specific subjects computer science consists of.  

It would be hugely helpful, even if someone pointed out essential courses from MIT Course ware ( + essential subjects not present at MIT OCW) in a recommended order of study.   

I'll list the Posts I already went through (and I didn't get what I was looking for there)  

<a href="https://softwareengineering.stackexchange.com/questions/49557/computer-science-curriculum-for-non-cs-major">https://softwareengineering.stackexchange.com/questions/49557/computer-science-curriculum-for-non-cs-major</a> - top answer says it isn't worth studying cse  

<a href="https://softwareengineering.stackexchange.com/questions/110345/how-can-a-self-taught-programmer-learn-more-about-computer-science">https://softwareengineering.stackexchange.com/questions/110345/how-can-a-self-taught-programmer-learn-more-about-computer-science</a> - points to MIT OCW  

<a href="https://softwareengineering.stackexchange.com/questions/49167/studying-computer-science-what-am-i-getting-myself-into">https://softwareengineering.stackexchange.com/questions/49167/studying-computer-science-what-am-i-getting-myself-into</a>  

<a href="https://softwareengineering.stackexchange.com/questions/19912/overview-of-computer-science-programming">https://softwareengineering.stackexchange.com/questions/19912/overview-of-computer-science-programming</a>  

#### Answer accepted (score 24)
I've seen some course material from MIT, and it was <em>shockingly bad</em>. They had teaching materials which required VC5, bunches of implicit global variables, passing colours as "Blue" instead of 32bit ARGB, let alone 4x [0,1] floats, that sort of thing. I wouldn't trust a curriculum or code just because it comes from a big-name university.  

My CS degree (from a university which is top 10 in the UK for CS) consisted of:  

First year:  

<ol>
<li>OOP- the super basics</li>
<li>Computer Systems- stuff like, binary integer representations.    </li>
<li>Basic relational database theory</li>
<li>Mathematics for CS- simple 2D and 3D geometry. </li>
<li>A little bit of HTML/JS- complete beginner's stuff </li>
<li>An equally tiny bit of PHP.</li>
<li>A tad of functional programming</li>
</ol>

Second year:  

<ol>
<li>Legal issues in computing- stuff like, laws revolving around
protection of user data</li>
<li>Programming languages- Chomsky hierarchy and lexing was covered</li>
<li>Operating Systems, Networks, and the Internet- mostly stuff like
virtual memory and paging, IP stack</li>
<li>2D computer graphics- mostly just proving theorems of the underlying
mathematics</li>
<li>AI- basic descriptions of neural networks, Bayesian belief systems,
etc.</li>
<li>Requirements analysis- brief overview of UML,
functional/nonfunctional requirements.</li>
<li>Team project</li>
</ol>

Third year:  

<ol>
<li>Algorithm analysis- complexity theory, mostly</li>
<li>Implementation of programming languages- LL/LR parsing techniques,
CFGs, and such things.</li>
<li>Software Project Management- a look at Waterfall/Agile models</li>
<li>International Computing- Unicode and other localization fun</li>
<li>Advanced AI- don't know, honestly, and I've got an exam on it soon</li>
<li>3D computer graphics- mostly, again, just proving theorems for
rotation matrices and such</li>
<li>Agent-based Systems- mostly about asynchronous agents communicating,
reaching group decisions, etc.</li>
<li>Microprocessor Applications- digital signal processing</li>
<li>Robotics- covers stuff like computer vision and robot decision
making at a high level</li>
</ol>

As you'll notice, pretty much everything is "the basics" of something and almost nothing is covered to a useful depth.  

The stuff that was actually worth doing, essential:  

<ol>
<li>OOP- and then some more, and then some more</li>
<li>Functional programming- also some more. Try to pick a language like C++ or C# where you don't have to re-learn the syntax and tools, etc, to cover both styles.</li>
<li>The OS part- virtual memory is good to know about, as is kernel mode vs user mode. Skip segmentation and the IP stack.</li>
<li>Requirements analysis- Gotta be useful for any project</li>
<li>Algorithm analysis- knowing what algorithmic complexity is, how to reduce it, and what the complexity is of common operations is important.</li>
<li>Software project management models- many shops do Agile and many older ones still do Waterfall-style models.</li>
<li>International computing- Unicode is essential</li>
</ol>

The stuff that was worth doing, optionally:  

<ol>
<li>Programming languages- Chomsky hierarchy, the tools of lexing and parsing. Skip the theory behind LL or LR parsers- an LR parser can accept virtually any realistic unambiguous CFG, and when it can't, your parser generator's documentation will tell you about it.</li>
<li>3D Graphics. I don't mean "Prove this is a rotation matrix formula" wastes of time, I mean actual "This is a vertex shader" stuff, or GPGPU. That's fun, interesting, and different.</li>
<li>Some of the AI stuff is fun- like potential fields and pathfinding.</li>
</ol>

Stuff that's essential but I didn't cover it anyway:  

<ol>
<li>Concurrency- a must-know, at least the basics, for anyone in 2012.</li>
</ol>

The rest were a complete waste of time. Unfortunately, most of these nine points I either already knew, or picked up the useful parts elsewhere. If you read about things like <a href="http://www.codinghorror.com/blog/2007/02/why-cant-programmers-program.html">the FizzBuzz problem</a> it rapidly becomes apparent that you don't actually need to know all that much to be on top of the pack- which is fortunate, since my degree and many of the materials I've seen online for other degrees really do not teach much at all.  

#### Answer 2 (score 5)
<p>Open Course ware is just a list of courses that they have made available.  If you want to know what a student would have taken, swing by MIT's(non OCW) website and look at the actual program.  They have a list of what is required and what is considered a prereq for what.
<a href="http://web.mit.edu/catalog/degre.engin.ch6.html" rel="nofollow">Here is their page.</a></p>

#### Answer 3 (score 5)
<p>Open Course ware is just a list of courses that they have made available.  If you want to know what a student would have taken, swing by MIT's(non OCW) website and look at the actual program.  They have a list of what is required and what is considered a prereq for what.
<a href="http://web.mit.edu/catalog/degre.engin.ch6.html" rel="nofollow">Here is their page.</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How is a "Software Developer" different from a "Software Consultant"? What makes a consultant? (score [155602](https://stackoverflow.com/q/76659) in 2016)

#### Question
I have seen a lot of people claiming themselves to be a "software consultant". These consultants do what a normal software developer does, write code, estimate tasks, fix bugs and attend meetings etc. The only difference being the financials, consultants end up earning more. Then how is a software developer different from a "consultant"?   

In addition to the main question, I would like to know how can a software developer become a consultant? Are there any specific guidelines for a consultant? Do they need to amass certifications and write up research papers? Please do not confuse the software consultant with a management consultant. Software consultants I have seen are not managers.  

#### Answer accepted (score 107)
<strong>Here's a list of softies</strong>  

<em>Software developer</em> - is an employee on the full-time payroll and does the job of implementing the requirements for the application. Developers skip around on different projects working as when directed by their employers.  

<em>Software consultant</em> - is not an employee, and is brought in to provide advice (consultancy) as to how the application should be implemented using current industry approaches. Often the consultant provides technical advice on how to configure a large application (SAP, Oracle etc). Consultants, in my experience, are not generally programmers.  

<em>Software contractor</em> - is not an employee, and is brought in to provide skills and expertise in current industry approaches. Typically the contractor works on a single project and sees it through to completion, programming as required. They are not under the direction of their employers, although they may assist in other areas as a professional courtesy.  

<strong>How do you become a Software Consultant?</strong>  

Usually as a result of working for a software consultancy that hires you out on a daily basis. Imagine you work for Oracle and some large company needs assistance in setting up middleware. You're a permanent employee working on a contract basis for a third-party. This isn't always the case (see next section), but it is the usual path.  

<strong>How do you become a Software Contractor?</strong>  

Usually as a result of creating your own company and letting recruitment agents know that you're available for work (programming, consulting, both...) . The agency then hires you out on a daily basis, subject to certain contractual terms. You can go direct, but it's much more difficult (the agent's role is to land the client, your role is to provide the expertise).   

#### Answer 2 (score 55)
A "Software Consultant" differs from a "Software Developer" based on terms of employment. The "Software Consultant" is hired as a contractor for a specified period of time and for a very specific task/role/project whereas the "Software Developer" (who is not a contractor or consultant) is a full-time staff member on salary, and may have multiple roles/projects within the company.  

"Sofware Consultant" <em>could</em> refer to a developer/programmer who is employed on a contract-basis rather than a developer/programmer who is employed on a full-time basis. It could also refer to someone who give guidance and high-level project management/design/architechture, as others have mentioned, though in my experiences the title "Software Consultant" usually ends up being someone who works 60-90% of the time as a developer/programmer and is employed on a contract rather than full-time.  

Any developer can be a Consultant by working as a contractor. To do this it usually is a question of either being a freelance contractor, or working with a consulting firm.  

#### Answer 3 (score 35)
Consultants are supposed to <strong>improve the business</strong> not just develop some software.  

I've been a developer for over 30 years. I've only known enough to be a consultant for the last ten or so.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How many types of programming languages are there? (score [155181](https://stackoverflow.com/q/17976) in )

#### Question
Basically, I want to learn lots of programming languages to become a great programmer.  I know only a handful to depth and <strong>I was hoping someone could elaborate on how many <em>classes</em> or <em>types</em> of programming languages there are</strong>.  Like how you would lump them together if you had to learn them in groups.  

Coming from a Java background, I'm familiar with static typing, but I know that in addition to dynamic typing there has to be such variety in available languages that I would love to see a categorical breakdown if possible.  

#### Answer accepted (score 72)
It depends on how you want to classify languages. Fundamentally, languages can be broken down into two types: <strong>imperative</strong> languages in which you instruct the computer <em>how</em> to do a task, and <strong>declarative</strong> languages in which you tell the computer <em>what</em> to do. Declarative languages can further be broken down into <strong>functional</strong> languages, in which a program is constructed by composing functions, and <strong>logic</strong> programming languages, in which a program is constructed through a set of logical connections. Imperative languages read more like a list of steps for solving a problem, kind of like a recipe. Imperative languages include C, C++, and Java; functional languages include Haskell; logic programming languages include Prolog.  

Imperative languages are sometimes broken into two subgroups: <strong>procedural</strong> languages like C, and <strong>object-oriented languages</strong>. Object-oriented languages are a bit orthogonal to the groupings, though, as there are object-oriented functional languages (OCaml and Scala being examples).  

You can also group languages by typing: <strong>static</strong> and <strong>dynamic</strong>. Statically-typed languages are ones in which typing is checked (and usually enforced) prior to running the program (typically during a compile phase); dynamically-typed languages defer type checking to runtime. C, C++, and Java are statically-typed languages; Python, Ruby, JavaScript, and Objective-C are dynamically-typed languages. There are also <strong>untyped</strong> languages, which include the Forth programming language.  

You can also group languages by their typing <em>discipline</em>: <strong>weak</strong> typing, which supports implicit type conversions, and <strong>strong</strong> typing, which prohibits implicit type conversions. The lines between the two are a bit blurry: according to some definitions, C is a weakly-typed languages, while others consider it to be strongly-typed. Typing discipline isn't really a useful way to group languages, anyway.  

#### Answer 2 (score 12)
<ul>
<li><strong>Assembly</strong>   </li>
<li><strong>Procedural</strong><br>
<ul>
<li>Basic  </li>
<li>C  </li>
</ul></li>
<li><strong>Object-Oriented</strong><br>
<ul>
<li>C#  </li>
<li>Java  </li>
</ul></li>
<li><strong>Declarative</strong><br>
<ul>
<li>Prolog</li>
<li>SQL    </li>
</ul></li>
<li><strong>Functional</strong><br>
<ul>
<li>Lisp  </li>
<li>Haskell  </li>
</ul></li>
</ul>

These are the main ones, but there's a lot of other paradigms out there, and there's plenty of overlap between them.  

#### Answer 3 (score 11)
For types of programming languages (Paradigms), look here:  <br> <a href="http://en.wikipedia.org/wiki/Programming_paradigm">http://en.wikipedia.org/wiki/Programming_paradigm</a>  

<p>For other characteristics of programming languages (e.g. Type Systems), look here:
<a href="http://en.wikipedia.org/wiki/Programming_language">http://en.wikipedia.org/wiki/Programming_language</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Visual Studio 2012 - Express vs Professional (score [154347](https://stackoverflow.com/q/166716) in 2013)

#### Question
I'm having trouble finding a feature comparison between <a href="https://en.wikipedia.org/wiki/Microsoft_Visual_Studio_Express#2012_products">Visual Studio 2012 Express Edition</a> and the professional edition. I'm using the trial Professional version at the moment, but it'll run out soon, so I need to make a decision whether to purchase the full version.   

Obviously, I can just try both initially and see if the Express edition is suitable, but the problem is that there are that many features in Visual Studio, there might be a really useful feature that was missing in the standard edition that I didn't even know existed! Or I didn't spot it was missing until later down the line. I could really do with a feature comparison list like the one for all non-Express editions <a href="http://www.microsoft.com/visualstudio/eng/products/compare">here</a>. It's a shame that page doesn't include the Express edition.  

#### Answer accepted (score 37)
The biggest difference is that <strong>Express editions do not support plugins</strong> (No ReSharper, no add-ons).  Additionally, the non-express versions are all combined, meaning you don't have to switch back and forth to get features from individual express versions if you have a project that crosses web, desktop, etc.  

<strong>UPDATE 8/6/2015</strong> - If you're looking for a free edition of Visual Studio <em>today</em>, you will most likely be using the Visual Studio Community Edition, which is very different from the Express edtions (better).  Community Edition is essentially Professional Edition, but free for Individuals, and DOES support plugins!  

#### Answer 2 (score 16)
<strong>Short answer:</strong> Your link is good, but you are looking in the wrong place.  

A good reference to compare Express with Standard is <em><a href="http://msdn.microsoft.com/en-us/library/ms349441.aspx" rel="nofollow">Comparing Visual Studio and Visual Studio Express 2012 for Web edition</a></em>.  

In general, the Express edition is lacking all design tools that you may need for architecture.   

<strong>In prior VS Express versions,</strong> there was also lack of the <a href="http://en.wikipedia.org/wiki/NuGet" rel="nofollow">NuGet</a> support, and all the add-ons that you may get from Tools tab.  

Also as mentioned, in order to develop a web-application and a <a href="http://en.wikipedia.org/wiki/Windows_Mobile" rel="nofollow">Windows mobile</a> application, you have to install <strong>two different versions of the Express edition</strong>, while it is not the case with other versions.  

#### Answer 3 (score 2)
Microsoft makes the Express version for students, learners and newcomers. It's very easy to get started and is specially designed for doing one thing. This thing make learning faster and confuse someone new to programming less than a professional.  

As noted above.  

<ol>
<li><p>Visual Studio Express web 13 only supported Web programming.</p></li>
<li><p>Visual studio Express Desktop only supported Desktop programming.</p></li>
</ol>

Of course, the Express version doesn't provide plugin support and many good features.  

Visual studio Professional is a paid version for professionals. If you got into development then you need more features, so Visual Studio Professional is more reliable in that condition.  

I hope this answer helps :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: Why is mergesort O(log n)? (score [153707](https://stackoverflow.com/q/297160) in 2015)

#### Question
Mergesort is a divide and conquer algorithm and is O(log n) because the input is repeatedly halved. But shouldn't it be O(n) because even though the input is halved each loop, each input item needs to be iterated on to do the swapping in each halved array? This is essentially asymptotically O(n) in my mind. If possible please provide examples and explain how to count the operations correctly! I haven't coded anything up yet but I've been looking at algorithms online. I've also attached a gif of what wikipedia is using to visually show how mergesort works.  

<a href="https://i.stack.imgur.com/YlHqG.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/YlHqG.gif" alt="enter image description here"></a>  

#### Answer accepted (score 56)
It's O(n * log(n)), not O(log(n)). As you've accurately surmised, the entire input must be iterated through, and this must occur O(log(n)) times (the input can only be halved O(log(n)) times). n items iterated log(n) times gives O(n log(n)).  

It's been proven that no comparison sort can operate faster than this. Only sorts that rely on a special property of the input such as radix sort can beat this complexity. The constant factors of mergesort are typically not that great though so algorithms with worse complexity can often take less time.  

#### Answer 2 (score 32)
The complexity of merge sort is O(nlogn) and NOT O(logn).  

Merge sort is a divide and conquer algorithm. Think of it in terms of 3 steps -   

<ol>
<li>The divide step computes the midpoint of each of the sub-arrays. Each of this step just takes O(1) time.</li>
<li>The conquer step recursively sorts two subarrays of n/2 (for even n) elements each.</li>
<li>The merge step merges n elements which takes O(n) time.</li>
</ol>

Now, for steps 1 and 3 i.e. between O(1) and O(n), O(n) is higher. Let's consider steps 1 and 3 take O(n) time in total. Say it is cn for some constant c.  

<strong>How many times are these steps executed?</strong>  

<p>For this, look at the tree below - for each level from top to bottom
Level 2 calls merge method on 2 sub-arrays of length n/2 each. The complexity here is 2 * (cn/2) = cn
Level 3 calls merge method on 4 sub-arrays of length n/4 each. The complexity here is 4 * (cn/4) = cn
and so on ... </p>

Now, the height of this tree is (logn + 1) for a given n. Thus the overall complexity is (logn + 1)*(cn). That is O(nlogn) for the merge sort algorithm.  

<a href="https://i.stack.imgur.com/rPhxO.png" rel="noreferrer"><img src="https://i.stack.imgur.com/rPhxO.png" alt="Merge sort for n elements"></a>  

Image credits: <a href="https://www.khanacademy.org/computing/computer-science/algorithms/merge-sort/a/analysis-of-merge-sort" rel="noreferrer">Khan Academy</a>  

#### Answer 3 (score 9)
Merge Sort is a recursive algorithm and time complexity can be expressed as following recurrence relation.  

<blockquote>
  T(n) = 2T(n/2) + ɵ(n)  
</blockquote>

The above recurrence can be solved either using Recurrence Tree method or Master method. It falls in case II of Master Method and solution of the recurrence is ɵ(n log n).  

Time complexity of Merge Sort is ɵ(nLogn) in all 3 cases (worst, average and best) as merge sort always divides the array in two halves and take linear time to merge two halves.  

It divides input array in two halves, calls itself for the two halves and then merges the two sorted halves. The merg() function is used for merging two halves. The merge(arr, l, m, r) is key process that assumes that arr[l..m] and arr[m+1..r] are sorted and merges the two sorted sub-arrays into one. See following C implementation for details.  

```
MergeSort(arr[], l,  r)
If r > l
     1. Find the middle point to divide the array into two halves:  
             middle m = (l+r)/2
     2. Call mergeSort for first half:   
             Call mergeSort(arr, l, m)
     3. Call mergeSort for second half:
             Call mergeSort(arr, m+1, r)
     4. Merge the two halves sorted in step 2 and 3:
             Call merge(arr, l, m, r)
```

<a href="https://i.stack.imgur.com/lF95K.png" rel="noreferrer"><img src="https://i.stack.imgur.com/lF95K.png" alt="enter image description here"></a>  

If we take a closer look at the diagram, we can see that the array is recursively divided in two halves till the size becomes 1. Once the size becomes 1, the merge processes comes into action and starts merging arrays back till the complete array is merged.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Why there is no markdown for underline? (score [153282](https://stackoverflow.com/q/207727) in )

#### Question
I am wondering why there is no markdown syntax for underline?  I know that basic html tags can be embedded to achieve this but I am trying to understand why `underline` got omitted when <strong>bold</strong> and <em>italics</em> exists  

#### Answer accepted (score 125)
There are no mention of "bold" or "italics" in <a href="http://daringfireball.net/projects/markdown/syntax">the markdown syntax document</a>. What there is, is <a href="http://daringfireball.net/projects/markdown/syntax#em">an <em>emphasis</em> section</a>, which describes how the use of underscore and asterix -marked spans (`*`, `_`, `**`, `__`) should produce code wrapped in `<em>` and `<strong>` tags.  

The reason for this, I presume, is that markdown is a markup language, like html, and <a href="http://en.wikipedia.org/wiki/Separation_of_presentation_and_content">should not be concerned with how the text is presented</a> (that's the job of the styling/CSS), but to provide semantic meaning to the text. This is particularly useful for people who use non-graphical browsers, where the emphasis can be conveyed in other ways (Think about how a screen-reader could add emphasis when it encounters an `<em>` tag, or <em>really</em> add lots of emphasis in the case of the `<strong>` tag).  

I could well use CSS to style my emphasised text with underlines, rather than italics, but this is not the browser default in most cases.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: How to recognize a good programmer? (score [150898](https://stackoverflow.com/q/33816) in 2018)

#### Question
Our company is looking for new programmers. And here comes the problem - there are many developers who look really great at the interview, seem to know the technology you need and have a good job background, but after two months of work, you find out that they are not able to work in a team, writing some code takes them a very long time, and moreover, the result is not as good as it should be.  

<p>So, do you use any formalized tests (are there any?)? How do you recognize a good programmer - and a good person? Are there any simple 'good' questions that might reveal the future problems? 
...or is it just about your 'feeling' about the person (ie., mainly your experience), and trying him/her out?</p>

Edit: According to Manoj's answer, <a href="https://stackoverflow.com/questions/304916/job-interview-coding-task">here</a> is the question related to the coding task at the job interview.  

#### Answer 2 (score 157)
Get them to talk about what they're interested in. I have yet to meet a developer who is really passionate when talking about programming but can't actually code. They may well exist, of course - and your interview should check for competency as well - but passion is a good indicator in my experience. (Note that that's not the same as being able to "talk the talk" in terms of buzzwords.)  

Ask them what they don't like about their favourite language or platform. How would they fix things? What would they like to see in the next version? Do they have hobby projects? If they've got a blog, read it. Check their general online presence.  

#### Answer 3 (score 83)
Hiring good people is <strong>hard</strong>.    

It has taken some real mistakes for me to get better at it. You start to trust your intestinal tract a lot more after the first couple of times you don't trust it and regret it.    

<p>I have a great respect for <a href="http://steve.yegge.googlepages.com/five-essential-phone-screen-questions" rel="noreferrer">Steve Yegge's phone screen questions</a> and have used this as the basis for interviewing people with some success.<br>
I also think that I became better at interviewing people after reading <a href="http://www.joelonsoftware.com/articles/fog0000000073.html" rel="noreferrer">Joel's guide to guerilla interviewing</a> (now at version 3.0, that's ahead of the version for the web and everything, it just has to be good).</p>

There are also 57 other questions (as of 20/11/2008) on <a href="https://softwareengineering.stackexchange.com/questions/tagged/interview">Software Engineering Stackexchange tagged with interview</a> and <a href="https://stackoverflow.com/questions/239185/what-is-the-best-way-to-tell-an-excellent-programmer-in-a-job-interview">some</a> of them look very relevant, so check those out.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Stack and Heap memory in Java (score [149614](https://stackoverflow.com/q/65281) in 2014)

#### Question
As I understand, in Java, stack memory holds primitives and method invocations and heap memory is used to store objects.  

Suppose I have a class   

```
class A {
       int a ;
       String b;
       //getters and setters
}
```

<ol>
<li><p>Where will the primitive `a` in class `A` be stored?</p></li>
<li><p>Why does heap memory exist at all? Why can't we store everything on the stack?</p></li>
<li><p>When the object gets garbage collected, is the stack associated with the objected destroyed?</p></li>
</ol>

#### Answer accepted (score 106)
The basic difference between stack and heap is the life cycle of the values.  

<p>Stack values only exist within the scope of the function they are created in. Once it returns, they are discarded.<br>
Heap values however exist on the heap. They are created at some point in time, and destructed at another (either by GC or manually, depending on the language/runtime).</p>

<p>Now Java only stores primitives on the stack. This keeps the stack small and helps keeping individual stack frames small, thus allowing more nested calls.<br>
Objects are created on the heap, and only references (which in turn are primitives) are passed around on the stack.  </p>

So if you create an object, it is put on the heap, with all the variables that belong to it, so that it can persist after the function call returns.  

#### Answer 2 (score 49)
<h5>Where are primitive fields stored?</h2>

Primitive fields are stored as part of the object that is instantiated <em>somewhere</em>. The easiest way to think of where this is - is the heap.  <em>However</em>, this is not always the case.  As described in <a href="http://www.ibm.com/developerworks/java/library/j-jtp09275/index.html" rel="noreferrer">Java theory and practice: Urban performance legends, revisited</a>:  

<blockquote>
  JVMs can use a technique called escape analysis, by which they can tell that certain objects remain confined to a single thread for their entire lifetime, and that lifetime is bounded by the lifetime of a given stack frame. Such objects can be safely allocated on the stack instead of the heap. Even better, for small objects, the JVM can optimize away the allocation entirely and simply hoist the object's fields into registers.  
</blockquote>

Thus, beyond saying "the object is created and the field is there too", one cannot say if something is on the heap or on the stack.  Note that for small, short lived objects, its possible that the 'object' won't exist in memory as such and may instead have its fields placed directly in registers.  

The paper concludes with:  

<blockquote>
  JVMs are surprisingly good at figuring out things that we used to assume only the developer could know. By letting the JVM choose between stack allocation and heap allocation on a case-by-case basis, we can get the performance benefits of stack allocation without making the programmer agonize over whether to allocate on the stack or on the heap.  
</blockquote>

Thus, if you have code that looks like:  

```
void foo(int arg) {
    Bar qux = new Bar(arg);
    ...
}
```

where the `...` doesn't allow `qux` to leave that scope, `qux` <em>may</em> be allocated on the stack instead.  This is actually a win for the VM because it means it doesn't need to ever be garbage collected - it will disappear when it leaves the scope.  

More on <a href="http://en.wikipedia.org/wiki/Escape_analysis" rel="noreferrer">escape analysis</a> at Wikipedia.  For those willing to delve into papers, <a href="http://www-plan.cs.colorado.edu/diwan/7135/escapeOopsla99.ps" rel="noreferrer">Escape Analysis for Java</a> from IBM.  For those coming from a C# world, you may find <a href="http://blogs.msdn.com/b/ericlippert/archive/2009/04/27/the-stack-is-an-implementation-detail.aspx" rel="noreferrer">The Stack Is An Implementation Detail</a> and <a href="http://blogs.msdn.com/b/ericlippert/archive/2010/09/30/the-truth-about-value-types.aspx" rel="noreferrer">The Truth About Value Types</a> by Eric Lippert good reads (they're useful for Java types also as many of the concepts and aspects are the same or similar). <a href="https://softwareengineering.stackexchange.com/q/16571/40980">Why do .Net books talk about stack vs heap memory allocation?</a> also goes into this.  

<h5>On the whys of the stack and the heap</h2>

<h5>On the heap</h3>

So, why have the stack or the heap at all? For things that leave scope, the stack can be expensive.  Consider the code:  

```
void foo(String arg) {
    bar(arg);
    ...
}

void bar(String arg) {
    qux(arg);
    ...
}

void qux(String arg) {
    ...
}
```

The parameters are part of the stack too.  In the situation that you don't have a heap, you would be passing the full set of values on the stack.  This is fine for `"foo"` and small strings... but what would happen if someone put a huge XML file in that string.  Each call would copy the entire huge string onto the stack - and <em>that</em> would be quite wasteful.  

Instead, it is better to put the objects that have some life outside of the immediate scope (passed to another scope, stuck in a structure that someone else is maintaining, etc...) into another area which is called the heap.  

<h5>On the stack</h3>

You don't <em>need</em> the stack.  One could, hypothetically, write a language that doesn't use a stack (of arbitrary depth).  An old BASIC that I learned on in my youth did so, one could only do 8 levels of `gosub` calls and all variables were global - there was no stack.  

The advantage of the stack is that when you have a variable that exists with a scope, when you leave that scope, that stack frame is popped.  It really simplifies what is there and what isn't there.  The program moves to another procedure, a new stack frame; the program returns to the procedure, and you've back in the one that sees your current scope; the program leaves the procedure and all the items on the stack are deallocated.  

This really makes life easy for the person writing the runtime for the code to use a stack and a heap.  They simply many concepts and ways of working on the code allowing the person writing the code in the language to be freed of thinking of them explicitly.  

The stack's nature also means it can't become fragmented. <a href="http://en.wikipedia.org/wiki/Fragmentation_(computing)" rel="noreferrer">Memory fragmentation</a> is a real problem with the heap.  You allocate a few objects, then garbage collect a middle one, and then try finding space for the next large one to be allocated.  Its a mess.  Being able to put things on the stack instead means that you don't have to deal with that.  

<h5>When something is garbage collected</h2>

When something is garbage collected, its gone.  But it is only garbage collected because its already forgotten about - there are no more references to the object in the program that can be accessed from the current state of the program.  

I'll point out that this is a very large simplification of garbage collection.  There are many garbage collectors (even within Java - you can tweak the garbage collector by using various flags (<a href="http://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html" rel="noreferrer">docs</a>).  These behave differently and the nuances of how each one does things is a bit too deep for this answer.  You may wish to read <a href="http://www.oracle.com/webfolder/technetwork/tutorials/obe/java/gc01/index.html" rel="noreferrer">Java Garbage Collection Basics</a> to get a better idea of how some of that works.  

That said, if something is allocated on the stack, it is not garbage collected as part of `System.gc()` - it is deallocated when the stack frame pops.  If something is on the heap, and referenced from something on the stack, it will not be garbage collected at that time.  

<h5>Why does this matter?</h2>

For the most part, its tradition.  The text books written and compiler classes and various bits documentation make a big deal about the heap and the stack.  

However, virtual machines of today (JVM and similar) have gone to great lengths to try to keep this hidden from the programmer.  Unless you are running out of one or the other and need to know <em>why</em> (rather than just increasing the storage space appropriately), it doesn't matter too much.  

The object is <em>somewhere</em> and its in the place where it can be accessed correctly and quickly for the appropriate amount of time that it exists.  If its on the stack or the heap - it doesn't really matter.  

#### Answer 3 (score 7)
<ol>
<li>In the heap, as part of the object, which is referenced by a pointer in the stack. ie. a and b will be stored adjacent to each other.</li>
<li>Because if all memory were stack memory, it wouldn't be efficient any more. It's good to have a small, fast-access area where we start and have that reference items in the much larger area of memory which remains. However, this is overkill when an object is simply a single primitive which would take up about the same amount of space on the stack as the pointer to it would.</li>
<li>Yes.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: What Specifications should a Programmer Seek in a Computer Purchase ? Or, What Computer should I buy? (score [148914](https://stackoverflow.com/q/200495) in 2015)

#### Question
I wish to acquire a new computer that is specially designed for programming.   

I would like to build it myself for the learning experience, but am willing to purchase it made as well.  

Basically I have downloaded so many files dedicated to programming that are so large that a) my computer is near capacity and b) my 4 year old computer is extremely slow.  

Specifically, I am into databases (Oracle/PostGreSQL, Mongo, Hadoop) and java, but love learning all possible languages.  

#### Answer 2 (score 10)
I would say build a computer that has decent amount of power. The reason for this is that some languages have useful IDEs (ex: Visual Studios for .NET), and some of those IDEs require a powerful machine (ex: Eclipse for Java).  

Also, we computer people should have powerful and interesting computers. :)  

CPU, RAM, and storage (HDD or SSD) are probably most important for a programmer. Some specs that would be ideal for such a computer (in my view) are:  

```
Intel i5 CPU (3.0+ GHz)
8+ GB RAM
~500GB Harddrive
(Optional) An SSD for OS and big programs such as Eclipse
```

These specs will suffice for a programmers use, but you may go for better specs if you so desire. The rest of the parts won't really matter much and are based more on preference than specs.  

#### Answer 3 (score 6)
Subjective Question but here's my answer:  

Whatever you do, include a SSD, at least big enough to install the OS (64-128GB). sacrifice some CPU power to get it if you have to. Also the more RAM the better.   

My current 'Basic' Davelopment system (I have built 2 this year and they are good for my programming needs):  

```
Pentium G630. (entry level, socket compatible with i3 i5 i7 etc)
4GB RAM DDR3
500GB 7200RPM hard drive
128GB SSD (I used Kingston SSDNow which is cheaper but there are better ones)
350w Power supply
Cheapest Gigabyte motherboard
24-inch 1920x1080 monitor. (This is just big enough to display two documents side by side - of course dual screen would be nicer!)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Why are interfaces useful? (score [148280](https://stackoverflow.com/q/108240) in 2011)

#### Question
I have been studying and coding in C# for some time now. But still, I can't figure the usefulness of Interfaces. They bring too little to the table. Other than providing the signatures of function, they do nothing. If I can remember the names and signature of the functions which are needed to be implemented, there is no need for them. They are there just to make sure that the said functions(in the interface) are implemented in the inheriting class.  

C# is a great language, but sometimes it gives you the feeling that first Microsoft creates the problem (not allowing multiple inheritance) and then provides the solution, which is rather a tedious one.  

That's my understanding which is based on limited coding experience. What's your take on interfaces? How often you make uses of them and what makes you do so?  

#### Answer accepted (score 151)
<blockquote>
  They are there just to make sure that the said functions (in the interface) are implemented in the inheriting class.  
</blockquote>

Correct. That's a sufficiently awesome benefit to justify the feature. As others have said, an interface is a <em>contractual obligation</em> to implement certain methods, properties and events. The compelling benefit of a statically typed language is that the compiler can verify that a contract which your code relies upon is actually met.  

That said, interfaces are a fairly weak way to represent contractual obligations. If you want a stronger and more flexible way to represent contractual obligations, look into the Code Contracts feature that shipped with the last version of Visual Studio.  

<blockquote>
  C# is a great language, but sometime it gives you the feeling that first Microsoft creates the problem(not allowing multiple inheritance) and then provides the solution, which is rather a tedious one.  
</blockquote>

Well I'm glad you like it.   

All complex software designs are a result of weighing conflicting features against each other, and trying to find the "sweet spot" that gives large benefits for small costs. We've learned through painful experience that languages that permit multiple inheritance <em>for the purposes of implementation sharing</em> have relatively small benefits and relatively large costs. Permitting multiple inheritance only on interfaces, which do not share implementation details, gives many of the benefits of multiple inheritance without most of the costs.  

#### Answer 2 (score 235)
<img src="https://i.stack.imgur.com/y3IN7.png" alt="enter image description here">  

So in this example, the PowerSocket doesn't know anything else about the other objects. The objects all depend on Power provided by the PowerSocket, so they implement IPowerPlug, and in so doing they can connect to it.  

Interfaces are useful because they provide contracts that objects can use to work together without needing to know anything else about each other.  

#### Answer 3 (score 145)
<blockquote>
  Other than providing the signatures of function, they do nothing. If I can remember the names and signature of the functions which are needed to be implemented, there is no need for them  
</blockquote>

The point of interfaces is not to help you remember what method to implement, it is here to <strong>define a contract</strong>. In <a href="https://softwareengineering.stackexchange.com/questions/108240/usefulness-of-interfaces-in-c/108242#108242">foreach P.Brian.Mackey example</a> (which <a href="https://stackoverflow.com/questions/6368967/duck-typing-in-the-c-compiler/6369022#6369022">turns out to be wrong</a>, but we don't care), IEnumerable defines a contract between <em>foreach</em> and <strong>any</strong> enumerable thing. It says : "Whoever you are, as long as you stick to the contract (implement IEnumerable), I promise you I'll iterate over all your elements". And, that is great (for a non dynamic language).    

Thanks to interfaces you can achieve very low coupling between two classes.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: When do you use a struct instead of a class? (score [147805](https://stackoverflow.com/q/92339) in 2019)

#### Question
What are your rules of thumb for when to use structs vs. classes?  I'm thinking of the C# definition of those terms but if your language has similar concepts I'd like to hear your opinion as well.  

I tend to use classes for almost everything, and use structs only when something is very simplistic and should be a value type, such as a PhoneNumber or something like that.  But this seems like a relatively minor use and I hope there are more interesting use cases.  

#### Answer accepted (score 169)
The general rule to follow is that structs should be small, simple (one-level) collections of related properties, that are immutable once created; for anything else, use a class.  

C# is nice in that structs and classes have no explicit differences in declaration other than the defining keyword; so, if you feel you need to "upgrade" a struct to a class, or conversely "downgrade" a class to a struct, it's mostly a simple matter of changing the keyword (there are a few other gotchas; structs can't derive from any other class or struct type, and they can't explicitly define a default parameterless constructor).  

I say "mostly", because the more important thing to know about structs is that, because they are value types, treating them like classes (reference types) can end up a pain and a half. Particularly, making a structure's properties mutable can cause unexpected behavior.   

For example, say you have a class SimpleClass with two properties, A and B. You instantiate a copy of this class, initialize A and B, and then pass the instance to another method. That method further modifies A and B. Back in the calling function (the one that created the instance), your instance's A and B will have the values given to them by the called method.  

Now, you make it a struct. The properties are still mutable. You perform the same operations with the same syntax as before, but now, A and B's new values aren't in the instance after calling the method. What happened? Well, your class is now a struct, meaning it's a value type. If you pass a value type to a method, the default (without an out or ref keyword) is to pass "by value"; a shallow copy of the instance is created for use by the method, and then destroyed when the method is done leaving the initial instance intact.   

This becomes even more confusing if you were to have a reference type as a member of your struct (not disallowed, but <em>extremely</em> bad practice in virtually all cases); the class would not be cloned (only the struct's reference to it), so changes to the struct would not affect the original object, but changes to the struct's subclass WILL affect the instance from the calling code. This can very easily put mutable structs in very inconsistent states that can cause errors a long way away from where the real problem is.  

For this reason, virtually every authority on C# says to always make your structures immutable; allow the consumer to specify the properties' values only on construction of an object, and never provide any means to change that instance's values. Readonly fields, or get-only properties, are the rule. If the consumer wants to change the value, they can create a new object based on the values of the old one, with the changes they want, or they can call a method which will do the same. This forces them to treat a single instance of your struct as one conceptual "value", indivisible and distinct from (but possibly equatable to) all others. If they perform an operation on a "value" stored by your type, they get a new "value" which is different from their initial value, but still comparable and/or semantically equatable.  

For a good example, look at the DateTime type. You cannot assign any of the fields of a DateTime instance directly; you must either create a new one, or call a method on the existing one which will produce a new instance. This is because a date and time are a "value", like the number 5, and a change to the number 5 results in a new value that is not 5. Just because 5+1 = 6 doesn't mean 5 is now 6 because you added 1 to it. DateTimes work the same way; 12:00 does not "become" 12:01 if you add a minute, you instead get a new value 12:01 that is distinct from 12:00. If this is a logical state of affairs for your type (good conceptual examples that aren't built in to .NET are Money, Distance, Weight, and other quantities of a UOM where operations must take all parts of the value into account), then use a struct and design it accordingly. In most other cases where the sub-items of an object should be independently mutable, use a class.  

#### Answer 2 (score 14)
The answer: "Use a struct for pure data constructs, and a class for objects with operations" is definitely wrong IMO.  If a struct holds a large number of properties then a class is nearly always more appropriate.  Microsoft often says, from an efficiency point of view, if your type is larger than 16 bytes it should be a class.  

<a href="https://stackoverflow.com/questions/1082311/why-should-a-net-struct-be-less-than-16-bytes">https://stackoverflow.com/questions/1082311/why-should-a-net-struct-be-less-than-16-bytes</a>  

#### Answer 3 (score 10)
The most important difference between a `class` and a `struct` is what happens in the following situation:  

<pre>
  Thing thing1 = new Thing();
  thing1.somePropertyOrField = 5;
  Thing thing2 = thing1;
  thing2.somePropertyOrField = 9;
</pre>

What should be the effect of the last statement on `thing1.somePropertyOrField`?  If `Thing` a struct, and `somePropertyOrField` is an exposed public field, the objects `thing1` and `thing2` will be "detached" from each other, so the latter statement will not affect `thing1`.  If `Thing` is a class, then `thing1` and `thing2` will be attached to each other, and so the latter statement will write `thing1.somePropertyOrField`.  One should use a struct in cases where the former semantics would make more sense, and should use a class in cases where the latter semantics would make more sense.  

Note that while some people advise that a desire to make something mutable is an argument in favor of it being the class, I would suggest the reverse is true: if something which exists for the purpose of holding some data is going to be mutable, and if it will not be obvious whether instances are attached to anything, the thing should be a struct (likely with exposed fields) so as to make clear that instances are not attached to anything else.  

For example, consider the statements:  

<pre>
  Person somePerson = myPeople.GetPerson("123-45-6789");
  somePerson.Name = "Mary Johnson"; // Had been "Mary Smith"
</pre>

Will the second statement alter the information stored in `myPeople`?  If `Person` is an exposed-field struct, it won't, <i>and the fact that it won't will be an obvious consequence of its being an exposed-field struct</i>; if `Person` is a struct and one wishes to update `myPeople`, one would clearly have to do something like `myPeople.UpdatePerson("123-45-6789", somePerson)`.  If `Person` is a class, however, it may be much harder to determine whether the above code would never update the contents of `MyPeople`, always update it, or sometimes update it.  

With regard to the notion that structs should be "immutable", I disagree in general.  There are valid usage cases for "immutable" structs (where invariants are enforced in a constructor) but requiring that an entire struct must be rewritten any time any part of it changes is awkward, wasteful, and more apt to cause bugs than would simply exposing fields directly.  For example, consider a `PhoneNumber` struct whose fields, include among others, `AreaCode` and `Exchange`, and suppose one has a `List<PhoneNumber>`.  The effect of the following should be pretty clear:  

<pre>
  for (int i=0; i &lt; myList.Count; i++)
  {
    PhoneNumber theNumber = myList[i];
    if (theNumber.AreaCode == "312")
    {
      string newExchange = "";
      if (new312to708Exchanges.TryGetValue(theNumber.Exchange), out newExchange)
      {
        theNumber.AreaCode = "708";
        theNumber.Exchange = newExchange;
        myList[i] = theNumber;
      }
    }
  }
</pre>

Note that nothing in the above code knows or cares about any fields in `PhoneNumber` other than `AreaCode` and `Exchange`.  If `PhoneNumber` were a so-called "immutable" struct, it would be necessary either that it provide a `withXX` method for each field, which would return a new struct instance which held the passed-in value in the indicated field, or else it would be necessary for code like the above to know about every field in the struct.  Not exactly appealing.  

BTW, there are at least two cases where structs may reasonably hold references to mutable types.  

<ol><li>The semantics of the struct indicate that it's storing the identity of the object in question, rather than as a shortcut for holding the object's properties.  For example, a `KeyValuePair` would hold the identities of certain buttons, but would not be expected to hold a persistent information about those button's positions, highlight states, etc.
<li>The struct knows that it holds the only reference to that object, nobody else will get a reference, and any mutations which will ever be performed to that object will have been done before a reference to it gets stored anywhere.
</ol>

In the former scenario, the object's IDENTITY will be immutable; in the second, the class of the nested object may not enforce immutability, but the struct holding the reference will.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: How accurate is "Business logic should be in a service, not in a model"? (score [147165](https://stackoverflow.com/q/218011) in 2019)

#### Question
<strong>Situation</strong>  

Earlier this evening I gave an <a href="https://stackoverflow.com/questions/19881435/editing-of-an-existing-object-should-be-done-in-repository-layer-or-in-service">answer</a> to a question on StackOverflow.   

<em>The question:</em>  

<blockquote>
  Editing of an existing object should be done in repository layer or in service?   
  
  For example if I have a User that has debt. I want to change his debt. Should I do it in UserRepository or in service for example BuyingService by getting an object, editing it and saving it ?  
</blockquote>

<em>My answer:</em>  

<blockquote>
  You should leave the responsibility of mutating an object to that same object and use the repository to retrieve this object.   
</blockquote>

<em>Example situation:</em>  

```
class User {
    private int debt; // debt in cents
    private string name;

    // getters

    public void makePayment(int cents){
        debt -= cents;
    }
}

class UserRepository {
    public User GetUserByName(string name){
        // Get appropriate user from database
    }
}
```

<em>A comment I received:</em>  

<blockquote>
  Business logic should really be in a service. Not in a model.  
</blockquote>

<strong>What does the internet say?</strong>  

<p>So, this got me searching since I've never really (consciously) used a service layer.
I started reading up on the Service Layer pattern and the Unit Of Work pattern but so far I can't say I'm convinced a service layer has to be used.</p>

Take for example <a href="http://martinfowler.com/bliki/AnemicDomainModel.html" rel="noreferrer">this article</a> by Martin Fowler on the anti-pattern of an Anemic Domain Model:  

<blockquote>
  There are objects, many named after the nouns in the domain space, and these objects are connected with the rich relationships and structure that true domain models have. The catch comes when you look at the behavior, and you realize that there is hardly any behavior on these objects, making them little more than bags of getters and setters. Indeed often these models come with design rules that say that you are not to put any domain logic in the the domain objects. Instead there are a set of service objects which capture all the domain logic. These services live on top of the domain model and use the domain model for data.  
  
  (...)  The logic that should be in a domain object is domain logic - validations, calculations, business rules - whatever you like to call it.  
</blockquote>

To me, this seemed exactly what the situation was about: I advocated the manipulation of an object's data by introducing methods inside that class that do just that. However I realize that this should be a given either way, and it probably has more to do with how these methods are invoked (using a repository).  

I also had the feeling that in that article (see below), a Service Layer is more considered as a <a href="http://en.wikipedia.org/wiki/Facade_pattern" rel="noreferrer">façade</a> that delegates work to the underlying model, than an actual work-intensive layer.  

<blockquote>
  Application Layer [his name for Service Layer]: Defines the jobs the software is supposed to do and directs the expressive domain objects to work out problems. The tasks this layer is responsible for are meaningful to the business or necessary for interaction with the application layers of other systems. This layer is kept thin. It does not contain business rules or knowledge, but only coordinates tasks and delegates work to collaborations of domain objects in the next layer down. It does not have state reflecting the business situation, but it can have state that reflects the progress of a task for the user or the program.  
</blockquote>

Which is reinforced <a href="http://msdn.microsoft.com/en-us/library/ee658090.aspx" rel="noreferrer">here</a>:  

<blockquote>
  Service interfaces. Services expose a service interface to which all inbound messages are sent. You can think of a service interface as a façade that exposes the business logic implemented in the application (typically, logic in the business layer) to potential consumers.  
</blockquote>

And <a href="https://softwareengineering.stackexchange.com/questions/168517/recovering-an-anemic-domain-model-into-a-multitier-architecture">here</a>:  

<blockquote>
  The service layer should be devoid of any application or business logic and should focus primarily on a few concerns. It should wrap Business Layer calls, translate your Domain in a common language that your clients can understand, and handle the communication medium between server and requesting client.  
</blockquote>

This is a serious contrast to <a href="https://stackoverflow.com/questions/9010088/on-properly-implementing-complex-service-layers?rq=1">other resources</a> that talk about the Service Layer:  

<blockquote>
  The service layer should consist of classes with methods that are units of work with actions that belong in the same transaction.  
</blockquote>

Or the <a href="https://stackoverflow.com/questions/4270461/service-layer-in-java-swing-application?rq=1">second answer</a> to a question I've already linked:  

<blockquote>
  At some point, your application will want some business logic. Also, you might want to validate the input to make sure that there isn't something evil or nonperforming being requested. This logic belongs in your service layer.  
</blockquote>

<strong>"Solution"?</strong>  

Following the guidelines in <a href="https://softwareengineering.stackexchange.com/questions/211688/use-a-service-layer-with-mvc">this answer</a>, I came up with the following approach that uses a Service Layer:  

```
class UserController : Controller {
    private UserService _userService;

    public UserController(UserService userService){
        _userService = userService;
    } 

    public ActionResult MakeHimPay(string username, int amount) {
        _userService.MakeHimPay(username, amount);
        return RedirectToAction("ShowUserOverview");
    }

    public ActionResult ShowUserOverview() {
        return View();
    }
}

class UserService {
    private IUserRepository _userRepository;

    public UserService(IUserRepository userRepository) {
        _userRepository = userRepository;
    }

    public void MakeHimPay(username, amount) {
        _userRepository.GetUserByName(username).makePayment(amount);
    }
}

class UserRepository {
    public User GetUserByName(string name){
        // Get appropriate user from database
    }
}

class User {
    private int debt; // debt in cents
    private string name;

    // getters

    public void makePayment(int cents){
        debt -= cents;
    }
}
```

<strong>Conclusion</strong>  

All together not much has changed here: code from the controller has moved to the service layer (which is a good thing, so there is an upside to this approach). However this doesn't look like it had anything to do with my original answer.  

I realize design patterns are guidelines, not rules set in stone to be implemented whenever possible. Yet I have not found a definitive explanation of the service layer and how it should be regarded.   

<ul>
<li><p>Is it a means to simply extract logic from the controller and put it inside a service instead? </p></li>
<li><p>Is it supposed to form a contract between the controller and the domain? </p></li>
<li><p>Should there be a layer between the domain and the service layer?</p></li>
</ul>

And, last but not least: following the original comment   

<blockquote>
  Business logic should really be in a service. Not in a model.   
</blockquote>

<ul>
<li><p>Is this correct?</p>

<ul>
<li>How would I introduce my business logic in a service instead of the model?</li>
</ul></li>
</ul>

#### Answer accepted (score 369)
In order to define what a <em>service's</em> responsibilities are, you first need to define what a <em>service</em> is.  

<em>Service</em> is not a canonical or generic software term. In fact, the suffix `Service` on a class name is a lot like the much-maligned <a href="http://www.codinghorror.com/blog/2006/03/i-shall-call-it-somethingmanager.html">Manager</a>: It tells you almost nothing about what the object actually <em>does</em>.  

In reality, what a service ought to do is highly architecture-specific:  

<ol>
<li><p>In a traditional layered architecture, <em>service</em> is literally synonymous with <em>business logic layer</em>. It's the layer between UI and Data. Therefore, <strong>all</strong> business rules go into services. The data layer should only understand basic CRUD operations, and the UI layer should deal only with the mapping of presentation DTOs to and from the business objects.</p></li>
<li><p>In an RPC-style distributed architecture (SOAP, UDDI, BPEL, etc.), the <em>service</em> is the logical version of a physical <em>endpoint</em>. It is essentially a collection of operations that the maintainer wishes to provide as a public API. Various best practices guides explain that a service <em>operation</em> should in fact be a business-level operation and not CRUD, and I tend to agree.</p>

However, because routing <em>everything</em> through an actual remote service can seriously hurt performance, it's normally best <em>not</em> to have these services actually implement the business logic themselves; instead, they should wrap an "internal" set of business objects. A single service might involve one or several business objects.  </li>
<li><p>In an MVP/MVC/MVVM/MV* architecture, <em>services</em> don't exist at all. Or if they do, the term is used to refer to any generic object that can be injected into a controller or view model. The business logic is in your <em>model</em>. If you want to create "service objects" to orchestrate complicated operations, that's seen as an implementation detail. A lot of people, sadly, implement MVC like this, but it's considered an anti-pattern (<a href="http://en.wikipedia.org/wiki/Anemic_domain_model">Anemic Domain Model</a>) because the model itself does nothing, it's just a bunch of properties for the UI.</p>

Some people mistakenly think that taking a 100-line controller method and shoving it all into a service somehow makes for a better architecture. It really doesn't; all it does is add another, probably unnecessary layer of indirection. <em>Practically</em> speaking, the controller is still doing the work, it's just doing so through a poorly named "helper" object. I highly recommend Jimmy Bogard's <a href="http://vimeo.com/43598193">Wicked Domain Models</a> presentation for a clear example of how to turn an anemic domain model into a useful one. It involves careful examination of the models you're exposing and which operations are actually valid in a <em>business</em> context.  

For example, if your database contains Orders, and you have a column for Total Amount, your application <em>probably</em> shouldn't be allowed to actually change that field to an arbitrary value, because (a) it's history and (b) it's supposed to be determined by what's <em>in</em> the order as well as perhaps some other time-sensitive data/rules. Creating a service to manage Orders does not necessarily solve this problem, because user code can <em>still</em> grab the actual Order object and change the amount on it. Instead, the order <em>itself</em> should be responsible for ensuring that it can only be altered in safe and consistent ways.  </li>
<li><p>In DDD, services are meant specifically for the situation <a href="http://gorodinski.com/blog/2012/04/14/services-in-domain-driven-design-ddd/">when you have an operation that doesn't properly belong to any aggregate root</a>. You have to be careful here, because often the need for a service can imply that you didn't use the correct roots. But assuming you did, a service is used to coordinate operations across multiple roots, or sometimes to handle concerns that don't involve the domain model at all (such as, perhaps, writing information to a BI/OLAP database).</p>

One notable aspect of the DDD service is that it is allowed to use <a href="http://martinfowler.com/eaaCatalog/transactionScript.html">transaction scripts</a>. When working on large applications, you're very likely to eventually run into instances where it's just way easier to accomplish something with a T-SQL or PL/SQL procedure than it is to fuss with the domain model. This is OK, and it belongs in a Service.  

This is a radical departure from the layered-architecture definition of services. A service layer encapsulates domain objects; a DDD service encapsulates whatever <strong>isn't</strong> in the domain objects and doesn't make sense to be.  </li>
<li><p>In a Service-Oriented Architecture, a <em>service</em> is considered to be the technical authority for a business capability. That means that it is the <em>exclusive</em> owner of a certain subset of the business data and nothing else is allowed to touch that data - not even to just <em>read</em> it.</p>

By necessity, services are actually an end-to-end proposition in an SOA. Meaning, a service isn't so much a specific <em>component</em> as an entire <em>stack</em>, and your entire application (or your entire business) is a set of these services running side-by-side with no intersection except at the messaging and UI layers. Each service has its own data, its own business rules, and its own UI. They don't need to orchestrate with each other because they are supposed to be business-aligned - and, like the business itself, each service has its own set of responsibilities and operates more or less independently of the others.  

So, by the SOA definition, every piece of business logic <em>anywhere</em> is contained within the service, but then again, so is the entire <em>system</em>. Services in an SOA can have <em>components</em>, and they can have <em>endpoints</em>, but it's fairly dangerous to call any piece of code a <em>service</em> because it conflicts with what the original "S" is supposed to mean.  

Since SOA is generally pretty keen on messaging, the operations that you might have packaged in a <em>service</em> before are generally encapsulated in <em>handlers</em>, but the multiplicity is different. Each handler handles <em>one</em> message type, <em>one</em> operation. It's a strict interpretation of the <a href="http://en.wikipedia.org/wiki/Single_responsibility_principle">Single Responsibility Principle</a>, but makes for great maintainability because every possible operation is in its own class. So you don't really <em>need</em> centralized business logic, because commands represents business operations rather than technical ones.  </li>
</ol>

Ultimately, in any architecture you choose, there is going to be some component or layer that has most of the business logic. After all, if business logic is scattered all over the place then you just have spaghetti code. But whether or not you call that component a <em>service</em>, and how it's designed in terms of things like number or size of operations, depends on your architectural goals.  

There's no right or wrong answer, only what applies to your situation.  

#### Answer 2 (score 40)
As for your <strong>title</strong>, I don't think the question makes sense.  The MVC Model consists of data and business logic.  To say logic should be in the Service and not the Model is like saying, "The passenger should sit in the seat, not in the car".    

Then again, the term "Model" is an overloaded term.  Perhaps you didn't mean MVC Model but you meant model in the Data Transfer Object (DTO) sense.  AKA an Entity.  This is what Martin Fowler is talking about.  

The way I see it, Martin Fowler is speaking of things in an ideal world.  In the real world of Hibernate and JPA (in Java land) the DTOs are a super leaky abstraction.  I'd love to put my business logic in my entity.  It'd make things way cleaner.  The problem is these entities can exist in a managed/cached state that is very difficult to understand and constantly prevents your efforts.  To summarize my opinion: Martin Fowler is recommending the right way, but the ORMs prevent you from doing it.  

I think Bob Martin has a more realistic suggestion and <a href="http://cleancoders.com/codecast/clean-code-episode-5/show">he gives it in this video that's not free</a>.  He talks about keeping your DTOs free of logic.  They simply hold the data and transfer it to another layer that's much more object oriented and doesn't use the DTOs directly.  This avoids the leaky abstraction from biting you.  The layer with the DTOs and the DTOs themselves are not OO.  But once you get out of that layer, you get to be as OO as Martin Fowler advocates.  

The benefit to this separation is it abstracts away the persistence layer.  You could switch from JPA to JDBC (or vice versa) and none of the business logic would have to change.  It just depends on the DTOs, it doesn't care <em>how</em> those DTOs get populated.    

To <em>slightly</em> change topics, you need to consider the fact that SQL databases aren't object oriented.  But ORMs usually have an entity - which is an object - per table.  So right from the start you've already lost a battle.  In my experience, you can never represent the Entity the exact way you want in an object oriented way.    

As for "<strong>a</strong> service", Bob Martin would be against having a class named `FooBarService`.  That's not object oriented.  What does a service do?  <em>Anything</em> related to `FooBars`.  It may as well be labeled `FooBarUtils`.  I think he'd advocate a service layer (a better name would be the business logic layer) but every class in that layer would have a meaningful name.    

#### Answer 3 (score 25)
I'm working on the greenfield project right now and we had to make few architectural decisions  just yesterday. Funnily enough I had to revisit few chapters of 'Patterns of Enterprise Application Architecture'.  

This is what we came up with:  

<ul>
<li>Data layer. Queries and updates database. The layer is exposed through injectable repositories.</li>
<li>Domain layer. This is where the business logic lives. This layer makes a use of injectable repositories and is responsible for the majority of business logic. This is the core of the application that we will test thoroughly. </li>
<li>Service layer. This layer talks to the domain layer and serves the client requests. In our case the service layer is quite simple - it relays requests to the domain layer, handles security and few other cross cutting concerns. This is not much different to a controller in MVC application - controllers are small and simple.</li>
<li>Client layer. Talks to the service layer through SOAP.</li>
</ul>

We end up with the following:  

Client -> Service -> Domain -> Data  

We can replace client, service or data layer with reasonable amount of work. If your domain logic lived in the service and you've decided that you want to replace or even remove your service layer, then you'd have to move all of the business logic somewhere else. Such a requirement is rare, but it might happen.  

Having said all this, I think this is pretty close to what Martin Fowler meant by saying  

<blockquote>
  <p>These services live on top of the domain model and use the domain
  model for data.</p>
</blockquote>

Diagram below illustrates this pretty well:  

<a href="http://martinfowler.com/eaaCatalog/serviceLayer.html">http://martinfowler.com/eaaCatalog/serviceLayer.html</a>  

<blockquote>
  <img src="https://i.stack.imgur.com/d1Y57.gif" alt="http://martinfowler.com/eaaCatalog/ServiceLayerSketch.gif" title="Service Layer sketch">  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: Why declare final variables inside methods? (score [146994](https://stackoverflow.com/q/115690) in 2013)

#### Question
<p>Studying some classes of Android, I realized that most of the variables of methods
are declared as final.</p>

Example code taken from the class android.widget.ListView:  

```
/**
* @return Whether the list needs to show the top fading edge
*/
private boolean showingTopFadingEdge() {
    final int listTop = mScrollY + mListPadding.top;
    return (mFirstPosition > 0) || (getChildAt(0).getTop() > listTop);
}

/**
 * @return Whether the list needs to show the bottom fading edge
 */
private boolean showingBottomFadingEdge() {
    final int childCount = getChildCount();
    final int bottomOfBottomChild = getChildAt(childCount - 1).getBottom();
    final int lastVisiblePosition = mFirstPosition + childCount - 1;
    final int listBottom = mScrollY + getHeight() - mListPadding.bottom;
    return (lastVisiblePosition < mItemCount - 1)
                     || (bottomOfBottomChild < listBottom);
}
```

What is the intention of using the final keyword in these cases?  

#### Answer accepted (score 63)
I would say that this is due to <em>force of habit</em>. The programmer that wrote this code knew as he was writing it that the values for the final variables should never be changed after assignment, and so made them final. Any attempt to assign a new value to a final variable after assignment will result in a compiler error.   

As habits go, it's not a bad one to develop. At the least, making a variable final specifies the <em>intent</em> of the programmer at the time of writing. This is important as it might give subsequent programmers who edit the code pause for thought before they start changing how that variable is used.   

#### Answer 2 (score 53)
Speaking as a Java developer who makes all variables `final` by default (and who appreciates the fact that Eclipse can do this automatically), I find it easier to reason about my program if variables are initialized once and never changed again.  

For one thing, uninitialized variables are no longer any concern, because trying to use a `final` variable before it has been initialized will result in a compile error.  This is particularly useful for nested conditional logic, where I want to make sure that I covered all the cases:  

```
final int result;
if (/* something */) {
  if (/* something else */) {
    result = 1;
  }
  else if (/* some other thing */) {
    result = 2;
  }
}
else {
  result = 3;
}
System.out.println(result);
```

Did I cover all the cases?  (Hint: No.)  Sure enough, this code won't even compile.  

One more thing: In general, any time you know that something is always true about a variable, you should try to get your language to enforce it.  We do this every day when we specify a variable's type, of course:  The language will ensure that values that are not of that type cannot be stored in that variable.  Likewise, if you know that a variable should not be reassigned because it already has the value that it should keep for the entire method, then you can get the language to enforce that restriction by declaring it `final`.  

Lastly, there's the matter of habit.  Others have mentioned that this is a habit (+1 to <a href="https://softwareengineering.stackexchange.com/questions/115690/why-declare-final-variables-inside-methods/115702#115702">Jon for that</a>), but let me say something about why you would want this habit.  If you are declaring fields in your class and not local variables in a method, then it's possible for multiple threads to access those fields at the same time.  There are some obscure exceptions, but in general, if a field is final, then every thread that uses your class will see the same value for the variable.  Conversely, if a field is not final and multiple threads are using your class, you will need to worry about explicit synchronization  using `synchronized` blocks and/or classes from `java.util.concurrent`.  Synchronization is possible, but programming is hard enough already. ;-)  So, if you just declare <em>everything</em> `final` out of habit, then many of your fields will be final and you'll spend as little time as possible worrying about synchronization and concurrency-related bugs.  

For more on this habit, check out the "Minimize Mutability" tip in Joshua Bloch's <a href="https://www.oracle.com/technetwork/java/effectivejava-136174.html" rel="nofollow noreferrer" title="Effective Java">Effective Java</a>.  

<strong>Edit:</strong> @Peter Taylor has pointed out that the example above would also not compile if the `final` keyword is removed, which is completely correct.  When I advised in favor of keeping all local variables final, it's because I wanted to make examples like the following one impossible:  

```
int result = 0;

// OK, time to cover all the cases!
if (/* something */) {
  if (/* something else */) {
    result = 1;
  }
  else if (/* some other thing */) {
    result = 2;
  }
  // Whoops, missed an "else" here. Too bad.
}
else {
  result = 3;
}
System.out.println(result);  // Works fine!
```

Using a new variable instead of reusing an old one is how I can tell the compiler that trying to cover the complete universe of possibilities, and using `final` variables forces me to use a new variable instead of recycling an old one.  

Another valid complaint about this example is that you should avoid complex nested conditional logic in the first place.  That's true, of course, precisely because it's hard to make sure you covered all the cases in the way that you intended.  However, sometimes complex logic can't be avoided.  When my logic is complex, I want my variables to be as simple to reason about as possible, which I can achieve by making sure my variables' values never change after they are initialized.  

#### Answer 3 (score 7)
We can't know the answer for sure (unless we ask the original developers), but my guesses are:  

<ol>
<li>The programmers of these methods may have felt that adding "final" better expresses the purpose of those variables.</li>
<li>The programmers may be using a tool that automatically add "final" where it can.</li>
<li>It could be an optimisation trick: I don't have the knowledge / tools to verify this myself, but would be interested to know either way.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: What's the difference between simulation and emulation (score [146794](https://stackoverflow.com/q/134746) in 2015)

#### Question
I frequently see  <em>Simulation</em> and <em>Emulation</em> in computer science. These two terms seem synonymous. Is there any difference between <em>Simulation</em> and <em>Emulation</em>?  

#### Answer accepted (score 108)
Yes, the concepts are different.  

<hr>

<h5>Simulation</h2>

A `simulation` is a system that behaves <em>similar to</em> something else, but is implemented in an entirely different way. It provides the basic behaviour of a system, but may not necessarily adhere to all of the rules of the system being simulated.  It is there to give you an idea about how something works.  

<strong>Example</strong>  

Think of a flight simulator as an example. It looks and feels like you are flying an airplane, but you are completely disconnected from the reality of flying the plane, and you can bend or break those rules as you see fit. For example, fly an Airbus A380 upside down between London and Sydney without breaking it.  

<hr>

<h5>Emulation</h2>

An `emulation` is a system that behaves <em>exactly like</em> something else, and adheres to all of the rules of the system being emulated. It is effectively a complete replication of another system, right down to being binary compatible with the emulated system's inputs and outputs, but operating in a different environment to the environment of the original emulated system. The rules are fixed, and cannot be changed, or the system fails.  

<strong>Example</strong>  

The <a href="http://www.google.com.au/url?sa=t&amp;rct=j&amp;q=mame&amp;source=web&amp;cd=1&amp;ved=0CDoQFjAA&amp;url=http://mamedev.org/&amp;ei=jvk4T_LhHaORiQem8sn8AQ&amp;usg=AFQjCNFF4sVrNdrEE65RJYrHxqnKZgyZlA">M.A.M.E.</a> system is built around this very premise.  All those old arcade systems that have been long forgotten, that were implemented almost entirely in hardware, or in the firmware of their hardware systems can be emulated right down to the original bugs and crashes that would occur when you reached the highest possible score.  

#### Answer 2 (score 16)
A <strong>simulation</strong> is a model constructed of something else which reproduces some of that thing's features and leaves others out - obviously you want to preserve the features relevant to your query, and leave out the irrelevant ones.   

For instance, a simulation of early-morning commuter traffic leaves out the commuter's names, and maybe even their identities (using a counter variable rather than an actual set of `Commuter` objects), but it cannot disregard their rate of arrival.  

<hr>

<strong>Emulation</strong> is the running of a software X created for platform A on platform B, without changing the software itself. This requires building a model of A that runs on B, and obviously it has to model everything about A that involves code execution. (In theory you could omit support for opcodes that you know this particular software won't ever use, but that is rare - doing an emulator is hard work, and it's much more worthwhile to do a thorough job and have something reusable than a kludge that works only for S.)  

#### Answer 3 (score 7)
Both means something doing the job of something else.   

The difference is that "Simulation" happens at a <em>conscious</em> level (with respect to the user) and is finalized typically to anticipate the result of a reality without touching the reality itself.  

"Emulation" happens at an <em>unconscious</em> level, and has the purpose to replace an underlying component with another different one that -in respect to the user- works as the old one.  

In other words, <em>simulation</em> happen in a "parallel world", while <em>emulation</em> happens in a "replaced world".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Why store a function inside a python dictionary? (score [145943](https://stackoverflow.com/q/182093) in 2016)

#### Question
<p>I'm a python beginner, and I just learned a technique involving dictionaries and functions. The syntax is easy and it seems like a trivial thing, but my python senses are tingling. Something tells me this is a deep and very pythonic concept and I'm not quite grasping its importance. <strong>Can someone put a name to this technique and explain how/why it's useful?</strong>
<hr />
The technique is when you have a python dictionary and a function that you intend to use on it.  You insert an extra element into the dict, whose value is the name of the function. When you're ready to call the function you issue the call <em>indirectly</em> by referring to the dict element, not the function by name.</p>

The example I'm working from is from Learn Python the Hard Way, 2nd Ed. (This is the version available when you sign up through <a href="http://www.udemy.com/learn-python-the-hard-way/" rel="noreferrer">Udemy.com</a>; sadly the <a href="http://learnpythonthehardway.org/book/" rel="noreferrer">live free HTML version</a> is currently Ed 3, and no longer includes this example).   

To paraphrase:  

```
# make a dictionary of US states and major cities
cities = {'San Diego':'CA', 'New York':'NY', 'Detroit':'MI'}

# define a function to use on such a dictionary
def find_city (map, city):
    # does something, returns some value
    if city in map:
        return map[city]
    else:
        return "Not found"

# then add a final dict element that refers to the function
cities['_found'] = find_city
```

Then the following expressions are equivalent. You can call the function directly, or by referencing the dict element whose value is the function.  

```
>>> find_city (cities, 'New York')
NY

>>> cities['_found'](cities, 'New York')
NY
```

Can someone explain what language feature this is, and maybe where it comes to play in "real" programming? This toy exercise was enough to teach me the syntax, but didn't take me all the way there.  

#### Answer accepted (score 83)
Using a dict let's you translate the key into a callable. The key doesn't need to be hardcoded though, as in your example.  

Usually, this is a form of caller dispatch, where you use the value of a variable to connect to a function. Say a network process sends you command codes, a dispatch mapping lets you translate the command codes easily into executable code:  

```
def do_ping(self, arg):
    return 'Pong, {0}!'.format(arg)

def do_ls(self, arg):
    return '\n'.join(os.listdir(arg))

dispatch = {
    'ping': do_ping,
    'ls': do_ls,
}

def process_network_command(command, arg):
    send(dispatch[command](arg))
```

Note that what function we call now depends entirely on what the value is of `command`. The key doesn't have to match either; it doesn't even have to be a string, you could use anything that can be used as a key, and fits your specific application.  

Using a dispatch method is safer than other techniques, such as `eval()`, as it limits the commands allowable to what you defined beforehand. No attacker is going to sneak a <a href="http://xkcd.com/327/">`ls)"; DROP TABLE Students; --`</a> injection past a dispatch table, for example.  

#### Answer 2 (score 28)
@Martijn Pieters did a good job explaining the technique, but I wanted to clarify something from your question.  

The important thing to know is that you are <strong>NOT</strong> storing "the name of the function" in the dictionary. You are storing a reference to the function itself. You can see this using a `print` on the function.  

```
>>> def f():
...   print 1
... 
>>> print f
<function f at 0xb721c1b4>
```

`f` is just a variable that references the function you defined. Using a dictionary allows you to group like things, but it isn't any different from assigning a function to a different variable.  

```
>>> a = f
>>> a
<function f at 0xb721c3ac>
>>> a()
1
```

Similarly, you can pass a function as an argument.  

```
>>> def c(func):
...   func()
... 
>>> c(f)
1
```

#### Answer 3 (score 7)
Note that Python class is really just a syntax sugar for dictionary. When you do:  

```
class Foo(object):
    def find_city(self, city):
        ...
```

when you call   

```
f = Foo()
f.find_city('bar')
```

is really just the same as:  

```
getattr(f, 'find_city')('bar')
```

which, after name resolution, is just the same as:  

```
f.__class__.__dict__['find_city'](f, 'bar')
```

One useful technique is for mapping user input to callbacks. For example:  

```
def cb1(...): 
    ...
funcs = {
    'cb1': cb1,
    ...
}
while True:
    input = raw_input()
    funcs[input]()
```

This can alternatively be written in class:  

```
class Funcs(object):
    def cb1(self, a): 
        ...
funcs = Funcs()
while True:
    input = raw_input()
    getattr(funcs, input)()
```

whichever callback syntax is better depends on the particular application and programmer's taste. The former is more functional style, the latter is more object oriented. The former might feel more natural if you need to modify the entries in the function dictionary dynamically (perhaps based on user input); the latter might feel more natural if you have a set of different presets mapping that can be chosen dynamically.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: What are the key differences between software engineers and programmers? (score [145637](https://stackoverflow.com/q/4951) in 2016)

#### Question
What are the key differences between software engineers and programmers?  

#### Answer accepted (score 79)
When hiring, we look for a distinction between someone who is going to be able to help us architect our system, define processes, create technical specifications, implement advanced refactoring, etc. and someone who is going to help us complete programming tasks off a checklist.  I believe you could call the former a <strong>Software Engineer</strong> and the latter a <strong>Programmer</strong>.  

#### Answer 2 (score 131)
It's up to the company really, as I don't think there's a legal framework to enforce a denomination or another, or at least not that I am aware of and this might vary from country to country (for instance, the use of the term "engineer" is actually fairly regulated in France, but there are variants that are allowed for the "abusive" cases).  

That being said the general trend goes like this:  

<ul>
<li><p>A <strong>programmer</strong> position is usually the one of <em>a professional hired to to produce the code of a computer program</em>. It will imply that you <em>know how to write code</em>, can <em>understand an algorithm</em> and <em>follow specifications</em>. However, it usually stops there in terms of responsibility.</p></li>
<li><p>A <strong>developer</strong> position is usually considered <em>a super-type of the programmer position</em>. It encompasses the same responsibilities, <strong>plus</strong> the <em>ability to design and architect a software component</em>, and to <em>write the technical documentation</em> for it (including specifications). You are <em>able to  - at least technically - lead others</em> (so, programmers), but not necessarily a team (there comes the fuzz...)</p></li>
<li><p>An <strong>engineer</strong> position would usually imply that you are a developer who <em>has a specific type of degree</em>, some <em>knowledge of engineering</em>, and is <em>capable of designing a system</em> (as in: a combination of software components/modules that together form a whole software entity). Basically, you <em>see a wider picture</em>, and you are <em>capable of designing and explaining</em> it and <em>separating it into smaller modules</em>.</p></li>
</ul>

However, <strong>all this is arguable</strong>, and as I said, <em>there's no legal requirement that I am aware of in US/UK countries</em>. That being said, in France you can only call yourself an "engineer" if you come from an engineering school (recognized by the Commission des Titres d'Ingenieurs or something like that). You cannot say that you have an "Engineer Degree", but you can say that you have a "Degree in Engineering" if you have studied a discipline that falls under the portemanteau of engineering and technologies.  

It might be that some countries have a similar distinction, I just don't really know.  

Back to the software engineer title... Once, one of my teacher told our class - and rightly so - that <strong>there's no such thing, as of today, as so-called "software engineering"</strong>. Because engineering something (be it a building, a vehicle, a piece of hardware...) means you are capable of envisioning its design and all the phases of its production, and to predict with accuracy the resources you will need, and thus the cost of the production.  

This is true of most "true" engineering disciplines. There are fluctuations, of course (the prices of the materials will vary over time, for instance), but there are very finite theoretical models (for design and planning) and empirical models (for pretty much keeping any of the former within accessible constraints) that allow you to predict the termination date of a project and its resource usage.  

The major problem with software is that it is not there yet. We want to aim for software engineering, but we're not there yet, really. Because we have a very fluid and dynamic environment, very variable constraints for projects, and still a lack of maturity in retrospect in our processes. Sure we could say we get better at it (highly arguable with hard-data, though), but we've only been at it since the 60s (earlier projects were actually closer to hardware-only computers, thus closer to real engineering, ironically). Whereas we've been building motored vehicles for more than a century, vehicles in general for a few millennias, and building for even more millennias (and have been pretty damn good at it actually in some part of the world, making you feel like we're ridiculous kids playing with our new flashy software toys in comparison).  

We <em>fail to systematically predict deadlines accurately</em>, we <em>fail to systematically predict costs accurately</em>, we <em>fail to systematically identify and mitigate inherent and external risks efficiently and deterministically</em>. The best we can manage to do is produce good enough <strong>guesstimates</strong>, and accommodate for some buffer, while trying our best to optimize the processes to reduce cycles and overhead.  

But see, maybe that's what engineering is. And that's what, when someone talks about a "software engineer", they should think of and aim for.  

So that seems hardly interchangeable with the simple act of programming routines, or the more advanced act of developing applications.  

Still, everything is a matter of trends. Lately it's pretty common to have an horizontal dev team where everybody on the team is a Senior Software Developer (yes, capitals, because that makes us feel special, doesn't it?), without real distinction of age (fair enough, in my opinion) and not so much distinction of skills (uh-oh...) and responsibilities (now that can't be good, apart purely for PR buzz).  

It's also <strong>sometimes just a force of habit and specific to an industry's culture and jargon</strong>. More positions for embedded software production use titles for software engineers. Mostly because it would probably imply that you will always have to deal to a certain extent with the hardware as well in this field, so you obviously deal with other aspects of the production and of the whole "system" you produce. Not just the bits going nuts inside it. On the other hand of the spectrum, you don't really see the term engineer being used in financial software production positions. It's either because is a mimetic evolution of this industry from one of its predecessors (say, embedded engineering find its roots in automobile engineering, for instance), or because they just want to give more or less credit/weight to a position.  

And to be sure to loose everybody in the fog, <strong>you'll then find other titles mixing both</strong> (like "Software Development Engineer" or "Software Engineer in Test"!), and then other ones emphasizing even more crazy bridges with other domains (think of "Software Architect" and how "software architecture" might be a shameless theft of vocabulary). And keep them coming: Release Engineer, Change Development Manager, Build Engineer (that one goes ffaaarrrrrr out there as well). And sometimes just simply "engineer".  

Hope that helped, though it's not really an answer.  

Oh, and that means your new company is either trying to lure you in with a new title or that they don't really care about titles, or that you really are going to have a higher-level position. The only way of knowing is to read your job spec, talk to them and eventually give it a shot and judge for yourself. I'd hope it's the latter option and that you're happy with it (and potentially cash more in on it). ;)  

#### Answer 3 (score 81)
<strong>Software engineers</strong> are people who work at companies that call the people who write software for them "software engineers."  

<strong>Programmers</strong> are people who work at companies that call the people who write software for them "programmers."  

There are also <strong>developers</strong>, or <strong>software developers</strong>.  They are people who work at companies that call the people who write software for them "developers" or "software developers," respectively.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Best way to unit test methods that call other methods inside same class (score [144932](https://stackoverflow.com/q/188609) in )

#### Question
I was recently discussing with some friends which of the following 2 methods is best to stub return results or calls to methods inside same class from methods inside same class.  

This is a very simplified example. In reality the functions are much more complex.  

Example:  

```
public class MyClass
{
     public bool FunctionA()
     {
         return FunctionB() % 2 == 0;
     }

     protected int FunctionB()
     {
         return new Random().Next();
     }
}
```

So to test this we have 2 methods.  

<p>Method 1:
Use Functions and Actions to replace functionality of the methods.
Example:</p>

```
public class MyClass
{
     public Func<int> FunctionB { get; set; }

     public MyClass()
     {
         FunctionB = FunctionBImpl;
     }

     public bool FunctionA()
     {
         return FunctionB() % 2 == 0;
     }

     protected int FunctionBImpl()
     {
         return new Random().Next();
     }
}

[TestClass]
public class MyClassTests
{
    private MyClass _subject;

    [TestInitialize]
    public void Initialize()
    {
        _subject = new MyClass();
    }

    [TestMethod]
    public void FunctionA_WhenNumberIsOdd_ReturnsTrue()
    {
        _subject.FunctionB = () => 1;

        var result = _subject.FunctionA();

        Assert.IsFalse(result);
    }
}
```

<p>Method 2:
Make members virtual, derive class and in derived class use Functions and Actions to replace functionality
Example:</p>

```
public class MyClass
{     
     public bool FunctionA()
     {
         return FunctionB() % 2 == 0;
     }

     protected virtual int FunctionB()
     {
         return new Random().Next();
     }
}

public class TestableMyClass
{
     public Func<int> FunctionBFunc { get; set; }

     public MyClass()
     {
         FunctionBFunc = base.FunctionB;
     }

     protected override int FunctionB()
     {
         return FunctionBFunc();
     }
}

[TestClass]
public class MyClassTests
{
    private TestableMyClass _subject;

    [TestInitialize]
    public void Initialize()
    {
        _subject = new TestableMyClass();
    }

    [TestMethod]
    public void FunctionA_WhenNumberIsOdd_ReturnsTrue()
    {
        _subject.FunctionBFunc = () => 1;

        var result = _subject.FunctionA();

        Assert.IsFalse(result);
    }
}
```

I want to know wich is better and also WHY ?  

<p>Update:
NOTE: <strong>FunctionB can also be public</strong></p>

#### Answer accepted (score 32)
<strong>Edited following original poster update.</strong>  

Disclaimer : not a C# programmer (mostly Java or Ruby). My answer would be : I would not test it at all, and I do not think you should.  

The longer version is : private/protected methods are not parts of the API, they are basically implementation choices, that you can decide to review, update or throw away completely without any impact on the outside.   

I suppose you have a test on FunctionA(), which is the part of the class that is visible from the external world. It should be the only one that has a contract to implement (and that could be tested). Your private/protected method has no contract to fulfil and/or test.  

See a related discussion there : <a href="https://stackoverflow.com/questions/105007/should-i-test-private-methods-or-only-public-ones">https://stackoverflow.com/questions/105007/should-i-test-private-methods-or-only-public-ones</a>  

<strong>Following the comment</strong>, if FunctionB is public, I'll simply test both using unit test. You may think that the test of FunctionA is not totally "unit" (as it call FunctionB), but I would not be too worried by that : if FunctionB test works but not FunctionA test, it means clearly that the problem is not in the subdomain of FunctionB, which is good enough for me as a discriminator.   

If you really want to be able to totally separate the two tests, I would use some kind of mocking technique to mock FunctionB when testing FunctionA (typically, return a fixed known correct value). I lack the C# ecosystem knowledge to advice a specific mocking library, but you may look at <a href="https://stackoverflow.com/questions/37359/what-c-sharp-mocking-framework-to-use">this question</a>.  

#### Answer 2 (score 11)
I subscribe to the theory that if a function is important to test, or is important to replace, it is important enough to not be a private implementation detail of the class under test, but to be a public implementation detail of a <em>different</em> class.  

So if I am in a scenario where I have   

```
class A 
{
     public B C()
     {
         D();
     }

     private E D();
     {
         // i actually want to control what this produces when I test C()
         // or this is important enough to test on its own
         // and, typically, both of the above
     }
}
```

Then I am going to refactor.   

```
class A 
{
     ICollaborator collaborator;

     public A(ICollaborator collaborator)
     {
         this.collaborator = collaborator;
     }

     public B C()
     {
         collaborator.D();
     }
}
```

Now I have a scenario where D() is independently testable, and fully replaceable.   

As a means of organization, my collaborator <em>might</em> not live at the same namespace level. For example, if `A` is in FooCorp.BLL, then my collaborator might be another layer deep, as in FooCorp.BLL.Collaborators (or whatever name is appropriate). My collaborator might further only be visible inside the assembly via the `internal` access modifier, which I would then also expose to my unit testing project(s) via the `InternalsVisibleTo` assembly attribute. The takeaway is that you can still keep your API clean, as far as callers are concerned, while producing verifiable code.  

#### Answer 3 (score 0)
Adding on to what Martin points out,  

If your method is private/protected - do not test it. It is internal to the class and should not be accessed outside the class.  

In both the approaches that you mention, I have these concerns -  

Method 1 - This actually changes the class under test's behaviour in the test.  

Method 2 - This actually does not test the production code, instead tests another implementation.  

In the problem stated, I see that the only logic of A is to see if the output of FunctionB is even. Although illustrative, FunctionB gives Random value, which is tough to test.  

I expect a realistic scenario where we can setup MyClass such that we know what FunctionB would return. Then our expected result is known, we can call FunctionA and assert on the actual result.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Why use a database instead of just saving your data to disk? (score [143792](https://stackoverflow.com/q/190482) in 2013)

#### Question
Instead of a database I just serialize my data to JSON, saving and loading it to disk when necessary. All the data management is made on the program itself, which is faster AND easier than using SQL queries. For that reason I have never understood why databases are necessary at all.  

Why should one use a database instead of just saving the data to disk?  

#### Answer 2 (score 280)
<ol>
<li>You can query data in a database (ask it questions).</li>
<li>You can look up data from a database relatively rapidly.</li>
<li>You can relate data from two different tables together using JOINs.</li>
<li>You can create meaningful reports from data in a database.</li>
<li>Your data has a built-in structure to it.</li>
<li>Information of a given type is always stored only once.</li>
<li>Databases are <a href="http://en.wikipedia.org/wiki/ACID">ACID</a>.</li>
<li>Databases are fault-tolerant.</li>
<li>Databases can handle very large data sets.</li>
<li>Databases are concurrent; multiple users can use them at the same time without corrupting the data.</li>
<li>Databases scale well. </li>
</ol>

In short, you benefit from a wide range of well-known, proven technologies developed over many years by a wide variety of very smart people.  

If you're worried that a database is overkill, check out SQLite.  

#### Answer 3 (score 200)
Whilst I agree with everything Robert said, he didn't tell you when you should use a database as opposed to just saving the data to disk.  

So take this in addition to what Robert said about scalability, reliability, fault tolerance, etc.  

<h5>For when to use a RDBMS, here are some points to consider:</h3>

<ul>
<li>You have relational data, i.e. you have a customer who purchases your products and those products have a supplier and manufacturer</li>
<li>You have large amounts of data and you need to be able to locate relevant information quickly</li>
<li>You need to start worrying about the previous issues identified: scalability, reliability, ACID compliance</li>
<li>You need to use reporting or intelligence tools to work out business problems</li>
</ul>

<h5>As for when to use a NoSQL</h3>

<ul>
<li>You have lots of data that needs to be stored which is unstructured</li>
<li>Scalability and speed needs</li>
<li>You generally don't need to define your schema up front, so if you have changing requirements this might be a good point</li>
</ul>

<h5>Finally, when to use files</h3>

<ul>
<li>You have unstructured data in reasonable amounts that the file system can handle</li>
<li>You don't care about structure, relationships</li>
<li>You don't care about scalability or reliability (although these can be done, depending on the file system)</li>
<li>You don't want or can't deal with the overhead a database will add</li>
<li>You are dealing with structured binary data that belongs in the file system, for example: images, PDFs, documents, etc.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: What should and what shouldn't be in a header file? (score [142604](https://stackoverflow.com/q/167723) in 2012)

#### Question
What things should absolutely never be included in a header file?  

If for example I'm working with a documented industry standard format that has a lot of constants, is it a good practice to define them in a header file (if I'm writing a parser for that format)?  

<p>What functions should go into the header file? 
<br/>What functions shouldn't?</p>

#### Answer accepted (score 57)
<strong>What to put in headers:</strong>  

<ul>
<li>The minimal set of `#include` directives that are needed to make the header compilable when the header is included in some source file.</li>
<li>Preprocessor symbol definitions of things that need to be shared and that can only accomplished via the preprocessor. Even in C, preprocessor symbols are best kept to a minimum. </li>
<li>Forward declarations of structures that are needed to make the structure definitions, function prototypes, and global variable declarations in the body of the header compilable.</li>
<li>Definitions of data structures and enumerations that are shared amongst multiple source files.</li>
<li>Declarations for functions and variables whose definitions will be visible to the linker.</li>
<li>Inline function definitions, but take care here.</li>
</ul>

<strong>What doesn't belong in a header:</strong>  

<ul>
<li>Gratuitous `#include` directives. Those gratuitous includes cause recompilation of things that don't need to be recompiled, and can at times make it so a system can't compile. Don't `#include` a file in a header if the header itself doesn't need that other header file.</li>
<li>Preprocessor symbols whose intent could be accomplished by some mechanism, any mechanism, other than the preprocessor.</li>
<li>Lots and lots of structure definitions. Split those up into separate headers.</li>
<li>Inline definitions of functions that require an additional `#include`, that are subject to change, or that are too big. Those inline functions should have little if any fan out, and if they do have fan out, it should be localized to stuff defined in the header.</li>
</ul>

<strong>What constitutes the minimal set of `#include` statements?</strong>  

This turns out to be a nontrivial question. A TL;DR definition: A header file must include the header files that directly define each of the types directly used in or that directly declare each of the functions used in the header file in question, but must not include anything else. A pointer or C++ reference type does not qualify as direct use; forward references are preferred.  

There is a place for a gratuitous `#include` directive, and this is in an automated test. For every header file in a software package, I automatically generate and then compile the following:  

```
#include "path/to/random/header_under_test"
int main () { return 0; }
```

The compilation should be clean (i.e., free of any warnings or errors). Warnings or errors regarding incomplete types or unknown types mean that the header file under test has some missing `#include` directives and/or missing forward declarations. Note well: Just because the test passes does not mean that the set of `#include` directives is sufficient, let alone minimal.  

#### Answer 2 (score 15)
In addition to what has already been said.  

H files should always contain:  

<ul>
<li><strong>Source code documentation!!!</strong> At a minimum, what is the purpose of the various parameters and return values of the functions.</li>
<li>Header guards, #ifndef MYHEADER_H #define MYHEADER_H ... #endif</li>
</ul>

H files should never contain:  

<ul>
<li>Any form of data allocation.</li>
<li>Function definitions. Inline functions may be a rare exception in some cases.</li>
<li>Anything labelled `static`.</li>
<li>Typedefs, #defines or constants that have no relevance to the rest of the application.</li>
</ul>

(I would also say that there is never any reason to use non-constant global/extern variables, anywhere, but that's a discussion for another post.)  

#### Answer 3 (score 4)
I would probably never say never, but statements that generate data and code as they are parsed should not be in a .h file.    

Macros, inline functions and templates may look like data or code, but they do not generate code as they are parsed, but instead when they are used.  These items often need to be used in more than one .c or .cpp, so they belong in the .h.  

In my view, a header file should have the minimum practical interface to a corresponding .c or .cpp.  The interface can include #defines, class, typedef, struct definitions, function prototypes, and less preferred, extern definitions for global variables.  However, if a declaration is used in only one source file, it probably should be excluded from the .h and be contained in the source file instead.    

Some may disagree, but my personal criteria for .h files is that they #include all other .h files that they need to be able to compile.  In some cases, this can be a lot of files, so we have some effective methods to reduce external dependencies like forward declarations to classes that let us use pointers to objects of a class without including what could be a big tree of include files.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Is Python Interpreted or Compiled? (score [142385](https://stackoverflow.com/q/24558) in 2018)

#### Question
This is just a wondering I had while reading about interpreted and compiled languages.     

<p><strong>Ruby</strong> is no doubt an interpreted language since the source code is processed by an interpreter at the point of execution.<br>
On the contrary <strong>C</strong> is a compiled language, as one have to compile the source code first according to the machine and then execute. This results is much faster execution.</p>

Now coming to <strong>Python</strong>:    

<ul>
<li>A python code (<strong>somefile.py</strong>) when imported creates a file (<strong>somefile.pyc</strong>) in the same directory. Let us say the import is done in a python shell or django module. After the import I change the code a bit and execute the imported functions again to find that it is still running the old code. This suggests that *.pyc files are compiled python files similar to executable created after compilation of a C file, though I can't execute *.pyc file directly.</li>
<li>When the python file (somefile.py) is executed directly ( ./somefile.py or python somefile.py ) no .pyc file is created and the code is executed as is indicating interpreted behavior. </li>
</ul>

These suggest that a python code is compiled every time it is imported in a new process to create a .pyc while it is interpreted when directly executed.   

<p>So which type of language should I consider it as? Interpreted or Compiled?
And how does its efficiency compare to interpreted and compiled languages?</p>

According to wiki's <a href="http://en.wikipedia.org/wiki/Interpreted_language#Languages_usually_compiled_to_a_virtual_machine_code" rel="noreferrer">Interpreted Languages</a> page, it is listed as a language compiled to Virtual Machine Code, what is meant by that?  

#### Answer accepted (score 80)
It's worth noting that <em>languages</em> are not interpreted or compiled, but rather language <em>implementations</em> either interpret or compile code. You noted that Ruby is an "interpreted language", but you can compile Ruby à la <a href="http://www.macruby.org/">MacRuby</a>, so it's not <em>always</em> an interpreted language.  

Pretty much every Python implementation consists of an interpreter (rather than a compiler). The `.pyc` files you see are byte code for the Python virtual machine (similar to Java's `.class` files). They are not the same as the machine code generated by a C compiler for a native machine architecture. Some Python implementations, however, do consist of a <em>just-in-time</em> compiler that will compile Python byte code into native machine code.  

(I say "pretty much every" because I don't know of any native machine compilers for Python, but I don't want to claim that none exist anywhere.)  

#### Answer 2 (score 35)
Python will fall under byte code interpreted. `.py` source code is first compiled to byte code as `.pyc`. This byte code can be interpreted (official CPython), or JIT compiled (PyPy). Python source code (`.py`) can be compiled to different byte code also like IronPython (.Net) or Jython (JVM). There are multiple implementations of Python language. The official one is a byte code interpreted one. There are byte code JIT compiled implementations too.  

For speed comparisons of various implementations of languages you can try <a href="http://shootout.alioth.debian.org/" rel="nofollow noreferrer">here</a>.  

#### Answer 3 (score 11)
Compiled vs. interpreted can be helpful in some contexts, but when applied in a technical sense, it is a false dichotomy.  

A compiler (in the broadest sense) is a <em>translator</em>. It translates program A to program B and for future execution it using a machine M.  

An interpreter (in the broadest sense) is an <em>executor</em>. It is a machine M that executes program A. Though we typically exclude from this definitions physical machines (or non-physical machines that act just like physical ones). But from theoretic perspective, that distinction is somewhat arbitrary.  

<hr>

For example, take <a href="https://docs.python.org/2/library/re.html#re.compile" rel="noreferrer">`re.compile`</a>. It "compiles" a regex to an intermediate form, and that intermediate form is interpreted/evaluated/executed.  

<hr>

In the end, it depends on what level abstraction you are talking about, and what you care about. People say "compiled" or "interpreted" as broad descriptions of the most interesting parts of the process, but really most every program is compiled (translated) and interpreted (executed) in one way or another.  

CPython (the most popular implementation of the Python language) is mostly interesting for executing code. So CPython would typically be described as interpreted. Though this is a loose label.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: How is IntelliJ better than Eclipse? (score [142159](https://stackoverflow.com/q/21987) in 2017)

#### Question
I know there have been questions like <a href="https://softwareengineering.stackexchange.com/questions/219/what-is-your-favorite-editor-ide">What is your favorite editor/IDE?</a>, but none of them have answered this question: Why spend the money  on <strong>IntelliJ</strong> when <strong>Eclipse</strong> is free?  

I'm personally a big IntelliJ fan, but I haven't really tried Eclipse. I've used IntelliJ for projects that were Java, JSP, HTML/CSS, Javascript, PHP, and Actionscript, and the latest version, 9, <a href="https://softwareengineering.stackexchange.com/questions/20950/what-justifies-the-use-of-an-standard-editor-versus-a-ide/21092#21092">has been excellent</a> for all of them.  

Many coworkers in the past have told me that they believe Eclipse to be "pretty much the same" as IntelliJ, but, to counter that point, I've occasionally sat behind a developer using Eclipse who's seemed  comparably inefficient (to accomplish roughly the same task), and I haven't experienced this with IntelliJ. They may be on par <strong>feature-by-feature</strong> but features can be ruined by a poor user experience, and I wonder if it's possible that IntelliJ is easier to pick up and discover time-saving features.  

For users who are already familiar with Eclipse, on top of the real cost of IntelliJ, there is also the cost of time spent learning the new app. Eclipse gets a lot of users who simply don't want to spend $250 on an IDE.  

If IntelliJ really could help my team be more productive, how could I sell it to them? For those users who've tried both, I'd be very interested in specific pros or cons either way.  

#### Answer accepted (score 63)
I work with Intellij (9.0.4 Ultimate) and Eclipse (Helios) every day and Intellij beats Eclipse every time.   

How? Because <strong>Intellij indexes the world</strong> and everything just works intuitively. I can navigate around my code base much, much faster in Intellij. F3 (type definition) works on <em>everything</em> - Java, JavaScript, XML, XSD, Android, Spring contexts. Refactoring works everywhere and is totally reliable (I've had issues with Eclipse messing up my source in strange ways). CTRL+G (where used) works <em>everywhere</em>. CTRL+T (implementations) keeps track of the most common instances that I use and shows them first.   

Code completion and renaming suggestions are so clever that it's only when you go back to Eclipse that you realise how much it was doing for you. For example, consider reading a resource from the classpath by typing `getResourceAsStream("/` at this point Intellij will be showing you a list of possible files that are currently available on the classpath and you can quickly drill down to the one you want. Eclipse - nope.  

The (out of the box) Spring plugin for Intellij is vastly superior to SpringIDE mainly due to their code inspections. If I've missed out classes or spelled something wrong then I'm getting a red block in the corner and red ink just where the problem lies. Eclipse - a bit, sort of.  

Overall, Intellij builds up a lot of knowledge about your application and then uses that knowledge to help you write better code, faster.  

Don't get me wrong, I love Eclipse to bits. For the price, there is no substitute and I recommend it to my clients in the absence of Intellij. But once I'd trialled Intellij, it paid for itself within a week so I bought it, and each of the major upgrades since. I've never looked back.  

#### Answer 2 (score 16)
I hear the difference with IntelliJ is that they are <strong>much more likely to fix and close bugs</strong> that you submit. That could make a big difference if there is some Eclipse bug that is blocking you.  

On the other hand, you cannot look at IDEs in isolation; <strong>you need to look at the ecosystem</strong>. Here, I think Eclipse has an advantage (similar to Firefox's advantage over Chrome*): There are many more plug-ins available, and developers are much more likely to write an Eclipse plug-in than otherwise.  

[Tangent: *For Firefox I'm thinking of Zotero and HTTPS-Everywhere. I use both Chrome and Firefox, but some things Chrome just can't handle. Also, when making handouts, I really do need print preview.]  

#### Answer 3 (score 13)
<p><em><strong>Disclaimer</em></strong><br>
<em>This is limited to Android development only (In Java obviously).</em></p>

I am coming to this with some limited knowledge of Eclipse and IntelliJ both; however, I have recently had to decide on a development environment for Android. It would seem that the first clear choice would be to use Eclipse since Google supports it with their ADT plugin. Unfortunately, I found it terribly clunky to get around since I am used to Visual Studio (2010, more recently 2012). I have always used ReSharper with Visual Studio so I decided to give IntelliJ a try. After about 10 minutes I realized that I had made the right decision.  

IntelliJ, as some have stated, indexes everything. The intellisense was a joy to work with and the intelligence surrounding suggestions was excellent. The debugging experience I found to be a pleasure and quite honestly, I really couldn't live without the code analysis. I know a lot of purists would have a problem with that kind of thing but I don't care. I have to push out projects very quickly for lots of people so sometimes it's just nice to run the code anaylsis and see what the IDE suggests. Whether or not you take those suggestions is another story but I didn't find anything like this in Eclipse.  

Some also say that there is no Android designer in the current version of IntelliJ. This is certainly the case but I wouldn't ever use it anyway. I am debugging on a device most of the time so it doesn't matter. I get to see the interface and play with it everytime I run the program. Anyway, from a traditionally "non-Java" guy I have to say that Java is particularly nice as compared to Eclipse.   

</section>

