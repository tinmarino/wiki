---
title: Puzzling <- StackExchange top 100
category: puzzling
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: Brooklyn 99 riddle: Weighing Islanders (score [1017514](https://stackoverflow.com/q/9979) in 2015)

#### Question
This one comes from this week's Brooklyn Nine-Nine episode!  

There is an island with 12 islanders. All of the islanders individually weigh exactly the same amount, except for one, who either weighs more or less than the other 11.   

You must use a see-saw to figure out whose weight is different, and you may only use the see-saw 3 times. There are no scales or other weighing device on the island.   

How can you find out which islander is the one that has a different weight?   

#### Answer accepted (score 14)
Divide them into 3 groups of 4 people.  

Put any two groups on each side of the see-saw. (First Use)  

<strong>Condition 1</strong>  

<hr>

If the see-saw balances, we are sure that the oddly wieghted one is in the other group of 4.  

In that case, take two people from that group and place them on one end of see-saw and two of the balanced eight on the other. (Second Use)  

<strong>Condition 1.1</strong>  

If the see saw balances, remove all but one from the seesaw and put one of the remaining two opposite them. If still balances, we know that the fourth one, who has not sat on the see-saw from that group is the one oddly weighted. (Third Use)  

<strong>Condition 1.2</strong>  

If the see saw is not balanced, remove one from each end. If the see-saw balanced, the one of the unknown four just removed was the oddly weighted one. Otherwise the one who stayed is the oddly weighted one.(Third Use)  

<strong>Condition 2</strong>  

<hr>

If the two groups of 4 don't balance remember which side was lighter, have three get off one end and the remaining person swap places with one of the other four. Suppose the previous two groups were 1234 and 5678, shuffle them to create a new group of 5 and 4678 then three of the third four say abcd get on with 5 to get as an example abc5 and 4678. (Second Use)  

<strong>Condition 2.1.1</strong>  

<p>If the position of seesaw does not change and as an example say 5678 and then 4678 are heavier, we know that either 6 or 7 or 8 is oddly weighted. Now put 7 on one end and 8 on the other.  If one is heavier they are the odd one otherwise it is 6. (Third Use)
<em>note</em> this works equally well if the group was lighter, just replace terms for appropriate identification.</p>

<strong>Condition 2.1.2</strong>  

If the seesaw reverses, ether 4 or 5 is the oddly weighted one. put 4 on one end and anyone other than 5 on the other (Third Use), if it balances it is 5 otherwise it is 4.  

<strong>Condition 2.1.3</strong>  

<p>If the seesaw balances we know that either 1 or 2 or 3 is oddly weighted.  Say as example 1234 were lighter.  Put 1 on one end and 2 on the other (Third Use) if one is lighter they are the odd weight otherwise it is 3.
<em>note</em> this works equally well if the group was heavier, just replace terms for appropriate identification.</p>

<hr>

Done - easy peasy  

<p>It is easier than everyone makes it.  A seesaw is binary.  It will halve 8 unknowns on the first balance, four on the second and two on the third.  Set it up so deduction eliminates everything else and your gold.
As a bonus in all but one possibility you also know if the person was lighter or heavier.</p>

(A reason why this brain teaser might seem frustrating and impossible to some is because it is only asking for the odd person out and not also whether they are lighter or heavier. It is impossible to know both for sure in only three steps.)  

<p>Edit: 
In 11/12 cases you know whether the person is lighter or heavier as the seasaw dictates it. The only case where you don’t is 1.1.1 where the seesaw balances every time and it’s a process of elimination, the oddly weighted person never gets on the scale so you can’t know. </p>

#### Answer 2 (score 5)
OK, I think I have it, now the problem of explaining it, here goes:   

We are going to name the islanders 1 2 3 4 5 6 7 8 9 10 11 12  

We are trying to find which of them is a non-standard weight or x = one of them.    

//are comments during explanation  

Use 1:    

1 2 3 4 against 5 6 7 8  

I)  1 2 3 4 = 5 6 7 8 then Use 2:  9 against 10    //9 10 11 or 12 are x  

```text
     A) 9 > 10 or 9 < 10 then Use 3:  9 against 11    //9 or 10 are x

          i)  9 > 11 or 9 < 11 then 9 = x

         ii)  9 = 11  then 10 = x

     B) 9 = 10 then Use 3:  9 against 11      //11 or 12 are x

          i) 9 > 11 or 9 < 11 then 11 = x

         ii) 9 = 11 then 12 = x
```

//Ok four down, eight to go, that was the easy part  

II)  1 2 3 4 > 5 6 7 8 then Use 2: 1 2 3 5 against 4 10 11 12  //10 11 12 are not x now  

```text
  A) 1 2 3 5 > 4 10 11 12 then Use 3: 1 against 2  //1 2 or 3 are x now and x is heavier than the rest

         i) 1 > 2 then 1 is x //x is heavier

        ii) 1 < 2 then 2 is x

       iii) 1 = 2 then 3 is x

  B) 1 2 3 5 < 4 10 11 12 then Use 3:  4 against 12 // 4 or 5 is x. The switched 4 and 5 caused a reversal

        i) 4 > 12 or 4 < 12 then 4 is x

       ii) 4 = 12 then 5 is x

 C) 1 2 3 5 = 4 10 11 12 then Use 3:  6 against 7   //6 7 or 8 are x and lighter than the rest 

        i) 6 > 7 then 7 is x

       ii) 6 < 7 then 6 is x

      iii) 6 = 7 then 8 is x
```

III) 1 2 3 4 &lt; 5 6 7 8  do the same process as II with appropriate adjustments being made.    

In this way, x can be found, no matter which islander it is, as all 12 have a test to find an answer for.    

Hope that makes sense. :D   

#### Answer 3 (score 3)
I can do this in one move, where no one gets off the see saw, and they only get on it once.  

<p>It is a see saw, not a giant scale! 
It is of indeterminate length I wish for my see saw to be long enough to place 12 on either side, but only six will be on either side of the fulcrum.</p>

<p>Now I have islanders 1-6 on side "A" and 7-12 on side "B"  both groups of six are as close to the fulcrum of the see saw in a single file line as possible, one side will fall, one side will rise.<br>
The side that rises will "scootch" down the length of the see saw, away from the fulcrum until both sides balance.<br>
The side that is lighter has the men switch positions getting closer or further from the fulcrum without coming on or off the see saw, after all of the positions have been tried, if the see saw does not move, it means all the men on that side are of equal weight, if the balance is lost, the last man to move before the balance is lost is the lighter man.<br>
If the light side men are all of equal weight, the heavy side is then ordered to switch positions until the balance is no longer achieved, when the balance is lost, the last man to move is the heavier man. </p>

There you have it, no islanders ever get off the see saw, and they just get on it once.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: Two doors with two guards - one lies, one tells the truth (score [925166](https://stackoverflow.com/q/2188) in 2017)

#### Question
You are a prisoner in a room with 2 doors and 2 guards. One of the doors will guide you to freedom and behind the other is a hangman --you don't know which is which.  

One of the guards always tells the truth and the other always lies. You don't know which one is the truth-teller or the liar either.  

You have to choose and open one of these doors, but you can only ask a single question to one of the guards.  

What do you ask so you can pick the door to freedom?  

#### Answer accepted (score 99)
<blockquote class="spoiler">
   If I asked what door would lead to freedom, what door would the other guard point to?  
</blockquote>

If you asked the truth-guard, the truth-guard would tell you that the liar-guard would point to the door that leads to death.  

If you asked the liar-guard, the liar-guard would tell you that the truth-guard would point to the door that leads to death.   

Therefore, no matter who you ask, the guards tell you which door leads to death, and therefore you can pick the other door.  

#### Answer 2 (score 48)
Choose a guard and ask him,   

<blockquote class="spoiler">
  "If I asked you 'are you standing in front of the freedom door?', would your reply be 'yes'?"  
</blockquote>

<ul>
<li>If you choose the truthful guard, he will give you an honest answer. Enter his door if he says "yes" and enter the other door otherwise.</li>
<li>If you choose the liar, he will lie about what his reply would be. Since that reply is also a lie, the two lies cancel out. Enter his door if he says "yes" and enter the other door otherwise.</li>
</ul>

#### Answer 3 (score 35)
Here is a twisted solution.  

<blockquote class="spoiler">
  <p> Go to any guard, point at a door and ask:<br>
 Among the propositions 1. "You are a liar", 2. "You will reply negatively" and 3. "This door leads to freedom", is there an odd number of true propositions?</p>
</blockquote>

<p>If you get the answer yes:<br>
If the guard is a truthteller, the number of truths is odd, 1. is false, 2. is false, so 3. must be true.<br>
If the guard is a liar, the number of truths is even, 1. is true, 2. is false, so 3. must be true.  </p>

<p>If you get a negative answer:<br>
If the guard is a truthteller, the number of truths is even, 1. is false, 2. is true, so 3. must be true.<br>
If the guard is a liar, the number of truths is odd, 1. is true, 2. is true, so 3. must be true.  </p>

So regardless of the answer of the guard, the door you pointed at is the door to freedom, you can leave safely.  

<hr>

<p><strong>Note:
Before you argue about this solution, please read the following:</strong><br>
<a href="https://puzzling.stackexchange.com/questions/7954/logic-explanation-in-two-doors-answer">Logic explanation in &quot;two doors&quot; answer</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: Puzzle of putting numbers 1-9 in 3x3 Grid to add up to 15 (score [380924](https://stackoverflow.com/q/1957) in 2015)

#### Question
In a 3x3 grid, I'd have to put numbers from 1 to 9 in a manner so that respective row, column and diagonal add up to 15.  

I have only been able to come up with one solution:  

<p>$$\begin{array}{ccc}
6 &amp; 1 &amp; 8 \\
7 &amp; 5 &amp; 3 \\
2 &amp; 9 &amp; 4
\end{array}$$</p>

Through some calculations and trial and error method.  

Is there any strategy or way of approach to this problem, or is trial and error method the solution to it?  

#### Answer accepted (score 15)
There is a general, very simple, algorithm for generating any magic square which has an odd number of rows/columns as follows:  

<ol>
<li>Start in the middle of the top row and enter 1.</li>
<li>Move Up 1 and Right 1 wrapping both vertically and horizontally when you leave the grid *(see note below). </li>
<li>If that square is empty enter the next number; if the square is not empty put the next number underneath the last number you entered. </li>
<li>Repeat 2&amp;3 until the grid is complete. All rows, columns and the two diagonals will sum to the same value.</li>
</ol>

Here is the 5x5 square:  

<p>$$\begin{array}{ccccc}
17&amp;	24&amp;	1&amp;	8&amp;	15	\\
23&amp;	5&amp;	7&amp;	14&amp;	16	\\
4&amp;	6&amp;	13&amp;	20&amp;	22	\\
10&amp;	12&amp;	19&amp;	21&amp;	3	\\
11&amp;	18&amp;	25&amp;	2&amp;	9
\end{array}$$</p>

As the square square is symmetric there are eight symmetries. You can also get these symmetries by a simple variation of the start square and direction used in step 2.  

<p>*Note: 
So as you are in the middle of the top row on the first move you want to place the next number in the next column of the row above. The row above does not exist so move to the last row of the square in the same column. If you were in the last column you would move to the first column. If you look at the example of the 5x5 at number 15. The next position is the square up and to the right of 15 which wraps on both the row and column to point to the lower right square which has 11 in it. As that square is not empty we placed 16 underneath 15.</p>

#### Answer 2 (score 7)
There are 8 equations which must must add to $15$  

$$a+b+c=15$$ $$d+e+f=15$$ $$ g+h+I=15$$ $$ a+d+g =15$$ $$b+e+h =15$$ $$c+f+I=15$$ $$ a+e+I =15$$ $$ c+e+g=15$$  I would place these in excel personally. So adding equations $2,5,7,8$ and then subtracting equations $1,2,3$ yields $3e=15$ so $ e=5$.  

No others are solvable without guessing one but from there you just solve them one at a time. Guess $1$ is in a corner, requires $9$ in the other corner. There must be two pairs which add to $14$. The only one is $8+6$ so $1$ cannot be in the corner.  

Guess $1$ not in a corner, $9$ must still be opposite to it. $8$ and $6$ must be in the adjacent corners. The other corners can be solved by the diagonal equations ($2$ and $4$). Finally the last two squares can be easily solved.  

There are only 8 different solutions and because this logic eliminates any others; they are all mirrors/rotations of the one you already posted.  

Of course there are some made from larger squares....  

#### Answer 3 (score 4)
It is simple. Put  

<p>$$\begin{array}{ccc}
 1 &amp; 2 &amp; 3 \\
 4 &amp; 5 &amp; 6 \\
 7 &amp; 8 &amp; 9 \\
\end{array}$$</p>

…then make cross lines as shown in the picture below. Then it becomes 3x3 boxes. For the remaining boxes, put the number which is opposite to the box.  

<a href="https://i.stack.imgur.com/hI25c.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/hI25c.png" alt=""></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: Crack the lock code (score [271894](https://stackoverflow.com/q/46871) in 2016)

#### Question
Can any one know how to crack this? I got this as a challenge.  

<a href="https://i.stack.imgur.com/ZHs7v.jpg"><img src="https://i.stack.imgur.com/ZHs7v.jpg" alt="enter image description here"></a>  

#### Answer accepted (score 45)
The code is:  

<blockquote class="spoiler">
   <strong>042</strong>  
</blockquote>

<hr>

<strong>Explanations:</strong>  

One number is correct and is also correctly placed:  

<blockquote class="spoiler">
   2   
</blockquote>

One number is correct but wrongly placed:   

<blockquote class="spoiler">
   4  
</blockquote>

Two numbers are correct and wrongly placed:  

<blockquote class="spoiler">
   0 &amp; 2 incorrectly placed  
</blockquote>

Nothing is correct:  

<blockquote class="spoiler">
   None of them are in the code  
</blockquote>

One number is correct but wrongly placed:  

<blockquote class="spoiler">
   0  
</blockquote>

<strong>Approach/Thought Process Chosen</strong>  

<strong>682 - One number is correct and well placed</strong>    

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 6,8,2<br>
 <strong>Confirm Number's array</strong> -      </p>
</blockquote>

<strong>614 - One number is correct but wrong placed</strong>       

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 8,2,1,4(6 is removed since this clue contradicts the previous one and hence 6 should not be present even in the code-The position of 6 is same in Clue 1 and 2 which mean's it can be pushed out of scope)<br>
 <strong>Confirm Number's array</strong> -     </p>
</blockquote>

<strong>206 - Two Numbers are correct but wrong placed</strong>       

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 8,2,1,4,0<br>
 <strong>Confirm Number's array</strong> - 0_2(Since 6 is out of scope, consider 2 and 0 to be in the confirm array list and clue 1 says 2 is well placed )     </p>
</blockquote>

<strong>738 - Nothing is correct</strong>       

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 0,2,1,4(8 is removed from the array)<br>
 <strong>Confirm Number's array</strong> - 0_2     </p>
</blockquote>

<strong>780 - One Number is correct but wrong placed</strong>       

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 0,2,4(Clues 3 and 5 confirms the position of 0 to be the first. Clues 1 confirms the position of 2. Clue 2 confirms the position of 4 and hence 1 is removed from the list)<br>
 <strong>Confirm Number's array</strong> - 042     </p>
</blockquote>

#### Answer 2 (score 45)
The code is:  

<blockquote class="spoiler">
   <strong>042</strong>  
</blockquote>

<hr>

<strong>Explanations:</strong>  

One number is correct and is also correctly placed:  

<blockquote class="spoiler">
   2   
</blockquote>

One number is correct but wrongly placed:   

<blockquote class="spoiler">
   4  
</blockquote>

Two numbers are correct and wrongly placed:  

<blockquote class="spoiler">
   0 &amp; 2 incorrectly placed  
</blockquote>

Nothing is correct:  

<blockquote class="spoiler">
   None of them are in the code  
</blockquote>

One number is correct but wrongly placed:  

<blockquote class="spoiler">
   0  
</blockquote>

<strong>Approach/Thought Process Chosen</strong>  

<strong>682 - One number is correct and well placed</strong>    

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 6,8,2<br>
 <strong>Confirm Number's array</strong> -      </p>
</blockquote>

<strong>614 - One number is correct but wrong placed</strong>       

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 8,2,1,4(6 is removed since this clue contradicts the previous one and hence 6 should not be present even in the code-The position of 6 is same in Clue 1 and 2 which mean's it can be pushed out of scope)<br>
 <strong>Confirm Number's array</strong> -     </p>
</blockquote>

<strong>206 - Two Numbers are correct but wrong placed</strong>       

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 8,2,1,4,0<br>
 <strong>Confirm Number's array</strong> - 0_2(Since 6 is out of scope, consider 2 and 0 to be in the confirm array list and clue 1 says 2 is well placed )     </p>
</blockquote>

<strong>738 - Nothing is correct</strong>       

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 0,2,1,4(8 is removed from the array)<br>
 <strong>Confirm Number's array</strong> - 0_2     </p>
</blockquote>

<strong>780 - One Number is correct but wrong placed</strong>       

<blockquote class="spoiler">
  <p> <strong>Correct Number's array</strong> - 0,2,4(Clues 3 and 5 confirms the position of 0 to be the first. Clues 1 confirms the position of 2. Clue 2 confirms the position of 4 and hence 1 is removed from the list)<br>
 <strong>Confirm Number's array</strong> - 042     </p>
</blockquote>

#### Answer 3 (score 34)
My solution:  

<ul>
<li>Clues 1 &amp; 2 say number 6 is not included as it cannot be in both the wrong and the right place at the same time</li>
<li>Clue 3 then says 2 and 0 are included</li>
<li>Clue 1 then says 2 must be in the last position</li>
<li>Clue 3 then says 0 must be in the first position</li>
<li>Clue 2 then has 1 &amp; 4 as possible values, but only 4 is not in the middle position</li>
</ul>

042, clues 4 and 5 are unnecessary.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: 1 2 3 4 5 6 7 8 9 = 1 (score [264230](https://stackoverflow.com/q/12187) in 2017)

#### Question
<a href="https://puzzling.stackexchange.com/questions/11998/1-2-3-4-5-6-7-8-9-100">This question</a> inspired me to write the same puzzle but instead replace the "= 100" with "= 1" with similar requirements and restrictions.  

What is the expression with the fewest number of operators inserted that evaluates to 1?  

Restrictions:  

<ol>
<li>The numbers need to be in the order that's shown in the question.</li>
<li>Only use the operators +,−,×,÷ and √ and ! (Implies that modulus "%", exponent "^", binomial coefficients, and other operators are not allowed).</li>
<li>Parentheses will not be counted, so they can be used to change the order of operations.</li>
<li>Rounding is not allowed, so it have to equal to 1.</li>
</ol>

Verify your calculations in that calculator application that comes with your PC, if it ever did came with your PC.  

This is my first time writing a puzzle here so obviously I should have thought this out a lot more instead of adding rules when situation comes.  

#### Answer accepted (score 39)
If √ can mean nth root:  

$$\sqrt[1234567]{-8+9}$$  

3 operators. Obviously...  

#### Answer 2 (score 22)
$$1+23-45-67+89$$  

uses four. (I wrote a Python script.)  

#### Answer 3 (score 10)
How many significant digits matter here for rounding? Because if it's anything less than $3,456,789$ zeroes, I can solve it in three ;)  

<blockquote class="spoiler">
   $1+2/3456789! = ~1$  
</blockquote>

Many programming languages will evaluate it as "1". Even <a href="https://www.wolframalpha.com/input/?i=1%2B2%2F3456789!" rel="nofollow noreferrer">Wolfram Alpha</a> can't show me enough decimal digits to tell me I'm wrong ;P  

<p><strong>EDIT:</strong>
Yes, I know this is no longer valid as of the rule change that doesn't include rounding. I didn't expect it would be allowed anyways, just figured it would be worth submitting, since it comes so infinitesimally close to 1. Besides, kgull managed to get even closer using a similar method.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: 6, the magic number (score [260778](https://stackoverflow.com/q/1963) in 2014)

#### Question
Here's a fun (albeit difficult) one:  

Make these equations true using arithmetic operations:  

```text
1 1 1 = 6
2 2 2 = 6
3 3 3 = 6
4 4 4 = 6
5 5 5 = 6
6 6 6 = 6
7 7 7 = 6
8 8 8 = 6
9 9 9 = 6
```

For example: `6 + 6 - 6 = 6` (I hope I did not spoil some of you :D)  

Allowed operators are:  

```text
+, -, *, /, ! , ^, %
```

Setting parenthesis is also allowed.  

The `^` operator is an exception as you are permitted to supply a second argument to it which may be any positive integer or the multiplicative inverse of it.  

$x^{1/y}$ is <strong>always</strong> positive and real.  

If you find an alternative solution using other operators you may post it but please also provide a solution using only these 7 operators.  

<hr>

For those of you who think this was easy, here is a bonus:  

```text
0 0 0 = 6
```

#### Answer accepted (score 45)
1.  

<blockquote class="spoiler">
   <span class="math-container">$(1+1+1)! = 6 $</span>  
</blockquote>

2.  

<blockquote class="spoiler">
   <span class="math-container">$2+2+2 = 6$</span>  
</blockquote>

3.  

<blockquote class="spoiler">
   <span class="math-container">$3*3-3 = 6$</span>  
</blockquote>

4.  

<blockquote class="spoiler">
   <span class="math-container">$\left(4-\frac 4 4\right)! = \sqrt 4+\sqrt 4+\sqrt 4=6$</span>  
</blockquote>

5.  

<blockquote class="spoiler">
   <span class="math-container">$5+\frac 5 5 = 6$</span>  
</blockquote>

6.  

<blockquote class="spoiler">
   <span class="math-container">$6*\frac 6 6 = 6 + 6 -6=6$</span>  
</blockquote>

7.  

<blockquote class="spoiler">
   <span class="math-container">$7-\frac 7 7 = 6$</span>  
</blockquote>

8.  

<blockquote class="spoiler">
   <span class="math-container">$\left(\sqrt{8+\frac 8 8}\right)! = 6$</span>  
</blockquote>

9.  

<blockquote class="spoiler">
   <span class="math-container">$\left(\frac{\sqrt{9}\sqrt{9}}{\sqrt 9}\right)! = 6$</span>  
</blockquote>

Bonus:   

<blockquote class="spoiler">
   <span class="math-container">$(0!+0!+0!)! = 6$</span>  
</blockquote>

#### Answer 2 (score 34)
I insist on using all the digits!  

<blockquote class="spoiler">
  <p> $(1 + 1^{1234567890} + 1)! = 6$<br>
<br>
 $(2 + (2^{1234567890}\ \text{mod}\ 2)!)! = 6$<br>
<br>
 $(3 + 3^{1234567890}\ \text{mod}\ 3)! = 6$<br>
<br>
 $(4 - (4^{1234567890}\ \text{mod}\ 4)!)! = 6$<br>
<br>
 $5 + (5^{1234567890}\ \text{mod}\ 5)! = 6$<br>
<br>
 $6 + 6^{1234567890}\ \text{mod}\ 6 = 6$<br>
<br>
 $7 - (7^{1234567890}\ \text{mod}\ 7)! = 6$<br>
<br>
 $(\sqrt[3]8 + (8^{1234567890}\ \text{mod}\ 8)!)! = 6$<br>
<br>
 $(\sqrt{9} + (9^{1234567890}\ \text{mod}\ 9))! = 6$<br>
<br>
 $(0! + (0^{1234567890})! + 0!)! = 6$  </p>
</blockquote>

No, wait!  How about if we take subtraction out and put subfactorial in?  More exclamation points!!!!  

<blockquote class="spoiler">
  <p> $((!1)! + (!1)! + (!1)!)! = 6$<br>
<br>
 $(!2 + !2 + !2)! = 6$<br>
<br>
 $!3 + !3 + !3 = 6$<br>
<br>
 $(\sqrt{!4} \times 4 \div 4)! = 6$<br>
<br>
 $!(\sqrt{!5\ \text{mod}\ 5}) + 5 = 6$<br>
<br>
 $!6\ \text{mod}\ 6 \times 6 = 6$<br>
<br>
 $!7\ \text{mod}\ 7\ \text{mod}\ 7 = 6$<br>
<br>
 $(!8\ \text{mod}\ 8 + \sqrt[3]8)! = 6$<br>
<br>
 $\sqrt[3]{!9\ \text{mod}\ 9} \times \sqrt9 = 6$<br>
<br>
 $(!0 + !0 + !0)! = 6$  </p>
</blockquote>

#### Answer 3 (score 9)
The bottom five (0 through 4) can all be solved using the same construction:  

<blockquote class="spoiler">
  <p>     `(0!+0!+0!)! = 6`<br>
     `(1 +1 +1 )! = 6`<br>
     `(2 +2 /2 )! = 6`<br>
     `(3 +3 %3 )! = 6`<br>
     `(4 -4 /4 )! = 6`  </p>
</blockquote>

For 6 and 7, there are slightly more funky solutions:  

<blockquote class="spoiler">
  <p>     `(6!)%(6!-6)=6`<br>
     `((7!)/7)%7=6`  </p>
</blockquote>

(I haven't found an interesting solution for 5, nor any square-root-free solutions for 8 or 9.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: What is the number of the parking spot? (score [198434](https://stackoverflow.com/q/1797) in 2015)

#### Question
One needs to find the number under the car.  

<img src="https://i.stack.imgur.com/CT56W.jpg" alt="A picture of some parking spaces from the top down, appearing to be numbered &quot;16, 06, 68, 88, ??, 98&quot;">  

#### Answer accepted (score 47)
I believe the most obvious answer is:  

<blockquote class="spoiler">
  <p> There is a usual sequence of numbers, we're just looking at it in the wrong direction. The numbers of the parking spots must be viewed from the outside in, as a driver would see them, which is upside-down from the current view.<br /> <br />
 The shown numbers are: 86, ??, 88, 89, 90, 91. Therefore the answer is <strong>87</strong>.</p>
</blockquote>

#### Answer 2 (score 47)
I believe the most obvious answer is:  

<blockquote class="spoiler">
  <p> There is a usual sequence of numbers, we're just looking at it in the wrong direction. The numbers of the parking spots must be viewed from the outside in, as a driver would see them, which is upside-down from the current view.<br /> <br />
 The shown numbers are: 86, ??, 88, 89, 90, 91. Therefore the answer is <strong>87</strong>.</p>
</blockquote>

#### Answer 3 (score 12)
<p>The Number is 87. Just rotate the image 180 degree.
<img src="https://i.stack.imgur.com/dJC2c.jpg" alt="enter image description here"></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: What is the best method of scrambling a rubik's cube? (score [158170](https://stackoverflow.com/q/323) in 2014)

#### Question
If I wanted to solve a physical Rubik's cube multiple times, for practice, what is the best, most random way, to scramble the solved cube?  

The best way I can think is to hold it behind my back and turn randomly until, when I look at it, it <em>looks</em> random enough.  

Is there a better way?  

#### Answer accepted (score 26)
If you're willing to take the time: The <a href="https://www.worldcubeassociation.org">World Cube Association</a> has a specific method for shuffling their cubes. They use a program called <a href="https://github.com/cubing/tnoodle">TNoodle</a> to do the scrambling; the program generates a "scramble sequence" which can be followed to produce a scrambled cube.  

Their code actually features a nice interface to generate the scrambles:  

<img src="https://i.stack.imgur.com/rOj6o.png" alt="enter image description here">  

I have yet to figure out what the "Adjust Events" options do, but producing the scramble sequences just comes down to clicking the "Scramble!" button.  

Here's the result of running their program:  

<img src="https://i.stack.imgur.com/bLOyh.png" alt="enter image description here">  

<strong>There is also an online interface <a href="https://www.worldcubeassociation.org/regulations/history/files/scrambles/scramble_cube.htm">here</a>.</strong> I used it to scramble my new 30x30x30 Rubik's cube:  

<img src="https://i.stack.imgur.com/ZyqN4.png" alt="enter image description here">  

#### Answer 2 (score 10)
If the goal is to have a truly random cube, holding behind your back and scrambling it is as good as any other method, as long as you do ~20 twists or so.  

People often intuitively think that if you scramble a cube for a really long time, it will make it harder to solve. Beyond the first few twists, this is not so. Not only can any amateur solver demonstrate a cube scrambled for half an hour is as easy to solve as a cube scrambled for 10 seconds, there is a proven upper bound on the "hardest" possible Rubik's cube state: 20 moves from scrambled to solved.  

<a href="http://www.cube20.org/">http://www.cube20.org/</a>  

Naturally it's possible to produce a scramble using any method where, by random chance, there is less work needed at some point (As in, you solve the first two layers, and lo and behold, the third layer required only one operation!). This is a perfectly fair random occurrence though, and a good scrambler wouldn't discriminate against such scenarios, even if it could detect them.  

One more thing: for most solvers, as few as six random twists is enough to scramble a cube. It is a fun puzzle to have a friend perform 4, 5, or 6 random twists on a solved cube, and then see if you can undo the twists without messing up the cube. 4 is usually easy, 5 is quite hard for me, and I can't do 6 without getting lucky : )  

Bottom line is, unless you're a savant or a supercomputer, don't overthink cube scrambling!  

#### Answer 3 (score 6)
The best tool to generate scrambles for all WCA puzzles is <a href="http://ruwix.com/puzzle-scramble-generator/" rel="noreferrer">http://ruwix.com/puzzle-scramble-generator/</a>  

It supports cubes from 2x2x2 up to 11x11x11, Square-1, Rubik's Clock, Megaminx, Pyraminx and Skewb. You can customize the scramble in many ways and there's a built-in stopwatch to measure your times.  

<img src="https://i.stack.imgur.com/y8uRX.jpg" alt="enter image description here">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: 1 2 3 4 5 6 7 8 9 = 100 (score [146365](https://stackoverflow.com/q/11998) in 2015)

#### Question
The sequence of numbers $1\ 2\ 3\ 4\ 5\ 6\ 7\ 8\ 9$ has the property that you can insert mathematical operators in between the numbers from $1$ to $9$ and make the expression evaluate to 100. For example:  

$$1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 \times 9 = 100$$  

There are possibly hundreds of solutions to this problem, involving different varieties of operators. What is the expression with the fewest number of operators inserted (out of the set $+, -, \times, \div$ and maybe $\sqrt{}$ and $!$) that evaluates to 100?  

#### Answer accepted (score 66)
<strong><em>Note</strong>: This answer only applies prior to the edit that clarifies that the expression on the left must evaluate to 100, rather than simply the equation being true.</em>  

If you allow exponents, you can get away with just two:  

<blockquote class="spoiler">
   $ 1^{ 23456789 } = 10^0 $  
</blockquote>

#### Answer 2 (score 66)
<strong><em>Note</strong>: This answer only applies prior to the edit that clarifies that the expression on the left must evaluate to 100, rather than simply the equation being true.</em>  

If you allow exponents, you can get away with just two:  

<blockquote class="spoiler">
   $ 1^{ 23456789 } = 10^0 $  
</blockquote>

#### Answer 3 (score 30)
Best I can do so far is tie the smallest (3 operators):  

<blockquote class="spoiler">
  <p> 1234%567%8^9 = 100<br>
 which <a href="https://www.wolframalpha.com/input/?i=1234%25567%258%5E9">Wolfram Alpha</a> interprets as:<br>
 $(1234\bmod567)\bmod8^9 = 100$<br>
 $(100)\bmod8^9 = 100$</p>
</blockquote>

For those who are unfamiliar, % is the modulo operator. Throw the equation in wolfram alpha.  

<p><strong>EDIT:</strong>
Started on finding this solution before the operator limit was imposed. Not valid under the rules of the current question.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: 5 Letter Word, Removing letters (score [135367](https://stackoverflow.com/q/14872) in )

#### Question
<p>Take away my first letter, and I still sound the same. 
<br>Take away my last letter, I still sound the same. <br>Even take away my letter in the middle, I will still sound the same. <br>I am a five letter word. <br>What am I?</p>

#### Answer accepted (score 14)
This is an old one.  

The answer is:  

<blockquote class="spoiler">
   EMPTY  
</blockquote>

Because:  

<blockquote class="spoiler">
   MPTY still sounds like EMPTY,<br> EMPT still sounds like EMPTY,<br>and EMTY still (sort of) sounds like EMPTY.  
</blockquote>

And, of course, you can   

<blockquote class="spoiler">
   take all 3 away and M T is left.  
</blockquote>

#### Answer 2 (score 5)
A postman, because he/she will be a postman without any letters.  

#### Answer 3 (score 5)
A postman, because he/she will be a postman without any letters.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Poisoned Iced Tea (score [130496](https://stackoverflow.com/q/2980) in 2015)

#### Question
Two girls went to dinner together and both ordered iced tea. One girl pounded down five of them in about a minute, and the other took her time drinking one.    

The girl who drank one died, while the girl who drank five survived. However, all of the drinks that were served turned out to contain poison.  

Why did the girl that drank more iced tea survive?  

#### Answer accepted (score 102)
Because...  

<blockquote class="spoiler">
   ...the poison was in the ice. She drank them before the Ice melted to the point where it would kill her.  
</blockquote>

#### Answer 2 (score 68)
Because...  

<blockquote class="spoiler">
   ...they were Long Island Iced Teas.  
</blockquote>

<sub></sub>  

<blockquote class="spoiler">
   The first girl drank so much so fast she couldn't hold her liquor and (fortunately) threw them up before her body absorbed the poison.  
</blockquote>

#### Answer 3 (score 12)
Because...  

<blockquote class="spoiler">
  ...the girl who only drank one was allergic to the tea. They were all 'poisoned', but were only meant to kill her, not the other girl.    
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Four prisoners wearing black and white hats (score [127079](https://stackoverflow.com/q/1980) in 2018)

#### Question
There are four prisoners. All four prisoners will be freed, if at least one of them correctly guesses the color of the hat on his head.  

They can't speak to each other, and they can't touch each other.  

<p>Number 1 sees number 2 and 3's hats.<br>
Number 2 sees number 3's hat.<br>
Number 3 sees only the wall.<br>
Number 4 sees only the wall.</p>

There are no mirrors.  

They all know that there are 2 black hats and 2 white hats, and that there are four people.  

They know their placement in this room is as follows:  

<img src="https://i.stack.imgur.com/wQdL9.png" alt="enter image description here">  

Can the four prisoners be freed? If so, how?  

#### Answer accepted (score 3)
<blockquote class="spoiler">
   4 can't see the other three due to the wall so he can't guess. 3 also can't see due to the wall. I eliminate 4 and 3. For 2, he knows 3 is wearing white hat. But how could he knows he is wearing black? For 1, if 2 hat is white then 1 hat is black. But if 1's is black and 2's is white then, he would be able to know. If the two in front have white hats then, he will answer first and say 'Mine is black'. But properly, 2 is aware of 1's hesitation , 'Ah~ 1 is also white'.Then, 2 will answer 'Mine is black'. So the answer is 2.  
</blockquote>

#### Answer 2 (score 4)
Prisoner 2 can know the color of his hat - it should be exactly opposite of that worn by the prisoner ahead of him, Prisoner 3.  

Prisoner 1 can see both 2 and 3 in front of him, but the fact that he cannot guess the color of his own hat must mean 2 and 3 are wearing different colored hats. For example, if 2 and 3 both had white hats, and knowing that there are only two white hats (with the other two being black), prisoner 1 would have been able to work out that he's wearing a black hat. Likewise, if both 2 and 3 had black hats on, 1 would know he's wearing a white hat. BUT, if 2 and 3 had different colored hats on, then 1 cannot logically deduce the color of his own hat.  

FROM THAT LOGIC ABOVE, 2 knows that the color of his own hat is different to the color worn by the person ahead of him (prisoner 3). Thus, if 3 has a white hat on, 2's own hat must be black. Else, if 3 has a black hat, then 2 must be wearing a white hat.  

As only one person needs to deduce the answer correctly for them all to be released, that person is 2.  

#### Answer 3 (score 3)
<blockquote class="spoiler">
   4 can't see the other three due to the wall so he can't guess. 3 also can't see due to the wall. I eliminate 4 and 3. For 2, he knows 3 is wearing white hat. But how could he knows he is wearing black? For 1, if 2 hat is white then 1 hat is black. But if 1's is black and 2's is white then, he would be able to know. If the two in front have white hats then, he will answer first and say 'Mine is black'. But properly, 2 is aware of 1's hesitation , 'Ah~ 1 is also white'.Then, 2 will answer 'Mine is black'. So the answer is 2.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: The Jeweler and the Five Rings (score [119814](https://stackoverflow.com/q/49410) in 2017)

#### Question
A king asks a learned man to visit his palace, to which the learned man responds:  

"I will come some day next month, but I will not tell you on which day. Further, you must give me gold in grams equal to the date on which I come."  

In preparation for the visit, the king demands that his jeweler make gold rings of 1 to 31 grams.  

The wise jeweler made only 5 rings. What are their weights?  

#### Answer accepted (score 11)
the weights of 5 rings are:  

<blockquote class="spoiler">
   1, 2, 4, 8, 16 grams  
</blockquote>

Using these combination of 5 type of weights you can reward 1-31 grams in weight to the wise man.  

Example:  

<blockquote class="spoiler">
  <p> If wise man visit on 3rd day, you can give him ring with 1 &amp; 2 grams.
<br>
 If wise man visit on 15th day, you can give him ring with 1, 2, 4, 8 grams.
<br>
 If wise man visit on 30th day, you can give him ring with 2, 4, 8, 16 grams.</p>
</blockquote>

You can do this for all possible number of days.  

#### Answer 2 (score 5)
The rings are going to weigh:  

<blockquote class="spoiler">
  <p> 1, 2, 4, 8, and 16 grams<br>
<br>
 Since each ring will or will not be used, all we have to do is represent the numbers in binary, and give the corresponding rings.<br>
<br>
 As an example, 5 is 00101 in binary, so we give the rings of weight 4 and 1, and 19 will be 01011, so 16+2+1, and 31 is 11111, so we give all of the rings.</p>
</blockquote>

#### Answer 3 (score -4)
The answer is   

<blockquote class="spoiler">
  <p> 1,2,4,8,16<br>
<br>
 2^0=1<br>
 2^1=2<br>
 2^2=4<br>
 2^3=8<br>
 2^4=16</p>
</blockquote>

Since 5 rings are made..We can stop up to 5 numbers.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: Brooklyn Nine-Nine Riddle: Weighing Islanders (score [117031](https://stackoverflow.com/q/15426) in 2015)

#### Question
A brain teaser posed by the character Captain Ray Holt of 'Brooklyn Nine-Nine' played by Andre Braugher during episode 18 of season 2:   

"There are twelve(12) men on an island, eleven(11) weigh exactly the same amount, but one of them is slightly lighter or heavier, [the object is to] figure out [whether he is lighter or heavier]. A standard see-saw must be used and only three times."  

(Rephrased for clarity, below is a verbatim transcript of 'Holts' dialogue)  

"There are twelve men on an island, eleven weigh exactly the same amount, but one of them is slightly lighter or heavier, you must figure out which. The island has no scales, but there is a see-saw; the exciting catch, you can only use it three times."  

#### Answer accepted (score 6)
There are 24 possible situations (the different man can be any of 1-12, and he can be heavier or lighter). Thus we need to log<sub>2</sub>24 bits of information to solve the puzzle. You can weigh three combinations of men on the see-saw. Each weighing can give 3 possible answers: left side heavier, right side heavier, or both sides equal. Thus in principle we can get log<sub>2</sub>27 bits from the three comparisons.  So in principle, we should be able to solve the problem. The key to this problem is making sure all three output values (left side heavier, right side heavier, two sides the same) are possible and informative in almost every comparison you do so that we can eek log<sub>2</sub>24 bits out of the comparisons. Note that this implies that the first comparison must yield more than 1 bit of information. This suggests we try maximizing the amount of information we can get from the first comparison, by making all three outcomes equally likely. Comparing (1,2,3,4) to (5,6,7,8) does exactly this. Similar logic will help us design all further comparisons.   

Here is one solution:  

Number the men 1,2,3...12. First weigh 1,2,3,4 against 5,6,7,8. One of two things will happen:  

1) They are equal. Now we know that the different man is among {9,10,11,12}. Weigh 9,10,11 against 1,2,3. If these are equal, the different man is 12. Weigh 12 against 1 to find out whether 12 is heaver or lighter. If the 9,10,11 differs from 1,2,3, then weigh 9 against 10. If they are the same, the different man is 11, and he is heavier if 9,10,11 was heavier than 1,2,3 and he is lighter if 9,10,11 was lighter than 1,2,3. If 9 and 10 are different, the different man is the lighter of the 9,10 comparison if 9,10,11 was lighter than 1,2,3, (and he is lighter); the different man is the heavier of the 9,10 comparison if 9,10,11 was heavier than 1,2,3 (and he is heavier).  

2) They are different. Without loss of generality suppose that 1,2,3,4 is heavier than 5,6,7,8. (We could always relabel the men so that this is true). We know {9,10,11,12} all weigh the same.   

Weigh 1,2,5,6,7 against 8,9,10,11,12:   

a) If 1,2,5,6,7 is heavier, then either 1 or 2 heavier, or 8 is lighter. Weigh 1 against 2. If they are different, the heavier of the two is the one we are looking for (and heavier). If they are the same, 8 is the one we are looking for (and lighter).  

b) If 1,2,5,6,7 is lighter, then one of 5,6,7 is different and lighter. Weigh 5 against 6. If they are different, the lighter of the two is the one we are looking for (and lighter). If they are the same, 7 is different (and lighter).  

c) If they are the same, then one of 3,4 is different. Weigh them against each other. The one who is heavier is the different man (and heavier).   

#### Answer 2 (score 0)
The solution:  

Split the men into two(2) groups 'abcdef' and '123456'.  

Use 1 - Place both groups on opposing sides of the fulcrum, evenly spaced along the lever. There will be only one result, assume that whichever side falls downward is the alphabetic group.  

<p>Use 2 - Remove six(6) men from the see-saw, three(3) from both groups. Let's say 'abc' and '456'. There are two possible results. 
A_ the equilibrium of the see-saw remains unchanged, therefore the man of a different weight is now amongst group 'def123' or 
B_ the see-saw becomes level with the ground, therefore the man of a different weight is standing with group 'abc456'. 
Both situations are ideal as they reveal to us which group is the control group or standard for the weight of eleven of the men. Which brings us to...</p>

Use 3 - Place both new groups 'def123' and 'abc456' on the teeter-totter again as we did in the beginning. Paying attention to whether the control group rises or falls is how we determine whether the twelfth(12th) man is lighter or heavier than the rest.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: When is Cheryl's Birthday? (score [113551](https://stackoverflow.com/q/12022) in 2015)

#### Question
I saw this question on <a href="https://www.facebook.com/kennethjianwenz/photos/a.173663129479243.1073741827.167504136761809/385751114937109/?type=1&amp;theater">Facebook</a>:  

<blockquote>
  Albert and Bernard just became friends with Cheryl, and they want to know when her birthday is. Cheryl gives them a list of 10 possible dates.  
  
  May 15 16 19  
  
  June 17 18  
  
  July 14 16  
  
  August 14 15 17  
  
  Cheryl then tells Albert and Bernard separately the month and the day of her birthday, respectively.  
  
  <strong>Albert</strong>: I don't know when Cheryl's birthday is, but I know that Bernard does not know, too.  
  
  <strong>Bernard</strong>: At first, I didn't know when Cheryl's birthday is, but I know now.  
  
  <strong>Albert</strong>: Then I also know when Cheryl's birthday is.  
</blockquote>

When is Cheryl's birthday?  

There is an official solution which is explained in the link below, but I don't understand the logic.  

<blockquote class="spoiler">
   July 16, as explained here. <a href="https://www.facebook.com/kennethjianwenz/posts/386479228197631">https://www.facebook.com/kennethjianwenz/posts/386479228197631</a>  
</blockquote>

What is wrong with the logic in the answer I posted below (I put it in spoilers if others want to try)?   

#### Answer accepted (score 11)
I will try to help you understand the answer. It is important to note that Albert and Bernard both know the answer before we do.  

With Albert's first statement, it is clear to us that Albert was told either July or August. Had he been told May or June, he would not be able to state definitively that he knew Bernard didn't know. (May 19 and June 18 both could be uniquely identified immediately by Bernard without Albert's help, so in order for Albert to know that Bernard doesn't know, the month he was told must not be May or June.)  

Because Bernard has been able to identify Cheryl's birthday after Albert's statement, he must not have been told 14. Because Albert's statement revealed July and August, had Bernard been told 14, he would still be unclear on the date. (If he said he didn't know, then Albert would know the birthdate, but Bernard would never be able to deduce it.)  

We still don't know whether it is July 16, August 15, or August 17.  

However, since Albert (who was only told the month) is able to state that he also knows the birthday, he must not have been told August. Had he been told August, he would be unable to decide if Bernard was told the 15th and 17th.  

It is only after the third statement that we (as outsiders) can deduce the birthday. Bernard knew after the first statement and Albert knew after the second.  

#### Answer 2 (score 5)
<blockquote>
  Albert: I know Bernard doesn't know when Cheryl's birthday is.  
</blockquote>

Since May and June contain unique dates 18 and 19, then Albert cannot have been given one of those months, since if Bernard had received 18 or 19, then he would have immediately known (and therefore Albert wouldn't know if Bernard already knew Cheryl's birthday or not). So Cheryl's birthday must be in July or August.  

<blockquote>
  Bernard: Now I know when Cheryl's birthday is.  
</blockquote>

Since Bernard didn't know before and now he does, he must have deduced some information about the date, which means the date can't be 14 because then Bernard would still have been stuck with the month being either July or August.  

<blockquote>
  Albert: And now I know too.  
</blockquote>

Since Albert needs this information to discover which date it is, there must only have been one possibility remaining from eliminating 14 as a possible day, which is only applicable if the month is July. The remaining possibility is July 16, and so that's Cheryl's birthday.  

#### Answer 3 (score 3)
<blockquote>
  Albert: I don't know when Cheryl's birthday is, but I know that Bernard does not know, too.  
</blockquote>

<p>No matter what month is given to A he can not know the birthday.
If A was given May: B was given 15 or 16, 19. But if B was given 19(not ambiguous), he could deduce the birthday so A was not given May.</p>

If A was given June, B was given 17 or 18, again 18 is not ambiguous.  

Conclusion: A was given July or Aug, in which all dates are ambiguous  

<blockquote>
  Bernard: At first, I didn't know when Cheryl's birthday is, but I know now.  
</blockquote>

<p>So the date give to B may be 14, 15, 16 or 17.
14: Still ambigous as present in both months. So he had 15, 16 or 17 and now he knows the birthday</p>

<blockquote>
  Albert: Then I also know when Cheryl's birthday is.  
</blockquote>

Now A can rule out 14, otherwise B could not know the date. Eliminating 14, 16 is the only date remaining in July but 2 more dates remains in Aug leading to ambiguity. As A knows the answer now, it must be July and can not be 14.  

So the answer is:  

<blockquote class="spoiler">
   July 16 is Cheryl's birthday  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Five Angles in a Star (score [111014](https://stackoverflow.com/q/17681) in 2015)

#### Question
In a regular pentagram (5-pointed star), the angle in each point is 36 degrees, so the angles in all five points sum to 180 degrees:  

<img src="https://i.stack.imgur.com/bfWtQ.jpg" alt="regular star">  

What about an irregular pentagram, such as the following?  

<img src="https://i.stack.imgur.com/vvge8.jpg" alt="irregular star">  

Now the angles might be all different from each other; the situation is much more complicated. <strong>Can you prove that the angles in all five points <em>still</em> sum to 180 degrees?</strong>  

Restrictions (to make clear that this is neither a maths <em>problem</em> [as opposed to a maths puzzle] nor an exercise in computation or advanced Euclidean geometry):  

<ul>
<li>no arithmetic operations allowed (addition, multiplication, ...)</li>
<li>you may draw one new line-segment on the star, but no more than that</li>
</ul>

#### Answer accepted (score 49)
$\hskip 1.5in$<img src="https://i.stack.imgur.com/lCw7u.gif" alt="Isn&#39;t it dreamy?">  

This is an image of an arrow sweeping each of the successive angles in the star. Notice that, after it traces all $5$ angles, its orientation is reversed - meaning it has rotated $180^{\circ}$ and that this must be the sum of the angles. We can do the same thing to the star in your figure, ergo, its angles too sum to $180^{\circ}$.  

<hr>

<strong>A Generalization:</strong>  

<p>We can do the same thing to a figure like this, whose angles sum to $180^{\circ}$: 
$\hskip 1.5in$<img src="https://i.stack.imgur.com/2die8.png" alt="enter image description here"><br>
We can also do this to a triangle. The important property is this:</p>

<blockquote>
  There must be no vertices of the star <em>interior</em> to the cone swept out by a ray traversing a given angle.  
</blockquote>

Satisfying this condition - which basically says that we never have to "ignore" vertices, but instead just rotate the arrow and see what it hits -  we find that we can order the vertices in a "clockwise" manner, so that, at each angle, either the head or the tail of the arrow steps to the next vertex in the order (and they alternate which). Obviously, both head and tail will make a full revolution when twice as many angles as vertices have been traced, yielding the desired result.  

(One might also express my condition as "assigning the vertices the numbers $1$ through $2n+1$ in clockwise order as seen from a central point, it must be that $1$ connects to $n$ and $n+1$, and all other points are connected analogously")  

#### Answer 2 (score 35)
Place your pencil on line 1.  

<img src="https://i.stack.imgur.com/za2jxm.png" alt="enter image description here">  

Rotate your pencil so it lines up with line 2. You just rotated it counterclockwise by the angle at the top of the pentagram.  

Now rotate it counterclockwise again onto line 3. Then again onto line 4, then 5, and finally back to 1. You have just rotated your pencil through all five angles of the pentagram in sequence.  

And what happened? The pencil now lies on the same line it started at, pointing in the opposite direction. If you track which direction the pencil points at each step, you can see that in total, you rotated it counterclockwise by one half turn. Whence, $180^\circ$.  

#### Answer 3 (score 17)
Here's another proof.  

Label the points as shown, and draw the line-segment CD. Use A, B, etc. to denote the angles we are asked to find the sum of.  

<img src="https://i.stack.imgur.com/NomDF.jpg" alt="enter image description here">  

Now  

<blockquote class="spoiler">
   <span class="math-container">$\angle ADC + \angle DCA + A = 180^\circ$</span> (angles in a triangle)  
</blockquote>

So it is sufficient to prove that  

<blockquote class="spoiler">
   <span class="math-container">$\angle ADC + \angle DCA = B + C + D + E$</span>  
</blockquote>

Now  

<blockquote class="spoiler">
   <span class="math-container">$\angle ADC = D + \angle BDC$</span> and <span class="math-container">$\angle DCA = C + \angle ECD$</span>  
</blockquote>

So it is sufficient to prove that  

<blockquote class="spoiler">
   <span class="math-container">$\angle BDC + \angle ECD = B + E$</span>  
</blockquote>

which is obviously true because  

<blockquote class="spoiler">
   the LHS is the supplement of <span class="math-container">$\angle DFC$</span> and the RHS is the supplement of <span class="math-container">$\angle EFB$</span>, where  <span class="math-container">$\angle DFC$</span> and <span class="math-container">$\angle EFB$</span> are equal because vertically opposite.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: Clever ways to solve Mastermind? (score [107039](https://stackoverflow.com/q/546) in 2015)

#### Question
Is there any specific way to solve Mastermind?  

<img src="https://i.stack.imgur.com/rOeTu.jpg" alt="enter image description here">  

Apart from the first step that is pure chance, is there any way to continue based on the colors that you think are correct?  

#### Answer accepted (score 30)
Wikipedia has the <a href="http://en.wikipedia.org/wiki/Mastermind_(board_game)#Five-guess_algorithm" rel="noreferrer">nice section on optimal Mastermind strategies</a>:  

<blockquote>
  <p>In 1977, Donald Knuth demonstrated that the codebreaker can solve the
  pattern in five moves or fewer, using an algorithm that progressively
  reduced the number of possible patterns. The algorithm works as
  follows:</p>
  
  <ul>
  <li>Create the set S of 1296 possible codes, 1111,1112,.., 6666.</li>
  <li>Start with initial guess 1122 (Knuth gives examples showing that some other first guesses such as 1123, 1234 do not win in five tries
  on every code).</li>
  <li>Play the guess to get a response of colored and white pegs.</li>
  <li>If the response is four colored pegs the game is won, the algorithm terminates.</li>
  <li>Otherwise, remove from S any code that would not give the same response if it (the guess) were the code.</li>
  <li>Apply minimax technique to find a next guess as follows: For each possible guess, that is, any unused code of the 1296 not just those in
  S, calculate how many possibilities in S would be eliminated for each
  possible colored/white peg score. The score of a guess is the minimum
  number of possibilities it might eliminate from S. From the set of
  guesses with the maximum score select one as the next guess, choosing
  a member of S whenever possible. (Knuth follows the convention of
  choosing the guess with the least numeric value e.g. 2345 is lower
  than 3456. Knuth also gives an example showing that in some cases no
  member of S will be among the highest scoring guesses and thus the
  guess cannot win on the next turn yet will be necessary to assure a
  win in five.)</li>
  <li>Repeat from step 3.</li>
  </ul>
  
  <p>Subsequent mathematicians have been finding various algorithms that
  reduce the average number of turns needed to solve the pattern: in
  1993, Kenji Koyama and Tony W. Lai found a method that required an
  average of 5625/1296 = 4.340 turns to solve, with a worst-case
  scenario of six turns. The minimax value in the sense of game theory
  is 5600/1296 = 4.321.</p>
</blockquote>

<a href="http://mathworld.wolfram.com/Mastermind.html" rel="noreferrer">MathWorld's page on Mastermind</a> also gives a nice synopsis and mention a few more strategies:  

<blockquote>
  <p>Knuth (1976-77) showed that the codebreaker can always succeed in five
  or fewer moves (i.e., knows the code after four guesses). His
  technique uses a greedy strategy that minimizes the number of
  remaining possibilities at each step, and requires 4.478 guesses on
  average, assuming equally likely code choice. Irving (1978-79)
  subsequently found a strategy with slightly smaller average length.
  Koyama and Lai (1993) described a strategy that minimizes the average
  number of guesses, requiring on average 4.340 guesses, although may
  require up to six in the worst case. A slight modification also
  described by Koyama and Lai (1993) increases the average to 4.341, but
  reduces the maximum number of guesses required to five.</p>
  
  <p>Swaszek (1999-2000) gives an analysis of practical strategies that do
  not require complicated record-keeping or use of a computer. Making a
  random guess from the set of remaining candidate code sequences gives
  a surprisingly short average game length of 4.638, while interpreting
  each guess as a number and using the next higher number consistent
  with the known information gives a game of average length 4.758.</p>
</blockquote>

In summary, there is a trade-off to make between the average length and the maximum length of the game. (length is expressed in the number of code guesses)  

#### Answer 2 (score 7)
I play Mastermind with numbers instead of colours, because I first learned it in the second grade as Bagel Pico Fermi which uses numbers. For the rest of my answer, I will refer to red pegs as "bagels", and white pegs as "picos" (and holes without pegs as "fermis").  

<hr>

The system I tend to use is suboptimal but very easy to follow. It goes as follows:  

<ol>
<li><p>Start with 0000. You can never get picos if all digits are the same, only bagels.</p>

<ul>
<li><p>If the secret number was 0187, then you will get one bagel and three fermis.</p></li>
<li><p>If the secret number was 2966, then you will get four fermis and you know that 0 is not in the secret number at all.</p></li>
</ul></li>
<li><p>If there are any bagels with 0000, include that many 0's in your next answer, and replace the rest with 1's.</p>

<ul>
<li><p>If the secret number was 0187, then you'd keep one of the 0's in your answer, and guess 0111 next, getting two bagels.</p></li>
<li><p>If the secret number was 2966, then you'd guess 1111 next, getting four fermis again.</p></li>
</ul></li>
<li><p>Keep increasing the extra digits by 1. Those digits are "background digits", while the digits that you've kept the same should never change values and are "foreground digits".</p>

However many more pegs there are when you change the background digits, that many background digits then become foreground digits.  </li>
<li><p>Eventually you'll get to a point where you have a total of four pegs. If you have four bagels, congratulations, you have the right answer. But if some of them are picos, then some of them are in the wrong order. At this point, just try rearranging them, paying attention to whether your arrangement matches the number of switched digits in each of your previous guesses.</p></li>
</ol>

An example of this algorithm at work might be as follows:  

```text
Secret number: 4034
Every round there are A bagels and B picos.

[BG digit: 0] 1. 0000  1A0B  (so there's one 0) 
[BG digit: 1] 2. 0111  0A1B  (so there's no 1's, and the 0 is in the wrong place)
[BG digit: 2] 3. 2022  1A0B  (so there's no 2's either, but we know where the 0 is now) 
[BG digit: 3] 4. 3033  2A0B  (so there's one 3, because A+B increased by 1) 
[BG digit: 4] 5. 3044  2A2B  (you now have all the numbers, just not in the right order)
[BG digit: -] 6. 4043  2A2B  (the switch didn't work, try another one)
[BG digit: -] 7. 4034  4A0B  (you win!)
```

This isn't as good as the algorithm that a computer would use, but it's very simple and systematic, and very easy to get the hang of once you understand what you're doing.  

#### Answer 3 (score 5)
A simple strategy which is good and computationally much faster than Knuth's is the following (I have programmed both)  

Create the list 1111,...,6666 of all candidate secret codes  

Start with 1122.  

Repeat the following 2 steps:  

1) After you got the answer (number of red and number of white pegs) eliminate from the list of candidates all codes that would not have produced the same answer if they were the secret code.  

2) Pick the first element in the list and use it as new guess.  

This averages no more than 5 guesses.   

This is the Swaszek (1999-2000) strategy that was mentioned in another answer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: I am the first in Earth, What am I? (score [96996](https://stackoverflow.com/q/13339) in 2015)

#### Question
<blockquote>
  <p>I am the first in Earth,<br>
  The second in Heaven.  </p>
  
  <p>I appear twice in a week,<br>
  Never in a month,<br>
  Once in a year.</p>
  
  And I am found in the middle of the sea.  
</blockquote>

<strong>What am I?</strong>  

#### Answer accepted (score 47)
<strong>What am I?</strong>  

<blockquote class="spoiler">
   The letter "E"  
</blockquote>

I am the first on Earth,  

<blockquote class="spoiler">
   E-arth  
</blockquote>

The second in Heaven.  

<blockquote class="spoiler">
   h-E-aven  
</blockquote>

I appear twice in a week,  

<blockquote class="spoiler">
   w-EE-k  
</blockquote>

Never in a month,  

<blockquote class="spoiler">
   month &lt;--- no E!  
</blockquote>

Once in a year,  

<blockquote class="spoiler">
   y-E-ar  
</blockquote>

And I am found in the middle of the sea.  

<blockquote class="spoiler">
   s-E-a  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Three Doors, One Truth-Teller, One Question (score [92757](https://stackoverflow.com/q/12396) in 2017)

#### Question
You are in a prison. There are 3 doors, and a ghost standing in the middle of the prison. He says one of the doors is the way to freedom while the other two lead to death. You get to ask only one question. He will only answer with YES or NO. All he says is truth. What do you ask to find the door to freedom?  

#### Answer accepted (score 56)
The puzzle lays a restriction on the ghost's answers, but not on your question (i.e., your question doesn't have to be a yes/no question). I think it's a bit of misdirection.  

Give the doors names: "Door 1 I name 'Yes', Door 2 I name 'No', and Door 3 I give no name. Behind the door of which name lies freedom?"  

The ghost can answer "Yes," "No," or nothing, and by his answer he designates the name you gave that door.  

This is very similar to GOTO 0's <a href="https://puzzling.stackexchange.com/a/12414/8803">answer</a>, but this doesn't involve asking two questions for the price of one.  

#### Answer 2 (score 17)
I will try to be in the spirit of the riddle: Ask only one question and get a real YES/NO aka true/false response:  

<strong>If I take the first door and my brother takes one of the first two doors, will at least one of us get to freedom ?</strong>  

<ul>
<li>If the first door leads to freedom, the answer is yes.</li>
<li>If the third door leads to freedom, the answer is no.</li>
<li>If the second door leads to freedom, the answer would be maybe/don't know, so the ghost cannot answer with yes/no.</li>
</ul>

#### Answer 3 (score 15)
Keeping in mind that the ghost will only answer if the answer is yes or no, a way to find the door to freedom is to formulate a question such that the answer would be yes, no, or anything else respectively for each of the three doors. In the latter case, the ghost will not answer at all.  

There are several possibilities, one of them is this one.  

<blockquote>
  If the door to freedom is not the third one, then is it the first one? Otherwise, what was the name of Napoleon Bonaparte?  
</blockquote>

<ul>
<li>If the door to freedom is the first one, the ghost will answer <em>yes</em>.</li>
<li>If the door to freedom is the second one, the ghost will answer <em>no</em>.</li>
<li>If the door to freedom is the third one, the ghost will not answer.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: When does 1+1=3? (score [89217](https://stackoverflow.com/q/5656) in 2014)

#### Question
When does one plus one equal three?  

#### Answer accepted (score 7)
I have a mathematical proof for you:  

<blockquote>
  <p>Start with the following simple equation:
  $$a = b$$ (step 1)
  Multiply both sides by $b$:
  $$ab = b^2$$ (step 2)
  Subtract $a^2$ from both sides and factorize:
  $$ab - a^2 = b^2 - a^2$$ (step 3)
  $$a(b-a) = (b+a)(b-a)$$ (step 4)
  Simplify and add 1 to both sides:
  $$a = b + a$$ (step 5)
  $$a + 1 = b + a + 1$$
  Now since $a = b$ (the starting point of this proof), we can write this as:
  $$a + 1 = 2a + 1$$
  And in the case where $a = 1$, we have:
  $$1 + 1 = 2 + 1$$
  So, therefore,
  $$1 + 1 = 3$$</p>
</blockquote>

#### Answer 2 (score 16)
I have a mathematical proof for you:  

<blockquote>
  <p>Start with the following simple equation:
  $$a = b$$ (step 1)
  Multiply both sides by $b$:
  $$ab = b^2$$ (step 2)
  Subtract $a^2$ from both sides and factorize:
  $$ab - a^2 = b^2 - a^2$$ (step 3)
  $$a(b-a) = (b+a)(b-a)$$ (step 4)
  Simplify and add 1 to both sides:
  $$a = b + a$$ (step 5)
  $$a + 1 = b + a + 1$$
  Now since $a = b$ (the starting point of this proof), we can write this as:
  $$a + 1 = 2a + 1$$
  And in the case where $a = 1$, we have:
  $$1 + 1 = 2 + 1$$
  So, therefore,
  $$1 + 1 = 3$$</p>
</blockquote>

#### Answer 3 (score 14)
Here is an image that shows that 1 + 1 = 3:  

<img src="https://i.stack.imgur.com/H6sE0.png" alt="1 + 1 = 3">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Deaf, Mute and Blind (score [88202](https://stackoverflow.com/q/4405) in 2015)

#### Question
There were three men. One was deaf, the other was blind and the third was mute. One day the deaf man kissed the blind man's wife. The mute man saw this and he wants to tell it to the blind man, but he cannot speak. So how does the mute man explain the situation to the blind man.  

<p>Just to give a clarification regarding the question, I want to specify in detail these points:
There were only three of them and the blind man's wife and no one else in the situation.</p>

The mute man doesn't know how to write Braille.  

#### Answer accepted (score 10)
<blockquote class="spoiler">
   Tap it out in morse code - or use text-to-speech technology.  
</blockquote>

Old answer:  

<blockquote class="spoiler">
  He types up some braille and puts the blind man's hand on it.  
</blockquote>

#### Answer 2 (score 4)
Of course with access to modern technology or other people, this would become trivial.  

He could write it down and ask someone else without disabilities to read it to the blind man, or he could just send the blind man a message via SMS/Mail whatever, which can be processed text-to-speech.  

If we assume there are only these three man and no access to special technology or other people (one could just place the riddle in a closed room in 16th century to assure this) there are two ways left - communication over a shared available sense (most likely touch) or by tricking the deaf man into telling the blind man.  

The problem is for any kind of trick or secret language the blind and the mute man would have to share a secret-code or something, which has to be communicated first - and if we have a way to communicate that, we can just use this way for the vital information.  

This leaves a trick where the deaf man will somehow reveal himself by accident (for example convincing him the blind man has left the room, he won't here when he comes back and talking to him about the kiss) or using violence or threats to persuade the perpetrator, which will be pretty hard, since the deaf man can tell the blind man anything and we cannot argue against it.  

So the only ways left are conveying information by touch, morse, writing letters with somethimg the blind man can feel, or humming "he kissed your girl" ^^  

#### Answer 3 (score 2)
<blockquote class="spoiler">
   Have the mute man write a well-thought out letter to the blind man's wife explaining the folly of her ways and encouraging her to confess and apologise in order to achieve atonement and regain her honour  
</blockquote>

I would put this "solution" in a comment but I don't have enough kudos or whatever you call them  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: The man who made it didn't want it (score [80820](https://stackoverflow.com/q/29309) in 2016)

#### Question
The man who made it didn't want it.  

The man who bought it didn't need it.  

The man who got it didn't know it.  

What is it?  

Explain your reasoning.  

#### Answer accepted (score 7)
This is an old one.   

<blockquote class="spoiler">
   A coffin or casket.   
</blockquote>

Explanation:  

<blockquote class="spoiler">
   The man who makes it, doesn't want to use it, the man who bought it isn't the one who it's for, and the man got it, is dead.   
</blockquote>

#### Answer 2 (score 4)
The answer is :  

<blockquote class="spoiler">
   Coffin  
</blockquote>

It's a well known riddle :-)  

<blockquote class="spoiler">
  <p> The one who makes it is still alive(probably).<br>
 The one who buys it is also alive.<br>
 The one who is dead, and is buried in it doesn't know that he is in the coffin.  </p>
</blockquote>

#### Answer 3 (score 0)
I also think it could be an atom bomb.  

<blockquote>
  The man who made it didn't want it.  
</blockquote>

They're seen as a necessary evil rather than something wanted   

<blockquote>
  The man who bought it didn't need it.  
</blockquote>

When sold to warring countries its to those who don't actually need it.  

<blockquote>
  The man who got it didn't know it.  
</blockquote>

There's no real early warning system that works practically, so they'd have no warning  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Make numbers 1 - 30 using the digits 2, 0, 1, 8 (score [76112](https://stackoverflow.com/q/58633) in )

#### Question
It's 2018 so let's repeat <a href="https://puzzling.stackexchange.com/questions/47409/make-numbers-1-32-using-the-digits-2-0-1-7">last year's challenge</a> with new digits.  

This is similar to the <a href="https://en.wikipedia.org/wiki/Four_fours" rel="noreferrer">"Four fours"</a> puzzle, but using the digits 2, 0, 1 and 8.  

Rules:  

<ul>
<li>Use all four digits exactly once</li>
<li>Allowed operations: +, -, x, ÷, ! (factorial), exponentiation, square root</li>
<li>Parentheses and grouping (e.g. "21") are also allowed</li>
<li>Squaring uses the digit 2 so expressions using multiple twos, like $2^2$ or $1^2 + 8^2$, are not allowed</li>
<li>Keep the order "2 0 1 8" in at least 25 expressions (and more if you can!)</li>
<li>The modulus operator is not allowed</li>
<li>Rounding is not allowed (e.g. 201/8=25)</li>
</ul>

Good luck and Happy New Year!  

<hr>

<sup>Similar question for <a href="https://puzzling.stackexchange.com/questions/42385/making-1-50-from-2016">2016</a></sup>  

#### Answer accepted (score 30)
Found 29 solutions with the numbers in order. Found two almost acceptable cheats for the remaining one.  

<blockquote class="spoiler">
  <p> $30 = 21 + 0! + 8 = \frac{(2 + 0! + 1)!}{ .8 } = \sqrt{\frac{(2+0+1)!!}{.8}}$ (<em>Cheaty McCheatface</em>)<br>
 $29 = 20 + 1 + 8 $<br>
 $28 = 20 * 1 + 8 $<br>
 $27 = 20 -1 + 8$<br>
 $26 = 2 + \sqrt{\sqrt{(0! + 1)^8}} !$<br>
 $25 = \sqrt{\sqrt{((2 + 0!)!-1)^8}} $<br>
 $24 = (2+0!+1^8)!$<br>
 $23 = 20 + \sqrt{1+8}$<br>
 $22 = -2 + \sqrt{\sqrt{(0! + 1)^8}} !$<br>
 $21 = 20 + 1^8$<br>
 $20 = 20 * 1^8$<br>
 $19 = 20 - 1^8$<br>
 $18 = 2 * 0 + 18$<br>
 $17 = 20 - \sqrt{1+8}$<br>
 $16 = 2^{0!+\sqrt{1+8}}$<br>
 $15 = -2 - 0! + 18$<br>
 $14 = -(2 + 0) * (1 - 8)$<br>
 $13 = 20 + 1 -8 $<br>
 $12 = 20 * 1 - 8 $<br>
 $11 = 20 - 1 - 8 $<br>
 $10 = 2^0 + 1 + 8$<br>
 $9 = 2 * 0 + 1 + 8 $<br>
 $8 = 2 * 0 * 1 + 8 $<br>
 $7 = 2 * 0 - 1 + 8 $<br>
 $6 = (2 + 0) * \sqrt{1+8}$<br>
 $5 = -2 + 0 - 1 + 8$<br>
 $4 = 2 * (0! + 1^8)$<br>
 $3 = 2 + 0 + 1^8 $<br>
 $2 = 20 - 18$<br>
 $1 = 2 * 0 + 1^8$  </p>
</blockquote>

#### Answer 2 (score 14)
Finished all 30, with only 4 not in order  

<blockquote class="spoiler">
  <p> $1  = 2 ^{(0 * 1 * 8)}$<br>
 $2  = 2 + (0 * 1 * 8)$<br>
 $3  = 2 + 0 + (1 ^ 8)$<br>
 $4  = -2 - 0! - 1 + 8$<br>
 $5  = -2 + 0 - 1 + 8$<br>
 $6  = -2 + (0 * 1) + 8$<br>
 $7  = (2 * 0) - 1 + 8$<br>
 $8  = (2 * 0 * 1) + 8$<br>
 $9  = (2 * 0) + 1 + 8$<br>
 $10 = 2 + (0 * 1) + 8$<br>
 $11 = 2 + 0 + 1 + 8$<br>
 $12 = 2 + 0! + 1 + 8$<br>
 $13 = (2 + 0!)! - 1 + 8$<br>
 $14 = (2 + 0!)! + (1 * 8)$<br>
 $15 = (2 + 0!)! + 1 + 8$<br>
 $16 = 2 * (0 + (1 * 8))$<br>
 $17 = -2 + 0! + 18$<br>
 $18 = (2 + 0) * (1 + 8)$<br>
 $19 = 2 - 0! + 18$<br>
 $20 = 2 + 0 + 18$<br>
 $21 = (2 + 0!) * (-1 + 8)$<br>
 $22 =$<br>
 $23 = 20 + \sqrt{(1 + 8)}$<br>
 $24 = (2 + 0 + 1) * 8$<br>
 $25 = $<br>
 $26 = $<br>
 $27 = (2 + 0!) * (1 + 8)$<br>
 $28 = 20 + (1 * 8)$<br>
 $29 = 20 + 1 + 8$<br>
 $30 = $  </p>
</blockquote>

Without maintaining the 2018 order:  

<blockquote class="spoiler">
  <p> $22 = 21 + 8^0$<br>
 $25 = 8 * (2 + 0!) - 1$<br>
 $26 = 28 - 1 - 0!$<br>
 $30 = 21 + (0! + 8)$   </p>
</blockquote>

#### Answer 3 (score 5)
Belated Happy New Year!   

Only uses addition, subtraction, multiplication, exponents and factorials! (and brackets):  

<blockquote>
  <p>$$1=2-0!\cdot1^8$$
  $$2=20-18$$
  $$3=2+0+1^8$$
  $$4=-2-0!-1+8$$
  $$5=-2+0-1+8$$
  $$6=-2+0!-1+8$$
  $$7=-2+0+1+8$$
  $$8=2-0!-1+8$$
  $$9=2+0-1+8$$
  $$10=2+0!-1+8$$
  $$11=2+0+1+8$$
  $$12=2+0!+1+8$$
  $$13=20+1-8$$
  $$14=(2+0+1)!+8$$
  $$15=-2-0!+18$$
  $$16=-2+0+18$$
  $$17=-2+0!+18$$
  $$18=2\cdot0+18$$
  $$19=2-0!+18$$
  $$20=2+0+18$$
  $$21=2+0!+18$$
  $$\color{red}{22=21+(0!)^8}$$
  $$\color{red}{23=(2+0!)\cdot8-1}$$
  $$24=(2+0+1)\cdot8$$
  $$\color{red}{25=(2+0!)\cdot8+1}$$
  $$\color{red}{26=28-0!-1}$$
  $$27=20-1+8$$
  $$28=20^1+8$$
  $$29=20+1+8$$
  $$\color{red}{30=21+0!+8}$$</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: Twelve balls and a scale (score [75823](https://stackoverflow.com/q/183) in 2015)

#### Question
You are given twelve identical-looking balls and a two-sided scale. One of the balls is of a different weight, although you don't know whether it's lighter or heavier. How can you use just three weighings of the scale to determine not only what the different ball is, but also whether it's lighter or heavier?  

#### Answer accepted (score 32)
Split this into three groups of four, A1, A2, A3, A4; B1, B2...; C1, C2... Each step here corresponds to one weighing.  

<ul>
<li>Weigh A against B. 
<ul>
<li>If A > B, then weigh A1, B1, and B2 against B3, B4, and C1.
<ul>
<li>If the weights are equal, then one of A2...4 is heavier; weigh A2 and A3. If they are equal, A4 is heavier. If one is heavier, then that ball is heaviest.</li>
<li>If the first group is heavier, then either A1 is heavier, or B3-4 is lighter. Compare B3 and B4; if they are equal, A1 is heavier; if they are different, the lightest is the lightest ball.</li>
<li>If the first group is lighter, then either B1 or B2 is lighter. Weigh them and see.</li>
</ul></li>
<li>If A &lt; B, renumber all A-balls to B-balls, and perform the above steps.</li>
<li>If A = B, weigh A1, A2, A3 against C1, C2, C3
<ul>
<li>If they are equal, then weigh A1 against C4.  If A1 is lighter, then C4 is the odd ball and it is heavy. If A1 is heavier, then C4 is the odd ball and it is light.</li>
<li>If A is heavier than C, weigh C1 against C2. If they are equal, then C3 is the odd ball and it is lighter. If they are not equal, then the lighter of the two balls is the lightest ball</li>
<li>If A is lighter than C, weigh C1 against C2. If they are equal, then C3 is the odd ball and it is heavier. If they are not equal, then the heavier of the two balls is the heaviest ball.</li>
</ul></li>
</ul></li>
</ul>

We can work backwards from the third step to see, approximately, why this works. At the third weighing, the options need to be reduced to either two or three balls. This means that the second weighing must reduce to either two or three possible balls.  

We know that the first step will remove either 1/3 or 2/3 of the possible solutions, no matter what you do. This means that, in the 1/3 case, you need to split the possibilities down from 8 into a group of 3, a group of 3, and a group of 2. From this, the third weighing points to the odd ball out. Because this case implies one set of balls is heavier, by virtue of finding the odd ball out, we know whether it's heavier or lighter, so we actually don't need to worry about this piece of information at all.  

In the 2/3 case, you need to reduce the possibilities into a group of 3 and a group of 1, which is easy enough to do intuitively. Because we actually don't know the relative weight of the odd ball in this case, the information from the third weighing must be used to determine whether the ball is heavier or lighter.  

#### Answer 2 (score 32)
Split this into three groups of four, A1, A2, A3, A4; B1, B2...; C1, C2... Each step here corresponds to one weighing.  

<ul>
<li>Weigh A against B. 
<ul>
<li>If A > B, then weigh A1, B1, and B2 against B3, B4, and C1.
<ul>
<li>If the weights are equal, then one of A2...4 is heavier; weigh A2 and A3. If they are equal, A4 is heavier. If one is heavier, then that ball is heaviest.</li>
<li>If the first group is heavier, then either A1 is heavier, or B3-4 is lighter. Compare B3 and B4; if they are equal, A1 is heavier; if they are different, the lightest is the lightest ball.</li>
<li>If the first group is lighter, then either B1 or B2 is lighter. Weigh them and see.</li>
</ul></li>
<li>If A &lt; B, renumber all A-balls to B-balls, and perform the above steps.</li>
<li>If A = B, weigh A1, A2, A3 against C1, C2, C3
<ul>
<li>If they are equal, then weigh A1 against C4.  If A1 is lighter, then C4 is the odd ball and it is heavy. If A1 is heavier, then C4 is the odd ball and it is light.</li>
<li>If A is heavier than C, weigh C1 against C2. If they are equal, then C3 is the odd ball and it is lighter. If they are not equal, then the lighter of the two balls is the lightest ball</li>
<li>If A is lighter than C, weigh C1 against C2. If they are equal, then C3 is the odd ball and it is heavier. If they are not equal, then the heavier of the two balls is the heaviest ball.</li>
</ul></li>
</ul></li>
</ul>

We can work backwards from the third step to see, approximately, why this works. At the third weighing, the options need to be reduced to either two or three balls. This means that the second weighing must reduce to either two or three possible balls.  

We know that the first step will remove either 1/3 or 2/3 of the possible solutions, no matter what you do. This means that, in the 1/3 case, you need to split the possibilities down from 8 into a group of 3, a group of 3, and a group of 2. From this, the third weighing points to the odd ball out. Because this case implies one set of balls is heavier, by virtue of finding the odd ball out, we know whether it's heavier or lighter, so we actually don't need to worry about this piece of information at all.  

In the 2/3 case, you need to reduce the possibilities into a group of 3 and a group of 1, which is easy enough to do intuitively. Because we actually don't know the relative weight of the odd ball in this case, the information from the third weighing must be used to determine whether the ball is heavier or lighter.  

#### Answer 3 (score 12)
Some of the existing answers to this ancient question are excellent, but there's one famous answer that I think deserves mention here. It comes from an article in <em>Eureka</em>, the annual magazine of the University of Cambridge's student mathematical society, written by C A B Smith under the pseudonym of "Blanche Descartes".  

It has two very nice features. The first is that it's an "unbranching" solution: you don't need to change what you do on later weighings depending on the results of earlier ones. The second is that once you've seen it it's almost impossible to forget.  

Smith's solution is written entirely in verse and includes an explanation of how it all works, but I shall quote only the actual answer. "F" here is our protagonist Professor Felix Fiddlesticks, whose mother has asked him for help with the puzzle. I have made some trifling changes to the original formatting.  

<blockquote>
  <p>F set the coins out in a row<br>
  And chalked on each a letter, so,<br>
  To form the words: `F AM NOT LICKED`<br>
  (An idea in his brain had clicked.)  </p>
  
  <p>And now his mother he'll enjoin:<br>
  "MA, DO / LIKE<br>
  ME TO / FIND<br>
  FAKE / COIN!"</p>
</blockquote>

Each of the three lines of F's injunction describes one weighing. When you've done them all, the results uniquely determine which coin is fake and in which way.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: In the 100 blue eyes problem - why is the oracle necessary? (score [73451](https://stackoverflow.com/q/236) in 2015)

#### Question
<h5>The riddle</h2>

Randall Munroe (of <a href="https://xkcd.com">xkcd</a> fame) has, a bit hidden on his site, <a href="https://xkcd.com/blue_eyes.html">a logic puzzle</a>:  

<blockquote>
  <p>A group of people with assorted eye colors live on an island. They are
  all perfect logicians -- if a conclusion can be logically deduced,
  they will do it instantly. No one knows the color of their eyes. Every
  night at midnight, a ferry stops at the island. Any islanders who have
  figured out the color of their own eyes then leave the island, and the
  rest stay. Everyone can see everyone else at all times and keeps a
  count of the number of people they see with each eye color (excluding
  themselves), but they cannot otherwise communicate. Everyone on the
  island knows all the rules in this paragraph.</p>
  
  <p>On this island there are 100 blue-eyed people, 100 brown-eyed people,
  and the Guru (she happens to have green eyes). So any given blue-eyed
  person can see 100 people with brown eyes and 99 people with blue eyes
  (and one with green), but that does not tell him his own eye color; as
  far as he knows the totals could be 101 brown and 99 blue. Or 100
  brown, 99 blue, and he could have red eyes.</p>
  
  <p>The Guru is allowed to speak once (let's say at noon), on one day in
  all their endless years on the island. Standing before the islanders,
  she says the following:</p>
  
  "I can see someone who has blue eyes."  
  
  Who leaves the island, and on what night?  
  
  <p>There are no mirrors or reflecting surfaces, nothing dumb. It is not a
  trick question, and the answer is logical. It doesn't depend on tricky
  wording or anyone lying or guessing, and it doesn't involve people
  doing something silly like creating a sign language or doing genetics.
  The Guru is not making eye contact with anyone in particular; she's
  simply saying "I count at least one blue-eyed person on this island
  who isn't me."</p>
  
  And lastly, the answer is not "no one leaves."  
</blockquote>

He admits the puzzle isn't his:  

<blockquote>
  I didn't come up with the idea of this puzzle, but I've written and rewritten it over the the years to try to make a definitive version. The guy who told it to me originally was some dude on the street in Boston named Joel.  
</blockquote>

<h5>The answer</h2>

He gives <a href="https://xkcd.com/solution.html">his solution</a>:  

<blockquote>
  The answer is that on the 100th day, all 100 blue-eyed people will leave. It's pretty convoluted logic and it took me a while to believe the solution, but here's a rough guide to how to get there. Note -- while the text of the puzzle is very carefully worded to be as clear and unambiguous as possible (thanks to countless discussions with confused readers), this solution is pretty thrown-together. It's correct, but the explanation/wording might not be the best. If you're really confused by something, let me know.  
  
  If you consider the case of just one blue-eyed person on the island, you can show that he obviously leaves the first night, because he knows he's the only one the Guru could be talking about. He looks around and sees no one else, and knows he should leave. So: [THEOREM 1] If there is one blue-eyed person, he leaves the first night.  
  
  If there are two blue-eyed people, they will each look at the other. They will each realize that "if I don't have blue eyes [HYPOTHESIS 1], then that guy is the only blue-eyed person. And if he's the only person, by THEOREM 1 he will leave tonight." They each wait and see, and when neither of them leave the first night, each realizes "My HYPOTHESIS 1 was incorrect. I must have blue eyes." And each leaves the second night.  
  
  So: [THEOREM 2]: If there are two blue-eyed people on the island, they will each leave the 2nd night.  
  
  If there are three blue-eyed people, each one will look at the other two and go through a process similar to the one above. Each considers the two possibilities -- "I have blue eyes" or "I don't have blue eyes." He will know that if he doesn't have blue eyes, there are only two blue-eyed people on the island -- the two he sees. So he can wait two nights, and if no one leaves, he knows he must have blue eyes -- THEOREM 2 says that if he didn't, the other guys would have left. When he sees that they didn't, he knows his eyes are blue. All three of them are doing this same process, so they all figure it out on day 3 and leave.  
  
  This induction can continue all the way up to THEOREM 99, which each person on the island in the problem will of course know immediately. Then they'll each wait 99 days, see that the rest of the group hasn't gone anywhere, and on the 100th night, they all leave.  
  
  Before you email me to argue or question: This solution is correct. My explanation may not be the clearest, and it's very difficult to wrap your head around (at least, it was for me), but the facts of it are accurate. I've talked the problem over with many logic/math professors, worked through it with students, and analyzed from a number of different angles. The answer is correct and proven, even if my explanations aren't as clear as they could be.  
  
  User lolbifrons on reddit posted <a href="http://www.reddit.com/r/AskReddit/comments/khhpl/reddit_what_is_your_favorite_riddle/c2kdlr6">an inductive proof</a>.  
  
  If you're satisfied with this answer, here are a couple questions that may force you to further explore the structure of the puzzle:   
  
  <ol>
  <li>What is the quantified piece of information that the Guru provides that each person did not already have? </li>
  <li>Each person knows, from the beginning, that there are no less than 99 blue-eyed people on the island. How, then, is considering the 1 and 2-person cases relevant, if they can all rule them out immediately as possibilities? </li>
  <li>Why do they have to wait 99 nights if, on the first 98 or so of these nights, they're simply verifying something that they already know? </li>
  </ol>
  
  These are just to give you something to think about if you enjoyed the main solution. They have answers, but please don't email me asking for them. They're meant to prompt thought on the solution, and each can be answered by considering the solution from the right angle, in the right terms. There's a different way to think of the solution involving hypotheticals inside hypotheticals, and it is much more concrete, if a little harder to discuss. But in it lies the key to answering the four questions above.  
</blockquote>



<h5>The question</h2>

Everybody on the island could have come to the conclusion that 'There is at least one person with blue eyes', simply by looking around, seeing 100 people with blue eyes, and realising that everybody can see at least one person with blue eyes.  

<strong>So why is it necessary for the Guru to say 'I see at least one person with blue eyes' to get the ball rolling?</strong>  

#### Answer accepted (score 40)
Let's continue the induction, since the jump to 99 blue eyes does seem weird. After all, everyone knows that someone has blue eyes.  

If there are 4 blue eyed-people, A will look at B,C,D, thinking :  

<blockquote class="spoiler">
   Maybe I don't have blue eyes (only 3 blue eyes?). In this case B must be thinking, that he may not have blue eyes either, and B is looking at C and D, whom he perceives as being the only ones to have blue eyes (since I consider the option that I don't have blue eyes), and B thinks that C is having the same reasoning. C thinks he does not have blue eyes and only D has.  
</blockquote>

Now, the issue here is that I, being A, can see that B has blue eyes. Therefore I know that C sees at least D and B as having blue eyes. But this is the reasoning of B, who does not know that he has blue eyes.  

<blockquote class="spoiler">
   When I project myself into the reasoning of the next person, I cannot use the knowledge I have of their eyes color.  
</blockquote>

The same goes for 5 people and more. I see 4 blue-eyed people, each of which is possibly seeing only 3, and thinking that each of the other is possibly seeing only 2...  

#### Answer 2 (score 48)
Every blue-eyed person sees 99 blue-eyed people. Since they don't know that they have blue eyes, they suspect it might be the case that every other blue-eyed person can only see 98 blue-eyed people, and if those people only see 98 blue-eyed people, they might think that each of <em>them</em> only see 97 blue-eyed people. And so it continues, until someone considers a hypothetical situation in which someone sees no blue-eyed people. Then the guru, in this hypothetical, really does make a difference.  

So the essential piece of information the Guru provides is that everyone knows that everyone knows that everyone knows that [... etc. ...] everyone knows that there is someone on the island with blue eyes. This enables everyone to discard that nested hypothetical.  

It might be easier if we assign everyone numbers. People 1 to 100 have blue eyes. Person 1 sees 99 people with blue eyes, so suspects that Person 2 might see only 98 people with blue eyes, in which case Person 2 would think that Person 3 might only be able to see 97 people with blue eyes, in which case they would think that Person 4 might only be able to see 96… all this speculating is unravelled when everyone finds out that if Person 100 could not see any blue eyes, then Person 100 would be able to leave, so if Person 99 could only see one set of blue eyes, Person 99 would be able to leave after they didn't, so… etc.  

<hr>

Perhaps this is enlightening: if the Guru went to each person individually, and told them each in secret that there was a person with blue eyes, then it would not help: they would truly have learned nothing. The Guru saying that someone has blue eyes does not change anyone's mind about whether or not anyone has blue eyes. But that's not all everyone gets from the situation: not only did everyone hear the announcement, everyone saw that everyone else heard the announcement, and everyone saw that everyone saw that etc. Everyone finds out something about other people's state of knowledge.  

#### Answer 3 (score 40)
Every blue-eyed person sees 99 blue-eyed people. Since they don't know that they have blue eyes, they suspect it might be the case that every other blue-eyed person can only see 98 blue-eyed people, and if those people only see 98 blue-eyed people, they might think that each of <em>them</em> only see 97 blue-eyed people. And so it continues, until someone considers a hypothetical situation in which someone sees no blue-eyed people. Then the guru, in this hypothetical, really does make a difference.  

So the essential piece of information the Guru provides is that everyone knows that everyone knows that everyone knows that [... etc. ...] everyone knows that there is someone on the island with blue eyes. This enables everyone to discard that nested hypothetical.  

It might be easier if we assign everyone numbers. People 1 to 100 have blue eyes. Person 1 sees 99 people with blue eyes, so suspects that Person 2 might see only 98 people with blue eyes, in which case Person 2 would think that Person 3 might only be able to see 97 people with blue eyes, in which case they would think that Person 4 might only be able to see 96… all this speculating is unravelled when everyone finds out that if Person 100 could not see any blue eyes, then Person 100 would be able to leave, so if Person 99 could only see one set of blue eyes, Person 99 would be able to leave after they didn't, so… etc.  

<hr>

Perhaps this is enlightening: if the Guru went to each person individually, and told them each in secret that there was a person with blue eyes, then it would not help: they would truly have learned nothing. The Guru saying that someone has blue eyes does not change anyone's mind about whether or not anyone has blue eyes. But that's not all everyone gets from the situation: not only did everyone hear the announcement, everyone saw that everyone else heard the announcement, and everyone saw that everyone saw that etc. Everyone finds out something about other people's state of knowledge.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: Flip edge in Equator layer (score [71502](https://stackoverflow.com/q/163) in )

#### Question
If you use the Beginners' Method to solve the Rubik's cube, and solve the equator layer (the layer between the U-layer and D-layer), it can happen that one of the edges is flipped, like this:  

<img src="https://i.stack.imgur.com/U1npR.png" alt="Flipped edge in Equator layer">  

<sup>Screenshot generated using Cube Explorer</sup>  

A way to solve this is to replace the flipped edge by a random block and then put the edge at its right place. However, I would prefer a shorter way to do this. It does not matter what happens to the top layer.  

How can I do this?  

#### Answer accepted (score 5)
An intuitive solution is to remove both the corner and edge, splitting them up, then move them back in an intelligent way. This can be done with:  

```text
R U R' U' R U' R'
```

then by solving again.   

Or, you could just memorize an algorithm. A couple easy solutions:  

```text
(R2 U2) (F R2 F') (U2 R' U R')
(R' F R F') (R U' R' U) (R U' R' U2) (R U' R')
```

It's also a good idea to actively avoid being stuck in this situation whenever possible.  

#### Answer 2 (score 3)
I would suggest starting to look ahead (which you might do <a href="http://lar5.com/cube/" rel="nofollow">earlier than this</a>, but could do here), you know you will want all the top (as you show) edges to have the correct flip, this would be an ideal point at which to start combining your efforts - your method most likely does the corners next, but it is most likely that the manoeuvres you already use do not flip the edges*.  

The fact that this edge is flipped and $7$ are not (the ones you've solved) means either $1$ or $3$ of the other $4$ (on the top) are flipped.  

If only $1$ edge is flipped on `U` ($3$ yellows are facing up in your diagram) you could use a "flavour" of a single $9$ face-turn manoeuvre to both flip the edge you are solving and that one:  

```text
Flipped U Edge    Sequence
      B           R2 U2 F  R2 F' U2 R' U  R'
      F           R  U' R  U2 F  R2 F' U2 R2
      R           F' U  F' U2 R' F2 R  U2 F2
      L           F2 U2 R' F2 R  U2 F  U' F
```

If $3$ edges are flipped on `U` ($1$ yellow is facing up in your diagram) you could use a "flavour" of a single $11$ face-turn manoeuvre to both flip the edge you are solving and those three:  

```text
Correct U Edge    Sequence
      B           F' U  F  U' R  U2 B  U' B' U  R'
      F           R  U' B  U  B' U2 R' U  F' U' F
      L           R  U' R' U  F' U2 L' U  L  U' F
      R           F' U  L' U' L  U2 F  U' R  U  R'
```

<hr>

* If you're manoeuvres to swap two corners and twist three corners on your final layer do flip edges, you could use these and their reflections instead:  

```text
Swap 2 corners:   R  U' L' U  R' U' L
Twist 3 corners:  L' U' L  U' L' U2 L
```

#### Answer 3 (score 3)
I would suggest starting to look ahead (which you might do <a href="http://lar5.com/cube/" rel="nofollow">earlier than this</a>, but could do here), you know you will want all the top (as you show) edges to have the correct flip, this would be an ideal point at which to start combining your efforts - your method most likely does the corners next, but it is most likely that the manoeuvres you already use do not flip the edges*.  

The fact that this edge is flipped and $7$ are not (the ones you've solved) means either $1$ or $3$ of the other $4$ (on the top) are flipped.  

If only $1$ edge is flipped on `U` ($3$ yellows are facing up in your diagram) you could use a "flavour" of a single $9$ face-turn manoeuvre to both flip the edge you are solving and that one:  

```text
Flipped U Edge    Sequence
      B           R2 U2 F  R2 F' U2 R' U  R'
      F           R  U' R  U2 F  R2 F' U2 R2
      R           F' U  F' U2 R' F2 R  U2 F2
      L           F2 U2 R' F2 R  U2 F  U' F
```

If $3$ edges are flipped on `U` ($1$ yellow is facing up in your diagram) you could use a "flavour" of a single $11$ face-turn manoeuvre to both flip the edge you are solving and those three:  

```text
Correct U Edge    Sequence
      B           F' U  F  U' R  U2 B  U' B' U  R'
      F           R  U' B  U  B' U2 R' U  F' U' F
      L           R  U' R' U  F' U2 L' U  L  U' F
      R           F' U  L' U' L  U2 F  U' R  U  R'
```

<hr>

* If you're manoeuvres to swap two corners and twist three corners on your final layer do flip edges, you could use these and their reflections instead:  

```text
Swap 2 corners:   R  U' L' U  R' U' L
Twist 3 corners:  L' U' L  U' L' U2 L
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: What can go up a chimney down, but not down a chimney up? (score [61276](https://stackoverflow.com/q/56028) in 2017)

#### Question
Here's one I know from childhood. I didn't see it on here, so I thought I would add it.  

<blockquote>
  What can go up a chimney down,  but not down a chimney up?  
</blockquote>

#### Answer accepted (score 3)
<blockquote class="spoiler">
   An umbrella. If "up" (open), you cannot pull it down a chimney (it's too wide); if it's "down" (closed), it will easily fit through.  
</blockquote>

#### Answer 2 (score 2)
<blockquote class="spoiler">
   Down  
</blockquote>

It goes up a chimney down, and in the unlikely case that it isn't burnt up and comes back down the chimney it would come down down.  

#### Answer 3 (score 2)
<blockquote class="spoiler">
   Down  
</blockquote>

It goes up a chimney down, and in the unlikely case that it isn't burnt up and comes back down the chimney it would come down down.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: Are there published Sudoku puzzles that require guessing? (score [60838](https://stackoverflow.com/q/12) in 2016)

#### Question
I believe in a number of books I have read and solved myself, the introduction stated that guessing should never be necessary for any of the puzzles in the book.  Instead, a handful of techniques could be used to solve the puzzle completely, including the hard puzzles.  

Are there published puzzles out there that do require guessing? Perhaps designed to challenge those who have "mastered" the more basic Sudoku puzzles?  

#### Answer accepted (score 32)
The immediate answer is no. Any valid Sudoku can be solved without guessing, just by exhaustively trying all possibilities.  

However, there are two interesting variant interpretations of the question:  

<strong>Are there Sudoku puzzles that can't be solved logically?</strong>  

This one depends on what you accept as a "logical solution." In the strictest sense, the answer is again <em>no.</em> However, if you define a "logical solution" as excluding brute-force solving, the answer is probably "yes." There is some imprecise agreement on what constitutes a logical solution under this definition in the puzzling community, but based on this, we will again find that yes, there are definitely Sudoku puzzles that have no logical solution.  

Thomas Snyder has given an insightful <a href="http://www.gmpuzzles.com/blog/2013/03/ask-dr-sudoku-12-the-line-must-be-drawn-here/">definition</a> of when a puzzle is solvable logically:  

<blockquote>
  When I can solve a puzzle in ink, without erasures, with all deductions either positive or negative coming from visualization in my head and not making scratch-work on the paper, the puzzle is solvable by logic.  
</blockquote>

<strong>Are there Sudoku puzzles that are faster to solve by guessing?</strong>  

Again, the answer is "yes." In a competitive setting, most solvers would not use the more obscure techniques. After having narrowed possibilities somewhat with realistic techniques, some puzzles "require" guessing so as to not put the solver at a competitive disadvantage.  

#### Answer 2 (score 12)
Every <a href="http://en.wikipedia.org/wiki/Mathematics_of_Sudoku#Minimum_number_of_givens">"proper" sudoku puzzle</a> which only has one solution can be solved without guessing.  

The only time you would need to guess is when the sudoku puzzle is improper, and thus has multiple possible solutions, and your guesses would be irrelevant to whether the puzzle could be solved.  

And, just so people are aware, improper sudoku puzzles are actually not uncommon. I have a booklet of them on my shelf, so these puzzles are actually used.  

In these cases, the puzzles aren't more challenging necessarily (though they're typically written to be). While improper puzzles <em>can</em> be harder to solve, they are not usually more difficult to solve <em>because</em> they are improper, but rather because the design of the puzzle is more difficult.  

#### Answer 3 (score 8)
TL;DR - short of a definitive mathematical proof, there is no way of knowing.  

If you do a web search for Sudoku solving techniques, you will find that there are a great many. Some of them are difficult and obscure, but handle cases that can't be solved any other way.  

My own experience, using the Sudoku app on my tablet, has been that every puzzle, no matter how difficult, can be solved by some technique, no matter how obscure. So, if you don't know a technique for a given situation, you may be reduced to guessing, but when asked for a hint, my tablet has always had a technique up it's sleeve for every possible situation.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Which way is the bus going? (score [57797](https://stackoverflow.com/q/575) in 2016)

#### Question
<img src="https://i.stack.imgur.com/rmanH.jpg" alt="enter image description here">  

If I'm not mistaken, this is a children's puzzle, but it got me thinking for a while.  

<strong>The bus is driving on the autobahn. Relative to you, which way is the bus going? Left or Right?</strong>  

#### Answer accepted (score 36)
I saw this problem on a web page once.  

<hr>

The initial thought that most people have is that you can't tell, because the bus is totally symmetrical. However, this misses one important detail that apparently children will imply in their minds more often than adults.  

The canonical answer is that <em>this picture of a bus is missing its door</em>, and therefore the bus must be going <em>left</em>, because the door is on the <em>right</em> side of the bus and there's no door visible on the side that's facing you in the picture.  

<hr>

Of course, as Gilles pointed out, depending on which country you're in, the bus could be driving on either side of the road. If you're in Britain or some of the Commonwealth countries, then the bus must be going <em>right</em>, because the door is on the <em>left</em> side of the bus.  

And depending on where from the bus you're exiting, the door could be on the top or bottom as well. I've never seen a bus that had its wheels so far below the chassis like on this one, and maybe there's a stairwell that opens from the bottom to let people in and out.  

Alternatively, it could be a maglev train given that the car appears to be floating above two round things. A maglev train has doors on <em>both</em> sides. In both of the above cases, you can't tell which way the vehicle is going without further information.  

<hr>

The question was updated to indicate that the bus was driving on the Autobahn. However, a <em>bus</em> on the <em>Autobahn</em> sounds really unsafe, and so we might actually be viewing a tipped-over bus from a bird's eye view (it would certainly explain the detached wheels). In such a case, you still couldn't tell which way the bus was going unless you knew which side of the highway it was driving on.  

#### Answer 2 (score 3)
Another way of looking at it, this image looks much like the grill or front face of the bus.   

With that in mind I would answer that it is going neither to the left nor the right from my perspective. Relative to me, the bus is advancing directly at me.  

#### Answer 3 (score 1)
I know this has been answered already. But thought I'd add my opposite thought.  

Under the assumption that you haven't just stepped into the middle of the autobahn, and that the bus is heading in the correct direction. The bus must be on the side of the road closest to you, otherwise you would have a crash barrier in the way.  

if this was the case then the bus would be moving right. And the bus evidently comes from the UK and took the wrong exit when heading onto the autobahn (hence the door not being on the right side)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: A man with two red pills and two white pills (score [57508](https://stackoverflow.com/q/6688) in )

#### Question
<h5>Story:</h2>

A Color blind man is travelling in a somewhat famous ship that had just a few people on board. Everything was smooth sailing for some days.  

One day,the man heard some noises from outside when he was in his room. The ship started to shake and began to sink. By the time the man reached outside,nobody was there and the ship was almost fully sunk. There was no time for the man to search for the rest of the crew. He jumped in the ocean and saw the ship sinking to the bottom of the ocean.  

Struggling to find some help,he sees an island and swam straight in that direction. The current was a bit strong,but he managed to get to his destination. By the time he reaches the shore,he starts coughing and also remembers something. <strong>He forgot to take his pills!</strong>. He keeps a few pills in his pocket and the rest in his room. He thrust his hand into his pocket. Fortunately, The pills were still there in his pocket.  

<h5>Puzzle:</h2>

He recalls putting 4 pills in his pocket(with the help of a friend) out of which 2 are red ones and the rest of them are white. All the pills are completely identical. He is supposed to take one red pill and one white pill everyday. The order which he takes them doesn't matter. He must <strong>not</strong> take two pills of the same color and if he does so,he dies. How does he take one red pill and one white pill?  

Note that the man is <em>color blind</em> and he knows that help will arrive soon,since the ship he was travelling was a famous one. Also,the island that the man is on is <em>deserted</em>.  

#### Answer accepted (score 33)
<strong>Answer:</strong>  

<blockquote class="spoiler">
   Just take half of each pill everyday which will always be 1 red + 1 white when put together.  
</blockquote>

#### Answer 2 (score 10)
<strong>Answer:</strong>  

<blockquote class="spoiler">
  <p> Put them in the sun. The white pills will be cooler than the red,
 since they will reflect more light. Take a warm pill and a cool pill
 per day - and cross your fingers!</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: A short, brutal riddle (score [53338](https://stackoverflow.com/q/20233) in 2017)

#### Question
<blockquote>
  Left alone, I'm a word with five letters.  
  
  I'm honest and fair, I'll admit.  
  
  Rearranged, I'm of no use to trains.  
  
  Again, and I'm an overt place, warm and well lit.  
</blockquote>

<strong>What am I?</strong>  

#### Answer accepted (score 505)
I believe the answer is    

<blockquote class="spoiler">
  LIAR    
</blockquote>

The riddle was tricky (as indicated by the title) and each of the lines is    

<blockquote class="spoiler">
  a lie.    
</blockquote>

Left alone, I'm a word with five letters.    

<blockquote class="spoiler">
  The word is actually 4 letters    
</blockquote>

I'm honest and fair I'll admit    

<blockquote class="spoiler">
  Obviously, a liar is the antithesis of honest and fair.    
</blockquote>

Rearranged, I'm of no use to trains.    

<blockquote class="spoiler">
  RAIL, an anagram of LIAR, is an incredibly important facet to the function of trains.    
</blockquote>

Again, and I'm an overt place, warm and well-lit.    

<blockquote class="spoiler">
  LAIR, another anagram of LIAR, is a hidden, dark place, the opposite of the adjectives provided.    
</blockquote>

I could be way off track but I have a good feeling that this is it.  

#### Answer 2 (score 69)
I'm honest and fair I'll admit:  

<blockquote class="spoiler">
   <a href="https://en.wikipedia.org/wiki/Snipe">Snipe</a>, a bird perhaps capable of deception. We'll have to cover our bases with truths <em>and</em> lies to be sure.  
</blockquote>

Rearranged, I'm of no use to trains:  

<blockquote class="spoiler">
  <p> Spine (useless to trains)<br>
 or<br>
 Pines (a lie! Pine is a type of wood which could be used in <a href="https://en.wikipedia.org/wiki/Railroad_tie">railroad ties</a>)</p>
</blockquote>

Again, and I'm an overt place, warm and well-lit:  

<blockquote class="spoiler">
  <p> Penis (Warm, though often illegal to be overt and well-lit)<br>
 or<br>
 <a href="https://en.wikipedia.org/wiki/Peins">Peins, Netherlands</a> (a lie! With moderate/cool yearly averages and a population of just 270 (in 2006), Peins is likely secluded, cool, and poorly lit.)</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: Make the equation true by only drawing a single straight line (score [50124](https://stackoverflow.com/q/4315) in 2014)

#### Question
Fred has a puzzle.  The instruction sheet, which is separate from the equation,simply says:  "Make this equation true.  You may ONLY draw ONE, PERFECTLY straight line".  The equation is all alone on a blank piece of paper and reads:    

```text
5+5+5=550
```

There are 4 acceptable answers.  You must get all 4 for a correct answer.  

#### Answer accepted (score 37)
<ol>
<li><blockquote class="spoiler">
   Cross out the equals sign  
</blockquote></li>
<li><blockquote class="spoiler">
   Turn the first $+$ into a 4 giving $545+5=550$  
</blockquote></li>
<li><blockquote class="spoiler">
   Turn the second $+$ into a 4 giving $5+545=550$  
</blockquote></li>
<li><blockquote class="spoiler">
   Turn the equals sign into less than or equal to  
</blockquote></li>
</ol>

#### Answer 2 (score 15)
I think the fourth answer, which hasn't been posted yet is:  

<blockquote class="spoiler">
  $5+5+5≤550$  
</blockquote>

That makes all of them:  

<blockquote class="spoiler">
  <p>$5+5+5≤550$<br/>
$545+5=550$<br/>
$5+545=550$<br/>
$5+5+5≠550$<br/></p>
</blockquote>

#### Answer 3 (score 10)
<blockquote class="spoiler">
  <p> 5+5+5≠550
 <br><br>negating the equality.
 <br><br>
 Edit:
 <br>You could negate the entire statement, depending on how you interpret the equation...<br>
 _________<br>
 5+5+5=550     &nbsp;&nbsp;&nbsp;could evaluate to "true" in some contexts... ^^</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Fill the holes? (score [49848](https://stackoverflow.com/q/11729) in 2015)

#### Question
You have to fill the boxes to make the equation true:  

<kbd> </kbd> + <kbd> </kbd> + <kbd> </kbd> = 30  

Using only <kbd>1</kbd>, <kbd>3</kbd>, <kbd>5</kbd>, <kbd>7</kbd>, <kbd>9</kbd>, <kbd>11</kbd>, <kbd>13</kbd>, <kbd>15</kbd>.  

You can also repeat the numbers. (eg: 1 + 1 + 1)  

<h5>Edit1: the boxes of the equation are empty right now</h3>

<h5>Edit 2:</h3>

That's my first post here and I didn't realize how fantastics your mind was, that's why my question was so broad. I'll accept the answer I was expecting but it doesn't mean that the other are wrong. Let's the upvoter decide.  

#### Answer accepted (score 4)
<blockquote>
  __+15+15 = 30  
</blockquote>

Assuming we don't need to use all the boxes   

#### Answer 2 (score 15)
I think we can use a little trick:  

<blockquote class="spoiler">
   Just use 9 upside down: 11 + 6 + 13 = 30  
</blockquote>

#### Answer 3 (score 12)
I think the answer is  

<blockquote class="spoiler">
   The sum of 3 odd numbers will always be odd, so there is no answer that will yield an even number  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: Make numbers 1 - 32 using the digits 2, 0, 1, 7 (score [49183](https://stackoverflow.com/q/47409) in 2017)

#### Question
This is similar to the <a href="https://en.wikipedia.org/wiki/Four_fours" rel="nofollow noreferrer">"Four fours"</a> puzzle, but using the digits 2, 0, 1 and 7.  

Rules:  

<ul>
<li>Use all four digits exactly once</li>
<li>Allowed operations: +, -, x, ÷, ! (factorial), exponentiation, square root</li>
<li>Parentheses and grouping (e.g. "21") are also allowed</li>
<li>Squaring uses the digit 2 so expressions using multiple twos, like $2^2$ or $1^2 + 7^2$, are not allowed</li>
<li>Keep the order "2017" in at least 16 expressions (and more if you can!)</li>
</ul>

Good luck and Happy New Year!  

<hr>

<sup>Similar question for <a href="https://puzzling.stackexchange.com/questions/42385/making-1-50-from-2016">2016</a></sup>  

#### Answer accepted (score 16)
This answer has 29 expressions with the "2017" order. Those NOT in order are denoted by sadness - :(   

<blockquote class="spoiler">
   $1=2*0+1^7$ <br/><br/>$2=2^0+1^7$<br/><br/>$3=2+0+1^7$<br/><br/>$4=-2+0-1+7$<br/><br/>$5=-2+(0*1)+7$<br/><br/>$6=(2*0)-1+7$<br/><br/>$7=2^0-1+7$<br/><br/>$8=(2*0)+1+7$<br/><br/>$9=2+(0*1)+7$<br/><br/>$10=2+0+1+7$<br/><br/>$11=2+0!+1+7$<br/><br/>$12=(2+0)*(-1+7)$<br/><br/>$13=(2+0+1)!+7$<br/><br/>$14=(2+0!)!+1+7$<br/><br/>$15=-2+0+17$ (Improved for order by Ivo Beckers)<br/><br/>$16=-((2*0)!)+17$<br/><br/>$17=(2*0)+17$<br/><br/>$18=(2^0)+17$<br/><br/>$19=2+0+17$<br/><br/>$20=2+0!+17$<br/><br/>$21=20+1^7$<br/><br/>$22=-2+ (\sqrt{-(0!-17)})!$ (Improved by Pratheek B!) <br/><br/>$23=(2+0!)!+17$<br/><br/>$24=(2+0!)*(1+7)$<br/><br/>$25=(7-1-0!)^2$ :(<br/><br/>$26=20-1+7$<br/><br/>$27=20+(1*7)$<br/><br/>$28=20+1+7$<br/><br/>$29=27+(1+0!)$ :(<br/><br/>$30=10\sqrt{2+7}$ :(<br/><br/>$31=(2+0!+1)!+7$<br/><br/>$32=2^{-(0!)-1+7}$  
</blockquote>

FOOLING AROUND (I'm simply curious about how far we can go)  

<blockquote class="spoiler">
   $33=17*2-0!$<br/><br/>$34 = (2+0)*17$ :D<br/><br/>$35=((2+0!)!-1)*7$ (Improved by Christoph!)<br/><br/>$36=(7-1+0)^2$<br/><br/>$37=20+17$ :D<br/><br/>$38=???$<br/><br/>$39=7^2-10$<br/>  
</blockquote>

#### Answer 2 (score 6)
In order solution for 22:  

<blockquote class="spoiler">
   $-2 + \sqrt{-0! + 17}! $  
</blockquote>

#### Answer 3 (score 4)
Okay, I know there's another answer but I'm posting mine before I look at it (honest!). 28/32 in order.  

<blockquote class="spoiler">
  <p> 1 = 2^(0*1*7)<br>
 2 = 2 + 0*1*7<br>
 3 = 2 + 0 + 1^7<br>
 4 = -2 + 0 - 1 + 7<br>
 5 = -2 + 0*1 + 7<br>
 6 = -2 + 0 + 1 + 7<br>
 7 = 2*0*1 + 7<br>
 8 = (2^0)*1 + 7<br>
 9 = 2 + 0*1 + 7<br>
 10 = 2 + 0 + 1 + 7<br>
 11 = 2 + 0! + 1 + 7<br>
 12 = 2*(0 - 1 + 7)<br>
 13 = (2 + 0 + 1)! + 7<br>
 14 = 2*(0*1 + 7)<br>
 15 = -2 + 0 + 17<br>
 16 = 2*(0 + 1 + 7)<br>
 17 = 2*0 + 17<br>
 18 = 2^0 + 17<br>
 19 = 2 + 0 + 17<br>
 20 = 20 * 1^7<br>
 21 = 20 + 1^7<br>
 *22 = 21 + 7^0<br>
 23 = (2 + 0!)! + 17<br>
 24 = (2 + 0!) * (1 + 7)<br>
 *25 = (7 - 2)^(0! + 1!)<br>
 26 = 20 - 1 + 7<br>
 27 = 20 + 1*7<br>
 28 = 20 + 1 + 7<br>
 *29 = 21 + 0! + 7<br>
 *30 = 210 / 7<br>
 31 = (2 + 0! + 1)! + 7<br>
 32 = 2 * (-0! + 17)  </p>
</blockquote>

My attempts to press on...  

<blockquote class="spoiler">
  <p> *33 = 2*17 - 0!<br>
 34 = (2 + 0)*17<br>
 35 = ((2 + 0!)! - 1)*7<br>
 36 = 2 * (0! + 17)<br>
 37 = 20 + 17<br>
 38 = ?<br>
 *39 = 7^2 - 10<br>
 40 = ?<br>
 *41 = ((2 + 0!)! * 7) - 1<br>
 42 = (2 + 0!)! *1*7<br>
 *43 = ((2 + 0!)! * 7) + 1<br>
 44 = ?<br>
 45 = ?<br>
 46 = ?<br>
 *47 = 7^2 - 0! - 1<br>
 48 = (2 + 0!)! * (1 + 7)<br>
 49 = ((2 + 0!)! + 1) * 7<br>
 *50 = 7^2 + 0 + 1<br>
 51 = (2 + 0!) * 17  </p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: 6 Tries to Guess a Number Between 1-100 (score [47675](https://stackoverflow.com/q/3074) in )

#### Question
After every time you guess, you're told if you're right, too high, or too low. Is there a strategy you can use to guarantee you'll get it on your 6th attempt (or lower)?  

I know a strategy to get it on your 7th attempt.  

#### Answer accepted (score 30)
Ask about 50.   

<ul>
<li><p>If too high, then ask about 25.  </p></li>
<li><p>If too low, then ask about 75. </p></li>
</ul>

Continue, continually halving the search-space. This requires $\lceil \log_2 (n+1)\rceil$ maximum questions. For 100, that's 7. It is a binary search algorithm known to be $\mathrm O(\log(n))$ time. I'm fairly sure there isn't a faster way. Binary search is considered the best for this problem - unless you are allowed to ask other questions.  

#### Answer 2 (score 24)
Yes.  

Each guess eliminates one number as well as dividing the remaining numbers into 2. One guess can pick a number from 3 (is your number 2?). 2 guesses can do 7. N guesses can pick a number from $2^{N+1}-1$, so 6 guesses can do it for 1-127.  

Edit: As noted in the comments, you're supposed to have <strong>guessed</strong> the number on or before the 6th attempt, while this only ensures you <strong>know</strong> the answer by then.  

#### Answer 3 (score 17)
Totally ripping off <a href="https://puzzling.stackexchange.com/users/2162/matt-malone">Matt Malone</a>'s answer:  

If you can ask any question about the number where "correct," "too high," or "too low" are valid answers, go with:  

<ol>
<li>If you translate the number into trinary, is the last digit a "1"?</li>
<li>If you translate the number into trinary, is the second-to-last digit a "1"?</li>
<li>If you translate the number into trinary, is the third digit from the right a "1"?</li>
<li>If you translate the number into trinary, is the forth digit from the right a "1"?</li>
<li>If you translate the number into trinary, is the fifth digit from the right a "1"?</li>
<li>Is the number X?</li>
</ol>

For example, 100 in trinary would be 10201.  The first five answers would be: "correct, too high, too low, too high, correct" which would tell me that the number is 100.  That would be my final guess.  

This works for any integer from 0 up to 242.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: What is the maximum number of solutions a Sudoku puzzle can have? (score [46788](https://stackoverflow.com/q/2) in 2015)

#### Question
I've seen Sudoku puzzles that can be solved two different ways. Referring to a traditional 9x9 grid:  

<ol>
<li><p>Is it possible for a Sudoku puzzle to have more than two solutions? If so, what is the maximum number of solutions a single Sudoku puzzle can have?</p></li>
<li><p>For any given puzzle, is there a way to find out how many solutions it has (other than brute force)?</p></li>
</ol>

#### Answer accepted (score 38)
Most Sudoku puzzles published have only one solution. If there is more than one solution, it is probably a mistake. That said, puzzles with incomplete clues can have multiple solutions. In the extreme case, a puzzle with no clues has 6,670,903,752,021,072,936,960 solutions according to <a href="http://en.wikipedia.org/wiki/Sudoku">Wikipedia</a>.  

I don't know if it's possible to have exactly 3 solutions, but boards with 2 and 4 (and more) solutions are easy to find. In general, I think boards with an even number of solutions are easier to create.  

Finding the number of solutions is a generalization of Sudoku solving algorithms, and there are Sudoku algorithms that do significantly better than brute forcing. Once the board has been filled out as far as possible, it can be brute forced the rest of the way.  

#### Answer 2 (score 25)
I have seen two dissenting opinions on this subject (and in my opinion, the first option is right):  

<ol>
<li><p>By definition, a Sudoku has only one solution. Anything else is just a grid of numbers. Sometimes, there are errors in a publication, and a starting grid has multiple solutions, but, then the starting grid was not a Sudoku!</p></li>
<li><p><a href="http://en.wikipedia.org/wiki/Sudoku" rel="noreferrer">From Wikipedia</a>: <em>The number of classic 9×9 Sudoku solution grids is 6,670,903,752,021,072,936,960, or approximately 6.67×10<sup>21</sup> (ignoring rotations and other factors, there are many fewer solutions, just 5,472,730,538</em></p></li>
</ol>

Assuming you define a sudoku to have just one possible solution, then the rest of your questions are moot.  

If the sudoku is defined to have multiple solutions, then, brute-forcing is one way, but it is also possible to pre-compute all possible solutions for all inputs, and look up the result that way (a <a href="http://en.wikipedia.org/wiki/Rainbow_table" rel="noreferrer">rainbow table</a>).   

#### Answer 3 (score 11)
By definition, all valid Sudoku puzzles should have only one solution. In point of fact, many of the techniques used for solving puzzles <em>depend</em> on there being only one solution. All of the Unique Rectangle techniques for example, only work if there is one, and only one, solution.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: Swap the edges in a solved Rubik's cube (score [46592](https://stackoverflow.com/q/10753) in 2015)

#### Question
I have a rubik cube, which always have two swapped edges in the last layer. No matter which color I start with, there are always two edges in the last layer which remained swapped with each other.  

How to solve this scenario. Or if this is an invalid scenario, please can somebody explain how is this an invalid scenario.  

See this image for sample:   

<img src="https://i.stack.imgur.com/5lSjp.jpg" alt="http://m.imgur.com/u8P9Sag">  

#### Answer accepted (score 15)
<p>In a Rubik's cube, every legal move swaps a even number of dowels, so any legal configuration can be obtained only with a even number of swaps.
In this configuration, the difference between a legal cube (the solved one) and the current status consists of 1 swap; since 1 is odd, this is a <strong>No Win Scenario</strong>.</p>

#### Answer 2 (score 4)
It is possible to swap two edge pieces as per your diagram, but only if you also swap two corner pieces. Once the corner pieces are correctly positioned, you can only swap "double pairs" of edge pieces, including rotating a set of three edge pieces.  

Basically, your cube is wrongly assembled.  

#### Answer 3 (score 1)
Hold your cube so that the pieces are in the upper-front and upper-back position. In the case here, have the orange face pointed directly at you and yellow pointed up. This should put the cube in the correct orientation. Use: R' U2 R U R' U R U' R' U2 R U R' U R  

This will swap the front-middle-upper and front-middle-back edge pieces and keep their orientation. However, the corner pieces will be repositioned and you will need to redo those steps. You're supposed to get the edge pieces correct before working on the corners anyways.  

<p><em>EDIT</em><br>
I decided to cheat and put it onto an online solver. It said it wasn't solvable. At first I thought that those moves would leave the corner pieces alone, but apparently not. I punched in a very similar pattern I had once and it solved it. So apparently your cube really is improperly manufactured. Just take the two pieces off of the cube and put them back in correctly.<br>
<em>/EDIT</em></p>

<p>For those who don't understand cube notation:<br>
R = right face of the cube<br>
U = upper face</p>

<p>X means to rotate that face in a clockwise rotation (90')<br>
X' means to rotate the face in a counter-clockwise rotation (-90')<br>
X2 means to rotate the face twice (180')</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: A camel transporting bananas (score [46069](https://stackoverflow.com/q/230) in 2016)

#### Question
A somewhat well-known puzzle is described as such:  

<blockquote>
  You have a pile of 3,000 bananas. You wish to transport them to a place 1,000 miles away on the back of a camel; however, the camel can only carry a maximum of 1,000 bananas, and will eat one banana every mile it travels (and will not go anywhere if it does not have any bananas). However, you can load and unload as many bananas as you want anywhere. What is the most bananas you can bring over to your destination?  
</blockquote>

Obviously you can't just load up 1,000 bananas and go, because the camel will have eaten them all by the time you get there.  

I'd never figured out the answer by myself before. Does anybody have any insights into how to solve this problem and other problems like it?  

#### Answer accepted (score 38)
Solution for <span class="math-container">$n$</span> bananas, where <span class="math-container">$n$</span> is the number of bananas you own, and <span class="math-container">$c$</span> is the number of bananas the camel can carry:  

<blockquote class="spoiler">
  <p> - For bananas <span class="math-container">$0 \rightarrow c$</span> the cost to move a banana is <span class="math-container">$1$</span> banana per mile.<br>
  - For bananas <span class="math-container">$c+1 \rightarrow 2c$</span>, the cost to move a banana is <span class="math-container">$3$</span> bananas per mile.<br>
  - For bananas <span class="math-container">$2c+1 \rightarrow 3c$</span>, the cost to move a banana is <span class="math-container">$5$</span> bananas per mile.<br>
 - etc.</p>
</blockquote>

This is because, if the camel moves the bananas 1 mile at a time, he needs to make two trips for each load beyond his current capacity.  

Define <span class="math-container">$t = \lfloor\frac{n}{c}\rfloor$</span> Therefore, the total number of miles the camel can reach is:  

<blockquote class="spoiler">
  <span class="math-container">$$\left(\sum_{k=1}^{t} \frac{c}{2k - 1}\right) + \frac{(n \bmod c)}{2t+1}$$</span>  
</blockquote>

In particular, plugging in the given <span class="math-container">$n = 3000$</span> and <span class="math-container">$c = 1000$</span>, we have that the camel can travel  

<blockquote class="spoiler">
  <span class="math-container">$$1000 + 333 + 200 = 1533 \text{ miles}$$</span>  
</blockquote>

To figure out how many bananas <strong>remain</strong> for a given distance,   

<blockquote class="spoiler">
  Subtract the extra miles and multiply back at the rate given above.  
</blockquote>

For the first <span class="math-container">$1000$</span> miles, this number is just the distance beyond the total capacity:  

<blockquote class="spoiler">
  <span class="math-container">$1533 - 1000 = 533$</span>, or <strong>533 bananas</strong>.  
</blockquote>

#### Answer 2 (score 27)
First of all, the brute-force approach does not work. If the Camel starts by picking up the 1000 bananas and try to reach point B, then he will eat up all the 1000 bananas on the way and there will be no bananas left for him to return to point A.  

So we have to take an approach that the Camel drops the bananas in between and then returns to point A to pick up bananas again.  

```text
<---p1---><--------p2-----><-----p3---->
A---------------------------------------->B
-----> ------> -------->
<----- <------
-----> ------>
<-----
----->
```

Since there are 3000 bananas and the Camel can only carry 1000 bananas, he will have to make 3 trips to carry them all to any point in between.  

When bananas are reduced to 2000 then the Camel can shift them to another point in 2 trips and when the number of bananas left are &lt;= 1000, then he should not return and only move forward.  

In the first part, P1, to shift the bananas by 1Km, the Camel will have to  

<ol>
<li>Move forward with 1000 bananas – Will eat up 1 banana in the way forward</li>
<li>Leave 998 banana after 1 km and return with 1 banana – will eat up 1 banana in the way back</li>
<li>Pick up the next 1000 bananas and move forward – Will eat up 1 banana in the way forward</li>
<li>Leave 998 banana after 1 km and return with 1 banana - will eat up 1 banana in the way back</li>
<li>Will carry the last 1000 bananas from point a and move forward – will eat up 1 banana</li>
</ol>

Note: After point 5 the Camel does not need to return to point A again.  

So to shift 3000 bananas by 1km, the Camel will eat up 5 bananas.  

After moving to 200 km the Camel would have eaten up 1000 bananas and is now left with 2000 bananas.  

Hence the length of part P1 is 200 Km.  

Now in the Part P2, the Camel needs to do the following to shift the Bananas by 1km.  

<ol>
<li>Move forward with 1000 bananas - Will eat up 1 banana in the way forward</li>
<li>Leave 998 banana after 1 km and return with 1 banana - will eat up this 1 banana in the way back</li>
<li>Pick up the next 1000 bananas and move forward - Will eat up 1 banana in the way forward</li>
</ol>

Note: After point 3 the Camel does not need to return to the starting point of P2.  

So to shift 2000 bananas by 1km, the Camel will eat up 3 bananas.  

After moving to 333 km the camel would have eaten up 1000 bananas and is now left with the last 1000 bananas.  

Because it is a multiple of 3, after 333 times there is 1001 bananas left. Therefore, the camel must take 1000 bananas and then take 1 back with him to pick up the last banana, leaving him with 999 bananas. This would leave the camel at 334 km + 200 km, so the merchant only needs to travel 466 km, eating 1 banana for every km.  

999 bananas - 466 bananas for each remaining km equals 533 bananas left at point B. Therefore, the merchant has 533 bananas to sell at point B.  

#### Answer 3 (score 17)
<p>While the amount of bananas is larger than 2000, the camel will have to make 5 trips to shift them. At a cost of 1 banana per mile, this will cost 5 bananas per mile in total.<br>
While the amount of bananas is larger than 1000, it takes 3 trips to shift them, so a total cost of 3 bananas per mile.<br>
For the final stretch, it just takes a single banana per mile.</p>

<ol>
<li>3000 - 2000 bananas (numbers given for first mile)
<ol>
<li>Move 1000 bananas, feed 1, 2999 left.</li>
<li>Go back, feed 1, 2998 left.</li>
<li>Move 1000 bananas, feed 1, 2997 left.</li>
<li>Go back, feed 1, 2996 left.</li>
<li>Move 998 bananas, feed 1, 2995 left.</li>
</ol></li>
<li>2000 - 1000 bananas (numbers given for first mile)
<ol>
<li>Move 1000 bananas, feed 1, 1999 left.</li>
<li>Go back, feed 1, 1998 left.</li>
<li>Move 999 bananas, feed 1, 1997 left.</li>
</ol></li>
<li>1000 bananas (numbers given for first mile)
<ol>
<li>Move 1000 bananas, feed 1, 999 left.</li>
</ol></li>
</ol>

So at 5 bananas/mile you're down to 2000 bananas after 200 miles. Your total mileage then improves to 3 bananas/mile for the next 333 miles. After that, you're on the home stretch and move at 1 banana/mile for the remaining 467 miles (after which you'll have 533 bananas left).  

A few things to note:  

<ul>
<li>It is not necessary to move in one mile increments. For the first stretch, you can load up with 1000 bananas, move 200 miles, unload 600, and use 200 for your return trip. You do the same thing again, and after the last trip, you can unload 800, or rather, load 200 to be at a full 1000 again.</li>
<li>After completing the 333 mile stretch, you're 467 miles away from your destination, with exactly 1001 bananas. There are now two solutions:
<ol>
<li>Eat a banana (or leave it to rot) to have a nice, integer solution.</li>
<li>Use it to move for a total of 333&#8531; miles. If the camel needs to be fed <em>after</em> walking a full mile, you will now make it to your destination with &#8531; of a mile to spare, which should save you a banana, leaving you with <strong>534</strong> bananas.<br>
Congratulations, you're now banana king!</li>
</ol></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Use the numbers 8 6 4 2 = 25 (score [45803](https://stackoverflow.com/q/12316) in 2015)

#### Question
Use the numbers 8,6,4,2 and the operators +,-,*,/ to get 25.  

You can use each number once.  

Each operator can be used once.  

The least number of operators you use the better answer will be.  

#### Answer accepted (score 6)
Answer of this question is  

<blockquote class="spoiler">
   <strong>4*(6+(2/8))</strong>   
</blockquote>

#### Answer 2 (score 2)
here is my solution, just with 2 operators:   

<blockquote class="spoiler">
   (98+2)/4=25, where 6 is upside down  
</blockquote>

#### Answer 3 (score -4)
<blockquote class="spoiler">
  They are all even numbers. No matter what u do the answer has to be an even number.  It could be (8*6+4)/2=26 etc  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: Fill number in missing? (score [44423](https://stackoverflow.com/q/52943) in 2019)

#### Question
<a href="https://i.stack.imgur.com/JZ5YP.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/JZ5YP.png" alt="enter image description here"></a>  

Given options are:  

<ul>
<li>A. 13</li>
<li>B. 42</li>
<li>C. 18</li>
<li>D. 30 </li>
</ul>

#### Answer accepted (score 3)
This is a long shot, and probably not the correct answer but seems to fit.  

<blockquote class="spoiler">
   If you take the number of enclosed areas in the upper row and multiply by 4, you get the second digit in the lower row. If you take the number of "corners" or "loose" ends (I know -- this is a very vague definition :-D) and subtract 1, you get the first digit in the lower row.  
</blockquote>

So...  

<blockquote class="spoiler">
   6 has one enclosed area, three has three "corners" or "loose" ends. $(3 - 1) , 1 \times 4 = (2, 4)$.  
</blockquote>

and   

<blockquote class="spoiler">
   8 has two enclosed areas, 64 has five "corners" or "loose" ends. $(5-1), 2 \times 4 = (4,8)$.  
</blockquote>

So,  

<blockquote class="spoiler">
   7 has no enclosed areas, 4 has four "corners" or "loose" ends. $(4-1), 2 \times 0 = (3,0)$. This gives D.  
</blockquote>

#### Answer 2 (score 2)
<strong><a href="https://puzzling.stackexchange.com/a/53224/30633">@Dark Matter</a></strong> makes a telling observation, but I disagree with their conclusion.  

My answer would be:    

<blockquote class="spoiler">
   <strong>C. 18</strong>    
</blockquote>

Here's why.  

<blockquote class="spoiler">
  <p> Each cell contains a value that can be factored into powers of 2, 3, and 7 - the telling observation @Dark Matter made.  It seems safe to assume the final value will also fit this pattern.  From this, we can drop choices A and D, as they do not factor to powers of 2, 3, and 7.<br>
<br>
 Let's factor the values in the grid:<br>
 <pre>Powers of 2,3,7 per cell

 1,1,0  3,0,0   0,0,1
 0,1,0  6,0,0   2,0,0
 1,3,0  4,1,0   ?,?,?</pre>
 (For example, bottom middle is <span class="math-container">$2^4\times3^1\times7^0=16\times3\times1=48$</span>, so `4,1,0`.)  </p>
</blockquote>

@Dark Matter suggests that    

<blockquote class="spoiler">
  <p> there shouldn't be only one value that is a factor of 7.  I disagree - I think the lone 7 is intentional, and that it is the "origin" of concentric layers, each layer having a pattern in the factorization.<br>
<br>
 Upper right cell is `0,0,1`.<br>
 Its three neighbors are all `n,0,0` - pure powers of 2.<br>
 The remaining cells we can see are `x,n,0` - x is any value, n>0<br>
<br>
 To fit the pattern, the last cell should also be `x,n,0`.  Our options are:<br>
 &emsp; <strong>B. 42</strong> - factors to 2x3x7, or `1,1,1` - not our pattern.<br>
 &emsp; <strong>C. 18</strong> - factors to 2x3x3, or `1,2,0` - fits our pattern.<br>
<br>
 So we choose <strong>C. 18</strong>.</p>
</blockquote>

#### Answer 3 (score 2)
<strong><a href="https://puzzling.stackexchange.com/a/53224/30633">@Dark Matter</a></strong> makes a telling observation, but I disagree with their conclusion.  

My answer would be:    

<blockquote class="spoiler">
   <strong>C. 18</strong>    
</blockquote>

Here's why.  

<blockquote class="spoiler">
  <p> Each cell contains a value that can be factored into powers of 2, 3, and 7 - the telling observation @Dark Matter made.  It seems safe to assume the final value will also fit this pattern.  From this, we can drop choices A and D, as they do not factor to powers of 2, 3, and 7.<br>
<br>
 Let's factor the values in the grid:<br>
 <pre>Powers of 2,3,7 per cell

 1,1,0  3,0,0   0,0,1
 0,1,0  6,0,0   2,0,0
 1,3,0  4,1,0   ?,?,?</pre>
 (For example, bottom middle is <span class="math-container">$2^4\times3^1\times7^0=16\times3\times1=48$</span>, so `4,1,0`.)  </p>
</blockquote>

@Dark Matter suggests that    

<blockquote class="spoiler">
  <p> there shouldn't be only one value that is a factor of 7.  I disagree - I think the lone 7 is intentional, and that it is the "origin" of concentric layers, each layer having a pattern in the factorization.<br>
<br>
 Upper right cell is `0,0,1`.<br>
 Its three neighbors are all `n,0,0` - pure powers of 2.<br>
 The remaining cells we can see are `x,n,0` - x is any value, n>0<br>
<br>
 To fit the pattern, the last cell should also be `x,n,0`.  Our options are:<br>
 &emsp; <strong>B. 42</strong> - factors to 2x3x7, or `1,1,1` - not our pattern.<br>
 &emsp; <strong>C. 18</strong> - factors to 2x3x3, or `1,2,0` - fits our pattern.<br>
<br>
 So we choose <strong>C. 18</strong>.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: if you have one, you have none (score [44092](https://stackoverflow.com/q/32507) in 2018)

#### Question
If you have three, you have three. If you have two, you have two. If you have one, you have none. What is it?  

#### Answer accepted (score 104)
This is kind of a play on words, but:  

<blockquote class="spoiler">
  <p> <strong>Options</strong><br>

 If you have 3 options, you have 3 options. If you have 2 options you have 2 options. If you have only 1 option, you don't have any options.</p>
</blockquote>

Along similar lines, this works too:  

<blockquote class="spoiler">
  <p> <strong>Choices</strong><br>

 If you have 3 choices, you have 3 choices. If you have 2 choices you have 2 choices. If you have only 1 choice, you don't have a choice.</p>
</blockquote>

#### Answer 2 (score 51)
If you say the riddle aloud, the answer could be:  

<blockquote class="spoiler">
   Competitors  
</blockquote>

Because:  

<blockquote class="spoiler">
   "one" sounds like "won". If you have 2 or 3 competitors, then you have 2 or 3 competitors. But if you have "won", then you have none.  
</blockquote>

#### Answer 3 (score 28)
What about  

<blockquote class="spoiler">
  Stack Exchange Reputation Score?  
</blockquote>

If you have three, you have three.   

If you have two, you have two,  

but if you have one, you have none.  

<blockquote class="spoiler">
   as it is the default rep score here. If you have 1 rep score <strong>you really have none</strong>.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How many balls can fit in the box? (score [43426](https://stackoverflow.com/q/3718) in )

#### Question
I think the answer isn't as simple as the question. So, I need your help. :)  

Assumed I have a box, sized 100cm X 100cm X 100cm (width X length X height). How many balls can fit in that box (the ball is 1cm in diameter)? Thanks.  

#### Answer accepted (score 11)
Quoting from <a href="http://en.wikipedia.org/wiki/Kepler_conjecture" rel="nofollow noreferrer">wikipedia</a>:  

<blockquote>
  <p>Experiment shows that dropping the spheres in randomly will achieve a
  density of around 65%. However, a higher density can be achieved by
  carefully arranging the spheres as follows. Start with a layer of
  spheres in a hexagonal lattice, then put the next layer of spheres in
  the lowest points you can find above the first layer, and so on – this
  is just the way you see oranges stacked in a shop. At each step there
  are two choices of where to put the next layer, so this natural method
  of stacking the spheres creates an uncountably infinite number of
  equally dense packings, the best known of which are called cubic close
  packing and hexagonal close packing. Each of these arrangements has an
  average density of $\frac\pi {3\sqrt2} = 0.740480489...$. The
  Kepler conjecture says that this is the best that can be done—no other
  arrangement of spheres has a higher average density.</p>
</blockquote>

So your answer is  

<blockquote class="spoiler">
  <p> $\frac{\text{box volume}}{\text{ball volume}} \times {\text{packing density}} =$<BR><BR>
 $\frac{100^3}{\frac43 \times \pi \times \left(\frac12\right)^3} \times {\frac\pi {3\sqrt2}} =$<BR><BR>
 $\frac{100^3}{\left(\frac12\right)^3\times 4 \times \sqrt2} =$<br><br>
 $\frac{100^3}{\frac12 \times \sqrt2} = 100^3 \times \sqrt2 \approx 1414213$</p>
</blockquote>

#### Answer 2 (score 4)
<h5>1401611</h1>

The optimal pattern of packing spheres is pretty well known, not as widely known is the fact that this pattern has 7 different orientations where the spheres are all organised in layers of simple patterns. In four of these orientations the spheres are aligned in a triangular pattern, in the three other planes they are aligned in a square pattern. The key to this puzzle is to rotate the pattern so that the wasted space along the sides of the box is minimised.  

An orientation where the three square planes are aligned with the walls of the box happens to fit extremely well, as a 71 ball wide configuration is $99.995\text{ cm}$ wide. In this configuration the bottom of the box is filled like so:  

<img src="https://i.stack.imgur.com/GeA9A.png" alt="enter image description here">  

With 71 balls bordering each edge, for a total of $71^2+70^2=9941$ balls in the bottom layer, the layer on top of it will use the same pattern, but be shifted so that the balls lie in the holes between the balls in the bottom layer, this will allow one ball less. These two layer configurations are then repeated until there are 71 configurations like the first layer, and 70 like the second layer. This gives a total of $71\times9941+70\times9940=1401611$ balls.  

#### Answer 3 (score 4)
<h5>1401611</h1>

The optimal pattern of packing spheres is pretty well known, not as widely known is the fact that this pattern has 7 different orientations where the spheres are all organised in layers of simple patterns. In four of these orientations the spheres are aligned in a triangular pattern, in the three other planes they are aligned in a square pattern. The key to this puzzle is to rotate the pattern so that the wasted space along the sides of the box is minimised.  

An orientation where the three square planes are aligned with the walls of the box happens to fit extremely well, as a 71 ball wide configuration is $99.995\text{ cm}$ wide. In this configuration the bottom of the box is filled like so:  

<img src="https://i.stack.imgur.com/GeA9A.png" alt="enter image description here">  

With 71 balls bordering each edge, for a total of $71^2+70^2=9941$ balls in the bottom layer, the layer on top of it will use the same pattern, but be shifted so that the balls lie in the holes between the balls in the bottom layer, this will allow one ball less. These two layer configurations are then repeated until there are 71 configurations like the first layer, and 70 like the second layer. This gives a total of $71\times9941+70\times9940=1401611$ balls.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Candle timing measurement (score [42744](https://stackoverflow.com/q/1959) in 2014)

#### Question
You are given two candles of equal size, which can burn 1 hour each. You have to measure 90 minutes with these candles. (There is no scale or clock). You are also given a lighter.  

#### Answer accepted (score 3)
<p>OK. Old Infosys interview question.
As @klm123 said, you burn both ends of one candle. It will burn in 30 minutes and you burn the other one from one end only.</p>

Initially, the problem was with `ropes / threads` with each of `timespan 30 minutes` and you have to `measure 45 minutes with 2 ropes`; with which it was quite affirmative and little easy. But someone (NOT the asker here) become thinking himself/herself very smart changed the problem with candles and increased time to double. The smarty who changed it probably had no / little understanding of Physics / Chemistry.The candle will burn quicker if burned on both ends by placing it horizontal (burn a little faster from both sides) or vertical (burn quite faster from one side). So, we won't get exact 30 mins but have to approximate.  

<p>The rope problem on math exchange and glassdoor . Take a look : <a href="https://math.stackexchange.com/questions/183282/puzzle-there-are-two-lengths-of-rope">https://math.stackexchange.com/questions/183282/puzzle-there-are-two-lengths-of-rope</a>
<a href="http://www.glassdoor.co.in/Interview/You-have-2-pieces-of-rope-each-of-which-burns-from-one-end-to-the-other-in-30-minutes-no-matter-which-end-is-lit-If-dif-QTN_108377.htm" rel="nofollow noreferrer">http://www.glassdoor.co.in/Interview/You-have-2-pieces-of-rope-each-of-which-burns-from-one-end-to-the-other-in-30-minutes-no-matter-which-end-is-lit-If-dif-QTN_108377.htm</a></p>

#### Answer 2 (score 2)
If the candles burn at the same rate when sideways vs. upright (which they probably won't, but let's make the assumption for the sake of having a solution), lie the candles horizontally next to each other, but with the wicks at opposite ends. Light both. When they meet, they'll have both burned halfway - 30 minutes gone.  

Now blow one out. Let the other burn the rest of its 30 minute lifespan - now you've timed 60 minutes.  

When it goes out, relight the other one for the remaining 30 minutes - total of 90 minutes.  

#### Answer 3 (score 1)
One way that assumes the candle are exactly the same is to use the unlit candle to determine when the first candle has burned half-way.  

<ol>
<li>Light the first candle and wait for it to burn to approximately half-way (must be before it reaches half-way).</li>
<li>Place the unlit candle next to the lit candle and use your finger or thumb to mark where the lit candle is on the unlit candle.</li>
<li>Invert the unlit candle keeping your finger/thumb on the position you measured in step 2 and compare it to the height of the lit candle again.</li>
<li>Once the mark is the same on the first and inverted measurement you know the lit candle has burned exactly half-way. You can now light the unlit candle and wait for it to burn to the end.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: Cutting a cake into 8 pieces (score [42662](https://stackoverflow.com/q/2827) in 2017)

#### Question
Say, you are given a cake which you must share with 7 others. So, you must cut the cake into 8 pieces. But, you are only allowed to make 3 straight cuts. You cannot move pieces of the cake after the first cut.   

#### Answer accepted (score 22)
Obviously, this doesn't work in the plane.  So you need a 3D solution.  

A 3D solution is simple.  Cut the cake with 2 perpendicular cuts through the center, then make a horizontal cut at half the height of the cake.  It is not fair regarding topping, but you have 8 pieces.  

#### Answer 2 (score 6)
Florian's answer mentions that it's 'obvious' that the cuts don't work in the plane, but I figure it's worth a short proof that you in fact can't cut a (convex!) 2d cake into eight pieces with three slices.  

Firstly, since the cake <em>is</em> convex we may as well say that it's infinitely large and just look at cutting the plane into pieces; this won't affect the maximum number of pieces we can get.  Now, since each slice is a line, any two of them intersect in at most one point.  If all three of them intersect in the same point then they partition the plane into at most six regions.  Likewise, if any two slices don't intersect, then they partition the plane into at most six regions.  Otherwise, pick two of the slices: they divide the plane into four quadrants.  Now, the third slice intersects the other two in one point each, and those two intersection points border a common quadrant.  Whichever quadrant is opposite to that one can't be cut by the third slice, because either getting 'in' or 'out' of it would require another intersection with one of the first two slices definiing the quadrants; this means that the three slices partition the plane into at most 4 (the quadrants from the first two slices) + 3 (the new regions defined by the third slice) =7 pieces.  

And why convex?  Well, cutting this nonconvex 'cake' into eight pieces with just three slices is left as an exercise to the reader:  

<img src="https://i.stack.imgur.com/7Zdf7.jpg" alt="enter image description here">  

#### Answer 3 (score 3)
<a href="https://i.stack.imgur.com/lOZqG.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/lOZqG.png" alt="Cut a cake into 8 pieces - with 3 cuts"></a>  

<p><br>
As in the image; I will cut the cake horizontally first and two vertical cuts into it will be added. 
<br> So it can have 8 pieces in total finally without even moving the cake position. 
<br> I guess that's very simple and easy way. Isn't it? :D.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Make a square with matchsticks! (score [42484](https://stackoverflow.com/q/38758) in 2017)

#### Question
After the previous <a href="https://puzzling.stackexchange.com/q/29004/1766">mat(c)h-stick puzzle</a>, this one is relatively <a href="http://matchstickpuzzles.blogspot.in/2016/07/406-hidden-square.html" rel="nofollow noreferrer">old</a>.    

<a href="https://i.stack.imgur.com/ghD0I.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/ghD0I.jpg" alt="The matchsticks"></a>  

Move <strong>only one matchstick</strong> to make a square.  

#### Answer accepted (score 48)
<blockquote class="spoiler">
   Move the right-most match to a diagonal between the top and left matches, making a 4, a square (number)  
</blockquote>

#### Answer 2 (score 48)
<blockquote class="spoiler">
   Move the right-most match to a diagonal between the top and left matches, making a 4, a square (number)  
</blockquote>

#### Answer 3 (score 27)
The answer:  

<blockquote class="spoiler">
   A match is easy to break <a href="https://i.stack.imgur.com/kOljR.png" rel="noreferrer"><img src="https://i.stack.imgur.com/kOljR.png" alt="The answer"></a>  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Mensa IQ test question made by www.bergmandata.com (score [41929](https://stackoverflow.com/q/19823) in 2019)

#### Question
<blockquote>
  <p>Which of the 8 tiles below is missing?
  <img src="https://i.stack.imgur.com/6Stlh.jpg" alt=""></p>
</blockquote>

I've been trying to figure out the answer to this question for quite some time. Can anyone spot the pattern?  

#### Answer accepted (score 197)
I think the answer is  

<blockquote class="spoiler">
   Tile 5  
</blockquote>

Because it looks to me like  

<blockquote class="spoiler">
   Reading from left to right, the lines continue where the previous square left off, to make two long connecting 'strings' of sorts. The eighth square leaves off in the top righthand corner and about 80% of the way down the bottom side, which is where tile 5 would connect to.  
</blockquote>

<hr>

Here is an image of the final solution:  

<blockquote class="spoiler">
   <img src="https://i.stack.imgur.com/83V1G.png" alt="Mensa Squares">  
</blockquote>

#### Answer 2 (score 27)
I think the answer is  

<blockquote class="spoiler">
   <a href="https://puzzling.stackexchange.com/a/19824/12727">The one given by @Bailey M</a>, but I would like to offer another answer...  
</blockquote>

Because I figured that  

<blockquote class="spoiler">
  <p> It would be fun to have an alternative solution :-). With this solution, the supposed rules for tiles are that:
<br>
<br>
 1. the third column tiles' lines always "indicate" adjoined sides;<br>
 2. the third column tiles' lines always touch exactly one corner;
<br>
<br>
 Meaning that<br>
<br>
 Tiles 1, 2, 7, and 8 are out because of rule 1;<br>
 Tiles 4, 5, 6, (and 7) are out because of rule 2;<br>
  </p>
</blockquote>

And thus that  

<blockquote class="spoiler">
   it must be Tile 3!  
</blockquote>

Here's an image to visualize that  

<blockquote class="spoiler">
    <a href="https://i.stack.imgur.com/dutAO.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/dutAO.png" alt="visualization of the solution"></a>  
</blockquote>

#### Answer 3 (score 19)
You're all thinking to hard. This is just a game of Tic Tac Toe. Since it is the turn of X, tiles 1, 4, 5, 6, and 7 would all be correct. I personally would go with 7 because it's a well drawn X.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Simple 4x4x4 OLL parity algs? (score [41513](https://stackoverflow.com/q/55763) in 2017)

#### Question
I am learning to solve a 4x4x4 Rubik's cube and I think that the beginner OLL parity alg:  

```text
(r U2 x r U2 r' U2 l U2 r' U2 r U2 r' U2 r')
```

is a little too complex.  

<strong>Does anyone know a simpler alg for it?</strong>  

#### Answer accepted (score 4)
<p>I think this is the simplest: \begin{array}
\
  r\; U2\; x\; r\; U2\; r'\; U2\; l\; U2\; r'\; U2\; r\; U2\; r'\; U2\; r' 
\end{array}<br>
Unless this works:
\begin{array}
\
r2\;F2\; U2\; r'\; F'\; u\; L'\; U2\; L\; u'\; F'\; r'\; U2\; r2\; F2\; r\
\end{array}</p>

You can find all the 4x4x4 parity algorithms here <strong>:</strong> <a href="https://www.speedsolving.com/wiki/index.php/4x4x4_Parity_Algorithms" rel="nofollow noreferrer">https://www.speedsolving.com/wiki/index.php/4x4x4_Parity_Algorithms</a>  

#### Answer 2 (score 3)
r' U2 l F2 l' F2 r2 U2 r U2 r' U2 F2 r2 F2  

Super simple! (corrected version)  

#### Answer 3 (score 1)
(Rr)2 B2 U2 (Ll) U2 (Rr)' U2 (Rr) U2 F2 (Rr) F2 (Ll)' B2 (Rr)2  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: 29 - 1 = 30 – how? (score [41363](https://stackoverflow.com/q/52487) in 2017)

#### Question
How is $29 - 1 = 30$?  

If also  

$14 - 1 = 15$  

$11 - 1 = 10$  

$9 - 1 =10$.  

Hint:  

<blockquote class="spoiler">
  Guess the answer and be like Minerva  
</blockquote>

#### Answer accepted (score 133)
Explanation:  

<blockquote class="spoiler">
   If you're using Roman numerals, you can remove I (one) from the representations of the numbers before the minus sign to get the representation of the numbers in the right.  
</blockquote>

29 - 1 = 30   

<blockquote class="spoiler">
   XXIX - I = XXX  
</blockquote>

14 - 1 = 15  

<blockquote class="spoiler">
   XIV - I = XV  
</blockquote>

11 - 1 = 10  

<blockquote class="spoiler">
   XI - I = X  
</blockquote>

9 - 1 =10  

<blockquote class="spoiler">
   IX - I = X  
</blockquote>

#### Answer 2 (score 42)
<p>$$9 - 1 = 10 = 11 - 1,$$ 
thus </p>

<p>$$29 - 1 = 20 + 9 - 1 =\\
= 20 + 11 - 1 = 31 - 1 = 30.$$</p>

<strong>Edit</strong>  

Or just using that $9-1 = 10$  

$$ 29 - 1 = 20 + 9-1 = 20 + 10 = 30.$$  

#### Answer 3 (score 21)
I suppose you could always round the answer to the nearest multiple of 5, although that has nothing to do with Athena.  

<p>$$\begin{align}
29-1&amp;=28 \xrightarrow{\text{rounds to }}30\\
14-1&amp;=13 \xrightarrow{\phantom{\text{________}}} 15\\
11-1&amp;=10 \xrightarrow{\phantom{\text{________}}} 10\\
9-1 &amp;= \phantom08 \xrightarrow{\phantom{\text{________}}} 10\\
\end{align}$$</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: What is the largest tile possible in 2048? (score [41212](https://stackoverflow.com/q/48) in 2015)

#### Question
I can get to 4096 max. There are videos on youtube of guys making it to 8192. What is the theoretical maximum limit on this?  

PS: if you haven't played this, here is the <a href="http://gabrielecirulli.github.io/2048">link to addiction.</a>  

#### Answer accepted (score 52)
In the original game, sometimes the new tile that pops up is a 4. Let's ignore that possibility for the sake of simplicity.  

We've 16 squares in total and considering the new tile popped up at the position we chose, to make it to 4096, we need minimum these tiles:   

`2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 2`  

These can be combined from right to left to get to 4096. That's a total of 12 tiles. Since that's less than 16 (max number of tiles that can fit),  4096 is possible. Following along:  

<ul>
<li>8192: `4096, 2048, 1024, ..., 4, 2, 2` Total 13</li>
<li>16384: `8192, 4096, 2048, ..., 4, 2, 2` Total 14</li>
<li>32768: `16384, 8192, 4096, ..., 4, 2, 2` Total 15</li>
<li>65536: `32768, 16384, 8192, 4096, ..., 4, 2, 2` Total 16</li>
</ul>

Next is 131072 which will require at least 17 tiles which can't fit on the board.  

<strong>So, the largest possible tile is 65536.</strong>  

EDIT: Since the game pops up some 4's at times, <strong>131072 is still theoretically possible</strong> if the last tile that pops up is a 4 making the board look like this:  

131072: `65536, 32768, 16384, 8192, 4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 4`   

that's 16 tiles in total.  

#### Answer 2 (score 18)
BlueFlame gives an essentially correct answer, but I wanted to add a rigorous proof (for anyone looking for it). [EDIT: user2357112's comment points out an annoying hole in the proof, under the "proof that 65536 is theoretically possible" section. While I believe the hole can be filled, I don't have time to do it right now.]  

I will prove that 65536 is the maximum when 2 is the only tile which appears newly on the board.  It is easy to adapt the proof to show that 131072 is the maximum when 4 may also appear.  

<strong>1. Proof that 65536 is an upper bound.</strong>  

At every step of the game, the <em>total value among all tiles</em> goes up by 2, or stays the same.  

Suppose towards contradiction that at some point in time the 131072 tile is attained.  That at this time the sum of all the tiles is at least 131072.  Thus <em>at some point in time,</em> the sum of all the tiles was <em>exactly</em> 131070 (= 131072 - 2).  Then at this time there was a set S of at most 16 powers of two adding to get 131070.  Recursively adding together pairs of equal elements of S until all the elements are distinct (i.e., adding them as if they had combined in the game), we obtain a set R with at most 16 <em>distinct</em> powers of two adding to get 131070.  But 131070 = 2^16 + 2^15 + 2^14 + ... + 2^1 cannot be written as a sum of anything less than <em>exactly</em> 16 distinct powers of two (using unique representation in binary).  Therefore the set S must have initially consisted of one each of the numbers 2, 4, 8, ..., 2^15, 2^16, and the entire 4x4 grid must have been filled.  But then the position would have been a losing position, i.e. no two tiles could have combined and there was no space left on the board.  Contradiction.  

<strong>2. Proof that 65536 is theoretically possible.</strong>  

<p>The idea is to use a strategy like this:
<img src="https://i.stack.imgur.com/rWrgE.png" alt="enter image description here"></p>

Label the 4 x 4 grid with the numbers 1 through 16, with the numbers in the following pattern:  

```text
13 14 15 16
12 11 10  9
 5  6  7  8
 4  3  2  1
```

Call a board state "ideal" if it has the following properties: (1) the tiles that are filled are exactly 16, 15, 14, ..., k for some k, and (2) if two tiles a and b are on the board, with a located on a bigger label than b, then the value of tile a is greater than the value of tile b.  This matches the general pattern of the picture above.  

Then, suppose we are in an ideal state with all the tiles less than 65536 = 2^16.  Since there are only 15 distinct tile values less than 2^16, there must be an open space.  Then we can choose to spawn the 2 in the <em>open space with the highest label</em>.  After this, we can recursively combine the lowest two tiles if they have equal value, by sliding left, right, or up, depending on the board state.  But due to the nature of our "ideal state" strategy, the left, right, and up slides will never modify any tiles but the two lowest ones which are combining.  Thus after the entire process we are left in another ideal state. [EDIT: This paragraph has a hole: it forgets to consider that a new 2 tile must spawn after each slide. One should probably be fine if the new 2 tile always spawns, as the first 2 tile, in the open space with the highest label. But the reasoning gets a bit more complicated.]  

We will be able to follow this strategy continually as long as there is no 65536 tile on the board.  Moreover, the total value of all values on the board will do nothing but increase.  Therefore, at some point we will either reach a 65536 tile, in which case we will be done, or we will reach an ideal state with the total value of all tiles equaling at least 65536.  Since no set of unique tiles less than 65536 can add to 65536 or more, and since an ideal state contains unique tiles, this is a contradiction and we will necessarily reach the 65536 tile at some point.  

#### Answer 3 (score 10)
Okay, so I actually made it this far (no photoshop or anything, just a secret trick and play endlessly without any hassle. It works for long time also on normal mode, until you make a mistake).  

<img src="https://i.stack.imgur.com/K7S6G.jpg" alt="enter image description here">  

No more possibilities...  

<p><strong>EDIT:</strong>
So someone did ask me for the "trick", so here it is:</p>

First, always corner your highest tile. This is very important, as this gives you the maximum space to play the game. Since all the middle tiles are surrounded by 4 tiles, the corner tiles are the ones which have minimum contact with the other tiles. If your highest tile is somewhere in the middle, it only acts like an obstruction, so keeping it aside is the best move. Like in the above screenshot, 131072 is in the top left corner.  

Ordering your tiles is also a good strategy. Like see how I have ordered my tiles in descending order. It creates minimum wastage of big tiles and less blockage for small tiles.  

Secondly, "stick" to a wall. This is the trickiest part. Like seriously, stick to the side of a chosen wall. I had chosen the top wall. Try not to disturb the tiles along the wall. For example for sticking to the top wall, <strong>do not swipe down</strong>. It works since once your tiles are made, and as you progress, not only the biggest tile will obstruct, but also the tiles just before it also do it's job. Also sticking to a wall makes way for smaller tiles and they could be merged and made off into bigger tiles more easily. This ensures uniformity and a clean game.  

The above, although a logically great option, does not work pretty well in normal mode. I was only able to get 8192 by it. Just ensure the chances of getting stuck in a case where the only option is to swipe down is minimum. Play accordingly in normal mode. Practice mode has no such hassle, so it's all good :)  

Another thing to ensure is blocking. Never block a tile and make it useless. Remember, unusable spaces are the steps to defeat. Moves will always be available if none of your tiles are blocked. For example, if a 2 gets cornered, on the top right and you stick to the upper boundary, do not make your 2 just sit there. Merge it first and ensure this with other tiles. No tile should block your flow.  

I personally prefer to use minimum number of undos, but sometimes when the only move is to go down, or when things go tight and in order to go further and create a tile, you do have to undo. That is the luck part which gets eliminated in practice mode. In normal mode just try to play perfectly and follow your strategy. Your score in normal mode is literally pot luck.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Mysterious Murder Mystery (score [39100](https://stackoverflow.com/q/3726) in 2015)

#### Question
Last year, December 21, 2013, you were awarded the "#1 Detective in the World" for solving more than 50 murders. Your boss gave you a promotion, contingent upon your moving to Chicago. You agreed and took your new position. Your boss told you that you would be taking a plane to Chicago, the ticket and everything already having been paid for by your boss. He also told you that you would be taking off on January 15, 2014.  

All of a sudden, all you heard was a loud beeping sound. "BEEP BEEP BEEP BEEP BEEP", as your eyes open wide. You got up and realized it was your alarm clock going off. 6:30 AM. You turned the alarm off, did a big stretch and gave a big yawn. "Why do I keep having the same dream about the day that I got promoted?" you pondered to yourself. Without giving it another thought, you got out of bed and started getting ready for your day.  

You got to work and went straight to your office. As soon as you sat down you heard a knock on your office door. "Come in," you said.  

Your assistant opened the door. "You're needed at the intersection of Main and Peele." You weren't surprised to hear this. You quickly got up and drove to the location.  

When you got there, there were 3-4 police cars, yellow "Police Line" tape, and a large crowd gathered around the intersection. You got out of the car and walked towards the scene. As you got closer, you could see a body covered with a blanket, and other police and detectives talking and taking pictures.  

"Morning. It seems like this man here was murdered," said one of the other detectives.  

You lifted the blanket to see that the man had been stabbed three times, had two gunshot wounds to his left hip, and had red markings around his neck. "It looks like he has been strangled with rope as well," you said as you kept on examining his body.  

You covered the body back up with the blanket. You looked around and saw that there were small yellow cones with numbers on them, and beside each cone you saw an object. You walked over to one of the cones. It had the number "4" on it. You looked beside the cone and saw perfect circular blood drops. You then walked over to the number "2" cone, seeing a knife with no blood on it. Cone number "3" was beside a piece of paper. On it was "He Deserved It! 1H8H1M". You looked closely at "1H8H1M" and wondered what that meant. You stood there and pondered it for a minute, then moved on to cone number "1". The last cone was beside a shoe print. It was mud which produced the prints. The shoe size looked to be a size 9 men's shoe.  

"I've seen enough. I'm heading back to my office" you told the other detectives.  

The next day, your assistant told you that the forensics lab had asked you to visit them when you had the chance. You headed over to the forensics lab.  

"Hello, you must be the great detective. Nice to meet you!" said the forensic technician. "The results are back. There were no fingerprints on the note. The knife was clean like it was brand new straight from the box. The shoe print was of a size 9 men's shoe. But the most interesting part is that the blood stains are not human. It's animal blood. Specifically from a poodle."  

As you pondered the information that the technician had told you, your cell phone rang. You answered it. "We have found a few suspects here at the station. Please come ASAP."  

You rushed over to the station. As you drove over there, you got violently cut off by another driver and almost crashed. "Learn how to drive!" the man in the other car yelled as he drove away. You caught a glimpse of a man with shaggy brown hair, small nose, and big ears. You took a deep breath and continued on.  

When you arrived at the station you saw that the police had gathered three suspects: a white man between the age of 22-26, short black hair, with a toned build; a tall blonde female, wearing a fancy dress and jewelry like she was going on a date or to a party; and a skinny homeless man wearing very battered clothing, with long greasy hair and a full beard.   

The twenty-something man said that he was at the bank getting some money three blocks away from the murder site around the same time the murder was reported.  

The blonde female said that she was going for a run around the block as she just lived down the street from the murder site. She made one round around the block, then decided to do another round. As she was jogging she saw the crowd and decided to stop and take a look.  

The homeless man didn't speak English well and seemed kinda crazy. "I did no murder. I asking for money for food. Hungry, haven't eat couple days."   

You went back to your office and pondered about the clues and information from the murder scene, the forensics lab, and the suspects. After pondering a while you figured out who the murderer was. You quickly rushed back to the police station and told the police to arrest the person.  

Who was the murderer?  

#### Answer accepted (score 24)
I have a possible solution which no-one else has yet suggested. It has the <a href="http://en.wikipedia.org/wiki/Occam&#39;s_razor" rel="nofollow noreferrer">virtue of simplicity</a>.  

<blockquote class="spoiler">
   The puzzle has no single logically unique answer; OP is a troll (or does not  understand that a puzzle should have a specific answer that can be deduced from the question).  
</blockquote>

My reasoning:  

<blockquote class="spoiler">
  <p> - OP has no posting history here or on linked SE sites.<br>
 - So much detail in the story, so many 'clues', <a href="http://tvtropes.org/pmwiki/pmwiki.php/Main/RasputinianDeath" rel="nofollow noreferrer">Rasputinian Death</a>.<br>
 - <a href="https://puzzling.stackexchange.com/posts/3726/revisions">Flaky grammar</a> in the original post is not consistent with an intelligent OP (counter-argument: OP could have English as a foreign language or have a condition such as dyslexia which allows them to be intelligent but not good at writing in English. Or maybe the mistakes are intentional.)<br>
 - No sign of this puzzle on Google, so OP probably came up with it themselves.<br>
 - OP: "i just like reading all the answers people come up with"<br>
 - I'm a deeply cynical person.</p>
</blockquote>

I'd consider the following answers equivalent to my solution (you might not agree):  

<blockquote class="spoiler">
  <p> - <strong>OP has a solution but it's no more logical or likely than anyone else's solution.</strong> <br>
 - Everyone in the story is non-human (they're goldfish and 'Chicago' is the name of the fishbowl, etc etc). <br>
 - God / Satan / Father Christmas / aliens did it (<a href="http://en.wikipedia.org/wiki/Deus_ex_machina" rel="nofollow noreferrer">deus ex machina</a>).  <br>
 - It's <a href="http://tvtropes.org/pmwiki/pmwiki.php/Main/AllJustADream" rel="nofollow noreferrer">all just a dream</a> / hallucination / taking place in The Matrix. <br>
 - Dead body is not a human or is not really dead.</p>
</blockquote>

The OP gets a bounty from me if:  

<blockquote class="spoiler">
  <p> The puzzle <em>is</em> logically coherent and: <br> <br>
 - The detective is a ghost ('the Shyamalan' plot twist).<br>
 - The detective is the murderer or the victim.<br>
 - They all did it ('<a href="http://en.wikipedia.org/wiki/Murder_on_the_Orient_Express" rel="nofollow noreferrer">Murder on the Orient Express</a>').<br>
 - The solution involves a time machine or an alternate universe. <br>
 - The murderer is one of the minor characters, eg the assistant, the old boss or the forensic scientist ('the butler did it').<br>
 - The mangled English is integral to the solution of the puzzle.<br>
 - The puzzle is not a murder mystery (e.g message enciphered in the typos).<br>
 - The story (with original typos) successfully compiles in any well-known programming language<br> <br>
 or if OP's solution consists solely of trollface.gif.</p>
</blockquote>

Double bounty if:  

<blockquote class="spoiler">
  <p> The puzzle <em>is</em> logically coherent and: <br> <br>
 - The detective is the murderer <strong>and</strong> the victim.<br>
 - The detective appears to be a ghost but is actually a living human pretending to be a ghost pretending to be a living human (the dreaded <a href="http://dresdencodak.com/2009/05/11/42-essential-3rd-act-twists/" rel="nofollow noreferrer">reverse double Shyamalan</a>).<br>
 - The puzzle outputs the name of the murderer when executed by the Perl interpreter.<br>
 - The entire puzzle takes place in the <a href="http://en.wikipedia.org/wiki/Buffyverse" rel="nofollow noreferrer">Buffyverse</a>.</p>
</blockquote>

<hr>

Update after reading OP's solution: yay! Nailed it.  :)   

#### Answer 2 (score 24)
I have a possible solution which no-one else has yet suggested. It has the <a href="http://en.wikipedia.org/wiki/Occam&#39;s_razor" rel="nofollow noreferrer">virtue of simplicity</a>.  

<blockquote class="spoiler">
   The puzzle has no single logically unique answer; OP is a troll (or does not  understand that a puzzle should have a specific answer that can be deduced from the question).  
</blockquote>

My reasoning:  

<blockquote class="spoiler">
  <p> - OP has no posting history here or on linked SE sites.<br>
 - So much detail in the story, so many 'clues', <a href="http://tvtropes.org/pmwiki/pmwiki.php/Main/RasputinianDeath" rel="nofollow noreferrer">Rasputinian Death</a>.<br>
 - <a href="https://puzzling.stackexchange.com/posts/3726/revisions">Flaky grammar</a> in the original post is not consistent with an intelligent OP (counter-argument: OP could have English as a foreign language or have a condition such as dyslexia which allows them to be intelligent but not good at writing in English. Or maybe the mistakes are intentional.)<br>
 - No sign of this puzzle on Google, so OP probably came up with it themselves.<br>
 - OP: "i just like reading all the answers people come up with"<br>
 - I'm a deeply cynical person.</p>
</blockquote>

I'd consider the following answers equivalent to my solution (you might not agree):  

<blockquote class="spoiler">
  <p> - <strong>OP has a solution but it's no more logical or likely than anyone else's solution.</strong> <br>
 - Everyone in the story is non-human (they're goldfish and 'Chicago' is the name of the fishbowl, etc etc). <br>
 - God / Satan / Father Christmas / aliens did it (<a href="http://en.wikipedia.org/wiki/Deus_ex_machina" rel="nofollow noreferrer">deus ex machina</a>).  <br>
 - It's <a href="http://tvtropes.org/pmwiki/pmwiki.php/Main/AllJustADream" rel="nofollow noreferrer">all just a dream</a> / hallucination / taking place in The Matrix. <br>
 - Dead body is not a human or is not really dead.</p>
</blockquote>

The OP gets a bounty from me if:  

<blockquote class="spoiler">
  <p> The puzzle <em>is</em> logically coherent and: <br> <br>
 - The detective is a ghost ('the Shyamalan' plot twist).<br>
 - The detective is the murderer or the victim.<br>
 - They all did it ('<a href="http://en.wikipedia.org/wiki/Murder_on_the_Orient_Express" rel="nofollow noreferrer">Murder on the Orient Express</a>').<br>
 - The solution involves a time machine or an alternate universe. <br>
 - The murderer is one of the minor characters, eg the assistant, the old boss or the forensic scientist ('the butler did it').<br>
 - The mangled English is integral to the solution of the puzzle.<br>
 - The puzzle is not a murder mystery (e.g message enciphered in the typos).<br>
 - The story (with original typos) successfully compiles in any well-known programming language<br> <br>
 or if OP's solution consists solely of trollface.gif.</p>
</blockquote>

Double bounty if:  

<blockquote class="spoiler">
  <p> The puzzle <em>is</em> logically coherent and: <br> <br>
 - The detective is the murderer <strong>and</strong> the victim.<br>
 - The detective appears to be a ghost but is actually a living human pretending to be a ghost pretending to be a living human (the dreaded <a href="http://dresdencodak.com/2009/05/11/42-essential-3rd-act-twists/" rel="nofollow noreferrer">reverse double Shyamalan</a>).<br>
 - The puzzle outputs the name of the murderer when executed by the Perl interpreter.<br>
 - The entire puzzle takes place in the <a href="http://en.wikipedia.org/wiki/Buffyverse" rel="nofollow noreferrer">Buffyverse</a>.</p>
</blockquote>

<hr>

Update after reading OP's solution: yay! Nailed it.  :)   

#### Answer 3 (score 21)
<strong>Story</strong>  

<blockquote class="spoiler">
   The woman was jogging with the poodle around the block. <br /><br />The "victim" (here on out as Attacker) confronted the woman with the knife and the dog went crazy as any good dog should. Then the attacker pulls out a gun and shoots the dog. The homeless man is witnessing this and comes to the aid of the woman. He is carrying his own knife. <br/><br/>The homeless man surprises the attacker and stabs him and they start wrestling on the ground. The attacker struggles and accidentally shoots himself in the leg as the homeless man wrestles with him and the gun. <br /><br /> While this is happening, the woman starts to strangle the man with the leash. As the attacker gets weaker, the homeless man is able to stab a couple of more times.  
</blockquote>

<strong>Evidence Allocation</strong>  

<blockquote class="spoiler">
   - The circular blood stains is from the dog bleeding and being carried. <br /> - The foot print is either from the woman jogging if she has large feet or the homeless man <br /> - The clean knife is the attackers which he never used. <br /> - The gunshots were self inflicted by the attacker struggling. <br />- The note was written by both or just the homeless man as the woman told him what to write. The "1H8H1M" came from the homeless man meaning "I hate him".  
</blockquote>

<strong>Murderer</strong>  

<blockquote class="spoiler">
   The murderers are the woman and homeless man.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How can one solve a Rubik's cube without relying on guides/algorithms? (score [38620](https://stackoverflow.com/q/54060) in 2017)

#### Question
I am wondering who is able to solve Rubik's cube just by thinking without knowing the rules behind it. As far as I know the inventor Ernő Rubik was professor of architecture and he intended to help students to learn 3D imagination. However from my point of view it is really ridiculous and probably to hard for most of us at least in reasonable time. For me personally it is really hard to memorize all implications of either move after 2 or even 3 turns.  

What special logic or memorization techniques could be applied to solving a Rubik's cube <em>without relying on guides or taught algorithms</em>? In other words, how would one go about solving a Rubik's cube "blind", from a general mechanical understanding and first principles?  

#### Answer accepted (score 29)
There are three techniques that allow you to come up with useful move sequences for solving a cube.  

<strong>Conjugation</strong>  

This is where you already have a move sequence that does one thing and allows you to apply it more generally.  

<p>Suppose for example that you know a move sequence `X` that twists the two adjacent corners at the front of the top layer (i.e. at UFR and UFL). However, maybe you want to twist to corners that are not adjacent. You might for example want to make a pretty pattern where two diametrically opposed corners are twisted (i.e. UFR and DBL). Then all you have to do is some setup move(s) to bring the two corner pieces you want to twist to the top front, apply the sequence `X`, and then undo the setup move(s).
<br>In this example, `X` could be `R'DR FDF' U' FD'F' R'D'R U`.
<br>The setup move to bring DBL to UFL is simply `L2`.
<br>The resulting move sequence is then `L2 X L2`, or `L2 R'DR FDF' U' FD'F' R'D'R U L2`</p>

This process is called conjugation. You conjugate the move sequence `X` so that you can apply the twists to any two corners of the cube rather than just the two at the top front.  

<strong>Commutation</strong>  

This technique allows you to come up with a useful move sequence such as `X` in the first place.  

Suppose you are solving the top layer first, and have only one corner left to do. So the top layer is solved apart from the URF corner, and the corner piece that belongs there is below it at DRF. You can insert it in two ways - using the right face by `R'D'R`, or with the front face by `FDF'`. If you choose the wrong one, the corner will be put in its correct place but twisted. If you put it in with `R'D'R` and it was wrong, you can take it out again by undoing those moves (i.e. `R'DR`) and then using the front face instead (i.e. `FDF'`).  

<p>From this we have a short move sequence `R'DR FDF'` that twists a single corner in the top face. Lets call it `Y`. Unfortunately `Y` is only useful on the first top layer, since it messes up the pieces of the other two layers. <br>This is where commutation comes in. Consider what happens when you do `Y U' Y' U`. The first `Y` twists the top right corner. The `U'` temporarily replaces that twisted corner by another. The `Y'` twists that replacement corner in the opposite direction. Finally the `U` puts the corners back where they came from.
<br>The clever thing is what happens to the bottom two layers. It is not affected by the `U'` or `U` so it only "feels" the `Y` and `Y'` which cancel each other out.  This means that everything is left as it was except for the two twisted corners.</p>

<p>A commutator is a move sequence of the form `YZY'Z'` where `Y` and `Z` are any move sequences you like. The magic happens when there are very few pieces that are affected by both `Y` and `Z`. For example in this case `Z`=`U'` affected only pieces in the top layer while `Y` affected mostly the bottom two layers except for one corner piece of the top layer.   

So commutation fully explains how the move sequence `X` works.  

There are various tutorials online about conjugation and commutation/commutators and how they apply to the Rubik's Cube and similar puzzles.  

<strong>Repetition</strong>  

Another technique that is mentioned less often but which can be very useful on occasion is repetition. Consider the commutation of two adjacent face moves, for example `RF'R'F`. The faces have 3 pieces that overlap, so the result of this commutator is not quite so simple. It affects 3 edges which are moved around in a 3-cycle, and affects 4 corners which are swapped in pairs.  

Nevertheless this move sequence is very useful if you repeat it three times. By doing this the 3-cycle of edges are returned to where the started, so that only the 4 corners are affected.  

<strong>tldr;</strong>  

With these three techniques you can build enough useful move sequences to solve almost any twisty puzzle. The move sequences may not always be as short as they could be, but they will be easy to memorise because you know the underlying structure that they were built from and which explains how they do what they do.  

#### Answer 2 (score 14)
<p>I haven't solved the 3x3x3 Cube myself. I bought mine in 2010, and used a tutorial to solve it. In 2012 I started a twisty puzzles collection, and I currently have <a href="http://www.twistypuzzles.com/forum/viewtopic.php?f=14&amp;t=26889" rel="nofollow noreferrer">more than 350 puzzles in my collection</a>. So even though I haven't solved the 3x3x3 Cube myself, I have solved quite a few other puzzles myself (after I gained knowledge, understanding and ideas from all the other puzzles I have).<br>
Some of the puzzles I own are custom made, 3D-printed, or made by myself, so they are fairly unique, and only a handful of people in the entire world have these puzzles. Because of this, there also aren't any tutorials or solutions out there for some of these puzzles.</p>

So how do I tackle those puzzles? How do I solve them myself? (Short disclaimer, I'm more of a collector than a solver, so I'm certainly no expert or good solver.)  

<ol>
<li>When I have a new puzzle, the first thing to figure out is how it works of course. This may be a pretty obvious step, but sometimes a puzzle may work slightly different than it looks like on first look. I look at the moves that are possible, and how many (and which) pieces move around. I also look at how many times I have to repeat this before it's back where it was (like four times on a 3x3x3 Cube, five times on a <a href="https://s28.postimg.cc/dednql2xp/DSC_0060.jpg" rel="nofollow noreferrer">Megaminx</a>, three times on a <a href="https://s22.postimg.cc/ks4ukd29t/DSC_0070.jpg" rel="nofollow noreferrer">Pyraminx</a>, etc.).</li>
<li>Then I usually choose between two basic strategies:<br>
a. Solve by piece-type: I personally mainly use this method with puzzles I solve myself, because it's easier to grasp imho.<br>
b. Solve layer-by-layer: This is the method I've learned from the 3x3x3 Cube, and later also for other puzzles like the <a href="https://s28.postimg.cc/dednql2xp/DSC_0060.jpg" rel="nofollow noreferrer">Megaminx</a>, <a href="https://s22.postimg.cc/ks4ukd29t/DSC_0070.jpg" rel="nofollow noreferrer">Pyraminx</a>, etc.</li>
<li><p>Whether I solve by piece-type or layer-by-layer it really depends on the puzzle. When the puzzle is derived from another puzzle I already know, like the 3x3x3 Cube, I use a method as close to that as possible. A simple example: I would first reduce a 5x5x5 Cube to a 3x3x3 by creating 3x3 centers, and 1x3 edges, and then solve it as such. Or a bandaged 3x3x3 I would also solve as a regular 3x3x3 Cube and use algorithms and strategies from multiple different 3x3x3 methods I've learned (Beginner's Method, Cuboid, Triamese, own algorithms, etc.) to bypass the bandaged pieces and still solve layer-by-layer (although sometimes it can't be helped, and by piece-type is a better strategy for a certain bandaged 3x3x3).  </p>

<p>So let's say I solve per piece-type. What does piece-type mean, you say? When we look at a 3x3x3 Cube, there are three different piece-types: Centers, Corners and Edges. When we look at a <a href="https://s8.postimg.cc/kf95m179h/DSCN2873.jpg" rel="nofollow noreferrer">Tangram Cube Extreme</a> (which I recently figured out how to solve myself), <a href="https://s2.postimg.cc/f4lqulig9/Tangram_Cube_Extreme_piece-types.png" rel="nofollow noreferrer">we see six different piece-types</a>. It's a bit too advanced and off-topic to explain what each piece-type is, or how the Tangram Cube Extreme works for now.. The important part is, when I've figured out how to solve the Tangram Cube Extreme, I noticed that it's best to start solving the middle-layer (piece-types F and G). Why? When I try to solve the other pieces, it's very easy to come up with short algorithms which keep the middle-layer (F &amp; G) solved. Kinda like solving the second layer of a 3x3x3 Cube, without destroying the already solved first layer.<br>
After I had solved the middle layer intuitively, I came up with a three-cycle for the big B and C pieces. When I used this algorithm I came up with, I noticed it also moved the pieces D and E around, so therefore I knew I had to solve B and C first with this algorithm, before moving on to D and E.<br>
After all B and C pieces were correctly aligned with the corners (A) and middle layer (F &amp; G), I came up with a new three-cycle for the pieces D, which wouldn't disturb/destroy the pieces A, B, C, F nor G (which we had already solved). And finally I used an algorithm I already knew from another puzzles to purely three-cycle the E-pieces to finish the solve.</p></li>
</ol>

<strong>Coming up with algorithms:</strong>  

As I told above, I came up with three-cycle algorithms for the Tangram Cube Extreme. But how do you come up with algorithms?  

<p>Algorithms usually consist of four parts:<br>
- It can be in the form of `A B A' B'`. Where both `A` and `B` are a single move or a short sequence, and `A'` and `B'` is undoing those moves or sequences. These kind of algorithms are usually used to move pieces around (three-cycles, five-cycles, double-swaps, etc.)<br>
- It could also be in the form of `A B A' B`. These kind of algorithms are usually used to orient pieces without moving them.</p>

Let's look at some algorithms we might know from the 3x3x3 Cube (if you know <a href="https://www.youtube.com/watch?v=bNgxnIE3eKc" rel="nofollow noreferrer">this Beginner's Method</a> - NOTE that there are A LOT of 3x3x3 Cube Beginner's method. The only thing they have in common is that you solve them layer-by-layer, but apart from that the algorithms and steps can differ a lot):  

<ul>
<li>`D' R' D R D F D' F'`: This algorithm is used to insert a middle-layer edge on a 3x3x3 Cube, using a layer-by-layer Beginner's Method. As you can see, this consist of `D' R' D R` and `D F D' F'`, combining two `A B A' B'` algorithms to achieve what we want: solving a middle-layer edge piece, without destroying the first layer, nor any other middle-layer edge pieces we might already have solved.</li>
<li>`U R U' L' U R' U' L`: This algorithm is used to three-cycle three top-layer corners on a 3x3x3 Cube, using a layer-by-layer Beginner's Method. This is again an `A B A' B'`-algorithm, with the following four parts: `U R U'`; `L'`; `U R' U'`; `L`.</li>
<li>`((R' D' R D)2 U)3 U` or `R' D' R D (2x)` used three times: This algorithm is used to orient the top-layer corners of a 3x3x3 Cube, at the end of the layer-by-layer Beginner's Method. This is an `A B A' B`-algorithm, where `B` are the `U`-moves, and `A` and `A'` are the `R' D' R D (2x)` (Note that `R' D' R D` is a sequence in the form of `A B A' B'` itself.)</li>
</ul>

<p>So, that's the theory around algorithm types, but how do we come up with these ourselves? As I mentioned before, I'm no expert, but personally I always try to do some short four or six move sequences and see how it affects the piece-types in the puzzle. If it does something useful, like swapping pieces or creating a five-cycle, I make a commutators (`A B A' B'`) where this sequence I came up with is either `A` or `B`, and I use some in-between setup moves to create three-cycles or double-swaps which I can use to solve the puzzle.<br>
My big pitfall when I solve puzzles however, is that I sometimes use this entire 3-cycle I came up with for one part of the solve, as a sequence part (`A` or `B`) for another 3-cycle of the next part of the solve. This means I sometimes have algorithms of over 40 moves long to three-cycle or orient some of the final pieces. Pretty inefficient as you can imagine (although I'm still proud to say I've been able to solve some puzzles myself using these long-ass algorithms, which I came up with entirely on my own).</p>

<strong>Difficulty of the puzzle</strong>  

It also all depends on the difficulty of a puzzle, and prior knowledge. A 2x2x2 is obviously easier than a 3x3x3, and a 3x3x3 is easier than a 4x4x4. If you know how to solve a 3x3x3, you are automatically able to solve a 2x2x2 (because it's a corners-only 3x3x3). When you can solve a 4x4x4 (using a reduction method) you can automatically solve a 3x3x3 and 2x2x2.  

Your question however, was how people solved a 3x3x3 Cube without any prior knowledge. Not much different than I solve new puzzles tbh. They try to come up with useful sequences and algorithms; analyze the most useful order to solve them in with the algorithms they come up with; and overcome challenges during the solve with cases they hadn't thought of, like parities on even-layered cubes of 4x4x4 or higher; or something as simple a middle-layer 3x3x3 edge that is already at the correct place, but should be oriented correctly / mirrored; or needing a double-swap of top-layer corners instead of a three-cycle. Both 'cases' are easily to overcome (by inserting a random piece in the middle-layer edge position to bump the other out, which you can then insert correctly oriented; or by just using the three-cycle of corners algorithm once, and then one of the four corners should be correct).  

Still, I personally think it's impressive when people figured out how to solve a 3x3x3 Cube entirely on their own, without any prior knowledge. Chapeau to them for doing so. And it's always cool to see which method they've developed, and how they came up with it (like <a href="https://www.youtube.com/watch?v=HhaXYA3e8ic" rel="nofollow noreferrer">the video I linked of Tony Fisher</a> in my comment of the question).  

#### Answer 3 (score 12)
<strong>Logic</strong>  

Every method for solving a Rubik's Cube comes down to algorithms at some stage. These algorithms are a set of moves which you memorise and perform when a set of criteria is met. For example, the popular "T-Permutation" will swap two corners and two edges in a T shape and is used to solve the last layer in most methods.  

For most people, they are able to complete one face of the cube. This can easily be achieved through trial and error, with a low level of thinking.  

To complete a <em>layer</em>, one must place the corners and edges in such a way that three squares in each surrounding face are also complete:  

<a href="https://i.stack.imgur.com/LRrTX.png" rel="noreferrer"><img src="https://i.stack.imgur.com/LRrTX.png" alt="First layer completed."></a>  

Notice that the middle layer can be rotated so that all four centre squares are correct, too.  

After this point, most people trying to do it themselves struggle. It is impossible to move an edge piece into its place on the middle layer without rotating one of the sides. This leads to the breaking up of the initial face, causing progress to be reset.  

<strong>To place these edges an algorithm must be used.</strong>  

It is possible to complete both the first and middle layer without using algorithms. This method is called F2L (First two layers) because it involves solving both layers simultaneously. I won't go into detail here, however in short it still leaves the last layer, which must be done using algorithms.  

<strong>How does an individual "work out" how to solve one then, without looking up the algorithms?</strong>  

Well, how did people find these algorithms in the first place? By playing with the cube and observing the effects that groups of moves have, it is possible for one to discover a set of moves which only moves a small number of parts as the end result. Once a set of algorithms is found, you must find a method which makes use for them.  

For example: if you don't have an algorithm that moves corners, you will need to find a method that always results in a final phase which does not need to move corners. The "corners first" method achieves this, where the corners of the whole cube are put into place and the edges are done using edge-swap algorithms.  

<strong>Summary</strong>  

In short, it is possible to find a method yourself, however few people have been able to do this. All of those who have have done it through finding and using algorithms.  

<strong>TL:DR</strong>  

<ol>
<li>You need algorithms.</li>
<li>Most people can do one face.</li>
<li>Some people can do a layer, using observation, calculations, and logic.</li>
<li>It's possible to solve two layers without using algorithms; the final layer requires them.</li>
<li>Algorithms can be found through trial and error, recording results and comparing them.</li>
<li>Once a few algorithms are found, you must construct a method which uses them.</li>
<li>Very few people have done this, and I think that very few people have the patience.</li>
<li>TL:DR: Use algorithms. It takes time and patience.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: Logical English Riddles (score [38297](https://stackoverflow.com/q/63693) in )

#### Question
<blockquote>
  <p>Someone's mother has four sons. name of three sons are
  <strong>north</strong>,<strong>east</strong>,<strong>west</strong>, what is the name of the fourth son</p>
</blockquote>

can anyone tell?  

#### Answer accepted (score 10)
i believe that the answer is   

<blockquote class="spoiler">
   What  
</blockquote>

as  

<blockquote class="spoiler">
   whenever this question is asked, it’s actually asked this way: “Someone's mom has four sons, North, East and West. What is the name of the fourth son. Can you guess the name of the fourth son?”  
</blockquote>

moreover  

<blockquote class="spoiler">
   If you read it again, the second sentence ends with a full stop. It’s a statement. It tells you the name of the fourth son is, “What”.  
</blockquote>

#### Answer 2 (score 10)
i believe that the answer is   

<blockquote class="spoiler">
   What  
</blockquote>

as  

<blockquote class="spoiler">
   whenever this question is asked, it’s actually asked this way: “Someone's mom has four sons, North, East and West. What is the name of the fourth son. Can you guess the name of the fourth son?”  
</blockquote>

moreover  

<blockquote class="spoiler">
   If you read it again, the second sentence ends with a full stop. It’s a statement. It tells you the name of the fourth son is, “What”.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Up the hill with 3 legs and back down with 4 (score [38115](https://stackoverflow.com/q/27927) in 2016)

#### Question
<p>Though I'm not alive, I had 4 legs when I was born.<br>
I lost a leg when I got too stressed and worn.<br>
I go up the hill with just 3 legs, and come down the hill with 4.<br>
If my owner doesn't lose some weight, I'll be going up the hill some more!</p>

#### Answer accepted (score 6)
Maybe  

<blockquote class="spoiler">
   A chair.  
</blockquote>

Though I'm not alive, I had 4 legs when I was born.  

<blockquote class="spoiler">
   4 legs and not alive. Sounds like a chair to me.  
</blockquote>

I lost a leg when I got too stressed and worn.  

<blockquote class="spoiler">
   Stressed and worn - a chair leg broke because of a large weight. (applying pressure causes stress and can wear down wood)  
</blockquote>

I go up the hill with just 3 legs, and come down the hill with 4.  

<blockquote class="spoiler">
   ? I suppose that someone who fixes chairs has his office at the top of a hill for some reason.  
</blockquote>

If my owner doesn't lose some weight, I'll be going up the hill some more!  

<blockquote class="spoiler">
   Well, if the owner is heavy, he's bound to break that chair leg again sooner or later.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: 3 Logicians Walk Into a Bar (score [37838](https://stackoverflow.com/q/12422) in 2015)

#### Question
Three logicians walk into a bar. The barman says, 'Does everybody want a drink?'  

The first logician says, 'I don't know.'  

The second logician says, 'I don't know.'  

What does the third logician say?  

<hr>

Please provide a clear explanation of why each of the logicians reply in the way they do.  

#### Answer accepted (score 107)
<em>Question:</em>  

<blockquote>
  Does <strong>everybody</strong> want a drink?  
</blockquote>

The third logician answers:    

<blockquote class="spoiler">
   "<strong>YES</strong>" if he wants a drink, "<strong>NO</strong>" if doesn't want it.   
</blockquote>

<em>Reason:</em>   

<p>The first says "I don't know" because he wants a drink, but doesn't know if  everybody wants one. If the first didn't want a drink, he would have answered "No".<br>
 Same for the second, he wants a drink but doesn't know if the third wants one.
 So, the third answers "Yes" if he wants a drink, "No" if he doesn't.</p>

#### Answer 2 (score 11)
We'll name the logicians A, B, and C to simplify.  

If A wants a drink, A doesn't yet know whether B and C want a drink.  Thus A cannot answer "yes".  

If A does not want a drink, A would say "no" because at least one of A, B, and C don't want a drink, making "does everybody want a drink" false.  

By saying "I don't know" A indicates their personal desire for a drink, but his lack of knowledge about the other two.  

B is essentially in the same situation.  B can deduce that A wants a drink, but still doesn't know the preference of C, therefore must answer "no" if B doesn't want a drink, and must answer "I don't know" if B wants a drink.  

C, however, can now deduce that A and B both want drinks.  

So if the third logician wants a drink, they say:  

<blockquote class="spoiler">
   Yes, everybody wants a drink.  
</blockquote>

If the third logician doesn't want a drink, they say:  

<blockquote class="spoiler">
   No, not everyone wants a drink.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: The coach, the shoes and the whistle (score [37298](https://stackoverflow.com/q/61057) in 2018)

#### Question
I recently received the following mathematical puzzle in a Whatsapp group:  

<a href="https://i.stack.imgur.com/YsJMd.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/YsJMd.jpg" alt="enter image description here"></a>  

After a lot of debating, the group got to the conclusion that the answer was   

<blockquote class="spoiler">
   11  
</blockquote>

I however, was skeptical. After a while I realized that <strong>?</strong> can, in fact, be <strong>any number</strong>.  

You have to show this. For simplicity, you need to show that the solution can be both the number above (i.e. what the Whatsapp group agreed), and <strong>8.162</strong> (rounded to the third decimal).   

After doing the above, it becomes evident that any number can solve the problem.   

Note: a 50 reputation bonus will go to the one who can mathematically show that any number can solve the problem.  

#### Answer accepted (score 15)
I guess it is something like that:  

<blockquote class="spoiler">
  <p> Who said a pair of shoes value is the sum of two shoes value? For an example, I will say values of two objects together multiply.<br>
 Then we have 1 shoe value is sqrt (10).  A whistle is 2 and a man  is 5/2.   </p>
</blockquote>

Making the result:   

<blockquote class="spoiler">
   sqrt (10) + 5/2 * 2 = 8.16   
</blockquote>

#### Answer 2 (score 11)
<blockquote class="spoiler">
  <p> The problem does not specify how to compute the value of multiple
 objects combined into a single picture, and so multiple choices are
 possible.  As other answers have explained, using addition gives an
 answer of 11, whereas multiplication gives 8.162.</p>
</blockquote>

.  

<blockquote class="spoiler">
  <p> However, these aren't the only two possible choices. Arguably, the only
 hard requirement is that the valuation for a pair of objects be a
 commutative function, as there is no clear ordering of the pair of
 objects being combined.  This allows for an infinite number of possible
 functions, so it is reasonable that we can come up with one to get any
 desired answer.</p>
</blockquote>

.  

<blockquote class="spoiler">
  <p> One family of such functions would be to take the sum but scale by an
 arbitrarily chosen constant, i.e. $f(x, y)=\frac{x + y}{k}$.  (It makes
 the math simpler later to divide rather than multiply.) For $k=1$, this
 is the same as just adding the components, and we would get the answer
 11.  But there is no reason we can’t set $k$ to other values — any
 nonzero value we choose for $k$ would still be consistent with the given
 facts; it would just scale the “base value” of the standalone symbols. 
 Specifically, the base values for one shoe, a man without a whistle, and
 a whistle would be $5k$, $3k$, and $2k$.</p>
</blockquote>

.  

<blockquote class="spoiler">
   The final line then becomes $5k + 3k\times2k =$ ?  
</blockquote>

.  

<blockquote class="spoiler">
  <p> This allows us to choose a $k$ so as to give any desired value for the
 ?:  Let’s call our desired answer $d$. We then get
 $6k^2 + 5k - d = 0$, which we can solve for $k$ using the binomial
 theorem:</p>
</blockquote>

.  

<blockquote class="spoiler">
  <p> $k=\frac{-5 \pm\sqrt{(5)^2 -4(6)(-d)}}{2(6)} =$
 $\frac{-5 \pm\sqrt{25 + 24d}}{12}$</p>
</blockquote>

This has at least one nonzero solution for all real values of $d$, demonstrating that any real number is a valid answer to the puzzle.  

#### Answer 3 (score 10)
Using algebra, we arrive at:   

<blockquote class="spoiler">
  <p> A <strong>single shoe = 5</strong> (and a pair = 10)<br>
 A <strong>coach = 5</strong><br>
 A <strong>whistle = 2</strong> (and a pair = 4)  </p>
</blockquote>

However, note that:   

<blockquote class="spoiler">
  <p> The coach has a whistle around his neck in the first 3 occurrences<br>
 That implies that <strong>coach + whistle = 5</strong><br>
 And in turn, <strong>coach without whistle = 3</strong>  </p>
</blockquote>

That would result in:   

<blockquote class="spoiler">
  <p> ? = shoe + (coach without whistle) x whistle = 5 + (3) * 2<br>
 Resulting in <strong>? = 11</strong> </p>
</blockquote>

This covers the first part of the answer, matching what was originally agreed in your WhatsApp group.   

Building on <a href="https://puzzling.stackexchange.com/a/61063/33080">Untitpoi's answer</a>, I'd say that we can say that the question mark can be any number because:   

<blockquote class="spoiler">
  <p> The principle can be extended as one likes with general functions.<br>
<br>
 For instance, if a single shoe is $x$ then a pair of shoes can be viewed as $f(x)$.<br>
 My answer above treated $f(x) = 2 \cdot x$, Untitpoi showed how $f(x) = x^2$ gives a different answer.<br>
<br>
 Instead, if $f(x)$ is some other function (say $f(x) = ln(x) $ ), it can result in some other number. The choice of different functions for deriving a pair of shoes from a single shoe, a pair of whistles from a single whistle, and a coach with/without a whistle can all generate different numbers. </p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: If you choose an answer to this question at random, what is the chance you will be correct? (score [37273](https://stackoverflow.com/q/6653) in )

#### Question
If you choose an answer to this question at random, what is the chance you will be correct?  

A) 25%  

B) 50%  

C) 60%  

D) 25%  

<img src="https://pbs.twimg.com/media/B57kNq4IYAEA-Zj.jpg:large" alt="">  

#### Answer accepted (score 13)
When limited to the 4 provided answers, there is no correct answer, because this question is a paradox.  

When there is one correct answer, the chance to pick that answer would be 25%. However, the answer 25% exists twice, so there is a 50% chance of picking it. But there is only one answer which says 50% and the chance to pick that answer is 25%.  

However, there is no instruction in the question that you need to pick one of the <em>provided</em> answers. In that case "picking an answer at random" would mean that I would respond with a completely random statement like "A", "Y", "3.14159", "Warshaw", "jksdaskfa" or "Bob is the one who stole the strawberry cake". My answer could be literally anything, so there is an unlimited number of possible responses. Assuming that there is an unlimited set of incorrect answers but only a limited set of correct answers, the chance of picking a correct answer is `0%` which would be my answer.  

#### Answer 2 (score 7)
You did not state the answer had to be <strong>uniformely random</strong> so therefore I can look at the answers, recognize the paradox, and limit the answers to the 2 possible, <em>25%</em> and <em>50%</em>. Then the answer becomes 50% since there are 2 choices.  

TL;DR  

<blockquote>
  50%  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: My wife has died (score [37239](https://stackoverflow.com/q/11238) in 2015)

#### Question
In 1980, a man lives on the 30th floor of his building. Every morning he wakes up, gets ready, kisses his wife, takes the elevator down to the first floor, and goes to work.    

One morning, he wakes up, gets ready, kisses his wife, and gets in the elevator, exactly as he always has done. The morning is exactly the same as any other morning, and no one else was in their apartment.    

The man is alone in the elevator and there are no windows in or visible from the elevator. Without receiving any  communication of any kind, or the man being in any danger of any harm, he begins crying when the elevator reaches the 12th floor, because he knows his wife has died.    

How is this possible?    

Notes (added later) to eliminate "too broad" answers:   

<blockquote class="spoiler">
  <p> His wife was alive when he left the apartment.<br>
 The man loved his wife, and would never harm her in any way.</p>
</blockquote>

And for the more extreme options:   

<blockquote class="spoiler">
  <p> The man had a boring typical day job. No danger involved. 
 The laws of physics have not been repealed, and there are no mythical or fiction occurrences happening.<br>
 As always, aliens are not involved.</p>
</blockquote>

#### Answer accepted (score 108)
His wife  

<blockquote class="spoiler">
   is on in-home life support.  
</blockquote>

The elevator   

<blockquote class="spoiler">
   stops at the 12th floor because the power in the building went out.  
</blockquote>

So now he's   

<blockquote class="spoiler">
   stuck in an elevator (despite being in no harm) while his wife is dying upstairs.  
</blockquote>

I guess you could argue that the event is a sort of "communication", but that seems pretty weak to me.  

#### Answer 2 (score 89)
I know I'm coming in late here, however, I'll toss a completely different take on this.  

<blockquote class="spoiler">
   When he kisses his "wife" each morning, it's only a picture. She died a year ago on this day. He's crying because it's the 1 year anniversary of her death.  
</blockquote>



#### Answer 3 (score 43)
My solution:  

<blockquote class="spoiler">
  <p>The building he lives in has a 13th floor.<br>
<br>
However, this morning he noticed the 13th was missing, it went from the 14th floor directly to the 12th floor. <br>
<br>
The only possibility? The labyrinth builder was superstitious of the number 13 so his copy of the building did not include it.<br>
<br>
The man is Dom Cobb, and he is in a dream. His wife, Mal Cobb, committed suicide years ago. The error in the building has made him aware of the dream.</p>
</blockquote>

Inception!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: You can keep it only after you give it to someone else. What is it? (score [36905](https://stackoverflow.com/q/30541) in )

#### Question
You can keep it only after you give it to someone else. What is it?   

#### Answer accepted (score 23)
The answer to the riddle is:   

<blockquote class="spoiler">
   your word  
</blockquote>

#### Answer 2 (score 5)
Or, (equivalently),  

<blockquote class="spoiler">
   a promise.  
</blockquote>

#### Answer 3 (score 4)
Answer    

<blockquote class="spoiler">
  <p> Genes<br>
<br>
 You can keep your genes "going", only after you passed them you your son/daughter. </p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: What is the Official notation on rubik's revenge(4x4)? (score [36474](https://stackoverflow.com/q/12098) in 2018)

#### Question
When solving a 4x4 cube you have specific notation to inner and outer lines, like `R` = <em>Clockwise outer right</em> and `r` = <em>Clockwise inner right</em>. If you want to turn both, the two letter must be combined like `Rr`, `(Rr)'` or `(Rr)2`. To solve OLL parity I could use the following algorithm:  

<img src="https://i.stack.imgur.com/EZ3Xn.gif" alt="enter image description here">  

<em>Image linked from <a href="http://www.speedcubing.com/chris/4speedsolve3.html" rel="nofollow noreferrer">speedcubing.com</a></em>  

```text
r2 B2 U2 l U2 r' U2 r U2 F2 r F2 l' B2 r2
```

If `r2` means <em>"turn inner right 2 times clockwise"</em>, why some sites uses `r` as `Rr`?  

<strong>Example:</strong>  

<ol>
<li>Open <a href="https://alg.cubing.net/" rel="nofollow noreferrer">Alg Cubing</a></li>
<li>Select 4x4 cube</li>
<li>Inside the Moves field, type `r`</li>
<li>Play. <em>It will turn both right columns.</em> </li>
</ol>

<strong>Related Stuff:</strong>  

<ul>
<li><a href="http://www.rubiksplace.com/cubes/4x4/" rel="nofollow noreferrer">This site</a> uses the notation `r` to define "both layers(outer and inner)".</li>
<li>However, <a href="http://loki.ist.unomaha.edu/~jtrimm/project/4x4.html" rel="nofollow noreferrer">this site</a> uses the notation `Rr`to define "both layers"</li>
</ul>

<strong>My question</strong>: What is the official notation to 4x4 movements(if any exists)?  

#### Answer accepted (score 6)
There is <a href="https://www.worldcubeassociation.org/regulations/#article-12-notation" rel="noreferrer">an official scramble notation</a> for WCA competitions (which has continued to change over the years), which uses `Rw` as (`Rr`), `3Rw` as (`l' r R`), and so forth.  

You will notice on that page that they do not have symbols designated for inner slice turns only because the WCA scrambles cubes using outer block turns only to follow the outer block turn metric (OBTM).  However, <a href="https://www.youtube.com/watch?v=j-svGANFGXc" rel="noreferrer">SiGN notation</a>, as you have seen on alg.cubing.net, is used more often now than previously.  

Clearly a move such as `Rw` = (`Rr`) which is used for WCA scrambles is never mistaken for an inner slice turn, for example; and thus a good rule of thumb for the casual cuber who wishes to communicate his algorithms to others is to have the courtesy to label the notation next to the alg if the algorithm does not use "`Rw`" moves (clearly Old WCA) `2R2` moves (clearly SiGN).  

Taking the edge flip alg you posted, for example:  

`r2 B2 U2 l U2 r' U2 r U2 F2 r F2 l' B2 r2` (Old WCA notation).  

Lastly, it's even better to link your algorithms to a site like alg.cubing.net (for SiGN notation) or alg.garron.us (for old WCA notation), so that those who do not know of a notation at all can still see the algorithm with a click of a play button.  

#### Answer 2 (score 2)
Notation is just a way of expressing sequences of moves. The notation used can change depending on who's doing the notating, and this is true of all higher-dimensional puzzles. There's not really a standard way to notate, any more than the symbols we use for physics are standard. It'd be inconvenient to switch, but we certainly could.   

As an example, <a href="https://i.stack.imgur.com/oKyMN.jpg" rel="nofollow noreferrer">the Trignis</a> has very different notation depending on the method the solver used to solve the puzzle.  

Consequently, there is no <em>standard notation</em> per se for higher-dimensional twisty puzzles. I more often see `R` for the rightmost, `r` for inner right, `l` for inner left, and `L` for far left; however, this is by no means necessarily universal. I've also seen `eL/eR` on the 4x4 and 5x5 for "edge-wing left" and "edge-wing right" - it just depends on convenience.  

Be sure you check with the guide you're following to see what their notation is for cube movements.  

#### Answer 3 (score 1)
I've found this, which explains the notation of 4x4 cube.    

<a href="http://www.speedcubing.com/chris/4-presolution.html" rel="nofollow">http://www.speedcubing.com/chris/4-presolution.html</a>    

<p>Basically, you have the same letters of the 3x3 (U R F B L D), upper-case if referring to external layers, lower-case if referring to internal layers.<br>
This kind of notation is commonly used in many websites and guides.<br>
You ask: <strong>"Is this official?"</strong><br>
The answer is no! As far as I know, nobody (except Erno Rubik) can say "this is official, this isn't official". In fact, there's no need to establish an official notation for the Rubik's cube.<br>
This doesn't exclude the existence of (useful) conventions, though unofficial!<br>
Currently, the preferred notation is the one described above, with capitals and lower-case letters.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: 3D wooden puzzle (score [36361](https://stackoverflow.com/q/2682) in 2017)

#### Question
I got a 3D wooden puzzle in which you are supposed to rebuild. I took pictures of the 6 pieces (click images to enlarge):  

<p><a href="https://i.stack.imgur.com/CvhjV.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/CvhjVs.jpg" alt="Piece#1"></a>
<a href="https://i.stack.imgur.com/RFvzN.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/RFvzNs.jpg" alt="Piece#2"></a>
<a href="https://i.stack.imgur.com/nOLJh.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/nOLJhs.jpg" alt="Piece#3"></a>
<a href="https://i.stack.imgur.com/UoPlB.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/UoPlBs.jpg" alt="Piece#4"></a>
<a href="https://i.stack.imgur.com/VzGG4.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/VzGG4s.jpg" alt="Piece#5"></a>
<a href="https://i.stack.imgur.com/kM04a.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/kM04as.jpg" alt="Piece#6"></a></p>

I found this image on the Internet. I believe it's the solved version:  

<img src="https://i.stack.imgur.com/PTxsK.jpg" alt="Solution">  

How do you solve it? Has anybody here done it?  

#### Answer accepted (score 15)
<p>This is one of the most well-known wooden interlocking "Burr" puzzles, called The Chinese Cross. <br /><br />
If you look at the two images below, you can see pieces that are the same shapes as yours, but with each one a different color. Using the colors as a guide, you can see how they fit together in the assembled version. <br /><br />
The photos are from Rob Stegmann's page on interlocking puzzles, which has a great deal more information on this puzzle and many like it: <a href="http://robspuzzlepage.com/interlocking.htm" rel="noreferrer">Rob's Puzzle Page</a></p>

You might also be interested in the Burr Tools program, created by Andreas Röver. It can be used to analyze and solve a huge number of different types of burr puzzles, and can be found at the <a href="http://burrtools.sourceforge.net/" rel="noreferrer">BurrTools Sourceforge</a>  

<p><img src="https://i.stack.imgur.com/k03Lc.jpg" alt="Chinese Cross pieces">
<img src="https://i.stack.imgur.com/LqoIu.jpg" alt="Chinese Cross assembled"></p>

<p><br />
Here is a set of steps for assembly. The numbered pieces correspond to the colored pieces in the photo with the following mapping: <br />
4 - Red <br />
8 - Yellow <br />
13 - Green <br />
12 - Blue <br />
7 - Pink/Purple <br />
1 - Orange <br />
<img src="https://i.stack.imgur.com/i07Xk.jpg" alt="Solution Steps">
<br /> 
You can also see a solution video here: <a href="https://www.youtube.com/watch?v=8rclzr24nS4" rel="noreferrer">Solution Video</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Why does this answer to "two doors with two guards" work? (score [34473](https://stackoverflow.com/q/40901) in 2017)

#### Question
On this post: <a href="https://puzzling.stackexchange.com/questions/2188/two-doors-with-two-guards-one-lies-one-tells-the-truth">Two doors with two guards - one lies, one tells the truth</a> the most common answer for this riddle is given.  

However, while the answer marked as correct is the most common solution I found, it does not seem correct to me. It, as with others in the thread I linked, seem to contradict the initial logic of the riddle. I have not come across the solution I came up with anywhere, so I'm curious if my logic is wrong, or if I'm just dense. Both of which are entirely possible.  

This is the original riddle in the most common form I've seen, identical to OP in linked thread...  

<blockquote>
  You are a prisoner in a room with 2 doors and 2 guards. One of the doors will guide you to freedom and behind the other is a hangman -- you don't know which is which.  
  
  One of the guards always tells the truth and the other always lies. You don't know which one is the truth-teller or the liar either.  
  
  You have to choose and open one of these doors, but you can only ask a single question to one of the guards.  
  
  What do you ask so you can pick the door to freedom?  
</blockquote>

The most common solution is:  

<blockquote class="spoiler">
   If I asked what door leads to freedom, what door would the other guard point to?   
</blockquote>

I've seen this solution everywhere, but my problems with it are that..   

<ol>
<li><p>It assumes that the guards will point to doors instead of only responding verbally. Which isn't indicated in the riddle.</p></li>
<li><p>If we ask this of the truth-guard he will point to the death door, however if we ask the same question of the liar-guard he will point to the freedom door. Otherwise he would be telling the truth about which door his counter part would point to. In essence depending on which guard we asked that question, they would still point to different doors.</p></li>
</ol>

Maybe I'm being super dense here, but it seems that doesn't tell us what door to walk through, and a better solution would be to walk up to either guard and ask  

<blockquote class="spoiler">
   Would 'you' walk through this door to freedom?  
</blockquote>

With this question no matter which guard you ask, if the answer is yes you choose the door you indicated when asking the question. If the guard answers no you choose the opposite door.   

Sorry for the long post, but thanks in advance for any responses.  

#### Answer accepted (score 17)
The most common solution is <em>usually</em> stated as  

<blockquote>
  "If I asked the other guard if the left door led to freedom, what would he say?"  
</blockquote>

This makes the chain of statements "run through" the liar once and the truthteller once, so you know the door indicated is the wrong one. ("Yes" means you should go through the right door, "no" means you should go through the left.)  

<em>Your</em> solution is the second most common one, and it's more commonly stated as:  

<blockquote>
  "If I asked <em>you</em> if the left door led to freedom, what would you say?"  
</blockquote>

This makes the chain of statements "run through" one guard twice, meaning it's either a lying paraphrase of a lie (making it the truth) or just the plain truth. This means the indicated door is the correct one.  

Either way, you know the actual correct door and can proceed.  

<hr>

Your problems with the solution given don't really hold up.  

<ul>
<li><p>"Point to" can be metaphorical. This is more of a phrasing issue though than an issue with the logic - "indicate" may be a better way to state it.</p></li>
<li><p>The liar guard would also point to the death door. The truth-teller guard would point to the freedom door, so the liar would lie about that pointing, and point to the death door. This ensures that both guards point to the death door when asked that question.</p></li>
</ul>

#### Answer 2 (score 3)
<ol>
<li><p>This is an unimportant detail to the question and answer. Whether the guards point or verbalize their answer is inconsequential. If you asked the same question, but requested they speak the answer, it would not change their answer.</p></li>
<li><p>Both guards would point to the same door when given this question, as you are not asking the liar guard what the other guard's answer to <strong>this question that you are actually asking</strong> is, you are asking him about what his answer to <strong>a hypothetical question that you did not directly ask</strong> is. You are not asking them to respond to the question you are actually asking, so the other guard's answer will not affect their own.</p></li>
</ol>

Your proposed solution, however, makes an assumption that the guards have a sense of self-preservation. This might be a safe assumption normally, but given the initial absurdity of this scenario in the first place, I wouldn't leave room for assuming anything outside of the stated parameters of the problem.  

#### Answer 3 (score 0)
A small piece, but you are injecting an extra layer into your reasoning. Your issue:  

<blockquote>
  If we ask this of the truth-guard he will point to the death door, however if we ask the same question of the liar-guard he will point to the freedom door. Otherwise he would be telling the truth about which door his counter part would point to. In essence depending on which guard we asked that question, they would still point to different doors.  
</blockquote>

is looking too deep for the liar.  

<p>Let's build a table<br>
<code>
|Guard| He Points To| Says Partner Points To|
|Truth|    Freedom  |         Death         |
|Liar |     Death   |         Death         |
</code>
You are thinking of what the liar guard would say if he was asked what his partner would say <strong>he would say</strong>. It's a level deeper than what the question is actually asking. In reality, he would say the partner points to death, because he is lying about what he partner points to, which is freedom. </p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: A seven letter word - the meaning doesn't change if you remove letters (score [34367](https://stackoverflow.com/q/2821) in 2018)

#### Question
I am a seven letter word. If you remove one letter from me my meaning does not change. If you remove two letters from me my meaning still does not change, and if you remove three letters from me, my meaning still does not change.   

Even if you remove all letters my meaning won't change. What word is this?  

#### Answer accepted (score 82)


The answer is a postbox/mailbox because if you remove a physical letter from it, it remains a mailbox; its meaning is still to hold letters. You can remove all the letters, but it will still be a mailbox.  

#### Answer 2 (score 82)


The answer is a postbox/mailbox because if you remove a physical letter from it, it remains a mailbox; its meaning is still to hold letters. You can remove all the letters, but it will still be a mailbox.  

#### Answer 3 (score 2)
The answer is  

<blockquote class="spoiler">
  <strong>NOTHING</strong>  
</blockquote>

Because:  

<blockquote class="spoiler">
  if you remove "G", it becomes "NOTHIN" which has the same meaning, nothing. Remove N, it becomes "NOTHI" which means nothing. "I", "NOTH", which means nothing. "H", "NOT", which arguably does not make sense in this context. "T", "NO", somewhat similar. "N", nothing big.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: How do I solve the world's hardest sudoku? (score [34325](https://stackoverflow.com/q/252) in 2017)

#### Question
This question is posted under the guidelines <a href="https://puzzling.meta.stackexchange.com/questions/3/is-it-on-topic-to-present-specific-logic-puzzles-or-brainteasers-as-questions"><strong>Don't worry too hard about restricting or regulating anything that isn't turning into a problem yet.</strong></a> If you don't agree that this question is on topic, <a href="https://puzzling.meta.stackexchange.com/questions/3/is-it-on-topic-to-present-specific-logic-puzzles-or-brainteasers-as-questions"><strong>please go to that meta thread</strong></a> and talk about why you feel that way!*  

Solve this Sudoku. Post how you did it in your answer. Enjoy!  

<img src="https://i.stack.imgur.com/IA61i.jpg" alt="8..........36......7..9.2...5...7.......457.....1...3...1....68..85...1..9....4..">  

Note: I put this program into the solver on <a href="http://www.sudokuwiki.org/sudoku.htm" rel="nofollow noreferrer">sudokuwiki.org</a> and it couldn't find any numbers. I then gave it cell H7 (the only cell with two possibilities) and still no luck. Then I gave it cell G7 (which became the only cell with two possibilities) and it was only able to solve one cell before it got stuck.  

<a href="http://aisudoku.com/index_en.html" rel="nofollow noreferrer">Here's the website of the mathematician who discovered this puzzle.</a>  

#### Answer accepted (score 18)
Guessing single values in a depth-first search is sub-optimal.   

So, here is a reasoning chain based on a breadth-first hypothesis/disproof method (which my stepson reluctantly calls "educated guessing").  

Just following the chain including contradictions requires to solve 23 variants of the sudoku, so it's best used with a computer aided solver. However, it does not require any fancy algorithms to follow it. (I use my own home grown unoptimized python program, so there is no real computing power involved either).  

The notation follows spreadsheet conventions (column = letter, row = number) (or chess if you will).  

```text
STA Original Sudoku G8: 3,9
HYP # I8: 3,9
DIS # I8: 3,9 # B1: 1,2 => CTR => B1: 6
STA # I8: 3,9 + B1: 6
DIS # I8: 3,9 + B1: 6 # A2: 1,2 => CTR => A2: 5,9
STA # I8: 3,9 + B1: 6 + A2: 5,9
DIS # I8: 3,9 + B1: 6 + A2: 5,9 # B5: 1,2 => CTR => B5: 3,8
DIS # I8: 3,9 + B1: 6 + A2: 5,9 + B5: 3,8 => CTR => I8: 2,7
STA I8: 2,7
HYP I8: 2,7 # G7: 5
DIS I8: 2,7 # G7: 5 # G4: 6 => CTR => G4: 1,8
STA I8: 2,7 # G7: 5 + G4: 1,8
DIS I8: 2,7 # G7: 5 + G4: 1,8 # C5: 2,9 => CTR => C5: 6
STA I8: 2,7 # G7: 5 + G4: 1,8 + C5: 6
DIS I8: 2,7 # G7: 5 + G4: 1,8 + C5: 6 # H3: 4,5 => CTR => H3: 8
DIS I8: 2,7 # G7: 5 + G4: 1,8 + C5: 6 + H3: 8 => CTR => G7: 3,9
STA I8: 2,7 + G7: 3,9
HYP I8: 2,7 + G7: 3,9 # A8: 3,4,6
DIS I8: 2,7 + G7: 3,9 # A8: 3,4,6 # A9: 3 => CTR => A9: 6,7
STA I8: 2,7 + G7: 3,9 # A8: 3,4,6 + A9: 6,7
DIS I8: 2,7 + G7: 3,9 # A8: 3,4,6 + A9: 6,7 # D7: 2,7 => CTR => D7: 4,9
STA I8: 2,7 + G7: 3,9 # A8: 3,4,6 + A9: 6,7 + D7: 4,9
PRF I8: 2,7 + G7: 3,9 # A8: 3,4,6 + A9: 6,7 + D7: 4,9 => SOL
```

I have put up screen shots of the steps and a quick explanation of the method at <a href="http://sw-amt.ws/sudoku/level-hard/xx-world-hardest-sudoku.html">World's Hardest Sudoku</a>. Since I am only interested in solving hard puzzles by "educated guessing", I found that this sudoku is actually not so hard as advertised (1 level of hypothesis + 1 lookahead = 2 levels of hypotheses). In fact, I have not yet found a sudoku that requires more than 2 levels of hypotheses + one lookahead (= 3 levels of hypotheses).  

#### Answer 2 (score 13)
For this puzzle, while it has one and only one solution, no known patterns work on it, other than a slightly more intelligent guess-and-check. The number of steps one has to look ahead in order to reduce away clues is the metric here, and this puzzle needs nine sequential guesses to reach a solvable state.   

The solver on SudokuWiki can't get it because it would simply take too long to do in Javascript, and it's not programmed to guess numbers.   

The solution requires one to assume the values of squares, and then reduce the puzzle to see if you need more assumptions - if you do, make another one and continue. It is a depth-first-search of the possible solutions, in essence. The solver on <a href="http://www.sudoku-solutions.com/" rel="noreferrer">sudoku-solutions</a> does come up with the solution to this puzzle, but when asked to provide the steps, declares:  

<blockquote>
  <strong>This solver could not solve the puzzle completely by logic, this does not mean there is not a logical solution.</strong>  
</blockquote>

and then promptly fails to list <em>any</em> of the steps it used to solve it. This only happens when the solver must use brute-force branching guessing to find the solution.  

As a result, there is no way I myself could reasonably provide a "how to solve this puzzle" answer, since doing so would involve finding these specific chains and explaining why the other vast quantity of chains don't work.  

But that's how you do it: assume a square is a number, then another, then another, and keep checking until you've come to a sequence that still makes sense and allows you to solve the puzzle, or you've come to a contradiction and need to back up and try again. I'm afraid I think this is the best answer you can get to this question.   

Since you did ask for a solution to the puzzle, however, I can provide it (mouseover the spoiler block):  

<blockquote class="spoiler">
   <img src="https://i.stack.imgur.com/11Rin.png" alt="enter image description here">  
</blockquote>

#### Answer 3 (score 1)
Download the <a href="http://arstechnica.com/information-technology/2015/05/prime-minister-of-singapore-shares-his-c-code-for-sudoku-solver/" rel="nofollow">prime minister of Singapore's Sudoku solver</a> and feed it this puzzle (ONLY if you're REALLY stuck). Believe it or not, that prime minister made a pretty robust program, and although it looks like it gets stuck for a while there, it eventually comes out with the following solution:  

<blockquote class="spoiler">
  <p>862 || 751 || 349<br>
943 || 628 || 157<br>
571 || 493 || 286<br>
============<br>
159 || 387 || 624<br>
386 || 245 || 791<br>
724 || 169 || 835<br>
============<br>
217 || 934 || 568<br>
438 || 576 || 912<br>
695 || 812 || 473  </p>
</blockquote>

Apparently it is possible to solve with logic, though, according to the guy who invented this puzzle. It just took the solvers 24 hours to do it.  

<em>Note: This puzzle has the 1 on the 7th line in a different position as the question's. This puzzle has multiple solutions.</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Create all numbers from 0-100 only using all of 1,2,3,4 and 5 (score [34121](https://stackoverflow.com/q/50167) in 2017)

#### Question
Create all numbers from 0-100 only using 1,2,3,4 and 5. No repeats and you have to use each number. Also, you can use any operation. I've only gotten to 50 by pure brute force. I think that this might be fun for you puzzlers!  

Also, could someone please help with tags and wording of this puzzle. I know this is similar <a href="https://puzzling.stackexchange.com/questions/40339/expressing-numbers-using-0-1-2-3-and-4">Expressing numbers using 0, 1, 2, 3, and 4</a> but I'm still posting this.  

Note: You may not use concatenation to combine digits. Ex 1 and 2 to get 21 or 12  

#### Answer accepted (score 51)
<blockquote>
  Also, you can use any operation.  
</blockquote>

Ok then.  

<p>$\begin{array}{c|c}
0 &amp; \log_{\frac1 2} \left( \log_{4!!-3} 5 \right) \\
1 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt 5 \right) \\
2 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt{\sqrt 5\,} \right) \\
3 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt{\sqrt{\sqrt 5\,}\,} \right) \\
4 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt{\sqrt{\sqrt{\sqrt 5\,}\,}\,} \right) \\
5 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt{\sqrt{\sqrt{\sqrt{\sqrt 5\,}\,}\,}\,} \right) \\
6 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt 5\,}\,}\,}\,}\,} \right) \\
7 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt 5\,}\,}\,}\,}\,}\,} \right) \\
8 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt 5\,}\,}\,}\,}\,}\,}\,} \right) \\
9 &amp; \log_{\frac1 2} \left( \log_{4!!-3} \sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt{\sqrt 5\,}\,}\,}\,}\,}\,}\,}\,} \right) \\
\\
\vdots &amp; \vdots
\end{array}$</p>

<hr>

<blockquote>
  would you mind running me through this solution?  
</blockquote>

This is because for <em>any</em> number $x$ (and in my examples, $4!!-3=5$)  

$$\log_\frac12\left[\log_x\\underbrace{\sqrt{\sqrt{\dots\sqrt{x\,}\,}\,}}_\text{n square roots}\right]\equiv n$$  

And the reason this is true  

<p>$$
\begin{align}
&amp; a^b=c\implies \log_a c = b \\
&amp; \sqrt x = x^{\frac12} \\
&amp; \sqrt{\sqrt x} = x^{\frac14} \\
&amp; \sqrt{\sqrt{\sqrt x}} = x^{\frac18} \\
\vdots \\
&amp; \log_x \sqrt{\sqrt x} = \frac14 \\
&amp; \log_\frac12 \left[ \log_x \sqrt{\sqrt x} \right] = \log_\frac12 \left(\frac14\right) = 2 \impliedby \left(\frac12\right)^2=\frac14
\end{align}
$$</p>

See what happens when you add another square root.  

#### Answer 2 (score 38)
<p>$\begin{align}
0 &amp; = (1 + 2 - 3) \times (4 + 5) \\  
1 &amp; = 1 + (2+3-5) \times 4 \\
2 &amp; = 2 + (1+3-4) \times 5 \\
3 &amp; = 1 -2+3-4+5 \\
4 &amp; = 1 \times (2+3-5) + 4 \\
5 &amp; = 1-2-3+4+5 \\
6 &amp; = 5+1 \times (2+3-4) \\
7 &amp; = 5+2 \times (4-3) \times 1 \\
8 &amp; = 5+3 \times (4-2-1) \\
9 &amp; = 5+3 + (4-2-1) \\
10 &amp; = 5+4 + (3-2) \times 1 \\
11 &amp; = 5+4 + (3-2) + 1 \\
12 &amp; = 5+4+3 \times (2-1) \\
13 &amp; = 5+4+3 + 2-1 \\
14 &amp; = 5+4+3 + 2 \times 1 \\
15 &amp; = 5+4+3 + 2 + 1 \\
16 &amp; = 5+3 + 4 \times 2 \times 1 \\
17 &amp; = 5+3 + 4 \times 2 + 1 \\
18 &amp; = 5 + 4 + 3 ^ 2 \times 1 \\
19 &amp; = 5 + 4 + 3 ^ 2 + 1 \\
20 &amp; = 5 \times 4 \times (3 - 2) \times 1 \\
21 &amp; = 5 \times 4 \times (3 - 2) + 1 \\
22 &amp; = 5 \times 4 + 3 - 2 + 1 \\
23 &amp; = 5 \times 4 + 3 \times (2 - 1) \\
24 &amp; = 5 \times 4 + 3 + (2 - 1) \\
25 &amp; = 5^{4-3+2-1} \\
26 &amp; = (5 + 4 + 3 + 1) \times 2 \\
27 &amp; = 3 \times (4-1) \times (5-2) \\
28 &amp; = (5\times 3 - 1) \times \frac{4}{2} \\
29 &amp; = 5 \times 3 \times \frac{4}{2} - 1 \\
30 &amp; = 5 \times 3 \times \frac{4}{2} \times 1 \\
31 &amp; = 5 \times 3 \times \frac{4}{2} + 1 \\
32 &amp; = 2^5 + 4 -3 - 1 \\
33 &amp; = 2^5 + 4 - 3 \times 1 \\
34 &amp; = 2^5 + 4 - 3 + 1 \\
35 &amp; = (3 + 4) \times 5 \times (2-1) \\
36 &amp; = (3 + 4) \times 5 + (2-1) \\
37 &amp; = 2 \times 4 \times 5 - 3 \times 1 \\
38 &amp; = 2 \times 4 \times 5 - 3 + 1 \\
39 &amp; = (5 + 4 \times 2 ) \times 3 \times 1 \\
40 &amp; = (5 + 4 \times 2 ) \times 3 + 1 \\
41 &amp; = (4 + 5 \times 2 ) \times 3 - 1 \\
42 &amp; = (4 + 5 \times 2 ) \times 3 \times 1 \\
43 &amp; = (4 + 5 \times 2 ) \times 3 + 1 \\
44 &amp; = (1+2+3+5) \times 4 \\
45 &amp; = 3 \times 5 \times (4 - 2 +1) \\
46 &amp; = (5 \times 4 + 3 ) \times 2 \times 1 \\
47 &amp; = (5 \times 4 + 3 ) \times 2 + 1 \\
48 &amp; = 2^4 \times (5-3+1) \\
49 &amp; = (5+2) \times (4+3) \times 1 \\
50 &amp; = (5+2) \times (4+3) + 1 \\
51 &amp; = (5 \times 4 - 3) \times (2+1) \\
52 &amp; = (3 \times 5 - 2) \times 4 \times 1 \\
53 &amp; = (3 \times 5 - 2) \times 4 + 1 \\
54 &amp; = (5 \times 4 - 2) \times 3 \times 1 \\
55 &amp; = (5 \times 4 - 2) \times 3 + 1 \\
56 &amp; = (5+3 -1) \times 4^2 \\
57 &amp; = (5 \times 4 \times 3)  -2 -1 \\
58 &amp; = (5 \times 4 \times 3)  -2 \times 1 \\
59 &amp; = (5 \times 4 \times 3)  -2 +1 \\
60 &amp; = (5 \times 4 \times 3)   \times (2 -1) \\
61 &amp; = (5 \times 4 \times 3)  + 2 - 1 \\
62 &amp; = (5 \times 4 \times 3)  + 2 \times  1 \\
63 &amp; = (5 \times 4 \times 3)  + 2 + 1 \\
64 &amp; = 2^5 \times (4-3) \times 1 \\
65 &amp; = 2^5 \times (4-3) + 1 \\
66 &amp; = 2^5 + 4-3+1 \\
67 &amp; = 4! \times 3 - 5 \times (2-1) \\
68 &amp; = 4! \times 3 - 5 + (2-1) \\
69 &amp; = (4+3) \times 5 \times 2 -1 \\
70 &amp; = (4+3) \times 5 \times 2 \times 1 \\
71 &amp; = (4+3) \times 5 \times 2 + 1 \\
72 &amp; = 4! \times (5-2) \times 1^3 \\
73 &amp; = 4! \times (5-2) + 1^3 \\
74 &amp; = 5^2 \times 3 - 1^4 \\
75 &amp; = 5^2 \times 3 \times 1^4 \\
76 &amp; = 5^2 \times 3 + 1^4 \\
77 &amp; = 4! \times 3 + 5 \times 1^2 \\
78 &amp; = 4! \times 3 + 5 + 1^2 \\
79 &amp; = 4! \times 3 + 5 + 2 \times 1 \\
80 &amp; = 4! \times 3 + 5 + 2 + 1 \\
81 &amp; = 3^{4-1} \times (5-2) \\
82 &amp; = 4! \times 3 + 5 \times 2 \times 1 \\
83 &amp; = 4! \times 3 + 5 \times 2 + 1 \\
84 &amp; = 3^4 + 5 - 2 \times 1 \\
85 &amp; = 3^4 + 5 - 2 + 1 \\
86 &amp; = 3^4 + 5 \times 1^2 \\
87 &amp; = 3^4 + 5 + 1^2 \\
88 &amp; = 3^4 + 5 +2^1 \\
89 &amp; = 3^4 + 5 + 2 + 1 \\
90 &amp; = 3^2 \times 5  \times 2^1 \\
91 &amp; = 3^2 \times 5  \times 2 + 1 \\
92 &amp; = 3^4 + 5 \times 2 + 1 \\
93 &amp; = 2^5 \times 3 +1 - 4 \\
94 &amp; = 5^2 \times 4 - 3! \times 1 \\
95 &amp; = 5^2 \times 4 - 3! + 1 \\
96 &amp; = 5^2 \times 4 - 3 - 1 \\
97 &amp; = 5^2 \times 4 - 3 \times 1 \\
98 &amp; = 5^2 \times 4 - 3 + 1 \\
99 &amp; = 5^2 \times 4 -1^3 \\
100 &amp; = 5^2 \times 4 \times 1^3
\end{align}$</p>

Someone please double check it.    

#### Answer 3 (score 17)
<p>$ 0 =  3^2 \times 1 - 4 - 5 $<br>
$ 1 = 3^2 + 1 - 4 - 5 $<br>
$ 2 = (4 - 5 + 3)/ 1^2 $<br>
$ 3 = (5 + 4) \times 1 - 2 \times 3 $<br>
$ 4 = (5 + 3) \times 1^2 - 4 $<br>
$ 5 = 5 \times 2 - 4 - 1^3 $<br>
$ 6 = 3 \times 2 + 5 - 1 - 4 $<br>
$ 7 = 5 \times 2 - 3 \times 1^4 $<br>
$ 8 = 4 + 5 - 3 + 2^1 $<br>
$ 9 = 3^2 - 4 - 1 + 5 $<br>
$ 10 = 5 \times 2 - 4 + 1 + 3 $<br>
$ 11 = 5 + 3 + 4 - 1^2 $<br>
$ 12 = 4 \times 5 \times 1 - 2^3 $<br>
$ 13 = 4 \times 5 - 1 - 3 \times 2 $<br>
$ 14 = 4 \times 5 - 3 \times 2 \times 1 $<br>
$ 15 = 1 + 2 + 3 + 4 + 5 $<br>
$ 16 = 4 + 5 + 2 \times 3 + 1 $<br>
$ 17 = 5 + 3 + 2 \times 4 + 1 $<br>
$ 18 = 5 + 4 + 1 + 2^3 $<br>
$ 19 = 5 + 4 + 1 + 3^2 $<br>
$ 20 = 5 \times 4 - 3 + 2 + 1 $<br>
$ 21 = 5 \times 4 + 3 - 2 \times 1 $<br>
$ 22 = 5 \times 4  + 3 - 2 + 1 $<br>
$ 23 = 4 \times 3 + 5 \times 2 + 1 $<br>
$ 24 = 5 \times 4 + 2 \times (3 - 1) $<br>
$ 25 = 5 \times 4 + 3 + 2 \times 1 $<br>
$ 26 = 5 \times 4 + 3 + 2 + 1 $<br>
$ 27 = 5 \times 4 + 3 \times 2 + 1 $<br>
$ 28 = 5 \times 4 \times 1 + 2^3 $<br>
$ 29 = 5 \times 4 \times 1 + 3^2 $<br>
$ 30 = 5 \times 4 + 3^2 + 1 $<br>
$ 31 = 5 \times (4 + 2) + 1^3 $<br>
$ 32 = 5 \times (4+2) + 3 - 1 $<br>
$ 33 = 5 \times (4+2) + 3 \times 1 $<br>
$ 34 = 5 \times (4+2) + 3 + 1 $<br>
$ 35 = 5 \times 3 \times 2 + 4 + 1 $<br>
$ 36 = 5 \times (4+2) \times 1 + 3! $<br>
$ 37 = 5 \times (4+2) + 3! + 1 $<br>
$ 38 = 4! + 2 \times 5 + 3 + 1 $<br>
$ 39 = 2^5 + 4 + 3 \times 1 $<br>
$ 40 = 2^5 + 4 + 3 + 1 $<br>
$ 41 = 5 \times 2^3 + 1^4 $<br>
$ 42 = 5 \times 3^2 + 4 - 1 $<br>
$ 43 = 5 \times 2^3 + 4 - 1 $<br>
$ 44 = 5 \times 2^3 + 4 \times 1 $<br>
$ 45 = 5 \times 2^3 + 4 + 1 $<br>
$ 46 = 5 \times 4 \times 2 \times 1 + 3! $<br>
$ 47 = 5 \times 3(4 - 1) + 2 $   or $ 5 \times 4 \times 2 + 1 + 3! $<br>
$ 48 = 4! \times 2 \times 1^3 $<br>
$ 49 = 4! \times 2 + 1^{3+5} $<br>
$ 50 = 4! \times 2 + 3 - 1^5 $ or $ 5 \times (4+3+2+1) $<br>
$ 51 = 4! \times 2 \times 1^5 + 3 $<br>
$ 52 = 4! \times 2 + 3 + 1^5 $<br>
$ 53 = 4! \times 2 + 5 \times 1^3 $<br>
$ 54 = 4! \times 2 + 5 + 1^3 $<br>
$ 55 = 4! \times 2 + 5 + 3 - 1 $<br>
$ 56 = 4! \times 2 + 5 + 3 \times 1 $<br>
$ 57 = 5 \times 4 \times 3 - 1 - 2 $ or $ 4! \times 2 + 5 + 3 + 1 $<br>
$ 58 = 5 \times 4 \times 3 - 2 \times 1 $<br>
$ 59 = 5 \times 4 \times 3 - 2 + 1 $<br>
$ 60 = 5 \times 4 \times 3 \times 1^2 $<br>
$ 61 = 5 \times 4 \times 3 - 1 + 2 $<br>
$ 62 = 5 \times 4 \times 3 + 2 \times 1 $<br>
$ 63 = 5 \times 4 \times 3 + 1 + 2 $<br>
$ 64 = 2^5  \times  (4 - 3 + 1) $<br>
$ 65 = 4! \times 3 - 5 - 2 \times 1 $<br>
$ 66 = 4! \times 3 - 5 - 2 + 1 $<br>
$ 67 = 4! \times 3 - 5 \times 1^2 $<br>
$ 68 = 4! \times 3 - 5 - 1 + 2 $<br>
$ 69 = 4! \times 3 - 5 + 2 \times 1 $<br>
$ 70 = 4! \times 3 - 5 + 2 + 1 $<br>
$ 71 = 4! \times 3 - 1^{5+2} $<br>
$ 72 = 4! \times 3 \times 1^{5+2} $<br>
$ 73 = 4! \times 3 + 1^{5+2} $<br>
$ 74 = 4! \times 3 + 2 \times 1^5 $<br>
$ 75 = 4! \times 3 \times 1 + 5 - 2 $<br>
$ 76 = 4! \times 3 + 5 - 2 + 1  $<br>
$ 77 = 4! \times 3 + 5 \times 1^2 $<br>
$ 78 = 4! \times 3 + 5 + 1^2 $<br>
$ 79 = 4! \times 3 + 5 + 2 \times 1 $<br>
$ 80 = 4! \times 3 + 5 + 2 + 1 $<br>
$ 81 = 4! \times 3 + 5 \times 2 - 1 $<br>
$ 82 = 4! \times 3 + 5 \times 2 \times 1 $<br>
$ 83 = 4! \times 3 + 5 \times 2 + 1 $<br>
$ 84 = 3^4 + 5 - 2 \times 1 $<br>
$ 85 = 3^4 + 5 - 1^2 $<br>
$ 86 = 3^4 + 5 \times 1^2 $<br>
$ 87 = 3^4 + 5 + 1^2 $<br>
$ 88 = 3^4 + 5 + 2 \times 1 $<br>
$ 89 = 3^4 + 5 + 2 + 1 $<br>
$ 90 = 3^4 + 5 \times 2 - 1 $<br>
$ 91 = 3^4 + 5 \times 2 \times 1 $<br>
$ 92 = 3^4 + 5 \times 2 + 1 $<br>
$ 93 = 4! \times (3 + 1) - 5 + 2 $<br>
$ 94 = 4! \times (5 - 1^3) - 2 $<br>
$ 95 = 4! \times (5 + 3)/2 - 1 $<br>
$ 96 = 4! \times 1 \times (5+3)/2 $<br>
$ 97 = 4! \times (5+3)/2 + 1 $<br>
$ 98 = 4! \times (5-1^3) + 2 $<br>
$ 99 = 4! \times (5-1^2) + 3 $<br>
$ 100 = 5 \times 4 \times (3+2) \times 1 $<br>
$ 101 = 5 \times 4 \times (3+2) + 1 $</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: What color was the bear (score [33846](https://stackoverflow.com/q/3668) in 2016)

#### Question
This is an old one but I don't see it here.  

A man stepped out of his tent with his rifle and walked 1 mile south, 1 mile east and 1 Mile north.  Then he shot a bear in front of his tent.    

What color was the bear?  

#### Answer accepted (score 6)
<blockquote class="spoiler">
   The bear is white. The hunter was hunting at the North Pole (no idea why though...)  
</blockquote>

The reason it had to have been there is because that is one of the few (if not the only) places on earth that match the criteria, and will only have the one type-coloured bear.  

#### Answer 2 (score 7)
Black, because the bear was a polar bear and polar bears are black underneath the fur.  

#### Answer 3 (score 6)
<blockquote class="spoiler">
   The bear is white. The hunter was hunting at the North Pole (no idea why though...)  
</blockquote>

The reason it had to have been there is because that is one of the few (if not the only) places on earth that match the criteria, and will only have the one type-coloured bear.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: I can't die. Who am I? (score [33684](https://stackoverflow.com/q/80219) in 2019)

#### Question
I meet many people.  

I treat them equal.  

I can harvest grain the middle age way.  

I always go on, I never stay.  

I can't die.  

Some believe I can fly.  

Most people don't like me.  

And thus try to fight me.  

Most people don't want me to touch them.  

Some mad people want me to rush them.  

There is no proof that I exist.  

But what I do can't be dismissed.  

Who am I?  

#### Answer accepted (score 60)
I think you might be  

<blockquote class="spoiler">
   <a href="https://en.wikipedia.org/wiki/Death_(personification)" rel="noreferrer">The Grim Reaper</a> (Angel of Death)  
</blockquote>

<p>I meet many people.<br>
I treat them equal.</p>

<blockquote class="spoiler">
   Many people die every day, death comes equally for all  
</blockquote>

I can harvest grain the middle age way.  

<blockquote class="spoiler">
   The Reaper is often depicted as holding a large scythe.  
</blockquote>

<p>I always go on, I never stay.<br>
I can't die.</p>

<blockquote class="spoiler">
   Death itself cannot die.  
</blockquote>

Some believe I can fly.  

<blockquote class="spoiler">
   According to the Midrash, the Angel of Death was created by God on the first day. His dwelling is in heaven, whence he reaches earth in eight flights  
</blockquote>

Most People don't like me.  

<blockquote class="spoiler">
   Not many people want to die (meet the reaper)  
</blockquote>

And thus try to fight me.  

<blockquote class="spoiler">
   Many will try to avoid death for as long as possible  
</blockquote>

<p>Most people don't want me to touch them.<br>
Some mad people want me to rush them.</p>

<blockquote class="spoiler">
   Not sure but perhaps those with a deathwish.  
</blockquote>

There is no proof that I exist.  

<blockquote class="spoiler">
   This is just a personification based on belief.  
</blockquote>

But what I do cant be dismissed.  

<blockquote class="spoiler">
   Death is constantly observed  
</blockquote>

Who am I?  

#### Answer 2 (score 27)
Who am I?  

<blockquote class="spoiler">
  You are Time.  
</blockquote>

I meet many people.  

<blockquote class="spoiler">
  Time meets everyone, every time  
</blockquote>

I treat them equal.  

<blockquote class="spoiler">
  Time never act differently with anyone.  
</blockquote>

I can harvest grain the middle age way.  

<blockquote class="spoiler">
  Do not know. Actually, do not understood what that mean.  
</blockquote>

I always go on, I never stay.  

<blockquote class="spoiler">
  Obviously; isn't it?  
</blockquote>

I can't die.  

<blockquote class="spoiler">
  Time never <em>start</em> and never it does <em>end</em>. In other words, it never born and never die. By the way, quantum physics does not agree with me. It says, time was <em>created</em> while big bang; before that, there was no time. Also that time will end when entire universe will again convert in small dot of energy. Anyway, we are not discussing physics here.  
</blockquote>

Some believe I can fly.  

<blockquote class="spoiler">
  Time <em>flies</em> so quickly when we are happy, with loved ones.  
</blockquote>

Most people don't like me.  

<blockquote class="spoiler">
  Those who are in bad conditions, difficulties do not like <em>current</em> time. They want it to be passed quickly.  
</blockquote>

And thus try to fight me.  

<blockquote class="spoiler">
  As said above, they do not like it. They try hard (fight) to get out of bad times.  
</blockquote>

Most people don't want me to touch them.  

<blockquote class="spoiler">
  Age? Most people like to live young (or kid) all the time.  
</blockquote>

Some mad people want me to rush them.  

<blockquote class="spoiler">
  Not sure but some people like to grow up quickly. Or when in bad time, people want good time should come quickly.  
</blockquote>

There is no proof that I exist.  

<blockquote class="spoiler">
  Time is not visible, not touchable, not smell-able. One cannot prove the existence of time. Physics does; but again, we are not discussing in terms of physics.  
</blockquote>

But what I do can't be dismissed.  

<blockquote class="spoiler">
  Though we cannot prove its existence, we see the incidents happening around us and the history. We cannot dismiss these things and those prove the existence of time.  
</blockquote>

#### Answer 3 (score 14)
are you  

<blockquote class="spoiler">
   the Grim Reaper  
</blockquote>

because  

<p>I meet many people.
I threat them equal.</p>

<blockquote class="spoiler">
   everybody dies  
</blockquote>

I can harvest grain the midlle age way.  

<blockquote class="spoiler">
   you can die young   
</blockquote>

I always go on, I never stay.  

<blockquote class="spoiler">
   death's fast most of the time  
</blockquote>

I can't die.  

<blockquote class="spoiler">
   death can't die, people will always be dying  
</blockquote>

Some believe I can fly.  

<blockquote class="spoiler">
   some representations show the Grim Reaper flying above the floor  
</blockquote>

<p>Most People dont like me.
And thus try to fight me.</p>

<blockquote class="spoiler">
   people don't want to die, and heal themselves when sick  
</blockquote>

<p>Most people don't want me to touch them.
Some mad people want me to rush them.</p>

<blockquote class="spoiler">
   again, most people don't wanna die but some jackasses don't care doing potentially lethal stuff  
</blockquote>

There is no proof that I exist.  

<blockquote class="spoiler">
   Death sure exists, but the Grim Reaper as shown in popular believes don't   
</blockquote>

But what I do cant be dismissed.  

<blockquote class="spoiler">
   you can't revive people  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How to swap two opposite corner pieces of a solved face? (score [33489](https://stackoverflow.com/q/40225) in 2016)

#### Question
I have a solved white face but I want to swap two opposite corner pieces of the white face to form a T-shape on the back face. How can I achieve this without messing up the other pieces on those two faces?  

#### Answer accepted (score 4)
As far as I can tell from the question so far it would appear that you mean you have solved the white face (`U`) and have all of the first layer - the ring around that face is all of the correct colour - except for to opposite corner cubies like so, or a mirror image (or colour change):  

<a href="https://i.stack.imgur.com/cFIYb.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/cFIYb.png" alt="enter image description here"></a>  

...and you want to swap these two without changing the ring except at those cubies (thus fully solving the top layer).  

This is quite easily remedied by just using the bottom layer, one quick way would be to perform:  

`R2 F' R2 D2 R2 F R2` - <a href="https://en.wikipedia.org/wiki/Rubik%27s_Cube#Solutions" rel="nofollow noreferrer">Singmaster notation</a>  

The first three moves will set the two corners onto opposite locations in the bottom layer with everything else out of the way; the `D2` swaps them; and the last three put everything back again.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Make 24 With 7,3,7,3 (score [33224](https://stackoverflow.com/q/9053) in 2015)

#### Question
You may use math signs you wish, but you must use the numbers  

<blockquote>
  7,3,7,3  
</blockquote>

in an equation so it equals  

<blockquote>
  24  
</blockquote>

Is it possible? If so, show how.  

<strong>No-nos:</strong>  

<ul>
<li>You are not allowed to combine numbers to make bigger numbers (<em>e.g.</em> you can't have 73)</li>
<li>You cannot use numbers more than once, you only have <strong>2 7s</strong> and <strong>2 3s</strong></li>
<li>You have to use all the numbers given to you.</li>
</ul>

<strong>What is a math sign? Examples: +, -, *, /, (, )</strong>  

#### Answer accepted (score 8)
<blockquote>
  <p>(3/7+3)*7 =24<br>
  => (3/7 + 21/7) * 7 =24<br>
  => (24/7) * 7 =24<br>
  => 24=24 </p>
</blockquote>

Took me a while!  

#### Answer 2 (score 6)
<strong>Answer</strong>  

<blockquote class="spoiler">
   $$((7/7)+3)*(3!) = 4*(3!) = 24 $$  
</blockquote>

#### Answer 3 (score 3)
There's an implied $1$, but I didn't actually write it:  

<blockquote class="spoiler">
   $7 \times 3 + 3 + \int_{\{7\}}dx$  
</blockquote>

And here's another solution (I think you can argue that $7$ is used twice):  

<blockquote class="spoiler">
   $7 \times 3 - 3 = 24$ in base $7$  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Rubik's cube with one disoriented corner (score [32771](https://stackoverflow.com/q/32740) in )

#### Question
<p>I have been trying to solve Rubik's cube using beginner's method provided here:
<a href="https://ruwix.com/the-rubiks-cube/how-to-solve-the-rubiks-cube-beginners-method/" rel="nofollow noreferrer">https://ruwix.com/the-rubiks-cube/how-to-solve-the-rubiks-cube-beginners-method/</a> </p>

I ended up with just one last corner which is not oriented properly as shown in the picture. I cannot seem to solve it using R’ D’ R D algorithm, it messes up the whole square when the corner piece gets oriented. Every time I try to solve the cube, it again has just one last corner disoriented. None of the algorithms mention one last corner case. they always talk about 2 or more corners disoriented. I don't understand. Can someone explain whats happening and how to solve it?  

<a href="https://i.stack.imgur.com/rPbhz.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/rPbhz.jpg" alt="one last corner not oriented properly"></a>  

#### Answer accepted (score 3)
You can't. Your cube is in an unsolvable state. You must take apart the cube and fix the corner. This happened because one piece was put in improperly. You can either flip one other piece or flip the disoriented piece  

Someone pranked you  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Is it possible to use one sequence of moves to solve the Rubik's cube from any position? (score [32200](https://stackoverflow.com/q/4820) in 2014)

#### Question
Is there a sequence of moves that can be repeated over and over again which can solve any legal position the Rubik's Cube? If so what is it, and if there's more than one, what's the shortest? If not, prove that it's impossible.  

<em>The sequence can be of any length but cannot be broken up into multiple pieces to be executed depending on Rubik's cube patterns; it must, when repeated from start to finish, end in a perfectly solved Rubik's cube.</em>  

#### Answer accepted (score 17)
The only way you can have a solve-all sequence is if you have a sequence of moves that goes through all 43 quintillion configurations of the Rubik's Cube. In order to do this, you need to draw a transition graph between all the states of the Rubik's Cube and find a Hamiltonian cycle through them.  

This sequence of moves doesn't necessarily have to be 43 quintillion moves long - a simple sequence of 4 moves can produce a cycle of 1,260 configurations as seen in mdc32's answer, and in general a sequence of symbols in the group will produce a cycle of configurations much longer than the cycle itself. However, the sequence will still be very long, simply because 43 quintillion moves is still a lot.  

Micah provided <a href="http://bruce.cubing.net/ham333/rubikhamiltonexplanation.html">a link</a> to a page that did construct such a Hamiltonian cycle in a comment. I haven't been able to make head or tail of its notation (or to figure out how to count the number of moves from the descriptions of the cosets), but it looks like the sequence of moves that is required is billions of moves long, which is still definitely outside of the realm of plausibility for memorization.  

#### Answer 2 (score 5)
<strong>EDIT: This only works in a certain set of configurations, as the loop only goes through 1260 states before returning to the original position. My mistake, this is incorrect, but still useful.</strong>  

Great solution found <a href="http://aperiodical.com/2014/03/how-to-solve-a-rubiks-cube-in-one-easy-step/" rel="nofollow noreferrer">here</a>. Basically, if you rotate the right, back, left, and front faces all clockwise and in order, then it will always solve the cube - eventually. The core part of it is in one simple explanation - doing this cannot enter an inescapable loop.  

If you move the front face clockwise, then counter-clockwise, nothing happens to the cube. The faces are not moved with respect to each other, and you are in the same position. In order for a loop to happen, two different layouts <strong>must</strong> lead to the same configuration with the same move. But wait - if you reverse  this move, then what position does it go to? The simple answer is this will never happen. Here is a great diagram in the article itself. <img src="https://i.stack.imgur.com/9Folm.png" alt="enter image description here">  

As you can see, reversing this loop would not work, as there are two possible options. This is a proof that loops will never happen.  

Moving these four faces is the shortest possible configuration of moves that affects each and every cube, save for the center ones which are irrelevant anyway. This means it is the shortest possible solution that you could repeat to solve the Cube.  

#### Answer 3 (score -2)
<blockquote>
  Is there a sequence of moves that can be repeated over and over again which can solve any position the Rubik's Cube can be scrambled in?  
</blockquote>

This actually depends on how you define "scrambling" a cube. If you mean taking the cube apart and putting it back together with the pieces in random positions, then there is no such sequence. That's simply because <a href="http://ruwix.com/the-rubiks-cube/unsolvable-rubiks-cube-invalid-scramble/" rel="nofollow">most of the possible configurations of a Rubik's cube are unsolvable</a>.  

I don't know about a sequence of moves that can unscramble any solvable configuration.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: I am a computer’s nightmare, but a programmer’s best friend (score [32180](https://stackoverflow.com/q/57727) in 2017)

#### Question
I am a computer’s nightmare, but a programmer’s best friend.  

I am both the cause of a problem and the source of its resolution.  

<strong>What am I?</strong>  

#### Answer accepted (score 119)
How about  

<blockquote class="spoiler">
  <p>Stack Overflow
(the error and <a href="https://stackoverflow.com/">stackoverflow.com</a> at the same time).</p>
</blockquote>

I am a computer’s nightmare,  

<blockquote class="spoiler">
   If I was a computer, I wouldn't like these errors at all. Too much data to keep track of.  
</blockquote>

but a programmer’s best friend  

<blockquote class="spoiler">
   stackoverflow.com is one of the best places to go to if you get stuck while programming, according to <a href="https://github.com/sdmg15/Best-websites-a-programmer-should-visit#when-you-get-stuck" rel="noreferrer">this</a>  
</blockquote>

I am both the cause of a problem  

<blockquote class="spoiler">
   If you get a stack overflow error, you have a problem. There is <a href="https://stackoverflow.com/questions/2535723/try-catch-on-stack-overflows-in-java">not much you can do</a> once this error happens.  
</blockquote>

and the source of its resolution.  

<blockquote class="spoiler">
   You might be able to find help on stackoverflow.com, for example <a href="https://stackoverflow.com/questions/214741/what-is-a-stackoverflowerror">here</a>.  
</blockquote>

#### Answer 2 (score 90)
<blockquote class="spoiler">
  Coffee (or soda)  
</blockquote>

I am a computer’s nightmare,  

<blockquote class="spoiler">
   Ruins a computer if spilled on it  
</blockquote>

but a programmer’s best friend.  

<blockquote class="spoiler">
   Programmers love coffee to keep themselves going  
</blockquote>

I am both the cause of a problem and the source of its resolution.  

<blockquote class="spoiler">
   Coffee causes a problem by fueling overwork, leading to fatigue - which is solved with more coffee  
</blockquote>

#### Answer 3 (score 19)
The answer is  

<blockquote class="spoiler">
   the <a href="https://electronjs.org/" rel="noreferrer">electron framework</a>.   
</blockquote>

I am a computer’s nightmare,  

<blockquote class="spoiler">
   Drains major amounts of resources for simple apps.  
</blockquote>

but a programmer's best friend  

<blockquote class="spoiler">
   Who doesn't like easy GUIs and a single language?  
</blockquote>

I am both the cause of a problem  

<blockquote class="spoiler">
   Poor UX due to lag.  
</blockquote>

and the source of its resolution.  

<blockquote class="spoiler">
   Better UX due to ease of development.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: How did the man hang himself? (score [32179](https://stackoverflow.com/q/15209) in 2015)

#### Question
<sub> <em>This may be simple and fairly well known, but I couldn't find it anywhere here, and felt it deserved a place in the ranks of puzzles</em> </sub>  

A man is found dead, hanging in an empty barn having committed suicide. The base of the barn was 20 feet by 30 feet, and the ceiling was 10 feet above the ground. The rope was 4 feet from the roof to the man's neck, and the man's feet were hanging 1 foot above the ground, and the man was 5 feet from where the rope was around his neck to his toes. The man was hanging from the exact center of the barn. Aside from the man and the rope, there were no other objects in the barn, and the door to the barn was closed and locked from the inside, so no one had come in or out since the deed was done. The barn was structurally sound, with no holes or windows to be found anywhere. The roof was also water tight, but the ground beneath the man was damp. The ladder used to tie the rope up was found outside around the corner (guess he didn't want those that found him to have to move it later). There were no supports or beams along the ceiling of the barn.  

It was determined that the man was too weak to jump and pull himself into the noose, or to climb onto the roof with just his hands. How did he manage to hang himself?  

<sub>Change log: No windows, no holes in the roof. Roof is water tight. Door to the barn was locked from the inside. Damp ground was found under the man </sub>  

#### Answer accepted (score 44)
<strong>Canonical Answer:</strong>  

<blockquote class="spoiler">
   The man stood on a block of ice which has since melted.  
</blockquote>

<hr>

<strong>Non-canonical Answers:</strong>  

<blockquote class="spoiler">
  <p>  1. The man stood on his horse who then took off and is out wandering the fields. (This is in the same category as the ice: "Man stood on $X$ which has since removed itself through means common to things of its type.")<br><br>
  2. If it wasn't for the explicitly stating the ladder was used to hang the rope and implying the general weakness of the man, the man could have thrown the rope over the rafters, tied the ends together, and then climbed into the rafters. He then unties the rope, attaches it to the rafters, and ties a noose. He slips the noose over his head and jumps down.<br><br>
  3. Again, this might be ruined by the weakness, but he could tie it in the rafters with the ladder and then climb the rope, tie the noose, slip it on, and let go of the rope.<br><br>
  4. There is a powerful electromagnet under the floor set on a timer. The man was lifted up his shoes laced with natural magnets oriented to the opposite pole, put the noose around his neck, and waited for the magnet to turn off.<br><br>
  5. If it didn't state that it was suicide, I'd say that someone else hung him up there for cattle thievin'.<br><br>
  6. He was a depressed wizard with the power of levitation.<br><br>
  7. The rope is sentient and strangled its abusive master.<br><br>
  8. The rope was tied around the rafters before the barn was raised. He stood there as his friends and family raised the barn, lifting his body into the air.<br><br>
  9. He used the ladder. It is stated that the ladder was put away but not that the man was the one who put it away. That conclusion is only guessed at. The first person on the scene put the ladder away to make it seem like a murder as they were embarrassed that the man had committed suicide.<br><br></p>
</blockquote>

<hr>

<strong>Answers from the comments:</strong>  

<blockquote class="spoiler">
  <p>  A. He climbed the ladder around the corner of the barn (where it was later found) to the roof, then jumped through the hole in the roof. –  Paul Draper<br><br>
  B. The man was too weak to jump into the noose himself, but he put Flubber on the floor (or his shoes) and jumped on that. –  Paul Draper<br><br>
  C. Ropes with natural fibers can shrink 5-10% when wet. He tied the rope around his neck, and leaky roof cause the once 10ft rope to become 9ft. –  Paul Draper<br><br>
  D. The man dug a pit, tied the noose outside it, and jumped into the pit. –  Paul Draper<br><br></p>
</blockquote>

#### Answer 2 (score 12)
Since a heap of people have offered alternative solutions, I thought I'd provide a few of my own (ones that are relatively plausible, hopefully, compared with "he used flubber" or "he was a wizard with the power of levitation")...  

<blockquote class="spoiler">
  <p> 1. He used a rope made from a special polymer that gets significantly shorter as it cools. It was warm when he put it around his neck, and as it cooled, it pulled his body off the ground.<br>
<br>
 2. He used a second rope to assist him, but also carried a match, and burned the support rope (which was supporting enough of his weight - remove the support rope, and his full weight goes onto the noose). The ashes of the match and the support rope have since spread thinly enough in the barn that they're indistinguishable from the dirt.<br>
<br>
 3. He used hay as a substitute for some rope to help him, and the hay has since broken off and dropped back to the floor of the barn - nobody would have suspected that some of the stray hay in the barn was actually used in the suicide.</p>
</blockquote>

And now for some more entertaining answers (that are still hopefully a little more plausible than some of the answers):  

<blockquote class="spoiler">
  <p> 4. He had a severe hunch in his back - he was capable of straightening it out if he really tried, but when he relaxed it would go back to the hunched position. He stretched to reach the noose, then relaxed again.<br>
<br>
 5. He committed suicide during an extreme storm, during which the ceiling sagged from the rain and the walls tilted due to the wind (not the most structurally sound barn around, I grant you, but it stayed standing, so it didn't do too badly). These two effects combined to lower the centre of the ceiling far enough that the man could reach the noose. As the wind died down, his feet were raised just far enough to hang him. Over the next couple of days the wetness of the roof evaporated and the ceiling's sag reverted, restoring the barn to its original dimensions, thus further lifting the man's feet.<br>
<br>
 6. There was a large ant nest in the centre of the barn, with a mound over a foot tall. The man detested ants at the same time, so he chose that spot - he would put his weight on the mound, causing the ant tunnels to collapse, and in the process hang himself.<br>
<br>
 7. The barn originally had wooden floorboards in the centre as a kind of stage. However, it was infested by termites. The man committed suicide, the floorboards collapsed enough to hang him, and then the termites finished the job. They're probably already working on the walls. The person who discovered the body probably heard the faint scratching noise of them termites working away, but figured it was the guy's ghost come back to haunt the barn.<br>
<br>
 8. There had been a huge flood. The man had used the ladder as support while positioning the rope in the perfect place to grab as he tried to surf on the flowing water. Unfortunately, he misjudged it, and instead of his hands catching the rope, his head went through it. The force of the water caused the man to be hanged, and later the floodwaters receded, leaving him hanging out to dry, so to speak. Oh, and the floodwaters also forced the doors shut, where the auto-locking mechanism triggered.</p>
</blockquote>

And now for something completely different:  

<blockquote class="spoiler">
  <p> 9. Aliens. It's always aliens.<br>
<br>
 10. Thanks, Obama!<br>
<br>
 11. The man was a rare male spirit medium from the Fey clan. He was channelling a taller man he hadn't realised was a sociopath, who proceeded to use his body (currently shaped to match the possessing spirit's original body's shape) to "commit suicide", thereby killing the medium. It was simple - set things up, position his head in the noose, then leave the medium's body, which would immediately revert to its normal shape, thereby hanging the medium.<br>
<br>
 12. The man in the barn was Mario, and he had used a super mushroom to get bigger (becoming Super Mario). But he also had a poison mushroom in his possession - on positioning himself, he ate the poison mushroom to revert to normal, resulting in his hanging.</p>
</blockquote>

#### Answer 3 (score 9)
<blockquote class="spoiler">
   The rope was made of <a href="http://en.wikipedia.org/wiki/Shape-memory_alloy">shape-memory alloy</a>. The man tied it up during night when it was cool. The heat at daytime caused the rope to shorten, pulling him off the ground.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: I Can Only Live Where There is Light (score [32127](https://stackoverflow.com/q/56147) in )

#### Question
I can only live where there is light, but I die if the light shines on me.  

<strong>What am I?</strong>  

#### Answer accepted (score 10)
The answer is:  

<blockquote class="spoiler">
   A shadow  
</blockquote>

Only light creates   

<blockquote class="spoiler">
  shadows   
</blockquote>

of objects, but when light shines on it, it doesn't exist anymore.  

#### Answer 2 (score 6)
Another answer:  

<blockquote class="spoiler">
   <strong>Photography film</strong>. No one would say that a film unused is a living one, that is, it needs light to come alive for it's purpose. However, if the light shines on it, it ruins the exposure and becomes a 'dead film'.  
</blockquote>

#### Answer 3 (score 3)
Another possible answer (more literal):  

<blockquote class="spoiler">
   There are many plants which are adapted to shady environments (e.g. plants which typically grow on forest floors).  So, they obviously require indirect light to live, but if the sun shines directly on them too much, they shrivel up and die.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: How can 64 = 65? (score [32033](https://stackoverflow.com/q/24848) in 2016)

#### Question
Here is a interesting picture with two arrangements of four shapes.  

<a href="https://i.stack.imgur.com/fWdMd.jpg"><img src="https://i.stack.imgur.com/fWdMd.jpg" alt="pic"></a>  

How can they make a different area with the same shapes?  

#### Answer accepted (score 160)
This is a famous physical puzzle that can be tied to the <a href="https://en.wikipedia.org/wiki/Fibonacci_number">fibonacci series</a>.  

To answer the question as posed, the issue is that the two slopes are different ($\frac25$ vs $\frac38$).  Note that all those numbers are in the fibonacci series ($1,1,2,3,5,8,13,21,\ldots$).  

Successive fractions are closer approximations to <a href="https://en.wikipedia.org/wiki/Golden_ratio">$\varphi$</a>, alternating between above and below.  Diagrams like this can be generated by making a square with sides equal to a number in the fibonacci series (in this question 8), then dividing it into two rectangles with widths of the two fibonacci numbers that make up the first one chosen (3 and 5).  

Cut the smaller one down the diagonal, and cut the bigger one down the middle at a diagonal, such that the width of the diagonal cut is the next smallest number (2 in this case).  Note that this will leave a trapezoid, whose small parallel size matches the original small rectangle's smaller side (3 in this case), and whose larger parallel size matches the original larger rectangle's smaller side (5 in this case).  

Since $\frac25\approx\frac38$, and from the above constructions, the pieces can be rearranged into a rectangle (as shown), the area of which will always be one away from the original square, but will look approximately correct, since the slopes almost match.  

Edit: Since this answer received so many up-votes (thank you!), I suppose people are very interested in it, so I thought I'd draw up a few images!  

<strong>1,1,2,3</strong>: $3\times3 = 9 = 10 = 2\times5$  

<a href="https://i.stack.imgur.com/nWWOQ.png"><img src="https://i.stack.imgur.com/nWWOQ.png" alt="1,1,2,3"></a>  

<strong>1,2,3,5:</strong> $5\times5 = 25 = 24 = 3\times8$  

<a href="https://i.stack.imgur.com/7JHKs.png"><img src="https://i.stack.imgur.com/7JHKs.png" alt="1,2,3,5"></a>  

<strong>2,3,5,8:</strong> $8\times8 = 64 = 65 = 5\times13$ (The OP's example)  

<a href="https://i.stack.imgur.com/FmJY9.png"><img src="https://i.stack.imgur.com/FmJY9.png" alt="2,3,5,8"></a>  

<strong>3,5,8,13:</strong> $13\times13 = 169 = 168 = 8\times21$  

<a href="https://i.stack.imgur.com/5OK01.png"><img src="https://i.stack.imgur.com/5OK01.png" alt="3,5,8,13"></a>  

<strong>5,8,13,21:</strong> $21\times21 = 441 = 442 = 13\times34$  

<a href="https://i.stack.imgur.com/7B6ib.png"><img src="https://i.stack.imgur.com/7B6ib.png" alt="5,8,13,21"></a>  

#### Answer 2 (score 150)
<strong>The diagram is misleading, as it hides a gap in the middle of the second configuration.</strong>  

This is what we actually get if we rearrange the shapes in question. Notice that the diagonal “bows” slightly, leaving some extra space between the shapes – this is where the extra unit of area creeps in.  

<a href="https://i.stack.imgur.com/irWhD.png" rel="noreferrer"><img src="https://i.stack.imgur.com/irWhD.png" alt="enter image description here"></a> <a href="https://i.stack.imgur.com/vIMMx.png" rel="noreferrer"><img src="https://i.stack.imgur.com/vIMMx.png" alt="enter image description here"></a>  

But you shouldn’t trust me any more than the person who drew the original picture!  

As we see here, pictures can be misleading – so my diagram isn’t proof that the original diagram was wrong. This just gives an intuitive sense of where the extra space has come from.  

For a proper proof, consider the gradients:  

<ul>
<li>The gradient of the blue trapezium is $5/2 = 2.5$</li>
<li>The gradient of the red triangle is $8/3 = 2.666...$</li>
</ul>

Since the gradients don’t match, we can’t arrange them side-by-side like this without some blank space between them. But because they’re close, the eye can be tricked into thinking they form a single continuous line, and doesn’t notice the slope on the triangle changing midway down.  

#### Answer 3 (score 14)
The image on the right <em>cheats</em>: the pieces don't actually fit together perfectly, there's a gap in between. To prove it, we can calculate the size of the gap, by calculating the size of a triangle, formed by:  

<ul>
<li>the longest side of the yellow triangle: $a = \sqrt{3^2+8^2}$</li>
<li>the inclined side of the trapezoid: $b = \sqrt{2^2+5^2}$</li>
<li>the diagonal of the rectangle on the right: $c = \sqrt{5^2+13^2}$</li>
</ul>

The area of this triangle can be calculated using Heron's formula:  

<p>$$
A = \sqrt{s(s-a)(s-b)(s-c)}
$$</p>

where  

<p>$$
s = \frac{1}{2}(a+b+c)
$$</p>

Substituting the values into the formula gives exactly 0.5 for $A$. There are two such triangles, so that's a total 1 = the expected discrepancy.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: This is important. I need you to listen… (score [30813](https://stackoverflow.com/q/28494) in 2016)

#### Question
Look, you don't know me. We've never met. But, like I said, I need you to listen...  

I had the most disturbing dream the other night... Woke up in a cold sweat and couldn't get back to sleep. It wasn't a nightmare as such, just ... eerie, I guess? I don't even remember the details, but it left me with a real sense of foreboding. Weird thing about dreams, so clear when you have them, but the details fade so quickly... Vivid, yet fuzzy... And the strange logic that applies... Inconsistent flow of time... Disjointed cause and effect...  

I'm rambling... The thing is, when I woke up, I found an odd magazine clipping on my bedside table. It feels so familiar, like I've had it for quite a while, but for some reason, I can't remember how or when I acquired it. Wherever it came from, all I know is that it I gives me the same creepy feeling my dream did.  

Anyway, the strangest part about all this is... And perhaps you won't believe me... But, this piece of paper, I think...  

...I think it's meant for <em>you</em>.  

<hr>

<p>Here's a photo I took showing the whole page (click to enlarge):
<a href="https://i.stack.imgur.com/tcgNT.jpg"><img src="https://i.stack.imgur.com/JCtyr.jpg" alt="mysterious page"></a></p>

I also took a <a href="https://i.stack.imgur.com/B7g38.png">scan of the main picture</a>, but my intuition says it's the least important part. I thought the text of the main "article" might be more useful to you, so I've transcribed it here:  

<blockquote>
  <p><strong>RXZMHTHXCUTANEMZNVNQDTH</strong><br>
  <strong>MWDEJULDYHPHVERHBPGPOMT</strong>  </p>
  
  <p>pltdlgvqncltrr<br>
  umtmrqgba<br>
  mcdmwuygplpsdw<br>
  vaitzgifamqciw<br>
  wcogsplseplhbz<br>
  kgfibhsjyiebvt<br>
  jsurvclhzegko  </p>
  
  <p>nipzsbwaetoivh<br>
  onbvrvhtslls<br>
  lusihvlncaawlttfv<br>
  bngamiivvc<br>
  dyktpklecfjbijm<br>
  lpuhhvqtneqtrw<br>
  wfsgtfvqkyshgk<br>
  ngtdwiivvlitga<br>
  nrhqmkcmrleflmgl<br>
  uwlmfwgvv<br>
  unayficwvhoickso<br>
  wfxjbklwfmsnf  </p>
  
  <p>uwilt<br>
  RGMRI R VQKQ<br>
  LKH EOP A AGU A<br>
  kmuwzs<br>
  KNPW AGMR IIQ LBQP<br>
  KHAOP WFLZA WAK EZ  </p>
  
  <p>qikbfvmaovsncb<br>
  qaoelayjrklvum<br>
  owgarzmmndm<br>
  brghwcovoyiflark<br>
  apsblpqiflmhjbty<br>
  fifmayvzpij  </p>
</blockquote>

<hr>

Hopefully this all means more to you than it does to me...  

<hr>

<strong><em>Edit</em></strong>: As per <a href="http://meta.puzzling.stackexchange.com/questions/4530/etiquette-for-teaming-up-to-solve-a-puzzle">this meta post</a>, I've created a <a href="https://chat.stackexchange.com/rooms/36672/this-is-important-i-need-you-to-listen">chat room</a> if people wish to collaborate and discuss theories or post their partial solutions/notes somewhere.  

#### Answer accepted (score 212)
(<em>Thanks to f'' for the help in chat! He solved the majority of this puzzle - I just came in at the end.</em>)  

<strong>Step 1: Crossword</strong>  

The crossword was solved by feelinferrety, Z. Dailey, and Sleafar:  

<blockquote class="spoiler">
   <a href="https://i.stack.imgur.com/1DuXt.jpg"><img src="https://i.stack.imgur.com/1DuXt.jpg" alt="crosswordsolved"></a>  
</blockquote>

<strong>Step 2: NOTHEX</strong>  

<blockquote class="spoiler">
  In the caption, if you look at A and D only (as it says in the NOTHEX ad), and interpret them as crossword clues (only taking the letters not torn off) you get the message "THE TITLE IS THE KEY".  
</blockquote>

<strong>Step 3: Using The Key</strong>  

<blockquote class="spoiler">
  <p> When you use the newspaper title as a Vignere key for the first paragraph, you get the message<br>
 "you're not listening read it again and realise the truth"<br>
<br>
 If you use the <em>question</em> title instead,</p>
</blockquote>

you get a message for all four paragraphs:  

<blockquote class="spoiler">
  <p>well done you are<br>
beginning<br>
to see but we have<br>
not finished yet<br>
you need all your<br>
synapses firing<br>
for this to work<br>
<br>
a pirate's search<br>
but in reverse<br>
a map disguised here<br>
in the verse<br>
perfectly square<br>
this text aligns<br>
the mark is found<br>
follow the signs<br>
and now it dawns it's<br>
not enough<br>
dual maps required<br>
one fore one aft<br>
<br>
first<br>
ENEEE N SSWW<br>
SWW WWW W NNN S<br>
second<br>
WWWW NNEE EEN NNWW<br>
WWSWW SSSSS ESS WN<br>
<br>
but if it's broken<br>
what difference<br>
would it make<br>
once you can answer<br>
that the truth will<br>
become clear </p>
</blockquote>

<strong>Step 4: Following Directions</strong>  

<blockquote class="spoiler">
  <p>"In the verse / perfectly square" hints at the poems being more than just instructions. In fact, all of the text in the "article" is exactly 400 letters, which can be arranged into a 20×20 grid. "A pirate's search but in reverse" hints that we're starting at an X instead of ending at one. So, if you take the text and arrange it into a square grid, you get this:<br>
`pltdlgvqncltrrumtmrq`<br>
`gbamcdmwuygplpsdwvai`<br>
`tzgifamqciwwcogsplse`<br>
`plhbzkgfibhsjyiebvtj`<br>
`survclhzegkonipzsbwa`<br>
`etoivhonbvrvhtsllslu`<br>
`sihvlncaawlttfvbngam`<br>
`iivvcdyktpklecfjbijm`<br>
`lpuhhvqtneqtrwwfsgtf`<br>
`vqkyshgkngtdwiivvlit`<br>
`ganrhqmkcmrleflmgluw`<br>
`lmfwgvvunayficwvhoic`<br>
`ksowfXjbklwfmsnfuwil`<br>
`trgmrirvqkqlkheopaag`<br>
`uakmuwzsknpwagmriiql`<br>
`bqpkhaopwflzawakezqi`<br>
`kbfvmaovsncbqaoelayj`<br>
`rklvumowgarzmmndmbrg`<br>
`hwcovoyiflarkapsblpq`<br>
`iflmhjbtyfifmayvzpij`<br>
<strong>and for the plaintext:</strong><br>
`welldoneyouarebeginn`<br>
`ingtoseebutwehavenot`<br>
`finishedyetyouneedal`<br>
`lyoursynapsesfiringf`<br>
`orthistoworkapirates`<br>
`searchbutinreverseam`<br>
`apdisguisedhereinthe`<br>
`verseperfectlysquare`<br>
`thisteXtalignsthemar`<br>
`kisfoundfollowthesig`<br>
`nsandnowitdawnsitsno`<br>
`tenoughdualmapsrequi`<br>
`redoneforeoneaftfirs`<br>
`teneeensswwswwwwwwnn`<br>
`nssecondwwwwnneeeenn`<br>
`nwwwwswwsssssesswnbu`<br>
`tifitsbrokenwhatdiff`<br>
`erencewoulditmakeonc`<br>
`eyoucananswerthatthe`<br>
`truthwillbecomeclear`<br>
 Follow the directions in the third paragraph on the first grid (taking letters after every space), and you get the message "AMBIGRAM". If you repeat the process with the second grid and the second set of directions ("dual maps required, one fore one aft") you get "ISBROKEN".</p>
</blockquote>

<strong>Step 5: The Image</strong>  

<blockquote class="spoiler">
  An ambigram is the same thing upside-down and right-side-up. The image is <em>almost</em> an ambigram, but some pixels are changed. If you XOR the image with itself rotated 180°, you get the following: <a href="https://i.stack.imgur.com/0phTN.png"><img src="https://i.stack.imgur.com/0phTN.png" alt="pleasewakeup"></a>  
</blockquote>

<strong>Step 6: Interpreting Everything</strong>  

<blockquote class="spoiler">
  <p>Well, we appear to be in a coma. The messages on the borders of the "please wake up!" image are:<br>
 - We've been trying to get a message to you...<br>
 - You're in a coma...<br>
 - There was an accident...<br>
 - Open your eyes...<br>
 - We miss you...<br>
<br>
Even the crossword clues hint that you're in a coma: specifically, the unused clues for 7, 16, 21, and 26 across. (The solutions to those are "accident", "pity", "coma", and "dream".
<br>
 So we have two options: waking up and having to talk to people or staying in weird coma-land where everything is puzzles. I know which one <em>I'd</em> choose.</p>
</blockquote>

#### Answer 2 (score 25)
Here's what I found so far:  

<h5>Title</h1>

<blockquote class="spoiler">
   The word <strong>listen</strong> in the title looked pretty important from the beginning. It is also repeated in the first line of the question and there is a hint in the crossword (see below).  
</blockquote>

<h5>Crossword</h1>

<blockquote class="spoiler">
  <p> The visible hints for horizontal entries give the words ISOLATED, THEOLOGY, PITY, THEORY and KEY. The vertical word EYES was given in the linked image from the question. Filling the remaining letters reveals 2 additional vertical words: TITLE and EIGHTH. The eighth word in the title is <strong>listen</strong>.<br>
<br>
 <a href="https://i.stack.imgur.com/1DuXt.jpg"><img src="https://i.stack.imgur.com/1DuXt.jpg" alt="enter image description here"></a></p>
</blockquote>

<h5>Continuation</h1>

<blockquote class="spoiler">
   I'm stuck for now. The word <strong>listen</strong> suggests that the rest of the puzzle might have to do something with music. The letters A-F could stand for notes (they are obviously not hex numbers as stated in the advertisement). Replacing the numbers below the image with letters from the crossword didn't work for me either (even when using A &amp; D vitamins only).  
</blockquote>

#### Answer 3 (score 18)
I'm going to follow another user's example and post an answer to make notes.  

<strong>Solving the crossword:</strong>  

Thanks to Z. Dailey for the missing words. (1D, 4A, 11D)  

<blockquote class="spoiler">
   <img src="https://i.stack.imgur.com/bPmc8.jpg" alt="crossword">  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Split 12 liters in half with 5 and 8 liter bottles (score [30780](https://stackoverflow.com/q/2192) in 2016)

#### Question
You have 12 liters of apple juice in a 12 liters bucket and you want to share it with your best friend. But you have an empty 8-liter and an empty 5-liter bottle.  

How do you split the apple juice in half?  

Source: <a href="http://www.fekraneh.ir/tab-178/index.aspx" rel="noreferrer">fekraneh.ir</a>  

#### Answer accepted (score 5)
<p>Here is a general algorithm.  A and B are the 5 and 8 liter bottles.
The 12-liter bottle is the juice reserve.  The capacity is irrelevant.</p>

<ul>
<li>A empty => fill A from reserve</li>
<li>B full => empty B into reserve</li>
<li>else => transfer juice from A to B</li>
</ul>

Depending on which bottle is A and which is B, you get a 7-step or a 18-step solution.  (Or one less step if you accept solutions where one part is split in 2 bottles)  

This, by the way, works for every 2-bucket problem.  If it has a solution.  

PS: I realized the capacity of the 12-bottle is not irrelevant since it is less than 8+5.  It can be used for a 10-move solution.  

#### Answer 2 (score 5)
<p>Here is a general algorithm.  A and B are the 5 and 8 liter bottles.
The 12-liter bottle is the juice reserve.  The capacity is irrelevant.</p>

<ul>
<li>A empty => fill A from reserve</li>
<li>B full => empty B into reserve</li>
<li>else => transfer juice from A to B</li>
</ul>

Depending on which bottle is A and which is B, you get a 7-step or a 18-step solution.  (Or one less step if you accept solutions where one part is split in 2 bottles)  

This, by the way, works for every 2-bucket problem.  If it has a solution.  

PS: I realized the capacity of the 12-bottle is not irrelevant since it is less than 8+5.  It can be used for a 10-move solution.  

#### Answer 3 (score 0)
First pour the water in the bucket into the 8-litre bottle, then 4 litres remain in the former.    

Step 2: pour the water in the 8-litre bottle into the 5-litre bottle, now there'll be 4 litres in the bucket, 3 in the 8-litre bottle and 5 in the remaining one.    

Then add the water in the 5-litre bottle to the bucket - there'll be 9 litres in the latter and 3 in the 8-litre one.  

Now pour the water in the 8-litre bottle into the 5-litre bottle and fill the 8-litre bottle with the 12-litre bottle - there'll be 1 litres in the bucket, 8-litre one will be full and 3 litres will be in the 5-litre one.  

Finally fill the 5-litre bottle using the 8-litre one and pour all the water in the 5-litre bottle into the bucket.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Put the numbers 1, 2, 3, 4, 5, 6, 7, 8, and 9 so the total of each row, column and diagonal add up to the same number (score [30637](https://stackoverflow.com/q/54952) in )

#### Question
<p>Puzzle for grade 11 foundations of mathamatics course thank you in advance for the help 
<a href="https://i.stack.imgur.com/QP5qs.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/QP5qs.jpg" alt="enter image description here"></a></p>

#### Answer accepted (score 1)
Since nobody has answered...  

```text
6 1 8
7 5 3
2 9 4
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: Man buys item, throws it away on his way out (score [30627](https://stackoverflow.com/q/64123) in 2018)

#### Question
I thought of this lateral thinking puzzle. Hopefully, it's not too broad and hasn't been asked before.  

<blockquote>
  A man walks into a store, buys an item for $1, and throws it away along with the receipt on his way out. What item did he buy?  
</blockquote>

Notes:  

<ul>
<li>His decision to throw the item away on his way out was completely justified.</li>
<li>He did not put anything in his mouth between buying the item and throwing it away.</li>
</ul>

EDIT: To make this question less broad, here are some notes that I should've had in the beginning:  

<ul>
<li>He bought the item because he wanted the item.</li>
<li>"Throw away" means he put the item and the receipt in the trash can.</li>
<li>The item was reasonably priced at 1 USD in 2018.</li>
<li>He threw the item away because his perception of the item's intrinsic value changed.</li>
</ul>

#### Answer accepted (score 127)
It was  

<blockquote class="spoiler">
   A scratch card. And presumably not a winning one.  
</blockquote>

#### Answer 2 (score 110)
Perhaps he really needed to  

<blockquote class="spoiler">
   use the restroom, but the store has a strict customer-only policy.  
</blockquote>

In this case, what he bought was  

<blockquote class="spoiler">
   completely inconsequential.  
</blockquote>

#### Answer 3 (score 81)
<blockquote class="spoiler">
   He bought a newspaper, turned to the classifieds section, and read an ad. Then he threw away the newspaper. The ad could be anything: a secret spy communication, or a response to a proposal, or a code that's part of some puzzle game.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: How to solve this IQ test puzzle with arrows and pied squares? (score [30542](https://stackoverflow.com/q/1671) in 2017)

#### Question
What is correct answer for this IQ task and <strong>why</strong>?  

<img src="https://i.stack.imgur.com/9fv2s.jpg" alt="enter image description here">  

#### Answer accepted (score 23)
The answer is:  

<blockquote class="spoiler">
   <strong>F</strong>  
</blockquote>

<hr>

I googled and found the test this task is taken from: <a href="http://www.iqtest.dk/testEnglish.swf">http://www.iqtest.dk/testEnglish.swf</a>  

If I answer 1-10 questions correctly and 38 H, I get IQ 92.   

If I answer 1-10 questions correctly and 38 F, I get IQ 93.  

So I conclude that correct answer is F.  

<hr>

How I understand this puzzle:  

In the corners (cells: 11,13,31,33) we have some objects. In the middle edges (12,21,23,32) we have operators on neighbouring two objects. The centre cell (22) is simply do not used here [this opinion agrees with tasks 4 and 9 at the same test, where it is used similarly].  

Let's look on (12) operator (one arrow), it leads to simple vertical stretching of object.  

Let's look on (21) operator (two arrows), it leads to simple swap of object colours.  

Now we are looking on (23) and (32). (23), by our assumption, should swap colours of (13), creating the object from varian H, plus some additional operation, since (23) is different from (13). (32), by our assumption, should stretch (31), making variant H from it, plus some additional operation.  

<p>What are these additional operations? Since they make the same object from the same object (H) that must be the same. Looking on possible answers we see that all differences between objects are: size, swap of the colours, angle. We have notations for first two differences, so additional operation should be rotation.<br>
We see that (23) is rotated respectively to (21), by 45 degree clockwise. (32) is rotated respectively to (12) by 45 degree clockwise. So most probably both additional operations means rotation by 45 degree clockwise. This means that the right variant for (33) is F.</p>

<hr>

What I do not like about this solution:  

<ol>
<li>One arrow and two arrows means completely different things. It is counter intuitive. And though double arrow associated with swap, no doubts, it is also associated with stretching.</li>
<li>Arrows in (12) and (21) have different orientation, and this have no influence on the objects, meanwhile orientation of (32) and (23) is important. [The orientation of arrows can be explained by the fact that they also plays role of objects for meta operation, but this is lousy argument, based on "how would author think creating this puzzle" - the orientations of arrows when they play role operators still do not agree with each other.]</li>
</ol>

I hope, someone else will find even better explanation, without mentioned two drawbacks.  

#### Answer 2 (score 9)
H.  

Various categories of symbol appear on alternate rows and columns:  

<p>Odd row, odd column - rectangles shaded in two colours, with diagonal dividing line.
Odd row, even column - single headed arrows
Even row, odd column - double headed arrows
Even row, even column - cross</p>

Each category of symbol appears to have its own type of transformation:  

<p>Odd row, odd column - height increases moving right, which half is shaded swaps moving down (or 180 degree rotation moving down)
Odd row, even column - 45 degree rotation clockwise moving down
Even row, odd column - 45 degree rotation clockwise moving right
Even row, even column - ?  (only one member)</p>

In the absence of any obvious common rule for all symbols, I conclude that each set follows its own rules.  Thus the answer is H (column 3 = tall, row 3 = top left half black).  

I did wonder if the arrows represented transformations for the squares on either side - the arrow in row 1 column 2 could represent a height increase.  The double headed arrows suggest a flip to me but would have to represent a rotation for this to work.  But this system breaks down with row 3 column 2 - there are no answers which have been stretched along a diagonal (which would give a parallelogram).  

#### Answer 3 (score 1)
Like <a href="https://puzzling.stackexchange.com/questions/1671/how-to-solve-this-puzzle-from-iq-test/1677#1677">bmj</a>, I also get <strong>H</strong> as the answer. However, my logic is much more straightforward:  

<ul>
<li><p>We see:</p>

<ul>
<li>Upper Left  $\rightarrow$  Upper Right $\Rightarrow$ Rectangle $\rightarrow$  Square</li>
<li>Upper Left  $\rightarrow$  Lower Left $\Rightarrow$ Invert colors</li>
</ul></li>
<li><p>Therefore:</p>

<ul>
<li>Lower Left  $\rightarrow$  Lower Right $\Rightarrow$ Rectangle $\rightarrow$  Square</li>
<li>Upper Right $\rightarrow$  Lower Right $\Rightarrow$ Invert colors</li>
</ul></li>
<li><p>Resulting in a color-inverted square.</p></li>
</ul>

The arrows and $\times$ are just distractions.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Strategy to solve the Missionaries and Cannibals problem (score [30524](https://stackoverflow.com/q/131) in )

#### Question
In the <a href="http://en.wikipedia.org/wiki/Missionaries_and_cannibals_problem#The_problem">Missionaries and Cannibals problem</a>:  

<blockquote>
  Three missionaries and three cannibals must cross a river using a boat which can carry at most two people, under the constraint that, for both banks and the boat, if there are missionaries present on the bank (or the boat), they cannot be outnumbered by cannibals (if they were, the cannibals would eat the missionaries). The boat cannot cross the river by itself with no people on board.  
</blockquote>

<a href="http://en.wikipedia.org/wiki/Missionaries_and_cannibals_problem#Solution">The shortest solution</a> for this puzzle has 11 one-way trips.  

<strong>What should be the strategy to solve this puzzle for M missionaries and C cannibals</strong>, given that M is not less than C, or else the puzzle wouldn't be solvable.  

#### Answer accepted (score 11)
Let's define `a b * c d` to represent the state of the river at any given time: `a` missionaries and `b` cannibals on the left, `c` missionaries and `d` cannibals on the right, and `*` being `<` if the boat is on the left and `>` if the boat is on the right.  

The problem starts out in the state `M C < 0 0`, and we want to get `0 0 > M C`.  

For the case of `M` being more than `C`, here's an algorithm to transfer 1 missionary and 1 cannibal at a time:  

<ul>
<li>Bring 1 missionary and 1 cannibal over. (`M-1 C-1 > 1 1`)</li>
<li>Bring the <em>cannibal</em> back. (`M-1 C < 1 0`; since `M > C`, `M-1 >= C`, as required.) </li>
<li>Bring 1 missionary and 1 cannibal over again. (`M-2 C-1 > 2 1`)</li>
<li>Bring a missionary back. (`M-1 C-1 < 1 1`).</li>
</ul>

And then you're left with the case of `M-1` missionaries and `C-1` cannibals on one side of the river. Just keep repeating this procedure (it works by induction) until you have only missionaries on the left side of the river. Then you're home free.  

For `M` equal to `C`, I don't think you'll have a solution for `M > 3`, because the solution for `M = 3` already depends on the fact that you can have <em>only</em> cannibals on one side and they won't be able to do anything to the missionaries no matter how many there are on one side.  

The part of the solution where this applies looks something like this:  

<ul>
<li>`3 1 < 0 2`</li>
<li>`1 1 > 2 2`</li>
<li>`2 2 < 1 1`</li>
<li>`0 2 > 3 1`</li>
</ul>

There's no way to get a similar arrangement for anything greater than three, because you can't send enough missionaries at once to balance out the rest of the cannibals.  

#### Answer 2 (score 2)
For the case of more M than C it becomes trivial as a canibal can run the ferry after some initial setup.  It starts with 1 M and 1C in the boat with C+1 M on the original shore.  The M takes the boat back and gets another M, leaving C Ms on the original shore, The Ms get to the other side and send the C back with the boat.  The C can now ferry alternating C's and Ms without issue.  The Ms will always outnumber the number left on either shore.  

If M is 2 or more higher than C, then M can actually run the boat as well since they can start with 2 Ms in the boat and keep a higher number on both shores simultaneously while also operating the boat.  

#### Answer 3 (score 0)
Here's a foolproof solution:    

<blockquote class="spoiler">
   One missionary and one cannibal cross to the other side, <br>The cannibal gets out and the missionary comes back<br> Missionary gets out of the boat, two cannibals get in and cross<br>One cannibals gets out and the other cannibal goes back<br>The cannibal gets out and two missionaries get in and cross<br>One missionary gets out, the other missionary stays in the boat and one cannibal gets in and goes back.<br>The cannibal gets out and two missionaries get in and cross<br>The two missionaries get down and the cannibal gets in the boat and goes back<br>One cannibal gets in and they both cross but only one cannibal gets out<br>The other cannibal in the boat goes back, collects the other cannibal, they cross and they get out.  
</blockquote>

And you should have won  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How did the police know? (score [30306](https://stackoverflow.com/q/16460) in 2016)

#### Question
One night, a man receives a call from the police. The police tell the man that his wife was robbed, murdered, and her body dumped in a remote location, and that he should reach the crime scene as soon as possible.   

The man drops his phone in shock, and drives 20 minutes to the crime scene. Though the man does not have any evidence of committing the murder on his personal being (no blood or other signs of foul play on the car or any possessions) as soon as he reaches the crime scene, and before he can say or do anything, the police arrest him on suspicion of committing the murder (he will, of course be judged by a jury of his peers, etc.).  

<blockquote>
  Without any sign of <em>typical</em> evidence, why do the police think that he committed the crime?    
</blockquote>

<sub> It should be noted that this takes place in the <em>typical</em> world, without aliens, super powers, or unlimited quantities of any material.</sub>  

#### Answer accepted (score 82)
I think   

<blockquote class="spoiler">
   They didn't tell him where the murder scene was but he could find it.  
</blockquote>

#### Answer 2 (score 53)
He was framed for the murder by popular musicians Sting, Andy Summers and Stewart Copeland.  

<blockquote class="spoiler">
   You've stated that he was told about the murder by <a href="https://en.wikipedia.org/wiki/The_Police">the Police</a> (note the capitals), and was arrested as he arrived at the scene of the crime by <strong>the police</strong>.  
</blockquote>

Clearly they knew he would be coming somehow.  

#### Answer 3 (score 31)
From a lateral point of view, you've not actually stated that he was arrested for <strong>his wife's murder.</strong>  

He could therefore have been arrested because:  

<blockquote class="spoiler">
   There was an outstanding arrest warrant for him <em>already</em>  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Riddles whose answer is "the moon" (score [30302](https://stackoverflow.com/q/30553) in 2016)

#### Question
The short version: what are five riddles whose answer is "the moon"?  

Longer:  

I'm preparing to run the D&amp;D module "White Plume Mountain". At one point in that Adventure there's an encounter with a sphinx who asks each character a riddle. Unbeknownst to the party, the answer ("moon") is also the password to disarm a nearby magical trap, so that the trap does not attack that character. So the sphinx needs to get each character to say the word "moon" before they continue.  

Using the scenario as written, the sphinx would ask this riddle to each character in turn:  

<pre>Round she is, yet flat as a board, 
Altar of the Lupine Lords, 
Jewel on black velvet, pearl in the sea, 
Unchanged but e'erchanging, eternally.</pre>

But this is silly. What self-respecting sphinx would ask the same riddle five times in a row?  

So: what are five riddles (counting the above riddle) whose answer is "moon"? It's okay if some of the riddles are a bit lame or awkward. It's better if the riddles avoid anachronisms since this is a fantasy setting.  

#### Answer accepted (score 22)
<blockquote>
  Always old, sometimes new.   
  
  Never sad, sometimes blue.   
  
  Never empty, sometimes full.   
  
  Never pushes, always pulls.  
</blockquote>

#### Answer 2 (score 20)
These are possibly too easy(?), but you probably don't want it to be too hard if a single person is supposed to get it fairly quickly...  

<hr>

<blockquote>
  <p>When new, he can't be seen at all<br>
  But he grows with each night fall<br>
  And as he looms over the wall<br>
  Hark and hear the lone wolf's call  </p>
</blockquote>

<hr>

<blockquote>
  <p>Bright and dark. Black and white.<br>
  I am the shepherd of the night.<br>
  Fast and slow. Rise and sink.<br>
  Blind, yet every month, I blink.  </p>
</blockquote>

<hr>

Or a bit of a silly one:    

<blockquote>
  <p>First a bovine's song, and then,<br>
  Take the third of nine or ten.<br>
  Join them up, there is no time,<br>
  Too soon, it is, to make a rhyme.  </p>
</blockquote>

<hr>

#### Answer 3 (score 9)
<blockquote>
  <p>A slave I have been and shall remain<br>
  To a cruel mistress I'm tied with invisible chains<br>
  Yet always I put on the same brave face<br>
  She keeps me her prisoner, but leaves me some space</p>
</blockquote>

And a possible second verse (<em>edit - improved from earlier versions</em>):  

<blockquote>
  <p>My sorrow moves oceans, tugs at her heart<br>
  Though we're bound to each other, we remain worlds apart<br>
  Round and round my cell I walk, but never complain<br>
  A slave I have been, and shall remain</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Can you make 1 1 1 1 = 5? (score [29982](https://stackoverflow.com/q/58954) in 2018)

#### Question
Can you find a way to make 1 1 1 1 = 5 by adding any operations or symbols? You can use symbols such as these: +, -, *, !, ^, (). It is not limited to this list.   

Good Luck!  

P.S. You can not add any other numbers to the equation.   

#### Answer accepted (score 94)
How about  

<blockquote class="spoiler">
  <p> $(1+1+1)!-1$
 = $6 -1$ = $5$</p>
</blockquote>

#### Answer 2 (score 53)
How about such a variant?  

<blockquote class="spoiler">
   ++(1+1+1+1)=5  
</blockquote>

#### Answer 3 (score 43)
Here's another solution:  

<blockquote class="spoiler">
   $1$E$1$ $/ (1 + 1)$ =  $5$  
</blockquote>

Where:  

<blockquote class="spoiler">
  <p> E is the exponential notation symbol.

 i.e. 1E1 = $1 \times 10^1$</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: Draw a line through all doors (score [29920](https://stackoverflow.com/q/1856) in 2015)

#### Question
I saw the following problem on 4chan and couldn't solve it:  

<img src="https://i.stack.imgur.com/dnglT.jpg" alt="enter image description here">  

It's very likely to be some kind of troll (no solution).  

I'm hoping to see some rigorous proofs that disprove the existence of such a line.  

#### Answer accepted (score 35)
It is impossible.  

Quite the same problem is "<a href="http://en.wikipedia.org/wiki/Seven_Bridges_of_K%C3%B6nigsberg">Seven Bridges of Königsberg</a>", it was solved (proven) by Euler.  

<ol>
<li><p>Suppose you have drawn such a line and follow it from one room to another. Since you must use each door you must have a look at each room out of 5. What are these rooms?  </p></li>
<li><p>There will be 3 (at least) rooms you always go through - if you enter it you always exit it later.<br>
Indeed, 1 (at most) room you can start at, and another 1 (at most) room you can finish at, but others you must go through: $5-1-1 = 3$.</p></li>
<li><p>Since you use each door exactly once, the mentioned 3 rooms must have an even number of doors, since you entry them the same number of times you exit them. But you have only 2 rooms with an even number of doors, the others have 5 doors. So you could not draw such a line.</p></li>
</ol>

#### Answer 2 (score 35)
It is impossible.  

Quite the same problem is "<a href="http://en.wikipedia.org/wiki/Seven_Bridges_of_K%C3%B6nigsberg">Seven Bridges of Königsberg</a>", it was solved (proven) by Euler.  

<ol>
<li><p>Suppose you have drawn such a line and follow it from one room to another. Since you must use each door you must have a look at each room out of 5. What are these rooms?  </p></li>
<li><p>There will be 3 (at least) rooms you always go through - if you enter it you always exit it later.<br>
Indeed, 1 (at most) room you can start at, and another 1 (at most) room you can finish at, but others you must go through: $5-1-1 = 3$.</p></li>
<li><p>Since you use each door exactly once, the mentioned 3 rooms must have an even number of doors, since you entry them the same number of times you exit them. But you have only 2 rooms with an even number of doors, the others have 5 doors. So you could not draw such a line.</p></li>
</ol>

#### Answer 3 (score 34)
<em>Just for fun:</em>  

<p>Actually, there is solution, which formally satisfies all the rules. You just need to walk through a wall!<br>
Hard, but possible! <img src="https://i.stack.imgur.com/gpEsn.jpg" alt="enter image description here"></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Grandma likes coffee but not tea (score [29918](https://stackoverflow.com/q/45059) in 2016)

#### Question
<em>Note: My grandma is a little odd. She only likes certain things. Solve this puzzle by providing phrases that are true. For example: Grandma likes A but not B</em>  

<ul>
<li>Grandma likes coffee but not tea. </li>
<li>Grandma likes fall but not autumn.</li>
<li>Grandma likes seconds but not minutes. </li>
<li>Grandma likes dark but not light. </li>
<li>Grandma likes one but not two.</li>
<li>Grandma likes false but not true.</li>
</ul>

<hr>

(Puzzle Credit: My friend Derek)  

#### Answer accepted (score 66)
Grandma likes  

<blockquote class="spoiler">
  <p> Flowers but not plants<br>
 Fingers but not toes<br>
 Fridges but not magnets<br>
 In but not out<br>
 Pancakes but not sweets<br>
 Paper clips but not staples</p>
</blockquote>

Why?  

<blockquote class="spoiler">
   Because grandma does not like <strong>T</strong>ea!  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Hats and Aliens (score [29316](https://stackoverflow.com/q/282) in 2015)

#### Question
Here's a neat little puzzle taken from a Google interview question:  

<blockquote>
  10 humans are abducted by aliens; each represents 10% of the entire human population. The aliens give each abductee either a purple hat or a green hat. The 10 are lined up in a single file line, each facing forward, such that the last person can see the remaining 9's hats, the second to last person can see the remaining 8's hats and so on. No one can see his or her own hat.  
  
  The aliens then proceed, starting from the last person, to ask each of the abductees what the color of their hat is. If they guess correctly, they and the 10% of the human population they represent survives; if not, the opposite happens.  
  
  Assuming the abductees are given a chance to develop a strategy before they are lined up and questioned: what is the optimal strategy they can utilize (i.e. the one with the highest expected number of survivals)?  
  
  During the questioning, the abductees are not allowed to say <em>anything</em> besides their guess for the color of their hat when it is their turn.  
</blockquote>

<hr>

<strong>Hint:</strong>  

<blockquote class="spoiler">
   The optimal strategy will always ensure 9 survivals, and will have a 50% chance of the 10th survival.  
</blockquote>

#### Answer accepted (score 45)
I think this would work? Sorry if it's confusing. I sort of confused myself when I came to this conclusion.  

<blockquote class="spoiler">
   The first guy would count the number of hats before him of a particular color... like, I dunno, I guess purple? And if the count of purple hats is odd, then he would say that his hat is purple. But if the count of purple hats is even, he'd say his hat was green.  
</blockquote>

So the next guy should then be able to determine the color of his hat by:   

<blockquote class="spoiler">
  <p> The remaining hats. So if the questioning went:<br>

 Alien: What color is your hat?<br>

 10th person: Purple.  </p>
</blockquote>

Then the 9th person would look ahead and:   

<blockquote class="spoiler">
   Count the number of purple hats. If it's an odd number, he has a green hat. If it's an even number, his hat is purple. So on and so forth. They just need to remember the "number" of purple hats.  
</blockquote>

But the first guy has no way of knowing his own hat color, so he's got a 50/50 chance of dying either way.  

If anyone has trouble understanding this, a visual explanation can be found here:  

<blockquote class="spoiler">
  <a href="https://www.youtube.com/watch?v=N5vJSNXPEwA" rel="noreferrer">https://www.youtube.com/watch?v=N5vJSNXPEwA</a>  
</blockquote>

#### Answer 2 (score 15)
Generically, what do you do if there are $c$ colors, and $n$ people? Imagine further the aliens say the following:  

<blockquote>
  You can plan your strategy now, but we are only going to tell you what the colors are going to be (including their hex representation) and how many there are after you are no longer allowed to communicate.  
</blockquote>

How well can the humans do? It's the same as before, except the human who goes first has a $\frac{1}{c}$ chance of survival.  

In advance, the humans use the following strategy:  

<ol>
<li>Each color is assigned a number from $0 \rightarrow c-1$ (this is arbitrary, the humans just have to agree on some numbering).</li>
<li>The human who goes first adds up the colors of all the hats that he sees, and computes the result $\bmod c$.</li>
<li>He then calls out the color required to make the total sum equal to $0 \bmod c$.</li>
<li>Each remaining human can then use the colors called out behind them and the colors they see in front of them to see what the total must be.</li>
</ol>

This strategy works no matter how many or how few humans there are.  

Example: 5 colors, 8 humans. Their hats have color numbers (assume the humans are all facing right, so the first human is the leftmost hat):  

```text
32130343
```

<ol>
<li>The first human sees `2130343`. This adds to $16$. Note $16 \bmod 5 \equiv 1$, so to make the total come out to be $0$, he calls out $4$, because $0 \equiv 4 + 1 \bmod 5$.</li>
<li>The second human sees `130343`, and has heard $4$. This adds to $18 \equiv 2 (\bmod 5)$, so he knows he must have color $2$.</li>
<li>The third human sees `30343`, and has heard `42`. This adds to $19 \equiv 1 (\bmod 5)$, so he must have color $1$.</li>
<li>This process proceeds down the line, and only the first person dies.</li>
</ol>

#### Answer 3 (score 10)
This puzzle has a computer science interpretation¹.  

The humans must provide 10 bits of information in total (each hat color is one bit of information). Participant number $k$ (with #0 at the back and #9 at the front) will hear $k$ bits of information from the humans behind him and will see $10-k-1$ bits of information on the heads in front of him. So there's one bit missing.  

The person at the back cannot do better than guess at random, since he has no information whatsoever that would indicate his own hat's color. Therefore the strategy should provide information that will help his successors optimally. The amount of information is precisely one bit, which is what the other partipants need.  

Assuming that all the participants except poor #0 succeed in calling their own hat's color, participant $k$ will have complete information except for #0's hat color (which is irrelevant) and his own hat color. In other words, he has a bit string with one bit missing. This calls for an <a href="http://en.wikipedia.org/wiki/Error_correcting_code">error correcting code</a>!  

Since the position of the error will be known, a very simple error correcting code is sufficient: a <a href="http://en.wikipedia.org/wiki/Parity_bit">parity bit</a>. Participant #0 calls out (for example) “purple” if he sees an even number of purple hats and “green” otherwise. Each other participant deduces from what he hears and sees whether the number of purple hats other than #0's and his is even or odd, and calls accordingly.  

¹ <sub> Which, in as much as puzzles belong in a job interview, makes it a little relevant when interviewing for a programming job. The puzzle itself is older than Google. It may well be older than computers, but I don't know its origin. </sub>    

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Sum six unique digits to make 20 (score [28776](https://stackoverflow.com/q/23781) in 2015)

#### Question
You have 6 boxes. You can use the digits from 1 to 9 but not 0. Digit repetition is not allowed. The total sum of the numbers/digits should be 20.  

<p>$$
\huge\square\square\square\\
\huge\square\square\square
$$</p>

#### Answer accepted (score 9)
It's not possible. The sum of the 6 smallest digits (1 through 6) is 21, already greater than 20.  

#### Answer 2 (score 9)
It's not possible. The sum of the 6 smallest digits (1 through 6) is 21, already greater than 20.  

#### Answer 3 (score 3)
If we add the <a href="/questions/tagged/lateral-thinking" class="post-tag" title="show questions tagged &#39;lateral-thinking&#39;" rel="tag">lateral-thinking</a> tag, I have a solution:  

<p>Write `4`, `5`, and `8` in the first three boxes<br>
Cut off three of your fingers (also called "digits") and place one in each of the other three boxes.<br>
Now you have 6 digits (three numbers, three fingers) in the boxes<br>
Each finger has a value of `1` so the sum is $1+1+1+4+5+8=20$</p>

Alternatively, if fingers have a value of `0`, then us the numbers `2`, `3`, `4`, `5`, `6` and only cut off one finger (value of `0`). Now the sum is $0+2+3+4+5+6=20$  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: 10 digit number where first n digits are divisible by n (score [28372](https://stackoverflow.com/q/3017) in 2015)

#### Question
What is the complete set of 10-digit numbers using each value ($0$-$9$) once, such that the first $n$ digits form a number divisible by $n$ (for $n \in \{1,2,...,10\}$)?  

E.g. if the number were $1234567890$, $1$ must be divisible by $1$, $12$ must be divisible by $2$, $123$ must be divisible by $3$, etc...  

#### Answer accepted (score 21)
Let us write the number as $abcdefghij$.  

$ab$, $abcd$, $abcdef$, $abcdefgh$, $abcdefghij$ are all even, therefore $\{b, d, f, h, j\}$ are the even digits and the remaining digits $\{a, c, e, g, i\}$ are the odd digits.  

Let's write $k \mid N$ (read "k divides N") when $N$ is a multiple of $k$.  

<p>$10 \mid abcdefghij \implies j = 0$.<br>
$5 \mid abcde \implies e$ is $0$ or $5$.  But $0$ is taken, so $e = 5$.<br>
$4 \mid abcd$ $\implies$ $4 \mid cd$.  This with $c$ odd $\implies$ $d \in \{2,6\}$.<br>
$8 \mid abcdefgh$ $\implies$ $4 \mid gh$.  This with $g$ odd $\implies$ $h \in \{2,6\}$.</p>

The last 2 lines imply $\{d,h\} = \{2,6\}$.  In either order.  

We know $\{b, d, f, h, j\}$ are the even digits. Since $j=0$ and $\{d,h\} = \{2,6\}$, the remaining digits are 4 and 8.  $\{b,f\}=\{4,8\}$.  

<p>$3 \mid abc \implies 3 \mid abc000$.  This with $6 \mid abcdef$ implies $3 \mid def$.
But we already know $e=5$, $d \in \{2,6\}$ and $f \in \{4,8\}$.  Only $def=258$ and $def=654$ satisfy these conditions.  The choice of $d$ and $f$ also force the value of $b$ and $h$.</p>

So far we have 2 partial solutions: $\_4\_258\_6\_0$ and $\_8\_654\_2\_0$.  

$8 \mid abcdefgh$ $\implies$ $8 \mid fgh$.  But $f$ is even, $8 \mid f00$, so we just need $8 \mid gh$.  This with $g \in \{1,3,7,9\}$ leaves only $gh \in \{16,32,72,96\}$.  

a) Let's consider $\_4\_258\_6\_0$.  In that case we have $g \in \{1,9\}$.  

$3 \mid abc$ with $b=4$ and $a,c \in \{1,3,7,9\}$ leaves only 2 possibilities: $abc \in \{147, 741\}$.  

<p>If $abcdef=147258$ with $7 \mid abcdefg$ then $g=3$.  But this is not possible because $g \in \{1,9\}$.<br>
If $abcdef=741258$ with $7 \mid abcdefg$ then $g=7$.  This is not possible for the same reason.</p>

So there is no solution for case (a).  

b) Let's consider $\_8\_654\_2\_0$.  In that case we have $g \in \{3,7\}$.  

$3 \mid abc$ with $b=8$ and $a,c \in \{1,3,7,9\}$ gives 8 possibilities: $abc \in \{183,189,381,387,783,789,981,987\}$.  Two of them, $387$ and $783$, are incompatible with $g \in \{3,7\}$.  They can be removed.  (Thanks to frodoskywalker.)  

For the remaining 6 solutions you need to find $g$ that satisfies $7 \mid abcdefg$ and verify that $g \in \{3,7\}$.  

For $abc=381$, we have $abcdef=381654$.  $7 \mid abcdefg$ implies $g=7$ which is valid. You can complete it with $i=9$ and you get the solution: $abcdefghij=3816547290$.  

No other $abc$ under consideration gives a valid $g$.  

<strong>The only solution is 3816547290.</strong>  

#### Answer 2 (score 21)
Let us write the number as $abcdefghij$.  

$ab$, $abcd$, $abcdef$, $abcdefgh$, $abcdefghij$ are all even, therefore $\{b, d, f, h, j\}$ are the even digits and the remaining digits $\{a, c, e, g, i\}$ are the odd digits.  

Let's write $k \mid N$ (read "k divides N") when $N$ is a multiple of $k$.  

<p>$10 \mid abcdefghij \implies j = 0$.<br>
$5 \mid abcde \implies e$ is $0$ or $5$.  But $0$ is taken, so $e = 5$.<br>
$4 \mid abcd$ $\implies$ $4 \mid cd$.  This with $c$ odd $\implies$ $d \in \{2,6\}$.<br>
$8 \mid abcdefgh$ $\implies$ $4 \mid gh$.  This with $g$ odd $\implies$ $h \in \{2,6\}$.</p>

The last 2 lines imply $\{d,h\} = \{2,6\}$.  In either order.  

We know $\{b, d, f, h, j\}$ are the even digits. Since $j=0$ and $\{d,h\} = \{2,6\}$, the remaining digits are 4 and 8.  $\{b,f\}=\{4,8\}$.  

<p>$3 \mid abc \implies 3 \mid abc000$.  This with $6 \mid abcdef$ implies $3 \mid def$.
But we already know $e=5$, $d \in \{2,6\}$ and $f \in \{4,8\}$.  Only $def=258$ and $def=654$ satisfy these conditions.  The choice of $d$ and $f$ also force the value of $b$ and $h$.</p>

So far we have 2 partial solutions: $\_4\_258\_6\_0$ and $\_8\_654\_2\_0$.  

$8 \mid abcdefgh$ $\implies$ $8 \mid fgh$.  But $f$ is even, $8 \mid f00$, so we just need $8 \mid gh$.  This with $g \in \{1,3,7,9\}$ leaves only $gh \in \{16,32,72,96\}$.  

a) Let's consider $\_4\_258\_6\_0$.  In that case we have $g \in \{1,9\}$.  

$3 \mid abc$ with $b=4$ and $a,c \in \{1,3,7,9\}$ leaves only 2 possibilities: $abc \in \{147, 741\}$.  

<p>If $abcdef=147258$ with $7 \mid abcdefg$ then $g=3$.  But this is not possible because $g \in \{1,9\}$.<br>
If $abcdef=741258$ with $7 \mid abcdefg$ then $g=7$.  This is not possible for the same reason.</p>

So there is no solution for case (a).  

b) Let's consider $\_8\_654\_2\_0$.  In that case we have $g \in \{3,7\}$.  

$3 \mid abc$ with $b=8$ and $a,c \in \{1,3,7,9\}$ gives 8 possibilities: $abc \in \{183,189,381,387,783,789,981,987\}$.  Two of them, $387$ and $783$, are incompatible with $g \in \{3,7\}$.  They can be removed.  (Thanks to frodoskywalker.)  

For the remaining 6 solutions you need to find $g$ that satisfies $7 \mid abcdefg$ and verify that $g \in \{3,7\}$.  

For $abc=381$, we have $abcdef=381654$.  $7 \mid abcdefg$ implies $g=7$ which is valid. You can complete it with $i=9$ and you get the solution: $abcdefghij=3816547290$.  

No other $abc$ under consideration gives a valid $g$.  

<strong>The only solution is 3816547290.</strong>  

#### Answer 3 (score -1)
I'm obviously misunderstanding the question, because from what I can see, the number 2485701369 also satisfies the conditions, as does 2485701396, and others.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: I have legs but cannot walk (score [27952](https://stackoverflow.com/q/41163) in 2016)

#### Question
<blockquote>
  I have eyes, but cannot see.  
  
  I have hands, but cannot work.  
  
  I have legs, but cannot walk.  
  
  Kids like me very much.  
</blockquote>

What am I?  

#### Answer accepted (score 12)
Maybe you are  

<blockquote class="spoiler">
   a doll  
</blockquote>

Because  

<blockquote class="spoiler">
   dolls have eyes, hands and legs - but they cannot actually see, work or walk (except for in our imaginations). Children often like them, but I don't know for sure if they like children!  
</blockquote>

#### Answer 2 (score 7)
May be Answer is   

<blockquote class="spoiler">
   Scarecrow  
</blockquote>

It have hands, eyes and legs but non of them working  

#### Answer 3 (score 3)
<blockquote class="spoiler">
   A full size portrait showing a person with eyes, arms and legs.  
</blockquote>

I have eyes but cannot see.  

<blockquote class="spoiler">
   The person on the portrait has eyes but can't really see  
</blockquote>

I have a hands but can't clap.  

<blockquote class="spoiler">
   It has arms and hands but can't clap.  
</blockquote>

I have a legs but cannot walk.  

<blockquote class="spoiler">
   It has legs but can't walk with them.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: How can I solve the Gear Cube Extreme? (score [27821](https://stackoverflow.com/q/563) in 2015)

#### Question
The <a href="http://www.puzl.co.uk/gear-cube-extreme-level-p-534.html" rel="nofollow">Gear Cube Extreme</a> is another Mechanical Puzzle. I ordered it not so long ago and a friend of mine "accidentally" scrambled it. Now I want to solve it again but I have no idea how or even where to start as it is my first non standard Rubik's cube to solve.  

#### Answer accepted (score 7)
Here's how I solve it:  

<ol>
<li>Solve the middle layer</li>
<li>Solve the corners<br>
2.1 Resolve middle layer parity and centers (if there is a problem)</li>
<li>Move the edges to the correct layers</li>
<li>Move the edges into the correct positions</li>
<li>Rotate the edges into the correct orientations</li>
</ol>

<hr>

<strong>0. Notation</strong>  

I'm using `R, L, B, F` to indicate a 180-degree turn of each side. This is because, as you know, you cannot rotate each side except in increments of 180. `U, D`, however, will refer to 90 degree turns of the upper and lower layers.  

If I refer to a corner using three letters, those letters indicate the faces that corner touches. For instance, the UFL corner is the upper front left corner.  

<hr>

<strong>1. Solve the middle layer</strong>  

This step is pretty easy, honestly, and you should be able to do this intuitively using the side moves. However, a couple algorithms that can help if you're truly stuck on this: use `R B R` to move the edges to a more understandable position, and `R2` or `L2` to rotate the middle slice 180 degrees to solve the centers.  

<hr>

<strong>2. Solve the corners</strong>  

For now, keep one hand firmly on two pieces of the center layer, and don't move it. If you do, you'll need to restore it, which isn't a difficult problem, but I'm not going to cover how to do it because it shouldn't happen. We'll restore the middle layer at the end of this step.  

I solve this in two steps: first, by solving the bottom layer corners; then, by solving the top layer corners.   

The algorithm I use to solve bottom layer corners is pretty simple: `R U R U' R'` This moves the UFL corner into the DFL position without disturbing the other pieces on the bottom layer. The process for solving the bottom layer pieces is simple:   

<ul>
<li>Find a bottom-layer corner on the top layer, and find where it should go. Use `U` to place the piece in the UFL position, and use `D` to place its target location in the DFL position. Then, execute the algorithm.</li>
<li>Here, 'target location' refers to a spot relative to other properly-placed pieces.</li>
<li>If there are no top-layer pieces on the bottom layer, then just move a piece there for reference.</li>
<li>If there are no bottom-layer pieces on the top layer, find an incorrectly-positioned piece on the bottom layer and swap it with any top-layer piece.</li>
</ul>

After this, you're on to the top layer corners. One algorithm should be sufficient here: `R U R U' R' (U' D) R U' R U R'`. This swaps the UFL and UBL corners. Executing this strategically should lead you to a solved upper layer.  

<strong>2.1 Resolve middle layer parity (if it exists)</strong>  

If the two middle layer pieces you've been holding onto are flipped, then execute the following algorithm: `D' R D R (D' R)2 D' R' U' D R'`. At this point, there will be one yellow corner on the top, and a corresponding purple corner on the bottom. Proceed from the beginning of Step 2 - this shouldn't take long to complete.   

<p>If there's a problem with a particular center, just rotate an adjacent `L/R` or 
`F/B` slice 180 degrees and check again.</p>

<hr>

<strong>3. Move the edges to the correct layers</strong>  

This step takes only one algorithm: `(R U R' U')5`. This swaps the UF and BR edges. Use this as many times as needed, placing an incorrect edge in each place and swapping them.   

<hr>

<strong>4. Move the edges into the correct positions</strong>  

For this, you need two algorithms. These images are courtesy of <a href="http://ruwix.com/twisty-puzzles/gear-cube-extreme-ultimate-how-to-solve-gearcube-solution/" rel="nofollow noreferrer">Ruwix</a>.  

<img src="https://i.stack.imgur.com/SUleU.jpg" alt="enter image description here"> <img src="https://i.stack.imgur.com/IIuAJ.jpg" alt="enter image description here">  

Left: `R2 U R2 U`; Right: `R D R U2 R2 U2 R D' R'`  

This should cover most cases intuitively. Use `U` and `D` to move the pieces in position.  

If you end up with three pieces on one layer that need to be swapped, then do not solve the middle of the three first and you'll be alright. To do this, use the second algorithm twice - the first time will flip two edges on the other layer, but the second time will flip them back.  

<hr>

<strong>5. Rotate the edges into the correct orientations</strong>  

Next, you'll need the following two algorithms:  

<ul>
<li>`(R U)2 (R )4 (U' R')2` (CCW)</li>
<li>`(R U)2 (R')4 (U' R')2` (CW)</li>
</ul>

These two algorithms will do strange things. They both turn the bottom front edge piece in different directions, which is really the focus of them, but they also turn the UL, UB, and UR edges as well.   

The first step is to solve the bottom-layer edges. If the top layer has a solved edge, move it into the UF position. If it doesn't have one, do so immediately after you solve the first bottom-layer piece. For each unsolved edge on the bottom layer, execute the appropriate algorithm above.  

If the cube is not solved, flip it over. Repeat this process for all the edges again.   

If the cube is still not solved, flip it over again. Once you repeat the process again, the edges are guaranteed to be solved.  

#### Answer 2 (score 1)
<a href="http://www.cs.brandeis.edu/~storer/JimPuzzles/RUBIK/GearCube/GearCube.pdf" rel="nofollow">This document provides a much simpler solution!</a>  

In brief:  

<ol>
<li>Solve corners</li>
<li>Solve as much as possible of the edges</li>
<li>Solve the rest using simple moves exchanging edges and centres</li>
</ol>

Here is an extract from the document:  

<ol>
<li>Restore puzzle to be flat (easy - do flips as needed).</li>
<li>Solve the corners (easy - faces cannot rotate 90 degrees).</li>
<li>Use step A to solve as much as possible, use Step B, and repeat until solved (repositioning
the cube as appropriate):
A. Flip the right face clockwise 6 times.
(Exchanges front/rear and top/bottom of the vertical center layer).
B. Flip the bottom face clockwise, flip the right face twice clockwise, flip the bottom face
counter clockwise, flip the right face twice counter clockwise.
(Exchanges front/rear of vertical center layer and left/right centers.)</li>
</ol>

Really easy!  

#### Answer 3 (score 0)
<p>Jaap's Puzzle Page has lots of helpful twisty solutions. Here's the link for the Gear Cube Extreme:
<a href="http://www.jaapsch.net/puzzles/gearcube2.htm" rel="nofollow">http://www.jaapsch.net/puzzles/gearcube2.htm</a></p>

<p>This site also has steps to a solution, with some pictures to assist:
<a href="http://ruwix.com/twisty-puzzles/gear-cube-extreme-ultimate-how-to-solve-gearcube-solution/" rel="nofollow">http://ruwix.com/twisty-puzzles/gear-cube-extreme-ultimate-how-to-solve-gearcube-solution/</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Find 10 triangles in a five pointed star using two straight lines (score [27159](https://stackoverflow.com/q/2325) in 2016)

#### Question
This puzzle consists of counting ten triangles (check three sides for each one, remember that there aren't exist triangles with more than three sides :P ) using two straight lines that cross the figure wherever you want.   

<p>You can't count a triangle that contains other triangles inside. I mean, every triangle has to have an empty area inside.
Here is an example of the game:</p>

<img src="https://i.stack.imgur.com/yFVZu.png" alt="enter image description here">  

<p>Is kind of easy to find nine triangles, but I only could find one solution that solves the problem. 
Good luck! Ask me if you don't understand the rules!</p>

#### Answer accepted (score 27)
I was starting to get disappointed, but finally I found the solution. here it is:  

<img src="https://i.stack.imgur.com/PfflG.png" alt="enter image description here">  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: Solving Rubik's cube with one algorithm (score [26812](https://stackoverflow.com/q/11797) in 2015)

#### Question
<p>I was wondering if it's possible to solve a Rubik's cube just iterating a single algorithm. It doesn't matter how complex the algorithm is (as long as it is less than 1 million moves), nor the time required to solve the cube; I just want to know if there exists a "periodic" sequence of moves that allows to turn any valid scrambled configuration to the solved configuration.
Once you start executing the algorithm, you can't stop it (unless you finish, of course), rotate the cube and start it on another face. </p>

If the question is still unclear, let's make an example. You have to find a sequence like this one, to be repeated an unlimited number of times, that lets you solve any configuration:    

```text
Example: U D R' U' F L' U F' R' U' L D' R  to be repeated 12412183213 times!
```

<em>Note: The above sequence is just an example, 99,999% it's not working!</em>  

<strong>I just ask you to prove whether such sequence exists or not.</strong> If it exists, I would appreciate you to post it, unless it consists of more than 1000 moves.  

#### Answer accepted (score 12)
Does an algorithm exist?  

<blockquote>
  <strong>Yes</strong>. Consider every valid state of the Rubik's cube. It can be brought to the solved state in 20 moves or less. For each state, apply the sequence of moves followed by its inverse. This giant algorithm is guaranteed to solve any cube.  
</blockquote>

Now, does a reasonable-length algorithm exist?  

<blockquote>
  <strong>No</strong>. I will show that any such algorithm should have length at least <strong>34326986725785600</strong>.  
</blockquote>

<strong>Proof</strong>  

<blockquote>
  An algorithm of length L, even if applied an infinite number of times, will only go though 1260L states at most. Applying the algorithm once takes it to at most L states. The important thing is that every element in the <a href="http://en.wikipedia.org/wiki/Rubik%27s_Cube_group">Rubik's cube group</a> has order 1260 or less. As a result, even if you apply the algorithm any number of times, you will not be able to reach more than 1260L states.  
  
  Now, there are 43252003274489856000 valid states of the Rubik's cube. This means that any algorithm which passes through all these states should have length at least 43252003274489856000/1260=34326986725785600  
</blockquote>

#### Answer 2 (score 9)
The answer is no for "iterating"/repeating a single algorithm because the maximum order (of a permutation) of an algorithm is 1260, which is not 43 quintillion.  In other words, no one move sequence can be repeated more than 1260 times before the cube is restored to the original state it was in before iterating that algorithm.  

<hr>

<p>However, the answer is yes for "executing" a single algorithm.  That is, Bruce Norskog constructed a 43 quintillion face quarter turn move algorithm which will go through every single 3x3x3 position exactly once upon completion of execution.
<a href="http://bruce.cubing.net/ham333/rubikhamiltonexplanation.html" rel="nofollow noreferrer">http://bruce.cubing.net/ham333/rubikhamiltonexplanation.html</a></p>

<hr>

In addition, one can use a J-Perm such as <a href="https://alg.cubing.net/?alg=B-_U_F-_U2_B_U-_B-_U2_F_B_U-&amp;view=playback" rel="nofollow noreferrer">B' U F' U2 B U' B' U2 F B U'</a> to construct the move U, for example, by inserting cube rotations.  

For example,  

U =  

B' U F' U2 B U' B' U2 F B U'  

y  

B' U F' U2 B U' B' U2 F B U'  

y  

B' U F' U2 B U' B' U2 F B U'  

y2  

<a href="https://alg.cubing.net/?alg=B-_U_F-_U2_B_U-_B-_U2_F_B_U-_y_B-_U_F-_U2_B_U-_B-_U2_F_B_U-_y_B-_U_F-_U2_B_U-_B-_U2_F_B_U-_y2&amp;view=playback" rel="nofollow noreferrer">Animation</a>  

And thus it follows that if we allow only cube rotations in between this one move sequences, we can create any of the other (6)(3) = 18 different face turn moves to be able to express any move sequence (any solution) in terms of a single J-perm algorithm and cube rotations.  

#### Answer 3 (score 1)
So, you want a general solution (if it exists), meaning a solution that is independent of the current state of the cube.  

Common strategies for solving the cube depend heavily on the current state of the cube. There are around 43 quintillion possible states. Each move brings into view 1 more state, so it seems impossible that a general solution could exist with less than 1 million moves, because you could never even see 1 million states, let alone 43 quintillion.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: Of these five approaches to starting a jigsaw puzzle, which one is fastest? (score [26112](https://stackoverflow.com/q/231) in 2014)

#### Question
Of the following 5 strategies for getting started assembling a jigsaw puzzle:  

<ul>
<li>Assembling the border and connecting other pieces to it</li>
<li>Working your way out from one corner  </li>
<li>Trying to assemble faces or other recognizable parts of the picture</li>
<li>Picking a random piece and working your way out from it  </li>
<li>Finding random pieces that fit together</li>
</ul>

which one or what combination results in the shortest solving time, on average, statistically speaking, according to the experts? Note that this is <em>not</em> a matter of experience. What do the studies on jigsaw-puzzle solving show?  

Be sure to include the reasons why the strategy or combination of strategies is the fastest.  

#### Answer accepted (score 11)
Let's take a 25 x 25 puzzle of a color gradient(also called color ramp and color progression). No two connections the same, even it is off by a millimeter. All the pieces are in a pile, with no way to identify the pieces. The fastest would be the first solution, assembling the border first.  

Number 1, which is the fastest, would require you to sift through the pile and find edges and corners. Since it is a color gradient, the top edges would take little effort and the bottom edge just more so. After finishing that, just grab a piece and put it where you think it goes. If you make a wrong guess, the piece will move around the surface you are building on into the right place, thus solving the puzzle quickest.  

Number 2 is the third fastest. Not as fast as number 1, you would have to go through the pile I mentioned in my introduction to find a corner. It also depends on how you assemble from the corner. Since number 1 is building a border, this would be a block progression, starting from the one corner piece to a corner, 2 edges, and one four sided piece to a corner, 4 edges, and 4 four sided pieces, and so on so forth.  

Number 3 is the second fastest. You would have to find pieces of similar color and, since there are no faces, start off with that. A color gradient would have two identical colors near each other and you could just fit them together.  

Number 4 would be the second slowest, because you would have to find 2, 3, or 4 pieces that fit with it. Since every piece has a certain connection with 2-4 others, you would most likely have to sift through all the pieces to find the right one.  

Number 5 would not be the fastest, but actually the slowest, because you would be required to go through all of the pieces to see ones that fit with another. Unless you got lucky, saying you chose two pieces and they just happened to fit together, you would take the most time trying to fit pieces together rather than putting all of them together.  

#### Answer 2 (score 7)
Efficiency means that you handle each tile as little as possible, and that you make as few mistakes as possible. Ideally you want to pick up a tile and fit it to at least one other rather than put it down again unmatched. Incorrect fitting wastes time when correct matches are rejected and when you have to unpick the mistake.    

From experience, the most efficient strategy has 5 stages. Overall this strategy  is : (i) divide the problem into manageable sub-tasks, and (ii) do the easiest tasks first. The goal is to minimise the choice of tiles and maximise the number of clues at each stage, particularly for the hardest tasks.   

In the early stages colour and pattern are important, because these features are the most easily identified and distinguished. In the last stage when remaining tiles are almost identical in colour, shape becomes the dominant distinguishing feature.   

<ol>
<li>Turn all tiles face up and sort them into about 6 groups. One group is all edge tiles. Another group is the skyline. Other groups are <strong>the major colours</strong> or combinations of colours in the picture. Examples are : sky, sea, foliage, flowers, buildings, roads, people/animals. Then separate out tiles belonging to individual features within each group, in preparation for stage 2.</li>
</ol>

There should be no assembly until stage 1 is complete, because assembly is easiest when all the required tiles are at hand.  

<ol start="2">
<li><strong>Assemble small clusters of high-contrast patterns and easily distinguished features</strong> within each group. Typical features are faces, groups of people, windows, doors, chimneys, printed signs, the skyline, the outlines of buildings. This is your strategy #3. Regions which are mostly featureless such as the sky, or which can only be distinguished in the fine detail such as foliage, should be left to stage 5.  </li>
</ol>

Assembling the border early on provides a framework for placing clusters in their approximate positions.  

<ol start="3">
<li><p><strong>Extend the small clusters outwards</strong> by fitting as many as possible of the remaining tiles from the same colour group. At this stage it is efficient to pick up the most distincitive tile, locate it on the picture, and then place it in its exact place in the correct cluster, like a golfing hole-in-one. This is efficient because you are almost certain to connect it to a cluster, or at least place it beside a cluster. The reverse strategy is also efficient : use the picture and the shape of the gap to identify the missing tile among those remaining. This stage overlaps with the next : </p></li>
<li><p><strong>Join the small clusters together</strong> and attach them to the borders. This requires looking for the <strong>matching of patterns and colours</strong> and also the <strong>interlocking of shapes</strong> at large scales (clusters) and at small scales (individual knobs and holes). </p></li>
<li><p><strong>Fill in the remaining gaps</strong>. Start by completing the picture-matching strategy of stage 3, extending outwards the most easily identified features or patterns, which have the smallest choice of alternatives. Leave until last the largest areas of featureless, uniform pattern or colour, such as the sky, sea, foliage, grass, or dark shadow. These require the laborious testing of numerous options. This is your strategy #1. </p></li>
</ol>

The last stage requires the most organisation, method and attention to detail. Sort the pieces into 5 rows of tiles with 4 knobs down to none, with each row sorted from light to dark. Identify gaps in the puzzle where there are 2 or 3 adjacent tiles, or which have unusual shapes or the fewest remaining tiles of that shade of colour. These give the most confidence of a correct fit, and are the easiest to find.   

At each stage (particularly the last) it is important to <strong>make full use of all the clues available</strong> in order to ensure that the fit is correct : check the exact match of colour and patterns and also the ease with which the tiles fit together. A fit which is too tight or too loose, or leaves an uneven gap around a tile, is almost certainly wrong.   

Beside the picture, the pattern in the shapes of tiles is also a clue, to ensure that a fit is correct, or narrowing the search for a tile. In most jigsaw puzzles four tiles meet at every corner, and there is a repeating pattern of wide or narrow tiles every 6-8 rows or columns.  

<hr>

The above strategy - or one very close to it - is mentioned in most online advice. For example :   

<p><a href="https://hobbylark.com/puzzles/How-To-Do-Jigsaw-Puzzles-Like-an-Expert" rel="noreferrer">HobbyLark : How To Do Jigsaw Puzzles Like an Expert</a><br>
<a href="https://www.puzzlewarehouse.com/jigsaw-puzzle-tips/" rel="noreferrer">Puzzle Warehouse :Jigsaw Puzzle Stragegies - A Guide to becoming a Puzzle Expert</a><br>
<a href="http://www.wikihow.com/Assemble-Jigsaw-Puzzles" rel="noreferrer">wiki : How to Assemble Jigsaw Puzzles</a><br>
<a href="https://www.quora.com/How-does-one-solve-a-jigsaw-puzzle-in-the-fastest-way-possible" rel="noreferrer">Quora : How does one solve a jigsaw puzzle in the fastest way possible?</a><br>
<a href="https://www120.secure.griffith.edu.au/rch/file/6727e872-7c69-ea18-5ffc-44f2bdd1d55d/1/02Chapter1.pdf" rel="noreferrer">Chapter 1 : The Jigsaw Puzzle Problem</a> (a thesis examining automation of solution strategies)</p>

<hr>

I agree with other answers here that your strategies #2, #4 and #5 are inefficient and should be avoided.  

<em>Strategy #2</em> : Starting from one corner can be useful when the only clue is the shape of the pieces. But generally this requires laborious searching and checking of a large number of possible options, which should be left until the options have been narrowed down (stage 4).  

<em>Strategy #4</em> : It is satisfying to pick up an interesting tile, locate it on the picture, and then fit it at once into its exact position in the puzzle. However, this is only likely to succeed when adjacent tiles are already in place.  

<em>Strategy #5</em> : Trying to fit random tiles together is highly inefficient. You are very unlikely to get a match because there are very many options, and you might try the same tiles more than once.   

#### Answer 3 (score 1)
The above answer deals with a gradient puzzle. I don't have an answer analyzed by experts, but from personal experience. I have been working on a 1000 piece puzzle of the Biltmore estate. It is a night scene on Christmas. It has large area of black along the bottom and a large area of sky which is a gradient of blue. This involved using a hybrid technique for different parts for the most efficient solving time.  

The building and  other distinguishable features of the puzzle were quickly put together by randomly finding pieces that match and leaving them in approximate locations and building around them.  

For the gradient part, like Max's answer, Method 1 was used.  

For the solid black part  however, It is brute force technique. Pick one piece try to match it to an open space, if it fits great, if not, put it aside and pick another one to try.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Who will shout first? (score [25976](https://stackoverflow.com/q/11557) in 2018)

#### Question
<img src="https://i.stack.imgur.com/Di3Sd.png" alt="enter image description here">  

There are four guys standing in a line. They need to find out which color their hats are. They can't see their own hat color and only can see to the right. They can't see the person behind the seperation wall. If they know their hat color they can shout it and will win a million dollars. If they're wrong they die.  

Who shouts and therefore wins the million dollars?  

[ I found this puzzle on another site and thought it was worth sharing, not sure if it's allowed ]  

#### Answer accepted (score 5)
<a href="http://en.wikipedia.org/wiki/Prisoners_and_hats_puzzle" rel="nofollow"><strong>Prisoners and hats puzzle</strong></a>  

The answer is   

<blockquote class="spoiler">
  2  
</blockquote>

<p>Since there are only two hats of each color, 1 is able to deduce his color when 2 and 3 are the same color. Though, in this situation 2 and 3 are different, so 1 doesn't shout. 
2, not hearing 1 shouting, deduces that his hat is of the opposite color of 3 and shouts!</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Not the usual "8 5 4 9 1 7 6 3 2 0" sequence puzzle (score [25363](https://stackoverflow.com/q/64791) in )

#### Question
This is not the usual $8, 5, 4, 9, 1, 7, 6, 3, 2, 0$ sequence puzzle, which the answer of the pattern is  

<blockquote class="spoiler">
   Numbers are in alphabetical order  
</blockquote>

The sequence is: $3, 9, 1, 5, 7, 0, 2, 4, 8, 6$. Can you figure the pattern of this sequence?  

#### Answer accepted (score 13)
<blockquote class="spoiler">
   It's in alphabetical order by the last letter. E, E, E, E, N, O, O, R, T, X  
</blockquote>

#### Answer 2 (score 0)
Observation (not full answer):   

<blockquote class="spoiler">
   first 5 numbers are odd, last 5 are even.   
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Lock your computer when you walk away! (score [25090](https://stackoverflow.com/q/32908) in 2016)

#### Question
Well this is strange.    

I forgot to lock my monitor when I walked away from my desk, at work, and one of my co-workers decided to have a little fun.  

When I got back, I found this little C# console app code segment, sitting forefront on my machine.  I ran it a few times, but the results don't really tell me anything.    

Does anyone else know what this could mean??  

```text
void Main()
{ 
  GetEwe();
  Console.WriteLine($"You have been given: {Ewe}");  
}

public enum Directions { Up, Down, Left, Right, Forward, Backward, Diagonally };
public Directions? Ewe;

public Directions GetEwe()
{
  Random rand = new Random(DateTime.Now.Millisecond);
  do
  {
    Ewe = 
    (
      from direction in Enum.GetValues(typeof(Directions)).OfType<Directions>()
      //let u = Directions.Down     
      select direction
    ).ElementAt(rand.Next(0, Enum.GetNames(typeof(Directions)).Length));
  }
  while (Ewe == Directions.Up);
  return Ewe.Value;  Around();
}

private void Around()
{
  Ewe = null;
}
```

#### Answer accepted (score 173)
I guess this is  

<blockquote class="spoiler">
    A <a href="https://www.youtube.com/watch?v=DLzxrzFCyOs">rickroll</a>  
</blockquote>

Because  

<blockquote class="spoiler">
  <p> This code is <strong>never going to give you</strong> (Ewe) <strong>up</strong>, because the loop will
 assign a random direction to ewe as long as it is up<br>
 It is <strong>never going to let you</strong> (u) <strong>down</strong>, because the line`//let u = Directions.Down` is just a comment.<br>
 Since the return statement happens before calling `Around()`, it is obviously <strong>never going to run around</strong>.<br>
 <strong>And</strong>, because the method `Around()` is never called, it is also never going to "<strong>desert you</strong>", because it will never assign a null-value to Ewe.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Can you solve this? Answer isn't 19 or 26 (score [24916](https://stackoverflow.com/q/56750) in )

#### Question
I've found this viral image online, can you solve it? It is tricky, but simpler than you think.  

<a href="https://i.stack.imgur.com/YXuCIl.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/YXuCIl.png" alt="People are losing their shit over this viral riddle! 45, 23, 10, ??; Can you solve that? Answer isn&#39;t 19 or 26"></a>  

<sup>Source: Originally found it at <a href="https://www.facebook.com/brainperformancecenters" rel="nofollow noreferrer">CBP - Brain Centers</a> Facebook Page.</sup>  

#### Answer accepted (score 10)
My best guess is  

<blockquote class="spoiler">
   38  
</blockquote>

but it requires a lot of assumptions.    

The first line is  

<blockquote class="spoiler">
   15+15+15=45    
</blockquote>

The second is  

<blockquote class="spoiler">
   4+4+15=23    
</blockquote>

The third is  

<blockquote class="spoiler">
   4+3+3=10  
</blockquote>

The trick is  

<blockquote class="spoiler">
  <p> None of the symbols in the 4th are present in the previous three lines, there are 3 bananas in the bunch instead of 4, the clock points to 2 rather than 3, and the geometric shape is missing the square.<br>
 The square has 4 points, leaving 11 points of the 15, the rest of the numbers can be assumed to be adjusted as they are pointed to as well, making the final equation 2+3+3*11=38</p>
</blockquote>

#### Answer 2 (score 10)
My best guess is  

<blockquote class="spoiler">
   38  
</blockquote>

but it requires a lot of assumptions.    

The first line is  

<blockquote class="spoiler">
   15+15+15=45    
</blockquote>

The second is  

<blockquote class="spoiler">
   4+4+15=23    
</blockquote>

The third is  

<blockquote class="spoiler">
   4+3+3=10  
</blockquote>

The trick is  

<blockquote class="spoiler">
  <p> None of the symbols in the 4th are present in the previous three lines, there are 3 bananas in the bunch instead of 4, the clock points to 2 rather than 3, and the geometric shape is missing the square.<br>
 The square has 4 points, leaving 11 points of the 15, the rest of the numbers can be assumed to be adjusted as they are pointed to as well, making the final equation 2+3+3*11=38</p>
</blockquote>

#### Answer 3 (score 4)
I think it's  

<blockquote class="spoiler">
   38  
</blockquote>

Because  

<blockquote class="spoiler">
   every banana, every hour and every angle of a polygon represents one. Then it's just basic arithmetics.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: Is this Tetris puzzle solvable? (score [24915](https://stackoverflow.com/q/15529) in 2019)

#### Question
As a birthday present last year, I received some fridge magnets. They didn't come as a puzzle, so I don't know if they have a solution, but I made a puzzle out of them anyway.  

The magnets are tetrominoes. There are 7 of each shape. Is it possible to arrange them into a 7x28 rectangle so that they are all used and all inside the rectangle?  

The closest I have managed is this:  

<img src="https://i.stack.imgur.com/2mXcu.jpg" alt="enter image description here">  

#### Answer accepted (score 340)
It is impossible.  

<p>Proof:<br>
Let the $7\times 28$ area be painted with black and white squares in a checkerboard pattern. Every piece will cover $2$ black and $2$ white squares, except the T-piece, which covers $3$ of one color and $1$ of another. Since there are $7$ T-pieces, a tiling that uses every piece cannot cover the same number of black and white squares. Since the board contains the same number of black and white squares, it is impossible.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Some Rebus puzzles (score [24737](https://stackoverflow.com/q/47279) in 2017)

#### Question
So a rebus puzzle is basically where you have to work out the 'hidden' meaning. For example    

<a href="https://i.stack.imgur.com/HFWTm.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/HFWTm.png" alt="enter image description here"></a>    

would be    

<blockquote class="spoiler">
   TH under STORM (because the TH is under the STORM) or Thunderstorm  
</blockquote>

So I've made 6 puzzles for you to enjoy :) Good luck!    

<a href="https://i.stack.imgur.com/w5WYa.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/w5WYa.png" alt="enter image description here"></a>  

<hr>

<a href="https://puzzling.stackexchange.com/questions/47314/some-more-rebus-puzzles">Part II</a> and <a href="https://puzzling.stackexchange.com/questions/47641/even-more-rebus-puzzles">III</a>  

#### Answer accepted (score 14)
From left to right, first row then second row:  

<blockquote class="spoiler">
  <p>Fishin(g) for compliments<br>
Third time lucky<br>
Four leaf clover (credit @silenus)<br>
There is no I in TEAM<br>
An inside job<br>
 i &lt;3 u</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: How do I solve these 3x3 magic squares? (score [24704](https://stackoverflow.com/q/14695) in 2015)

#### Question
I'm doing 3x3 magic squares. Here are the squares I'm working on:  

```text
|   | 5 |   |
|   |   |   |
| 8 |   |   |
```

The values must be between 3 and 12, and each line must add to 21.  

Here's another one:   

```text
|   | 9 |   |
|   |   | 3 |
|   |   |   |
```

For this one, the boundaries are 3-11. As with the last one, each line total must add to 21.  

#### Answer accepted (score 13)
In general, any $n\times n$ magic square of range [1, $n^2$] with <strong>odd number</strong> $n$ can be solved using the following algorithm:  

<ol>
<li>Start at the middle grid in the bottom row. This is your 1.</li>
<li>Move downwards and to the right by one grid. If this move results in a position outside the square, wrap around to the beginning of the row (or column).</li>
<li>If 2 cannot be performed (i.e. the grid is already occupied or you are at the bottom-right corner), move upwards by one grid instead.</li>
<li>Repeat 2 (or 3) until all numbers are filled.</li>
</ol>

Illustration using $n=3$. (For cells 2 and 3 the position before wrapping is shown in parentheses.)  

```text
|   |   |   |
|   |   |   |
|   | 1 |   | // start here

|   |   | 2 |
|   |   |   |
|   | 1 |   | // move to the right and then down.
         (2)  // Because moving down brings us outside the square,
              // we wrap around to the start of the column

|   |   | 2 |
| 3 |   |   | (3)
|   | 1 |   | // move to the right and down.
              // moving right brings us outside, so wrap around to start of row

| 4 |   | 2 |
| 3 |   |   |
|   | 1 |   | // cannot move down and right because that is occupied
              // so we move up instead

| 4 |   | 2 |
| 3 | 5 |   |
|   | 1 |   | // move down and right

| 4 |   | 2 |
| 3 | 5 |   |
|   | 1 | 6 | // move down and right

| 4 |   | 2 |
| 3 | 5 | 7 |
|   | 1 | 6 | // cannot move down and right, so move up

| 4 |   | 2 |
| 3 | 5 | 7 |
| 8 | 1 | 6 | // move down and right, wrap around to start of row

| 4 | 9 | 2 |
| 3 | 5 | 7 |
| 8 | 1 | 6 | // move down and right, wrap around to start of column
```

Now, if you need to solve your magic square that starts with 3, simply add 2 to all cells of this standard square. Then rotate and/or reflect it until you get one where the numbers match your given ones.  

For example, consider your first square (assuming we can omit 12):  

```text
|   | 5 |   |
|   |   |   |
| 8 |   |   |
```

We first add 2 to all elements of our standard square:  

```text
| 6  | 11 | 4  |
| 5  | 7  | 9  |
| 10 | 3  | 8  |
```

Then rotate clockwise by 90 degrees:  

```text
| 10 | 5  | 6  |
| 3  | 7  | 11 |
| 8  | 9  | 4  |
```

Your first square solved.  

Further reading: <a href="http://mathworld.wolfram.com/MagicSquare.html">Magic Square from Wolfram MathWorld</a>, which includes methods for solving even squares as well.  

#### Answer 2 (score 3)
Here is an alternative technique. Consider your first magic square:  

```text
| a | 5 | b |
| c | d | e |
| 8 | f | g |
```

I filled in the empty cells with the variables $a$ through $g$. We will create a system of equations to solve for these seven variables.  

We know that each row must sum to 21. As a result, we can write the following three equations:  

<ul>
<li>1st row: $a + 5 + b = 21$</li>
<li>2nd row: $c + d + e = 21$</li>
<li>3rd row: $8 + f + g = 21$</li>
</ul>

Likewise, every column and diagonal must sum to 21, giving us five more equations:  

<ul>
<li>1st column: $a + c + 8 = 21$</li>
<li>2nd column: $5 + d + f = 21$</li>
<li>3rd column: $b + e + g = 21$</li>
<li>\ diagonal: $a + d + g = 21$</li>
<li>/ diagonal: $8 + d + b = 21$</li>
</ul>

So we now have 8 equations with 7 unknowns. We can select any seven of them and apply the usual equation-solving techniques to find the values of $a$, $b$, $c$, $d$, $e$, $f$, and $g$, giving us the solution to the magic square.  

#### Answer 3 (score 1)
The answer for the first puzzle is this:  

```text
|10 | 5 | 6 |
| 3 | 7 |11 |
| 8 | 9 | 4 |

| A | B | C |
| D | E | F |
| G | H | I |

| A | 5 | C |
| D | E | F |
| 8 | H | I |
```

Range 3 - 12.  

There is one extra integer.  

Neither 11 or 12 can be in the same row, column or diagonal as 8 since the other number would be 1 or 2 which is outside the range.  Therefore F is 11 or 12 and the other is the integer that is not included.  

Neither 3 nor 4 can be in the same row or column as 5 since the other number would be 12 or 13 and 13 is outside the range and 12 must be in F if it is in the puzzle.  Therefore D and I are 3 and 4.  Continuing H and A are 10 and 9 and E and C are 6 and 7.  

I cannot be 3 since either E would be 6 or 7 and A would be 11 or 12 and 11 and 12 is in F or not in the puzzle.  Therfore I = 4.  The rest of the puzzle fills itself in from there.  The number not included is 12.  

</section>

