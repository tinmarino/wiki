---
title: Chemistry <- StackExchange top 100
category: chemistry
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: What are the maximum number of electrons in each shell? (score [932828](https://stackoverflow.com/q/8598) in 2017)

#### Question
In my textbook, it says that the maximum number of electrons that can fit in any given shell is given by 2n². This would mean 2 electrons could fit in the first shell, 8 could fit in the second shell, 18 in the third shell, and 32 in the fourth shell.   

However, I was previously taught that the maximum number of electrons in the first orbital is 2, 8 in the second orbital, 8 in the third shell, 18 in the fourth orbital, 18 in the fifth orbital, 32 in the sixth orbital.  I am fairly sure that orbitals and shells are the same thing.   

Which of these two methods is correct and should be used to find the number of electrons in an orbital?   

I am in high school so please try to simplify your answer and use fairly basic terms.  

#### Answer accepted (score 45)
Shells and orbitals are not the same. In terms of quantum numbers, electrons in different shells will have different values of principal quantum number <em>n</em>.  

To answer your question...  

In the first shell (n=1), we have:  

<ul>
<li>The 1s orbital</li>
</ul>

In the second shell (n=2), we have:  

<ul>
<li>The 2s orbital</li>
<li>The 2p orbitals</li>
</ul>

In the third shell (n=3), we have:  

<ul>
<li>The 3s orbital</li>
<li>The 3p orbitals</li>
<li>The 3d orbitals</li>
</ul>

In the fourth shell (n=4), we have:  

<ul>
<li>The 4s orbital</li>
<li>The 4p orbitals</li>
<li>The 4d orbitals</li>
<li>The 4f orbitals</li>
</ul>

So another kind of orbitals (s, p, d, f) becomes available as we go to a shell with higher <em>n</em>. The number in front of the letter signifies which shell the orbital(s) are in. So the 7s orbital will be in the 7th shell.  

<p><strong>Now for the different kinds of orbitals</strong>
Each kind of orbital has a different "shape", as you can see on the picture below. You can also see that:</p>

<ul>
<li>The s-kind has only one orbital</li>
<li>The p-kind has three orbitals</li>
<li>The d-kind has five orbitals</li>
<li>The f-kind has seven orbitals</li>
</ul>

<img src="https://i.stack.imgur.com/XkAjM.jpg" alt="Orbital shapes">  

Each orbital can hold <em>two</em> electrons. One spin-up and one spin-down. This means that the 1s, 2s, 3s, 4s, etc., can each hold <em>two</em> electrons because they each have only one orbital.  

The 2p, 3p, 4p, etc., can each hold <em>six</em> electrons because they each have <em>three</em> orbitals, that can hold <em>two</em> electrons each (3*2=6).  

The 3d, 4d etc., can each hold <em>ten</em> electrons, because they each have <em>five</em> orbitals, and each orbital can hold <em>two</em> electrons (5*2=10).  

<strong>Thus, to find the number of electrons possible per shell</strong>  

First, we look at the <strong>n=1 shell (the first shell)</strong>. It has:  

<ul>
<li>The 1s orbital</li>
</ul>

An s-orbital holds 2 electrons. Thus n=1 shell can hold two electrons.  

The <strong>n=2 (second)</strong> shell has:  

<ul>
<li>The 2s orbital</li>
<li>The 2p orbitals</li>
</ul>

s-orbitals can hold 2 electrons, the p-orbitals can hold 6 electrons. Thus, the second shell can have 8 electrons.  

The <strong>n=3 (third)</strong> shell has:  

<ul>
<li>The 3s orbital</li>
<li>The 3p orbitals</li>
<li>The 3d orbitals</li>
</ul>

s-orbitals can hold 2 electrons, p-orbitals can hold 6, and d-orbitals can hold 10, for a total of 18 electrons.  

<strong>Therefore, the formula $2n^2$ holds! What is the difference between your two methods?</strong>  

There's an important distinction between <em>"the number of electrons possible in a shell"</em> and <em>"the number of valence electrons possible for a period of elements"</em>.  

There's space for $18 \text{e}^-$ in the 3rd shell: $3s + 3p + 3d = 2 + 6 + 10 = 18$, however, elements in the 3rd period only have up to 8 valence electrons. This is because the $3d$-orbitals aren't filled until we get to elements from the 4th period - ie. elements from the 3rd period don't fill the 3rd shell.  

The orbitals are filled so that the ones of lowest energy are filled first. The energy is roughly like this:  

$$1s &lt; 2s &lt; 2p &lt; 3s &lt; 3p &lt; 4s &lt; 3d &lt; 4p &lt; 5s$$  

An easy way to visualize this is like this:  

<img src="https://i.stack.imgur.com/bvjvh.gif" alt="Filling order of orbitals">  

#### Answer 2 (score 23)
The pattern of maximum possible electrons = $2n^2$ is correct.  

Also, note that Brian's answer is good and takes a different approach.  

Have you learned about <a href="http://en.wikipedia.org/wiki/Quantum_number#Traditional_nomenclatures" rel="noreferrer">quantum numbers</a> yet?   

<blockquote>
  If not...  
</blockquote>

Each shell (or energy level) has some number of <a href="http://en.wikipedia.org/wiki/Electron_shell#Subshells" rel="noreferrer">subshells</a>, which describe the types of atomic orbitals available to electrons in that subshell. For example, the $s$ subshell of any energy level consists of spherical orbitals. The $p$ subshell has dumbbell-shaped orbitals. The orbital shapes start to get weird after that. Each subshell contains a specified number of orbitals, and each orbital can hold two electrons. The types of subshells available to a shell and the number of orbitals in each subshell are mathematically defined by quantum numbers. Quantum numbers are parameters in the wave equation that describes each electron. The <a href="http://en.wikipedia.org/wiki/Pauli_exclusion_principle" rel="noreferrer">Pauli Exclusion Principle</a> states that no two electrons in the same atom can have the exact same set of quantum numbers. A more thorough explanation using quantum numbers can be found below. However, the outcome is the following:  

The subshells are as follows:  

<ul>
<li>The $s$ subshell has one orbital for a total of 2 electrons</li>
<li>The $p$ subshell has three orbitals for a total of 6 electrons</li>
<li>The $d$ subshell has five orbitals for a total of 10 electrons</li>
<li>The $f$ subshell has seven orbitals for a total of 14 electrons</li>
<li>The $g$ subshell has nine orbitals for a total of 18 electrons</li>
<li>The $h$ subshell has eleven orbitals for a total of 22 electrons</li>
</ul>

etc.  

Each energy level (shell) has more subshells available to it:  

<ul>
<li>The first shell only has the $s$ subshell $\implies$ 2 electrons</li>
<li>The second shell has the $s$ and $p$ subshells $\implies$ 2 + 6 = 8 electrons</li>
<li>The third shell has the $s$, $p$, and $d$ subshells $\implies$ 2 + 6 + 10 = 18 electrons</li>
<li>The fourth shell has the $s$, $p$, $d$, and $f$ subshells $\implies$ 2 + 6 + 10 + 14 = 32 electrons</li>
<li>The fifth shell has the $s$, $p$, $d$, $f$, and $g$ subshells $\implies$ 2 + 6 + 10 + 14 + 18 = 50 electrons</li>
<li>The sixth shell has the $s$, $p$, $d$, $f$, $g$, and $h$ subshells $\implies$ 2 + 6 + 10 + 14 + 18 + 22 = 72 electrons</li>
</ul>

The pattern is thus: $2, 8, 18, 32, 50, 72, ...$ or $2n^2$  

In practice, no known atoms have electrons in the $g$ or $h$ subshells, but the quantum mechanical model predicts their existence.   

<blockquote>
  Using quantum numbers to explain why the shells have the subshells they do and why the subshells have the number of orbitals they do.  
</blockquote>

Electrons in atoms are defined by 4 quantum numbers. The Pauli Exclusion Principle means that no two electrons can share the same quantum numbers.  

The quantum numbers:  

<ul>
<li>$n$, the principle quantum number defines the shell. The values of $n$ are integers: $n=1,2,3,...$</li>
<li>$\ell$, the orbital angular momentum quantum number defines the subshell. This quantum number defines the shape of the orbitals (probability densities) that the electrons reside in. The values of $\ell$ are integers dependent on the value of $n$: $\ell = 0,1,2,...,n-1$</li>
<li>$m_{\ell}$, the magnetic quantum number defines the orientation of the orbital in space. This quantum number also determines the number of orbitals per subshell. The values of $m_\ell$ are integers and depend on the value of $\ell$: $m_\ell = -\ell,...,-1,0,1,...,+\ell$</li>
<li>$m_s$, the spin angular momentum quantum number defines the spin state of each electron. Since there are only two allowed values of spin, thus there can only be two electrons per orbital. The values of $m_s$ are $m_s=\pm \frac{1}{2}$</li>
</ul>

<strong>For the first shell</strong>, $n=1$, so only one value of $\ell$ is allowed: $\ell=0$, which is the $s$ subshell. For $\ell=0$ only $m_\ell=0$ is allowed. Thus the $s$ subshell has only 1 orbital. The first shell has 1 subshell, which has 1 orbital with 2 electrons total.  

<strong>For the second shell</strong>, $n=2$, so the allowed values of $\ell$ are: $\ell=0$, which is the $s$ subshell, and $\ell=1$, which is the $p$ subshell. For $\ell=1$, $m_\ell$ has three possible values: $m_\ell=-1,0,+1$. Thus the $p$ subshell has three orbitals. The second shell has 2 subshells: the $s$ subshell, which has 1 orbital with 2 electrons, and the $p$ subshell, which has 3 orbitals with 6 electrons, for a  total of 4 orbitals and 8 electrons.  

<strong>For the third shell</strong>, $n=3$, so the allowed values of $\ell$ are: $\ell=0$, which is the $s$ subshell,  $\ell=1$, which is the $p$ subshell, and $\ell=2$, which is the $d$ subshell. For $\ell=2$, $m_\ell$ has five possible values: $m_\ell=-2,-1,0,+1,+2$. Thus the $d$ subshell has five orbitals. The third shell has 3 subshells: the $s$ subshell, which has 1 orbital with 2 electrons, the $p$ subshell, which has 3 orbitals with 6 electrons, and the $d$ subshell, which has 5 orbitals with 10 electrons, for a  total of 9 orbitals and 18 electrons.  

<strong>For the fourth shell</strong>, $n=4$, so the allowed values of $\ell$ are: $\ell=0$, which is the $s$ subshell,  $\ell=1$, which is the $p$ subshell, $\ell=2$, which is the $d$ subshell, and $\ell=3$, which is the $f$ subshell. For $\ell=3$, $m_\ell$ has seven possible values: $m_\ell=-3,-2,-1,0,+1,+2,-3$. Thus the $f$ subshell has seven orbitals. The fourth shell has 4 subshells: the $s$ subshell, which has 1 orbital with 2 electrons, the $p$ subshell, which has 3 orbitals with 6 electrons,  the $d$ subshell, which has 5 orbitals with 10 electrons, and the $f$ subshell, which has 7 orbitals with 14 electrons, for a  total of 16 orbitals and 32 electrons.  

#### Answer 3 (score -1)
The first shell can carry up to two electrons, the second shell can carry up to eight electrons.  

The third shell can carry up 18 electrons, but it is more stable by carrying only eight electrons.  There is a formula for obtaining the maximum number of electrons for each shell which is given by $2n^2~\ldots$ where n is the position of a certain shell.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I figure out the hybridization of a particular atom in a molecule? (score [698629](https://stackoverflow.com/q/4399) in 2018)

#### Question
I'm learning how to apply the VSEPR theory to Lewis structures and in my homework, I'm being asked to provide the hybridization of the central atom in each Lewis structure I've drawn.  

I've drawn out the Lewis structure for all the required compounds and figured out the arrangements of the electron regions, and figured out the shape of each molecule. I'm being asked to figure out the hybridization of the central atom of various molecules.  

<p>I found a sample question with all the answers filled out:
$\ce{NH3}$</p>

It is $sp^3$ hybridized.  

Where does this come from? I understand how to figure out the standard orbitals for an atom, but I'm lost with hybridization.  

<p>My textbook uses $\ce{CH4}$ as an example.
Carbon has $2s^22p^2$, but in this molecule, it has four $sp^3$. I understand the purpose of four (there are four hydrogens), but where did the "3" in $sp^3$ come from?</p>

How would I figure out something more complicated like $\ce{H2CO}$?  

#### Answer accepted (score 43)
If you can assign the total electron geometry (geometry of all electron domains, not just bonding domains) on the central atom using VSEPR, then you can always automatically assign hybridization. Hybridization was invented to make quantum mechanical bonding theories work better with known empirical geometries. If you know one, then you always know the other.  

<ul>
<li>Linear - $\ce{sp}$ - the hybridization of one $\ce{s}$ and one $\ce{p}$ orbital produce two hybrid orbitals oriented $180^\circ$ apart.</li>
<li>Trigonal planar - $\ce{sp^2}$ - the hybridization of one $\ce{s}$ and two $\ce{p}$ orbitals produce three hybrid orbitals oriented $120^\circ$ from each other all in the same plane. </li>
<li>Tetrahedral - $\ce{sp^3}$ - the hybridization of one $\ce{s}$ and three $\ce{p}$ orbitals produce four hybrid orbitals oriented toward the points of a regular tetrahedron, $109.5^\circ$ apart.</li>
<li>Trigonal bipyramidal - $\ce{dsp^3}$ or $\ce{sp^3d}$ - the hybridization of one $\ce{s}$, three $\ce{p}$, and one $\ce{d}$ orbitals produce five hybrid orbitals oriented in this weird shape: three equatorial hybrid orbitals oriented $120^\circ$ from each other all in the same plane and two axial orbitals oriented $180^\circ$ apart, orthogonal to the equatorial orbitals.</li>
<li>Octahedral - $\ce{d^2sp^3}$ or $\ce{sp^3d^2}$ - the hybridization of one $\ce{s}$, three $\ce{p}$, and two $\ce{d}$ orbitals produce six hybrid orbitals oriented toward the points of a regular octahedron $90^\circ$ apart.</li>
</ul>

I assume you haven't learned any of the geometries above steric number 6 (since they are rare), but they each correspond to a specific hybridization also.  

<blockquote>
  $\ce{NH3}$  
</blockquote>

For $\ce{NH3}$, which category does it fit in above? Remember to count the lone pair as an electron domain for determining total electron geometry. Since the sample question says $\ce{NH3}$ is $\ce{sp^3}$, then $\ce{NH3}$ must be tetrahedral. Make sure you can figure out how $\ce{NH3}$ has tetrahedral electron geometry.  

<blockquote>
  For $\ce{H2CO}$  
</blockquote>

<ol>
<li>Start by drawing the Lewis structure. The least electronegative atom that is not a hydrogen goes in the center (unless you have been given structural arrangement). </li>
<li>Determine the number of electron domains on the central atom.</li>
<li>Determine the electron geometry using VSEPR. Correlate the geometry with the hybridization. </li>
<li>Practice until you can do this quickly.</li>
</ol>

#### Answer 2 (score 19)
You can find the hybridization of an atom by finding its steric number:  

The <strong>steric number</strong> = the number of atoms bonded to the atom + the number of lone pairs the atom has.  

If the steric number is 4, the atom is $\mathrm{sp^3}$ hybridized.  

If the steric number is 3, the atom is $\mathrm{sp^2}$  hybridized.  

If the steric number is 2, the atom is $\mathrm{sp}$  hybridized.  

#### Answer 3 (score 18)
<p>Hybridization is given by the following formula:
$$H= \frac{1}{2} (V + X - C + A)$$
Where:</p>

<ul>
<li>$V$ = number of valence electrons in central atom<br/></li>
<li>$X$ = number of monovalent atoms around the central atom<br/></li>
<li>$C$ = positive charge on cation  </li>
<li>$A$ = negative charge on anion</li>
</ul>

$$H=4 \to \ce{sp^3},\;2\to \ce{sp,\;3}\to \ce{sp^2}...$$  

<p>e.g.: in $\ce{NH3}$, the hybridization of $\ce{N}$ atom is: 
$$H= \frac{1}{2}(5+3-0+0)=4 \to \ce{sp^3}$$</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: Positive or Negative Anode/Cathode in Electrolytic/Galvanic Cell (score [462714](https://stackoverflow.com/q/16785) in 2017)

#### Question
In a galvanic (voltaic) cell, the anode is considered negative and the cathode is considered positive. This seems reasonable as the anode is the source of electrons and cathode is where the electrons flow.  

However, in an electrolytic cell, the anode is taken to be positive while the cathode is now negative. However, the reaction is still similar, whereby electrons from the anode flow to the positive terminal of the battery, and electrons from the battery flow to the cathode.  

So why does the sign of the cathode and anode switch when considering an electrolytic cell?   

#### Answer accepted (score 37)
The anode is the electrode where the oxidation reaction  

<p>\begin{align}
 \ce{Red -&gt; Ox + e-}
\end{align}</p>

takes place while the cathode is the electrode where the reduction reaction  

<p>\begin{align}
 \ce{Ox + e- -&gt; Red}
\end{align}</p>

takes place. That's how cathode and anode are defined.  

<strong>Galvanic cell</strong>  

Now, in a galvanic cell the reaction proceeds without an external potential helping it along. Since at the anode you have the oxidation reaction which produces electrons you get a build-up of negative charge in the course of the reaction until electrochemical equilibrium is reached. Thus the anode is negative.  

At the cathode, on the other hand, you have the reduction reaction which consumes electrons (leaving behind positive (metal) ions at the electrode) and thus leads to a build-up of positive charge in the course of the reaction until electrochemical equilibrium is reached. Thus the cathode is positive.  

<strong>Electrolytic cell</strong>  

In an electrolytic cell, you apply an external potential to enforce the reaction to go in the opposite direction. Now the reasoning is reversed. At the negative electrode where you have produced a high electron potential via an external voltage source electrons are "pushed out" of the electrode, thereby reducing the oxidized species $\ce{Ox}$, because the electron energy level inside the electrode (Fermi Level) is higher than the energy level of the LUMO of $\ce{Ox}$ and the electrons can lower their energy by occupying this orbital - you have very reactive electrons so to speak. So the negative electrode will be the one where the reduction reaction will take place and thus it's the cathode.  

At the positive electrode where you have produced a low electron potential via an external voltage source electrons are "sucked into" the electrode leaving behind the the reduced species $\ce{Red}$ because the electron energy level inside the electrode (Fermi Level) is lower than the energy level of the HOMO of $\ce{Red}$. So the positive electrode will be the one where the oxidation reaction will take place and thus it's the anode.  

<strong>A tale of electrons and waterfalls</strong>  

Since there is some confusion concerning the principles on which an electrolysis works, I'll try a metaphor to explain it. Electrons flow from a region of high potential to a region of low potential much like water falls down a waterfall or flows down an inclined plane. The reason is the same: water and electrons can lower their energy this way. Now the external voltage source acts like two big rivers connected to waterfalls: one at a high altitude that leads towards a waterfall - that would be the minus pole - and one at a low altitude that leads away from a waterfall - that would be the plus pole. The electrodes would be like the points of the river shortly before or after the waterfalls in this picture: the cathode is like the edge of a waterfall where the water drops down and the anode is like the point where the water drops into.  

Ok, what happens at the electrolysis reaction? At the cathode, you have the high altitude situation. So the electrons flow to the "edge of their waterfall". They want to "fall down" because behind them the river is pushing towards the edge exerting some kind of "pressure". But where can they fall down to? The other electrode is separated from them by the solution and usually a diaphragm. But there are $\ce{Ox}$ molecules that have empty states that lie energetically below that of the electrode. Those empty states are like small ponds lying at a lower altitude where a little bit of the water from the river can fall into. So every time such an $\ce{Ox}$ molecule comes near the electrode an electron takes the opportunity to jump to it and reduce it to $\ce{Red}$. But that does not mean that the electrode is suddenly missing an electron because the river is replacing the "pushed out" electron immediately. And the voltage source (the source of the river) can't run dry of electrons because it gets its electrons from the power socket.  

Now the anode: At the anode, you have the low altitude situation. So here the river lies lower than everything else. Now you can imagine the HOMO-states of the $\ce{Red}$ molecules as small barrier lakes lying at a higher altitude than our river. When a $\ce{Red}$ molecule comes close to the electrode it is like someone opening the floodgates of the barrier lake's dam. The electrons flow from the HOMO into the electrode thus creating an $\ce{Ox}$ molecule. But the electrons don't stay in the electrode, so to speak, they are carried away by the river. And since the river is such a vast entity (lots of water) and usually flows into an ocean, the little "water" that is added to it doesn't change the river much. It stays the same, unaltered so that everytime a floodgate gets opened the water from the barrier lake will drop the same distance.  

#### Answer 2 (score 14)
The electrode at which oxidation takes place is known as the anode, while the electrode at which reduction take place is called the cathode.  

```text
Reduction -> cathode  
Oxidation -> anode
```

If you see galvanic cell reduction take place at the left electrode, so the left one is the cathode. Oxidation takes place at the right electrode, so the right one is the anode.  

While in electrolytic cell reduction takes place at the right electrode, so right one is the cathode. Oxidation takes place at the left electrode, so the left one is the anode.  

<img src="https://i.stack.imgur.com/p1mke.jpg" alt="enter image description here">  

#### Answer 3 (score 4)
I'm no expert nor scholar, but from what I am reading in all of these explanations, and what  I notice from the illustration, it becomes obvious...at least to me...which I feel may clarify the polarity change between the Galvanic cell and electrolytic cell for this user.  

As established and understood, the source of electrons and transfer of ions flows from the negative pole, (Anode) and is received by the positive pole (Cathode) (intentionally using most basic terms) the anode is negative here because the the flow originates FROM the electrolyte, into the light bulb, for which, if the terminals of the bulb were labeled, they would match the electrolyte in the other cell as it is the force coming from the bulb pushing the flow to the cell's cathode, and the cell's cathode is pulling from the bulb.  

In the electrolytic cell, the "electrolyte" is taking the role of the light bulb of the Galvanic cell, since the electrons are being SENT TO it from the power source, and is not in itself the SOURCE of flow, but is SUBJECT TO the force from the source of flow.   

SO just as the Galvanic cell's anode sends to the light bulb, and the electrolyte is labeled like the load of the galvanic cell, and transferring its incoming negative force from the current source, and this pushes through the electrolyte like the flow FROM the light bulb.  

It may be easier if you note that the SOURCE of power is NOT the electrolyte and technically, the black terminal of the power supply is the TRUE anode (Sending), and the red side the TRUE Cathode, (Receiving) but when identifying the reactive substance submerged/surrounded by the electrolytic substance, the anode is giving up its ions, which then add to the Cathode which is receiving them.     

Therefore the tags in the electrolytic cell are not naming the "source of flow", but the reaction of the substances involved, due TO the force/flow imposed on them from the power source, but is not THE source of power, and therefore should not be labeled AS one...and there are only two options for labeling them, and since it cannot be changed at the power source it can only b changed at the point of contact with the electrolyte!     

At least this is what I have come to understand by reviewing the comments and illustrations.  

I sincerely hope it helps clarify the rationale for the reversal of labels for this user and any others struggling with the concept of being due to the source of current having to be labeled as - Anode and + Cathode... forcing the object the current plays upon to be the opposite despite their poles and due to direction of flow.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: Why does ice water get colder when salt is added? (score [430421](https://stackoverflow.com/q/5748) in 2017)

#### Question
It is well known that when you add salt to ice, the ice not only melts but will actually get colder. From chemistry books, I've learned that salt will lower the freezing point of water. But I’m a little confused as to why it results in a drop in temperature instead of just ending up with water at 0 °C.  

What is occurring when salt melts the ice to make the temperature lower?  

#### Answer accepted (score 28)
When you add salt to an ice cube, you end up with an ice cube whose temperature is above its melting point.  

This ice cube will do what any ice cube above its melting point will do: it will melt. As it melts, it cools down, since energy is being used to break bonds in the solid state.  

(Note that the above point can be confusing if you're new to thinking about phase transitions. An ice cube melting will take up energy, while an ice cube freezing will give off energy. I like to think of it in terms of Le Chatelier's principle: if you need to lower the temperature to freeze an ice cube, this means that the water gives off heat as it freezes.)  

The cooling you get, therefore, comes from the fact that some of the bonds in the ice are broken to form water, taking energy with them. The loss of energy from the ice cube is what causes it to cool.  

#### Answer 2 (score 7)
We know that melting or freezing is an equilibrium process. The energy that is required to melt an ice cube will not contribute in elevating its temperature until all the solid water is molten.  

If we take two ice cubes and add salt to one of them, then put each of them at room temperature, both of the ice cubes will absorb energy from the surroundings, and this energy as we said will contribute in breaking down the bonds between water molecules.   

The cube that salt has not been added to, has a melting point $0~\mathrm{^\circ C}$ and so if we measure its temperature during melting it will remain zero until all ice is molten. That ice cube to which we have added salt, the salt that is added lowers the melting and freezing points of water because it lowers the vapor pressure of water. This ice cube will absorb energy from the environment to help break bonds between water molecules. We know that the salt added will dissolve in the melted portion of the ice. This formed solution of salt will have a lowered freezing point, so the equilibrium between the solid phase and the aqueous phase will be shifted towards the liquid phase since such a solution will freeze at say $-2~\mathrm{^\circ C}$. Since both phases are close together, the ice will absorb energy from the salt solution and will reduce its temperature to the $-2~\mathrm{^\circ C}$ to maintain the equilibrium. When all ice is molten we end up with a salt solution that has got a temperature of say $-1.5~\mathrm{^\circ C}$. This is due to the solution being diluted now. After that, it will start absorbing heat from the room and reach zero and above. So, in conclusion that is how salt melts ice.  

#### Answer 3 (score 3)
A mixture of water and ice stabilizes at the freezing point of water.  

If the ice were any colder, it would absorb heat from the water, in the process raising its own temperature while freezing some part of the water.  

If the water is any hotter, it will cool down by melting some of the ice.  

This works because ice thawing is endothermic; energy (heat) is used up to turn solid into liquid even though the temperature is staying the same.  

The freezing point of water is $0 \pu{°C}$, so water-ice slush stays at $0 \pu{°C}$. If it was lower, it would stabilize at the lower temperature. By adding salt, you are lowering the freezing temperature. The mixture stabilizes there and is colder.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Why is it important to use a salt bridge in a voltaic cell? Can a wire be used? (score [299285](https://stackoverflow.com/q/5477) in 2017)

#### Question
I was learning about voltaic cells and came across salt bridges. If the purpose of the salt bridge is only to move electrons from an electrolyte solution to the other, then why can I not use a wire?  

Also, will using $\ce{NaCl}$ instead of $\ce{KNO3}$ in making the salt bridge have any effects on voltage/current output of the cell? why?  

Plus if it matters, I'm using a Zinc-Copper voltaic cell with a tissue paper soaked in $\ce{KNO3}$ as salt bridge  

#### Answer accepted (score 45)
<a href="https://chemistry.stackexchange.com/questions/2644">There's another question</a> related to salt bridges on this site.  

The purpose of a salt bridge is <strong>not</strong> to move electrons from the electrolyte, rather it's to maintain charge balance because the electrons are moving from one-half cell to the other.  

<img src="https://i.stack.imgur.com/fLfN9.png" alt="enter image description here">  

The electrons flow from the anode to the cathode.  The oxidation reaction that occurs at the anode generates electrons and positively charged ions.  The electrons move through the wire (and your device, which I haven't included in the diagram), leaving the unbalanced positive charge in this vessel.  In order to maintain neutrality, the negatively charged ions in the salt bridge will migrate into the anodic half cell.  A similar (but reversed) situation is found in the cathodic cell, where $\ce{Cu^{2+}}$ ions are being consumed, and therefore electroneutrality is maintained by the migration of $\ce{K+}$ ions from the salt bridge into this half cell.  

Regarding the second part of your question, it is important to use a salt with inert ions in your salt bridge. In your case, you probably won't notice a difference between $\ce{NaCl}$ and $\ce{KNO3}$ since the $\ce{Cu^{2+}}$ and $\ce{Zn^{2+}}$ salts of $\ce{Cl-}$ and $\ce{NO3-}$ are soluble. There will be a difference in the <a href="https://www.youtube.com/watch?v=qQoDML0miVg" rel="noreferrer">liquid junction potential</a>, but that topic is a bit advanced for someone just starting out with voltaic/galvanic cells.  

#### Answer 2 (score 13)
Without the salt bridge, the solution in the anode compartment would become positively charged and the solution in the cathode compartment would become negatively charged, because of the charge imbalance, the electrode reaction would quickly come to a halt.  

It helps to maintain the flow of electrons from the oxidation half-cell to a reduction half cell, this completes the circuit.  

#### Answer 3 (score 9)
The purpose of the salt bridge is to move <em>ions</em>.  

If you use enough electrolyte solution on both sides, though, it doesn't matter;  in that case, the salt bridge can be neglected.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Saturated vs unsaturated fats - Structure in relation to room temperature state? (score [223452](https://stackoverflow.com/q/4058) in 2017)

#### Question
I'm sure most of us have heard that saturated fats are solid at room temperature, and unsaturated fats are liquid at room temperature. I'm wondering how this relates to their chemical structure -- saturated fats contain only single bonds between carbons, yet to qualify as an unsaturated fat a C=C double bond must exist.  

Since a double bond is stronger than a single bond, and the length of the C=C double bond is shorter than that of the single bond, why is it that the fat containing a double bond is a liquid and saturated fats are solids at room temperature? Seems like the double bond would inhibit movement and the resulting substance would be less like olive oil and more like butter.   

#### Answer accepted (score 14)
In the solid state, the individual triacylglycerol molecules are interacting with each other primarily through Van der Waals interaction. These weak bonds between molecules are broken at the solid-liquid transition. The amount of energy needed to disrupt these interactions (which determines the melting point of the fat or oil) is determined by the energy associated with all of these bonds added together. In a saturated fat, the acyl chains are able to align perfectly right along their length, maximizing intermolecular interactions. This effect is reflected in the fact that the melting temperature of a pure triacylglycerol increases as the chain length increases.   

You can see this effect clearly in the melting temperatures of individual fatty acids. (C18:0 means an 18 carbon molecule with zero double bonds in the acyl chain):   

<blockquote>
  C18:0 (stearic acid) 70&deg;C   
  
  C16:0 (palmitic acid) 63&deg;C  
  
  C14:0 (myristic acid) 58&deg;C  
</blockquote>

So the addition of a single -CH<sub>2</sub>- group in the acyl chain increases melting temperature by a few degrees.  

When a cis double bond is introduced into the acyl chain this creates a kink in the structure. Because of this, the acyl chains cannot align completely along their length - they don't pack together as well. Because of this, the sum of the energy associated with intermolecular Van der Waals interactions is reduced. Again this is seen clearly in the melting temperatures of fatty acids:  

<blockquote>
  stearic acid C18:0 70&deg;C  
  
  oleic acid C18:1 16&deg;C  
</blockquote>

As you can see from these numbers, the effect of introducing a double bond is large compared to the chain length effect.  

A typical fat or oil will, of course, be a mixture of different triacylglycerols, but the underlying principle is the same.  

#### Answer 2 (score 14)
In the solid state, the individual triacylglycerol molecules are interacting with each other primarily through Van der Waals interaction. These weak bonds between molecules are broken at the solid-liquid transition. The amount of energy needed to disrupt these interactions (which determines the melting point of the fat or oil) is determined by the energy associated with all of these bonds added together. In a saturated fat, the acyl chains are able to align perfectly right along their length, maximizing intermolecular interactions. This effect is reflected in the fact that the melting temperature of a pure triacylglycerol increases as the chain length increases.   

You can see this effect clearly in the melting temperatures of individual fatty acids. (C18:0 means an 18 carbon molecule with zero double bonds in the acyl chain):   

<blockquote>
  C18:0 (stearic acid) 70&deg;C   
  
  C16:0 (palmitic acid) 63&deg;C  
  
  C14:0 (myristic acid) 58&deg;C  
</blockquote>

So the addition of a single -CH<sub>2</sub>- group in the acyl chain increases melting temperature by a few degrees.  

When a cis double bond is introduced into the acyl chain this creates a kink in the structure. Because of this, the acyl chains cannot align completely along their length - they don't pack together as well. Because of this, the sum of the energy associated with intermolecular Van der Waals interactions is reduced. Again this is seen clearly in the melting temperatures of fatty acids:  

<blockquote>
  stearic acid C18:0 70&deg;C  
  
  oleic acid C18:1 16&deg;C  
</blockquote>

As you can see from these numbers, the effect of introducing a double bond is large compared to the chain length effect.  

A typical fat or oil will, of course, be a mixture of different triacylglycerols, but the underlying principle is the same.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: Difference between shells, subshells and orbitals (score [218518](https://stackoverflow.com/q/18466) in 2014)

#### Question
What are the definitions of these three things and how are they related? I've tried looking online but there is no concrete answer online for this question.  

#### Answer accepted (score 34)
Here's a graphic I use to explain the difference in my general chemistry courses:  

<img src="https://i.stack.imgur.com/i8V5L.png" alt="Shells, sub-shells, and orbitals">  

<ul>
<li>All electrons that have the same value for <strong>$n$</strong> (the principle quantum number) are in the same <strong>shell</strong></li>
<li>Within a shell (same $n$), all electrons that share the same <strong>$l$</strong> (the angular momentum quantum number, or orbital shape) are in the same <strong>sub-shell</strong></li>
<li>When electrons share the same <strong>$n$</strong>, <strong>$l$</strong>, and <strong>$m_l$</strong>, we say they are in the same <strong>orbital</strong> (they have the same energy level, shape, and orientation)</li>
</ul>

So to summarize:  

<ul>
<li>same $n$ - shell</li>
<li>same $n$ and $l$ - sub-shell</li>
<li>same $n$, $l$, and $m_l$ - orbital</li>
</ul>

Now, in the other answer, there is some discussion about spin-orbitals, meaning that each electron would exist in its own orbital. For practical purposes, you don't need to worry about that - by the time those sorts of distinctions matter to you, there won't be any confusion about what people mean by "shells" and "sub-shells." For you, for now, orbital means "place where up to two electrons can exist," and they will both share the same $n$, $l$, and $m_l$ values, but have opposite spins ($m_s$).  

#### Answer 2 (score 10)
Have a look <a href="http://chemed.chem.purdue.edu/genchem/topicreview/bp/ch6/quantum.html#shells" rel="noreferrer">here</a>:  

<blockquote>
  Orbitals that have the same value of the principal quantum number $n$ form a shell. Orbitals within a shell are divided into subshells that have the same value of the angular quantum number $l$. Chemists describe the shell and subshell in which an orbital belongs with a two-character code such as 2p or 4f. The first character indicates the shell (n = 2 or n = 4). The second character identifies the subshell. By convention, the following lowercase letters are used to indicate different subshells.  
  
  <ul>
  <li>s:         l = 0</li>
  <li>p:         l = 1</li>
  <li>d:         l = 2</li>
  <li>f:         l = 3</li>
  </ul>
</blockquote>

<p>What is called an orbital might differ according to the context.
With orbitals in the context of shells and subshells one usually means atomic orbitals, i.e. two-electron eigenstates of an atom's Hamilton operator which are characterized by the three quantum numbers: the principal quantum number $n$, the angular quantum number $l$ and the magnetic quantum number $m$.
But often the word orbital is also used for spin-orbitals, i.e. one-electron eigenstates of the system's one-electron Hamilton operator which are characterized not only by $n$, $l$ and $m$ but also by the spin quantum number $m_{\mathrm{s}}$ which can be either $+\frac{1}{2}$ or $-\frac{1}{2}$.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: What's the difference between alpha-glucose and beta-glucose? (score [217712](https://stackoverflow.com/q/7308) in 2016)

#### Question
What's the difference between $\alpha$-D-glucose and $\beta$-D-glucose? Are they isomers? Or do they differ in their elemental composition?  

#### Answer accepted (score 26)
$\alpha$-D-glucose and $\beta$-D-glucose are stereoisomers - they differ in the 3-dimensional configuration of atoms/groups at one or more positions.   

<blockquote>
  $\alpha$-D-glucose   
</blockquote>

<img src="https://i.stack.imgur.com/MYOEj.png" alt="enter image description here">  

<blockquote>
  $\beta$-D-glucose  
</blockquote>

<img src="https://i.stack.imgur.com/JUzVl.png" alt="enter image description here">  

Note that the structures are almost identical, except that in the $\alpha$ form, the $\ce{OH}$ group on the far right is <strong>down</strong>, and, in the $\beta$ form, the $\ce{OH}$ group on the far right is <strong>up</strong>.  

More specifically, they are a class of stereoisomer called an <a href="http://en.wikipedia.org/wiki/Anomer" rel="noreferrer">anomer</a>. Anomers are capable of interconverting in solution. All cyclic structures of monosaccharides exhibit anomeric $\alpha$ (down) and $\beta$ (up) versions. These differences occur at the anomeric acetal carbon (the only carbon with two $\ce{C-O}$ bonds.  

These two forms exist because all monosaccharides also have an open-chain form with <strong>one fewer stereocenter</strong>. When the chain closes to the cyclic structure, the aldehyde or ketone carbon becomes a <a href="http://en.wikipedia.org/wiki/Chirality_%28chemistry%29#Stereogenic_centers" rel="noreferrer">stereocenter</a>, and it can do so in either configuration. One configuration is preferred ($\beta$), but both exist.   

<blockquote>
  Open chain form of glucose:  
</blockquote>

<img src="https://i.stack.imgur.com/71elQ.png" alt="enter image description here">  

In the presence of acid or base (although water can fulfill this role if need be), the two anomers interconvert through the open form until dynamic equilibrium is established. The mechanism below starts with $\alpha$ in the upper left and finishes with $\beta$ in the lower right. The open-chain form is in the middle.  

<img src="https://i.stack.imgur.com/ah5Ov.png" alt="enter image description here">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Is it actually possible to dispose of a body with hydrofluoric acid? (score [216913](https://stackoverflow.com/q/4877) in 2015)

#### Question
In the TV show "Breaking Bad", Walter White frequently gets rid of people who get in his way by submerging them in a plastic container full of hydrofluoric acid. This, at least in the TV show, completely dissolves the body leaving nothing but a red sludge behind at the end.  

Is it actually possible to dispose of a body with hydrofluoric acid?  

If hydrofluoric acid wouldn't work, are there any acids corrosive enough to achieve the stated effect from the show?  

#### Answer accepted (score 85)
Hydrofluoric acid is toxic and corrosive, but actually isn't that strong of an acid compared to other hydrohalic acids; the fluorine has a very good orbital overlap with hydrogen and is also not very polarizable, therefore it resists donating its proton, unlike other hydrohalic acids which are good proton donators. It will break down some tissues, but it will take a relatively long time and won't turn the entire body into stuff that can be rinsed down the drain. Hydrochloric acid is a much stronger acid, and as it has several uses from pH-balancing pool water to preparing concrete surfaces, it's available by the gallon from any hardware store. However, it isn't very good at dissolving bodies either; while it will eventually work by breaking down the connective tissues, it will make a huge stink and take several days to dissolve certain types of tissues and bones.  

The standard body-dissolving chemical is lye aka sodium hydroxide. The main source is drain clog remover because most drain clogs are formed by hair and other bio-gunk that accumulates naturally when humans shower, exfoliate etc. It works, even though the body's overall chemistry is slightly to the basic side of neutral (about 7.35-7.4) because the hydroxide anion is a strong proton acceptor. That means that it strips hydrogen atoms off of organic molecules to form water (alkaline hydrolysis, aka saponification), and as a result, those organic molecules are turned into simpler molecules with lower melting points (triglycerides are turned into fatty acids, saturated fats are dehydrogenated to form unsaturated fats, alkanes become alcohols, etc). Sodium hydroxide is also a ready source of the sodium ion; sodium salts are <em>always</em> water-soluble (at least I can't think of a single one that isn't). The resulting compounds are thus either liquids or water-soluble alcohols and salts, which flush down the drain. What's left is the brittle, insoluble calcium "shell" of the skeleton; if hydrolyzed by sodium hydroxide, the resulting calcium hydroxide ("slaked lime") won't dissolve completely but is relatively easy to clean up.  

#### Answer 2 (score 29)
I think the use of Hydrofluoric Acid was script-driven rather than fact driven: it sounds scary rather than being a good choice. Also, it allows for the possibility of the darkly comic bathtub scene where the acid dissolves a ceramic bath because Jessie ignores Walter's instructions (which establishes Walter's expertise and Jessie's lack of it).  

There is no good reason why Pinkman and White pharmaceuticals needed to have hydrofluoric acid, therefore using large quantities of it is somewhat implausible.  

Moreover, it probably wouldn't work as well as several alternatives. Hydrofluoric acid is very nasty stuff, but it isn't a strong acid. Even when dilute it will etch glass and ceramics, but it won't dissolve or burn flesh. I once saw a demonstration where a lecturer showed this by spilling some dilute hydrofluoric acid on his hand and then onto a glass surface. The surface was frosted, his hand unharmed (he was very careful to wash the acid off quickly and take appropriate precautions and I don't recommend trying this at home!)  

Its danger to people is its toxicity, not its ability to burn: it insinuates itself into the body and destroys connective tissue and bone slowly by interfering with anything containing calcium. Its danger is worse because it doesn't cause <em>immediate</em> damage and you may receive a dangerous dose without noticing. So it is scary but not corrosive.  

Other alternatives are better. Concentrated alkalis such as Sodium Hydroxide are readily available and are very good at dissolving flesh (which is why they are commonly used as drain cleaners). But alkalis don't do a good job on bone. Concentrated sulfuric acid is even better as it does a good job on flesh and will, eventually, dissolve the bone as well. Murderers have used both methods to try to dispose of evidence. For example, John George Haigh who used sulfuric acid and left little other than gallstones (<a href="http://en.wikipedia.org/wiki/John_George_Haigh" rel="noreferrer">http://en.wikipedia.org/wiki/John_George_Haigh</a>). Using alkali is often done but tends to leave bone fragments even with sophisticated processes that pressure cook the solution (see <a href="http://www.slate.com/articles/news_and_politics/explainer/2009/12/soluble_dilemma.html" rel="noreferrer">http://www.slate.com/articles/news_and_politics/explainer/2009/12/soluble_dilemma.html</a>).  

So I think the answer is that HF solutions are not a good choice for body disposal as it probably doesn't work well compared to known alternatives.  

<strong>Update</strong>  

A lot of the above is <em>theory</em> but good scientists do experiments. So Periodic Videos decided to test this very idea using chicken legs as a model. They compared what happens when raw chicken legs are suspended in strong solutions of HCl, H<sub>2</sub>SO<sub>4</sub> and HF. The HF was the least impressive for flesh-dissolving characteristics, though it did seem to cause other, more subtle damage, to the components of the flesh.   

See the actual results <a href="https://www.youtube.com/watch?v=oipksRhISfM" rel="noreferrer">here</a>.  

#### Answer 3 (score 13)
<p>Here in Mexico, a guy was arrested a couple years ago for "dissolving" more than 300 bodies killed by the cartels.
They found 55-gallon drums around town with a sludge in it, usually with a note to warn other. 
His recipe?
A 55-gallon drum, several bags of lye, add body, fill with h20, and build fire beneath drum.</p>

It took about 24hrs I believe.   

<p>Sorry, I got caught up In the comments. And I'm New to this and all (bulletin boards?)
Like the case in Australia with sealed drums w/ HCL, in a bank vault, it Actually did more to preserve the bodies. I am no chemist, but it is my understanding, that when acids burn the skin the results are the same for both Fire and chemicals burns both rapidly dehydrate the body, destroying it. But is in a sealed container, that water can only go to the lid. Stopping the process. 
I bet any acid will destroy a body.
When you're in the bath or pool too long you get those wrinkles, I've heard of people with wet feet in boots for weeks, remove their boots, and literally stripping the flesh off their feet to the bone.</p>

<p>The issue is how long will it take like the method used in here in Mexico and another post, boiling seems to be an important component. And again I'm guessing (and vegetarian), the heat tenderizes the meat, helping the acid along, but also the rolling of the water stirs it. If you were to put a piece of meat in acid that was stagnant, the acid might react, dissolve some meat, as the dissolved meat dilutes the acid depending on the makeup. It could settle or form a layer of meat/acid that sits on top of the meat, protecting it. Think layered shots. Or a unflushed end toilet that has had time to settle. 
Hydrofluoric acid will eat thru skin, google it. One of the reasons the burns are so bad is @ 50%, it can take 8 hours to realize you were burned.
So that would be a slow process, and fluoride, as we know, preserves teeth, by extension bones. And for hydrofluoric acid burns, the standard treatment is calcium.
So it would be very slow, very likely stop, possible preserve the bones, making the resistant to rotting and harden them, but as your, we'll my fingers have less meat than most parts of my body, it would get to bone faster, ossicle dissolving some calcium, then render all the acid useless. 
Again I am not a chemist but have self-studied chemistry for years, I would be very interested to hear anyone else's opinions on my determinations!</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: Why do transition elements make colored compounds? (score [214190](https://stackoverflow.com/q/4667) in 2015)

#### Question
Why do transition metals element  make colored compounds both in solid form and in solution? Is it related to their electrons?  

#### Answer accepted (score 21)
You are absolutely correct, it all about the metal's electrons and also about their d orbitals.   

Transition elements are usually characterised by having d orbitals. Now when the metal is not bonded to anything else, these d orbitals are degenerate, meaning that they all have the same energy level.  

However when the metal starts bonding with other ligands, this changes. Due to the different symmetries of the d orbitals and the inductive effects of the ligands on the electrons, the d orbitals split apart and become non-degenerate (have different energy levels).  

This forms the basis of <strong>Crystal Field Theory</strong>. How these d orbitals split depend on the geometry  of the compound that is formed. For example if an octahedral metal complex is formed, the energy of the d orbitals will look like this:  

<a href="https://i.stack.imgur.com/vAkr4.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/vAkr4.gif" alt="enter image description here"></a>  

As you can see, previously the d orbitals were of the same energy, but now 2 of the orbitals are higher in energy. Now what does this have to do with its colour?  

Well, electrons are able to absorb certain frequencies of electromagnetic radiation to get promoted to higher energy orbitals. These frequencies have a certain energy which correspond to the energy difference between different orbitals. Now most substances are only able to absorb frequencies of radiation which are outside the visible light spectrum, for example they might be able to absorb radiation which has a frequency of $300$GhZ (that is infrared radiation). This means that it reflects all other types of radiation, including the full spectrum of visible light. So our eyes see a mixture of all the colours; red, green, blue, violet, etc. This is seen as white (this is why several organic compounds are white).   

However transition metals are special in that the energy difference between the non-degenerate d orbitals correspond to the energy of radiation of the visible light spectrum. This means that when we look at the metal complex, we don't see the entire visible light spectrum, but only a part of it.   

So for example, if the electrons in an octahedral metal complex are able to absorb green light and get promoted from the $d_{yz}$ orbital to the $d_{z^2}$ orbital, the compound will reflect all other colours except for green. Therefore by using the colour wheel, we can find the complementary colour of green which will be the colour of the compound, which is magneta.  

<a href="https://i.stack.imgur.com/MjBsV.gif" rel="noreferrer"><img src="https://i.stack.imgur.com/MjBsV.gif" alt="enter image description here"></a>  

This explains why <strong>not all</strong> transition metal complexes are colourful. For example copper sulfate is a bright blue compound, however zinc sulfate on the hand is a white compound despite being a transition metal. The reason behind this is because zinc's d orbitals are completely filled up with electrons, meaning that it is not possible for any electron to make a d-> d transition as they are all filled up. Hence you might sometimes see zinc referred as not being a transition metal.    

#### Answer 2 (score 16)
The partially full d-orbitals in transition metals have energy splittings that happen to lie in the visible range.  Depending on the arrangement of substituents (known as ligands) that attach to them, the electron energies split according to <a href="http://en.wikipedia.org/wiki/Crystal_field_theory#Explaining_the_colors_of_transition_metal_complexes" rel="nofollow noreferrer" title="crystal field splitting">crystal field theory</a>.  Similar splitting in the s or p orbitals produce gaps in the ultraviolet, and any visible light goes right through, so we don't see any color.  In transition metals, however, visible light excites the electrons from a lower d orbital to a higher one and only letting some light through.  

#### Answer 3 (score 1)
Colored compounds of transition elements are associated with partially filled (n-1)d orbitals. Tthe transition metal ions containing unpaired d-electrons undergoes an electronic transition from one d-orbital to another. During this d-d transition process, the electrons absorb certain energy from the radiation and emit the remainder of energy as colored light. The color of ion is complementary of the color absorbed by it. hence, colored ion is formed due to d-d transition which falls in the visible region for all transition elements.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: How do I type a simple chemical equation in Microsoft Word? (score [201404](https://stackoverflow.com/q/2509) in 2016)

#### Question
How do I type a simple chemical equation in Microsoft Word? I can do subscripts, but long arrows are more difficult. I can't get them to align with the text.  

Also, I can't figure out how to put a delta above the arrow for heat. I have tried the Chemistry add-on from Microsoft, but that does not seem to help with equations.   

#### Answer accepted (score 30)
If you are using MS Word 2007 or newer, use the equation feature. It is designed for math but works okay for chemistry.  

Go to the insert tab. (For shortcut you can press Alt+= sight together)  

<img src="https://i.stack.imgur.com/LBF2v.png" alt="enter image description here">  

Click on the equation button on the far right.  

<img src="https://i.stack.imgur.com/Ix52E.png" alt="enter image description here">  

Type in your equation. Use the buttons in the ribbon to do superscripts and subscripts. Alternatively you can use _ for subscript and ^ for superscript.  The default is to have letters italicized (as variables), so you will want to fix that.   

<img src="https://i.stack.imgur.com/kRCce.png" alt="enter image description here">  

There are also shortcut commands to render most the common things you want. For example, underscore _ creates a subscript and a caret ^ creates a superscript <a href="https://www.youtube.com/watch?v=SdzgM9GacCY&amp;t=21s" rel="noreferrer">Shortcut for typing subscript and superscript in MS Word 2007|2010|2013|2016 and office 365</a>  . You have access to a wide range of arrows from a pull-down menu, but -> will give you a simple right arrow (although it is not very long). This feature on Word will also accept some (but not all) <a href="http://tex.stackexchange.com">tex</a> commands for formatting equations.  

To get a long arrow, click on the operator but and choose the arrow with the word "yields" written over it under common operator structures. For up arrow and down arrow showing gas liberation and precipitation use \\uparrow or \downarrow followed by space <a href="https://cpgupta1201.wordpress.com/2018/09/21/quickest-way-to-type-chemical-reaction-chemical-equation-reaction-arrows-in-word-2007-above/" rel="noreferrer">Shortcut for typing arrows of chemical equation in Word 2007 and above</a>.    

<img src="https://i.stack.imgur.com/o0yC6.png" alt="enter image description here">  

Click on the word "yields" and replace it with as many spaces as you need to create an arrow of whatever length you want. Shortcut for other types of arrows is.  

<img src="https://i.stack.imgur.com/NjD8m.png" alt="enter image description here">  

Finally, finish your equation.  

<img src="https://i.stack.imgur.com/fgTro.png" alt="enter image description here">  

If you need to type above or below arrow just type "\above(text above arrow goes here)[space]".Similarly tying below arrow just type \below(test below goes here)[space]". <a href="https://www.youtube.com/watch?v=IXML84P3P-c&amp;t=29s" rel="noreferrer">How to type chemical equation and arrows in Word 2007 and above</a>.  

For older versions of MS Word, go to the insert menu and click on the equation, which launches the Equation Editor Program (you can also find this program on your computer by searching for eqnedt.exe), which gives you the same ability to create equations.  

#### Answer 2 (score 18)
Even though your question has already been answered (and this is not an alternative answer), but if you're open to it, switching from Word to LaTeX with the <a href="http://www.math.washington.edu/tex-archive/macros/latex/contrib/chemmacros/chemmacros_en.pdf">`chemmacros`</a> package (PDF) will benefit you greatly in the long run.  

#### Answer 3 (score 4)
The answer mentioned above is correct but there is also a shortcut built in which is math autocorrect. It is much like LaTeX. By default it's inactive but you can activate it and is really helpful if you want to write big equations. For example, if you want to type $\ce{H2}$H then you just have to type H_2.  

Many more options are available. For example, if you want a superscript character, the caret (^) sign will be converted as superscript. Many such shortcuts are covered in <a href="https://www.youtube.com/playlist?list=PLbTE-xLDPxtBP-TE2fS1MysSqFCkHh1N3" rel="nofollow noreferrer">these videos</a> or you can simply search for How to insert mathematical equation (like LaTeX) in Ms-Office: Tips and tricks on YouTube.  

These methods will be especially helpful if you are a fast at typing. Moreover, it will save your time which is lost while switching between keyboard and mouse and searching proper option in Word.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How to determine number of structural isomers? (score [201234](https://stackoverflow.com/q/16135) in 2019)

#### Question
I have come across many questions where I'm asked to give the number of possible structural isomers. For example number, <a href="http://www.madsci.org/posts/archives/1997-12/878572346.Ch.r.html" rel="nofollow noreferrer">structural isomers of hexane</a> is 5, while the number structural isomers of decane is 75.  

How can I determine the possible number of structural isomers of a given organic compound?  

#### Answer accepted (score 22)
<p>(1) As for the number of alkanes ($\ce{C_nH_{2n+2}}$),  Table 1, which is extracted from the data reported in 
<a href="http://match.pmf.kg.ac.rs/electronic_versions/Match57/n2/match57n2_299-340.pdf" rel="noreferrer">
S. Fujita, <I>MATCH Commun. Math. Comput. Chem.</I>, <B>57</B>, 
299--340 (2007)</a> (access free), 
shows the comparison between two enumerations based on 
Polya's theorem and on Fujita's proligand method. </p>

<a href="https://i.stack.imgur.com/kAbs7.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/kAbs7.jpg" alt="enter image description here"></a>  

<p>The number of alkanes ($\ce{C_nH_{2n+2}}$) 
as constitutional isomers (structural isomers) and as steric isomers 
is calculated by Polya's theorem (G. Polya and R. C. Read, 
<a href="http://link.springer.com/book/10.1007/978-1-4612-4664-0/page/1" rel="noreferrer">
Combinatorial Enumeration of Groups, Graphs, and Chemical Compounds</a>, Springer (1987)). 
In the process of calculating constitutional isomers, 
one 2D structure (graph or constitution) is counted just once. 
In the process of calculating steric isomers, one achiral molecule or each chiral molecule 
of an enantiomeric pair is counted just once, where achiral molecules and chiral molecules 
are not differentiated from each other. </p>

<p>On the other hand, 
the number of alkanes ($\ce{C_nH_{2n+2}}$) 
as three-dimensional (3D) structural isomers 
and as steric isomers is 
calculated by Fujita's proligand method 
(S. Fujita, 
<a href="http://match.pmf.kg.ac.rs/mcm15.html" rel="noreferrer">
Combinatorial Enumeration of Graphs, Tree-Dimensional Structures, and 
Chemical Compounds</a>, Unversity of Kragujevac (2013)). 
In the process of calculating 3D structural isomers, 
one achiral molecule or one pair of enantiomers is counted just once, 
where achiral molecules and chiral molecules (enantiomeric pairs) 
are differentiated from each other. </p>

<p>For more information, see an account article entitled 
"Numbers of Alkanes and Monosubstituted Alkanes. 
A Long-Standing Interdisciplinary Problem over 130 Years" 
(<a href="https://www.jstage.jst.go.jp/article/bcsj/83/1/83_20090008/_pdf" rel="noreferrer">
S. Fujita, <I> Bull. Chem. Soc. Japan</I>, <B>83</B>, 1--18 (2010)</a>, 
access free). This account article has discussed the difference between graph enumeration (Polya's theorem) and 3D structural enmeration (Fujita's proligand method) during recursive calculation. </p>

<p>It should be emphasized that graph-theoretical enumerations of chemical compounds 
as constitutional isomers (structural isomers) and as steric isomers (based on asymmetry) 
should be differentiated from stereochemical enumerations of chemical compounds 
as 3D structural isomers and as steric isomers (based on chirality). 
Although steric isomers based on asymmetry (graphs governed by permutation groups) and 
steric isomers based on chirality (3D structures governed by point groups) give identical 
enumeration results, they are conceptually different entities. 
This point of view stems from Fujita's stereoisogram approach, 
which is described in a recent book 
(S. Fujita <a href="http://www.degruyter.com/view/product/431387" rel="noreferrer">
Mathematical Stereochemistry</a>, De Gruyter (2015)).</p>

<p>(2) Enumeration of achiral and chiral alkanes of a given carbon content has been 
conducted by considering internal branching 
(<a href="http://doi.org/10.1246/bcsj.81.1423" rel="noreferrer">
S. Fujita, <I>Bull. Chem. Soc. Jpn.</I>, <B>81</B>, 1423--1453 (2008)</a>). 
Figure 3 of this report is cited below. </p>

<a href="https://i.stack.imgur.com/dCRHj.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/dCRHj.jpg" alt="enter image description here"></a>  

<p>The symbol [q, t, s, p] means 
the presence of q quaternary carbons, t tertiary carbons, s secondary carbons, 
and p primary carbons. Alkanes are categorized into 
centroidal and bicentroidal alkanes, which are the 3D extension of 
centroidal and bicentroidal trees of graph theory.</p>

#### Answer 2 (score 22)
<p>(1) As for the number of alkanes ($\ce{C_nH_{2n+2}}$),  Table 1, which is extracted from the data reported in 
<a href="http://match.pmf.kg.ac.rs/electronic_versions/Match57/n2/match57n2_299-340.pdf" rel="noreferrer">
S. Fujita, <I>MATCH Commun. Math. Comput. Chem.</I>, <B>57</B>, 
299--340 (2007)</a> (access free), 
shows the comparison between two enumerations based on 
Polya's theorem and on Fujita's proligand method. </p>

<a href="https://i.stack.imgur.com/kAbs7.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/kAbs7.jpg" alt="enter image description here"></a>  

<p>The number of alkanes ($\ce{C_nH_{2n+2}}$) 
as constitutional isomers (structural isomers) and as steric isomers 
is calculated by Polya's theorem (G. Polya and R. C. Read, 
<a href="http://link.springer.com/book/10.1007/978-1-4612-4664-0/page/1" rel="noreferrer">
Combinatorial Enumeration of Groups, Graphs, and Chemical Compounds</a>, Springer (1987)). 
In the process of calculating constitutional isomers, 
one 2D structure (graph or constitution) is counted just once. 
In the process of calculating steric isomers, one achiral molecule or each chiral molecule 
of an enantiomeric pair is counted just once, where achiral molecules and chiral molecules 
are not differentiated from each other. </p>

<p>On the other hand, 
the number of alkanes ($\ce{C_nH_{2n+2}}$) 
as three-dimensional (3D) structural isomers 
and as steric isomers is 
calculated by Fujita's proligand method 
(S. Fujita, 
<a href="http://match.pmf.kg.ac.rs/mcm15.html" rel="noreferrer">
Combinatorial Enumeration of Graphs, Tree-Dimensional Structures, and 
Chemical Compounds</a>, Unversity of Kragujevac (2013)). 
In the process of calculating 3D structural isomers, 
one achiral molecule or one pair of enantiomers is counted just once, 
where achiral molecules and chiral molecules (enantiomeric pairs) 
are differentiated from each other. </p>

<p>For more information, see an account article entitled 
"Numbers of Alkanes and Monosubstituted Alkanes. 
A Long-Standing Interdisciplinary Problem over 130 Years" 
(<a href="https://www.jstage.jst.go.jp/article/bcsj/83/1/83_20090008/_pdf" rel="noreferrer">
S. Fujita, <I> Bull. Chem. Soc. Japan</I>, <B>83</B>, 1--18 (2010)</a>, 
access free). This account article has discussed the difference between graph enumeration (Polya's theorem) and 3D structural enmeration (Fujita's proligand method) during recursive calculation. </p>

<p>It should be emphasized that graph-theoretical enumerations of chemical compounds 
as constitutional isomers (structural isomers) and as steric isomers (based on asymmetry) 
should be differentiated from stereochemical enumerations of chemical compounds 
as 3D structural isomers and as steric isomers (based on chirality). 
Although steric isomers based on asymmetry (graphs governed by permutation groups) and 
steric isomers based on chirality (3D structures governed by point groups) give identical 
enumeration results, they are conceptually different entities. 
This point of view stems from Fujita's stereoisogram approach, 
which is described in a recent book 
(S. Fujita <a href="http://www.degruyter.com/view/product/431387" rel="noreferrer">
Mathematical Stereochemistry</a>, De Gruyter (2015)).</p>

<p>(2) Enumeration of achiral and chiral alkanes of a given carbon content has been 
conducted by considering internal branching 
(<a href="http://doi.org/10.1246/bcsj.81.1423" rel="noreferrer">
S. Fujita, <I>Bull. Chem. Soc. Jpn.</I>, <B>81</B>, 1423--1453 (2008)</a>). 
Figure 3 of this report is cited below. </p>

<a href="https://i.stack.imgur.com/dCRHj.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/dCRHj.jpg" alt="enter image description here"></a>  

<p>The symbol [q, t, s, p] means 
the presence of q quaternary carbons, t tertiary carbons, s secondary carbons, 
and p primary carbons. Alkanes are categorized into 
centroidal and bicentroidal alkanes, which are the 3D extension of 
centroidal and bicentroidal trees of graph theory.</p>

#### Answer 3 (score 1)
As far as I am aware, there is no straight up formula. Obviously there are very general trends, but not precise enough to tell you the number of isomers.   

If you need to decide how many isomers something has, I suggest you either do it manually or use a programme like this: <a href="http://www-jmg.ch.cam.ac.uk/tools/isomercount/" rel="nofollow">http://www-jmg.ch.cam.ac.uk/tools/isomercount/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: Why do branched chain compounds have lower boiling points than the corresponding straight chain isomers? (score [201135](https://stackoverflow.com/q/6944) in 2017)

#### Question
<blockquote>
  The branched chain compounds have lower boiling points than the corresponding straight chain isomers. For example,    
  
  <ul>
  <li>$\ce{CH_3CH_2CH_2CH_2CH_3}$ - 
  No branching-Pentane (n-pentane) ($\mathrm{b.p.}=309~\mathrm{K}$)  </li>
  <li>$\ce{CH_3CH(CH_3)CH_2CH_3}$ - 
  One branching-2-Methylbutane (Iso-pentane) ($\mathrm{b.p.}=301~\mathrm{K}$)  </li>
  <li>$\ce{C(CH_3)_4}$ - Two branches-2,2-Dimethylpropane (Neo-pentane) ($\mathrm{b.p.}=282.5\mathrm{K~}$)  </li>
  </ul>
  
  This is due to the fact that branching of the chain makes the molecule more compact and thereby decreases the surface area. Therefore, the intermolecular attractive forces which depend upon the surface area, also become small in magnitude on account of branching. Consequently, <em>the boiling points of the branched chain alkanes are less than the straight chain isomers.</em>    
</blockquote>

The above extract from my book, mentions clearly that branching makes the molecule more compact and thereby decreases the surface area. Even for isomeric alkyl halides, the boiling points decrease with branching. The reason is said to be because of the decrease in surface area, same as explained before. How does decrease in the surface area make the intermolecular forces small in magnitude?  

#### Answer accepted (score 14)
The simple explanation is that weak intermolecular forces (the forces that make something condense to a liquid when things are cold enough) depend on the surface area (as well as many other things). But in the case of relatively similar non-polar isomers (where weak intermolecular forces are the dominant forces), the larger surface area will lead to the large force and hence the highest boilling point.   

2,2 dimethyl propane is a compact, almost spherical molecule. Pentane is long and "floppier" so will experience more forces between molecules.  

The underlying, but slightly simplified, explanation of this is that intermolecular forces (often called van der Waal's forces) depend on attractions caused by quantum fluctuations in the surface electrons of the molecule. These lead to short-lived dipole moments that can also induce dipoles in neighboring molecules to which the original dipole is attracted. The larger the surface area, the more opportunity for such dipoles to exist and therefore a stronger force.  

#### Answer 2 (score 2)
Straight chain molecules have more places along its length where they can be attracted to other molecules, so there are more chances of London Dispersion Forces to be developed. Hence, they have stronger intermolecular forces as compared to the branched chain molecules which have a compact shape, therefore fewer spaces where they can be attracted to other molecules.  

#### Answer 3 (score -1)
Straight chain compounds have higher boiling point then branched chain because in straight chain, molecules are strongly entangled with each other (like noodles)and have more contact with other molecules so strong force is required to remove such molecules consequently straight chain compounds have higher boiling point than branched compounds  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: What is the definition of of 'compound', 'mixture', 'element' and 'molecule'? (score [190223](https://stackoverflow.com/q/2879) in 2017)

#### Question
I am looking for the precise definitions, as I am very confused as to what they are exactly because although I mostly understand what they mean, I have encountered some conflicting definitions that confused me.  

As it stands, this is what I understand them to mean:   

<blockquote>
  <ul>
  <li>Compound: two or more different atoms bonded together.</li>
  <li>Mixture: two or more different atoms together but not joined.</li>
  <li>Molecule: two particles (same or different) bonded together.</li>
  <li>Element: only 1 type of atom; this definition is applied to things both bonded and not to itself.</li>
  </ul>
</blockquote>

I don't know whether these terms apply microscopically, macroscopically, or both. For example, I think 1 $\ce{H2O}$ molecule is a compound but is a bathtub of them called a mixture (as it contains more than 1 atom type), a compound, or both? That is, to be a compound, do all the atoms in the compound have to be bonded physically together? Generally, to what extent can these four terms overlap?  

I would very much like a systematic way of thinking about these terms.  

#### Answer accepted (score 17)
I can't really provide a systematic approach, but I can attempt to clarify (as a student myself).  

<ul>
<li><p><strong>Elements</strong> are classes of atoms. Atoms of the same element are similar (if not identical) in their physical and chemical properties (but be aware of <a href="http://en.wikipedia.org/wiki/Isotope" rel="nofollow noreferrer">Isotopes</a> which are physical variations among atoms of the same element).<br>
A definite (I suppose, systematic) way to distinguish elements is that their corresponding atoms have different numbers of electrons orbiting the nucleus.<br>
The term is also used to describe a collective of the same atom (element). A bar of gold (Gold being an 'element'; a chemical class) is said to be an element itself.</p></li>
<li><p><strong>Molecules</strong> are a group of atoms <a href="http://en.wikipedia.org/wiki/Covalent_bond" rel="nofollow noreferrer">covalently</a> bonded to each other (which can be considered a 'direct connection', if you will). The molecule can consist of atoms of the same element, or atoms of different elements.<br>
If you joined to molecules via covalent bonding, you'd have created a new molecule (it's nothing special)</p></li>
<li><p><strong>Compounds</strong> are (in the chemical sense of the term) made of two or more elements. This means a lot of molecules (like H2O) are considered compounds (though H2 is not). 'Compound' is often used interchangeably with the word <a href="http://en.wikipedia.org/wiki/Chemical_substance" rel="nofollow noreferrer">substance</a>, which describes a collective of molecules (water is a substance. It is a large quantity of neighboring H2O molecules).<br>
A substance (and a compound, when a compound is used to describe a quantity of molecules) only consists of the same molecule. In water, all the molecules are H2O. If there were also some H2 molecules among them, it would no longer be considered a compound/substance (but instead; a mixture).<br>
These molecules are not directly bonded to each other (or they'd be one big molecule), they are just in close* proximity to one another and are <a href="http://en.wikipedia.org/wiki/Intermolecular_force" rel="nofollow noreferrer">attracted</a> to one another, keeping them in proximity. Even when the substance is a solid, like ice, they are not directly connected, the molecules are just slower (less energetic) and closer together (and in some special cases, like ice, stronger, such as <a href="http://en.wikipedia.org/wiki/Hydrogen_bond" rel="nofollow noreferrer">Hydrogen Bonding</a>. Don't be confused, though it is referred to as 'bonding', there is no direct covalent bond, just an attraction).</p></li>
<li><p><strong>Mixtures</strong> are collectives of different molecules or atoms. The molecules and atoms are like that in a substance; they're not bonded to each other, but are attracted, and in a mixture specifically, the molecules/atoms are not all the same. Juice, for instance, is a mixture. It contains some Vitamin C molecules, some water molecules, some sugar molecules, etc.</p></li>
</ul>

Here is a horribly drawn diagram to help clarify the distinctions.   

<img src="https://i.stack.imgur.com/7EJs0.png" width="400">  

Reflecting on this, here is what in your understanding needs specific attention.  

<p>Compound: <strike>two or more different atoms bonded together</strike> <strong>A molecule or a group of identical molecules.</strong><br>
Mixture: two or more different atoms <strong>or molecules</strong> together but not joined <strong>(they're not covalently bonded)</strong>.<br>
Molecule: two or more atoms(same or different) bonded together.  </p>

#### Answer 2 (score 11)
In a sample of water, you'll find the <strong>compound</strong> $\ce{H2O}$. In a sample of hydrogen gas, you'll find the <strong>element</strong> hydrogen, though it'll take the form of the <strong>molecule</strong> $\ce{H2}$. In a mixture, you may find different <strong>molecules</strong>, <strong>compounds</strong>, and <strong>elements</strong>.  

<p>At this point, you may find it helpful to look at the following classification of matter.
<img src="https://i.stack.imgur.com/wsfz0.png" alt="Matter tree"><br>
The left side of the tree denotes chemical bonds/changes. The right is physical. (i.e., you can get a heterogeneous mixture to convert to a homogeneous mixture by changing physical things about the mixture like adding in another element. You can't do the same to elements and compounds.)</p>

#### Answer 3 (score 4)
I was also confused when I learned this all stuff first time. When you get any element, molecule, compound or mixture don't think about complex stuff but think on the basic level.  

I have given the most basic definition (properties) of an element, molecule, compound or mixture.  

<strong>Element:</strong>  

<ul>
<li><p>A substance which cannot be broken down chemically is called elements.</p></li>
<li><p>All substances listed in Periodic Table are elements.</p></li>
</ul>

<strong>Molecule:</strong>  

<ul>
<li>Two or more atoms or elements combined together are called a molecule.</li>
</ul>

<strong>Compound:</strong>  

<ul>
<li><p>Two or more elements combine together to form a compound. </p></li>
<li><p>The smallest unit of a compound is a molecule.</p></li>
<li><p>Compounds possess different characteristics compared to constituent elements.</p></li>
<li><p>Example: $\ce{H2O}$. </p>

<ul>
<li><p>$\ce{H}$ is highly combustible</p></li>
<li><p>$\ce{O}$ helps in combustion</p></li>
<li><p>$\ce{H2O}$ is used in fire extinguishers (different characteristics than $\ce{H}$ and $\ce{O}$  )</p></li>
</ul></li>
</ul>

<strong>Mixture:</strong>  

<ul>
<li><p>When two or more matter mix without changing their original property this is called a mixture.</p></li>
<li><p>Mixtures can be separated by a simple process, like filtration. </p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: What is SPDF configuration? (score [187437](https://stackoverflow.com/q/31189) in 2019)

#### Question
Recently in my chemistry classes, the teacher spoke about SPDF configuration and then said that we'll be taught about it in higher classes.   

But I'm sorta curious to know that what is SPDF configuration and is there something like - obtaining electronic configuration in SPDF format?  

#### Answer accepted (score 20)
s, p, d, f and so on are the names given to the orbitals that hold the electrons in atoms.  These orbitals have different shapes (<em>e.g.</em> electron density distributions in space) and energies (<em>e.g</em>. 1s is lower energy than 2s which is lower energy than 3s; 2s is lower energy than 2p).  

<img src="https://i.stack.imgur.com/K5EcA.jpg" alt="enter image description here">  

(<a href="http://chemwiki.ucdavis.edu/Physical_Chemistry/Quantum_Mechanics/09._The_Hydrogen_Atom/Atomic_Theory/Electrons_in_Atoms/Electronic_Orbitals" rel="noreferrer">image source</a>)  

So for example,  

<ul>
<li>a hydrogen atom with one electron would be denoted as $\ce{1s^1}$ - it has one electron in its 1s orbital</li>
<li>a lithium atom with 3 electrons would be $\ce{1s^2~2s^1}$</li>
<li>fluorine has 9 electrons which would be $\ce{1s^2~2s^2~2p^5}$</li>
</ul>

Again, as we read from left to right the energy of the orbital increases and the superscript shows the number of electrons in the orbital. You can read more <a href="http://en.wikipedia.org/wiki/Electron_configuration" rel="noreferrer">here</a>.  

#### Answer 2 (score 7)
By SPDF configuration, he meant orbital configuration. Now the basic of this concept is from very fundamental quantum chemistry formulation but I don't think you need to know that now (It is usually taught in 4th year of UG or 1st year of graduate study in Engineering discipline but i am not sure about pure science discipline). Whatever I would like to think about it from a different perspective. Are you familiar with quantum numbers? There are 4 different quantum numbers:    

<ol>
<li><p>Principal quantum number (This is like the city you live in). There are lots of electrons in an atoms. Now if we want to distinguish between those electrons than we need to name them or there should be something to distinguish. Imagine you are living in a circular states and the cities are named as the radius it has. Like sector 1 is the city which has a mean radius of 1 unit and so on. By principal quantum number, we actually mean that the probability of finding that electron is high within that particular radius. It is named as n=1,2,3...  </p></li>
<li><p>Azimuthal quantum number: This is like the building you live in. Now if you are living in a city that is very small and has only one building, then you don't need to specify each building of that city differently. Like for n=1, l=0 (Here l=azimuthal quantum number/building number) but if n=3, then l=0 to (n-1), that means in Sector 3 city there are 3 building named 0,1 &amp; 2.    </p></li>
<li><p>Magnetic quantum number: This is like apt number on that building. m=0 to (+/-)l. So, if you are living in building no. 3, you can either live in apt -3,-2,-1,0,1,2 or 3.   </p></li>
<li><p>Spin quantum number: Each apt has two rooms (room A and room B) (This is actually unrestricted Hartree-Fock case) but if you are living with spouse than you can have a large room by breaking the wall between those two rooms (Only room A or restricted Hartree-Fock case)   </p></li>
</ol>

<p>Now, The building name can be rephrased as spdf orbital. If you are living in building no. 0 that means you are living in s orbital. Similarly<br>
building no.1= p orbital<br>
building no.2= d orbital<br>
building no.3= f orbital<br>
So, in your building no.0 (s orbital),<br>
total number of room = 1apt * 2rooms/apt = 2rooms or 2 electrons<br>
In building no.1 (p orbital),<br>
total number of electron/room = 3apt * 2rooms/apt = 6 rooms or 6 electrons  </p>

Now if you want to know more you can read:    

<ul>
<li>Hund's rule   </li>
<li>Pauli's exclusion principle  </li>
<li>Aufbau principle   </li>
</ul>

But they all are superficial theory, they can say what is going on but they can't say why. But quantum chemistry method will give you mathematical understanding of why there is 2 rooms/apt or why building 2 has 5 apt etc.    

#### Answer 3 (score 0)
First of all, I must appreciate your eagerness to learn new stuff (though it makes it harder to explain). I will try my best to explain in a way you can understand.  

You might have been taught about eletron filling order like: 2 electrons in K shell, 8 electrons in L shell and so on. However, that works only up to a certain level.   

Its a fact that each shell itself is composed of <em>subshells</em> (experiments involving spectra have shown this). The number of subshells each shell has depends on the number of the shell (like 1st shell, 2nd shell; a.k.a principal quantum number). These subshells are called as s, p, d, or f. The s-subshell can fit 2 electrons, p-subshell can fit a maximum of 6 electrons, d-subshell can fit a maximum of 10 electrons, and f-subshell can fit a maximum of 14 electrons. The first shell has only an s orbital, so its called as 1s. Since it can have either one or two electrons, its called as $1s^1$ and $1s^2$ respectively. They are also the respective "SPDF" configurations of hydrogen and helium. In this way, you would consider the electronic configuration of oxygen to be $1s^22s^22p^4$.  

<p>Another important point to note, is that the filling of electrons in subshells doenst actually fill from low to high. There is a special rule called <em>aufbau principle</em> (german word for 'building up'). Here is a diagrammatic representation of aufbau principle:
<img src="https://i.stack.imgur.com/dsjqP.png" alt="enter image description here"></p>

This infact, is the <em>actual</em> way of writing an electronic configurations. Schools teach to primary classes the 'configuration-per-shell' method simply because its easier and they usually dont come across geniuses like you. Now, I think you can understand the 'SPDF' configuration much better.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Why add water first then acid? (score [186227](https://stackoverflow.com/q/893) in 2019)

#### Question
From school, I remember a very important rule: first you need to pour the water and <em>then</em> the acid (when you need to mix them) not vice-versa. This is because otherwise the aсid becomes very hot and splashing may happen.  

So, why does it get hotter when water is poured into it? What reaction takes place?  

#### Answer accepted (score 53)
This is mostly the case for sulfuric acid. Commercially available sulfuric acid is dense (~1.8 g/ml) and when water is added, it may not mix. In this case a layer of hot weak acid solution is formed, which boils and sprays around. When acid is poured into water, it flows down the flask and mixes much better, so no boiling occurs.  

The reason this occurs is due to the large amount of energy released in the hydration reaction of sulfuric acid ions. Do not believe that heat comes from dissociation, as the dissociation of acids, bases, and salts always consumes energy. The energy is released from subsequent hydration, and the release may be high, especially if $\ce{H+}$ or $\ce{OH-}$ ions are hydrated.   

#### Answer 2 (score 19)
This happens with strong acids and bases. <em>Strong</em> means the acid almost complete dissociates into ions; e.g. $\ce{HCl}$ to $\ce{H+}$ and $\ce{Cl-}$.  When the dissociation occurs, it releases a great deal of heat (i.e. <em>exothermic</em>) because of the subsequent hydration of $\ce{H+}$ to $\ce{H3O+}$, as the other comments have indicated. The reason you add acid to water is that if you add water to acid, the first drop of water reacts immediately, and the heat might be high enough to boil the water instantly, which could spray acid out of the container.  

#### Answer 3 (score 4)
This is more a problem with thermal mass. Sulfuric acid releases a lot of thermal energy when water is introduced to typical stock sulfuric acid which is about 90% acid by weight. When dilution is performed, a small mass of the acid is combined with a much larger mass of water.   

If the acid mass is in the receiving flask, there is initially a small mass of acid and water as the dilution is started. The energy released will heat up the low mass mixture, with four joules of energy heating up one gram of the mixture by one degree Celsius. If there isn't much mass, then the temperature change is dramatic and can easily cause the solution to boil, throwing droplets of concentrated sulfuric acid in the air.   

Sulfuric acid is extremely dangerous. It is intensely hydroscopic and will readily dehydrate carbohydrates and proteins by removing oxygens and hydrogens to make water molecules. This process will destroy the carbohydrates and proteins, including the materials that make up your skin and muscle. Concentrated sulfuric acid has disfigured many people who have been unlucky enough to come in contact with it. Even when sulfuric acid is diluted the proper way, by adding the acid to a volume of water, it can still result in an extremely hot mixture that might even boil.   

Good practice involves using a receiving flask that can contain splashing acid water mixture, such as Erlenmeyer flask, and even chilling the mixture during the dilution. A splash shield can also be placed between the worker and the dilution mixture and it could be done in a fume hood. Heavy neoprene lab gloves, as well as eye protection,  are recommended. Students in introductory chemistry classes rarely perform this dilution procedure, because of the high likelihood of accidents.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: Will alcohol or soap damage plastic or rubber? (score [177507](https://stackoverflow.com/q/1092) in 2017)

#### Question
I have read conflicting advice on various sites about the appropriate methods for cleaning plastic and rubber items and would like to ask people who <strong><em>actually know what's going on</em></strong> what they would recommend.    

I realize some of my assumptions may be false:  

<ul>
<li>I am (perhaps wrongly) assuming that most plastics would have similar properties as it relates to cleaning with alcohol or soaps/detergents and that you don't need me to give you the actual chemical structure of a specific polymer.</li>
<li>I am (perhaps wrongly) assuming that most soaps and detergents would act similarly on either a plastic or a rubber item.  If this is false please give your understanding of what an "average" soap or detergent would do.</li>
</ul>

<p>I <em>am not</em> assuming that plastics and rubber will respond the same to either alcohol or soaps and detergents.  If they are different, please note which will have what effect.
I <em>am not</em> assuming that synthetic and real rubber will act the same.  If they are different and you know the answer for both, please mention the difference.</p>

I am <em>hoping</em> that it's okay to ask "applied" questions here.  This seems like the best of all stackexchange.com sites, not just because none of the less theoretical sites are deal with this sort of question, but also because it really boils down to a matter of chemical reactions.  

<strong><em>Update</em></strong>: by "alcohol" I mean rubbing alcohol, or isopropanol.  

#### Answer accepted (score 22)
<blockquote>
  Will soap damage plastic or rubber?  
</blockquote>

<strong>Probably not.</strong> Most plastics and rubbers are resistant to aqueous solutions and ionic compounds (including most surfactants and soaps).  

<blockquote>
  Will alcohol damage plastic or rubber?  
</blockquote>

<strong>Maybe.</strong> There are two problems, in that neither <em>alcohol</em> nor <em>plastic</em> refer to specific compounds, but are rather generic terms encompassing hundreds of compounds each. The number of possible combinations is endless. As Leonardo suggests, the best approach is either to look in the manual or experiment in a small inconspicuous part of the product.  

However, assuming that by <em>alcohol</em> you either mean <a href="http://en.wikipedia.org/wiki/Ethanol" rel="noreferrer">ethanol</a>, which is the drinking kind of alcohol, or <a href="http://en.wikipedia.org/wiki/Isopropanol" rel="noreferrer">isopropanol</a>, which is the alcohol in many cleaning products, then I can give you some advice based on common plastic types. Both are similar enough in their solvent properties that we can generalize.    

Alcohol will damage some plastics, but not all. I will list my answers by the <a href="http://en.wikipedia.org/wiki/Resin_code" rel="noreferrer">resin code</a>, or "recycling symbol", found on most plastic items:  

<ol>
<li><p>Poly(ethylene terephthalate), PET or PETE - PET is not very soluble in ethanol or isopropanol, but prolonged exposure may cause <a href="http://en.wikipedia.org/wiki/Crazing" rel="noreferrer">crazing</a> or stiffening due to the dissolution of <a href="http://en.wikipedia.org/wiki/Plasticizer" rel="noreferrer">plasticizers</a>.</p></li>
<li><p>High-Density polyethylene, HDPE - HDPE is resistant to most things.</p></li>
<li><p>Poly(vinyl chloride), PVC - PVC is not very soluble in ethanol or isopropanol, but prolonged exposure may cause crazing or stiffening.</p></li>
<li><p>Low-Density polyethylene, LDPE - LDPE is resistant to most things.</p></li>
<li><p>Polypropylene, PP - PP is resistant to most things.</p></li>
<li><p>Polystyrene PS - PS is not very soluble in ethanol or isopropanol, but prolonged exposure may cause crazing or stiffening.</p></li>
<li><p>This stands for "other", but the most common is polycarbonate, which is not very soluble in ethanol or isopropanol, but prolonged exposure may cause crazing or stiffening. </p></li>
</ol>

<strong>Rubber</strong> - most rubbers are probably resistant to alcohols, but prolonged exposure will cause loss of elasticity  

#### Answer 2 (score 3)
<strong>My advice: Look up manuals where applicable, or experiment with methods if you cannot find good answers, hopefully, you can figure out what exact material it is you are cleaning.</strong>  

What I can tell you for sure is that I have a small 'plastic' refrigerator which, by quickly looking up the model No. and finding <a href="http://www.eofficedirect.com/PSNFSR3770S/Counter-Height-Office-Refrigerator-with-Crisper-3-7-cu-ft-Black-Stainless-St.html" rel="nofollow noreferrer">this</a> order website, and the <a href="https://www.google.com/#hl=en&amp;sclient=psy-ab&amp;q=SR-3770S+manual&amp;oq=SR-3770S+manual&amp;gs_l=hp.3..0j0i5i30l2.12733.14616.1.14725.7.7.0.0.0.0.125.556.6j1.7.0.les;..0.0...1c.5USeEuzokmE&amp;pbx=1&amp;bav=on.2,or.r_gc.r_pw.r_qf.&amp;fp=e726f0c03c60e912&amp;biw=939&amp;bih=596" rel="nofollow noreferrer">manual</a>, it is made of <a href="http://en.wikipedia.org/wiki/Polyurethane" rel="nofollow noreferrer">Polyurethane</a>. And the manual indicates under "cleaning and maintenance" that I should <strong>"wash the</strong> inside <strong>(polyurethane) material with a solution of warm water and two tablespoons baking soda per quart water."</strong> And, specifically, <strong>do not use "soaps, detergents, scouring powder, spray cleaners, or the like because it may cause odors</strong>."  

Perhaps about.com has answers you wish, but I prefer the good old owners manual for the cold hard truth. By the way, I went ahead and used dish soap and cold water from my hose (I am a very lazy person). It smells slightly.. goofy, and that was a couple days ago. So I think they know what they are talking about. Note that the manual says nothing about Polyurethane!  

I hope that helps clarify something or another.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Is there an easy way to find number of valence electrons" (score [168609](https://stackoverflow.com/q/7674) in 2019)

#### Question
I want an high-school level answer. What I mean with "valence electrons" is the outermost electrons in that atoms' electronic arrangement? For example, 3 in an atom with an electronic arrangement of 2, 8, 3.)  

Without actually writing the electron configuration, or orbitals, and knowing electron number, is there any way to find this number easily?  

Also, is there an easy way to find if certain atom fits "atomic/orbital symmetry" given the numbers of electrons? (I don't know the english words for this and couldn't find them. So I translated it literally, but what I mean is, if orbital is half-full or full i.e  <span class="math-container">$\mathrm{s^1}$</span> or <span class="math-container">$\mathrm{2p^3}$</span> or <span class="math-container">$\mathrm{2p^6}$</span> and so on... hope you understand what I am trying to say)  

I am asking this because sometimes questions give me electron numbers in a range of 40+ and just writing it out doesn't seem like a good way.  

#### Answer accepted (score 5)
You can get the valence electrons in an atom's electronic arrangement by consulting the periodic table:  

<img src="https://i.stack.imgur.com/VrFqx.jpg" alt="enter image description here">  

<ul>
<li>The Group 1 atoms have 1 valence electron.</li>
<li>The Group 2 atoms have 2 valence electrons.</li>
<li>The Group 3 atoms have 3 valence electrons.</li>
<li>The Group 4 atoms have 4 valence electrons.</li>
<li>The Group 5 atoms have 5 valence electrons.</li>
<li>The Group 6 atoms have 6 valence electrons.</li>
<li>The Group 7 atoms have 7 valence electrons.</li>
</ul>

The atom with electric configuration 2, 8, 3 is Aluminium and you can find it in Group 3 of the periodic table.  

The periodic table is usually given in exams so...  

<hr>

The first two groups of the periodic table are the groups concerned with the filling of the $s$ orbital. So, all Group 1 atoms will have an outermost $s$ orbital filled with a single electron.  

Similarly, Group 3 - Group 8 (Group 8 is also referred to as Group 0) are where the $p$ orbital is being filled up. All the Group 5 atoms thus all have an outermost $p$ orbital filled with 3 electrons.  

The Periods in the periodic table can be used as an indication of the number of shells the atom has. Sulfur for instance is in Period 3 and thus has 3 shells.  

#### Answer 2 (score -3)
Yes there is! For all elements in the following groups;  

<p>Group 1A= +1
Group 2A= +2
Group 3A= +3
Group 4A= +4 or -4
Group 5A= -3</p>

From group 5, the valency descends in this order;  

-3, -2, -1, 0.  

Group 8A elements have a valency of Zero.  

I hate complicated stuff too lol.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: What is "heating under reflux"? (score [164156](https://stackoverflow.com/q/22364) in 2015)

#### Question
When dealing with organic reactions, <strong>heating under reflux</strong> is often required, such as the oxidation of Toluene using acidified $\ce{KMnO4}$ and dilute $\ce{H2SO4}$ to Benzoic acid($\ce{C6H6O2})$  

What does this mean and how does it differ from "normal" heating?  

#### Answer accepted (score 20)
Many organic reactions are unreasonably slow and can take an extended period of time to achieve any noticeable effect so heating is often used to increase the rate of reaction. However, many organic compounds have low boiling points and will vaporise upon exposure to such high heat, preventing the reaction from proceeding in full.  

To address this, `heating under reflux` is used. This refers to heating a solution with an attached condenser to prevent reagents from escaping.   

<img src="https://upload.wikimedia.org/wikipedia/en/thumb/5/51/Reflux_labled.svg/668px-Reflux_labled.svg.png" alt="wikied image">  

As seen above, any vapour will condense on the cool surface of the attached condenser and flow back into the flask.  

<strong>EDIT (thanks permeakra!):</strong> the hot water bath pictured is an optional component of heating under reflux and is usually only used for particularly sensitive reactions. Also, using it limits the reaction temperature to 100 degrees Celsius.   

#### Answer 2 (score 5)
Temperature control is important for reactions, especially in organic chemistry. Some reactions are strongly exothermic or have notable side-reactions that can be suppressed at a low temperature. For others, assuming all reactants survive the temperatures in question, van ’t Hoff’s rule dictates that an increase of the temperature by $10~\mathrm{^\circ C}$ increases the reaction rate by a factor of $2$ to $4$. Thus, increasing the temperature is often favourable.  

Almost all organic reaction are conducted in a solvent. The choice of solvent dictates the temperature range you can reach; e.g. tetrahydrofurane solidifies at $-108.4~\mathrm{^\circ C}$ and boils at $65.8~\mathrm{^\circ C}$, so any reactions will have to take place at in-between temperatures.  

Often, a published reaction will have a set of conditions most likely to work; they typically come with a preferred solvent and a preferred temperature. A Dess-Martin oxidation is typically conducted at $0~\mathrm{^\circ C}$ in dichloromethane. For many reactions, the preferred temperature coincides with the solvent’s boiling point — it means that maximum heating is required to conduct the reaction in that solvent. When heated to the boiling point, the solvent will partially evaporate and recondense on colder surfaces. But since also the concentration of reactants is important, one typically wants to recollect the evaporating solvent.  

This is where <em>heating under reflux</em> comes into play. <em>Reflux</em> is the term used to mean ‘letting a solvent boil and collecting its vapour in some kind of condenser to let it drip back into the reaction vessel.’ The most common type of condenser I have encountered for refluxing is the <em>Dimroth condenser</em> as shown in the image below (taken from <a href="https://en.wikipedia.org/wiki/File:Dimroth_mirr_stdzd.png" rel="noreferrer">Wikipedia</a>, where a full list of authors is available).  

<a href="https://i.stack.imgur.com/9RiHO.png" rel="noreferrer"><img src="https://i.stack.imgur.com/9RiHO.png" alt="Dimroth condenser"></a>  

It is important to connect the cooling water circuit correctly. <strong>For some reason, most images found on the internet, including the one in the other answer, suggest a suboptimal cooling.</strong> The most optimal cooling efficiency is given in a countercurrent setup. To quote <a href="https://en.wikipedia.org/wiki/Countercurrent_exchange" rel="noreferrer">Wikipedia</a>:  

<blockquote>
  The maximum amount of heat or mass transfer that can be obtained is higher with countercurrent than co-current (parallel) exchange because countercurrent maintains a slowly declining difference or gradient (usually temperature or concentration difference). In cocurrent exchange the initial gradient is higher but falls off quickly, leading to wasted potential.  
</blockquote>

Thus, in the image above, the water supply should be connected to the top connector while the bottom one should be used as water outlet. This allows the strongest cooling efficiency to be at the top of the condensor, which is important, because if vapour manages to get that high up it needs a quick and efficient cooling.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How can melting point equal freezing point? (score [163846](https://stackoverflow.com/q/5382) in 2019)

#### Question
I don't understand how the freezing point of a substance is the same temperature as the melting point of the same substance.  

For example, if liquid water freezes at 0 °C how can ice also melts at 0 °C?  

#### Answer accepted (score 11)
Because melting point and freezing point describe the same <em>transition of matter</em>, in this case from liquid to solid (freezing) or equivalently, from solid to liquid (melting).  

What you may not realize is that while water is freezing or melting, its temperature is <strong>not</strong> changing!  It is stuck on $0\ \mathrm{^\circ C}$ during the entire melting or freezing process.  It is easier to see this for <em>boiling points</em>.  if you put a thermometer in water and heat it, the temperature will rise until it reaches $100\ \mathrm{^\circ C}$, and then it starts boiling.  And while it boils, it will <em>stay</em> at $100\ \mathrm{^\circ C}$!  All the way until the water has all boiled away.  Now if you could somehow trap the steam (gaseous water) and keep heating it, the steam could have a temperature higher than $100\ \mathrm{^\circ C}$.  

So to sum this all up, when matter is transitioning from solid to liquid (melting) or liquid to solid (freezing), its temperature is fixed at the melting/freezing point, which is the <strong>same</strong> temperature.  

#### Answer 2 (score 9)
I think this is an interesting question where the confusion is mostly due to semantics.  

Let's consider an ice cube in your freezer (a typical kitchen freezer has a temperature of -10 C).  When that ice cube is taken out of the freezer and placed in a warm kitchen, heat from the surroundings (air, counter top, etc.) is transferred to the ice cube.  We observe that the temperature of the ice cube increases.  The ice cube stays a cube because the energy of the intermolecular forces that keep the water molecules together is greater than the heat energy added to the ice cube so far.  

At the melting point, however, there <em>is</em> enough thermal energy to start breaking those intermolecular forces.  What we observe is that the temperature does not rise, but bonds are breaking and the solid starts to melt.  Once all the solid melts, the temperature of the (now liquid) water can increase when thermal energy is added.  

A similar explanation can be used for the reverse process (freezing water) only in this case the thermal energy is being transferred from the water to the surroundings.  

So we come to your question, how can melting point = freezing point.  This "point" is <em>the temperature at which the solid and liquid forms of the molecule are in equilibrium.</em>  When we use a term like <strong>melts</strong> oftentimes we mean <strong>melts completely</strong>.  In this case, the temperature of the liquid would be just <strike>beyond</strike> <em>above</em> the melting point.  

#### Answer 3 (score 5)
<a href="http://en.wikipedia.org/wiki/Triple_point" rel="noreferrer">http://en.wikipedia.org/wiki/Triple_point</a>  

If a material's equilibrium melting and freezing points were non-identical, you would have a perpetual motion machine of the first kind.  Go head, trace the energy flows for temperature versus specific heats and latent enthalpies of transition.  Cycled divergent vapor pressures at the differing transition temperatures would power a perpetual wind generator.  Ya gotta think about these things. e.g., water below,  

<img src="https://i.stack.imgur.com/0aBrg.gif" alt="Water vapor pressures">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How to calculate the concentration H3O+ in a solution with pH=6.99? (score [157784](https://stackoverflow.com/q/44150) in )

#### Question
What is the correct way to calculate the concentration $\ce{H3O+}$ in a solution with $\ce{pH}=6.99$?  

Attempt 1.   

<blockquote>
  pH&lt;7, therefore there are only $\ce{H3O+}$ particles in the solution. $[\ce{H3O+}] = 10^{-\ce{pH}} = 10^{-6.99} = 1.02 \cdot 10^{-7}$  
</blockquote>

Attempt 2.   

<blockquote>
  We have $[\ce{H3O+}] = 10^{-\ce{pH}} = 10^{-6.99} = 1.02 \cdot 10^{-7}$ and $[\ce{OH-}] = 10^{-\ce{pOH}} = 10^{-7.01} = 9.77 \cdot 10^{-8}$. <br> <br> Because of $\ce{H3O+ + OH- -&gt; 2 H2O}$ we are left with $[\ce{H3O+}] = 1.02 \cdot 10^{-7}- 9.77 \cdot 10^{-8} = 4.6 \cdot 10^{-9}$  
</blockquote>

When the pH is smaller than 6 or greater than 8, one will not notice the difference, but here it is logarithmically speaking very large. So I wonder what the correct way is?  

#### Answer accepted (score 9)
If you take a sample of pure water, there will be few hydroxide and hydronium ions. Of course, they can combine to form water and yes they do combine but there will be few water molecules which break/combine to form the ions again. Hence, there exists a <em>dynamic equilibrium</em> between concentration of ions and water molecules.   

$\textrm{pH}$ by definition is the negative logarithm of hydronium ion concentration.   

$$\textrm{pH} = -\log [\ce{H^+}] = -\log [\ce{H3O^+}]$$  

You can obtain the concentration of H<sup>+</sup> ions by substituting the value of pH in the following formula,   

$$[\ce{H3O^+}] = 10^{\mathrm{-pH}}.$$  

Your attempt 2 is flawed because your assumption that all the ions combine to form water molecules is incorrect. There will <strong>always</strong> be some concentrations of the ions and all of them needn't combine to produce water molecules. Your attempt 1 is correct.  

It appears like you are not aware of the concept of equilibrium and self ionization of water, I have picked few good materials which you might(should) want to refer to,  

<a href="https://en.wikipedia.org/wiki/Chemical_equilibrium">Chemical Equilibrium</a>  

<a href="https://en.wikipedia.org/wiki/Self-ionization_of_water">Self Ionization of water</a>  

The concept of chemical equilibrium is very important and you will come across it frequently in chemistry, so you must learn it. Also, self-ionization of water along with chemical equilibrium are central concepts for learning acids and bases.  

#### Answer 2 (score 5)
I think you are confusing two different concepts. If you want to know <em>how much acid</em> you need to add to get to a pH of 6.99, it is important to take account of the fact that water is slightly dissociated. But that was not the question. The question was simply   

<blockquote>
  what is the concentration of H<sub>3</sub>O<sup>+</sup>  
</blockquote>

And that follows directly from the definition of `p` in `pH`:   

$$\rm{pH = -\log_{10}([H_3O^+])}$$  

A simple mathematical rearrangement gives you  

$$\rm{[H_3O^+] = 10^{-6.99}}$$  

Don't confuse yourself with random bits of science that don't belong in the answer... it just makes it harder than it needs to be.  

#### Answer 3 (score 3)
Please discard earlier answer as there was a small misunderstanding.   

Here self ionization of water will also take place which will increase H<sup>+</sup> concentration and will reduce OH<sup>-</sup>  concentration. Also [H<sup>+</sup> ] from water will not be equal to 10<sup>-7</sup> due to common ion effect. Net [H+]=10<sup>-pH</sup>   

Also [H<sup>+</sup> ] = [H<sub>3</sub>O<sup>+</sup> ] because a single H<sup>+</sup>  combines with a single water molecule to give H3O+ without involving OH<sup>-</sup>  as you did in attempt 2.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How does one tell if a specific molecule is acidic or basic? (score [156714](https://stackoverflow.com/q/6751) in 2018)

#### Question
Let's take the $\ce{KOH}$ molecule into account. I know it is a base from literature, but how would one go about determining if a molecule is acidic or basic simply based on the structure of the molecule? How about amphoteric?  

Also, I understand that there are two complementary systems - Lewis and Brønsted-Lowry theories. How do they work and how do they fit together?  

#### Answer accepted (score 17)
It is sometimes challenging to determine if a molecule is going to be acidic or basic if the system in which it is reacting is not considered.  An important point to consider when dealing with acids and bases is that <em>acid/base strength is inherently tied to the solvent</em>.  For this answer, I'm going to limit the discussion to acids and bases in an aqueous environment.  

It is helpful to consider the terms acid and base as a means to <em>classify</em> substances.  This way, Chemists can explain chemical reactivity and structure-function relationships of substances.  Very early classification systems depended on our senses (acids are sour, bases are slippery to the touch) and more recent classification systems utilize structural characterization tools such as NMR or crystallography.  Many classification systems have been proposed over the years, and only a few of them have found sufficiently widespread use to end up in textbooks used in the standard Chemistry curriculum.  Below are a few systems, taken from Miessler &amp; Tarr's Inorganic Chemistry textbook.  The 2nd through 4th entries are those in common use today.  

<ul>
<li>NAME (YEAR) acid definition [example]; base definition [example]</li>
<li>Liebig (~1776) Acid: an oxide of N, P, S [$\ce{SO_3}$]; Base: Reacts with
acid [$\ce{NaOH}$]</li>
<li>Arrhenius (1894) Acid: Forms hydronium ion [$\ce{HNO_3}$]; Base: Forms hydroxide ion [$\ce{NaOH}$]</li>
<li>Brønsted (1923) Acid: Proton donor [$\ce{HCl}$]; Base: Proton acceptor [$\ce{NaOH}$]</li>
<li>Lewis (1923) Acid: Electron-pair acceptor [$\ce{Ag^+}$]; Base: Electron-pair donor [$\ce{NH_3}$]</li>
<li>Ingold-Robinson (1932) Acid: Electrophile [$\ce{BF_3}$]; Base: Nucleophile [$\ce{NH_3}$]</li>
<li>Lux-Flood (1939) Acid: Oxide ion acceptor [$\ce{SiO_2}$]; Base: Oxide ion donor [$\ce{CaO}$]</li>
<li>Usanovich (1939) Acid: Electron acceptor [$\ce{Cl_2}$]; Base: Electron donor [$\ce{Na}$]</li>
<li>Solvent system (1950s) Acid: Solvent cation [$\ce{BrF_2^+}$]; Base: Solvent anion [$\ce{BrF_4^-}$]</li>
<li>Frontier Orbitals (1960s) Acid: LUMO of acceptor [$\ce{BrF_3}$]; Base: HOMO of donor [$\ce{NH_3}$]</li>
</ul>

I find the various acid/base systems very enlightening.  Note how From Arrhenius through Lewis there was a broadening of the acid/base classification system; Arrhenius can't be used to describe non-aqueous acids and bases and Brønsted can't be used with aprotic substances.  Yet, the Lewis definition incorporates the previous two (a Brønsted acid <em>is also</em> a Lewis acid; an Arrhenius base <em>is also</em> a Lewis base).  One then may ask, what's up with the Lux-Flood definition then?  This definition is counter to the trend of broadening the classification system, and yet it is useful in describing anhydrous solid-state chemistry and is used to describe geochemical reactions as well as the chemistry of high-temperature melts.  My point being: classification of substances into acids and bases is only meaningful if it helps explain chemical phenomena.  

Which brings us to the Usanovich definition, which essentially states that <em>every reaction is an acid-base reaction</em>.  Such a broad definition is not overly helpful, and to those of us with an affinity towards electrochemistry (ahem), is somewhat arrogant :-)  

I do believe that determining if a substance will behave as an acid or a base requires a bit of chemical intuition (or a Socratic method).  For example, you may have performed an experiment in which $\ce{KOH}$ served as a base; you know that, like potassium, sodium is an alkali metal; therefore you presume that $\ce{NaOH}$ would be a base as well.  

<h5>Back to the question at hand</h2>

So how do I suggest one use this information to <strong>predict whether a substance will behave as an acid or a base using its structure alone</strong>?  Personally, I find the Lewis theory as the most useful classification system in answering this type of question.  If the structure of a compound is set before me and I am to predict its acid/base chemistry, I will ask two questions:  

<ul>
<li>Are there any lone pair electrons that can be donated?</li>
<li>Are there any electron-deficient atoms that could serve as electron pair acceptors?</li>
</ul>

If the answer to question 1 is yes, then the molecule can behave as a base.  If the answer to question 2 is yes, then the molecule is an acid.  If both are true, then I have an amphoteric substance.  

In proofreading this answer, I realize I said I would restrict myself to aqueous systems, in which case using the Brønsted system may be more helpful.  In this case, the questions become:  

<ul>
<li>Is there a hydrogen that can be donated? (You'll be right more often than you are wrong if you rephrase this question as "Is there a hydrogen that is attached to something other than carbon?").</li>
<li>Is there a lone pair that can accept a proton?</li>
</ul>

#### Answer 2 (score 4)
<blockquote>
  How does one tell if a specific molecule is acidic or basic?    
</blockquote>

An acid (from the Latin acidus/acēre meaning sour) is a chemical substance whose aqueous solutions are characterized by a sour taste, the ability to turn blue litmus red, and the ability to react with bases and certain metals (like calcium) to form salts.  

In chemistry, a base is a substance that, in aqueous solution, is slippery to the touch, tastes bitter, changes the colour of indicators (e.g., turns red litmus paper blue), reacts with acids to form salts, and promotes certain chemical reactions (base catalysis).    

We do have $3$ different definitions from Arrhenius, Brønsted-Lowry, and Lewis. We would be in trouble, in some cases, where one definition accepts a molecule as acid or base and other not. So, we do have a common definition for acids and bases as mentioned above.    

Coming to amphoteric substance, consider $\ce{H2O}$ which has no taste.    

<em>LINKS</em>    

<ul>
<li><a href="http://en.wikipedia.org/wiki/Acid" rel="nofollow noreferrer">http://en.wikipedia.org/wiki/Acid</a> (definition of acid is extracted from this link)  </li>
<li><a href="http://en.wikipedia.org/wiki/Base_(chemistry)" rel="nofollow noreferrer">http://en.wikipedia.org/wiki/Base_(chemistry)</a> (definition of base is extracted from this link)</li>
</ul>

#### Answer 3 (score -2)
<p>In organic chemistry, whether a compound is acidic or basic can be predicted by looking at the molecular structure and can quite easily be explained by applying the resonance theory.  In essence, if the compound can ionize to form a proton and the resulting anion is stable, then the ionization equilibria will be shifted to the right and the compound is acidic.  The more stable the anion, the more acidic the compound is.<br>
Consider the following examples:</p>

<ol>
<li>Sulfuric acid   <span class="math-container">$\ce{H2SO4 &lt;=&gt; 2H+ + SO4^2-}$</span>   the sulfate anion is stabilized by 4 resonant structures, therefore sulfuric acid is very acidic.</li>
<li>Nitric acid  <span class="math-container">$\ce{HNO3 &lt;=&gt; H+ + NO3-}$</span>   the nitrate anion is stabilized by 3 resonant structures, therefore nitric acid is acidic.</li>
<li>Carboxylic acids   <span class="math-container">$\ce{RCOOH &lt;=&gt; H+ + RCOO-}$</span>   the carboxylate anion is stabilized by 2 resonant structures, therefore carboxylic acids are acidic.</li>
<li>Phenols versus alcohols.  <span class="math-container">$\ce{C6H5OH &lt;=&gt; H+ + C6H5O-}$</span>   the phenoxide anion has 4 resonant structures while the alkoxide anion has none.  Therefore, phenols are more likely to ionize to produce a proton than alcohols.  That is, phenols are more acidic than alcohols.</li>
<li>Ketones versus alcohols.    <span class="math-container">$\ce{R1COCHR2R3 &lt;=&gt; H+ + R1COC-R2R3}$</span>   the resulting anion has 2 resonant structures whereas alcohols have none.  Therefore the α-hydrogen to the carbonyl group is acidic because the enoxide ion is more stable than the alkoxide ion (keto-enol tautomerism).</li>
<li>Amides   <span class="math-container">$\ce{RCONH2 &lt;=&gt; H+  + RCONH-}$</span>  the resulting anion has 2 resonant structures, but they are not equivalent because one has the negative charge on the oxygen, the other one has it on the nitrogen.  Therefore the anion is not particularly stable so amides are only weakly acidic.  The lone pair of electrons on the nitrogen is only slightly available for bonding because they are withdrawn by the more electronegative oxygen.  Therefore amides are only weakly basic. They are practically neutral.</li>
<li>Sulfonamides  <span class="math-container">$\ce{RS(O)2NH2 &lt;=&gt; H+  + RS(O)2NH-}$</span>   the resulting anion has 3 resonant structures, 2 of which have the negative charge on the more electronegative oxygen atom.  Therefore sulfonamides are a little more acidic than amides and can form salt with metals (e.g. silver sulfadiazine, sodium sulfacetamide).</li>
<li>Urea  <span class="math-container">$\ce{H2NCONH2}$</span> the lone pair of electrons on one nitrogen are withdrawn by the more electronegative oxygen (see amide above), but the lone pair on the other nitrogen is available for bonding.  Therefore urea is basic.</li>
<li>Imides  <span class="math-container">$\ce{R1CONHCOR2 &lt;=&gt; H+ +  R1CON-COR2}$</span>   the resulting anion has 3 resonant structures, 2 of which have the negative charge on the more electronegative oxygen, therefore imides are acidic (for example phthalimide).</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: What is the reaction between oxalic acid and potassium permanganate? (score [150505](https://stackoverflow.com/q/4310) in 2017)

#### Question
I've already searched online some information about this equation, but everywhere I read, there's also sulfuric acid, which we did not use in the laboratory. We only used potassium permanganate and oxalic acid and water, there was no sulfuric acid. The purpose of the laboratory was to calculate experimentally the rate of the reaction at different concentrations, but in order to do so, I need the balanced equation. Can anyone help me out?  

By the way, the oxalic acid was dihydrate.  

If anyone is wondering, one of the experiments was as follows:  

First we took $1.5~\pu{mL}$ of $\ce{H2C2O4}$ and added $1.5~\pu{mL}$ of $\ce{H2O}$, and finally, we added $1~\pu{mL}$ of $\ce{KMnO4}$ and then we shook the test tube until the colour changed from purple to ochre. Because from what I read, they said the $\ce{H2SO4}$ was necessary so the reaction takes place, but in the experiment, the reaction did occur and we didn't use it.  

#### Answer accepted (score 8)
We had a titration of oxalic acid vs. potassium permanganate for an experiment in which we used concentrated $\ce{H2SO4}$.   

Actually, the reaction requires an acidic medium i.e. $\ce{H+}$ is involved as a reactant... I suppose the $\ce{H+}$ released by the oxalic acid would be enough since you are studying the rate of the reaction though I am not sure.  

<p>The balanced ionic equation is:
$\ce{2MnO4- + 5H2C2O4 + 6H+ -&gt; 2 Mn^2+ + 10CO2 + 8H2O}$</p>

As you can see, $\ce{H+}$ is involved as a reactant and that is why you might have read that conc.$\ce{H2SO4}$ is necessary.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: What are the products of the dissociation of sodium bicarbonate in water? What is the relative pH of the solution? (score [142789](https://stackoverflow.com/q/8490) in 2017)

#### Question
I had a recent question on a test that asked what the products would be if sodium hydrogen carbonate were dissolved in water. I had a few candidate answers  

<ol>
<li>$\displaystyle\ce{NaHCO3 -&gt; Na+ + HCO3-}$, but that one doesn't involve water at all</li>
<li>$\displaystyle\ce{NaHCO3 + H2O -&gt; Na+ + OH- + H2CO3}$, but doesn't $\ce{H2CO3}$ decompose into $\ce{H2O + CO2}$?</li>
<li>$\displaystyle\ce{NaHCO3 + H2O -&gt; Na+ + OH- + H2O + CO2}$, but that has water on both sides of the equation.</li>
</ol>

Part two of the question asked whether the solution would be acidic, basic, or neutral. What is the proper reaction for this?  

#### Answer accepted (score 12)
It's not as intuitive as it seems and your questions are all legitimate questions, but sometimes even good arguments can't be used as evidence in chemistry.  

<hr>

<blockquote>
  $\ce{NaHCO3 -&gt; Na+ + HCO3-}$, but that one doesn't involve water at all  
</blockquote>

<p>Look at this reaction:
$$\ce{NaCl &lt;=&gt;Na+ +Cl-}$$</p>

Even this reaction doesn't "involve" water in the schematics but is right, we assume that is a dissociation of a salt in water.  

<hr>

<blockquote>
  $\ce{NaHCO3 + H2O -&gt; Na+ + OH- + H2CO3}$, but doesn't $\ce{H2CO3}$ decompose into $\ce{H2O + CO2}$?  
</blockquote>

<p>Yes, but in fact this is an equilibrium:
$$\ce{H2CO3 &lt;=&gt; H2O + CO2}$$</p>

<p>And then you have to take into account another important equilibrium many time ignored:
$$\ce{CO2 (aq) &lt;=&gt; CO2 (g)}$$
So the amount of $\ce{CO2}$ present in the solution depends on by the type of system and the pressure exerted. Like a Coca-Cola bottle: if the system is closed, the $\ce{CO2}$ remains dissolved otherwise the equilibrium shift to the right and the $\ce{CO2}$ "escapes" until the rate between the $\ce{CO2}$ molecule dissolved and the $\ce{CO2}$ molecule escaped forms the solution is the same. </p>

<hr>

<blockquote>
  $\ce{NaHCO3 + H2O -&gt; Na+ + OH- + H2O + CO2}$, but that has water on both sides of the equation.  
</blockquote>

Okay, it is not a net ionic equation but the stoichiometry is still right. Maybe water is used to indicate that we are talking about a reaction that takes place in water.  

<hr>

<h5>Which reaction is not right?</h1>

<p>All the reactions here are right, I think maybe they put some formal inaccuracies to help you, but in fact they are all part of series of equilibria that normally occur and can be described as:
$$\begin{multline}
\ce{NaHCO3 + H2O &lt;=&gt;[A] Na+ + HCO3- + H2O &lt;=&gt;[B] Na+ + H2CO3 + OH-} \\
\ce{ &lt;=&gt;[C] Na+ + OH- + H2O + (CO2(aq)&lt;=&gt;[C_2]CO2 ^ (g))}\end{multline}$$</p>

The question should be more specific asking for <strong>the ultimate</strong> products of the reaction because all these are products of the dissociation of sodium hydrogen carbonate and because are equilibria is probable that all the species are present in different amounts when the reaction reach the equilibrium. However, the ultimate products are described by the third answer. And this equation can give you a hint about the acidity of the solution. When $\ce{CO2}$ escape from the solution (equilibrium $\mathrm{C_2}$ goes to the right) the concentration of the manly acid species goes down but the hydroxides from the equilibrium $\mathrm{B}$ are still present so at the end the solution in an open system with an atmosphere with a low partial pressure of $\ce{CO2}$ will have a higher pH, will become mildly alkaline.  

#### Answer 2 (score -1)
First, ionize the salt as you have shown. NaOH is a very strong base so Na+ must be a very weak acid. It is solvated. Being a singly-charged, rather large cation, it stops there. If it were $\ce{Al^{3+}}$, coordinated water would be acidic by charge withdrawal from that brutally small trication.  

Bicarbonate is the salt of the first ionization of weak carbonic acid. It will then be a modestly weak base by hydrolysis, as you have shown (reversible). Bicarbonate solutions are weakly basic. If you add acid (even weak acetic acid) they fizz. Boiling the solution will drive out carbon dioxide.  

Carbonate is the salt of the second ionization of weak carbonic acid. It is a strong base.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Can an atom have more than 8 valence electrons? If not, why is 8 the limit? (score [132839](https://stackoverflow.com/q/444) in 2015)

#### Question
According to some chemistry textbooks, the maximum number of valence electrons for an atom is 8, but the reason for this is not explained.   

So, can an atom have more than 8 valence electrons?   

If this is not possible, why can't an atom have more than 8 valence electrons?  

#### Answer accepted (score 94)
<strong>2017-10-27 Update</strong>  

<em>[NOTE: My earlier notation-focused answer, unchanged, is below this update.]</em>  

Yes. While having an octet of valence electrons creates an exceptionally deep energy minimum for most atoms, it is only a minimum, not a fundamental requirement. If there are sufficiently strong compensating energy factors, even atoms that strongly prefer octets can form stable compounds with more (or less) than the 8 valence shell electrons.  

However, the same bonding mechanisms that enable formation of greater-than-8 valence shells also enable alternative structural interpretions of such shells, depending mostly on whether such bonds are interpreted as ionic or covalent. <a href="https://chemistry.stackexchange.com/a/445/83">Manishearth's excellent answer</a> explores this issue in much greater detail than I do here.  

Sulfur hexafluoride, $\ce{SF6}$, provides a delightful example of this ambiguity. As I described diagrammatically in my original answer, the central sulfur atom in $\ce{SF6}$ can be interpreted as either:  

(a) A sulfur atom in which all 6 of its valence electrons have been fully ionized away by six fluorine atoms, or  

(b) A sulfur atom with a stable, highly symmetric 12-electron valence shell that is both created and stabilized by six octahedrally located fluorine atoms, each of which covalently shares an electron pair with the central sulfur atom.  

While both of these interpretations are plausible from a purely structural perspective, the ionization interpretation has serious problems.  

The first and greatest problem is that fully ionizing all 6 of sulfur's valence electrons would require energy levels that are unrealistic ("astronomical” might be a more apt word).  

A second issue is that the stability and clean octahedral symmetry of $\ce{SF6}$ strongly suggests that the 12 electrons around the sulfur atom have reached a stable, well-defined energy minimum that is different from its usual octet structure.  

Both points imply that the simpler and more energetically accurate interpretation of the sulfur valence shell in $\ce{SF6}$ is that it has 12 electrons in a stable, non-octet configuration.  

Notice also that for sulfur this 12- electron stable energy minimum is unrelated to the larger numbers of valence-related electrons seen in transition element shells, since sulfur simply does not have enough electrons to access those more complex orbitals. The 12 electron valence shell of $\ce{SF6}$ is instead a true bending of the rules for an atom that in nearly all other circumstances prefers to have an octet of valence electrons.  

That is why my overall answer to this question is simply "yes".  

<em>Question: Why are octets special?</em>  

The flip side of whether stable non-octet valence shells exist is this: Why do octet shells provide an energy minimum that is so deep and universal that the entire periodic table is structured into rows that end (except for helium) with noble gases with octet valence shells?  

In a nutshell, the reason is that for any energy level  above the special case of the $n=1$ shell (helium), the "closed shell" orbital set $\{s, p_x, p_y, p_z\}$ is the only combination of orbitals whose angular momenta are (a) all mutually orthogonal, and (b) cover all such orthogonal possibilities for three-dimensional space.  

It is this unique orthogonal partitioning of angular momentum options in 3D space that makes the $\{s, p_x, p_y, p_z\}$ orbital octet both especially deep and relevant even in the highest energy shells. We see the physical evidence of this in the striking stability of the noble gases.  

The reason orthogonality of angular momentum states is so important at atomic scales is the Pauli exclusion principle, which requires that every electron have its own unique state. Having orthogonal angular momentum states provides a particularly clean and easy way to provide strong state separation between electron orbitals, and thus to avoid the larger energy penalties imposed by Pauli exclusion.  

Pauli exclusion conversely makes incompletely orthogonal sets of orbitals substantially less attractive energetically. Because they force more orbitals to share the same spherical space as the fully orthogonal $p_x$, $p_y$, and $p_d$ orbitals of the octet, the $d$, $f$, and higher orbitals are increasingly less orthogonal, and thus subject to increasing Pauli exclusion energy penalties.  

<em>A final note</em>  

I may later add another addendum to explain angular momentum orthogonality in terms of classical, satellite-type circular orbits. If I do, I'll also add a bit of explanation as to why the $p$ orbitals have such bizarrely different dumbell shapes.  

(A hint: If you have ever watched people create a two loops in a single skip rope, the equations behind such double loops have unexpected similarities to the equations behind $p$ orbitals.)  

<strong>Original 2014-ish Answer (Unchanged)</strong>  

This answer is intended to supplement <a href="https://chemistry.stackexchange.com/a/445/83">Manishearth's earlier answer</a>, rather than compete with it. My objective is to show how octet rules can be helpful even for molecules that contain more than the usual complement of eight electrons in their valence shell.  

I call it donation notation, and it dates back to my high school days when none of the chemistry of the texts in my small-town library bothered to explain how those oxygen bonds worked in anions such as carbonate, chlorate, sulfate, nitrate, and phosphate.  

The idea behind this notation is simple. You begin with the electron dot notation, then add arrows that show whether and how other atoms are "borrowing" each electron. A dot with an arrow means that that the electron "belongs" mainly to the atom at the base of the arrow, but is being used by another atom to help complete that atom's octet. A simple arrow without any dot indicates that the electron has effectively left the original atom. In that case, the electron is no longer attached to the arrow at all but is instead shown as an increase in the number of valence electrons in the atoms at the end of the arrow.  

Here are examples using table salt (ionic) and oxygen (covalent):  

<img src="https://i.stack.imgur.com/tjb6K.gif" alt="salt and oxygen in donation notation">  

Notice that the ionic bond of $\ce{NaCl}$ shows up simply as an arrow, indication that it has "donated" its outermost electron and fallen back to its inner octet of electrons to satisfy its own completion priorities. (Such inner octets are never shown.)  

Covalent bonds happen when each atom contributes one electron to a bond. Donation notation shows both electrons, so doubly bonded oxygen winds up with four arrows between the atoms.  

Donation notation is not really needed for simple covalent bonds, however. It's intended more for showing how bonding works in anions. Two closely related examples are calcium sulfate ($\ce{CaSO4}$, better known as gypsum) and calcium sulfite ($\ce{CaSO3}$, a common food preservative):  

<img src="https://i.stack.imgur.com/IIDSF.gif" alt="calcium sulfate and sulfite in donation notation">  

In these examples the calcium donates via a mostly ionic bond, so its contribution becomes a pair of arrows that donate two electrons to the core of the anion, completing the octet of the sulfur atom. The oxygen atoms then attach to the sulfur and "borrow" entire electrons pairs, without really contributing anything in return. This borrowing model is a major factor in why there can be more than one anion for elements such as sulfur (sulfates and sulfites) and nitrogen (nitrates and nitrites). Since the oxygen atoms are not needed for the central atom to establish a full octet, it is possible for some of the pairs in the central octet to remain unattached. This results in less oxidized anions such as sulfites and nitrites.  

Finally, a more ambiguous example is sulfur hexafluoride:  

<img src="https://i.stack.imgur.com/aU9gk.gif" alt="sulfur hexafluoride in donation notation">  

The figure shows two options. Should $\ce{SF6}$ be modeled as if the sulfur is a metal that gives up all of its electrons to the hyper-aggressive fluorine atoms (option a), or as a case where the octet rule gives way to a weaker but still workable 12-electron rule (option b)? There is <a href="http://en.wikipedia.org/wiki/Hypervalent_molecule#History_and_controversy" rel="noreferrer">some controversy even today</a> about how such cases should be handled. The donation notation shows how an octet perspective can still be applied to such cases, though it is never a good idea to rely on first-order approximation models for such extreme cases.  

<strong>2014-04-04 Update</strong>  

Finally, if you are tired of dots and arrows and yearn for something closer to standard valence bond notation, these two equivalences come in handy:  

<img src="https://i.stack.imgur.com/ckKXP.png" alt="covalent and u-bond versions of donation notation">  

The upper straight-line equivalence is trivial since the resulting line is identical in appearance and meaning to the standard covalent bond of organic chemistry.  

The second <em>u-bond</em> notation is the novel one. I invented it out of frustration in high school back in the 1970s (yes I'm that old), but never did anything with it at the time.  

The main advantage of u-bond notation is that it lets you prototype and assess non-standard bonding relationships while using only standard atomic valences. As with the straight-line covalent bond, the line that forms the u-bond represents a single pair of electrons. However, in a u-bond, it is the atom at the bottom of the U that donates <em>both</em> electrons in the pair. That atom gets nothing out of the deal, so none of its bonding needs are changed or satisfied. This lack of bond completion is represented by the absence of any line ends on that side of the u-bond.  

The beggar atom at the top of the U gets to use <em>both</em> of the electrons for free, which in turn means that <em>two</em> of its valence-bond needs are met. Notationally, this is reflected by the fact that both of the line ends of the U are next to that atom.  

Taken as a whole, the atom at the bottom of a u-bond is saying "I don't like it, but if you are <em>that</em> desperate for a pair of electrons, and if you promise to stay very close by, I'll let you latch onto a pair of electrons from my already-completed octet."  

Carbon monoxide with its baffling "why does carbon suddenly have a valence of two?" structure nicely demonstrates how u-bonds interpret such compounds in terms of more traditional bonding numbers:  

<a href="https://i.stack.imgur.com/j3Wbb.png" rel="noreferrer"><img src="https://i.stack.imgur.com/j3Wbb.png" alt="Carbon monoxide in u-bond notation"></a>  

Notice that two of carbon's four bonds are resolved by standard covalent bonds with oxygen, while the remaining two carbon bonds are resolved by the formation of a u-bond that lets the beggar carbon "share" one of the electron pairs from oxygen's already-full octet. Carbon ends up with four line ends, representing its four bonds, and oxygen ends up with two. Both atoms thus have their standard bonding numbers satisfied.  

Another more subtle insight from this figure is that since a u-bond represents a single pair of electrons, the combination of one u-bond and two traditional covalent bonds between the carbon and oxygen atoms involves a total of six electrons, and so should have similarities to the six-electron triple bond between two nitrogen atoms. This small prediction turns out to be correct: nitrogen and carbon monoxide molecules are in fact electron configuration homologues, one of the consequences of which is that they have nearly identical physical chemistry properties.  

Below are a few more examples of how u-bond notation can make anions, noble gas compounds, and odd organic compounds seem a bit less mysterious:  

<a href="https://i.stack.imgur.com/mMR6h.png" rel="noreferrer"><img src="https://i.stack.imgur.com/mMR6h.png" alt="Collection of hypervalent molecules"></a>  

#### Answer 2 (score 87)
Yes, it can. We have molecules which contain "superoctet atoms". Examples:  

$\ce{PBr5, XeF6, SF6, HClO4, Cl2O7, I3- ,  K4[Fe(CN)6], O=PPh3 }$  

Almost <em>all</em> coordination compounds have a superoctet central atom.  

Non-metals from Period 3 onwards are prone to this as well. The halogens, sulfur, and phosphorus are repeat offenders, while <em>all</em> noble gas compounds are superoctet. Thus sulfur can have a valency of +6, phosphorus +5, and the halogens +1, +3, +5, and +7. Note that these are still covalent compounds -valency applies to covalent bonds as well.  

The reason why this isn't usually seen is as follows. We basically deduce it from the properties of <a href="http://enwp.org/Atomic_orbital" rel="noreferrer">atomic orbitals</a>.  

By the <a href="http://en.wikipedia.org/wiki/Aufbau_Principle" rel="noreferrer">aufbau principle</a>, electrons fill up in these orbitals for period $n$:  

$n\mathrm{s}, (n-2)\mathrm{f},(n-1)\mathrm{d},n\mathrm{p}$  

(theoretically, you'd have $(n-3)\mathrm{g}$ before the $\mathrm{f}$, and so on. But we don't have atoms with those orbitals, yet)  

Now, the outermost shell is $n$. In each period, there are only eight slots to fill in this shell by the Aufbau principle - 2 in $n\mathrm{s}$, and 6 in $n\mathrm{p}$. Since our periodic table pretty much follows this principle, we don't see any superoctet atoms usually.  

But, the $\mathrm{d,f}$ orbitals for that shell <em>still exist</em> (as empty orbitals) and can be filled if the need arises. By "exist", I mean that they are low enough in energy to be easily filled. The examples above consist of a central atom, that has taken these empty orbitals into its hybridisation, giving rise to a superoctet species(since the covalent bonds add an electron each)  

I cooked up a periodic table with the shells marked. I've used the shell letters instead of numbers to avoid confusion. $K,L,M,N$ refer to shell 1,2,3,4 etc. When a slice of the table is marked "M9-M18", this means that the first element of that block "fills" the ninth electron in the M(third) shell, and the last element fills the eighteenth.  

Click to enlarge:  

<a href="https://i.stack.imgur.com/kY6qF.png" rel="noreferrer"><img src="https://i.stack.imgur.com/kY6qFm.png" alt="enter image description here"></a>  

<sub>(Derivative of <a href="http://commons.wikimedia.org/wiki/File:White_periodic_table.svg" rel="noreferrer">this image</a>)</sub>  

Note that there are a few irregularities, with $\ce{Cu}$, $\ce{Cr}$, $\ce{Ag}$, and a whole bunch of others which I've not specially marked in the table.  

#### Answer 3 (score 50)
<em>In chemistry, and in science in general, there are many ways of explaining the same empirical rule. Here, I am giving an overview that is very light on quantum chemistry: it should be fairly readable at a novice level, but will not explain in its deepest way the reasons for the existence of electronic shells.</em>  

<hr>

The “rule” you are citing is known as the <a href="http://en.wikipedia.org/wiki/Octet_rule" rel="noreferrer"><strong>octet rule</strong></a>, and one of its formulations is that  

<blockquote>
  atoms of low (<em>Z</em> &lt; 20) atomic number tend to combine in such a way that they each have eight electrons in their valence shells  
</blockquote>

You'll notice that it's not specifically about a <em>maximal</em> valence (i.e. the number of electrons in the valence shell), but a <em>preferred</em> valence in molecules. It is commonly used to determine the <a href="http://en.wikipedia.org/wiki/Lewis_structure" rel="noreferrer">Lewis structure</a> of molecules.  

However, the octet rule is not the end of the story. If you look at hydrogen (H) and helium (He), you will see that do not prefer an eight-electron valence, but a two-electron valence: H forms e.g. H<sub>2</sub>, HF, H<sub>2</sub>O, He (which already has two electrons and doesn't form molecules). This is called the <strong><a href="http://en.wikipedia.org/wiki/Octet_rule#Exceptions" rel="noreferrer">duet rule</a></strong>. Moreover, heavier elements including all <a href="http://en.wikipedia.org/wiki/Transition_metal" rel="noreferrer">transition metals</a> follow the aptly-named <strong><a href="http://en.wikipedia.org/wiki/18-Electron_rule" rel="noreferrer">18-electron rule</a></strong> when they form metal complexes. This is because of the quantum nature of the atoms, where electrons are organized in <a href="http://en.wikipedia.org/wiki/Electron_shell" rel="noreferrer">shells</a>: the first (named the K shell) has 2 electrons, the second (L-shell) has 8, the third (M shell) has 18. Atoms combine into molecules by trying in most cases to have valence electrons entirely filling a shell.  

Finally, there are elements which, in some chemical compounds, break the duet/octet/18-electron rules. The main exception is the family of <a href="http://en.wikipedia.org/wiki/Hypervalent_molecule" rel="noreferrer"><strong>hypervalent molecules</strong></a>, in which a main group element nominally has more than 8 electrons in its valence shell. Phosphorus and sulfur are most commonly prone to form hypervalent molecules, including $\ce{PCl5}$, $\ce{SF6}$, $\ce{PO4^3-}$, $\ce{SO4^2-}$, and so on. Some other elements that can also behave in this way include iodine (e.g. in $\ce{IF7}$), xenon (in $\ce{XeF4}$), and chlorine (in $\ce{ClF5}$). (This list isn't exhaustive.)  

<a href="https://chemistry.stackexchange.com/a/5242/16683">Gavin Kramar's answer</a> explains how such hypervalent molecules can come about despite apparently breaking the octet rule.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How do I extract cyanide from apple seeds? (score [128983](https://stackoverflow.com/q/24528) in 2016)

#### Question
I'm working on a crime story about cyanide poisoning from apple seeds. I just would like to have an idea of what processes and extraction techniques might be involved in getting cyanide from the seeds. The character is supposed to have access to a high school chemistry lab; so I was thinking equipment and tools that can be found in a typical HS lab. I prefer a detailed answer, step by step, if possible. If not then just generalized terminologies would work.  

#### Answer accepted (score 43)
<ol>
<li>Forget about the apple seeds, they contain about 1 to 4 mg amygdalin per gramm seeds (<a href="http://dx.doi.org/10.1016/j.foodchem.2014.08.083">DOI</a>).</li>
<li>Instead, collect <strong>apricot seeds</strong> during the right season, the amygdalin content varies though the year and can be as high as 5% of the dry weight of the seed (<a href="http://dx.doi.org/10.2306/scienceasia1513-1874.2012.38.218">DOI</a>).</li>
<li>It is probably advantagenous to break the husk with a nut cracker, a plier, etc. and cut the softer inner material to smaller pieces.</li>
<li><p>Extraction of amygdalin can be performed by</p>

<ul>
<li>immersing the material in methanol and subsequent ultrasonification</li>
<li>Soxhlet extraction with methanol</li>
<li>reflux extraction in water in the presence of citric acid</li>
</ul></li>
</ol>

A comparison of the extraction methods is given <a href="http://dx.doi.org/10.1093/chromsci/43.7.383">here</a>.  

Removal of the solvent in vacuum will yield a crude material with significant amounts of amygdalin. You might want to have a look at this article from the <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1272529/pdf/westjmed00222-0011.pdf">Western Journal of Medicine</a> on the toxicity. Here, an $\mathrm{LD_{50}}$ of 522 mg amygdalin per kg body weight was estimated for the oral application to rats. The online resource of the <a href="http://chem.sis.nlm.nih.gov/chemidplus/rn/29883-15-6">U.S. National Library of Medicine</a> gives a value of 405 mg/kg.  

<p><hr>
Further information on the health risk of apricot kernels are provided by of the German <a href="http://www.bfr.bund.de/cm/343/verzehr_von_bitteren_aprikosenkernen_ist_gesundheitlich_bedenklich.pdf">Bundesinstitut für Risikobewertung</a> (Federal Institute for Risk Assessment) and the British <a href="http://cot.food.gov.uk/sites/default/files/cot/cotstatementapricot200615.pdf">Committee on Toxicity</a>.</p>

A note in the a German medical journal, Deutsche Ärzteblatt, (<a href="http://www.aerzteblatt.de/pdf/111/50/a2240.pdf">PDF</a>) describes a case where boy of four years (110 cm, 18 kg body weight) was given apricot kernels during an alternative cancer treatment. Upon additional treatment with a single dose of 500 mg amygdalin, the kid showed agitation, spasms and the eyes started to roll.  

<p><hr>
I'll leave it up to your fantasy as a writer on how to apply the poison, but spicing some marzipan with it might help ;) </p>

#### Answer 2 (score 13)
Honestly, you probably wouldn't be able to get this done with just a highschool chem lab, at least not to a high purity (whether or not this is needed is debatable; in fact it could be interesting in the story because it would give a clue as to how it was produced, whereas pure cyanide wouldn't really tell the detective much).  

Having said that, apples don't contain the harmful version of cyanide (hydrogen cyanide) in and of themselves. They do however contain amygdalin, which can be metabolized to hydrogen cyanide. A quick search ends up with <a href="http://en.wikipedia.org/wiki/Amygdalin">wikipedia</a> giving a brief overview of how it is isolated:  

<blockquote>
  Amygdalin is extracted from almonds or apricot kernels by boiling in ethanol; on evaporation of the solution and the addition of diethyl ether, amygdalin is precipitated as white minute crystals.  
</blockquote>

In case your orgo isn't all that great (mine is a little rusty too), what you should read from the above quote is that ethanol is used to oxydize the primary alcohol group to an aldehyde or a carboxylic acid (depending on how long you let it boil for) making it polar and so non-soluble the diethyl ether (an organic solvent) which leads it to precipitating out as a white crystal. Once it precipitates out the easiest way to isolate it is just to use a paper filter, since it should be the only solid present. Suction filtration would be optimal but that's generally not available in high schools. Lastly you could use <a href="http://en.wikipedia.org/wiki/Sublimation_%28phase_transition%29">sublimation</a> to get a really pure final product, but again this isn't normally available in high school labs.  

If you're writing a novel I recommend you take the time to read up on it and how it is metabolized within the body. The more you understand the process the more authentic it'll feel, imo. Best of luck.  

EDIT: You may want to consider switching to apricot kernels as opposed to apple seeds. The process is effectively the same but it's more realistic, since you'd need a LOT of apple seeds to get a decent amount of cyanide. Also, like I said my orgo is a bit rusty so if someone else could look over this that would be nice.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How to dissolve candle wax (paraffin)? (score [126910](https://stackoverflow.com/q/17109) in 2015)

#### Question
Wikipedia states that waxes can be dissolved by non-polar organic solvents.   

I failed to dissolve candle wax in both acetone and ethanol, which are the only organic solvents I have at home.  

I have some clothes with wax stuck on them. How can I dissolve the wax and drive it away without damaging my clothing?  

#### Answer accepted (score 16)
Ethanol and acetone are not non-polar organic solvents. Each one has  a slight dipole moment; due to the difference of electronegativity between $\ce{H}$ and  $\ce{O}$ in ethanol and between $\ce{C}$ and  $\ce{O}$ in acetone.  Wax is composed of heavy, long-chain alkanes. And as "Like dissolves like" try to dissolve your wax in toluene or in xylene.  

#### Answer 2 (score 12)
Being a chemist, I know that paraffin would require a lipophilic solvent as pointed out by others. It occurred to me that ordinary vegetable oil is a cheap and of course innocuous lipophilic substance. I spilled about 2 oz molten candle wax on a marble surface and after it solidified removed a good portion by scraping with a plastic spoon. This was followed by adding about a tablespoon of vegetable oil and mixing with the spoon. The wax dissolved in the oil with no problem and could be mopped up with a paper towel. Treatment of the oily residue with sink soap removed what was left. Hope this helps.   

#### Answer 3 (score 4)
A readily available mixture of various non-polar alkanes  would be petrol (gasoline).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: What do the different grades of chemicals mean? (score [126176](https://stackoverflow.com/q/575) in 2017)

#### Question
When purchasing chemicals from Sigma, Fisher, or wherever, there are often <em>-grade</em>'s attached to their description like <em>reagent-grade</em>, <em>technical-grade</em>, <em>analytical-grade</em>, or more niche-sounding <em>biotech-grade</em>, <em>HPLC-grade</em>, <em>DNA grade</em> (DNase free perhaps?)  

Is there some sort of standard for what these actually mean or are they arbitrary, differing from supplier to supplier or even chemical to chemical?  Beyond the 'niche' grades, is there a common order of purity between the others or do they depend on the <em>types</em> of impurities?  

#### Answer accepted (score 31)
Sigma-Aldrich gives a very useful <a href="http://www.sigmaaldrich.com/technical-service-home/product-portfolio.html" rel="noreferrer">table</a> outlining what the different purity levels are and suggested applications. I was less successful at finding equal documentation from some of the other suppliers, but the analysis for the purity of the chemicals they sell is in the catalog and on the bottle.   

In general, technical grade or laboratory grade are the lowest purity. <a href="http://pubs.acs.org/reagents/index.html" rel="noreferrer">ACS Reagent grade</a> means that the chemical conforms to specifications defined by the Committee on Analytical Reagents of the American Chemical Society (but Aldrich <em>"ReagentPlus"</em> means >95% pure). So, "ACS Reagent grade" chemicals should be comparable from different suppliers.  Analytical grade is generally the most pure.  

For some of the other grades, such as HPLC grade solvents, the issue is less about overall purity than about being free of substances that would interfere with a particular application. I've reproduced a piece of the table below to give you an idea of the information available.   

<a href="https://i.stack.imgur.com/KX2Z0.png" rel="noreferrer"><img src="https://i.stack.imgur.com/KX2Z0.png" alt="enter image description here"></a>  

#### Answer 2 (score 0)
At the company Puritan Products, the reagent grade designation is used to describe high purity chemicals for which no established specifications exist. Apparently, this is often the case with products diluted from ACS grade products, as some of these cannot be ACS reagent grade in dilution by the standards that ACS sets.   

<a href="http://www.puritanproducts.com/resources-support/chemicals-101/acs-vs-reagent-grade/" rel="nofollow noreferrer">Source</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: How to calculate melting/boiling points at different pressures (score [124630](https://stackoverflow.com/q/14373) in )

#### Question
I know water boils at below room temperature in a vacuum, and want to know if there's an equation to calculate the melting or boiling points of elements or compounds at a given pressure.   

How would I go at attempting this?  

The main reason I ask is because I'd like to know if Gallium, a metal which melts at $29.77^\circ C$ at atmospheric pressure would be in a liquid state at room temperature if stored under a vacuum.   

Thanks!  

#### Answer accepted (score 13)
I don't believe there is an equation that you can use for <strong>melting points</strong> of a general substance as a function of pressure (since the melting phase transition has a lot to do with the geometry of the molecule and the structure of the solid), but there is one for the <strong>boiling point</strong> of any pure substance when you are not near the critical point.  

The liquid-vapor transition follows a very specific curve on the pressure-temperature plane of a PVT diagram. This is given by the <a href="http://en.wikipedia.org/wiki/Clausius%E2%80%93Clapeyron_relation" rel="noreferrer">Clausius-Clapeyron</a> relation, which at temperatures and pressures that are not close to the critical point, can be approximated as:  

<p>$$
\ln\frac{P_2}{P_1} = \frac{-\Delta H_{vap}}{R}\left(\frac{1}{T_2} - \frac{1}{T_1}\right)
$$</p>

This is the two-point form, which lets you predict the pressure of the vapor phase at a given temperature if you know the temperature and pressure at another point, and the enthalpy of vaporization.  

You can use this to predict boiling points as a function of pressure by recognizing that:  

<blockquote>
  The boiling point is the temperature at which the vapor pressure at equilibrium exceeds atmospheric pressure  
</blockquote>

This means that if you know the boiling point of a substance at 1 atm (the normal boiling point), and you know $\Delta H_{vap}$ for that substance, you can predict the boiling point at another pressure by plugging in values for $P_1$ and $T_1$ (the normal boiling point), $P_2$ (the pressure you are interested in), and $\Delta H_{vap}$, the enthalpy of vaporization (also sometimes called the <strong>latent heat</strong>), then solving for $T_2$ (the new boiling point.)  

Like I said, this only works when you aren't near the critical point, but for most applications that's not a concern.  

For your specific case, especially since you are probably more interested in the liquid-solid transition at this temperature, you are better off looking at a phase diagram.  

Here's one for gallium (<a href="http://commons.wikimedia.org/wiki/File:Phase_diagram_of_gallium_(1975).png" rel="noreferrer">source</a>) (<a href="http://www.osti.gov/scitech/servlets/purl/4010212" rel="noreferrer">original source</a>):  

<img src="https://i.stack.imgur.com/1oVI7.png" alt="Phase diagram of gallium">  

The solid-liquid line has a negative slope at low pressure (as ron pointed out) which means the melting temperature <em>increases</em> as pressure decreases. Depending on how high the vacuum is, and on what temperature "room temperature" is, you might be in the solid phase - but the slope is steep, so even at 0 atm the melting point is still right around 300 K.  

#### Answer 2 (score 2)
There is no general equation for melting points and boiling points that applies to all elements.  However, the melting point for gallium has been studied in considerable detail because gallium's melting point has been adopted as a calibration standard.  Isotech, a calibration company posted the following:  

"2.3 The temperature of the melting point equilibrium of pure gallium depends upon the ambient pressure of the surrounding environment, and varies with atmospheric pressure expressed upon the surface of the gallium column as follows:  

t C = 29.7646 +/- (-0.002 C per std. atmos.) Eq. 2  

(The negative sign of the coefficient is a result of the solidus expansion (liquidus contraction)."  

Here is a <a href="http://www.isotech.co.uk/files/document_library_file-31.pdf" rel="nofollow">link</a> to the above formula (see page 3).  Perhaps you could contact Isotech to get further clarification on their formula.  

#### Answer 3 (score 0)
A pressure-Temperature nomograph such as <a href="http://www.sigmaaldrich.com/chemistry/solvents/learning-center/nomograph.html" rel="nofollow">this one by Sigma-Aldrich</a>  

might help this and related questions.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: White powder observed after boiling water in electric kettle for many weeks (score [124224](https://stackoverflow.com/q/4094) in )

#### Question
I used my water kettle (metal ones, not the plastic ones) to boil my water. Usually, if I did not consume all the water in the kettle and the water was cold, I usually topup extra water to the kettle and turn it on to boil.  

So, after many weeks of boiling in this way, I notice that there are white powder outside the kettle. (I notice that when the water is boil, some water was splashed to the outside of the kettle and I left those water splashed out to dry as time goes)  

Is the white powder actually called fluoride? How do I tested it to verify if the white powder chemical is safe or not?    

#### Answer accepted (score 19)
It's likely that your home is supplied with "hard" water (that is, water with a high mineral content). These dissolved minerals typically include calcium or magnesium ions (from dissolved calcium bicarbonate and magnesium bicarbonate, respectively). Heating or boiling your "hard" water in a kettle will soften it by precipitating the calcium carbonate as its solubility decreases with increasing temperature.   

<img src="https://i.stack.imgur.com/4PlKK.jpg" alt="enter image description here">  

This (calcium carbonate) could be the white powder you have observed after evaporation. Hard water should not pose any health risks, and in fact can add some extra calcium and magnesium to your diet. If it's still concerning to you, there are hundreds of products available that can soften your water before you use it, just google "water softener" and you'll be overwhelmed.  

<a href="http://en.wikipedia.org/wiki/Hard_water" rel="noreferrer">http://en.wikipedia.org/wiki/Hard_water</a>  

#### Answer 2 (score 2)
I live a place where the water is extremely hard, and I regularly remove calcium carbonate from my electric heater. The method is quite simple: fill the kettle with water, add citric acid (as solid) and heat. You will notice a lot of gas which is carbondioxide (CaCO3 + 2H+ -> Ca2+ + H2O + CO2). You can use any acid but citric acid is cheap.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: What is a neutral atom? (score [122442](https://stackoverflow.com/q/738) in 2019)

#### Question
I was told that an atom's atomic number is defined as follows:  

<blockquote>
  The number of electrons or protons present in a <strong>neutral atom</strong> is called atomic number. It is represented by `Z`.  
</blockquote>

What does neutral mean here? Why isn't it just "..present in an atom..."?  

#### Answer accepted (score 19)
Electrons and protons are charged particles. The electrons have negative charge, while protons have positive charge. A neutral atom is an atom where the charges of the electrons and the protons balance. Luckily, one electron has the same charge (with opposite sign) as a proton.  

Example: Carbon has 6 protons. The neutral Carbon atom has 6 electrons. The atomic number is 6 since there are 6 protons.  

#### Answer 2 (score 11)
Here, a "neutral atom" is simply an atom that has no charge.  

See, an atom consists of protons, neutrons, and electrons. Protons are positively charged, electrons are negatively charged (with the same magnitude of charge per particle as a proton). Neutrons have no charge.  

Now, in a "neutral atom", the number of protons must be equal to the number of electrons, otherwise it would not be neutral.  

Basically, the definition is saying that "in a neutral atom, the atomic number is equal to both the number of protons , <em>and</em> the number of electrons, because, well, they both are the same."  

Compare this with an <a href="http://en.wikipedia.org/wiki/Ion">ion</a>  

<blockquote>
  An ion is an atom or molecule in which the total number of electrons is not equal to the total number of protons, giving it a net positive or negative electrical charge  
</blockquote>

Here, the atomic number cannot be equal to both--because they are unequal. In this case, a better definition would be:  

<blockquote>
  The number of protons present in an atom is it's atomic number. It is represented by $Z$.  
</blockquote>

#### Answer 3 (score 5)
I totally agree with George that <a href="https://chemistry.stackexchange.com/questions/738/what-is-a-neutral-atom#comment1424_738">"neutral atom" is close to nonsense</a>. Indeed, IUPAC recommends the following definition for atom:  

<blockquote>
  <strong><a href="http://goldbook.iupac.org/A00493.html" rel="nofollow noreferrer">atom</a></strong>  
  
  <p>Smallest particle still characterizing a chemical element. It
  consists of a nucleus of a positive charge ($Z$ is the proton number and
  $e$ the elementary charge) carrying almost all its mass (more than
  99.9%) and $Z$ electrons determining its size.</p>
</blockquote>

As one can see, for an atom the proton number, also known as atomic number, which is the number of protons in the atomic nucleus, is the same as the number of electrons. Consequently, any atom is (electrically) neutral by definition, as George mentioned in his comment.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: Why does chlorine have a higher electron affinity than fluorine? (score [118254](https://stackoverflow.com/q/6901) in )

#### Question
Since fluorine has its valence electrons in the n=2 energy level, and since chlorine has its valence electrons in the n=3 energy level, one would initially expect that an electron rushing towards fluorine would release more energy, as it would land in the n=2 energy level, whereas in chlorine, the electron would land only in the n=3 energy level, and would then not release as much energy.  Thus, one would expect fluorine to have a greater electron affinity than chlorine.  However, why is it that chlorine has a higher electron affinity (349 kJ/mol)  than fluorine (328.165 kJ/mol)?  

#### Answer accepted (score 14)
Fluorine, though higher than chlorine in the periodic table, <strong>has  a very small atomic size</strong>. This makes the fluoride anion so formed unstable (highly reactive) due to a very high charge/mass ratio. Also, fluorine has no d-orbitals, which limits its atomic size. As a result, fluorine has an electron affinity less than that of chlorine.  

See <a href="http://answers.yahoo.com/question/index?qid=20090424075637AA1Dz7r">this</a>.  

#### Answer 2 (score 10)
The electron being gained by fluorine would be taken in to a much smaller 2p orbital and requires more electron coupling energy than that of much larger 3p orbital of chlorine. Therefore, energy released during the electron gaining process of fluorine is less than that of chlorine.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: What is the carbon dioxide content of a soda can or bottle? (score [116338](https://stackoverflow.com/q/9067) in )

#### Question
I sort of know how carbonated beverages are carbonated: a lot of $\ce{CO2}$ gets pushed into the liquid, and the container is sealed. There are at least two things I don't know. First, how much carbon dioxide is actually dissolved in the liquid? Second, what is the resulitng partial pressure of $\ce{CO2}$ in the headspace and the total pressure in the headspace? I'm interested in cans, plastic bottles, and glass bottles. I know from experience that there is some variation among manufacturers even for the same beverage, so I will be happy with general numbers or a good estimate.  

#### Answer accepted (score 9)
General estimates have placed a can of Coca-Cola to have 2.2 grams of $\ce{CO2} $ in a single can. As a can is around 12 fluid ounces, or 355 ml, the amount of $\ce{CO2}$ in a can is:  

$$\text{2.2 g} \ \ce{CO2}* \frac{\text{1 mol} \ \ce{CO2}}{\text{44 g} \ \ce{CO2} } = 0.05 \ \text{mol}$$  

$$ \text{355 mL} * \frac{\text{1 L}}{\text{1000 mL}} = 0.355 \ \text{L} $$  

So here we can see we have about 0.05 mol/0.355 L or about 0.14 mol of carbon dioxide per liter of soda. Of course this value varies by manufacturer, type of drink, container, etc.  

Looking at Wikipedia, inside Coca-Cola is:  

<blockquote>
  Carbonated water, Sugar (sucrose or high-fructose corn syrup depending on country of origin), Caffeine, Phosphoric acid, Caramel color (E150d), Natural flavorings  
  
  A can of Coke (12 fl ounces/355 ml) has 39 grams of carbohydrates (all from sugar, approximately 10 teaspoons), 50 mg of sodium, 0 grams fat, 0 grams potassium, and 140 calories.  
</blockquote>

Thus, we can calculate the pressure of $CO_2$ gas using the Ideal Gas equation if we store our coke at, say, 20 Celsius:  

<p>$$ P = \frac{nRT}{V} $$
$$ P = \frac{\text{0.05 mol} * \text{0.08206} \frac{\text{L} \cdot \text{atm}}{\text{mol} \cdot \text{K} } * \text{293.15 K}}{\text{0.355 L}}$$
$$ P = 3.39 \ \text{atm} $$</p>

According to this website, <a href="http://hypertextbook.com/facts/2000/SeemaMeraj.shtml">http://hypertextbook.com/facts/2000/SeemaMeraj.shtml</a>:  

<blockquote>
  On average, the 12 ounce soda cans sold in the US tend to have a pressure of roughly 120 kPa when canned at 4 °C, and 250 kPa when stored at 20 °C.  
</blockquote>

$$\text{3.39 atm} * \frac{\text{760 torr}}{\text{1 atm}} * \frac{\text{133 Pa}}{\text{1 torr}} * \frac{\text{1 kPa}}{\text{1000 Pa}} = 342.66 \ \text{kPa}$$  

Water vapor exerts it's own partial pressure. Looking at standard tabulated values for water vapor pressure, water exerts a pressure of 17.5 torr at 20 Celsius.  

$$\text{17.5 torr}* \frac{\text{133 Pa}}{\text{1 torr}} * \frac{\text{1 kPa}}{\text{1000 Pa}} = 2.3275 \ \text{kPa} $$  

Knowing that our total pressure is the sum of all our pressures:  

$$P_{total} = \text{342.66 kPa} + \text{2.3275 kPa} = 344.99 \ \text{kPa}$$  

Here, we are roughly about 100 kPa off from the data provided by the website. This is just an approximation. A more accurate way would be to calculate the moles of each product inside the soda, and knowing the total pressure or partial pressure of one of the parts, we can calculate the pressures more accurately. However, that information is proprietary. It's their secret recipe!   

<strong>Headspace:</strong>  

<a href="http://extension.psu.edu/food/preservation/news/2012/why-allow-headspace">http://extension.psu.edu/food/preservation/news/2012/why-allow-headspace</a>  

We have to determine the volume of the headspace - again, I am not sure of exact data - which is between 1/2 inch to 1 and 1/2 inches depending on the container and what it holds. I will assume that the headpsace occupies 6% of the total volume of the can which is 21.3 mL.  

At manufacturing and at storage, the can is at different temperatures. Taking the above data, we'll say it is manufactured at $4^\circ C$ and say, stored at $20^\circ C$  

Furthermore, when carbon dioxide is solubilized in water, it forms carbonic acid. I will neglect that as the ionization constant is small.  

Assuming our 2.2 grams of carbon dioxide is the <em>maximum</em> amount of carbon dioxide that can be placed inside, some of the carbon dioxide is soluble in water while the rest exerts pressure inside the headspace to force the carbon dioxide inside the liquid. The pressure is necessary inside this closed volume as, once you open the cap, the carbon dioxide tries to achieve equilibrium.  

$$ \ce{CO_2 (solution) &lt;=&gt; CO2 (g)} $$  

In general, the solubility of gases <em>increases</em> at lower temperatures and <em>decreases</em> at higher temperatures. A notable exception is the noble gases. In regards to pressure, Henry's law states that the solubility of a gas in a liquid is directly proportional to the pressure of that gas above the surface of the solution.   

The solubility of carbon dioxide in water shifts according to Le Chatlier's principle.  

For the solution to this problem, we would need to know several things about the manufacturing of soda's, or rather, more quantitative data. At manufacturing, the pressure is high and temperature low, so as much carbon dioxide as possible is solubilized in the water.   

Once shipped out and stored, the pressure inside the headspace increases as the pressure is decreased from manufacturing, the carbon dioxide then leaves solution and enters the headspace. Increasing temperature also decreases solubility.  

If you can provide me with more information, I will be more than happy to help. :)  

#### Answer 2 (score 3)
It depends from drink and time, according to <a href="http://www.ncbi.nlm.nih.gov/pubmed/20457301" rel="nofollow">S. Teerasong, Analytica Chimica Acta 668 (2010) 47–53</a> for a normal Cola is about $3.1 \frac{g_{CO_2}}{L}$ (take a look even to <a href="http://www.chemicalbulletin.ro/admin/articole/69129art_5.pdf" rel="nofollow">Glevitzky, Chem. Bull. "POLITEHNICA" Univ. (Timişoara) Volume 50 (64), 1-2,2005</a> but his esteem is very high).  

Regarding the pressure in the headspace this is very difficult to esteem theoretically because you have to take in account not only the temperature but the whole system. <del>:you can shake the bottle and increase the pressure dramatically</del>.  

#### Answer 3 (score 3)
It depends from drink and time, according to <a href="http://www.ncbi.nlm.nih.gov/pubmed/20457301" rel="nofollow">S. Teerasong, Analytica Chimica Acta 668 (2010) 47–53</a> for a normal Cola is about $3.1 \frac{g_{CO_2}}{L}$ (take a look even to <a href="http://www.chemicalbulletin.ro/admin/articole/69129art_5.pdf" rel="nofollow">Glevitzky, Chem. Bull. "POLITEHNICA" Univ. (Timişoara) Volume 50 (64), 1-2,2005</a> but his esteem is very high).  

Regarding the pressure in the headspace this is very difficult to esteem theoretically because you have to take in account not only the temperature but the whole system. <del>:you can shake the bottle and increase the pressure dramatically</del>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How can I figure out the electron configuration of Br-? (score [114629](https://stackoverflow.com/q/6872) in 2016)

#### Question
It's easy to do atomic electron configuration, but ionic is confusing.  

#### Answer accepted (score 7)
The electronic configuration for $\ce{Br-}$ is:  

$$\mathrm{1s^2 2s^2 2p^6 3s^2 3p^6 4s^2 3d^{10} 4p^6}$$  

Because it have one more electron than bromine, which ends its electronic configuration with $\mathrm{4p^5}$.  

#### Answer 2 (score 5)
I suppose that you know how to find the atomic electron configuration for Br which is $\mathrm{1s^22s^22p^63s^23p^64s^23d^{10}4p^5}$. Now for ions, it is really simple. All you have to do is look at if the ion is a cation or an anion. If it is an anion then add the same amount of electrons as the number of the charge. If it is a cation subtract the number electrons as the number of the charge.   

In the case of $\ce{Br-}$ it is an anion of charge minus 1 meaning that it will have one more electron than a normal bromine atom. So really its electron configuration will be the same as krypton which is the atom after bromine. So all you have to do is add an extra electron in the last orbital, the 4p orbital. Therefore its electron configuration will be: $$\mathrm{1s^22s^22p^63s^23p^64s^23d^{10}4p^6}$$  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: How come water would not affect the results of a titration? (score [114627](https://stackoverflow.com/q/11016) in 2019)

#### Question
We were told to rinse the buret with the base so that the concentration won't be messed up, but when it comes to the flask that is going to hold the acid, there is no need to rinse, because it would not affect the result if it has water in it.  

Why is that? Wouldn't the acid be diluted a little bit and that throws off the accuracy?  

#### Answer accepted (score 4)
The volume and concentration of base equals the number of moles of base. This is use to determine the number of moles of acid in the flask. Since you are interested in the number of moles of acid in the flask, why would adding water (which doesn't have any acid) change the number of moles of acid?  

#### Answer 2 (score 2)
Considering a direct titration:  

<a href="https://i.stack.imgur.com/gwyDr.gif" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/gwyDr.gif" alt="Titration Set up"></a>  

You will probably use a volumetric pipette to pass the acid solution to the erlenmeyer used on the titration, so the volume of acid is known (the exactly volume of the pipette).  

<a href="https://i.stack.imgur.com/lwrGx.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/lwrGx.jpg" alt="Volumetric Pipette"></a>  

Any distilled water you add to this erlenmeyer will change its volume, but won't change the amount of substance of acid inside it, neither the initial volume you added of the acid solution. Sometimes it's even recommended that you add some water to make the color change more visible.  

The objective of the titration is to find the volume of the base (of known concentration) necessary to neutralize the acid, and therefore, since you know the volume of acid added in the erlenmeyer (the pipette volume), calculate the concentration of the acid solution.  

Water in the glass of the buret can cause variations in the concentration of the base being used, reason why we rinse it with the base, so we have a good precision titration. The erlenmeyer can be rinsed only with distilled water, since the volume of acid solution used for the calculation is constant.  

You will have a equation that looks like this:  

<span class="math-container">$$V(\text{base}) \cdot c(\text{base}) = V(\text{acid}) \cdot c(\text{acid}) \cdot f$$</span>  

Where <span class="math-container">$V(\text{base})$</span> is the volume of base consumed in the titration, <span class="math-container">$c(\text{base})$</span> is the concentration of the base (which is known), <span class="math-container">$V(\text{acid})$</span> is the volume of the solution of acid added to the erlenmeyer (the volume of the pipette), <span class="math-container">$c(\text{acid})$</span> is the estimated concentration of the acid and <span class="math-container">$f$</span> is the correction coefficient (so the real acid concentration is <span class="math-container">$c(\text{acid}) \cdot f$</span>).  

#### Answer 3 (score 0)
<p>Where concentration matters ( burette )
there is rinsing to achieve stable and constant concentration.</p>

Where amounts matters ( flask ) there is no rinsing to achieve stable and constant amount.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: What is the pKa Range for weak acids and bases? (score [112391](https://stackoverflow.com/q/7851) in 2015)

#### Question
Am I correct in assuming that the following is true?  

<ul>
<li><p>$\mathrm pK_\mathrm a &lt; 3$ is for a strong acid</p></li>
<li><p>$3 &lt; \mathrm pK_\mathrm a &lt; 7$ is for a weak acid</p></li>
<li><p>$7 &lt; \mathrm pK_\mathrm a &lt; 11$ is for a weak base</p></li>
<li><p>$\mathrm pK_\mathrm a &gt; 11$ is for a strong base</p></li>
</ul>

#### Answer accepted (score 10)
$\mathrm pK_\mathrm a$ is negative log of the acid dissociation constant ($K_\mathrm a$).  

$$\mathrm pK_\mathrm a = -\log K_\mathrm a$$  

Acid dissociation constant is the equilibrium constant of the dissociation of ions of an acid in an aqueous solution. Consider a weak acid $\ce{HA}$. Weak acids do not dissociate completely in aqueous solution. The equilibrium for the dissociation of such acids can be expressed as  

$$ \ce{HA + H2O &lt;=&gt; H3O+ + A-}$$  

The equilibrium constant for this reaction(dissociation) will be  

$$K_\mathrm a = \frac{\ce{[H3O+][A^{-}]}}{\ce{[HA]}}$$  

It can be seen that the greater is the extent of dissociation, the greater will be the value of $K_\mathrm a$. Or, the stronger is the acid, the greater will be its $K_\mathrm a$.  

Since, $\mathrm pK_\mathrm a$ is negative log of $K_\mathrm a$, it's values will be greater for weaker acid.  

There is no sharp boundary between <em>weak</em> and <em>strong</em> acid. Wikipedia defines strong acids as <a href="http://en.wikipedia.org/wiki/Acid_strength" rel="nofollow noreferrer"><em>acids which ionize completely in aqueous solution</em></a>. So, an acid, say $\ce{HA}$ , is said to be strong if one mole of this acid dissociates in aqueous solution to give one mole of $\ce{H+}$ and one mole of $\ce{A-}$. Now $K_\mathrm a$ of such an acid will be 1.  

Usually, $\mathrm{pH}$ is used to measure the acid strength, which is negative log of $\ce{H+}$ ion concentration. $$\mathrm{pH} = -\log\ce{[H+]}$$  

<p>The concentration of $\ce{H+}$ ions in water is $10^{-7}$ (It has been found out experimentally). Hence, its $\mathrm{pH}$ is $-\log(10^{-7}) = 7$.
For acids stronger than $\ce{H2O}$, the concentration of $\ce{H+}$ ions, $\ce{[H+]} &gt; 10^{-7}$. So, $\mathrm{pH} &lt; 7$ for acids and $\mathrm{pH} &gt; 7$ for bases.</p>

What you are referring to may actually be $\mathrm{pH}$ and in that case the ranges you've given <s>are</s> may be correct. But once again there is no clear difference between <em>weak</em> and <em>strong</em>.  

<p>There is a simple relation between $\mathrm{pH}$ and $\mathrm pK_\mathrm a$,
$$\mathrm{pH} = \frac{1}{2}[\mathrm pK_\mathrm a - \log c]$$
where $c$ is concentration of the acid. You can derive this relation using <a href="http://en.wikipedia.org/wiki/Law_of_dilution" rel="nofollow noreferrer">Ostwald's dilution law</a>.</p>

Similarly, we have $K_\mathrm b$, $\mathrm pK_\mathrm b$ and <a href="http://en.wikipedia.org/wiki/PH#pOH" rel="nofollow noreferrer">$\mathrm{pOH}$</a> for bases which are basic analogues of $K_\mathrm a$, $\mathrm pK_\mathrm a$ and $\mathrm{pH}$. These variables show the strength of a base.  

<strong>Conclusion</strong>  

<ul>
<li><p>The greater is the value of $K_\mathrm a$, the stronger will be the acid and the weaker will be the base.</p></li>
<li><p>The greater is the value of $\mathrm pK_\mathrm a$, the weaker will be the acid and the stronger will be the base.</p></li>
<li><p>The greater is the value of $\mathrm{pH}$, the weaker will be the acid and the stronger will be the base. For acids, $\mathrm{pH} &lt; 7$ and for bases, $\mathrm{pH} &gt; 7$.</p></li>
<li><p>The greater is the value of $K_\mathrm b$, the stronger will be the base and the weaker will be the acid.</p></li>
<li><p>The greater is the value of $\mathrm pK_\mathrm b$, the weaker will be the base and the stronger will be the acid.</p></li>
<li><p>The greater is the value of $\mathrm{pOH}$, the weaker will be the base and the stronger will be the acid. For bases, $\mathrm{pOH} &lt; 7$ and for acids, $\mathrm{pOH} &gt; 7$.</p></li>
</ul>

#### Answer 2 (score 3)
Not quite, what you are describing is the <a href="http://en.wikipedia.org/wiki/PH" rel="nofollow noreferrer">pH scale</a>, although the two terms are related, according to the Columbia University document <a href="http://www.columbia.edu/~crg2133/Files/CambridgeIA/Chemistry/AcidityBasicitykPa.pdf" rel="nofollow noreferrer">Acidity, Basicity and $pK_a$</a>, $pK_a$ is  

<blockquote>
  It turns that that the $pK_a$ of an acid is the $pH$ at which it is exactly half dissociated  
</blockquote>

The full derivation is on the document (and a bit long to post here with explanations).  

But another explanation is provided in the document <a href="http://kchem.weebly.com/uploads/8/6/0/4/8604167/6_ph_and_pka.pdf" rel="nofollow noreferrer">$pH$ and $pK_a$</a>, where they state  

<blockquote>
  <p>$pK_a$ tells you if a given molecule is going to either 
  give a proton to water at a certain $pH$, or remove a 
  proton</p>
</blockquote>

So, to answer your question, in terms of $pK_a$, strong and weak acids and bases can be defined by the following table of examples:  

<img src="https://i.stack.imgur.com/qzj49.gif" alt="enter image description here">  

Image source: <a href="http://pharmacy.nova.edu/Pharmacodynamics/Modules/AcidsSaltsBases/Main_P3.html" rel="nofollow noreferrer">Strength of Acids and Bases</a>, a key point is that there is no clear boundary that defines strong from weak acids or bases.  

They conclude with the following very generalised rule for $pK_a$:  

<blockquote>
  For acids: the stronger the acid, the smaller the $pK_a$  
  
  For bases: the stronger the base, the larger the $pK_a$  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: What is the difference between D and L configuration, and + and −? (score [112282](https://stackoverflow.com/q/44260) in 2017)

#### Question
What is the difference between D and L configuration, and + and −?   

<p>My textbook says they are two different things. 
It also says that the correct way to name glucose is D(+)-glucose. </p>

Could someone please explain what D, L and +, − represent, and why they are different?  

#### Answer accepted (score 24)
The D-L system corresponds to the <b>configuration</b> of the molecule: spatial arrangement of its atoms around the chirality center.  

While (+) and (-) notation corresponds to the <b>optical activity</b> of the substance, whether it rotates the plane of polarized light clockwise (+) or counterclockwise (-).  

D-L system tells us about the <em>relative configuration</em> of the molecule, compared to the enantiomers of glyceraldehyde as the standard compound. Compounds with the same relative configuration as (+)-glyceraldehyde are assigned the D prefix, and those with the relative configuration of (-)-glyceraldehyde are given the L prefix.  

It's kind of another way to tell the configuration of molecules beside the Cahn–Ingold–Prelog convention (R/S system), with little difference. (D-L system labels the <em>whole</em> molecule, while R/S system labels the <em>absolute configuration</em> of <em>each</em> chirality center.)  

In short, the D-L system doesn't have direct connection to (+)/(-) notation. It only relates the stereochemistry of the compound with that of glyceraldehyde, but says nothing about its optical activity. We may have compound with same relative configuration as (+)-glyceraldehyde (thus, it's given the D prefix), yet it rotates the polarized light counterclockwise (-), such as D-(-)-ribose.  

And also, don't confuse the D-L system with d- and l- naming. d- and l- is the exact same with (+) and (-) notation.  

<hr>

<b>Additional explanation</b>  

D-L system (also called Fischer–Rosanoff convention) is mainly used for naming α-amino acids and sugars. It compares the relative configurations of molecules to the enantiomers of glyceraldehyde. This convention is still in common use today.  

Rosanoff in 1906 selected the enantiomeric glyceraldehydes as the point of reference<sup>[1]</sup>; any sugar derivable by chain lengthening from what is now known as (+)-glyceraldehyde (or named D-glyceraldehyde) belongs to the D series. In other words, we used a D to designate the sugars that degrade to (+)-glyceraldehyde and an L for those that degrade to (-)-glyceraldehyde.  

In assigning the D and L configurations of sugars, we could direcly look for the OH group of the bottom asymmetric carbon in the Fischer projection. If it's located on the right, we designate it with D, and vice versa, since they would have the same relative configurations with glyceraldehyde for the bottom asymmetric carbon.  

<b>Reference</b>  

[1]: IUPAC and IUBMB. Joint Commission On Biochemical Nomenclature. <i>Nomenclature of Carbohydrates</i>. <b>1996</b>, 7.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: Why is the 2s orbital lower in energy than the 2p orbital when the electrons in 2s are usually farther from the nucleus? (score [109958](https://stackoverflow.com/q/152) in 2014)

#### Question
<img src="https://i.stack.imgur.com/Tnn32.gif" alt="Diagram of P orbital vs. S orbital distance from nucleus">  

My chemistry book explains that even though electrons in the 2p orbital are closer to the nucleus on average, electrons from the 2s orbital spend a very short time very close to the nucleus (penetration), so it has a lower energy. Why does this tiny amount of time spent close to the nucleus make such a big difference? It seems like it should be the average distance that matters, not the smallest distance achieved at any one point, in determining stability. What makes that momentary drop in energy so important that it is outweighs all the time spent farther away from the nucleus with a higher energy?  

#### Answer accepted (score 54)
<p>I think your question implicates another question (which is also mentioned in some comments here), namely: Why are all energy eigenvalues of states with a different <strong>angular momentum quantum number</strong> $\ell$ but with the same <strong>principal quantum number</strong> $n$ (e.g. $3s$, $3p$, $3d$) degenerate in the hydrogen atom but non-degenerate in multi-electron atoms?
Although `AcidFlask` already gave a good answer (mostly on the non-degeneracy part) I will try to eleborate on it from my point of view and give some additional information. 
I will split my answer in three parts: The first will address the $\ell$-degeneracy in the hydrogen atom, in the second I will try to explain why this degeneracy is lifted, and in the third I will try to reason why $3s$ states are lower in energy than $3p$ states (which are in turn lower in energy than $3d$ states).</p>

<h5>$\ell$-degeneracy of the hydrogen atoms energy eigenvalues</h2>

<p>The non-relativistic electron in a hydrogen atom experiences a potential that is analogous to the <a href="http://en.wikipedia.org/wiki/Kepler_problem">Kepler problem</a> known from classical mechanics. 
This potential (aka Kepler potential) has the form $\frac{\kappa}{r}$, where $r$ is the distance between the nucleus and the electron, and $\kappa$ is a proportionality constant. 
Now, it is known from physics that symmetries of a system lead to conserved quantities (<a href="http://en.wikipedia.org/wiki/Noether%27s_theorem">Noether Theorem</a>).
For example from the rotational symmetry of the Kepler potential follows the conservation of the angular momentum, which is characterized by $\ell$. But while the length of the angular momentum vector is fixed by $\ell$ there are still different possibilities for the orientation of its $z$-component, characterized by the <strong>magnetic quantum number $m$</strong>, which are all energetically equivalent as long as the system maintains its rotational symmetry.
So, the rotational symmetry leads to the $m$-degeneracy of the energy eigenvalues for the hydrogen atom.
Analogously, the $\ell$-degeneracy of the hydrogen atoms energy eigenvalues can also be traced back to a symmetry, the $SO(4)$ symmetry. 
The system's $SO(4)$ symmetry is not a geometric symmetry like the one explored before but a so called dynamical symmetry which follows from the form of the Schroedinger equation for the Kepler potential.
(It corresponds to rotations in a four-dimensional cartesian space. Note that these rotations do not operate in some physical space.)
This dynamical symmetry conserves the <a href="http://en.wikipedia.org/wiki/Runge-Lenz">Laplace-Runge-Lenz vector</a> $\hat{\vec{M}}$ and it can be shown that this conserved quantity leads to the $\ell$-independent energy spectrum with $E \propto \frac{1}{n^2}$. (A detailed derivation, though in German, can be found <a href="http://www.desy.de/~jlouis/Vorlesungen/PS_06/vortrag_09.pdf">here</a>.)</p>

<h5>Why is the $\ell$-degeneracy of the energy eigenvalues lifted in multi-electron atoms?</h2>

<p>As the $m$-degeneracy of the hydrogen atom's energy eigenvalues can be broken by destroying the system's spherical symmetry, e.g. by applying a magnetic field, the $\ell$ degeneracy is lifted as soon as the potential appearing in the Hamilton operator deviates from the pure $\frac{\kappa}{r}$ form.
This is certainly the case for multielectron atoms since the outer electrons are screened from the nuclear Coulomb attraction by the inner electrons and the strength of the screening depends on their distance from the nucleus.
(Other factors, like spin and relativistic effects, also lead to a lifting of the $\ell$-degeneracy even in the hydrogen atom.)</p>

<h5>Why do states with the same $n$ but lower $\ell$ values have lower energy eigenvalues?</h2>

Two effects are important here:  

<ul>
<li><p>The <strong>centrifugal force</strong> puts an "energy penalty" onto states with higher angular momentum.${}^{1}$ So, a higher $\ell$ value implies a stronger centrifugal force, that pushes electrons away from the nucleus.</p>

<ol>
<li>The concept of centrifugal force can be seen in the radial Schroedinger equation for the radial part $R(r)$ of the wave function $\Psi(r, \theta, \varphi) = R(r) Y_{\ell,m} (\theta, \varphi )$
\begin{equation}
\bigg( \frac{ - \hbar^{2} }{ 2 m_{\mathrm{e}} } \frac{ \mathrm{d}^{2} }{ \mathrm{d} r^{2} } + \\underbrace{ \frac{ \hbar^{2} }{ 2 m_{\mathrm{e}} } \frac{ \ell (\ell + 1) }{ r^{2} } } - \frac{ Z e^{2} }{ 2 m_{\mathrm{e}} r } - E \bigg) r R(r) = 0
\end{equation}
\begin{equation}
{}^{= ~ V^{\ell}_{\mathrm{cf}} (r)} \qquad \qquad
\end{equation}
The radial part experiences an additional $\ell$-dependent potential $V^{\ell}_{\mathrm{cf}} (r)$ that pushes the electrons away from the nucleus.</li>
</ol></li>
<li><p><strong>Core repulsion</strong> (Pauli repulsion), on the other hand, puts an "energy penalty" on states with a lower angular momentum. That is because the core repulsion acts only between electrons with the same angular momentum${}^{1}$. So it acts stronger on the low-angular momentum states since there are more core shells with lower angular momentum. </p>

<ol>
<li>Core repulsion is due to the condition that the wave functions must be orthogonal which in turn is a consequence of the Pauli principle. Because states with different $\ell$ values are already orthogonal by their angular motion, there is no Pauli repulsion between those states. However, states with the same $\ell$ value feel an additional effect from core orthogonalization.</li>
</ol></li>
</ul>

<p>The "accidental" $\ell$-degeneracy of the hydrogen atom can be described as a balance
between centrifugal force and core repulsion, that both act against the nuclear Coulomb
attraction.
In the real atom the balance between centrifugal force and core repulsion is broken,
The core electrons are contracted compared to the outer electrons because there are less inner electron-shells screening the nuclear attraction from the core shells than from the valence electrons.
Since the inner electron shells are more contracted than the outer ones, the core repulsion is weakened whereas the effects due to the centrifugal force remain unchanged. The reduced core repulsion in turn stabilizes the states with lower angular momenta, i.e. lower $\ell$ values. So, $3s$ states are lower in energy than $3p$ states which are in turn lower in energy than $3d$ states.</p>

Of course, one has to be careful when using results of the hydrogen atom to describe effects in multi-electron atoms as `AcidFlask` mentioned. But since only a qualitative description is needed this might be justifiable.  

I hope this somewhat lengthy answer is helpful. If something is wrong with my arguments I'm happy to discuss those points.   

#### Answer 2 (score 36)
General chemistry textbooks tend to explain atomic structure exceedingly poorly using a hodgepodge of obsolete concepts. Your chemistry book provides such a typical example - the notion of penetration only makes sense in the ancient <a href="http://en.wikipedia.org/wiki/Bohr_model#Refinements">Bohr-Sommerfeld</a> model that has been obsolete since the discovery of quantum mechanics! The idea was that orbits of electrons in $p$ states were more elliptical than those in $s$ states because they had more angular momentum, and so on average there will be some fraction of the time where $p$ electrons would be closer to the nucleus than those in the $s$ orbits, i.e. they would <em>penetrate</em> the $s$ orbit.  

We now know that electrons do not actually have classical orbits and that the Bohr-Sommerfeld model is wrong. However there remains one correct statement of fact, which is that electrons in $p$ orbitals by definition have more angular momentum than those in $s$ orbitals. (The orbital angular momentum is $l=1$ in $p$ and $l=0$ in $s$.) Nonetheless it is completely misleading, since $2s$ and $2p$ orbitals are only well-defined in hydrogen and other ions with only one electron, and furthermore that <em>all orbitals of the same principal quantum number are degenerate in energy in hydrogenic systems</em>. Thus angular momentum alone cannot be the answer.  

It is only due to electron-electron interactions that the orbitals that correspond to $2s$ and $2p$ in multielectron atoms split and become nondegenerate. The effect of having more angular momentum therefore turns out to be only indirectly responsible via the different many-electron interactions occurring in the analogs of $2p$ and $2s$ orbitals in many-electron atoms. The simplest explanation that is even remotely correct is the screening effect, where the $2s$ electrons by their very presence make the $2p$ electrons feel a lower effective nuclear charge than if they were absent. A more precise quantum mechanical statement is that Slater's variational treatment of the nuclear charge in hydrogenic orbitals results in a lower effective nuclear charge for $2p$ electrons than $2s$ orbitals. There is unfortunately no good <em>a priori</em> physical principle for this; it is merely a statement of a result from a quantum mechanical calculation.  

Summary: $2p$ electrons are higher in energy than $2s$ ones due to screening effects that result from electron-electron interactions. Explanations involving penetration of classical orbits or purely angular momentum considerations are wrong, even though they tend to show up in general chemistry textbooks.  

#### Answer 3 (score 19)
<blockquote>
  It seems like it should be the average distance that matters  
</blockquote>

No. It is the average energy that matters. Note that this stuff about "spends so much time here and so much there..." is really just a (not particularly good) way of describing a quantum-mechanical wave function's absolute square. The electron is actually never at any particular place in the orbital, rather it's <em>everywhere at the same time</em> – until you decide to measure its precise position (thereby destroying the orbital, that has to do with the <a href="http://en.wikipedia.org/wiki/Heisenberg_uncertainty_principle">Heisenberg uncertainty principle</a>), in which case there would be a certain <em>probability</em> of finding it here or there. That probability can be calculated from the <a href="http://en.wikipedia.org/wiki/Wavefunction">wave function</a> $\psi(\mathbf{x})$ by taking its absolute square, which gives the radial distribution function in your plots.  

The energy of any quantum state is determined by the expectation value of the <a href="http://en.wikipedia.org/wiki/Hamiltonian_%28quantum_mechanics%29">Hamiltonian operator</a>, which very roughly means "measure the energy at <em>all</em> places in space, multiply with the probability the electron is found at that place, and add all those values up". That should sound quite intuitive. In actuality it's more complicated: the electron also has some kinetic energy at every place in space, which is itself <a href="http://en.wikipedia.org/wiki/Momentum_operator#Definition">encoded in the wave function</a> – but you need to consider its <em>complex phase</em>, which is a whole extra dimension that you simply don't see in your plots and certainly not in the average distance.  

Calculating the exact energies for atomic orbitals is a lot of maths that probably doesn't belong here, but it's possible to <a href="http://en.wikipedia.org/wiki/Hydrogen-like_atom#Non-relativistic_wavefunction_and_energy">carry it out</a>*, and it should be obvious now that the result doesn't necessarily have much to do with simple "energy at the average distance". The quantities such as angular momentum mentioned in CHM's answer can be used to make it a bit simpler again (the Hamiltonian <em>separates</em> into a radial and spherical part), but that alone doesn't really explain much I suppose.  

<p><br>
*As a matter of fact, it's <em>not</em> possible to calculate it exactly for anything more complicated than a hydrogen atom! You have to do it with certain approximations.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Difference between conformational, constitutional, and structural isomers and the same and different molecules (score [109938](https://stackoverflow.com/q/6676) in 2015)

#### Question
Consider the following sets of problems:  

<img src="https://i.stack.imgur.com/8CNGb.jpg" alt="enter image description here">  

I was hoping someone could clarify what each checkbox means exactly. All of these answers are incorrect (except the first one with the check marks signifies the correct answers).  

For example, why are the first pair different molecules? What makes something a conformation/constitution/structural isomer?   

What does it mean to say something is an "identical conformation of the same molecule" vs "different conformation of the same molecule?"  

When can I definitiviely tell if something is an enantiomer or just a diastereomer? It seems like (for an enantiomer) you can't just do the check of "switch all dashes to wedges and all wedges to dashes" because, as in the third pair of newman projections, they are enantiomers of each other but I don't understand why that is.  

#### Answer accepted (score 3)
I'm going to assume that you don't need an explanation for the checkboxes `the same molecule` and `difference molecules`, so that leaves the following:  

The terms <strong>constitutional isomers</strong> and <strong>stereoisomers</strong> make up two broad categories of isomers (molecules with the same chemical formula).  Constitutional isomers typically have different connectivities and stereoisomers have the same connectivities but differ in spatial arrangements.  

<strong>enantiomers</strong> are stereoisomers that are non-superimposeable mirror images of one another.  Your hands are (roughly) enantiomers.  <strong>both are optically active</strong> is true of enantiomers.  

<strong>diastereomers</strong> also known as geometric isomers are also stereoisomers that are not mirror images of one another. cis- and trans-dichloroethene are diastereomers.  

If you do a web image search of isomer flowchart you'll see a lot of informative information on isomers.  Linked below is the public domain version from <a href="http://en.wikipedia.org/wiki/Isomer" rel="nofollow noreferrer">Wikipedia</a> which is an example (although not the best in my opinion.)  

<img src="https://i.stack.imgur.com/rU4ZK.png" alt="enter image description here">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: amu and g/mol relation (score [109925](https://stackoverflow.com/q/13764) in 2018)

#### Question
Do we have that $\pu{1 g/mol} = \pu{1 amu}$ ?  

Because we have, for the mass of an atom of carbon 12, call it $m(\ce{^12C})$, that  

$$m(\ce{^12C}) = \pu{12 amu}$$  

and furthermore  

$$\pu{1 mol} \cdot m(\ce{^12C}) = \pu{12 g}$$  

therefore  

$$m(\ce{^12C}) = \pu{12 amu} = \pu{12 g/mol}$$  

So finally we get that $\pu{1 g/mol} = \pu{1 amu}$ .  

However, my chemistry teacher is telling me that those are two completely different things and that I am confused between the mass per atom and the mass per $6.022\cdot10^{23}$ atoms. I can't understand how, and this is really bugging me, so help is very appreciated.  

Note that this requires the mole to be a number (or a "constant"), which may be where I'm wrong.  

#### Answer accepted (score 13)
You are correct, but to make it a little more clear you can include the assumed "atom" in the denominator of amu:  

<p><span class="math-container">$$
\begin{align}
m_{\ce{C}^{12}} &amp;= \pu{12amu atom^-1} \\ \\
m_{\ce{C}^{12}} &amp;= \pu{12g mol^-1} \\ \\
\pu{12amu atom^-1} &amp;= \pu{12g mol^-1} \\ \\
\pu{1amu atom^-1} &amp;= \pu{1g mol^-1}
\end{align}
$$</span></p>

In other words, the <strong>ratio of amu/atom is the same as the ratio of g/mol.</strong> The definitions of amu and moles were intentionally chosen to make that happen (I'm surprised your teacher didn't explain this, actually). This allows us to easily relate masses at the atomic scale to masses at the macroscopic scale.  

To check this, look at the mass of an amu when converted to grams:  

<span class="math-container">$\pu{1amu}= \pu{1.6605E-24 g}$</span>  

Now divide one gram by one mole:  

<span class="math-container">$\pu{1g mol^-1}= \frac{\pu{1 g}}{\pu{6.022E23 atom}} = \pu{1.6605E-24 g atom^-1}$</span>  

It's the same number! Therefore:  

<span class="math-container">$\pu{1g mol^-1}= \pu{ 1 amu atom^-1}$</span>  

#### Answer 2 (score 1)
You need to be more careful with your units. The erroneous result is that you are equating a value in amu (a measure of mass, like grams) with a value in grams per mole (an invariant property of an element or compound, regardless of the amount you have).   

#### Answer 3 (score 0)
There are two things that routinely mystify science students:   

<ol>
<li><p>anything to do with amount of substance (now to be called "chemical amount"), the mole, and the Avogadro constant (or the Avogadro number), and </p></li>
<li><p>anything to do with the now-you-see-me-now-you-don't radian.  Let me address the first.</p></li>
</ol>

<p>If we have a general number of entities of kind X (e.g. X is the chemical symbol) represented by N(X), the corresponding chemical amount of X is denoted by n(X), which is an aggregate of N(X) entities.  In symbols:
n(X) = N(X) ent, where ent represents an amount of one entity (atom, molecule, ion, sub-atomic particle, . . .), i.e. the entity itself.</p>

The Avogadro number is the (dimensionless) ratio of one gram to one "atomic mass unit" (now called dalton, Da): g/Da.  One mole is an an Avogadro number of entities: mol = (g/Da) ent. Thus we have the important relationship: Da/ent = g/mol = kg/kmol, exactly.  In other words, at the atomic level, the appropriate unit for amount-specific mass ("molar" mass) is dalton per entity--and, because of the mole definition as an Avogadro number of entities, dalton per entity is exactly equal to the macroscopic units gram per mole or kilogram per kilomole.   

The critical problem is that IUPAC does not have a recognised symbol for one entity.  It is sometimes (incorrectly) thought of as the (dimensionless) number one.  In which case the "mole" is simply another name for the Avogadro number: "mol = g/Da".  In this case we have the (incorrect) relationship: "Da = g/mol".  Tables of "atomic weights" list the numerical values of atomic-scale masses in daltons--e.g. Ar(O) = ma(O)/Da = 16.  The corresponding amount-specific mass is M(O) = 16 Da/ent; and this is (exactly) equal to 16 g/mol or 16 kg/kmol.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Difference between thermodynamic and kinetic stability (score [109345](https://stackoverflow.com/q/2881) in 2013)

#### Question
What is the difference between thermodynamic and kinetic stability? I'd like a basic explanation, but not too simple. For example, methane does not burn until lit -- why?  

#### Answer accepted (score 43)
To understand the difference between kinetic and thermodynamic stability, you first have to understand <strong><a href="http://en.wikipedia.org/wiki/Potential_energy_surface" rel="nofollow noreferrer">potential energy surfaces</a></strong>, and how they are related to the state of a system.  

A potential energy surface is a representation of the <strong><a href="http://en.wikipedia.org/wiki/Potential_energy" rel="nofollow noreferrer">potential energy</a></strong> of a system as a function of one or more of the other dimensions of a system. Most commonly, the other dimensions are spatial. Potential energy surfaces for chemical systems are usually very complex and hard to draw and visualize. Fortunately, we can make life easier by starting with simple 2-d models, and then extend that understanding to the generalized N-d case.  

So, we will start with the easiest type of potential energy to understand: gravitational potential energy. This is easy for us because we live on Earth and are affected by it every day. We have developed an intuitive sense that things tend to move from higher places to lower places, if given the opportunity. For example, if I show you this picture:  

<img src="https://i.stack.imgur.com/C94wb.png" alt="enter image description here">  

You can guess that the rock is eventually going to roll downhill, and eventually come to rest at the bottom of the valley.  

However, you also intuitively know that it is not going to move unless something moves it. In other words, it needs some <strong><a href="http://en.wikipedia.org/wiki/Kinetic_energy" rel="nofollow noreferrer">kinetic energy</a></strong> to get going.  

I could make it even harder for the rock to get moving by changing the surface a little bit:  

<img src="https://i.stack.imgur.com/Xk3ys.png" alt="2d potential surface with local minimum">  

Now it is really obvious that the rock isn't going anywhere until it gains enough kinetic energy to overcome the little hill between the valley it is in, and the deeper valley to the right.  

We call the first valley a <strong>local minimum</strong> in the potential energy surface. In mathematical terms, this means that the first derivative of potential energy with respect to position is zero:   

<span class="math-container">$$\frac{\mathrm dE}{\mathrm dx} = 0$$</span>  

and the second derivative is positive:  

<span class="math-container">$$\frac{\mathrm d^2E}{\mathrm dx^2} \gt 0$$</span>  

In other words, the slope is zero and the shape is concave up (or convex).  

The deeper valley to the right is the <strong>global minimum</strong> (at least as far as we can tell). It has the same mathematical properties, but the <em>magnitude</em> of the energy is lower – the valley is deeper.  

If you put all of this together, (and can tolerate a little <a href="http://www.merriam-webster.com/dictionary/anthropomorphize" rel="nofollow noreferrer">anthropomorphization</a>) you could say that the rock <em>wants</em> to get to the global minimum, but whether or not it <em>can</em> get there is determined by the amount of kinetic energy it has.   

<strong>It needs at least enough kinetic energy to overcome all of the local maxima along the path between its current local minimum and the global minimum.</strong>  

If it doesn't have enough kinetic energy to move out of its current position, we say that it is <em>kinetically stable</em> or <em>kinetically trapped.</em> If it has reached the global minimum, we say it is <em>thermodynamically stable.</em>  

To apply this concept to chemical systems, we have to change the potential energy that we use to describe the system. Gravitational potential energy is too weak to play much of a role at the molecular level. For large systems of reacting molecules, we instead look at one of several <strong><a href="http://en.wikipedia.org/wiki/Thermodynamic_potential" rel="nofollow noreferrer">thermodynamic potential energies</a>.</strong> The one we choose depends on which <strong><a href="http://en.wikipedia.org/wiki/State_variable" rel="nofollow noreferrer">state variables</a></strong> are constant. For macroscopic chemical reactions, there is usually a constant number of particles, constant temperature, and either constant pressure or volume (NPT or NVT), and so we use the <a href="http://en.wikipedia.org/wiki/Gibbs_free_energy" rel="nofollow noreferrer">Gibbs Free Energy</a> (<span class="math-container">$G$</span> for NPT systems) or the <a href="http://en.wikipedia.org/wiki/Helmholtz_free_energy" rel="nofollow noreferrer">Helmholtz Free Energy</a> (<span class="math-container">$A$</span> for NVT systems).  

Each of these is a thermodynamic potential under the appropriate conditions, which means that it does the same thing that gravitational potential energy does: it allows us to predict where the system will go, if it gets the opportunity to do so.   

For kinetic energy, we don't have to change much - the main difference between the kinetic energy of a rock on a hill and the kinetic energy of a large collection of molecules is how we measure it. For single particles, we can measure it using the velocity, but for large groups of molecules, we have to measure it using temperature. In other words, increasing the temperature increases the kinetic energy of all molecules in a system.  

If we can describe the thermodynamic potential energy of a system in different states, we can figure out whether a transition between two states is thermodynamically favorable – we can calculate whether the potential energy would increase, decrease, or stay the same.  

If we look at all accessible states and decide that the one we are in has the lowest thermodynamic potential energy, then we are in a <strong>thermodynamically stable</strong> state.  

In your example using methane gas, we can look at Gibbs free energy for the reactants and products and decide that the products are more thermodynamically stable than the reactants, and therefore methane gas in the presence of oxygen at 1 atm and 298 K is thermodynamically <em>unstable</em>.  

However, you would have to wait a very long time for methane to react without some outside help. The reason is that the <strong><a href="http://en.wikipedia.org/wiki/Transition_state" rel="nofollow noreferrer">transition states</a></strong> along the lowest-energy reaction path have a much higher thermodynamic potential energy than the average kinetic energy of the reactants. The reactants are <em>kinetically trapped</em> - or stable just because they are stuck in a local minimum. The minimum amount of energy that you would need to provide in the form of heat (a lit match) to overcome that barrier is called the <strong><a href="http://en.wikipedia.org/wiki/Activation_energy" rel="nofollow noreferrer">activation energy</a></strong>.  

We can apply this to lots of other systems as well. One of the most famous and still extensively researched examples is <a href="http://en.wikipedia.org/wiki/Glass" rel="nofollow noreferrer">glasses</a>.  

Glasses are interesting because they are examples of kinetic stability in physical phases. Usually, phase changes are governed by thermodynamic stability. In glassy solids, the molecules would have a lower potential energy if they were arranged in a crystalline structure, but because they don't have the energy needed to get out of the local minimum, they are "stuck" with a liquid-like disordered structure, even though the phase is a solid.  

#### Answer 2 (score 20)
Kinetics deals with all things that impact the rate at which a reaction occurs. One implication of that is that reaction kinetics are partially a function of the stability of the intermediate species (and transition states) that the pathway of a chemical reaction necessarily has to pass through en route to the formation of the final product. If those intermediates are highly unstable (i.e., highly energetic) relative to the initial reactants, then the initial barrier of activation energy that must be surpassed to set the reaction in motion will be relatively high, and the reaction will tend to proceed slowly (if at all).  

Thermodynamic stability, on the other hand, is strictly a function of the change in free energy (&Delta;G), which is a state function, meaning that its value is determined exclusively by the difference between the initial state and the final state (or the free energy of the initial products and the final products). In other words, thermodynamic stability is totally independent of the pathway between reactants and products.  

While it's true that thermodynamic stability is the ultimate arbiter of the spontaneity of a reaction, if the kinetics render the reaction too slow then, in practice, the reaction may not actually occur at all (under some given set of conditions). The classic textbook example is the conversion of diamond to graphite, which is thermodynamically favorable because the free energy of graphite is lower, but doesn't occur under ordinary conditions because the kinetics of the reaction (in the form of the immense activation energy required) are extremely unfavorable.  

Imagine you have some set of reactants, A + B, and there are two different pathways through which A + B can react, both of which lead to final products that are lower in free energy than the reactants A + B. Pathway #1 has much higher activation energy than Pathway #2, but the final products at the end of Pathway #1 are lower in free energy (i.e., more thermodynamically stable) than those at the end of Pathway #2. This means that Pathway #1 is thermodynamically favored, but Pathway #2 is kinetically favored (that is, it poses a lower barrier in terms of activation energy and the reaction will proceed more rapidly via this pathway). The consequence of this is that the kinetic pathway, Pathway #2, will be the favored one, unless environmental conditions (temperature, pressure, concentrations of catalysts, etc.) are tuned in a such a way that the higher activation energy of Pathway #1 can be surpassed.  

In summary, thermodynamic stability (in terms of free energy difference between reactants and products) will determine whether a given reaction could be theoretically spontaneous, but kinetic factors will decide whether the reaction occurs in practice under the given environmental conditions, as well as which pathway for a given reaction takes primacy.   

#### Answer 3 (score 8)
There is often a "reaction barrier" that needs to be overcome.  Thus one must supply energy to get the reaction started, but once started it becomes self-sustaining.  

One can think of it this way:  one has to break bonds in a reaction before one can make bonds.  Energy is needed to break the first bonds.  Then making new bonds can supply enough energy to keep the reaction going.  

Note that I'm talking about thermodynamically allowed reactions.  If a reaction is not thermodynamically allowed, then even if some bonds are broken by adding energy, the reaction will not spontaneously continue.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: What are the differences between diesel and unleaded gasoline? (score [108425](https://stackoverflow.com/q/33490) in 2015)

#### Question
I am curious about the flammability of diesel fuel and its properties, as I don't deal with it on a regular basis (at all).   

In particular, I want to know how the fuel works when powering a diesel engine.  

Things I know about gasoline engines:  

<ul>
<li>Compresses gasoline and air</li>
<li>Ignites compressed gasoline and air with spark from spark plug</li>
<li>The ignition pushes the piston back turning the crank shaft</li>
</ul>

I have heard that diesel is less flammable than gasoline and that diesel engines don't require spark plugs. How does this work?  

#### Answer accepted (score 11)
<h5>Diesel engines vs. gasoline engines</h2>

Diesel engines don't rely on spark plugs, but they still work by igniting the fuel to generate a force that moves a cylinder in the engine.  The air/fuel mixture in a diesel engine is ignited by the compression of the same cylinder during the "compression" stroke.  That is, like most gasoline engines in cars, diesel engines are <a href="https://en.wikipedia.org/wiki/Four-stroke_engine" rel="noreferrer">four-stroke engines</a>.    

The compression stroke, in a gasoline engine or in a diesel engine, causes heating of the cylinder contents as the compression happens.  Diesel engines are designed to have a more severe compression of the cylinder contents during the compression stroke.  This results in much higher heating of the contents; in fact the temperature becomes so high that the ignition of the fuel and air becomes spontaneous.  

You may ask, where does the energy to power the compression stroke come from?  It comes from inertia in the engine as it is running.  Another way to say it is that the previous power stroke provides the energy for the compression stroke.  (The power stroke is when the exploding air fuel mixture pushes the cylinder out, doing useful work.)  There is so much work released in the power stroke that there is enough to move the car forward as well as provide inertia for the next compression stroke.  

Here are some more web links with helpful explanations:  

<ul>
<li><p><a href="https://en.wikipedia.org/wiki/Diesel_engine" rel="noreferrer">Wikipedia</a>: </p>

<blockquote>
  <p>The diesel engine (also known as a compression-ignition or 'CI' engine) is an internal combustion engine in which ignition of the fuel that has been injected into the combustion chamber is initiated by the high temperature which a gas achieves when greatly compressed (adiabatic compression). This contrasts with spark-ignition engines such as a petrol engine (gasoline engine) or gas engine (using a gaseous fuel as opposed to gasoline), which use a spark plug to ignite an air-fuel mixture.
  The diesel engine has the highest thermal efficiency of any standard internal or external combustion engine due to its very high compression ratio and inherent lean burn which enables heat dissipation by the excess air.</p>
</blockquote></li>
<li><p><a href="http://auto.howstuffworks.com/diesel1.htm" rel="noreferrer">How stuff works</a>:</p>

<blockquote>
  <p>In theory, diesel engines and gasoline engines are quite similar. They are both internal combus­tion engines designed to convert the chemical energy available in fuel into mechanical energy. This mechanical energy moves pistons up and down inside cylinders. The pistons are connected to a crankshaft, and the up-and-down motion of the pistons, known as linear motion, creates the rotary motion needed to turn the wheels of a car forward.
  Both diesel engines and gasoline engines covert fuel into energy through a series of small explosions or combustions. The major difference between diesel and gasoline is the way these explosions happen. In a gasoline engine, fuel is mixed with air, compressed by pistons and ignited by sparks from spark plugs. In a diesel engine, however, the air is compressed first, and then the fuel is injected. Because air heats up when it's compressed, the fuel ignites.</p>
</blockquote></li>
</ul>

Be sure to watch the animation at How Stuff Works.  It's quite helpful!  

<h5>Diesel fuel vs. gasoline</h2>

<s>In diesel engines, premature combustion can be a problem.  This happens when the fuel ignites "too early" in the compression phase, before maximum temperature and thus maximum efficiency can be obtained.  This means that by design, diesel fuel is a bit harder to ignite than gasoline.  It's made of slightly less volatile hydrocarbons.</s>  

As noted by @steveverrill in the comments, the above paragraph was incorrect.  A better explanation (straight from his comment) is  

<blockquote>
  Diesel is harder to ignite at ambient temp due to its lower volatility / higher flash point (approx 52 &deg;C vs -43 &deg;C). This means it's difficult to form an explosive mixture which could be ignited by a spark (which is a local area at much higher than ambient temp.) But inside an engine both diesel &amp; gasoline are fully evaporated. Under these conditions diesel is easier to ignite due to its lower autoignition temperature (approx 265 &deg;C vs 280 &deg;C). Autoignition temperature is tuned by additives to help ensure diesel can be ignited just by compression, whereas gasoline cannot ignite without a spark.  
</blockquote>

<ul>
<li><p><a href="https://en.wikipedia.org/wiki/Diesel_fuel" rel="noreferrer">Wikipedia again</a></p>

<blockquote>
  Petroleum-derived diesel is composed of about 75% saturated hydrocarbons (primarily paraffins including $n$, $iso$, and cycloparaffins), and 25% aromatic hydrocarbons (including naphthalenes and alkylbenzenes). The average chemical formula for common diesel fuel is $\ce{C12H23}$, ranging approximately from $\ce{C10H20}$ to $\ce{C15H28}$.  
</blockquote></li>
<li><p><a href="https://en.wikipedia.org/wiki/Gasoline" rel="noreferrer">Wikipedia on gasoline</a></p>

<blockquote>
  The bulk of a typical gasoline consists of hydrocarbons with between 4 and 12 carbon atoms per molecule (commonly referred to as C4-C12). It is a mixture of paraffins (alkanes), cycloalkanes (naphthenes), and olefins (alkenes).  
</blockquote></li>
</ul>

Thus, diesel fuel contains mostly hydrocarbon molecules that have on average 12 or so carbon atoms, while gasoline contains hydrocarbons that contain on average 8 or so carbon atoms.  The heavier, bigger molecules in diesel fuel means it evaporates more slowly at ambient conditions, requires more heating (i.e. more compression) before it spontaneously ignites.  

#### Answer 2 (score 6)
<strong>Diesel fuel</strong>  

The difference between gasoline and diesel fuel lies in <a href="http://auto.howstuffworks.com/fuel-efficiency/alternative-fuels/question1051.htm" rel="nofollow noreferrer">the length of carbon chains</a>.  

Gasoline and diesel fuel are examples of <a href="http://en.wikipedia.org/wiki/Hydrocarbon" rel="nofollow noreferrer">hydrocarbons</a>, molecules made up purely of hydrogen ($\ce{H}$) and carbon ($\ce{C}$) atoms. Simple examples include $\ce{C_3H_8}$ (propane) and $\ce{C_8H_18}$ (octane).  

Gasoline contains compounds with carbon chains containing a certain amount of carbon atoms; their formulas are typically in the range of $\ce{C_7H_16}$ to $\ce{C_11H_24}$. Diesel fuel, on the other hand, has carbon chains somewhere in the area of $\ce{C_13}$ to $\ce{C_18}$.  

However, in order for some set of atoms to qualify as a chain, it must have a certain structure. You could not somehow make random hoops of carbon and call them carbon chains.  

<strong>Diesel engines</strong>  

I hope you read <a href="http://en.wikipedia.org/wiki/Diesel_engine" rel="nofollow noreferrer">the Wikipedia article</a> on diesel engines. It explains that compression is used to ignite the fuel, rather than a traditional spark (from a spark plug).  

There are a few different reasons why diesel fuel is better than gasoline in diesel engines. One major one (<a href="https://engineering.stackexchange.com/questions/1903/what-happens-when-you-put-the-wrong-type-of-fuel-in-an-internal-combustion-engin/1948#1948">referring to Engineering Stack Exchange</a>) is that diesel has a lower autoignition temperature - which is perfect, because diesel engines don't have spark plugs like those used in gasoline engines.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Reaction of silver nitrate and hydrochloric acid (score [108356](https://stackoverflow.com/q/15394) in 2018)

#### Question
Consider the reaction of $\ce{AgNO3}$ and $\ce{HCl}$. I read that silver chloride would be formed. But $\ce{H} &gt; \ce{Ag}$ in reactivity, then how could $\ce{Ag}$ displace $\ce{H}$ from $\ce{HCl}$ ?  

If there was a reaction, $\ce{AgCl}$ and $\ce{HNO3}$ were to form. But then these would react again to give us the original compounds back. The actual question was to write down the reaction between $\ce{AgNO3}$ and $\ce{HCl}$. I (wrongly) realized that the compounds wouldn't react because of the reasons stated.  

#### Answer accepted (score 12)
One of the most difficult parts of chemistry is learning to recognize a type of reaction based solely on its reactants. This has to be done before you can apply a reaction pattern to the problem, and so it is critical to get this step right in the beginning.  

In this case, you are looking at the reaction:  

<p>$$
\ce{AgNO3 + HCl -&gt;  AgCl + HNO3}
$$</p>

You already know the products, but are questioning how these products can be formed since the activity of H is greater than Ag, implying that Ag is easier to oxidize than H. This is true - but take a look at the oxidation numbers of each species in this reaction:  

$\ce{Ag: +1 -&gt; +1}$  

$\ce{NO3: -1 -&gt; -1}$  

$\ce{H: +1 -&gt; +1}$  

$\ce{Cl: -1 -&gt; -1}$  

Since there is no overall transfer of electrons, this can't be a redox reaction, and that means activities won't matter here.  

That means there must be another driving force for this reaction - another reaction pattern that fits better.  

I don't want to give you the answer directly, but I will give you some advice that should help:   

Write the full equation - <em>including the phases.</em>  

<p>$$
\ce{AgNO3(aq) + HCl(aq) -&gt;  AgCl(s) + HNO3(aq)}
$$</p>

See if you can find another reaction pattern that fits this equation better. Later, I'll update this answer to show how you can identify the correct pattern for aqueous reactions using only the reactants.  

<strong>Update</strong>  

As I mentioned, one of the hardest parts of chemistry is learning to identify reaction patterns based only on the reactants. This is a <a href="http://en.wikipedia.org/wiki/Salt_metathesis_reaction">double-displacement</a> (or metathesis, or precipitation) reaction. It is easy to see now, given that the reactants are aqueous and at least one of the products is solid (the precipitate). Formation of the solid is the driving force for this reaction - the quick explanation is that the forces attracting silver and chloride ions together are stronger than the solvation forces between those ions and water, as well as the forces holding them to sodium and nitrate ions.  

This is good, but how do we predict that this is a precipitation reaction ahead of time?  

The key is to have a good understanding of the three common types of salt/acid/base reactions that occur in aqueous solution, and to learn to recognize clues in the reactants.  

Briefly, the three types that are most commonly seen are:  

<ol>
<li>Precipitation</li>
<li>Acid/base (Arrhenius definition)</li>
<li>Redox (single displacement)</li>
</ol>

You can recognize each of these by the reactants if you know what to look for.  

<strong>Precipitation</strong> - Two soluble salts (ionic compounds), or a salt with an acid or base.  

<strong>Acid/base</strong> - An Arrhenius acid <em>and</em> base (compound containing hydroxide)  

<strong>Redox</strong> - a salt or acid and an elemental metal  

There are many other types of reactions that occur in aqueous solution, and many variations of the acid/base and redox category, but these three cover the cases most commonly seen in a classroom.  

Once you have identified the likely pattern that the reaction will follow, the next step is to predict the products using that pattern to see if they make sense. If they do, then you have likely chosen correctly.  

You can use this algorithm for more advanced chemistry as well - in organic chemistry, for example, one of the major goals is to learn to predict reactions based on functional groups. Once you can identify functional groups and have memorized reaction patterns for them, it becomes possible to predict a huge range of reactions.   

#### Answer 2 (score 3)
<p>One thing of paramount importance in Chemistry is to visualize concepts.
According to the solubility table, nitrates are always soluble, so the strong ionic bond between silver ions and nitrate ions are broken by water molecules because of ion-dipole attraction. By definition, acids ionize in water to give mobile ions, so hydrogen chloride in aqueous solution gives out hydrogen ions (and form hydronium ions) and chloride ions.</p>

Hence, you can see that there are five types of particles in the solution now: $\ce{H2O}$ molecules, $\ce{Ag+}$ ions, $\ce{NO3-}$ ions, $\ce{H+}$ ions, and $\ce{Cl-}$ ions. (Slight ionization of water is neglected in this case.) They freely bump into each other as they are mobile. However, this freely moving condition is inhibited by the interaction between $\ce{Ag+}$ ions and $\ce{Cl-}$ ions. According to the solubility table, $\ce{AgCl}$ is insoluble in water. When $\ce{Ag+}$ ions and $\ce{Cl-}$ ions bump into each other, they strongly attract each other, in which the strong ionic force cannot be separated by the ion-dipole force between them and $\ce{H2O}$ molecules. As a result, $\ce{AgCl}$ evolves as a white solid.  

Although some may speak this of an example of double displacement reaction, this has no direct relationship with reactivity of hydrogen and silver because there is no transfer of electrons (which occurs in redox reactions).  

#### Answer 3 (score 2)
<blockquote>
  But H>Ag in reactivity, then how could Ag displace H from HCl ?  
</blockquote>

What do you mean that hydrogen is more reactive than silver? In what context?   

<blockquote>
  <p>If there was a reaction, AgCl and HNO3 were to form. But then these
  would react again to give us the original compounds back.</p>
</blockquote>

How do you know? Why would these form? Why not silver nitrate? Why not hydrochloric acid?   

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: Is melting/boiling point of ionically bonded substance higher than of covalently bound? (score [107612](https://stackoverflow.com/q/5394) in 2017)

#### Question
Is the melting and boiling point of ionic bond usually higher than covalent bond?   

I know that compounds with ionic bonds are usually solid at room temperature, so I want other answers than this. (and this question can also be about why compounds with ionic bonds are usually solid in room temperature.)  

#### Answer accepted (score 12)
The answer relates to the strength of the interactions between the component units that make up a crystal or a solid.  

The reason why anything is a solid at a given temperature is, crudely, that the interactions between the units that make up the solid (atoms, ions or molecules) are stronger than the amount of thermal energy available at that temperature.   

Diamond, for example, is a solid because each unit carbon is bonded to its neighbours by a strong carbon-carbon bond that takes a great deal of energy to break. Non-polar molecular compounds, like candle wax (in reality a mixture but imagine a pure long chain hydrocarbon to keep it simple) are held together by the intermolecular forces between the molecules (often called dispersion or Van der Waals forces). These are much weaker than chemical bonds and depend on the surface area of the molecules. So small non-polar or not-very polar molecules tend to have low melting points. Hexane is a volatile liquid. The shape and symmetry of the molecule matters a bit to these interactions so toluene is a liquid down to -95°C but benzene, which is very similar to toluene but far more symmetric and slightly flatter only melts at about 6°C as the molecules pack together better encouraging stronger interactions. Polar molecules have stronger interactions because the molecular dipoles interact and this produces stronger forces than the non-polar dispersion forces. So phenol (very similar in size to toluene but far more polar) melts at about 41°C.  

Simple ionic solid are made from charged ions. Table salt crystals consist of Na<sup>+</sup> and Cl<sup>-</sup> ions. The key interaction between these is electrostatic and this is a strong force that takes a lot of energy to break. The melting point is about 800°C. Permanent electrostatic interactions are strong especially if the components can get close (remember, it's an inverse square law). This explains why not every ionic compound is a solid. There are ionic compounds that are liquid at room temperature. These tend to consist of molecular ions that are large and sometime irregular so forcing structures where the ionic force has to act over much larger distances and, therefore, be much weaker. An example is [BMIM]PF<sub>6</sub> which has a melting point well below room temperature:  

<img src="https://i.stack.imgur.com/CPrYX.png" alt="BMIMPF6">  

These ionic liquids are an interesting area of research in chemistry as they sometimes enable much less wasteful chemical reactions in industry (see <a href="http://www.wikiwand.com/en/Ionic_liquid" rel="noreferrer">wikipedia</a>).  

#### Answer 2 (score 3)
One set of comparisons is:  

Why it take so much energy to turn sodium chloride molten, whereas candle wax melts virtually upon touch?  

"Ionic compounds" tend to form crystals.  You may have seen pictures of a crystal lattice of sodium chloride:  cubic packing with a sodium being surrounded by many chlorides.  It takes a lot of energy to break up all of those bonds.  

In the case of wax (also a solid at room temperature), there are not these strong, "ionic" interactions between molecules. Things are more "layered" and disordered rather than crystalline. (Though there is definitely inter-molecular bonding Otherwise it would never be solid!!!)  

#### Answer 3 (score 1)
It looks to me like sodium chloride is sort of a big frat party. All the boys are attracted to all the girls (you choose which element is which), so they're all holding hands with each other. To break NaCl into smaller bits, you have to break those handholds (melting, requiring lots of energy) or give them something else to hold (such as one end of a polarized water molecule).  By contrast, sugar molecules are a bunch of close knit family groups. The members of each family are holding on to each other, but not attracted to any other family. To melt sugar, by getting the families to move around relative to each other, does not require much energy. When sugar is dissolved in water, the water molecules easily fit in among the sugar molecules, but again, elements of a given family are not attracted to outsiders.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Naming convention for graphs? (score [106766](https://stackoverflow.com/q/35793) in 2017)

#### Question
I always have trouble naming my graphs in class. They never seem too scientific or professional.  

For example, we are reviewing density now, and had to graph the mass (Y) of different volumes (X) of water. So, very simply, my title was "Mass of Different Volumes of Water". Is this appropriate?  

Are there any naming conventions, such as "X vs. Y", or "Effects of X on Y" or "Relationship of X and Y", etc.? Sorry if this is a bit stylistic and opinion based, but I would like some feedback. Thanks.  

<em>Note: I'm in the tenth grade.</em>  

<em>Note 2: I'm also not sure what site to post this under (there's no "science" site) nor what tags to post this with. Feel free to improve it.</em>  

#### Answer accepted (score 4)
<p>Label your graph with a title of what it shows. 
For example, if you have plotted a graph of the temperature recorded each day at one location for a year, you could title it: </p>

<strong>Temperature at Observation Site A during 2014-15</strong>  

<p>Essentially, you want to summarise the X and Y variables and what your sample is in the title. 
In this case, X = date, Y = temperature, and the sample is Observation Site A.</p>

If you had measured the mass and volume of water at 25°C for numerous samples, you could title it:  

<strong>Mass vs Volume of Water at 25°C</strong>  

In this case, X = mass, Y = volume, and your sample is water at a fixed temperature.  

I hope this makes some sense?   

<hr>

As for naming conventions, they tend to be dictated by whoever is going to assess it. If you write a paper to submit to a journal, they have certain styles. A different journal, different styles. Whatever you do decide on, be consistent.   

#### Answer 2 (score 4)
<p>Label your graph with a title of what it shows. 
For example, if you have plotted a graph of the temperature recorded each day at one location for a year, you could title it: </p>

<strong>Temperature at Observation Site A during 2014-15</strong>  

<p>Essentially, you want to summarise the X and Y variables and what your sample is in the title. 
In this case, X = date, Y = temperature, and the sample is Observation Site A.</p>

If you had measured the mass and volume of water at 25°C for numerous samples, you could title it:  

<strong>Mass vs Volume of Water at 25°C</strong>  

In this case, X = mass, Y = volume, and your sample is water at a fixed temperature.  

I hope this makes some sense?   

<hr>

As for naming conventions, they tend to be dictated by whoever is going to assess it. If you write a paper to submit to a journal, they have certain styles. A different journal, different styles. Whatever you do decide on, be consistent.   

#### Answer 3 (score 2)
Another way to think of it is "Y" as a function of "X".  For example, "Distance as a function of time" or "Distance vs. Time".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Reviving Li-ion battery in freezer? (score [105446](https://stackoverflow.com/q/5471) in 2017)

#### Question
I <a href="http://www.ehow.com/how_5982537_revive-lithium-ion-batteries.html" rel="nofollow noreferrer">have read</a> that it is possible to revive a dead Li-ion battery by putting it in the freezer for <em>three to seven days</em>, then letting it get back to room temperature.  

<em>Can this process work, and if so, how does it work?</em>  

Notes:  

<ul>
<li><p>Somehow the opposite, i.e. heating (cooking) the battery, is more intuitive to me. After all, in the dead battery, there is "something stuck" (crystallized?), and heat could break that. But I don't know if it's a good idea to <em>try that at home</em>. ;-)</p></li>
<li><p>I also found that hitting a Li-ion battery, against a table, for example, has some effect. At the moment, I have a battery in an IBM ThinkPad T41 laptop that, although still working, is on it's way to death. When it runs flat and I connect the laptop to mains, then the battery is not detected properly (battery status LED continues blinking orange). So, I take it out, hit it, put it back in, and the problem is solved (LED constantly orange). Also, I have the impression that hitting gives some extra charge. It could be all just a coincidence, of course.</p></li>
<li><p>I am asking in part for a friend whose laptop battery has been dead, I believe, already for some weeks or months. He said that the battery is not that old, but he has let it run flat in cold weather (up in the mountains). Anyhow, whether the process works for this particular battery should not influence my decision on accepting an answer. I am primarily interested in understanding a little bit more about battery chemistry, just to broaden my general knowledge.</p></li>
</ul>

#### Answer accepted (score 2)
There are a number of rumors on the internet about different ways to treat your battery. Some of these involve putting batteries in the refrigerator or freezer for varying lengths of time to improve performance in some way. <a href="http://www.snopes.com/oldwives/battery.asp" rel="nofollow">Snopes</a> has concluded that there is no basis for this. However, batteries and battery aging mechanisms are very complex and so I think it's difficult to completely rule out the possibility that under some situations there could be some beneficial effect from freezing.  

Nevertheless, I would recommend that you avoid using your battery in any way that it was not designed for. The reason is that internal damage to the battery (such as from extreme temperatures, moisture, or mechanical stress) could create a safety hazard. Even if cooking, freezing, or bashing does have some positive effect, it is probably not worth putting yourself at risk. The best thing to do is to recycle your old battery and buy a replacement.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Use of aqueous KOH and alcoholic KOH in dehydrohalogenation reactions (score [104914](https://stackoverflow.com/q/43002) in 2018)

#### Question
What is the difference between aqueous KOH and alcoholic KOH? How do they react differently in dehydrohalogenation?  

#### Answer accepted (score 9)
Aqueous $\ce{KOH}$ is alkaline in nature i.e. it dissociates to produce a hydroxide ion. These hydroxide ions act as a strong nucleophile and replace the halogen atom in an alkyl halide.  

$$\ce{RCl + KOH (aq) -&gt; ROH + KCl}$$  

This results in the formation of alcohol molecules and the reaction is known as nucleophilic substitution reaction.  

Alcoholic, $\ce{KOH}$, specially in ethanol, produces $\ce{C2H5O-}$ ions. The $\ce{C2H5O-}$ ion is a stronger base than the $\ce{OH-}$ ion. Thus,the former abstracts the ß-hydrogen of an alkyl halide to produce alkenes. This reaction is known as elimination reaction.  

$$\ce{CH3CH2Br + KOH (alc) -&gt; H2C=CH2 + KBr + H2O}$$  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: What would be the effect of the addition of an inert gas to a reaction at equilibrium? (score [102551](https://stackoverflow.com/q/18567) in 2018)

#### Question
<p>Why does a dissociation reaction shift to the right with the addition of an inert gas?
(I am still new to the topic of equilibrium, so please explain in simple words.)</p>

#### Answer accepted (score 38)
<p>Dissociation obviously increases the number of moles.<br>
The addition of an inert gas can affect the equilbrium, but only if the volume is allowed to change.</p>

There are two cases on which equilibrium depends. These are:  

<ul>
<li><strong>Addition of an inert gas at constant volume</strong>:<br>
When an inert gas is added to the system in equilibrium at constant volume, the total pressure will increase. But the concentrations of the products and reactants (i.e. ratio of their moles to the volume of the container) will not change.</li>
</ul>

Hence, when an inert gas is added to the system in equilibrium at constant volume there will be no effect on the equilibrium.  

<ul>
<li><strong>Addition of an inert gas at constant pressure</strong>:<br>
When an inert gas is added to the system in equilibrium at constant pressure, then the total volume will increase. Hence, the number of moles per unit volume of various reactants and products will decrease. Hence, the equilibrium will shift towards the direction in which there is increase in number of moles of gases.</li>
</ul>

<p>Consider the following reaction in equilibrium:
$$\ce{2 NH_3(g) ⇌ N_2 (g) + 3 H2 (g)}$$
The addition of an inert gas at constant pressure to the above reaction will shift the equilibrium towards the forward direction because the number of moles of products is more than the number of moles of the reactants.</p>

Please read about the <a href="http://en.wikipedia.org/wiki/Le_Chatelier&#39;s_principle#Effect_of_adding_an_inert_gas">Effect of adding an Inert Gas</a>  

#### Answer 2 (score 34)
Nick's answer is good. Let's add a little maths.  

Let's take an example dissociation reaction $\ce{A&lt;=&gt;B + C}$ for which $K_p=1$. Since  

$$K_p = \frac{P_B P_C}{P_A}$$  

one equilibrium scenario is $P_A =P_B = P_C = 1 \text{ atm}$. The total pressure $P_T = 3 \text{ atm}$.  

If we add an inert gas <strong>at constant pressure</strong>, the total pressure cannot change. Thus, the partial pressures of the three components $\ce{A}$, $\ce{B}$, and $\ce{C}$ must decrease. If we add some inert gas $\ce{D}$ so that $P_A=P_B=P_C=P_D=\frac{3}{4} \text{ atm}$, the total pressure is still $P_T=3\text{ atm}$. The reaction quotient $Q_p$ is now:  

$$Q_p = \frac{P_B P_C}{P_A}=\frac{(\frac{3}{4}\text{ atm})(\frac{3}{4}\text{ atm})}{\frac{3}{4}\text{ atm}}=\frac{3}{4}\text{ atm}&lt;K_p$$  

Since $Q_p&lt;K_p$, the equilibrium will shift toward products.   

At <strong>constant volume</strong>, the partial pressures of the three components $\ce{A}$, $\ce{B}$, and $\ce{C}$ can remain constant and equilibrium will be unchanged. Adding inert gas $\ce{D}$ will increase the pressure of the system.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Are all PP(Polypropylene), i.e. resin code 5 plastics, safe for microwave and steaming? (score [101530](https://stackoverflow.com/q/8202) in 2019)

#### Question
If a plastic is marked PP as in Polypropylene (i.e. <a href="http://en.wikipedia.org/wiki/Resin_identification_code" rel="nofollow noreferrer">resin code</a> 5), is it automatically safe for steaming and microwaving, such that it wouldn't leach chemicals into the food(besides not melting)?  

#### Answer accepted (score 7)
<strong>No.</strong>  

Just because the polymer is of one or the other kind does not let you say what industrial process actually synthesized it. Subsequently it is impossible to know what trace chemicals are left in the polymer packaging.  

<strong>If if isn't labelled as microwave-safe, it isn't!</strong>  

They test the package for it's microwave compatibility, not one type of polymer each! It <a href="http://www.scn.org/~bk269/plastics.html" rel="noreferrer">seems</a> that resin code 5 polymers are often used for microwave-proof packaging, but again: You don't know how it was made, you have no idea what's in there, don't microwave it (together with food or something else that you then ingest).  

#### Answer 2 (score 3)
Consumer polyolefin plastics contain trace mold releases that adversely affect biological studies.  For human food use, one presumes Generally Recognized as Safe as long as the contents stay water wet, below 100 C.  Burning on residues (cheese) allows the temperature to skyrocket.  

Polyoelfin containers are penetrated by hot lipid and especially hydrocarbons (red lycopene in tomato products).  Do NOT use dishwasher "bleaches" to remove the internal stain.  The active ingredient is dispersed dibenzoyl peroxide (Bondo cure).  Sure, it diffuses in and free-radical breaks up the molecule's conjugation, rendering then colorless.  It also free-radical scissions all plastics in the dishwasher.  Things go brittle and fail.  

#### Answer 3 (score 2)
Basically any plastic used in a microwave is <a href="http://www.skoozeme.com/science_and_tech/plastics.html" rel="nofollow noreferrer">problematic</a>.   I have seen several containers at work marked "microwave safe" that clearly reacted into the food when used in the microwave.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Are metallic/ionic bonds weaker than covalent bonds? (score [100796](https://stackoverflow.com/q/11048) in 2015)

#### Question
In mineralogy class, I was taught that metallic and ionic bonds are weaker than covalent bonds and that's why quartz and diamond have such a high hardness value. However, in organic chemistry class, I learned that covalent bonds are weaker than metallic and ionic bonds, thus organic substances have a much lower melting point than that of metals and ionic compounds.  

What am I getting wrong? Are ionic and metallic bonds weaker than covalent bonds or not?  

#### Answer accepted (score 18)
Quartz and diamond are stronger substances because their molecules form network covalent structures. These structures form a lattice-like structure, much the same as ionic compounds.  

This molecular network is also the reason that diamond and quartz form a crystalline structures, just like you'd see in ionic substances such as NaCl. Some other structures you might want to look into are Graphite and Graphene, which are both allotropes of carbon (allotropes are, simply put, different molecular arrangements of an element).   

The network structure combines to make the substance stronger than normal covalent bonded substances.   

So to answer your question, substances with standard covalent bonds seem to be weaker than those with ionic bonds because the ionic bonds tend to form a lattice structure, that makes them much stronger. You can see this in the fact that the boiling points of ionic salts are much higher than that of a covalent substance like water. However, when covalent bonds form network covalent structures, atoms combine to form a singular macromolecule that is much stronger than singular covalent bonds.   

#### Answer 2 (score 7)
What you learned in your mineralogy class was correct; bond strength decrease in the following order covalent > ionic > metallic.  The reasoning for this is as follows.  In covalent bonds such as those in methane and oxygen, the valence electrons are shared between the atoms involved in the bond and they (the electrons) spend most of their time in the region between the nuclei involved in the bond; this makes for a strong bond.  In ionic materials such as sodium chloride, the electrons are donated from one (the electropositive) atom to the other (the electronegative) atom in order for the atoms to achieve a filled shell structure.  The ionic atoms are attracted to one another through electrostatic attraction and the crystal lattices that are formed.  The bonds formed through electrostatic attraction are not as strong as those formed from covalent sharing of electrons.  Finally, in metals the outermost electrons are donated or "pooled" in the band structure that exists in metals.  The electrons are free to travel great distances (hence the conductivity of metals) and serve as a glue to hold all of the positively charged metal nuclei together.  So in the case of metals, there are no significant metal-metal bonds and these bonds are therefor the weakest.    

#### Answer 3 (score 4)
It depends, because for covalent there are two types of bonds, network or molecular, or as I have also heard it be called, polar covalent and non polar covalent. But, network covalent consists of a vast network among the atoms and each one are connected, and they mostly made up of one element.   

Take a diamond for example, it is only made up of carbon, but since the atoms are connected to each other and have not bonding between molecules, like something such as salt, which is an ionic bond, it is harder to break. However, if it were a molecular covalent bond, then the whole story is different, because they tend to be very weak bonds and easily broken like sugar or otherwise known as glucose, sucrose doesn't matter, it is still a covalent molecular bond because they have molecules while as a diamond is technically one big molecule.   

But, since sugar has multiple the bond between each other molecule is weaker than the bonds between the elements themselves, then it is really weak.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: What is the inert pair effect? (score [99539](https://stackoverflow.com/q/8717) in 2018)

#### Question
I was reading about the p-block elements and found that the inert pair effect is mentioned everywhere in this topic. However, the book does not explain it very well. So, what is the inert pair effect? Please give a full explanation (and an example would be great!).  

#### Answer accepted (score 33)
The inert pair effect describes the preference of late p-block elements (elements of the 3rd to 6th main group, starting from the 4th period but getting really important for elements from the 6th period onward) to form ions whose oxidation state is 2 less than the group valency.  

So much for the phenomenological part. But what's the reason for this preference? The 1s electrons of heavier elements have such high momenta that they move at speeds close to the speed of light which means relativistic corrections become important. This leads to an increase of the electron mass. Since it's known from the quantum mechanical calculations of the hydrogen atom that the electron mass is inversely proportional to the orbital radius, this results in a contraction of the 1s orbital. Now, this contraction of the 1s orbital leads to a decreased degree of shielding for the outer s electrons (the reason for this is a decreased "core repulsion" whose origin is explained in <a href="https://chemistry.stackexchange.com/a/376/189">this answer</a> of mine, see the part titled "Why do states with the same $n$ but lower $\ell$ values have lower energy eigenvalues?") which in turn leads to a cascade of contractions of those outer s orbitals. The result of this relativistic contraction of the s orbitals is that the valence s electrons behave less like valence electrons and more like core electrons, i.e. they are less likely to take part in chemical reactions and they are harder to remove via ionization, because the s orbitals' decreased size lessens the orbital overlap with potential reaction partners' orbitals and leads to a lower energy. So, while lighter p-block elements (like $\ce{Al}$) usually "give away" their s  and p electrons when they form chemical compounds, heavier p-block elements (like $\ce{Tl}$) tend to "give away" their p electrons but keep their s electrons. That's the reason why for example $\ce{Al(III)}$ is preferred over $\ce{Al(I)}$ but $\ce{Tl(I)}$ is preferred over $\ce{Tl(III)}$.  

#### Answer 2 (score 7)
Inert pair effect is mostly shown by the 15-17th group elements.  

That is, the oxidation state reduces by 2 for elements below ($\ce{As}$, $\ce{Sb}$), which is more stable than the other oxidation states.  

The reason for this is the inertness of the inner $s$ electrons due to poor shielding.  

#### Answer 3 (score 4)
As we move down the group, the intervening d and f electrons shield the ns2 electrons poorly and hence the ns2 electrons are pushed inside towards the nucleus This results in the reluctance of ns electrons to participate in bond formation and this phenomenon is called Inert pair effect.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: During phase change in matter, why doesn't the temperature change? (score [98133](https://stackoverflow.com/q/15852) in 2018)

#### Question
I was working on something in school and came across the question:  

<blockquote>
  Why does the temperature not change much during a phase change?  
</blockquote>

I'm really not sure why this happens in matter and I couldn't find an answer in my school resources. Does anyone here know?  

#### Answer accepted (score 14)
From <a href="http://zonalandeducation.com/mstm/physics/mechanics/energy/heatAndTemperature/changesOfPhase/changeOfState.html">Changes of Phase (or State)</a>:  

...  

<h5>So, how could there be a change in heat during a state change without a change in temperature?</h2>

"During a change in state the heat energy is used to change the bonding between the molecules. In the case of melting, added energy is used to break the bonds between the molecules. In the case of freezing, energy is subtracted as the molecules bond to one another. These energy exchanges are not changes in kinetic energy. They are changes in bonding energy between the molecules.  

"If heat is coming into a substance during a phase change, then this energy is used to break the bonds between the molecules of the substance. The example we will use here is ice melting into water. Immediately after the molecular bonds in the ice are broken the molecules are moving (vibrating) at the same average speed as before, so their average kinetic energy remains the same, and, thus, their Kelvin temperature remains the same."  

#### Answer 2 (score 8)
For a first-order phase transition, you need to add the enthalpy of the phase transition.  As an example, starting with ice below the melting point, you pump heat in, and raise the temperature.  When you hit the melting temperature, the heat you put in goes towards the enthalpy of melting, and starts converting ice (sold) to water (liquid).  Additional heat continues to melt more of the ice.  Once all of the ice is converted (still at the melt temperature), than more heat starts increasing the temperature of the water.  

A second-order phase transition does not have an enthalpy associated with it.  

#### Answer 3 (score 2)
It is because the heat energy is used to overcome the inter-molecular force of attraction but when this inter-molecular force is broken it changes it state and the temperature starts increasing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How do you explain pKa to non-professional? (score [98000](https://stackoverflow.com/q/17326) in 2015)

#### Question
Let's say we have substance $\ce{A}$, which is mixed with substance $\ce{B}$ to improve shelf-life because $\mathrm{p}K_\mathrm{a}$ of the substance $\ce{A}$ is $7.9$ and in mix the $\mathrm{pH}$ is $5.2$.  

Does this mean that in the solution with $\mathrm{pH}$ near $8$ the substance $\ce{A}$ <strong>has multiple molecules in neutral state and not dissociate</strong>, thus it forms precipitates?  

<p>Does $\mathrm{p}K_\mathrm{a}$ mean that most of the molecules of the substance $\ce{A}$ <strong>are in nondissociated state</strong>?
 Does lowering $\mathrm{pH}$ in this case causes substance $\ce{A}$ <strong>to dissociate</strong>?</p>

Are bold parts right? Please explain in plain English without the use of external links.  

#### Answer accepted (score 9)
pKa and pH are related concepts but often confused. pKa is a property of a compound that tells us how acidic it is. The lower the pKa, the stronger the acid. pH is a property of a particular solution that depends on the concentrations and identities of the components.  

For this discussion, I'm going to use the terms protonated and deprotonated to mean that a compound is associated or dissociated with a proton.   

Based on the relationship between the pKa of a compound and the pH of a solution, we can predict whether a compound will be protonated or deprotonated. If the pH is lower than the pKa, then the compound will be protonated. If the pH is higher than the pKa, then the compound will be deprotonated.  

A further consideration is the charge on the compound. Acids are neutral when protonated and negatively charged (ionized) when deprotonated. Bases are neutral when deprotonated and positively charged (ionized) when protonated.  

Given the information you provided, if compound A (with pKa 7.9) is in a solution of pH 5.2, compound A will be in the protonated state.  

Without knowing anything about the identities of A and B, the following is speculation. Most likely compound A is a base and compound B is an acid. The protonated version of A (its "conjugate acid") is more stable for long term storage than A itself.  

Another possibility is that compound A is an acid and B is a stronger acid. If the deprotonated version of A is unstable, then compound B is added to ensure that if the mixture came in contact with a base, something more acidic than A would be present to react with the base.  

<p>EDIT BASED ON NEW INFORMATION:
As Mateus B said, lidocaine will be protonated by HCl at the amine nitrogen. This is likely done for two reasons. First, as its hydrochloride, it will be more water soluble. In solution, the compound will dissociate into protonated lidocaine cation and chloride anion. Second, as the nitrogen is protonated, it is less reactive to the environment. Over time, amines can react with oxygen to form the corresponding N-oxide and/or can absorb carbon dioxide.</p>

#### Answer 2 (score 2)
<blockquote>
  <p>Let's say we have substance A which was mixed with substance B to improve shelf-life because pKa of the substance A is 7.9 and in mix the pH is 5.2.
  Does this mean that in the solution with pH near 8 the substance A has multiple molecules in neutral state and not dissociate, thus it forms precipitates?</p>
</blockquote>

<strong>At all pH, the substance A will exist as a mixture of HA and A-. HA may or may not be soluble, so it may or may not precipitate.</strong>  

<blockquote>
  Does pKa mean that most of the molecules of the substance A are in nondissociated state?  
</blockquote>

<strong>The higher the pKa, the lower the Ka, the lower the ratio of A- to HA, and thus the higher fraction of molecules of substance A will be in the non dissociated state</strong>.  

<blockquote>
  Does lowering pH in this case causes substance A to dissociate?  
</blockquote>

<strong>No. Increasing pH causes substance A to dissociate.</strong>  

<hr>

<blockquote>
  Some additional information:   
  
  From the Henderson–Hasselbalch equation,  
  
  <p>$\textrm{pH} = \textrm{pK}_{a}+ \log_{10} \left (
&gt; \frac{[\textrm{A}^-]}{[\textrm{HA}]} \right )$</p>
  
  If pH = pKa, the concentration ratio of [A-] to [HA] is 1.  
  
  If your pH is higher than pKa, then [A-] must be greater than [HA].  
  
  <p>If you lower your pH such that it is lower than pKa, then [HA] must be
  greater than [A-]</p>
  
  <p>Therefore, by <em>increasing</em> the pH, you are dissociating HA into H+ and
  A-. Which makes sense according to the Le Chatelier principle, where
  H+ is released to counteract the increase in pH (or the decrease in
  [H+])</p>
</blockquote>

#### Answer 3 (score -1)
By specifying that A is lidocaine I could say that by adding HCl to it you'd be forming a diferent compound, lidocaine hydrocloride.  

<img src="https://i.stack.imgur.com/i4QMi.png" alt="Which is more or less like this in the solution.">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: Difference between exothermic and exergonic (score [95276](https://stackoverflow.com/q/5568) in )

#### Question
In High School I learned that an exothermic reactions releases energy, while an endothermic reaction needs energy to occur. Now I learned that there is a separate, somewhat similar classification scheme of exergonic and endergonic reactions.  

What is the difference between these two classification schemes? Are exothermic reactions always exergonic, and if not, can you give me an example?  

#### Answer accepted (score 39)
<blockquote>
  The classifications <em>endothermic</em> and <em>exothermic</em> refer to transfer of heat $q$ or changes in enthalpy $\Delta_\mathrm{R} H$. The classifications <em>endergonic</em> and <em>exergonic</em> refer to changes in free energy (usually the Gibbs Free Energy) $\Delta_\mathrm{R} G$.  
</blockquote>

If reactions are characterized and balanced by solely by heat transfer (or change in enthalpy), then you're going to use reaction enthalpy $\Delta{}_{\mathrm{R}}H$.    

Then there are three cases to distinguish:  

<ol>
<li>$\Delta{}_{\mathrm{R}}H &lt; 0$, an exothermic reaction that releases heat to the surroundings (temperature increases) </li>
<li>$\Delta{}_{\mathrm{R}}H = 0$, no net exchange of heat  </li>
<li>$\Delta{}_{\mathrm{R}}H &gt; 0$, an endothermic reaction that absorbs heat from the surroundings (temperature decreases)</li>
</ol>

In 1876, <a href="https://en.wikipedia.org/wiki/Julius_Thomsen" rel="noreferrer">Thomson</a> and <a href="https://en.wikipedia.org/wiki/Marcellin_Berthelot" rel="noreferrer">Berthelot</a> described this driving force in a <a href="https://en.wikipedia.org/wiki/Thomsen-Berthelot_principle" rel="noreferrer">principle</a> regarding affinities of reactions. According to them, only exothermic reactions were possible.  

Yet how would you explain, for example, wet cloths being suspended on a cloth-line -- dry, <em>even</em> during cold winter? Thanks to works by <a href="https://en.wikipedia.org/wiki/Hermann_von_Helmholtz" rel="noreferrer">von Helmholtz</a>,  <a href="https://en.wikipedia.org/wiki/Van%27t_Hoff,_Jacobus_Hendricus" rel="noreferrer">van't Hoff</a>, <a href="https://en.wikipedia.org/wiki/Boltzmann" rel="noreferrer">Boltzmann</a> (and others) we may do. <a href="https://en.wikipedia.org/wiki/Entropy" rel="noreferrer">Entropy</a> $S$, depending on the number of accessible realisations of the reactants ("describing the degree of order") necessarily is to be taken into account, too.   

These two contribute to the maximum work a reaction may produce, described by the <a href="http://en.wikipedia.org/wiki/Gibbs_free_energy" rel="noreferrer">Gibbs free energy</a> $G$. This is of particular importance considering reactions with gases, because the number of accessible realisations of the reactants ("degree or order") may change ($\Delta_\mathrm{R} S$ may be large).  For a given reaction, the change in reaction Gibbs free energy is $\Delta{}_{\mathrm{R}}G = \Delta{}_{\mathrm{R}}H - T\Delta{}_{\mathrm{}R}S$.  

Then there are three cases to distinguish:  

<ol>
<li>$\Delta{}_{\mathrm{R}}G &lt; 0$, an exergonic reaction, "running voluntarily" from the left to the right side of the reaction equation (react is spontaneous as written)</li>
<li>$\Delta{}_{\mathrm{R}}G = 0$, the state of thermodynamic equilibrium, i.e. on a macroscopic level, there is no net reaction or</li>
<li>$\Delta{}_{\mathrm{R}}G &gt; 0$, an endergonic reaction, which either needs energy input from outside to run from the left to the right side of the reaction equation or otherwise runs backwards, from the right to the left side (reaction is spontaneous in the reverse direction)</li>
</ol>

Reactions may be classified according to reaction enthalpy, reaction entropy, free reaction enthalpy -- even simultaneously -- always favouring an exergonic reaction:  

<ol>
<li>Example, combustion of propane with oxygen, $\ce{5 O2 + C3H8 -&gt; 4H2O + 3CO2}$. Since both heat dissipation ($\Delta_{\mathrm{R}}H &lt; 0$, exothermic) and increase of the number of particles ($\Delta_{\mathrm{R}}S &gt; 0$) favour the reaction, it is an exergonic reaction ($\Delta_{\mathrm{R}}G &lt; 0$).</li>
<li>Example, reaction of dioxygen to ozone, $\ce{3 O2 -&gt; 2 O3}$. This is an endergonic reaction ($\Delta_{\mathrm{R}}G &gt; 0$), because the number of molecules decreases ($\Delta_{\mathrm{R}}S &lt; 0$) and <em>simultaneously</em> it is endothermic ($\Delta_{\mathrm{R}}H &gt; 0$), too.</li>
<li><a href="https://en.wikipedia.org/wiki/Water-gas_shift_reaction" rel="noreferrer">Water gas reaction</a>, where water vapour is guided over solid carbon $\ce{H2O + C &lt;=&gt; CO + H2}$. Only at temperatures $T$ yielding an entropic contribution $T \cdot \Delta_{\mathrm{R}}S &gt; \Delta_{\mathrm{R}}H$, an endothermic reaction may become exergonic.</li>
<li>Reaction of hydrogen and oxygen to yield water vapour, $\ce{2 H2 + O2 -&gt; 2 H2O}$.  This is an exothermic reaction ($\Delta_{\mathrm{R}}H &lt; 0$) with decreasing number of particles ($\Delta_{\mathrm{R}}S &lt; 0$). Only at temperatures at or below $T$ with $|T \cdot \Delta_{\mathrm{R}}S| &lt; |\Delta_{\mathrm{R}}H|$ there is a macroscopic reaction.  In other words, while the reaction works fine at room temperature, at high temperatures (e.g. 6000 K), this reaction does not run.</li>
</ol>

After all, please keep in mind this is about thermodynamics, and not kinetics. There are also indications of spontaneity of a reaction.  

#### Answer 2 (score 1)
Both exergonic and exothermic reactions release energy, however, the energies released have different meanings as follows:  

<ul>
<li><p>Exothermic reaction</p>

<ul>
<li>Energy released is just called energy </li>
<li>Energy of reactants is greater than that of products</li>
<li>Energy of the reaction system decreases relative to that of the    surounding, i.e. the surrounding becomes hotter.</li>
</ul></li>
<li><p>Exergonic reaction</p>

<ul>
<li>Energy released, has a special name called Gibbs energy or Gibbs free   energy</li>
<li>Energy reactants is greater than that of the products</li>
<li>It has nothing to do with how hot or cold reactants become. Has a more chemical meaning - it relates to the spontaneity of the reaction; thus it always means that a reaction is feasible, i.e. reaction will always happen.</li>
</ul></li>
</ul>

In summary, whereas, an exergonic reaction means that a reaction is spontaneous, an exothermic reaction has nothing to do with spontaneity, but that an energy is released to the surrounding.  

#### Answer 3 (score -1)
<p>For a exothermic reaction, $\Delta H\lt0$. For a exergonic reaction constraint is (from Gibbs-Helmholtz eqn): $\Delta G\lt0 \Rightarrow \Delta H-T\Delta S\lt0 \Rightarrow \Delta H\lt T\Delta S$ 
Hence, even if $\Delta H&gt;0$ (endothermic reaction), a reaction can be exergonic provided it follows the constraint for it ($\Delta H\lt T\Delta S$; high temperature or greater no. of degree of freedom).
So there is no such imposition that a reaction has to be exothermic if it is exergonic or vice versa.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Why are there multiple lines in the hydrogen line spectrum? (score [94556](https://stackoverflow.com/q/5513) in 2017)

#### Question
Hydrogen has only one electron, yet it exhibits multiple lines in a spectral series, why is this?  

#### Answer accepted (score 15)
As the electrons fall from higher levels to lower levels, they release photons.  Different "falls" create different colors of light.  A larger transition releases higher energy (short wavelength) light, while smaller transitions release lower energies (longer wavelength).  

The visible wavelengths are caused a by single electron making the different transitions shown below.  There are even more transitions that release invisible wavelengths.  

```text
 Wavelength   Transition  Color              
 (nm)                                        
---------------------------------------------
 383.5384      9 -> 2    Ultra Violet
 388.9049      8 -> 2    Ultra Violet
 397.0072      7 -> 2    Ultra Violet
 410.174       6 -> 2    Violet
 434.047       5 -> 2    Violet
 486.133       4 -> 2    Bluegreen (cyan)
 656.272       3 -> 2    Red
 656.2852      3 -> 2    Red
```

*Values taken from <a href="http://hyperphysics.phy-astr.gsu.edu/hbase/hyde.html">Hyperphysics: Hydrogen Energies and Spectrum</a>  

(Why are there two different 3-> 2 transitions?  See here: <a href="http://hyperphysics.phy-astr.gsu.edu/hbase/quantum/hydfin.html#c1">Hydrogen Fine Structure </a>)  

#### Answer 2 (score 3)
Though a hydrogen atom has only one electron, it contains a large number of shells, so when this single electron jumps from one shell to another, a photon is emitted, and the energy difference of the shells causes different wavelengths to be released... hence, mono-electronic hydrogen has many spectral lines.  

#### Answer 3 (score 2)
Although hydrogen has only one electron, it contains many energy levels. When its electron jumps from higher energy level to a lower one, it releases a photon. Those photons cause different colours of light of different wavelengths due to the different levels. Those photons appear as lines. For this reason, though hydrogen has only one electron, more than one emission line is observed in its spectrum.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: How do you calculate molar specific heat? (score [94082](https://stackoverflow.com/q/1335) in 2015)

#### Question
I know how to calculate the specific heat, but not molar specific heat. What is molar specific heat and how do you calculate it?  

#### Answer accepted (score 3)
Specific heat has the units of $\mathrm{J/(K\cdot kg)}$.  

Molar specific heat is in units of $\mathrm{J/(K\cdot mol)}$, and is the amount of heat needed (in joules) to raise the temperature of $1$ mole of something, by $1$ kelvin (assuming no phase changes).  

So, the conversion factor you need, from dimension analysis, will have unit $\pu{kg/mol}$.  

$\pu{kg/mol}$ is the SI unit for molar mass.  

Multiply the specific heat by the molar mass to get the molar specific heat.  

<strong>For example,</strong> the molar mass of water is $\approx \pu{0.018 kg/mol}$.  

The specific heat of water is $\approx 4186\ \mathrm{J/(K\cdot kg)}$.  

So the molar specific heat of water is $4186\ \mathrm{J/(K\cdot kg)} \times \pu{0.018 kg/mol} \approx 75\ \mathrm{J/(K\cdot mol)}$  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Molecular orbital (MO) diagram for N2 and N2^- (score [93984](https://stackoverflow.com/q/34816) in 2017)

#### Question
I have been taught that the MO diagram is different for molecules with 14 or less electrons than the one used for molecules with 15 or more electrons.   

For $\ce{N2}$ the orbitals in increasing energy are:  

$$\sigma_\mathrm{1s} &lt; \sigma^*_\mathrm{1s} &lt; \sigma_\mathrm{2s} &lt; \sigma^*_\mathrm{2s} &lt; \pi_{\mathrm{2p}_x}, \pi_{\mathrm{2p}_y} &lt; \sigma_{\mathrm{2p}_z} &lt; \pi^*_{\mathrm{2p}_x}, \pi^*_{\mathrm{2p}_y} &lt; \sigma^*_{\mathrm{2p}_z}$$  

because it has 14 electrons.  

For $\ce{N2-}$ there are 15 electrons. Will the MO diagram be the same as that of $\ce{N2}$ or not? Why?    

And because this is a good chance to ask, why is there this difference in orbital energies anyway?  

#### Answer accepted (score 19)
<blockquote>
  <p>I have been taught that the MO diagram is different for molecules with
  14 or less electrons than the one used for molecules with 15 or more
  electrons.</p>
</blockquote>

This is (partly) wrong because the change in the order of $\mathrm{\sigma_{2p_{z}}}$ and $\mathrm{\pi_{2p_{xy}}}$ MOs to the left of $\ce{N2}$ is not directly related to the number of electrons. Rather, it is rationalized by a successive decrease of the $\mathrm{s}$-$\mathrm{p}$ interaction moving from $\ce{Li2}$ to $\ce{F2}$. The $\mathrm{s}$-$\mathrm{p}$ interaction is the bonding interaction between the $\mathrm{2s}$ orbital of one atom and the $\mathrm{2p_{z}}$ orbital of another atom which (among other things) increases the energy of the $\mathrm{\sigma_{2p_{z}}}$ MO relative to the hypothetical case without $\mathrm{s}$-$\mathrm{p}$ interaction.  

Now the difference in energy between the $\mathrm{2s}$ and $\mathrm{2p_{z}}$ AOs increases from $\ce{Li2}$ to $\ce{F2}$ due to increasing nuclear charge and poor screening of the $\mathrm{2s}$ electrons by electrons in the $\mathrm{2p}$ subshell. As a result, the rising effect of $\mathrm{s}$-$\mathrm{p}$ interaction on $\mathrm{\sigma_{2p_{z}}}$ MO is getting less and less prominent, so that eventually to the right of $\ce{N2}$ $\mathrm{\sigma_{2p_{z}}}$ MO becomes lower in energy than $\mathrm{\pi_{2p_{x,y}}}$ MO.  

<a href="https://i.stack.imgur.com/4KdEO.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/4KdEO.jpg" alt="enter image description here"></a>  

Image courtesy of the <a href="https://web.archive.org/web/20150706110342/http://chemwiki.ucdavis.edu/Wikitexts/UC_Davis/UCD_Chem_2A/UCD_Chem_2A:_Hayashi/Unit_IV:_Electronic_Structure_and_Bonding/10:_Bonding_II:_Additional_Aspects/10.5:_Molecular_Orbital_Theory" rel="noreferrer">UC Davis ChemWiki</a>.   

Now, back to the question.  

<blockquote>
  <p>For $\ce{N2-}$ there are 15 electrons. Will the MO diagram be the same as
  that of $\ce{N2}$ (because it is actually an ionized molecule of $\ce{N2}$) or not?
  Why?</p>
</blockquote>

The short answer is: we could not tell it using the primitive molecular orbital theory introduced in the general chemistry courses. In exact same way we could not tell why $\mathrm{\sigma_{2p_{z}}}$ MO becomes lower in energy than $\mathrm{\sigma_{2p_{z}}}$ MO to the left of $\ce{N2}$ and not to the left of, say, $\ce{C2}$. All this is simply because the primitive molecular orbital theory does not explain the things, rather it rationalizes them (for differences between explanation and rationalization, please, read <a href="https://chemistry.stackexchange.com/a/34327/186">here</a>).  

But then how do we know in the first place that $\mathrm{\sigma_{2p_{z}}}$ MO becomes lower in energy than $\mathrm{\sigma_{2p_{z}}}$ MO to the left of $\ce{N2}$ so that we can start to rationalize it? Well, we know that from a more advanced molecular orbital theory which is based on the laws of quantum mechanics. And the same advanced theory should be applied for the case of $\ce{N2-}$ to get the MO picture of this chemical species.   

Now note that even in this advanced molecular orbital theory a bunch of approximations is introduced, and the answer in general depends on at which level of theory calculations are done. The simplest picture would be the so-called <em>frozen-orbital approximation</em> (in the Hartree-Fock picture) in which MOs of an anion (as well as that of a cation) are assumed to be the same as for the corresponding neutral molecule. But this approximate picture might be far away from the reality.  

<strong>Update</strong>  

The question in fact does not make a lot of sense since $\ce{N2-}$ is known to be electronically <em>unstable</em>, i.e. its energetically less favourable then the system of $\ce{N2}$ plus a free electron. There exist few metastable resonance states of $\ce{N2-}$ that correspond to attachment of the scattered electron to excited valence states<sup>1</sup>, but that's a different story which is beyond the scope of the question.  

<hr>

1) Krauss, M., Neumann, D., Valence Resonance States of N2, <em>JResNatlStandSecA</em>, 77A, 4, 1973. <a href="http://nvlpubs.nist.gov/nistpubs/jres/77A/jresv77An4p411_A1b.pdf" rel="noreferrer">PDF</a>.  

#### Answer 2 (score 3)
The reason for the special order for molecules with 14 or less electrons is due to the s-p mixing that arises due to the s and p atomic orbitals being close in energy. It is not actually possible to definitely answer your question without looking at the actual orbital energies.   

Despite $\ce{N2-}$ being isoelectronic to $\ce{O2+}$, the lower effective nuclear charge on nitrogen should make its s orbitals a little closer to the energies of the p orbitals than they would be in oxygen. Hence s-p mixing should occur. However there are other considerations that we need to take in account, such as the extra electron repulsion that occur due to the extra electron. Yet, as I have stated above we can't definitively say which effect is more important without looking at the actual orbital energies.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: How to identify a compound as chiral or achiral (score [92596](https://stackoverflow.com/q/31157) in 2016)

#### Question
I read my book and learned everything about enantiomers, racemization, $\mathrm{S_N1}$ and $\mathrm{S_N2}$ reactions, but when I'm trying to identify molecules as chiral or achiral, I get confused.  

Consider the two molecules below:  

```text
1.CH3-CH-OH
      |
      Br

2.CH3-CH-Br
      |
      Br
```

How can I tell if a compound is chiral?  

#### Answer accepted (score 7)
Chirality can be determined by visualising the molecule in space. Once you do that, you can check to see if there exists a non-superimposable mirror image. If this is indeed the case, then your molecule is chiral.  

You can look for an asymmetric carbon atom--because this often results in chirality.   

An asymmetric carbon (or chiral carbon) is, very simply,  a carbon atom attached to four different groups.  

With this in mind, consider your examples: 1) should thus be chiral and 2) is achiral.  

Hope this makes sense.  

#### Answer 2 (score 8)
<ol>
<li><p>Draw both molecules. Don't draw them flat. Alternatively, model them using <a href="http://avogadro.cc">Avogadro</a>.</p></li>
<li><p>Exchange the positions of $\ce{Br}$ and $\ce{OH}$ in the first case. Is the new molecule identical to the original one?</p></li>
<li><p>Do the same for the dibromo-substituted compound. How is the result here?</p></li>
</ol>

#### Answer 3 (score 7)
<ol>
<li><p>Draw both molecules. Don't draw them flat. Alternatively, model them using <a href="http://avogadro.cc">Avogadro</a>.</p></li>
<li><p>Exchange the positions of $\ce{Br}$ and $\ce{OH}$ in the first case. Is the new molecule identical to the original one?</p></li>
<li><p>Do the same for the dibromo-substituted compound. How is the result here?</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Why does pH affect fermentation? (score [91506](https://stackoverflow.com/q/11160) in )

#### Question
I know that the lower the pH the faster fermentation occurs. Why does this happen?  

#### Answer accepted (score 6)
pH affects the shape of proteins. In the case of fermentation a collection of enzymes is responsible for the metabolic processes that occur. - an enzyme is a protein which performs a metabolic process. For example sucrase is an enzyme which breaks sucrose down into fructose and glucose. They are kind of like organic catalysts.  

Proteins are made of amino acids strung together in a long line, based off DNA. The amino acids bond up into a long polymer. Then cross linking occurs between the R groups on the amino acids. This makes the unique shape of the protein, because the cross-linking turns the protein into a 3-d shape.  

Amino acids may be acidic amino acids, or basic amino acids, due to the R group on the amino acids. If the pH is increased, this affects the shape of proteins, by disrupting the bonds in the protein. In the case of fermentation, you say the rate increases when it get's more acidic - when the pH is lower. This is because the organisms - the yeast - producing the enzymes to ferment glucose, have adapted to acidic conditions. This means that through natural selection the enzymes today have been selected because they work best in acidic conditions, which bend the protein into the correct shape to allow fermentation to occur.  

Read: <a href="http://www.icr.org/article/glycolysis-alcoholic-fermentation/" rel="noreferrer">http://www.icr.org/article/glycolysis-alcoholic-fermentation/</a>  

In this article it says that 10 enzymes turn glucose in pyruvic acid:<a href="http://en.wikipedia.org/wiki/File%3aPyruvic-acid-2D-skeletal.png" rel="noreferrer">http://en.wikipedia.org/wiki/File:Pyruvic-acid-2D-skeletal.png</a>  

And then two enzymes turn this into ethanol and CO2. The last two enzymes function best in acidic conditions, presumably because they have evolved to work best in the acidic conditions made by the pyruvic cid. However all fermentation stops after the pH drops below about 4.2. The optimum pH is about 4.8 - 5.0. After this we can assume that the pH bends the proteins out of shape too much, and the protein is said to have been denatured.  

So to conclude... The rate increases because enzymes are all suited to specific conditions, dictated by natural selection - the conditions they have evolved around - and in the case of fermentation the last 2 enzymes - turning pyruvic acid to ethanol and CO2 - work best in acidic conditions, as they have evolved to those conditions. But increase the pH too much... and the protein denatures, and fermentation stops completely.  

#### Answer 2 (score 4)
In addition to the other answers, another reason for the increase in fermentation rate in a lower PH is that the reaction actually uses up more protons (H+) than are actually produced in glycolysis. Like lactate fermentation the 2 NADH and 2 H+ produced during glycolysis are converted back to NAD+, but in ethanol fermentation there is an earlier step in which a hydrogen atom is added to the pyruvate when it is decarboxylated.  

Take a look at <a href="http://chemwiki.ucdavis.edu/@api/deki/files/19458/=ferm_01.jpg?revision=1&amp;size=bestfit&amp;width=482&amp;height=119" rel="nofollow">this image</a>. The "acetaldehyde" (ethanal) gains 2 hydrogen atoms from the NADH and H+ which is expected, but it has one more hydrogen atom than the pyruvate molecule. Now look at <a href="https://upload.wikimedia.org/wikipedia/commons/6/6c/Pyruvate_decarboxylase_mechanism.png" rel="nofollow">this image</a> of the mechanism of pyruvate decarboxylase. See how in the third part an H+ appears out of nowhere?   

In low PH solutions the concentration of H+ is greater. This increases the rate of reaction which, of course, increases the rate of ethanol fermentation.  

#### Answer 3 (score 3)
I don't know that it's correct to say that lower pH increases fermentation rate in all cases. It is true for pH ranges that are close to neutral, but there is a point where increasing acidity will kill the yeast.  

In general though, yeasts and molds are more tolerant of acidic conditions than they are of basic conditions, down to a pH of about 5. Bacteria, on the other hand, tend to not be very tolerant of acidic conditions (at least, not the bacteria commonly found in places where we are trying to encourage fermentation.) This <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1087585/" rel="nofollow">article</a> compares the growth and fermentation rates of bacteria to yeast under different conditions, and finds that under mildly acidic conditions (pH of 5.5 to 5.0) the bacterial growth rate was slowed and the yeast growth rate was maximized. Since bacteria competes with yeast for food, the ideal pH is the one that kills the most bacteria without slowing the yeast growth rate down. A pH of 5 is about the same as a cup of black coffee, and is about one hundred times less acidic than orange juice.   

I also found this <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC294626/" rel="nofollow">article</a> which describes another interesting effect - the bacteria that was used in the first experiment actually starts producing ethanol as a fermentation product under acidic conditions, instead of just lactose. I suspect that growth rates are a bigger factor, but it is an interesting complication.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How is it determined how many electrons are transferred in redox reactions? (score [89370](https://stackoverflow.com/q/5122) in 2013)

#### Question
For example, iron and tin(II) sulfate will react to produce iron(II) sulfate and tin:  

$\ce{Fe + SnSO4 -&gt; FeSO4 + Sn}$  

With the following half equations:  

$\ce{Fe + SO4^{2-} -&gt; FeSO4 + 2e-}$  

and  

$\ce{Sn^{2+} + 2e- -&gt; Sn}$  

but where does the "2" come from? Why can't it be:  

$\ce{Fe + SO4^{5-} -&gt; FeSO4 + 5e-}$  

and  

$\ce{Sn^{5+} + 5e- -&gt; Sn}$  

#### Answer accepted (score 6)
In short, the species you mention ($\ce{Sn^{5+}}$ and $\ce{SO_4^{5-}}$) do not exist in any chemical system at anywhere near ordinary conditions. The number of electrons shuffled in the reaction is not chosen arbitrarily, but is based on the initial and final oxidation numbers of the elements in the reaction, after the equations are balanced. The only stable compound with formula $\ce{SnSO_4}$ is made of $\ce{Sn^{2+}}$ and $\ce{SO_4^{2-}}$ ions. Hence in your reaction, $\ce{Sn}$ atoms start with oxidation number +2 and end with 0 (therefore gaining two electrons) and $\ce{Fe}$ atoms start with oxidation number 0 and end with +2 (therefore losing two electrons).  

As another example of electron counting, here's the reaction between $\ce{Ba}$ and $\ce{Al^3+}$:  

Oxidation: $\ce{Ba^0 -&gt; Ba^{2+} + 2e^{-}}$  

Reduction: $\ce{Al^{3+} + 3e^{-} -&gt; Al^0}$  

To balance the equations, the oxidation half-reaction must be multiplied by 3 and the reduction half-reaction must be multiplied by two. Therefore:  

Oxidation: $\ce{3Ba^0 -&gt; 3Ba^{2+} + 6e^{-}}$  

Reduction: $\ce{2Al^{3+} + 6e^{-} -&gt; 2Al^0}$  

Global: $\ce{3Ba^0 + 2Al^{3+} -&gt; 3Ba^{2+} + 2Al^0}$  

In the global reaction, <em>six</em> electrons are involved.  

#### Answer 2 (score 1)
After you calculate everything and balance the $\ce{e-}$ too, then you will know that one side loses a certain number of $\ce{e-}$ and the other gains this certain number of $\ce{e-}$.   

There isn't any other way apart from balancing the equation and figuring it out from there.  

Check <a href="http://www.dummies.com/how-to/content/how-to-balance-redox-equations.html" rel="nofollow">here</a> and <a href="https://www.khanacademy.org/test-prep/mcat/physical-processes/redox-reactions/v/balance-and-redox-reactions1" rel="nofollow">here</a> for more info.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Why doesn't calcium carbonate dissolve in water even though it is an ionic compound? (score [89136](https://stackoverflow.com/q/17089) in 2014)

#### Question
I studied the solubility of compounds in water. I have found that <a href="http://en.wikipedia.org/wiki/Calcium_carbonate">calcium carbonate</a> doesn't dissolve in water. The teacher stated that the ionic compounds dissolve in water except some carbonates. What would be a clear elaboration of this phenomenon?  

#### Answer accepted (score 16)
As someone said here, this:  

<blockquote>
  <p>The teacher stated that the ionic compounds dissolve in water except
  some carbonates.</p>
</blockquote>

Is indeed an oversimplification. First of all, the distinction between an "ionic compound" to other compounds isn't too defined. What your teacher probably said, or didn't say but wanted to, is that some ionic compounds easily dissolve in water. Salt (halite - NaCl) is the best example.  

Calcium carbonate, in nature, also commonly dissolves. It's just not as immediate as dissolution of the more soluble ionic compounds. You are probably familiar with this phenomenon:  

<img src="https://i.stack.imgur.com/FMZlp.jpg" alt="picture of a cave">  

This forms <em>because</em> calcium carbonate dissolves. The rock is limestone, which is usually composed of pure calcium carbonate. Acidic water greatly enhances the solubility of calcium carbonate, and it doesn't even need to be highly acidic. Rain or river water that come into contact with the atmosphere absorb the $\ce{CO2}$ as $$\ce{H2O + CO2 &lt;=&gt; H2CO3},$$ which then facilitates calcium carbonate dissolution with $$\ce{CaCO3 + H2CO3 &lt;=&gt; Ca^2+ + 2HCO3-}.$$  

#### Answer 2 (score 15)
For an ionic substance to dissolve in water, there are two competing factors that determine the enthalpy of solution $\Delta{H}_\mathrm{sol}$ which is the enthalpy (energy) change  when a solute is dissolved in a solvent:  

<ol>
<li>The lattice energy (LE), the energy of formation of the crystal between infinitely separated ions. As LE is proportional to the charges of its ions, for calcium carbonate, its LE would be roughly 4&times; the LE of sodium chloride. $$\ce{CaCO3 (s) -&gt; Ca^2+ (g) + CO3^2- (g)}$$ This value is always positive, as energy is required to separate the ions.</li>
<li>The hydration energy of gaseous ions, which  is the enthalpy change when gaseous ions dissolve in sufficient water to give an infinitely dilute solution. $$\ce{Ca^2+ (g) + CO3^2- (g) -&gt; Ca^2+ (aq) + CO3^2- (aq)}$$ These values are always negative, as energy is released upon hydration of ions.</li>
</ol>

As the LE of calcium carbonate is so large, a great amount of free energy would be required to break the strongly attracted ions apart, and this energy has to come from the enthalpy of hydration. In the case of calcium carbonate,  the enthalpy of hydration is not large enough to overcome the large lattice energy, hence it exists as a solid.  

Do note that solubility of ionic compounds are not absolute. In fact, solubility in water is often given as a value in g/L of water.   

However, generally, we define solubility as:  

<ol>
<li>Soluble substances can form a 0.1&nbsp;M solution at 25&nbsp;°C.</li>
<li>Insoluble substances cannot form a 0.1&nbsp;M solution at 25&nbsp;°C.</li>
</ol>

#### Answer 3 (score 13)
<blockquote>
  Teacher stated that the ionic compounds dissolve in water except some carbonates.  
</blockquote>

That is, at best, an oversimplification. Other ionic compounds such as silver sulfide are sparingly soluble in water. Note that this isn't a carbonate.   

And sodium hydrogen carbonate - $\ce{NaHCO3}$ - is soluble in water.   

Sodium carbonate ($\ce{Na2CO3}$) is also soluble in water.   

<blockquote>
  I want a clear elaboration of this phenomenon can somebody help me??  
</blockquote>

Solubility depends on:  

1) The strength of the intermolecular attractions within the solute and the strength of the solvent-solvent interactions. How strongly is the calcium ion and the carbonate ion bound together? You might <em>think</em> that the force of attraction between a +2 and a -2 ion is strong, but remember, covalent bonds are generally stronger than ionic interactions. How strong are the solvent-solvent molecule interactions - which must be broken before something can be solvated?   

2) Solvation. How well can the solvent lower the energy of the dissociated solute ions? How well can calcium ion and carbonate ion be solvated (by water in this case?) How strong are the solvent-solute ion interactions? What about the entropy of solvation? (Solvation shells are highly ordered).   

If you wish to predict the solubility of some compound, try using hard soft acid/base theory.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Covalent Bond/Hydrogen Bond (score [88303](https://stackoverflow.com/q/4315) in 2015)

#### Question
During the formation of a molecule of water ($\ce{H2O}$), what kind of bond occurs between the elements? I'm studying this subject on my own and from some sources I saw that there is a covalent bond and others showed an hydrogen bond, responsible for the non-evaporation of water at $-90\ ^{\circ} \rm{C}$. Can you guys explain to me exactly how this bonds behave? Both of them occurs to the molecules of water?  

#### Answer accepted (score 7)
Covalent bonds are the bonds between the atoms within the same water molecule. Hydrogen bonds are the bonds between two water molecules. All molecules have covalent bonds, but only some molecules have hydrogen bonds. As an example, water has hydrogen bonds, but carbon dioxide does not.  

One of the requirements for hydrogen bonding is that the molecule must be polar. Water molecules are polar because of two effects. The first is that oxygen is more electronegative than hydrogen, so each of the OH bonds will be polar. The electrons shared in each of those bonds will spend more time near the oxygen than near the hydrogen. The other effect is the geometry of the molecule: the oxygen atom has two free electron pairs in addition to the two bonds, so it assumes a tetrahedral arrangement. The $\ce{O-H}$ bonds are two corners of that tetrahedron, and the free electron pairs are the other two corners. This arrangement means that, if you only look at the atoms, the molecule has a bent geometry. Because of that, the polarity of the two bonds partially adds together. By contrast, $\ce{CO2}$ has a linear geometry, and the two polar bonds cancel each other out, leaving the molecule non-polar.    

So the water molecule is polar, with a lot of excess positive charge around the hydrogen atoms, and a lot of negative charge on the side of the oxygen atom away from the hydrogen atoms. Hydrogen bond is the name given to the electrostatic interaction between the positive charge on a hydrogen atom and the negative charge on the oxygen atom of a neighboring molecule. The covalent bond is the electrostatic interaction between two atoms in the same molecule. Covalent bonds are much stronger than hydrogen bonds: the $\ce{O-H}$ has a strength of 467 kJ/mol, while the hydrogen bond is usually between 4 to 40 kJ/mol.  

#### Answer 2 (score 7)
Covalent bonds are the bonds between the atoms within the same water molecule. Hydrogen bonds are the bonds between two water molecules. All molecules have covalent bonds, but only some molecules have hydrogen bonds. As an example, water has hydrogen bonds, but carbon dioxide does not.  

One of the requirements for hydrogen bonding is that the molecule must be polar. Water molecules are polar because of two effects. The first is that oxygen is more electronegative than hydrogen, so each of the OH bonds will be polar. The electrons shared in each of those bonds will spend more time near the oxygen than near the hydrogen. The other effect is the geometry of the molecule: the oxygen atom has two free electron pairs in addition to the two bonds, so it assumes a tetrahedral arrangement. The $\ce{O-H}$ bonds are two corners of that tetrahedron, and the free electron pairs are the other two corners. This arrangement means that, if you only look at the atoms, the molecule has a bent geometry. Because of that, the polarity of the two bonds partially adds together. By contrast, $\ce{CO2}$ has a linear geometry, and the two polar bonds cancel each other out, leaving the molecule non-polar.    

So the water molecule is polar, with a lot of excess positive charge around the hydrogen atoms, and a lot of negative charge on the side of the oxygen atom away from the hydrogen atoms. Hydrogen bond is the name given to the electrostatic interaction between the positive charge on a hydrogen atom and the negative charge on the oxygen atom of a neighboring molecule. The covalent bond is the electrostatic interaction between two atoms in the same molecule. Covalent bonds are much stronger than hydrogen bonds: the $\ce{O-H}$ has a strength of 467 kJ/mol, while the hydrogen bond is usually between 4 to 40 kJ/mol.  

#### Answer 3 (score 1)




In H2O molecule, two water molecules are bonded by a Hydrogen bond but the bond between two H - O bonds within a water molecule are covalent.  

Refer this diagram : <a href="http://goo.gl/84w9T" rel="nofollow">http://goo.gl/84w9T</a>  

 The dotted lines represent a hydrogen bond and the solid lines represent a covalent bond.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: How to Find the Mass of an Individual Element in a Compound/Molecule (score [88216](https://stackoverflow.com/q/39221) in 2015)

#### Question
What is the procedure/math for finding the mass of a specific element in a substance? For instance, how many grams of Oxygen are in 6.8 grams of Epinephrine (Adrenaline)?   

#### Answer accepted (score 4)
<strong>Step 1: Find the Molar Mass of Adrenaline</strong>   

To do this, you must need to know its chemical formula which is $\ce{C9H13NO3}$. Now to calculate its molar mass, we add up all of the molar masses of each atom: $$M =9\times12~\mathrm{g~mol^{-1}} + 1\times13~\mathrm{g~mol^{-1}} + 14~\mathrm{g~mol^{-1}} + 3\times16~\mathrm{g~mol^{-1}} = 183~\mathrm{g~mol^{-1}}$$  

<strong>Step 2: Find the Mass of Oxygen in 1 mol of Adrenaline</strong>  

In each molecule of adrenaline, there is 3 molecules of oxygen atoms. This means that in $1\ \mathrm{mol}$ of adrenaline, there are $3\ \mathrm{mol}$ of oxygen. Therefore the mass of oxygen in $1\ \mathrm{mol}$ of adrenaline is: $\mathrm{3~mol\times16~g~mol^{-1} = 48~g}$.   

<strong>Step 3: Calculate Percentage Composition of Oxygen by Mass</strong>  

We now know that in every mole of adrenaline, there are $48\ \mathrm{g}$ of oxygen. We also know that $1\ \mathrm{mol}$ of adrenaline weighs $183\ \mathrm{g}$. Therefore in $183\ \mathrm{g}$ of adrenaline, there are $48\ \mathrm{g}$ of oxygen. All have to do is simply divide by them by each other and multiply by $100$ to get the percentage composition of oxygen. Therefore the percentage composition is $26.23\,\%$.  

<strong>Step 4: Calculate Mass of Oxygen in Sample</strong>  

Now we know the percentage composition of oxygen which is $26.23\,\%$. This means that in every gram of adrenaline, there is $0.2623\ \mathrm{g}$ of oxygen. Therefore to find the mass of oxygen in the sample: $$m_\text{oxygen} = 0.2623 \times 6.8~\mathrm{g} = 1.78~\mathrm{g}$$  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Half equations for H2O2 for its reducing and oxidising nature in acidic and alkaline medium (score [88025](https://stackoverflow.com/q/10375) in 2019)

#### Question
Is there a complete list of all the half equations for <span class="math-container">$\ce{H2O2}$</span> - both oxidation and reduction, in acidic and alkaline conditions? I've looked on the internet but can't seem to find a list with all of them.  

These are my first attempts:   

<ul>
<li><span class="math-container">$\ce{H2O2 + 2e^- -&gt; 2OH^-}$</span> (in alkaline conditions)</li>
<li><span class="math-container">$\ce{H2O2 + 2H^+ + 2e^- -&gt; 2H2O}$</span> (in acidic conditions)</li>
<li><span class="math-container">$\ce{H2O2 -&gt; 2H^+ + O2 + 2e^-}$</span> (in acidic conditions)</li>
</ul>

Are these correct and are there any more?  

#### Answer accepted (score 5)
From <a href="http://books.google.it/books?id=cptVx_1zpawC&amp;pg=PA198&amp;dq=hydrogen+peroxide+electrochemistry&amp;hl=it&amp;sa=X&amp;ei=k_FhU_zvMoqFtQa1oIDIDg&amp;ved=0CEsQ6AEwAA#v=onepage&amp;q=hydrogen%20peroxide%20electrochemistry&amp;f=false" rel="nofollow noreferrer">Proceedings of the Symposium on Oxygen Electrochemistry</a> and <a href="https://doi.org/10.1016/S0043-1354(01)00235-4" rel="nofollow noreferrer"><em>Water Research</em> <strong>2002</strong>, <em>36</em> (1), 85-94</a>:  

<p><span class="math-container">$$
\begin{array}{lcc}
\text{Formation}&amp;:&amp;~\ce{2H+ + O2 + 2e- &amp;-&gt;&amp; H2O2} &amp;\quad E^0=\pu{0.440V} \text{ vs. SCE}\\
\text{Reduction}&amp;:&amp; ~\ce{H2O2 + 2H+ + 2e- &amp;-&gt;&amp; 2H2O} &amp;\quad E^0=\pu{1.534V} \text{ vs. SCE}\\
\text{Direct water}&amp;:&amp; ~\ce{2H+ + 1/2O2 + 2e- &amp;-&gt;&amp; H2O}\\
\text{Decomposition}&amp;:&amp;  ~\ce{H2O2 &amp;-&gt;&amp; H2O + 1/2 O2}
\end{array}$$</span></p>

(<span class="math-container">$\text{SCE}$</span> stands for <a href="https://en.wikipedia.org/wiki/Saturated_calomel_electrode" rel="nofollow noreferrer">Saturated Calomel Electrode</a>)  

Another strange suggested reaction involves the anion <span class="math-container">$\ce{HO2-}$</span> (<a href="http://doi.org/10.1007/BF00938566" rel="nofollow noreferrer">Abel E.: Über die Selbstzersetzung von Wasserstoffsuperoxyd. <em>Monatshefte für Chemie</em> <strong>1952</strong> <em>83(2)</em> 422–39.</a>):  

<span class="math-container">$$\text{Decomposition 2}:\ce{H2O2 + H2O- -&gt; H2O + O2 + OH-}$$</span>  

<hr>

At the cathode occur at the same time the hydrogen gas evolution:  

<span class="math-container">$$\ce{2H+ + 2e- -&gt; H2~} \qquad\qquad\phantom{00} E^0=\pu{0.242 V} \text{ vs. SCE}$$</span>  

Meanwhile, at the anode, oxygen gas is evolved:  

<span class="math-container">$$~\ce{2H2O -&gt; 4H+ + O2 + 4e-} \quad E^0=\pu{0.987V} \text{ vs. SCE}$$</span>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: How do I calculate the degree of dissociation in equilibrium? (score [87768](https://stackoverflow.com/q/531) in 2017)

#### Question
<p>In my textbook, for calculating the percentage dissociation of $\ce{HF}$ for the given equation:
$$\ce{HF + H2O &lt;=&gt; H3O+ + F-}$$</p>

The solution is:  

<p>Initial Concentrations
$$[\ce{HF}] = 0.08~\mathrm{M}, \: \ce{[H3O+]} = 0, \:\ce{[F- ]}= 0$$
Equilibrium concentrations
$$[\ce{HF}] = 0.08~\mathrm{M} - x, \: \ce{[H3O+]} = x, \:\ce{[F- ]}= x$$</p>

I am not able to undestand why $x$ is subtracted from 0.08 and not $cx$ [ where $x$ is the degree of dissociation]   

I tried solving the same problem taking $cx$ but not able to get the solution, can anybody explain the difference to me? I have tried asking a <a href="https://chemistry.stackexchange.com/q/507/160">similar question</a> earlier too but it is really hard for me to get my head around this concept.  

#### Answer accepted (score 15)
Let us first define the terms needed here.     

<ul>
<li><strong>Degree of dissociation (DOD)</strong><br>
Degree of dissociation is the fraction of a mole of the reactant that underwent dissociation. It is represented by $\alpha$.<br>
$$\alpha = \frac{\text{amount of substance of the reactant dissociated}}{\text{amount of substance of the reactant present initially}}$$  </li>
<li><strong>Number of moles dissociated</strong><br>
It is defined as the product of the <em>initial concentration of the reactant</em> and the <em>degree of dissociation</em></li>
</ul>

<p>Now suppose you have a reaction like this<br>
$$\ce{A-&gt;B + C}$$</p>

<p>The initial state of A is <strong>always</strong> the concentration of A (should be given in the question) while initial moles of B and C are zero (if anything else is not specified).
The final state of A is <strong>always</strong> defined as $\text{(amount of substance initially present) - (amount of substance dissociated)}$ while for B and C it is <strong>just</strong> $\text{amount of substance of A dissociated)}$.</p>

<p>Writing our equation again,
\begin{array}{lcccc}
 &amp; \ce{A &amp;-&gt; &amp;B &amp;+ &amp;C}\\
\text{Initial amount of substance}&amp; a &amp;&amp; 0 &amp;&amp; 0\\
\text{Final amount of substance}&amp;   a - a\cdot(\mathrm{DOD}) &amp;&amp; a\cdot(\mathrm{DOD}) &amp;&amp; a\cdot(\mathrm{DOD})\\
\end{array}</p>

#### Answer 2 (score 0)
<p>x is the extent of the reaction and α is the DoD. if the initial amount of the only reactant is a than<br>
α=x/a
and x=aα 
α is useful to dissociation type reactions, where reactant is only one and the coefficient is 1.
such as
PCl5-> PCl3  +  Cl2
N2O4  ->  2NO2
NH3  ->  (1/2)N2  +(3/2)H2 </p>

#### Answer 3 (score -1)
x is subtracted from reactants , because the reaction is forward, so it will change in to ions, or we can say the concentration of reactants will decrease therefore we write minus x, and the acid you mention here is weak acid so it will not dissociate completely, so we donot know directly how much it will dissociate thus we use a variable x ,to find the value of x  we make equation ,eg c-x=x+x then kc =x2/c-x ,then we solve for x , and get the amount which dissociated,  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How do non-polar substances dissolve in non-polar solvents? (score [87347](https://stackoverflow.com/q/1289) in )

#### Question
The case of polar solvents is clear to me - we get an attraction between opposite charges. However, how do non-polar substances dissolve in non-polar solvents? How could it be explained on a molecular level?  

#### Answer accepted (score 28)
The electron density distribution in molecules (including nonpolar ones) is not static. Therefor, as a function of time, the electron density is not uniform. Occasionally, randomly, the electron density in a molecule will shift to produce a spontaneous dipole: part of the molecule now has more electron density ($\delta^-$) and part of the molecule now has less electron density ($\delta^+$). This spontaneous dipole is transient. The electron density will shift back to negate it and then shift again to create a new spontaneous dipole. In a vacuum, this behavior would be a curiosity.  

In the presence of other molecules, these spontaneous dipoles have a propagating effect. If molecule A develops a spontaneous dipole, then the electron density in neighboring molecule B will by respond by developing a spontaneous (but opposite) dipole. The $\delta^+$ region of B will be close to the $\delta^-$ region of A. This new dipole in molecule B is an induced dipole. This induced dipole in B will then induce a new induced dipole in another neighboring molecule C. By this time the transient dipole in A is already fading, perhaps to be replaced by a new induced dipole from another molecule.  

These random, transient, but continuously propagating dipoles have attractive forces associated with them. These forces are named London dispersion forces after the physicist who proposed them. The magnitude of these forces scales with increasing surface area of the molecule. Thus, larger molecules will overall have stronger London dispersion forces than smaller molecules. Linear rod-like molecules will have stronger forces than spherical molecules (spheres having the smallest surface area to volume ratio of the 3-dimensional solids).  

More complex attractive forces also arise from nonpolar molecules. Benzene (and other aromatic molecules) can <a href="http://en.wikipedia.org/wiki/Pi_stacking">pi stack</a>, which relies on the strong permanent electric <a href="http://en.wikipedia.org/wiki/Quadrupole">quadrupole</a>. Benzene also has a (weak but) permanent magnetic dipole due to its ring current, so some component of the attraction between benzene molecules may be magnetic and not coulombic. Or, the two attractions may be one and the same, as benzene's electric quadrupole may result from its having a magnetic dipole. As his part of the discussion is devolving into physics, I will end here.   

#### Answer 2 (score 19)
I think @Ben Norris's answer is great, but I wanted to add one other reason that non-polar molecules will dissolve in non-polar solvents, even in the absence of interactions: entropy. If there are no intermolecular interactions at all (ie, the solvent molecules ignore each other and the solute molecules, and the solute molecules ignore each other and the solvent molecules), then the <a href="http://en.wikipedia.org/wiki/Entropy_of_mixing">entropy of mixing</a> will be positive, and mixing will be favored. As a result, species always want to mix; it takes unfavorable conditions to cause non-solubility.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: Tetrahedral or Square Planar (score [87008](https://stackoverflow.com/q/4649) in 2013)

#### Question
How can one predict whether a given complex ion will be square planar or tetrahedral when its coordination number is 4 using crystal field theory ?  

Is it possible to theoretically predict this?  

#### Answer accepted (score 17)
This is a really quick and dirty method since I don't know much about the calculations involved in crystal field theory. This method is based on some general observations I've made.  

First of all, if your complex metal ion is not in group 8 ($\ce{Ni}$, $\ce{Pd}$, $\ce{Pt}$) or it doesn't have a $d^8$ configuration (like $\ce{Rh(I)}$ or $\ce{Au(III)}$), it is usually tetrahedral (Assuming you already know that the coordination number is 4).  

If your metal ion is in group 8 or has a $d^8$ configuration, look at the crystal field splitting diagram. Square planar complexes have a four tiered diagram (i.e. four different sets of orbitals with different energies).  

<img src="https://i.stack.imgur.com/Mkc9g.png" alt="enter image description here">  

If it has a two tiered crystal field splitting diagram then it is tetrahedral.  

<img src="https://i.stack.imgur.com/7JOGx.png" alt="enter image description here">   

But this assumes you have the crystal field splitting diagram of the complex.   

As to how you obtain these diagrams (the calculations involved), I don't know exactly how it's done for specific molecules.   

Like I mentioned before, this is just a very basic way to distinguish between the two geometries. I'm sure the calculations involved to obtain these diagrams would be really complicated but would make more sense in some cases if you're looking for the actual reasons behind why some complexes are square planar while others are tetrahedral.  

<strong>EDIT:</strong>  

Predicting the structure of a complex depends on how much info you're given. If you only have the number of ligands in the complex or the molecular formula of the complex, then you can predict the structure based on this list <a href="http://en.wikipedia.org/wiki/Coordination_complex#Geometry" rel="noreferrer">here</a>.  

Then again, steric factors and electronic factors are also important in determining the structure and your prediction would be more accurate if you know what ligand(s) you're dealing with (for steric effects) and the electronic configuration and oxidation state of the central metal ion.   

I don't know much about how exactly these factors influence the structure but in general, you only have to be worried about these if:  

<ol>
<li>the ligands are bulky or have some other special features</li>
<li>certain special electronic configurations (I've read something about certain electronic configurations causing distortions in the structure especially in copper(II) complexes)</li>
</ol>

#### Answer 2 (score 8)
There are all sorts of approximations available, but the short of it is that in general one cannot predict square planar vs tetrahedral without either doing experiments or doing some very detailed calculations.  

Put another way, ligand field theories and the like are after the fact justifications of observations rather than predictions of observations.  

#### Answer 3 (score 4)
<p>Our teacher told us this trick to tell if complex is going to be square planar.<br>
We are considering the fact that the coordination no. is 4.    </p>

If the metal has a $\ce{d^7}$, $\ce{d^8}$ or $\ce{d^9}$ configuration along with a <strong>strong field ligand</strong> or $\ce{d^4}$ with <strong>weak field ligand</strong> then complex will be square planar otherwise tetrahedral.    

One exception i have come across for this is $\ce{[PtCl4]^2-}$ which is a square planar. You can read the explanation for it <a href="https://answers.yahoo.com/question/index?qid=20080308120955AAjfZWx" rel="nofollow">here</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Why does carbon monoxide have a greater affinity for hemoglobin than oxygen? (score [86275](https://stackoverflow.com/q/33780) in 2016)

#### Question
Hemoglobin is an iron-containing oxygen transport metalloprotein in the red blood cells of most mammals. Simply put, it's a carrier protein. Interestingly it doesn't carry carbon dioxide in the same way it does for oxygen $\ce{O2}$. Oxygen binds to the iron atoms in the protein whereas carbon dioxide $\ce{CO2}$ is bound to the protein chains of the structure. Carbon dioxide doesn't compete with oxygen in this binding process.   

However, carbon monoxide $\ce{CO}$ is a very aggressive molecule. It's a colourless, odourless, and tasteless gas that is lighter than air and can be fatal to life. It has a greater affinity for hemoglobin than oxygen does. It displaces oxygen and quickly binds, so very little oxygen is transported through the body cells.  

There are two equilibrium reactions of binding oxygen and becoming oxygenated hemoglobin:  

$$\ce{Hb (aq) + 4O2 (g) -&gt; Hb(O2)4 (aq)}$$  

$$\ce{Hb (aq) + 4O2 (g) &lt;- Hb(O2)4 (aq)}$$  

And carbon monoxide binding equation at equilibrium:  

$$\ce{Hb (aq) + 4CO (g) ⇌ Hb(CO)4 (aq)}$$  

<p><a href="https://books.google.com.sg/books?id=XOL6mgnGOHoC&amp;pg=PA22&amp;lpg=PA22&amp;dq=why+carboxyhemoglobin+bond+is+stronger&amp;source=bl&amp;ots=1xabW6LWuh&amp;sig=wG57G9h3bCI5THVb_ITsAJ07VYk&amp;hl=en&amp;sa=X&amp;ei=lZeeVffEEcyvuQTgv7eQDA&amp;ved=0CEwQ6AEwCA#v=onepage&amp;q&amp;f=false" rel="noreferrer">It is said</a>
 the equation is shifted towards right, generating $\ce{Hb(CO)4(aq)}$, since its bond is much stronger.</p>

I have two main related questions:  

<ol>
<li><p>Why is the carboxyhemoglobin bond stronger relative to that of oxygenated hemoglobin?</p></li>
<li><p>Why is carbon monoxide highly attracted to hemoglobin?</p></li>
</ol>

Does it have anything to do with the oxidation state of oxygen in each molecule? Please show some reaction equations associating $\ce{Fe}$.  

#### Answer accepted (score 22)
<h5>Excursion into simple coordination chemistry: Bonding, backbonding and simple orbital schemes</h1>

Please refer to <a href="https://chemistry.stackexchange.com/a/33782">Breaking Bioinformatic’s answer</a> for the MO scheme of carbon monoxide, it is very helpful. You might also look at the orbital pictures in <a href="https://chemistry.stackexchange.com/a/31003">this answer by Martin</a>. Carbon monoxide can bind to metal centres <em>via</em> a &#x3c3; coordinative bond where the HOMO of <span class="math-container">$\ce{CO}$</span> interacts with metal orbitals and also by the &#x3c0; backbonding, Breaking Bioinformatics mentioned. I’ll start by touching the &#x3c3; bond so we can later better understand the &#x3c0; bond. In figure 1 you can see the molecular orbital scheme of a complex composed of a central metal ion and six ligands that donate in a &#x3c3; manner exclusively.  

<p><img src="https://i.stack.imgur.com/GKvJQ.png"><br>
<strong>Figure 1:</strong> Molecular orbital scheme of an octahedral complex with six &#x3c3; donors around a central metal. Copied from <a href="http://www.cup.lmu.de/ac/kluefers/homepage/L_kc.html" rel="nofollow noreferrer">this site</a> and first used in <a href="https://chemistry.stackexchange.com/a/38229">this answer of mine</a>. Metal orbitals are 3d, 4s, 4p from bottom to top; ligand orbitals are of s-type.</p>

You will notice that figure 1 contains the irreducible representations of the orbitals beneath them. Orbitals can only interact if they have identical irreducible representations; otherwise, their interactions will sum up to zero. We can see that the metal d orbitals are split up into a <span class="math-container">$\mathrm{t_{2g}}$</span> set and and <span class="math-container">$\mathrm{e_g}^*$</span> set. This is the effect of &#x3c3; bonding and why it stabilises the entire entity.  

&#x3c0; bonding can only occur if the ligands have available orbitals of &#x3c0; symmetry. The 2&#x3c0; orbitals of <span class="math-container">$\ce{CO}$</span> are a nice example, but one could also simply assume a halide with its p-orbitals for the same effect. Further down in the <a href="http://www.cup.lmu.de/ac/kluefers/homepage/L_kc.html" rel="nofollow noreferrer">internet scriptum I originally copied the picture from</a>, you can see a set of two pictures that introduce p-orbitals. Twelve ligand p-type orbitals will transform as <span class="math-container">$\mathrm{t_{1g} + t_{1u} + t_{2g} + t_{2u}}$</span>, thus a further stabilising/destabilising interaction is introduced for the <span class="math-container">$\mathrm{t_{2g}}$</span> orbitals. Due to the <span class="math-container">$2\\unicode[Times]{x3c0}^*(\ce{CO})$</span> orbitals being similar in energy to the metal’s <span class="math-container">$\mathrm{t_{2g}}$</span> <em>and</em> empty, they can stabilise the former well, creating a possibly strong stabilisation for the overall system. Since this is an interaction of two orbitals creating both bonding and antibonding orbitals, and since the resulting molecular orbital is filled with two electrons <em>that stem from the metal centre</em> this is termed &#x3c0;-backbonding.  

<h5>The binding mode of carbon monoxide to haemoglobin</h1>

After this extensive background discussion, it may be clear that <span class="math-container">$\ce{CO}$</span> is generally a good ligand. For reasons I didn’t go into, a carbonyl complex of metal <em>ions</em> isn’t that stable, but a single carbonyl ligand will almost always be beneficial. Such is the case for the porphyrin-iron(II) system that forms the heart of haemoglobin: The central iron(II) ion is coordinated well from five directions (four from the porphyrin ring and one histidine of haemoglobin) and has a weakly bound water atom in the ground state in its sixth coordination slot, sometimes displaced by a distal histidine. Carbon monoxide can diffuse in and bind very well to this system, displacing the weakly bound water and histidine. In fact, isolated haem can bind carbon monoxide <span class="math-container">$10^5$</span> times better that it can oxygen.  

This is something that nature could not really inhibit, because it is based on fundamental properties, but also something nature didn’t really care for, because the natural concentration of carbon monoxide is very low, and nature rarely had to deal with it competitively inhibiting oxygen binding to haemoglobin.  

<h5>The binding mode of oxygen to haemoglobin</h1>

Oxygen, the <span class="math-container">$\ce{O2}$</span> molecule, is an absolutely lowsy &#x3c3; donor — especially when compared to <span class="math-container">$\ce{CO}$</span>. Its molecular orbital scheme is generally that of carbon monoxide except that it is entirely symmetric and two more electrons are included: They populate the 2&#x3c0; orbitals to give a triplet ground state. These orbitals are now the HOMOs and they hardly extend into space in any meaningful way — plus the still existant lone pair on each oxygen atoms is now at a much lower energy and also does not extend into space and thus cannot bind to a metal centre in a &#x3c3; manner.  

What happens here is rather complex, and the last lecture I heard on the topic basically said that final conclusive evidence has not yet been provided. Orthocresol discusses the different viewpoints in detail in <a href="https://chemistry.stackexchange.com/q/79083">this question</a>. The diamagnetic properties of the resulting complex are, however, unquestioned and thus one must assume a singlet ground state or one where antiferromagnetic coupling cancels any spins at molecular levels. Since the ground state of haemoglobin has a high-spin iron(II) centre and the ground state of oxygen is a paramagnetic triplet, it makes sense to assume those two to be the initial competitors.  

<a href="http://www.cup.lmu.de/ac/kluefers/homepage/L_bac.html" rel="nofollow noreferrer">Professor Klüfers</a> now states the steps to be the following:  

<blockquote>
  <ol>
  <li><p>Iron(II) is in a high-spin state with four unpaired electrons;</p></li>
  <li><p>Paramagnetic triplet oxygen approaches and one of its <span class="math-container">$\\unicode[Times]{x3c0}^*$</span> orbitals coordinates to the iron(II) centre in a &#x3c3; fashion.</p></li>
  <li><p>This induces a high-spin low-spin transition on iron and slightly reorganises the ligand sphere (pulling oxygen closer to the iron centre). We now have a low-spin singlet iron(II) centre and a coordinative &#x3c3; half-bond from oxygen. We can attribute that electron to the iron centre.</p></li>
  <li><p>Through linear combination, we can adjust the spin-carrying &#x3c3; orbital and the populated iron orbitals so that an orbital is generated which can interact with the <em>other</em> <span class="math-container">$\\unicode[Times]{x3c0}^*$</span> of oxygen in a &#x3c0; fashion.</p></li>
  <li><p>We thus expect an antiferromagnetic coupling and an overall state that can be described best as <span class="math-container">$\ce{Fe^{III}-^2O2^{.-}}$</span> — a formal one-electron oxidation of iron to iron(III), reducing oxygen to superoxide (<span class="math-container">$\ce{O2-}$</span>).</p></li>
  <li><p>If the spin-carrying orbitals are <em>all</em> treated as being metal-centred, we gain a <span class="math-container">$\ce{Fe^{II}-^1O2}$</span> state.</p></li>
  </ol>
</blockquote>

(Content in the link I quoted from are in German; translation mine and shortened from the original.)  

Only due to the complexly tuned ligand sphere and also due to the stabilising high-spin low-spin transition (plus reorganising) is oxygen able to bind to iron <em>at all.</em> The distal histidine further stabilises the complex by a hydrogen bond, alleviating the charge slightly. It is to be assumed that nature did a great deal of tuning throughout the evolution since the entire process is rather complex and well-adjusted for collecting oxygen where it is plentiful (in the lungs) and liberating it in tissue where it is scarce.  

<h5>Comparison of the oxygen and carbon monoxide binding modes</h1>

The simpler picture I drew above for carbon monoxide is not correct. Inside haemoglobin, carbon monoxide <em>also</em> binds in an angular fashion as if it were oxygen — see <a href="https://chemistry.stackexchange.com/a/34383">bonCodigo’s answer</a> for space-filling atom models. This is because the entire binding pocket is made to allow oxygen to bind (as I stated) thus attempting everything to make oxygen a comfortable home. Carbon monoxide is rather strained in there, its binding affinity is reduced by a factor of <span class="math-container">$1000$</span>. However, since we started with a binding affinity difference of <span class="math-container">$10^5$</span>, <strong>carbon monoxide can still bind <span class="math-container">$100$</span> times better than oxygen can.</strong>  

<h5>Summary</h1>

<ul>
<li><p>Carbon monoxide is generally a good ligand that can bind to metal centres well.</p></li>
<li><p>Oxygen is generally a poor ligand.</p></li>
<li><p>Nature did everything to make oxygen a comfortable home in haemoglobin.</p></li>
<li><p>In doing so, the binding pocket became <em>substantially</em> less comfortable for <span class="math-container">$\ce{CO}$</span>.</p></li>
<li><p>But since carbon monoxide was so good and oxygen so poor to start with, the former still binds better than the latter.</p></li>
<li><p>Nature didn’t really care, because individuals seldomly come in contact with carbon monoxide so the collateral damage was taken into account.</p></li>
</ul>

#### Answer 2 (score 16)
The answer has to do with <a href="https://en.wikipedia.org/wiki/Pi_backbonding" rel="noreferrer">pi-backbonding</a>.   

In essence, the CO molecule has a negative formal charge on the carbon (it's neutral because of the oxygen having a positive formal charge). However, C is quite electropositive, and would like to relieve the stress caused by the negative formal charge. To relieve the stress caused by the negative charge, the CO molecule will want to bond to the iron.   

How it does this is related to CO's molecular orbitals, which look like:  

<img src="https://i.stack.imgur.com/HzGfp.png" alt="CO MO Diagram">  

Note that the 4, 5, and 6 sigma orbitals, as well as the 2 pi orbital, are all antibonding. I will denote them with * from now on.  

As CO stands right now, it has a bond order of three (the two lower sigmas cancel each other out, since 4* is antibonding while 3 is bonding). None of its orbitals, as they stand, can participate in bonding.  

However, because carbon wants to rid itself of the negative charge, CO will do an interesting trick. It will promote an electron from the 5 sigma orbital into 2* pi. This reduces the bond order of CO from three to two, and introduces a separation of an electron pair. The picture of the 2* pi orbital is shown here, on the top:  

<img src="https://i.stack.imgur.com/qMncn.gif" alt="pi star orbital">  

So how is this more stable? In isolation, it is not. However, remember, we are not operating in isolation: there's an iron nearby. Most saliently, the iron has a d orbital, which looks like:  

<img src="https://i.stack.imgur.com/1esYd.jpg" alt="d orbital">  

Now, the iron can put an electron into this d orbital and bond it with the pi* star orbital on the CO on the carbon end. This is hugely stable (note that we were willing to promote an electron into an unoccupied orbital and break up an electron pair to do it), especially since it relieves charge stress to do it (as opposed to molecular oxygen, which does no such thing). This backbonding is also why cyanide will stable itself onto iron.  

Why isn't hemoglobin designed to bind oxygen as strongly as possible, then? Surely it would seem this would be an advantage, evolutionarily, if oxygen could bind tightly and never let go? But oxygen <em>needs</em> to let go: hemoglobin is a transport protein, and it needs to release oxygen into the tissues. That's why you have plenty of things that bond hemes more tightly than molecular oxygen: we need $\ce{O_2}$ in our tissues, not locked into hemoglobin forever.  

EDIT: The hybridization of the iron in the protein is often (but incorrectly) assigned as $\ce{sp^3d^2}$. This is implied by the octahedral geometry the ligands around the iron take: the heme consists of an iron bound in four coordination sites by a porphyrin ring, one site by a histidine, and the last site by the oxygen the iron needs to bind.  

The formula:  

$\ce{Fe(II) + CO -&gt; Fe(III)CO}$                   

#### Answer 3 (score 10)
<p>I appreciate above answer by BreakingBioinformatics. However I have been looking for the oxidation reactions involving Fe in this case. <a href="http://chemwiki.ucdavis.edu/?title=Textbook_Maps/General_Chemistry_Textbook_Maps/Map:_Averill_%26_Eldredge_%22Chemistry%22/23:_The_d-Block_Elements/23.6:_Transition_Metals_in_Biology" rel="noreferrer">Found some useful material here.</a> It is based on the textbook, Chemistry: Principles, Patterns, and Applications, 2007, Bruce Averill, Patricia
Eldredge. </p>

<p><strong>Note : Following picture only shows the binding of Myoglobin.</strong> 
<a href="https://i.stack.imgur.com/YEvNi.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/YEvNi.jpg" alt="enter image description here"></a></p>

Here's the text which explains some relevant and interesting details about the affinity of O2 and CO, although the main focus of the text is on <strong>primary function of the distal histidine in preventing self-poisoning of CO</strong>.  

<blockquote>
  <p>Oxygen is not unique in its ability to bind to a ferrous heme complex;
  small molecules such as CO and NO bind to deoxymyoglobin even more
  tightly than does O2. The interaction of the heme iron with oxygen and
  other diatomic molecules involves the transfer of electron density
  from the filled t2g orbitals of the low-spin d6 Fe2+ ion to the empty
  π* orbitals of the ligand. In the case of the Fe2+–O2 interaction, the
  transfer of electron density is so great that the Fe–O2 unit can be
  described as containing low-spin Fe3+ (d5) and O2−. We can therefore
  represent the binding of O2 to deoxyhemoglobin and its release as a
  reversible redox reaction:</p>
  
  $\ce{Fe^{2+} + O2 ⇌ Fe^{3+} – O^{2−}}$ (26.8.2)   
  
  <p>As shown in Figure 26.8.4 (the figure is not loading), the Fe–O2 unit is
  bent, with an Fe–O–O angle of about 130°. Because the π* orbitals in
  CO are empty and those in NO are singly occupied, these ligands
  interact more strongly with Fe2+ than does O2, in which the π*
  orbitals of the neutral ligand are doubly occupied.</p>
  
  Although CO has a much greater affinity for a ferrous heme than does O2 (by a factor of about 25,000), the affinity of CO for deoxyhemoglobin is only about 200 times greater than that of O2, which suggests that something in the protein is decreasing its affinity for CO by a factor of about 100. Both CO and NO bind to ferrous hemes in a linear fashion, with an Fe–C(N)–O angle of about 180°, and the difference in the preferred geometry of O2 and CO provides a plausible explanation for the difference in affinities. As shown in Figure 26.8.4 "Binding of O", the imidazole group of the distal histidine is located precisely where the oxygen atom of bound CO would be if the Fe–C–O unit were linear. Consequently, CO cannot bind to the heme in a linear fashion; instead, it is forced to bind in a bent mode that is similar to the preferred structure for the Fe–O2 unit. This results in a significant decrease in the affinity of the heme for CO, while leaving the O2 affinity unchanged, which is important because carbon monoxide is produced continuously in the body by degradation of the porphyrin ligand (even in nonsmokers). Under normal conditions, CO occupies approximately 1% of the heme sites in hemoglobin and myoglobin. If the affinity of hemoglobin and myoglobin for CO were 100 times greater (due to the absence of the distal histidine), essentially 100% of the heme sites would be occupied by CO, and no oxygen could be transported to the tissues. Severe carbon-monoxide poisoning, which is frequently fatal, has exactly the same effect. Thus the primary function of the distal histidine appears to be to decrease the CO affinity of hemoglobin and myoglobin to avoid self-poisoning by CO.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Why does the melting point get lower going down the Alkali Metal Group with increase in atomic number? (score [85583](https://stackoverflow.com/q/4554) in 2013)

#### Question
Why does the melting point get lower  going down the Alkali Metal Group with increase in atomic number?  

#### Answer accepted (score 13)
You have to understand that melting point is related to the bonds in a metal between the metal cation and the 'sea of electrons'. With an increase in atomic number, you have an increase in electron shells.   

As the radius of atoms get larger down the group, you could say that the force holding them together is spread over the greater area and hence, the metal cations are more weakly bonded. And coming back to my first point, when the bonding is weaker, the metal's melting point will decrease.  

#### Answer 2 (score 8)
As you go down any group, there are extra electron shells (for example Lithium has 2 shells, Francium has 7) which cause electron shielding. Because the force of attraction must extend further and through these shells to the outermost shell, the force becomes less so there is less strong bonding occuring.  

Thus, it is easier to break these less strong bonds, and because the melting point is a measure of the point at which all the bonds holding a metallic structure together are broken, it will decrease because this point is reached a lot sooner as the bonds are not as strong.  

#### Answer 3 (score 4)
melting points of all group (i) elements is dependent on the strength of the metallic bond. In metallic bonding, the group (i) cations in the metallic lattice are attracted to the delocalised electrons. Down the group, the number of delocalised electrons and the charge on each cation remains the same at +1 but the cationic radius increases so the attraction between the cations and the electrons in the lattice get weaker down the group and so does the strength of the metallic bond  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: What is the balanced equation for the reaction of potassium permanganate, iron sulfate, and sulfuric acid? (score [85326](https://stackoverflow.com/q/37142) in 2018)

#### Question
<p>I'm trying to balance the following redox equation. I think this is happening in acidic solution, the textbook doesn't specify anything more. Can you please help me understand if I got the half reactions correct?
<span class="math-container">$$\ce{KMnO4 + FeSO4 + H2SO4 -&gt; K2SO4 + MnSO4 + Fe2(SO4)3 + H2O}$$</span></p>

<p>I found out that manganese is reduced as the oxidation number goes from <span class="math-container">$+7$</span> to <span class="math-container">$+2$</span> and iron gets oxidized as the oxidation number goes from <span class="math-container">$+2$</span> to <span class="math-container">$+3$</span>.
I wrote the two half reactions, \eqref{Q:red} for the reduction and \eqref{Q:ox} for the oxidation. <em>Did I get them right?</em></p>

<p><span class="math-container">\begin{align}
\tag{A}\label{Q:red}\ce{KMnO4 + H2SO4 &amp;-&gt; K2SO4 + MnSO4}\\
\tag{B}\label{Q:ox}\ce{FeSO4 &amp;-&gt; Fe2(SO4)3}\\
\end{align}</span></p>

I started working on the reduction half-equation and this is what I came up with after balancing <em>atoms</em> and <em>charge</em>:  

<span class="math-container">$$\ce{10 e- + 10 H+ + 2 KMnO4 + 3 H2SO4 -&gt; K2SO4 + 2 MnSO4 + 8 H2O}$$</span>  

Now comes the trouble. How do I balance iron and sulfur in the oxidation half-reaction \eqref{Q:ox}?  

#### Answer accepted (score 3)
<p>Your first half reaction, for the reduction, is correct:
<span class="math-container">$$\ce{10 e- + 10 H+ + 2 KMnO4 + 3 H2SO4 -&gt; K2SO4 + 2 MnSO4 + 8 H2O}\tag1\label{red}$$</span></p>

<p>For the second half reaction, the oxidation, start by balancing iron:
<span class="math-container">\begin{align}
\ce{FeSO4 &amp;-&gt; Fe2(SO4)3 }\tag{2a}\\
\ce{2 FeSO4 &amp;-&gt; Fe2(SO4)3 }\tag{2b}
\end{align}</span></p>

<p>Add <span class="math-container">$\ce{H2SO4}$</span> on the left so you can balance sulfur:
<span class="math-container">\begin{align}
\ce{2 FeSO4 &amp;-&gt; Fe2(SO4)3 }\tag{2c}\\
\ce{H2SO4 + 2 FeSO4 &amp;-&gt; Fe2(SO4)3 }\tag{2d}
\end{align}</span></p>

<p>Now balance the protons and electrons:
<span class="math-container">\begin{align}
\ce{H2SO4 + 2 FeSO4 &amp;-&gt; Fe2(SO4)3 }\tag{2d}\\
\ce{H2SO4 + 2 FeSO4 &amp;-&gt; Fe2(SO4)3 + 2 H+ + 2 e-}\tag{2e}\label{ox}\\
\end{align}</span></p>

<p>Now add \eqref{red} and five times \eqref{ox} so that the electrons are equal on every side and coincidentally the protons also balance:
<span class="math-container">\begin{align}
\ce{10 e- + 10 H+ + 2 KMnO4 + 3 H2SO4 &amp;-&gt; K2SO4 + 2 MnSO4 + 8 H2O}\tag1\\
\ce{5 H2SO4 + 10 FeSO4 &amp;-&gt; 5 Fe2(SO4)3 + 10 H+ + 10 e-}\tag{$5\times$2e}
\end{align}</span></p>

<p>And the final result is:
<span class="math-container">\begin{align}
\ce{2 KMnO4 + 8 H2SO4 + 10 FeSO4 &amp;-&gt; K2SO4 + 2 MnSO4 + 8 H2O + 5 Fe2(SO4)3}\tag3
\end{align}</span></p>

#### Answer 2 (score 0)
Yes you are correct saying that manganese gets reduced from <span class="math-container">$+7$</span> to <span class="math-container">$+2$</span> and iron gets oxidised from <span class="math-container">$+2$</span> to <span class="math-container">$+3$</span>.   

However, if I were you, since they already gave you the complete redox equation, &ndash; it is just unbalanced &ndash;, I wouldn't bother with writing the half equations. I would just focus on balancing the equation that they have already given you.  

Here is a guide for balancing most redox equations:  

<ol>
<li>Balance all the elements in the equation except for oxygen and hydrogen. For polyatomic ions that are spectator ions, just think as them as one big element.</li>
<li>Check if oxygen is balanced. If it isnt, add water to the side which is missing oxygen.</li>
<li>Check if hydrogen is balanced. If it isn't, add protons <span class="math-container">$(\ce{H+})$</span> to the side with doesn't have enough hydrogen.</li>
<li>Now that all the elements have been balanced, make sure that the charges are balanced, too. If they are not, add electrons to the side which is more positive.</li>
<li>Check your equation now to make sure that everything is balanced correctly.</li>
<li>When you have balanced both half-reactions, add them so that electrons cancel on each side.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Does water really 'go bad' after a couple of days? (score [84948](https://stackoverflow.com/q/9395) in 2016)

#### Question
<p>Among my friends it is a sort of 'common wisdom' that you should throw away water after a couple of days if it was taken from the tap and stored in a bottle outside the fridge, because it has 'gone bad'.
First of all, the couple of days is not very well defined, which already makes me a bit suspicious. Second, I cannot think of anything in tap water that would make the water undrinkable after a couple of days already.</p>

Can someone clarify this issue for me? Does tap water really 'go bad' after a couple of days outside the fridge? Why?   

#### Answer accepted (score 45)
<p>First of all, it depends on how the tap water was treated before it was piped to your house. In most cases, the water was chlorinated to remove microorganisms. By the time the water arrives at your house, there is very little (if any) chlorine left in the water. When you fill you container, there is likely to be some microorganisms present (either in the container or in the water).
In a nutrient rich environment, you can see colonies within 3 days. For tap water, it will probably take 2 to 3 weeks. But that doesn't mean that the small amount of growth doesn't produce bad tasting compounds (acetic acid, urea, etc.).</p>

BTW Nicolau Saker Neto, cold water dissolves more gas than hot water. Watch when you heat water on your stove. Before it boils, you will see gas bubbles that form on the bottom and go to the surface (dissolved gases) and bubbles that disappear while rising to the surface (water vapor).  

#### Answer 2 (score 37)
<blockquote>
  I cannot think of anything in tap water that would make the water undrinkable after a couple of days already.  
</blockquote>

Tagging the question with <a href="/questions/tagged/biochemistry" class="post-tag" title="show questions tagged &#39;biochemistry&#39;" rel="tag">biochemistry</a> probably points in the right direction. The only effect I can think about is growth of anaerobic microbes, e.g. <em>Escherichia coli</em>, causing diarrhea.  

<p><hr>
There's good chance to keep the water from 'going bad' and even 'turn it good' again when keeping the water in PET bottles in the sunlight, letting <a href="http://www.cdc.gov/safewater/solardisinfection.html">SODIS</a> (solar disinfection) work for you.</p>

#### Answer 3 (score 12)
A few lazy weeks of summer cottages, camping far from the beaten track or boat excursions in the archipelago: When summer comes, we seek to be closer to nature. Sometimes that means we may waive some of everyday life's certainties, like drinking water straight from the tap.  

Do this!  

Fill the drinking water of good quality, such as municipal drinking water in sterilized bottles or cans. Keep the water dark and as cool as possible. That keeps drinking water fresh for at least one week.  

<h5>Smell and Taste</h2>

<ul>
<li>Putting a limit on how long drinking water can be stored has more flavoring to it than health risks, says Torbjörn Lindberg, State inspector at NFA.</li>
<li>The risk of getting sick of water is small in Sweden. But you should of course do not drink water that tastes or smells bad, is turbid or highly colored.</li>
</ul>

<h5>Get microorganisms in drinking water</h2>

Good drinking water does not contain pathogenic microorganisms, such as viruses and bacteria. It is also a nutrient-poor environment that makes it difficult for such microorganisms to survive. They are simply ill-suited to the aquatic environment. If they are there from the beginning, it is therefore likely that they will disappear over time, and the risk of getting sick is reduced.  

<h5>Drinking water can be bad</h2>

Sometimes, bacteria, micro-sponges and algae that are adapted to the aquatic environment are found in the drinking water from the start. They can also multiply over time. It is completely natural and gives no health risks. However, drinking water can start to smell or taste badly, especially if kept long and hot, for instance in the sun. It can also be colored and can form a slimy layer on the inside of the container.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Why do the melting and boiling points of the noble gases increase when the atomic number increases? (score [84858](https://stackoverflow.com/q/10106) in 2016)

#### Question
What causes the melting and boiling points of noble gases to rise when the atomic number increases? What role do the valence electrons play in this?  

#### Answer accepted (score 19)
The melting and boiling points of noble gases are very low in comparison to those of other substances of comparable atomic and molecular masses. This indicates that only weak van der Waals forces or weak London dispersion forces are present between the atoms of the noble gases in the liquid or the solid state.    

The van der Waals force increases with the increase in the size of the atom, and therefore, in general, the boiling and melting points increase from $\ce{He}$ to $\ce{Rn}$.     

Helium boils at $-269\ \mathrm{^\circ C}$. Argon has larger mass than helium and have larger dispersion forces. Because of larger size the outer electrons are less tightly held in the larger atoms so that instantaneous dipoles are more easily induced resulting in greater interaction between argon atoms. Therefore, its boiling point ($-186\ \mathrm{^\circ C}$) is more than that of $\ce{He}$.    

Similarly, because of increased dispersion forces, the boiling and melting points of monoatomic noble gases increase from helium to radon.  

<img src="https://i.stack.imgur.com/k61Jv.gif" alt="enter image description here">    

<hr>

For more data of melting and boiling points of noble gas <em>compounds</em>, read this <a href="http://books.google.co.in/books?id=6OcDAAAAMBAJ&amp;pg=PA340&amp;dq=melting+and+boiling+points+of+noble+gas+compounds&amp;hl=en&amp;sa=X&amp;ei=CuZTU5HoHcePrQe8loHwBA&amp;ved=0CC0Q6AEwAA#v=onepage&amp;q=melting%20and%20boiling%20points%20of%20noble%20gas%20compounds&amp;f=false" rel="noreferrer">page</a>  

#### Answer 2 (score 8)
Other answers have mentioned <em>that</em> dispersion forces are the key to answering the question but not <em>how</em> they increase from helium to radon (or let’s take xenon because that’s not radioactive so I feel safer breathing it).  

The larger the mass of a nucleus the more protons are in there, and the more protons in a nucleus the more electrons are around the outside. Traditionally, one thought of electrons orbiting the nucleus rather like satellites orbiting a planet on more or less fixed orbits at certain heights. But that picture is wrong. It is much better to consider electrons as waves that completely surround the nucleus. If one were to translate these waves into particles (because of the wave-particle dualism at quantum levels), all one would get would be probabilities of finding specific electron $e$ at specific location $x$.  

For a neutral atom that is surrounded by nothing, these probabilities depend only on the wave function, and are inherently centrosymmetric or anticentrosymmetric, leading to a net charge distribution of zero. In a sample of xenon gas, however, other atoms approach the atom we are observing. Consider an atom approaching our xenon atom at from ‘above’ (i.e. perpendicular to our viewpoint). While the atom as a whole is neutral, the could of electrons surrounding the nucleus is negatively charged. This new negative charge changes the potential energy the electrons in our observed atom are perceiving: While we originally had a centrosymmetric potential distribution (decreasing positive charge intensity from the nucleus) we now have a second negative source at 12 o’clock. Therefore, the probability distributions will shift ever so slightly and it will be slightly more likely to detect our electron $e$ at position $y$ below the nucleus rather than at position $z$ above the nucleus. <strong>Note that this simplification relies on the freezing of time at a certain moment when the other atom is approaching and a certain controlled environment that I have invented for example purposes.</strong>  

With the electrons now more likely to be at $y$ rather than $z$, we can say that we have created a <em>spontaneous</em> or an <em>induced dipole.</em>  A mild positive charge is now pointing towards the other atom and ever so slightly attracting it. This will, if you advance the time flow by one spec, create another induced dipole in the originally approaching atom plus further in every other atom that is close around. We cannot freeze this picture though. Every infinitesimal change in position, movement direction or rotation will change the entire picture, meaning that our induced dipole is extremely short-lived.  

It is only the combination of all these induced dipoles and their slight attraction that attracks the different atoms together. Since they rely on electron distribution changing, the more electrons we have the stronger these induced dipoles can be and the more force can be excersized between atoms. Since the number of electrons loosely correlates with mass (and strictly correlates with nuclear charge), larger atoms are said to display stronger van der Waals forces than smaller ones.  

#### Answer 3 (score 7)
As mentioned in other answers the dispersion force is responsible for noble gases forming liquids. The calculation of the boiling points is now outlined after some general comments about the dispersion force.  

The dispersion force (also called London, charge-fluctuation, induced-dipole-induced-dipole force) is universal, just like gravity, as it acts between all atoms and molecules.  The dipole forces can be long-range, >10 nm down to approx 0.2 nm depending on circumstances, and can be attractive or repulsive.  

Although the dispersion force is quantum mechanical in origin it can be understood as follows: for a non-polar atom such as argon the time average dipole is zero, yet at any instance there is a finite dipole given by the instantaneous positions of the electrons relative to the nucleus. This instantaneous dipole generates an electric field that can polarise another nearly atom and so induce a dipole in it. The resulting interaction between these two dipoles gives rise to an instantaneous attractive force between the two atoms, whose time average in not zero.  

The dispersion energy was derived by London in 1930 using quantum mechanical perturbation theory. The result is  

$$U(r)=-\frac{3}{2}\frac{\alpha_0^2I}{(4\pi\epsilon _0)^2r^6}=-\frac{C_{\mathrm{disp}}}{r^6}$$  

where $\alpha_0$ is the electronic polarisability, $I$ the first ionisation energy, $\epsilon_0$ the permittivity of free space and $r$ the separation of the atoms. The electronic polarisability $\alpha_0$ arises from the displacement of an atom's electrons relative to the nucleus and it is the constant of proportionality between the induced dipole and the electric field $E$, viz., $\mu_{\mathrm{ind}} = \alpha_0 E$. The polarisability has units of $\pu{J-1 C2 m2}$, which means that in SI units $\alpha_0/(4\pi\epsilon_0)$ has units of $\pu{m3}$ and this polarisability is in effect a measure of electronic volume, or put another way $\alpha_0 = 4\pi\epsilon_0r_0^3$ where experimentally it is found that $r_0$ is approximately the atomic radii. The ionisation energy $I$ arises because to estimate $r_0$ a simple model of an atom is used to calculate the orbital energy and hence radius and in doing so the energy is equated to the ionisation energy since this can be measured.  

As can be seen from the formula the energy depends on the product of the square of the polarisability, i.e. volume of molecule or atom and its ionisation energy, and also on the reciprocal of the sixth power of the separation of the molecules/atoms. In a liquid of noble gases this separation may be taken to be the atomic radius, $r_0$. Thus the dependence is much more complex than just size, see table of values below. The increase in polarisability as the atomic number increases, is offset somewhat by the reduction in ionisation energy and increase in atomic radius.   

If experimental values are put into the London equation then the attractive energy can be calculated. In addition the boiling point can be estimated by equating the London energy with the average thermal energy as $U(r_0)=3k_\mathrm{B}T/2$ where $k_\mathrm B$ is the Boltzmann constant and $T$ the temperature. The relevant parameters are given in the table below, with values in parentheses being experimental values:<sup>[1]</sup>  

<p>$$\begin{array}{c|c|c|c|c|c}
\text{Noble gas} &amp; (\alpha_0/4\pi\epsilon_0)~/~\pu{10^{-30}m^3} &amp; I~/~\pu{eV} &amp; r_0~/~\pu{nm} &amp; C_\mathrm{disp}~/~\pu{10^{-70} J m6} &amp; T_\mathrm{b}~/~\pu{K} \\
\hline
\ce{Ne} &amp; 0.39 &amp; 21.6 &amp; 0.308 &amp; 3.9~(3.8) &amp; 22~(27) \\
\ce{Ar} &amp; 1.63 &amp; 15.8 &amp; 0.376 &amp; 50~(45) &amp; 85~(87) \\
\ce{Xe} &amp; 4.01 &amp; 12.1 &amp; 0.432 &amp; 233~(225) &amp; 173~(165)
\end{array}$$</p>

The fit to data is very good, possibly this is fortuitous, but these are spherical atoms showing only dispersion forces and a good correlation to experiment is expected. However, there short range repulsive forces that are ignored as well as higher order attractive forces. Nevertheless it does demonstrate that dispersion forces can account for the trend in boiling quite successfully.  

<hr>

<ol>
<li>Israelachvili, J. N. <em>Intermolecular and Surface Forces,</em> 3rd ed.; Academic Press: Burlington, MA, 2011; p 110.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: Reaction between NaOH and CO2 (score [84091](https://stackoverflow.com/q/57288) in 2017)

#### Question
So I wanted to know what the reaction between sodium hydroxide and carbon dioxide can be, and upon research I got 2 answers. The first one is  

$$\ce{CO2 + NaOH(aq) -&gt; NaHCO3(aq)}$$  

and the second one is a two-step reaction, first with water then sodium hydroxide:  

<p>$$\ce{CO2 + H2O(l) -&gt; H2CO3(aq)}, \\           
\ce{H2CO3(aq) + NaOH(aq) -&gt; NaHCO3(aq) + H2O(l)}$$</p>

So my question is which one of these answers is right?  

To me, I do not understand why the 2nd option takes into account water because really concentrated $\ce{NaOH}$ would/should be written just as $\ce{NaOH}$, which to me makes the 1st option the right one. Am I wrong?  

#### Answer accepted (score 4)
No both are right.  

If you add the latter equations, then you will get the former.  

If sodium hydroxide solution was highly concentrated like you said, then both equations are wrong since sodium hydroxide solution will strip away the second hydronium as well forming carbonates.  

All state notations with (aq) implies that it is dissolved in water. If it was pure NaOH, it would be in a solid state under room temperatures. It is also noteworthy to know that NaOH must be contained in a dry environment as it will spontaneously absorb water from the air.  

#### Answer 2 (score 4)
No both are right.  

If you add the latter equations, then you will get the former.  

If sodium hydroxide solution was highly concentrated like you said, then both equations are wrong since sodium hydroxide solution will strip away the second hydronium as well forming carbonates.  

All state notations with (aq) implies that it is dissolved in water. If it was pure NaOH, it would be in a solid state under room temperatures. It is also noteworthy to know that NaOH must be contained in a dry environment as it will spontaneously absorb water from the air.  

#### Answer 3 (score 0)
The mechanism of reaction between the acidic oxide and the alkali depends on the concentration of the alkali solution.  

(a) When the alkali ($\ce{NaOH}$) solution is very dilute ($\mathrm{pH} &lt; 8$), carbon dioxide will first react with water to form carbonic acid ($\ce{H2CO3}$) slowly. The acid thus formed then reacts with the alkali to give sodium hydrogencarbonate ($\ce{NaHCO3}$).  

<p>$$\begin{align}
\ce{CO2 + H2O &amp;= H2CO3}\\
\ce{NaOH + H2CO3 &amp;= NaHCO3 + H2O}
\end{align}$$</p>

(b) When the alkali solution is a fairly concentrated one ($\mathrm{pH} &gt; 10$), carbon dioxide directly reacts with it to form the bicarbonate, which further reacts with the alkali to form sodium carbonate ($\ce{Na2CO3}$) as the main product by complete neutralization.  

<p>$$\begin{align}
\ce{NaOH + CO2 &amp;= NaHCO3}\\
\ce{NaHCO3 + NaOH &amp;= Na2CO3 + H2O}
\end{align}$$</p>

Thus, only when the concentration of the alkali solution is quite low, the reaction proceeds via the formation of carbonic acid. But the acidic oxide is not completely neutralized in this case.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Melting points and boiling points of primary alcohols do not follow the same trend (score [83342](https://stackoverflow.com/q/7257) in 2015)

#### Question
If one considers boiling points (in °C) of primary alcohols, one finds the following:  

<ul>
<li>methanol: 65</li>
<li>ethanol: 79</li>
<li>1-propanol: 97</li>
<li>1-butanol: 117</li>
<li>1-pentanol: 138</li>
</ul>

This trend is due to Van der Waals forces increasing with molecular weight.    

Now if one focuses on melting points, I would expect the same trend, but these are the experimental values (in °C):  

<ul>
<li>methanol: −98</li>
<li>ethanol: −117</li>
<li>1-propanol: <strong>−127</strong></li>
<li>1-butanol: −90</li>
<li>1-pentanol: −79</li>
</ul>

the lowest value being the melting point of 1-propanol.   

The general idea stating that with all else being equal, more massive molecules have higher boiling and melting points, does not fully apply for this set of alcohols.  

So my question: why melting and boiling points of primary alcohols do not follow the same trend?  

#### Answer accepted (score 3)
Melting points are a bit trickier to compare than boiling points, especially when you're looking at the lightest examples of a group of molecules. <a href="http://en.wikipedia.org/wiki/File:AlkaneBoilingMeltingPoint.png" rel="nofollow noreferrer">This graph</a> for the unbranched alkanes exemplifies nicely how the trends differ in smoothness.   

As you increase the weight of molecules, the observed trend depends on <em>how</em> you increase the weight. For example, if you start with methanol and increase the weight by adding more $\ce{-HCOH -}$ units (methanol, ethylene glycol, glycerol, and so on) you would find a very clear increase in both melting and boiling points. In some sense this is a more legitimate trend to analyse, because the relative amounts of different types of intermolecular interactions stays approximately constant (in particular, all molecules have one hydroxyl per carbon atom, and hence they all have about the same amount of hydrogen bonding per atom in the molecule). In your sequence of alcohols, the strong hydrogen bonding allowed by the hydroxyl group becomes "diluted" as the molecule gains an ever larger alkyl chain, which can only sustain much weaker van der Waals interactions. In the limit of alcohols with very large alkyl chains, the alcohols' melting and boiling points do not differ tremendously from their parent saturated hydrocarbons. Compare the melting and boiling points of <a href="http://en.wikipedia.org/wiki/Cetyl_alcohol" rel="nofollow noreferrer">1-hexadecanol</a> (49°C and 344°C) and <a href="http://en.wikipedia.org/wiki/Cetane" rel="nofollow noreferrer">hexadecane</a> (18°C and 287°C).  

Also, the temperature at which a substance freezes is dependent not only on the strength of intermolecular interactions, but how the solid packs. Even substances with strong interactions may only freeze at very low temperatures if they pack very poorly when solidified. Extreme examples to which this effect contributes are <a href="http://en.wikipedia.org/wiki/Ionic_liquid" rel="nofollow noreferrer">ionic liquids</a>. They tend to have a very low vapour pressure at reasonable temperatures (as you would expect of many salts), but some melt even below 0°C. The freezing of such bulky entities would entail lots of ordering and therefore a very large decrease in entropy, so it is disfavoured (or equivalently, their melting is highly entropically favoured, so the free energy of the liquid phase becomes lower than the free energy of the solid phase even at relatively low temperatures). The exact geometry of the molecules in the solid is also important, as some favourable interactions may be suppressed in the solid state due to steric hindrance which may be less present in the more freely-moving molecules of a liquid. Furthermore, molecules with a high amount of symmetry tend to have high melting points, because freezing is entropically favoured due to molecules more readily <em>fitting</em> in the solid lattice.  

Yet another effect to consider is how large a surface area each molecule has available for intermolecular interactions. This is often brought up to explain differences between melting and boiling points of branched and unbranched organic compounds; when comparing structural isomers, branched compounds have a lower available area for interaction than unbranched compounds, so the latter tend to have higher <s>melting and</s> boiling points (branching may sometimes create a combination of opposing packing and surface area effects, though).  

So why does your sequence of alcohols behave the way it does? The fact that the trend in boiling point is monotonic while the melting point is not suggests that even though there is a relative shift in importance of types of intermolecular interaction as the alkyl chain increase (from hydrogen bonding to van der Waals interactions), it is probably not the source of the melting point drop. Hence it likely has to do with geometric factors in the solid. The alcohol's alkyl chain probably disrupts the hydrogen bonding network of the solid as it grows from methyl to propyl in a very severe fashion, by making the solid pack less well or by partially hindering the number or strength of hydrogen bonds in the geometry of the solid. Perhaps looking at the crystalline structures of the solid alcohols may provide further insight.  

<strong>Edit</strong>: I wrote a wrong answer initially. I've updated it, but now I realize I'm still not quite sure it's correct. I originally meant to write just a comment, and as I kept writing more I forgot that my very first thought was actually incorrect, so the whole text wasn't built as well as it should be. Anyone is free to pick apart or repurpose what I wrote!  

Edit 2: User Uncle Al posted <a href="https://chemistry.stackexchange.com/questions/8777/why-does-sif4-have-a-higher-melting-point-than-sf4/8784#8784">an interesting list of compounds</a> and their melting/boiling points, showing the importance of molecular symmetry and solid packing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: What role does sulfuric acid play in the titration of oxalic acid and potassium permanganate? (score [83321](https://stackoverflow.com/q/38915) in 2016)

#### Question
The titration is between oxalic acid and potassium permanganate, with $\ce{H2SO4}$ added to oxalic acid. My question is what role other than a dehydrating agent and maybe catalysing does the $\ce{H2SO4}$ play in this titration.  

The question came to me while reading a book (Advanced Chemistry by Philip Matthews - Cambridge university press), I was reading about titrations and this question came to me, but it isn't mentioned in the book.  

#### Answer accepted (score 12)
The used analytical reaction of purple permanganate to colourless $\ce{Mn^2+}$ occurs under acidic conditions:  

$$\ce{MnO4- + 8H+ + 5e- &lt;=&gt; Mn^2+ + 4H2O}$$  

Under neutral conditions, permanganate would be reduced to dark brown manganese(IV) oxide:  

$$\ce{MnO4- + 4H+ + 3e- &lt;=&gt; MnO2 + 2H2O}$$  

Therefore, sulfuric acid is added to make the solution acidic. Actually, excess acid is required since $\ce{H+}$ is consumed during the reaction (8 mol $\ce{H+}$ per 1 mol $\ce{MnO4-}$).  

Sulfuric acid is used because it is stable towards oxidation; whereas, for example, hydrochloric acid would be oxidized to chlorine by permanganate.  

#### Answer 2 (score 0)
H2SO4 increase the acidic content of the solution so as to prevent MnO4 (purple) to reduced to MnO2(dark brow). Hence sulfuric acid is stable in the present of strong oxidising agent. If HCl acid is use it will be oxidised to Cl and make the end point much higher. Furtherore sulfuric acid increase the H+ as it consume.  

#### Answer 3 (score 0)
H2SO4 increase the acidic content of the solution so as to prevent MnO4 (purple) to reduced to MnO2(dark brow). Hence sulfuric acid is stable in the present of strong oxidising agent. If HCl acid is use it will be oxidised to Cl and make the end point much higher. Furtherore sulfuric acid increase the H+ as it consume.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Why does zinc react with sodium hydroxide? (score [82761](https://stackoverflow.com/q/16497) in 2018)

#### Question
If zinc is less reactive than sodium, then why does it still react with sodium hydroxide?  

#### Answer accepted (score 30)
Indeed, $\ce{Zn}$ is lower than $\ce{Na}$ in activity series of metals, so the following reaction <em>won't</em> take place  

$$\require{cancel}\ce{Zn + 2NaOH \cancel{→} Zn(OH)2 + 2Na}$$  

Remember, however, that $\ce{Zn}$ is <em>amphoteric</em>, so it can reacts with a strong base such as $\ce{NaOH}$ as an acid forming sodium zincate  

$$\ce{Zn + 2 H2O + 2 NaOH -&gt; Na2Zn(OH)4 + H2}$$  

P.S. I forget a lot of good ol' chemistry, and I have just realized that usually we do not call metals themselves amphoteric, but rather use this term for their oxides/hydroxides. For metals we just say that some of them (such as $\ce{Zn}$) dissolve both in acids and in bases. The point is that $\ce{Zn}$ does not react as an acid in the reaction above since the reaction is not an acid-base one, but rather oxidation-reduction. So, the answer then is that $\ce{Zn}$ reacts with aqueous solution of sodium hydroxide because it can be oxidized in these condition in accordance with the reaction mentioned.  

#### Answer 2 (score 2)
In effect zinc is not displacing sodium. It's displacing hydrogen. We expect a metal to do this from a hydroxide base if  

<ol>
<li>the metal is more reactive than hydrogen and</li>
<li>the metal's own hydroxide can act as acid  towards this base (amphoteric hydroxide).</li>
</ol>

Zinc passes both tests and so, party time!  

#### Answer 3 (score 0)
<p>Zn is a amphoteric element. Therefore Zn can react with both acids and alkalis eliminating hydrogen. Learn more about amphoteric elements and compounds 
<a href="https://www.chemistryscl.com/chemistry_theories/amphoteric_compounds/main.php" rel="nofollow noreferrer">https://www.chemistryscl.com/chemistry_theories/amphoteric_compounds/main.php</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Angular and radial nodes (score [82456](https://stackoverflow.com/q/8655) in 2016)

#### Question
Nodes are the points in space around a nucleus where the probability of finding an electron is zero. However, I heard that there are two kinds of nodes, <strong>radial nodes</strong> and <strong>angular nodes</strong>. What are they and what information do they provide of an atom?  

#### Answer accepted (score 18)
<strong>1. How to get the number and type of nodes for an orbital</strong>  

As you said, nodes are points of zero electron density. From the principal quantum number $n$ and the azimuthal quantum number $\ell$, you can derive the number of nodes, and how many of them are <em>radial</em> and <em>angular</em>.  

$$\text{number of nodes}=n-1$$  

$$\text{angular nodes}=\ell$$  

$$\text{radial nodes}=(\text{number of nodes})-(\text{angular nodes})$$  

So each type of orbital ($s, p, d$ etc) has its own unique, fixed number of angular nodes, and then as $n$ increases, you add radial nodes.  

<blockquote>
  Examples: First shell  
</blockquote>

For the first shell, $n=1$, which means the number of nodes will be 0.  

<blockquote>
  Examples: Second shell  
</blockquote>

For the second shell, $n=2$, which yields 1 node.  

<ul>
<li>For the $2s$ orbital, $\ell = 0$, which means the node will be radial</li>
<li>For the $2p$ orbital, $\ell = 1$, which means the node will be angular</li>
</ul>

<blockquote>
  Examples: Third shell  
</blockquote>

The third shell, $n=3$, yielding $3-1=2$ nodes.  

<ul>
<li>The $3s$ orbital still has $\ell = 0$ meaning no angular nodes, and thus the two nodes must be radial</li>
<li>The $3p$ orbital still has one angular node, meaning there will be one radial node as well</li>
<li>The $3d$ orbital has two angular nodes, and therefore no radial nodes!</li>
</ul>

<strong>2. The difference between <em>radial</em> and <em>angular</em> nodes</strong>  

Radial nodes are nodes inside the orbital lobes as far as I can understand. Its easiest to understand by looking at the $s$-orbitals, which can only have radial nodes.  

<img src="https://i.stack.imgur.com/RkhwT.jpg" alt="Radial nodes of the s-orbitals">  

To see what an angular node is, then, let's examine the $2p$-orbital - an orbital that has one node, and that node is angular.  

<img src="https://i.stack.imgur.com/jMW9A.gif" alt="Angular nodes of the 2p orbitals">  

We see that angular nodes are not internal countours of 0 electron probability, but rather is a plane that goes through the orbital. For the $2p_\text{z}$-orbital, the angular node is the plane spanned by the x- and y-axis. For the $2p_\text{y}$-orbital, the angular node is the plane spanned by the z- and x-axis.  

#### Answer 2 (score 15)
The accepted answer has nice pictures, but is perhaps somewhat lacking in rigour. Here's a bit more maths.  

Atomic orbitals, which are one-electron wavefunctions, are split into two components: the radial and angular wavefunctions  

$$\psi_{nlm}(r,\theta,\phi) = R_{nl}(r)Y_{lm}(\theta,\phi)$$  

so-called because they only have radial ($r$) and angular ($\theta$,$\phi$) dependencies respectively. If either of these two components are zero, the total wavefunction is zero and the probability density there (given by $\psi^*\psi$) is also zero.  

A radial node occurs when the radial wavefunction is equal to zero. Since the radial wavefunction only depends on $r$, this obviously means that each radial node corresponds to one particular value of $r$. (The radial wavefunction may be zero when $r = 0$ or $r \to \infty$, but these are not counted as radial nodes.)  

An angular node is analogously simply a region where the angular wavefunction is zero.<sup>1</sup> In the case of the p-orbitals, this is a plane, although <em>angular nodes are not necessarily planes</em>.  

The number of radial and angular nodes is dictated by the forms of the wavefunctions, which are derived by solving the Schrodinger equation. For a given orbital with quantum numbers $(n,l)$, there are $n-l-1$ radial nodes and $l$ angular nodes, as previously described.  

<h5>An example</h2>

Let's take a look at one of the hydrogen 3d wavefunctions<sup>2</sup> with $(n,l) = (3,2)$. $a_0$ is the <a href="https://en.wikipedia.org/wiki/Bohr_radius" rel="noreferrer">Bohr radius</a> of the hydrogen atom. We would expect $3-2-1 = 0$ radial nodes and $2$ angular nodes.  

$$\mathrm{3d}_{z^2} = \\underbrace{\left[\frac{4}{81\sqrt{30}}a_0^{-3/2}\left(\frac{r}{a_0}\right)^2 \exp{\left(-\frac{r}{3a_0}\right)}\right]}_{\text{radial: }R_{32}} \\underbrace{\left[\sqrt{\frac{5}{16\pi}}(3\cos^2\theta - 1)\right]}_{\text{angular: }Y_{20}}$$  

All the individual terms in the radial wavefunction can never be zero (excluding the cases of $r = 0$ or $r \to \infty$ as I described earlier). Therefore, this orbital has no radial nodes. Surprise, surprise.  

The angular nodes are more interesting. The angular wavefunction vanishes when $3 \cos^2\theta - 1 = 0$. Since $\theta$ takes values between $0^\circ$ and $180^\circ$,<sup>3</sup> this corresponds to the two solutions $\theta = 54.7^\circ, 125.3^\circ$. Both of these solutions are angular nodes. This is how they look like.<sup>4</sup>  

<a href="https://i.stack.imgur.com/6PMiw.png" rel="noreferrer"><img src="https://i.stack.imgur.com/6PMiw.png" alt="enter image description here"></a>  

The dotted lines are the angular nodes. They are not planes, but rather <em>cones</em>. They correspond to one particular value of $\theta$, which in spherical coordinates is the angle made with the positive $z$-axis; I have marked these angles on the diagram.  

If you can obtain the forms of the wavefunctions, then it is easy to find the radial nodes. Mark Winter at Sheffield has a <a href="https://winter.group.shef.ac.uk/orbitron/AOs/1s/equations.html" rel="noreferrer">great website</a> for this; just click on the orbital you want on the left, then "Equations" near the top-right corner.  

<strong>Notes and references</strong>  

<sup>1</sup> If we stick to complex atomic orbitals, which are simultaneous eigenfunctions of $H$, $L^2$ and $L_z$, then the dependency on $\phi$ is always of the form $e^{\pm im\phi}$, which can never be zero, so angular nodes never arise due to $\phi$-dependency. However, radial and angular nodes are most commonly discussed in the context of <a href="https://en.wikipedia.org/wiki/Atomic_orbital#Real_orbitals" rel="noreferrer">real atomic orbitals</a>, obtained by linear combination of the spherical harmonics. These do have angular nodes that depend on both $\theta$ and $\phi$, but they are often much simpler to express in terms of Cartesian coordinates $(x,y,z)$ (obvious examples being the $\mathrm{2p}_x$ and $\mathrm{2p}_y$ orbitals). The $\mathrm{3d}_{z^2}$ orbital is an exception that was deliberately chose as an example because its angular nodes are not planes.  

<sup>2</sup> Griffiths, <em>Introduction to Quantum Mechanics</em>, 2nd ed., pp 139, 154.  

<sup>3</sup> Yes, I am using degrees, not radians.  

<sup>4</sup> Image source: own work. It was surprisingly difficult to find an appropriate picture online.  

#### Answer 3 (score 3)
If you vibrate a piece of rope then it is quite easy to show that nodes will appear, and when standing waves are produced the nodes are fixed in space and time. Between the nodes the rope oscillates up and down. The n$^{th}$ harmonic has $n-1$ nodes. The more nodes there are, the greater is the energy is required to produce them. In a vibrating rectangular membrane nodal lines are produced and in a vibrating disc nodal rings. The nodal lines, where the amplitude is zero separate normal vibrational modes.  

Similarly with atoms and molecules. Nodes are points where the wavefunction crosses zero, and its amplitude is zero. Where the wavefunction gradually approaches zero (at the origin or infinity) are not considered nodes. Nodes naturally appear in all solutions of the Schrodinger equation, even for simple systems such as a particle in a box. Not all wavefunctions have nodes, the lowest energy one does not, (e.g. the S orbital in atoms, zero point vibration and zero rotation in molecules, lowest MO in a molecule). The larger the number of nodes a wavefunction has the greater the energy eigenvalue. Some pictures of wavefunctions and nodes has been given in the answer by @Brian.  

There appears to be no special significance to a node, it arises purely out of the solution of the Schrodinger equation and is a consequence of the solutions (hence boundary conditions) we choose to obtain quantisation. Without nodes it is difficult to see how wavefunctions describing different energy eigenvalues could be constructed.   

Briefly extending the question to include bond formation. In forming bonds from atomic orbitals the parity of the wavefunction is important. Upon interchanging coordinates, i.e. inversion operator, odd parity (ungerade, u) produces -1 itself and even parity (gerade, g)leaves the orbital indistinguishable. The node in a <em>p</em> orbital causes it to have odd parity, as <em>s</em> orbital even. The symmetry (parity) determines whether two orbitals can combine to form a bonding orbital or anti-bonding one, e.g. $\sigma$ or $\sigma ^*$ or $\pi$ or $\pi ^*$. Anti-bonding orbitals always have nodes.<br/> Nodal planes are also important in Diels Alder addition and similar reactions as here symmetry is important. In spectroscopic transitions in molecules, the nodal structure of the molecular orbitals  determine, via symmetry, which transitions are allowed or forbidden.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: Alkane, alkene, alkyne boiling point comparison (score [82153](https://stackoverflow.com/q/28576) in 2018)

#### Question
Which of the following has higher boiling points? Alkanes, alkenes, or alkynes? And why?   

#### Answer accepted (score 20)
<em>Disclaimer</em>: <strong>All of this "jazz" will be about reaching a mere rule-of-thumb. You can't just compare whole families of organic compounds with each other. There are more factors to consider than below, mostly based on isomerism notions. However, as most of the A grade exams emphasize on the lighter aliphatic compounds, we can understand each other here.</strong> :)  

<hr>

<h5>It's all about <a href="http://en.wikipedia.org/wiki/Polarizability" rel="nofollow noreferrer">polarizability</a>.</h2>

<blockquote>
  Polarizability is the ability for a molecule to be polarized.  
</blockquote>

When determining (aka comparing) the boiling points of different <em>molecular</em> substances, intermolecular forces known as <a href="https://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=3&amp;cad=rja&amp;uact=8&amp;ved=0CCcQFjAC&amp;url=https%3A%2F%2Fwww.chem.purdue.edu%2Fgchelp%2Fliquids%2Fdisperse.html&amp;ei=eosqVbOoL4vaavrtgdAO&amp;usg=AFQjCNEMaPTsbL6eJQpOZWNAR8iFFF1TiA&amp;sig2=0RMrlg0sDiEn23odyik6Xw&amp;bvm=bv.90491159,d.d2s" rel="nofollow noreferrer">London Dispersion Forces</a> are at work here. Which means, these are the forces that are overcome when the boiling occurs. (See <a href="https://chemistry.stackexchange.com/questions/23459/why-do-simple-molecular-substances-have-weak-intermolecular-forces-and-why-do-gi/23462#23462">here</a> for example)   

<img src="https://i.stack.imgur.com/9IKF8.jpg" alt="">  

<a href="http://340454897494774470.weebly.com/uploads/1/6/2/0/16209380/8406765.jpg?395" rel="nofollow noreferrer">Source</a>  

London forces get stronger with an increase in volume, and that's because the polarizability of the molecule increases. (See <a href="https://chemistry.stackexchange.com/questions/28499/relation-between-molar-mass-and-van-der-waals-force/28504#28504">the answer to this recent question</a>)  

<h5>Alkanes vs. Alkenes</h2>

In their simplest form (where no substitution etc. has occurred) alkanes tend to have very close boiling points to alkenes.  

<blockquote>
  The boiling point of each alkene is very similar to that of the alkane with the same number of carbon atoms. Ethene, propene and the various butenes are gases at room temperature. All the rest that you are likely to come across are liquids.  
  
  Boiling points of alkenes depends on  more molecular mass (chain length). The more intermolecular mass is added, the higher the boiling point. Intermolecular forces of alkenes gets stronger with increase in the size of the molecules.  
  
  <p>\begin{array}{|c|c|}\hline
\text{Compound} &amp; \text{Boiling point / }^\circ\mathrm{C} \\ \hline
\text{Ethene}	&amp; -104 \\ \hline
\text{Propene}	&amp; -47 \\ \hline
\textit{trans}\text{-2-Butene}	&amp; 0.9 \\ \hline
\textit{cis}\text{-2-Butene} &amp; 3.7 \\ \hline
\textit{trans}\text{-1,2-dichlorobutene} &amp;	155 \\ \hline
\textit{cis}\text{-1,2-dichlorobutene} &amp;	152 \\ \hline
\text{1-Pentene}	&amp; 30 \\ \hline
\textit{trans}\text{-2-Pentene}	&amp; 36 \\ \hline
\textit{cis}\text{-2-Pentene}	&amp; 37 \\ \hline
\text{1-Heptene}	&amp; 115 \\ \hline
\text{3-Octene}	&amp; 122 \\ \hline
\text{3-Nonene}	&amp; 147 \\ \hline
\text{5-Decene}	&amp; 170 \\ \hline
\end{array}
  In each case, the alkene has a boiling point which is a small number of degrees lower than the corresponding alkane. The only attractions involved are Van der Waals dispersion forces, and these depend on the shape of the molecule and the number of electrons it contains. Each alkene has 2 fewer electrons than the alkane with the same number of carbons.</p>
</blockquote>

<h5>Alkanes vs. Alkynes</h2>

As explained, since there is a bigger volume to an alkane than its corresponding alkyne (i.e. with the same number of carbons) the alkane should have a higher boiling point. However, there's something else in play here:  

<strong><em>Alkynes, have a TRIPLE bond!</em></strong>  

I currently can think of two things that happen as a result of this:  

<ul>
<li><p>London Dispersion Forces are in relation with distance. Usually, this relation is $r^{-6}$. (See <a href="https://chemistry.stackexchange.com/questions/23718/london-dispersion-forces-and-distance-relationship">here</a>) The triple bond allows two alkynes to get closer. The closer they are, the more the electron densities are polarised, and thus the stronger the forces are.</p></li>
<li><p>Electrons in $\pi$ bonds are more polarizable$^{10}$.</p></li>
</ul>

These two factors overcome the slight difference of volume here. As a result, you have higher boiling points for alkynes than alkanes, generally.  

<p>\begin{array}{|c|c|}\hline
\text{Compound} &amp; \text{Boiling point / }^\circ\mathrm{C} \\ \hline
\text{Ethyne}	&amp; -84^{[1]} \\ \hline
\text{Propyne}	&amp; -23.2^{[2]} \\ \hline
\text{2-Butyne}	&amp; 27^{[3]} \\ \hline
\text{1,4-Dichloro-2-butyne} &amp;	165.5^{[4]} \\ \hline
\text{1-Pentyne}	&amp; 40.2^{[5]} \\ \hline
\text{2-Heptyne}	&amp; 112\text{–}113^{[6]} \\ \hline
\text{3-Octyne}	&amp; 133^{[7]} \\ \hline
\text{3-Nonyne}	&amp; 157.1^{[8]} \\ \hline
\text{5-Decyne}	&amp; 177\text{–}178^{[9]} \\ \hline
\end{array}
<sub>1: <a href="http://en.wikipedia.org/wiki/Acetylene" rel="nofollow noreferrer">http://en.wikipedia.org/wiki/Acetylene</a></sub><br/>
<sub>2: <a href="http://en.wikipedia.org/wiki/Propyne" rel="nofollow noreferrer">http://en.wikipedia.org/wiki/Propyne</a></sub><br/>
<sub>3: <a href="http://en.wikipedia.org/wiki/2-Butyne" rel="nofollow noreferrer">http://en.wikipedia.org/wiki/2-Butyne</a></sub><br/>
<sub>4: <a href="http://www.lookchem.com/1-4-Dichloro-2-butyne/" rel="nofollow noreferrer">http://www.lookchem.com/1-4-Dichloro-2-butyne/</a> </sub><br/>
<sub>5: <a href="http://en.wikipedia.org/wiki/1-Pentyne" rel="nofollow noreferrer">http://en.wikipedia.org/wiki/1-Pentyne</a> </sub><br/>
<sub>6: <a href="http://www.chemsynthesis.com/base/chemical-structure-17405.html" rel="nofollow noreferrer">http://www.chemsynthesis.com/base/chemical-structure-17405.html</a> </sub><br/>
<sub>7: <a href="http://www.chemspider.com/Chemical-Structure.76541.html" rel="nofollow noreferrer">http://www.chemspider.com/Chemical-Structure.76541.html</a></sub><br/>
<sub>8: <a href="http://www.thegoodscentscompany.com/data/rw1120961.html" rel="nofollow noreferrer">http://www.thegoodscentscompany.com/data/rw1120961.html</a></sub><br/>
<sub>9: <a href="http://www.chemsynthesis.com/base/chemical-structure-3310.html" rel="nofollow noreferrer">http://www.chemsynthesis.com/base/chemical-structure-3310.html</a></sub><br/>
<sub>10: <a href="https://chemistry.stackexchange.com/a/27531/5026">https://chemistry.stackexchange.com/a/27531/5026</a></sub></p>

<hr>

<p><strong>Conclusion</strong>: We can't fully determine the boiling points of the whole class of alkanes, alkenes and alkynes. However, for the lighter hydrocarbons, comparing the boiling points, you get:
$$\text{Alkynes &gt; Alkanes &gt; Alkenes}$$</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: Is there an easy way to remember charges on ions? (score [81941](https://stackoverflow.com/q/14348) in 2018)

#### Question
I have a chemistry test coming up and I might need to know the charge that goes with the different ions like $\ce{SO4}$ has $-2$, $\ce{NO2}$ is $-1$ and  $\ce{PO4}$ is $-3$.  Is there an easy way to remember this by looking at the periodic table or something like remembering that the second row elements are all going to be $\ce{something-O3}$  and the next row is all $\ce{something-O4}$ for the -ate endings (except $\ce{Cl}$ which is the odd man out). It will make writing out the different acid combos easier, if I can remember the charge difference that needs offsetting by the hydrogen.  

I'm just trying to lay down some associative triggers for myself.  

#### Answer accepted (score 10)
I don't believe there is any simple way to determine what they are except by just plain memorization. I have given some tricks below that have helped me.  

When I write down my poly-atomic ions, I generally put them in similar groups in a certain order. From least amount of oxygen to most amount oxygen.   

<ul>
<li><strong>hypo</strong> (name of ion) <strong>ite</strong> -> least oxygen</li>
<li>(name of ion) <strong>ite</strong> -> one more oxygen than above</li>
<li>(name of ion) <strong>ate</strong> -> one more oxygen than 'ite'</li>
<li><strong>per</strong> (name of ion) <strong>ate</strong> -> one more oxygen than 'ate'</li>
</ul>

Understanding the above helps most with 'ite' and 'ate'. 'Ate' generally being 1 more than 'ite' for oxygen.  

Then I list them from least charge to most charge. I order them this way:  

<ul>
<li>Nitr <strong>ite</strong> $\ce{NO2-}$</li>
<li>Nitr <strong>ate</strong> $\ce{NO3-}$</li>
<li>Sulf <strong>ite</strong> $\ce{SO3^2-}$</li>
<li>Sulf <strong>ate</strong> $\ce{SO4^2-}$</li>
</ul>

You can see that 'ate' has one more oxygen, and that I have listed them in charge order. Sometimes looking at the trends in oxygen and charge will help you memorize. I have had to remember them by writing them down several times and now I am comfortable.  

<p>Here is another example: Hypochlorite is 
$\ce{ClO^-}$</p>

So, chlorite should be?  

<blockquote class="spoiler">
   $\ce{ClO2-}$, because it has one more oxygen, and  
</blockquote>

Chlorate should be?  

<blockquote class="spoiler">
   $\ce{ClO3-}$, because it has one more oxygen than the above, and  
</blockquote>

$\ce{ClO4-}$, will be called?  

<blockquote class="spoiler">
   <strong>Per</strong> chlor <strong>ate</strong>, because it has the maximum amount of oxygen.  
</blockquote>

The above is not a hard and fast rule. One exception I can think of is manganate and permanganate.  

Manganate is $\ce{MnO4^2-}$ but permanganate is $\ce{MnO4^-}$; same amount of oxygen, just a different charge.  

Trying to figure out any of the above from a periodic table didn't make a difference to me because my professor tests us without it. Yikes!  

#### Answer 2 (score 6)
There is a very useful trick that I was taught to remember the charges and formulas:  

<blockquote>
  Nick the Camel ate an Icky Clam Booger for Supper in Phoenix.  
</blockquote>

This trick helps with most of the polyatomics. The first letter of each word stands for the first letter of there compound.   

<ul>
<li><strong>Nick</strong> Nitrate. The number of consonants is the number of oxygen so. Nick = 3 O's.  The number of vowels stand for the charge. One vowel in Nick = -1 charge. So, $\ce{NO3-}$</li>
<li><strong>Camel</strong> Carbonate; 3 consonants= 3 O's; 2 vowels = 2-; $\ce{CO3^2-}$   </li>
<li><strong>Icky</strong> Iodate; 3 consonants = 3 O's; 1 vowel = 1-; $\ce{IO3^-}$    </li>
<li><strong>Clam</strong> Chlorate; $\ce{ClO3^-}$  </li>
<li><strong>Booger</strong> Borate; $\ce{BO3^3-}$  </li>
<li><strong>Supper</strong> Sulfate; $\ce{SO4^2-}$  </li>
<li><strong>Phoenix</strong> Phosphate; $\ce{PO4^3-}$  </li>
</ul>

Hopefully this helped, you can always add word to the sentence to help remember other polyatomic ions.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: How to find pH by mixing two solutions of different concentrations? (score [81783](https://stackoverflow.com/q/32091) in 2018)

#### Question
<blockquote>
  A mixture is made by combining 110 mL of 0.15 M $\ce{HCl}$ and 215 mL of 0.055 M $\ce{HI}$.  What is the pH of the solution?  
</blockquote>

<p>$$\ce{HCl -&gt; H+ + Cl-}$$
$$\ce{HI -&gt; H+ + I-}$$ 
According to what I thought, the molarity of $\ce{H+}$ is the same as $\ce{HCl}$, because it is a strong acid and the mole ratio.  So, I added the molarity of both acids: $\pu{0.15M} + \pu{0.055M} = \pu{0.205M}$ for $\ce{H+}$ in solution. </p>

<p>$$\mathrm{pH} = -\log[\ce{H+}]$$ 
$$\mathrm{pH} = -\log[0.205]$$ 
$$\mathrm{pH} = 0.689$$</p>

#### Answer accepted (score 9)
<p>You are right in assuming the two acids are strong acids and therefore completely dissociated, but you can easily look that also up, e.g. <a href="http://clas.sa.ucsb.edu/staff/Resource%20folder/Chem109ABC/Acid,%20Base%20Strength/Table%20of%20Acids%20w%20Kas%20and%20pKas.pdf">here</a>.
Therefore you can assume, that the concentration of protons is equal to the concentration of the acid.
\begin{align}
c_{\ce{HI}}(\ce{H+}) &amp;=  c(\ce{HI}) &amp;
c_{\ce{HCl}}(\ce{H+}) &amp;=  c(\ce{HCl}) &amp;
\end{align}</p>

Now you need to determine the amount of the protons in each solution with $$n=c\cdot V.$$  

<p>You have to add the amount of protons in each solution and determine the combined volume.
\begin{align}
n_\mathrm{tot}(\ce{H+}) &amp;= n_{\ce{HI}}(\ce{H+}) + n_{\ce{HCl}}(\ce{H+})&amp;
V_\mathrm{tot} &amp;= V(\ce{HI}) + V(\ce{HCl})
\end{align}</p>

<p>To calculate the pH of the resulting concentration, just take the negative logarithm.
$$\mathrm{pH} = -\log c_\mathrm{tot}(\ce{H+}) = -\log\left[\frac{n_\mathrm{tot}(\ce{H+})}{V_\mathrm{tot}}\right]$$</p>

<blockquote class="spoiler">
   Your solution should be $\mathrm{pH}=1.06$, rounded to three significant figures.  
</blockquote>

The approach you chose can only work, if you have equal volumes of the two solutions.  

#### Answer 2 (score -2)
<p>$$\begin{align}
M_1V_1+M_2V_2&amp;=M\left(V_1+V_2\right)\\
0.015\times110+0.055\times215&amp;=M\left(110+215\right)\\
1.65+11.825&amp;=M\cdot325\\
M&amp;=\frac{13.475}{325}\\
M&amp;=0.04146=4.416\times10^{-2}\\
\mathrm{pH}&amp;=-\log\left(4.416\times10^{-2}\right)\\
\mathrm{pH}&amp;=-\log4.416+2\log10\\
\mathrm{pH}&amp;=-0.617+2\\
\mathrm{pH}&amp;=1.383
\end{align}$$</p>

<p>You can go this way also
$$\begin{align}
\text{HCl conc}&amp;=0.015\ \mathrm M\\
&amp;=0.015\times\frac{110}{1000}\ \mathrm{mol}\\
&amp;=1.65\times10^{-3}\ \mathrm{mol}
\end{align}$$</p>

<p>$$\begin{align}
\text{HI conc}&amp;=0.055\ \mathrm M\\
&amp;=0.055\times\frac{215}{1000}\\
&amp;=11.825\times10^{-3}\ \mathrm{mol}
\end{align}$$</p>

<p>$$\begin{align}
\text{Total}\ [\ce{H+}]&amp;=\left(1.65\times10^{-3}+11.825\times10^{-3}\right)\ \mathrm{mol}\ \text{in}\ 325\ \mathrm{ml}\\
&amp;=13.475\times10^{-3}\ \mathrm{mol}\ \text{in}\ 325\ \mathrm{ml}\\
\text{so in}\ 1000\ \mathrm{ml}&amp;=13.475\times10^{-3}\times\frac{1000}{325}\\
&amp;=4.146\times10^{-2}\\
\text{Thus}\ \mathrm{pH}&amp;=1.383
\end{align}$$</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: Differences between phenols and alcohols (score [81140](https://stackoverflow.com/q/729) in 2016)

#### Question
I know <strong><em>phenols are more acidic as compared to alcohols</em></strong>, but are they considered different from alcohols?  

Sure, you can study something as a subset, but are <strong>phenols</strong> considered a subset of alcohols, or are they considered as completely different from alcohols? My confusion is due to the fact that both of them contain a hydroxyl group.  

<p><img src="https://i.stack.imgur.com/Ow6mK.png" alt="Phenol"><br>
<img src="https://i.stack.imgur.com/V6znn.png" alt="Alcohol"></p>

#### Answer accepted (score 47)
Nope. Alcohols consist of an <span class="math-container">$\ce{OH}$</span> group bonded to a <em>saturated</em> carbon (<span class="math-container">$sp^3$</span> hybridized, no multiple bonds)  

<a href="https://goldbook.iupac.org/A00204.html" rel="noreferrer">IUPAC says:</a>  

<blockquote>
  <h5>alcohols</h1>
  
  Compounds in which a hydroxy group, <span class="math-container">$\ce{–OH}$</span>, is attached to a saturated carbon atom <span class="math-container">$\ce{R3COH}$</span>. The term 'hydroxyl' refers to the radical species, <span class="math-container">$\ce{HO.}$</span>.  
</blockquote>

<a href="https://goldbook.iupac.org/P04539.html" rel="noreferrer">and</a>  

<blockquote>
  <h5>phenols</h1>
  
  Compounds having one or more hydroxy groups attached to a benzene or other arene ring, e.g. 2-naphthol:  
  
  <p><a href="https://i.stack.imgur.com/0BVVA.png" rel="noreferrer"><img src="https://i.stack.imgur.com/0BVVA.png" alt="2-naphthol structure"></a><br>
  <sub>(source: <a href="https://goldbook.iupac.org/SVG/P04539.png" rel="noreferrer">iupac.org</a>)</sub>  </p>
</blockquote>

A phenol consists of an <span class="math-container">$\ce{-OH}$</span> bonded to an unsaturated <span class="math-container">$sp^2$</span> carbon. Thus, it does not qualify as an alcohol. One <em>can</em> classify it as an <a href="http://en.wikipedia.org/wiki/Enol" rel="noreferrer">enol</a>, though.  

<hr>

Really, to me, the classification doesn't matter. Classifications are artificial, what is important is how well the properties fit in the classification.   

Many of the alcohol properties depend upon:  

<ul>
<li>Its unsaturated nature: oxidation to ketone/aldehyde/acid</li>
<li>The weaker <span class="math-container">$\ce{R-O}$</span> bond and its ability to easily break and form an <span class="math-container">$\ce{R+}$</span> cation (this makes it a good participant in <span class="math-container">$S_N1$</span> reactions)</li>
</ul>

Phenol can obviously not be oxidised at the <span class="math-container">$\ce{OH}$</span> to a ketone/acid (though one <em>can</em> do stuff to make it into a quinone). Phenylic carbocations are unstable, thus we don't get any <span class="math-container">$S_N1$</span> reactions, and the <span class="math-container">$\ce{Ph-O}$</span> bond stays put.  

On the other hand, most of the reactions of phenol depend upon its  

<ul>
<li>Aromatic phenyl ring: All the EAS reactions</li>
<li>Weaker <span class="math-container">$\ce{O-H}$</span> bond (i.e., acidic nature): Reimer-Tiemann reaction, etc </li>
</ul>

Thus phenols and alcohols don't have too many reactions in common. So, in this case, they have been classified in a sensible manner--if phenols were classified as alcohols, we would basically be clubbing two radically different classes of compounds under one umbrella.  

#### Answer 2 (score -3)
Phenols are the aromatic organic compounds that have a hydroxyl group directly connected to a ring and alcohols are the non- aromatic compounds that have a hydroxyl group connected to the main chain. The difference is that one is cyclic and one is non- cyclic.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Why calcium chloride is used to melt ice over sodium chloride (score [81038](https://stackoverflow.com/q/5023) in 2018)

#### Question
I'm not quite sure I understand this. My question is:   

<blockquote>
  Calcium chloride is a salt used widely to melt ice on sidewalks and roads.  Explain why one mole of $\ce{CaCl2}$ would be more effective than one mole of $\ce{NaCl}$.  
</blockquote>

So from everything I've learned, $\ce{NaCl}$ would be more effective for the <strong>melting</strong>, because calcium chloride dissociates into three ions and sodium chloride dissociates into two, so that would make the boiling point of water with calcium chloride higher.  Therefore, it shouldn't be used to <strong>melt</strong> ice over sodium chloride, as it would make the water have a higher boiling point so wouldn't melt it as well!  

#### Answer accepted (score 13)
<p>That one mole of $\ce{CaCl2}$ is more effective in melting ice than one mole of $\ce{NaCl}$ is explained by the van 't Hoff factor. The freezing point depression of a solution is calculated by
$$\Delta T=K_fbi$$
where $K_f$ is a cryogenic constant which is specific to the solvent, $b$ is the molal concentration of the solute, and $i$ is the van 't Hoff factor, which indicates number of solute particles. In this case, it is the number of ions produced upon dissociation. Because $K_f$ and $b$ are constant, and $i=3$ for $\ce{CaCl2 \rightarrow Ca^2+ + 2 Cl-}$ and $i = 2$ for $\ce{NaCl \rightarrow Na+ + Cl-}$ the freezing point depression is greater for $\ce{CaCl2}$.</p>

The reason $\ce{CaCl2}$ is widely used as melting agent may have more to do with keeping the concrete intact. Concrete is composed of many calcium-containing species. When water flows over the concrete, the calcium can be leeched out, and the concrete becomes brittle. The higher the calcium content in the water, the less leeching occurs, and the concrete remains structurally sound.  

#### Answer 2 (score 4)
Calcium chloride produces an exothermic reaction when mixed with water or when placed on top of ice, which means that it literally heats up when it comes in contact with ice. Sodium chloride does not produce this exothermic reaction.  

#### Answer 3 (score 2)
In addition to the colligative and thermochemical properties, there are practical considerations as to why calcium chloride or sodium chloride would be used to melt ice in a public area. Calcium chloride will make a surface slippery under reasonably cold ($&lt;0~^\circ\mathrm{F}$) conditions presumably due to the hygroscopic nature of the salt.  On the other hand, sodium chloride is fairly corrosive and can damage concrete and vegetation.  I'm not a fan of sending visitors to other Q&amp;A sites, but <a href="http://chemistry.about.com/cs/howthingswork/a/aa120703a.htm" rel="nofollow noreferrer">this answer</a> has a nice table of the pros and cons of several salts used in melting ice.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How to calculate crystal field stabilisation energy? (score [79113](https://stackoverflow.com/q/6489) in 2013)

#### Question
How to calculate it? I know that it depends on the coordination compound and the number of electrons present in t2g and eg orbitals and the final answer is expressed in terms of crystal field splitting parameter. But, how to know how many electrons are there in t2g and eg orbitals?  

I think rather than a broad answer and example would help. So, consider the compound $\ce{[Ni(CO)4]}$ and how to calculate CFSE for it?  

#### Answer accepted (score 12)
<blockquote>
  Step 1: Look up <a href="http://en.wikipedia.org/wiki/Nickel_carbonyl" rel="nofollow noreferrer">Nickel Carbonyl</a> and find out what geometry it has.   
</blockquote>

We need the geometry to know how the $d$ orbitals will split in the ligand field. The geometry can also be predicted: late transition metals with strong field ligands tend to be tetrahedral.   

<img src="https://i.stack.imgur.com/sdZA2.png" alt="nickel carbonyl">  

<blockquote>
  Step 2: Find the appropriate <a href="http://en.wikipedia.org/wiki/Crystal_field_theory#Crystal_field_splitting_diagrams" rel="nofollow noreferrer">crystal field splitting diagram</a> for this geometry.  
</blockquote>

<img src="https://i.stack.imgur.com/VXd7i.png" alt="tetrahedral ligand field splitting diagram">  

<blockquote>
  Step 3: Figure out how many $d$ electrons there are.   
</blockquote>

<a href="http://en.wikipedia.org/wiki/Nickel" rel="nofollow noreferrer">Nickel</a> is in Group 10, with a configuration of $\ce{[Ar]}4s^2 3d^8$ or $\ce{[Ar]}4s^1 3d^9$. In coordination compounds we will consider this configuration to become $\ce{[Ar]}4s^2 3d^8 \implies \ce{[Ar]}3d^{10}$. The $s$ electrons are considered to move to the $d$ sub-shell in bonding - bonding need not represent ground state <strong>atomic</strong> electron configurations just group state <strong>molecular</strong> electron configurations. For more information on $d$ electron count, go to <a href="http://en.wikipedia.org/wiki/D_electron_count#d10" rel="nofollow noreferrer">this Wikipedia page.</a>  

<blockquote>
  Step 4: Fill in the $d$ electrons.  
</blockquote>

You can do this part yourself. How do you put 10 $d$ electrons in the orbital diagram?  

<blockquote>
  Step 5: Determine $\Delta E$.  
</blockquote>

$\Delta$ is the energy different between the $e_g$ and $t_{2g}$ sets of orbitals. This <a href="http://en.wikipedia.org/wiki/Crystal_field_theory#Crystal_field_stabilization_energy" rel="nofollow noreferrer">Wikipedia page</a> walks through an octahedral complex. In tetrahedral complexes, the energy of the $e_g$ orbitals is lower and the energy of the $t_{2g}$ orbitals is higher. The energies are:  

<ul>
<li>$e_g \ (d_{x^2-y^2},\ d_{z^2}) \ E=-\frac{3}{5}\Delta_\textrm{tet}$ (stabilized)</li>
<li>$t_{2g} \ (d_{xy},\ d_{xz},\ d_{yz}) \ E=\frac{2}{5}\Delta_\textrm{tet}$ (destabilized)</li>
</ul>

Then multiply the numbers of electrons in the orbitals by the stabilization/destabilization values, and sum.  

$$\Delta E = 4\times\left(-\frac{3}{5}\Delta_\textrm{tet}\right)+6\times\left(\frac{2}{5}\Delta_\textrm{tet}\right)=?$$  

#### Answer 2 (score 2)
We have to see the $d$-orbital of the metal atom how many electrons there are, but in <em>excited state</em> not in ground state; then see the spins whether it is low spin or high spin because $d$-orbital is divided into $t_{2g}$ and $e_g$ with respect to their energies difference then apply the formula. The formula is   

<blockquote>
  $$\mathrm{no.\ of\ electrons\ in\ t_{2g}\cdot(-0.4)}+\mathrm{no.\ of\ electrons\ in\ e_g\cdot(0.6)}$$   
</blockquote>

Example: I have $\mathrm{[Co(F)_6]^{3-}}$ now see cobalt has $3d^7$, $4s^2$ system in ground state but in excited state it loses three electrons in the formation of ions and two elctrons from $4s$ and one from $3d$ orbital so thus Cobalt gets $3d^6$ configuration. Now it is of high spin so $4$ electrons go to $t_{2g}$ orbital and $2$ electrons go to $e_g$ orbital. By applying formula,  

<blockquote>
  $4(-0.4)+2(0.6)=-1.6+1.2=-0.4$  
</blockquote>

#### Answer 3 (score -1)
<p>The process is quite simple. .. to determine CFSE  we need to know that the diffidence of energy levels of two sets have been arbiter taken as 10 dq. . Where t2g set is more stable then eg set octahedral and vice versa in tetrahedral complex. 
-0.4x + 0.6y will help to calculate it.
X indicates electrons in t2g and y in eg. 
Sum up all and find the diffidence ... 
That gives cfsc
Usually tetrahedral splitting is shown in terms of octahedral as
4/9 OS</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: Chemistry behind Gale's coffee maker in Breaking Bad (score [78551](https://stackoverflow.com/q/7439) in 2016)

#### Question
Is there a scientific basis for the coffee making equipment which Gale Boetticher describes in Breaking Bad?  

<img src="https://i.stack.imgur.com/RXXSf.jpg" alt="Picture of the &quot;Ultimate&quot; coffee maker">  

He talks about maintaining the right conditions for bringing out the coffee flavor without degrading it.  

#### Answer accepted (score 25)
Yes, there is a scientific basis, but I think you can't do anything with the apparatus shown in the figure. <a href="http://weakinteractions.wordpress.com/2010/05/01/the-science-of-breaking-bad-sunset/" rel="noreferrer">Here</a> you can find much information about it. I will try to summarize.  

It seems that extracting coffee at a lower temperature makes it tastes better. Gale thinks that the amount of quinic acid is the key variable that makes good coffee. In fact, some studies (McCamey, D. A.; Thorpe, T. M.; and McCarthy, J. P. Coffee Bitterness. In "Developments in Food Science." Vol 25. 169-182. 1990.) report that bitterness of coffee is due to quinic acid but is not the only substance involved (see <a href="http://www.coffeeresearch.org/science/bittermain.htm" rel="noreferrer">this link</a>). I don't have any reference about the dependence between temperature and method of extraction and quantitative of quinic acid extracted.  

By the way, the apparatus should extract the coffee in a more effective way. The vacuum pump seems to suggest the use of the vacuum to make the water boil at a lower temperature. But the connections in my opinion make no sense, so I will try to describe it:  

<img src="https://i.stack.imgur.com/l3zLS.png" alt="enter image description here">  

All start with an autoclave that is connected with a <a href="http://rads.stackoverflow.com/amzn/click/B007IBO2I0" rel="noreferrer">Gast vacuum pump</a>. This is connected with an <a href="http://en.wikipedia.org/wiki/Condenser_(laboratory)#Allihn_condenser" rel="noreferrer">Allihn condenser</a> (not the right thing to do because in there you should connect the water used to refrigerate), and then to a heated Erlenmeyer flask that is connected with a strange steel cylinder (I don't know what it is, maybe a filter), then to a Florence flask and then to another steel cylinder (...). The inspiration comes from a Florence Siphon but this is much simpler and is generally something like this:  

<img src="https://i.stack.imgur.com/ktu3F.jpg" alt="enter image description here">  

<a href="http://makezine.com/projects/the-florence-siphon/" rel="noreferrer">Here</a> you can read and <a href="http://www.youtube.com/watch?v=rHjVKnsOpBw" rel="noreferrer">here</a> you can watch how it works.  

Of course this is not so nice and intriguing as the previous apparatus and is not a geeky thing that makes us think we are dealing with a great chemist, so the authors thought to make the apparatus more appealing but completely useless!  

#### Answer 2 (score 6)
<p>I think you can make coffee with the machine shown in the picture.
This is my analysis.</p>

<img src="https://i.stack.imgur.com/Fa50M.png" alt="breaking bad coffee machine">  

#### Answer 3 (score 2)
The setup used in breaking bad is non functional. It isn't an autoclave but a vacuum pot. Check out this video from inside breaking bad which explains it doesn't actually work! <a href="https://www.youtube.com/watch?v=VY0GCYJlpwk" rel="nofollow noreferrer">https://www.youtube.com/watch?v=VY0GCYJlpwk</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Why are there peaks in electronegativities in d-block elements? (score [77714](https://stackoverflow.com/q/33611) in 2015)

#### Question
Looking at the Pauling electronegativities in the Periodic Table (below, from <a href="http://chemwiki.ucdavis.edu/Physical_Chemistry/Physical_Properties_of_Matter/Atomic_and_Molecular_Properties/Electronegativity/Allred-Rochow_Electronegativity" rel="noreferrer">ChemWiki</a>):  

<img src="https://i.stack.imgur.com/80wJk.gif" alt="enter image description here">  

Asides from the overall trend of increasing electronegativity across and up the Periodic Table (towards fluorine), there seems to be a minor peak in the first 3 periods of the $d$-block elements, this peak becomes more pronounced as you go down the $d$-block, with the most noticable peaks in Periods 5 and 6 - seemingly the reverse of the overall trend. This is shown in the graph below (<a href="http://2012books.lardbucket.org/books/principles-of-general-chemistry-v1.0/s11-the-periodic-table-and-periodi.html" rel="noreferrer">Image source)</a>:  

<img src="https://i.stack.imgur.com/xitIQ.jpg" alt="enter image description here">  

In the ChemWiki page, there is also a reference to the Allred-Rochow Electronegativity Scale, which also has peaks occurring most prominently in Periods 4 and 6:  

<img src="https://i.stack.imgur.com/nHwui.png" alt="enter image description here">  

<a href="https://de.wikipedia.org/wiki/Elektronegativit%C3%A4t#Allred-Rochow-Skala" rel="noreferrer">Image source</a>  

The Wikipedia page <a href="https://en.wikipedia.org/wiki/Electronegativity#Methods_of_calculation" rel="noreferrer">Electronegativity</a> details several methods of calculation, which brings into question how well-defined the electronegativity values are; however, there still seems to be the peaks occurring, particularly in Periods 5 and 6, and to a lesser extent in Period 4.  

<strong>What is the reason for these electrongativity peaks in the $d$-block?</strong>  

#### Answer accepted (score 1)
You should know that closeness to filling a shell and atomic size are the reasons for the overall electronegativity trend. This also applies to the subshells, how close is an element to filling, or half-filling, a subshell? How large is the atom?  

The atomic size trend for the d subshell is opposite to that of the overall trend. In period 4 the 3d subshell is deep in the core orbitals and the electron density is high, whereas in the lower periods the d orbital is more diffuse and can more easily accommodate more electrons, leading to a better energy payoff for completing the subshell. For the elements that take s electrons to fill the d subshell, this energy payoff is even greater from then filling the s subshell as they are very diffuse.  

#### Answer 2 (score -5)
The peaks in electronegativity for elements may be named as groups as next:  

<p>V Cr Mn has a peak and then Mn drops down. Iron is the key as shown next.
Zr Nb Mo has a peak and then a a plateau. Zirconium is the key as shown next.
My research is displayed : 
Periodic Table of Elements : Shape of Each Nucleus affecting electronegativity</p>

<p><a href="https://i.stack.imgur.com/BltJB.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/BltJB.jpg" alt="enter image description here"></a>
<a href="http://pyramidalcube.blogspot.com/2017/08/periodic-table-of-shapes-of-nuclei.html" rel="nofollow noreferrer">http://pyramidalcube.blogspot.com/2017/08/periodic-table-of-shapes-of-nuclei.html</a>
The shape of the nucleus affects the properties of the element. Notice how
Manganese is the last in a series from the carbon core cube-2, then iron starts the cube-3 shape. That transition across the Table causes the abrupt change in electronegativity.
Alan Folmsbee</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Can you make napalm out of gasoline and orange juice concentrate? (score [77443](https://stackoverflow.com/q/15606) in 2019)

#### Question
According to the novel <a href="http://en.wikipedia.org/wiki/Fight_Club_%28novel%29" rel="noreferrer">Fight Club</a> by <a href="http://en.wikipedia.org/wiki/Chuck_Palahniuk" rel="noreferrer">Chuck Palahniuk</a>:  

<blockquote>
  <p>The three ways to make napalm: One, you can mix equal parts of
  gasoline and frozen orange juice concentrate. Two, you can mix equal
  parts of gasoline and diet cola. Three, you can dissolve crumbled cat
  litter in gasoline until the mixture is thick.</p>
</blockquote>

The <a href="http://en.wikipedia.org/wiki/Napalm" rel="noreferrer">napalm</a> is originally called napalm because is mixture of <a href="http://en.wikipedia.org/wiki/Naphthenic_acid" rel="noreferrer"><b>na</b>phthenic acid</a>  and <a href="http://en.wikipedia.org/wiki/Palmitic_acid" rel="noreferrer"><b>palm</b>itic acid</a>. This makes me very skeptic about it being created by gasoline and juice. Also I see no reason for it to be frozen.  

The only thing that sounds realistic to achieve the sticky effect is the use of cat litter - but you could as well just use dry dirt, couldn't you? And dirt doesn't really burn so you're weakening the burning effect.  

#### Answer accepted (score 15)
Here's an excerpt from an interview with the author of Fight Club, Chuck Palhniuk.  

<blockquote>
  How to make Napalm with Frozen Orange Juice and Gasoline?  
  
  Well, Ed Norton changed one ingredient in every one to make them useless. So, that really pissed me off because I really research those really well. Actually its styrofoam and gasoline - it make the most incredible explosive.  
</blockquote>

<a href="http://www.dvdtalk.com/interviews/chuck_palahniuk.html">http://www.dvdtalk.com/interviews/chuck_palahniuk.html</a>  

So no, Fight Club does not accurately convey any of the recipes. All were clearly modified. And most likely for safety reasons - i.e. you wouldn't want someone to walk out the theatre with a "bright" idea. On the other hand I would still expect a mixture of gasoline and orange juice concentrate to be rather flammable ...   

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Why are sigma bonds stronger than pi bonds? (score [76326](https://stackoverflow.com/q/6244) in 2014)

#### Question
Why are sigma bonds stronger than pi bonds?   

#### Answer accepted (score 11)
The reason behind this is the orientation of the overlapped orbitals. Sigma bonds result from head-on(co-axial) overlapping while pi bonds are outcome of lateral(para-axial) overlapping. Here is a pictorial representation of ethene(sp<sup>2</sup> hybridized C atoms) :    

<img src="https://i.stack.imgur.com/g7mqW.jpg" alt="enter image description here">   

<strong><em>The greater the extent of overlapping, the higher the probability of finding the valence  electrons in between the nuclei and hence the bond will be stronger &amp; shorter.</em></strong>   

In MOT, this can be explained using <a href="http://en.wikipedia.org/wiki/Orbital_overlap" rel="nofollow noreferrer">Overlap Integral</a>. This is how Atkins depicts it :  

<img src="https://i.stack.imgur.com/bJicn.png" alt="enter image description here">         

<strong><em>In simple terms, after forming a sigma-bond (a pre-requisite for pi-bonds), the two atoms get locked along the inter-nuclear axis. As a result, the orbitals available for pi-bonding can only partially overlap, thus forming a weaker bond.</em></strong>     

#### Answer 2 (score 1)
As stated previously, it is due to the head-on overlap of sigma bonds and the lateral overlap of pi-bonds.  

The smaller overlap of pi bonds also explains why double and triple bonds basically exist only for 2nd row elements (C,N,O especially) and not for higher row elements. A C=C bond has a length of 133 pm. A Si-Si bond length is at around 186 pm, therefore the contribution of the pi-integral overlap is almost negligible.   

The inability of Silicium  to form strong pi bonds is also one of the answer why life on earth is carbon based and not silicium based, since the richness of organic chemistry is in part due to the ability of carbon to form strong double and triple bonds.  

#### Answer 3 (score -1)
Pi bonds involve sideways overlap while sigma bond involves head on or axial overlap. Axial overlaps have higher degree of overlapping than sideways overlap.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: After completing an experiment, a student finds that the percentage yield exceeded 100%. What could have occurred to the sample to lead to this? (score [75806](https://stackoverflow.com/q/32699) in )

#### Question
I am looking for a general answer; nothing too detailed. And no. This is not a homework question. It happened to me in lab and I am wondering what error I could have committed.  

#### Answer accepted (score 9)
Below is a basic example.    

If percent yield is based on a mass, then a >100% yield can result from a product contains materials that should not be there.  For instance, a product that should be anhydrous may not be completely dry and water would add mass to the product increasing your yield.  Other present contaminants can also do this and can even appear from a product that reacted with the surrounding atmosphere.  

#### Answer 2 (score 9)
Below is a basic example.    

If percent yield is based on a mass, then a >100% yield can result from a product contains materials that should not be there.  For instance, a product that should be anhydrous may not be completely dry and water would add mass to the product increasing your yield.  Other present contaminants can also do this and can even appear from a product that reacted with the surrounding atmosphere.  

#### Answer 3 (score 4)
Imagine a reaction where your starting material is cleaved and the product has a lower molecular weight. If the conversion is incomplete and the product contaminated with some starting material, the resulting weight may suggest a yield higher than 100%.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Why DNA is negatively charged and what makes it so? (score [75287](https://stackoverflow.com/q/24791) in 2016)

#### Question
<ol>
<li>What part in the strand contributes to the overall non neutral charge?</li>
<li>DNA is not isolated in the body, so what keeps it stable while being charged?</li>
<li>Why is it important for DNA to be charged?</li>
</ol>

#### Answer accepted (score 16)
As cibrail said, DNA is a polymer of nucleotides. They join themselves through phosphodiester bonds (a specific kind of covalent bond) that can grow to as much as millions of nucleotides.  

<h5>What part in the strand contributes to the overall non neutral charge?</h2>

The reason why DNA is negatively charged is the phosphate group that makes up every nucleotide (pentose + nitrogenous base + phosphate). When forming part of the phosphodiester bond, they retain 1 of 2 negative charges (the other being lost to form the other ester bond to a new pentose, that's why the bond is called "phospho-di-ester").  

<img src="https://i.stack.imgur.com/jJqx9.jpg" alt="Phosphodiester bond">  

Lehninger 5th edition. Part of figure 25-5  

<h5>DNA is not isolated in the body, so what keeps it stable while being charged?</h2>

The main molecules in charge of that are proteins called <strong>histones</strong>. They have alkali features and positive charge, and so, they neutralize these negative charges. On the other hand, that's not the main point of histones. Histones play a really important key role in the regulation and compaction of DNA within the nucleus of the cell, and are important targets of diverse molecules that want to alter DNA structure and function:  

<img src="https://i.stack.imgur.com/xnUGe.jpg" alt="Histones">  

Lehninger 5th edition.Figure 24-26  

<h5>Why is it important for DNA to be charged?</h2>

<p>It has great importance because cell machinery is adapted to that property. If DNA wasn't negatively charged, the structural fundamentals of interactions between DNA and transcription factors would be completely different. 
Thanks to the fact that it is negatively charged, it becomes spontaneously pretty straight when denaturalised, because negative charges repel themselves. It forms very wide curves.
And of course, histones wouldn't be able to join DNA and exert their key regulating functions.</p>

#### Answer 2 (score 3)
DNA is basically a polymer of nucleotides. These are held together by covalent bonds formed between the phosphate groups, each of which forms and ester with a hydroxyl group of the pentose of the NEXT nucleotide. This uses two of the three acidic 'OH' groups of the acid, leaving the last free to ionize. This ionization leaves a negative charge on each phosphate group.  

These charges allow the DNA strands to band to protein molecules which stabilize the structure, giving a nucleoprotein complex.  

<p>This complex helps stabilize the DNA—which as important in several ways<br>
– The DNA molecules are VERY long and easily broken<br>
– particularly when being moved etc at cell division</p>

#### Answer 3 (score 2)
DNA contain negative charge because the presence of phosphate group. Generally, hydrogen is not shown in DNA structure.   

DNA  

There are 3 hydrogens in phosphoric acid, each of them leaves as:  

<p>1 H joins with 3' -OH of previous nucleotide to form $\ce{H2O}$ during DNA replication.<br>
1 OH joins with H of next nucleotide to form $\ce{H2O}$ during DNA replication.<br>
1 H is released as $\ce{H+}$ (remember it was phosphoric acid), hence giving rise to the acidic character of DNA (remember it is deoxyriboNucleic acid).</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Why are bonds ionic when the electronegativity difference between bonded atoms is greater than 1.7? (score [74856](https://stackoverflow.com/q/9222) in 2017)

#### Question
I'm learning about how to recognise whether a bond is ionic or covalent, based on the difference in electronegativity between the two bonding partners, $\Delta \chi$.  

What I have now is a formula:  

<ul>
<li>If $\Delta \chi = 0$, then the bond is nonpolar</li>
<li>If $0 &lt; \Delta\chi \leq 1.7$, then the bond is polar covalent</li>
<li>If $\Delta \chi &gt; 1.7$, then the bond is ionic</li>
</ul>

But I don't know how scientists determined that formula, the history of it and which experiment indicates that formula.  

#### Answer accepted (score 18)
The first thing to consider is the difference between covalent and ionic bonding, from the UCDavis ChemWiki site <a href="http://chemwiki.ucdavis.edu/Organic_Chemistry/Fundamentals/Ionic_and_Covalent_Bonds" rel="noreferrer">Ionic and Covalent Bonds</a>,  

<blockquote>
  In ionic bonding, atoms transfer electrons to each other. Ionic bonds require at least one electron donor and one electron acceptor. In contrast, atoms that have the same electronegativity share electrons in covalent bonds since donating or receiving electrons is unfavorable.  
</blockquote>

The electron donor has a low electronegativity and the electron acceptor has a higher elelctronegativity - so there is a difference in electronegativity $\Delta{EN}$, effectively creating a positive and negative end, an example is below:  

<img src="https://i.stack.imgur.com/QmjsA.png" alt="enter image description here">  

Image source: <a href="http://www.spring8.or.jp/en/news_publications/press_release/2011/111020/" rel="noreferrer">Japan Synchrotron Radiation Research Institute (JASRI)</a>  

When the differences in electronegativities of various compounds are graphed against % ionic character, as shown below:  

<p><img src="https://i.stack.imgur.com/ikx1x.gif" alt="enter image description here">
Image source: <a href="http://www.chem.ufl.edu/~itl/4411/lectures/lec_13.html" rel="noreferrer">University of Florida Chemical Bonding page</a> </p>

Values of $\Delta{EN}$ greater than 1.7 correspond to an ionic character of greater than 50%, from the University of Florida website:  

<blockquote>
  What determines how the electrons are shared is the relative electronegativity (electron greed) of the bonding atoms. The degree of polarity or degree of ionic bonding of any given bond can vary continuosly zero to nearly 100%. We normally say that bonds between atoms with electronegativity difference ($\Delta{EN}$) greater than 1.7 are ionic, although this really means only more than about half ionic in character.  
</blockquote>

Another resource is from the University of Washington <a href="http://courses.washington.edu/bhrchem/c152/Lec23.pdf" rel="noreferrer">Lecture 23: Ionic to Covalent Bonds</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: What is the difference between configuration and conformation in stereochemistry? (score [74612](https://stackoverflow.com/q/18836) in 2015)

#### Question
I understand conformation to be any spacial arrangement of atoms that can be achieved through rotation of a single bond. I understand configuration to be the disposition of atoms/groups in space. However, would a conformational isomer also be a configurational isomer since the groups are arranged differently in space?    

#### Answer accepted (score 7)
<p>I recommend you this webpage: <a href="http://worldofbiochemistry.blogspot.com/2012/09/conformation-vs-configuration.html" rel="nofollow noreferrer">http://worldofbiochemistry.blogspot.com/2012/09/conformation-vs-configuration.html</a>.
Configuration and conformation are two concepts are often used interchangeably, but represent very different things. The conformation regards the relative spatial orientation of a portion of a molecule relative to another. Thus, it is an aspect that is not directly related to the covalent bonds that are established within the molecule, but with their possible rotation.</p>

<img src="https://i.stack.imgur.com/UC4uz.png" alt="enter image description here">  

When we talk about rotation around covalent bonds, we are only referring to the single bonds, as they are the only ones that can suffer rotation. Basically this concept is easily understood if we think that the bounds work as an axis...  

<p>It should be noted that when we speak of different conformations, it does not necessarily involve all the covalent bonds of a molecule, it can account only for one or few of them.
 Taken together, it is possible to convert one conformation to another without <strong>cleaving or forming chemical bonds</strong>, simply by rotating some simple covalent bonds. <strong><em>Thermal energy at room temperature is sufficient to rotate some simple covalent bonds</em></strong>.</p>

The configuration is a concept that is related to the order by which different substituents linked to the same central atom establish covalent bonds. That means, in this case it is clearly an aspect that is a direct consequence of the covalent backbone of molecules.  

<img src="https://i.stack.imgur.com/Od9gd.jpg" alt="enter image description here">  

To change the configuration, you <strong>must always cleave and form new covalent bonds.</strong>..<strong><em>This costs a lot of energy!!</em></strong>  

In conclusion, the concept conformation encompasses portions of a molecule which are not directly linked to the same atom and do not involve the covalent backbone of the molecules, while the configuration comprehends parts of the molecule which are bound to the same atom, which means that there is a direct involvement of the covalent bounds of the molecule.  

#### Answer 2 (score 1)
Configuration is arrangement of atom in three dimensional space around the molecule. Here there is no free rotation of atom usually we use configuration in optical isomerism and conformation is the one which allows free rotation of single bond with in  the molecule and we use conformation to represent the biomolecule structure.   

#### Answer 3 (score -1)
Configuration differs from conformation by a fact that conformations are only due to the orientation of the atoms in molecule around the covalent bond considering the bond as an axis.  And changing the configuration causes the cleavage and formation of new chemical bonds.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: What makes Coke acidic? (score [74072](https://stackoverflow.com/q/2859) in 2015)

#### Question
What makes Coke and other soft drinks acidic?  These drinks are carbonated, so a freshly-opened can should have a lot of dissolved carbonic acid, but the ingredients also lists phosphoric acid.  Would flat Coke be significantly less acidic than carbonated Coke?    

#### Answer accepted (score 15)
If you look at the list of ingredients, you will find that Coca-Cola and many other brands contain phosphoric acid (food grade - don't worry). This is probably the dominant cause of acidity. Citric acid is another common component. Of course, the carbon dioxide is also acidic, but weakly, so there should be very little difference between carbonated and flat.  

#### Answer 2 (score 3)
Flat coke is less acidic than carbonated coke. I did a lab report on this topic, and found that Carbonated coke had a concentration of around 0.131M whereas flat coke had a concentration of 0.064M. I guess we can assume that the carbonic acid that's dissolved in Coke makes up a large proportion of the acidity.  

#### Answer 3 (score 0)
Mostly Carbonic acid, probably. Because it is the only species in coke, that can escape in the form of gas.   

Just shake a coke, or heat it and see how much of the acidity is gone. It is the part that is due to $\ce{CO2}$.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: What is Fajans rule? (score [72825](https://stackoverflow.com/q/64968) in 2017)

#### Question
when reading about polar covalent bond I came across the rule called 'Fajan's Rule' but could not find the explanation nor the derivation   

#### Answer accepted (score 12)
<strong>Fajans' rules</strong> (note the difference) were formulated in 1923 <a href="https://en.wikipedia.org/wiki/Fajans&#39;_rules" rel="noreferrer">by Kazimierz Fajans</a>.  

They are a method for predicting ionic vs. covalent that predates electronegativity (by three decades) and make use of ionic and atomic radius data that was becoming available through x-ray crystallography.   

To use Fajans' Rules, assume your binary compound is ionic and identify the potential cation and anion.  

By Fajans' Rules, compounds are more likely to be ionic if: there is a small positive charge on the cation, the cation is large, and the anion is small. For example, $\ce{NaCl}$ is correctly predicted to be ionic since $\ce{Na+}$ is a larger ion with a low charge and $\ce{Cl-}$ is a smaller anion.  

Compounds are more likely to be covalent if: there would be a large positive charge on the cation, the cation would be small, and the anion would be large. For example, $\ce{AlI3}$ is correctly predicted to be covalent since it would have a small cation with a high charge and a large anion.   

Note that Fajans' Rules have been largely displaced by Pauling's approach using electronegtivites. However, the remnants of Fajans' Rules are found in <a href="https://en.wikipedia.org/wiki/HSAB_theory" rel="noreferrer">Hard-Soft Acid-Base Theory</a>, which predicts bonding properties based on polarizability (which is based on size and charge). Binary compounds having a soft acid and/or a soft base are often covalent.  

<p>$$\begin{array}{|c|c|c|c|}\hline
\mathrm{compound} &amp; \mathrm{Fajans} &amp; \mathrm{Pauling} &amp; \mathrm{HSAB}\\ \hline
\ce{NaCl} &amp; \mathrm{low + charge \\ larger\ cation \\ smaller\ anion \\ionic} &amp; \mathrm{3.16-0.93 = 2.19\\ ionic} &amp; \mathrm{hard\ acid \\ borderline\ base \\ ionic}  \\ \hline
\ce{AlI3} &amp; \mathrm{high + charge\\ smaller\ cation \\ larger anion \\covalent} &amp; \mathrm{2.66 - 1.61 = 1.05 \\covalent} &amp; \mathrm{hard\ acid\\ soft\ base \\covalent} \\ \hline
\end{array}$$</p>

#### Answer 2 (score 3)
Fajans' rule states that a compound with low positive charge, large cation and small anion has ionic bond where as a compound with high positive charge, small cation and large anion are covalently bonded.  

<p>For high charge, small cation will have more polarizing power. 
Where as larger is the size of anion, more will be the polarization of anion. Because if this electron cloud of anion is more diffused. This makes the anion easily polarizable.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: How can carbon dioxide be converted into carbon and oxygen? (score [72561](https://stackoverflow.com/q/915) in 2018)

#### Question
How can $\ce{CO2}$ be converted into carbon and oxygen?  

$$\ce{CO2 -&gt; C + O2}$$  

Alternatively:  

$$\ce{CO2 + ? -&gt; C + O2}$$  

I'm aware that plants are capable of transforming $\ce{CO2 + H2O}$ to glucose and oxygen via photosynthesis, but I'm interested in chemical or physical means rather than biological.  

#### Answer accepted (score 31)
In my opinion, the catalytic, solar-driven conversion of carbon dioxide to methanol, formic acid, etc. is much more interesting and promising, but since Enrico asked for the conversion of carbon dioxide to carbon itself:  

The group around <strong>Yutaka Tamaura</strong> was/is active in this field. In one of their earlier publications,<sup>[1]</sup> they heated magnetite ($\ce{Fe3O4}$) at 290 °C for 4 hours in a stream of hydrogen to yield a material which turned out to be stable at room temperature <strong>under nitrogen</strong>. This material, $\ce{Fe_{3+\delta}O4}$ $(\delta=0.127)$, i.e. the metastable cation-excess magnetite is able to incorporate oxygen in the form of $\ce{O^2-}$.   

Under a $\ce{CO2}$ atmosphere, the oxygen-deficient material converted to "ordinary" $\ce{Fe3O4}$ with <strong>carbon deposited on the surface</strong>.  

This remarkable reaction however is <strong>not catalytic</strong>, but a short recherche showed that the authors have published a tad more in this field. Maybe somebody else finds a a report on a catalytic conversion among their publications.   

<ol>
<li>Tamaura, Y.; Tahata, M. Complete reduction of carbon dioxide to carbon using cation-excess magnetite. <em>Nature</em> <strong>1990,</strong> <em>346</em> (6281), 255–256. <a href="https://doi.org/10.1038/346255a0" rel="nofollow noreferrer">DOI: 10.1038/346255a0</a>.</li>
</ol>

#### Answer 2 (score 9)
Electrolysis of carbonates in anhydrous environment can produce either $\ce{CO + O_2}$ or $\ce{C + O_2}$, <sup>[ref]</sup> depending on conditions. A base, remaining in electrolyzed liquid then can capture carbon dioxide from other sources and be recirculated.  

<strong>Reference:</strong> L. Massot, P. Chamelot, F. Bouyer, P. Taxil; Electrodeposition of carbon films from molten alkaline fluoride media. <em>Electrochimica Acta</em>, <strong>2002</strong>, <em>47</em> (12), 1949-1957. <a href="https://doi.org/10.1016/S0013-4686(02)00047-6" rel="nofollow noreferrer">https://doi.org/10.1016/S0013-4686(02)00047-6</a>   

#### Answer 3 (score 7)
<p><strike>Use</strike> Exploit the fact that burning magnesium continues to burn in atmosphere of carbon dioxide.
$${\ce{Mg}}+\color{\red}{\ce{CO2}}\to \ce{MgO}+\color{\red}{\ce{C}} $$</p>

Now you can electrolyse your mixture :   

$$\ce{MgO}+\ce{H2O}\to \ce{Mg(OH)2} $$  

$$\ce{4OH-}\to\color{\red}{\ce{ O2}}+\ce{2H2O}+\ce{4e-}$$  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: What is the difference between a coefficient and a subscript in a chemical equation? (score [71582](https://stackoverflow.com/q/15067) in 2017)

#### Question
Observe the following parts of an electron transfer equation:  

<p>\begin{align}
\ce{2Li + S &amp;-&gt; Li2S}\tag{1}\\
\ce{2Al + 3Br2 &amp;-&gt; 2AlBr3}\tag{2}
\end{align}</p>

The first equation says $\ce{Li}$ with a small subscript 2, however the second one says Al with a coefficient 2 instead of $\ce{Al2}$.  

Can someone please explain this discrepancy and inconsistency I'm seeing? Why is lithium in the first reaction written with a small $2$, while in the second one aluminium is written with a big $2$? Why can't both of them be written in the same way? Does it matter? Is there a difference? How do I tell which one to use?  

#### Answer accepted (score 8)
<blockquote>
  Why can't both of them be written in the same way? Does it matter? Is there a difference?  
</blockquote>

Yes, there is a difference, and it does matter! The placement of subscripts and coefficients tells you how the substances are put together on the atomic level.  

Let's look at the first equation:  

<p>$$
\ce{2Li + S -&gt; Li2S} 
$$</p>

This one indicates that two moles of lithium combine with one mole of sulfur to form one mole of lithium sulfide. $\ce{Li2S}$ is called a <a href="http://en.wikipedia.org/wiki/Formula_unit" rel="noreferrer">formula unit</a> or <a href="http://en.wikipedia.org/wiki/Emprical_formula" rel="noreferrer">empirical formula</a>, and tells you the smallest whole-number ratio of atoms that make up a "building block" of the compound. In this case, the smallest building block of a lithium sulfide crystal would contain two lithium ions for every one sulfide ion. Here's a picture from <a href="http://en.wikipedia.org/wiki/Lithium_sulfide" rel="noreferrer">wikipedia</a> to demonstrate:  

<img src="https://i.stack.imgur.com/0gKDX.png" alt="Lithium sulfide crystal structure">  

From this, we can learn that:  

<blockquote>
  <strong>Coefficients</strong> tell us the number of moles, molecules, or formula units of a species  
</blockquote>

and  

<blockquote>
  <strong>Subscripts</strong> tell us how many atoms or ions there are <em>within</em> a compound  
</blockquote>

Now if we look at the second equation:  

<p>$$
\ce{2Al + 3Br2 -&gt; 2AlBr3}
$$</p>

we can see that in this case, it take 2 moles of aluminum to combine with three moles of bromine to produce two moles of aluminum tribromide. If it were instead $\ce{Al2Br6}$, that would indicate a different formula unit - it would imply a different compound.  

So to answer your question:  

<blockquote>
  Why is Lithium in the first reaction written with a small 2, while in the second one Aluminium is written with a big 2  
</blockquote>

This is because in the first equation, the product has two lithium ions for every one sulfur in the formula unit, while in the second, two moles of aluminum tribromide are produced for every two moles of aluminum, but the formula unit contains only one aluminum atom and three bromine atoms.  

For your final question:  

<blockquote>
  How do I tell which one to use?  
</blockquote>

You would have to know what the formula of the product is. In these examples, you can predict it by assuming that they are ionic compounds and balancing charges. You would get the correct answer, even though this assumption is not true for the second equation (it is actually a covalent compound, and you would just get the right answer by luck).  

#### Answer 2 (score 2)
The question is quickly answered when you consider the ionic forms of the elements you present. It is easy if you break down the reaction into simple oxidation and reduction reactions:  

<p><strong>Oxidations</strong>
$$ \ce{Li -&gt; Li+ + e-} $$
$$ \ce{Al -&gt; Al^{3+} + 3e-} $$</p>

<p><strong>Reductions</strong>
$$ \ce{S + 2e- -&gt; S^{2-}} $$
$$ \ce{Br2 + 2e- -&gt; 2Br-} $$</p>

<p>Since the resulting compounds of your reactions are neutral, all we have to do is to match up the starting compounds in the right amounts to get to the right final products. Retrosynthetically speaking:
$$ \ce{Li2S &lt;- 2Li+ + S^{2-} &lt;-[\mathrm{red}] 2Li+ + 2e- + S &lt;-[\mathrm{ox}] 2Li + S } $$</p>

<p>Or if you go from the start:
$$ \ce{2Al + 3Br2 -&gt;[\mathrm{ox}] 2Al^{3+} + 6e- + 3Br2 -&gt;[\mathrm{red}] 2Al^{3+} + 6 Br- -&gt; 2AlBr3 (-&gt; Al2Br6)} $$</p>

I put the last step in parentheses because usually we give formulae of ionic compounds with the smallest integer amount possible, which would be $\ce{AlBr3}$ and not $\ce{Al2Br6}$. This should answer your question about which one to use.  

<blockquote>
  Is there a difference?  
</blockquote>

Yes. For example $\ce{AlCl3}$, a lewis acid, can dimerize to $\ce{Al2Cl6}$. Which one you mean depends on the formula you give and can be a barrier of understanding in a conversation.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Why are metal oxides basic and non-metals' acidic or neutral (score [70054](https://stackoverflow.com/q/19494) in 2017)

#### Question
Recently I came across the fact: <em>Metal oxides basic and non-metals' acidic or neutral.</em>  

Searching for it, partly my query is solved, as I found:  

<p>Metal oxides or $\ce{O2-}$ forms $\ce{OH-}$ after hydrolysis in the following reaction so metal oxides are basic in aqeous solutions.
$$\ce{O2- + 2H2O-&gt;4OH-}$$</p>

I think this might happen as metal form ionic compunds and non-metals form covalent and some of them may not even react tus neutral.  

I've got only a little $5\%$ of the exact reason, therefore I wish if someone could explain the whole process/fact. I considered Arhenius concept.  

<strong>Note</strong> My question is partly answered <a href="https://chemistry.stackexchange.com/questions/1215/why-does-polonium-form-acidic-oxides">here</a>, but is not satisfactory.  

#### Answer accepted (score 3)
<p>We have learnt that metallic oxides are basic nature. This is because the oxides of metals like $\ce{MgO}$ or $\ce{CaO}$ or $\ce{Na2O}$ form hydroxides in their aqueous solutions.
For example:
$$\ce{K2O + H2O -&gt; 2KOH}$$
$$\ce{MgO + H2O -&gt; Mg(OH)2}$$</p>

<p>But when non-metallic oxides dissociate into their constituent ions in water, they give $\ce{H+}$ ions in their aqueous solutions forming acids
For example:
$$\ce{CO2 + H2O -&gt; H2CO3}$$
$$\ce{SO3 + H2O -&gt; H2SO4}$$</p>

#### Answer 2 (score 0)
Metal oxides like $\ce{CaO}$ and $\ce{Na2O}$ react with water and give hydroxides:  

$\ce{CaO + H2O &lt;=&gt; Ca(OH)2}$  

$\ce{Na2O + H2O &lt;=&gt; 2 NaOH}$  

While non-metal oxides like $\ce{CO2}$ and $\ce{SO2}$ react with water and give acids:  

$\ce{CO2 + H2O &lt;=&gt; H2CO3 &lt;=&gt; H+ + HCO3-}$  

$\ce{SO2 + H2O &lt;=&gt; H2SO3 &lt;=&gt; H+ + HSO3-}$  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: What is the difference between steric strain and torsional strain? (score [69918](https://stackoverflow.com/q/38323) in 2015)

#### Question
I know that in ethane, the extra energy present in the eclipsed conformer is caused by torsional strain.   

In butane, the gauche conformation experiences steric strain. But the eclipsed conformation at 0 degrees has substantial amounts of both steric strain and torsional strain.   

What is the difference?   

#### Answer accepted (score 11)
<strong>TL;DR</strong> Torsional strain can be thought as the repulsion due to electrostatice forces between electrons in adjacent MOs. Meanwhile steric strain (also known as van der Waals strain) can be thought as the repulsion when two bulky groups which are not directly bonded to each other become too close to each other and hence there isn't enough space for them.  

Here is the more detailed version.  

<strong>Torsional Strain</strong>  

Lets consider an ethane molecule. The C-C sigma bond is free to rotate and in principle there are an infinite number of possible conformations. However only 2 are significant, these are staggered and eclipse conformations. Different conformers are usually drawn as Newman projections as they can easily be compared with each other. Below are the Newman projections for the eclipsed and staggered conformer:  

<a href="https://i.stack.imgur.com/2UumA.png" rel="noreferrer"><img src="https://i.stack.imgur.com/2UumA.png" alt="enter image description here"></a>  

The staggered conformer is the most stable conformer while the eclipsed conformer is the least stable conformer. The staggered conformer is approximately $\mathrm{12~kJ~mol^{-1}}$ more stable than the eclipsed conformer. This energy difference between this maxima and minima is known as the <strong>torsional barrier</strong>.   

So what is torsional strain? The reason for the eclipse conformer being higher energy than any other conformers is due to the destabilising electrostatic repulsion between the electron pairs of the C-H sigma bonds on the two carbons. Furthermore, there also exists a stabilising feature which is greater in the staggered conformer. In the staggered conformer there is a constructive orbital interaction involving the bonding and anti-bonding MOs of the adjacent H atoms. This results in hyper conjugation which stabilises the compound.   

<a href="https://i.stack.imgur.com/J5JpN.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/J5JpN.jpg" alt="enter image description here"></a>  

The two effects that I have mentioned above is what torsional strain refer to. So you can think of torsional strain as the strain that is the result of electrostatic forces.   

<strong>Steric Strain</strong>  

Now lets consider butane. Rotation of the $\mathrm{C_2-C_3}$ sigma bond also lead to infinite possible conformers. However there are 4 main conformers shown below:  

<a href="https://i.stack.imgur.com/fgsHn.png" rel="noreferrer"><img src="https://i.stack.imgur.com/fgsHn.png" alt="enter image description here"></a>  

Here there are 2 types of eclipsed conformers which are the least stable of the conformers. The most unstable one is known as the <strong>eclipsed syn form</strong>. The syn form is approximately $\mathrm{20~kJ~mol^{-1}}$ higher in energy than the staggered conformer. The reason for this can partly be attributed to torsional strain as there is repulsion between the electrons in the sigma bonding orbitals. However also it can largely be attributed to the repulsion of the two relatively bulky methyl groups as they become too close to each other and there isn't enough space for them.  

This repulsion is known as steric strain. Therefore steric strain can be define as the repulsion which occurs when non-bonded groups which are not directly bonded approach each other too closely. This repulsion only exists for bulky substituents, such as methyl or ethyl groups. So in ethane there is no steric hindrance as the hydrogen atoms are not that bulky.   

#### Answer 2 (score 4)
For simplicity's sake, <strong>torsional strain</strong> is defined as as the strain experienced by the bonds when conformations are not staggered. So, at any angle other than 60, 120, or 180, there is torsional strain. Additionally, <strong>torsional strain</strong> can only ever exist in atoms separated by only <strong>three bonds</strong>.   

Therefore, the hydrogens in ethane only ever experiences torsional strain, and it is zero (technically minimized) when it's staggered.  

<a href="https://i.stack.imgur.com/UsLMl.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/UsLMl.png" alt="Ethane"></a>  

<strong>Steric strain</strong> exists only in molecules who have four or more bonds, since <strong>steric strain</strong> is defined as the repulsion felt between atoms at four or more bonds separated from each other forced closer than their van der Waals radius would typically allow.  

In the butane below, there is torsional strain between the two central carbons and hydrogens from each central methylene group. However, atoms separated by four or more bonds experience steric strain. Steric hindrance will never be zero, but it can be minimized when the atoms are separated by as much space as possible.  

<a href="https://i.stack.imgur.com/fRaVE.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/fRaVE.png" alt="enter image description here"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: Why do different substances have different boiling points? (score [69892](https://stackoverflow.com/q/180) in 2012)

#### Question
For example, why does for example oxygen turn into gas at a much lower temperature than water?  

Does it have anything to do with the molecular structure? A water molecule does have a more complex structure than oxygen, though the R-410A (a mixture of two gases commonly used in heating pumps) is much more complex than water, and it boils at -48.5 degrees Celsius.  

#### Answer accepted (score 32)
The boiling point of a liquid depends on the intermolecular forces present between the atoms or molecules in the liquid since you must disrupt those forces to change from a liquid to a gas. The stronger the intermolecular forces, the higher the boiling point.   

Two oxygen molecules are attracted to each other through London dispersion forces (induced temporary dipoles between the molecules) while water molecules are attracted to each other by hydrogen bonding (attraction of the + dipole on H in one molecule to the – dipole on an oxygen in an adjacent molecule) that is relatively strong. (Hydrogen bonding is an important intermolecular force for molecules where H is directly covalently bonded to F, O or N, which are quite electronegative and thus form bond with H with a relatively strong dipole.) London dispersion forces become more important for atoms and molecules with more electrons. Dipole–dipole attractions are also important in some molecules.   

#### Answer 2 (score 0)
Because boiling point of different materials depend on the intermolecular forces present between the atoms. The stronger the intermolecular forces the higher the boiling point and the weaker the intermolecular forces the lower the boiling point.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: What is the white substance left behind after boiling down water (score [69835](https://stackoverflow.com/q/24182) in 2015)

#### Question
I was boiling down water in a stainless steel pot as an experiment the other day. When the water was completely vaporised, a white substance was left behind on the bottom of the pot. I tried rubbing it off the bottom, but it would not come off. I'm unsure what this substance is. What is this substance?  

#### Answer accepted (score 9)
These are minerals that are naturally present in "tap" water. Chemically, they are most likely a mixture of calcium carbonate and magnesium carbonate, both of which are only very lightly soluble in water.  

As you boil away the water, these dissolved calcium/magnesium carbonates remain behind and their concentrations eventually become greater than their respective solubility limits. At this point they begin to precipitate out of the solution, forming the 'scale' you see on the pot.  Interestingly, while most salts become more soluble at higher temperatures, calcium carbonate is anomalous in that its solubility decreases as temperature increases (see the accepted answer <a href="https://chemistry.stackexchange.com/questions/4094/white-powder-observed-after-boiling-water-in-electric-kettle-for-many-weeks?rq=1" title="here">here</a>), which accelerates the precipitation process.  

The easiest way to get rid of them is to add a cup of white vinegar and let it sit in the pot. You might need to agitate the scale from time to time. You can boil the vinegar in the pot if you want, but it will stink! Over time, the vinegar will dissolve the precipitate, and you will see carbon dioxide bubbles forming. You can then pour out the vinegar and flush the pot with lots of water.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Why does the solubility of Group II hydroxides increase and the solubility of sulphates decrease down the group? (score [69529](https://stackoverflow.com/q/13607) in 2018)

#### Question
I know that, solubility of alkaline earth metal hydroxides increases down the group and solubility of alkaline earth metal sulfates decreases down the group.  

I wish to understand the reason for these trends.  

#### Answer accepted (score 4)
A few weeks ago I would have given the hard soft acid base theory (HSAB) explanation.  

I have heard this "trend" explained in this way:  Hydroxide is hard and sulfate is soft.  So, the harder ions are, the more soluble with sulfate and less with hydroxide.  

About a week ago I was playing around with some DH, lattice energy, and Ksp data and I found that barium seems to go against the "trend".  

I found these posts that show that many of the "trends" we are taught in chem class aren't as trendy as we are told.   

Look at this:  <a href="http://www.chemguide.co.uk/inorganic/group2/solubility.html" rel="nofollow">http://www.chemguide.co.uk/inorganic/group2/solubility.html</a>  

Is this a homework question or a curiosity question?  If the former, the "trend" isn't that trendy and the teacher should read the links above.  If the latter, do you know that barium salts tend to go against the "trend"?  

#### Answer 2 (score 4)
A few weeks ago I would have given the hard soft acid base theory (HSAB) explanation.  

I have heard this "trend" explained in this way:  Hydroxide is hard and sulfate is soft.  So, the harder ions are, the more soluble with sulfate and less with hydroxide.  

About a week ago I was playing around with some DH, lattice energy, and Ksp data and I found that barium seems to go against the "trend".  

I found these posts that show that many of the "trends" we are taught in chem class aren't as trendy as we are told.   

Look at this:  <a href="http://www.chemguide.co.uk/inorganic/group2/solubility.html" rel="nofollow">http://www.chemguide.co.uk/inorganic/group2/solubility.html</a>  

Is this a homework question or a curiosity question?  If the former, the "trend" isn't that trendy and the teacher should read the links above.  If the latter, do you know that barium salts tend to go against the "trend"?  

</section>

