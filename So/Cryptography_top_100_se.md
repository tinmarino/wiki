---
title: Cryptography <- StackExchange top 100
category: cryptography
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How secure is AES-256? (score [250619](https://stackoverflow.com/q/2251) in 2017)

#### Question
The cipher AES-256 is used among other places in <a href="https://en.wikipedia.org/wiki/Transport_Layer_Security" rel="noreferrer">SSL/TLS</a> across the Internet. It's considered among the top ciphers.  

In theory it's not crackable since the combinations of keys are massive.  

Although NSA has categorized this in <a href="https://en.wikipedia.org/wiki/NSA_Suite_B_Cryptography" rel="noreferrer">Suite B</a>, they have also recommended using higher than 128-bit keys for encryption.  

So how secure is this cipher really? Should you assume the worlds top cracker-institutions are near or have cracked it already?  

#### Answer 2 (score 57)
I wouldn't assume that the NSA has cracked AES ciphers. I would assume that most crypto systems that use AES have implementation flaws that the NSA exploits when they feel it is worth it.   

In any case, when the <em>only</em> possible way a state can know something is by breaking a cipher, it's difficult for them to use that information; doing so would reveal that the cipher is broken. So in practice, a broken cipher is more likely to be used as a shortcut to find something that could be discovered (albeit with more difficulty) by other methods.  

<hr>

You might be interested in <a href="http://www.wired.com/threatlevel/2012/03/ff_nsadatacenter/5/">this recent story</a> and <a href="http://www.schneier.com/blog/archives/2012/03/can_the_nsa_bre.html">commentary</a> about NSA's crypt analytical capabilities.  

#### Answer 3 (score 37)
An interesting thing about some modern standardized ciphers, like AES, is that the government is "eating its own dogfood" by using them internally. (AES 192 and 256 <a href="http://en.wikipedia.org/wiki/Advanced_Encryption_Standard#Security">are approved for top-secret data</a>.) Back in the day (up through the 90s), U.S. government internal encryption standards was not closely aligned with public sector cryptography, and we largely had to speculate as to whether public crypto could hold up to the government standards; the NSA had a history of knowing more crypto than they let on. But now that they are willing to stake their own security on them, that seems like a decent endorsement of those algorithms.  

The U.S. government has conflicting goals: they want to be able to break crypto, but at the same time, in the interest of protecting the citizen in the digital age, they want us to be protected against the crypto attacks of others. So much of our modern economy relies on crypto that we want a high security margin on it. Since the 90s, crypto knowledge in the public and foreign intelligence domains has sky rocketed, and a vulnerability that the NSA can exploit is possibly a vulnerability that someone else can exploit. So at the drafting of AES, we doubt that they were focused on choosing a candidate that could be broken and kind of suspect they wanted a candidate that could not be.  

Since you only break crypto when you don't have the key, to compromise those two goals they could just allow us mathematically secure crypto, then focus on getting the keys instead. If they can recover keys, they don't care how strong our crypto is. Attacking the endpoints that generate the keys is not always as hard as it seems (consider how many user and corporate machines get infected with malware, and think about what sort of key-related backdoors could be planted in popular software), and a simple subpoena might get keys in some situations. As more user data moves toward the cloud, backdoors in public services (voluntarily provided or not) are going to make the job of key recovery even easier.  

Summary of these two points:  

<ul>
<li><p>The federal government is allowed to use AES for top-secret information.</p></li>
<li><p>We don't know that they would actually want AES to be mathematically breakable, so at the AES competition 11 years ago it is possible they would have avoided any algorithm they thought they could break in the near future.</p></li>
</ul>

None of that is proof, but we tend to assume that the NSA can't break AES.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: Are there two known strings which have the same MD5 hash value? (score [122492](https://stackoverflow.com/q/1434) in 2013)

#### Question
Is there an example of two known strings which have the same MD5 hash value (representing a so-called "MD5 collision")?  

#### Answer 2 (score 64)
Yes you can, see at the <a href="http://www.mscs.dal.ca/~selinger/md5collision/" rel="noreferrer">MD5 Collision Demo</a>, the two blocks:  

<pre>
d131dd02c5e6eec4693d9a0698aff95c 2fcab5<b>8</b>712467eab4004583eb8fb7f89 
55ad340609f4b30283e4888325<b>7</b>1415a 085125e8f7cdc99fd91dbd<b>f</b>280373c5b 
d8823e3156348f5bae6dacd436c919c6 dd53e2<b>b</b>487da03fd02396306d248cda0 
e99f33420f577ee8ce54b67080<b>a</b>80d1e c69821bcb6a8839396f965<b>2</b>b6ff72a70
</pre>

and  

<pre>
d131dd02c5e6eec4693d9a0698aff95c 2fcab5<b>0</b>712467eab4004583eb8fb7f89 
55ad340609f4b30283e4888325<b>f</b>1415a 085125e8f7cdc99fd91dbd<b>7</b>280373c5b 
d8823e3156348f5bae6dacd436c919c6 dd53e2<b>3</b>487da03fd02396306d248cda0 
e99f33420f577ee8ce54b67080<b>2</b>80d1e c69821bcb6a8839396f965<b>a</b>b6ff72a70
</pre>

produce an MD5 collision.  

Each of these blocks has MD5 hash `79054025255fb1a26e4bc422aef54eb4`.  

#### Answer 3 (score 33)
A <a href="http://marc-stevens.nl/research/md5-1block-collision/">new result</a> shows how to generate <em>single block</em> MD5 collisions, including an example collision:  

<a href="http://marc-stevens.nl/research/md5-1block-collision/message1.bin">Message 1</a>  

<a href="http://marc-stevens.nl/research/md5-1block-collision/message2.bin">Message 2</a>  

```cryptography
> md5sum message1.bin message2.bin
> 008ee33a9d58b51cfeb425b0959121c9 message1.bin
> 008ee33a9d58b51cfeb425b0959121c9 message2.bin
```

There is an earlier example of a single block collision but not technique for generating it was published.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: What is the difference between CBC and GCM mode? (score [121805](https://stackoverflow.com/q/2310) in 2017)

#### Question
I am trying to learn more about GCM mode and how it differs between CBC.  I already know that GCM provides a MAC which is used for message authentication.  From what I have read, and from the code snippets I've seen, GCM does an exclusive or much like CBC, but I'm not sure what the exclusive-or is against.  In CBC mode, the exclusive-or is plaintext against the previous ciphertext block, except for the first block which uses a random IV.  Does GCM do the same, or does it do the exclusive-or against something else?  If so, can someone please briefly explain how GCM uses the IV and how the exclusive-or is done.  

#### Answer accepted (score 85)
GCM and CBC modes internally work quite differently; they both involve a block cipher and an exclusive-or, but they use them in different ways.  

In CBC mode, you encrypt a block of data by taking the current plaintext block and exclusive-oring that wth the previous ciphertext block (or IV), and then sending the result of that through the block cipher; the output of the block cipher is the ciphertext block.  

GCM mode provides both privacy (encryption) and integrity.  To provide encryption, GCM maintains a counter; for each block of data, it sends the current value of the counter through the block cipher.  Then, it takes the output of the block cipher, and exclusive or's that with the plaintext to form the ciphertext.  

Note two key differences:  

<ul>
<li><p>What's being exclusive-or'ed; in CBC mode, the plaintext is exclusive-or'ed with data that the attacker knows (the IV or a previous ciphertext block); hence, that in itself does not provide any inherent security (instead, we do it to minimize the chance that we send the same block twice through the block cipher).  In GCM mode, the plaintext is exclusive-or'ed with output from the block cipher; it is inherent in the security model that the attacker cannot guess that output (unless he already knows the plaintext and the ciphertext).</p></li>
<li><p>What's being sent through the block cipher; in CBC mode, the plaintext is sent through the block cipher (after it's been 'randomized' with an exclusive-or); in GCM mode, what's being sent through the block cipher doesn't actually depend on the data being encrypted, but instead only on internal state.</p></li>
</ul>

As for how GCM uses an IV (I personally consider 'nonce' a better term for what GCM uses, because that emphesizes the idea that with GCM, you cannot use the same nonce for the same key twice), well, it is used to initialize the counter.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: Should we MAC-then-encrypt or encrypt-then-MAC? (score [112105](https://stackoverflow.com/q/202) in 2016)

#### Question
Most of the time, when some data must be encrypted, it must also be protected with a <a href="http://en.wikipedia.org/wiki/Message_authentication_code">MAC</a>, because encryption protects only against passive attackers. There are some nifty encryption modes which include a MAC (<a href="http://en.wikipedia.org/wiki/EAX_mode">EAX</a>, <a href="http://en.wikipedia.org/wiki/Galois/Counter_Mode">GCM</a>...) but let's assume that we are doing old-style crypto, so we have a standalone encryption method (e.g. AES with CBC chaining and PKCS#5 padding) and a standalone MAC (e.g. <a href="http://en.wikipedia.org/wiki/HMAC">HMAC</a> with SHA-256). How should we assemble the encryption and the MAC?  

<ul>
<li>MAC-then-Encrypt: Compute the MAC on the cleartext, append it to the data, and then encrypt the whole? (That's what <a href="http://tools.ietf.org/html/rfc5246">TLS</a> does)</li>
<li>Encrypt-and-MAC: Compute the MAC on the cleartext, encrypt the cleartext, and then append the MAC at the end of the ciphertext? (That's what SSH does)</li>
<li>Encrypt-then-MAC: Encrypt the cleartext, then compute the MAC on the ciphertext, and append it to the ciphertext? (In that case, we do not forget to include the initialization vector (IV) and the encryption method identifier into the MACed data.)</li>
</ul>

The first two options are often called "MAC-then-encrypt" while the third is "encrypt-then-MAC". What are the arguments for or against either?  

#### Answer accepted (score 281)
I'm assuming you actually know all of this better than I do... anyway, <a href="http://cseweb.ucsd.edu/~mihir/papers/oem.html" rel="noreferrer">this paper</a> neatly summarises all these approaches and what level of security they do or don't provide. I shall paraphrase it in English, rather than Mathematical notation, as I understand it, here:  

<ul>
<li>Encrypt-then-MAC:

<ul>
<li>Provides integrity of Ciphertext. Assuming the MAC shared secret has not been compromised, we ought to be able to deduce whether a given ciphertext is indeed authentic or has been forged; for example, in public key cryptography anyone can send you messages. EtM ensures you only read valid messages.</li>
<li>Plaintext integrity.</li>
<li>If the cipher scheme is <a href="https://en.wikipedia.org/wiki/Malleability_(cryptography)" rel="noreferrer">malleable</a> we need not be so concerned, since the MAC will filter out this invalid ciphertext.</li>
<li>The MAC does not provide any information on the plaintext since, assuming the output of the cipher appears random, so does the MAC. In other words, we haven't carried any structure from the plaintext into the MAC.</li>
</ul></li>
<li>MAC-then-Encrypt:

<ul>
<li>Does not provide any integrity on the ciphertext, since we have no way of knowing until we decrypt the message whether it was indeed authentic or spoofed.</li>
<li>Plaintext integrity.</li>
<li>If the cipher scheme is <a href="https://en.wikipedia.org/wiki/Malleability_(cryptography)" rel="noreferrer">malleable</a> it may be possible to alter the message to appear valid and have a valid MAC. This is a theoretical point, of course, since practically speaking the MAC secret should provide protection.</li>
<li>Here, the MAC cannot provide any information on the plaintext either, since it is encrypted.</li>
</ul></li>
<li>Encrypt-and-MAC:

<ul>
<li>No integrity on the ciphertext again, since the MAC is taken against the plaintext. This opens the door to some chosen-ciphertext attacks on the cipher, as shown in section 4 of <a href="http://www.cs.washington.edu/homes/yoshi/papers/SSH/index.html" rel="noreferrer">Breaking and provably repairing the SSH authenticated encryption scheme: A case study of the Encode-then-Encrypt-and-MAC paradigm</a>.</li>
<li>Integrity of the plaintext can be verified</li>
<li>If the cipher scheme is malleable, the contents of the ciphertext could well be altered, but on decryption we ought to find the plaintext is invalid. Of course, any implementation error that can be exploited in the decryption process has been by that point.</li>
<li>May reveal information about the plaintext in the MAC. Theoretical, of course, but a less than ideal scenario. This occurs if the plaintext messages are repeated, and the MACed data does not include a counter (it does in the SSH 2 protocol, but only as a 32-bit counter, so you should take care to rekey before it overflows).</li>
</ul></li>
</ul>

In short, Encrypt-then-MAC is the most ideal scenario. Any modifications to the ciphertext that do not also have a valid MAC can be filtered out before decryption, protecting against any attacks on the implementation. The MAC cannot, also, be used to infer anything about the plaintext. MAC-then-Encrypt and Encrypt-and-MAC both provide different levels of security, but not the complete set provided by Encrypt-then-MAC.  

#### Answer 2 (score 127)
@Ninefingers answers the question quite well; I just want to add a few details.  

Encrypt-then-MAC is the mode which is recommended by most researchers. Mostly, it makes it easier to prove the security of the encryption part (because thanks to the MAC, a decryption engine cannot be fed with invalid ciphertexts; this yields automatic protection against chosen ciphertext attacks) and also avoids any trouble to confidentiality from the MAC (since the MAC operates on the encrypted text, it cannot reveal anything about the plaintext, regardless of its quality). Note that the <a href="http://en.wikipedia.org/wiki/Padding_oracle_attack">padding oracle attacks</a>, which have been applied in the field to ASP.NET, are chosen ciphertext attacks.  

Ferguson and Schneier, in their book <a href="http://www.schneier.com/book-practical.html">Practical Cryptography</a>, have argued the opposite: that MAC-then-encrypt (or MAC-and-encrypt) is the "natural" order and that encrypt-then-MAC is overly complex. The sore point of encrypt-then-MAC is that you have to be careful about what you MAC: you must not forget the initialization vector, or (in case the protocol allows algorithm flexibility) the unambiguous identifier for the encryption algorithm; otherwise, the attacker could change either, inducing a plaintext alteration which would be undetected by the MAC. To prove their point, Ferguson and Schneier describe an attack over an instance of IPsec in which the encrypt-then-MAC was not done properly.  

So while encrypt-then-MAC is theoretically better, it is also somewhat harder to get right.  

#### Answer 3 (score 49)
<p>Hugo Krawczyk has a paper titled <a href="http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.106.5488&amp;rep=rep1&amp;type=pdf">The Order of Encryption and Authentication for Protecting Communications (or: How Secure Is SSL?)</a>. 
It identifies 3 types of combining authentication (MAC) with encryption:</p>

<ol>
<li>Encrypt then Authenticate (EtA) <a href="http://tools.ietf.org/html/rfc4303#section-3.3.2.1">used in IPsec</a>;</li>
<li>Authenticate then Encrypt (AtE) <a href="http://tools.ietf.org/html/rfc5246#section-6.2.3">used in SSL</a>;</li>
<li>Encrypt and Authenticate (E&amp;A) <a href="http://tools.ietf.org/html/rfc4253#section-6.4">used in SSH</a>.</li>
</ol>

It proves that EtA is <em>the</em> secure way to use, and both AtE and E&amp;A are subject to attacks, unless the encryption method is either in CBC mode or it is a stream cipher.  

The abstract says everything; I emphasized important parts by bolding them:  

<blockquote>
  We study the question of how to generically compose symmetric encryption and authentication when building “secure channels” for the protection of communications over insecure networks. We show that any secure channels protocol designed to work with any combination of secure encryption (against chosen plaintext attacks) and secure MAC must use the <strong>encrypt-then-authenticate</strong> method. We demonstrate this by showing that the other common methods of composing encryption and authentication, including the <strong>authenticate-then-encrypt</strong> method used in <strong>SSL</strong>, are <strong>not generically secure</strong>. We show an example of an encryption function that provides (Shannon’s) perfect secrecy but when combined with any MAC function under the authenticate-then-encrypt method yields a totally insecure protocol (for example, finding passwords or credit card numbers transmitted under the protection of such protocol becomes an easy task for an active attacker). The same applies to the <strong>encrypt-and-authenticate</strong> method used in <strong>SSH</strong>.  
  
  On the positive side we show that the <strong>authenticate-then-encrypt</strong> method is secure if the encryption method in use is either <strong>CBC mode</strong> (with an underlying secure block cipher) or a <strong>stream cipher</strong> (that xor the data with a random or pseudorandom pad). Thus, while we show the generic security of SSL to be broken, the current practical implementations of the protocol that use the above modes of encryption are safe.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Difference between stream cipher and block cipher (score [111831](https://stackoverflow.com/q/5333) in 2017)

#### Question
I read that  

<blockquote>
  A typical stream cipher encrypts plaintext one byte at a time, although a stream cipher may be designed to operate on one bit at a time or on units larger than a byte at a time.  
</blockquote>

(Source: <a href="http://williamstallings.com/Cryptography/" rel="noreferrer">Cryptography and Network Security</a>, William Stallings.)  

A block cipher encrypts one block at a time. The block may be of size one byte or more or less. That means we can also encrypt a block of one byte by help of a stream cipher as a stream.  

So, what exactly is the difference between a stream cipher and a block cipher?  

#### Answer accepted (score 38)
A <a href="http://en.wikipedia.org/wiki/Block_cipher" rel="noreferrer"><strong>block cipher</strong></a> is a deterministic and computable function of <span class="math-container">$k$</span>-bit keys and <span class="math-container">$n$</span>-bit (plaintext) blocks to <span class="math-container">$n$</span>-bit (ciphertext) blocks. (More generally, the blocks don't have to be bit-sized, <span class="math-container">$n$</span>-character-blocks would fit here, too). This means, when you encrypt the same plaintext block with the same key, you'll get the same result. (We normally also want that the function is invertible, i.e. that given the key and the ciphertext block we can compute the plaintext.)  

To actually encrypt or decrypt a message (of any size), you don't use the block cipher directly, but put it into a <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation" rel="noreferrer"><strong>mode of operation</strong></a>. The simplest such mode would be <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Electronic_codebook_.28ECB.29" rel="noreferrer">electronic code book mode (ECB)</a>, which simply cuts the message in blocks, applies the cipher to each block and outputs the resulting blocks. (This is generally not a secure mode, though.)  

Some early encryption schemes like the one used by Caesar could be categorized as a "block cipher with 1-character blocks in ECB-mode". Or generally, everything that has a <em>code book</em>.  

We usually use other modes of operation, which include an <strong>initialization vector</strong> and some kind of feedback, so that every block of every message is encrypted a different way.  

<p>A <a href="http://en.wikipedia.org/wiki/Stream_cipher" rel="noreferrer"><strong>stream cipher</strong></a> is a function which directly maps <span class="math-container">$k$</span>-bit keys and arbitrary length plaintexts to (same arbitrary length) ciphertext, in such a way that prefixes of the plaintext map to prefixes of the ciphertext, i.e. we can compute the starting part of the ciphertext before the trailing part of the plaintext is known.
(Often the message sizes might be limited to multiples of some "block size", too, but usually with smaller blocks like whole bytes or such.)</p>

If a part of the plaintext repeats, the corresponding ciphertext usually is not the same – different parts of the message will be encrypted in different ways.  

Often such stream ciphers work by producing a <em>keystream</em> from the actual key (and maybe an initialization vector) and then simply XOR-ing it with the message – these are called <a href="http://en.wikipedia.org/wiki/Stream_cipher#Synchronous_stream_ciphers" rel="noreferrer"><strong>synchronous stream ciphers</strong></a>.  Other stream ciphers might vary the encryption of future parts of the message depending on previous parts.  

Some block cipher modes of operation actually create a synchronous stream cipher, like <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Counter_.28CTR.29" rel="noreferrer">CTR</a> and <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Output_feedback_.28OFB.29" rel="noreferrer">OFB</a> mode.  

You should never reuse a key (and IV, if applicable) of a synchronous stream cipher (which includes block ciphers in streaming modes) for different messages, since this can lead to compromises. (And even for the same message it will show that you repeated a message.)  

Note that in actual usage you will also want a MAC, e.g. integrity protection, for your message. (Some schemes are broken in case of a chosen-ciphertext attack, for example, and such a MAC will prevent this (if you only pass the message to the decryptor after checking the MAC).)  

#### Answer 2 (score 21)
Mathematically, a block cipher is just a keyed <a href="http://en.wikipedia.org/wiki/Pseudorandom_permutation" rel="noreferrer">pseudorandom permutation</a> family on the set $\{0,1\}^n$ of $n$-bit blocks.  (In practice, we usually also require an efficient way to compute the inverse permutation.)  A block cipher <em>on its own</em> is not very useful for practical cryptography, at least unless you just happen to need to encrypt small messages that each fit into a single block.  

However, it turns out that block ciphers are <em>extremely</em> versatile building blocks for constructing other cryptographic tools: once you have a good block cipher, you can easily build anything from stream ciphers to hash functions, message authentication codes, key derivation functions, pseudorandom number generators, entropy pools, etc. based on just one block cipher.  

Not all of these applications necessarily <em>need</em> a block cipher; for example, many of them could be based on any <a href="http://en.wikipedia.org/wiki/Pseudorandom_function" rel="noreferrer">pseudorandom function</a> which need not be a permutation (but, conveniently, there's a <a href="http://www.scribd.com/doc/59889516/29/The-PRP-PRF-switching-lemma" rel="noreferrer">lemma</a> that says a pseudorandom permutation will, nonetheless, work).  Also, many of the constructions are indirect; for example, you can construct a key derivation function from a message authentication code, which you can construct from a hash function, which you can &mdash; but don't <em>have</em> to &mdash; construct from a block cipher.  But still, if you have a block cipher, you <em>can</em> build all the rest out of it.  

Furthermore, these constructions typically come with (conditional) security proofs that reduce the security of the constructed functions to that of the underlying block cipher.  Thus, you don't need to carry out the laborious and unreliable task of cryptanalyzing each of these functions separately &mdash; instead, you're free to concentrate all your efforts on the block cipher, knowing that any confidence you'll have on the security of the block cipher directly translates into confidence on all the functions based on it.  

Obviously, all this is very convenient if you're, say, working on a small embedded platform where including efficient and secure code for lots of separate crypto primitives could be difficult and expensive.  But even if you're not on such a constrained platform, writing and analyzing low-level crypto code can be laborious due to the need to pay attention to things like <a href="http://en.wikipedia.org/wiki/Side_channel_attack" rel="noreferrer">side-channel attacks</a>.  It's easier to restrict yourself to a limited number of low-level building blocks and to build everything you need out of those.  

Also, even on fast platforms with lots of memory, like desktop CPUs, implementing low-level crypto operations directly in hardware can be much faster than doing them in software &mdash; but it's not practical to do that for more than a few of them.  Due to their versatility, block ciphers are excellent candidates for hardware implementation (as in the <a href="http://en.wikipedia.org/wiki/AES_instruction_set" rel="noreferrer">AES instruction set</a> for modern x86 CPUs).  

<hr>

What about stream ciphers, then?  

Mathematically, a <a href="http://en.wikipedia.org/wiki/Stream_cipher" rel="noreferrer">stream cipher</a> &mdash; in the most general sense of the term &mdash; is also a keyed invertible pseudorandom function family, but on the set $\{0,1\}^*$ of arbitrary-length bitstrings rather than on blocks of limited length.  

(There are some subtleties here; for example, most stream cipher constructions require the input to include a unique <a href="http://en.wikipedia.org/wiki/Cryptographic_nonce" rel="noreferrer">nonce</a> value, and do not guarantee security &mdash; in the sense of indistinguishability from a truly random function &mdash; if the same nonce is used for two different inputs.  Also, as there is no uniform distribution on invertible functions from $\{0,1\}^*$ to itself to choose random functions from, we need to define carefully just what it means for a stream cipher to look "indistinguishable from random", and this definition <em>does</em> have practical security implications &mdash; for example, most stream ciphers leak the length of the message.  Practically, we usually also require that stream ciphers, in fact, be "streaming", in the sense that arbitrarily long input bitstreams can be encrypted &mdash; and decrypted &mdash; using only constant storage and time linear in the message length.)  

Of course, stream ciphers are much more immediately useful than block ciphers: you can use them directly to encrypt messages of any length.  However, it turns out that they're also much <em>less</em> useful as building blocks for other cryptographic tools: if you have a block cipher, you can easily <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation" rel="noreferrer">turn it into a stream cipher</a>, whereas turning an arbitrary stream cipher into a block cipher is <a href="https://crypto.stackexchange.com/questions/712/converting-a-stream-cipher-into-a-block-cipher">difficult if not impossible</a>.  

So why do people bother designing dedicated stream ciphers at all, then, if block ciphers can do the job just as well?  Mostly, the reason is speed: sometimes, you need a fast cipher to encrypt lots of data, and there are some <em>really</em> fast dedicated stream cipher designs out there.  Some of these designs are also designed to be very compact to implement, either in software or hardware or both, so that if you really only need a stream cipher, you can save on code/circuit size by using one of those ciphers instead of a general block cipher based one.  

However, what you gain in speed and compactness, you lose in versatility.  For example, there doesn't seem to be any simple way to <a href="https://crypto.stackexchange.com/questions/2214/can-you-make-a-hash-out-of-a-stream-cipher">make a hash function out of a stream cipher</a>, so if you need one of those (and you often do, because hash functions, besides being useful on their own, are also common building blocks for other crypto tools), you'll have to implement them separately.  And, guess what, most hash functions are based on block ciphers, so if you have one, you might as well reuse the same block cipher for encryption too (unless you really need the raw speed of the dedicated stream cipher).  

#### Answer 3 (score 12)
A block cipher by itself does map `n` bits to `n` bits using a key. i.e. it's a keyed pseudo-random permutation. It cannot accept longer or shorter texts.  

To actually encrypt a message you <em>always</em> need a chaining mode. ECB is one such chaining mode(and a really bad one), and it's not the pure block cipher. Even ECB consists of "add-on processing operations". These chaining modes can have quite different properties.  

One of the most popular chaining modes, Counter mode (CTR) constructs a synchronous stream cipher from a block cipher. Another mode, CFB constructs a self synchronizing stream cipher, with properties somewhere between those of CBC and a synchronous stream cipher.  

So your assumption that there are no ciphers between stream and blockciphers isn't really true. Cryptographers just prefer building them from the well understood block cipher primitive, instead of creating a completely new system.  

I'd call Vigenère a stream cipher, albeit one with a much too short period. It uses a 26 symbol encoding instead of a 2 symbol encoding, but that doesn't mean it's not a stream cipher. Look at <a href="http://en.wikipedia.org/wiki/Solitaire_%28cipher%29">Solitaire/Pontifex</a> for a modern construction of a stream cipher with 26 symbols.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How does RSA signature verification work? (score [110869](https://stackoverflow.com/q/9896) in )

#### Question
I understand how the RSA algorithm works for encryption and decryption purposes but I don't get how signing is done.  

Here's what I (think) I know and is common practice:  

<ul>
<li>If I have a message that I want to sign, I don't sign the message itself but I create a hash of it and then sign that hash by using my private key.</li>
<li>The signature gets attached to the message and both are transferred to the recipient.</li>
<li>The recipient recalculates the hash of the message and then uses my public key to verify the signature he received.</li>
</ul>

Here are the questions:  

<ul>
<li>Why is it common practice to create a hash of the message and sign that instead of signing the message directly?</li>
<li>The important part and this is where I really started scratching my head: How can the recipient verify that I own the private key if the public key seems to be enough to recreate the signature?</li>
</ul>

#### Answer accepted (score 82)
<blockquote>
  Why is it common practice to create a hash of the message and sign that instead of signing the message directly?  
</blockquote>

Well, the RSA operation can't handle messages longer than the modulus size.  That means that if you have a 2048 bit RSA key, you would be unable to directly sign any messages longer than 256 bytes long (and even that would have problems, because of lack of padding).  

In contrast, a cryptographical hash can take an arbitrarily long message, and 'compress' it into a short string, in such a way that we cannot find two messages that hash to the same value.  Hence, signing the hash is just as good as signing the original message; without the length restrictions we would have if we didn't use a hash.  

<blockquote>
  The important part and this is where I really started scratching my head: How can the recipient verify that I own the private key if the public key seems to be enough to recreate the signature?  
</blockquote>

What made you think that the public key is enough to recreate the signature?  It is sufficient to verify a signature that you're given, but it is not sufficient to generate new ones (or so we hope; if that's not true, the signature scheme is broken).  

If you're using RSA, the signature verification process is (effectively) checking whether:  

$S^e = \operatorname{Pad}(\operatorname{Hash}(M))\pmod N$  

Definitions: $S$ is the signature; $M$ is the message; $e$ and $N$ are the public exponent and modulus from the public key; $\pmod N$ means that equality is checked modulo $N$; $\operatorname{Pad}$ is the padding function; and $\operatorname{Hash}$ is the hashing function. Note I say "effectively" because sometimes the padding method is nondetermanistic; that makes this check slightly different, but not in a way that matters for this discussion.  

Now, if we were trying to forge a signature for a message $M'$ (with only the public key), we could certainly compute $P' = \operatorname{Pad}(\operatorname{Hash}(M'))$; however, then we'd need to find a value $S'$ with:  

$S'^e = P' \pmod N$  

and, if $N$ is an RSA modulus, we don't know how to do that.  

The holder of the private key can do this, because he has a value $d$ with the property that:  

$(x^e)^d = x \pmod N$  

for all $x$.  That means that:  

$(P')^d = (S'^e)^d = S' \pmod N$  

is the signature.  

Now, if we have only the public key, we don't know $d$; getting that value is equivalent to factoring $N$, and we can't do that.  The holder of the private key knows $d$, because he knows the factorization of $N$.  

#### Answer 2 (score 5)
<blockquote>
  The important part and this is where I really started scratching my head: How can the recipient verify that I own the private key if the public key seems to be enough to recreate the signature?  
</blockquote>

You can use `public key` to "encrypt" (or "decrypt" which is same in "textbook" RSA) the `signature` and get `hashed message`. If the `hashed message` equals hashed `message`, then you verified the `message` being correctly signed.  

You cannot use `public key` and `message` to recreate  a `signature` that can pass the above verification though.  

P.S. For "textbook" RSA, I mean <a href="https://www.cs.cornell.edu/courses/cs5430/2015sp/notes/rsa_sign_vs_dec.php" rel="noreferrer">https://www.cs.cornell.edu/courses/cs5430/2015sp/notes/rsa_sign_vs_dec.php</a>   

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: What is safer: ZipCrypto or AES-256? (score [105988](https://stackoverflow.com/q/3791) in )

#### Question
Like in title: which one of these encryption methods (ZipCrypto, AES-256) is more secure and why? I am asking about it because I'd like to know which should be preferred when compressing files with Zip.  

#### Answer accepted (score 44)
According to <a href="http://sevenzip.sourceforge.jp/chm/fm/plugins/7-zip/add.htm" rel="nofollow noreferrer">7-Zip</a>,   

<blockquote>
  Use ZipCrypto, if you want to get archive compatible with most of the ZIP archivers. AES-256 provides stronger encryption, but now AES-256 is supported only by 7-Zip, WinZip and some other ZIP archivers.  
</blockquote>

So really there is some balance to be played with. Do you require better security at the sacrifice of compatibility or more compatibility at the sacrifice of security?  

According to the <a href="http://infozip.sourceforge.net/FAQ.html#crypto" rel="nofollow noreferrer">Info-Zip FAQ</a>, it sounds like ZipCrypto is pretty weak. Keep that in mind when making your decision.  

<em>Note: The link on Info-Zip FAQ to the publication is broken, you can find the file on <a href="http://ftp.gnome.org/mirror/archive/ftp.sunet.se/pub/security/docs/crypt/ripem.msu.edu/kocher-pkzip-attack.txt.gz" rel="nofollow noreferrer">A Known-Plaintext Attack on the PKZIP Stream Cipher</a></em>  

#### Answer 2 (score -1)
The main advantage of using the Zip archive file format is that it is a standard format that (for all newer versions of Windows at least, which I think goes back to Windows 2000) is directly supported by the Windows OS. That is, you don't need to download any additional software to compress or decompress Zip files. Windows doesn't support encrypting Zip files though, but third party software like 7Zip do. However, Windows does support DECRYPTING Zip files, at least those encrypted with ZipCrypto. 7Zip supports encrypting with one of 2 types of encryption. These are ZipCrypto and AES-256. AES is by far the stronger of the 2 types, but it has one major flaw. That flaw is it CANNOT be decrypted with Windows, only with 3rd party software (like 7Zip itself) that supports AES decryption.  

If you want to send a file to somebody that is encrypted, and make sure it can be decrypted without asking them to download additional software, your best bet is to use 7Zip set to perform ZipCrypto encryption. Why not just use AES encrypted Zip and then tell the recipient to download 7Zip so they can decrypt it? The answer to that is simple. There's no point in that. There's no point in sending an AES encrypted Zip file at all in fact. AES is already supported in the much better compressed file type called 7Z, which of course is 7Zip's default file. 7Z has a better compression ratio than Zip. So if you are going to use AES to encrypt it and make sure that both the sender and the receiver have 7Zip installed on their PCs, you might as well not even bother with the Zip file format, and instead use the 7Z file format. The 7Z file format also has a major advantage when it comes to encryption, because it can encrypt file names as well as the actual bytes of the file itself. If you really don't want somebody to know what you are sending, and file names can give a clue, you would want to be able to encrypt the file name itself.  

As for why Zip with AES encryption isn't supported in Windows, it's because it isn't part of the official Zip standard. It was added in 7Zip as an unofficial extension to the Zip standard. Windows's Zip utilities are based strictly on the official Zip format specification.  

<p>So here's my recommendations:
Use a Zip file with ZipCrypto if you want to send a file that doesn't require external software to decrypt.
Use a 7Z file with AES if you want the strongest encryption.
Don't use a Zip file with AES encryption, as there's no point in doing so.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: What is the SSL private key file format? (score [105445](https://stackoverflow.com/q/21102) in 2015)

#### Question
I was researching about how to encrypt with RSA. I understood everything but not the format of the private keys.  

In the phpseclib (RSA in PHP), you can import your private key (private.key format) and in the key file there is text like this:  

```cryptography
-----BEGIN RSA PRIVATE KEY-----
MIIBOQIBAAJBAIOLepgdqXrM07O4dV/nJ5gSA12jcjBeBXK5mZO7Gc778HuvhJi+
RvqhSi82EuN9sHPx1iQqaCuXuS1vpuqvYiUCAwEAAQJATRDbCuFd2EbFxGXNxhjL
loj/Fc3a6UE8GeFoeydDUIJjWifbCAQsptSPIT5vhcudZgWEMDSXrIn79nXvyPy5
BQIhAPU+XwrLGy0Hd4Roug+9IRMrlu0gtSvTJRWQ/b7m0fbfAiEAiVB7bUMynZf4
SwVJ8NAF4AikBmYxOJPUxnPjEp8D23sCIA3ZcNqWL7myQ0CZ/W/oGVcQzhwkDbck
3GJEZuAB/vd3AiASmnvOZs9BuKgkCdhlrtlM6/7E+y1p++VU6bh2+mI8ZwIgf4Qh
u+zYCJfIjtJJpH1lHZW+A60iThKtezaCk7FiAC4= 
-----END RSA PRIVATE KEY-----
```

<p>But when I decode this with Base64 and then convert it to decimal it is just <strong>one</strong> number...
I thought you need both $p$ and $q$! My question:</p>

<strong>If I roll a dice (with 0 and 1) 1024 times and find the nearest prime number it would be my $p$ and I would do this process again so I get $q$, but how do I convert those numbers to the private.key format? And what's the difference?</strong>  

#### Answer accepted (score 32)
Copy / paste that key into <a href="http://phpseclib.sourceforge.net/x509/asn1parse.php" rel="nofollow noreferrer">http://phpseclib.sourceforge.net/x509/asn1parse.php</a> and you'll see that there are several different integers in there. <span class="math-container">$p$</span> is there, <span class="math-container">$q$</span> is there as is the exponent and several other integers to speed things up by taking advantage of the Chinese Remainder Theorem.  

The key is encoded using DER and derives semantic meaning via ASN.1. The following URL elaborates:  

<a href="http://tools.ietf.org/html/rfc3447#appendix-C" rel="nofollow noreferrer">http://tools.ietf.org/html/rfc3447#appendix-C</a>  

Quoting <a href="https://stackoverflow.com/a/21289989/569976">I understand the mathematics of RSA encryption: How are the files in ~/.ssh related to the theory?</a>:  

<blockquote>
  <p>The ASN.1 syntax for that DER-encoded string is described in
  <a href="https://tools.ietf.org/html/rfc3447#appendix-A.1" rel="nofollow noreferrer">RFC3447</a> (aka <a href="https://en.wikipedia.org/wiki/PKCS_1" rel="nofollow noreferrer">PKCS1</a>):</p>

```cryptography
  Version ::= INTEGER { two-prime(0), multi(1) }
      (CONSTRAINED BY
      {-- version must be multi if otherPrimeInfos present --})

  RSAPrivateKey ::= SEQUENCE {
      version           Version,
      modulus           INTEGER,  -- n
      publicExponent    INTEGER,  -- e
      privateExponent   INTEGER,  -- d
      prime1            INTEGER,  -- p
      prime2            INTEGER,  -- q
      exponent1         INTEGER,  -- d mod (p-1)
      exponent2         INTEGER,  -- d mod (q-1)
      coefficient       INTEGER,  -- (inverse of q) mod p
      otherPrimeInfos   OtherPrimeInfos OPTIONAL
  }
```
  
  <p>DER encoding uses a tag-length-value notation. So here's a sample
  private key:</p>

```cryptography
-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCqGKukO1De7zhZj6+H0qtjTkVxwTCpvKe4eCZ0FPqri0cb2JZfXJ/DgYSF6vUp
wmJG8wVQZKjeGcjDOL5UlsuusFncCzWBQ7RKNUSesmQRMSGkVb1/3j+skZ6UtW+5u09lHNsj6tQ5
1s1SPrCBkedbNf0Tp0GbMJDyR4e9T04ZZwIDAQABAoGAFijko56+qGyN8M0RVyaRAXz++xTqHBLh
3tx4VgMtrQ+WEgCjhoTwo23KMBAuJGSYnRmoBZM3lMfTKevIkAidPExvYCdm5dYq3XToLkkLv5L2
pIIVOFMDG+KESnAFV7l2c+cnzRMW0+b6f8mR1CJzZuxVLL6Q02fvLi55/mbSYxECQQDeAw6fiIQX
GukBI4eMZZt4nscy2o12KyYner3VpoeE+Np2q+Z3pvAMd/aNzQ/W9WaI+NRfcxUJrmfPwIGm63il
AkEAxCL5HQb2bQr4ByorcMWm/hEP2MZzROV73yF41hPsRC9m66KrheO9HPTJuo3/9s5p+sqGxOlF
L0NDt4SkosjgGwJAFklyR1uZ/wPJjj611cdBcztlPdqoxssQGnh85BzCj/u3WqBpE2vjvyyvyI5k
X6zk7S0ljKtt2jny2+00VsBerQJBAJGC1Mg5Oydo5NwD6BiROrPxGo2bpTbu/fhrT8ebHkTz2epl
U9VQQSQzY1oZMVX8i1m5WUTLPz2yLJIBQVdXqhMCQBGoiuSoSjafUhV7i1cEGpb88h5NBYZzWXGZ
37sJ5QsW+sJyoNde3xH8vdXhzU7eT82D6X/scw9RZz+/6rCJ4p0=
-----END RSA PRIVATE KEY-----
```
  
  Here's the hex encoding:  

```cryptography
3082025c02010002818100aa18aba43b50deef38598faf87d2ab634e4571c130a9bca7b878267414
faab8b471bd8965f5c9fc3818485eaf529c26246f3055064a8de19c8c338be5496cbaeb059dc0b35
8143b44a35449eb264113121a455bd7fde3fac919e94b56fb9bb4f651cdb23ead439d6cd523eb081
91e75b35fd13a7419b3090f24787bd4f4e196702030100010281801628e4a39ebea86c8df0cd1157
2691017cfefb14ea1c12e1dedc7856032dad0f961200a38684f0a36dca30102e2464989d19a80593
3794c7d329ebc890089d3c4c6f602766e5d62add74e82e490bbf92f6a482153853031be2844a7005
57b97673e727cd1316d3e6fa7fc991d4227366ec552cbe90d367ef2e2e79fe66d26311024100de03
0e9f8884171ae90123878c659b789ec732da8d762b26277abdd5a68784f8da76abe677a6f00c77f6
8dcd0fd6f56688f8d45f731509ae67cfc081a6eb78a5024100c422f91d06f66d0af8072a2b70c5a6
fe110fd8c67344e57bdf2178d613ec442f66eba2ab85e3bd1cf4c9ba8dfff6ce69faca86c4e9452f
4343b784a4a2c8e01b0240164972475b99ff03c98e3eb5d5c741733b653ddaa8c6cb101a787ce41c
c28ffbb75aa069136be3bf2cafc88e645face4ed2d258cab6dda39f2dbed3456c05ead0241009182
d4c8393b2768e4dc03e818913ab3f11a8d9ba536eefdf86b4fc79b1e44f3d9ea6553d55041243363
5a193155fc8b59b95944cb3f3db22c9201415757aa13024011a88ae4a84a369f52157b8b57041a96
fcf21e4d058673597199dfbb09e50b16fac272a0d75edf11fcbdd5e1cd4ede4fcd83e97fec730f51
673fbfeab089e29d
```
  
  <p>The 30 is because it's a SEQUENCE tag. The 82025c represents the
  length. The first byte means the length is of the "long form" (82 &amp; 80) and that
  the next two bytes represent the length (82 &amp; 7F). So the actual length of the
  SEQUENCE is 025c. So after that is the value.</p>
  
  <p>Then you get to the version. 02 is of type int, 01 is the tag length
  and 00 is the value. ie. it's a two-prime key as opposed to a
  multi-prime key.</p>
  
  <a href="http://www.itu.int/ITU-T/studygroups/com17/languages/X.690-0207.pdf" rel="nofollow noreferrer">More info on the Distinguished Encoding Rules</a>.  
  
  <p>Trying to understand ASN.1 is a lot more complicated and a lot of it,
  for the purpose of understanding the formatting of RSA private keys,
  is unnecessary. For X.509 it becomes more necessary but RSA keys
  aren't nearly as complicated, formatting-wise, as X.509 certs.</p>
  
  Hope that helps!  
</blockquote>

#### Answer 2 (score 23)
It is correct that the given private key does not encode a single integer, and that it includes two primes $p$ and $q$. More precisely, that Base64 data encodes a string of bytes, which is an RSAPrivateKey encoded per ASN.1 DER-TLV (and thus <a href="https://www.itu.int/ITU-T/studygroups/com17/languages/X.690-0207.pdf#page=11" rel="nofollow noreferrer">BER-TLV</a>) following <a href="https://www.emc.com/collateral/white-papers/h11300-pkcs-1v2-2-rsa-cryptography-standard-wp.pdf#page=41" rel="nofollow noreferrer">PKCS#1v2.2 Appendix A.1.2</a> (likely restricted to version 0). It decodes to:  

<ul>
<li>`30` ASN.1 tag for <em>sequence</em>, a BER-TLV tag (Application class, Constructed encoding, Tag number 0)</li>
<li>`82 01 39` Length as prefix plus two bytes, of 0x139 = 313 (number of bytes following)

<ul>
<li>`02` ASN.1 tag for <em>int</em>, also a BER-TLV tag (Universal class, Primitive encoding, Tag number 2)</li>
<li>`01` Length encoded on one byte, of 0x01 = 1

<ul>
<li>`00` Version 0, meaning RSA private key with 2 primes</li>
</ul></li>
<li>`02` ASN.1 tag for <em>int</em></li>
<li>`41` Length encoded on one  byte, of 0x41 = 65<br>

<ul>
<li>`00 83 8B 7A 98 1D A9 7A CC D3 B3 B8 75 5F E7 27 98 12 03 5D A3 72 30 5E 05 72 B9 99 93 BB 19 CE FB F0 7B AF 84 98 BE 46 FA A1 4A 2F 36 12 E3 7D B0 73 F1 D6 24 2A 68 2B 97 B9 2D 6F A6 EA AF 62 25` public modulus $n$ (big-endian, leftmost bit is sign)</li>
</ul></li>
<li>`02` ASN.1 tag for <em>int</em></li>
<li>`03` Length encoded on one byte, of 0x03 = 3

<ul>
<li>`01 00 01` public exponent $e$ (big-endian, leftmost bit is sign)</li>
</ul></li>
<li>`02` ASN.1 tag for <em>int</em></li>
<li>`40` Length encoded on one byte, of 0x40 = 64

<ul>
<li>`4D 10 DB 0A E1 5D D8 46 C5 C4 65 CD C6 18 CB 96 88 FF 15 CD DA E9 41 3C 19 E1 68 7B 27 43 50 82 63 5A 27 DB 08 04 2C A6 D4 8F 21 3E 6F 85 CB 9D 66 05 84 30 34 97 AC 89 FB F6 75 EF C8 FC B9 05` private exponent $d$ (big-endian, leftmost bit is sign)</li>
</ul></li>
<li>`02` ASN.1 tag for <em>int</em></li>
<li>`21` Length encoded on one byte, of 0x21 = 33

<ul>
<li>`00 F5 3E 5F 0A CB 1B 2D 07 77 84 68 BA 0F BD 21 13 2B 96 ED 20 B5 2B D3 25 15 90 FD BE E6 D1 F6 DF` secret prime $p$ (big-endian, leftmost bit is sign)</li>
</ul></li>
<li>`02` ASN.1 tag for <em>int</em></li>
<li>`21` Length encoded on one byte, of 0x21 = 33

<ul>
<li>`00 89 50 7B 6D 43 32 9D 97 F8 4B 05 49 F0 D0 05 E0 08 A4 06 66 31 38 93 D4 C6 73 E3 12 9F 03 DB 7B` secret prime $q$ (big-endian, leftmost bit is sign)</li>
</ul></li>
<li>`02` ASN.1 tag for <em>int</em></li>
<li>`20` Length encoded on one byte, of 0x20 = 32

<ul>
<li>`0D D9 70 DA 96 2F B9 B2 43 40 99 FD 6F E8 19 57 10 CE 1C 24 0D B7 24 DC 62 44 66 E0 01 FE F7 77` $dp=d\bmod(p-1)$ (big-endian, leftmost bit is sign)</li>
</ul></li>
<li>`02` ASN.1 tag for <em>int</em></li>
<li>`20` Length encoded on one byte, of 0x20 = 32

<ul>
<li>`12 9A 7B CE 66 CF 41 B8 A8 24 09 D8 65 AE D9 4C EB FE C4 FB 2D 69 FB E5 54 E9 B8 76 FA 62 3C 67` $dq=d\bmod(q-1)$ (big-endian, leftmost bit is sign)</li>
</ul></li>
<li>`02` ASN.1 tag for <em>int</em></li>
<li>`20` Length encoded on one byte, of 0x20 = 32

<ul>
<li>`7F 84 21 BB EC D8 08 97 C8 8E D2 49 A4 7D 65 1D 95 BE 03 AD 22 4E 12 AD 7B 36 82 93 B1 62 00 2E` $q_\text{inv}=q^{-1}\bmod p$ (big-endian, leftmost bit is sign)</li>
</ul></li>
</ul></li>
</ul>

Therefore, this private keys has:  

<ul>
<li>$n$&nbsp;=&nbsp;6889562268374622799957651484276189567066573692163081374402850932375514118031048420110853972747558241305562483958233191802399592639320405757333978594894373</li>
<li>$e$&nbsp;=&nbsp;65537</li>
<li>$d$&nbsp;=&nbsp;4036265671212347870735218712159303880670782869380678233214786480134242711167668040594757438422211656546040377235338723652323162649874081271989898105895173</li>
<li>$p$&nbsp;=&nbsp;110926848377808511478526072563819593239744031998335766139683653481372583065311</li>
<li>$q$&nbsp;=&nbsp;62109059881601353504240950986730444628975000449359215027377545384004575026043</li>
<li>$dp$&nbsp;=&nbsp;6264251733315063261699879374379301990940883202249731761950794231267222026103</li>
<li>$dq$&nbsp;=&nbsp;8414580201851449070969916288679366126930879182597013446268294634551118019687</li>
<li>$q_\text{inv}$&nbsp;=&nbsp;57677188406707620788831013172875873422122983590947547357547002213122938372142</li>
</ul>

As expected, these values verify:  

<ul>
<li>$n=p\cdot q$</li>
<li>$e\cdot d\equiv 1\pmod{\operatorname{lcm}(p-1,q-1)}$</li>
<li>$dp=e^{-1}\bmod(p-1)=d\bmod(p-1)$</li>
<li>$dq=e^{-1}\bmod(q-1)=d\bmod(q-1)$</li>
<li>$q_\text{inv}=q^{-1}\bmod p$</li>
</ul>

The public modulus $n$ is 512-bit, which is too small to be safe.  

<hr>

If one draws $p$ and $q$ using 1024 dice throws for each, rounding to the nearest <em>lower</em> prime, $p$ and $q$ are about (and at most) 1024-bit each, thus the public modulus $n$ about 2048-bit, which is safe. With overwhelming odds, $p$ and $q$ are distinct.  

It is customary and recommended to ensure that $n$ has <em>exactly</em> $k$ bits with $k$ a multiple of some power of two at least 64, and towards that goal to choose $p$ and $q$ above $2^{(k-1)/2}$.  

It is customary and unobjectionable to choose $e=2^{16}+1=65537$, and towards that goal to choose $p$ and $q$ such that $p\not\equiv1\pmod{65537}$ and $q\not\equiv1\pmod{65537}$.  

Afterwards, one  

<ul>
<li>computes $n$, $d$, $dp$, $dq$, $q_\text{inv}$, $d$; for $d$, among other options, one can 

<ul>
<li>compute $d=e^{-1}\bmod((p-1)\cdot(q-1))$ as in the private key above,</li>
<li>compute $d=e^{-1}\bmod(\operatorname{lcm}(p-1,q-1))$ for a slightly smaller $d$,</li>
<li>build $d$ from $dp$ and $dq$;</li>
</ul></li>
<li>encodes the private key per ASN.1 DER-TLV following PKCS#1v2 Appendix A.1.2, as above;</li>
<li>converts to Base64;</li>
<li>adds `-----BEGIN RSA PRIVATE KEY-----` and `-----END RSA PRIVATE KEY-----` delimiters;</li>
<li>adds line breaks as appropriate (including at least before and after each delimiter, except that a newline is not necessary at start of file).</li>
</ul>

Easily missed rules when encoding to ASN.1 DER-TLV by induction from example:  

<ul>
<li>length encoding (in the context of RSA, all length are usually in range [1..0xFFFF], but some implementations have a lower size restriction)

<ul>
<li>any length from 0 up to 0x7F is encoded as one byte in `00`..`7F`;</li>
<li>any higher length up to 0xFF is encoded as prefix `81` and one byte;</li>
<li>any higher length up to 0xFFFF is encoded as prefix `82` and two bytes;</li>
<li>any higher length up to 0xFFFFFF is encoded as prefix `83` and three bytes;</li>
<li>any higher length up to 0xFFFFFFFF is encoded as prefix `84` and four bytes;</li>
<li>the rule goes on for higher lengths, but some standards (including ISO/IEC&nbsp;7816-4:2013, appendix E.2) explicitly exclude these.</li>
</ul></li>
<li>the byte representation of a non-negative integer must be the shortest big-endian byte representation with leftmost sign bit; therefore:

<ul>
<li>it starts with a byte in range `00`..`7F`;</li>
<li>and if that first byte is `00`, then the next byte (if present) must be in range `80`..`FF`.</li>
</ul></li>
</ul>

#### Answer 3 (score 9)
To conclude the answers here's a note about the simplest way (on linux at least) to view the contents of such keys with openssl:  

```cryptography
$ openssl rsa -in test.key -text
Private-Key: (512 bit)
modulus:
    00:83:8b:7a:98:1d:a9:7a:cc:d3:b3:b8:75:5f:e7:
    27:98:12:03:5d:a3:72:30:5e:05:72:b9:99:93:bb:
    19:ce:fb:f0:7b:af:84:98:be:46:fa:a1:4a:2f:36:
    12:e3:7d:b0:73:f1:d6:24:2a:68:2b:97:b9:2d:6f:
    a6:ea:af:62:25
publicExponent: 65537 (0x10001)
privateExponent:
    4d:10:db:0a:e1:5d:d8:46:c5:c4:65:cd:c6:18:cb:
    96:88:ff:15:cd:da:e9:41:3c:19:e1:68:7b:27:43:
    50:82:63:5a:27:db:08:04:2c:a6:d4:8f:21:3e:6f:
    85:cb:9d:66:05:84:30:34:97:ac:89:fb:f6:75:ef:
    c8:fc:b9:05
prime1:
    00:f5:3e:5f:0a:cb:1b:2d:07:77:84:68:ba:0f:bd:
    21:13:2b:96:ed:20:b5:2b:d3:25:15:90:fd:be:e6:
    d1:f6:df
prime2:
    00:89:50:7b:6d:43:32:9d:97:f8:4b:05:49:f0:d0:
    05:e0:08:a4:06:66:31:38:93:d4:c6:73:e3:12:9f:
    03:db:7b
exponent1:
    0d:d9:70:da:96:2f:b9:b2:43:40:99:fd:6f:e8:19:
    57:10:ce:1c:24:0d:b7:24:dc:62:44:66:e0:01:fe:
    f7:77
exponent2:
    12:9a:7b:ce:66:cf:41:b8:a8:24:09:d8:65:ae:d9:
    4c:eb:fe:c4:fb:2d:69:fb:e5:54:e9:b8:76:fa:62:
    3c:67
coefficient:
    7f:84:21:bb:ec:d8:08:97:c8:8e:d2:49:a4:7d:65:
    1d:95:be:03:ad:22:4e:12:ad:7b:36:82:93:b1:62:
    00:2e
```

If you have only a public RSA key - just add `-pubin` flag to openssl.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Should I use ECB or CBC encryption mode for my block cipher? (score [104063](https://stackoverflow.com/q/225) in 2016)

#### Question
Can someone tell me which mode out of <strong>ECB</strong> and <strong>CBC</strong> is better, and how to decide which mode to use? Are there any other modes which are better?  

#### Answer accepted (score 88)
The really simple explanation for the difference between the two is this:  

<ul>
<li>ECB (<strong>electronic code book</strong>) is basically raw cipher. For each block of input, you encrypt the block and get some output. The problem with this transform is that any resident properties of the plaintext might well show up in the ciphertext – possibly not as clearly – that's what blocks and key schedules are supposed to protect againt, but analyzing the patterns you may be able to deduce properties that you otherwise thought were hidden.</li>
<li>CBC mode is short for <strong>cipher block chaining</strong>. You have an initialization vector which you XOR the first block of plaintext against. You then encrypt that block of plaintext. The next block of plaintext is xor'd against the last encrypted block before you encrypt this block.
<img src="https://i.stack.imgur.com/5rDqg.png" alt="enter image description here">
(<a href="http://commons.wikimedia.org/wiki/File:Cbc_encryption.png" rel="noreferrer">Public domain image from Wikimedia Commons</a>.)</li>
</ul>

The advantages of CBC over ECB are many – with ECB, assuming many things, you could manage a partial decryption and easily fill in the blanks, for example if extracting data from an encrypted hard disk. With CBC, if you are missing a few blocks in the sequence encryption becomes impossible. However, there is one downside to CBC – ECB naturally supports operation in parallel since each block can be encrypted independently of the next. However, with CBC this is harder, since you have to wait on each block. (You can still parallelize decryption, though.)  

CBC itself can also be considered vulnerable in certain situations, specifically the use of predictable IVs and unauthenticated decryption can allow you to guess plaintexts as <a href="https://crypto.stackexchange.com/a/3885/46">explained in this answer</a> and in more detail <a href="https://crypto.stackexchange.com/a/1082/46">here</a>.  

The IV problem is resolved by using unpredictable (cryptographically random) IVs. The authentication problem is traditionally resolved using message authentication codes - however, implementation of these is not perfect. Dedicated modes have been invented which tackle the issue of authentication too, for example <a href="https://en.wikipedia.org/wiki/EAX_mode" rel="noreferrer">EAX</a> and <a href="https://en.wikipedia.org/wiki/Galois/Counter_Mode" rel="noreferrer">Galois Counter Mode</a>.  

Other modes exist to deal with specific scenarios, e.g.:  

<ul>
<li><a href="https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Counter_.28CTR.29" rel="noreferrer">Counter Mode</a> uses the fact that a block cipher's output in ECB mode should be indistinguishable from random, and XOR's the result of encrypting a counter+iv combination as a stream cipher.</li>
<li><a href="https://en.wikipedia.org/wiki/XTS_mode#XEX-based_tweaked-codebook_mode_with_ciphertext_stealing_.28XTS.29" rel="noreferrer">XTS</a> is a mode of operation used in disk encryption.</li>
</ul>

The key point to take away is that each mode has a number of merits and implementation concerns and these must be weighed up carefully (and correctly implemented). And, where possible, avoid ECB.  

<hr>

<strong>Expanded explanation for how resident properties propagate into ciphertext with ECB</strong>  

When writing this answer, I tried to not post a picture of the typical ECB-encrypted linux penguin, but I've been asked to expand on "resident properties in the plaintext" so what follows will be the same idea, just in text form. If you don't need it, feel free to skip.  

Firstly, let's use a format I know something about - <a href="http://www.mp3-tech.org/programmer/frame_header.html" rel="noreferrer">the mp3 frame</a>. Like most plaintext this is far from "indistinguishable from random" - indeed for example, the MP3 frame header begins with 11 bits set to 1.  

There are two important properties of block ciphers:  

<ul>
<li>On a block level, operations are deterministic. If I encrypt "Cryptography Stack Exchange" and this fits in a single block, I expect to get the same output for given parameters every time. This sounds like a crazy critera (of course we need this) but it's worth highlighting.</li>
<li>On a block level, the output is indistinguishable from random - more formally there's no advantage for an attacker over using a random permutation, at least in a way that is realistically computable. My terminology might be a bit off because I am self taught, but I believe if the advantage is non-zero you've got a bias and this makes the cipher a candidate for linear cryptanalysis.</li>
</ul>

These statements apply considering only a single block; however obviously in the real world we want more than that - we want to encrypt multiple blocks.  

Suppose we live in an imaginary world where people think block ciphers with a block size of one byte are a good idea. Now let's imagine this is otherwise a totally fine block cipher. Now imagine you have some MP3s of Justin Bieber music and you'd very much like the NSA not to find out about this. So you take your block cipher and you encrypt your MP3.  

Now, one of those blocks, making some assumptions about file alignment, is going to be `0xFF` - that's 8 of your 11 ones from the frame header in the MP3. These are always there at the beginning of each frame. Now our cipher is indistinguishable from random so we get perfectly random ciphertext, say `0x1c`. But it is also deterministic and we're using ECB, so every frame header that was `0xFF` becomes `0x1c`.  

All of a sudden we're giving away information to our attacker - specifically they can deduce where the frame headers are if they suspect this to be an MP3. Cryptanalysis is sometimes about guessing correctly and a correct guess in this case will give them an idea of exactly how long the audio samples are and allow them to identify the format.  

Moreover, every other ciphertext block `0x1c` is now decodable too. That's not information we intended to give away, but we did.  

This problem is common particularly when you consider much of what we encrypt has a rigid data format. You have to make some assumptions about alignment on the blocks, but the larger the data the more this problem becomes apparent.  

This is what I mean by residual plaintext properties becoming evident in the ciphertext. These are the structure inherent to and wanted in the plaintext that inadvertedly become exposed to the attacker.  

The original purpose of CBC mode <a href="https://www.google.com/patents/US4074066" rel="noreferrer">was as a form of identifying corrupt messages</a> and the security of CBC for this purpose is treated <a href="http://web.cs.ucdavis.edu/~rogaway/papers/sym-enc.pdf" rel="noreferrer">in this paper</a>. I can't find the original realization of this idea in terms of papers, but you might be able to find it. Certainly most books on block ciphers that I have read mention it and other issues.  

#### Answer 2 (score 21)
ECB and CBC are only about encryption. Most situations which call for encryption also need, at some point, integrity checks (ignoring the threat of <em>active</em> attackers is a common mistake). There are combined modes which do encryption <em>and</em> integrity simultaneously; see <a href="http://en.wikipedia.org/wiki/EAX_mode">EAX</a> and <a href="http://en.wikipedia.org/wiki/Galois/Counter_Mode">GCM</a> (see also <a href="http://en.wikipedia.org/wiki/OCB_mode">OCB</a>, but this one has a few lingering patent issues; assuming that software patents apply at all to your situation -- a non-trivial question --, then there are some explicit <a href="http://www.cs.ucdavis.edu/~rogaway/ocb/license.htm">licenses</a>).  

#### Answer 3 (score 18)
Never use ECB!  It is insecure.  

I recommend an authenticated encryption mode, like EAX or GCM.  If you can't use authenticated encryption, use CBC or CTR mode encryption, and then apply a MAC (e.g., AES-CMAC or SHA1-HMAC) to the resulting ciphertext.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: What is the difference between PKCS#5 padding and PKCS#7 padding (score [102297](https://stackoverflow.com/q/9043) in )

#### Question
One runtime platform provides an API that supplies PKCS#5 padding for block cipher modes such as ECB and CBC. These modes have been defined for the triple DES, AES and Blowfish block ciphers. The other platform API only provides PKCS#7 padding.  

Are PKCS#5 padding and PKCS#7 padding compatible?  

#### Answer accepted (score 98)
The difference between the PKCS#5 and PKCS#7 <a href="http://en.wikipedia.org/wiki/Padding_%28cryptography%29" rel="noreferrer">padding mechanisms</a> is the block size; PKCS#5 padding is defined for 8-byte block sizes, PKCS#7 padding would work for any block size from 1 to 255 bytes.  

This is the definition of <a href="https://www.ietf.org/rfc/rfc2898.txt" rel="noreferrer">PKCS#5</a> padding (6.2) as defined in the RFC:  

<blockquote>
  <p>The padding string PS shall consist of 8 - (||M|| mod 8) octets all
  having value 8 - (||M|| mod 8).</p>
</blockquote>

The RFC that contains the <a href="https://www.ietf.org/rfc/rfc2315.txt" rel="noreferrer">PKCS#7</a> standard is the same except that it allows block sizes up to 255 bytes in size (10.3 note 2):  

<blockquote>
  <p>For such algorithms, the method shall be to pad the input at the
  trailing end with k - (l mod k) octets all having value k -
  (l mod k), where l is the length of the input.</p>
</blockquote>

So fundamentally PKCS#5 padding is a subset of PKCS#7 padding for 8 byte block sizes. Hence, PKCS#5 padding can not be used for AES. PKCS#5 padding was only defined with (triple) DES operation in mind.   

Many cryptographic libraries use an identifier indicating PKCS#5 or PKCS#7 to define the same padding mechanism. The identifier <em>should</em> indicate PKCS#7 if block sizes other than 8 are used within the calculation. Some cryptographic libraries such as the <a href="http://docs.oracle.com/javase/7/docs/technotes/guides/security/StandardNames.html#Cipher" rel="noreferrer">SUN provider in Java</a> indicate PKCS#5 where PKCS#7 should be used - `"PKCS5Padding"` should have been `"PKCS7Padding"`. This is a legacy from the time that only 8 byte block ciphers such as (triple) DES symmetric cipher were available.  

Note that neither PKCS#5 nor PKCS#7 is a standard created to describe a padding mechanism. The padding part is only a small subset of the defined functionality. PKCS#5 is a standard for Password Based Encryption or PBE, and PKCS#7 defines the Cryptographic Message Syntax or CMS. In that sense you could say that ECB and CBC mode can use <em>PKCS#5 or PKCS#7 compatible</em> padding.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Why is elliptic curve cryptography not widely used, compared to RSA? (score [100610](https://stackoverflow.com/q/1190) in 2012)

#### Question
I recently ran across elliptic curve crypto-systems:  

<ul>
<li><a href="http://www.math.brown.edu/~jhs/Presentations/WyomingEllipticCurve.pdf">An Introduction to the Theory of Elliptic Curves</a> (Brown University)</li>
<li><a href="http://en.wikipedia.org/wiki/Elliptic_curve_cryptography">Elliptic Curve Cryptography</a> (Wikipedia)</li>
<li><a href="http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&amp;arnumber=4493606&amp;isnumber=4493499">Performance analysis of identity management in the Session Initiation Protocol (SIP)</a> (IEEE)</li>
<li><a href="http://www.rsa.com/rsalabs/node.asp?id=2013">Overview of Elliptic Curve Cryptosystems.</a> (RSA.com)</li>
</ul>

It seemed to me to be great alternative to RSA as the de-facto cryptosystems to be used in banking and financial systems and in the public key infrastructure for certificates, but is not used! If someone can explain why this is not done, it would be very helpful. A comparison between traditional RSA and an elliptic curve cryptology would be helpful.  

To begin with:  

Advantage of RSA:  

<ol>
<li>Well established.</li>
</ol>

Advantages of elliptic curve:  

<ol>
<li>Shorter keys are as strong as long key for RSA (see the IEEE paper)</li>
<li>Low on CPU consumption.</li>
<li>Low on memory usage.</li>
</ol>

#### Answer accepted (score 134)
RSA was there first. That's actually enough for explaining its preeminence. RSA was first published in 1978 and the <a href="https://web.archive.org/web/20130731100315/http://www.rsa.com/rsalabs/node.asp?id=2125" rel="noreferrer">PKCS#1</a> standard (which explains exactly how RSA should be used, with unambiguous specification of which byte goes where) has been publicly and freely available since 1993. The idea of using elliptic curves for cryptography came to be in 1985, and relevant standards have existed since the late 1990s. Also, both RSA and elliptic curves have been covered by patents, but the RSA patents have expired in 2000, while some elliptic curve patents are <a href="http://en.wikipedia.org/wiki/ECC_patents" rel="noreferrer">still alive</a>.  

One perceived, historical advantage of RSA is that RSA is <em>two</em> algorithms, one for encryption and one for signatures, that could both use the same key and the same core implementation. But this is not a real advantage because it is usually a <a href="https://security.stackexchange.com/questions/8559/digital-certificate-deployment-using-two-certs-for-each-user/8563#8563">bad idea</a> to use the same key for both encryption and signatures. Also, you can mathematically use the same private key for <a href="http://en.wikipedia.org/wiki/Elliptic_curve_Diffie%E2%80%93Hellman" rel="noreferrer">ECDH</a> (key exchange) and for <a href="http://en.wikipedia.org/wiki/Elliptic_Curve_DSA" rel="noreferrer">ECDSA</a> (signatures), so that's really not an "advantage" of RSA over EC at all.  

Another advantage of RSA is that its mathematics are somewhat simpler than those involved for elliptic curves, so many engineers feel that they "understand" RSA more than elliptic curves; again, a fallacious argument, since <em>implementation</em> of cryptographic algorithms is fraught with subtle details and best left to professionals -- and there is no need to understand the internal mathematics of a library to simply use it (we could make this argument semi-valid by pointing out that RSA relies on the hardness of factorization, which has been studied for 2500 years, whereas discrete logarithm on elliptic curves can only sport about 25 years of research).  

The only scientifically established advantaged of RSA over elliptic curves cryptography is that public key operations (e.g. signature <em>verification</em>, as opposed to signature generation) are faster with RSA. But public-key operations are rarely a bottleneck, and we are talking about 8000 ECDSA verifications per second, vs 20000 RSA verifications per second.  

An additional interoperability issue is that elliptic-curve operations can be made over curves of distinct types, and can be widely optimized if you stick to a specific curve known when the code was written. There is no security issue in using the same curve for many distinct people with distinct key pairs. But it means that most implementations will only support two or three specific curves. NIST has defined <a href="http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-4.pdf" rel="noreferrer">15 standard curves</a>. However, in practice, many implementations only support two of them, P-256 and P-384, because that's what is recommended by NSA (under the name "suite B")(a notorious example is NSS, the cryptography library used by the Firefox Web browser for SSL).  

There are two ANSI standards for elliptic curves, <a href="http://webstore.ansi.org/RecordDetail.aspx?sku=ANSI%20X9.62:2005" rel="noreferrer">X9.62</a> for signatures (partially redundant with FIPS 186-3, but much more detailed), and <a href="http://webstore.ansi.org/RecordDetail.aspx?sku=ANSI%20X9.63:2001" rel="noreferrer">X9.63</a> for asymmetric encryption.  

So there is a lot of political push for the adoption of elliptic curves in cryptography, by both academic researchers and institutional organizations. But inertia of the firmly entrenched RSA will take time to defeat. Also, the perceived mathematical complexity, and the potential legal risks related to patents, still hinder wide acceptance of elliptic curves.  

(To your list, you can add "key generation time": generating a new key pair for ECDH or ECDSA is widely faster than generating a new RSA key pair.)  

#### Answer 2 (score 37)
This is mostly a supplement to <a href="https://crypto.stackexchange.com/a/1194/12164">@ThomasPornin's answer</a>, not a complete answer on its own (but too long to fit in a comment).  

ECC uses a finite field, so even though elliptical curves themselves are relatively new, most of the math involved in taking a discrete logarithm over the field is much older. In fact, most of the algorithms used are relatively minor variants of factoring algorithms.  

The real question (and one that's still open, AFAIK) is whether discrete logarithms over an elliptical curve have the same "smoothness" property as you use in the sieve-based algorithms for factoring the product of large primes. If elliptical curves aren't "smooth" (and quite a few mathematicians seem convinced they're not) then the sieve-style factoring algorithms <em>can't</em> be adapted to taking discrete logarithms over elliptical curves. If they <em>are</em> smooth (and a fair number of other mathematicians seem convinced this is likely to be true), however, the sieve-style algorithms <em>could</em> be adapted. This would be a significant "break" against ECC -- you'd need to increase key sizes substantially to maintain security (probably not to <em>quite</em> as large as RSA for equivalent security, but fairly close).  

What this all comes down to is one thing: it's not nearly so clear-cut a difference as 2500 years vs. a few decades. If anything, almost the opposite is actually true: variants of most of the <em>older</em> factoring algorithms can be used to find discrete logarithms over elliptical curves. What does <em>not</em> apply (at least based on present knowledge) to elliptical curves is the research of the last few decades or so into sieve-based algorithms.  

As far as the patent situation goes, I think the situation is much more clear than @poncho implies. Yes, Certicom holds some patents (120 currently, though not all of them are on ECC), but what is or isn't covered by those patents has been quite clear for years. Their patents cover some specific ways to optimize ECC, but definitely do <em>not</em> cover ECC itself. In fact, the patents themselves have a "Field of the Invention" (or, in some, "Background of the invention") section that tells you about what was known before the patent, and these have a fairly complete explanation of how to use ECC for both encryption and signatures. For example,  see US Patent Number <a href="http://www.google.com/patents?as_q=patent:6141420" rel="noreferrer">6,141,420</a>, which has quite a decent explanation of the math involved in elliptical curves, <em>and</em> how to implement ElGamal with elliptical curves -- all in the description of what was known prior to the patent.  

#### Answer 3 (score 22)
Part of the reason is trust; RSA has been around longer than EC, and people feel they understand it, and they trust it more (and in security, this is important).  It's also easier to implement.  

However, I believe that a bigger concern (at least for major companies) is the fear of being sued; there's a small company called Certicom that holds a number of EC-related patents, and has threatened to sue anyone who might infringe on their patents (and, of course, without there being any clear definition of what those patents actually cover).  They have sued Sony (and eventually settled out of court).  

The bottom line: for quite a while, it was just easier for companies to stick with RSA/DH, rather then either pay Certicom or take the legal risk.  

Lately, things have shifted; people have figured out they can implement EC using things that can be documented to predate the Certicom patents (and hence are immune to lawsuit); it appears that more common use of Elliptic Curves is not that far away.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: What is the main difference between a key, an IV and a nonce? (score [95878](https://stackoverflow.com/q/3965) in 2015)

#### Question
What are the main differences between a nonce, a key and an IV? Without any doubt the key should be kept secret. But what about the nonce and the IV? What's the main difference between them and their purposes? Is it only that, in literature and in practice, an IV is being used as "initiator" of a block cipher encryption mode which <em>should</em> be unique? And the same property should hold for a nonce as well, but since it doesn't instantiate something we call it a nonce? I.e: in AES-CTR mode the IV is a nonce+counter. And both are put in plaintext format in the beginning of the ciphertext.  

#### Answer accepted (score 129)
A <a href="https://en.wikipedia.org/wiki/Key_(cryptography)" rel="noreferrer"><strong>key</strong></a>, in the context of <a href="https://en.wikipedia.org/wiki/Symmetric-key_algorithm" rel="noreferrer">symmetric cryptography</a>, is something you keep secret.  Anyone who knows your key (or can guess it) can decrypt any data you've encrypted with it (or forge any authentication codes you've calculated with it, etc.).  

(There's also "asymmetric" or <a href="https://en.wikipedia.org/wiki/Public-key_encryption" rel="noreferrer">public key cryptography</a>, where the key effectively has two parts: the private key, which allows decryption and/or signing, and a public key (derived from the corresponding private key) which allows encryption and/or signature verification.)  

An <a href="https://en.wikipedia.org/wiki/Initialization_vector" rel="noreferrer"><strong>IV</strong></a> or initialization vector is, in its broadest sense, just the initial value used to start some iterated process.  The term is used in a couple of different contexts, and implies different security requirements in each of them.  For example, <a href="https://en.wikipedia.org/wiki/Cryptographic_hash_function" rel="noreferrer">cryptographic hash functions</a> typically have a fixed IV, which is just an arbitrary constant which is included in the hash function specification and is used as the initial hash value before any data is fed in:  

<a href="https://en.wikipedia.org/w/index.php?title=File:Merkle-Damgard_hash_big.svg" rel="noreferrer"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Merkle-Damgard_hash_big.svg/400px-Merkle-Damgard_hash_big.svg.png" alt="Diagram of a Merkle-Damgård hash function from Wikipedia"></a>  

Conversely, most <a href="https://en.wikipedia.org/wiki/Block_cipher_modes_of_operation" rel="noreferrer">block cipher modes of operation</a> require an IV which is random and unpredictable, or at least unique for each message encrypted with a given key.  (Of course, <em>if</em> each key is only ever used to encrypt a single message, one can get away with using a fixed IV.)  This random IV ensures that each message encrypts differently, such that seeing multiple messages encrypted with the same key doesn't give the attacker any more information than just seeing a single long message.  In particular, it ensures that encrypting the <em>same</em> message twice yields two completely different ciphertexts, which is necessary in order for the encryption scheme to be <a href="https://en.wikipedia.org/wiki/Semantic_security" rel="noreferrer">semantically secure</a>.  

In any case, the IV never needs to be kept secret &mdash; if it did, it would be a key, not an IV.  Indeed, in most cases, keeping the IV secret would not be practical even if you wanted to, since the recipient needs to know it in order to decrypt the data (or verify the hash, etc.).  

<p>A <a href="https://en.wikipedia.org/wiki/Cryptographic_nonce" rel="noreferrer"><strong>nonce</strong></a>, in the broad sense, is just "a number used only once".  The only thing generally demanded of a nonce is that it should never be used twice (within the relevant scope, such as encryption with a particular key).
The unique IVs used for block cipher encryption qualify as nonces, but various other cryptographic schemes make use of nonces as well.</p>

There's some variation about which of the terms "IV" and "nonce" is used for different block cipher modes of operation: some authors use exclusively one or the other, while some make a distinction between them.  For CTR mode, in particular, some authors reserve the term "IV" for the full cipher input block formed by the concatenation of the nonce and the initial counter value (usually a block of all zero bits), while others prefer not to use the term "IV" for CTR mode at all.  This is all complicated by the fact that there are several variations on how the nonce/IV sent with the message in CTR mode is actually mapped into the initial block cipher input.  

Conversely, for modes other than CTR (or related modes such as EAX or GCM), the term "IV" is almost universally preferred over "nonce".  This is particularly true for CBC mode, since it has requirements on its IV (specifically, that they be unpredictable) which go beyond the usual requirement of uniqueness expected of nonces.  

#### Answer 2 (score 18)
The three terms (key, IV, nonce) you mentioned, and another, the salt, basically describe random numbers and each term is used in another context. The key is used as input for a cryptographic primitive and should be kept secret.  

A nonce is a random number only used once and for a short time with the intention to get replaced by or converted into something better. A initialization vector is also used as input for a cryptographic primitive to achieve randomization of normally deterministic primitives. Stream ciphers are called <em>stateful</em> where the same key is used for many states and the nonces are used to ensure different key streams. For this reason, we use IVs for the modes of operations of block ciphers but nonces for stream ciphers. This is a little bit confusing when we talk about AES-CTR because we use the term IV for the block cipher and the term nonce+counter for the state of the stream cipher.  

For the sake of completeness, a salt is also some kind of initialization vector for one-way functions but with the goal to achieve additional entropy for low-entropy inputs, e.g. password hashing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: Possible ways to crack simple hand ciphers? (score [89189](https://stackoverflow.com/q/3826) in 2017)

#### Question
We had a quiz in class today where we had to break the ciphertext with the key given, but not the algorithm. Suffice to say that I wasn't able to decrypt it within the allotted time of 12 mins and will probably get a 0% score on the quiz.  

So, I was just wondering if there are some kind of standard techniques that are followed when decrypting a simple substitution ciphertext.  

#### Answer accepted (score 27)
When trying to break an unknown cipher, one first needs to figure out what kind of cipher one it is.  Generally, a good starting point would be to start with the most common and well known <a href="http://en.wikipedia.org/wiki/Classical_cipher">classical ciphers</a>, eliminate those that obviously don't fit, and try the remaining ones to see if any of them might work.  

An obvious first step is to look at the ciphertext alphabet: does the ciphertext consist of letters (and if so, in what alphabet), numbers, abstract symbols or some combination of those?  If it's letters, does it include spaces, punctuation or case distinctions &mdash; and, if it does, do they look like they're also scrambled somehow, or are they perhaps just left as they are in the plaintext?  

Compiling a letter (or symbol) frequency table of the ciphertext, and comparing it to the corresponding table of plain English text, can often yield information about the general type of cipher one is dealing with:  

<ul>
<li><p>If the ciphertext is written in letters, and their frequencies more or less match <a href="http://en.wikipedia.org/wiki/Letter_frequency#Relative_frequencies_of_letters_in_the_English_language">those of plain English text</a> (the nonsense phrase <a href="http://en.wikipedia.org/wiki/ETAOIN_SHRDLU">ETAOIN SHRDLU</a> is handy to remember for this), you're probably dealing with a <a href="http://en.wikipedia.org/wiki/Transposition_cipher">transposition cipher</a>.  (If the most frequent letters don't quite match, but still look plausible for natural text &mdash; mostly vowels and a few simple consonants &mdash; it might be a transposition of text in some other language.)</p></li>
<li><p>If the rank&ndash;frequency distribution looks <a href="http://en.wikipedia.org/wiki/File%3aEnglish_letter_frequency_%28frequency%29.svg">similar to that for plain English</a>, but the letters are obviously scrambled (e.g. most frequent letters are `G`, `X` and `Q` instead of `E`, `T` and `A`), the cipher is likely to be a <a href="http://en.wikipedia.org/wiki/Substitution_cipher#Simple_substitution">monoalphabetic substitution</a> (possibly combined with transposition).</p></li>
<li><p>If the frequency distribution is closer to uniform than one would expect for natural language, you're probably looking at a <a href="http://en.wikipedia.org/wiki/Polyalphabetic_cipher">polyalphabetic substitution</a> cipher.  With experience (and enough ciphertext), one may even be able to guess at the most likely cipher just based on the frequency distribution.</p></li>
</ul>

Knowing whether the cipher has a key or not, and what form the key takes (word, number, sequence of numbers, etc.) can also help reduce the range of possibilities.  For example, let's say that the ciphertext is uppercase letters with no spaces or punctuation, and that we know it has a key which is a word or a short phrase.  That narrows down the likely choices quite a bit:  

<ul>
<li><p>If it's a transposition cipher, the obvious thing to try would be <a href="http://en.wikipedia.org/wiki/Transposition_cipher#Columnar_transposition">columnar transposition</a> and its variants like double transposition.</p></li>
<li><p>If it's a monoalphabetic substitution and has a keyword, the <a href="http://en.wikipedia.org/wiki/Keyword_cipher">keyword cipher</a> described by mikeazo in his answer is the obvious choice.</p></li>
<li><p>If it's a polyalphabetic substitution, there are more choices.  The first ciphers I'd try would be <a href="http://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher">Vigenère</a>, <a href="http://en.wikipedia.org/wiki/Autokey_cipher">autokey</a> and <a href="http://en.wikipedia.org/wiki/Playfair_cipher">Playfair</a>; if those don't work out, <a href="http://en.wikipedia.org/wiki/Beaufort_cipher">Beaufort</a>, <a href="http://en.wikipedia.org/wiki/Two-square_cipher">two-square</a> and <a href="http://en.wikipedia.org/wiki/Four-square_cipher">four-square</a> may be worth trying too.</p></li>
</ul>

Since you already know what the key is supposed to be, testing each cipher should be pretty straightforward: just try to decrypt the message with the key and see if the output makes sense.  

Note that, in some cases, effort can be shared between ciphers.  For example, the Vigenère and autokey ciphers are identical for the beginning of the message; they only start to behave differently when the end of the keyword is reached.  It may also be a good idea to try simple variants of these ciphers, such as switching the encryption and decryption rules around; some of them work equally well in both directions, and may have been used so.  

#### Answer 2 (score 8)
If it is a simple substitution cipher, there are a few standard techniques:  

<ul>
<li><p><strong>Frequency analysis.</strong>  Count how many times each letter appears in the ciphertext.  The most common ciphertext-letters probably correspond to the most-common letters in English.  The most common letters in English are ETAOINSHRDLU... (in decreasing order of prevalence).  Therefore, the letter that appears most frequently in the ciphertext is probably E, T, A, or O, etc., in decreasing order of likelihood.</p>

Using this information, you can make some tentative guesses, and see if any words seem to start to form.  

If you know how the words are broken up (if the inter-word spaces remain in the ciphertext), you can also do frequency analysis of letters at the end of a word.  Here are the most common letters that appear at the end of a word: ETSDNRY.  

You can also do frequency analysis of pairs of letters (digraphs).  However, this tends to be harder to take advantage of by hand.  Here are some common digraphs (letter pairings): TH, HE, AT, ST, AN, IN, EA, ND, ER, EN, RE, NT, TO, ES, ON, ED, IS, TI.  Here are some letters that are often doubled: LL, TT, SS, EE, PP, OO, RR, FF, CC, DD, NN.  Therefore, if you see a single letter in the ciphertext that appears twice next to each other, it is likely to be one of those.  </li>
<li><p><strong>Crib-dragging.</strong> If you have some idea of a word that you suspect appears in the message, look for any spot where it could possibly match up.  That will give you the mapping for all of the letters in the word.  Try applying that mapping to the rest of the ciphertext, and check to see if you get something that seems to start looking right.</p>

Crib-dragging works best when you have some domain knowledge about the likely content of the message.  However, if you know nothing, you can try matching against the most common words in English.  Here are some of the most common words in English: THE, OF, ARE, I, AND, YOU, A, CAN, TO, HE, HER, THAT, IN, WAS, IS, HAS, IT, HIM, HIS.  </li>
</ul>

#### Answer 3 (score 7)
A substitution cipher consist of a mapping from letters in the alphabet to letters in the alphabet (not necessarily the same alphabet, but probably is in this case). There are many forms that a key can take on. Ones I've seen in practice are:  

<ol>
<li><p>The key is the mapping (i.e. `a->m, b->x, c->q,...`). </p></li>
<li><p>The key represents a shift. A key of `5` would mean the transformation of `a->f, b->g,..., z->e`.</p></li>
<li><p>The key is a word which is used to generate the map. This is often done by writing the alphabet out. Then below, write the key (removing repeated letters), then write the rest of the alphabet, removing letters that are in the key. For example:  </p></li>
</ol>

<p>`abcdefghijklmnopqrstuvwxyz`<br>
`paswordbcefghijklmnqtuvxyz`</p>

You then substitute by finding the letter in the first row and going down the the second row.  

Since you were given the key, chances are you had to use one of these methods (or possibly another) to come up with the mapping.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: Can you help me understand what a cryptographic "salt" is? (score [86841](https://stackoverflow.com/q/1776) in 2013)

#### Question
I'm a beginner to cryptography and looking to understand in very simple terms what a cryptographic <em>"salt"</em> is, when I might need to use it, and why I should or should not use it. Can anyone offer me a very simple and clear (beginner level) explanation please?  

If you know of any references on the topic, those would also be useful in addition to your explanation.   

#### Answer accepted (score 159)
The reason that salts are used is that people tend to choose the same passwords, and not at all randomly. Many used passwords out there are short real words, to make it easy to remember, but this also enables for an attack.  

As you may know, passwords are generally not stored in cleartext, but rather hashed. If you are unsure of the purpose of a hash-function, please read up on that first.  

Now, what the attackers can do is to simply generate a list of common passwords and their corresponding hashes. Comparing the hashes that a site has stored with the table will, if common passwords are being used, reveal the passwords to the attacker.  

A <strong>salt</strong> is simply added to <strong>make a password hash output unique</strong> <em>even for users adopting common passwords</em>. Its purpose is to make pre-computation based attacks unhelpful. If your password is stored with a unique salt then any pre-computed password-hash table targeting unsalted password hashes or targeting an account with a different salt will not aid in cracking your account's password. A long randomly generated salt (using `/dev/urandom`) is expected to be <strong>globally unique</strong>. Thus salts can be used to make pre-computation attacks totally ineffective.  

The simplest way to combine the salt and the password is to simply concatenate them, i.e. the stored hash value is `Hash(salt||password)`. The common password `password1` now magically becomes, e.g., `6$dK,3gCA%Jpassword1` which is unlikely to be found in a password cracker's table.  

The salt can be stored completely in the clear in the database, next to the hashed value. Once the attacker has the database and wants to find the passwords, he needs to generate the pre-calculated table for each salt individually, a costly operation.  

Another way to help defend against offline password cracking is to perform password stretching, ie. making a password hash slower to compute for any person, including the log-in service and password crackers. One method used to stretch passwords is achieved by iterating the hash-function many times, i.e. storing `Hash(Hash(Hash(Hash…(Hash(salt||password)))…)`.   

Another common idea related to salting is called a <strong>pepper</strong>. That is, another random value concatenated to the password, such that the stored value is `Hash(pepper||salt||password)`. The pepper is then <strong>not stored at all</strong>. Both the login server and password cracker need to brute force the unknown pepper value, slowing password hash comparisons for both parties.  

From 2013 to 2015 a <a href="https://password-hashing.net/" rel="noreferrer">password hashing competition</a> was held to search for a better password-stretching algorithm. The winner was the <strong>Argon2</strong> algorithm. Programmers are recommended to use Argon2 <strong>instead of implementing their own algorithm</strong>.  

#### Answer 2 (score 17)
<blockquote>
  Can you help me understand what a cryptographic “salt” is?  
</blockquote>

In the context of password creation, a "salt" is data (random or otherwise) added to a hash function in order to make the hashed output of a password harder to crack.  

<blockquote>
  When might I need to use it?  
</blockquote>

Always.  

<blockquote>
  Why should or should I not use it?  
</blockquote>

You should always use a salt value with your hash functions, for reasons explained below.  

It is generally true people choose weak passwords, and it is certainly true there are gigabytes of <a href="https://crackstation.net" rel="nofollow noreferrer">publicly available rainbow tables</a> chock-full of hashed values representing them. So when somebody creates an account on your service and selects a password to secure their identity, you can typically bet the password they choose will be 1) common, 2) unsecure and 3) available for cross-reference in lookup tables.  

For example, the password <strong>Nowayin1</strong> when hashed via MD5 is <strong>6f367d65bc74b88e21fb9959487ffa3a</strong> and is obviously not a good choice. Even if it may look okay (and it doesn't), the fact the password's MD5 hash appears in open databases makes it worthless.  

But that's just 128-bit MD5. What about something stronger, like SHA1 (160-bit) or even Whirlpool (512-bit)?  

Same problem.  

For example, <strong>P@$$word</strong> with SHA1 is <strong>1e69e0a615e8cb813812ca797d75d4f08bdc2f56</strong> and <strong>1qazXSW@</strong> hashed with Whirlpool is <strong>0bf7545b784665d23b9c174ca03688a405f05b048e9d6c49bfc2721a1fa872bbd6576273d002e56d7c2a9c378efe607af36eea9d708a776e6f60ecb26e081cdf</strong>.  

The root issue with all of these passwords, and billions more like them, is the fact their commonly-used hashes have become common knowledge.  

A password <em>salt</em> changes that.  

If a random value (the salt) were added to the user's selected password, then the SHA1 hash <strong>1e69e0a615e8cb813812ca797d75d4f08bdc2f56</strong> would no longer reveal <strong>P@$$word</strong> as the user's password, because the hash value in the rainbow table would no longer match it.  

And it wouldn't take much. A small 16-bit random value, for example,  would yield 65,536 variants of each hashed value in the lookup tables. So a database of 15 billion entries would now need over 983 billion hashes in it to account for the salt.  

So, that's the point of salting your hashes, to thwart lookup and rainbow tables. But don't hang your hat on a salted hash, because hackers won't waste much time using rainbow tables to figure out your passwords.  

They'll use a <a href="http://www.webcitation.org/6Wb40sRBD" rel="nofollow noreferrer">five-server 25-GPU cluster system</a> running Hashcat that can burn through 350 billion guesses per second cracking hashes for every conceivable eight-character password containing upper- and lower-case letters, numbers and special characters, in just under six hours. (And that was back in 2012.)  

Techniques such as key-stretching that make hashes run slower can be used to offset the speed of such hardware, making dictionary and brute-force attacks too slow to be worthwhile, but hardware just keeps getting faster and faster.  

<strong>UPDATE 2018:</strong>  

Current best practices include securely hashing your passwords with <a href="https://www.argon2.com/" rel="nofollow noreferrer">Argon2i</a> (preferred over scrypt), a memory-hard function which is very <a href="https://password-hashing.net/submissions/specs/Argon-v3.pdf" rel="nofollow noreferrer">resilient</a> to FPGAs, multiplecore GPUs and dedicated ASIC modules used to easily crack non-stretched passphrases. In the <a href="https://secure.php.net/manual/en/function.password-hash.php" rel="nofollow noreferrer">PHP7</a> implementation of Argon2, the salt is handled internally for you.  

#### Answer 3 (score 7)
I'm going to attempt to answer a part of your question that has so far been neglected:  

<blockquote>
  when I might need to use it and why I should/should not use it.  
</blockquote>

The short answer is that, as an amateur, you should not be using cryptography at a level that requires dealing with salts directly.  

For instance, the `bcrypt` password hashing algorithm uses salts internally. But it doesn't expose that fact to developers using it — you simply pass the password to `bcrypt` (and optionally, a parameter that sets the "level of CPU effort" needed to generate the hash) and it returns the hash. When you need to validate if a password is correct, you pass `bcrypt` both the password and the previously-generated hash. It will indicate whether or not the password was the one used to generate the hash.  

Do <em>not</em> take the advice given here and try to hash your own passwords using a salt. It is a low-level implementation detail, and if you find yourself working at a level where these sorts of things are needed, you are working at far too low a level of abstraction. Cryptography is very difficult to do correctly, and the Internet is absolutely littered with well-intentioned developers' completely insecure home-grown password hashing schemes.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: RSA encryption with private key and decryption with a public key (score [85457](https://stackoverflow.com/q/2123) in 2014)

#### Question
When using the RSA cryptosystem, does it still work if you instead encrypt with the private key and decrypt with the public key? What about in the case of using RSA for sender authentication?  

#### Answer accepted (score 31)
Mathematically it work just fine. "Encrypt" with the private key, "decrypt" with the public key. Typically, however, we say <strong>sign</strong> with the private key and <strong>verify</strong> with the public key.  

As stated in the comments, it isn't just a straight forward signing of the message $m$. Typically a hash function and padding is involved. Also, often one has a <a href="https://stackoverflow.com/q/5133246">separate key pair for signing</a>.  

As you can see, there are a number of caveats, but in general you are correct, it is used for sender authentication.  

#### Answer 2 (score 23)
Asymmetric encryption and signing are entirely distinct concepts. The security and construction requirements are completely different. (Encryption for instance, needs to be an injection, whereas signature verification needs to be a surjection towards the verified message space. As a further hint of how they are intrinsically different, note that it lasted quite a bit of time before ID-based encryption could be designed, whereas ID-based signatures were there from the beginning.)  

To put it simply: there is no meaning for (understand definition for) the wording "encrypt with the private key". How would you do it?   

<p>By way of example, take the ElGamal encryption scheme: $s$ is your private key, $g^s$ your public key. To encrypt $m$, you draw a random $r$ and compute the ciphertext $(g^r,m*g^{r*s})$. Now, let's be practical: you've got this nice library implementing ElGamal. The API for encryption says the function takes two arguments: a message and a public key, that is a group element $g^s$ for some secret number $s$ and some group generator $g$. Now how do you "encrypt with the private key" $s$? You feed the function with $m$ and $s$? It does not comply with the API and it might even crash.
Then let's be theoretical: how do you sign with the ElGamal encryption?</p>

Eventually, this misconception probably arise from the specifics of the underlying mathematical structure of RSA (which has both signature and encryption variants, and where a private key of the same form can be used for decryption or signature, and the corresponding public key used for encryption of signature verification). But even there, a standard-compliant implementation will not allow you to "decrypt with the public key". Due to padding indeed, there is no way decryption will succeed. For the particular case of RSA, see also <a href="https://crypto.stackexchange.com/questions/2123">there</a>.  

<p>So if you need to sign, use the signing function of a signature scheme with a private key.
And if you need to encrypt, use the encryption function of an encryption scheme with a public key. After all, that's what they were designed for.</p>

#### Answer 3 (score 20)
The two keys $(e,m)$ and $(d,m)$ in the RSA key pair are fully equivalent, in that $e$ and $d$ can be arbitrarily chosen integers (in the interval $0..m-1$) as long as they fulfill the well-known congruence $ed \equiv 1 \mod \phi(m)$. You can swap them and nothing will change.  

A key becomes `public` the moment you (as the key generator) decide to disclose it, possibly to attackers too. By consequence, the one you decide <strong>not</strong> to disclose becomes the `private` key.  

When you use the key pair for <strong>confidentiality</strong> purposes, you typically want everybody to be able to send confidential messages to a receiver, so that only such receiver can interpret them. In such case, everybody shares a key (which will be the `public` one by the definition above, used for <strong>encryption</strong>), whereas the receiver has got the one which is not shared with anybody else (which must be the `private` key, used for <strong>decryption</strong>).  

The idea of using the `public` key for decryption undermines the very purpose of having a scheme in place for confidentiality as defined above. Why should you do encryption at all if anybody (including the attacker) can undo it?  

If you are thinking "<em>Maybe I could securely distribute the public key only to the intended receiver</em>", then you are not disclosing any key at all, and the definition of `public` and `private` do not hold anymore: you use RSA as a sort of secret key cipher like AES.  

On the other hand, when you use the key pair for <strong>authentication</strong> purposes, you typically want everybody (including any forger) to be able to establish with certainty that a message really comes from a certain originator, and not from anybody else. In such case, everybody shares a key (which is again the `public` one, used for <strong>verification</strong>), whereas the originator has got the one which is not disclosed to anybody else (which must be the `private` key, used for <strong>signing</strong>).  

In the same way as before, using the `public` key for signing is contradictory.  

Finally, it should be noted that the `public` key (in either case) takes a special form (`3`, `65537`, etc). That is purely for efficiency purposes (since the key must be `public` anyway, why don't we pick one that is computationally easy to deal with?), and it is not related to security.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How is SHA1 different from MD5? (score [85248](https://stackoverflow.com/q/18612) in 2014)

#### Question
On the surface, SHA1 and MD5 look pretty similar. Their diagrams include chunks of bits, bit rotation, xor and special functions. Their implementations are roughly the same length (at least the ones I've seen). Yet it's widely known that MD5 is broken, but currently SHA1 isn't.  

Is the security difference from the increased rounds? SHA1 has 80 compared to MD5's 64. Or is it the greater digest size? SHA1 seems to be described as "more conservative", but I'm not sure what that means.  

#### Answer accepted (score 26)
MD5 and SHA-1 have a lot in common; SHA-1 was clearly inspired on either MD5 or MD4, or both (SHA-1 is a patched version of SHA-0, which was published in 1993, while MD5 was described as a RFC in 1992).  

The main structural differences are the following:  

<ul>
<li>SHA-1 has a larger state: 160 bits vs 128 bits.</li>
<li>SHA-1 has more rounds: 80 vs 64.</li>
<li>SHA-1 rounds have an extra bit rotation and the mixing of state words is slightly different (mostly to account for the fifth word).</li>
<li>Bitwise combination functions and round constants are different.</li>
<li>Bit rotation counts in SHA-1 are the same for all rounds, while in MD5 each round has its own rotation count.</li>
<li>The message words are pre-processed in SHA-0 and SHA-1. In MD5, each round uses one of the 16 message words "as is"; in SHA-0, the 16 message words are expanded into 80 derived words with a sort of word-wise linear feedback shift register. SHA-1 furthermore adds a bit rotation to these word derivation.</li>
</ul>

The extra bit rotation is what makes SHA-1 distinct from SHA-0; it also makes SHA-1 much stronger against collision attacks, and, indeed, SHA-0 collisions have been found (with effort <span class="math-container">$2^{39}$</span>, thus highly doable) while SHA-1 collisions are much more difficult.  

<strong>We don't have a true theory of what makes a hash function strong.</strong> However, we can still have some "gut feelings", and my own intestine tells me that in the case of MD-like functions (MD4, MD5, SHA-0, SHA-1, and the SHA-2 functions), the two important points are:  

<ul>
<li><p>Rotating bits a lot. Collision attacks based on differential paths try to induce small differences and keep them from propagating non-linearly everywhere; a useful tool for that is the lack of carry beyond the upper bits in word-wise additions (a difference in the upper bit in one of the operands of an addition modulo <span class="math-container">$2^{32}$</span> propagates to the output with probability <span class="math-container">$1$</span>; two such differences cancel each other reliably). The 1-bit rotation added in SHA-1 is effective at making differential paths harder to find.</p></li>
<li><p>Doing "enough work". If you count the number of elementary operations per input byte (which more or less translates to code size or speed, especially on GPU), you will see that SHA-1 is about 30% heavier than MD5, while SHA-256 is close to twice heavier than SHA-1. SHA-3 candidates were also, as a rule, "heavier" than SHA-1 (some could get faster by leveraging SIMD opcodes in CPU, but still had more operations per input byte).</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How much would it cost in U.S. dollars to brute force a 256 bit key in a year? (score [81982](https://stackoverflow.com/q/1145) in 2018)

#### Question
I am often told that any key can be broken and that it is only a matter of time and resources for any key to be broken. I know that this is technically true. However, I think that there is probably a point where it makes sense to say a key is uncrackable (for example, if it would cost 100 times the world GDP to crack it, it is essentially uncrackable without the help of an advanced alien civilization, etc.).  

How much would it cost in U.S. dollars to brute force a 256-bit key using a strong algorithm such as AES or Twofish in a year?  

I would also be curious to know what it would cost to crack a 128 bit key in a year.  

I am asking this mostly out of curiosity. I do not know very much about cryptography, so please feel free to pick the algorithm of your choice if that matters. I am interested in how one would project the cost (assume you have to buy the hardware but you get to choose what hardware you buy).  

#### Answer accepted (score 156)
The average cost of electricity in the US is <span class="math-container">$\$0.12$</span> per kWh. For a single server, I'll use <a href="http://www.vertatique.com/average-power-use-server" rel="noreferrer">3741 kWh annually</a> as an estimate. That would be about <span class="math-container">$\$450$</span> per year for one machine.   

Let's say you can do <span class="math-container">$10^{14}$</span> decryptions per second. That is <span class="math-container">$3.15\times 10^{21}$</span> decrypts per year for one machine. You need to do (on average) <span class="math-container">$2^{255}$</span> decryptions in a year, so you would need <span class="math-container">$\frac{2^{255}}{3.15\times 10^{21}} \approx 1.84\times 10^{55}$</span> machines. To figure your cost you would multiply that by <span class="math-container">$\$450$</span> and get about <span class="math-container">$\$8\times 10^{57}$</span> or 8 <a href="https://web.archive.org/web/20140104120058/http://www.jimloy.com/math/billion.htm" rel="noreferrer">octodecillion</a> dollars. Gross world product, or GWP, is about <span class="math-container">$63\times 10^{12}$</span>, so brute-forcing a 256-bit key would cost about <span class="math-container">$10^{44}$</span> times the GWP.  

You can follow similar math to get the cost of brute forcing a 128-bit key.  

<hr>

<strong>Note:</strong>  

I am completely ignoring hardware costs, maintenance, etc. The estimate above is for electricity only. We can take a hint from the NSA on this. You'd be a lot better off hiring a few thousand mathematicians and have them work on breaking the cipher as opposed to trying to brute-force it.  

#### Answer 2 (score 148)
There is some Thermodynamic Limitations. A good explanation about Thermodynamic Limitations is by Bruce Schneier in <a href="http://rads.stackoverflow.com/amzn/click/0471117099" rel="noreferrer">Applied Cryptography</a>:  

<blockquote>
  <p>One of the consequences of the second law of thermodynamics is that a
  certain amount of energy is necessary to represent information. To
  record a single bit by changing the state of a system requires an
  amount of energy no less than $kT$, where $T$ is the absolute temperature
  of the system and $k$ is the Boltzman constant. (Stick with me; the
  physics lesson is almost over.)  </p>
  
  <p>Given that $k =1.38 \cdot 10^{-16} \mathrm{erg}/{^\circ}\mathrm{Kelvin}$,
  and that the ambient temperature of the universe is $3.2{^\circ}\mathrm K$, an ideal
  computer running at $3.2{^\circ}\mathrm K$ would consume $4.4 \cdot 10^{-16}$ ergs every time it
  set or cleared a bit. To run a computer any colder than the cosmic
  background radiation would require extra energy to run a heat pump.  </p>
  
  <p>Now, the annual energy output of our sun is about $1.21 \cdot 10^{41}$ ergs. This
  is enough to power about
  $2.7 \cdot 10^{56}$ single bit changes on our ideal computer; enough state changes to put a 187-bit counter through all its values. <strong>If we built a
  Dyson sphere around the sun and captured all of its energy for 32
  years, without any loss, we could power a computer to count up to
  $2^{192}$.</strong> Of course, it wouldn’t have the energy left over to perform any useful calculations with this counter.   </p>
  
  <p>But that’s just one star, and a
  measly one at that. A typical supernova releases something like $10^{51}$
  ergs. (About a hundred times as much energy would be released in the
  form of neutrinos, but let them go for now.) If all of this energy
  could be channeled into a single orgy of computation, a 219-bit
  counter could be cycled through all of its states.  </p>
  
  <p>These numbers have
  nothing to do with the technology of the devices; they are the
  maximums that thermodynamics will allow. <strong>And they strongly imply that
  brute-force attacks against 256-bit keys will be infeasible until
  computers are built from something other than matter and occupy
  something other than space</strong>.</p>
</blockquote>

#### Answer 3 (score 113)
256-bit key cracking through exhaustive search is <a href="https://security.stackexchange.com/questions/6141/amount-of-simple-operations-that-is-safely-out-of-reach-for-all-humanity/6149#6149">totally out of reach of Mankind</a>. And it takes quite a lot of wishful thinking to even envision a 128-bit key cracking:  

<ul>
<li>trying one key must be reduced to the flip of a single logic gate (compared to the hundreds of thousands which are actually required);</li>
<li>that gate must be more energy-efficient than the most efficient logic gates currently in production;</li>
<li>all of the energy production on Earth must be diverted to that single key cracking goal.</li>
</ul>

Under these conditions (each of which is utterly unrealistic in its own way), a 128-bit key cracking effort could be imagined.  

But this is far beyond the point where the notion of "dollar" makes any sense. The dollar is a <a href="http://en.wikipedia.org/wiki/Currency" rel="noreferrer">currency</a>: a conventional representation of "values", that people give to each other under the assumption that they could convert it back to tangible objects or services as they wish. So there is no possible notion of the dollar when the sum far exceeds the total worth of what can ever be bought on Earth. The <a href="http://en.wikipedia.org/wiki/Gross_world_product" rel="noreferrer">Gross World Product</a> is, as of 2011, somewhere between 60 and 80 trillions of dollars: it depends a lot on what dollar you use as a basis and how you try to map <em>that</em> on "purchase power". The point is that there is no meaningful notion of dollar beyond about $8*10^{13}$.  

If you follow @mikeazo argument (450\$ of energy consumption per machine and per year, where one machine can try about $3.2*10^{21}$ keys per year), then the GWD, converted entirely in energy, would allow for $2.5*10^{35}$ keys to be tried, i.e. a space of 118 bits or so. A 128-bit key space is 1024 times <em>harder</em> than that. Also, this assumes that <em>everything</em> produced on Earth can be reduced to energy with the same efficiency than the most competitive coal plants, which is a bit optimistic because GWD includes a lot of things which are not energy-convertible, such as artistic creations: how exactly would you make electricity out of, say, a song ? Moreover, all the energy invested in the computation becomes, ultimately, heat, so there could be some climatic consequences, as in "the Earth is cooked".  

<hr>

<strong>To sum up:</strong> even if you use all the dollars in the World (including the dollars which do not exist, such as accumulated debts) and fry the whole planet in the process, you can barely do 1/1000th of an exhaustive key search on 128-bit keys. So this will not happen. And a 256-bit key search is about 340 billions of billions of billions of billions times harder than a 128-bit key search, so don't even think about it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Taking advantage of one-time pad key reuse? (score [79291](https://stackoverflow.com/q/59) in 2012)

#### Question
Suppose Alice wants to send encryptions (under a one-time pad) of $m_1$ and $m_2$ to Bob over a public channel.  Alice and Bob have a shared key $k$; however, both messages are the same length as the key $k$.  Since Alice is extraordinary lazy (and doesn't know about stream ciphers), she decides to just reuse the key.  

Alice sends ciphertexts $c_1 = m_1 \oplus k$ and $c_2 = m_2 \oplus k$ to Bob through a public channel.  Unfortunately, Eve intercepts both of these ciphertexts and calculates $c_1 \oplus c_2 = m_1 \oplus m_2$.  

<blockquote>
  What can Eve do with $m_1 \oplus m_2$?    
</blockquote>

Intuitively, it makes sense that Alice and Bob would not want $m_1 \oplus m_2$ to fall into Eve's hands, but how exactly should Eve continue with her attack?  

#### Answer 2 (score 126)
There is a great graphical representation (which I found on cryptosmith, but they keep changing their url structures, so I've added the graphics in here) of the possible problems that arise from reusing a one-time pad.   

Let's say you have the image  

<img src="https://i.stack.imgur.com/GGJpC.gif" alt="send cash image">  

and you encrypt it by using the binary one-time-pad (xor-ing on black and white)  

<img src="https://i.stack.imgur.com/HtXag.gif" alt="2">.  

You get the following extremely secure encryption  

<img src="https://i.stack.imgur.com/CqiLY.gif" alt="3">.  

If you then encrypt a smiley face with the same one-time-pad,  

<a href="https://i.stack.imgur.com/FR32c.png" rel="noreferrer"><img src="https://i.stack.imgur.com/FR32c.png" alt="enter image description here"></a>  

you get another secure encryption  

<img src="https://i.stack.imgur.com/a1tQa.gif" alt="5">.  

But if you have <em>both</em> and you xor them together  

<img src="https://i.stack.imgur.com/mTvmW.png" alt="6">  

then you get the image  

<img src="https://i.stack.imgur.com/0Fktn.gif" alt="7">  

which, as you can qualitatively and intuitively see is very insecure.  

Reusing the same key multiple times is called giving the encryption 'depth' - and it is intuitive that the more depth given, the more likely it is that information about the plaintext is contained within the encrypted text.  

The process of 'peeling away' layered texts has been studied, <a href="https://crypto.stackexchange.com/a/64/12164">as ir01 mentions</a>, and those methods improve with more layers.  

#### Answer 3 (score 32)
<p>There are two methods, named <strong><em>statistical analysis or <a href="http://en.wikipedia.org/wiki/Frequency_analysis">Frequency analysis</a></em></strong> and <strong><em>pattern matching</em></strong>.<br>
Note that in statistical analysis Eve should compute frequencies for $aLetter \oplus aLetter$ using some tool like <a href="http://robert-lerner.com/live-letter-frequency-analysis.php">this</a>. A real historical example using <a href="http://www.characterfrequencyanalyzer.com/english/index.php">frequency analysis</a> is the <a href="http://en.wikipedia.org/wiki/Venona_project">VENONA project</a>.  </p>

<p>EDIT: Having statistical analysis of $aLetter \oplus aLetter$ like <a href="http://www.data-compression.com/english.html">this</a> says:<br>
If a character has distribution $X$, the two characters behind $c_1 \oplus c_2$ with probability $P$ are $c_1$, $c_2$. </p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: What are the differences between a digital signature, a MAC and a hash? (score [77115](https://stackoverflow.com/q/5646) in 2012)

#### Question
A message may be accompanied with a <strong>digital signature</strong>, a <strong>MAC</strong> or a message <strong>hash</strong>, as a proof of some kind.  

Which assurances does each primitive provide to the recipient?  

What kind of keys are needed?  

#### Answer accepted (score 187)
These types of cryptographic primitive can be distinguished by the security goals they fulfill (in the simple protocol of "appending to a message"):  

<ul>
<li><p><strong>Integrity:</strong> Can the recipient be confident that the message has not been accidentally modified?</p></li>
<li><p><strong>Authentication:</strong> Can the recipient be confident that the message originates from the sender?</p></li>
<li><p><strong>Non-repudiation:</strong> If the recipient passes the message and the proof to a third party, can the third party be confident that the message originated from the sender? (Please note that I am talking about non-repudiation in the cryptographic sense, <a href="https://security.stackexchange.com/a/6108/15712">not in the legal sense</a>.)</p></li>
</ul>

Also important is this question:  

<ul>
<li><strong>Keys:</strong> Does the primitive require a shared secret key, or public-private keypairs?</li>
</ul>

I think the <strong>short answer</strong> is best explained with a table:  

```cryptography
Cryptographic primitive | Hash |    MAC    | Digital
Security Goal           |      |           | signature
------------------------+------+-----------+-------------
Integrity               |  Yes |    Yes    |   Yes
Authentication          |  No  |    Yes    |   Yes
Non-repudiation         |  No  |    No     |   Yes
------------------------+------+-----------+-------------
Kind of keys            | none | symmetric | asymmetric
                        |      |    keys   |    keys
```

Please remember that authentication without confidence in the keys used is useless. For digital signatures, a recipient must be confident that the verification key actually belongs to the sender. For MACs, a recipient must be confident that the shared symmetric key has only been shared with the sender.  

<strong>The longer answer:</strong>  

A (unkeyed) <strong>hash of the message</strong>, if appended to the message itself, only protects against accidental changes to the message (or the hash itself), as an attacker who modifies the message can simply calculate a new hash and use it instead of the original one. So this only gives <em>integrity</em>.  

<sup>If the hash is transmitted over a different, protected channel, it can also protect the message against modifications. This is sometimes be used with hashes of very big files (like ISO-images), where the hash itself is delivered over HTTPS, while the big file can be transmitted over an insecure channel.</sup>  

A <strong>message authentication code</strong> (MAC) (sometimes also known as <strong>keyed hash</strong>) protects against message forgery by anyone who doesn't know the secret key (shared by sender and receiver).  

This means that the receiver can forge any message – thus we have both <em>integrity</em> and <em>authentication</em> (as long as the receiver doesn't have a split personality), but not <em>non-repudiation</em>.  

Also an attacker could replay earlier messages authenticated with the same key, so a protocol should take measures against this (e.g. by including message numbers or timestamps). (Also, in case of a two-sided conversation, make sure that either both sides have different keys, or by another way make sure that messages from one side can't sent back by an attacker to this side.)  

MACs can be created from unkeyed hashes (e.g. with the HMAC construction), or created directly as MAC algorithms.  

A (digital) <strong>signature</strong> is created with a private key, and verified with the corresponding public key of an asymmetric key-pair. Only the holder of the private key can create this signature, and normally anyone knowing the public key can verify it. Digital signatures don't prevent the replay attack mentioned previously.  

<sup>There is the special case of <em>designated verifier signature</em>, which only ones with knowledge of another key can verify, but this is not normally meant when saying "signature".</sup>  

So this provides all of <em>integrity</em>, <em>authentication</em>, and <em>non-repudiation</em>.  

Most signature schemes actually are implemented with the help of a hash function. Also, they are usually slower than MACs, and as such used normally only when there is not yet a shared secret, or the non-repudiation property is important.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: What are the practical differences between 256-bit, 192-bit, and 128-bit AES encryption? (score [75096](https://stackoverflow.com/q/20) in 2014)

#### Question
AES has several different variants:  

<ul>
<li>AES-128</li>
<li>AES-192</li>
<li>AES-256</li>
</ul>

But why would someone prefer use one over another?  

#### Answer accepted (score 68)
For practical purposes, 128-bit keys are sufficient to ensure security. The larger key sizes exist mostly to satisfy some US military regulations which call for the existence of several distinct "security levels", regardless of whether breaking the lowest level is already far beyond existing technology.  

The larger key sizes imply some CPU overhead (+20% for a 192-bit key, +40% for a 256-bit key: internally, the AES is a sequence of "rounds" and the <a href="http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf">AES standard</a> says that there shall be 10, 12 or 14 rounds, for a 128-bit, 192-bit or 256-bit key, respectively). So there is some rational reason <em>not</em> to use a larger than necessary key.  

<p>A larger key size also resists better to large quantum computer attacks: Using <a href="http://en.wikipedia.org/wiki/Grover%27s_algorithm">Grover's algorithm</a>, a brute-force attack on any k-bit key block cipher would only take $O(2^{k/2})$ steps, so a 256-bit key would still give 128-bit security, while a 128-bit key could be cracked in 2^64 operations, which is doable. But as far as I know, the threat of QC was an ulterior rationalization; also, it does not explain the 192-bit key size.
(And quantum computers of this size are not yet in sight for the next some years.)</p>

#### Answer 2 (score 42)
The actual encryption algorithm is almost the same between all variants of AES. They all take a 128-bit block and apply a sequence of identical "rounds", each of which consists of some linear and non-linear shuffling steps. Between the rounds, a <em>round key</em> is applied (by XOR), also before the first and after the last round.  

The differences are:  

<ul>
<li>The longer key sizes use more rounds: AES-128 uses 10 rounds, AES-192 uses 12 rounds and AES-256 uses 14 rounds.</li>
<li>The derivation of the round keys looks a bit different.</li>
</ul>

For AES-128, we need 11 round keys, each of which consisting of 128 bits, i.e. 4 32-bit columns. The original cipher key consists of 128 bits (i.e. 4 columns). Call these $k_0$, $k_1$, $k_2$ and $k_3$. The key expansion algorithm now expands these to $k_0$ to $k_{43}$ (so we get 44 columns in total).  

The key expansion works in a way that $k_i$ only depends directly on $k_{i-1}$ and $k_{i -N_k}$ (where $N_k$ is the number of columns in the key, i.e. 4 for AES-128). In most cases it is a simple $\oplus$, but after each $N_k$ key columns, a non-linear function $f_i$ is applied.  

```cryptography
                              ┏━━━┓
   k_0    k_1    k_2    k_3 ─→┃f_1┃─╮
    │      │      │      │    ┗━━━┛ │
 ╭──│──────│──────│──────│──────────╯
 │  ↓      ↓      ↓      ↓
 ╰─→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕
    │   │  │   │  │   │  │
    ↓   │  ↓   │  ↓   │  ↓    ┏━━━┓
   k_4 ─╯ k_5 ─╯ k_6 ─╯ k_7 ─→┃f_2┃─╮
    │      │      │      │    ┗━━━┛ │
 ╭──│──────│──────│──────│──────────╯
 │  ↓      ↓      ↓      ↓
 ╰─→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕
    │   │  │   │  │   │  │
    ↓   │  ↓   │  ↓   │  ↓     ┏━━━┓
   k_8 ─╯ k_9 ─╯ k_10 ╯ k_11 ─→┃f_3┃─╮
    │      │      │      │     ┗━━━┛ │
 ╭──│──────│──────│──────│───────────╯
 │  ↓      ↓      ↓      ↓
.......................................
 │  ↓      ↓      ↓      ↓
 ╰─→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕
    │   │  │   │  │   │  │
    ↓   │  ↓   │  ↓   │  ↓
   k_40 ╯ k_41 ╯ k_42 ╯ k_43
```

The functions $f_i$ are nonlinear functions build from the AES S-box (applied on each byte separately), a rotation by one byte, and an XOR with a round constant depending on $i$ (this is the element of $GF(2^8)$ corresponding to $x^{i-1}$, but there also is a table in the standard).  

Then the key selection algorithm simply takes $k_0 \dots k_3$ as the first round key, $k_4\dots k_7$ as the second one, until $k_{40} \dots k_{43}$ as the last one.  

AES-192 looks almost the same, but with six columns in parallel (A similar diagram you can see in <a href="https://crypto.stackexchange.com/a/2496/58">my answer to a different question</a>). As we need 13 round keys (=52 key columns), this will be done until $k_{51}$ (i.e. 8 full rows and four keys in the ninth row).  

For AES-256 (and all variants of Rijndael with more than 192 bits of key), there is an additional non-linear transformation after the fourth column:  

```cryptography
                                                             ┏━━━┓
  k_0    k_1    k_2    k_3       k_4    k_5    k_6    k_7 ──→┃f_1┃─╮
   │      │      │      │         │      │      │      │     ┗━━━┛ │
╭──│──────│──────│──────│─────────│──────│──────│──────│───────────╯
│  ↓      ↓      ↓      ↓     ┏━┓ ↓      ↓      ↓      ↓
╰─→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕   ╭→┃g┃→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕
   │   │  │   │  │   │  │   │ ┗━┛ │   │  │   │  │   │  │
   ↓   │  ↓   │  ↓   │  ↓   │     ↓   │  ↓   │  ↓   │  ↓     ┏━━━┓
  k_8 ─╯ k_9 ─╯ k_10 ╯ k_11 ╯    k_12 ╯ k_13 ╯ k_14 ╯ k_15 ─→┃f_2┃─╮
   │      │      │      │         │      │      │      │     ┗━━━┛ │
╭──│──────│──────│──────│─────────│──────│──────│──────│───────────╯
│  ↓      ↓      ↓      ↓     ┏━┓ ↓      ↓      ↓      ↓
╰─→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕   ╭→┃g┃→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕
   │   │  │   │  │   │  │   │ ┗━┛ │   │  │   │  │   │  │
   ↓   │  ↓   │  ↓   │  ↓   │     ↓   │  ↓   │  ↓   │  ↓     ┏━━━┓
  k_16 ╯ k_17 ╯ k_18 ╯ k_19 ╯    k_20 ╯ k_21 ╯ k_22 ╯ k_23 ─→┃f_3┃─╮
   │      │      │      │         │      │      │      │     ┗━━━┛ │
╭──│──────│──────│──────│─────────│──────│──────│──────│───────────╯
│  ↓      ↓      ↓      ↓         ↓      ↓      ↓      ↓
....................................................................
│  ↓      ↓      ↓      ↓     ┏━┓ ↓      ↓      ↓      ↓
╰─→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕   ╭→┃g┃→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕
   │   │  │   │  │   │  │   │ ┗━┛ │   │  │   │  │   │  │
   ↓   │  ↓   │  ↓   │  ↓   │     ↓   │  ↓   │  ↓   │  ↓     ┏━━━┓
  k_48 ╯ k_49 ╯ k_50 ╯ k_51 ╯    k_52 ╯ k_53 ╯ k_54 ╯ k_55 ─→┃f_7┃─╮
   │      │      │      │                                    ┗━━━┛ │
╭──│──────│──────│──────│──────────────────────────────────────────╯
│  ↓      ↓      ↓      ↓
╰─→⊕   ╭─→⊕   ╭─→⊕   ╭─→⊕
   │   │  │   │  │   │  │
   ↓   │  ↓   │  ↓   │  ↓
  k_56 ╯ k_57 ╯ k_58 ╯ k_59
```

$g$ is a simpler variant of $f_i$: simply the application of the AES S-box on every byte of the column in parallel (without the rotation or the round constant, thus without an index).  

Here we need 15 round keys, i.e. 60 columns, which means to do seven and a half round of key expansion.  

(I now did read the word <strong>practical</strong> in the question, and my post doesn't really apply here ... but there seems to be no better question to post this as an answer, so I still post it here.)  

#### Answer 3 (score 9)
In my opinion, if AES-128 is broken, then it's highly likely that AES-192 and AES-256 will fall too (because these types of attacks are structural and easily extend to longer key-lengths).  In fact, we <strong>know</strong> a successful attack on AES will <strong>not</strong> be via exhaustive key search on a conventional computer.  

There is, however, some chance that key-size will matter in face of a practical attack: suppose the attack takes about the square-root of the size of the key-space (kind of like a collision-attack on hash functions; in fact, quantum computers <strong>will</strong> give this kind of speedup on exhaustive key search via Grover's Algorithm).  Then the square-root of $2^{128}$ becomes practical whereas the square-root of $2^{256}$ remains out of reach.  Nevertheless, I guarantee you if AES-128 falls, people will quickly migrate away from the longer-key variants out of worry that they will fall too.  

Attacks don't get worse... they only get better.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How can I generate large prime numbers for RSA? (score [72660](https://stackoverflow.com/q/71) in 2011)

#### Question
What is the currently industry-standard algorithm used to generate large prime numbers to be used in RSA encryption?  

I'm aware that I can find any number of articles on the Internet that explain how the RSA algorithm works to encrypt and decrypt messages, but I can't seem to find any article that explains the algorithm used to generate the `p` and `q` large and distinct prime numbers that are used in that algorithm.  

#### Answer accepted (score 60)
The standard way to generate big prime numbers is to take a preselected random number of the desired length, apply a <a href="http://en.wikipedia.org/wiki/Fermat_primality_test">Fermat test</a> (best with the base $2$ as it can be optimized for speed) and then to apply a certain number of <a href="http://en.wikipedia.org/wiki/Miller-Rabin_primality_test">Miller-Rabin tests</a> (depending on the length and the allowed error rate like $2^{-100}$) to get a number which is very probably a prime number.  

The preselection is done either by test divisions by small prime numbers (up to few hundreds) or by <a href="http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes">sieving</a> out primes up to 10,000 - 1,000,000 considering many prime candidates of the form $b+2i$ ($b$ big, $i$ up to few thousands).  

The deterministic prime number test by <a href="http://en.wikipedia.org/wiki/AKS_primality_test">AKS</a> is to my knowledge not yet used as it is slower and as the likeliness that an calculation error caused by the hardware is higher than $2^{-100}$.  

Most smart cards offer a coprocessor for modular arithmetic with moduli from 1024 up to few thousand bits. The manufacturers often provide also libraries for RSA and RSA key generation using the coprocessor.  

#### Answer 2 (score 27)
<p><a href="http://csrc.nist.gov/publications/fips/fips186-3/fips_186-3.pdf">FIPS 186-3</a> tells you how they expect you to generate primes for cryptographic applications. 
It is essentially Miller-Rabin but it also specify what to do when you need extra properties from your primes.</p>

#### Answer 3 (score 16)
The problem of generating prime numbers reduces to one of determining primality (rather than an algorithm specifically designed to generate primes) since <a href="http://en.wikipedia.org/wiki/Prime_counting_function">primes are pretty common</a>: &pi;(n) ~ n/ln(n).  

Probabilistic tests are used (e.g. in <a href="http://download.oracle.com/javase/6/docs/api/java/math/BigInteger.html#probablePrime%28int,%20java.util.Random%29">`java.math.BigInteger.probablePrime()`</a>) rather than deterministic tests. See <a href="http://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test">Miller-Rabin</a>.  

<a href="http://en.literateprograms.org/Miller-Rabin_primality_test_%28Java%29">http://en.literateprograms.org/Miller-Rabin_primality_test_%28Java%29</a>  

As far as primes for RSA goes, there are some <a href="http://en.wikipedia.org/wiki/RSA#Key_generation_2">additional minor requirements</a>, namely that (p-1) and (q-1) should not be easily factorable, and p and q should not be close together.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How to find modulus from a RSA public key? (score [71556](https://stackoverflow.com/q/18031) in 2017)

#### Question
I am studying the RSA cryptosystem. The public key consists of $(n, e)$, the modulus (product of two large primes), and the encryption exponent. I want to separate the modulus $n$ and exponent $e$. A typical public key is expressed in base64, and is of the following type:  

```cryptography
 -----BEGIN PUBLIC KEY-----

 MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCqGKukO1De7zhZj6+H0qtjTkVxwTCpvKe4eCZ0
 FPqri0cb2JZfXJ/DgYSF6vUpwmJG8wVQZKjeGcjDOL5UlsuusFncCzWBQ7RKNUSesmQRMSGkVb1/
 3j+skZ6UtW+5u09lHNsj6tQ51s1SPrCBkedbNf0Tp0GbMJDyR4e9T04ZZwIDAQAB

-----END PUBLIC KEY-----
```

Now from the above key, it is not clear which part is the modulus and which is the exponent. How can I extract the two?  

#### Answer accepted (score 17)
RSA key formats are defined in at least <a href="http://www.ietf.org/rfc/rfc3447.txt" rel="noreferrer">RFC 3447</a> and <a href="http://www.ietf.org/rfc/rfc5280.txt" rel="noreferrer">RFC 5280</a>. The format is based on ASN.1 and includes more than just the raw modulus and exponent.  

If you decode the base 64 encoded ASN.1, you will find some wrapping (like an object identifier) as well as an internal ASN.1 bitstring, which decodes as:  

```cryptography
(
    119445732379544598056145200053932732877863846799652384989588303737527328743970559883211146487286317168142202446955508902936035124709397221178664495721428029984726868375359168203283442617134197706515425366188396513684446494070223079865755643116690165578452542158755074958452695530623055205290232290667934914919, 
    65537
)
```

The former is the 2048-bit modulus $n$ and the latter the public exponent $e$, which is usually <a href="https://crypto.stackexchange.com/q/8454/13625">chosen</a> as either 3 or, like here, 65537. To do the same for an arbitrary key, you will need to read up on at least <a href="ftp://ftp.rsa.com/pub/pkcs/ascii/layman.asc" rel="noreferrer">ASN.1</a>, or else <a href="https://crypto.stackexchange.com/a/18034/13625">use an existing decoder</a>.  

#### Answer 2 (score 27)
I wanted to help break down exactly what you're seeing.   

If you take your base64 string:  

<blockquote>
  MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCqGKukO1De7zhZj6+H0qtjTkVxwTCpvKe4eCZ0FPqri0cb2JZfXJ/DgYSF6vUpwmJG8wVQZKjeGcjDOL5UlsuusFncCzWBQ7RKNUSesmQRMSGkVb1/3j+skZ6UtW+5u09lHNsj6tQ51s1SPrCBkedbNf0Tp0GbMJDyR4e9T04ZZwIDAQAB  
</blockquote>

You then decode it into hex:  

```cryptography
30 81 9F 30 0D 06 09 2A  86 48 86 F7 0D 01 01 01
05 00 03 81 8D 00 30 81  89 02 81 81 00 AA 18 AB
A4 3B 50 DE EF 38 59 8F  AF 87 D2 AB 63 4E 45 71
C1 30 A9 BC A7 B8 78 26  74 14 FA AB 8B 47 1B D8
96 5F 5C 9F C3 81 84 85  EA F5 29 C2 62 46 F3 05
50 64 A8 DE 19 C8 C3 38  BE 54 96 CB AE B0 59 DC
0B 35 81 43 B4 4A 35 44  9E B2 64 11 31 21 A4 55
BD 7F DE 3F AC 91 9E 94  B5 6F B9 BB 4F 65 1C DB
23 EA D4 39 D6 CD 52 3E  B0 81 91 E7 5B 35 FD 13
A7 41 9B 30 90 F2 47 87  BD 4F 4E 19 67 02 03 01
00 01 
```

So the question is: what is this? Well it's actually the DER variant of ASN.1 encoding. ASN.1 is a horrible monstrosity, but you can use <a href="https://lapo.it/asn1js/" rel="noreferrer">the web-based ASN.1 decoder</a> to find that the values are actually this:  

```cryptography
30 81 9F             ;30=SEQUENCE (0x9F = 159 bytes)
|  30 0D             ;30=SEQUENCE (0x0D = 13 bytes)
|  |  06 09          ;06=OBJECT_IDENTIFIER (0x09 = 9 bytes)
|  |  2A 86 48 86    ;Hex encoding of 1.2.840.113549.1.1
|  |  F7 0D 01 01 01
|  |  05 00          ;05=NULL (0 bytes)
|  03 81 8D 00       ;03=BIT STRING (0x8d = 141 bytes)
|  |  30 81 89       ;30=SEQUENCE (0x89 = 137 bytes)
|  |  |  02 81 81    ;02=INTEGER (0x81 = 129 bytes) the modulus
|  |  |  00          ;leading zero of INTEGER 
|  |  |  AA 18 AB A4 3B 50 DE EF  38 59 8F AF 87 D2 AB 63 
|  |  |  4E 45 71 C1 30 A9 BC A7  B8 78 26 74 14 FA AB 8B 
|  |  |  47 1B D8 96 5F 5C 9F C3  81 84 85 EA F5 29 C2 62 
|  |  |  46 F3 05 50 64 A8 DE 19  C8 C3 38 BE 54 96 CB AE 
|  |  |  B0 59 DC 0B 35 81 43 B4  4A 35 44 9E B2 64 11 31 
|  |  |  21 A4 55 BD 7F DE 3F AC  91 9E 94 B5 6F B9 BB 4F 
|  |  |  65 1C DB 23 EA D4 39 D6  CD 52 3E B0 81 91 E7 5B 
|  |  |  35 FD 13 A7 41 9B 30 90  F2 47 87 BD 4F 4E 19 67 
|  |  02 03          ;02=INTEGER (0x03 = 3 bytes) - the exponent
|  |  |  01 00 01    ;hex for 65537
```

So encoded in there are the two important numbers in hex:  

<ul>
<li><strong>Exponent</strong>: `65537` <em>(Nearly everyone universally uses 65,537 as their prime exponent)</em></li>
<li><strong>Modulus</strong>: `00 AA 18 AB A4 3B 50 DE EF 38 59 8F AF 87 D2 AB 63 4E 45 71 C1 30 A9 BC A7 B8 78 26 74 14 FA AB 8B 47 1B D8 96 5F 5C 9F C3 81 84 85 EA F5 29 C2 62 46 F3 05 50 64 A8 DE 19 C8 C3 38 BE 54 96 CB AE B0 59 DC 0B 35 81 43 B4  4A 35 44 9E B2 64 11 31 21 A4 55 BD 7F DE 3F AC 91 9E 94 B5 6F B9 BB 4F 65 1C DB 23 EA D4 39 D6 CD 52 3E B0 81 91 E7 5B 35 FD 13 A7 41 9B 30 90 F2 47 87 BD 4F 4E 19 67`</li>
</ul>

Or, in decimal, your modulus is:  

<blockquote>
  119,445,732,379,544,598,056,145,200,053,932,732,877,863,846,799,652,384,989,588,303,737,527,328,743,970,559,883,211,146,487,286,317,168,142,202,446,955,508,902,936,035,124,709,397,221,178,664,495,721,428,029,984,726,868,375,359,168,203,283,442,617,134,197,706,515,425,366,188,396,513,684,446,494,070,223,079,865,755,643,116,690,165,578,452,542,158,755,074,958,452,695,530,623,055,205,290,232,290,667,934,914,919  
</blockquote>

No need for OpenSSL and it's voodoo commands.  

#### Answer 3 (score 22)
In practice, one can use `openssl` to extract the information:  

```cryptography
$ cat pubkey.txt
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCqGKukO1De7zhZj6+H0qtjTkVxwTCpvKe4eCZ0
FPqri0cb2JZfXJ/DgYSF6vUpwmJG8wVQZKjeGcjDOL5UlsuusFncCzWBQ7RKNUSesmQRMSGkVb1/
3j+skZ6UtW+5u09lHNsj6tQ51s1SPrCBkedbNf0Tp0GbMJDyR4e9T04ZZwIDAQAB
-----END PUBLIC KEY-----

$ openssl rsa -pubin -in pubkey.txt -text -noout
Public-Key: (1024 bit)
Modulus:
    00:aa:18:ab:a4:3b:50:de:ef:38:59:8f:af:87:d2:
    ab:63:4e:45:71:c1:30:a9:bc:a7:b8:78:26:74:14:
    fa:ab:8b:47:1b:d8:96:5f:5c:9f:c3:81:84:85:ea:
    f5:29:c2:62:46:f3:05:50:64:a8:de:19:c8:c3:38:
    be:54:96:cb:ae:b0:59:dc:0b:35:81:43:b4:4a:35:
    44:9e:b2:64:11:31:21:a4:55:bd:7f:de:3f:ac:91:
    9e:94:b5:6f:b9:bb:4f:65:1c:db:23:ea:d4:39:d6:
    cd:52:3e:b0:81:91:e7:5b:35:fd:13:a7:41:9b:30:
    90:f2:47:87:bd:4f:4e:19:67
Exponent: 65537 (0x10001)
```

The modulus is printed in hexadecimal, how to obtain its decimal value is left as an exercise to the reader.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: What is the difference between .pem , .csr , .key and .crt? (score [71364](https://stackoverflow.com/q/43697) in 2017)

#### Question
I'm new to SSL / TLS and I want to work with the OpenSSL toolkit.  

I don't know what `.pem` and `.csr` stands for?  

I do know that `.key` is the private key and `.crt` is the public key.   

#### Answer accepted (score 62)
File extensions can be (very) loosely seen as a type system.  

<ul>
<li>`.pem` stands for PEM, Privacy Enhanced Mail; it simply indicates a base64 encoding with header and footer lines. Mail traditionally only handles text, not binary which most cryptographic data is, so some kind of encoding is required to make the contents part of a mail message itself (rather than an encoded attachment). The contents of the PEM are detailed in the header and footer line - `.pem` itself doesn't specify a data type - just like `.xml` and `.html` do not specify the contents of a file, they just specify a specific <em>encoding</em>; </li>
<li>`.key` can be any kind of key, but usually it is the private key - OpenSSL can wrap private keys for all algorithms (RSA, DSA, EC) in a generic and standard PKCS#8 structure, but it also supports a separate 'legacy' structure for each algorithm, and both are still widely used even though the documentation has marked PKCS#8 as superior for almost 20 years; both can be stored as DER (binary) or PEM encoded, and both PEM and PKCS#8 DER can protect the key with password-based encryption or be left unencrypted;</li>
<li>`.csr` stands for Certificate Signing Request, it contains information such as the public key and common name required by a Certificate Authority to create and sign a certificate for the requester, the encoding could be PEM or DER (which is a binary encoding of an ASN.1 specified structure);</li>
<li>`.crt` stands simply for certificate, usually an X509v3 certificate, again the encoding could be PEM or DER; a certificate <em>contains</em> the public key, but it contains much more information (most importantly the signature by the Certificate Authority over the data and public key, of course).</li>
</ul>

Beware that not everyone may use the same extensions - there is no official register or anything like that. You're probably better off using the POSIX `file` command line utility first.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: Should we sign-then-encrypt, or encrypt-then-sign? (score [68858](https://stackoverflow.com/q/5458) in 2017)

#### Question
We often want to send messages that are both (a) encrypted, so passive attackers can't discover the plaintext of the message, and (b) signed with a private-key digital signature, so active attackers can't trick Alice into thinking that some message came from Bob, when really the message is some (accidental or malicious) modification of a real message Bob sent, or a message that was forged out of whole cloth by an attacker.  

<p>Is it better to (a) generate the digital signature from the (hashed) plaintext, and then encrypt a file containing both the plaintext message and the digital signature?
Or is it better to (b) encrypt the message first, and then generate a digital signature from the (hashed) encrypted file?
Or (c) combine encryption and public-key digital signatures in some other way?</p>

<p>A closely related earlier question ( <a href="https://crypto.stackexchange.com/questions/202/should-we-mac-then-encrypt-or-encrypt-then-mac">Should we MAC-then-encrypt or encrypt-then-MAC?</a> )
seems to focus on symmetric-key MAC authentication.
As <a href="https://crypto.stackexchange.com/questions/5417/is-there-an-authenticated-encryption-scheme-where-the-recipient-can-attribute-th">Robert I. Jr. asked earlier</a>,
Do the same issues with (symmetric-key) MAC-then-encrypt apply to (public-key) sign-then-encrypt?</p>

#### Answer accepted (score 83)
Assuming you are asking about public-key signatures + public-key encryption:  

<strong>Short answer:</strong> I recommend sign-then-encrypt, but prepend the recipient's name to the message first.  

<strong>Long answer:</strong> When Alice wants to send an authenticated message to Bob, she should sign and encrypt the message. In particular, she prepends Bob's name to the message, signs this using her private key, appends her signature to the message, encrypts the whole thing under Bob's public key, and sends the resulting ciphertext to Bob. Bob can decrypt, verify the signature, and confirm that this indeed came from Alice (or someone she shared her private key with).  Make sure you use an IND-CCA2-secure public-key encryption scheme and a UF-CMA-secure public-key signature scheme (i.e., one that is secure against existential forgery attack).  

<strong>Justification:</strong> The reason to do this is to defeat some subtle attacks.  These attacks are not necessarily a problem in all scenarios, but it's best to harden the approach as much as possible.  A complete explanation would take more space than is available here, but see below for a sketch of the reasoning.  

For a detailed analysis about whether to sign first or encrypt first, the following is a good resource: <a href="http://world.std.com/~dtd/sign_encrypt/sign_encrypt7.html">Defective Sign &amp; Encrypt in S/MIME, PKCS#7, MOSS, PEM, PGP, and XML</a>.    

I don't recommend encrypt-then-sign. It could work, but it has some subtle pitfalls in some contexts, because the signature does not prove that the sender was aware of the context of the plaintext. For instance, suppose Alice's SSH client sends the message "Dear SSH server, please append my public key to /root/.ssh/authorized_keys -- and you can know that I am authorized because I know the root password is lk23jas0" (encrypted then signed with Alice's public key), and the SSH server acts on it if the root password is correct. Then Eve can eavesdrop, capture this message, strip off Alice's signature, sign the ciphertext with Eve's own key, and send it to the SSH server, obtaining root-level access even though Eve didn't know the root password.  

#### Answer 2 (score 19)
<blockquote>
  <p>Should we sign-then-encrypt, or encrypt-then-sign?
  ...
  Do the same issues with (symmetric-key) MAC-then-encrypt apply to (public-key) sign-then-encrypt?</p>
</blockquote>

Yes. From a security engineering standpoint, you are consuming <strong><em>unauthenticated</em></strong> data during decryption <em>if</em> you mac-then-encrypt or sign-then-encrypt. A very relevant paper is Krawczyk's <a href="https://www.iacr.org/archive/crypto2001/21390309.pdf">The Order of Encryption and Authentication for Protecting Communications</a>.  

The order may (or may not) be problematic in practice for you. But as the SSL/TLS folks have repeatedly shown, its problematic in practice.  

Another important paper is cited by D.W. and Sashank: Don Davis' <a href="http://world.std.com/~dtd/sign_encrypt/sign_encrypt7.html">Defective Sign &amp; Encrypt in S/MIME, PKCS#7, MOSS, PEM, PGP, and XML</a>.  

I think the primitive of sign vs mac is less important. With all things being equal (like security levels, key management and binding), then one of the top criteria is efficiency. Obviously, a symmetric cipher is more efficient than an asymmetric cipher.  

<hr>

Data authentication is a different property than entity authentication. You can use a MAC for data authentication and a signature for entity authentication.  

But its not entirely clear to me if you want data authentication or entity authentication. The security goal you state in (b) begs for data authentication (a MAC), and not entity authentication (a signature).  

I think that's why CodesInChaos said he signs then performs authenticated encryption. That's another way to say he signs-then-encrypts-then-macs. If the MAC is good, then he decrypts and verifies the signature to verify who sent the message. If the MAC is bad, then he does not bother decrypting - he just returns <em>FAIL</em>.  

If you look at the <a href="http://world.std.com/~dtd/sign_encrypt/sign_encrypt7.html">link provided by Sashank</a>, CodesInChaos' fix is effectively <em>Sign/Encrypt/Sign</em> from Section 5.2 of the paper. And D.W's solution is effectively <em>Naming Repairs</em> from Section 5.1.  

<hr>

There's a third option that's not readily apparent. It combines Encrypt-Then-MAC for bulk encryption with public key cryptography. Its also IND-CCA2 as D.W. suggested you strive for.  

The option is an <a href="https://en.wikipedia.org/wiki/Integrated_Encryption_Scheme">Integrated Encryption Scheme</a>. There are two of them that I am aware. The first is Shoup's ECIES, which operates elliptic curves; the second is Abdalla, Bellare and Rogaway's DLIES, which operates over integers. <a href="http://www.cryptopp.com/">Crypto++</a> provides both <a href="http://www.cryptopp.com/wiki/Elliptic_Curve_Integrated_Encryption_Scheme">ECIES</a> and <a href="http://www.cryptopp.com/wiki/Discrete_Logarithm_Integrated_Encryption_Scheme">DLIES</a>. Bouncy Castle provides ECIES.  

ECIES and DLIES combine a Key Encapsulation Mechanism (KEM) with a Data Encapsulation Mechanism (DEM). The system independently derives a symmetric cipher key and a MAC key from a common secret. Data is first encrypted under a symmetric cipher, and then the cipher text is MAC'd under an authentication scheme. Finally, the common secret is encrypted under the public part of a public/private key pair. The output of the encryption function is the tuple `{K,C,T}`, where `K` is the encrypted common secret, `C` is the ciphertext, and `T` is the authentication tag.  

There's some hand waiving around the use of a symmetric cipher. The schemes use a stream cipher that XORs the plaintext with the output of the KDF. The design choice here was to avoid a block cipher with padding. You could use a block cipher in a streaming mode, like AES/CTR to the same effect.  

There is some hand waiving around the "common secret" since its actually the result of applying a Key Agreement function and later digesting the shared secret with a KDF. The Key Agreement function uses the recipient's static public key and an ephemeral key pair. The ephemeral key pair is created by the person doing the encryption. The person performing the decrypt uses their public key to perform the other half of the key exchange to arrive at the "common secret".  

The KEM and the DEM avoid padding, so padding oracles are not a concern. That's why a KDF is used to digest the large "common secret" under the KEM. Omitting the padding vastly simplifies the security proofs of the system.  

#### Answer 3 (score 13)
It depends on your requirement,   

<ul>
<li>If you Sign-then-encrypt then only receiver can decrypt and then<br>
verify .  </li>
<li>If encrypt-then-sign  then anybody can verify the<br>
authenticity and only receiver can decrypt it .</li>
</ul>

But in practice, both are not enough , ideally We have to sign-encrypt-sign , am not able to recollect the paper which discusses this   

There is one more paper that is popular and discusses this issue in <a href="http://world.std.com/~dtd/sign_encrypt/sign_encrypt7.html">general</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Why shouldn't I use ECB encryption? (score [67555](https://stackoverflow.com/q/20941) in 2014)

#### Question
I'm using Java to generate encrypted strings, and I get this warning at build time:   

<blockquote>
  ECB encryption mode should not be used  
</blockquote>

So I'm wondering why I shouldn't use ECB and what I can use instead?  

#### Answer accepted (score 82)
<h5>Why shouldn't I use ECB encryption?</h2>

The main reason not to use <a href="//en.wikipedia.org/wiki/ECB_mode" rel="noreferrer">ECB mode</a> encryption is that it's not <a href="//en.wikipedia.org/wiki/Semantic_security" rel="noreferrer">semantically secure</a> &mdash; that is, merely observing ECB-encrypted ciphertext can leak information about the plaintext (even beyond its length, which all encryption schemes accepting arbitrarily long plaintexts will leak to some extent).  

Specifically, the problem with ECB mode is that encrypting the same block (of 8 or 16 bytes, or however large the block size of the underlying cipher is) of plaintext using ECB mode always yields the same block of ciphertext.  This can allow an attacker to:  

<ul>
<li>detect whether two ECB-encrypted messages are identical;</li>
<li>detect whether two ECB-encrypted messages share a common prefix;</li>
<li>detect whether two ECB-encrypted messages share other common substrings, as long as those substrings are aligned at block boundaries; or</li>
<li>detect whether (and where) a single ECB-encrypted message contains repetitive data (such as long runs of spaces or null bytes, repeated header fields or coincidentally repeated phrases in text).</li>
</ul>

There's a nice <a href="https://filippo.io/the-ecb-penguin/" rel="noreferrer">graphical demonstration</a> of this weakness on Wikipedia, where the same (raw, uncompressed) image is encrypted using both ECB mode and a semantically secure cipher mode (such as CBC, CTR, CFB or OFB):  

&nbsp; &nbsp; &nbsp; <img src="https://i.stack.imgur.com/bXAUL.png" alt="ECB penguin">  

While this scenario is somewhat artificial (one would not usually encrypt raw images like this), it nicely demonstrates the problem with ECB mode: repetitive areas in the input image result in repetitive patterns in the encrypted output, so that many large-scale features of the image remain recognizable despite the encryption.  In the real world, a cryptanalyst attacking an ECB-based encryption scheme would be more likely to look for such patterns in a hex dump of the ciphertext, but the principle is the same.  

An actual case of this weakness of ECB encryption contributing to a real-world data compromise is given by the 2013 <a href="http://nakedsecurity.sophos.com/2013/11/04/anatomy-of-a-password-disaster-adobes-giant-sized-cryptographic-blunder/" rel="noreferrer">Adobe password database leak</a>, as described in <a href="https://crypto.stackexchange.com/questions/14487/can-someone-explain-the-ecb-penguin/14490#14490">this answer</a>.  Here, one element contributing to the severity of the leak was that, instead of <a href="https://security.stackexchange.com/questions/211/how-to-securely-hash-passwords">hashing them properly</a>, Adobe had encrypted the passwords using ECB mode.  This allowed the attackers to quickly locate passwords shared by multiple accounts, or sharing a common prefix with other passwords (like <em>password1</em> and <em>password2</em>), and also revealed the approximate length of each password.  

<hr>

The ECB encryption mode also has other weaknesses, such as the fact that it's highly <a href="//en.wikipedia.org/wiki/Malleability_(cryptography)" rel="noreferrer">malleable</a>: as each block of plaintext is separately encrypted, an attacker can easily generate new valid ciphertexts by piecing together blocks from previously observed ciphertexts.  

However, the malleability is only an issue if ECB encryption is used without a <a href="//en.wikipedia.org/wiki/Message_authentication_code" rel="noreferrer">message authentication code</a>, and, in this situation, is shared (to some extent) by all other <a href="//en.wikipedia.org/wiki/Block_cipher_mode_of_operation" rel="noreferrer">non-authenticated encryption modes</a>, like the aforementioned CBC, CTR, CFB and OFB.  Thus, it cannot really be considered a specific weakness of ECB mode, even though it does tend to be an additional issue whenever ECB mode is used.  

<hr>

<h5>What should I use instead?</h2>

You should use any <a href="//en.wikipedia.org/wiki/Authenticated_encryption" rel="noreferrer">authenticated encryption</a> mode, such as <a href="//en.wikipedia.org/wiki/Galois/Counter_Mode" rel="noreferrer">GCM</a>, <a href="//en.wikipedia.org/wiki/EAX_mode" rel="noreferrer">EAX</a> or <a href="//en.wikipedia.org/wiki/OCB_mode" rel="noreferrer">OCB</a>.  

Personally, for short messages, I'm rather fond of <a href="http://web.cs.ucdavis.edu/~rogaway/papers/keywrap.html" rel="noreferrer">SIV mode</a> (<a href="//tools.ietf.org/html/rfc5297" rel="noreferrer">RFC 5279</a>), which provides an extra layer of misuse-resistance.  (Many other encryption modes will break rather badly if the same IV / nonce is accidentally used to encrypt multiple messages.  SIV mode retains all its security properties in this situation, except for leaking whether the encrypted messages are identical.)  

You can also use any traditional semantically secure encryption mode (such as <a href="//en.wikipedia.org/wiki/CBC_mode" rel="noreferrer">CBC</a> or <a href="//en.wikipedia.org/wiki/CTR_mode" rel="noreferrer">CTR</a>), combined with a message authentication code (such as <a href="//en.wikipedia.org/wiki/Hash-based_message_authentication_code" rel="noreferrer">HMAC</a>) using the <a href="https://crypto.stackexchange.com/questions/202/should-we-mac-then-encrypt-or-encrypt-then-mac">Encrypt-then-MAC</a> construction.  (That is, you should first encrypt the message, then compute a MAC of the ciphertext, and append it to the ciphertext.)  As long as you make sure to verify the MAC before attempting to decrypt the message, this construction will protect you from the various vulnerabilities of these modes to active (chosen-ciphertext) attacks.  

For <a href="//en.wikipedia.org/wiki/Disk_encryption_theory" rel="noreferrer">disk encryption</a> or similar applications that require the ability modify parts of the ciphertext without re-encrypting all the data, you should use a cipher mode designed for that purpose, such as <a href="//en.wikipedia.org/wiki/XTS_mode" rel="noreferrer">XTS</a>.  Note that such modes generally lack resistance to active attacks, and may have other weaknesses that should be understood before using them.  If possible, they should be combined with some form of integrity protection, such as a MAC on a <a href="//en.wikipedia.org/wiki/Merkle_tree" rel="noreferrer">hash tree</a>.  

#### Answer 2 (score 19)
You should not use ECB mode because it will encrypt identical message blocks (i.e., the amount of data encrypted in each invocation of the block-cipher) to identical ciphertext blocks. This is a problem because it will reveal if the same messages blocks are encrypted multiple times. Wikipedia has a very nice illustration of this <a href="https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Electronic_codebook_.28ECB.29">problem</a>.  

#### Answer 3 (score -3)
As @Guut Boy mentioned it, ECB isn't semantically secure, in the sense that if a message with identical blocks is encrypted, then an attacker get a certain advantage to have information on plaintext, by only observing CipherText.  

Use preferably CBC mode to encrypt long message. This mode introduce an additional parameter called the IV (Initial Value), you initialise with the session number to prevent attacks in the case of encrypting the same message twice.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: FIPS 140-2 Compliant Algorithms (score [67188](https://stackoverflow.com/q/3859) in )

#### Question
Is there any reference to check the list of encryption &amp; signing algorithms which are compliant to FIPS 140-2. After an exhaustive search I could find only "AES".  

Any suggestions would be much appreciated.  

#### Answer accepted (score 16)
Take a look at <a href="http://csrc.nist.gov/publications/fips/fips140-2/fips1402annexa.pdf">FIPS 140-2 Annex A</a>. It lists the following:  

<ul>
<li>Symmetric Key
<ul>
<li>AES, Triple-DES, Escrowed Encryption Standard</li>
</ul></li>
<li>Asymmetric Key
<ul>
<li>DSA, RSA, ECDSA  </li>
</ul></li>
<li>Hash Standards<br>
<ul>
<li>SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, SHA-512/224, SHA-512/256</li>
</ul></li>
<li>Random number generators
<ul>
<li>See <a href="http://csrc.nist.gov/publications/fips/fips140-2/fips1402annexc.pdf">annex c</a></li>
</ul></li>
<li>Message authentication
<ul>
<li>CCM, GCM, GMAC, CMAC, HMAC</li>
</ul></li>
</ul>

#### Answer 2 (score 2)
The current list of FIPS-approved cryptographical methods is <a href="http://csrc.nist.gov/publications/fips/fips140-2/fips1402annexa.pdf" rel="nofollow">here</a>.  

For encryption, we're limited to AES, 3DES (known as TDEA in FIPS-speak), and EES (Skipjack).  

As for signing algorithms, we have RSA, DSA and ECDSA.  

Note that the list of FIPS-approved algorithms does change at times; not extremely frequently, but more often than they come out with a new version of FIPS 140.  

#### Answer 3 (score 1)
Looks like there is no FIPS 140-2 approved asymmetric encryption algorithm, as DSA/RSA/ECDSA are only approved for key generation/signature.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: Calculating RSA private exponent when given public exponent and the modulus factors using extended euclid (score [66423](https://stackoverflow.com/q/5889) in 2014)

#### Question
When given $p = 5, q = 11, N = 55$ and $e = 17$, I'm trying to compute the RSA private key $d$.  

I can calculate $\varphi(N) = 40$, but my lecturer then says to use the extended Euclidean algorithm to compute $d$. That's where I get stuck.  

<hr>

Here's my work so far:  

First I use the Euclid algorithm to calculate:  

```cryptography
40 = 2(17) + 6 
17 = 2(6) + 5
6 = 1(5) + 1 = gcd
```

So I know the GCD is 1. Applying the 'extended' section of the algorithm:  

```cryptography
6 = 40-2(17)
5 = 17-2(6)
1 = 6-1(5)
1 = 6-1(17-2(6))
3(6) = 1 (17)
3(40 - 2(17)) - 1(17)
3(40) - 3(17)
```

I know the answer is $33$, but I have no idea how to get there using the extended Euclidean algorithm. I can't figure out why I'm getting $3(40) - 3(17)$ when I know the answer should contain $33$.  

#### Answer accepted (score 37)
The extended Euclidean algorithm is essentially the Euclidean algorithm (for GCD's) ran backwards.  

Your goal is to find $d$ such that $ed \equiv 1 \pmod{\varphi{(n)}}$.  

Recall the EED calculates $x$ and $y$ such that $ax + by = \gcd{(a, b)}$. Now let $a = e$, $b = \varphi{(n)}$, and thus $\gcd{(e, \varphi{(n)})} = 1$ by definition (they need to be coprime for the inverse to exist). Then you have:  

$$ex + \varphi{(n)} y = 1$$  

Take this modulo $\varphi{(n)}$, and you get:  

$$ex \equiv 1 \pmod{\varphi{(n)}}$$  

And it's easy to see that in this case, $x = d$. The value of $y$ does not actually matter, since it will get eliminated modulo $\varphi{(n)}$ regardless of its value. The EED will give you that value, but you can safely discard it.  

<hr>

Now, we have $e = 17$ and $\varphi{(n)} = 40$. Write our main equation:  

$$17x + 40y = 1$$  

We need to solve this for $x$. So apply the ordinary Euclidean algorithm:  

$$40 = 2 \times 17 + 6$$  

$$17 = 2 \times 6 + 5$$  

$$6 = 1 \times 5 + 1$$  

Write that last one as:  

$$6 - 1 \times 5 = 1$$  

Now substitute the second equation into $5$:  

$$6 - 1 \times (17 - 2 \times 6) = 1$$  

Now substitute the first equation into $6$:  

$$(40 - 2 \times 17) - 1 \times (17 - 2 \times (40 - 2 \times 17)) = 1$$  

Note this is a linear combination of $17$ and $40$, after simplifying you get:  

$$ (-7) \times 17 + 3 \times 40 = 1$$  

We conclude $d = -7$, which is in fact $33$ modulo $40$ (since $-7 + 40 = 33$).  

As you can see, the basic idea is to use the successive remainders of the GCD calculation to substitute the initial integers back into the final equation (the one which equals $1$) which gives the desired linear combination.  

<hr>

As for your error, it seems you just made a calculation error here:  

3(40 - 2(17)) - 1(17)  

which incorrectly became:  

3(40) - 3(17)  

It seems you forgot the factor of 3 for the left 17, the correct result would be:  

3(40 - 2(17)) - 1(17) = 3 * 40 - 3 * 2 * 17 - 1 * 17 = 3 * 40 + (-7) * 17  

Which is the -7 expected.  

#### Answer 2 (score 6)
The method in the <a href="https://crypto.stackexchange.com/a/5894/555">other answer</a> is didactic, but requires backtracking earlier calculations, and thus having kept these or use of recursion, which is undesirable in constrained environments as often used for crypto.  

Another commonly taught method is the <a href="https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Pseudocode" rel="noreferrer">full extended Euclidean algorithm</a>, which finds Bézout coefficients without recursion. However that requires keeping track of 6 quantities beyond inputs, when for the modular inverse we can do with 4. Plus, the usual description manipulates negative integers; requires a final correction of sign; and makes use of simultaneous double assignment or variable swap, which are not directly available in some computer languages.  

Here is a step-by-step method to compute $a^{-1}\bmod m$ (and test if that's defined) for non-negative integer $a$ and positive integer $m$ . It uses the half-extended Euclidean algorithm, modified to deal only with non-negative quantities (always at most the largest input) and simple assignments.  

<ol>
<li>$b\gets m$ and $x\gets0$ and $y\gets1$.<br>
Note: $ax+by=m$ will keep holding, with $m$ the modulus.</li>
<li>if $a=1$, then output <em>"the desired inverse is $y$"</em> and stop.</li>
<li>If $a=0$, then output <em>"the desired inverse does not exists"</em> and stop ($b$ is the GCD).</li>
<li>$q\gets\lfloor b/a\rfloor$ .</li>
<li>$b\gets b-aq$ and $x\gets x+qy$ .</li>
<li>if $b=1$, then output <em>"the desired inverse is $m-x$"</em> and stop.</li>
<li>If $b=0$, then output <em>"the desired inverse does not exists"</em> and stop ($a$ is the GCD).</li>
<li>$q\gets\lfloor a/b\rfloor$ .</li>
<li>$a\gets a-bq$ and $y\gets y+qx$ .</li>
<li>Continue at 2.</li>
</ol>

<hr>

The question asks to apply that with $a=e=17$ and $m=\varphi(N)=40$.  

<ul>
<li>At step 1: &nbsp; $a=17$ , $b=40$ , $x=0$ , $y=1$ .</li>
<li>At steps 4/5: $q=2$ , $b=6$ , $x=2$, ( $a=17$ and $y=1$ unchanged)</li>
<li>At steps 8/9: $q=2$ , $a=5$ , $y=5$, ( $b=17$ and $x=2$ unchanged)</li>
<li>At steps 4/5: $q=1$ , $b=1$ , $x=7$, ( $a=5$ and $y=5$ unchanged)</li>
<li>At step 6, we output <em>"the desired inverse is"</em> $m-x=33$.</li>
</ul>

Thus $d=33$ is one (out of several) possible private exponents.  

#### Answer 3 (score 5)
<p>A useful way to understand the extended Euclidean algorithm is in terms of linear algebra.
(This is somewhat redundant to <a href="https://crypto.stackexchange.com/a/54477">fgrieu's answer</a>, but I decided to post this anyway, since I started writing this before fgrieu expanded their answer.  Hopefully the slightly different perspective may still be useful.)</p>

Let's say we're trying to find the inverse of $e$ modulo $\varphi$, i.e. a number $d$ such that $$de \equiv 1 \pmod \varphi.$$  In other words, given $e$ and $\varphi$, we wish to find an integer solution $(d, k)$ to the linear equation $$de + k\varphi = 1.$$  Of course, we know that this equation is only solvable if $\gcd(e,\varphi) = 1$.  More generally, if that's not the case, the best we can hope for is a solution to the generalized equation $$de + k\varphi = r,$$ where $r = \gcd(e,\varphi)$ is the smallest positive integer for which such a solution exists.  

As it happens, we already <em>have</em> several trivial solutions to this equation, including $$\begin{aligned}d_0 &amp;= 0,&amp; k_0 &amp;= 1,&amp; r_0 &amp;= \varphi,&amp; \text{and} \\ d_1 &amp;= 1,&amp; k_1 &amp;= 0,&amp; r_1 &amp;= e.\end{aligned}$$  

However, as noted above, we're specifically interested in solutions that minimize $r$, which these trivial solutions usually don't.  However, we hopefully remember from high school algebra that subtracting both sides of a valid equation from the respective two sides of another valid equation yields yet another valid equation: if $x = y$ and $p = q$, then $x - p = y - q$.  

Thus, assuming that $r_0 = \varphi &gt; r_1 = e &gt; 0$, we can obtain another solution with an even smaller (but still non-negative) $r$ by repeatedly subtracting both sides of the equation $d_1e + k_1\varphi = r_1$ from the corresponding sides of $d_0e + k_0\varphi = r_0$ until the resulting solution $$\begin{aligned}d_2 &amp;= d_0-a_1d_1,&amp; k_2 &amp;= k_0-a_1k_1,&amp; r_2 &amp;= r_0-a_1r_1,\end{aligned}$$ where $a_1$ is the number of times we've subtracted the smaller solution from the larger one, satisfies $r_2 &lt; r_1$.  In fact, we can even directly calculate the multiplier $a_1 = \left\lfloor\frac{r_0}{r_1}\right\rfloor$ (where $\lfloor x \rfloor$ denotes $x$ rounded down, i.e. the largest integer no greater than $x$) without having to do any actual repeated subtraction.  

Now we have a new solution $d_2e + k_2\varphi = r_2$, but the new $r_2$ might still not be minimal.  However, it <em>is</em> smaller than $r_1$, so we can repeat the same subtraction trick again to obtain yet another new solution $$\begin{aligned}d_3 &amp;= d_1-a_2d_2,&amp; k_3 &amp;= k_1-a_2k_2,&amp; r_3 &amp;= r_1-a_2r_2,\end{aligned}$$ where $a_2 = \left\lfloor\frac{r_1}{r_2}\right\rfloor$, and so on.  

More generally, given the two trivial initial solutions, we can keep constructing new solutions with smaller and smaller $r$ using the recurrence $$\begin{aligned}d_{i+1} &amp;= d_{i-1}-a_i d_i,&amp; k_{i+1} &amp;= k_{i-1}-a_i k_i,&amp; r_{i+1} &amp;= r_{i-1}-a_i r_i,\end{aligned}$$ where $a_i = \left\lfloor\frac{r_{i-1}}{r_i}\right\rfloor$.  

We can keep repeating this process until, eventually, we find that $r_i$ evenly divides $r_{i-1}$ (which implies that $r_{i+1}$ would be zero, which we don't want).  At that point, if $r_i = 1$, then the corresponding coefficient $d_i$ (reduced modulo $\varphi$) is the modular inverse of $e$ that we wanted.  

Otherwise, it's not hard to show that $r_i$ in fact evenly divides <em>all</em> $r_j$ for $0 \le j &lt; i$, including $r_0 = \varphi$ and $r_1 = e$, and is thus a nontrivial common divisor (in fact, the <em>greatest</em> common divisor) of $e$ and $\varphi$.  In particular, this implies that $e$ is not invertible modulo $\varphi$.  

<hr>

Ps. As fgrieu notes in their answer, it's not actually necessary to keep track of the $k_i$ coefficients if we're only interested in $d$ (and $r$).  Thus, an implementation of this algorithm only needs to store $r_i$, $d_i$, $r_{i-1}$, $d_{i-1}$ and the temporary value $a_i$.  (Some other temporary values may also be needed in practice, although it should be noted that $r_{i+1}$ and $d_{i+1}$ do <em>not</em> need to be stored separately in general, since they can immediately overwrite $r_{i-1}$ and $d_{i-1}$.)  

Here's a simple implementation in Python (which, conveniently, has arbitrary-precision integers built in):  



```cryptography
def modinv(e, phi):
    d_old = 0; r_old = phi
    d_new = 1; r_new = e
    while r_new > 0:
        a = r_old // r_new
        (d_old, d_new) = (d_new, d_old - a * d_new)
        (r_old, r_new) = (r_new, r_old - a * r_new)
    return d_old % phi if r_old == 1 else None
```

<sup><a href="https://tio.run/##VZDRCsIwDEXf9xV5EVqpbENRmOgn@AsiNGOF2Y44HX59zZa6aZ7S3Jzb3nbvvgl@Gy3WcA/W@ZdCA13jdJUBl72G1sIJiiNQallMkseBz@UoSYuTMDSuxTQ7QyFGY914RVzyXPRZUtNFRkw176mpM@kBG2bXSVwYEoZmhoShH4YWhrB/kk@OqzEHuPobi3MAtg@ES/AYO3K@V@lDyoOBXaF19j/dyzTGDw" rel="noreferrer" title="Python 3 – Try It Online">Try it online!</a></sup>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Signatures: RSA compared to ECDSA (score [63468](https://stackoverflow.com/q/3216) in )

#### Question
I'm signing very small messages using RSA, and the signature and public key are added to every message, which requires a lot of space compared to the actual content.  

I'm considering switching to ECDSA, would this require less space with the same level of encryption? And is the verification performance in the same range as RSA?  

#### Answer accepted (score 40)
<blockquote>
  I'm considering switching to ECDSA, would this require less space with the same level of encryption?  
</blockquote>

The answer to that question is yes, both ECDSA signatures and public keys are much smaller than RSA signatures and public keys of similar security levels.  If you compare a 192-bit ECDSA curve compared to a 1k RSA key (which are roughly the same security level; the 192-bit ECDSA curve is probably a bit stronger); then the RSA signature and public key can be expressed in 128 bytes each (assuming that you'll willing to use a space-saving format for the public key, rather than using the standard PKCS format); the ECDSA signature would be 48 bytes, and the public key would be 25 bytes.  

As you increase the required security level, the advantage tilts even more radically towards ECDSA; that's because you have to increase the RSA modulus size far faster than the ECDSA curve size to increase the security level.  

<blockquote>
  And is the verification performance in the same range as RSA?  
</blockquote>

Well, no, ECDSA signature verification is slower than RSA (for reasonable security levels).  That is the one place that RSA shines; you can verify RSA signatures rather faster than you can verify an ECDSA signature.  According to <a href="http://www.cryptopp.com/benchmarks.html">this web page</a>, on their test environment, 2k RSA signature verification took 0.16msec, while 256-bit ECDSA signature verification took 8.53msec (see the page for the details on the platform they were testing it).  Now to be fair, this isn't quite an apples-to-apples comparison (256-bit ECDSA is probably a bit stronger than 2k RSA), but even if the difference isn't quite 50x, RSA is still faster.  

I do have one question, though.  You mention that you are including the RSA public key along with the signed message.  Does that mean that the verifier uses that public key to verify the message?  If so, how do you know that someone who wants to forge a message won't just provide his own public key along with the signature (signed using his private key)?  That is, how does the receiver know that the public key he sees in the message is the one that was sent?  

#### Answer 2 (score 2)
For a 128 bit security level, you need 256 bit ECC. Compressed public keys need about 32 bytes, and signatures use 64 bytes.  

The verification time depends a lot on the choice of curve, representation and implementation. <a href="http://ed25519.cr.yp.to/software.html" rel="nofollow">Ed25519</a> Is supposed to be one of the fastest versions, especially if you use batch verification. But I'm not sure if it's possible to create a windows build of the optimized version.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How does one attack a two-time pad (i.e. one time pad with key reuse)? (score [63281](https://stackoverflow.com/q/2249) in 2017)

#### Question
My question might appear the same as the question <a href="https://crypto.stackexchange.com/questions/59/taking-advantage-of-one-time-pad-key-reuse">Taking advantage of one-time pad key reuse?</a>, but actually I did read all the answers and none of them helped me with the details I need.  

<p>I am new to cryptography and my problem is with two time pad attacks on OTP.
The problem I had in my course was that I have 10 ciphertexts encrypted with the same key $K$. I am then given another ciphertext that I should decrypt.</p>

I know that XOR-ing two ciphers gives me the XOR of their original messages.  

<strong>My question is what is the correct thing to do after that?</strong>  

I tried to take 3 ciphertexts $C_1, C_2$ and $C_3$.  

Then get $S_1 = C_1 \oplus C_2  \oplus $`' '`, also get $S_2 = C_1 \oplus C_3 \oplus$ `' '`.  

<p>After that I compared all corresponding characters in $S_1$ and $S_2$, 
and if $S_1[i] = S_2[i]$ then I calculate $S_1[i] \oplus C_2[i]$ to get $K[i]$.</p>

I tried this on paper before coding and it worked, but I might be missing something.  

Is this the right approach? Why does it work?  

#### Answer accepted (score 76)
Well, the classical answer to "what is the correct thing to do after you have the XOR of the two original messages" is crib-dragging.  

That is, you take a guess of a common phrase that may appear in one of the plaintexts (the classical example against ASCII english is the 5 letter " the "), and exclusive-or that against the XOR of the two original messages in various locations.  If one of the plaintexts had the text of the crib (" the " in our example), then the result of the exclusive-or is what the other plaintext had in that position; if neither plaintext had that, it's likely that the result of the exclusive-or is just gibberish.  And, once you have a plausible short section, you can extend it (for example, if you know that one of the plaintexts is " na*<em>*</em>", you can go through the dictionary of all words that start with "na", use those as cribs, and see which makes the other plaintext make sense).  

In addition, you can often deduce things directly from the bit pattern.  For example, if the messages are in ASCII, then one thing to note that bit 6 of letters is set, but bit 6 of spaces, numbers and (most) punctuation is clear; because spaces are far more common than numbers and punctuation, then that will give you a good guess of where spaces occur in the texts (albeit without telling you which message a specific space appears in).  

Now, if you have 11 messages all encrypted with the same pad (an "11-time pad"), things get even easier.  Obviously, you can grab a crib across one message, and check it against the other 10; if it makes all 10 make sense, then it is almost certainly accurate.  Even better, by using the observation that you can distinguish spaces from letters (again, by comparing bit 6), you can find where all the spaces appear in the messages; these all act like 1 character cribs, probably revealing virtually all the text of all the messages.  

#### Answer 2 (score 28)
In general, knowledge of $m_1 \oplus m_2$ is not enough to uniquely determine $m_1$ and $m_2$, even if both are known to be, say, English text.  For a simple example, $$\text{"one one"} \oplus \text{"two two"} = \text{"one two"} \oplus \text{"two one"}.$$  

However, in practice it <em>may</em> be possible to obtain fairly good guesses for $m_1$ and $m_2$; the typical methods are similar to those used for breaking classical ciphers, and rely on the fact that there's a lot of redundancy in English text (and in many other types of data).  

For example, one might start by guessing that at least one of the messages is likely to contain the word "the", probably surrounded by spaces.  So one can take the five-character string "` the `", XOR it with every five-character substring of $m_1 \oplus m_2$ and look for results that look like English (either by eye or by computer using statistical analysis).  

Now, let's say that one of the five-character substrings thus obtained is, say, "`messa`".  Now we (or a computer) could guess that the next two characters are likely to be "`ge`" (or perhaps "`gi`").  We can now XOR that with the next two characters of $m_1 \oplus m_2$ and see if the result fits naturally after "` the `"; if the result is, say, "`la`", we might tentatively assume our guess to have been right; if it's "`q%`", we <em>probably</em> guessed wrong.  We can proceed in this manner to confirm and extend our guess further, and perhaps eventually to connect separate guessed fragments together until we have a reasonable guess of all, or at least most, of the content of the two messages.  

#### Answer 3 (score 7)
I just came across this question and was surprised that no one referenced the paper: <a href="https://www.cs.jhu.edu/~jason/papers/mason+al.ccs06.pdf" rel="noreferrer">A Natural Language Approach to Automated Cryptanalysis of Two-time Pads</a> by Mason et al. at ACM CCS 2006. This shows how to solve this problem in an automated and intelligent way.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How big an RSA key is considered secure today? (score [62652](https://stackoverflow.com/q/1978) in 2012)

#### Question
I think 1024 bit RSA keys were considered secure ~5 years ago, but I assume that's not true anymore. Can 2048 or 4096 keys still be relied upon, or have we gained too much computing power in the meanwhile?  

Edit: Lets assume an appropriate padding strategy. Also, I'm asking both about security of signatures and security of data encryption.  

#### Answer accepted (score 124)
In the first decade of the 21st century, and counting, on a given <span class="math-container">$\text{year}$</span>, no RSA key bigger than <span class="math-container">$(\text{year} - 2000) \cdot 32 + 512$</span> bits has been openly factored other than by exploitation of a flaw of the key generator (a pitfall <a href="https://eprint.iacr.org/2012/064" rel="noreferrer">observed</a> in poorly implemented devices <a href="https://smartfacts.cr.yp.to/" rel="noreferrer">including Smart Cards</a>). This linear estimate of <em>academic</em> factoring progress should be used neither for long-term predictions (after 2016 or 1024-bits); nor for <em>choosing</em> a key length so as to be safe from attacks with high confidence (or, equivalently, conforming to standards with that aim), a goal best served by this website on <a href="https://www.keylength.com/" rel="noreferrer">keylength</a>.  

The current factoring record is <a href="https://eprint.iacr.org/2010/006" rel="noreferrer">768 bits, by the end of 2009</a>, and quoting this:  

<blockquote>
  it is not unreasonable to expect that 1024-bit RSA moduli can be factored well within the next decade by an academic effort.  
</blockquote>

<em>Update</em>: I emphasize that the above is about attacks <em>actually performed</em> by <em>academics</em>. So far, hackers have always been some years behind (see below). On the other hand, it is quite conceivable that well-funded government agencies are many years <em>ahead</em> in the factoring game. They have <a href="https://www.top500.org/lists/2017/11/" rel="noreferrer">the hardware and CPU time</a>. And there are so many 1024-bit keys around that it is likely a worthwhile technique to be in a position to break these. It is one of the most credible and <a href="https://www.schneier.com/blog/archives/2012/03/can_the_nsa_bre.html" rel="noreferrer">conjectured</a> explanation for <a href="https://www.wired.com/2012/03/ff_nsadatacenter/all/1/" rel="noreferrer">claims of a cryptanalytic breakthrough by the NSA</a>. Also, dedicated hardware could change the picture someday; e.g. as outlined by Daniel Bernstein and Tanja Lange: <a href="https://cr.yp.to/papers.html#batchnfs" rel="noreferrer"><em>Batch NFS</em></a> (in <a href="https://doi.org/10.1007/978-3-319-13051-4_3" rel="noreferrer">proceedings of SAC 2014</a>; also in <a href="https://eprint.iacr.org/2014/921" rel="noreferrer">Cryptology ePrint Archive</a>, November 2014).  

By 2018, the main <em>practical</em> threat to systems still using 1024-bit RSA to protect commercial assets often is <em>not</em> factorization of a public modulus (but rather, penetration of the IT infrastructure by other means, such as hacking, and trust in digital certificates issued to entities that should not be trusted). With 2048 bits or more we are safe from that factorization threat for perhaps two decades, with fair (but not absolute) confidence.  

<p><em>Update 2</em>: Factorization progress is best shown on a graph (to get at the raw data e.g. to make a better graph, edit this answer)


<img src="https://i.stack.imgur.com/VSwml.png" alt="Graph of academic RSA factorization records">  

This also shows the linear approximation at the beginning of this answer, which actually is a conjecture at even odds for the [2000-2016] period that I made privately circa 2002, and <a href="https://groups.google.com/forum/?fromgroups#!msg/fr.misc.cryptologie/F6ghzB_Pgx8/lSOpPFxOUwMJ" rel="noreferrer">committed publicly in 2004 (in French)</a>. Also pictured are the three single events that I know of hostile factorization of an RSA key (other than copycats of these events, or exploitation of flawed key generator):  

<ul>
<li><p>The <a href="http://baby.indstate.edu/msattler/_sci-tech/comp/privacy/pgp/misc/blacknet-key-attack.html" rel="noreferrer">Blacknet PGP Key</a> in 1995. Alec Muffett, Paul Leyland, Arjen Lenstra, and Jim Gillogly covertly factored a 384-bit RSA key that was used to PGP-encipher "the BlackNet message" spammed over many Usenet newsgroup. There was no monetary loss.</p></li>
<li><p>The French "YesCard" circa 1998. An individual factored the 321-bit key then used (even though it was clearly much too short) in issuer certificates for French debit/credit bank Smart Cards. By proxy of a lawyer, he contacted the card issuing authority, trying to monetize his work. In order to prove his point, he made a handful of counterfeit Smart Cards and actually used them in metro tickets vending machine(s). He was caught and got a <a href="https://www.legalis.net/jurisprudences/tribunal-de-grande-instance-de-paris-13eme-ch-correctionnelle-jugement-du-25-fevrier-2000/" rel="noreferrer">10 months suspended sentence (judgment in French)</a>. In 2000 the factorization of the same key <a href="https://groups.google.com/forum/?fromgroups#!msg/fr.misc.cryptologie/lKaAfKTeEM8/lNTX14KpYLsJ" rel="noreferrer">was posted (in French)</a> and soon after, counterfeit Smart Cards burgeoned. These worked with any PIN, hence the name <a href="https://web.archive.org/web/20060411051448/http://parodie.com/monetique/" rel="noreferrer">YesCard (in French)</a>. For a while, they caused some monetary loss in vending machines.</p></li>
<li><p>The <a href="https://www.ticalc.org/archives/news/articles/14/145/145154.html" rel="noreferrer">TI-83 Plus OS Signing Key</a> in 2009. An individual <a href="https://www.cemetech.net/projects/uti/viewtopic.php?t=8888&amp;start=0#entry135113" rel="noreferrer">factored</a> the 512-bit key used to sign downloadable firmware in this calculator, easing installation of custom OS, thus making him a hero among enthusiasts of the machine. There was no direct monetary loss, but the manufacturer was apparently less than amused. Following that, many 512-bit keys (including those of other calculators) have been factored.</p></li>
</ul>

<em>Update 3</em>: Definitely, 512-bit RSA was no longer providing substantial security by 2000-2005. Despite that, <a href="https://groups.google.com/forum/?fromgroups#!topic/mozilla.dev.security.policy/cn1sBm2ibWo" rel="noreferrer">reportedly</a>, certificates with this key size were issued until 2011 by official Certification Authorities and used to sign malware, possibly by means of a hostile factorization.  

#### Answer 2 (score 30)
You might want to look at <a href="http://csrc.nist.gov/publications/PubsDrafts.html#SP-800-57-Part%201">NIST SP800-57</a>, section 5.2. As of 2011, new RSA keys generated by unclassified applications used by the U.S. Federal Government, should have a moduli of at least bit size 2048, equivalent to 112 bits of security. If you are not asking on behalf of the U.S. Federal Government, or a supplier of unclassified software applications to the U.S. Federal Government, other rules might of course apply.   

However, at the very least, these figures indicate what the U.S. Federal Government thinks about the computational resources of it's adversaries, and presuming they know what they are talking about and have no interest in deliberately disclosing their own sensitive information, it should give some hint about the state of the art.  

#### Answer 3 (score 12)
The simplest answer would be to look at the <a href="http://www.keylength.com/" rel="noreferrer">keylength.com</a>  site, and if you don't trust that, to the linked papers, particularly by NIST and ECRYPT II. Note that those mainly agree with the Lenstra equations, so you could use those as well.  

You may have additional restrictions and - if you are brave or stupid - relaxations depending on the use case. But at least they establish a base line that you can work with.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How should I calculate the entropy of a password? (score [62423](https://stackoverflow.com/q/374) in 2016)

#### Question
If part of the password is a whole regular English word, does the entropy of that part depend on the number of English words in existence, the number of English words known by the choosing algorithm, the number of English words assumed by the attacker?  

Does the language matter, is the average entropy per word in German, French, Italian, or Spanish significantly different from the average entropy in English?  

Does a numeric digit always have an entropy of $\log_2(10) = 3.321928$?  

#### Answer accepted (score 89)
Entropy is a measure of what the password <em>could have been</em> so it does not really relate to the password itself, but to the <strong>selection process</strong>.  

We define the entropy as the value <span class="math-container">$S$</span> such the best guessing attack will require, on average, <span class="math-container">$S/2$</span> guesses. "Average" here is an important word. We assume that the "best attacker" knows all about what passwords are more probable to be chosen than others, and will do his guessing attack by beginning with the most probable passwords. The model is the following: we suppose that the password is generated with a program on a computer; the program is purely deterministic and uses a cryptographically strong PRNG as source of alea (e.g. `/dev/urandom` on a Linux system, or `CryptGenRandom()` on Windows). The attacker has a copy of the source code of the program; what the attacker does <em>not</em> have is a copy of the random bits that the PRNG actually produced.  

Entropy is easy to compute if the random parts of the selection process are uniform (e.g. with dice or a computer with a good PRNG -- as opposed to a human being making a "random" chance in his head). For instance, if you have a list of 2000 words and choose one among them (uniformly), then the entropy is <span class="math-container">$S = 2000$</span>. Entropy is often expressed in bits: an entropy of <span class="math-container">$n$</span> bits is what you get out of a sequence of <span class="math-container">$n$</span> bits which have been selected uniformly and independently of each other (e.g. by flipping a coin for each bit); it is a simple logarithmic scale: "<span class="math-container">$n$</span> bits of entropy" means "entropy is <span class="math-container">$S = 2^n$</span>" (and the attack cost is then <span class="math-container">$2^{n-1}$</span> on average).  

If you think of a password as two halves chosen independently of each other, then the total entropy is the product of the entropies of each half; when expressed with bits, this becomes a sum, because that's what logarithms do: they transform multiplications into sums. So if you take two words, randomly and independently (i.e. never ruling out any <em>combination</em>, even if the two words turn out to be the same), out of a list of 2000, then the total entropy is <span class="math-container">$2000\cdot2000 = 4000000$</span>. Expressed in bits, each word implies an entropy of about 11 bits (because <span class="math-container">$2^{11}$</span> is close to <span class="math-container">$2000$</span>), and the total entropy is close to 22 bits (and, indeed, <span class="math-container">$2^{22}$</span> is close to <span class="math-container">$4000000$</span>).  

This answers your question about digits: a decimal digit has entropy 10, as long as it is chosen randomly and uniformly and independently from all other random parts of the password. Since <span class="math-container">$10 = 2^{3.321928...}$</span> then each digit adds about 3.32 extra bits to the entropy.  

If a human being is involved in the selection process then calculating the entropy becomes much more difficult. For instance, if a human chooses two digits and the first digit is '4', then the probability that the second digit is '2' is quite higher than <span class="math-container">$\frac1{10}$</span>. It could be argued that it is also difficult <em>for the attacker</em>: he will also have more work to do to sort the potential passwords so that he begins with the most probable. But this becomes a psychological problem, where the attacker tries to model the thinking process of the user, and we try to model the thinking process of the attacker: it will be hard to quantify things with any decent precision.  

#### Answer 2 (score 12)
Information entropy is closely related to the "predictability" of the same information.  

When we talk about password entropy we are usually concerned with how easy it is for a password cracking software to predict a password. The more passwords the software has to try before guessing the password the larger the entropy is.  

You can check software like John the Ripper (http://www.openwall.com/john/). It's free and you can download for free a list of words from 20 different languages (to answer your question about different languages).  

Using this entropy concept, its easy to see that a digit in the middle of a word probably has more entropy than a digit in the end of a word. John will try words + 1~2 digits combinations pretty early in the attempts, so something like crypto5 has less entropy than cryp5to and uses the same characters.  

#### Answer 3 (score 4)
Basically, any password is a string of letters and entropy can be easily calculated. For example you can use <a href="http://www.shannonentropy.netmark.pl" rel="nofollow">Shannon entropy calculator</a> or by hand using a scientific calculator.   

Entropy is calculated based on frequencies of letters in the password, it does not care about used language. So diverse passwords with many different letters are preferred as entropy will be larger. Words are treated equally if they have the same proportions of used letters, e.g. English 'and' and Indonesian 'dan' has the same entropy). This means, contrary to what Paulo said earlier, that 'cryp5to' and 'crypto5' has the same entropy, entropy does not care about letter order. If you do not believe this, try it yourself by entering similar examples into <a href="http://www.shannonentropy.netmark.pl" rel="nofollow">http://www.shannonentropy.netmark.pl</a>    

Of course, if an attacker will assume that your password is a word, not a random string (most people do that) he will use a dictionary to break your password and he will break it earlier, but his knowledge that you use a word, not a random string is actually information which decreases entropy, so he used external information to lower the entropy needed to break it.   

<p>"Does the entropy of that part depend on the number of English words in existence, ..." 
NO, it depends on all the combinations which can be done based on password length and diversity. </p>

<p>"... the number of English words known by the choosing algorithm..." 
it may affect the algorithm, but not from an entropy point of view, e.g. if this algorithm will be: just try all words from dictionary in which there is no crypto5, but crypto is present, it fails, but if the algorithm is more clever, for instance take all words from dictionary and mutate them by random letter or number it will finally find crypto5. </p>

<p>" ... the number of English words assumed by the attacker?" 
it may affect the algorithm, but not from an entropy point of view, see above, and remember you do not know who and how will hack your password, so you cannot assume anything like I will use different language, because it has more words, but on the other hand you can use different language if it has more letters (and you will use them in the password).</p>

<p>"Does the language matter, is the average entropy per word in German, French, Italian, or Spanish significantly different from the average entropy in English?" 
You can calculate entropy for different languages (actually this is what Shannon did), but again it does not influence the entropy of the password. </p>

<p>"Does a numeric digit always have an entropy of $\log_2(10) = 3.321928$?" 
No, base 2 is the most common, and it has nothing to numeric digits, it can be used also to letters or any other signs, see Wikipedia [information theory entropy]</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: What are the advantages of TOTP over HOTP? (score [61084](https://stackoverflow.com/q/2220) in 2017)

#### Question
HMAC-based One Time Password (HOTP) was published as an informational IETF RFC 4226 in December 2005. In May, 2011, Time-based One-time Password Algorithm (TOTP) officially became RFC 6238. What advantages does it introduce?  

#### Answer accepted (score 56)
One of the advantages is purely on the human side of security. From RFC 6238's abstract:  

<blockquote>
  <p>The
     HOTP algorithm specifies an event-based OTP algorithm, where the
     moving factor is an event counter.  The present work bases the moving
     factor on a time value.  A time-based variant of the OTP algorithm
     provides <strong>short-lived OTP values, which are desirable for enhanced
     security</strong>.</p>
</blockquote>

(Emphasis mine.)  

The TOTP passwords are short-lived, they only apply for a given amount of human time. HOTP passwords are potentially longer lived, they apply for an unknown amount of human time.  

The reference to "enhanced security" is referencing (at least) two areas: The value of a compromised key, and ability to attack one.  

First, should a current HOTP password be compromised it will potentially be valid for a "long time". Ensuring frequent use of the HOTP in human time is not a part of the HOTP design, so it is unknown how long the current HOTP password will be valid for and we have to assume the worst case, namely, that it will be a "long" time. This allows the attacker to use a compromised password at their leisure. But should the current TOTP be compromised, it will not be useful for very long because in one TOTP time increment it will be invalidated. Of course, in theory the attacker could grab and use the password in negligible time, but it does prevent a practical human aspect. For example, someone who gets a look at your current Paypal key (which rotates every 30 seconds, IIRC) can't go home and try to use it later, they would have to lunge for a computer in the moment. Someone who compromises they key may not realize it until after the key has expired. Etc.  

Second, if you are attacking a key, your work is potentially invalidated or set back every time increment of the TOTP because the target has moved. Perhaps an attacker has discovered an attack against an OTP scheme that allows them to predict the next password only if they have some number of the last 10 passwords, but it takes about 2 hours of computing time to do so. If the OTP changes every minute, their attack is pretty much useless. Brute-force attacks are inhibited as well, because the next password is chosen the same distribution each time; it is possible to brute-force exhaust the password space and not find the password. TOTP doesn't eliminate those sorts of attacks, but hopefully it limits which ones have the ability to be effective.  

#### Answer 2 (score -6)
Neither is worthwile.  Changing number codes were invented by RSA in 1984 to block keyloggers. More than 90% of todays internet breakins take place as a result of phishing, and we're seeing incidence of entire countries having more malware infected machines than clean ones (the boleto bandits, have pocketed $1bn cash so far, &amp; are still going strong).  

TOTP and HOTP are almost completely ineffective against todays' risks.  

You need solutions that include mutual authentication, and transaction verification, not 30-years-old gizmos.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: What are the chances that AES-256 encryption is cracked? (score [59357](https://stackoverflow.com/q/46559) in 2017)

#### Question
I'm currently building a web application and would like to encrypt all data on the back-end. I was thinking of using the AES-256 encryption but wasn't sure how safe it was. I did that math and felt safe.  

I took this model to a professor at my college, who is a cyber security expert, and he seemed to have quite a different take. He told me there are only two encryption schemes that he knows of that cannot be broken, and AES is not one of them. He said sure, put it in, but just know that there are people out there who can crack it.  

<p>I Googled everything I could about the AES and it being cracked, and the only information I could find was <a href="https://eprint.iacr.org/2009/241.pdf" rel="noreferrer">this paper: Distinguisher and Related-Key Attack on the Full AES-256
(Extended Version)</a>. Sure it says the AES has been cracked but is still has a practical use, right? I believe it is $2^{231}$ instead of $2^{256}$.</p>

So what gives? Is it practically secure to use or not? Does he just know something that most people don't? If my web application database credentials are somehow exposed, and a hacker gets the raw encrypted data, how can I ensure he won't be able to decrypt it within his lifetime?  

#### Answer accepted (score 78)
<blockquote>
  He told me there are only two encryptions that he knows of that cannot be broken, and AES is not one of them  
</blockquote>

This tells me you asked your professor the wrong question.  You asked a cyber security expert if an algorithm could be cracked, to which the answer is <strong>always</strong> yes, with the exception of a handful of inconvenient algorithms, such as One Time Use Pads used in exactly the correct way.  Even in those cases, there's exploits to worry about.  

AES-256 is an algorithm.  It can be broken.  If you look at the history of cryptography, every algorithm gets broken eventually.  That's why we make new algorithms.  The question is how long it takes to figure out the math to break it.  

The real question to ask is "what is your threat model?"  What sort of attack are you trying to prevent?  Are you creating a digital lock on a diary to keep it safe from your sister's prying eyes, or are you Edward Snowden, on the run from several three letter agencies with billions of dollars of funding?  

AES-256 is currently labeled as sufficient to use in the US government for the transmission of TOP SECRET/SCI information.  That's pretty much the highest classification level they could clear it for, so the US government is pretty darn confident that nobody can break AES-256 on the timescales required to protect our nation's greatest secrets.  

(Well, almost.  What it really says is that they are confident that nobody <em>outside of the US government</em> can break AES-256.  What you believe that that says about whether the US government, themselves, can break it depends on your threat model... and whether you engage in discussions of whether heavy-duty tin foil  makes better hats or not)  

#### Answer 2 (score 51)
AES-256 - the block cipher - as far as we know hasn't been broken. It has not even been close to broken. On the other hand, we cannot prove that it is secure. That means that an algorithm that is able to crack AES may be found. Most ciphers cannot be <em>proven</em> to be secure. Only a handful algorithms such as the one-time-pad are secure in the information-theoretical sense.  

The paper you point to is about related key attacks. These attacks are indeed possible and they reduce the strength of AES <em>for specific use cases</em> to a value that theoretically breaks the cipher. Basically you should not use AES-256 to build a hash function. Practically, for achieving confidentiality, AES-256 is still considered secure, even against attacks using quantum cryptanalysis.   

Having a secure block cipher doesn't provide any security on its own though. You need a secure system, and for that secure system you <em>may</em> need a secure protocol. And in that protocol you <em>may</em> need a scheme or a mode of operation (such as GCM). And that encryption scheme may require a block cipher. And that block cipher may be AES-256.  

The AES-256 algorithm itself requires a well protected secret key and secure implementation - such as protection against side channel attacks, where required - to be considered secure. It could for instance be made FIPS compliant.  

Although the AES-256 algorithm is considered secure, that doesn't mean your scheme, protocol or system is secure. For this you need a threat model and show that it is practically secure against all possible attack vectors.  

<hr>

TL;DR: when building a secure system you may use AES-256, it's considered secure <em>even if this cannot be proven</em>. Other aspects of the system are much more likely to fail than AES-256 - the block cipher by itself.  

#### Answer 3 (score 22)
<blockquote>
  So what gives? Is it safe to use or not?  
</blockquote>

You seems to change what you are asking about from phrase to phrase. You ask if it is cracked, you ask if it is secure to use, you ask if it is "practical"...  

AES-256 is indeed cracked, because it doesn't hold its original 256bit security. You ask if it is secure - security isn't a yes/no question, it is 231bit secure, and common wisdom is that 128bit+ is "pretty secure", and 90bit- is close to practically broken.  

<blockquote>
  <p>He said sure, put it in, but just know that there are people out there
  who can crack it.</p>
</blockquote>

This thought seems to persist because you can't prove something doesn't exist. There isn't any information that would suggest that AES is practically broken. If you had trillions of dollars you would be better of hiring security experts to hopefully find weaknesses somewhere to reduce complexity to something manageable than to build massive computer clusters. This is indeed how certain three-letter-agencies break some algorithms (and especially their implementations). This of course didn't apply to AES-256 or so we hope, but countless implementations were broken because they did misuse something.  

<blockquote>
  How do I defend my web application from a professional hacker?  
</blockquote>

This has nothing to do with encryption or cryptography. There is misconception that encryption gives you security. What we should ask is what kind of security it gives you.  

Does it protect your children on their way to school? Does it protect your house from burning down? Last I heard no.  

Instead treat encryption and cryptography as a tool. It might work as smoke detectors/making house of nonflammable materials.  

Does smoke detection prevent you from anything if you don't change batteries? No. Does house made of nonflammable materials prevent anything if build over it with all wood? No. Instead encryption has its dependencies (only people who are supposed to know the key, do know te key), and something that it gives you (people who don't have the key can't read message).  

So question you ask shouldn't be "Is AES-256 secure and does it repel hackers?" but instead "what tools/techniques should I use to prevent/detect X?", only then you should focus on tools to do the job.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: AES256-CBC vs AES256-CTR in SSH (score [57843](https://stackoverflow.com/q/18538) in 2014)

#### Question
I used AES256-CBC to SSH to a remote server. Recently, it stopped working with the following message:  

```cryptography
no matching cipher found: client aes256-cbc server  
aes128-ctr,aes256-ctr,arcfour256,arcfour,3des-cbc
```

When I used AES256-CTR as a cipher to SSH to the server, it worked as expected.  

I read <a href="https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation" rel="noreferrer">this</a> article which outlines the following:  

<blockquote>
  <p>CBC (Cipher-block chaining)<br>
   Encryption parallelizable: No<br>
   Decryption parallelizable: Yes</p>
  
  <p>CTR (Counter)<br>
   Encryption parallelizable: Yes<br>
   Decryption parallelizable: Yes</p>
</blockquote>

Is <em>“Encryption parallelization”</em> necessary in SSH?  

Any other advantages of AES256-CTR over AES256-CBC used in SSH except being more robust against padding oracle attacks?  

#### Answer accepted (score 9)
Other advantages of CTR are:  

<ul>
<li>easier to decrypt from a certain offset within the ciphertext</li>
<li>no randomness requirements for the nonce
<ul>
<li>nonce can be calculated, e.g. be a simple counter</li>
<li>nonce can be a message identifier </li>
</ul></li>
<li>$E = D$: encryption is the same as decryption, which means
<ul>
<li>only encryption or decryption required from the block cipher</li>
<li>less logic required</li>
</ul></li>
<li>no padding overhead or mechanism required</li>
<li>key stream can be pre-calculated (latency advantages)</li>
</ul>

Draws:  

<ul>
<li>sequential speed the same (about the same number of ciphertext blocks)</li>
<li>cryptographic security (when used properly)</li>
</ul>

Disadvantages:  

<ul>
<li>nonce reuse is catastrophic, confidentiality is completely lost</li>
<li>leaks somewhat more information about the size of the plaintext</li>
<li>multiple, slightly different schemes with regards to IV creation and the method that the nonce is used</li>
<li>still less common in libraries or known by (starting) developers</li>
</ul>

Another questionable disadvantage is that CTR has no error propagation, but that should probably be considered an advantage by now; if you want integrity, use an authentication tag (MAC or signature).  

<hr>

You can attack CBC and CTR using different methods, with different consequences. If CBC mode has problems in a certain protocol, then switching to another mode has its advantages of course. See the answer of Thor for good reason to switch to CTR for OpenSSH specifically.  

That's probably a better reason to disable CBC than the reasons given above. If you want to know for sure, you should ask the OpenSSH developers though (or the person that disabled CBC-mode, anyway).  

#### Answer 2 (score 6)
<p>There seems to be an attack on SSH when using CBC: <a href="http://www.isg.rhul.ac.uk/~kp/SandPfinal.pdf" rel="noreferrer">Plaintext Recovery Attacks Against SSH</a>.
I have just scanned the paper and they state, that this will not be possible when CTR mode is used. I don't think that en-/decryption parallelization is need or even utilized in SSH.</p>

Update: Link to CERT concerning the topic: <a href="http://www.kb.cert.org/vuls/id/958563" rel="noreferrer">Vulnerability Note VU#958563 SSH CBC vulnerability</a>  

#### Answer 3 (score 0)
Parallelization is not a necessity but it can help to speed things up if you have a multicore processor. This is because of the parallel nature of CTR mode where the blocks are encrypted independently of each other.  

Another main advantage, besides being parallelizable, is that unlike CBC, CTR mode can perform certain calculations offline to prepare the key stream. When the PT/CTXT blocks are available, it simply XORs the PT/CTXT with the key stream online to generate CTXT/PT, decreasing the latency of the system.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Why can't we reverse hashes? (score [57249](https://stackoverflow.com/q/45377) in 2017)

#### Question
First off, I know hashes are 1 way. There are an infinite number of inputs that can result in the same hash output. Why can't we take a hash and convert it to an equivalent string that can be hashed back to the original hash output?  

eg:  

```cryptography
string: "Hello World"
hashed: a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e 

unhash: "rtjwwm689phrw96kvo48rm64unc8oetb5kmrjiuh7h8huhi6dde5n5"
        (a real string that gives the same hash as "Hello World")
hashed: a591a6d40bf420404a011733cfb7b190d62c65bf0bcda32b57b277d9ad9f146e 
```

...  

#### Answer 2 (score 222)
Take a simple mathematical operation like addition. Addition takes 2 inputs and produces 1 output (the sum of the two inputs). If you know the 2 inputs, the output is easy to calculate - and there's only one answer.  

`321 + 607 = 928`  

But if you only know the output, how do you know what the two inputs are?  

```cryptography
928 = 119 + 809
928 = 680 + 248
928 = 1 + 927
...
```

Now you might think that it doesn't matter - if the two inputs sum to the correct value, then they must be correct. But no.  

What happens in a real hash function is that hundreds of one-way operations take place sequentially <strong>and the results from earlier operations are used in later operations</strong>. So when you try to reverse it (and guess the two inputs in a later stage), the only way to tell if the numbers you are guessing are correct is to work all the way back through the hash algorithm.  

If you start guessing numbers (in the later stages) wrong, you'll end up with an inconsistency in the earlier stages (like 2 + 2 = 53). And you can't solve it by trial and error, because there are simply too many combinations to guess (more than atoms in the known universe, etc)  

In summary, hashing algorithms are specifically designed to perform lots of one-way operations in order to end up with a result that cannot be calculated backwards.  

Update  

<p>Since this question seems to have attracted some attention, I thought I'd list a few more of the features hashing algorithms
use and how they help to make it non-reversible. (As above, these are basic explanations and if you really want to understand, <a href="https://en.wikipedia.org/wiki/Cryptographic_hash_function" rel="noreferrer">Wikipedia is your friend</a>).</p>

<ul>
<li><p><strong>Bit dependency</strong>: A hash algorithm is designed to ensure that each bit of the output is dependent upon every bit in the input. This prevents anyone from splitting the algorithm up and trying to reverse calculate an input from each bit of the output hash separately. 
In order to solve just one output bit, you have to know the entire input. In other words, when reversing a hash, it's all or nothing.</p></li>
<li><p><strong>Avalanching</strong>: Related to bit dependency, a change in a <em>single bit</em> in the input (from 0 to 1 or vice-versa) is designed to
result in a huge change in the internal state of the algorithm and of the final hash value. Since the output changes so dramatically with each input bit change, this stops people from building up relationships between inputs and outputs (or parts thereof).</p></li>
<li><p><strong>Non-linearity</strong>: Hashing algorithms always contain non-linear operations - this prevents people from using linear algebra techniques
to "solve" the input from a given output. Note the addition example I use above is a linear operation; building a hash algorithm using
just addition operators is a really bad idea! In reality, hashing algorithms use many combinations of linear and non-linear operations.</p></li>
</ul>

All of this adds up to a situation where the easiest way of finding a matching hash is just to guess a different input, hash it and see if it matches.  

<p>Lastly, if you <em>really</em> want to know how hard reversing a hash is, there's no better substitute than just trying it out for yourself. 
All good hashing algorithms are openly published and you can find plenty of code samples. Take one and try to code a version that reverses each step; you'll quickly discover why it's so hard.</p>

#### Answer 3 (score 33)
Cryptographically secure hashes were specifically build to (among other things) make what you're asking hard!  

Now, you <em>could</em> try to create an appropriate dictionary of all hashes, hoping to find appropriate pairs... but it would take more storage space than the total storage space that's currently available on our planet and more computing power than you'll be able to get access to in this universe (at least, at the time of writing this) — which is why we call it "infeasable".  

In your theoretical example, the collision would be the strings "Hello World" and "rtjwwm689phrw96kvo48rm64..." both producing the same hash `a591a6d40bf420404a011733...`  

For SHA-2 and SHA-3, such pairs are not known up until today. If, such a (once cryptographically secure) hash would have to be considered as broken due to collisions.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How does asymmetric encryption work? (score [54321](https://stackoverflow.com/q/292) in 2011)

#### Question
I've always been interested in encryption but I have never found a good explanation (beginners explanation) of how <strong>encryption</strong> with public key and <strong>decryption</strong> with private key works.  

How does it encrypt something with one key and decipher it with another key?  

#### Answer accepted (score 40)
Generally speaking, the public key and its corresponding private key are linked together through their internal mathematical structure; such keys are not "just" arbitrary sequences of random bits. The encryption and decryption algorithms exploit that structure.  

One possible design for a public key encryption system is that of a <a href="http://en.wikipedia.org/wiki/Trapdoor_function" rel="noreferrer">trapdoor permutation</a>. A trapdoor permutation is a mathematical function which is a permutation of some space, such that computing the function in one way is easy, but the reverse is hard, <em>unless</em> you know some information on how the trapdoor permutation was built. Encryption is applying the function on a message, decryption is about using the trapdoor to reverse the function.  

For <a href="https://en.wikipedia.org/wiki/RSA_(cryptosystem)" rel="noreferrer">RSA</a>, a well-known asymmetric encryption algorithm, consider a rather big (say 300 digits or more) integer $n$. $n$ is composite: it is the product of two big prime integers $p$ and $q$. There are more such composite integers than there are particles in the observable universe, so there is no problem in generating such an integer. $n$ is called the <em>modulus</em> because we will compute things <a href="http://en.wikipedia.org/wiki/Modular_arithmetic" rel="noreferrer">"modulo $n$"</a>. It turns out that:  

<ul>
<li>it is easy to compute cubes modulo $n$ (given $m$, compute $m^3 \mod n$);</li>
<li>if $p$ and $q$ were chosen appropriately (I skip the details), raising to the cube is a permutation modulo $n$ (no two integers modulo $n$ will have the same cube, so any integer between $0$ and $n-1$ has a unique cube root modulo $n$);</li>
<li>computing the cube root of an integer modulo $n$ is extremely hard</li>
<li>... unless you know $p$ and $q$, in which case it becomes computationally easy;</li>
<li>recovering $p$ and $q$ from $n$ (that's <a href="http://en.wikipedia.org/wiki/Integer_factorization" rel="noreferrer">factorization</a>) is extremely hard.</li>
</ul>

So the public key is $n$, the trapdoor permutation is raising to the power 3, and the reverse is computing a cube root; knowledge of $p$ and $q$ is the private key. The private key can remain "private" even if the public key is public, because recomputing the private key from the public key is a hard problem.  

There is a bit more to RSA than the description above (in particular, RSA does not necessarily uses the power 3), but the gist of the idea is there: a function which is one-way for everybody, except for the one who selected the function in the first place, with a hidden internal structure which he can use to reverse the function.  

<a href="http://en.wikipedia.org/wiki/Transport_Layer_Security" rel="noreferrer">SSL</a> (now known as TLS) is a more complex beast which usually uses some asymmetric encryption during the initial stages of the connection, so that client and server end up having a "shared secret" (a commonly known sequence of bits); the shared secret is then used to apply conventional encryption and decryption to the rest of the data ("conventional" meaning: same key to encrypt and decrypt).  

#### Answer 2 (score 25)
A lot of answers have said "a mathematical structure" which is absolutely right, but I still see there might be a question: how on earth can one exist? I'll try and fill that gap at a simpler level.  

So a simple caeser-shift cipher might look like this: $x+7$. In our really simplistic, dangerous example, the "key" here is $7$. If I have some encrypted text, I know that by subtracting $7$, I get back to $x$. Therefore, this is a really simple example of a symmetric cipher, because what I do one way also allows me to undo it.  

As you might have noticed, most domains in cryptography are finite - for example, there are only 26 letters in the alphabet. At some point you need to "wrap around". Mathematics provides us with a technique to do this called modulo arithmetic. Essentially, under a modulus, you can think "if I divide this by the modulus, the number I have is the remainder". some examples:  

<ul>
<li><p>$4 = 4 \mod 7$</p></li>
<li><p>$8 = 1 \mod 7$ (8/7 = 1 remainder 1)</p></li>
<li><p>$4+7 = 4 \mod 7$ (11/7 = 1 remainder 4)</p></li>
<li><p>$-3 = 4 \mod 7$ (not so hard... what happens when you add 7 to -3?)</p></li>
</ul>

As you can see, arithmetic holds under modulo. Undergraduate mathematics courses rigorously establish these truths and if you're interested, read up on Number and Group theory. The next step is to understand that multiplication also holds:  

<ul>
<li>$2*4 = 1 \mod 7$ (2*4 = 8, as above)</li>
<li>$5*3 = 1 \mod 7$ (5*3 = 15, 15/7 = 2 remainder 1)</li>
</ul>

and so on. Multiplication in mathematics often throws up some problems when it comes to inverses - for example, how do I go from 1 back to 5? I can multiply by 5. How do I go back to 2 from 1? Multiply by 2. These examples are not quite right in terms of what I wanted to show, so here are some more:  

<ul>
<li>$6*3 = 4 \mod 7$ (6*3=18. 18/7 = 2 remainder 4)</li>
<li>$4*5 = 6 \mod 7$ (4*5=20. 20/7 = 2 remainder 6).</li>
</ul>

With these examples, I've shown that you can go from 6 to 4 and back to 6 using multiplication, but by multiplying by different things.  

This is one, very simple way to create such a mathematical structure. The genius of RSA is choosing the numbers involved in such a way that one can easily determine how to get to an encrypted value, but not back again. I've explained it fully <a href="https://crypto.stackexchange.com/questions/388/what-is-the-relation-between-rsa-fermats-little-theorem/398#398">in another answer</a>; however, in essence, it is simply a more complicated version of what we've done here. The clever part is understanding those structures and which choices of numbers make good/bad keys and which work/do not.  

<strong>But you're telling me multiplication is hard to undo: what about division?</strong>  

Firstly, it really depends on circumstances. Under some circumstances, like the trivial example I present above, finding an inverse or even using division <em>is</em> easy. It's important to think about what division means. In a rational (any number you can write as a fraction) field, multiplicative inverses exist in the form $p * (1/p)$ (as well as $p*q = 1$).   

However, when considering RSA, note that encryption is $t\times t\times \ldots = t^e = c \mod n$ for some public key $e$. So to compute the inverse, we'd need to compute $c \times (1/t) \times (1/t) \times \ldots = c \times (1/t)^e \mod n$. The reason for this is that each multiplication of $t$ needs to be undone by an inverse $(1/t)$ but it should be clear that if we only have the ciphertext $c$, we don't know $t$ to compute $1/t$.   

So our next possible route is to compute $c^{1/e}$ as $t^{e*1/e} = t$. This is equivalent to computing the eth-square root of $c$ (for example, $x^{1/2} = \sqrt{x}$) which is hard to do when under a modulus of the size that RSA requires you use - under certain circumstances. Under others, it's known as the "cube root" attack: see <a href="https://crypto.stackexchange.com/questions/388/what-is-the-relation-between-rsa-fermats-little-theorem/398#398">this presentation</a> and <a href="http://www.ee.ic.ac.uk/pcheung/teaching/ee4_network_security/L06RSA.pdf" rel="noreferrer">this one</a>.  

<p>Other public key crypto systems use similar observations - for example, Diffie-Hellman relies on this property:
$$a^x = b \mod n$$
Under certain cases of n (for example $(\mathbb{Z}_p, \times )$ i.e. when n is prime and we are interested only in multiplication and therefore a is greater or equal to 1) this is hard to reverse. This forms the basis of a number of other public cryptosystems.</p>

#### Answer 3 (score 5)
At a basic level, the client (i.e. your browser) and the server negotiate a key exchange algorithm to derive a random session key and then they use that private key to encrypt traffic with a symmetric algorithm.  

There's a lot of detail to the process and I wrote about this extensively on my blog: <a href="http://www.moserware.com/2009/06/first-few-milliseconds-of-https.html" rel="nofollow">The First Few Milliseconds of an HTTPS Connection</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: AES256-GCM - can someone explain how to use it securely (ruby) (score [53386](https://stackoverflow.com/q/17999) in 2014)

#### Question
I am looking into using AES256-GCM for encrypting some database fields. I know that for AES256-CBC, I need to generate a new IV for each encrypt, but I can use the same key. The IV can be openly stored alongside the ciphertext (ie, it can be public).   

I started to read about GCM, but I don't quite understand some things. On this <a href="https://crypto.stackexchange.com/questions/15699/leaving-authentication-data-blank-less-secure-for-aes-gcm?lq=1">Stackexchange Thread</a>, it is stated that:  

<ul>
<li>GCM does not need an IV supplied.</li>
<li>Associated Tag is not necessary, but may improve security (example they gave is using a database id)</li>
</ul>

But <a href="http://en.wikipedia.org/wiki/Galois/Counter_Mode">Wikipedia states about GCM</a>:  

<blockquote>
  GCM has been proven secure in the concrete security model.<sup>[<a href="http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.1.4591">13</a>]</sup> It is secure when it is used with a block cipher mode of operation that is indistinguishable from a random permutation; however security depends on choosing a unique initialization vector for every encryption performed with the same key (see <a href="http://en.wikipedia.org/wiki/Stream_cipher_attack">stream cipher attack</a>).  
</blockquote>

<ol>
<li><p>Which implies that the IV still needs to be randomly generated and supplied for each encrypt with GCM, so why does the user in the stackexchange answer post say that we are not required to provide the IV?</p>

Wikipedia also states:  

<blockquote>
  The authentication strength depends on the length of the authentication tag, as with all symmetric message authentication codes. However, the use of shorter authentication tags with GCM is discouraged. The bit-length of the tag, denoted t, is a security parameter. In general, it may be any one of the following five values: 128, 120, 112, 104, or 96.  
</blockquote></li>
<li><p>In OP's post in that stackexchange thread, OP uses `tag = cipher.auth_tag`. Is this by default 96? If so, is there a way to change it? Are there significant performance issues in using 128 than 96?</p></li>
<li><p>Does both the Associated Tag (`cipher.auth_data`) and the Authentication Tag (`cipher.auth_tag`) need to be kept secret? Or can they be kept open like the IV? </p></li>
<li><p>Finally, can someone explain further what is meant by the Associated Tag? The example in the answer that was given in OP's thread was that we can use a database id to ensure that the data belongs to a certain database user. Let's say that a user has the following database fields:</p>

```cryptography
User
- primary_id
- encrypted_email
```

And we want to encrypt the User's email before insertion. With User `primary_id==10` (modifying OP's ruby code):  

```cryptography
cipher = OpenSSL::Cipher::AES.new(128, :GCM)
cipher.encrypt
key = cipher.random_key
iv = cipher.random_iv
cipher.auth_data = "10"    # Using DB user's id!

encrypted = cipher.update(data) + cipher.final
tag = cipher.auth_tag
```

I replaced `cipher.auth_data` with the database user's primary_id. Is this correct?  </li>
</ol>

#### Answer 2 (score 44)
<p>Before answering your questions: 
GCM is an authentication encryption mode of operation, it is composed by two separate functions: one for encryption (AES-CTR) and one for authentication (GMAC). 
It receives as input:</p>

<ol>
<li>a Key</li>
<li>a unique IV</li>
<li>Data to be processed only with authentication (associated data)</li>
<li>Data to be processed by encryption and authentication</li>
</ol>

It outputs:  

<ol>
<li>The encrypted data of input 4</li>
<li>An authentication TAG</li>
</ol>

The authentication TAG is an input to the decryption, if someone tampered with your associated data or with your encrypted data, GCM decryption will notice this and will not output any data (or return an error and you should discard the received data without processing it)  

Now:  

<blockquote>
  <p>Which implies that the IV still needs to be randomly generated and supplied for each encrypt with GCM, so why does the user in the
      stackexchange answer post say that we are not required to provide
      the IV?</p>
</blockquote>

<p>GCM requires an IV, it is used both by AES-CTR and by AES-GMAC, so no matter what you are doing with GCM, you need to pass an IV.
It is required to be unique <strong>not</strong> necessarily random. Usually implementations takes a 96-bit IV and this is the recommended way to use GCM according to <a href="http://csrc.nist.gov/publications/nistpubs/800-38D/SP-800-38D.pdf">NIST</a>. </p>

<blockquote>
  <p>In OP's post in that stackexchange thread, OP uses tag = cipher.auth_tag. Is this by default 96? If so, is there a way to
      change it? Are there significant performance issues in using 128
      than 96?</p>
</blockquote>

By default the authentication tag is 128 bit. You should provide the authentication TAG to the receiver of your message, so in some applications make sense to use a smaller tag. Keep in mind that the smaller tag you have, the more collisions you might get. If bandwidth is not an issue, use 128.  

See also the detailed section on auth_tag([ tag_len ] → string <a href="http://ruby-doc.org/stdlib-2.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html">here</a>  

<blockquote>
  Does both the Associated Tag (cipher.auth_data) and the Authentication Tag (cipher.auth_tag) need to be kept secret? Or can they be kept open like the IV?  
</blockquote>

<p>The associated data (incorrectly you wrote Associated Tag) is used for data to be publicly known. Examples are headers or destination address. So it's not required to be secret, but if need to encrypt everything, then set the associated data to "".
The authentication Tag is not required to be secret and in fact it must be provided to the receiver unencrypted (like the IV).</p>

<blockquote>
  Finally, can someone explain further what is meant by the Associated Tag? The example in the answer that was given in OP's thread was that we can use a database id to ensure that the data belongs to a certain database user. Let's say that a user has the following database fields:  
</blockquote>

<p>It looks like you confuse the authentication data and authentication tag.
The authentication data (or associated data) is something that you want to protect with authentication (if somebody modifies it you will know) but don't need to be encrypted. As stated above this is usually the case for headers which must be read by intermediate routers which can't decrypt the encrypted message. </p>

The authentication Tag will depend upon the data you encrypt and on the associated data. So in decryption you will need to process also the associated data or you will fail.  

<p>In your example, which is not very clear to me, you authenticate the primary id and the email and you encrypt the email. If you store in your db both the IV and the TAG then you can decrypt the email if needed.
Without an authentication tag an attacker could copy the email of user1 to the email of user2, if he also copy the IVs, then when you will look up for the email of user2 you will successfully decrypt the email of user1 without noticing anything.</p>

Instead if you also use a TAG and process as associated data the id of the corresponding user, then an attacker could not do the previous attack, because in decryption will we notice the associated data wasn't the one used in encryption and the operation will fail (you will know someone tampered with user2 data).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: Does the SHA hash function always generate a fixed length hash? (score [52309](https://stackoverflow.com/q/2144) in 2013)

#### Question
I'm using the SHA1/2 family of algorithms for a particular project. I was wondering if all the SHA algorithms return a fixed length hash regardless of the length of the data.  

#### Answer accepted (score 14)
Essentially yes, they do.  

Depending on the exact hash function you choose depends on the length of output you'd expect. For example, SHA256 produces 256 bits of output.  

This does then beg the question "but the length of the hash is fixed and there are infinite possible inputs??!!". That's correct, except that $2^{256}$ is 115792089237316195423570985008687907853269984665640564039457584007913129639936. That's an awful lot of unique possible inputs which may be passed in.  

You may be interested to know the same concept is used in file systems - they're called <a href="http://www.virtualblueness.net/Ext2fs-overview/Ext2fs-overview-0.1-8.html">bitmaps</a> and provide a block to bit mapping so the file system can quickly find free blocks. The numbers do scale :)  

#### Answer 2 (score 15)
<p>Yes. By the definition in <a href="http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.180-4.pdf" rel="noreferrer">FIPS 180-4</a>, there are exactly<br>
160 bits in the output of `SHA-1`<br>
224 bits in the output of `SHA-224`<br>
256 bits in the output of `SHA-256`<br>
384 bits in the output of `SHA-384`<br>
512 bits in the output of `SHA-512`<br>
224 bits in the output of `SHA-512/224`<br>
256 bits in the output of `SHA-512/256`<br></p>

#### Answer 3 (score 4)
Yes, that's their idea. You can rely on it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Twofish vs. Serpent vs. AES (or a combo) (score [50253](https://stackoverflow.com/q/24192) in 2015)

#### Question
I've seen some posts and info online, but they are from 2009, 2010, 2011 or 2012, which is 3-6 years ago, which is a very long time. So I'm looking for an up-to-date answer about which of these is the safest encryption to be used, or rather most unbreakable? Particularly interested in encryption programs, so performance would also interest me, not only security.  

I think things have changed since Snowden's postings, though then again - I know that a file encrypted with some sort of TrueCrypt algorithms remains uncracked after a few years of trying in the FBI.  

So, having that in mind, I'd like to know more about it all so that I would be able to choose the right algorithm for me.  

#### Answer accepted (score 15)
None of Twofish, Serpent and AES are currently known as broken, so as far as security is concerned, you can use any of them. AES has a slight advantage because it's very widely used, so if it gets broken you're more likely to hear about it and get relevant software updates quickly.  

The Snowden postings haven't changed much as far as cryptography usage is concerned. They confirmed what was generally suspected before, which is that the generally-accepted cryptographic primitives are safe even from NSA-level adversaries¹; it's the systems and sometimes the protocols that are insecure. What's important is not your choice of primitive (as long as it's one of the generally-accepted ones, e.g. one approved by a NIST standard), but your choice of software.  

AES has the advantage that high-end x86 and ARM CPUs include hardware acceleration for it.  

If you're a user of cryptography, as opposed to an implementer of software like GPG, keep in mind that <a href="http://chargen.matasano.com/chargen/2009/7/22/if-youre-typing-the-letters-a-e-s-into-your-code-youre-doing.html" rel="nofollow noreferrer">if you're typing the letters A-E-S into your code, you're doing it wrong</a>.  

¹ <sub> You might consider `Dual_EC_DRBG` to be an exception, but <a href="https://crypto.stackexchange.com/questions/10189/who-uses-dual-ec-drbg">few people used it</a> because it had no obvious security benefit, and its potential to be backdoored was known, and it was slow. </sub>    

#### Answer 2 (score -2)
Twofish's composition is actually more secure than AES and is rendered unbreakable from a theoretical perspective and physical on the other hand Rijindael (Known as AES) is breakable in some theoretical scenarios. Due to Rijindael's higher efficiency, it was selected as the AES or Advanced Encryption Standard because both standards were regarded as so secure it was just faster to addopt Rijindael as AES due to it's high efficiency. But if you really want the best encryption use Twofish, it is impossible to break (except for bruteforce of course) and the only feasible way any mortal could break a Twofish password with at least 128 Bits and an 8-6 character password is if they rented a data center and waited a couple years until they finaly broke your password using bruteforce.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Why we can't implement AES 512 key size? (score [49362](https://stackoverflow.com/q/20253) in 2014)

#### Question
Out of curiosity why we can't implement AES 512 key size?    

Please explain somehow i can understand! I'm not an expert.  

#### Answer accepted (score 43)
We can't implement <em>"AES 512 key size"</em> because AES is <a href="http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf">defined</a> for key sizes $k\in\{128,192,256\}$ bits only; much like we can't make a bicycle with 3 wheels.  

I see no reason why we would <em>want to</em> define an AES <em>variant</em> with 512-bit key size (since AES-128 is safe enough for <strike>anything foreseeable</strike> most current applications except those that require huge security margins, AES-192 is more than enough for the most demanding ones, and AES-256 more than overkill). However we <em>could</em> define an AES <em>variant</em> with 512-bit key size. If we stick to the 128-bit block size, the two choices we have to make are:  

<ul>
<li>How many rounds we should use; since the number of rounds in standard AES is $r=k/32+6$, anything even from $r=14$ (for performance and subkeys space comparable to AES-256, at the expense of resistance to related-key attacks much <em>lower</em> than AES-256) to $r=24$ (as a paranoia damper) seems justifiable.</li>
<li>How we would generate the $4(r+1)$ 32-bit words forming the $(r+1)$ 128-bit round subkeys out of the 512-bit key. By analogy with standard AES, the first 16 such words should be right from the key. I won't venture further.</li>
</ul>

<hr>

The question seems to have been motivated by a "paper" titled <a href="http://www.ijircce.com/upload/2014/march/22_AES.pdf"><em>AES Algorithm Using 512 Bit Key Implementation for Secure Communication</em></a> (I'll charitably not mention the authors) which presents an AES variation with 512-bit key and block size, best summarized as: AES-128 with $8^2$ bytes wherever the original has $4^2$, an idea that at least could be made to work. However the "paper" has blatant issues:  

<ol>
<li>The "paper" present as "drawback" of AES-256 (which uses 14 rounds) that a 9-round variant is vulnerable to a related-key attack with $2^{224}$ works; yet it introduces a 10-round AES variant without the slightest justification that it will resist similar attacks.</li>
<li>The aim is "higher level of security throughput", without attempt of definition; and doing so "without increasing overall design area as compared to the original 128 bit AES", while the state of the proposed algorithm (thus number of D latches in an hardware implementation) is 4 times that of AES-128, for both key and data.</li>
<li>The drawing of the byte substitution step clearly shows a 4x4 grid of bytes holding "an array of 64 bytes".</li>
<li>There is the same issue in the "shift row" step (to be read as ShiftRows), and the drawing gets confusing, since the line with $s_3$ is shown right-rotated by 1 step, when the intend is that it is left-rotated by 3 steps.</li>
<li>Proof that the "Mix Column" step (to be read as MixColumns) is reversible, which is necessary for decryption to be possible, is alluded to only by dumping an alleged inverse of the polynomial used in MixColumns, without derivation.</li>
<li>On closer inspection, the matrix given for MixColumns does not correspond to the polynomial stated for MixColumns per the conventions used in the real AES; and the alleged inverse polynomial can not match either, according to any convention, for it contains too many terms with multiplication by $\{01\}$, so that decryption using it won't work. I conjecture that this would-be inverse polynomial simply has its four terms of even degree taken from the polynomial used for AES's InvMixColumns (within a reflexion); and other terms set to $\{01\}$, because there are a lot of these in the direct polynomial.</li>
<li>The number of rounds in the 512-bit AES variant is set to 10 with the sole justification that there are "ten AES rounds", without reference to which of the three AES ciphers that applies to.</li>
<li>The round index is variably $I$ or $i$ including in the same equation. </li>
<li>The first round constant probably has a typo.</li>
<li>But there's no test vector to settle that.</li>
<li>Performance is compared against AES-128, stated as encrypting "128 bytes" in "30-50 Seconds" on an unspecified platform; which (if we ignore the spurious capital S) is about $2^{26}$ times slower than routinely achieved by a single core of a modern CPU with AES-NI.</li>
<li>The 512-bit AES variant is stated as encrypting the same "128 bytes" in "20-40 Seconds" yet has "230%" the throughput; this creatively redefines benchmarking.</li>
<li>It is stated that the "Processor Required" is "Less" than for regular AES, with no attempt to evaluate the number of operations or memory accesses per byte encrypted; indeed this is about the same as in AES-128 for all steps except MixColumns, where there is significantly <em>more</em> work per byte (twice as many columns, each requiring multiplication by a matrix with twice as many raws and twice as many columns, thus about 8 times more work for 4 times as many bytes, thus about twice more work per byte; admittedly, the proportion of entries in the matrix that hold a $\{01\}$ is higher, but this only partially lowers that increase in work).</li>
<li>Proceedings is spelled "Pro-ceding's".</li>
<li>Several entries in the citations are to equally vacuous papers published in caricatures of scientific journals.</li>
<li>Two citations ([1] and [11]) are to other papers about AES-512, yet are not mentioned in the <em>Existing Work</em> section.</li>
<li><a href="http://computerresearch.org/stpr/index.php/gjcst/article/view/436/395">Citation [1]</a> is a 2010 paper strikingly similar to the 2014 paper itself, including having nearly the same title ("Implemented" rather than "Implementation"), yet other authors (and even more mistakes and vacuity).</li>
<li><a href="http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=6122835">Citation [11]</a> was published in the proceedings of an IAS 2011 conference with enough relation to the IEEE to be on their website and use their logo (notice that this IAS stands for Information Assurance and Security, <em>not</em> IEEE's Industry Applications Society). A look at this <a href="http://www.researchgate.net/profile/Yaser_Jararweh/publication/220793242_AES-512_512-bit_Advanced_Encryption_Standard_algorithm_design_and_evaluation/links/004635255d086e40c3000000">online version</a> shows it is strikingly similar to the 2014 article (including same erroneous polynomials, typo in first round constant, and 230% improvement), with different authors. I vote this 2011 paper as poor (especially on justification of security and misleading benchmark), but the least objectionable of the three.</li>
<li>The numbers for references in the text are often from text cut and pasted from the 2010 paper, rather than related to the numbering of the references given in the end.</li>
<li>The paper is published in a "peer reviewed" journal which most visible claim of seriousness <strike>is that</strike> used to be that it is an <em>"ISO 3297:2007 Certified Organization"</em>. A cursory look at <a href="http://www.iso.org/iso/home/store/catalogue_tc/catalogue_detail.htm?csnumber=39601">the summary of this standard</a> shows that it is about numbering publications, not review of their content. Now that journal boasts an impact factor of 6.577; this is telling of how reliable a measure of seriousness the impact factor is.</li>
</ol>

#### Answer 2 (score 3)
As mentioned in the answer by @fgrieu, AES is a standard (Advanced Encryption Standard) which is only defined for key sizes 128, 192 and 256. The actual underlying cryptographic algorithm is called <a href="https://csrc.nist.gov/csrc/media/projects/cryptographic-standards-and-guidelines/documents/aes-development/rijndael-ammended.pdf" rel="nofollow noreferrer">Rijndael</a>. At the time of its design (late 90s) key size of 256 bits was considered a huge enough security margin, while larger key sizes would increase computation complexity without providing much additional security.  

As processors became more powerful and switched to 64-bit architecture the overhead of computing larger block sizes is not so significant anymore and some modern ciphers introduce 512-bit blocks. For example a cipher <a href="https://en.wikipedia.org/wiki/Kalyna_(cipher)" rel="nofollow noreferrer">Kalyna</a> chosen as Ukrainian National Encryption standard is based on Rijndael and has mode for 512-bit key size.  

#### Answer 3 (score 0)
In fact we can, it is not common, because when NIST did choose AES candidates, they limit block size to 128 bit, and key to 128, 192, or 256 bits. For me this limitation is pure artificial and created just to make some sort of standard approach. We won't speculate on reason they decide to do so. In PHP for example you can specify block size as 256 bit, so I assume if you have enough knowledge, it's very possible to "unlock" higher key bit in code, or add necessary implementation  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: AES CBC mode or AES CTR mode recommended? (score [49323](https://stackoverflow.com/q/6029) in 2016)

#### Question
What are the benefits and disadvantages of CBC vs. CTR mode? Which one is more secure?   

#### Answer accepted (score 38)
I wrote a rather <a href="https://security.stackexchange.com/a/27780/655">lengthy answer</a> on another site a few days ago. Bottom-line is that CTR appears to be the "safest" choice, but that does not mean <em>safe</em>. The block cipher mode is only part of the overall protocol. Every mode has its quirks and requires some extra systems in order to use it properly; but in the case of CTR, the <em>design</em> of these extra systems is somewhat easier. For instance, when compared to OFB, there is no risk of a "short cycle" with CTR.  

This is why actually usable modes like <a href="http://en.wikipedia.org/wiki/EAX_mode" rel="noreferrer">EAX</a> and <a href="http://en.wikipedia.org/wiki/Galois/Counter_Mode" rel="noreferrer">GCM</a> internally use CTR.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How is XOR used for encryption? (score [47961](https://stackoverflow.com/q/19470) in )

#### Question
I am a programmer, so when I hear `XOR`, I think about the bitwise operator (e.g. `0110 ^ 1110 = 1000`).  

The mention of "XOR" comes up quite a bit in cryptography. Is this the same XOR as the bitwise operator? If so, how is it used to encrypt a large amount of data rather than just an integer? Wouldn't you need the "password" to be the same length as the data you are encrypting?  

#### Answer 2 (score 27)
Yes, it's the same <a href="http://en.wikipedia.org/wiki/Exclusive_or#Computer_science" rel="noreferrer">XOR</a>. It gets used inside most of the algorithms, or just to merge a stream cipher and the plaintext.  

Everything is just bits, even text. The word "hello" is in ASCII `01101000 01100101 01101100 01101100 01101111`. Just normal bits, grouped in 5 bytes. Now you can encrypt this string with a random string of 5 bytes, like an <a href="http://en.wikipedia.org/wiki/One-time_pad" rel="noreferrer">One-time pad</a>. Let's say we got the randomly generated string `10001001 10000010 00001011 01001101 11101101` (generated with <a href="http://www.random.org/bytes/" rel="noreferrer">www.random.org</a>). Now we XOR both strings, getting `11100001 11100111 01100111 00100001 10000010`. If you never reuse or reveal the key, nobody can crack this cipher. (Well, I did reveal the key, so it's not secure anymore.)  

Many block ciphers use XOR. Let's take <a href="http://en.wikipedia.org/wiki/Advanced_Encryption_Standard" rel="noreferrer">AES</a>: The Advanced Encryption Standard uses xor on single bytes (some other algorithms use blocks of 16 or 32 bits; there's no problem with sizes other than 8 bits). The round key will be XORed with the intermediate result and after that permuted and substituted. XOR also gets used in the key shedule.  

<a href="http://en.wikipedia.org/wiki/International_Data_Encryption_Algorithm" rel="noreferrer">IDEA</a> also uses XOR as one of its three main functions: XOR, addition and multiplication.  

XOR has (inter alia) these advantages when used for cryptography:  

<ul>
<li>Very fast computable, especially in hardware.</li>
<li>Not making a difference between the right and left site. (Being <a href="http://en.wikipedia.org/wiki/Commutative_property" rel="noreferrer">commutative</a>.)</li>
<li>It doesn't matter how many and in which order you XOR values. (Being <a href="http://en.wikipedia.org/wiki/Associative_property" rel="noreferrer">associative</a>.)</li>
<li>Easy to understand and analyse.</li>
</ul>

Of course, some of this "advantages" can be disadvantages, depending on the context. The fast speed makes it possible to use XOR often without huge performance drops. The security of <a href="http://en.wikipedia.org/wiki/Threefish" rel="noreferrer">Threefish</a>, another block cipher, relies on the non-linearity of alternately using modulo addition and XOR. Despite of the use of 72 rounds (as the base of the hash function <a href="https://en.wikipedia.org/wiki/Skein_hash_function" rel="noreferrer">Skein</a>) it's still quite fast.  

XOR alone is not enough to create a secure block or stream cipher. You need other elements like additions, S-boxes or a random, equally long bit stream. This is because of the linearity of the XOR operation itself. Without non-linear elements, a cipher can easily be broken. See <a href="https://crypto.stackexchange.com/questions/2820/why-do-block-ciphers-need-a-non-linear-component-like-an-s-box">Why do block ciphers need a non-linear component (like an S-box)?</a> for more details on why non-linearity is important.  

#### Answer 3 (score 11)
Yes, the XOR used in cryptography means the same bitwise XOR operator you're familiar with.  

And yes, to securely encrypt a message with XOR (alone), you <em>do</em> need a key that is as long as the message.  In fact, if you have such a key (and it's completely random, and you never reuse it), then the resulting encryption scheme (known as the <a href="//en.wikipedia.org/wiki/One-time_pad">one-time pad</a>) is provably unbreakable!  

Of course, in most circumstances, using such long keys would be extremely impractical.  Instead, the trick we use is to generate the XOR key "on the fly" from a shorter key, basically by using the short key to seed a suitable pseudorandom number generator and XORing the message with the output of the generator.  

Of course, for this trick to work, there cannot be any easy way for an attacker to recover the short key (or anything else that would let them predict the output of the generator) by observing the encrypted message (or even the raw output of the generator, which they may obtain if they can guess or choose the plaintext).  Most simple commonly used RNGs don't withstand this test, but we do have <a href="//en.wikipedia.org/wiki/CSPRNG">various kinds of generators believed to be secure</a> against such attacks.  

This kind of an encryption scheme is known as a (synchronous) <a href="//en.wikipedia.org/wiki/Stream_cipher">stream cipher</a>; see the Wikipedia article (and/or the <a href="/questions/tagged/stream-cipher" class="post-tag" title="show questions tagged &#39;stream-cipher&#39;" rel="tag">stream-cipher</a> tag here) for more details.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: How to solve MixColumns (score [47264](https://stackoverflow.com/q/2402) in 2014)

#### Question
I can't really understand MixColumns in Advanced Encryption Standard, can anyone help me how to do this?  

I found some topic in the internet about MixColumns, but I still have a lot of question to ask.  

ex.  

<p>$$
\begin{bmatrix}
\mathtt{d4} \\
\mathtt{bf} \\
\mathtt{5d} \\
\mathtt{30} \\
\end{bmatrix}
\cdot
\begin{bmatrix}
\mathtt{02} &amp; \mathtt{03} &amp; \mathtt{01} &amp; \mathtt{01} \\
\mathtt{01} &amp; \mathtt{02} &amp; \mathtt{03} &amp; \mathtt{01} \\
\mathtt{01} &amp; \mathtt{01} &amp; \mathtt{02} &amp; \mathtt{03} \\
\mathtt{03} &amp; \mathtt{01} &amp; \mathtt{01} &amp; \mathtt{02} \\
\end{bmatrix}
=
\begin{bmatrix}
\mathtt{04} \\
\mathtt{66} \\
\mathtt{81} \\
\mathtt{e5} \\
\end{bmatrix}
$$</p>

Here, the first element is calculated as  

$$(\mathtt{d4} \cdot \mathtt{02}) + (\mathtt{bf} \cdot \mathtt{03}) + (\mathtt{5d} \cdot \mathtt{01}) + (\mathtt{30} \cdot \mathtt{01}) = \mathtt{04}$$  

First we will try to solve $\mathtt{d4} \cdot \mathtt{02}$.  

We will convert $\mathtt{d4}$ to it's binary form, where $\mathtt{d4}_{16} = \mathtt{1101\,0100}_2$.  

<p>$$\begin{aligned}
\mathtt{d4} \cdot \mathtt{02} 
&amp;= \mathtt{1101\,0100} \ll 1 &amp; \text{(}{\ll}\text{ is left shift, 1 is the number of bits to shift)} \\
&amp;= \mathtt{1010\,1000} \oplus \mathtt{0001\,1011} &amp; \text{(XOR because the leftmost bit is 1 before shift)}\\
&amp;= \mathtt{1011\,0011} &amp; \text{(answer)}
\end{aligned}$$</p>

Calculation:  

<p>$$\begin{aligned}
 &amp; \mathtt{1010\,1000} \\
 &amp; \mathtt{0001\,1011}\ \oplus \\
=&amp; \mathtt{1011\,0011}
\end{aligned}$$</p>

The binary value of $\mathtt{d4}$ will be XORed with $\mathtt{0001\,1011}$ after shifting if the left most bit of the binary value of $\mathtt{d4}$ is equal to 1 (before shift).  

My question is, what if the left most bit of the binary value is equal to 0, what do I XOR it with then? ex. $\mathtt{01}_{16} = \mathtt{0000\,0001}_2$ ..?  

#### Answer accepted (score 29)
Well, it sounds like you're close.  

The multiplications implicit within the MixColumns operation are $GF(2^8)$ multiplication operations, using the same field representation as they use in the inverse within the sbox.  

However, because they're multiplying by the fixed constants $\mathtt{1}$, $\mathtt{2}$ and $\mathtt{3}$, it's easier to implement than a general $GF(2^8)$ multiplication.  

Multiplying by $\mathtt{1}$ is easy; it's exactly what you'd expect.  

Multiplying by $\mathtt{2}$ is what your question is about: it is equivalent to shifting the number left by one, and then exclusiving-or'ing the value 0x1B if the high bit had been one (where, in case you're wondering, the value 0x1B came from the field representation).  And so, that is the answer to the question you asked; if the high bit was a zero, then you don't need to exclusive or anything (or equivalently, you exclusive-or in a 0x00 constant).  

And, your next question would likely be "how do a multiply by $\mathtt{3}$"?  Well, you can do that by multiplying by $\mathtt{2}$ (see above), and then exclusive-or-ing that with the original value, since $\mathtt{3} = \mathtt{2} \oplus \mathtt{1}$.  Or, in other words:  

$$\mathtt 3 \times x = ( \mathtt{2} \oplus \mathtt{1})\times x = (\mathtt 2 \times x) \oplus x $$  

So, once we've gotten the multiplication by 2 operation solved, the multiplication by 3 is solved as well.  

Once you've multiplied all the vector elements, then you need to add them.  Now, you might be tempted to add them modulo 256, but that'd be wrong.  This "addition" operation is actually "exclusive-or".  They've written it as $+$ because, in $GF(2^n)$ fields, exclusive-or is considered the addition operation; it acts an awful lot like an addition operation in conjunction with the multiplication operation.  

So, if we look at the calculation:  

$$(\mathtt{d4} \times \mathtt{02}) + (\mathtt{bf} \times \mathtt{03}) + (\mathtt{5d} \times \mathtt{01}) + (\mathtt{30} \times \mathtt{01})$$  

<ul>
<li><p>$\mathtt{d4} \times \mathtt{02}$ is $\mathtt{d4} &lt;&lt; 1$, exclusive-ored with $\mathtt{1b}$ (because the high bit of $\mathtt{d4}$ is set), giving $\mathtt{b3}$;</p></li>
<li><p>$\mathtt{bf} \times \mathtt{03}$ is $\mathtt{bf} &lt;&lt; 1$ exclusive-ored with $\mathtt{1b}$ (because the high bit of $\mathtt{bf}$ is set) and $\mathtt{bf}$ (because we're multiplying by $\mathtt{3}$), giving us $\mathtt{da}$;</p></li>
<li><p>$\mathtt{5d} \times \mathtt{01}$ is $\mathtt{5d}$, and $\mathtt{30} \times \mathtt{01}$ is $\mathtt{30}$.</p></li>
</ul>

Now, we add (rather, exclusive or) $\mathtt{b3}$, $\mathtt{da}$, $\mathtt{5d}$ and $\mathtt{30}$ together, and that gives us $\mathtt{04}$.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: AES 256 Encryption - Is it really easy to decrypt if you have the key? (score [46862](https://stackoverflow.com/q/9276) in 2013)

#### Question
So this might sound like a crazy question but bear with me for a minute. I can't find any info on the internet and so am here, although this might have been a good place to start.  

I've recently developed an encryption engine using the .net's AES managed classes. I use a 256 bit key generated by the `Rfc2898DeriveBytes` function. The key is generated from a pass phrase that is at least 40 characters long. The IV is also generated from this pass phrase. The encryption class uses a CypherMode of CBC and a padding mode of PKCS7. There is a static salt that is 8 bytes long.   

The key is stored in a separate database to the data and is itself encrypted using a certificate based on the database master key.  

So, my question is: is it really easy to decrypt the data if the attacker has the key? I'm not talking about the Chinese government (or even GHCQ given recent headlines), I'm talking about an attacker who steals both databases.   

What would be the steps they have to follow and/or how can I stop them on their path? The reason I ask this is that I want to know how feasible it is. Is it something that can be done in minutes or does it fall into the bracket of being infeasible? Do they have to calculate all of the parameters used when encrypting?  

#### Answer accepted (score 9)
I assume you follow <a href="https://en.wikipedia.org/wiki/Kerckhoffs%27s_principle" rel="nofollow noreferrer">Kerckhoffs' principle</a> so the attacker knows the padding scheme and derivation function so the answer is yes, it only takes a few seconds to decrypt and anyone can do it.   

If he doesn't know these things, he can find them by trial and error (assuming he can get his hands on a valid ciphertext).  

The IV can be sent in the clear so making it depend on the key reveals some information on the key. It should also be unique for each session so I'm a bit worried about it. <strike>It should be OK if the KDF you're using is non-deterministic, which implies it uses its own IV so the problem remains.</strike> See <a href="https://crypto.stackexchange.com/questions/8592/iv-security-clarification">this question</a> for more on IVs.  

<hr>

<p>Edit based on comments:
The cracking procedure is the following: 
$a$ is the number of <em>all</em> modern ciphers. Let's set this to 100. $m$ is the number of modes per cipher, set it to 6. $k=100$ is the number of key derivation functions, $p=100$ are the padding schemes. The values are arbitrary. So we have $(p*k*m*a*c)/n = 6*10^6$ which equals to approx. 69 days with $c=1$ second and $n=1$ processor. </p>

Your adversary will solve the problem in $69/2=34.5$ days. Not <em>as</em> practical but definitely feasible, especially if you throw extra processors at it. This solution is completly brute-force, it makes no attempt at distinguishing and pre-eliminating ciphers.  

Since non-indistinguishability is a business requirement (really?) you could just get away with using ECB instead of any other mode.  

#### Answer 2 (score 5)
To answer your question: yes, your system is really easy to break.  

The more detailed answer: While you started out using the proper set of cryptographic primitives (AES-256 in CBC mode, PBKDF2, etc), these primitives only work <em>if used correctly</em>, and it sounds like you've used them so poorly as to make them meaningless. You want the following to provide all of the security of your protocol:  

<ol>
<li>The fact that an adversary is unaware that you're using AES-256-CBC.</li>
<li>A fixed but unknown IV.</li>
</ol>

Item #1 isn't going to help you at all. If I'm given a ciphertext and a key but don't know the underlying encryption scheme used, I guarantee you that AES-256-CBC will be on my top 5 list of choices: AES is the most common encryption scheme used, the 256 bit version is its 2nd most popular variant, and CBC mode is the most common mode of operation. Moreover, please don't use this logic to say "okay, now I'll switch to a less ubiquitous encryption scheme; as rath showed above, that's not really going to help much.  

Item #2 is bad for a few reasons. First of all, you're making the encryption scheme deterministic. You argue that you "must do this for business purposes," so I recognize the futility of trying to convince you otherwise. I hope we can agree at least though that deterministic encryption is a Really Bad Thing. It is necessary sometimes though, so cryptographers have tried to find the "best" (even if not good) way of doing it. Your solution is not that way.  

I'm going to sidestep the question of "can all the security of AES-256-CBC be provided by the IV," because it's irrelevant here. The major problem is that (if I understand your idea correctly) you're reusing the IV. This is another Really Bad Thing, and that will allow an attacker to break your system easily as well.  

I'm not trying to be mean here, but I think you're trying to have things both ways here. On the one hand, you're disregarding all of the expertise of 50 years of cryptographic research, and dismissing it all away as saying "I need to make sure I satisfy the business requirements." That's fine in and of itself; sometimes business needs impose burdensome constraints, and as long as you (1) understand that your scheme is weak as a result and (2) are willing to tolerate that, you're okay. However, you're also trying to get some reassurance from the Internet that your scheme is somehow still okay, and that's not going to happen.  

#### Answer 3 (score 0)
<blockquote>
  So to clarify then the question would be this: The attacker has the encrypted data and the plain text key and no other knowledge. How easy is it to decrypt the data and why.  
</blockquote>

As I understand it, modern ciphers can't be broken knowing just the ciphertext (and no other information). <em>But,</em> the cipher algorithym (eg. AES) is only one part of a wider system using RNGs, keys, salts, IVs, padding, signatures, certificates, and so on. People have developed amazing exploits against tiny deficiencies in how those parts all fit together. So even though the ciper itself is secure, that <em>does not mean</em> that the system as a whole is secure.  

Here's a simple analogue. SCUBA tanks have a threaded hole where the valve screws in. Some of those holes use a "3/4 NPS" thread, others use an "M25" thread. An M25 valve will screw "perfectly" into a 3/4 NPS hole - but those two threads aren't quite the same. Result: the valve can explode from the tank when it is pressurized. Each component is fine on its own; they <em>seem</em> to fit together correctly; an amateur won't see any problem; but the resultant system can fail catastrophically.  

Crypto's the same!  

TC  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Why is padding used for RSA encryption given that it is not a block cipher? (score [45558](https://stackoverflow.com/q/3608) in 2012)

#### Question
<ol>
<li><p>In AES we use some padded bytes at end of message to fit 128/256
byte blocks.  But as RSA is not a block cipher why is padding used?</p></li>
<li><p>Can the message size be any byte length (is the encrypting agent
free to choose) or must it be a certain byte length to use RSA
encryption?</p></li>
</ol>

#### Answer 2 (score 26)
<p>RSA without padding is also called Textbook RSA.
The question why RSA without padding is insecure has already been answered 
<a href="https://crypto.stackexchange.com/questions/1448/definition-of-textbook-rsa">in this question</a>.</p>

We can fix a few issues by introducing padding.  

<ol>
<li><p>Malleability: If we have a strict format for messages, i.e. that the first or last bytes contain a specific value, simply multiplying both message and ciphertext will decrease the probability of creating a valid (in terms of padding) message.</p></li>
<li><p>Semantical Security: Add randomness such that RSA is not deterministic anymore (a deterministic encryption scheme yields always the same $x$  for each instance of  $x = enc_{pubkey}(m)$ for constant $m$ and $pubkey$). See <a href="http://en.wikipedia.org/wiki/Optimal_Asymmetric_Encryption_Padding" rel="noreferrer">OAEP</a> as an example on how to achieve this.</p></li>
</ol>

<strong>Edit</strong>: To answer the second question, RSA plain text are (unlike AES plain texts) limited by an <em>upper</em> bound. Messages must not be longer than the $N$ of the public key. It is also noteworthy, that common cipher schemes don't handle or pad blocks of RSA ciphertexts at all. Usually, the message is encrypted using a symmetric cipher (like AES) and only the key to this seperate cipher text is encrypted using an asymmetric cipher (like RSA). This is also called <em>hybrid encryption</em>.  

#### Answer 3 (score 10)
<h5>1. Why do we use padding?</h2>

Both block ciphers and RSA are permutations on a block(RSA's block isn't an integral number of bytes), so it's clear that both of them need some kind of padding if the data size doesn't correspond to the block size.  

With block ciphers the padding doesn't do much: It fills up the remainder of the block, and tells you how much padding there was.  

With RSA the padding is essential for its core function. RSA has a lot of mathematical structure, which leads to weaknesses. Using correct padding prevents those weaknesses.  

For example RSA Encryption padding is randomized, ensuring that the same message encrypted multiple times looks different each time. It also avoids other weaknesses, such as encrypting the same message using different RSA keys leaking the message, or an attacker creating messages derived from some other ciphertexts.  

RSA padding should always be used, and it has a minimum size of dozens of bytes, as opposed to a single byte with most block cipher paddings.  

<h5>2. Can the message size be any byte length or must it be a certain byte length to use RSA encryption?</h2>

Using a single RSA operation you can only encrypt a small constant amount of bytes (100 or so).   

In principle one could chain multiple RSA operations similar to how we chain block ciphers. In practice (almost) nobody does that. RSA is slow, decrypting perhaps 100kB/s instead of >100MB/s with AES. The padding also bloats the ciphertext unnecessarily.  

What we actually do is generating a random symmetric key, and encrypting the message with that key and AES. And then we encrypt the key with RSA. This is efficient, and at least as secure as encrypting the message with RSA.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: What is the lowest level of mathematics required in order to understand how encryption algorithms work? (score [44953](https://stackoverflow.com/q/10467) in 2013)

#### Question
What mathematical fields of knowledge would be required in order to get a good understanding of encryption algorithms?   

Is it basic algebra, or is there a "higher education" mathematical field dedicated to encryption? I know there is the cryptography field, but what is the subset of knowledge required for cryptographers?  

#### Answer accepted (score 31)
Most encryption is based heavily on number theory, most of it being abstract algebra.  Calculus and trigonometry isn't heavily used.  Additionally, other subjects should be understood well; specifically probability (including basic combinatorics), information theory, and asymptotic analysis of algorithms.  There's also more math that's worth knowing to be a good programmer which is key if you really want to be an expert.  The number theory is more important with understanding asymmetric encryption, but does come up in symmetric encryption as well (e.g., in AES how to derive the S-box and MixColumns relates to understanding Galois fields).  

First, you need to learn some notation.  Things like logical operators, most importantly for cryptography XOR (sometimes denoted as circle plus: ⊕), where 0 XOR 1 = 1 XOR 0 = 1, and 0 XOR 0 = 1 XOR 1 = 0.  It also helps to be able to understand the notation and language of abstract mathematics and set theory; e.g., {0,1}<sup>128</sup> means the set of all strings that are made up of 128 binary digits (each digit is a 0 or 1).  Similarly, F: {0,1}<sup>64</sup> → {0,1}<sup>128</sup> means F is a function that maps a 64 bit input into an output that is 128-bit string.  You'll have to learn the difference between a function, bijection, permutation, etc, but again this is mostly just terminology of relatively simple concepts.  

One of the most important topics is modular arithmetic.  E.g., `1 ≡ 64 (mod 21)` where `(mod N)` means you only care about the remainder when dividing by N (since 64/21 = 3 with remainder 1; the modulo is 1).  One important notation to learn (that's a potential source of confusion) is that the `(mod N)` applies to both sides of the equation; so you could equivalently say `8^2 ≡ 1 (mod 21)`.  Many programming languages (e.g., C, Java, python, javascript) use `%` to do modulo division -- e.g., `64 % 21` gives `1`.  The cool thing about modular arithmetic is that you can just do normal arithmetic (addition and multiplication) and reduce at the end (or at any step in the middle) as modular arithmetic forms a finite field; e.g., 8 ≡ 29 ≡ 50 (mod 21) so since `8*8 ≡ 64 ≡ 1 (mod 21)` we also know that `29*8 = 232 ≡ 29*50 = 1450 ≡ 1 (mod 21)`.  With modular arithmetic there's no difference both 8, 29, 50 represent the exact same number.  

You'll need to understand things like Fermat's little theorem, Euler's theorem (based on totient), Euclid's algorithm for greatest common denominators (specifically Euclid's extended algorithm to generate multiplicative inverses), Carmichael numbers, Fermat primality test, Miller-Rabin primality test, modular exponentiation, and discrete logarithms.    

If you want to go further you may want to learn about things like finite fields (specifically Galois fields), polynomial rings, elliptic curves, etc.  This isn't meant to limit things; e.g., cryptography (and attacks on cryptography) aren't necessarily limited to these types of math.  E.g., <a href="http://en.wikipedia.org/wiki/NTRUEncrypt">NUTRUEncrypt</a> is based on lattices/shortest vector problem, and the <a href="http://en.wikipedia.org/wiki/McEliece_cryptosystem">McEliece Cryptosystem</a> is based on Goppa codes, but again you still need to learn the math above to be able to understand this math.  

And then you have the basic math background to learn about cryptography, which isn't just the math but also involves using the math in secure ways.  (For example, textbook RSA `c = m^e mod p q` is insecure for a variety of reasons - you should use a secure randomized padding scheme to your message and likely combine with symmetric encryption for long messages).  

<strong>Free Electronic References</strong>  

<ul>
<li><p><a href="http://cacr.uwaterloo.ca/hac/">The Handbook of Applied Cryptography</a> - Chapter 2 has a decent introduction to these concepts for the advanced learner -- it introduces concepts very quickly and compactly, and is probably better as a reference or second/third attempt at the material.  </p></li>
<li><p>Chapter 1 of <a href="http://www.cs.berkeley.edu/~vazirani/algorithms.html">Algorithms by DPV</a> (specifically sections 1.2 to 1.4) give a gentler introduction to the math behind RSA.  (<strong>2015 Update</strong>: <em>This pre-print of the book appears to be have taken off the one of the authors' academic website.  The good textbook is available for purchase on <a href="http://rads.stackoverflow.com/amzn/click/0073523402">amazon</a>.  I believe you can still find the book for free via google search for "Dasgupta  Papadimitriou Vazirani algorithms pdf", though I am not directly linking as I am not sure it is being shared by a copyright holder with authority to legally share the book.</em>)</p></li>
<li><p><a href="http://shoup.net/ntb/">Shoup - A Computational Introduction to Number Theory and Algebra</a> - From the preface "Number theory and algebra play an increasingly significant role in computing and communications, as evidenced by the striking applications of these subjects to such ﬁelds as cryptography and coding theory. My goal in writing this book was to provide an introduction to number theory and algebra, with an emphasis on algorithms and applications, that would be accessible to a broad audience."  Very detailed and fairly accessible.</p></li>
<li><p><a href="http://www.moserware.com/2009/09/stick-figure-guide-to-advanced.html">Stick-figure introduction to AES</a> at various levels of complexity with the last level showing where the number theory goes in.</p></li>
<li><p>The Udacity <a href="https://www.udacity.com/course/cs387">Applied Crypto course</a>.  More of an introduction to the cryptography than the math behind it, but introduces the math when necessary.</p></li>
<li>Dan Boneh's <a href="https://www.coursera.org/course/crypto">Coursera cryptography</a> course.  Solid introduction to cryptography, again introducing the math when necessary.</li>
</ul>

#### Answer 2 (score 9)
@dr jimbob gives a pretty solid answer, so let me just summarize it: <a href="http://en.wikipedia.org/wiki/Finite_field">finite fields</a>. Regardless of the area of cryptography you are interested in, you always end up with finite fields, in particular <strong>Z</strong><sub><em>p</em></sub> (with <em>p</em> prime), for RSA / DH / DSA / some elliptic curves, and <strong>Z</strong><sub><em>2</em></sub> and extensions thereof (<em>GF(2<sup>m</sup>)</em>) for symmetric cryptography and some other types of elliptic curves (you have to know what it means when we say "linear approximation of a S-box": it is all about vector spaces with <strong>Z</strong><sub><em>2</em></sub> as base field).  

<a href="http://rads.stackoverflow.com/amzn/click/0387942939">This book</a> is good; not really as an <em>introduction</em>, but if you can get through it, then you know enough to do crypto. If you don't, then it shows areas where you still need practice.  

#### Answer 3 (score 4)
A fun book to start with for the number theory side of things:  

<a href="http://rads.stackoverflow.com/amzn/click/0321816196" rel="nofollow">http://www.amazon.com/Friendly-Introduction-Number-Theory-4th/dp/0321816196/ref=sr_1_2?ie=UTF8&amp;qid=1326998078&amp;sr=8-2</a>  

It's pretty accessible for the mathematically inclined but for whatever reason didn't get the grounding they should have in college.  

I haven't found a good intro book on Probability, but I think a part of that is that I took it in college so I haven't really tried.    I'd love to hear some good recommendations, I could use an easy going refresher (a surprisingly hard thing to find for math..  mathematicians seem to think everything should be left up as an exercise to the reader, even if you're stuck.  Those who can get over such conceit are the real math gods to me..)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Should we trust the NIST-recommended ECC parameters? (score [44944](https://stackoverflow.com/q/10263) in 2019)

#### Question
<a href="https://www.nytimes.com/2013/09/06/us/nsa-foils-much-internet-encryption.html?hp&amp;pagewanted=all">Recent articles in the media</a>, based upon Snowden documents, have suggested that the NSA has actively tried to enable surveillance by embedding weaknesses in commercially-deployed technology -- including at least one NIST standard.  

The NIST FIPS 186-3 standard provides <a href="https://en.wikipedia.org/wiki/Elliptic_curve_cryptography#NIST-recommended_elliptic_curves">recommended parameters</a> for curves that can be used for elliptic curve cryptography.  These recommended parameters are widely used; it is widely presumed that they are a reasonable choice.  

<strong>My question.</strong> Can we trust these parameters?  Is there any way to verify that they were generated in an honest way, <a href="https://en.wikipedia.org/wiki/Nothing_up_my_sleeve_number">in a way that makes it unlikely they contain backdoors</a>?  

<p><strong>Reasons for concern.</strong>
Bruce Schneier has written that he has seen a bunch of secret Snowden documents, and after seeing them, he recommends classical integer discrete log-based cryptosystems over elliptic curve cryptography.  When asked to elaborate on why he thinks we should avoid elliptic-curve cryptography, <a href="https://www.schneier.com/blog/archives/2013/09/the_nsa_is_brea.html#c1675929">he writes</a>:</p>

<blockquote>
  I no longer trust the constants. I believe the NSA has manipulated them through their relationships with industry.  
</blockquote>

This suggests we should look closely at how the "constants" (the curve parameters) have been chosen, if we use ECC.  This is where things look concerning.  I recently read <a href="https://lists.torproject.org/pipermail/tor-talk/2013-September/029956.html">a message on the tor-talk mailing list</a> that seems to suggest the NIST curve parameters were not generated in a verifiable way.  That message examines how the parameters were generated:  

<blockquote>
  <p>I looked at the random seed values for the P-xxxr curves. For
  example, P-256r's seed is c49d360886e704936a6678e1139d26b7819f7e90.  No justification is given for that value.</p>
</blockquote>

and ultimately concludes:  

<blockquote>
  <p>I now personally consider this to be smoking evidence that the
  parameters are cooked.</p>
</blockquote>

Based upon my reading of FIPS 186-3, this appears to be an accurate description of the process by which the P-xxxr curves were generated.  So, should people be concerned about this?  Or is this just paranoia based upon <a href="https://www.schneier.com/blog/archives/2013/09/conspiracy_theo_1.html">loss of trust in the NSA</a>?  

See also <a href="http://cr.yp.to/talks/2013.05.31/slides-dan+tanja-20130531-4x3.pdf">these slides from Dan Bernstein and Tanja Lange</a>, particularly pp.6-7, 8-10, 14-17 for further discussion about the NIST parameter choices.  

#### Answer 2 (score 76)
<strong>Edit:</strong> I have made some tests and I found something weird. See at the end.  

<hr />

<strong>Initial answer:</strong>  

At least the <strong>Koblitz curves</strong> (K-163, K-233... in NIST terminology) cannot have been specially "cooked", since the whole process is quite transparent:  

<ul>
<li>Begin with a binary field $GF(2^m)$. For every <em>m</em> there is only one such field (you can have several representations, but they are all isomorphic).</li>
<li>Restrict yourself to prime values of <em>m</em> to avoid possible weaknesses by plunging into sub-fields.</li>
<li>Consider curves $Y^2+XY=X^3+aX^2+b$ where $b \ne 0$; this is the normal form of non-supersingular curves in binary fields.</li>
<li>You only want curves where $a = a^2$ and $b = b^2$, so that you can speed up computations with the <a href="http://en.wikipedia.org/wiki/Frobenius_endomorphism">Frobenius endomorphism</a> (basically, you replace point doublings with simply squaring both coordinates, which is very fast).</li>
<li>When $a = 0$, the curve order is necessarily a multiple of 4; when $a = 1$, necessarily a multiple of 2.</li>
</ul>

Then you want a curve order which is "as prime as possible", i.e. equal to $2p$ or $4p$ for a prime $p$ (depending on whether $a = 1$ or $0$). For $m$ ranging in the "interesting range" (say 160 to 768), you will not find a lot of suitable curves (I don't remember the exact count, but it is something like 6 or 7 curves). NIST simply took the 5 of them corresponding to the $m$ values which were closest to (but not lower then) their "security levels" (80, 112, 128, 192 and 256-bit "equivalent strength"). There is no room for "cooking" here.  

So I would say that at least Koblitz curves are demonstrably free from all these "cooking" rumours. Of course, some other people argue that Koblitz curves have some special structure which might be leveraged for faster attacks; and that's true in two ways:  

<ul>
<li>Faster computations mean faster attacks, mechanically;</li>
<li>One can solve discrete logarithm "modulo the Frobenius endomorphism" which means that K-233 is about as strong as a 225-bit curve (because 233 is an 8-bit number).</li>
</ul>

I still consider such curves to be reasonable candidates for serious cryptographic work. They have been "in the wild" for more at least 15 years and are still unscathed, which is not bad, as these things go.  

<hr />

<strong>Edit:</strong> I have made a few tests, enumerating all Koblitz curves in $GF(2^m)$ for $m$ ranging from 3 to 1200. For each $m$, there are two curves to test, for $a = 0$ and $a = 1$. We consider the curve "appropriate" if its order is equal to $4p$ (for $a = 0$) or $2p$ (for $a = 1$) with $p$ prime (this is the "best possible" since the curve is always an extension of the same curve in $GF(2)$, so the curve order is necessarily a multiple of the curve in $GF(2)$, and that's 4 or 2, depending on $a$). For the "interesting range" of $m$ between 160 and 768, there are <strong>fourteen appropriate curves</strong>:  

<ul>
<li>$m = 163$, $a = 1$</li>
<li>$m = 233$, $a = 0$</li>
<li>$m = 239$, $a = 0$</li>
<li>$m = 277$, $a = 0$</li>
<li>$m = 283$, $a = 0$</li>
<li>$m = 283$, $a = 1$</li>
<li>$m = 311$, $a = 1$</li>
<li>$m = 331$, $a = 1$</li>
<li>$m = 347$, $a = 1$</li>
<li>$m = 349$, $a = 0$</li>
<li>$m = 359$, $a = 1$</li>
<li>$m = 409$, $a = 0$</li>
<li>$m = 571$, $a = 0$</li>
<li>$m = 701$, $a = 1$</li>
</ul>

NIST's target was their five "security levels" of 80, 112, 128, 192 and 256 bits, and a curve would match that level only if its size is at least twice the level. So the standard curve for each level ought to be the smallest curve which is large enough for that level. This should yield Koblitz curves in fields of size 163, 233, 277, 409 and 571 bits, respectively.  

Strangely enough, this matches NIST's choices <em>except</em> for the "128-bit" level, in which they chose $m = 283$ instead of $m = 277$. I don't know the reason for this. For both field sizes, the smallest possible reduction polynomial is a pentanomial ($X^{277}+X^{12}+X^{6}+X^{3}+1$ for $m = 277$, $X^{283}+X^{12}+X^{7}+X^{5}+1$ for $m = 283$), so neither field is at a computational advantage on the other is using polynomial bases (well, the 277-bit field is a bit shorter, so a bit faster). With normal bases, the 277-bit field is actually more efficient, because it accepts a "type 4" Gaussian normal basis, while the 283-bit field is a "type 6" (smaller types are better for performance). The list of all suitable Koblitz curves is easy to rebuild and, indeed, NIST / NSA did it (e.g. see <a href="http://computacion.cs.cinvestav.mx/~armfaz/res/soli2000.pdf">this article</a> from NSA-employed J. A. Solinas -- search for "277").  

Why they chose the 283-bit field is mysterious to me. I still deem it very improbable that this constitutes "cooking"; this is a backdoor only if NIST (or NSA) knows how to break Koblitz curves in a 283-bit field and not in a 277-bit field, which not only requires an assumption of "unpublished big cryptanalytic advance", but also requires that supposed novel breaking technique to be quite weird.  

#### Answer 3 (score 28)
Your question is at least partially answered in <a href="http://csrc.nist.gov/publications/fips/fips186-3/fips_186-3.pdf" rel="nofollow noreferrer">FIPS 186-3</a> itself…  

<strong>Appendix A</strong> describes how to start with a seed and use an iterative process involving SHA-1 until a valid elliptic curve is found.  

<strong>Appendix D</strong> contains the NIST recommended curves and includes the seed used to generate each one according to the procedure in <em>Appendix A</em>.  

So to believe that NSA cooked the constants, you would have to believe one of two things: Either they can invert SHA-1, or a sufficient fraction of curves would have to meet their hidden conditions that they could find appropriate SEED values by a brute force search.  

Customarily, "nothing up my sleeve" constructions start with something simple, like the <span class="math-container">$sin$</span> (for MD5) or <span class="math-container">$sqrt$</span> (for SHA-1) of small integers. To my knowledge (am I wrong?), the SEED values for the NIST curves are not so easily described, which is itself arguably suspicious.  

On the other hand, these are the curves commercial software must support to receive FIPS certification, allowing it to be purchased by U.S. government agencies and used for the protection of classified data.  

So if NSA did cook the constants, they did a moderately good job of hiding it, and they have some confidence that other people will not find the holes any time soon.  

The Bernstein/Lange criticisms are based on other properties, like how easy it is to botch an implementation using the NIST curves.  

That said...  

The preponderance of evidence from the latest revelations suggest NSA knows <strong>something</strong> cryptographically relevant about SSL/TLS. Maybe that means ECDHE, and maybe not. (Heck, maybe it just means certain common implementations.)  

But given that we have alternatives from the likes of Dan Bernstein (Curve25519), I see no compelling reason to use NIST's curves even if you want to ignore Schneier's gut feeling to avoid ECC altogether.  

[Update]  

The Bernstein/Lange presentation says the NIST elliptic curves were created by "Jerry Solinas at NSA". I missed that on the first reading.  

I have sent this question to Perry Metzger's cryptography list:  

<a href="http://www.metzdowd.com/pipermail/cryptography/2013-September/017446.html" rel="nofollow noreferrer">http://www.metzdowd.com/pipermail/cryptography/2013-September/017446.html</a>  

Maybe somebody can get in touch with Mr. Solinas and ask him how he chose the seed values and why. It would be interesting to hear the answer from the source, even if nobody is likely to believe it.  

[Update 2]  

See also <a href="http://safecurves.cr.yp.to/rigid.html" rel="nofollow noreferrer">http://safecurves.cr.yp.to/rigid.html</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How to decrypt a '.enc' file that has been encrypted with RSA using a public key? (score [44688](https://stackoverflow.com/q/24792) in 2015)

#### Question
While solving a CTF challenge online, I came across a situation where I needed to decrypt a `'.enc'` file that has been encrypted using someone's public key. The corresponding public key `'.pem'` file was provided to me. I solved almost all other CTF challenges except this one and it has been bugging me since. I solved the first part: I have been able to decode a hint that says: `"The file file.enc could be decrypted with a private key. Using raw algorithm, every 64 bits chunk of data was encrypted at a time. You can do the same thing to decrypt using RSA."`  

<strong>Here's what I have tried:</strong>  

Read many posts like this one online and tried to decrypt the '.enc' file: <a href="http://www.czeskis.com/random/openssl-encrypt-file.html" rel="noreferrer">http://www.czeskis.com/random/openssl-encrypt-file.html</a>  

I tried the following command for decryption: openssl rsautl -decrypt -in public_key.pem -out key.bin. I got the this error:  

```cryptography
 no keyfile specified
 unable to load Private Key
```

Yes, but that's because private key is not provided to me. If I try to use the public_key.pem as infile, I get this error:  

```cryptography
unable to load Private Key
139914348455592:error:0906D06C:PEM routines:PEM_read_bio:no start line:pem_lib.c:703:Expecting: ANY PRIVATE KEY
```

Tried the tool 'openssl' in Linux in several ways to try to decrypt the file.  

Here is the 3 files zipped in tarball, if anyone wants to analyse them: <a href="http://www.filedropper.com/chaltar" rel="noreferrer">http://www.filedropper.com/chaltar</a>  

Could someone please advise me on how to decrypt the '.enc' file before I give up on this challenge? I have worked long and broken the first part of the challenge, now I feel I'm so close.   

Facts:  

<ul>
<li>I know the tool 'openssl' will be used to solve this challenge.</li>
<li>Encryption: RSA </li>
<li>Files: Only three files, public_key.pem, file.enc,
and a random file that I decrypted that provided the hint I wrote
above.</li>
</ul>

#### Answer accepted (score 3)
```cryptography
openssl rsa -pubin -inform PEM -text -noout < public_key.pem
Public-Key: (64 bit)
Modulus: 16513720463601767803 (0xe52c8544a915157b)
Exponent: 65537 (0x10001)
```

The modulus is small enough that you can <a href="https://www.wolframalpha.com/input/?i=factor%2016513720463601767803" rel="nofollow">easily factor it</a>  

After finding the prime factors, you can <a href="https://www.wolframalpha.com/input/?i=65537%5E-1+mod+%283917781346+*+4215069448%29" rel="nofollow">calculate the private exponent</a>  

After you have the private exponent, you raise each 64-bit block of ciphertext to the private exponent mod the modulus.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: What is the effect of the different AES key lengths? (score [44331](https://stackoverflow.com/q/3615) in 2012)

#### Question
How does a changing key length affects the ciphertext, not only in case of AES, but in general? I know that the key spaces become much larger and the number of rounds in case of AES changes, but is security really that much enhanced that if I choose 256 bits as key length it is sort of unbreakable?  

Something else what I'm thinking about currently, any idea if it is possible to get any details about key length or algorithm of an observed ciphertext? For example when measuring the entropy (or anything else) is there any difference e.g. between AES and DES?  

#### Answer 2 (score 14)
For symmetric algorithms (like AES or DES or RC4 -- but <em>not</em> for RSA or ECDSA), a key is a sequence of bits, such that <em>any</em> sequence of bits of the same size is a potential key. So longer keys means more possible keys.  

<em>Exhaustive search</em> is about trying all possible keys until a match is found. It is an absolute limit to the strength of an algorithm: exhaustive search is <em>always</em> applicable, there is nothing an algorithm can do against it. The only defence against exhaustive search is to expand the space of possible keys, i.e. have longer keys. Fortunately, this is very effective: the largest exhaustive search experiment which was ever reported to have been performed was for a <a href="http://www.distributed.net/RC5" rel="nofollow noreferrer">64-bit key</a> (a search for a 72-bit key is underway, but not completed yet). Traditionally we use "80 bits" as the practical limit, but technology improvement may force us to increase that. Every additional bit doubles the hardness of exhaustive search. See <a href="https://security.stackexchange.com/a/6149/655">this answer on security.SE</a> for some additional discussion. Bottom line: 128 bits are safe.  

It is somewhat delicate to compare strengths of 128-bit and 256-bit keys: while the latter is a much wider key space, the former is already in the "can't break it" zone, and you cannot get better than that, practically speaking. Thus, stating that AES-256 is stronger than AES-128 would be kind of abusive.  

There are a few gotchas:  

<ul>
<li><p>DES uses 64-bit keys (and 3DES uses 192-bit keys). However, the algorithm specification is such that DES totally ignores 8 of the 64 key bits (24 ignored bits for 3DES). Thus, the key size of DES is often said to be 56 bits (168 bits for 3DES).</p></li>
<li><p>AES morphs with the key size: with a longer key, there are more rounds. This is not about exhaustive key search; this is because a longer key is a promise of "higher academic strength" ("academic" means "we assume that the attacker can perform 300-bit exhaustive searches"). In an academic way, AES needs exhaustive search to be the best attack (i.e. attacks on the algorithm internal structure must be slower). A 256-bit key raises the bar: the non-exhaustive-search attacks must not be more effective than $2^{256}$ work factor. Hence the extra rounds. <em>In practice</em>, the extra rounds do not buy you more security (just like the larger key does not make the algorithm really less breakable than the already unbreakable AES-128); what the extra rounds <em>do</em> is that they make encryption 40% slower.</p></li>
<li><p>When an algorithm morphs with the key size, this is no longer "the same" algorithm, so anything goes. AES-256 could theoretically have weaknesses that AES-128 does not have (there is no guarantee that the extra rounds do not harm security).</p></li>
<li><p>Symmetric key size is <em>very rarely</em> the weak point of a system which uses cryptography. If you use 64-bit keys and that key size is indeed the best attack point, then you can consider yourself extremely lucky: the rest of the system must be inordinately robust.</p></li>
</ul>

#### Answer 3 (score 7)
<p><strong>To answer your first question on key length:</strong>
DES uses a 56 bit key. A brute-force attack will need a maximum complexity of $2^{56}$ to find the correct key. Now by today's standards this is not much. A complexity of $2^{90}$ or more is considered secure enough.
By that standard AES with any key size – 128, 192 or 256 – is strong enough to use.
As far as their relative security is concerned, read this <a href="http://www.schneier.com/blog/archives/2009/07/another_new_aes.html">post</a>.
In this post Bruce Schneier advises to use AES-128 over AES-256.</p>

<p><strong>For your second question:</strong>
AES, DES or any other good encryption algorithm is basically a PRF (Pseudo Random Function).
The property of a good PRF is that one should not be able to distinguish between a PRF and a TRF (Truly Random Function) by just observing their outputs.</p>

So, if one is able to observe the ciphertext and tell whether it came from AES or DES then it completely defeats the purpose. One should not be even able to tell whether the ciphertext was generated from a PRF (like AES) or a TRF, let alone identifying the type of PRF.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: What is the difference between MAC and HMAC? (score [43645](https://stackoverflow.com/q/6523) in 2017)

#### Question
In reference to <a href="https://crypto.stackexchange.com/questions/2936/hmac-vs-mac-functions">this question</a>, what are the "stronger security properties" that HMAC provides over MAC. I got that MAC requires an IV whereas HMAC doesn't. I also understood that MAC may reveal information about plaintext in contrast to HMAC. Is my understanding right?  

What are other security properties of MAC and HMAC?  

#### Answer accepted (score 56)
A Message Authentication Code (MAC) is a string of bits that is sent alongside a message. The MAC depends on the message itself and a secret key. No one should be able to compute a MAC without knowing the key. This allows two people who share a secret key to send messages to each without fear that someone else will tamper with the messages. (At least, if someone <em>does</em> tamper with a message, this can be detected by checking to see if the MAC is right.)  

The term "MAC" can refer to the string of bits (also called a "tag") or to the algorithm used to generate the tag.  

HMAC is a recipe for turning hash functions (such as MD5 or SHA256) into MACs. So HMAC-MD5 and HMAC-SHA256 are specific MAC algorithms, just like QuickSort is a specific sorting algorithm.  

There are other ways of constructing MAC algorithms; CMAC, for example, is a recipe for turning a blockcipher into a MAC (giving us CMAC-AES, CMAC-DES, CMAC-PRINCE, and the like).  

Some MAC algorithms use IVs. Others, such as HMAC, do not.  

<p>MAC algorithms should have the security property of being <em>unforgeable under chosen-message attacks</em>. Let's say that Alice and Bob share a secret MAC key (which they use when sending messages to each other), and that Eve is spying on them and sees both their messages and the corresponding tags. 
Eve should not be able to use what she learns to fake valid tags. This should even be true if Eve can convince Bob to send specific messages.</p>

For example, pretend Eve tells Bob to send the message:  

<blockquote>
  Dear Alice,  
  
  Eve said "hi."  
  
  Love, Bob  
</blockquote>

<p>and then Eve sees the corresponding tag.
Eve should still be unable to "fake" the tag for the message:</p>

<blockquote>
  Dear Alice,  
  
  Please give Eve $100 for me. I'll pay you back.  
  
  Love, Bob  
</blockquote>

In addition to being unforgeable under chosen-message attacks (UF-CMA), HMAC has the stronger property of being a <em>pseudo-random function</em> (PRF). This means that if Eve doesn't know the key, then all of Bob's HMAC tags look like completely random strings of bits, even if Eve knows or even <em>chooses</em> what messages Bob sends. This is a stronger property because every PRF is UF-CMA (you can't guess a big random number), but not every UF-CMA MAC algorithm is a PRF (it's possible that for some MAC algorithm, all the tags begin with 10 zeroes --- not very random-looking at all, but the other bits could still be hard to guess without knowing the key).  

#### Answer 2 (score 7)
A MAC is a general term describing `message authentication code`. That is a tag that will verify the integrity of your data. You are be able to say whether or not an attacker has tampered with the data that you receive. One construction is `HMAC` and it uses a hash function as a basic building block. There is another way which is `CBC-MAC` and its improved version `CMAC` and is based on block ciphers.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: SHA512 faster than SHA256? (score [43251](https://stackoverflow.com/q/26336) in 2017)

#### Question
I'm getting this strange result that <strong>SHA512</strong> is around 50% <em>faster</em> than <strong>SHA256</strong>. I'm using .net's `SHA512Managed` and `SHA256Managed` classes. The code is similar to the one posted <a href="https://stackoverflow.com/questions/30852745/hashing-speed-cryptic-results-hashing-twice-much-slower-than-hashing-once">here</a> but I'm referring to tests taking caching into account (from the second time reading the file onwards it seems that it's cached completely). I've tested it several times with the same results.  

My question is: is this logical or must there be something wrong with my test?    

#### Answer accepted (score 62)
This isn't necessarily unexpected. 32-bit platforms vs 64-bit platforms can make a significant difference, as well as the amount of data you're hashing.  

```cryptography
$ uname -m
x86_64

$ openssl speed sha256 sha512
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
sha256           29685.74k    79537.52k   148376.58k   186700.77k   196588.36k
sha512           23606.96k    96415.90k   173050.74k   253669.59k   291315.50
```

As you can see, on my 64-bit machine, SHA-512 beats SHA-256 for hashing anything more than 16 bytes of data at a time. And generally, the more data being hashed at once, the bigger the performance improvement.  

Edit: As @MaartenBodewes points out in the comments, there's also SHA-512/256 which does the same computation as normal SHA-512 (with a different initial value) but truncates the output to 256 bits. This is a better option (due to the different IV) than simply truncating the output of SHA-512 to 256 bits by yourself in the case where you need the higher throughput but are limited to 256 bit outputs. Alternatively, if you <em>really</em> need higher throughput, BLAKE2b is an excellent cryptographic hash that is extremely fast and natively supports arbitrarily sized outputs (between 1 and 64 bytes).  

#### Answer 2 (score 40)
SHA-512 has 25% more rounds than SHA-256. On a 64-bit processor each round takes the same amount of operations, yet can process double the data per round, because the instructions process 64-bit words instead of 32-bit words. Therefore, 2 / 1.25 = 1.6, which is how much faster SHA-512 can be under optimal conditions.  

Of course there is memory overhead, instruction latency, and other factors involved; on an Intel Ivy Bridge processor long message SHA-512 is 1.54 x faster, and on an AMD Piledriver it is 1.48 x faster.  

For small messages (less than 448 bits) SHA-512 will be approx 1.25 x slower, because only a single hash iteration is performed. There are also various crossover points where one hash will need to process an extra iteration and the other will not, but these numbers are averages, the actual performance graph will be stepped at the iteration increment point.  

#### Answer 3 (score 8)


<h5>Benchmarks</h1>

I would like to see also some real-life measurements here, so I hope you'll like it ;)  

<hr>

<h5>Intel Core i7-7700HQ (7th gen = <em>Kaby Lake</em>); RAM (DDR4)</h2>

<strong>HW / OS configuration:</strong>  

<ul>
<li><p>System: Linux Mint 19.1 Cinnamon 64-bit; `intel-microcode` package, as well as the latest UEFI/BIOS patch, were installed.</p></li>
<li><p>Processor: <strong><a href="https://ark.intel.com/content/www/us/en/ark/products/97185/intel-core-i7-7700hq-processor-6m-cache-up-to-3-80-ghz.html" rel="noreferrer">Intel® Core™ i7-7700HQ (Ark Intel)</a></strong>, <a href="https://www.cpubenchmark.net/cpu.php?cpu=Intel%20Core%20i7-7700HQ%20%40%202.80GHz&amp;id=2906" rel="noreferrer">PassMark</a>, 2.80GHz - 3.80GHz, 4 cores, 8 threads, laptop</p></li>
<li><p>Memory: 16GiB DDR4 2400MHz (single-channel)</p></li>
<li><p>CPU flags (`grep flags /proc/cpuinfo`):</p>

```cryptography
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
```
</li>
</ul>

<strong>Methodology:</strong>  

<ol>
<li><p>Starting with rebooting the laptop.</p></li>
<li><p>For speed measurement the `pv` utility (<a href="https://linux.die.net/man/1/pv" rel="noreferrer">man page</a>) has been used:</p>

```cryptography
pv --average-rate BigFile10GiBinRAM | sha512sum --binary
pv --average-rate BigFile10GiBinRAM | sha256sum --binary
```
</li>
<li><p>The `BigFile10GiBinRAM` was with `/dev/urandom` generated file.</p></li>
<li><p>Of course, all unnecessary services and programs were stopped at test time.</p></li>
<li><p>The file was located in the RAM (`tmpfs`).</p></li>
<li><p>I ran each test 3 times with the results being the same +/- 1.</p></li>
</ol>

<strong>Test results:</strong>  

<ol>
<li><p><strong>SHA-512</strong> resulted in speed of <strong>344MiB/s</strong> ~ about <strong>60% faster</strong>!</p></li>
<li><p><strong>SHA-256</strong> resulted in speed of <strong>215MiB/s</strong>.</p></li>
</ol>

<hr>

<h5>Intel Core i7-4700HQ (4th gen = <em>Haswell</em>); SSD (SATA)</h2>

<strong>HW / OS configuration:</strong>  

<ul>
<li><p>System: Linux Mint 18.2 Cinnamon 64-bit; `intel-microcode` package, as well as the latest UEFI/BIOS patch, were installed.</p></li>
<li><p>Processor: <strong><a href="https://ark.intel.com/content/www/us/en/ark/products/75116/intel-core-i7-4700hq-processor-6m-cache-up-to-3-40-ghz.html" rel="noreferrer">Intel® Core™ i7-4700HQ (Ark Intel)</a></strong>, <a href="https://www.cpubenchmark.net/cpu.php?cpu=Intel%20Core%20i7-4700HQ%20%40%202.40GHz&amp;id=1949" rel="noreferrer">PassMark</a>, 2.40GHz - 3.40GHz, 4 cores, 8 threads, laptop</p></li>
<li><p>Memory: 16GiB DDR3 1600MHz (dual-channel)</p></li>
<li><p>CPU flags (`grep flags /proc/cpuinfo`): </p>

```cryptography
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
```
</li>
</ul>

<strong>Methodology:</strong>  

<ol>
<li><p>Starting with rebooting the laptop.</p></li>
<li><p>For speed measurement the `pv` utility (<a href="https://linux.die.net/man/1/pv" rel="noreferrer">man page</a>) has been used:</p>

```cryptography
pv --average-rate BigFile103GiB | sha512sum --binary
pv --average-rate BigFile103GiB | sha256sum --binary
```
</li>
<li><p>The `BigFile103GiB` was a virtual disk containing real data (VirtualBox).</p></li>
<li><p>Of course, the virtual machine wasn't running at test time, and all unnecessary services and programs were stopped at test time.</p></li>
<li><p>The file was located on a 2.5" SATAIII SSD drive.</p></li>
<li><p>I ran each test 3 times with the results being the same +/- 1.</p></li>
</ol>

<strong>Test results:</strong>  

<ol>
<li><p><strong>SHA-512</strong> resulted in speed of <strong>275MiB/s</strong> ~ about <strong>50% faster</strong>!</p></li>
<li><p><strong>SHA-256</strong> resulted in speed of <strong>183MiB/s</strong>.</p></li>
</ol>

<hr>

<h5>Intel Xeon E3-1225 v3 (4th gen = <em>Haswell</em>); RAM (DDR3)</h2>

<strong>HW / OS configuration:</strong>  

<ul>
<li><p>System: GNU/Linux Debian 9 64-bit; `intel-microcode` package, as well as the latest UEFI/BIOS patch, were installed.</p></li>
<li><p>Processor: <strong><a href="https://ark.intel.com/content/www/us/en/ark/products/75461/intel-xeon-processor-e3-1225-v3-8m-cache-3-20-ghz.html" rel="noreferrer">Intel® Xeon® E3-1225 v3 (Ark Intel)</a></strong>, <a href="https://www.cpubenchmark.net/cpu.php?cpu=Intel%20Xeon%20E3-1225%20v3%20%40%203.20GHz&amp;id=1993" rel="noreferrer">PassMark</a>, 3.20GHz - 3.60GHz, 4 cores, 4 threads, server</p></li>
<li><p>Memory: 32GiB DDR3 1600MHz (dual-channel) UDIMM <a href="https://en.wikipedia.org/wiki/ECC_memory" rel="noreferrer">ECC</a></p></li>
<li><p>CPU flags (`grep flags /proc/cpuinfo`): </p>

```cryptography
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm epb tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts
```
</li>
</ul>

<strong>Methodology:</strong>  

<ol>
<li><p>Starting with rebooting the server.</p></li>
<li><p>For speed measurement the `pv` utility (<a href="https://linux.die.net/man/1/pv" rel="noreferrer">man page</a>) has been used:</p>

```cryptography
pv --average-rate BigFile24GiBinRAM | sha512sum --binary
pv --average-rate BigFile24GiBinRAM | sha256sum --binary
```
</li>
<li><p>The `BigFile24GiBinRAM` was with `/dev/urandom` generated file.</p></li>
<li><p>Of course, all unnecessary services and programs were stopped at test time.</p></li>
<li><p>The file was located in the RAM (`tmpfs`).</p></li>
<li><p>I ran each test 3 times with the results being the same +/- 1.</p></li>
</ol>

<strong>Test results:</strong>  

<ol>
<li><p><strong>SHA-512</strong> resulted in speed of <strong>315MiB/s</strong> ~ about <strong>53% faster</strong>!</p></li>
<li><p><strong>SHA-256</strong> resulted in speed of <strong>206MiB/s</strong>.</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: What is the difference between known-plaintext attack and chosen-plaintext attack? (score [42274](https://stackoverflow.com/q/2846) in 2012)

#### Question
I am very confused between the concept of known-plaintext attack and chosen-plaintext attack. It seems to me that these two are the same thing, but it definitely is not.  

Can anyone explain to me how these two differ?  

#### Answer 2 (score 34)
It's the difference between an active and a passive attacker:  

<ul>
<li><p><strong>Known plaintext attack:</strong> The attacker knows at least one sample of both the plaintext and the ciphertext. In most cases, this is recorded real communication. If the <a href="http://en.wikipedia.org/wiki/XOR_cipher">XOR cipher</a> is used for example, this will reveal the key as `plaintext xor ciphertext`.</p></li>
<li><p><strong>Chosen plaintext attack:</strong> The attacker can specify his own plaintext and encrypt or sign it. He can carefully craft it to learn characteristics about the algorithm. For example he can provide an empty text, a text which consists of one "a", two "aa", ... For example: if the <a href="http://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher">Vigenère cipher</a> is used, it is very easy to extract the key length and recover the key by repeating one letter.</p></li>
</ul>

So the second type of attack is a lot more powerful.  

#### Answer 3 (score 5)
A <em>known plaintext</em> attack is that if you know any of the plaintext that has been encrypted and have the resulting encrypted file, with a flawed encryption algorithm you can use that to break the rest of the encryption.   

Example: We saw this with the old pkzip encryption method. In this case if you had any of the unencrypted files in the archive, you could use that to obtain the key to break the rest.  

A <em>chosen plaintext</em> attack is the same thing except you get to choose the plaintext which can be useful. In this case the attacker determines what will be encrypted and then uses the result to determine the key (or perhaps other less useful information) of the encryption.   

Example: A good example here is XOR encryption. If you can choose the plaintext and get to see the result, you can use those to easily determine the key being used.   

You could also use a known plaintext attack with non-salted hashes. So if I choose a password and can see the resulting hash, I could search to see if there are any other similar hashes and therefore know they have the same password.   

So yeah they are basically the same thing, its really just a matter of what you have to work with or what you are trying to accomplish.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: What is the "shared secret" used for in IPSec VPN? (score [41135](https://stackoverflow.com/q/9926) in 2013)

#### Question
Can somebody explain what the "shared secret" and "password" do when opening/creating a VPN tunnel?  

In this specific case I setup a VPN to my Fritz!Box and I had to provide a shared secret (which was pregenerated and very long) and a password.  

I'd like to understand how each of these two credentials is used in terms of encryption.  

#### Answer accepted (score 14)
Most likely, this 'shared secret' was actually an IKE "preshared key"; it is used to authenticate the two sides (and, for IKEv1, is stirred into the keys).  It actually isn't used as a key (and hence someone learning that key cannot use it to listen in, unless they perform an active Man-in-the-Middle attack).  

I suspect the password is the authentication credential to the remote operating system; it doesn't get involved with the encryption at all.  

Now, if you're asking "how is this IKE preshared key" used, well, I'll try to outline it for you; the bottom line is that someone with the preshared key cannot listen in (or be able to decrypt previously captured sessions).  They would be able to perform a man-in-the-middle attack; that's because the preshared-key works as authentication data; someone with it can impersonate.  

To make this even more complex, there are two different version of IKE (IKEv1 and IKEv2), and they use the preshared key somewhat differently.  Since I don't know which one you're using, I'll list how they both work separately.  

For both versions of IKE, the negotiation happens in two phases; the differences (that you care about) occur in the first phase (which generates the IKE SAs; that is an encrypted control channel that the two sides use to coordinate things).  

Here's how the first phase of IKEv1 works (assuming that you're using preshared key authentication, and omitting the parts not relevant to the key generation):  

<ul>
<li><p>The two sides exchange nonces</p></li>
<li><p>The two sides perform a Diffie-Hellman exchange</p></li>
<li><p>The two sides each take the nonces, the Diffie-Hellman shared secret and the preshared key), and generate a set of IKE keys</p></li>
<li><p>They exchange IKE encrypted messages (to verify that both came up with the same IKE keys; if they used different IKE keys, they won't).</p></li>
</ul>

For IKEv2, this first phase looks like:  

<ul>
<li><p>The two sides exchange nonces</p></li>
<li><p>The two sides perform a Diffie-Hellman exchange</p></li>
<li><p>The two sides each take the nonces, the Diffie-Hellman shared secret, and generate a set of IKE keys</p></li>
<li><p>Via IKE encrypted messages, they exchange authentication data.  For preshared key authentication, this is a complex (noninvertable) function of the preshared key, and the keying data.  The idea is that if there was a man-in-the-middle who didn't know the preshared key, the keying data between the actual two sides woudl differ, and the man-in-the-middle wouldn't be able to adjust this authentication tag to account for that).</p></li>
</ul>

Now, for both IKEv1 and IKEv2, they perform the second phase; they generate the IPSec SAs, which are the keys (and other data) used to actually encrypt the traffic.  To do this, they exchange SPI values and nonces, possibly do another Diffie-Hellman exchange, and they create the IPSec keys from some IKE keying data, the SPI values (and the Diffie-Hellman shared secret, if a Diffie-Hellman was used.  

Now that the two sides have the IPSec SAs established, they can now send and receive encrypted traffic.  

And, because a Diffie-Hellman operation was involved, someone listening into the traffic is unable to decrypt anything; even if they know what the "preshared key" was.  

<hr>

From the <a href="http://www.avm.de/de/Service/Service-Portale/Service-Portal/VPNen_Grundlagen/vpn_fuer_experten.php?portal=VPNen">fritzbox website on "VPN for experts"</a>:  

<blockquote>
  <p>IKE negotiation takes place in two phases. The first phase serves to
  establish an encrypted connection; in the second phase the actual VPN
  tunnel is established - already encrypted. Special authentication
  procedures ensure that no password or key is transmitted in plain text
  during the negotiation. A hacker tracing the establishment of the VPN
  connection using IPSec cannot procure any security-sensitive
  information.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Can you explain Bleichenbacher's CCA attack on PKCS#1 v1.5? (score [40836](https://stackoverflow.com/q/12688) in )

#### Question
I've studied that the Bleichenbacher's CCA attack on PKCS#1 v1.5. is a base to many versions of attacks in the area.  

I'm trying to understand that attack, but every explanation I saw starts with the technical details, without giving some overview, so it's hard to follow...  

Can you explain it in a simple words before giving the little details?  

#### Answer accepted (score 97)
When <em>encrypting</em> something with RSA, using PKCS#1 v1.5, the data that is to be encrypted is first <em>padded</em>, then the padded value is converted into an integer, and the RSA modular exponentiation (with the public exponent) is applied. Upon decryption, the modular exponentiation (with the <em>private</em> exponent) is applied, and then the padding is removed. The core of Bleichenbacher's attack relies on an <em>oracle</em>: the attack works if there is some system, somewhere, which can tell, given a sequence of bytes of the length of an encrypted message, whether decryption would yield something which has the proper padding format or not.  

An example would be a SSL/TLS server. In the initial handshake, at some point, the client is supposed to generate a random key (the "pre-master secret"), encrypt it with the server's public key, and send it. The server decrypts the value, obtains the pre-master secret, and then compute from that pre-master secret the keys used for symmetric encryption of the rest of the connection. Using the <a href="http://tools.ietf.org/html/rfc5246#section-7.3">standard</a> for guidance, the client sends a `ClientKeyExchange` (which contains the encrypted pre-master secret), then a `ChangeCipherSpec`, then `Finished`; this last message is encrypted with the derived symmetric key and its contents are verified by the server.  

If the client sends a random sequence of bytes of the right length to the server instead of a properly encrypted pre-master secret, then the server will, most of the time, respond with an error message telling "I tried to decrypt your `ClientKeyExchange` contents, but this failed, there was not a proper padding in it". However, by pure chance, it may happen that the random string, after applying the modular exponentiation, yields something which really looks like a pre-master secret with correct padding. In that case, the server will not complain about the `ClientKeyExchange`, but about the `Finished` message, which will be incorrectly encrypted.  

This is the information the attacker wants: whether the sequence of bytes he sent would, upon decryption, look properly padded or not.  

<hr />

Let's see with a bit more technical details. In RSA, let $n$ be the public modulus. Let $M$ be a message to encrypt with $n$ (in the case of SSL, $M$ is the pre-master secret, of length 48 bytes). The PKCS#1 v1.5 padding, for encryption, consists in adding some bytes to the left, so that the total length after padding is equal to that of $n$. For instance, if the server's public key is a 2048-bit RSA key, then $n$ has length 256 bytes, so the padded $M$ should also have length 256 bytes.  

A <em>properly padded</em> message $M$ has the following format:  

```cryptography
0x00 0x02 [some non-zero bytes] 0x00 [here goes M]
```

so the sequence of bytes will begin with a byte of value 0, then a byte of value 2, then some bytes which should have random values (but not zero), then a byte of value 0, then $M$ itself. The number of non-zero bytes is adjusted so that the total length is equal to the length of $n$. Upon decryption, the server will look at the first two bytes, and require them to be equal to 0x00 and 0x02, in that order. Then it will scan for the next byte of value 0, thus skipping over all the random non-zero bytes. This way, the padding can be unambiguously removed.  

It follows that if the client sends a random string of bytes, then it has probability roughly between $2^{-15}$ and $2^{-17}$ to follow the PKCS#1 padding format (that's the probability that the first two bytes are 0x00 0x02, and that there is at least one byte of value 0 afterwards; exact probability depends on the length and value of $n$).  

<strong>The attack scenario</strong> is the following:  

<ul>
<li>There is a SSL server, which will send distinct error messages depending on whether a proper PKCS#1 padding was found or not. Alternatively, the two cases could be distinguished through some other information leak (e.g. the server takes longer to respond if the padding was correct).</li>
<li>The attacker eavesdropped on a connection, and would like to decrypt it. He observed the `ClientKeyExchange`, so he saw an encrypted message $c$. He knows that $c = m^e \pmod n$ where $e$ is the public exponent, and $m$ is the padded pre-master secret for that connection. He wants to recover $m$, or at least the pre-master secret which is contained in $m$, because that will allow him to compute the symmetric keys used for the connection.</li>
</ul>

Then the attacker will initiate many connections to the server. For each connection, the attacker generates a value $s$ and sends, as `ClientKeyExchange`, a value $c' = cs^e \pmod n$. The server decrypts that, and obtains $m' = (cs^e)^d \pmod n$ ($d$ is the private exponent), which is equal to $ms \pmod n$. Most of the time, this $ms$ value will not be properly padded (it will not begin with 0x00 0x02 or will not contain an extra 0x00). However, with a low but non-negligible probability (once every 30000 to 130000 attempts, roughly), luck will have it that the $ms \pmod n$ value looks padded. If that is the case, then the server's behaviour will inform the attacker of that fact. The attacker then learns that, for this value $s$ (the attacker knows it, since he chose it), then $ms \pmod n$ is in a specific range (the range of integers which begin with 0x00 0x02 when encoded in bytes using big-endian convention).  

The rest of the attack is trying again, with carefully chosen random values $s$. Each time the server responds with "that was a proper PKCS#1 padding", this gives some information which helps the attacker narrow his guesses on $m$. After a few million connections in all, the attacker learned enough to pinpoint the exact $m$, yielding the pre-master secret.  

See <a href="http://archiv.infsec.ethz.ch/education/fs08/secsem/bleichenbacher98.pdf">the original article</a> for details; once you know how the RSA padding works, the rest is just maths, which are not too hard.  

<strong>To prevent this attack</strong>, SSL servers do <em>not</em> inform the client about padding woes. If decryption fails because of a bad padding, then the server continues with a random pre-master secret (the true failure will then occur when processing the `Finished` message).  

One may note that the specific weakness of the PKCS#1 v1.5 padding (for encryption) is that it is not very redundant; the random bytes are, indeed, random, without any specifically enforced value. This is what allows a sequence of random bytes to be "properly padded" with a small but not negligible probability. Newer versions of <a href="http://tools.ietf.org/html/rfc3447">PKCS#1</a> describe a new padding type, called OAEP, which uses hash function to add a lot of internal redundancy, which makes it extremely improbable that a random string matches the padding format. This prevents Bleichenbacher's attack. Unfortunately, SSL still uses PKCS#1 v1.5.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Length of encryption password aes-256-cbc (score [40735](https://stackoverflow.com/q/34884) in 2016)

#### Question
I'm encrypting a file with sensitive information with   

`cat secret | openssl aes-256-cbc -a -salt > secret.enc`  

I am choosing a random encryption password with `openssl rand -base64 32 | head -c [password-length]`  

Is there any standard, how long it should be? Given the password length, how long would it take to crack and view the contents of the file?   

I have read <a href="https://www.reddit.com/r/theydidthemath/comments/1x50xl/time_and_energy_required_to_bruteforce_a_aes256/" rel="noreferrer">this</a> article, but it seems it supposes that you use a password size of 256 bits.   

Edit: I found this picture, which pretty much answers my question. Is it reliable?  

<a href="https://www.inetsolution.com/blog/june-2012/complex-passwords-harder-to-crack,-but-it-may-not" rel="noreferrer">https://www.inetsolution.com/blog/june-2012/complex-passwords-harder-to-crack,-but-it-may-not</a>  

#### Answer 2 (score 8)
Suppose you use 128 characters out of an alphabet (this is a large alphabet). To create a key you'd need about 37 fully random characters to create an AES key of 256 bit strength. Even you would create such a password, you'd have trouble encoding it over the required number of bits. You could either use a 44 character base 64 string or 64 character hex string as well - at least those would be easy to decode/encode to/from bytes. In general, people don't use those kind of passwords.   

This is why password based key derivation functions such as bcrypt or PBKDF2 are being used. These strengthen the password using salt and a work factor (or iteration count for PBKDF2). Although still less then perfect, they allow you to use passwords relatively securely.  

In general you should look up Password Based Encryption or PBE. This is for instance specified in the PKCS#5 standards (which defines PBKDF2).  

<hr>

The default OpenSSL implementation uses a scheme called `EVP_BytesToKey`. It uses an 8 byte salt and an "iteration count" set to 1. Due to the non-existent work factor you are best off specifying all 37 characters if you want to achieve such high level security.  

In the end you're better off using e.g. PGP public / private key encryption. 128 bits of security is usually sufficient; the chance that your password is compromised is much larger than that anybody with a quantum computer tries to hack your file.   

#### Answer 3 (score 6)
AES supports <a href="https://en.wikipedia.org/wiki/Advanced_Encryption_Standard#Definitive_standards" rel="nofollow noreferrer">three key lengths</a>. They are 128, 192 and 256 bits long. You chose to use the 256 bit algorithm that operates in <a href="https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher_Block_Chaining_.28CBC.29" rel="nofollow noreferrer">CBC mode</a>. It's a correct choice.  

Now all you need is:  

<ul>
<li>key - 256 bits long</li>
<li>initialization vector - 128 bits long</li>
</ul>

You can generate them using the command I found <a href="http://www.ibm.com/support/knowledgecenter/SSLVY3_9.7.0/com.ibm.einstall.doc/topics/t_einstall_GenerateAESkey.html" rel="nofollow noreferrer">here</a>:  

```cryptography
openssl enc -aes-256-cbc -k secret -P -md sha1
```

where the "secret" is your password.  

I suggest not using a truly random key and IV, because you have to save them somewhere, and adversary can just read it from your hard drive. It's much better to use a long and complicated password that he has to read from a post-it-note glued to your monitor, and derive the key and IV from it.  

As for security, let me put it this way. If I wanted to crack 256 bits long key and 128 bit long IV on my work laptop, I would probably be around a fifth of way done when the universe would collapse. It's much simpler to use <a href="https://en.wikipedia.org/wiki/Rubber-hose_cryptanalysis" rel="nofollow noreferrer">rubber-hose cryptanalysis</a> in <a href="https://xkcd.com/538/" rel="nofollow noreferrer">this case</a>.  

EDIT:  

Just for you to know you shouldn't use password as a key directly. You need to derive a key from a password. The command I pasted does exactly that. About the security of the password you already answered yourself. 9 characters is the absolute minimum (if there is at least one uppercase letter, one lowercase letter, one number and one symbol). But I strongly suggest using a <a href="http://www.passworddragon.com/password-vs-passphrase" rel="nofollow noreferrer">passphrase</a> instead of a password. They are vulnerable to dictionary hacking, but if you use enough words a dictionary hack also takes years to complete.  

There are over a <a href="http://www.languagemonitor.com/number-of-words/number-of-words-in-the-english-language-1008879/" rel="nofollow noreferrer">milion</a> words in the English language.  

If we use only lowercase letters in our four word passphrase, the dictionary hack has to do in the worst case $1000000^{4} = 10^{24}$ searches. In comparison, there are around 100 characters on the keyboard. A password of 12 of those characters will be cracked in less than $100^{12} = 10^{24}$ searches.  

This mean that "singing retracted eleventh elephant" is an equivalent of a 12 character password, and also it's much easier to remember. And if we use a comma somewhere, uppercase letter, or use a word from a different language it gets much safer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Why haven't any SHA-256 collisions been found yet? (score [40569](https://stackoverflow.com/q/47809) in 2017)

#### Question
I've been thinking about this for a few days, a SHA-256 algorithm outputs 64 characters which can either be a lowercase letter or a number from 0-9. Which should mean that there are 64^36 distinct SHA-256 results.  

How has a collision never been found? If I decide to find the hash for a random input of increasing length I should find a collision eventually, even if it takes years. I imagine this can also be done where the input is a large file and you just change one byte and calculate the hashes until you find a collision. Why hasn't' this happened?  

#### Answer accepted (score 62)
I think you underestimate just how large $2^{256} \gg 64^{36}$ is.  

<blockquote>
  How has a collision never been found?  
</blockquote>

It will take a <em>very, very, very,</em> $\text{very}^{\text{very}}$ long time to find one. For comparison, as of January 2015, Bitcoin was computing <a href="https://en.bitcoin.it/wiki/Hash_per_second" rel="noreferrer">300 quadrillion SHA-256 hashes per second</a>. That's $300 \times 10^{15}$ hashes per second.  

Let's say you were trying to perform a <a href="https://en.wikipedia.org/wiki/Collision_attack" rel="noreferrer">collision attack</a> and would "only" need to calculate $2^{128}$ hashes. At the rate Bitcoin is going, it would take them  

$2^{128} / (300 \times 10^{15} \cdot 86400 \cdot 365.25) \approx 3.6 \times 10^{13}$ years. In comparison, our universe is only about $13.7 \times 10^9$ years old. Brute-force guessing is not a practical option.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: What's the appeal of using ChaCha20 instead of AES? (score [40189](https://stackoverflow.com/q/34455) in )

#### Question
I read about ChaCha20 being used in TLS by Google, SSH, and towards standardization in general.  

What's the appeal of using something other than AES, what with AES receiving dedicated CPU instructions on various architectures to make it so efficent?  

#### Answer 2 (score 42)
I believe there are three main reasons why ChaCha20 is sometime preferred to AES.  

<ol>
<li><p>On a general purpose 32-bit(or greater) CPU without dedicated instructions
ChaCha20 is generally faster than AES. The reason for this is the
fact that ChaCha20 is based on ARX (Addition-Rotation-XOR) which are
CPU friendly instructions, while AES uses binary fields for the Sbox
and Mixcolumns computations, which are generally implemented as look
up table in order to be more efficient.</p></li>
<li><p>The fact that AES uses lookup table with an index derived from
the secret makes general implementations vulnerable to cache-timing
attacks. ChaCha20 is not vulnerable to such attacks. (AES implemented through AES-NI is also not vulnerable)</p></li>
<li><p>Daniel J. Bernstein is having a significant above-than-average
success in advertising his algorithms. (I'm not implying there are
no merits. I'm just stating the fact that his
algorithms have success in terms of deployment)</p></li>
</ol>

<p>Of course there are other reasons that justify the choice of AES instead of ChaCha20. 
<br>To name a few:</p>

<ul>
<li>Dedicated instructions on high end CPUs</li>
<li>Amount of received cryptanalysis </li>
<li>Availability of studies on side channel (other than cache timing) protections</li>
</ul>

#### Answer 3 (score 11)
Unless we find information from Google - such as white papers &amp; mailinglist posts - we can only <em>speculate</em> why ChaCha20 is chosen. I think that efficient software implementation is still the most likely reason. That AES-GCM is relatively brittle - for instance with regards to timing attacks - could be another.  

Note that even though AES-NI is becoming more commonplace in the x86 processor market, that doesn't mean that other processor architectures are implementing AES acceleration. For instance cheap Android phones may not incorporate it.   

Furthermore, although AES-NI support is on the CPU, that doesn't mean that the software is actually <em>using</em> the instruction. Notice for instance that AES-GCM is only accelerated in Java 9. GCM mode requires additional instructions for the Galois field multiplication.  

Some library implementations of AES_GCM also buffer the ciphertext until the authentication tag is verified instead of using the online properties of the underlying CTR mode decryption. This could efficient implementations harder with regards to memory management.  

<hr>

It is of course possible to use AES CTR and Poly1305 together (while making sure that the keys aren't reused in an insecure fashion). But then the organization would have to define that AEAD algorithm first before you can use it. So using AES probably means GCM authentication and ChaCha20 gives you Poly1305/AES.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: HMAC-SHA1 vs HMAC-SHA256 (score [38568](https://stackoverflow.com/q/15382) in )

#### Question
I have three questions:  

<ol>
<li>Would you use HMAC-SHA1 or HMAC-SHA256 for message authentication?</li>
<li>How much HMAC-SHA256 is slower than HMAC-SHA1?</li>
<li>Are the security improvements of SHA256 (over SHA1) enough to justify its usage?</li>
</ol>

#### Answer 2 (score 33)
<blockquote>
  Would you use HMAC-SHA1 or HMAC-SHA256 for message authentication?  
</blockquote>

Yes.  

That is a semi-serious answer; both are very good choices, assuming, of course, that a Message Authentication Code is the appropriate solution (that is, both sides share a secret key), and you don't need extreme speed.  

<blockquote>
  How much HMAC-SHA256 is slower than HMAC-SHA1?  
</blockquote>

Those sorts of crypto performance questions are quite platform specific, and so it's hard to answer definitively.  In my experience, I've seen SHA-1 (and hence HMAC-SHA-1) be about 30% faster than SHA-256; Your Mileage May Vary, of course.  

Of course, the obvious comeback is "how much is this performance delta important to you?".  That rather depends on how fast you're adding/checking integrity tags.  

<blockquote>
  Are the security improvements of SHA256 (over SHA1) enough to justify its usage?  
</blockquote>

To the best of our knowledge, there is essentially no security difference between HMAC-SHA256 and HMAC-SHA1; with a sufficiently long key, both are impervious to brute force, and with a reasonably long tag, both will catch any forged messages with the expected probability.  There is a known weakness to SHA1 that allows someone to compute a collision in less time than expected; there is no known way to apply that to HMAC-SHA1, and so there are no known methods of attack (other than, as I mentioned just now, brute force, and guessing the tags randomly).  

#### Answer 3 (score 20)
I would use HMAC-SHA256.  

While <a href="https://crypto.stackexchange.com/a/15383/13625">poncho's answer</a> that both are secure is reasonable, there are several reasons I would prefer to use SHA-256 as the hash:  

<ul>
<li>Attacks only get better. SHA-1 collision resistance is <a href="https://crypto.stackexchange.com/questions/3690/no-sha-1-collision-yet-sha-1-is-broken">already broken</a>, so it's not impossible that other attacks will also be possible in the future.</li>
<li>It allows you to depend on just one hash function, which you can also use in signature algorithms etc. where collision resistance <em>is</em> required.</li>
<li>You don't have to justify using a broken primitive. ("I heard SHA-1 is broken?")</li>
</ul>

The only potential downside is performance, but it's probably not significant in most HMAC use cases, since where performance is important you can find even faster MACs to use instead. So I would consider the above reasons sufficient in most cases to justify using SHA-256 as the HMAC hash.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: What's the fundamental difference between Diffie-Hellman and RSA? (score [38557](https://stackoverflow.com/q/2867) in 2012)

#### Question
What is the difference in the purpose of DH and RSA?  Aren't they both public-key encryption?  

#### Answer accepted (score 30)
<p>The difference is subtle.<br>
DH is used to generate a <em>shared secret</em> in <em>public</em> for later <strong><em>symmetric</em></strong> ("private-key") encryption:</p>

<blockquote>
  <h5>Diffie-Hellman:</h3>
  
  <ul>
  <li>Creates a shared secret between two (or more) parties, for <strong>symmetric</strong> cryptography</li>
  <li><strong>Key identity:</strong> (<i>gen</i><sup><i>s</i><sub>1</sub></sup>)<sup><i>s</i><sub>2</sub></sup> = (<i>gen</i><sup><i>s</i><sub>2</sub></sup>)<sup><i>s</i><sub>1</sub></sup> = <i>shared secret</i>  &nbsp; (mod <i>prime</i>)</li>
  <li><p>Where:</p>
  
  <ul>
  <li><i>gen</i> is an integer whose powers generate <i>all</i> integer in [1, <i>prime</i>)  &nbsp; (mod <i>prime</i>)</li>
  <li><i>s<sub>1</sub></i> and <i>s<sub>2</sub></i> are the individuals' "secrets", <em>only</em> used to generate the symmetric key</li>
  </ul></li>
  </ul>
</blockquote>

RSA is used to come up with a public/private key pair for <strong><em>asymmetric</em></strong> ("public-key") encryption:  

<blockquote>
  <h5>RSA:</h3>
  
  <ul>
  <li>Used to perform "true" <strong>public-key</strong> cryptography</li>
  <li><strong>Key identity:</strong> (<i>m</i><sup><i>e</i></sup>)<sup><i>d</i></sup> = <i>m</i>  &nbsp;&nbsp;(mod <i>n</i>)  &nbsp;&nbsp;(lets you recover the encrypted message)</li>
  <li><p>Where:</p>
  
  <ul>
  <li><i>n</i> = <i>prime</i><sub>1</sub> × <i>prime</i><sub>2</sub>  &nbsp;&nbsp; (<i>n</i> is publicly used for encryption)</li>
  <li><i>φ</i> = (<i>prime</i><sub>1</sub> - 1) × (<i>prime</i><sub>2</sub> - 1)   &nbsp;&nbsp;(<a href="http://en.wikipedia.org/wiki/Euler&#39;s_totient_function" rel="nofollow noreferrer">Euler's totient function</a>)</li>
  <li><i>e</i> is such that 1 &lt; <i>e</i> &lt; <i>φ</i>, and (<i>e</i>, <i>φ</i>) are coprime  &nbsp;&nbsp;&nbsp;(<i>e</i> is publicly used for encryption)</li>
  <li><i>d</i> × <i>e</i> = 1  &nbsp; (mod <i>φ</i>)  &nbsp;&nbsp;&nbsp;(the modular inverse <i>d</i> is privately used for decryption)</li>
  </ul></li>
  </ul>
</blockquote>

<p>It just so happens that -- in practice -- RSA's results are subsequently used to generate a <em>symmetric</em> key.<br>
Furthermore, it also happens that you can <em>also</em> <a href="http://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange#Public_Key" rel="nofollow noreferrer">modify DH to be used for public-key encryption</a>.<br>
But they are fundamentally different, even though both of them have "public" and "private" components.</p>

#### Answer 2 (score 5)
Yes, they're both public key systems. The difference in the way that you're asking is that Diffie-Hellman relies on the hardness of taking logarithms (actually discrete logs, but just don't worry about that for now). RSA relies on the hardness of factoring.  

Interestingly, the two problems are related. There are mathematical theorems that say that a structural problem in one means there's a structural problem in the other. But they are two distinct families of public key crypto, the logarithm family and the factoring family.   

Elliptic curve crypto, by the way, is just logarithm-family crypto on a different finite field than modular arithmetic. If that just sailed over your head, I can explain later.  

Jon  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: What's the difference between RSA and Diffie-Hellman? (score [38270](https://stackoverflow.com/q/42180) in 2017)

#### Question
I've been reading on a lot of websites that same thing: RSA is for communication using the public and private key for both the server and client, where Diffie-Hellman is just for exchanging the same secret key that will then be used for both encryption and decryption, but they both depend on the same MATHS, e.g: that <a href="https://www.quora.com/What-is-the-difference-between-RSA-and-Diffie-Hellman" rel="noreferrer">question</a> on quora<a href="https://i.stack.imgur.com/WflGo.png" rel="noreferrer"><img src="https://i.stack.imgur.com/WflGo.png" alt="question"></a>Then I was confused when I also read that RSA shares a master and pre-master key, as well, like in this <a href="https://crypto.stackexchange.com/questions/27131/differences-between-the-terms-pre-master-secret-master-secret-private-key">question</a>:<a href="https://i.stack.imgur.com/NRbF7.png" rel="noreferrer"><img src="https://i.stack.imgur.com/NRbF7.png" alt="question"></a>SO, the question here is, does RSA use the public and private key to encrypt the whole conversation, or is it used just to encrypt a key then the encryption depends on that symmetric key? And if it was used to encrpyt the key and it was the same MATH as Diffie-Hellman, so what is the difference anyways??  

#### Answer accepted (score 18)
In practice, in situations like TLS, public key encryption will be used to encrypt a secret for encrypting the actual messages, as part of a <a href="https://en.wikipedia.org/wiki/Hybrid_cryptosystem" rel="nofollow noreferrer">hybrid cryptosystem</a>. This is done because <a href="https://crypto.stackexchange.com/questions/586/why-is-public-key-encryption-so-much-less-efficient-than-secret-key-encryption?noredirect=1&amp;lq=1">Asymmetric cryptography is significantly slower</a> than symmetric cryptography.   

However, there are other cryptosystems and applications that utilize public key encryption directly. As an example, <a href="https://en.wikipedia.org/wiki/Ransomware#Encrypting_ransomware" rel="nofollow noreferrer">ransomware</a> is not concerned with how long it takes to encrypt something, and it benefits immensely from not possessing the decryption key.   

There are also <a href="http://web.engr.oregonstate.edu/~yavuza/LogFASYavuzNingReiter.pdf" rel="nofollow noreferrer">cryptographic logging schemes</a> that make use of public key encryption directly:  

<blockquote>
  <p>Due to the forensic value of audit logs, it is vital to provide
  compromise resiliency
  and
  append-only
  properties in a logging system to prevent active attackers. Unfortunately, existing symmetric secure logging schemes are not
  publicly verifiable and cannot address applications that require public auditing...</p>
</blockquote>

So whether or not public key encryption is used for key exchange or on the data itself is actually a matter of where the tools are being used.   

RSA and Diffie-Hellman are based on different but similar mathematical problems. While they both make use of modular exponentiation, exactly what they do/why they work is different. This is evident when you look at how to attack each one: <a href="https://en.wikipedia.org/wiki/RSA_(algorithm)" rel="nofollow noreferrer">RSA</a> is threatened by integer factorization, while <a href="https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange" rel="nofollow noreferrer">DH</a> is threatened by discrete logarithms.  

Additionally: DH is a "<a href="https://en.wikipedia.org/wiki/Key_exchange" rel="nofollow noreferrer">key exchange</a>" algorithm, which is different then "<a href="https://en.wikipedia.org/wiki/Public-key_cryptography#Public_Key_Encryption" rel="nofollow noreferrer">public key encryption</a>"; It allows you and another person to mutually arrive at the same piece of information, while nobody else can. It is more or less equivalent to using public key encryption on a random message. This is in contrast to public key encryption, where you get to select the message that both parties will be aware of.  

Note that Diffie-Hellman can be turned into <a href="https://en.wikipedia.org/wiki/ElGamal_encryption" rel="nofollow noreferrer">public key encryption</a>.  

<h5>tl;dr</h2>

Both use modular exponentiation to provide the main functionality (encryption/signature generation for RSA, key agreement for DH), but the underlying problem, the key pair generation and the security properties of the input/output are different  

#### Answer 2 (score 46)
<h5>Diffie-Hellman Key Exchange</h2>

<strong>Problem:</strong> We have a symmetric encryption scheme and want to communicate. We don't want anybody else to have the key, so we can't say it out loud (or over a wire).  

<strong>Solution/Mechanics:</strong>   

<ol>
<li>We each pick a number, usually large, and keep it a secret, even from each other. I'll pick $x$, and you'll pick $y$.</li>
<li><p>We agree on two more numbers, both prime, which anybody can know. We'll call them $g$ and $n$.</p></li>
<li><p>I'll calculate $g^x\bmod n$ and tell you my answer. You'll calculate $g^y\bmod n$ and tell me your answer.</p></li>
<li><p>Our shared key is $g^{xy}\bmod n = (g^y\bmod n)^x\bmod n = (g^x\bmod n)^y\bmod n$.</p></li>
</ol>

<h5>RSA Asymmetric Encryption</h2>

<strong>Problem:</strong> I want anybody to be able to encrypt a message, but I'm the only one who can decrypt it. I don't want to share decryption keys with anybody.  

<strong>Solution/Mechanics:</strong>   

<ol>
<li><p>I choose two large primes, $p$ and $q$. </p></li>
<li><p>I calculate $n$ such that $pq = n$.</p></li>
<li><p>I calculate $t$ such that $(p-1)(q-1) = t$.</p></li>
<li><p>I choose an integer $e$ that is both less than $t$ and coprime with $t$.</p></li>
<li><p>I find $d$ such that $d$ is the multiplicative inverse of $e$ modulo $t$.</p></li>
<li><p>I release $(e, n)$ as my public key, and retain $(d, n)$ as my private key.</p></li>
<li><p>When you communicate with me, you treat your message as a large number $m$. The ciphertext $c$ is given by $c = m^e\bmod n$, and decrypted by $m = c^d\bmod n$.</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: How can I use SSL/TLS with Perfect Forward Secrecy? (score [38202](https://stackoverflow.com/q/8933) in 2013)

#### Question
I'm new to the field of cryptography, but I want to make the web a better web by setting up the sites that I host with Perfect Forward Secrecy.  I have a list of questions regarding the setup of Perfect Forward Secrecy.  Here it goes:  

<ul>
<li>Can my choice of certificate authority hinder the use of Perfect Forward Secrecy?</li>
<li>How can I create the strongest certificate using ONLY Perfect Forward Secrecy (meaning if the browser can't use PFS, it won't load anything)?</li>
<li>Are there any extra settings that I need to know about for configuring my sites to use these certificates (especially since I only want PFS)?</li>
<li>Anything else that I should know, feel free to tell me.  I'm completely new to this idea.</li>
</ul>

#### Answer accepted (score 25)
In the beginning SSL handshake, the client sends a list of supported ciphersuites (among other things). The server then picks one of the ciphersuites, based on a ranking, and tells the client which one they will be using.   

This step is the one that determines whether or not the future connection will have perfect forward secrecy. Note that, at this point, certificates have not entered the picture at all. This is because whether or not a connection has perfect forward secrecy is determined by how the session key is derived. And how the session key is derived is determined by the ciphersuite in use. So, the ciphersuites that use ephemeral Diffie-Hellman (DHE) or the elliptic-curve variant (ECDHE) will have perfect forward secrecy while the other options will not.  

Thus, in order to configure PFS for your site, what you want to configure is your web server's ciphersuite-selecting options. More on this below.  

<blockquote>
  <p>Can my choice of certificate authority hinder the use of Perfect
  Forward Secrecy?</p>
</blockquote>

No. Perfect forward secrecy protects against the revelation of master keys. CAs do not have access to private (master) keys; a certificate from a CA is a signed <em>public key</em>. The CA is there to say "okay, client, I have verified that the public key here is indeed associated with `<host>`, it's safe." (Or, rather, the fact that it's signed by the CA says this.) Thus, your choice of CA will not impact PFS in any way.  

<blockquote>
  <p>How can I create the strongest certificate using ONLY Perfect Forward
  Secrecy (meaning if the browser can't use PFS, it won't load
  anything)?</p>
</blockquote>

As you can see, certificates are unconnected with the choice of ciphersuite (and hence PFS).  

Instead, the web server you use probably has a ciphersuite configuration in its SSL configuration. There are usually two relevant options: first, the ciphersuites that you want your server to use, and second, how the server picks the ciphersuite. Here is the relevant section in my nginx configuration:  

```cryptography
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES128-SHA:RC4:HIGH:!MD5:!aNULL:!EDH;
ssl_prefer_server_ciphers on;
```

The first line tells nginx to use those four protocols, as is apparent. The third line tells nginx to prefer its own ciphersuites <em>over</em> the client's. The point here is that we want to control exactly which ciphersuite will be selected. A client may send an ordering that suggests a non-PFS ciphersuite; hence, we trust the server.  

The second line is where the magic happens. Note that I manually specify that I want those three ECDHE-* schemes first if they are supported by the client. From there, I fall back to the usual schemes. I feel the need to emphasize that I don't disallow clients that don't support PFS; <em>some</em> encryption is better than no encryption at all. Not all clients do support PFS, so this is pretty important. I realize your question said you want only PFS ciphersuites, but I would advise against that. With the above nginx configuration, the <em>vast</em> majority of connections' selected ciphersuites will have PFS. The configuration for Apache is <a href="https://scottlinux.com/2013/06/26/how-to-enable-perfect-forward-secrecy-in-apache-on-linux/" rel="noreferrer">apparently quite similar</a>, which is not surprising given that both use OpenSSL.  

To that end, a useful tool: the <a href="https://www.ssllabs.com/ssltest/" rel="noreferrer">SSL Labs SSL Test</a>. It gives you a basic grade on your SSL configuration. See, for example, <a href="https://www.ssllabs.com/ssltest/analyze.html?d=google.com" rel="noreferrer">Google's grade</a> (click on one). It has a little green box under the grade informing you that the site supports PFS for all its tested browsers, and if you scroll down to 'Configuration', you will see a ciphersuite priority list, including which ciphersuites have PFS, as well as "simulated handshake" for the common browsers of the day.  

#### Answer 2 (score 3)
Here is a good guide for <a href="https://www.net-security.org/article.php?id=1856" rel="nofollow">deploying forward secrecy on your SSL server</a>.  Here's <a href="https://community.qualys.com/blogs/securitylabs/2013/08/05/configuring-apache-nginx-and-openssl-for-forward-secrecy" rel="nofollow">another good guide</a> that describes how to deploy forward secrecy for Apache, Nginx, and OpenSSL.  

To answer your specific questions: As far as I know, you should be able to use any CA.  The choice of forward secrecy doesn't come from the certificate; it comes from the list of ciphersuites you configure on your server.  Therefore, if you configure your server with a short list of ciphersuites (listing only ciphersuites that provide forward secrecy), you will ensure that connections will either use forward secrecy or will fail.  The guide I linked to above should give you guidance on everything you need to know.  

#### Answer 3 (score -2)
Warning: it is widely believed that the ECC curves used for PFS have got NSA back doors in them.  If you're up-to-no-good, setting up to use curves and algorithms that were designed and promoted by the NSA themselves might not be the best solution.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Can I remove newlines in a public key? (score [38120](https://stackoverflow.com/q/19043) in 2016)

#### Question
Can I remove new lines from the RSA public key file to get a one line string? So the question is if the key looks like this  

```cryptography
AAA
BBB
CCC
```

or  

```cryptography
AAA\n\rBBB\n\rCCC\n\r
```

is this the same as  

```cryptography
AAABBBCCC
```

#### Answer accepted (score 26)
I'm assuming you mean a base 64 encoded key file, since removing the newlines from a binary file would obviously break things.  

The RSA standards (e.g. <a href="https://www.ietf.org/rfc/rfc2459">RFC 2459</a>) only define a binary representation for keys. In practice, like OpenPGP keys (<a href="http://tools.ietf.org/html/rfc4880">RFC 4880</a>), they are often encoded in base 64 using the otherwise obsolete PEM standards (<a href="http://tools.ietf.org/html/rfc1421">RFC 1421</a>).  

The PEM printable encoding section says:  

<blockquote>
  <p>To represent the encapsulated text of a PEM message, the encoding
     function's output is delimited into text lines (using local
     conventions), with each line except the last containing exactly 64
     printable characters and the final line containing 64 or fewer
     printable characters.</p>
</blockquote>

The OpenPGP radix 64 section says:  

<blockquote>
  The encoded output stream must be represented in lines of no more than 76 characters each.  
</blockquote>

For SSH, on the other hand, <a href="http://tools.ietf.org/html/rfc4716#section-3">RFC 4716 Section 3</a>:  

<blockquote>
  <p>A key file is a text file, containing a sequence of lines.  Each line
     in the file MUST NOT be longer than 72 8-bit bytes excluding line
     termination characters.</p>
</blockquote>

<hr>

Do implementations in practice accept longer lines? I would expect many to do so. However, while no information is lost, it's technically nonconforming to use such encodings.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Difference between "Signature Algorithm" and "Signature Hash Algorithm" in X.509 (score [38010](https://stackoverflow.com/q/2048) in 2016)

#### Question
What's the difference between the "Signature Algorithm" and the "Signature Hash Algorithm" found in an X.509 certificate? Why does it need a "Signature Hash Algorithm"?  

<img src="https://i.stack.imgur.com/CBzuj.jpg" alt="enter image description here">  

<strong>Edit:</strong>  

I'm creating the X.509 cert with PHP 5.2. When I change the 'digest_alg' to 'md5', both properties of the Microsoft Cert Tool changes to md5. So, as mentioned in one answer below, it seems to be an issue/invention of the Microsoft Cert Tool.  

Change to md5:  

```cryptography
           $configs = array(
                            'config'             => 'test.cnf',
                            'digest_alg'         => 'md5',
                            'x509_extensions'    => 'v3_ca',
                            'req_extensions'     => 'v3_req',
                            'private_key_bits'   => 2048,
                            'private_key_type'   => OPENSSL_KEYTYPE_RSA,
                            'encrypt_key'        =>
                        );
```

<strong>Result:</strong>  

<img src="https://i.stack.imgur.com/4bm19.png" alt="enter image description here">  

#### Answer accepted (score 12)
This has more to do with how Microsoft decided to implemented their certificate inspection GUI, than about the actual fields of the certificate. Most signature algorithm identifiers present in contemporary certificates specify both the public key algorithm (RSA in this case) and the digest algorithm (SHA-1 in this case). The identifier "sha1RSA" is most likely inaccurate in so far that Microsoft has decided to use it for an identifier that is known as `sha1WithRSAEncryption OBJECT IDENTIFIER ::= {  iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1) 5 }` in <a href="http://datatracker.ietf.org/wg/pkix/charter/">the standard</a>.  

The only semi-common standard signature algorithm I am aware of that actually separates the public key algorithm identifier from the digest algorithm identifier in the signature algorithm identifier of certificates, is <a href="http://datatracker.ietf.org/doc/rfc4055/?include_text=1">PKCS#1 v2 RSASSA-PSS</a>.  

<strong>Edit:</strong>  

Consequently, Microsoft follows conventions and the X.509 specification by letting "signature algorithm" mean a combination of a signature public key algorithm and signature hash algorithm, but, firstly, the identifiers they use for these combinations are non standard, and, secondly, adding a signature hash algorithm field is in most cases superfluous and doesn't usually reflect the actual X.509 format.  

#### Answer 2 (score 5)
I believe the SignatureAlgorithm is the algorithm used to sign the content using the private key, while the SignatureHashAlgorithm is used to hash the content before signing (so as to not sign as much data, which is a relatively slow process). In this case, it's easy enough to figure out that the SignatureHashAlgorithm is SHA1 because it's in the name of the SignatureAlgorithm, but I imagine there are cases where that isn't true.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: How are the AES S-Boxes calculated? (score [37317](https://stackoverflow.com/q/10996) in 2016)

#### Question
I'm trying to understand how the AES S-Boxes are calculated. I understand how the multiplicative inverse is calculated over $GF(2^8)$, but I'm confused by the description of the affine transformation. I haven't been able to Google a good explanation of how the S-Box values are calculated. Can someone explain how this works, starting after the calculation of the multiplicative inverse?  

#### Answer accepted (score 15)
The affine transformation works similar to MixColumns, but operates on an array of 8 bits instead of 4 bytes. Confusion in various descriptions of the affine transform in AES comes from where the LSB of the input byte is located. Some show it at the top of the column, others show it at the bottom. I will be using the version shown in the Rijndael paper, with the LSB at the top of the column.  

The matrix used in AES is a rotational matrix based on the value `0x1F`, which is `00011111` in binary. The multiplication is performed in the field GF(2), as is the addition of the final vector `0x63`. Addition in GF(2) is the same as xor.  

The bit indexes for the matrix are `76543210`, with `0` being the least significant bit and `7` being the most significant. Each column is the previous column rotated to the left by a single bit, as shown here:  

```cryptography
0  7  6  5  4  3  2  1
1  0  7  6  5  4  3  2
2  1  0  7  6  5  4  3
3  2  1  0  7  6  5  4
4  3  2  1  0  7  6  5
5  4  3  2  1  0  7  6
6  5  4  3  2  1  0  7
7  6  5  4  3  2  1  0
```

For the AES 0x1F affine matrix, the bits are arranged in the following way:  

```cryptography
1  0  0  0  1  1  1  1
1  1  0  0  0  1  1  1
1  1  1  0  0  0  1  1
1  1  1  1  0  0  0  1
1  1  1  1  1  0  0  0
0  1  1  1  1  1  0  0
0  0  1  1  1  1  1  0
0  0  0  1  1  1  1  1
```

For an input of `0x53` in AES, we first find its inverse, which is `0xCA`, represented in binary as `11001010`  

The affine transformation is as follows. The input bits are multiplied against the bits of a given row, with the first bit the LSB of the input. Input bit 0 is only multiplied by row bit 0, and so on. Only when both values are one (logical AND) is the result one. Finally, all bits are XORd against eachother within that row to generate the transformed bit for that row.  

```cryptography
Input = 0  1  0  1  0  0  1  1 (LSB First)
Row 0 = 1  0  0  0  1  1  1  1
Bit 0 = 0  0  0  0  0  0  1  1 = 0

Row 1 = 1  1  0  0  0  1  1  1
Bit 1 = 0  1  0  0  0  0  1  1 = 1

Row 2 = 1  1  1  0  0  0  1  1
Bit 2 = 0  1  0  0  0  0  1  1 = 1

Row 3 = 1  1  1  1  0  0  0  1
Bit 3 = 0  1  0  1  0  0  0  1 = 1

Row 4 = 1  1  1  1  1  0  0  0
Bit 4 = 0  1  0  1  0  0  0  0 = 0

Row 5 = 0  1  1  1  1  1  0  0
Bit 5 = 0  1  0  1  0  0  0  0 = 0

Row 6 = 0  0  1  1  1  1  1  0
Bit 6 = 0  0  0  1  0  0  1  0 = 0

Row 7 = 0  0  0  1  1  1  1  1
Bit 7 = 0  0  0  1  0  0  1  1 = 1
```

The final result LSB first is `01110001` or MSB first is `10001110 = 0x8E`. This value is then added (XOR) to the final vector `0x63`, giving an output of `0xED`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Why is writing your own encryption discouraged? (score [36969](https://stackoverflow.com/q/43272) in 2017)

#### Question
Say I want to write an encryption algorithm to communicate between me and my friend for this private use. How is that bad?  

E.g. I can take the word `Hello` and encrypt it with a simple algorithm – for example –  take each letter and multiply its value by 2 and add 13 so that it becomes completely unreadable.  

Is writing a private encryption that stays between two people discouraged or not? What's wrong with it?  

#### Answer 2 (score 219)
Your question, <a href="http://chat.stackexchange.com/rooms/52499/discussion-on-question-by-pierte-why-is-writing-your-own-encryption-discouraged#">MikeAzo's comment</a>, and <a href="http://chat.stackexchange.com/transcript/message/35015452#35015452">your reply</a> practically could not be a better example of <a href="https://www.schneier.com/blog/archives/2011/04/schneiers_law.html">Schneier's Law</a> in practice. Schneier stated:  

<blockquote>
  Anyone, from the most clueless amateur to the best cryptographer, can create an algorithm that he himself can't break.  
</blockquote>

To answer your reply  

<blockquote>
  How can you break it if I send you this "QTCPIGXKUXTGG" ciphertext encrypted by a merely a simple algorithm which you have no idea about how it was encrypted?  
</blockquote>

Because even though we might not know <em>exactly</em> what your secret algorithm is, the first thing an attacker is going to reach for are common tools to attack <a href="https://en.wikipedia.org/wiki/Substitution_cipher">substitution ciphers</a> or <a href="https://en.wikipedia.org/wiki/Polyalphabetic_cipher">polyalphabetic ciphers</a>. Given even a few sentences of ciphertext is likely enough to fully recover every plaintext.  

The fact that <em>you</em> don't know how to break it is irrelevant. It's trivial to create a cipher that you yourself can't break, but it's another thing entirely to create a cipher that others can't break. And the odds that you are capable of doing it when you're not aware of even the most basic attacks against ciphers hundreds of years old — not to mention modern concepts like <a href="https://en.wikipedia.org/wiki/Attack_model">indistinguishability under different attack models</a> — puts you at an insurmountable disadvantage compared to ciphers designed by researchers with decades of experience in the field who are building off of modern notions of security and the discarded remains of thousands of failed ciphers that came before.  

As an example, even if your cipher is somehow secure against a ciphertext-only attack (it's not), is it secure if I can trick you into encrypting a message for me? What if I can trick you into decrypting a message for me? What if I know part of or all of one of the messages you send? What if you encrypt multiple messages with the same key?  

I'll leave you with another Schneier classic, <a href="https://www.schneier.com/crypto-gram/archives/1998/1015.html#cipherdesign">Memo to the Amateur Cipher Designer</a>:  

<blockquote>
  A cryptographer friend tells the story of an amateur who kept bothering him with the cipher he invented. The cryptographer would break the cipher, the amateur would make a change to "fix" it, and the cryptographer would break it again. This exchange went on a few times until the cryptographer became fed up. When the amateur visited him to hear what the cryptographer thought, the cryptographer put three envelopes face down on the table. "In each of these envelopes is an attack against your cipher. Take one and read it. Don't come back until you've discovered the other two attacks." The amateur was never heard from again.  
</blockquote>

So here's your first envelope. Given a paragraph or two of ciphertext, your cipher will fail to language-based frequency analysis.  

Let me know when you've figured out the other two attacks.  

Edit: The comment about indistinguishability under different attack models is one reason why most "decipher this message crypto challenges" are <a href="http://www.cryptofails.com/post/70546720222/telegrams-cryptanalysis-contest">completely bunk</a>. They often simply give an attacker some ciphertext, ask them to decipher it, and declare victory when nobody produces the plaintext after some amount of time. Unfortunately that's not how crypto works in the real world; attackers have many more tricks up their sleeve in practice. They can trick computers into encrypting data of their choosing, they can trick computers into decrypting data of their choosing, and they can usually even do these things thousands, millions, or billions of times. <a href="https://moxie.org/blog/telegram-crypto-challenge/">Moxie's post</a> shows how even the most terrible, horribly-designed, and obviously insecure ciphers can be effectively impervious when you restrict an attacker to a single <a href="https://en.wikipedia.org/wiki/Ciphertext-only_attack">ciphertext-only attack</a>, which aren't representative of attackers' capabilities against ciphers as they're actually deployed in practice.  

#### Answer 3 (score 110)
I actually think this is a really good question. The answer is because cryptography is a skill, and like any skill, it takes time to develop. Additionally, you will be pitting your (in)experience in the skill against the skills of those who would seek to break your algorithm.   

This is the real reason why: It's not that you just shouldn't do it, period. It's that if you do write your own algorithms, you need to realize that it will take a long time before you create anything that is actually capable of securing your information against a dedicated adversary in the real world.   

Cryptography is like sword fighting. You would not sharpen a bamboo stick, swing it around a few times, and then go challenge a pack of thugs to a fight. The reason why should be really obvious. Especially when the pack of thugs in question could be a 3-Letter entity such as <strong>DJB</strong> or other <strong>N</strong>ation <strong>S</strong>tate level <strong>A</strong>dversaries.  

I say this as someone who is written too many crypto algorithms to count on both hands - I have <em>written</em> plenty of algorithms, but <em>proposed and used</em> none of them. Until you have something that 1. Is faster then AES or Salsa/ChaCha 2. Provably more secure then AES or Salsa/ChaCha, why should you propose or use the algorithm in question?  

Lastly, you will likely enjoy studying <a href="https://en.wikipedia.org/wiki/Information_theory" rel="noreferrer">information theory</a>. You will come to understand that keeping the algorithm secret is not efficient because the algorithm itself has a <a href="https://en.wikipedia.org/wiki/Kolmogorov_complexity" rel="noreferrer">minimum number of bits required to represent it</a>. These bits (the algorithm) simply <strong>become</strong> the key. It is well established that it is simply better to concentrate your secrecy into a proper small key with a public algorithm. If your key becomes compromised, you simply change the key. If the algorithm is the key, well, you'd need a whole new algorithm.  

<h5>tl;dr</h2>

I disagree that you should not <strong>write</strong> your own algorithms, it's that you need to have a good explicit reason for <strong>using/proposing</strong> your own algorithms. I personally would encourage you to write your own, as it will teach you to understand what does and what does not work and why. Doing so will help you to understand various sorts of mathematics and information theory (basically all of the math that I know I learned because/for cryptography).   

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: Differences between the terms "pre-master secret", "master secret", "private key", and "shared secret"? (score [36805](https://stackoverflow.com/q/27131) in 2017)

#### Question
Both <a href="https://crypto.stackexchange.com">crypto.SE</a> and <a href="https://security.stackexchange.com">security.SE</a> have excellent Q&amp;As about how TLS generates session keys (I have linked some at the bottom).  

In reading these threads I'm having troubles with terminology since the following terms seem to be used with overlapping contexts, though they are clearly different concepts. Reading definitions is only partially helpful since they don't show the differences between their usages.  

<ul>
<li>pre-master secret</li>
<li>master secret</li>
<li>private key</li>
<li>shared secret / session key</li>
</ul>

As I understand it, the pre-master secret is related to private keys, but is algorithm independent, and the master secret is (often?) used as the session key. But I'm sure there's more nuance to the definitions.  

<hr>

Related Questions:  

<ul>
<li><a href="https://security.stackexchange.com/q/20803/61443">How does SSL/TLS work?</a> [security.SE]</li>
<li><a href="https://security.stackexchange.com/questions/54399/whats-the-point-of-the-pre-master-key">What's the point of the pre-master key?</a> [security.SE]</li>
<li><a href="https://crypto.stackexchange.com/questions/24780/what-is-the-purpose-of-pre-master-secret-in-ssl-tls">What is the purpose of pre master secret in SSL/TLS?</a> [crypto.SE]</li>
<li><a href="https://crypto.stackexchange.com/questions/11328/whats-the-difference-between-the-long-term-key-and-the-session-keys">What's the difference between the long term key and the session keys?</a> [crypto.SE]</li>
</ul>

#### Answer accepted (score 23)
<p><a href="https://i.stack.imgur.com/trAgs.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/trAgs.jpg" alt="Simplified SSLv3/TLS"></a>
<em>Simplified SSLv3/TLS from <a href="http://rads.stackoverflow.com/amzn/click/0130460192" rel="noreferrer">this book</a></em> <sub><sup>Note, $R_{(Alice|Bob)}$ is a random nonce chosen by Alice or Bob respectively, and $\{S\}_{Bob}$ is encryption with Bob's public key.</sup></sub></p>

<h5>pre-master secret</h1>

As stated in one of the answer you <a href="https://crypto.stackexchange.com/questions/24780/what-is-the-purpose-of-pre-master-secret-in-ssl-tls">link to</a>, "The point of a premaster secret is to provide greater consistency between TLS cipher suites."  

In the figure above, the premaster secret is $S$ (in message 3). In this case, it is randomly generated. It could come from a diffie-hellman exchange, or some other method, depending on the agreed upon cipher suite.  

It isn't really "related to the private keys" but how it is generated/agreed upon depends on the cipher suite chosen in the second message of the figure.  

<h5>master secret</h1>

In the figure above, the master secret is $K$. Shown on the sides, it is a function of the pre-master secret and the two random values sent in the first two messages.  

<h5>private key</h1>

I'm not really sure where this comes from. It could refer to the Bob's private key for the certificate sent in message 2. It could also refer to private keys used in a diffie-hellman key exchange. If doing client authentication, it could refer to the client's private key associated with their certificate.  

<h5>shared secret / session key</h1>

This is what is referred to in the last step of the figure. The session key is referred to as "keys derived from K". Many keys are actually derived from K. This could be the encryption key, integrity protection keys (for say HMAC), IVs for the ciphers, etc. And, it is usually a different set for each direction.  

#### Answer 2 (score 5)
When a TLS/SSL session starts(after the hellos and cipher decisions) the server gives the client it's cert. The  key in the cert could perform different actions depending on the key-agreement algorithm decided on by the client and server.  

Let's say they agree on RSA key agreement. This means the cert contains the server public RSA key and the server has a private RSA key used for decryption, hence private key. The client generates a random sequence called the pre-master secret. The client uses the public RSA key on the cert to encrypt the PMS. The server decrypts the message and gets the PMS. The server and client then perform some random mixing on the PMS, could be a KDF. That Master secret is used to derive keys for symmetric encryption and MAC.  

Another option is the server and client could perform Diffie-Hellman key exchange in which the client must also generate a public-private DH pair used to exchange AND generate(due to the way DH works the client doesn't choose the PMS) the PMS. The MS is derived as above. A more modern approach is to use session keys in which the server cert contains it's public key for verifying a signature algorithm(RSA-SHA, ECDSA) that it used to sign either an RSA or DHE (the E means one-time use keys or session keys) public key for key-agreement. Thus the server is not reusing it's key-agreement public key. This provides perfect forward secrecy . In which finding the PriK (Long-lived key) of the signature algorithm the server uses to sign its keys does not make all the session keys vulnerable. In addition finding a session key should allow you to obtain information that would allow you to decrypt traffic that used another session key(The PMS could also be considered a "session key") You could look up a PKI to understand more about how a cert verification works which I did not explain. This is where the client makes sure the cert is valid.  

Asymmetric crypto is used for key-agreement (keys are smaller than messages) due to the high processing power required and symmetric crypto is used for encryption and authentication of the resulting cipher text. Also the term key-agreement is different than key-exchange (more general). Key-agreement means that there is no trusted-third party involved in the actual exchange of keys, which is true in the case of SSL/TLS  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: Why hash the message before signing it with RSA? (score [36034](https://stackoverflow.com/q/12768) in 2015)

#### Question
The <a href="http://commons.wikimedia.org/wiki/File:Digital_Signature_diagram.svg" rel="noreferrer">diagram</a> below illustrates the process of <a href="http://en.wikipedia.org/wiki/Digital_signature" rel="noreferrer">digitally signing</a> a message with RSA:  

<a href="http://commons.wikimedia.org/wiki/File:Digital_Signature_diagram.svg" rel="noreferrer"><img src="https://i.stack.imgur.com/eCCob.png" alt="Image"></a>  

As diagram shows, the message is first hashed, and the signature is then computed on the hash, rather than on the full message.  

Why hash the data before signing it? Why not sign the whole message? Of course, it'll save time if you sign just the hash value, but I've heard there are also security issues with directly signing the full message. If so, what are they?  

#### Answer accepted (score 28)
In addition to the performance problems <a href="https://crypto.stackexchange.com/a/12769/62266">poncho already mentioned</a> when using RSA signatures without hashing I just want to add on the <a href="https://crypto.stackexchange.com/a/12769/62266">security warning of poncho</a>:  

<strong>Reordering</strong>  

If you have a message <span class="math-container">$m&gt;N$</span> with <span class="math-container">$N$</span> being the RSA modulus, then you have to perform at least 2 RSA signatures as <span class="math-container">$m$</span> does not longer fit into <span class="math-container">$Z_N$</span>. Let us assume that it requires <span class="math-container">$k$</span> such signatures and write the message <span class="math-container">$m=(m_1,\ldots,m_k)$</span> and the overall signature will be <span class="math-container">$\sigma=(\sigma_1,\ldots,\sigma_k)$</span>, i.e., <span class="math-container">$k$</span> RSA signatures. Now without any additional measures anyone getting to hold <span class="math-container">$(m,\sigma)$</span> can manipulate the message and adopt the signature by 1) swapping any pair of submessage <span class="math-container">$m_i$</span>, <span class="math-container">$1\leq i\leq k$</span> and corresponding subsignature <span class="math-container">$\sigma_i$</span> or 2) dropping a submessage and corresponding subsignature.   

As an example for swapping lets say we have <span class="math-container">$m=(m_1,m_2,m_3)$</span> and thus <span class="math-container">$\sigma=(\sigma_1,\sigma_2,\sigma_3)$</span>, i.e., 3 indepenendet RSA signatures for a message consisting of 3 blocks, then an adversary who gets <span class="math-container">$(m,\sigma)$</span> can simply swap, for instance to <span class="math-container">$m'=(m_2,m_3,m_1)$</span> and <span class="math-container">$\sigma'=(\sigma_2,\sigma_3,\sigma_1)$</span>, which is a forgery, as it clearly is a valid signature.  

<strong>Existential forgery</strong>  

If you do not use a redundancy scheme for messages prior to signing within RSA (textbook RSA signatures), they are susceptible to existential forgeries. Let <span class="math-container">$(e,N)$</span> be the public signature verification key of RSA, then one can randomly choose a signature <span class="math-container">$\sigma \in Z_N$</span> and <strong>compute</strong> the corresponding message as <span class="math-container">$m\equiv \sigma^e \pmod N$</span>.  

Note that given an RSA signature <span class="math-container">$\sigma$</span>, a message <span class="math-container">$m$</span> and a public verification key <span class="math-container">$(e,N)$</span>, the signature verification for the textbook RSA signature will be to check: <span class="math-container">$m\stackrel{?}{\equiv} \sigma^e \pmod N$</span>.  

Clearly, this check will hold for the forgery by construction. Observe, however, that the adversary can not control <strong>what</strong> the message <span class="math-container">$m$</span> will exactly be. In particular, it will be a random element of <span class="math-container">$Z_N$</span>. However, this may be sufficient in some applications, e.g., when only signing random numbers when issuing some tokens. Applying a redundancy scheme to messages, i.e., hashing and padding prior to signing, renders so computed forged signatures useless in practice.   

<strong>Final Remarks</strong>  

Consequently, textbook RSA signatures must not be used and instead standardized <a href="http://en.wikipedia.org/wiki/PKCS_1#Schemes" rel="nofollow noreferrer">padding methods for RSA</a> involving hashing and padding the message must be used. Then, RSA signatures provide strong security guarantees (UF-CMA security).  

#### Answer 2 (score 12)
Well, one reason to hash the data before signing it is because RSA can handle only so much data; we might want to sign messages longer than that.  

For example, suppose we are using a 2k RSA key; that means that the RSA operation can handle messages up to 2047 bits; or 255 bytes.  We often want to sign messages longer than 255 bytes.  By hashing the message to something small, and then signing the hash, we get around the problem of message length.  Now, we could also solve this problem by breaking up the message to smaller chunks, and signing each chunk; however this adds a great deal of complexity and expense for no particularly good reason.  

I would like to add a warning not directly related to your question: that image you showed is simplified, and is missing an important piece of the RSA signature process.  After you perform the hash, it is essential that you pad the hash out before you give it to what they have labeled the 'encrypt hash with the signer's private key' step.  Conversely, after the signature verifier has used the signer's public key, they need to verify that the padding in the 'decrypted' message looks valid (in addition to the hash being the expected value).  There are known weaknesses that result by not performing the padding correctly.  

#### Answer 3 (score 0)
I am answering this in the context of Digital Signatures. Digital Signatures offer - Authenticity (that the message was sent by the person whom the message claims to be sent by) and Data Integrity (that the message was not altered in transit).  

Suppose, you encrypt the entire message using private key and send it out. Now, any body will be able to decrypt using the public key but won't be able to encrypt again (since private key is held by sender only). Instead say, the encrypted message itself is altered in transit. A receiver will proceed to decrypt using public key and will probably get an entirely different message. Now the intended audience will know who sent this message in the first place but cannot tell if the message was altered. So Data Integrity is clearly lost.  

Instead you generate a hash (using a publicly known algorithm) and then encrypt this hash using private key and send the data + encrypted hash to intended audience. Now, in transit, someone may modify the encrypted hash or the message. In either case, validation on receiver side (decrypt hash using public key, generate hash from actual data (that was sent in clear text) and comparing decrypted hash with generated hash) will fail if the message was edited. Thus we retain data integrity and authenticity.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Impacts of not using RSA exponent of 65537 (score [35876](https://stackoverflow.com/q/3110) in 2012)

#### Question
This <a href="http://www.ietf.org/rfc/rfc4871.txt">RFC says the RSA Exponent should be 65537</a>.  Why is that number recommended and what are the theoretical and practical impacts &amp; risks of making that number higher or lower?   

What are the impacts of making that value a non-Fermat number, or simply non prime?  

#### Answer accepted (score 52)
Using <span class="math-container">$e\ne65537$</span> would reduce compatibility with existing hardware or software, and break conformance to some standards or prescriptions of security authorities. Any higher <span class="math-container">$e$</span> would make the public RSA operation (used for encryption, or signature verification) slower. Some lower <span class="math-container">$e$</span>, in particular <span class="math-container">$e=3$</span>, would make that operation appreciably faster (up to 8.5 times). If using a proper padding scheme, the choice of <span class="math-container">$e$</span> is not known to make a security difference; but for many less than perfect padding schemes that have been (or are still) used, high values of <span class="math-container">$e$</span> (compared to the number of bits in the public modulus <span class="math-container">$n$</span>) are generally safer.  

<hr>

<span class="math-container">$e=65537$</span> is a common compromise between being high, and increasing the cost of raising to the <span class="math-container">$e$</span>-th power: any higher odd <span class="math-container">$e$</span> cost at least one more multiplication (or squaring), which is true for odd exponents of the form <span class="math-container">$2^k+1$</span>. Also, <span class="math-container">$e=65537$</span> is prime, which slightly simplify generating a prime <span class="math-container">$p$</span> suitable as RSA modulus, implying <span class="math-container">$\gcd(p-1,e)=1$</span>, which reduce to <span class="math-container">$p\not\equiv 1\pmod e$</span> for prime <span class="math-container">$e$</span>. Only the <a href="https://en.wikipedia.org/wiki/Fermat_number" rel="noreferrer">Fermat primes</a> <span class="math-container">$3,5,17,257,65537$</span> have both properties, and all are common choices of <span class="math-container">$e$</span>. It is conjectured that there are no other Fermat prime; and if there was any, it would we unusably huge.  

Using <span class="math-container">$e=65537$</span> (or higher) in RSA is an <strong><em>extra</em></strong> precaution against a variety of attacks that are possible when bad message padding is used; these attacks tend to be more likely or devastating with much smaller <span class="math-container">$e$</span>. Using <span class="math-container">$e=3$</span> would otherwise be attractive, since raising to the power <span class="math-container">$e=3$</span> cost 1 squaring and 1 multiplication, to be compared to 16 squaring and 1 multiplication when raising to the power <span class="math-container">$e=65537=2^{16}+1$</span>.  

For example, RSA with <span class="math-container">$e=65537$</span> has a security advantage over <span class="math-container">$e=3$</span> when:  

<ol>
<li>Sending a message naively encrypted as <span class="math-container">$\mathtt{ciphertext}=\mathtt{plaintext}^e\bmod n$</span>; the greater <span class="math-container">$e$</span> makes it more likely that <span class="math-container">$\log_2(\mathtt{plaintext})\gg \log_2(n)/e$</span> (which is necessary for security).</li>
<li>Sending the same message encrypted to <span class="math-container">$k$</span> recipients using the same padding (including any deterministic padding independent of <span class="math-container">$n$</span>); the greater <span class="math-container">$e$</span> makes it less likely that <span class="math-container">$k\ge e$</span>  (which allows a break).</li>
<li>Signing messages chosen by the adversary with a bad signature scheme. For example, with the scheme of the (withdrawn) ISO/IEC 9796 standard (described in <a href="https://cacr.uwaterloo.ca/hac/about/chap11.pdf#page=19" rel="noreferrer">HAC section 11.3.5</a>), the adversary could obtain a forged signature from only 1 legitimate signature if <span class="math-container">$e=3$</span>, but needs 3 legitimate signatures for <span class="math-container">$e=65537$</span>; trust <a href="https://www.iacr.org/archive/eurocrypt2000/1807/18070070-new.pdf" rel="noreferrer">me</a> on that one. The security advantage of <span class="math-container">$e=65537$</span> is wider for <a href="https://eprint.iacr.org/2009/203.pdf" rel="noreferrer">attacks</a> against scheme 1 of the (current) <a href="https://webstore.iec.ch/preview/info_isoiec9796-2%7Bed3.0%7Den.pdf" rel="noreferrer">ISO/IEC 9796-2</a>.</li>
</ol>

For more explanations and examples of the risk of the <em>combination</em> of questionable message padding and low <span class="math-container">$e$</span>, see section 4 in Dan Boneh's <a href="https://crypto.stanford.edu/~dabo/pubs/papers/RSA-survey.pdf" rel="noreferrer"><em>Twenty Years of Attacks on the RSA Cryptosystem</em></a>.  

<hr>

There is no <em>known technical imperative</em> <strong>not</strong> to use <span class="math-container">$e=3$</span> when using a sound message padding scheme, such as RSAES-OAEP or RSASSA-PSS from <a href="https://www.emc.com/collateral/white-papers/h11300-pkcs-1v2-2-rsa-cryptography-standard-wp.pdf" rel="noreferrer">PKCS#1</a>, or scheme 2 or 3 from ISO/IEC&nbsp;9796-2. However, it still makes sense to use <span class="math-container">$e=65537$</span>:  

<ul>
<li>The only known drawbacks are the performance loss (by a factor like 8), and the risk of leaving a bug in the key generator when a prime <span class="math-container">$p\equiv 1\pmod{65537}$</span> is hit; and when performance matters, there is an <a href="https://cr.yp.to/sigs/rwsota-20080131.pdf" rel="noreferrer">even better choice</a> than <span class="math-container">$e=3$</span>, with provable security (but more complex and uncommon).</li>
<li>Some <a href="https://eprint.iacr.org/2009/203.pdf" rel="noreferrer">attacks</a> on less than perfect RSA schemes that are (or have been) in wide use are significantly harder than with <span class="math-container">$e=3$</span> (as discussed above).</li>
<li><span class="math-container">$e=65537$</span> has become an industry standard (I have yet to find any RSA hardware of software that does not allow it), and is prescribed by some certification authorities.</li>
</ul>

#### Answer 2 (score 1)
65537 is commonly used as a public exponent in the RSA cryptosystem. This value is seen as a wise compromise, since it is famously known to be prime, large enough to avoid the attacks to which small exponents make RSA vulnerable, and can be computed extremely quickly on binary computers, which often support shift and increment instructions. Exponents in any base can be represented as shifts to the left in a base positional notation system, and so in binary the result is doubling - 65537 is the result of incrementing shifting 1 left by 16 places, and 16 is itself obtainable without loading a value into the register (which can be expensive when register contents approaches 64 bit), but zero and one can be derived more 'cheaply'. -wikipedia ('twas lazy)  

-thus, lower is vulnerable to quick factoring, higher is not insecure, but computationally more expensive.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: What is the length of an RSA signature? (score [35400](https://stackoverflow.com/q/3505) in )

#### Question
Is it the same as the bits of the key (So a 2048 bit system will yield a 2048 bit signature)? At <em>most</em> as the key? Or something else entirely?  

#### Answer accepted (score 9)
If $d,N$ is the private key, signing a message $m$ is computed as $m^d\bmod N$. The $\bmod N$ makes it so that the signed message is between $0$ and $N$. So, it is no larger than $N$.  

In most applications, however, there is usually some encoding or protocol fields that will make it larger.  

#### Answer 2 (score 17)
<a href="http://www.rsa.com/rsalabs/node.asp?id=2125">PKCS#1</a>, "the" RSA standard, describes how a signature should be encoded, and it is a sequence of bytes with big-endian unsigned encoding, always of the size of the modulus. This means that for a 2048-bit modulus, all signatures have length exactly 256 bytes, never more, never less.  

PKCS#1 is the most widely used standard, but there are other standards in some areas which may decide otherwise. Mathematically, a RSA signature is an integer between $1$ and $N-1$, where $N$ is the modulus. In some protocols, there can be some wrapping around the signature, e.g. to indicate which algorithm was used, or to embed certificates. For instance, in <a href="http://tools.ietf.org/html/rfc5652">CMS</a>, a "signature" contains the RSA value itself, but also quite a lot of additional data, for a virtually unbounded total size (I have seen signatures of a size of several <em>megabytes</em>, due to inclusion of huge CRL).  

#### Answer 3 (score 7)
The RSA signature size is dependent on the key size, the RSA signature size is equal to the length of the modulus in bytes. This means that for a "n bit key", the resulting signature will be exactly n bits long. Although the computed signature value is not necessarily n bits, the result will be padded to match exactly n bits.  

Now here is how this works: The RSA algorithm is based on modular exponentiation. For such a calculation the final result is the remainder of the "normal" result divided by the modulus. Modular arithmetic plays a large role in Number Theory. There the definition for congruence is (I'll use 'congruent' since I don't know how to get those three-line equal signs)  

$m \equiv n \mod k$ if $k$ divides $m - n$  

Simple example: Let $n = 2$ and $k = 7$, then  

<p>$2 \equiv 2 \mod 7$ ($7$ divides $2 - 2$)<br>
$9 \equiv 2 \mod 7$ ($7$ divides $9 - 2$)<br>
$16 \equiv 2 \mod 7$ ($7$ divides $16 - 2$)<br>
...</p>

$7$ actually does divide $0$, the definition for division is  

<blockquote>
  An integer $a$ divides an integer $b$ if there is an integer $n$ with the property that $b = n·a$.  
</blockquote>

For $a = 7$ and $b = 0$ choose $n = 0$. This implies that every integer divides $0$, but it also implies that congruence can be expanded to negative numbers (won't go into details here, it's not important for RSA).  

So the gist is that the congruence principle expands our naive understanding of remainders, the modulus is the "number after mod", in our example it would be $7$. As there are an infinite amount of numbers that are congruent given a modulus, we speak of this as the congruence classes and usually pick one representative (the smallest congruent integer $\geq 0$) for our calculations, just as we intuitively do when talking about the "remainder" of a calculation.  

In RSA, signing a message $m$ means exponentiation with the "private exponent" $d$, the result $r$ is the smallest integer with $0 \leq r &lt; n$ so that  

$$ m^d \equiv r \bmod n.$$  

This implies two things:  

<ol>
<li>The length of $r$ (in bits) is bounded by the length of $n$ (in bits).</li>
<li>The length of $m$ (in bits) must $\leq$ length($n$) (in bits, too).</li>
</ol>

To make the signature exactly $n$ bits long, some form of padding is applied. Cf. PKCS#1 for valid options.  

The second fact implies that messages larger than n would either have to be signed by breaking $m$ in several chunks $&lt; n$, but this is not done in practice since it would be way too slow (modular exponentiation is computationally expensive), so we need another way to "compress" our messages to be smaller than $n$. For this purpose we use cryptographically secure hash functions such as SHA-1 that you mentioned. Applying SHA-1 to an arbitrary-length message m will produce a "hash" that is 20 bytes long, smaller than the typical size of a RSA modulus, common sizes are 1024 bits or 2048 bits, i.e. 128 or 256 bytes, so the signature calculation can be applied for any arbitrary message.  

The cryptographic properties of such a hash function ensures (in theory - signature forgery is a huge topic in the research community) that it is not possible to forge a signature other than by brute force.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Is AES-256 weaker than 192 and 128 bit versions? (score [34969](https://stackoverflow.com/q/5118) in 2014)

#### Question
From a paper via Schneier on Security's <a href="http://www.schneier.com/blog/archives/2009/07/another_new_aes.html">Another AES Attack</a> (emphasis mine):  

<blockquote>
  In the case of AES-128, there is no known attack which is faster than the 2<sup>128</sup> complexity of exhaustive search. However, <strong>AES-192 and AES-256 were recently shown to be breakable by attacks which require 2<sup>176</sup> and 2<sup>119</sup> time, respectively</strong>. While these complexities are much faster than exhaustive search, they are completely non-practical, and do not seem to pose any real threat to the security of AES-based systems.  
  
  In this paper we describe several attacks which can break with practical complexity variants of AES-256 whose number of rounds are comparable to that of AES-128.   
</blockquote>

Is the implication here that AES-192 is stronger than AES-256? If so, in simple terms, how is that possible?  

<blockquote>
  The attack exploits the fact that the <strong>key schedule for 256-bit version is pretty lousy -- something we pointed out in our 2000 paper -- but doesn't extend to AES with a 128-bit key.</strong>  
</blockquote>

Again, in simple terms, what does that mean?     

In practice, does this mean I should drop AES-256 in favor of its 128-bit counterpart, like Schneier recommends in the comments?  

<blockquote>
  That being said, the key schedule for AES-256 is very poor. <strong>I would recommend that people use AES-128 and not AES-256.</strong>  
</blockquote>

#### Answer accepted (score 76)
<a href="http://en.wikipedia.org/wiki/Advanced_Encryption_Standard">AES</a> is an algorithm which is split into several internal <em>rounds</em>, and each round needs a specific 128-bit subkey (and an extra subkey is needed at the end). In an ideal world, the 11/13/15 subkeys would be generated from a strong, cryptographically secure PRNG, itself seeded with "the" key.  

However, this world is not ideal, and the subkeys are generated through a process called the <em>key schedule</em>, which is very fast but not a decent PRNG at all; it is meant to offer sufficient security in the very specific context of producing subkeys for the AES only. The key schedule of AES was already known to be somewhat weak in some ways, allowing some exploitable structure to leak from one subkey to another, and this means <a href="http://en.wikipedia.org/wiki/Related-key_attack">related-key attacks</a>.  

Related-key attacks are not a problem when the encryption algorithm is used for encryption, because they work only when the victim uses several distinct keys, such that the differences (bitwise XOR) between the keys are known to the attacker and follow a very definite pattern. This is not the kind of thing which often occurs in protocols where AES is used; correspondingly, resistance to related-key attacks was not a design criterion for the AES competition. Related-key attacks can be troublesome when we try to reuse the block cipher as a building block for something else, e.g. a hash function. In the formal land of academic cryptanalysis, related-key attacks still count as worthwhile results, despite their lack of applicability to most practical scenarios.  

The key schedules for AES-128, AES-192 and AES-256 are necessarily distinct from each other, since they must work over master keys of distinct sizes and produce distinct numbers of subkeys. It turns out that the version of the key schedule for AES-128 seems quite stronger than the key schedule for AES-256 <em>when considering resistance to related-key attacks</em>. It is actually quite logical: to build a related-key attack, the cryptographer must have some fine control over the subkeys, preferably as independently from each other as possible. It seems natural that the longer the source master key, the more control over subkeys the cryptanalyst gets -- because the related-key attack model is a model where the attacker can somehow "choose" the keys (or at least the differences between the keys). In the extreme case of a 1408-bit master key which would simply be split into eleven 128-bit keys, the cryptanalyst would have all the independent control he could wish for. Therefore, an academic weakness relatively to related-key attacks should, generically, increase with the key size.  

The apparent paradox of the decrease in academic security when the key size increases highlights the contrived nature of the related-key attack model.  

#### Answer 2 (score 37)
No.  AES-256 is not weaker than AES-128.  Absolutely not.  And I disagree with the the advice that you should avoid AES-256.  

The attack against AES-256 is a related-key attack, which is irrelevant to most real-world uses of AES-256.  Related-key attacks only become relevant if you use the block cipher improperly, which is not something that you ought to be doing.  (Second, the related-key attack against AES-256 is completely infeasible in practice.  $2^{100}$ steps of computation: harrumph.  Not gonna happen.  It's way beyond the realm of feasibility, no matter how many supercomputers you buy.  So, the attack against AES-256 is far from being the weakest point in the system.  You shouldn't waste any energy worrying about it.  I can just about guarantee there will be other weaker links in your system -- maybe the people, or maybe the software.)  I realize the adage is that "attacks only get better", but it's rare for a related-key attack to somehow turn into a non-related-key attack.  

So, basically, pay no attention to those claimed attacks on AES-256.  They are a theoretical curiousity with little or no relevance to practice at the moment.  Unfortunately, when people hear the sound bite ("new attack on AES-256!"), it's easy for them to get the wrong impression about how serious the attacks are.  As cryptographers and security experts, I think it is important to explain why users probably don't need to worry.  

#### Answer 3 (score 12)
<p>This depends on security notions. On the one hand, considering
related-key scenarios AES-256 is weaker then AES, since Biryukov and
Khovratovich introduced <a href="http://eprint.iacr.org/2009/317">a related key attack</a> that has $2^{99.5}$ time
and data complexity.</p>

<p>On the other hand AES-128 is weaker considering – the much more
realistic – single-key scenarios. Here Bogdanov et al. introduced <a href="http://eprint.iacr.org/2011/449">a key
recovery attack against AES-128</a> with computational complexity
$2^{126.1}$. Furthermore, they also found
a recovery attack against AES-256 with computational complexity
$2^{254.4}$.</p>

<p>Note, that related-key scenarios are very academical. Here,
cryptographers assume that an adversary can 'partially control' some
relations among keys used in the computation. Therefore, minor topics
regarding the key scheduler can become a major drama.</p>

<p>I do believe that single-key scenarios do much better model the
restriction of an real world adversary than related-key scenarios do.
Therefore, I claim that AES-256 is still stronger then AES-128, at
least when its comes to practical security. :-)</p>

The consideration for the case "AES-256 vs. AES-192" is similar.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: What characters does AES output? (score [34908](https://stackoverflow.com/q/12624) in )

#### Question
From what I understand after testing the Crypto-JS file here:   

<a href="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/aes.js" rel="noreferrer">http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/aes.js</a>   

AES creates encrypted strings that contained letters, both capitalized and lowercase, as well as numbers, division characters, addition characters and equal sign characters.  

Do AES encryption strings only contain the characters mentioned above, or can they contain any character from UTF-8?  

Thanks in advance. I know this question might seem a bit dumb, but I haven't been able to find the answer after online research.  

#### Answer accepted (score 10)
AES is a <a href="http://en.wikipedia.org/wiki/Block_cipher" rel="noreferrer">block cipher</a> that operates on 128 bit blocks and for any messages (plaintexts) of other size than 128 bit one uses AES in some <a href="http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation" rel="noreferrer">mode of operation</a>, e.g., <a href="http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher-block_chaining_.28CBC.29" rel="noreferrer">CBC</a> considering the message as a sequence of 128 bit blocks (plus padding if required) or modes like <a href="http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Counter_.28CTR.29" rel="noreferrer">CTR</a> to turn AES into a <a href="http://en.wikipedia.org/wiki/Stream_cipher" rel="noreferrer">stream cipher</a>.  

Anyways, the ciphertext which is output by AES when used with a particular mode of operation is a <strong>bitstring</strong> (sequence of bytes) of some size (size of the input message plus padding if necessary) and has as it is nothing to do with any character in any encoding.   

How you display/store/transmit the ciphertext (the bitstring/sequence of bytes) and thus the set of possible <strong>characters</strong> that are used therefore depends on the <a href="http://en.wikipedia.org/wiki/Character_encoding" rel="noreferrer">character encoding</a> that is used, e.g., utf 8.  

For any given message (bitstring), the ciphertext produced by AES can be any possible bitstring, i.e., all bit patterns of the size of the ciphertext are possible. For instance, let us for simplicity assume the message to be 128 bit and let it be $0^{128}$, then the ciphertext can be any element of $\{0,1\}^{128}$. Consequently, when using a character encoding for the ciphertext, any character (bit pattern) supported by the chosen character encoding may appear somewhere in an AES ciphertext.  

In you case, the ciphertext is <a href="http://en.wikipedia.org/wiki/Base64" rel="noreferrer">BASE64</a> encoded and thus you observe exactly this set of characters when displaying the ciphertext. This particular encoding is a usual choice, since you do not run into encoding issues when dealing with on/transmitting ciphertexts between different platforms/systems.  

#### Answer 2 (score 15)
AES does not operate on or produce characters — it has no knowledge or care of any particular character encoding. AES and other modern block ciphers accept and output <em>arrays of bytes</em>. The same concept applies to the key, and (in block modes that require one), the initialization vector.  

How (and if) you choose to encode the output is up to you. For storing in a file or database, there is typically no need to encode the output – byte buffers work just fine. For showing the result to a user, things like hex-encoding are frequently used. For transport mediums that require only 7-bit clean ASCII, you can encode with Base64.  

That said, CryptoJS <em>appears</em> to automatically encode outputs with Base64. I question the wisdom of this as a default (along with several others made by the CryptoJS authors), but that's the situation as it stands.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: What is Attribute Based Encryption? (score [34853](https://stackoverflow.com/q/17893) in 2019)

#### Question
Can someone explain what <a href="http://en.wikipedia.org/wiki/Attribute-based_encryption" rel="noreferrer">attribute based encryption</a> is?  

I was searching for a book or something that can help me in this regard but so far I have found none. Google also returns practically nothing aside from the papers.  

#### Answer accepted (score 55)
I try to provide a brief intro.  

<strong>ABE</strong>  

Attribute-based encryption (ABE) is a relatively recent approach that reconsiders the concept of public-key cryptography. In traditional public-key cryptography, a message is encrypted for a specific receiver using the receiver’s public-key. Identity-based cryptography and in particular identity-based encryption (IBE) changed the traditional understanding of public-key cryptography by allowing the public-key to be an arbitrary string, e.g., the email address of the receiver. ABE goes one step further and defines the identity not atomic but as a set of attributes, e.g., roles, and messages can be encrypted with respect to subsets of attributes (key-policy ABE - KP-ABE) or policies defined over a set of attributes (ciphertext-policy ABE - CP-ABE). The key issue is, that  someone should only be able to decrypt a ciphertext if the person holds a key for "matching attributes" (more below) where user keys are always issued by some trusted party.  

<strong>Ciphertext-Policy ABE</strong>  

In ciphertext-policy attribute-based encryption (CP-ABE) a user’s private-key is associated with a set of attributes and a ciphertext specifies an access policy over a defined universe of attributes within the system. A user will be ale to decrypt a ciphertext, if and only if his attributes satisfy the policy of the respective ciphertext. Policies may be defined over attributes using conjunctions, disjunctions and $(k,n)$-threshold gates, i.e., $k$ out of $n$ attributes have to be present (there may also be non-monotone access policies with additional negations and meanwhile there are also constructions for policies defined as arbitrary circuits). For instance, let us assume that the universe of attributes is defined to be $\{A,B,C,D\}$ and user 1 receives a key to attributes $\{A,B\}$ and user 2 to attribute $\{D\}$. If a ciphertext is encrypted with respect to the policy $(A \wedge C) \vee D$, then user 2 will be able to decrypt, while user 1 will not be able to decrypt.  

CP-ABE thus allows to realize implicit authorization, i.e., authorization is included into the encrypted data and only people who satisfy the associated policy can decrypt data. Another nice features is, that users can obtain their private keys after data has been encrypted with respect to policies. So data can be encrypted without knowledge of the actual set of users that will be able to decrypt, but only specifying the policy which allows to decrypt. Any future users that will be given a key with respect to attributes such that the policy can be satisfied will then be able to decrypt the data.  

<strong>Key-Policy ABE</strong>  

KP-ABE is the dual to CP-ABE in the sense that an access policy is encoded into the users secret key, e.g., $(A \wedge C) \vee D$, and a ciphertext is computed with respect to a set of attributes, e.g., $\{A,B\}$. In this example the user would not be able to decrypt the ciphertext but would for instance be able to decrypt a ciphertext with respect to $\{A,C\}$.   

An important property which has to be achieved by both, CP- and KP-ABE is called collusion resistance. This basically means that it should not be possible for distinct users to "pool" their secret keys such that they could together decrypt a ciphertext that neither of them could decrypt on their own (which is achieved by independently randomizing users' secret keys).   

<strong>Beyond ABE</strong>  

ABE is just one type of the more general concept of functional encryption (FE) covering IBE, ABE and many other concepts such as inner product or hidden vector encryption (yielding e.g., searchable encryption) etc. It is a very active and young field of research and has many interesting applications (in particular in the field of cloud computing).   

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How much computing resource is required to brute-force RSA? (score [34572](https://stackoverflow.com/q/3043) in )

#### Question
It's been over 30 years since Rivest, Shamir and Adleman first <a href="http://people.csail.mit.edu/rivest/Rsapaper.pdf">publicly</a> described their algorithm for public-key cryptography; and the intelligence community is thought to have known about it for around 40 years&mdash;possibly longer.  

It's fair to assume that, during those 40 years, certain three-letter organisations have employed their vast resources toward "breaking" RSA.  One brute-force approach may have been to enumerate every possible key-pair such that, upon encountering a message known to be  encrypted with a particular public-key, they need merely lookup the associated private-key in order to decrypt that message.  Signatures could be forged similarly.  

How reasonable is this hypothesis?  How much computing resource would have been required over those 40 years to enumerate every possible {1024,2048,4096}-bit key-pair?  I think it best to avoid discussion and leave the question of whether the spooks could have harnessed such resource as an exercise to the reader.  

#### Answer accepted (score 26)
It's not possible.  

The number of primes smaller than $x$ is <a href="http://en.wikipedia.org/wiki/Prime_number_theorem" rel="noreferrer">approximately</a> $\frac{x}{\ln x}$. Therefore the number of $512$ bit primes (approximately the length you need for $1024$ bit modulus) is approximately:  

$$\frac{2^{513}}{\ln 2^{513}}-\frac{2^{512}}{\ln 2^{512}} \approx 2.76×10^{151}$$  

The number of RSA moduli (i.e. pair of two distinct primes) is therefore:  

$$\frac{(2.76×10^{151})^2}{2}-2.76×10^{151}=1.88×10^{302}$$  

Now consider that the <a href="http://en.wikipedia.org/wiki/Observable_universe#Matter_content" rel="noreferrer">observable universe</a> contains about $10^{80}$ atoms. Assume that you could use each of those atoms as a CPU, and each of those CPUs could enumerate one modulus per millisecond. To enumerate all $1024$ bit RSA moduli you would need:  

<p>\begin{eqnarray*}
1.88×10^{302}ms / 10^{80}&amp;=&amp;1.88×10^{222}ms\\
&amp;=&amp;1.88×10^{219}s\\
&amp;=&amp;5.22×10^{215}h\\
&amp;=&amp;5.95×10^{211} \text{years}
\end{eqnarray*}</p>

Just as a comparison: the universe is about $13.75×10^9$ years old.  

It's not a question of resources, it's simply not possible.  

Also, it would not make any sense to do that. There are much faster ways to find out a secret key. In fact there are algorithms with sub-exponential running time for factoring integers.  

#### Answer 2 (score 13)
The brute force technique described in the question is hopeless, as pointed in this <a href="https://crypto.stackexchange.com/a/3044/555">other answer</a>.  

However there are much better techniques to attack RSA keys, including <a href="http://en.wikipedia.org/wiki/General_number_field_sieve" rel="noreferrer">GNFS</a>. Therefore 1024-bit RSA keys, even though they offer sizable security, can no longer be considered entirely safe from predictable academic efforts, or even safe at all from Three-Letter-Agencies. See my detailed <a href="https://crypto.stackexchange.com/a/1982/555">answer</a> to <a href="https://crypto.stackexchange.com/q/1978/555"><em>How big an RSA key is considered secure today?</em></a>. And for new systems, use whatever recommendation is applicable, or refer to one of the many on this <a href="http://www.keylength.com/" rel="noreferrer">site dedicated to keylength</a> recommendations.  

Also, sometime one can <a href="http://eprint.iacr.org/2012/064.pdf" rel="noreferrer">exploit a goof in the key generator</a>, or attack RSA in ways that do not involve integer factorization: stealing the private key; extracting it by <a href="http://www.cryptography.com/public/pdf/DPATechInfo.pdf" rel="noreferrer">Differential Power Analysis</a>, <a href="http://cpe.kmutt.ac.th/lab/logic/Side_Channel_Attack.pdf" rel="noreferrer">Timing or Fault attack</a>; or taking advantage of a weakness in <a href="http://www.jscoron.fr/publications/padding.pdf" rel="noreferrer">padding</a>. See also <a href="http://crypto.stanford.edu/~dabo/papers/RSA-survey.pdf" rel="noreferrer"><em>Twenty Years of Attacks on the RSA Cryptosystem</em></a>.  

Update: <em>Computational efforts</em> performed in the last 40 years help new attacks because the methods have been worked out, but (for any known practical method) <em>the computational effort</em> spent for attacking a particular key is not useful in attacking another key, much like knowing that $1234567890221=23801\cdot 51870421$ does not really help finding the factorization of $1234567890197$.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: SHA-256 and AES-128 (score [33770](https://stackoverflow.com/q/3856) in 2013)

#### Question
Does it make an encrypted string more secure if I use SHA256(x) instead of x as the secret key for AES-128 encryption? I do know that SHA-256 produces 64 characters of hashed string regardless of what the input is.  

<p>Will it still be accepted in AES as a key or it will cut it off to 32 characters?
Also is it true that each byte is equivalent to 8 bits (e.g. if I enter `xkcd` it will be 32 bits)?</p>

#### Answer accepted (score 13)
<strong>First let's take care of your encoding related issues:</strong>  

You can't simply say one byte equals one char. You need an encoding to transform between these, where the properties depend on that encoding.  

When transforming between normal text and bytes, <a href="http://en.wikipedia.org/wiki/UTF-8" rel="noreferrer">UTF-8</a> is a good choice. One character will correspond to a variable amount of bytes that way. You'd use this to turn a password into bytes. `xkcd` would result in 4 bytes, but non ASCII characters, such as `ü` will result in more than one byte per char.  

When turning arbitrary binary data into text, use an encoding specialized in that. Hex is very popular, turning each byte into two characters. <a href="http://en.wikipedia.org/wiki/Base64" rel="noreferrer">Base64</a> which turns 6 bits into one char is a common alternative.  

Now SHA-256 returns 32 bytes of binary data. If you use hex encoding on that, you get 64 chars.  

AES-128 takes a 16 byte key, which corresponds to 32 characters in hex encoding.  

<strong>Next we get to your key derivation issues:</strong>  

The problem with passwords is, that they tend to be weak, compared to random keys. So you need to send them through a <a href="http://en.wikipedia.org/wiki/Key_derivation_function" rel="noreferrer">key-derivation-function</a>, that makes password guessing attacks more difficult.  

SHA-256 is not a good choice for this, because it's fast. You should use a deliberately slow function, such as <a href="http://en.wikipedia.org/wiki/PBKDF2" rel="noreferrer">PBKDF-2</a>, together with a random salt.  

When using AES-128 truncate the output of it to 128 bits (or explicitly request 128 bits if your KDF supports that). Your password will be much weaker than even a 128 bit key, so there isn't much gain in using 256 bit keys.  

#### Answer 2 (score 6)
The proper way to do things in this case would be to feed the password to a <a href="http://en.wikipedia.org/wiki/Key_derivation_function">key derivation function</a> such as <a href="http://en.wikipedia.org/wiki/PBKDF2">PBKDF2</a>. PBKDF2 (and other KDFs) is designed specifically for what you describe. Since you are using AES-128, you would want a 128-bit output from PBKDF2, then feed that into AES.  

Now, stepping back a little, the best advice I can give you is to not roll your own crypto protocol and instead use a widely accepted standard. If you are doing file encryption, PGP (or GPG on the open-source side) is the way to go. If you are encrypting network traffic, you should be using SSL or IPsec. Providing us with more information as to what you are specifically doing would allow us to provide better guidance.  

That said, perhaps you are doing this as a learning exercise. In that case, I think the first paragraph is the best advice I can give.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Why use an Initialization Vector (IV)? (score [33656](https://stackoverflow.com/q/732) in 2017)

#### Question
Why use an <a href="http://en.wikipedia.org/wiki/Initialization_vector" rel="noreferrer">Initialization Vector (IV)</a>?  

<ul>
<li>How are IV's used?</li>
<li>What are the advantages/disadvantages of using an IV?</li>
<li>Why use an IV instead of a longer key in which some section of the key is pubic?</li>
<li>What happens to various security properties if an IV is <a href="https://crypto.stackexchange.com/questions/296/is-it-okay-to-use-a-hash-of-a-timestamp-as-the-iv-for-aes">insufficiently</a> <a href="https://crypto.stackexchange.com/questions/66/whats-the-details-of-the-des-weakness-of-reusing-the-same-iv-in-cbc-mode-with-th">random</a>?</li>
<li>Are IV's always public knowledge? If so is this the property that distinguishes an IV from a Key?</li>
<li>Given that IV are often public are there any attacks that involve a man-in-the-middle attack that alters the IV?</li>
</ul>

#### Answer accepted (score 33)
Many cryptographic algorithms are expressed as iterative algorithms. E.g., when encrypting a message with a block cipher in <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher-block_chaining_.28CBC.29" rel="nofollow noreferrer">CBC mode</a>, each message "block" is first XORed with the previous encrypted block, and the result of the XOR is then encrypted. The first block has no "previous block" hence we must supply a conventional alternate "zero-th block" which we call "initialization vector". Generally speaking, an IV is whatever piece of data is needed to begin running an algorithm, and is not secret (if it was secret, we would call it a "key", not an IV).  

If you take a look at <a href="http://tools.ietf.org/html/rfc1321" rel="nofollow noreferrer">MD5</a>, you see that it is an iterative algorithm which has a "running state" (four 32-bit words) and processes message data by 64-byte chunks, each yielding the next running state; the final state is the hash output. This has to begin with a conventional initial state, which is described in section 3.3 of the RFC.  

Since an IV has some cost (e.g. it must be transmitted along a message), it is not there just for aesthetic reasons: algorithms which use an IV need it to fulfil some sort of security property, and this <em>may</em> imply some constraints on what value an IV may have. This really depends on the algorithm. For instance, with MD5, the IV is fixed and this is not an issue. For the case of CBC, see <a href="https://crypto.stackexchange.com/questions/66/whats-the-details-of-the-des-weakness-of-reusing-the-same-iv-in-cbc-mode-with-th/82#82">this answer</a> to a previous question. Since uniform randomness is a difficult requirement (alea is a scarce resource, especially in embedded systems), it is considered a good thing if an encryption algorithm requires only a non-repeating IV (e.g. a simple counter); this is all that newer encryption modes such as <a href="http://en.wikipedia.org/wiki/EAX_mode" rel="nofollow noreferrer">EAX</a> need.  

An IV <em>can</em> be made public but nothing forces you to. It still tends to have a lifecycle distinct from that of a key, in that (for symmetric encryption) you need a new IV <em>per message</em> but not necessarily a new key. For instance, with <a href="http://tools.ietf.org/html/rfc5246" rel="nofollow noreferrer">TLS 1.2</a>, a session key is created during the tunnel setup (the "handshake"), then data is encrypted as so many "records" (up to 16 kB of data per record) and each record has its own IV.  

#### Answer 2 (score 23)
Well, the exact reason for an IV varies a bit between different modes that use IV.   At a high level, what the IV does is act as a randomizer, so that each encrypted message appears to be encrypted to a random pattern, even if those messages are similar.  In general, IVs disguise when you encrypt the same message twice (and more generally, when two messages you encrypt are related).  

To answer your specific questions:  

<ul>
<li><p>How are IV's used?
The are one of the inputs specified to various block cipher modes of operation.  Both the encryptor and the decryptor needs a copy of the IV to process a message; this IV need not be secret.  Exactly what the mode of operation does with the IV depends on the mode; for CBC mode, CBC mode XOR's each block with the previous ciphertext block; for the first block (where there is no previous one), the IV stands for the previous ciphertext block.</p></li>
<li><p>What are the advantages/disadvantages of using an IV?
If you are using a mode of operation that uses an IV, using one is mandatory; the question then becomes 'do we send an explicit on, or do we have the encryptor/decryptor agree on how they will compute the IVs'.  How the later works depends on what they agree upon, and how well that fulfills the requirements the mode of operations places on IVs.  If the question is 'why use a mode of operation that uses an IV', well, using a deterministic encryption method, it becomes impossible to disguise when you encrypt the same message twice.  Even if that is not a concern, it also becomes difficult to disguise when you're encrypting related messages (say, messages where the first 16 bytes are exactly the same).  This can be solved without an IV; it does involve nonstandard modes.</p></li>
<li><p>Why use an IV instead of a longer key in which some section of the key is public?
Because the IV needs to change for every message.</p></li>
<li><p>What happens to various security properties if an IV is insufficiently random?
That really depends on the mode of operation.  On one extreme, we have GCM and CTR mode, which couldn't care less if the IV is perfectly predictable (on the other hand, the security properties fail if you use the same IV for two different messages; hence we often use a counter to generate GCM and CTR IVs).  On the other extreme, we have CBC, where predictable IVs is known to allow a decryptor to recover plaintext with some work (and this is not a merely theoretical weakness, someone has recently announced a tool that uses this weakness to recover PayPal authentication cookies in TLS 1.0).</p></li>
<li><p>Are IV's always public knowledge?
Well, they don't <em>have</em> to be public knowledge.  However, they can be, and because the easiest way to transport them from encryptor to decryptor is just include them in the ciphertext, they usually are.</p></li>
<li><p>Given that IV are often public, are there any attacks that involve a man-in-the-middle attack that alters the IV?
Well, I would hope that any encryption mechanism would also include an integrity check which should catch this.  If this check is on the plaintext, any change in the IV will also modify the plaintext, and so it will check this.  If this check is on the ciphertext, the check will need to include a check on the IV.</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Basic explanation of Elliptic Curve Cryptography? (score [33317](https://stackoverflow.com/q/653) in 2011)

#### Question
I have been studying Elliptic Curve Cryptography as part of a course based on the book <a href="http://rads.stackoverflow.com/amzn/click/0136097049">Cryptography and Network Security</a>. The text for provides an excellent theoretical definition of the algorithm but I'm having a hard time understanding all of the theory involved in ECC.  

I'm looking for an explanation suitable for someone who has studied at undergraduate level in computer science. Can anyone explain how elliptic curve cryptography works in a simple, straightforward manner?   

#### Answer accepted (score 32)
There are some widely used cryptographic algorithms which need a finite, cyclic <a href="http://en.wikipedia.org/wiki/Group_%28mathematics%29">group</a> (a finite set of element with a composition law which fulfils a few characteristics), e.g. <a href="http://en.wikipedia.org/wiki/Digital_Signature_Algorithm">DSA</a> or <a href="http://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange">Diffie-Hellman</a>. The group must have the following characteristics:  

<ul>
<li>Group elements must be representable with relatively little memory.</li>
<li>The group size must be known and be a prime number (or a multiple of a known prime number) of appropriate size (at least 160 bits for the traditional security level of "80-bit security").</li>
<li>The group law must be easy to compute.</li>
<li>It shall be hard (i.e. computationally infeasible, up to at least the targeted security level) to solve <a href="http://en.wikipedia.org/wiki/Discrete_logarithm">discrete logarithm</a> in the group.</li>
</ul>

DSA, DH, ElGamal... were primarily defined in the group of non-zero integers modulo a big prime <em>p</em>, with modular multiplication as group law. The characteristics we look for are reached as long as <em>p</em> is large enough, e.g. at least 1024 bits (that's the minimal size for discrete logarithm to be hard in such a group).  

Elliptic curve are another kind of group, appropriate for group-based cryptographic algorithm. An elliptic curve is defined with:  

<ul>
<li>A <a href="http://en.wikipedia.org/wiki/Finite_field">finite field</a>, usually consisting in integers modulo some prime <em>p</em> (there are also other fields which can be used).</li>
<li>A curve equation, usually $y^2 = x^3 + ax +b$, where $a$ and $b$ are constant values from the finite field.</li>
</ul>

The curve is the set of pairs of values $(x, y)$ which match the equation, along with a conventional extra element called "the point at infinity". Since elliptic curves initially come from a graphical representations (when the field consists in the real numbers $\mathbb{R}$), the curve elements are called "<em>points</em>" and the two values $x$ and $y$ are their "<em>coordinates</em>".  

Then we define a group law, called <em>point addition</em> and denoted with a "$+$" sign. The definition looks quite artifical, with all the business about tracing a line and computing the intersection of that line with the curve; but the bottom-line is that it has the characteristics required for a group law, and it is easily computable (there are several methods; as a rough approximation, it costs about 10 multiplications in the base field). The <em>curve order</em> (the number of points on the curve) is close to $p$ (the size of the finite field): the curve order is equal to $p+1-t$ for some integer $t$ such that $|t| \leq 2\sqrt{p}$.  

Compared to the traditional multiplicative group modulo a big prime, elliptic curve variants of cryptographic algorithms have the following practical features:  

<ul>
<li><strong>They are <em>small</em> and <em>fast</em></strong>. There is no known efficient discrete-logarithm solving algorithm for elliptic curves, beyond the generic algorithms which work on every group. So we get appropriate security as soon as $p$ is close to 160 bits. Computing the group law costs ten field operations, but on a field which is 6 times smaller; since multiplications in a finite field have quadratic cost, we end up with an appreciable speedup.</li>
<li><strong>Creating a new curve is uneasy</strong>. Generating a new big prime is a matter of
a fraction of a second with a basic PC, but making a new curve is much more expensive (the hard part is figuring out the curve order). Since there is no security issue in using the same group for several distinct key pairs, it is customary, with elliptic curves, to rely on a handful of standard curves which have been created such that their order is appropriate (a big prime value or a multiple of a big enough prime value); see <a href="http://csrc.nist.gov/publications/fips/fips186-3/fips_186-3.pdf">FIPS 186-3</a>. The implementations are thus specialized and optimized for these particular curves, which again considerably speeds things up.</li>
<li><strong>Elliptic curves can be used to factor integers</strong>. Lenstra's <a href="http://en.wikipedia.org/wiki/Lenstra_elliptic_curve_factorization">elliptic curve factorization method</a> can find some factors in big integers with a devious use of elliptic curves. This is not the best known factorization algorithm, except when it comes to finding medium-sized factors in a big non-prime integer.</li>
<li><strong>Some elliptic curves allow for pairings</strong>. A <a href="http://en.wikipedia.org/wiki/Pairing">pairing</a> is a bilinear operation which can link elements from two groups into elements of a third group. A pairing for cryptography requires all three groups to be "appropriate" (in particular with a hard-to-solve discrete logarithm). Pairings are an active research subject because they can be used to implement protocols with three participants (e.g. in electronic cash systems, with the buyer, the vendor and the bank, all mathematically involved in the system). The only known practical pairings for cryptography use some special elliptic curves.</li>
</ul>

Elliptic curves are usually said to be the next generation of cryptographic algorithms, in order to replace RSA. Performance of EC computations is the main interest of these algorithms, especially on small embedded systems such as smartcards (in particular Koblitz curves over binary fields); the biggest remaining issue is that public-key operations with group-based algorithms are a bit slow (RSA signature <em>verification</em> or asymmetric <em>encryption</em>, as opposed to signature generation and asymmetric decryption, respectively, is extremely fast, whereas analogous operations in the group-based algorithms are just fast). Also, involved mathematics are a bit harder than with RSA, and there have been patents, so implementers are a bit wary. Yet elliptic curves become more and more common.  

#### Answer 2 (score 10)
Once upon a time, in a land far, far away, there lived two men by the name of Neal Koblitz and Victor S. Miller.  They didn't know each other, however, in 1985 they both suggested using elliptical curves over finite fields for encrypting/decrypting data.  

Seriously, though, the following explanation requires that you have a basic understanding of finite fields.  Most of it is taken from the Wiki links suggested by D.W.  

Elliptic curve cryptography (ECC) is an approach to public-key cryptography based on the algebraic structure of elliptic curves over finite fields.  

Public-key cryptography is based on the intractability of certain mathematical problems. Early public-key systems, such as the RSA algorithm, are secure assuming that it is difficult to factor a large integer composed of two or more large prime factors.  

For elliptic-curve-based protocols, it is assumed that finding the discrete logarithm of a random elliptic curve element with respect to a publicly-known base point is infeasible. The size of the elliptic curve determines the difficulty of the problem. It is believed that the same level of security afforded by an RSA-based system with a large modulus can be achieved with a much smaller elliptic curve group. Using a small group reduces storage and transmission requirements.  

For current cryptographic purposes, an elliptic curve is a plane curve which consists of the points satisfying the equation  

$y^2 = x^3 + ax + b$,  

along with a distinguished point at infinity. (The coordinates here are to be chosen from a fixed finite field of characteristic not equal to 2 or 3, or the curve equation will be somewhat more complicated.) This set together with the group operation of the elliptic group theory form an Abelian group, with the point at infinity as identity element. The structure of the group is inherited from the divisor group of the underlying algebraic variety.  

How it works depends on the cryptographic scheme you apply it to.  As an example, it can be applied it to the Diffie-Hellman key exchange, which is commonly known as the Elliptic Curve Diffie-Hellman (ECDH) key agreement protocol.  

Suppose Alice wants to establish a shared key with Bob, but the only channel available for them may be eavesdropped by a third party. Initially, the domain parameters (that is, $(p,a,b,G,n,h)$ in the prime case or $(m,f(x),a,b,G,n,h)$ in the binary case) must be agreed upon. Also, each party must have a key pair suitable for elliptic curve cryptography, consisting of a private key d (a randomly selected integer in the interval $[1,n − 1]$) and a public key $Q$ (where $Q = dG$). Let Alice's key pair be $(d_A,Q_A)$ and Bob's key pair be $(d_B,Q_B)$. Each party must have the other party's public key (an exchange must occur).  

Alice computes $(x_k,y_k) = d_AQ_B$. Bob computes $k = d_BQ_A$. The shared key is $x_k$ (the $x$ coordinate of the point).  

The number calculated by both parties is equal, because $d_AQ_B = d_Ad_BG = d_Bd_AG = d_BQ_A$.  

The protocol is secure because nothing is disclosed (except for the public keys, which are not secret), and no party can derive the private key of the other unless it can solve the Elliptic Curve Discrete Logarithm Problem.  

#### Answer 3 (score 5)
I recommend that you start by reading <a href="https://secure.wikimedia.org/wikipedia/en/wiki/Elliptic_curve_cryptography" rel="nofollow">the description of elliptic curve cryptography in Wikipedia</a>, and then let us know what you'd like to know: What didn't you understand?  What didn't it cover that you'd like to know about?  

The one-sentence version is that elliptic curve cryptography is a form of public-key cryptography that is more efficient than most of its competitors (e.g., RSA).  

For every public-key cryptosystem you already know of, there are alternatives based upon elliptic curve cryptography (ECC).  The ECC schemes are probably faster.  Consequently, ECC is particularly appropriate for embedded devices and other systems where performance is at a premium.  On the other hand, ECC is newer than some other well-known alternatives, and there is a bit of a patent minefield surrounding some kinds of elliptic-curve cryptography, so ECC hasn't seen as much deployment as classic RSA/DSA/El Gamal -- but ECC is used in the wild in some systems.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Why is AES resistant to known-plaintext attacks? (score [33246](https://stackoverflow.com/q/1512) in 2012)

#### Question
At least it's my understanding that AES isn't affected by known-plaintext. Is it immune to such an attack, or just resistant? Does this vary for chosen-plaintext?  

#### Answer accepted (score 40)
A known-plaintext attack (i.e. knowing a pair of corresponding plaintext and ciphertext) always allows a <em>brute-force attack</em> on a cipher:  

<ul>
<li>Simply try all keys, decrypt the ciphertext and see if it matches the plaintext.</li>
</ul>

This always works for every cipher, and will give you the matching key. (For very short plaintext-ciphertext pairs, you might get multiple matching keys. Then you need to try more pairs to eliminate the wrong ones).  

If you have no known plaintext, only the ciphertext, you can do it similarly, but you also need a function which says whether what you decrypted is a plausible plaintext.  

The problem with <em>try all keys</em> is that for every modern cipher (i.e. key sizes of 128 bit or more) the key space is that large that you need much more time than the remaining lifetime of the universe to check a significant portion of all keys.  

So, the question is, <em>are there any attacks which are faster than brute-force</em>?  

For now, there seem to be some attacks which are slightly faster (like needing only $2^{125}$ steps instead of $2^{127}$ for brute-force, a bit better for the 256-bit-key version) and needing either a <em>really large</em> amount of chosen plain- or ciphertexts (and knowing the result), or even larger amounts of known plaintexts. These are still not practically doable in our world.  

There are no proofs that AES (or any block cipher) is really secure, only the heuristic <em>"many smart people tried to break it and until now, nobody was successful"</em> (or at least, nobody who succeeded told the public).  

#### Answer 2 (score 13)
Well, the answer to 'why is AES resistant to known-plaintext attacks' is that, well, lots of really bright people have thought hard about how to break AES, and no one has come up with a practical way, either assuming known plaintext or chosen plaintext.  See <a href="https://crypto.stackexchange.com/questions/1145/how-much-would-it-cost-in-u-s-dollars-to-brute-force-a-256-bit-key-in-a-year">how-much-would-to-cost-to-brute-force-AES</a> for a discussion on what it would take, given the current state of knowledge.  

So, the answer to 'is it immune', the answer is, yes, as far as we know, it is.  

#### Answer 3 (score 4)
<em>Differential cryptanalysis</em> is a form of a plaintext attack. The <a href="http://en.wikipedia.org/wiki/Differential_cryptanalysis" rel="nofollow">Wikipedia article on Differential cryptanalysis</a> says that AES has been <em>designed</em> with resistance against this attack in mind. Wikipedia even say this resistance can be proven mathematically, but do not source it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: What is the recommended replacement for MD5? (score [33100](https://stackoverflow.com/q/2994) in 2013)

#### Question
Since MD5 is broken for purposes of security, what hash should I be using now for secure applications?  

#### Answer accepted (score 31)
That depends on what you want to use the hash function for.  

For signing documents, <a href="http://en.wikipedia.org/wiki/SHA-2">sha2</a> (e. g. sha512) is considered secure.  

For storing passwords, you should use one of the algorithms dedicated for this purpose: e. g. <a href="http://en.wikipedia.org/wiki/Crypt_%28Unix%29#Blowfish-based_scheme">bcrypt</a>, <a href="http://en.wikipedia.org/wiki/Crypt_%28Unix%29#SHA2-based_scheme">sha512crypt</a> or <a href="http://www.daemonology.net/blog/2009-05-09-scrypt-key-derivation.html">scrypt</a>. In order to slow down an attacker, these algorithms apply the hash functions many times with an input that is based on the number of the current round.   

Scrypt takes this concept one step further and uses a huge amount of memory. Typical hardware for password cracking has access to about a couple of KB of memory, the default configuration of scrypt requires 16 MB.  

#### Answer 2 (score 15)
Among the options for a replacement of MD5 <em>as a hash function</em>:  

<ul>
<li>If at all possible, you should increase the width of the hash for strong collision resistance, and use an at-least-256 bit member of the <a href="https://en.wikipedia.org/wiki/SHA-2" rel="nofollow noreferrer">SHA-2</a>, or perhaps the new <a href="https://en.wikipedia.org/wiki/SHA-3" rel="nofollow noreferrer">SHA-3</a> family. The collision resistance of any 128-bit hash can be broken by educated brute force and about $2^{65}$ hashes (which is feasible for decently fast hashes and modern means) using Paul C. van Oorschot and Michael J. Wiener's <em>Parallel Collision Search with Cryptanalytic Applications</em> (<a href="https://link.springer.com/article/10.1007/PL00003816" rel="nofollow noreferrer">in Journal of Cryptology</a>, January 1999, Volume 12, Issue 1; <a href="http://people.scs.carleton.ca/~paulv/papers/JoC97.pdf" rel="nofollow noreferrer">free slightly earlier version</a> available from the <a href="http://people.scs.carleton.ca/~paulv/papers/pubs.html" rel="nofollow noreferrer">first author's website</a>).</li>
<li>If a 128-bit replacement is thought despite the above (which would be rational in applications where collision resistance is not an issue, and perhaps in <a href="https://en.wikipedia.org/wiki/Hash-based_message_authentication_code" rel="nofollow noreferrer">HMAC</a>) 

<ul>
<li>a candidate worth examination is <a href="http://homes.esat.kuleuven.be/~bosselae/ripemd160/pdf/AB-9601/AB-9601.pdf" rel="nofollow noreferrer">RIPEMD-128</a>, a pin-compatible replacement of MD5, with a name. RIPEMD-128 uses the same security argument as RIPEMD-160 (though with 4 groups of rounds instead of 5). RIPEMD-160 in turn is AFAIK the single standard unbroken 160-bit hash, and has enjoyed the status of being vetted by European cryptographic authorities before the ban of all hashes less than 256-bit. RIPEMD-128 has been <em>threatened</em> in late 2013, by an <a href="https://eprint.iacr.org/2013/607" rel="nofollow noreferrer">attack</a> (theoretically) finding collision <em>on the round function for different chaining variable inputs</em> with about 5 times less work than brute force. However RIPEMD128 should not be considered broken (as stated in this <a href="https://crypto.stackexchange.com/q/2994/555#comment23002_3001">comment</a>), because the attack does not yield a hash collision for different messages, and was not extended to that (as far as I can tell as of early 2017). But as the saying goes, <em>attacks only get better; they never get worse</em>.<br>
Despite that partial attack, when moderate resistance to collision is enough, RIPEMD-128 would remain a better choice than MD5, if the objective of the change was to remove the word MD5 from the specification, without changing anything else, nor loosing too much speed or requiring much more memory. Note: RIPEMD, an ancestor of RIPEMD-128, is <a href="https://eprint.iacr.org/2004/199" rel="nofollow noreferrer">broken like MD5 is</a>, and must not be used.</li>
<li>A more conservative choice would be the-first-128-bits-of-<a href="https://en.wikipedia.org/wiki/SHA-2" rel="nofollow noreferrer">SHA-256</a>, if you relax the "with a name" and performance constraints just a tad. An attack against that would be considered an attack of SHA-256, which stands unbroken by March 2017 despite considerable efforts and attacks of reduced variants. The best known attack against the-first-128-bits-of-SHA-256 is a collision search (see start of this answer).</li>
</ul></li>
</ul>

MD5 has often been used for <em>protection of login information including password</em>, or generation of a key from a password. In such applications, using any fast hash is a bad design choice, and you want to use proper <a href="https://en.wikipedia.org/wiki/Key_stretching" rel="nofollow noreferrer">key stretching</a>. I have previously recommended <a href="https://www.tarsnap.com/scrypt.html" rel="nofollow noreferrer">scrypt</a> when constraints allow (that is: there is ample memory; an efficient implementation of <a href="http://cr.yp.to/snuffle.html#specification" rel="nofollow noreferrer">Salsa-20</a> is possible; and an appropriately secure implementation of SHA-256 is possible, which might be difficult if <a href="http://www.cryptography.com/public/pdf/IntroToDPA.pdf" rel="nofollow noreferrer">DPA</a> is a consideration); or <a href="https://en.wikipedia.org/wiki/Bcrypt" rel="nofollow noreferrer">bcrypt</a>, if scrypt is not an option; with some <a href="https://en.wikipedia.org/wiki/PBKDF2" rel="nofollow noreferrer">PBKDF2</a> and ample iteration parameter if all else is infeasible. Now we have <a href="https://password-hashing.net/" rel="nofollow noreferrer">Argon2</a>, which should take over these.  

#### Answer 3 (score 7)
One of the <a href="https://en.wikipedia.org/wiki/SHA-2" rel="nofollow noreferrer">SHA2</a> or <a href="https://en.wikipedia.org/wiki/SHA-3" rel="nofollow noreferrer">SHA 3</a> hashes; if you don't have any preference between them, pick SHA256.  

You might hear the argument that the 256 bit version of SHA-3 is "newer", hence ought to be preferred.  IMHO, older secure cryptography (that is, cryptography that has survived cryptanalysis longer) is generally to be preferred; however there appears to be nothing wrong with SHA-3.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Is secp256r1 more secure than secp256k1? (score [32936](https://stackoverflow.com/q/18965) in 2015)

#### Question
Curves secp256r1 and secp256k1 are both examples of two <a href="http://en.wikipedia.org/wiki/Elliptic_curve">elliptic curves</a> used in various asymmetric cryptography.  

Googling for these shows most of the top results are Bitcoin related. I've heard the claim that…  

<blockquote>
  Satoshi picked non-standard crypto which conventional wisdom says will be cracked in 5-10 years.  
</blockquote>

There is <a href="https://bitcointalk.org/index.php?topic=151120.0">this discussion</a> on bitcointalk with various opinions to both sides of the argument (also check out <a href="http://chrispacia.wordpress.com/2013/10/30/nsa-backdoors-and-bitcoin/">this article</a>). I would like to take it away from Bitcoin and into the general cryptographic question: is secp256r1 indeed more secure in some sense than secp256k1?  

#### Answer 2 (score 43)
The main difference is that secp256k1 is a Koblitz curve, while secp256r1 is not. Koblitz curves are known to be a few bits weaker than other curves, but since we are talking about 256-bit curves, neither is broken in "5-10 years" unless there's a breakthrough.  

The other difference is how the parameters have been chosen. In secp256r1 they are supposedly from random numbers, however, it is impossible to prove that's really the case. See e.g. <a href="http://www.hyperelliptic.org/tanja/vortraege/20130531.pdf">these slides</a> from Bernstein and Lange for an easily understandable treatment.  

The Koblitz curve, on the other hand, has had its parameters chosen <a href="http://safecurves.cr.yp.to/rigid.html">relatively rigidly</a>. The <a href="https://bitcointalk.org/index.php?topic=289795.msg3183975#msg3183975">post</a> runeks linked in the comments has an explanation for why they were chosen.  

So rather than saying one is more secure, I would say that the risks are different. If neither curve has backdoors or accidental weaknesses, both are secure. The few extra bits of security secp256r1 has won't matter unless you happen to own e.g. a moderately sized quantum computer that can just manage one but not the other. It would have been easier to backdoor the secp256r1 curve, but on the other hand, Koblitz curves as a class could be completely weak in some way not currently known.  

I.e. which to prefer is somewhat subjective. If you don't like Koblitz curves but are afraid secp256r1 is backdoored, there's always the option to use some other curve designed according to criteria you like. (Though you cannot, of course, change what BTC uses.)  

#### Answer 3 (score 17)
The curves secp256r1 and secp256k1 have comparable security.  

<p>If we consider only the best known attacks today, they have very close security.
Both curves are defined over prime fields and have no known weakness, therefore the best attack that applies is <a href="https://en.wikipedia.org/wiki/Pollard&#39;s_rho_algorithm">Pollard's Rho</a>. Its complexity is: $\sqrt{\frac{{\pi}n}{2m}}$ where $n$ is the order of the curve (if it's prime, such as in our cases) and $m$ is the order of the automorphism (see this <a href="https://www.iacr.org/cryptodb/data/paper.php?pubkey=178">paper</a> for the details of the following).</p>

Now, all elliptic curves have an automorphism of order 2, this is provided by the point inversion map, i.e., the fact that for $P=(x,y); -P=(x,-y)$.   

<p>secp256k1 have an additional automorphism because it belongs to a special class of elliptic curves, sometimes referred to as Koblitz (although this has lead to some confusion, and some people have mistakenly called it a binary curve), which have an additional automorphism. This allows to map the the point $P=(x,y)$ to either $\lambda P=(\beta x,y)$ or $\lambda^2 P=(\beta^2 x,y)$ where $\beta = \sqrt[3]{1} \pmod{p},\lambda = \sqrt[3]{1} \pmod{n}$. This can be combined with the inversion map and achieve order 6.
Given the two numerical values for the orders, using base 2 logs we obtain:</p>

Security secp256r1 = $\log_2\sqrt{\frac{{\pi}n_{secp256r1}}{4}}=127.83$   

Security secp256k1 = $\log_2\sqrt{\frac{{\pi}n_{secp256k1}}{12}}=127.03$  

Which are comparable.  

Then, considering rigidity, secp256k1 is more rigid than secp256r1. So it is theoretically possible that secp256r1 was chosen to belong to a secret class of elliptic curves that are not as secure as we think.  

<p>Then, considering special class of elliptic curves, secp256k1 belongs to a special class, because its parameters were not randomly chosen, while those of secp256r1 looks random (but we can't be sure due to secp256r1 rigidity issue). 
Thus it is theoretically possible that secp256k1's class will be found not as secure as we currently think. But this class is well known, and so far the only issue is that additional negation map, which, by the way allows for faster scalar multiplication computation than, e.g., secp256r1.</p>

It is difficult to judge how the rigidity and special class considerations affects the overall security of the curves. On one hand the NSA generated secp256r1 using a process that people don't fully trust, on the other hand secp256k1 has been chosen to belong to a special class of elliptic curves.  

<p>In my personal opinion these two facts cancel each other.
Therefore, in this case, I chose to stick to the current best known attack as measure of security and conclude that they have comparable security.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Best way to reduce chance of hash collisions: Multiple hashes, or larger hash? (score [32570](https://stackoverflow.com/q/1170) in 2011)

#### Question
I would like to maintain a list of unique data blocks (up to 1MiB in size), using the SHA-256 hash of the block as the key in the index. Obviously there is a chance of hash collisions, so what is the best way of reducing that risk? If I also calculate the (e.g.) MD-5 hash of the block, and use the combination (SHA-256, MD-5) as the key, is the chance of a collision about the same as some 384-bit hash function, or is it a little bit better because I'm using different hash functions?  

Thanks for the info!  

Edit: My blocks come from normal user data on hard drives, but it will be many petabytes in total.  

Edit2: As a follow-up (just tell me if this should be moved to a different question): Since the blocks can vary in size but can be up to some preconfigured limit (e.g. 1MiB), how will collision resistance be affected if I make the (64-bit) size of the block part of the key? That way you can only have collisions of blocks with the same size...  

#### Answer 2 (score 83)
The risk of collision is only theoretical; it will not happen in practice. Time spent worrying about such a risk of collision is <a href="https://stackoverflow.com/questions/4014090/is-it-safe-to-ignore-the-possibility-of-sha-collisions-in-practice/4014407#4014407">time wasted</a>. Consider that even if you have $2^{90}$ 1MB blocks (that's a billion of billions of billions of blocks -- stored on 1TB hard disks, the disks would make a pile as large of the USA and several kilometers high), risks of having a collision are lower than $2^{-76}$. On the other hand, the risks of being mauled by a gorilla escaped from a zoo are at least $2^{-60}$ per day, i.e. 65000 times more probable than the SHA-256 collision over way more blocks than possibly makes sense. Stated otherwise, before hitting a single collision, you can expect the visit from 65000 successive murderous gorillas. So if you know what's good for you, drop that MD5 and go buy a shotgun.  

<img src="https://i.stack.imgur.com/46Vwb.jpg" alt="SHA-256 collisions are not scary; gorillas are.">  

Now for the suggestion of concatenating the outputs of two distinct hash functions, say SHA-256 and MD5. It turns out that this does not enhance security as much as one could believe. The total size of 384 bits would certainly not provide <em>more</em> security against collisions that what a 384-bit hash function would give; but it actually is much weaker than that: it would not be really much stronger than SHA-256 alone. See <a href="https://crypto.stackexchange.com/questions/270/guarding-against-cryptanalytic-breakthroughs-combining-multiple-hash-functions">this previous question</a>, and <a href="http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.99.9368" rel="noreferrer">this research article</a> for the gory details. This can be summed up as follows: when using several hash functions in parallel and concatenating the outputs, the total is not stronger against collisions than the strongest of the individual functions.  

And, of course, MD5 itself is <a href="http://en.wikipedia.org/wiki/MD5#Collision_vulnerabilities" rel="noreferrer">weak against collisions</a> and as such should not be envisioned for newer designs.  

#### Answer 3 (score 13)
<blockquote>
  The risk of collision is only theoretical; it will not happen in practice.  
</blockquote>

Except in one particular instance.  The description given implies that this system is going to be some form of de-duplicating filesystem or backup system.  For most users, the collision risk is tiny.  

But, for one particular class of users, there is a much larger risk.  Those users are cryptographic hash researchers for whom one could presume that hash collisions within their HD's data content are more likely than the average joe, simply because they are attempting to manufacture such collisions.  

Therefore, if this is to be a de-duplicating filesystem or backup system, and a cryptographic hash researcher makes use of it, the risk of two different data blocks having a colliding hash is larger than for the average joe.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How does DES decryption work? Is it the same as encryption or the reverse? (score [32091](https://stackoverflow.com/q/9674) in 2013)

#### Question
If DES decryption is the same as encryption done in reverse order, then how can the reversed S-Box convert 4 bits into 6 bits?  

#### Answer 2 (score 6)
DES is based on a Feistel construction - while the one-way function used is.. well.. one-way, you don't need to reverse it at all to "decrypt" (otherwise you are correct we would have a problem). Look at <a href="http://en.wikipedia.org/wiki/Feistel_cipher#Construction_details" rel="noreferrer">this diagram</a>, specifically the decryption one:  

<blockquote>
  <img src="https://i.stack.imgur.com/GH4Sz.png" alt="enter image description here">  
</blockquote>

As you can see, even though one half of the ciphertext is passed through the one-way function, there's always a copy of it remaining. In this case, $L_{n + 1}$ goes through the one-way function to mask $R_{n + 1}$, but still becomes one half of the ciphertext, which lets you use it again during decryption to undo the XOR operation you used to mask the other half of the ciphertext.  

Then you keep doing that for each round (using the round keys in reverse) and you end up with the plaintext. No information is lost during the encryption process, the one-way function is simply used to mask each half in turn in an interleaved fashion (which can be done again during decryption in the opposite direction, but only if you have the key).  

Ultimately decryption is very similar to encryption, a common feature of Feistel ciphers in general. In fact with some arrangements the only difference is the order of the subkeys, which is (or at least was) a big advantage as it makes implementation easier on limited devices, as you can mostly reuse the encryption code for decryption.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Does the IV need to be known by AES (CBC mode)? (score [31885](https://stackoverflow.com/q/7935) in )

#### Question
I was thinking about this today and thought I should ask. I think I understand IV's enough to say that they are basically the same thing as Salts when talking about hashes. They are there to improve randomness between messages. If the IV is simple appended, or prepended to the plain text, why does AES need to know the IV to decrypt it? Can't it just decrypt it, drop the first x amount of bytes and then it has the original plaintext or does AES do some special jizz-jazz with the first bytes in the stream?  

#### Answer accepted (score 17)
The initialization vector is XORed against the first plaintext block before encryption in CBC mode, as shown in the <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher-block_chaining_.28CBC.29">Wikipedia article</a> on block cipher modes. After the first block is decrypted, you still have an intermediate value which has been XORed with the plaintext — without this, you have little hope of recovering the plaintext. However, you do not need the IV to decrypt subsequent blocks.  

You could perform CBC in a way that would remove the need to know the initialization vector (note: this is not recommended or encouraged, just pointing it out for the novelty). If you use a null IV and use a random value for the first block of plaintext, you can discard this value and only transmit the ciphertext. Note that this actually gains you nothing, because now the ciphertext is one whole block longer!  

#### Answer 2 (score -1)
<p>I agree. For my purposes I've been prepending the plaintext with a block
of random data so that when the receiver decrypts they simply discard the
first block as it was only there to ensure the ciphertext always changes even
if the plaintext payload was the same (not counting the first random block). 
This seems to achieve what the initialization vector was doing from the 
beginning without the need to send the initialization vector with the 
ciphertext. IE it can be ignored. </p>

It is recommended that an Initialization vector be random and used only once meaning it will some how need to be send to the receiver which seems identical to the proposal of generating a random first block of plaintext and discarding it after decryption.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How do ciphers change plaintext into numeric digits for computing? (score [31044](https://stackoverflow.com/q/3617) in 2012)

#### Question
For example, in RSA, we use this for encryption: $ciphertext = (m^e \mod n)$  and for decryption.  

If our message is `"hello world"`, then what number do we have to put as $m$ in the RSA formula?  

#### Answer 2 (score 9)
Say you want to encrypt "Hello World!" with RSA.  

<p>The first important thing here is the encoding of that text. "Hello World!" as such cannot be encrypted since characters are a non-numerical concept.
So an encoding is used convert the characters of that text to numeric values (e.g. the ASCII / Unicode table, but there are many others, especially for non-latin characters). Using Unicode-8, "Hello World" turns into this sequence of bytes (hex-notation):</p>

```cryptography
48 65 6C 6C 6F 20 57 6F 72 6C 64
```

Such a sequence of bytes can then be interpreted as a number by assigning a most-significant and least-significant byte (e.g. the more left-sided, the more significant). That sequence would then equal the number  

```cryptography
0x48656C6C6F20576F726C64 or 87521618088882538408046480
```

But since such a small number would not produce a secure ciphertext (as @SEJPM already said), a <a href="https://en.wikipedia.org/wiki/Padding_(cryptography)">padding</a> is applied. The sequence of bytes then might look something like this:  

```cryptography
01 48 65 6C 6C 6F 20 57 6F 72 6C 64 98 9C 38 83 E1 64 E7 0B BC F2 43 C0 6B
26 D4 5E AC 9B C9 DC 2F 1B 87 46 3D 2E 6F 86 66 5E 1B CB 44 DA 5A 50 79 2F
40 79 88 83 84 3E 16 9D 7F 1F 05 2C DF F2 9B 9B 07 11 F6 7A CB 1C 35 9B 76
BD 8D 46 1C E0 09 2A 9F C5 B8 A9 FB 61 41 ... up to the bitsize of N
```

That sequence is then interpreted as a number and shoved through the algorithm.  

#### Answer 3 (score 7)
<blockquote>
  …what number do we have to put as $m$ in the RSA formula?  
</blockquote>

There are three possibilities what $m$ can be.  

<ol>
<li>A full-sized random bit-sequence, e.g. a random sort-of-key which is roughly as large as the modulus and will be used to derive a symmetric key for message encryption.</li>
<li>Some padded message. This would mean you'd first apply some padding to your message, e.g. <a href="https://en.wikipedia.org/wiki/Optimal_asymmetric_encryption_padding" rel="nofollow">OAEP</a>, and then apply the RSA primitive to it. The message in this case is really any long bit string you want to send over. This can be some binary computation data, or it can be an ASCII-encoded, `\0` terminated string, whatever suits your needs.</li>
<li>(not recommended) Some unpadded message. This would skip the padding stage and directly apply the RSA primitive to your message. <strong>This is highly dangerous and should not be done in a production setting as really basic attacks can recover the plaintext.</strong></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: Number of keys when using symmetric and asymmetric encryption? (score [30931](https://stackoverflow.com/q/16075) in 2015)

#### Question
Quoting part of my homework/assignment:  

<blockquote>
  How many keys are required for secure communication among 1000 person if:   
  
  <ol>
  <li>Symmetric key encryption algorithm is used?</li>
  <li>Asymmetric key encryption algorithm is used?</li>
  </ol>
</blockquote>

My guess:  

For symmetric they each need to maintain and transfer their own key, so probably $1000 \times 1000$, and for asymmetric maybe just $2000$, each having one public one private.   

Is that correct?  

#### Answer 2 (score 3)
For the symmetric key, you can approach this problem as a complete graph with order 1000. With the vertexes representing people and the edges representing the symmetric keys. Then each vertex would have degree 999 and, applying the Handshaking lemma, the number of edges would be:  

$(1000 \times 999)/2 = 499500$  

So they would need 499500 symmetric keys to have a secure communication between all of them.  

For the asymmetric keys, each one would have 2 keys, so a total of 2000 keys.  

#### Answer 3 (score 1)
For a homework question you are probably correct. If the keys are distributed in a secure way that should be the minimum amount of keys for persons to communicate without them being able to read each others messages, if those messages can be intercepted.  

Practical protocols could use more or less static keys, it all depends on the requirements, attack vectors etc..  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: How can Cipher Block Chaining (CBC) in SSL be attacked? (score [30920](https://stackoverflow.com/q/1078) in 2013)

#### Question
I am trying to understand how CBC-mode in SSL/TLS can be attacked.  

I have been looking around online but all examples and explanations are very hard to understand and follow. Can you give a simple explanation for how such attacks happen?  

#### Answer 2 (score 25)
The recently demonstrated attack against SSL (<a href="http://vnhacker.blogspot.com/2011/09/beast.html" rel="nofollow noreferrer">BEAST</a>) was an IV misuse attack and not really the same thing as what happened to <a href="https://crypto.stackexchange.com/q/1066/58">XML Encryption</a>. Nonetheless, here is what happened with SSL.  

Basically they found two things:  

<ol>
<li>A way to get the browser to encrypt data under the session key used by an existing SSL connection and</li>
<li>A mistake in the way SSL was written that allowed that ability to be leveraged to read messages.</li>
</ol>

Let's says you are using AES with CBC mode. Encryption for the first block of a message is basically $AES(K, IV \oplus m)$. The IV is typically sent along with the ciphertext.  This is a simplification ignoring how longer messages are handled, see <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher-block_chaining_.28CBC.29" rel="nofollow noreferrer">Wikipedia's CBC article</a> for more details, but it works for this purpose.  

The point of this is that multiple encryptions of the same thing don't result in the same cipher text because the IV is random and `data XOR random = random`, so you never actually encrypt the same message. Thus an attacker who can cause the browser to encrypt data can't simply guess at what the message was and verify that guess by causing the browser to encrypt the guess and checking if it matches the encrypted message they want to read.  

Well the problem is, if I know the IV in advance, this no longer holds: If I want to guess that some previous message was "attack at dawn" (with IV $IV_1$) and I know the IV for the next message will be  $IV_2$, then I merely need to cause the browser to encrypt  a message $m$ such that  $IV_1 \oplus \text{"attack at dawn"} = IV_2 \oplus m$, and check if the ciphertext blocks match.  

SSL used the last 128 bits of the previous encrypted message as the IV. Because there was time between when this message was sent and the next, the attacker could make a guess.  

This is a basic overview, there still some details of how you do this efficiently to get the session cookie sent with each HTTP request, but that's the gist of it.   

This attack is not possible with TLS 1.1 and 1.2 (as they generate a new initialization vector for each message), and the OpenSSL library worked around this problem already in TLS 1.0 by sending an empty message (i.e. only padding and MAC) directly before each real message, so the ciphertext of this empty message is used as initialization vector for the real one (and this is not predictable without knowing the key). (Edit: it turns out this feature is disabled in OpenSSL because it breaks large numbers of servers who assume a zero byte read  is an end of file. Instead, the deployed fix is "1/n-1 record splitting" where one byte is sent in a block and the rest of the message is in the next block)  

#### Answer 3 (score 3)
CBC isn't an attack,  is a <a href="http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation" rel="nofollow">block cipher mode of operation</a>.   You're probably thinking of the "<a href="http://www.usenix.org/event/woot10/tech/full_papers/Rizzo.pdf" rel="nofollow">padding oracle</a>" attack.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Why is HMAC-SHA1 still considered secure? (score [30764](https://stackoverflow.com/q/26510) in 2017)

#### Question
This Q &amp; A <a href="https://security.stackexchange.com/questions/33123/hotp-with-as-hmac-hashing-algoritme-a-hash-from-the-sha-2-family">https://security.stackexchange.com/questions/33123/hotp-with-as-hmac-hashing-algoritme-a-hash-from-the-sha-2-family</a>  

says that the security of HMAC-SHA1 does not depend on resistance to collisions? Are they are saying specifically with respect to HOTP or for HMAC-SHA1 for any use?     

If HMAC-SHA1 is used for verifying the integrity of a document and you can find a collision, you can make changes in the document, right?    

<a href="http://tools.ietf.org/html/rfc2104#section-6" rel="noreferrer">http://tools.ietf.org/html/rfc2104#section-6</a>  

Even the RFC says that resistance to collisions is relevant    

<blockquote>
  The security of the message authentication mechanism presented here depends on cryptographic properties of the hash function H: <strong>the resistance to collision finding</strong> (limited to the case where the initial value is secret and random, and where the output of the function is not explicitly available to the attacker), and the message authentication property of the compression function of H when applied to single blocks   
</blockquote>

What am I missing here?  

#### Answer accepted (score 24)
In the first section of this answer I'll assume that through better hardware or/and algorithmic improvements, it has become routinely feasible to exhibit a collision for SHA-1 by a method similar to that of <a href="http://www.c4i.org/erehwon/shanote.pdf" rel="noreferrer">Xiaoyun Wang, Yiqun Lisa Yin, and Hongbo Yu's attack</a>, or <a href="http://2012.sharcs.org/slides/stevens.pdf" rel="noreferrer">Marc Stevens's attack</a>. This has been <a href="https://shattered.io/" rel="noreferrer">achieved publicly</a> in early 2017, and had been clearly feasible (the effort represents mere hours of the <a href="https://blockchain.info/en/charts/hash-rate?showDataPoints=false&amp;timespan=2year&amp;show_header=true&amp;daysAverageString=7&amp;scale=1&amp;address=" rel="noreferrer">hashing effort spent on bitcoin mining</a>; but the hardware used for that can't be re-purposed for the attack on SHA-1).  

Contrary to what is considered in the question, that would <em>not</em> allow an attacker <em>not kowing the HMAC-SHA-1 key</em> to make an undetected change in a document; that's including if the attacker is able to prepare the document s/he's willing to later alter.  

One explanation is that the collision attacks on SHA-1 we are considering require knowledge of the state of the SHA-1 chaining variable, and the attacker of HMAC not knowing the key is deprived from that knowledge by the key entering on both extremities of the iteration of rounds in which the message stands in HMAC. A much deeper break of SHA-1's round function would be needed to break HMAC. Not coincidentally, M. Bellare's <a href="https://cseweb.ucsd.edu/~mihir/papers/hmac-new.html" rel="noreferrer"><em>New Proofs for NMAC and HMAC: Security without Collision-Resistance</em></a> shows that security of HMAC holds assuming only weaker properties on its round function than needed for collision resistance of the corresponding hash.  

What would be possible is for an attacker <em>knowing the HMAC key</em> to prepare a document that s/he willing to later alter, that can be altered without changing the MAC. But since the attacker is holding the HMAC key, that's not considered a break of HMAC.  

<hr>

A <a href="https://crypto.stackexchange.com/q/26510/555#comment61538_26518">comment</a> asks <em>when should SHA-1 not be used?</em>  

It is advisable to quickly phase out SHA-1 in applications requiring collision-resistance (as an image: quickly walk away, as you exit a building which fire alarm rings when there's no smoke). That includes hashing for integrity check or digital signature of documents prepared by others even in part (which is, most documents). If continuing to use SHA-1 has strong operational benefits, it can safely be made an exception by inserting something unpredictable by adversaries before any portion of the message that an adversary can influence. For example, by enforcing an unpredictable certificate serial number at time of request of a certificate, a certification authority could still safely issue certificates using SHA-1 for their internal signature.  

As explained in the first section of this answer, as long as the key of HMAC-SHA-1 is assumed secret, there is no indication that HMAC-SHA-1 is insecure because it uses SHA-1. If the key is assumed public, or its leak is considered an operational possibility where it is still wanted collision-resistance for HMAC including for message prepared after disclosure of the key, then the precautions discussed in the previous paragraph apply.  

#### Answer 2 (score 14)
When people say HMAC-MD5 or HMAC-SHA1 are still secure, they mean that they're still secure as PRF and MAC.  

The key assumption here is that the key is unknown to the attacker.  

$$\mathrm{HMAC} = \mathrm{hash}(k_2 | \mathrm{hash}(k_1 | m)) $$  

<ul>
<li><p>Potential attack 1: Find a universal collision, that's valid for many keys:</p>

Using HMAC the message doesn't get hashed directly, but it has $k_1$ as prefix. This means that the attacker doesn't know the internal state of the hash when the message starts. Finding a message that collides for most choices is $k_1$ is extremely hard<sup>1</sup>.  </li>
<li><p>Potential attack 2: Recover the key</p>

For this to succeed the hash function needs much bigger breaks than merely collisions. It's similar to a first pre-image attack, a property that's still going strong for both MD5 and SHA1.   </li>
</ul>

On the other hand, if you used a key known to the attacker and the attacker has the ability to find collisions in the underlying hash (for arbitrary IVs), these turn into collisions of HMAC. So if you need security in an unkeyed scenario, use a collision resistant hash, like SHA2 and consider not using HMAC at all.  

<hr>

<sup>1</sup> I suspects it's not possible (for realistic message sizes) even for computationally unbounded attackers, but proving that is difficult.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Is PKCS7 a signature format or a certificate format? (score [30697](https://stackoverflow.com/q/37084) in 2017)

#### Question
I always though PKCS7 was a signature format.    

However, on the net I find several references to PKCS7 being a certificate format - for example, this talks about PKCS7 certificate: <a href="https://stackoverflow.com/questions/14809754/extract-raw-certificate-from-pkcs7-file-in-java">Extract raw certificate from PKCS#7 file in JAVA</a>   

Or: <a href="https://security.stackexchange.com/questions/73156/whats-the-difference-between-x-509-and-pkcs7-certificate">What's the difference between X.509 and PKCS#7 Certificate?</a>  

So is PKCS7 a signature format or a certificate format or both?  

#### Answer 2 (score 7)
<blockquote>
  So is PKCS7 a signature format or a certificate format or both?  
</blockquote>

Neither. PKCS7 is now <a href="https://tools.ietf.org/html/rfc5652" rel="nofollow noreferrer">Cryptographic Message Syntax(CMS)</a>. From the RFC 5652:  

<blockquote>
  <p>This
     syntax is used to digitally sign, digest, authenticate, or encrypt
     arbitrary message content.</p>
</blockquote>

CMS enables interoperability between different products which can operate on the same document without knowing anything about other product (implementation and such other specific info related to the product). CMS achieves this by defining specific message formats for each data type (signed data, enveloped data, authenticated enveloped data). Hence, each product which support CMS format can exchange files or messages defined in the CMS format with no trouble.  

The second link you provided also talks about CMS format.  

<hr>

After comments from @Maarten:  

It is also worth to mention that <a href="https://en.wikipedia.org/wiki/PKCS" rel="nofollow noreferrer">PKCS</a> stands for "Public Key Cryptography Standards". These are a set of public key cryptography standards created by RSA Security Inc. Some of these standards handed over to standards organizations and they became industry standards after that.  

Also, as @Maarten mentions, using CMS(PKCS7) format enables storing more than one certificate. (<a href="https://security.stackexchange.com/a/73201/97892">Check this answer</a>)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: How can I use asymmetric encryption, such as RSA, to encrypt an arbitrary length of plaintext? (score [30658](https://stackoverflow.com/q/14) in 2015)

#### Question
RSA is not designed to be used on long blocks of plaintext like a block cipher, but I need to use it to send a large (encrypted) message.  

How can I do this?  

#### Answer accepted (score 61)
The solution to this problem is to use <em>hybrid encryption</em>. Namely, this involves using RSA to asymmetrically encrypt a symmetric key.  

Randomly generate a symmetric encryption (say AES) key and encrypt the plaintext message with it. Then, encrypt the symmetric key with RSA. Transmit both the symmetrically encrypted text as well as the asymmetrically encrypted symmetric key.  

The receiver can then decrypt the RSA block, which will yield the symmetric key, allowing the symmetrically encrypted text to be decrypted.  

This can be shown more formally as the following. Let $M$ be the plaintext, $K_{AES}$ be the randomly chosen AES key, and $K_{Pu}$ be the receiver's public RSA key you already have.  

<p>$$ C_1 = E_{AES}(M, K_{AES}) $$
  $$ C_2 = E_{RSA}(K_{AES}, K_{Pu}) $$</p>

Then, send both $C_1$ and $C_2$.  

Let $K_{Pr}$ be the receiver's private RSA key. The receiver can then recover $M$ as  

<p>$$ K_{AES} = D_{RSA}(C_2, K_{Pr}) $$
  $$ M = D_{AES}(C_1, K_{AES}) $$</p>

(To allow streaming decryption or large messages, you would usually send $C_2$ first and then (the much larger) $C_1$.)  

#### Answer 2 (score 38)
Theoretically you <em>can</em> do encryption of long messages with RSA, in the same way that you can encrypt a long message with a block cipher. This requires an appropriate chaining mode, e.g. CBC: each plaintext "block" is first XORed with (part of) the encrypted previous block.  

With RSA and proper padding, there is a per-block size overhead. Namely, with the "v1.5" padding described in <a href="http://www.rsa.com/rsalabs/node.asp?id=2125">PKCS#1</a>, and a 1024-bit RSA key, each RSA invocation can encrypt a message up to 117 bytes, and results in a 128-byte value. Hence, in order to apply CBC chaining, you would have to "extract" a part of the previous 128-byte value of the appropriate size. Things can become subtle, security-wise, at that point, because CBC relies on encrypted blocks being good at "randomizing" data, and nothing proves that the 128 bytes will look sufficiently random from the outside (actually, there are good reasons why the first bytes will <em>not</em> be random enough).  

(If you do not use a proper padding, then you already have bigger problems. RSA without its padding is no longer RSA, and, more importantly, is no longer secure.)  

Nobody in their right frame of mind does such RSA-with-CBC encryption. Among the reasons are:  

<ul>
<li>the construction has not received sufficient scrutiny to be deemed secure;</li>
<li>the size overhead implies that the encrypted message will be about 9.4% longer than the plaintext message;</li>
<li>RSA encryption is not very fast (a modern CPU would still succeed in encrypting, say, 2 MBytes worth of data per second that way).</li>
</ul>

This last reason is the most often quoted, but, in my opinion, the least compelling of the three.  

In practice, everybody uses RSA encryption as a key exchange mechanism, to be used with a fast, secure symmetric encryption system, as @samoz describes. This has been much more analyzed (hence it is believed to be a secure way of doing things), it enlarges data by only a fixed amount (a few hundred bytes at most, even if encrypting gigabytes), and is much faster, too.  

#### Answer 3 (score 6)
<blockquote>
  [...] but I need to use it to send a large message.  
</blockquote>

The short answer to this is "no you don't" unless it's for some silly class assignment or something.  As @Samoz's answer indicates, there are ways asymmetric encryption can be forced into being a streaming cipher, but the disadvantages are deal-killing.  

In particular,   

<ul>
<li>it's not standard and is going to be an idiosyncratic scheme only you use,</li>
<li>using asymmetric encryption exposes weaknesses in the ciphers themselves,</li>
<li>it forces you to manage very large numbers of very large keys.</li>
</ul>

By comparison, well-known streaming ciphers, like AES, are computationally efficient, require much smaller keys and fewer of them, are more robust under operator mistakes, and are standard.  

Basically, one of the mistakes slightly less egregious than involvement in a land war in Asia is trying to do tricky things with existing encryption algorithms.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: What size of initialization vector (IV) is needed for AES encryption? (score [30423](https://stackoverflow.com/q/50782) in 2017)

#### Question
<p>What size of initialization vector (IV) is needed for AES encryption? 
I am using either CBC or CFB modes.</p>

Knowing that AES is a sysmmetrical block-cipher algorithm with a 128-bit block size, I think the answer for IV is still 16 bytes or 128 bits for AES 128, 192 and 256.   

Reading <a href="https://stackoverflow.com/questions/31132162/what-size-of-initialization-vector-needed-for-aes256-encryption-in-java">this stackoverflow Q&amp;A</a> it seems as if the size of the IV is the size of the block which is always 128 bit (= 16 bytes) in AES, even if the keysize is larger than the block size. Is that correct?  

#### Answer 2 (score 12)
For both CBC mode and CFB mode, the initialization vector is the size of a block, which for AES is 16 bytes = 128 bits.  For <a href="https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#CFB" rel="noreferrer">CFB mode</a>, the IV must never be reused for different messages under the same key; for <a href="https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#CBC" rel="noreferrer">CBC mode</a>, the IV must never be reused for different messages under the same key, <em>and</em> must be unpredictable in advance by an attacker.  Using successive integers as the IV is fine for CFB but not fine for CBC.  

Beware: The Wikipedia articles are currently (2017-08-11) full of archaic drivel about self-synchronizing ciphers and error propagation and other fortunately forgotten relics of the dark ages of crypto engineering from a bygone century.  I cite them <em>only</em> for the easily accessible statements of equations relating plaintext and ciphertext and their associated diagrams.  

All that said, could I interest you in an <a href="https://en.wikipedia.org/wiki/Authenticated_encryption" rel="noreferrer">authenticated encryption</a> scheme instead, such as <a href="https://nacl.cr.yp.to/secretbox.html" rel="noreferrer">NaCl `crypto_secretbox_xsalsa20poly1305`</a>?  Or, if you find yourself reaching for the letters ‘AES’ and ‘CBC’, you're probably lost in a vat of acronym soup and you may need help navigating crypto protocols more than you need help picking the right parameter sizes for a confusing crypto API that asks you to choose mode and then specify IV.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: PBKDF2 and salt (score [30405](https://stackoverflow.com/q/3484) in 2012)

#### Question
I want to ask some questions about the <a href="https://en.wikipedia.org/wiki/PBKDF2">PBKDF2</a> function and generally about the password-based derivation functions.  

Actually we use the derivation function together with the salt to provide resistance against the dictionary attacks, right? One example is the UNIX encryption scheme.  

My first question:<br/>For example, if want to encrypt a piece of data in a card and I use the password to derive a new key using the PBKDF2 function, usually the salt is stored unencrypted, right?  

But if an attacker get access to the card and find the salt then the only security we have is the password again, isnt it? So, why do we store the salt in the clear? I know that it makes it harder for dictionary attacks, but if someone gets access to the card, then we are in the first where the only precaution is the length of the password, right?  

Also, we have the same scenario:<br/>We have the password and we want to generate a new key and we use the PBKDF2 or any other function(I know it has the HMAC as generator). Until now, I didn't find anywhere explaining whether the result of the function, <em>the actual key</em> is stored or not?  

Also, given the password, how do we know whether the password is the right one, in order to derive the actual key?  

#### Answer 2 (score 13)
First, realize that PBKDF2 is PKCS #5 is RFC 2898, i.e. <a href="http://www.ietf.org/rfc/rfc2898.txt">http://www.ietf.org/rfc/rfc2898.txt</a>    

It's essentially an algorithm to securely hash a password as many times as you want, with whatever hash you want.  OWASP recommends hashing the password at least 64,000 times in 2012, and doubling that every two years, per <a href="https://www.owasp.org/index.php/Password_Storage_Cheat_Sheet">https://www.owasp.org/index.php/Password_Storage_Cheat_Sheet</a>  

Note that storing (also in cleartext) a variable number of iterations per user also helps.  Instead of always running PBKDF2 64,000 time, instead generate a random salt, <em>and</em> a random number I between 1 and 20,000.  Run PBKDF2 64,000 + I times for that particular username.  This makes cracking it just a little more difficult, and may prevent certain optimizations in cracking code from being useful.  

<blockquote>
  Actually we use the derivation function together with the salt to provide resistance against the dictionary attacks, RIGHT?   
</blockquote>

Essentially - we salt the cleartext passphrase prior to hashing it.  

<blockquote>
  My first question : ... usually the salt is stored un-encrypted, right?   
</blockquote>

In simpler implementations, a long (8 bytes or more), cryptographically random salt is stored unencrypted and regenerated with every password change.  OWASP (link above) recommends additional precautions including having an additional salt stored in a config file somewhere (i.e. not stored in the database), another portion hardcoded in the source code, and storing the per-user salt in a different location than the password, perhaps a flat file vs. a database (or vice versa).  Note this ideally also requires passwords and salts be backed up to different locations as well - the goal is to make it harder to steal both salts and passwords with one theft.  

<blockquote>
  Also, we have the same scenario : we have the password and we want to generate a new key ... Until now, I didnt find anywhere explaining if the result of the function (the actual key( it is stored or not?  
</blockquote>

That depends.  If you're using PBKDF2 to generate a key for realtime encryption during this session only, then no, it should stay in memory only, and be discarded at the end.  If you're using PBKDF2 to generate a hash (after N iterations) to authenticate a user later, then you must save that hash.  

<blockquote>
  I know is make it harder for dictionary attacks but if someone get access to the card i store it then we are in the first where the only precaution is the length of the password right  
</blockquote>

No, the only precaution is the <em>strength</em> of the password.  "P@ssw0rdP@ssw0rdP@ssw0rd" is a bad password, even if it is 24 characters long and "complex".  If you're going to be "registering" users, or letting them choose passwords, you need to reject any password in the most common cracking dictionaries.  Further, when you're testing for rejection, you need to apply the same kind of rules that rules based dictionary crackers like Elcomsoft or Hashcat use - translate to 1337 speak, add 1 to 1000 after it, add random characters to the front and back, double it, etc.  This is thankfully easier on the front end, since you can simply reverse-translate 1337 speak and lowercase it, so both P@ssw0rd and Passw0rd end up as "password", which should be filtered out as horrible.  Melinda2006 is always a bad password, as is 12345.  

<blockquote>
  Also, given the password how do we know if the password is the right password in order to derive the actual key?  
</blockquote>

<p>You don't know beforehand; you just try it.  If it works, it was right.  If it doesn't work, it was wrong.  Now, by "works", again, it depends.
For realtime decryption, you'd attempt to decrypt the message; you would then compare the HMAC you saved with the message (prior to encryption) with the values; if the HMAC doesn't match, it's a forgery, part of the message was altered, you have a bug, or the password was wrong.
For authentication, you collect the salt value that should have been used, and then re-hash the password the same number of times.  If you get the same hashed result, the input must have been the same, and so it was right.</p>

#### Answer 3 (score 5)
Password based key derivation functions generate a key suitable for ciphers from a given password. It relies only on the original password being kept secret.   

The purpose of the salt is simply to prevent the use of rainbow tables. A rainbow table would have to be made for each salt, and if (as is common practise), each user has their own salt, a rainbow table would have to be constructed for that particular user. In general it is not assumed to be secret.  

Salts are used in conjunction with a higher number of iterations inside the PBKDF function to hinder any attempt to create a rainbow table.  

<blockquote>
  The key derived from the PBKDF2 is stored somewhere  
</blockquote>

I think maybe you've confused a cryptographic hash of a password that is stored for authentication and PBKDF (which can use an underlying cryptographic hash) to 'stretch a password' for use in encryption.   

The generated key should not be stored anywhere (unless itself suitably encrypted). The generated key is used for encryption. When the data is to be decrypted, the user should be prompted for the password, and the key is generated again. This generated key is then used to decrypt the data.  

<blockquote>
  How do we know that the password we gave is the right one in order to perform the PBKDF2 function?  
</blockquote>

When encrypting data you should also be including message authentication (MAC). This generally means encrypting `message || MAC`. You would decrypt the data using a (potentially false) key. And then check to see if the MAC and message correspond. If they don't, either the key was false or otherwise the ciphertext has been tampered with.   

Alternatively you could hash the password. Though a PBKDF can be used for this, it should be clear that a different salt must be used (even if you don't use the same algorithm).This hash is stored. When the user enters their password you hash it, and check it with the stored hash, if they match you proceed to generate the encryption key, and decrypt the data.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Google is using RC4, but isn't RC4 considered unsafe? (score [30038](https://stackoverflow.com/q/853) in 2011)

#### Question
Why is Google using RC4 for their HTTPS/SSL?  

```cryptography
$ openssl s_client -connect www.google.com:443 | grep "Cipher is"
New, TLSv1/SSLv3, Cipher is RC4-SHA
```

Isn't RC4 unsafe to use?  

#### Answer 2 (score 46)
Academically speaking, RC4 is terrible; it has easy distinguishers ("easy" means "can really be demonstrated in lab conditions"). It is also hard to use properly. However, SSL/TLS uses RC4 correctly, and <strong>in practice</strong> the shortcomings of RC4 have no real importance.  

The power-that-be at Google decided to switch to RC4 by default because of the recent "BEAST" attack, which demonstrates (again, in lab conditions) a compromise of a Paypal cookie. There is no such dramatic demonstration for an attack on RC4 <em>as used in SSL</em>, so it was estimated that using AES-CBC with SSL/TLS 1.0 was "more risky" than using RC4.  

The academically "right thing" to do would be to use AES-CBC with TLS <strong>1.1</strong> (or any ulterior version), which has no problem with BEAST and none of the RC4-related weaknesses either. However, Google makes money in the real world, and, as such, they cannot enforce a configuration which would prevent a third of their user base from connecting.  

#### Answer 3 (score 14)
Wikipedia has a decent writeup on the <a href="http://en.wikipedia.org/wiki/RC4#Security" rel="nofollow">known attacks on RC4</a>. Most of them are from biases of the output. To give you an idea of the severity of the attacks see the following quotes from the Wikipedia page:  

<blockquote>
  The best such attack is due to Itsik Mantin and Adi Shamir who showed that the second output byte of the cipher was biased toward zero with probability 1/128 (instead of 1/256).  
</blockquote>

There is also this:  

<blockquote>
  Souradyuti Paul and Bart Preneel of COSIC showed that the first and the second bytes of the RC4 were also biased. The number of required samples to detect this bias is $2^{25}$ bytes.  
</blockquote>

The following bias in RC4 was used to attack WEP:  

<blockquote>
  ...over all possible RC4 keys, the statistics for the first few bytes of output keystream are strongly non-random, leaking information about the key. If the long-term key and nonce are simply concatenated to generate the RC4 key, this long-term key can be discovered by analysing a large number of messages encrypted with this key.  
</blockquote>

As far as I know, however, SSL/TLS does not use a long-term key with a nonce. It establishes a new key every connection (and even refreshes the key after some period of time).  

The take away point is, RC4 has shown some weaknesses that have actually been exploited to attack real-world system under certain configurations. But, no one has shown if/how these weaknesses affect SSL/TLS. If you are worried about it, however, I believe SSL/TLS has a cipher negotiation phase, so there is probably a way to force connections to not be able to use RC4. This could open you up to <a href="http://www.schneier.com/blog/archives/2011/09/man-in-the-midd_4.html" rel="nofollow">other attacks</a> though.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: What makes RSA secure by using prime numbers? (score [29427](https://stackoverflow.com/q/10590) in 2013)

#### Question
I am just learning about the RSA algorithm. Looking at the first two steps:  

<ol>
<li>Choose two distinct prime numbers $p$ and $q$.</li>
<li>Compute $n = pq$. </li>
</ol>

I have some probably stupid questions:  

<ul>
<li>Why do $p$ and $q$ have to be prime numbers? Why couldn't they be any integers or odd integers? Or does that break the whole algorithm?</li>
<li>Because prime numbers are rare in comparison to regular integers, does restricting the algorithm to only prime numbers reduce security? It would seem easier to find the private key if an attacker knows it's only going to be some prime number?</li>
</ul>

#### Answer accepted (score 11)
In order to generate a RSA key pair, you are to find a public exponent $e$ and a private exponent $d$ such that, for all $m \in \mathbb Z_n^*$, i.e. $m$ is relatively prime to $n$, $(m^e)^d \equiv m \pmod n$. It is a consequence of <a href="http://en.wikipedia.org/wiki/Euler%27s_theorem">Euler's theorem</a> that if $e, d$ satisfy the equation $ed \equiv 1 \pmod {\phi(n)}$, they are such a valid public/private exponent pair.   

<a href="http://en.wikipedia.org/wiki/Fundamental_theorem_of_arithmetic">The fundamental theorem of arithmetic</a> says that every integer has a factorization into powers of prime numbers that is unique to the integer, save for the order of the factors.   

The definition of <a href="http://en.wikipedia.org/wiki/Euler%27s_totient_function">Euler's $\phi$ function</a> is that $\phi(n)$ equals the number of integers less than $n$ and relatively prime to $n$. In order to determine this number, you have to know the factorization of $n$.  

Consequently, if you select a number $n = pq$ where $p, q$ are both prime, you will have selected a number you can factor, but, if it is large enough, no one else can factor. The reason for this is because, using known factorization algorithms for arbitrary integers, the running time of such algorithms depends on the relative size of the second largest prime factor of the input. This means that given the public exponent $e$ only you can determine the private exponent $d$.  

(<strong>Note:</strong> The hardness of performing the RSA private key operation $m \equiv c^d \mod n$ given only the public key $e, n$ as above, is known as <a href="http://en.wikipedia.org/wiki/RSA_problem">the RSA problem</a>, which hasn't been proved to be as hard as factoring the modulus. The best known method is however by factoring the modulus $n$ in order to determine $d$ given $e$.)  

It also means that if you were to select $p, q$ just as odd integers, you would make it harder for yourself to find $\phi(n)$, while at the same time decreasing the relative size of the second largest prime factor, and thereby making it easier for everyone else to factor $n$. In fact, it would be as hard for you to factor $n$ as it would be for everyone else, so you would completely loose the <a href="http://en.wikipedia.org/wiki/Trapdoor_function">trapdoor</a> component of your scheme (if not making it completely infeasible to find a pair $e, d$).  

Regarding your second question, for large $x$, <a href="http://primes.utm.edu/howmany.shtml">the number of primes less than $x$</a> equals $\pi(x) \approx \frac x {log(x)}$. Hence, the number of primes roughly equal to $\sqrt n$ is, for large $n = pq$, large enough to make factorization algorithms faster than a brute force search. Besides, by the arithmetic theorem above, the adversary is really only interested in prime numbers anyway, so the question is moot.  

#### Answer 2 (score 8)
Assume $n$ is 21. If you try to find the possible factors you have to try around until you find 3 and 7. This is of course easy because of the small numbers, but there is no effective way  to do that for big numbers. (And those used in RSA are really big)  

Now assume $n$ is 32. You can split that into 2 * 2 * 2 * 2 * 2. Now you only have to multipy those (bruteforce) until you get two numbers.   

Possible Combinations here would be:  

```cryptography
0,32 / 2,16 / 4, 8 / 8,4 / 16,2 / 32,0
```

(that means: one of those few combinations has to be the right answer)  

Now that of course gets more complicated with bigger numbers too, but still quite easy/fast. So basically if those numbers are not primes, that you can just split up $n$ as much as possible and from there you have an easier way to find $p$ and $q$. If both are primes you have to try values for $p$ and $q$ until you find exactly the right values.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Technical feasibility of decrypting https by replacing the computer's PRNG (score [29386](https://stackoverflow.com/q/9210) in )

#### Question
Intel has an on-chip RdRand function which supposedly bypasses the normally used entropy pool for /dev/urandom and directly injects output. Now rumors are going on that Intel works together with the NSA... and knowing that PRNGs are important for cryptography is enough to get this news spreading.  

I personally don't believe this is true, so this is entirely hypothetical: Let's assume that indeed RdRand does what news says it does and that it indeed outputs randomness into a place where applications and libraries would look for cryptographically secure randomness.  

<ol>
<li><p>How feasible is it that the chip's manufacturer can predict the output of this PRNG when it passed tests from the people applying the use of this RdRand instruction in kernels?</p></li>
<li><p>If the chip's manufacturer can predict the output of the PRNG to some extent, how feasible is it that they can decrypt any https traffic between two systems using their chips? (Or anything else requiring randomness, https is only an example.)</p></li>
</ol>

<p>My reason for asking: <a href="http://cryptome.org/2013/07/intel-bed-nsa.htm">http://cryptome.org/2013/07/intel-bed-nsa.htm</a><br>
As said, I don't believe everything written here, but I find it very interesting to discuss the possibility technically.</p>

#### Answer accepted (score 39)
<blockquote>
  1 - How feasible is it that the chip's manufacturer can predict the output of this PRNG when it passed tests from the people applying the use of this RdRand instruction in kernels?  
</blockquote>

A strong stream cipher's output is random and unpredictable to anyone <strong>not knowing the key</strong>. See where this is heading? Just because something looks random doesn't mean it's random.  

<blockquote>
  2 - If the chip's manufacturer can predict the output of the PRNG to some extent, how feasible is it that they can decrypt any https traffic between two systems using their chips? (Or anything else requiring randomness, https is only an example.)  
</blockquote>

If you can predict the PRNG you can basically predict the secrets used for key exchange, and from that deduce the shared secret. Then you can simply decrypt the communication.  

#### Answer 2 (score 15)
Have you heard of the strange story of Dual_EC_DRBG? A random number generator suggested and endorsed by the government that exhibits some very suspicious properties.    

<a href="http://www.schneier.com/blog/archives/2007/11/the_strange_sto.html">http://www.schneier.com/blog/archives/2007/11/the_strange_sto.html</a>  

From that article:   

<blockquote>
  This is how it works: There are a bunch of constants -- fixed numbers -- in the standard used to define the algorithm's elliptic curve. These constants are listed in Appendix A of the NIST publication, but nowhere is it explained where they came from.  
  
  What Shumow and Ferguson showed is that these numbers have a relationship with a second, secret set of numbers that can act as a kind of skeleton key. If you know the secret numbers, you can predict the output of the random-number generator after collecting just 32 bytes of its output. To put that in real terms, you only need to monitor one TLS internet encryption connection in order to crack the security of that protocol. If you know the secret numbers, you can completely break any instantiation of Dual_EC_DRBG.  
</blockquote>

So the short answer is yes, it is possible to create a random number generating algorithm that has exploitable weaknesses, in particular weakness that only the creator of the algorithm may be able to exploit.  

#### Answer 3 (score 12)
<blockquote>
  1 - How feasible is it that the chip's manufacturer can predict the output of this PRNG when it passed tests from the people applying the use of this RdRand instruction in kernels?  
</blockquote>

As nightcracker correctly stated, any strong cryptographic PRNG will produce a stream of numbers that pass statistical tests.  

However, the manufacturer has some constraints:  

<ul>
<li>Independent tests will be performed on multiple processors that are set up in an identical manner, so each processor must produce different outputs.</li>
<li>Any given processor must produce a different output stream on each power up.</li>
</ul>

A simple scheme would be to use the processor serial number as an input to the PRNG to ensure different processors had different outputs, and have an undisclosed non-volatile register (e.g. a power-on counter) to ensure each boot was different.  

A scheme such as this would probably resist any attempts at analysis using only its outputs: a standard cryptographic PRNG with a global secret (common across all processors), processor ID and power on counter as inputs. At this point, a large scale surveillance infrastructure on observing a new user would only have a space of a few millions of possible processor IDs, plus a few hundreds or thousands of possible boot counts. This could all be easily precomputed too, so would be very practical to hook into a surveillance infrastructure with today's computing power. (Once a user's processor ID and boot count have been identified once, it is of course much easier to keep track of this than have to do a full search each time).  

<strong>However</strong>, the odds are that Intel aren't betting their international sales solely on another fab not having the inclination to open up their chip and check this (e.g. ARM would have a strong incentive to identify such foul play). <strong>Update:</strong> but they could be <a href="http://www.theguardian.com/world/2013/sep/05/nsa-gchq-encryption-codes-security" rel="nofollow">compelled by the government</a> to put such a back door in whether it is in their commercial interests or not. <strong>Update 2:</strong> They, or their fab, could also use <a href="http://people.umass.edu/gbecker/BeckerChes13.pdf" rel="nofollow">stealthy dopant-level modifications</a> to make it extremely hard to detect the modifications, even by someone with Intel-like capabilities (see the first case study, Chapter 3 in the referenced paper).  

I'm not an expert in microprocessor hardware, so can't comment on techniques that might introduce biases or other predictable features without being detected. One possible backdoor might be to severely constrain the next requested output from RdRand only after performing a computation such as would be needed to verify the authenticity of a certificate signed by one of a set of long-lived root CAs (perhaps <a href="http://www1.cnnic.cn/index.htm" rel="nofollow">China's CNNIC</a> would be a useful candidate?).  

<blockquote>
  2 - If the chip's manufacturer can predict the output of the PRNG to some extent, how feasible is it that they can decrypt any https traffic between two systems using their chips? (Or anything else requiring randomness, https is only an example.)  
</blockquote>

Being able to predict that the output of RdRand is within a searchable subset of possible outputs doesn't alone mean an attacker could break the system - it depends how that output is used. For example if the consuming application uses it as just another optional input to its entropy pool, then being able to predict that input means the user is no better than without RdRand, but equally is not worse off.  

CodesInChaos points out that <a href="https://mailman.stanford.edu/pipermail/liberationtech/2013-July/009969.html" rel="nofollow">Linux has used RdRand directly at times</a>; Intel are also <a href="http://software.intel.com/en-us/articles/user-manual-for-the-rdrand-library-linux-version/" rel="nofollow">encouraging direct use of the instruction</a>. So it is not unreasonable to imagine a browser or other TLS client that uses output from RdRand as its sole source of entropy. If this is the case then an observer who can predict the output from RdRand can indeed compromise your security.  

<em>Most cryptosystems fail if the entropy input can be predicted, including SSL/TLS.</em>  

To pick a couple of examples in use by popular websites from the many possible TLS key exchange options:  

<ol>
<li><p>My TLS connection to gmail currently uses Ephemeral <a href="https://en.wikipedia.org/wiki/Elliptic_curve_Diffie-Hellman" rel="nofollow">Elliptic Curve Diffie-Hellman</a> (ECDHE; I believe this is Google's default these days if your browser supports it). If an observer can enumerate the possible random numbers used by my browser, then the observer knows my secret key $d$, so can compute the shared secret $x_k$ by calculating $x_k = dQ$, where Q is the Google server's ephemeral public key (and vice versa if the observer can predict Google's secret key). $x_k$ is <a href="https://tools.ietf.org/html/rfc4492#section-5.10" rel="nofollow">used as the `premaster secret`</a> - the secret from which all other secrets are derived, so obtaining it breaks all of the assurances that TLS aims to provide. </p></li>
<li><p>Your TLS connection to <a href="https://wikitech.wikimedia.org/wiki/Https#Performance_settings" rel="nofollow">Wikipedia</a> uses an RSA based key exchange, as <a href="https://www.ssllabs.com/ssltest/analyze.html?d=en.wikipedia.org" rel="nofollow">that's all they support</a> (e.g. mine is currently `TLS_RSA_WITH_RC4_128_SHA`). With <a href="https://tools.ietf.org/html/rfc2246#section-7.4.7.1" rel="nofollow">these ciphersuites</a>, the `premaster secret` is generated by the client using its random number generator, and sent to the server. Being able to predict the random number directly gives an attacker the secrets they need.</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Explaining weakness of Dual EC DRBG to wider audience? (score [29292](https://stackoverflow.com/q/10417) in 2019)

#### Question
I have an audience of senior (non-technical) executives and senior technical people who are taking the backdoor in Dual_EC_DRBG and considering it as a weakness of Elliptic curves in general. I can take a max of about 10 mins in my presentation to address this issue - no more.  

<ol>
<li><p>How can I explain the weakness in the EC_DUAL_DRBG to such an audience via Mathematical intuition (rather than hardcore math proofs)?</p></li>
<li><p>How do I establish the distinction between weakness in Dual EC DRBG from any weaknesses in EC in general (especially the NSA's Suite B EC curves - ironic, eh?). To me the weakness in Dual EC DRBG is clear (well, after the fact) with selection of the constant curve point. But the NIST EC curves also have constants although of a much different nature (the large prime modulo). Controlling paranoia is ... not easy.</p></li>
</ol>

Please note that the non-technical folks are very intelligent - just not security experts. So I'd like to respect that without dumbing it down too much.  

#### Answer accepted (score 49)
I wouldn't try to explain the mathematics of the backdoor.  Just explain that the NSA hid a secret backdoor in there.  

Instead, I would suggest focusing on the history and the context.  For instance, you could explain about Crypto.AG, how they spiked their RNG to help the NSA spy on their customers.  You could explain how random number generators are a classic weak point in cryptography, because of the RNG has been backdoored, whoever knows the backdoor can recover all your keys.  You could also explain how this is very hard to detect: since RNGs are supposed to output random-looking bits, if it's actually pseudorandom bits that the NSA can predict but no one else can (if the bits are actually coming from a PRNG that the NSA knows the seed to, but no one else does), this is very difficult to detect through black-box testing or through inspection of the supposedly  random bits.  

If you wanted, you could explain that back in 2006, cryptographers discovered the mathematical structure that would allow a backdoor but shied away from making any accusations, because, hey, surely the NSA wouldn't do that -- that would be so egregious a breach, that it seemed hard to imagine it actually contained a backdoor.  And now things are changed: it appears that what seemed unimaginable, is in fact reality.  So, you could explain how this is an eye-opener for the cryptographic community and how it will change the way we think about government standards and system design for the future.  

You could then explain the impact.  You could explain how the impact is believed to be relatively minor, because most people heeded Bruce Schneier's warning from 2007 and didn't use Dual_EC_DRBG.  However, you could explain that at least one major crypto library (RSA's BSAFE) does use it, for reasons that are unclear, so this might have an unknown impact on an unknown number of deployed products.  You could explain how this backdoor is likely to only allow the NSA to decrypt traffic, not anyone else.  And finally, you could explain what the biggest impact is: the potential for loss of trust in cryptographic standards and in American companies.  I'm not sure that we've seen the general public lose trust yet -- I think people still trust Google and Apple and Amazon to have their back -- but if that ever happened, that might be hard to recover from.  

<hr>

I see that you want to explain the mathematics.  OK, here is an explanation.  I'm going to attack a simplified version of Dual_EC_DRBG, but the simplification doesn't change any of the essence of the attack.  

The algorithm specification specifies an elliptic curve, which is basically just a finite cyclic (and thus Abelian) group $G$.  The algorithm also specifies two group elements $P,Q$.  It doesn't say how they were chosen; all we know is that they were chosen by an employee of the NSA.  In the simplified algorithm, the state of the PRNG at time $t$ is some integer $s$.  To run the PRNG forward one step, we do the following:  

<ul>
<li><p>We compute $sP$ (recall we use additive group notation; this is the same as $P^s$, if you prefer multiplicative notation), convert this to an integer, and call it $r$.</p></li>
<li><p>We compute $rP$, convert it to an integer, and call it $s'$ (this will become the new state in the next step).</p></li>
<li><p>We compute $rQ$ and output it as this step's output from the PRNG.  (OK, technically, we convert it to a bitstring in a particular way, but you can ignore that.)</p></li>
</ul>

Now here's the observation: we're pretty much guaranteed that $P=eQ$ for some integer $e$.  We don't know what $e$ is, and it's hard for us to find it (that requires solving the discrete log problem on an elliptic curve, so this is presumably hard).  However, since the NSA chose the values $P,Q$, it could have chosen them by picking $Q$ randomly, picking $e$ randomly, and setting $P=eQ$.  In particular, the NSA could have chosen them so that they know $e$.  

And here the number $e$ is a backdoor that lets you break the PRNG.  Suppose the NSA can observe one output from the PRNG, namely, $rQ$.  They can multiply this by $e$, to get $erQ$.  Now notice that $erQ = r(eQ) = rP = s'$.  So, they can infer what the next state of the PRNG will be.  This means they learn the state of your PRNG!  That's really bad -- after observing just one output from the PRNG, they can predict all future outputs from the PRNG with almost no work.  This is just about as bad a break of the PRNG as could possibly happen.  

Of course, only people who know $e$ can break the PRNG.  So this is a special kind of backdoor: the NSA presumably knows how to break Dual_EC_DRBG, but it's very unlikely that anyone else knows how to break it.  Even though we know now the backdoor exists, it's very hard to recover the secret backdoor $e$, because that requires solving a discrete log problem.  

<hr>

Hmm.  Maybe that's still too complicated, because it requires understanding additive groups and a little bit about elliptic curves and... ugh.  OK.  So, let me share with you an analogous: a PRNG that is just like Dual_EC_PRNG, except that it uses integers, instead of elliptic curves.  In particular, everything will be conceptually basically the same -- the backdoor will be the same, the PRNG will be the same -- this will just be easier to understand without any background in elliptic curve cryptography.  Hopefully this will give the intuition better.  

<ul>
<li><p><strong>The PRNG.</strong> The algorithm specifies a prime number $p$, and two integers $g,h$ that are both less than $p$.  The algorithm tells you that the state of the PRNG at each point in time is some number $s$ that satisfies $1\le s &lt; p$.  To step the PRNG forward by one iteration, you set $r = g^s \bmod p$, $s' = g^r \bmod p$, update the state to $s'$, and output $t = h^r \bmod p$.</p></li>
<li><p><strong>The backdoor.</strong> The backdoor is a secret number $e$ such that $g=h^e \bmod p$.  The NSA, who created the algorithm specification, chose $g,h$ by picking $h$ randomly, picking $e$ randomly, setting $g=h^e \bmod p$, and then publishing $g,h,p$ (but keeping $e$ secret, since $e$ is the backdoor).</p></li>
<li><p><strong>Breaking the PRNG.</strong> Here's how the NSA can break this PRNG.  Suppose they observe one output $t$ from the PRNG.  They compute $t^e \bmod p$.  Notice that</p>

$$t^e = (h^r)^e = h^{re} = (h^e)^r = g^r = s' \pmod p.$$  

This means they were able to compute $s'$, the next state of the PRNG.  So, after observing just one output from the PRNG, they can infer the next state of the PRNG and thereby predict what all future outputs from the PRNG will be.  

For instance, suppose you generate a random IV using this generator (and send it in the clear), then generate a session key using this generator, then encrypt stuff under that session key.  The NSA (who is eavesdropping on your communication and thus can see the IV) knows that the IV was output from this PRNG and can use their backdoor to infer the state of the PRNG and predict its future outputs -- and thus they can predict your session key and decrypt all your subsequent traffic.  You've been owned!  </li>
</ul>

I hope this gives the intuition.  The problem with Dual_EC_DRBG is exactly the same as the problem with this hypothetical PRNG that I just described.  Hopefully this is simple enough to follow: if you understand how Diffie-Hellman works, you can understand why this is broken.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How to use RCON In Key Expansion of 128 Bit Advanced Encryption Standard (score [29154](https://stackoverflow.com/q/2418) in 2012)

#### Question
I have a question about RCON  

here is my illustration...  

this is the 128 bit key..  

```cryptography
[2b] [28] [ab] [09]
[7e] [ae] [f7] [cf]
[15] [d2] [15] [4f]
[16] [a6] [88] [3c]
```

and then I will get this..  

```cryptography
[09]
[cf]
[4f]
[3c]
```

and then I will put down the first 8bit(1byte) where it is the 09:  

```cryptography
[cf]
[4f]
[3c]
[09]
```

after that I will change their value according to s-box..  

```cryptography
[8a]
[84]
[eb]
[01]
```

and then I will xor that substituted 32 bit value to   

```cryptography
[2b]        [8a]        [01]
[7e]  XOR   [84]  XOR   [00] <--- that is a RCON(4)
[15]        [eb]        [00]
[16]        [01]        [00]
```

My question is: How will I determine the RCON that I will use? Or will I only used this one?  

```cryptography
[01]
[00] <--- that is a RCON(4)
[00]
[00]
```

But why?  

#### Answer accepted (score 12)
The Rijndael/AES key schedule uses (for every some steps, depending on the key size) a non-linear function (I called it $f_i$ in <a href="https://crypto.stackexchange.com/a/1527/58">my schematic image in a related answer</a>) on a 32-bit <em>column</em>:  

This function $f_i$ (note that $i$ starts with $1$ here) does the following steps:  

<ul>
<li>substitute each byte, using the AES S-box.</li>
<li>rotate the whole column by one byte "down" (these two steps can be swapped around without effect)</li>
<li><p>XOR in the round constant $RCON[i] = [x^{i-1}, \mathtt{00}, \mathtt{00}, \mathtt{00} ]$. The values $x^{i-1}$ are to be computed in the same representation of $GF(2^8)$ as used in all other operations in AES (see at the end on how to do this), but you can also take them from a <a href="http://en.wikipedia.org/wiki/Rijndael_key_schedule#Rcon" rel="nofollow noreferrer">table in the Wikipedia article</a>, or from the examples in Appendix A of <a href="http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf" rel="nofollow noreferrer">the AES standard</a>.</p>

As you see, $RCON[i]$ consists mainly of zeros, the only effective part is in the first byte. This means, this step only modifies the first byte of the column, the others are unaffected.  </li>
</ul>

So, in your example, you have this column 3 of the original key:  

```cryptography
[09]
[cf]
[4f]
[3c]
```

Now we rotate this by one:  

```cryptography
[cf]
[4f]
[3c]
[09]
```

Now we put this through the AES S-box (component wise):  

```cryptography
[8a]
[84]
[eb]
[01]
```

And now the round step: This is round 1, thus we need $RCON[1] = [\mathtt{01}, \mathtt{00}, \mathtt{00}, \mathtt{00}]$:  

```cryptography
[8a ⊕ 01]   [8b]
[84 ⊕ 00] = [84]
[eb ⊕ 00]   [eb]
[01 ⊕ 00]   [01]
```

This was $f_1$, and we'll now XOR this result with column 0 of the original key to obtain column 4 of the expanded key:  

```cryptography
[8b ⊕ 2b]   [a0]
[84 ⊕ 7e] = [fa]
[eb ⊕ 15]   [fe]
[01 ⊕ 16]   [17]
```

After three more simple XOR steps to get column 5-7 we would then apply $f_2$ (which uses $RCON[ 2] = [\mathtt{02},\mathtt{00}, \mathtt{00}, \mathtt{00}]$) on column 7 and XOR the result with column 4 to get column 8, and so on.  

The `Rcon`-array on Wikipedia contains the precomputed constants $x^{i-1}$ for $i$ from $0$ to $255$, so you would put $RCON[i] = [\mathtt{Rcon[i]}, \mathtt{00}, \mathtt{00}, \mathtt{00}]$. For AES-128, you only need the RCONs from $1$ to $10$ (as you need 44 columns of round key material), and here are these as a table (in hexadecimal form, as all constants in code font here):  

```cryptography
   i        1     2     3     4     5     6     7     8     9    10
--------------------------------------------------------------------
          [01]  [02]  [04]  [08]  [10]  [20]  [40]  [80]  [1b]  [36]
RCON[i]   [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]
          [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]
          [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]  [00]
```

For AES-192 and AES-256 you need even less of these round constants, so putting all 255 of them in Wikipedia is a bit superfluous. Even for Rijndael-256-128 (i.e. 256-bit blocks and 128-bit keys) we would need only $(14+1)·8/4-1 = 29$ of these.  

As mentioned by fgrieu in a comment, you can also <strong>calculate the $\mathtt{Rcon[i]}$ on the fly</strong>, as each of them is obtained from the previous by an doubling in $GF(2^8)$, which in the representation used in Rijndael is just a left-shift followed with a conditional XOR with a constant. In C-like syntax (using a twos-complement representation like every usual computer nowadays) this looks like this:  

```cryptography
rcon = (rcon<<1) ^ (0x11b & -(rcon>>7));
```

<sub>An explanation: `(rcon<<1)` is the pure doubling (multiplication by $x$ in $\mathbb{Z}_2[x]$). `rcon >> 7` is the first bit of `rcon`, i.e. either $\mathtt{0}$ or $\mathtt{1}$. `-(rcon>>7)` then is $\mathtt{0}$ or -1 (= $\mathtt{f...ff}$, i.e. all bits set). Thus `(0x11b & -(rcon>>7))` is either $\mathtt{0}$ or $\mathtt{11b}$, and XORing with this just is reduction modulo the Rijndael polynomial $x^8 + x^4 + x^3 + x + 1$.</sub>  

<a href="https://crypto.stackexchange.com/a/2403/58">The same doubling operation is used in the MixColumns-step</a> of the actual encryption operation, so you need to implement it anyways.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Difference between linear cryptanalysis and differential cryptanalysis (score [29080](https://stackoverflow.com/q/10345) in 2013)

#### Question
What is the main difference between linear cryptanalysis and differential cryptanalysis? For example in relation to DES?  

#### Answer accepted (score 14)
Differential cryptanalysis works on <em>differences</em>. Linear cryptanalysis works on <em>linearity</em>. Neat, isn't it ?  

Instead of speaking of how they <em>differ</em>, it is easier to list their common features. Both kinds of attacks:  

<ul>
<li>Use a lot of known pairs plaintext/ciphertext (many input messages encrypted with the same key, and, for each of them, the attacker knows both the block value before encryption, and after).</li>
<li>Rely on an "approximation" of the internal behaviour of the encryption function, which holds with a small but non-zero probability for some input.</li>
<li>Work with detected weaknesses in the internal structure of the algorithm; they don't work "generically".</li>
</ul>

With differential cryptanalysis, the known plaintext/ciphertext pairs must be organized in pairs where both plaintexts differ by a specific difference ("difference" being a XOR, a subtraction... whatever works well algebraically with the algorithm at hand; for DES, this is XOR). The "approximation" is that this input difference will yield another specific difference on the output with a probability which is somewhat higher than what could be obtained with pure randomness, and the exact difference which will most probably appear depends on some of the key bits. Successful differential cryptanalysis normally requires <strong>chosen</strong> plaintext/ciphertext pairs (the attacker gets to choose the plaintexts or the ciphertexts).  

With linear cryptanalysis, the approximation is a linear formula (i.e. a bunch of XOR on bits) which links together some input bits, some output bits and some key bits, with a probability somewhat higher than what could be obtained with pure random. This "linear formula" works best (i.e. is fulfilled most often) when the hypothesis on the involved key bits is correct, so the analysis yields a few key bits.  

The most salient difference between linear and differential cryptanalysis is the known/chosen plaintext duality. For linear cryptanalysis, known random plaintexts are sufficient, but differential cryptanalysis requires chosen plaintexts, which, depending on the context, may or may not be a significant problem for the attacker.  

Linear cryptanalysis is easier to grasp, so begin with that one. <a href="http://www.apprendre-en-ligne.net/crypto/bibliotheque/PDF/lincrypt.pdf">This PhD thesis</a> is a nice introduction. For differential cryptanalysis, read <a href="http://sota.gen.nz/crypt_blues/biham91differential.pdf">this well-explained article</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Definition of textbook RSA (score [28803](https://stackoverflow.com/q/1448) in 2018)

#### Question
What is the definition of textbook or "raw" RSA?  

What are some of the properties of textbook RSA?  

How does it differ from other schemes based on RSA?  

#### Answer accepted (score 60)
<strong>Textbook RSA</strong>:  

<p>Choose two large primes $p$ and $q$.
Let $n=p\cdot q$. Choose $e$ such that $gcd(e,\varphi(n))=1$ (where $\varphi(n)=(p-1)\cdot (q-1)$). Find $d$ such that $e\cdot d\equiv 1\bmod{\varphi(n)}$. In other words, $d$ is the modular inverse of $e$, ($d\equiv e^{-1}\bmod{\varphi(n)}$).</p>

$(e, n)$ is the public key, $(d, n)$ the private one.  

<ul>
<li>To encrypt a message $m$, compute $c\equiv m^e\mod n$.</li>
<li>To decrypt a ciphertext $c$, compute $m \equiv c^d\mod n$.</li>
</ul>

Signing and verifying messages is also defined (omitted for brevity).  

<strong>Some (Undesirable) Properties of Textbook RSA</strong>:  

<ol>
<li>It is malleable. I.e., if you give me a ciphertext $c$ which encrypts $m$, I can compute $c'\equiv c\cdot 2^e\mod n$. When the owner of the private key decrypts $c'$, she will get $2m\mod n$. In other words, I can make predictable changes to ciphertexts.</li>
<li>It is deterministic, and thus not <a href="http://en.wikipedia.org/wiki/Semantic_security">semantically secure</a>. I.e., I can distinguish between the encryptions of $0$ and $1$ (simply by encrypting both values myself and comparing the ciphertexts).</li>
</ol>

<strong>Differences with Deployed RSA</strong>:  

<ol>
<li><a href="http://en.wikipedia.org/wiki/RSA_(algorithm)#Padding_schemes">Padding</a></li>
<li><a href="http://en.wikipedia.org/wiki/RSA_%28algorithm%29#Using_the_Chinese_remainder_algorithm">Chinese Remainder Theorem</a> is sometimes used in deployed systems for more efficient decryption.</li>
<li>$e$ is often statically set to $65537 = 2^{16} + 1$ for encryption speed (since there are only two set bits in that number).</li>
<li>Side-channel attack mitigations can be put in place for deployed systems too.</li>
</ol>

In no way is my list comprehensive, but hopefully this helps.  



#### Answer 2 (score 15)
RSA is both an encryption and signature function. I have heard the term "textbook RSA" used mostly with the encryption function, but the same basic principle applies to RSA signatures as well. It is essentially RSA without any padding.  

There is no canonical definition of textbook RSA (e.g., does it include restrictions on choosing safe primes or not?) and so it may differ by context, but it is what is called "plain RSA" on the <a href="http://en.wikipedia.org/wiki/RSA_%28algorithm%29">Wikipedia article</a>. Since Wikipedia evolves, also see <a href="http://crypto.stanford.edu/~dabo/courses/cs255_winter07/rsa.ppt">these slides</a> from Dan Boneh.   

Textbook RSA has no semantic security, therefore it is not secure against chosen plaintext attacks or ciphertext attacks. This is because, respectively, it is deterministic (encrypting the same message twice produces the same ciphertext) and multiplicatively homomorphic (an encrypted values can be multiplicatively modified under encryption).   

The main alternative to textbook RSA encryption is RSA with <a href="http://en.wikipedia.org/wiki/Optimal_Asymmetric_Encryption_Padding">OAEP</a>. This variant is semantically, CPA-, and CCA-secure. RSA+OAEP is randomized and has no homomorphisms. OAEP itself is a second generation padding scheme, the first generation only providing semantic/CPA-security for RSA.  

RSA signatures can also be padded. RSA with PSS makes the signatures randomized.   

#### Answer 3 (score 1)
A) <strong>RSA</strong>  

RSA is assymetric encryption method. RSA is one of the Public Key Cryptography methods. This method make use of two keys: a public key, known to all, for encryption and a private key, kept secret, for decryption.  

<p>Operations in RSA:
The RSA algorithm involves three steps: </p>

1) key generation - Key pairs are generated: a private key and a public key.  

2) Encryption - by using public key the message is encrypted.  

3) Decryption - by using private key the message is decrypted.  

B) <strong>Textbook RSA</strong>  

Some points regarding textbook RSA is given below:  

1) Textbook RSA is insecure  

2) Textbook RSA encryption:  

• public key: (N,e) Encrypt: C = M^e(mod N)  

• private key: d Decrypt:   C^d = M (mod N)  

```cryptography
                           (M Î ZN)
```

3) Completely insecure cryptosystem:  

```cryptography
 • Does not satisfy basic definitions of security.
 • Many attacks exist.
```

4) The RSA trapdoor permutation is not a cryptosystem.  

5) A simple attack on textbook RSA  

<a href="https://i.stack.imgur.com/oBdkA.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/oBdkA.png" alt="enter image description here"></a>  

<ul>
<li><p>Session-key K is 64 bits. View K {0,…,264}</p>

```cryptography
           Eavesdropper sees: C = K^e(mod N) .
```
</li>
<li><p>Suppose K = K1×K2 where K1, K2 &lt; 234 . (prob. 20%)</p>

Then: C/K1^e = K2^e(mod N)  </li>
<li>Build table: C/1^e, C/2^e, C/3^e, …, C/2^(34e) . time: 2^34
For K2 = 0,…, 2^34 test if K2^e is in table. time: 2^34 34</li>
<li>Attack time: 2^40 &lt;&lt; 2^64</li>
</ul>

6) Never use textbook RSA because of less security.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: When to use RSA and when ElGamal asymmetric encryption (score [28626](https://stackoverflow.com/q/1677) in 2017)

#### Question
If i am not wrong in cryptography there are 2 basic cryptographic schemes for public key cryptography. <a href="https://en.wikipedia.org/wiki/RSA_(cryptosystem)" rel="noreferrer">RSA</a> encryption whose security is based on the infeasibility of solving the factoring of big primes problem and the <a href="https://en.wikipedia.org/wiki/ElGamal_encryption" rel="noreferrer">ElGamal</a> encryption which is as secure as the discrete logarithmic problem. The question is whether or not there are specific circumstances where you must use ElGamal instead RSA and vice versa. What are the weak and the strong points of each?  

To sum up is it harder under the same attacking model to solve the factoring problem or the discrete logarithmic problem?  

#### Answer accepted (score 21)
Actually, for most applications where we want to use asymmetric encryption, we really want something a bit weaker: <a href="http://en.wikipedia.org/wiki/Key-agreement_protocol" rel="nofollow">key agreement</a> (also known as "key exchange"). When RSA or ElGamal is used for that, one party selects a random string, encrypts it with the public key of the other party, and the random string is used as a key for classical symmetric encryption. Therefore, we must add <a href="http://en.wikipedia.org/wiki/Diffie-Hellman" rel="nofollow">Diffie-Hellman</a> to the list. You can imagine Diffie-Hellman as a kind of asymmetric encryption in which you do not get to choose the random value you are encrypting: less versatile than ElGamal, yet sufficiently powerful for most protocols where asymmetric encryption is used. <a href="http://tools.ietf.org/html/rfc5246" rel="nofollow">SSL/TLS</a> and <a href="http://en.wikipedia.org/wiki/S/MIME" rel="nofollow">S/MIME</a> happily use RSA and Diffie-Hellman in practice. Diffie-Hellman, like ElGamal, relies (more or less) on the difficulty of breaking discrete logarithm, and is internally relatively similar to ElGamal.  

Among differences between RSA, DH and ElGamal, one can find:  

<ul>
<li><p>DH and ElGamal accept <a href="http://en.wikipedia.org/wiki/Elliptic_curve_cryptography" rel="nofollow">elliptic curve variants</a>. They rely on hardness of discrete logarithm on elliptic curves, which is distinct from discrete logarithms modulo a big prime. Elliptic curve variants can use smaller fields, so while the mathematics are a bit more complex, performance is better.</p></li>
<li><p>RSA <em>encryption</em> (with the public key) is faster than the corresponding operation with ElGamal, or half of Diffie-Hellman. On the other hand, RSA <em>decryption</em> (with a private key) is a bit slower than ElGamal decryption or the other half of Diffie-Hellman (especially the elliptic curve variants).</p></li>
<li><p>An RSA-encrypted message is larger than an ElGamal-encrypted message or half a Diffie-Hellman, provided that elliptic curves are used for the latter.</p></li>
<li><p>Historically, RSA was patented in the US, while ElGamal was not -- which is why <a href="http://tools.ietf.org/html/rfc4880" rel="nofollow">OpenPGP</a> specified ElGamal usage, and <a href="http://www.gnupg.org/" rel="nofollow">GnuPG</a> tends to favour it over RSA (the RSA patent expired a decade ago, so this is no longer an issue).</p></li>
<li><p>RSA is described by a <a href="http://www.rsa.com/rsalabs/node.asp?id=2125" rel="nofollow">clear standard</a>, which is free (as in "free beer"), and says precisely where each byte should go. That's very good for implementers: it reduces the possible mishaps. On the other hand, the <a href="http://webstore.ansi.org/RecordDetail.aspx?sku=ANSI%20X9.42:2003" rel="nofollow">Diffie-Hellman standard</a> (or <a href="http://webstore.ansi.org/RecordDetail.aspx?sku=X9.63-2011" rel="nofollow">that one</a> for the elliptic curve variant) is not free, and, in my experience, less clear. There is no established standard at all for ElGamal, except the bits about it in OpenPGP, which do not deal with ElGamal "in general".</p></li>
</ul>

What protocol designers should do is to make some provisions for <em>algorithm agility</em>: the protocol should work with various algorithms, with fields indicating which algorithm is actually used. Algorithm agility helps quite a lot with dealing with future cryptanalytic advances, and with regulatory requirements.  

#### Answer 2 (score 2)
<strong>Hardness</strong>  

As to the hardness of solving factoring, <a href="https://crypto.stackexchange.com/questions/802/would-the-ability-to-efficiently-find-discrete-logs-have-any-impact-on-the-secur">this question</a> (and answers and comments) provides an interesting discussion. As long as you follow recommended key sizes, either cryptosystem is sufficiently secure.  

<strong>Use Cases</strong>  

The one use case where I see ElGamal being used over RSA is when a multiplicatively homomorphic cryptosystem is needed (noe that both ElGamal and RSA are multiplicatively homomorphic). The reason ElGamal is preferred is that it is <a href="http://en.wikipedia.org/wiki/Semantic_security" rel="nofollow noreferrer">semantically secure</a> "out-of-the-box" (i.e., without modifications (<a href="https://crypto.stackexchange.com/questions/1448/definition-of-textbook-rsa">this question</a> and my answer there might provide more insight into what I'm talking about).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Simply put, what does “perfect secrecy” mean? (score [28378](https://stackoverflow.com/q/3896) in 2016)

#### Question
I would like to ask for a clear (but maybe not so deep) explanation of what the term "perfect secrecy" means.  

As far as I have researched and understood, it has to do with probabilities of assuming that a certain variable will be the key for a certain cipher text. And unless I'm confusing some concepts, the one-time pad is the only cipher known to have perfect secrecy, since no amount of resources would be enough to break it.  

My notions of probability are kind of weak, which is why I don't understand most documents that speak of it.   

#### Answer 2 (score 20)
<em>Perfect Secrecy</em> (or <em>information-theoretic secure</em>) means that the ciphertext conveys no information about the content of the plaintext. In effect this means that, no matter how much ciphertext you have, it does not convey anything about what the plaintext and key were. It can be proved that any such scheme must use at least as much key material as there is plaintext to encrypt. In terms of probabilities, it means that the probability distribution of the possible plaintexts is independent of the ciphertext.  

We contrast this with semantic security, which I define by quoting the seminal 1984 paper of Goldwasser&amp;Micali:  

<blockquote>
  Whatever is efficiently computable about the cleartext given the cyphertext, is also efficiently computable without the cyphertext.  
</blockquote>

For two examples, I quote <a href="https://crypto.stackexchange.com/a/11706/8911">my answer</a> to <a href="https://crypto.stackexchange.com/q/11698/8911">this</a> related question:  

<blockquote>
  When used correctly, the <a href="http://en.wikipedia.org/wiki/One-time_pad" rel="noreferrer">One Time Pad (OTP)</a> is <a href="http://en.wikipedia.org/wiki/Information_theoretic_security" rel="noreferrer">information-theoretic secure</a>, which means it can't be broken with cryptanalysis. However, part of being provably secure is that you need as much key material as you have plaintext to encrypt. Such a key needs to be shared between the two communicants, which basically means you have to give it to the other person through a perfectly secure protocol (eg by hand/trusted courier). So, actually it just allows you to have your trusted meeting in advance, rather than at the time of transmitting the secret information.  
  
  To illustrate this, consider what happens if one tries to brute force OTP? Since you have allowed an attacker infinite computational resources, he can keep guessing keys and calculating the appropriate plaintext until every key has been tested. Supposing the message was $b$ bits long, this would leave him with $2^b$ possible keys, each of which would generate a unique plaintext, making $2^b$ plaintexts. What is important here is that this means they would have candidate plaintexts corresponding to <em>ever</em> possible bit-string of length $b$. This means, even if you knew the message was "Meet me at the stadium at 2`?`:15" (where `?` is 0,1,2 or 3), you still wouldn't have any idea what the `?` was, because the possible plaintexts would contain this string with every possible value of `?`.  
  
  Most cryptographic methods we use now are <em>computationally secure</em>. There are lots of different ways to do this, and I'll just sketch at a few of them. We might come up with a reduction to a problem conjectured to be <em>hard</em> (eg the <a href="http://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_problem" rel="noreferrer">Diffie-Hellman Problem</a> or <a href="http://en.wikipedia.org/wiki/Discrete_logarithm_problem" rel="noreferrer">Discrete Log Problem</a>). That is, we prove that "If you can break my cipher, you can solve [hard-problem]", meaning our problem is at least a difficult to solve as [hard-problem]. So, if the problem is indeed hard to solve, so must cracking our encryption be.  
</blockquote>

#### Answer 3 (score 4)
Perfect secrecy is the notion that, given an encrypted message (or ciphertext) from a perfectly secure encryption system (or cipher), absolutely nothing will be revealed about the unencrypted message (or plaintext) by the ciphertext.  

A perfectly secret cipher has a couple of other equivalent properties:  

<ul>
<li>Even if given a choice of two plaintexts, one the real one, for a ciphertext, you cannot distinguish which plaintext is the real one (perfect message indistinguishability)</li>
<li>There is a key that encrypts every possible plaintext to every possible ciphertext (perfect key ambiguity) (* this is true only if the keys used are the same size as the messages)</li>
</ul>

<p>What perfect secrecy means in practice is that no amount of computation applied to the ciphertext will give you any advantage in knowing anything about the plaintext or key.
This is obviously a desirable property of a cipher, and perfectly secret ciphers do exist: e.g. <a href="http://en.wikipedia.org/wiki/One-time_pad" rel="noreferrer">One-time pad</a>.</p>

The downside of perfect secrecy is that it can be shown that no cipher where the keys used are shorter than the plaintext can be perfectly secret, so in effect you've simply changed the problem of transmitting a message securely from the transmission of the plaintext to the transmission of the key. (One-time pad has this problem, and other practical problems as well).  

In practice, outside niche applications that can use One-time pad, ciphers tend to have keys much shorter (typically between 128 and a few thousand bits) than the messages we encrypt. These ciphers of course cannot have perfect secrecy (since the key is shorter than the message) and so can (especially when broken) succumb to computational attacks (some practical, some theoretical) that leak information about plaintexts and even keys.  

We use the relatively weaker (but still practically very strong) notions of <a href="http://en.wikipedia.org/wiki/Semantic_security" rel="noreferrer">Semantic Security</a> or <a href="http://en.wikipedia.org/wiki/Ciphertext_indistinguishability" rel="noreferrer">Ciphertext indistinguishability</a> to evaluate and describe the security of non perfect-secrecy ciphers under various scenarios. The strength of a not-perfectly-secret cipher is generally expressed in terms of the computational complexity (in calculations and/or memory) of the best known attacks that break the cipher.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Calculating private keys in the RSA cryptosystem (score [28356](https://stackoverflow.com/q/1713) in 2012)

#### Question
<p>The number $43733$ was chosen as base for an implementation of the RSA system.
$M=19985$ is the message, that was encrypted with help of a public key $K=53$.</p>

<p>What is the plaintext text?
What is the private key?</p>

So far, my calculations are:  

<ol>
<li>$n=pq$</li>
<li>$n=101*433$</li>
<li>$\phi(43733) = (101 − 1)*(433 − 1) = 43200$.</li>
<li>The public key is $(n = 43733, e = 53)$.</li>
<li>The private key is $(n = 43733, d = 12343)$.</li>
</ol>

However, I'm not sure if this is right? Where am I going wrong?  

#### Answer accepted (score 4)
The public key is $K = e = 53$, already given. $n$ (the modulus) must also be given, so you could say that $(e, n)$ is the actual key.  

<p>The private key is $d$ which must satisfy $d * e = 1 \mod \phi(n)$.
So you're looking for $d$ for which $(53 * d) \mod 43200 == 1$. A quick brute-force search (with such small numbers it's not a problem) reveals that $17117$ satisfies this equation.</p>

Now $N=43733$, and you're guaranteed that $(M^e)^d = (M^d)^e = M \mod n$.  

Your message is $M=19985$:  

<ul>
<li><p>$19985^{53}  \equiv 17195 \mod 43733$</p></li>
<li><p>$17195^{17117} \equiv 19985 \mod 43733 $</p></li>
</ul>

<p>This shows that you can encrypt using the public key and decrypt using the private key.
The opposite also works (for signing the message):</p>

<ul>
<li><p>$19985 ^{17117}  \equiv 125 \mod 43733$</p></li>
<li><p>$125 ^{53} \equiv 19985 \mod 43733$</p></li>
</ul>

There are better ways to find $d$ from $e$ if you know $\phi(n)$. But if you don't, you're in trouble, because you need to factorise $n$ to do that.  

</section>

