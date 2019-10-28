---
title: Ai <- StackExchange top 100
category: ai
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: Could a paradox kill an AI? (score [39816](https://stackoverflow.com/q/1768) in 2018)

#### Question
In <a href="https://en.wikipedia.org/wiki/Portal_2" rel="noreferrer">Portal 2</a> we see that AI's can be "killed" by thinking about a paradox.  

<a href="https://i.stack.imgur.com/wkUSC.png" rel="noreferrer"><img src="https://i.stack.imgur.com/wkUSC.png" alt="Portal Paradox Poster"></a>  

I assume this works by forcing the AI into an infinite loop which would essentially "freeze" the computer's consciousness.  

<strong>Questions:</strong> Would this confuse the AI technology we have today to the point of destroying it? <br> If so, why? And if not, could it be possible in the future?  

#### Answer accepted (score 126)
This classic problem exhibits a basic misunderstanding of what an <a href="https://en.wikipedia.org/wiki/Artificial_general_intelligence">artificial general intelligence</a> would likely entail. First, consider this programmer's joke:  

<blockquote>
  The programmer's wife couldn't take it anymore. Every discussion with her husband turned into an argument over semantics, picking over every piece of trivial detail. One day she sent him to the grocery store to pick up some eggs. On his way out the door,  she said, <strong><em>"While you are there, pick up milk."</em></strong>  
  
  And he never returned.  
</blockquote>

It's a cute play on words, but it isn't terribly realistic.  

You are assuming because AI is being executed by a computer, it must exhibit this same level of linear, unwavering pedantry outlined in this joke. But AI isn't simply some long-winded computer program hard-coded with enough if-statements and while-loops to account for every possible input and follow the prescribe results.   

<pre>while (command not completed)
     find solution()
</pre>

This would not be strong AI.   

In any classic definition of <em>artificial general intelligence</em>, you are creating a system that mimics some form of cognition that exhibits problem solving and <em>adaptive learning</em> (&larr;note this phrase here). I would suggest that any AI that could get stuck in such an "infinite loop" isn't a learning AI at all. <strong>It's just a buggy inference engine.</strong>   

Essentially, you are endowing a program of currently-unreachable sophistication with an inability to postulate if there is a solution to a simple problem at all. I can just as easily say "walk through that closed door" or "pick yourself up off the ground" or even "turn on that pencil" &mdash; and present a similar conundrum.   

<blockquote>
  "Everything I say is false." &mdash; <a href="https://en.wikipedia.org/wiki/Liar_paradox">The Liar's Paradox</a>  
</blockquote>

#### Answer 2 (score 42)
This popular meme originated in the era of 'Good Old Fashioned AI' (GOFAI), when the belief was that intelligence could usefully be defined entirely in terms of logic.  

The meme seems to rely on the AI parsing commands using a theorem prover, the idea presumably being that it's driven into some kind of infinite loop by trying to prove an unprovable or inconsistent statement.  

Nowadays, GOFAI methods have been replaced by 'environment and percept sequences', which are not generally characterized in such an inflexible fashion. It would not take a great deal of sophisticated metacognition for a robot to observe that, after a while, its deliberations were getting in the way of useful work.  

Rodney Brooks touched on this when speaking about the behavior of the robot in Spielberg's AI film, (which waited patiently for 5,000 years), saying something like "My robots wouldn't do that - they'd get bored".   

EDIT: If you <em>really</em> want to kill an AI that operates in terms of percepts, you'll need to work quite a bit harder. <a href="http://arxiv.org/pdf/1606.00652.pdf" rel="noreferrer">This paper</a> (which was mentioned in <a href="https://ai.stackexchange.com/questions/1404/what-is-meant-by-death-in-this-paper">this question</a>) discusses what notions of death/suicide might mean in such a case.  

EDIT2: Douglas Hofstadter has written quite extensively around this subject, using terms such as 'JOOTSing' ('Jumping Out Of The System') and 'anti-Sphexishness', the latter referring to the loopy automata-like behaviour of the <a href="https://en.wikipedia.org/wiki/Sphex" rel="noreferrer">Sphex Wasp</a> (though the reality of this behaviour has also been <a href="http://www.academia.edu/4034267/The_Sphex_story_How_the_cognitive_sciences_kept_repeating_an_old_and_questionable_anecdote" rel="noreferrer">questioned</a>).  

#### Answer 3 (score 22)
I see several good answers, but most are assuming that <strong>inferential infinite loop</strong> is a thing of the past, only related to logical AI (the famous GOFAI). But it's not.  

An infinite loop can happen in any program, whether it's adaptive or not. And as @SQLServerSteve pointed out, humans can also get stuck in obsessions and paradoxes.  

Modern approaches are mainly using probabilistic approaches. As they are using floating numbers, it seems to people that they are not vulnerable to reasoning failures (since most are devised in binary form), but that's wrong: as long as you are reasoning, some intrinsic pitfalls can always be found that are caused by the very mechanisms of your reasoning system. Of course, probabilistic approaches are less vulnerable than monotonic logic approaches, but they are still vulnerable. If there was a single reasoning system without any paradoxes, much of philosophy would have disappeared by now.  

For example, it's well known that Bayesian graphs must be acyclic, because a cycle will make the propagation algorithm fail horribly. There are inference algorithms such as Loopy Belief Propagation that may still work in these instances, but the result is not guaranteed at all and can give you very weird conclusions.  

On the other hand, modern logical AI overcame the most common logical paradoxes you will see, by devising new logical paradigms such as <a href="http://plato.stanford.edu/entries/logic-nonmonotonic/">non-monotonic logics</a>. In fact, they are even used to investigate <a href="http://csjarchive.cogsci.rpi.edu/proceedings/2007/docs/p1013.pdf">ethical machines</a>, which are autonomous agents capable of solving dilemmas by themselves. Of course, they also suffer from some paradoxes, but these degenerate cases are way more complex.  

The final point is that inferential infinite loop can happen in any reasoning system, whatever the technology used. But the "paradoxes", or rather the degenerate cases as they are technically called, that can trigger these infinite loops will be different for each system depending on the technology AND implementation (AND what the machine learned if it is adaptive).  

OP's example may work only on old logical systems such as propositional logic. But ask this to a Bayesian network and you will also get an inferential infinite loop:  

```text
- There are two kinds of ice creams: vanilla or chocolate.
- There's more chances (0.7) I take vanilla ice cream if you take chocolate.
- There's more chances (0.7) you take vanilla ice cream if I take chocolate.
- What is the probability that you (the machine) take a vanilla ice cream?
```

And wait until the end of the universe to get an answer...  

Disclaimer: I wrote an article about ethical machines and dilemmas (which is close but not exactly the same as paradoxes: dilemmas are problems where no solution is objectively better than any other but you can still choose, whereas paradoxes are problems that are impossible to solve for the inference system you use).  

/EDIT: How to fix inferential infinite loop.  

Here are some extrapolary propositions that are not sure to work at all!  

<ul>
<li>Combine multiple reasoning systems with different pitfalls, so if one fails you can use another. No reasoning system is perfect, but a combination of reasoning systems can be resilient enough. It's actually thought that the human brain is using multiple inferential technics (associative + precise bayesian/logical inference). Associative methods are HIGHLY resilient, but they can give non-sensical results in some cases, hence why the need for a more precise inference.</li>
<li>Parallel programming: the human brain is highly parallel, so you never really get into a single task, there are always multiple background computations in true parallelism. A machine robust to paradoxes should foremost be able to continue other tasks even if the reasoning gets stuck on one. For example, a robust machine must always survive and face imminent dangers, whereas a weak machine would get stuck in the reasoning and "forget" to do anything else. This is different from a timeout, because the task that got stuck isn't stopped, it's just that it doesn't prevent other tasks from being led and fulfilled.</li>
</ul>

As you can see, this problem of inferential loops is still a hot topic in AI research, there will probably never be a perfect solution (<a href="https://en.wikipedia.org/wiki/No_free_lunch_theorem">no free lunch</a>, <a href="https://en.wikipedia.org/wiki/No_Silver_Bullet">no silver bullet</a>, <a href="https://en.wikipedia.org/wiki/One_size_fits_all">no one size fits all</a>), but it's advancing and that's very exciting!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How to select number of hidden layers and number of memory cells in an LSTM? (score [38318](https://stackoverflow.com/q/3156) in 2019)

#### Question
I am trying to find some existing research on how to select the number of hidden layers and the size of these of an LSTM-based RNN.  

Is there an article where this problem is being investigated, i.e., how many memory cells should one use? I assume it totaly depends on the application and in which context the model is being used, but what does the research say?  

#### Answer 2 (score 14)
Your question is quite broad, but here are some tips:  

For feedforward networks, see <a href="https://stats.stackexchange.com/questions/181/how-to-choose-the-number-of-hidden-layers-and-nodes-in-a-feedforward-neural-netw">this question</a>:  

<blockquote>
  <p><a href="https://stats.stackexchange.com/a/1097/15974">@doug's answer</a> has
  worked for me. There's one additional rule of thumb that helps for
  supervised learning problems. The upper bound on the number of hidden
  neurons that won't result in over-fitting is:</p>
  
  <span class="math-container">$$N_h = \frac{N_s} {(\alpha * (N_i + N_o))}$$</span>  
  
  <p><span class="math-container">$N_i$</span> = number of input neurons.    <span class="math-container">$N_o$</span> = number of output neurons. 
  <span class="math-container">$N_s$</span> = number of samples in training data set.   <span class="math-container">$\alpha$</span> = an
  arbitrary scaling factor usually 2-10.<br>
                      <a href="http://www.solver.com/training-artificial-neural-network-intro" rel="noreferrer">Others recommend</a>
  setting <span class="math-container">$alpha$</span> to a value between 5 and 10, but I find a value of 2
  will often work without overfitting. As explained by this <a href="http://hagan.okstate.edu/NNDesign.pdf#page=469" rel="noreferrer">excellent
  NN Design text</a>, you
  want to limit the number of free parameters in your model (its
  <a href="https://stats.stackexchange.com/q/57027/15974">degree</a> or number of
  nonzero weights) to a small portion of the degrees of freedom in your
  data. The degrees of freedom in your data is the number samples *
  degrees of freedom (dimensions) in each sample or <span class="math-container">$N_s * (N_i + N_o)$</span>
  (assuming they're all independent). So <span class="math-container">$\alpha$</span> is a way to indicate
  how general you want your model to be, or how much you want to prevent
  overfitting.</p>
  
  <p>For an automated procedure you'd start with an alpha of 2 (twice as
  many degrees of freedom in your training data as your model) and work
  your way up to 10 if the error for training data is significantly
  smaller than for the cross-validation data set.</p>
</blockquote>

And specifically on LSTM's, you might want to check out <a href="https://www.reddit.com/r/MachineLearning/comments/4behuh/does_the_number_of_layers_in_an_lstm_network/" rel="noreferrer">this</a>.  

But the main point: <strong>there is no rule for the amount of hidden nodes you should use, it is something you have to figure out for each case by trial and error</strong>.  

#### Answer 3 (score 6)
Select the number of hidden layers and number of memory cells in LSTM is always depend on  application domain and context where you want to apply this LSTM.   

<p>For hidden Layers.
The introduction of hidden layer(s) makes it possible for the network to exhibit non-linear behaviour. </p>

The optimal number of hidden units could easily be smaller than the number of inputs, there is no rule like multiply the number of inputs with N... If you have a lot of training examples, you can use multiple hidden units, but sometimes just 2 hidden units works best with little data. Usually people use one hidden layer for simple tasks, but nowadays research in deep neural network architectures show that many hidden layers can be fruitful for difficult object, handwritten character, and face recognition problems.  

<strong>`I assume it totally depends on the application and in which context the model is being used.`</strong>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: What is the difference between a Convolutional Neural Network and a regular Neural Network? (score [28045](https://stackoverflow.com/q/5546) in )

#### Question
I've seen these terms thrown around this site a lot, specifically in the tags <a href="/questions/tagged/convolutional-neural-networks" class="post-tag" title="show questions tagged &#39;convolutional-neural-networks&#39;" rel="tag">convolutional-neural-networks</a> and <a href="/questions/tagged/neural-networks" class="post-tag" title="show questions tagged &#39;neural-networks&#39;" rel="tag">neural-networks</a>.  

I know that a Neural Network is a system based loosely on the human brain. But what's the difference between a <em>Convolutional</em> Neural Network and a regular Neural Network? Is one just a lot more complicated and, ahem, <em>convoluted</em> than the other?   

#### Answer 2 (score 22)
<p><strong>TLDR:</strong> 
The convolutional-neural-network is a subclass of neural-networks which have at least one convolution layer. They are great for capturing local information (e.g. neighbor pixels in an image or surrounding words in a text) as well as reducing the complexity of the model (faster training, needs fewer samples, reduces the chance of overfitting). </p>

See the following chart that depicts the several neural-networks architectures including deep-conventional-neural-networks: <a href="https://i.stack.imgur.com/LgmYv.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/LgmYv.png" alt="visualization"></a>.  

<hr>

<strong>Neural Networks (NN)</strong>, or more precisely <strong>Artificial Neural Networks (ANN)</strong>, is a class of Machine Learning algorithms that recently received a lot of attention (again!) due to the availability of Big Data and fast computing facilities (most of Deep Learning algorithms are essentially different variations of ANN).    

The class of ANN covers several architectures including <strong>Convolutional Neural Networks</strong> (<a href="https://en.wikipedia.org/wiki/Convolutional_neural_network" rel="nofollow noreferrer">CNN</a>), Recurrent Neural Networks (<a href="https://en.wikipedia.org/wiki/Recurrent_neural_network" rel="nofollow noreferrer">RNN</a>) eg <a href="https://en.wikipedia.org/wiki/Long_short-term_memory" rel="nofollow noreferrer">LSTM</a> and <a href="https://en.wikipedia.org/wiki/Gated_recurrent_unit" rel="nofollow noreferrer">GRU</a>, <a href="https://en.wikipedia.org/wiki/Autoencoder" rel="nofollow noreferrer">Autoencoders</a>, and <a href="https://en.wikipedia.org/wiki/Deep_belief_network" rel="nofollow noreferrer">Deep Belief Networks</a>. Therefore, CNN is just one kind of ANN.  

Generally speaking, an ANN is a collection of connected and tunable units (a.k.a. nodes, neurons, and artificial neurons) which can pass a signal (usually a real-valued number) from a unit to another. The number of (layers of) units, their types, and the way they are connected to each other is called the network architecture.  

A CNN, in specific, has one or more layers of <strong><em>convolution</em></strong> units. A convolution unit receives its input from multiple units from the previous layer which together create a proximity. Therefore, the input units (that form a small neighborhood) share their weights.   

The convolution units (as well as pooling units) are especially beneficial as:  

<ul>
<li>They reduce the number of units in the network (since they are <em>many-to-one mappings</em>). This means, there are fewer parameters to learn which reduces the chance of overfitting as the model would be less complex than a fully connected network.</li>
<li>They consider the context/shared information in the small neighborhoods. This future is very important in many applications such as image, video, text, and speech processing/mining as the neighboring inputs (eg pixels, frames, words, etc) usually carry related information.  </li>
</ul>

Read the followings for more information about (deep) CNNs:  

<ol>
<li><a href="https://www.cs.toronto.edu/~kriz/imagenet_classification_with_deep_convolutional.pdf" rel="nofollow noreferrer">ImageNet Classification with Deep Convolutional Neural Networks</a></li>
<li><a href="https://arxiv.org/abs/1409.4842" rel="nofollow noreferrer">Going Deeper with Convolutions</a></li>
</ol>

<hr>

p.s. ANN is not <em>"a system based loosely on the human brain"</em> but rather a <strong>class</strong> of systems <strong>inspired</strong> by the neuron connections exist in animal brains.  

#### Answer 3 (score 8)
Convolutional Neural Networks (CNNs) are neural networks with architectural constraints to reduce computational complexity and ensure translational invariance (the network interprets input patterns the same regardless of translation— in terms of image recognition: a banana is a banana regardless of where it is in the image). Convolutional Neural Networks have three important architectural features.  

<strong><em>Local Connectivity:</em></strong> Neurons in one layer are only connected to neurons in the next layer that are spatially close to them. This design trims the vast majority of connections between consecutive layers, but keeps the ones that carry the most useful information. The assumption made here is that the input data has spatial significance, or in the example of computer vision, the relationship between two distant pixels is probably less significant than two close neighbors.  

<strong><em>Shared Weights:</em></strong> This is the concept that makes CNNs "convolutional." By forcing the neurons of one layer to share weights, the forward pass (feeding data through the network) becomes the equivalent of convolving a filter over the image to produce a new image. The training of CNNs then becomes the task of learning filters (deciding what features you should look for in the data.)  

<strong><em>Pooling and ReLU:</em></strong> CNNs have two non-linearities: pooling layers and ReLU functions. Pooling layers consider a block of input data and simply pass on the maximum value. Doing this reduces the size of the output and requires no added parameters to learn, so pooling layers are often used to regulate the size of the network and keep the system below a computational limit. The ReLU function takes one input, x, and returns the maximum of {0, x}. `ReLU(x) = argmax(x, 0)`. This introduces a similar effect to tanh(x) or sigmoid(x) as non-linearities to increase the model's expressive power.  

<hr>

<h5>Further Reading</h2>

As another answer mentioned, Stanford's CS 231n course covers this in detail. Check out <a href="http://cs231n.github.io/convolutional-networks/#overview" rel="noreferrer">this written guide</a> and <a href="https://www.youtube.com/watch?v=bNb2fEVKeEo&amp;t=0s&amp;list=PL3FW7Lu3i5JvHM8ljYj-zLfQRF3EO8sYv&amp;index=5" rel="noreferrer">this lecture</a> for more information. Blog posts like <a href="https://adeshpande3.github.io/adeshpande3.github.io/A-Beginner%27s-Guide-To-Understanding-Convolutional-Neural-Networks/" rel="noreferrer">this one</a> and <a href="https://ujjwalkarn.me/2016/08/11/intuitive-explanation-convnets/" rel="noreferrer">this one</a> are also very helpful.  

If you're still curious why CNNs have the structure that they do, I suggest reading <a href="http://www.dengfanxin.cn/wp-content/uploads/2016/03/1998Lecun.pdf" rel="noreferrer">the paper that introduced them</a> though this is quite long, and perhaps checking out <a href="https://www.youtube.com/watch?v=fKk9KhGRBdI" rel="noreferrer">this discussion</a> between Yann Lecun and Christopher Manning about innate priors (the assumptions we make when we design the architecture of a model).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How can neural networks deal with varying input sizes? (score [27131](https://stackoverflow.com/q/2008) in 2019)

#### Question
As far as I can tell, neural networks have a <strong>fixed number of neurons</strong> in the input layer.  

<p>If neural networks are used in a context like NLP, sentences or blocks of text of varying sizes are fed to a network. 
How is the <strong>varying input size</strong> reconciled with the <strong>fixed size</strong> of the input layer of the network? In other words, how is such a network made flexible enough to deal with an input that might be anywhere from one word to multiple pages of text?</p>

If my assumption of a fixed number of input neurons is wrong and new input neurons are added to/removed from the network to match the input size I don't see how these can ever be trained.  

I give the example of NLP, but lots of problems have an inherently unpredictable input size. I'm interested in the general approach for dealing with this.  

For images, it's clear you can up/downsample to a fixed size, but, for text, this seems to be an impossible approach since adding/removing text changes the meaning of the original input.  

#### Answer accepted (score 35)
Three possibilities come to mind.  

The easiest is the <strong>zero-padding</strong>. Basically, you take a rather big input size and just add zeroes if your concrete input is too small. Of course, this is pretty limited and certainly not useful if your input ranges from a few words to full texts.  

<a href="https://en.wikipedia.org/wiki/Recurrent_neural_network" rel="noreferrer">Recurrent NNs</a> (RNN) are a very natural NN to choose if you have texts of varying size as input. You input words as <strong>word vectors</strong> (or embeddings) just one after another and the internal state of the RNN is supposed to encode the meaning of the full string of words. <a href="http://www.iro.umontreal.ca/~lisa/pointeurs/RNNSpokenLanguage2013.pdf" rel="noreferrer">This is one</a> of the earlier papers.  

Another possibility is using <a href="https://en.wikipedia.org/wiki/Recursive_neural_network" rel="noreferrer"><strong>recursive NNs</strong></a>. This is basically a form of preprocessing in which a text is recursively reduced to a smaller number of word vectors until only one is left - your input, which is supposed to encode the whole text. This makes a lot of sense from a linguistic point of view if your input consists of sentences (which can vary a lot in size), because sentences are structured recursively. For example, the word vector for "the man", should be similar to the word vector for "the man who mistook his wife for a hat", because noun phrases act like nouns, etc. Often, you can use linguistic information to guide your recursion on the sentence. If you want to go way beyond the Wikipedia article, <a href="http://nlp.stanford.edu/~socherr/thesis.pdf" rel="noreferrer">this is probably a good start</a>.  

#### Answer 2 (score 12)
Others already mentioned:  

<ul>
<li>zero padding</li>
<li>RNN</li>
<li>recursive NN</li>
</ul>

so I will add another possibility: using convolutions different number of times depending on the size of input. Here is an <a href="http://www.deeplearningbook.org/contents/convnets.html" rel="noreferrer">excellent book</a> which backs up this approach:  

<blockquote>
  <p>Consider a collection of images, where each image has a different
  width and height. It is unclear how to model such inputs with a weight
  matrix of fixed size. Convolution is straightforward to apply; the
  kernel is simply applied a different number of times depending on the
  size of the input, and the output of the convolution operation scales
  accordingly.</p>
</blockquote>

Taken from page 360. You can read it further to see some other approaches.  

#### Answer 3 (score 7)
In NLP you have an inherent ordering of the inputs so RNNs are a natural choice.  

For variable sized inputs where there is no particular ordering among the inputs, one can design networks which:  

<ol>
<li>use a repetition of the same subnetwork for each of the groups of inputs (i.e. with shared weights). This repeated subnetwork learns a representation of the (groups of) inputs.</li>
<li>use an operation on the representation of the inputs which has the same symmetry as the inputs. For order invariant data, averaging the representations from the input networks is a possible choice.</li>
<li>use an output network to minimize the loss function at the output based on the combination of the representations of the input.</li>
</ol>

The structure looks as follows:  

<a href="https://i.stack.imgur.com/x4cCi.png" rel="noreferrer"><img src="https://i.stack.imgur.com/x4cCi.png" alt="network structure"></a>  

Similar networks have been used to learn the relations between objects (<a href="https://arxiv.org/abs/1702.05068" rel="noreferrer">arxiv:1702.05068</a>).  

A simple example of how to learning the sample variance of a variable sized set of values is given <a href="https://medium.com/@andre.holzner/learning-a-function-with-a-variable-number-of-inputs-with-pytorch-c487e35d4dba" rel="noreferrer">here</a> (disclaimer: I'm the author of the linked article).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Why is Python such a popular language in the AI field? (score [25775](https://stackoverflow.com/q/3494) in 2019)

#### Question
First of all, I'm a beginner studying AI and this is not an opinion oriented question or one to compare programming languages. I'm not saying that is the best language. But the fact is that most of the famous AI frameworks have primary support for Python. They can even be multilanguage supported, for example, TensorFlow that support Python, C++ or CNTK from Microsoft that support C# and C++, but the most used is Python (I mean more documentation, examples, bigger community, support etc). Even if you choose C# (developed by Microsoft and my primary programming language) you must have the Python environment set up.  

I read in other forums that Python is preferred for AI because the code is simplified and cleaner, good for fast prototyping.  

I was watching a movie with AI thematics (Ex_Machina). In some scene, the main character hacks the interface of the house automation. Guess which language was on the scene? Python.  

So what is the big deal, the relationship between Python and AI?  

#### Answer accepted (score 32)
<p>Python comes with a huge amount of inbuilt libraries. Many of the libraries are for Artificial Intelligence and Machine Learning. Some of the libraries are Tensorflow (which is high-level neural network library), scikit-learn (for data mining, data analysis and machine learning), pylearn2 (more flexible than scikit-learn), etc. The list keeps going and never ends.<br><br>
You can find some libraries <a href="https://wiki.python.org/moin/PythonForArtificialIntelligence" rel="noreferrer">here</a>.<br><br>
Python has an easy implementation for OpenCV. What makes Python favourite for everyone is its powerful and easy implementation.<br>
For other languages, students and researchers need to get to know the language before getting into ML or AI with that language. <strong>This is not the case with python</strong>. Even a programmer with very basic knowledge can easily handle python. Apart from that, the time someone spends on writing and debugging code in python is way less when compared to C, C++ or Java. This is exactly what the students of AI and ML want. <strong>They don't want to spend time on debugging the code for syntax errors, they want to spend more time on their algorithms and heuristics related to AI and ML</strong>.<br>
<strong>Not just the libraries but their tutorials, handling of interfaces are easily available online</strong>. People build their own libraries and upload them on GitHub or elsewhere to be used by others.<br><br>
All these features make Python suitable for them.</p>

#### Answer 2 (score 24)
Practically all of the most popular and widely used deep-learning frameworks are implemented in Python on the surface and C/C++ under the hood.  

I think the main reason is that Python is widely used in scientific and research communities, because it's easy to experiment with new ideas and code prototypes quickly in a language with minimal syntax like Python.  

<p>Moreover there may be another reason. As I can see, most of the over-hyped online courses on AI are pushing Python because it is easy for newbie programmers. AI is the new marketing hot word to sell programming courses.
( Mentioning AI can sell programming courses to kids who want to build HAL 3000, but can not even write a Hello World or drop a trend-line onto an Excel graph. :)</p>

#### Answer 3 (score 5)
Python has a standard library in development, and a few for AI. It has an intuitive syntax, basic control flow, and data structures. It also supports interpretive run-time, without standard compiler languages. This makes Python especially useful for prototyping algorithms for AI.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: In a CNN, does each new filter have different weights for each input channel, or are the same weights of each filter used across input channels? (score [24482](https://stackoverflow.com/q/5769) in 2018)

#### Question
My understanding is that the convolutional layer of a convolutional neural network has four dimensions: input_channels, filter_height, filter_width, number_of_filters.  Furthermore, it is my understanding that each new filter just gets convoluted over ALL of the input_channels (or feature/activation maps from the previous layer).    

HOWEVER, the graphic below from CS231 shows each filter (in red) being applied to a SINGLE CHANNEL, rather than the same filter being used across channels.  This seems to indicate that there is a separate filter for EACH channel (in this case I'm assuming they're the three color channels of an input image, but the same would apply for all input channels).    

This is confusing - is there a different unique filter for each input channel?   

<a href="https://i.stack.imgur.com/3m7mW.png" rel="noreferrer"><img src="https://i.stack.imgur.com/3m7mW.png" alt="enter image description here"></a>  

Source: <a href="http://cs231n.github.io/convolutional-networks/" rel="noreferrer">http://cs231n.github.io/convolutional-networks/</a>  

The above image seems contradictory to an excerpt from O'reilly's <a href="https://rads.stackoverflow.com/amzn/click/1491925612" rel="noreferrer">"Fundamentals of Deep Learning"</a>:   

<blockquote>
  <p>"...filters don't just operate on a single feature map. They operate
  on the entire volume of feature maps that have been generated at a
  particular layer...As a result, feature maps must be able to
  operate over volumes, not just areas"</p>
</blockquote>

...Also, it is my understanding that these images below are indicating a <strong>THE SAME</strong> filter is just convolved over all three input channels (contradictory to what's shown in the CS231 graphic above):  

<a href="https://i.stack.imgur.com/VdqER.png" rel="noreferrer"><img src="https://i.stack.imgur.com/VdqER.png" alt="enter image description here"></a>  

<a href="https://i.stack.imgur.com/kczF0.png" rel="noreferrer"><img src="https://i.stack.imgur.com/kczF0.png" alt="enter image description here"></a>  

#### Answer 2 (score 13)
<blockquote>
  In a convolutional neural network, is there a <em>unique</em> filter for each input channel or are the same new filters used across all input channels?  
</blockquote>

The former. In fact there is a <em>separate</em> kernel defined for each input channel / output channel combination.   

Typically for a CNN architecture, in a single filter as described by your `number_of_filters` parameter, there is one 2D kernel per input channel. There are `input_channels * number_of_filters` sets of weights, each of which describe a convolution kernel. So the diagrams showing one set of weights per input channel for each filter are correct. The first diagram also shows clearly that the results of applying those kernels are combined by summing them up and adding bias for each output channel.  

This can <em>also</em> be viewed as using a 3D convolution for each output channel, that happens to have the same depth as the input. Which is what your second diagram is showing, and also what many libraries will do internally. Mathematically this is the same result (provided the depths match exactly), although the layer type is typically labelled as "Conv2D" or similar. Similarly if your input type is inherently 3D, such as voxels or a video, then you might use a "Conv3D" layer, but internally it could well be implemented as a 4D convolution.  

#### Answer 3 (score 12)
The following picture that you used in your question, very accurately describes what is happening. Remember that each element of the <strong>3D filter</strong> (grey cube) is made up of a different value (`3x3x3=27` values). So, three different <strong>2D filters</strong> of size `3x3` can be concatenated to form this one <strong>3D filter</strong> of size `3x3x3`.  

<a href="https://i.stack.imgur.com/YCJRm.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/YCJRm.jpg" alt="convnet2D"></a>  

<p>The `3x3x3` RGB chunk from the picture is multiplied <em>elementwise</em> by a <strong>3D filter</strong> (shown as grey). In this case, the filter has `3x3x3=27` weights. When these weights are multiplied element wise and then summed, it gives one value.
<br/><br/><br/></p>

<h5>So, is there a separate filter for each input channel?</h2>

<p><strong>YES</strong>, there are as many <strong>2D filters</strong> as number of input channels in the image. <strong>However</strong>, it helps if you think that for input matrices with more than one channel, there is only one <strong>3D filter</strong> (as shown in the image above).
<br/><br/><br/></p>

<h5>Then why is this called 2D convolution (if filter is 3D and input matrix is 3D)?</h2>

This is 2D convolution because the strides of the filter is along the height and width dimensions only (<strong>NOT</strong> depth) and therefore, the output produced by this convolution is also a 2D matrix. The number of movement directions of the filter determine the dimensions of convolution.  

<strong>Note:</strong> <em>If you build up your understanding by visualizing a single <strong>3D filter</strong> instead of multiple <strong>2D filters</strong> (one for each layer), then you will have an easy time understanding advanced CNN architectures like Resnet, InceptionV3, etc.</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: Understanding GAN loss function (score [21322](https://stackoverflow.com/q/3488) in 2019)

#### Question
I'm struggling to understand the GAN loss function as provided in <a href="https://danieltakeshi.github.io/2017/03/05/understanding-generative-adversarial-networks/" rel="nofollow noreferrer">Understanding Generative Adversarial Networks</a> (a blog post written by Daniel Seita).  

In the standard cross-entropy loss, we have an output that has been run through a sigmoid function and a resulting binary classification.  

Sieta states   

<blockquote>
  Thus, For [each] data point <span class="math-container">$x_1$</span> and its label, we get the following loss function ...  
  
  <p><span class="math-container">$$
H((x_1, y_1), D) = -y_1 \log D(x_1) - (1 - y_1) \log (1 - D(x_1))
$$</span></p>
</blockquote>

This is just the log of the expectation, which makes sense, but how can, in the GAN loss function, we process the data from the true distribution and the data from the generative model in the same iteration?  

#### Answer accepted (score 5)
<strong>The Focus of This Question</strong>  

"How can ... we process the data from the true distribution and the data from the generative model in the same iteration?  

<strong>Analyzing the Foundational Publication</strong>  

In the referenced page, <em>Understanding Generative Adversarial Networks (2017)</em>, doctoral candidate Daniel Sieta correctly references <em>Generative Adversarial Networks, Goodfellow, Pouget-Abadie, Mirza, Xu, Warde-Farley, Ozair, Courville, and Bengio, June 2014</em>.  It's abstract states, "We propose a new framework for estimating generative models via an adversarial process, in which we simultaneously train two models ..." This original paper defines two models defined as MLPs (multilayer perceptrons).  

<ul>
<li>Generative model, G</li>
<li>Discriminative model, D</li>
</ul>

These two models are controlled in a way where one provides a form of negative feedback toward the other, therefore the term adversarial.  

<ul>
<li>G is trained to capture the data distribution of a set of examples well enough to fool D.</li>
<li>D is trained to discover whether its input are G's mocks or the set of examples for the GAN system.</li>
</ul>

(The set of examples for the GAN system are sometimes referred to as the real samples, but they may be no more real than the generated ones. Both are numerical arrays in a computer, one set with an internal origin and the other with an external origin.  Whether the external ones are from a camera pointed at some physical scene is not relevant to GAN operation.)  

Probabilistically, fooling D is synonymous to maximizing the probability that D will generate as many false positives and false negatives as it does correct categorizations, 50% each.  In information science, this is to say that the limit of information D has of G approaches 0 as t approaches infinity.  It is a process of maximizing the entropy of G from D's perspective, thus the term cross-entropy.  

<strong>How Convergence is Accomplished</strong>  

Because the loss function reproduced from Sieta's 2017 writing in the question is that of D, designed to minimize the cross entropy (or correlation) between the two distributions when applied to the full set of points for a given training state.  

<blockquote>
  <span class="math-container">$H((x_1, y_1), D) = 1 \, D(x_1)$</span>  
</blockquote>

There is a separate loss function for G, designed to maximize the cross entropy.  Notice that there are TWO levels of training granularity in the system.  

<ul>
<li>That of game moves in a two-player game</li>
<li>That of the training samples</li>
</ul>

These produce nested iteration with the outer iteration as follows.  

<ul>
<li>Training of G proceeds using the loss function of G.</li>
<li>Mock input patterns are generated from G at its current state of training.</li>
<li>Training of D proceeds using the loss function of D.</li>
<li>Repeat if the cross entropy is not yet sufficiently maximized, D can still discriminate.</li>
</ul>

When D finally loses the game, we have achieved our goal.  

<ul>
<li>G recovered the training data distribution</li>
<li>D has been reduced to ineffectiveness ("1/2 probability everywhere")</li>
</ul>

<strong>Why Concurrent Training is Necessary</strong>  

If the two models were not trained in a back and forth manner to simulate concurrency, convergence in the adversarial plane (the outer iteration) would not occur on the unique solution claimed in the 2014 paper.  

<strong>More Information</strong>  

Beyond the question, the next item of interest in Sieta's paper is that, "Poor design of the generator's loss function," can lead to insufficient gradient values to guide descent and produce what is sometimes called saturation.  Saturation is simply the reduction of the feedback signal that guides descent in back-propagation to chaotic noise arising from floating point rounding.  The term comes from signal theory.  

I suggest studying the 2014 paper by Goodfellow <em>et alia</em> (the seasoned researchers) to learn about GAN technology rather than the 2017 page.  

#### Answer 2 (score 2)
Let's start at the beginning. GANs are models that can learn to create data that is similar to the data that we give them.   

When training a generative model other than a GAN, the easiest loss function to come up with is probably the Mean Squared Error (MSE).  

Kindly allow me to give you an example (<a href="https://www.quora.com/Is-it-true-that-Generative-Adversarial-Networks-GANs-learn-the-loss-function-automatically-and-if-so-how" rel="nofollow noreferrer">Trickot L 2017</a>):  

<blockquote>
  Now suppose you want to generate cats ; you might give your model examples of specific cats in photos. Your choice of loss function means that your model has to reproduce each cat exactly in order to avoid being punished.  
  
  But that's not necessarily what we want! You just want your model to generate cats, any cat will do as long as it's a plausible cat. So, you need to change your loss function.  
  
  However which function could disregard concrete pixels and focus on detecting cats in a photo?  
  
  That's  a neural network. This is the role of the discriminator in the GAN. The discriminator's job is to evaluate how plausible an image is.  
</blockquote>

The paper that you cite, <a href="https://danieltakeshi.github.io/2017/03/05/understanding-generative-adversarial-networks/" rel="nofollow noreferrer">Understanding Generative Adversarial Networks</a> (Daniel S 2017) lists two major insights.  

<blockquote>
  Major Insight 1: the discriminator’s loss function is the cross entropy loss function.   
  
  Major Insight 2: understanding how gradient saturation may or may not adversely affect training. Gradient saturation is a general problem when gradients are too small (i.e. zero) to perform any learning.  
</blockquote>

To answer your question we need to elaborate further on the second major insight.   

<blockquote>
  In the context of GANs, gradient saturation may happen due to poor design of the generator’s loss function, so this “major insight” ... is based on understanding the tradeoffs among different loss functions for the generator.   
</blockquote>

The design implemented in the paper resolves the loss function problem by having a very specific function (to discriminate among two classes). The best way of doing this is by using cross entropy (Insight 1). As the blog post says:  

<blockquote>
  The cross-entropy is a great loss function since it is designed in part to accelerate learning and avoid gradient saturation only up to when the classifier is correct.  
</blockquote>

As clarified in the blog post's comments:  

<blockquote>
  The expectation [in the cross entropy function] comes from the sums. If you look at the definition of expectation for a discrete random variable, you'll see that you need to sum over different possible values of the random variable, weighing each of them by their probability. Here, the probabilities are just 1/2 for each, and we can treat them as coming from the generator or discriminator.  
</blockquote>

#### Answer 3 (score 1)
You can treat a combination of `z` input and `x` input as a single sample, and you evaluate how well the discriminator performed the classification of each of these.   

This is why the post later on separates a single `y` into `E(p~data)` and `E(z)` -- basically, you have different expectations (`y`s) for each of the discriminator inputs and you need to measure both at the same time to evaluate how well the discriminator is performing.  

That's why the loss function is conceived as a combination of both the positive classification of the real input and the negative classification of the negative input.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: How to handle images of large sizes in CNN? (score [20864](https://stackoverflow.com/q/3938) in 2018)

#### Question
Suppose there are 10K images of sizes 2400 x 2400 are required to use in CNN.Acc to my view conventional computers the people use will be of use. Now the question is how to handle such large image sizes where there is no privileges of downsampling.  

Here's the system requirements:-   

<p>Ubuntu 16.04 64-bit 
RAM 16 GB
GPU 8 GB
HDD 500 GB</p>

<p>1) Are there any techniques to handle such large images which are to be trained ?<br/>
2) What batch size is reasonable to use ? <br/>
3) Is there any precautions to take or any increase and decrease in hardware resources that I can do ?</p>

#### Answer accepted (score 13)
<blockquote>
  <p>Now the question is how to handle such large image sizes where there
  is no privileges of downsampling</p>
</blockquote>

I assume that by downsampling you mean scaling down the input <em>before</em> passing it into CNN. <a href="http://cs231n.github.io/convolutional-networks/#conv" rel="noreferrer">Convolutional layer</a> allows to downsample the image within a network, by picking a large stride, which is going to save resources for the next layers. In fact, that's what it has to do, otherwise your model won't fit in GPU.  

<blockquote>
  <p>1) Are there any techniques to handle such large images which are to
  be trained?</p>
</blockquote>

Commonly researches scale the images to a resonable size. But if that's not an option for you, you'll need to restrict your CNN. In addition to downsampling in early layers, I would recommend you to get rid of FC layer (which normally takes most of parameters) <a href="http://cs231n.github.io/convolutional-networks/#convert" rel="noreferrer">in favor of convolutional layer</a>. Also you will have to stream your data in each epoch, because it won't fit into your GPU.  

Note that none of this will prevent heavy computational load in the early layers, exactly because the input is so large: convolution is an expensive operation and the first layers will perform <em>a lot</em> of them in each forward and backward pass. In short, training will be slow.  

<blockquote>
  2) What batch size is reasonable to use ?  
</blockquote>

Here's another problem. A single image takes `2400x2400x3x4` (3 channels and 4 bytes per pixel) which is ~70Mb, so you can hardly afford even a batch size 10. More realistically would be 5. Note that most of the memory will be taken by CNN parameters. I think in this case it makes sense reduce the size by using 16-bit values rather than 32-bit - this way you'll be able to double the batches.  

<blockquote>
  <p>3) Is there any precautions to take or any increase and decrease in
  hardware resources that I can do?</p>
</blockquote>

Your bottleneck is GPU memory. If you can afford another GPU, get it and split the network across them. Everything else is insignificant compared to GPU memory.  

#### Answer 2 (score 5)
Usually for images the feature set is the pixel density values and in this case it will lead to quite a big feature set; also down sampling the images is also not recommended as you may lose (actually will) loose important data.  

[1] But there are some techniques that can help you reduce the feature set size, approaches like PCA(Principle Component Analysis) helps you in selection of important feature subset.  

For detailed information see link <a href="http://spark.apache.org/docs/latest/ml-features.html#pca" rel="noreferrer">http://spark.apache.org/docs/latest/ml-features.html#pca</a>.  

[2] Other than that to reduce the computational expense while training your Neural Network, you can use Stochastic Gradient Descent, rather than conventional use of Gradient Descent approach, that would reduce the size of dataset required for training in each iteration. Thus your dataset size to be used in one iteration would reduce, thus would reduce the time required to train the Network.  

The exact batch size to be used is dependent on your distribution for training dataset and testing datatset, a more general use is 70-30. Where you can also use above mentioned Stochastic approach to reduce required time.  

Detail for Stochastic Gradient Descent <a href="http://scikit-learn.org/stable/modules/sgd.html" rel="noreferrer">http://scikit-learn.org/stable/modules/sgd.html</a>  

[3] The Hardware seems apt for the upgradation would be required, still if required look at cloud solutions like AWS where you can get free account subscription upto a limit of usage.  

#### Answer 3 (score 2)
Such large data cannot be loaded into your memory. Lets split what you can do into two:  

<blockquote>
  <ol>
  <li><p>Rescale all your images to smaller dimensions. You can rescale them to 112x112 pixels. In your case, because you have a square image,
  there will be no need for cropping. You will still not be able to load
  all these images into your RAM at a goal.</p></li>
  <li><p>The best option is to use a generator function that will feed the data in batches. Please refer to the use of <a href="https://www.rdocumentation.org/packages/keras/versions/2.1.6/topics/fit_generator" rel="nofollow noreferrer">fit_generator</a> as used
  in Keras. If your model parameters become too big to fit into GPU
  memory, consider using batch normalization or using a Residual model
  to reduce your number of parameter.</p></li>
  </ol>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: What is the difference between strong-AI and weak-AI? (score [20722](https://stackoverflow.com/q/74) in 2019)

#### Question
I've heard the terms strong-AI and weak-AI used.  Are these well defined terms or subjective ones?  How are they generally defined?  

#### Answer accepted (score 31)
The terms <em>strong</em> and <em>weak</em> don't actually refer to processing, or optimization power, or any interpretation leading to "strong AI" being <em>stronger</em> than "weak AI". It holds conveniently in practice, but the terms come from elsewhere. In 1980, <a href="https://en.wikipedia.org/wiki/John_Searle">John Searle</a> coined the following statements:  

<ul>
<li>AI hypothesis, strong form: an AI system can <em>think</em> and have a <em>mind</em> (in the philosophical definition of the term);</li>
<li>AI hypothesis, weak form: an AI system can only <em>act</em> like it thinks and has a mind.</li>
</ul>

So <em>strong AI</em> is a shortcut for an AI systems that verifies the <em>strong AI hypothesis</em>. Similarly, for the weak form. The terms have then evolved: strong AI refers to AI that performs as well as humans (who have minds), weak AI refers to AI that doesn't.  

The problem with these definitions is that they're fuzzy. For example, <a href="https://en.wikipedia.org/wiki/AlphaGo">AlphaGo</a> is an example of weak AI, but is "strong" by Go-playing standards. A hypothetical AI replicating a human baby would be a strong AI, while being "weak" at most tasks.  

Other terms exist: <a href="https://en.wikipedia.org/wiki/Artificial_general_intelligence">Artificial General Intelligence</a> (AGI), which has cross-domain capability (like humans), can learn from a wide range of experiences (like humans), among other features. Artificial Narrow Intelligence refers to systems bound to a certain range of tasks (where they may nevertheless have superhuman ability), lacking capacity to significantly improve themselves.  

Beyond AGI, we find Artificial Superintelligence (ASI), based on the idea that a system with the capabilities of an AGI, without the physical limitations of humans would learn and improve far beyond human level.  

#### Answer 2 (score 8)
In contrast to the <em>philosophical</em> definitions, which rely on terms like "mind" and "think," there are also definitions that hinge on <em>observables</em>.  

That is, a Strong AI is an AI that understands itself well enough to self-improve. Even if it is philosophically not equivalent to a human, or unable to perform <em>all</em> cognitive tasks that a human can, this AI can still generate a tremendous amount of optimization power / good decision-making, and its creation would be of historic importance (to put it lightly).  

A Weak AI, in contrast, is an AI with no or limited ability to self-modify. A chessbot that runs on your laptop might have superhuman ability to play chess, but it can <em>only</em> play chess, and while it might tune its weights or its architecture and slowly improve, it cannot modify itself in a deep enough way to generalize to other tasks.  

Another way to think about this is that a Strong AI is an AI researcher in its own right, and a Weak AI is what AI researchers produce.  

#### Answer 3 (score 1)
<a href="https://en.wikipedia.org/wiki/Strong_AI" rel="nofollow">Strong</a> and <a href="https://en.wikipedia.org/wiki/Weak_AI" rel="nofollow">weak AI</a> are the older terms for <a href="https://en.wikipedia.org/wiki/Artificial_general_intelligence" rel="nofollow">AGI</a> (artificial general intelligence) and narrow AI. At least that's how I have seen it used and wikipedia seems to agree.   

I personally haven't seen Searle's definition of "weak and strong AI" in use much, but maybe the shift to the newer terms came about in part because Searle successfully confused the issue.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How does Hinton's "capsules theory" work? (score [20704](https://stackoverflow.com/q/1294) in )

#### Question
Geoffrey Hinton has been researching something he calls "capsules theory" in neural networks. What is this and how does it work?  

#### Answer accepted (score 30)
It appears to not be published yet; the best available online are <a href="http://cseweb.ucsd.edu/~gary/cs200/s12/Hinton.pdf" rel="noreferrer">these slides</a> for <a href="https://www.youtube.com/watch?v=TFIMqt0yT2I" rel="noreferrer">this talk</a>. (Several people reference an earlier talk with <a href="http://techtv.mit.edu/collections/bcs/videos/30698-what-s-wrong-with-convolutional-nets" rel="noreferrer">this link</a>, but sadly it's broken at time of writing this answer.)  

My impression is that it's an attempt to formalize and abstract the creation of subnetworks inside a neural network. That is, if you look at a standard neural network, layers are fully connected (that is, every neuron in layer 1 has access to every neuron in layer 0, and is itself accessed by every neuron in layer 2). But this isn't obviously useful; one might instead have, say, <em>n</em> parallel stacks of layers (the 'capsules') that each specializes on some separate task (which may itself require more than one layer to complete successfully).  

If I'm imagining its results correctly, this more sophisticated graph topology seems like something that could easily increase both the effectiveness and the interpretability of the resulting network.  

#### Answer 2 (score 13)
To supplement the previous answer: there is a paper on this that is mostly about learning low-level capsules from raw data, but explains Hinton's conception of a capsule in its introductory section: <a href="http://www.cs.toronto.edu/~fritz/absps/transauto6.pdf" rel="noreferrer">http://www.cs.toronto.edu/~fritz/absps/transauto6.pdf</a>  

It's also worth noting that the link to the MIT talk in the answer above seems to be working again.  

According to Hinton, a "capsule" is a subset of neurons within a layer that outputs both an "instantiation parameter" indicating whether an entity is present within a limited domain and a vector of "pose parameters" specifying the pose of the entity relative to a canonical version.   

The parameters output by low-level capsules are converted into predictions for the pose of the entities represented by higher-level capsules, which are activated if the predictions agree and output their own parameters (the higher-level pose parameters being averages of the predictions received).   

Hinton speculates that this high-dimensional coincidence detection is what mini-column organization in the brain is for. His main goal seems to be replacing the max pooling used in convolutional networks, in which deeper layers lose information about pose.  

#### Answer 3 (score 4)
Capsule networks try to mimic Hinton's observations of the human brain on the machine. The motivation stems from the fact that neural networks needed better modeling of the spatial relationships of the parts. Instead of modeling the co-existence, disregarding the relative positioning, capsule-nets try to model the global relative transformations of different sub-parts along a hierarchy. This is the eqivariance vs. invariance trade-off, as explained above by others.   

These networks therefore include somewhat a viewpoint / orientation awareness and respond differently to different orientations. This property makes them more discriminative, while potentially introducing the capability to perform pose estimation as the latent-space features contain interpretable, pose specific details.   

All this is accomplished by including a nested layer called capsules within the layer, instead of concatenating yet another layer in the network. These capsules can provide vector output instead of a scalar one per node.   

The crucial contribution of the paper is the dynamic routing which replaces the standard max-pooling by a smart strategy. This algorithm applies a <a href="https://en.wikipedia.org/wiki/Mean_shift" rel="nofollow noreferrer">mean-shift clustering</a> on the capsule outputs to ensure that the output gets sent only to the appropriate parent in the layer above.   

Authors also couple the contributions with a margin loss and reconstruction loss, which simultaneously help in learning the task better and show state of the art results on MNIST.  

<p>The recent-paper is named <a href="https://arxiv.org/pdf/1710.09829.pdf" rel="nofollow noreferrer">Dynamic Routing Between Capsules
</a> and is available on Arxiv: <a href="https://arxiv.org/pdf/1710.09829.pdf" rel="nofollow noreferrer">https://arxiv.org/pdf/1710.09829.pdf</a> . </p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: Which library would you recommend to begin with deep learning? (score [19419](https://stackoverflow.com/q/3528) in 2019)

#### Question
Which library (TensorFlow or Keras) would you recommend for a first approach to deep learning?   

I'm a neuroscience student trying for the first time computational approaches, if that matters.  

#### Answer accepted (score 30)
Keras is a simple and high-level neural networks library, written in Python, that works as a wrapper for Tensorflow and Theano. It's easy to learn and use. Using Keras is like working with Lego blocks. It was built so that people can do quick experiments and proofs-of-concept before launching into a full-scale build process.   

With that in mind, it was made to be highly modular and extensible. Now, it can be used for a lot more than just experiments. It can help with RNN, CNN, and combinations of both.   

If you want to begin and make a prototype ready solution, then I will recommend you start with Keras. To know the details under the hood, then learn TensorFlow. It has huge active community and also very good resources are available, for example, this <a href="https://www.youtube.com/watch?v=Se9ByBnKb0o&amp;list=PLXO45tsB95cJHXaDKpbwr5fC_CCYylw1f" rel="nofollow noreferrer">Youtube series</a>.  

See also <a href="https://blog.keras.io/keras-as-a-simplified-interface-to-tensorflow-tutorial.html" rel="nofollow noreferrer">https://blog.keras.io/keras-as-a-simplified-interface-to-tensorflow-tutorial.html</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Why does C++ seem less widely used in AI? (score [18731](https://stackoverflow.com/q/6185) in 2018)

#### Question
I just want to know why do Machine Learning engineers and AI programmers use languages like python to perform AI task and not C++ even though C++ is technically a more powerful language than python.  

#### Answer 2 (score 15)
<p>You don't need a powerful language for programming AI. Most of the developers are using libraries like Keras, Torch, Caffe, Watson, TensorFlow, etc.
Those libraries are highly optimized and handle all the though work, they are built with high performance languages, like C. Python is just there to describe the neural network layers, load data, launch the processing and display results. Using C++ instead would give barely no performance improvement, but would be harder for non-developers as it require to care for memory management. Also, several AI people may not have a very solid programming or computer science background.</p>

Another similar example would be game development, where the engine is coded in C/C++, and, often, all the game logic scripted in a high level language.  

#### Answer 3 (score 9)
C++ is actually one of the most popular languages used in the AI/ML space. Python may be more popular in general, but as others have noted, it's actually quite common to have hybrid systems where the CPU intensive number-crunching is done in C++ and Python is used for higher level functions.  

Just to illustrate:  

<a href="http://mloss.org/software/language/c__/" rel="noreferrer">http://mloss.org/software/language/c__/</a>  

<a href="http://mloss.org/software/language/python/" rel="noreferrer">http://mloss.org/software/language/python/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: Why is Lisp such a good language for AI? (score [17022](https://stackoverflow.com/q/2236) in 2017)

#### Question
I've heard before from computer scientists and from researchers in the area of AI that that Lisp is a good language for research and development in artificial intelligence. Does this still apply, with the proliferation of neural networks and deep learning? What was their reasoning for this? What languages are current deep-learning systems currently built in?  

#### Answer accepted (score 29)
First, I guess that you mean <a href="https://en.wikipedia.org/wiki/Common_Lisp" rel="nofollow noreferrer">Common Lisp</a> (which is a standard language specification, see its <a href="http://www.lispworks.com/documentation/HyperSpec/Front/" rel="nofollow noreferrer">HyperSpec</a>) with efficient implementations (à la <a href="https://sbcl.org/" rel="nofollow noreferrer">SBCL</a>). But some recent implementations of <a href="https://schemers.org/" rel="nofollow noreferrer">Scheme</a> could also be relevant (with good implementations such as <a href="https://www-sop.inria.fr/mimosa/fp/Bigloo/" rel="nofollow noreferrer">Bigloo</a> or <a href="https://www.call-cc.org/" rel="nofollow noreferrer">Chicken/Scheme</a>). Both Common Lisp and Scheme (and even <a href="https://clojure.org/" rel="nofollow noreferrer">Clojure</a>) are from the same Lisp family. And as a scripting language driving big data or machine learning applications, <a href="https://www.gnu.org/software/guile/" rel="nofollow noreferrer">Guile</a> might <a href="http://starynkevitch.net/Basile/guile-tutorial-1.html" rel="nofollow noreferrer">be</a> a useful replacement to Python and is also a Lisp dialect. BTW, I do recommend reading <a href="https://mitpress.mit.edu/sites/default/files/sicp/index.html" rel="nofollow noreferrer">SICP</a>, an excellent introduction to programming using Scheme.  

Then, Common Lisp (and other dialects of Lisp) is great for symbolic AI. However, many recent machine learning libraries are coded in more mainstream languages, for example <a href="https://en.wikipedia.org/wiki/TensorFlow" rel="nofollow noreferrer">TensorFlow</a> is coded in C++ &amp; Python. <a href="http://machinelearningmastery.com/popular-deep-learning-libraries/" rel="nofollow noreferrer">Deep learning libraries</a> are mostly coded in C++ or Python or C (and sometimes using <a href="https://en.wikipedia.org/wiki/OpenCL" rel="nofollow noreferrer">OpenCL</a> or Cuda for GPU computing parts).  

Common Lisp is great for <a href="https://en.wikipedia.org/wiki/Symbolic_artificial_intelligence" rel="nofollow noreferrer">symbolic artificial intelligence</a> because:  

<ul>
<li>it has very good <em>implementations</em> (e.g. <a href="http://sbcl.org/" rel="nofollow noreferrer">SBCL</a>, which compiles to machine code every expression given to the <a href="https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop" rel="nofollow noreferrer">REPL</a>)</li>
<li>it is <a href="https://en.wikipedia.org/wiki/Homoiconicity" rel="nofollow noreferrer"><strong>homoiconic</strong></a>, so it is easy to deal with programs as data, in particular it is easy to generate [sub-]programs, that is use <a href="https://en.wikipedia.org/wiki/Metaprogramming" rel="nofollow noreferrer">meta-programming</a> techniques.</li>
<li>it has a <a href="https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop" rel="nofollow noreferrer">Read-Eval-Print Loop</a> to ease interactive programming</li>
<li>it provides a very powerful <a href="https://en.wikipedia.org/wiki/Macro_%28computer_science%29" rel="nofollow noreferrer">macro</a> machinery (essentially, you define your own domain specific sublanguage for your problem), much more powerful than in other languages like C.</li>
<li>it mandates a <a href="https://en.wikipedia.org/wiki/Garbage_collection_%28computer_science%29" rel="nofollow noreferrer">garbage collector</a> (even code can be garbage collected)</li>
<li>it provides many <a href="https://en.wikipedia.org/wiki/Container_%28abstract_data_type%29" rel="nofollow noreferrer">container</a> abstract data types, and can easily handle symbols.</li>
<li>you can code both high-level (dynamically typed) and low-level (more or less startically typed) code, thru appropriate annotations.</li>
</ul>

However most machine learning &amp; neural network libraries are not coded in CL. Notice that neither neural network nor deep learning is in the symbolic artificial intelligence field. See also <a href="https://ai.stackexchange.com/q/35/3335">this question</a>.  

Several symbolic AI systems like <a href="https://en.wikipedia.org/wiki/Eurisko" rel="nofollow noreferrer">Eurisko</a> or <a href="https://en.wikipedia.org/wiki/Cyc" rel="nofollow noreferrer">CyC</a> have been developed in CL (actually, in some DSL built above CL).  

Notice that the programming language might not be very important. In the <a href="https://en.wikipedia.org/wiki/Artificial_general_intelligence" rel="nofollow noreferrer">Artificial General Intelligence</a> research topic, some people work on the idea of a AI system which would generate all its own code (so are designing it with a <a href="https://en.wikipedia.org/wiki/Bootstrapping_%28compilers%29" rel="nofollow noreferrer">bootstrapping</a> approach). Then, the code which is generated by such a system can even be generated in low level programming languages like C. See <a href="http://bootstrappingartificialintelligence.fr/WordPress3/" rel="nofollow noreferrer">J.Pitrat's blog</a>  

#### Answer 2 (score 15)
David Nolen (contributor to <a href="https://fr.wikipedia.org/wiki/Clojure" rel="noreferrer">Clojure</a> and <a href="https://github.com/clojure/clojurescript" rel="noreferrer">ClojureScript</a>; creator of Core Logic a port of miniKanren) in a talk called <strong>LISP as too powerful</strong> stated that back in his days LISP was decades ahead of other programming languages. There are <a href="http://blog.samibadawi.com/2013/05/lisp-prolog-and-evolution.html" rel="noreferrer">number of reasons</a> why the language wasn't able to maintain it's name.  

<a href="http://norvig.com/paip-preface.html" rel="noreferrer">This</a> article highlights som key points why LISP is good for AI  

<ul>
<li>Easy to define a new language and manipulate complex information.</li>
<li>Full flexibility in defining and manipulating programs as well as data.</li>
<li>Fast, as program is concise along with low level detail. </li>
<li>Good programming environment (debugging, incremental compilers, editors).</li>
</ul>

<p>Most of my friends into this field usually use Matlab for Artificial Neural Networks and Machine Learning. It hides the low level details though. If you are only looking for results and not how you get there, then Matlab will be good. But if you want to learn even low level detailed stuff, then I will suggest you go through LISP at-least once.<br>
Language might not be that important if you have the understanding of various AI algorithms and techniques. I will suggest you to read <em>"Artificial Intelligence: A Modern Approach (by Stuard J. Russell and Peter Norvig"</em>. I am currently reading this book, and it's a very good book.</p>

#### Answer 3 (score 4)
AI is a wide field that goes far beyond machine learning, deep learning, neural networks, etc. In some of these fields, the programming language does not matter at all (except for speed issues), so LISP would certainly not be a topic there.  

In search or AI planning, for instance, standard languages like C++ and Java are often the first choice, because they are fast (in particular C++) and because many software projects like planning systems are open source, so using a standard language is important (or at least wise in case one appreciates feedback or extensions). I am only aware of one single planner that is written in LISP. Just to give some impression about the role of the choice of the programming language in this field of AI, I'll give a list of some of the best-known and therefore most-important planners:  

<p><strong>Fast-Downward:</strong><br>
<em>description:</em> the probably best-known classical planning system<br>
<em>URL:</em> <a href="http://www.fast-downward.org/" rel="nofollow noreferrer">http://www.fast-downward.org/</a><br>
<em>language:</em> C++, parts (preprocessing) are in Python  </p>

<p><strong>FF:</strong><br>
<em>description:</em> together with Fast-Downward <em>the</em> classical planning system everyone knows<br>
<em>URL:</em> <a href="https://fai.cs.uni-saarland.de/hoffmann/ff.html" rel="nofollow noreferrer">https://fai.cs.uni-saarland.de/hoffmann/ff.html</a><br>
<em>language:</em> C</p>

<p><strong>VHPOP:</strong><br>
<em>description:</em> one of the best-known partial-order causal link (POCL) planning systems<br>
<em>URL:</em> <a href="http://www.tempastic.org/vhpop/" rel="nofollow noreferrer">http://www.tempastic.org/vhpop/</a><br>
<em>language:</em> C++  </p>

<p><strong>SHOP and SHOP2:</strong><br>
<em>description:</em> the best-known HTN (hierarchical) planning system<br>
<em>URL:</em> <a href="https://www.cs.umd.edu/projects/shop/" rel="nofollow noreferrer">https://www.cs.umd.edu/projects/shop/</a><br>
<em>language:</em> there are two versions of SHOP and SHOP2. The original versions have been written in LISP. Newer versions (called JSHOP and JSHOP2) have been written in Java. Pyshop is a further SHOP variant written in Python.  </p>

<p><strong>PANDA:</strong><br>
<em>description:</em> another well-known HTN (and hybrid) planning system<br>
<em>URL:</em> <a href="http://www.uni-ulm.de/en/in/ki/research/software/panda/panda-planning-system/" rel="nofollow noreferrer">http://www.uni-ulm.de/en/in/ki/research/software/panda/panda-planning-system/</a><br>
<em>language:</em> there are different versions of the planner: PANDA1 and PANDA2 are written in Java, PANDA3 is written primarily in Java with some parts being in Scala.</p>

These were just some of the best-known planning systems that came to my mind. More recent ones can be retrieved from the International Planning Competitions (IPCs, <a href="http://www.icaps-conference.org/index.php/Main/Competitions" rel="nofollow noreferrer">http://www.icaps-conference.org/index.php/Main/Competitions</a>), which take place every two years. The competing planners' codes are published open source (for a few years).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How can these 7 AI problem characteristics help me decide on an approach to a problem? (score [15935](https://stackoverflow.com/q/2675) in 2018)

#### Question
If this list<sup>1</sup> can be used to classify problems in AI ...   

<blockquote>
  <ul>
  <li>Decomposable to smaller or easier problems</li>
  <li>Solution steps can be ignored or undone</li>
  <li>Predictable problem universe</li>
  <li>Good solutions are obvious</li>
  <li>Uses internally consistent knowledge base</li>
  <li>Requires lots of knowledge or uses knowledge to constrain solutions</li>
  <li>Requires periodic interaction between human and computer</li>
  </ul>
</blockquote>

... is there a generally accepted relationship between placement of a problem along these dimensions and suitable algorithms/approaches to its solution?  

<strong>References</strong>  

[1] <a href="https://images.slideplayer.com/23/6911262/slides/slide_4.jpg" rel="nofollow noreferrer">https://images.slideplayer.com/23/6911262/slides/slide_4.jpg</a>  

#### Answer 2 (score 1)
<strong>The List</strong>  

This list originates from Bruce Maxim, Professor of Engineering, Computer and Information Science at the University of Michigan.  In his lecture Spring 1998 notes for CIS 479<sup>1</sup>, the following list was called,  

<blockquote>
  <strong>"Good Problems For Artificial Intelligence."</strong>  
</blockquote>

```text
  Decomposable to easier problems
  Solution steps can be ignored or undone
  Predictable Problem Universe
  Good Solutions are obvious
  Internally consistent knowledge base (KB)
  Requires lots of knowledge or uses knowledge to constrain solutions
  Interactive
```

It has since evolved into this.  

```text
  Decomposable to smaller or easier problems
  Solution steps can be ignored or undone
  Predictable problem universe
  Good solutions are obvious
  Uses internally consistent knowledge base
  Requires lots of knowledge or uses knowledge to constrain solutions
  Requires periodic interaction between human and computer
```

<strong>What it is</strong>  

His list was never intended to be a list of AI problem categories as an initial branch point for solution approaches or a, "heuristic technique designed to speed up the process of finding a satisfactory solution."  

Maxim never added this list into any of his academic publications, and there are reasons why.  

The list is heterogeneous.  It contains methods, global characteristics, challenges, and conceptual approaches mixed into one list as if they were like elements.  This is not a shortcoming for a list of, "Good problems for AI," but as a formal statement of AI problem characteristics or categories, it lacks the necessary rigor.  Maxim certainly did not represent it as a, "7 AI problem characteristics," list.  

<blockquote>
  <strong>It is certainly not a, "7 AI problem characteristics," list.</strong>  
</blockquote>

<strong>Are There Any Category or Characteristics Lists?</strong>  

There is no good category list for AI problems because if one created one, it would be easy to think of one of the millions of problems that human brains have solved that don't fit into any of the categories or sit on the boundaries of two or more categories.  

It is conceivable to develop a problem characteristics list, and it may be inspired by Maxim's Good Problems for AI list.  It is also conceivable to develop an initial approaches list.  Then one might draw arrows from the characteristics in the first list to the best prospects for approaches in the second list.  That would make for a good article for publication if dealt with comprehensively and rigorously.  

<strong>An Initial High Level Characteristics to Approaches List</strong>  

Here is a list of questions that an experienced AI architect may ask to elucidate high level system requirements prior to selecting an approaches.  

<ul>
<li>Is the task essentially static in that once it operates it is likely to require no significant adjustments?  If this is the case, then AI may be most useful in the design, fabrication, and configuration of the system (potentially including the training of its parameters).</li>
<li>If not, is the task essentially variable in a way that control theory developed in the early 20th century can adapt to the variance?  If so, then AI may also be similarly useful in procurement.</li>
<li>If not, then the system may possess sufficient nonlinear and temporal complexity that intelligence may be required.  Then the question becomes whether the phenomenon is controllable at all.  If so, then AI techniques must be employed in real time after deployment.</li>
</ul>

<strong>Effective Approach to Architecture</strong>  

If one frames the design, fabrication, and configuration steps in isolation, the same process can be followed to determine what role AI might play, and this can be done recursively as one decomposes the overall productization of ideas down to things like the design of an A-to-D converter, or the convolution kernel size to use in a particular stage of computer vision.  

As with other control system design, with AI, determine your available inputs and your desired output and apply basic engineering concepts.  Thinking that engineering discipline has changed because of expert systems or artificial nets is a mistake, at least for now.  

Nothing has significantly changed in control system engineering because AI and control system engineering share a common origin.  We just have additional components from which we can select and additional theory to employ in design, construction, and quality control.  

<strong>Rank, Dimensionality, and Topology</strong>  

Regarding the rank and dimensions of signals, tensors, and messages within an AI systems, Cartesian dimensionality is not always the correct concept to characterize the discrete qualities of internals as we approach simulations of various mental qualities of the human brain.  Topology is often the key area of mathematics that most correctly models the kinds of variety we see in human intelligence we wish to develop artificially in systems.  

More interestingly, topology may be the key to developing new types of intelligence for which neither computers nor human brains are well equipt.  

<strong>References</strong>  

<a href="http://groups.umd.umich.edu/cis/course.des/cis479/lectures/htm.zip" rel="nofollow noreferrer">http://groups.umd.umich.edu/cis/course.des/cis479/lectures/htm.zip</a>  

#### Answer 3 (score -1)
The 7 AI problem characteristics is a heuristic technique designed to speed up the process of finding a satisfactory solution to problems in artificial intelligence.   

In computer science, artificial intelligence and mathematical optimization, a heuristic is a technique designed for solving a problem more quickly, or for finding an approximate solution when you have failed to find an exact solution using classic methods.   

The 7 AI problem technique ranks alternative steps based on available information to help one decide on the most appropriate approach to follow in solving problems i.e. missionaries and cannibals, Tower of Hanoi, Traveling salesman e.t.c.   

<p>Regarding whether there is a generally accepted relationship between the placement of a problem and suitable algorithms. The answer is that indeed there is a generally accepted relationship. 
For example imagine trying to solve a game of chess and a game of sudoku.</p>

If a step is wrong in sudoku, we can backtrack and attempt a different approach. However if we are playing a game of chess and realize a mistake after a couple of moves. We cannot simply ignore the mistake and backtrack.(2nd Characteristic)   

If the problem universe is predictable,  we can make a plan to generate a sequence of operations that is guaranteed to lead to a solution. However in the case of problems with uncertain outcomes, we have to follow a process of plan revision as the plan is carried out while providing the necessary feedback. (3rd Characteristic)  

Below is an example of the 7 AI problem characteristics being applied to solve a water jug problem.  

<a href="https://i.stack.imgur.com/uUp1l.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/uUp1l.jpg" alt="Below is an example of the 7 AI problem characteristic being used to solve a water jug problem."></a>  

<p>Image source
<a href="https://gtuengineeringmaterial.blogspot.com/2013/05/discuss-ai-problems-with-seven-problem_1818.html" rel="nofollow noreferrer">https://gtuengineeringmaterial.blogspot.com/2013/05/discuss-ai-problems-with-seven-problem_1818.html</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: Sentence similarity in Python (score [15377](https://stackoverflow.com/q/4965) in 2018)

#### Question
I am working on a problem where I need to determine whether two sentences are similar or not.  I implemented a solution using BM25 algorithm and wordnet synsets for determining syntactic &amp; semantic similarity.  The solution is working adequately, and even if the word order in the sentences is jumbled, it is measuring that two sentences are similar e.g. - <br>  

<p>1) Python is a good language. <br>
2) Language a good python is.</p>

My solution is determining that these two sentences are similar.    

<ul>
<li>What could be the possible solution for Structural similarity? </li>
<li>How will I maintain structure of sentences?</li>
</ul>

#### Answer accepted (score 2)
The easiest way to add some sort of structural similarity measure is to use n-grams; in your case bigrams might be sufficient.  

Go through each sentence and collect pairs of words, such as:  

<ul>
<li>"python is", "is a", "a good", "good language".</li>
</ul>

Your other sentence has  

<ul>
<li>"language a", "a good", "good python", "python is". </li>
</ul>

Out of eight bigrams you have two which are the same ("python is" and "a good"), so you could say that the structural similarity is 2/8.  

Of course you can also be more flexible if you already know that two words are semantically related. If you want to say that <em>Python is a good language</em> is structurally similar/identical to <em>Java is a great language</em>, then you could add that to the comparison so that you effectively process "[PROG_LANG] is a [POSITIVE-ADJ] language", or something similar.  

#### Answer 2 (score 5)
Firstly, before we commence I recommend that you refer to similar questions on the network such as <a href="https://datascience.stackexchange.com/questions/25053/best-practical-algorithm-for-sentence-similarity">https://datascience.stackexchange.com/questions/25053/best-practical-algorithm-for-sentence-similarity</a> and <a href="https://stackoverflow.com/questions/62328/is-there-an-algorithm-that-tells-the-semantic-similarity-of-two-phrases">https://stackoverflow.com/questions/62328/is-there-an-algorithm-that-tells-the-semantic-similarity-of-two-phrases</a>  

To determine the similarity of sentences we need to consider what kind of data we have. For example if you had a labelled dataset i.e. similar sentences and disimilar sentences then a straight forward approach could have been to use a supervised algorithm to classify the  sentences.   

An approach that could determine sentence structural similarity would be to average the word vectors generated by word embedding algorithms i.e word2vec. These algorithms create a vector for each word and the cosine similarity among them represents semantic similarity among words. (Daniel L 2017)  

Using word vectors we can use the following metrics to determine the similarity of words.   

<ul>
<li>Cosine distance between word embeddings of the words</li>
<li>Euclidean distance between word embeddings of the words</li>
</ul>

Cosine similarity is a measure of the similarity between two non-zero vectors of an inner product space that measures the cosine of the angle between them. The cosine angle is the measure of overlap between the sentences in terms of their content.   

The Euclidean distance  between two word vectors provides an effective method for measuring the linguistic or semantic similarity of the corresponding words. (Frank D 2015)  

Alternatively you could calculate the eigenvector of the sentences to determine sentence similarity.   

Eigenvectors are a special set of vectors associated with a linear system of equations (i.e. matrix equation). Here a sentence similarity matrix is generated for each cluster and the eigenvector for the matrix is calculated. You can read more on Eigenvector based approach to sentence ranking on this paper <a href="https://pdfs.semanticscholar.org/ca73/bbc99be157074d8aad17ca8535e2cd956815.pdf" rel="noreferrer">https://pdfs.semanticscholar.org/ca73/bbc99be157074d8aad17ca8535e2cd956815.pdf</a>  

For source code Siraj Rawal has a Python notebook to create a set of word vectors. The word vectors can then be used to find the similarity between words. The source code is available here <a href="https://github.com/llSourcell/word_vectors_game_of_thrones-LIVE" rel="noreferrer">https://github.com/llSourcell/word_vectors_game_of_thrones-LIVE</a>  

Another option is a tutorial from Oreily that utilizes the gensin Python library to determine the similarity between documents. This tutorial uses NLTK to tokenize then creates a tf-idf (term frequency-inverse document frequency) model from the corpus.  The tf-idf is then used to determine the similarity of the documents. The tutorial is available here <a href="https://www.oreilly.com/learning/how-do-i-compare-document-similarity-using-python" rel="noreferrer">https://www.oreilly.com/learning/how-do-i-compare-document-similarity-using-python</a>  

#### Answer 3 (score 3)
<blockquote>
  <strong>The best approach at this time (2019):</strong>  
</blockquote>

The most efficient approach now is to use <a href="https://tfhub.dev/google/universal-sentence-encoder/1" rel="nofollow noreferrer"><strong>Universal Sentence Encoder by Google</strong></a> (<a href="https://arxiv.org/abs/1803.11175" rel="nofollow noreferrer">paper_2018</a>) which computes semantic similarity between sentences using the dot product of their embeddings <em>(i.e learned vectors of 215 values)</em>. Similarity is a float number between 0 <em>(i.e no similarity)</em> and 1 <em>(i.e strong similarity).</em>   

The implementation is now integrated to Tensorflow Hub and can easily be used. Here is a ready-to-use code to compute the similarity between 2 sentences. Here I will get the similarity between <strong><em>"Python is a good language"</em></strong> and <strong><em>"Language a good python is"</em></strong> as in your example.  

<blockquote>
  <strong>Code example:</strong>   
</blockquote>

```text
#Requirements: Tensorflow>=1.7 tensorflow-hub numpy

import tensorflow as tf
import tensorflow_hub as hub
import numpy as np

module_url = "https://tfhub.dev/google/universal-sentence-encoder-large/3" 
embed = hub.Module(module_url)
sentences = ["Python is a good language","Language a good python is"]

similarity_input_placeholder = tf.placeholder(tf.string, shape=(None))
similarity_sentences_encodings = embed(similarity_input_placeholder)

with tf.Session() as session:
  session.run(tf.global_variables_initializer())
  session.run(tf.tables_initializer())
  sentences_embeddings = session.run(similarity_sentences_encodings, feed_dict={similarity_input_placeholder: sentences})
  similarity = np.inner(sentences_embeddings[0], sentences_embeddings[1])
  print("Similarity is %s" % similarity)
```

<blockquote>
  <strong>Output:</strong>  
</blockquote>

```text
Similarity is 0.90007496 #Strong similarity
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Design AI for log file analysis (score [15210](https://stackoverflow.com/q/3258) in 2018)

#### Question
I'm developing an AI tool to find known equipments' errors and find new patterns of failure. This log file is time based and has known  messages (information and error).I'm using a JavaScript library Event drops to show the data in a soft way,but my real job and doubts are how to train the AI to find the known patterns and find new possible patterns. I have some requirements:  

1 - The tool shall either a. has no dependence on extra environment installation or b. the less the better (the perfect scenario is to run the tool entirely on the browser in standalone mode);  

2 - Possibility to make the pattern analyzer fragmented,a kind of modularity,one module per error;  

What are the recommended kind of algorithm to do this ( Neural network, genetic algorithm, etc)? Exist something to work using JavaScript? If not what is the best language to make this AI?  

#### Answer accepted (score 6)
<strong>Correlation Between Entries</strong>  

The first recommendation is to ensure that appropriate warning and informational entries in the log file are presented along with errors into the machine learning components of the solution.  All log entries are potentially useful input data if it is possible that there are correlations between informational messages, warnings, and errors.  Sometimes the correlation is strong and therefore critical to maximizing the learning rate.  

System administrators often experience this as a series of warnings followed by an error caused by the condition indicated in the warnings.  The information in the warnings is more indicative of the root cause of failure than the error entry created as the system or a subsystem critically fails.  

If one is building a system health dashboard for a piece of equipment or an array of machines that inter-operate, which appears to be the case in this question, the root cause of problems and some early warning capability is key information to display.  

Furthermore, not all poor system health conditions end in failure.  

The only log entries that should be eliminated by filtration prior to presentation to the learning mechanism are ones that are surely irrelevant and uncorrelated.  This may be the case when the log file is an aggregation of logging from several systems.  In such a case, entries for the independent system being analyzed should be extracted as an isolate from entries that could not possibly correlate to the phenomena being analyzed.  

It is important to note that limiting analysis to one entry at a time vastly limits the usefulness of the dashboard.  The health of a system is not equal to the health indications of the most recent log entry.  It is not even the linear sum of the health indications of the most recent N entries.  

System health has a very nonlinear and very temporally dependent relationships with many entries.  Patterns can emerge gradually over the course of days on many types of systems.  The base (or a base) neural net in the system must be trained to identify these nonlinear indications of health, impending dangers, and risk conditions if a highly useful dashboard is desired.  To display the likelihood of an impending failure or quality control issue, an entire time window of log entries of considerable length must enter this neural net.  

<strong>Distinction Between Known and Unknown Patterns</strong>  

Notice that the identification of known patterns is different in one important respect than the identification of new patterns.  The idiosyncrasies of the entry syntax of known errors has already been identified, considerably reducing the learning burden in input normalization stages of processing for those entries.  The syntactic idiosyncrasies of new error types must be discovered first.  

The entries of a known type can also be separated from those that are unknown, enabling the use of known entry types as training data to help in the learning of new syntactic patterns.  The goal is to present syntactically normalized information to semantic analysis.  

<strong>First Stage of Normalization Specific to Log Files</strong>  

If the time stamp is always in the same place in entries, converting it to relative milliseconds and perhaps removing any 0x0d characters before 0x0a characters can be done before anything else as a first step in normalization.  Stack traces can also be folded up into tab delimited arrays of trace levels so that there is a one-to-one correspondence between log entries and log lines.  

The syntactically normalized information arising out of both known and unknown entries of error and non-error type entries can then be presented to unsupervised nets for the naive identification of categories of a semantic structure.  We do not want to categorize numbers or text variables such as user names or part serial numbers.  

If the syntactically normalized information is appropriately marked to indicate highly variable symbols such as counts, capacities, metrics, and time stamps, feature extraction may be applied to learn the expression patterns in a way that maintains the distinction between semantic structure and variables.  Maintaining that distinction permits the tracking of more continuous (less discrete) trends in system metrics.  Each entry may have zero or more such variables, whether known a priori or recently acquired through feature extraction.  

Trends can be graphed against time or against the number of instances of a particular kind.  Such graphics can assist in the identification of mechanical fatigue, the approach of over capacity conditions, or other risks that escalate to a failure point.  Further neural nets can be trained to produce warning indicators when the trends indicate such conditions are impending.  

<strong>Lazy Logging</strong>  

All of this log analysis would be moot if software architects and technology officers stopped leaving the storage format of important system information to the varying convenient whims of software developers.  Log files are generally a mess, and the extraction of statistical information about patterns in them is one of the most common challenges in software quality control.  The likelihood that rigor will ever be universally applied to logging is small since none of the popular logging frameworks encourage rigor.  That is most likely why this question has been viewed frequently.  

<strong>Requirements Section of This Specific Question</strong>  

In the specific case presented in this question, requirement #1 indicates a preference to run the analysis in the browser, which is possible but not recommended.  Even though ECMA is a wonderful scripting language and the regular expression machinery that can be a help in learning parsers is built into ECMA (which complies with the other part of requirement #1, not requiring additional installations) un-compiled languages are not nearly as efficient as Java.  And even Java is not as efficient as C because of garbage collection and inefficiencies that occur by delegating the mapping of byte code to machine code to run time.  

Many experimentation in machine learning employs Python, another wonderful language, but most of the work I've done in Python was then ported to computationally efficient C++ for nearly 1,000 to one gains in speed in many cases.  Even the C++ method lookup was a bottleneck, so the ports use very little inheritance, in ECMA style, but much faster.  In typical kernel code traditional, C structures and function pointer use eliminates vtable overhead.  

The second requirement of modular handlers is reasonable and implies a triggered rule environment that many may be tempted to think is incompatible with NN architectures, but it is not.  Once pattern categories have been identified, looking for the most common ones first in further input data is already implied in the known/unknown distinction already embedded into the process above.  There is a challenge with this modular approach however.  

Because system health is often indicated by trends and not single entries (as discussed above) and because system health is not a linear sum of the health value of individual entries, the modular approach to handling entries should not just be piped to the display without further analysis.  This is in fact where neural nets will provide the greatest functional gains in health monitoring.  The outputs of the modules must enter a neural net that can be trained to identify these nonlinear indications of health, impending dangers, and risk conditions.  

Furthermore, the temporal aspect of pre-failure behavior implies that an entire time window of log entries of considerable length must enter this net.  This further implies the inappropriateness of ECMA or Python as a choice for the computationally intensive portion of the solution.  (Note that the trend in Python is to do what I do with C++:  Use object oriented design, encapsulation, and easy to follow design patterns for supervisory code and very computationally efficient kernel-like code for actual learning and other computationally intensive or data intensive functions.)  

<strong>Picking Algorithms</strong>  

It is not recommendable to pick algorithms in the initial stages of architecture (as was implied at the end of the question).  Architect the process first.  Determine learning components, the type of them needed, their goal state after training, where reinforcement can be used, and how the wellness/error signal will be generated to reinforce/correct desired network behavior.  Base these determinations not only on desired display content but on expected throughput, computing resource requirements, and minimal effective learning rate.  Algorithms, language, and capacity planning for the system can only be meaningfully selected after all of those things are at least roughly defined.  

<strong>Similar Work in Production</strong>  

Simple adaptive parsing is running in the lab here as a part of social networking automation, but only for limited sets of symbols and sequential patterns.  It does scale without reconfiguration to an arbitrarily large base linguistic units, prefixes, endings, and suffixes, limited only by our hardware capacities and throughput.  The existence of regular expression libraries was helpful to keep the design simple.  We use the PCRE version 8 series library fed by a ansiotropic form of DCNN for feature extraction from a window moving through the input text with a configurable windows size and move increment size.  Heuristics applied to input text statistics gathered in a first pass produce a set of hypothetical PCREs arranged in two layers.  

Optimization occurs to apply higher probabilistic weights to the best PCREs in a chaotically perturbed text search.  It uses the same gradient descent convergence strategies used in NN back propagation in training.  It is a naive approach that does not make assumptions like the existence of back-traces, files, or errors.  It would adapt equally to Arabic messages and Spanish ones.  

The output is an arbitrary directed graph in memory, which is similar to a dump of an object oriented database.  

```text
قنبلة -> dangereux -> 4anlyss
bomba -> dangereux
ambiguïté -> 4anlyss -> préemption -> قنبلة
```

Although a re-entrant algorithm for a reinforcement version is stubbed out and the wellness signal is already available, other work preempted furthering the adaptive parser or working toward the next step to use the work for natural language: Matching the directed graphs to persisted directed graph filters representing ideas, which would mimic the idea recollection aspect of language comprehension.  

<strong>Final Comments</strong>  

The system has components and process architecture similar to the log analysis problem and prove the concepts listed above.  Of course, the more disorganization in the way logging is done between developers of the system doing the logging, the more difficult it is for a human or artificial agent to disambiguate the entries.  Some system logging has been so poorly quality control for so long that the log is nearly useless.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How does one start learning artificial intelligence? (score [14826](https://stackoverflow.com/q/3374) in 2019)

#### Question
I am a software engineering student and I am complete beginner to AI. I have read a lot of articles on how to start learning AI, but each article suggests a different way. I was wondering if some of you experts can help me get started in the right way.  

A few more specific questions  

<ol>
<li><p>Which language should I focus on? A lot of articles suggest Python, C++ or Lisp for AI. Can I use Java instead of any of the other languages mentioned?</p></li>
<li><p>What kind of mathematical background should I have? During the first year, I did discrete mathematics, which included the following topics: sets, matrices, vectors, functions, logic and graph theory (They taught these topics briefly). Are the are there any more topics that I should learn now? For example, calculus?</p></li>
</ol>

If possible, I would appreciate any resources or books I could use in order to get started, or maybe you guys can give me a detailed procedure I can follow in order to catch up with to your level.  

Note: For now I would like to focus on neural networks and machine learning. After I that I would like to explore robotics and natural language processing.  

#### Answer accepted (score 14)
Artificial Intelligence is a very broad field and it covers many and very deep areas of computer science, mathematics, hardware design and even biology and psychology. As for the math: I think calculus, statistics and optimization are the most important topics, but learning as much math as you can won't hurt.  

<p>There are many good free introductory resources about AI for beginners.
I highly recommend to start with this one:
<a href="http://aiplaybook.a16z.com/" rel="noreferrer">http://aiplaybook.a16z.com/</a>
They also published two videos about the general concepts of AI, you can find them on Vimeo:
"AI, Deep Learning, and Machine Learning: A Primer"
and
"The Promise of AI"</p>

Once you have a clear understanding of the basic AI terms and approaches, you have to figure out what your goals are. What kind of AI software do you want to develop? What industries are you interested in? What are your chances to get involved in projects of big companies? It's easier to pick up the right tools when you know exactly what you want to achieve.  

<p>For most newcomers to AI the most interesting area is Deep Learning.
Just to make it clear, there are many areas of AI outside of Machine Learning and there are many areas of Machine Learning outside of Deep Learning.
(Artificial Intelligence > Machine Learning > Deep Learning)
Most of recent developments and hyped news are about DL.</p>

If you got interested in Deep Learning too, you have to start with learning about the concepts of artificial neural networks. Fortunately it's not too difficult to understand the basics and there are lots of tutorials, code examples and free learning resources on the web and there are many open-source frameworks to start experimenting with.  

The most popular such Deep Learning framework is TensorFlow. It's backed by Google. Love it or hate it, it's a Python based framework. There are many other Python based frameworks, as well. Scikit-learn, Theano, Keras are frequently mentioned in tutorials too. (A tip: if you use Windows you can download WinPython that includes all of these frameworks.)  

As for about Java frameworks, unfortunately there are not so many options. The most prominent Java framework for DL is Deeplearning4j. It's developed by a small company and its user base is much smaller then the crowd around TensorFlow. There are fewer projects and tutorials for this framework. However, industry specialists say Java based frameworks eventually integrate better with Java based Big Data solutions and they may provide a higher level of portability and easier product deployment. Just a sidenote: NASA's Jet Propulsion Laboratory used Deeplearning4j for many projects.  

If you decide to go with the flow and want to start learning more about TensorFlow, I recommend you to check out the YouTube channels of "DeepLearning.TV", "sentdex" and "Siraj Raval". They have nice tutorials and some cool demos. And if you decide to take a deeper dive, you can sign up for an online course at udacity or coursera.  

It also may be interesting to you to know that there are other Deep Learning frameworks for the Java Virtual Machine with alternative languages, for example Clojure. ( Clojure is a dialect of LISP and it was invented by John McCarthy, the same computer scientist who coined the term "artificial intelligence". In other words there are more modern and popular programming languages and tools, but it's still possible /and kinda cool/ to use the language for AI that was originally designed for AI. ThinkTopic in Boulder and Freiheit in Hamburg are two companies that use Clojure for AI projects. And if you want to see something awesome to get inspiration to use Clojure in AI and robotics, I recommend you to check out the YouTube video "OSCON 2013: Carin Meier, The Joy of Flying Robots with Clojure". (Mentioning Clojure in this answer was just an example to show you there is life outside of the bubble of Python-based AI frameworks.)  

(+++ Anybody feel free to correct me if I said anything wrong. +++)  

#### Answer 2 (score 5)
You'll find that both Calculus and Linear Algebra have some application in AI/ML techniques.  In many senses, you can argue that most of ML reduces to Linear Algebra, and Calculus is used in, eg. the backpropagation algorithm for training neural networks.    

You'd be well served to take a class or two in probability and statistics as well.  

Programming language choice is less important, IMO.  You can do AI/ML in pretty much any mainstream language, and plenty of non-mainstream languages.  The biggest difference involve performance, and availability of libraries / tools.  C++, for example, is usually going to outperform Java or Python and it lets you get "close to the metal" to really maximize the capabilities of your hardware.  Python, however, has a really good FFI, and is often used in conjunction with C or C++.   Python, C++, Java, R, Octave/Matlab and a few other languages tend to have lots of high quality libraries available, which may be important to you depending on what you want to do.   

That said, you probably don't want to try and do ML / AI in, say, COBOL or PL/I or RPG/400 or something.  Stick to something at least reasonably popular.  Poke around mloss.org and look at what libraries / toolkits are available in different languages and that should help guide your choice.  

#### Answer 3 (score 4)
When I got interested in AI, I started with the most basic things. My very first book was Russell&amp;Norvig's <a href="http://aima.cs.berkeley.edu/" rel="nofollow noreferrer">Artificial Intelligence- A modern Approach</a>. I think that's a good place to start, even if you're mostly interested in Deep Nets. It treats not just the basic AI concepts and algorithms (expert systems, depth-first and breadth-first search,knowledge representation,etc.) but also the fundamental mathematics (Bayesian reasoning, First Order Logic, NL n-grams, etc.) and some commonly known problems (as Traveling salesman problem for example).   

It may also be a good idea to learn statistics, since you are particularly interested in ML. After the mentioned book, you should also have a good idea about what to learn next.  

<ul>
<li>Don't care too much about the programming language. </li>
</ul>

It's much more important to understand programming itself and the related techniques. Learn something about data structures, algorithms, and the different programming paradigms (like OOP, Functional Programming, etc.). Try to understand the logic behind programming and not just a particular language. After all, learning a new language isn't that hard once you understand how to program (then learning a new language is just more or less syntactic sugar).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Some examples about Intelligent Agents classes (score [13909](https://stackoverflow.com/q/3243) in 2018)

#### Question
These days I searched about Intelligent Agents, and found that there are classes of Intelligent Agents such as:  

<ul>
<li>simple reflex agents</li>
<li>model-based reflex agents</li>
<li>goal-based agents</li>
<li>utility-based agents</li>
<li>learning agents</li>
</ul>

And there were diagrams about each class of IA, about how each type works by getting percepts from sensors and acting on the environment by effectors, with a special process inbetween.  

And I think that IA concepts, described on those sites I've searched, were very abstract and I'd like to have:  

<ol>
<li>Some examples about each class of IA.</li>
<li>Optional: Some compact definition of each class.</li>
</ol>

It will be helpful to compare and visualize those IA classes, and to understand well about what their working diagrams describe.  

#### Answer accepted (score 6)
There's no distinguishable hardware examples for each IA class. Same mobile robot architecture with proper sensors can be implemented to behave as any IA class. The way you can determine the class of an intelligent agent is from the way it process the percept, Based on chapter 2 of <em>Artificial Intelligent: A Modern Approach</em> I will try to give a concise explanation for each class:  

<strong>Simple Reflex agents:</strong> Takes action based on only the current environment situation it maps the current percept into proper action ignoring the history of percepts.The mapping process could be simply a table-based or by any rule based matching algorithm. Example of this class is a robotic vacuum cleaner that deliberate in an infinite loop, each percept contains a state of a current location [clean] or [dirty] and accordingly it decides whether to [suck] or [continue-moving].   

<strong>Model-based Reflex agents:</strong> Needs memory for storing the percept history, it uses the percept history to help revealing the current unobservable aspects of the environment. example of this IA class is the self-steering mobile vision where it's necessary to check the percept history to fully understand how the world is evolving.  

<strong>Goal-based Reflex agents:</strong> This kind of IA has a goal and has a strategy to reach that goal, All actions are based on its goal and from a set of possible actions it selects the one that improves the progress towards goal (not necessarily the best one). Example of this IA class is any searching robots that has initial location and want to reach a destination.  

<strong>Utility-based Reflex agents:</strong> Like the Goal-based agent but with a measure of "how much happy" an action would make me rather than the goal-based binary feedback ['happy','unhappy'], this kind of agents provide the best solution, an example is the route recommendation system which solves for the 'best' route to reach a destination.  

<strong>Learning agents:</strong> The essential component of autonomy, this agent is capable of learning from experience, it has the capability of automatic information acquisition and integration into the system, any agent designed and expected to be successful in an uncertain environment is considered to be learning agent.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Is it possible to train the neural network to solve math equations? (score [13843](https://stackoverflow.com/q/154) in 2017)

#### Question
I'm aware that neural networks are probably not designed to do that, however asking hypothetically, is it possible to train the deep neural network (or similar) to solve math equations?  

So given the 3 inputs: 1st number, operator sign represented by the number (1 - `+`, 2 - `-`, 3 - `/`, 4 - `*`, and so on), and the 2nd number, then after training the network should give me the valid results.  

Example 1 (`2+2`):  

<ul>
<li>Input 1: `2`; Input 2: `1` (`+`); Input 3: `2`; Expected output: `4`</li>
<li>Input 1: `10`; Input 2: `2` (`-`); Input 3: `10`; Expected output: `0`</li>
<li>Input 1: `5`; Input 2: `4` (`*`); Input 3: `5`; Expected output: `25`</li>
<li>and so</li>
</ul>

The above can be extended to more sophisticated examples.  

Is that possible? If so, what kind of network can learn/achieve that?  

#### Answer accepted (score 21)
Yes, it has been done!  

However, the applications aren't to replace calculators or anything like that. The lab I'm associated with develops neural network models of equational reasoning to better understand how humans might solve these problems. This is a part of the field known as <a href="http://archive.is/mt4RO" rel="noreferrer">Mathematical Cognition</a>. Unfortunately, our website isn't terribly informative, but here's a <a href="http://web.stanford.edu/~kmickey/pdf/MickeyMcClelland2014.pdf" rel="noreferrer">link</a> to an example of such work.  

Apart from that, recent work on extending neural networks to include external memory stores (e.g. Neural Turing Machines) tend to use solving math problems as a good proof of concept. This is because many arithmetic problems involve long procedures with stored intermediate results. See the sections of <a href="http://arxiv.org/pdf/1511.08228.pdf" rel="noreferrer">this paper</a> on long binary addition and multiplication.  

#### Answer 2 (score 8)
Not really.  

Neural networks are good for determining non-linear relationships between inputs when there are hidden variables. In the examples above the relationships are linear, and there are no hidden variables. But even if they were non-linear, a traditional ANN design would not be well suited to accomplish this.  

By carefully constructing the layers and tightly supervising the training, you could get a network to consistently produce the output 4.01, say, for the inputs: 2, 1 (+), and 2, but this is not only wrong, it's an inherently unreliable application of the technology.  

#### Answer 3 (score 5)
1) It is possible! In fact, it's an example of the popular deep learning framework Keras. Check out <a href="https://github.com/fchollet/keras/blob/master/examples/addition_rnn.py" rel="nofollow noreferrer">this link to see the source code</a>.  

2) This particular example uses a recurrent neural network (RNN) to process the problem as a sequence of characters, producing a sequence of characters which form the answer. Note that this approach is obviously different from how humans tend to think about solving simple addition problems, and probably isn't how you would ever want a computer to solve such a problem. Mostly this is an example of sequence to sequence learning using Keras. When handling sequential or time-series inputs, RNNs are a popular choice.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: Using Machine/Deep learning for guessing Pseudo Random generator (score [13595](https://stackoverflow.com/q/3850) in )

#### Question
Is it possible to feed a neural network, the output from a random number generator and expect it learn the hashing/generator function. So that it can predict what will be the next generated number? Does something like this already exist? If research is already done on this or something related to (predict pseudo random numbers) can anyone point me to the right resources. Any additional comments or advice would also be helpful.  

<p>Currently I am looking at this library and its related links.
<a href="https://github.com/Vict0rSch/deep_learning/tree/master/keras/recurrent" rel="noreferrer">https://github.com/Vict0rSch/deep_learning/tree/master/keras/recurrent</a></p>

#### Answer 2 (score 11)
If we are talking about a perfect RNG, the answer is a clear <strong>no</strong>. It is impossible to predict a truly random number, otherwise it wouldn't be truly random.  

When we talk about pseudo RNG, things change a little. Depending on the quality of the PRNG, the problem ranges from easy to almost impossible. A very weak PRNG like the one <a href="https://xkcd.com/221/" rel="noreferrer">XKCD</a> published could of course be easily predicted by a neural network with little training. But in the real world things look different.  

The neural network could be trained to find certain patterns in the history of random numbers generated by a PRNG to predict the next bit. The stronger the PRNG gets, the more input neurons are required, assuming you are using one neuron for each bit of prior randomness generated by the PRNG. The less predictable the PRNG gets, the more data will be required to find some kind of pattern. For strong PRNGs this is not feasable.  

On a positive note, it is helpful that you can generate an arbitrary amount of training patterns for the neural network, assuming that you have control over the PRNG and can produce as many random numbers as you want.  

Because modern PRNGs are a key component for cryptography, extensive research has been conducted to verify that they are "random enough" to withstand such prediction attacks. Therefore I am pretty sure that it is not possible with currently available computational resources to build a neural network to successfully attack a PRNG that's considered secure for cryptography.  

It is also worth noting that it is not necessary to exactly predict the output of a PRNG to break cryptography - it might be enough to predict the next bit with a certainty of a little more than 50% to weaken an implementation significantly. So if you are able to build a neural network that predicts the next bit of a PRNG (considered secure for cryptography) with a 55% success rate, you'll probably make the security news headlines for quite a while.  

#### Answer 3 (score 3)
Being a  complete newbie in machine learning, I did this experiment (using Scikit-learn ):  

<ul>
<li><p>Generated a large number (N) of pseudo-random extractions, using python random.choices function to select N numbers out of 90.</p></li>
<li><p>Trained a MLP classifier with training data composed as follow:</p>

<ul>
<li>ith sample : X &lt;- lotteryResults[i:i+100], Y &lt;- lotteryResults[i]</li>
</ul>

In practice, I aimed to a function that given N numbers, coud predict the next one.  </li>
<li><p>Asked the trained classificator to predict the remaining numbers.</p></li>
</ul>

Results:   

<ul>
<li><p>of course, the classificator obtained a winning score comparable with the one of  random guessing or of other techniques not based on neural networks (I compared results with several classifiers available in scikit-learn libraries )</p></li>
<li><p>however, if I generate the pseudo-random lottery extractions with a specific distribution function, then the numbers predicted by the neural network are roughly generated with the same distribution curve ( if you plot the occurrences of the random numbers and of the neural network predictions, you can see that that the two have the same trend, even if in the predicytions curve there are many spikes. So maybe the neural network is able to learn about pseudo-random number distributions ?</p></li>
<li><p>If I reduce the size of the training set under a certain limit, I see that the classifier starts to predict always the same few numbers, which are among the most frequent in the pseudo-random generation. Strangely enough ( or maybe not ) this behaviour seem to slightly increase the winning score.</p></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: 1 hidden layer with 1000 neurons vs. 10 hidden layers with 100 neurons (score [12895](https://stackoverflow.com/q/3262) in )

#### Question
These types of questions may be problem-dependent, but I have tried to find research that addresses the question whether the number of hidden layers and their size (number of neurons in each layer) really matter or not.  

So my question is, does it really matter if we for example have 1 large hidden layer of 1000 neurons vs. 10 hidden layers with 100 neurons each?  

#### Answer accepted (score 11)
Basically, having multiple layers (aka a deep network) makes your network more eager to recognize certain aspects of input data. For example, if you have the details of a house (size, lawn size, location etc.) as input and want to predict the price. The first layer may predict:  

<ul>
<li>Big area, higher price</li>
<li>Small amount of bedrooms, lower price</li>
</ul>

The second layer might conclude:  

<ul>
<li>Big area + small amount of bedrooms = large bedrooms = +- effect</li>
</ul>

Yes, one layer can also 'detect' the stats, however it will require more neurons as it cannot rely on other neurons to do 'parts' of the total calculation required to detect that stat.  

<a href="https://stats.stackexchange.com/questions/274569/deep-networks-vs-shallow-networks-why-do-we-need-depth/274571#274571">Check out this answer</a>  

#### Answer 2 (score 4)
There are so many aspects.  

<p><strong>1. Training:</strong>
Training deep nets is a hard job due to the <a href="http://neuralnetworksanddeeplearning.com/chap5.html#the_vanishing_gradient_problem" rel="nofollow noreferrer">vanishing</a> (rearly exploding) gradient problem. So building a 10x100 neural-net is not recommended.</p>

<strong>2. Trained network performance:</strong>  

<ul>
<li><strong>Information loss:</strong>
The classical usage of neural nets is the <a href="https://math.stackexchange.com/questions/141381/regression-vs-classification">classification</a> problem. Which means we want to get some well defined information from the data. (Ex. Is there a face in the picture or not.)
So usually classification problem has a lot of input, and few output, whats more the size of the hidden layers are descend from input to output.
However, we loss information using less neurons layer by layer. (Ie. We cannot reproduce the original image based on the fact that is there a face on it or no.) So you must know that you loss information using 100 neurons if the size of the input is (lets say) 1000.</li>
<li><strong>Information complexity:</strong> However the deeper nets (as Tomas W mentioned) can fetch more complex information from the input data. Inspite of this its not recommended to use 10 fully connected layers. Its recommended to use convolutional/relu/maxpooling or other type of layers. Firest layers can compress the some essential part of the inputs. (Ex is there any line in a specific part of the picture) Second layers can say: There is a specific shape in this place in the picture. Etc etc.</li>
</ul>

<strong>So deeper nets are more "clever" but 10x100 net structure is a good choice.</strong>  

#### Answer 3 (score 1)
<p>If the problem you are solving is linearly separable, one layer of 1000 neurons can do better job than 10 layers with each of 100 neurons.
If the problem is non linear and not convex, then you need deep neural nets. </p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: Can digital computers understand infinity? (score [12747](https://stackoverflow.com/q/15730) in 2019)

#### Question
As a human being, we can think infinity. In principle, if we have enough resources (time etc.), we can count infinitely many things (including abstract, like numbers, or real).  

For example, at least, we can take into account integers. We can think, principally, and "understand" infinitely many numbers that are displayed on the screen. Nowadays, we are trying to design artificial intelligence which is capable at least human being. However, I am stuck with infinity. I try to find a way how can teach a model (deep or not) to understand infinity. I define "understanding' in a functional approach. For example, If a computer can differentiate 10 different numbers or things, it means that it really understand these different things somehow. This is the basic straight forward approach to "understanding".  

As I mentioned before, humans understand infinity because they are capable, at least, counting infinite integers, in principle. From this point of view, if I want to create a model, the model is actually a function in an abstract sense, this model must differentiate infinitely many numbers. Since computers are digital machines which have limited capacity to model such an infinite function, how can I create a model that differentiates infinitely many integers?  

For example, we can take a deep learning vision model that recognizes numbers on the card. This model must assign a number to each different card to differentiate each integer. Since there exist infinite numbers of integer, how can the model assign different number to each integer, like a human being, on the digital computers? If it cannot differentiate infinite things, how does it understand infinity?  

If I take into account real numbers, the problem becomes much harder.  

What is the point that I am missing? Are there any resources that focus on the subject?  

#### Answer accepted (score 51)
I think this is a fairly common misconception about AI and computers, especially among laypeople. There are several things to unpack here.  

Let's suppose that there's something special about infinity (or about continuous concepts) that makes them especially difficult for AI. For this to be true, it must <em>both</em> be the case that humans can understand these concepts while they remain alien to machines, <em>and</em> that there exist other concepts that are not like infinity that both humans <em>and</em> machines can understand. What I'm going to show in this answer is that wanting both of these things leads to a contradiction.  

The root of this misunderstanding is the problem of what it means to <em>understand</em>. Understanding is a vague term in everyday life, and that vague nature contributes to this misconception.  

If by understand, we mean that a computer has the conscious experience of a concept, then we quickly become trapped in metaphysics. There is a <a href="https://plato.stanford.edu/entries/chinese-room/" rel="noreferrer">long running</a>, and essentially open debate about whether computers can "understand" anything in this sense, and even at times, about whether humans can! You might as well ask whether a computer can "understand" that 2+2=4. Therefore, if there's something <em>special</em> about understanding infinity, it cannot be related to "understanding" in the sense of subjective experience.  

So, let's suppose that by "understand", we have some more specific definition in mind. Something that would make a concept like infinity more complicated for a computer to "understand" than a concept like arithmetic. Our more concrete definition for "understanding" must relate to some objectively measurable capacity or ability related to the concept (otherwise, we're back in the land of subjective experience). Let's consider what capacity or ability might we pick that would make infinity a special concept, understood by humans and not machines, unlike say, arithmetic.  

We might say that a computer (or a person) understands a concept if it can provide a correct definition of that concept. However, if even one human understands infinity by this definition, then it should be easy for them to write down the definition. Once the definition is written down, a computer program can output it. Now the computer "understands" infinity too. This definition doesn't work for our purposes.  

We might say that an entity understands a concept if it can <em>apply</em> the concept correctly. Again, if even the one person understands how to apply the concept of infinity correctly, they we need only record the rules they are using to reason about the concept, and we can write a program that reproduces the behavior of this system of rules. Infinity is actually very well characterized as a concept, captured in ideas like <a href="https://en.wikipedia.org/wiki/Aleph_number" rel="noreferrer">Aleph Numbers</a>. It is not impractical to encode these systems of rules in a computer, at least up to the level that any human understands them. Therefore, computers can "understand" infinity up to the same level of understanding as humans by this definition as well. So this definition doesn't work for our purposes.  

We might say that an entity "understands" a concept if it can logically relate that concept to arbitrary new ideas. This is probably the strongest definition, but we would need to be pretty careful here: very few humans (proportionately) have a deep understanding of a concept like infinity. Even fewer can readily relate it to arbitrary new concepts. Further, algorithms like the <a href="https://en.wikipedia.org/wiki/General_Problem_Solver" rel="noreferrer">General Problem Solver</a> can, in principal, derive any logical consequences from a given body of facts, given enough time. Perhaps under this definition computers understand infinity <em>better</em> than most humans, and there is certainly no reason to suppose that our existing algorithms will not further improve this capability over time. This definition does not seem to meet our requirements either.  

Finally, we might say that an entity "understands" a concept if it can generate examples of it. For example, I can generate examples of problems in arithmetic, and their solutions. Under this definition, I probably do not "understand" infinity, because I cannot actually point to or create any concrete thing in the real world that is definitely infinite. I cannot, for instance, actually write down an infinitely long list of numbers, merely formulas which express ways to create ever longer lists by investing ever more effort in writing them out. A computer ought to be at least as good as me at this. This definition also does not work.  

This is not an exhaustive list of possible definitions of "understands", but we have covered "understands" as I understand it pretty well. Under every definition of understanding, there isn't anything special about infinity that separates it from other mathematical concepts.   

So the upshot is that, either you decide a computer doesn't "understand" anything at all, or there's no particularly good reason to suppose that infinity is harder to understand than other logical concepts. If you disagree, you need to provide a concrete definition of "understanding" that <em>does</em> separate understanding of infinity from other concepts.  

Infinity has a sort of semi-mystical status among the lay public, but it's really just like any other mathematical system of rules: if we can write down the rules by which infinity operates, a computer can do them as well as a human can (or better).  

#### Answer 2 (score 17)
I think your premise is flawed.  

You seem to assume that to "understand"(*) infinities requires infinite processing capacity, and imply that humans have just that, since you present them as the opposite to limited, finite computers.   

But humans <em>also</em> have finite processing capacity. We are beings built of a finite number of elementary particles, forming a finite number of atoms, forming a finite number of nerve cells. If we can, in one way or another, "understand" infinities, then surely finite computers can also be built that can.   

(* I used "understand" in quotes, because I don't want to go into e.g. the definition of sentience etc. I also don't think it matters in regarding this question.)  

<blockquote>
  As a human being, we can think infinity. In principle, if we have enough resources (time etc.), we can count infinitely many things (including abstract, like numbers, or real).  
</blockquote>

Here, you actually say it out loud. "With enough resources." Would the same not apply to computers?  

While humans <em>can</em>, e.g. use infinities when calculating limits etc. and can think of the idea of something getting arbitrarily larger, we can only do it in the abstract, not in the sense being able to process arbitrarily large numbers. The same rules we use for mathematics could also be taught to a computer.  

#### Answer 3 (score 11)
<strong>TL;DR</strong>: The subtleties of infinity are made apparent in the notion of unboundedness. Unboundedness is finitely definable. "Infinite things" are really things with unbounded natures. Infinity is best understood not as a thing but as a concept. Humans theoretically possess unbounded abilities <em>not</em> infinite abilities (eg to count to any arbitrary number as opposed to "counting to infinity"). A machine can be made to recognize unboundedness.   

<strong>Down the rabbit hole again</strong>  

How to proceed? Let's start with "limits."  

<strong>Limitations</strong>  

Our brains are not infinite (lest you believe in some metaphysics). So, we do not "think infinity". Thus, what we purport as infinity is best understood as some <strong>finite</strong> mental <em>concept</em> against which we can "compare" other concepts.   

Additionally, we cannot "count infinite integers." There is a subtly here that is <em>very</em> important to point out:   

Our concept of quantity/number is <strong><em>unbounded</em></strong>. That is, for any any finite value we have a finite/concrete way or producing another value which is strictly larger/smaller. That is, Provided <em>finite</em> time we could only count <em>finite</em> amounts.   

You cannot be "given infinite time" to "count all the numbers" this would imply a "finishing" which directly contradicts the notion of infinity. Unless you believe humans have metaphysical properties which allow them to "consistently" embody a paradox. Additionally how would you answer: What was the last number you counted? With no "last number" there is never a "finish" and hence never an "end" to your counting. That is you can never "have enough" time/resources to "count to infinity."  

I think what you mean is we can fathom the notion of <a href="https://en.wikipedia.org/wiki/Bijection" rel="nofollow noreferrer">bijection</a> between infinite sets. But this notion is a logical <em>construction</em> (ie it's a finite way of wrangling what we understand to be infinite).  

However, what we are really doing is: Within our bounds we are talking about our bounds and, when ever we need to, we can expand our bounds (by a finite amount). And we can even talk about the nature <em>of</em> expanding our bounds. Thus:   

<strong>Unboundedness</strong>  

A process/thing/idea/object is deemed unbounded if given some <em>measure</em> of its quantity/volume/existence we can in a finite way produce an "extension" of that object which has a measure we deem "larger" (or "smaller" in the case of infinitesimals) than the previous measure and that this extension process can be applied to the nascent object (ie the process is recursive).  

<em>Canonical case number one: The Natural Numbers</em>  

Additionally, our notion of infinity prevents any "at-ness" or "upon-ness" unto infinity. That is, one never "arrives" at infinity nor does one ever "have" infinity. Rather, one proceeds unboundedly.  

Thus how do we conceptualize infinity?  

<strong>Infinity</strong>  

It seems that "infinity" as a word is misconstrued to mean that there is a <em>thing that exists</em> called "infinity" as opposed to a <em>concept</em> called "infinity". Let's smash atoms with the word:  

<blockquote>
  Infinite: limitless or endless in space, extent, or size; impossible to measure or calculate.  
  
  <p>in- :a prefix of Latin origin, corresponding to English un-, having a negative or privative force, freely used as an English formative, especially of adjectives and their derivatives and of nouns (inattention; indefensible; inexpensive; inorganic; invariable).
  (<a href="https://www.dictionary.com/browse/in-" rel="nofollow noreferrer">source</a>)</p>
  
  Finite: having limits or bounds.  
</blockquote>

So in-finity is really un-finity which is <em>not having limits or bounds</em>. But we can be more precise here because we can all agree the natural numbers are infinite but <em>any</em> given natural number is finite. So what gives? Simple: <em>the</em> natural numbers satisfy our unboundedness criterium and thus we say "the natural numbers are infinite."  

That is, "infinity" is a concept. An object/thing/idea is deemed infinite if it possess a property/facet that is unbounded. As before we saw that unboundedness is finitely definable.  

Thus, if the agent you speak of was programmed well enough to spot the pattern in the numbers on the cards and that the numbers are all coming from the same set it could deduce the unbounded nature of the sequence and hence define the set of all numbers as infinite - purely because the set <em>has no upper bound</em>. That is, the progression of the natural numbers is unbounded and hence definably infinite.  

Thus, to me, infinity is best understood as a general concept for identifying when processes/things/ideas/objects posses an unbounded nature. That is, infinity is not independent of unboundedness. Try defining infinity without comparing it to finite things or the bounds of those finite things.   

<strong>Conclusion</strong>  

It seems feasible that a machine could be programmed to represent and detect instances of unboundedness or when it might be admissible to assume unboundedness.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Is a switch from R to Python worth it? (score [12715](https://stackoverflow.com/q/13775) in 2019)

#### Question
I just finished a 1-year Data Science master's program where we were taught R. I found that Python is more popular and has a larger community in AI.   

Is it worth for someone in my position to switch to Python and if yes, why? Does python have any game-changing features not available in R or is it just a matter of community?  

#### Answer accepted (score 59)
I want to reframe your question.  

Don't think about switching, think about adding.  

In data science you'll be able to go very far with either python or r but you'll go farthest with both.  

Python and r integrate very well, thanks to the `reticulate` package. I often tidy data in r because it is easier for me, train a model in python to benefit from superior speed and visualize the outcomes in r in beautiful `ggplot` all in one notebook!  

If you already know r there is no sense in abandoning it, use it where sensible and easy to you. But it is 100% a good idea to add python for many uses.  

Once you feel comfortable in both you'll have  a workflow that fits you best dominated by your favorite language.  

#### Answer 2 (score 28)
Of course, this type of questions will also lead to primarily opinion-based answers. Nonetheless, it is possible to enumerate the strengths and weakness of each language, with respect to machine learning, statistics, and data analysis tasks, which I will try to list below.  

<h5>R</h2>

<h5>Strengths</h3>

<ul>
<li><p>R was designed and developed for statisticians and data analysts, so it provides, <a href="https://en.wikipedia.org/wiki/Out_of_the_box_(feature)" rel="noreferrer">out-of-the-box</a> (that is, they are part of the language itself), features and facilities for statisticians, which are not available in Python, unless you install a related package. For example, the data frame, which Python does not provide, unless you install the famous Python's <a href="https://pandas.pydata.org/" rel="noreferrer">`pandas`</a> package. There are other examples like matrices, vectors, etc. In Python, there are also similar data structures, but they are more general, so not specifically targeted for statisticians.</p></li>
<li><p>There are a lot of statistical libraries.</p></li>
</ul>

<h5>Weakness</h3>

<ul>
<li>Given its purpose, R is mainly used to solve statistical or data analysis problems. However, it can also be used outside of this domain. See, for example, this Quora question: <a href="https://qr.ae/TWvefg" rel="noreferrer">Is R used outside of statistics and data analysis?</a>.</li>
</ul>

<h5>Python</h2>

<h5>Strengths</h3>

<ul>
<li><p>A lot of people and companies, including Google and Facebook, invest a lot in Python. For example, the main programming language of TensorFlow and PyTorch (two widely used machine learning frameworks) is Python. So, it is very unlikely that Python won't continue to be widely used in machine learning for at least 5-10 more years.</p></li>
<li><p>The Python community is likely a lot bigger than the R community. In fact, for example, if you look at <a href="https://www.tiobe.com/tiobe-index/" rel="noreferrer">Tiobe's index</a>, Python is placed 3rd, while R is placed 20th.</p></li>
<li><p>Python is also widely used outside of the statistics or machine learning communities. For example, it is used for web development (see e.g. the Python frameworks Django or Flask).</p></li>
<li><p>There are a lot of machine learning libraries (e.g. TensorFlow and PyTorch).</p></li>
</ul>

<h5>Weakness</h3>

<ul>
<li>It does not provide, out-of-the-box, the statistical and data analysis functionalities that R provides, unless you install an appropriate package. This might be a weakness or a strength, depending on your philosophical point of view.</li>
</ul>

There are other possible advantages and disadvantages of these languages. For example, both languages are dynamic. However, this feature can both be an advantage and a disadvantage (and it is not strictly related to machine learning or statistics), so I did not list it above. I avoided mentioning opinionated language features, such as code readability and learning curve, for obvious reasons (e.g. not all people have the same programming experience).  

<h5>Conclusion</h2>

Python is definitely worth learning if you are studying machine learning or statistics. However, it does not mean that you will not use R anymore. R might still be handier for certain tasks.   

#### Answer 3 (score 6)
I didn't have this choice because I was forced to move from R to Python:  

It depends on your <strong>environment</strong>: When you are embedded in an <strong>engineer</strong> department, working technical group or something similar than Python is more feasible.  

When you are surrounded by <strong>scientists</strong> and especially <strong>statisticians</strong>, stay with R.  

<p>PS: R offers keras and tensorflow as well though it is implemented under the hood of python. Only very advanced stuff will make you need Python.
Though I'm getting more and more used to Python, the synthax in <strong>R is easier</strong>. And though each package has its own, it is somehow consistent while Python is not..
And ggplot is so strong. Python has a clone (plotnine) but it lacks several (important) features. In principle you can do nearly as much as in R but especially visualization and data wrangling is much easier in R. Thus, the most famous Python library, pandas, is a <strong>clone</strong> of R.</p>

<p>PSS: <strong>Advanced</strong> statistics aims definitely at R. Python offers a lot of everyday tools and methods for a data scientist but it will never reach those ><strong>13,000</strong> packages R provides. For example, I had to do an inverse regression and python doesn't offer this. In R you can choose between several confidence tests and whether it is linear or nonlinear. 
The same goes to mixed models: It is implemented in python but it is so basic there I can't realize how this can be sufficient for someone.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: Are there real applications of fuzzy logic? (score [12555](https://stackoverflow.com/q/4176) in )

#### Question
<a href="https://ai.stackexchange.com/questions/10/what-is-fuzzy-logic">This question</a> covers in detail, what fuzzy logic is and how it relates to other math fields, such as boolean algebra and sets theory.  

<a href="https://ai.stackexchange.com/questions/118/how-can-fuzzy-logic-be-used-in-creating-ai">This question</a> is also very related, but the answers are focused more on general intuition and <em>potential</em> applicability. The only working system based on fuzzy logic, mentioned there, is <a href="https://en.wikipedia.org/wiki/Mycin" rel="noreferrer">MYCIN</a>, which goes back to the early 70s. This quote from wiki summarizes my impression of it:  

<blockquote>
  MYCIN was never actually used in practice.  
</blockquote>

From my experience in AI, the best tool to deal with uncertainty is <a href="https://en.wikipedia.org/wiki/Bayesian_probability" rel="noreferrer">Bayesian probability</a> and inference. It allows to apply not only a wide range of probabilistic tools, such as expectation, MLE, cross-entropy, etc, but also calculus and algebra.  

Can you call fuzzy logic a "pure theoretical" concept, which only played its role in the early development of AI? Are there real practical applications of fuzzy logic? What problem would you recommend to solve and to <em>code</em> using fuzzy logic?  

#### Answer accepted (score 3)
Fuzzy logic seems to have multiple of applications historically in Automotive Engineering.    

I found an interesting article on the subject from 1997. This excerpt provides an interesting rationale:  

<blockquote>
  <p>The key reason for fuzzy logic’s success in automotive engineering lies in the implications of its paradigm shift. Previously, engineers spent much time creating mathematical models of mechanical systems. More time went to real-world road tests that tuned the fudge factors of the control algorithms. If they succeeded, they ended up with a control algorithm of mathematical formulas involving many experimental parameters. Modifying or later optimizing such a solution is very difficult because of its lack of transparency. Fuzzy logic makes this design process faster, easier, and more transparent. It can implement control strategies using elements of everyday language. Everyone familiar with the control problem can read the fuzzy rules and understand what the system is doing and why. It also works for control systems with many control parameters. Designers can build innovative control systems that would have been intractable using traditional design techniques. <br><sub>SOURCE: <a href="ftp://ftp.me.psu.ac.th/pub/me/Fuzzy/88constantin.pdf" rel="nofollow noreferrer">Fuzzy Logic in
  Automotive Engineering</a>, 1997</sub></p>
</blockquote>

<br>Here are some papers and patents for automatic transmission control in motor vehicles. One of them is fairly recent:   

<a href="http://papers.sae.org/930674/" rel="nofollow noreferrer">Automatic Transmission Shift Schedule Control Using Fuzzy Logic</a> <br><sub>SOURCE: Society of Automotive Engineers, 1993</sub>  

<a href="http://www.tandfonline.com/doi/abs/10.1080/00423119508969099?journalCode=nvsd20" rel="nofollow noreferrer">Fuzzy Logic in Automatic Transmission Control</a> <br><sub>SOURCE: International Journal of Vehicle Mechanics and Mobility, 2007</sub>  

<p><a href="http://ipasj.org/IIJCS/Volume2Issue7/IIJCS-2014-06-24-3.pdf" rel="nofollow noreferrer">Fuzzy Logic Based Controller For Automated
Gear Control in Vehicles</a> <br><sub>SOURCE: International Journal of Computer Science, 2014</sub></p>

<a href="https://www.google.com/patents/US4841815" rel="nofollow noreferrer">Fuzzy control system for automatic transmission</a> | Patent | 1987  

<a href="https://www.google.com/patents/US5390117" rel="nofollow noreferrer">Transmission control with a fuzzy logic controller</a> | Patent | 1992  

<br>   

Likewise with fuzzy logic anti-lock breaking systems (ABS):  

<a href="http://www.fuzzytech.com/e/e_a_sie.html" rel="nofollow noreferrer">Antilock-Braking System and Vehicle Speed Estimation using Fuzzy Logic</a> <br><sub>SOURCE: FuzzyTECH, 1996</sub>  

<a href="https://www.ijser.org/researchpaper/FUZZY-LOGIC-ANTI-LOCK-BRAKE-SYSTEM.pdf" rel="nofollow noreferrer">Fuzzy Logic Anti-Lock Break System</a> <br><sub>SOURCE: International Journal of Scientific &amp; Engineering Research, 2012</sub>  

<a href="https://www.google.com/patents/US5416709?dq=fuzzy%20logic%20abs&amp;hl=en&amp;sa=X&amp;ved=0ahUKEwiV8dOaguLWAhUHLSYKHbtQC18Q6AEIKDAA" rel="nofollow noreferrer">Fuzzy controller for anti-skid brake systems</a> | Patent | 1993  

<br>   

This method seems to have been extended to aviation:  

<a href="http://aix.acad.ro/sectii2002/proceedings/doc2_2004/12_Ursu.pdf" rel="nofollow noreferrer">A Fuzzy Logic Control Synthesis for an Airplane Antilock-Breaking System</a> <br><sub>SOURCE: Proceedings of the Romanian Academy, 2004</sub>  

<a href="https://www.google.com/patents/US8955793?dq=fuzzy%20logic%20abs&amp;hl=en&amp;sa=X&amp;ved=0ahUKEwiV8dOaguLWAhUHLSYKHbtQC18Q6AEIVDAG" rel="nofollow noreferrer">Landing gear method and apparatus for braking and maneuvering</a> | Patent | 2003  

<br>  

#### Answer 2 (score 4)
You've obviously never heard of <a href="http://www.samsung.com/in/support/skp/faq/138486" rel="nofollow noreferrer">fuzzy logic washing machines</a>.  

<blockquote>
  ● Typically, fuzzy logic controls the washing process, water intake,water temperature, wash time, rinse performance, and spin speed. This optimises the life span of the washing machine. More sophisticated machines weigh the load (so you can’t overload the washing machine), advise on the required amount of detergent, assess cloth material type and water hardness, and check whether the detergent is in powder or liquid form. Some machines even learn from past experience,memorising programs and adjusting them to minimise running costs.   
</blockquote>

Fuzzy logic is used in a variety of control applications.  If your furnace can only be on or off, for example, you might use a probabilistic function of temperature to determine when to turn it on and off, rather than having fixed high and low temperatures activate your thermostat.  In some applications, that's been found to improve perceived comfort or efficiency.  

For more sophisticated AI applications, you could use fuzzy logic for activations in a neural net, but I don't think it's offering much improvement over fixed, weighted activations.  

#### Answer 3 (score 2)
The site <a href="http://www.fuzzytech.com/" rel="nofollow noreferrer">FuzzyTECH</a> lists an array of applications:  

<blockquote>
  <p><a href="http://www.fuzzytech.com/e/e_a_plc.html" rel="nofollow noreferrer">Industrial Automation</a> <br> 
  <a href="http://www.fuzzytech.com/e/e_a_glc.html" rel="nofollow noreferrer">Monitoring Glaucoma</a> <br> 
  <a href="http://www.fuzzytech.com/e/e_a_htw.html" rel="nofollow noreferrer">Coal Power Plant</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_kli.html" rel="nofollow noreferrer">Complex Chilling Systems</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_mull.html" rel="nofollow noreferrer">Refuse Incineration Plant</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_eet.html" rel="nofollow noreferrer">Fuzzy Logic Design</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_pfd.html" rel="nofollow noreferrer">Practical Design</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_dek.html" rel="nofollow noreferrer">Water Treatment System</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_spe.html" rel="nofollow noreferrer">Truck Speed Limiter</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_med.html" rel="nofollow noreferrer">Medical Shoe</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_med.html" rel="nofollow noreferrer">Fuzzy in Appliances</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_esw.html" rel="nofollow noreferrer">Automotive Engineering</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_sie.html" rel="nofollow noreferrer">Antilock Braking System</a> <br>
  <a href="http://www.fuzzytech.com/e/e_ap_afp.html" rel="nofollow noreferrer">Aircraft Flight Path</a> <br>
  <a href="http://www.fuzzytech.com/e/e_ap_nfu.html" rel="nofollow noreferrer">Nucluar Fusion</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_mot.html" rel="nofollow noreferrer">Motorla 68HC12 MCU</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_tfc.html" rel="nofollow noreferrer">Traffic Control</a> <br>
  <a href="http://www.fuzzytech.com/e/e_a_kumm.html" rel="nofollow noreferrer">Sonar Systems</a></p>
</blockquote>

Most of the linked articles have good bibliographies citing numerous papers, although it's notable that most of the material is a few decades old.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: What is the difference between artificial intelligence and machine learning? (score [11821](https://stackoverflow.com/q/35) in 2019)

#### Question
These two terms seem to be related, especially in their application in computer science and software engineering.  Is one a subset of another?  Is one a tool used to build a system for the other?  What are their differences and why are they significant?  

#### Answer 2 (score 46)
Machine learning has been defined by many people in different ways. One definition says that machine learning (ML) is the field of study that gives computers the <em>ability to learn</em> without being explicitly programmed.  

Given the above definition, we might say that machine learning is geared towards problems for which we have (lots of) data (experience), from which a program can learn and can get better at a task.  

Artificial intelligence has many more aspects, where machines do not get better at tasks by learning from data, but may exhibit <em>intelligence</em> through rules (e.g. expert systems like <a href="https://en.wikipedia.org/wiki/Mycin" rel="noreferrer">Mycin</a>), <a href="https://rads.stackoverflow.com/amzn/click/com/0201403757" rel="noreferrer" rel="nofollow noreferrer">logic</a> or algorithms, e.g. <a href="https://en.wikipedia.org/wiki/Pathfinding" rel="noreferrer">finding paths</a>.  

The book <a href="http://aima.cs.berkeley.edu/" rel="noreferrer"><em>Artificial Intelligence: A Modern Approach</em></a> shows more research fields of AI, like <em>Constraint Satisfaction Problems</em>, <em>Probabilistic Reasoning</em> or <em>Philosophical Foundations</em>.  

#### Answer 3 (score 15)
<p>Definitions of Artificial Intelligence can be categorized into four categories, Thinking Humanly, Thinking Rationally, Acting Humanly and Acting Rationally. The following picture (from Artificial Intelligence: A Modern Approach) will shed light on over these definitions:<br> <br>
<a href="https://i.stack.imgur.com/9jOK9.png" rel="noreferrer"><img src="https://i.stack.imgur.com/9jOK9.png" alt="enter image description here"></a>
 <br><br>
The definition which I like is by John McCarthy, "It is the science and engineering of making intelligent machines, especially intelligent computer programs. It is related to the similar task of using computers to understand human intelligence, but AI does not have to confine itself to methods that are biologically observable."<br>
<br>
Machine Learning, on the other hand, is the field of AI which deals with making software to make better predictions for the output without being explicitly programmed. Various algorithms are used over a set of data to predict the future. Machine Learning is data-driven and data-oriented. Machine Learning is evolved from the study of pattern recognition and computational learning theory of AI.<br></p>

<blockquote>
  <p>In a nutshell Artificial Intelligence is a field of Computer Science which deals with providing machines the ability to perform rational tasks. Natural Language Processing, Automation, Image Processing, and many others are part of it.<br>
  Machine Learning is a subset of AI which is data oriented and deals with predicting. Used in search engines, Youtube recommendation list, etc.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: Do scientists know what is happening inside artificial neural networks? (score [11562](https://stackoverflow.com/q/1479) in 2019)

#### Question
Do scientists or research experts know from the kitchen what is happening inside complex "deep" neural network with at least millions of connections firing at an instant? Do they understand the process behind this (e.g. what is happening inside and how it works exactly), or it is a subject of debate?  

For example this <a href="https://www.cs.nyu.edu/~fergus/papers/zeilerECCV2014.pdf" rel="noreferrer">study</a> says:  

<blockquote>
  However there is no clear understanding of <em>why</em> they perform so well, or <em>how</em> they might be improved.  
</blockquote>

So does this mean that scientists actually don't know how complex convolutional network models work?  

#### Answer accepted (score 51)
There are many approaches that aim to make a trained neural network more interpretable and less like a "black box", specifically <em>convolutional neural networks</em> that you've mentioned.  

<h5>Visualizing the activations and layer weights</h3>

<a href="https://medium.com/@awjuliani/visualizing-neural-network-layer-activation-tensorflow-tutorial-d45f8bf7bbc4" rel="noreferrer">Activations visualization</a> is the first obvious and straight-forward one. For ReLU networks, the activations usually start out looking relatively blobby and dense, but as the training progresses the activations usually become more sparse (most values are zero) and localized. This sometimes shows what exactly a particular layer is focused on when it sees an image.  

Another great work on activations that I'd like to mention is <a href="https://www.youtube.com/watch?v=AgkfIQ4IGaM" rel="noreferrer">deepvis</a> that shows reaction of every neuron at each layer, including pooling and normalization layers. Here's how they <a href="http://yosinski.com/deepvis" rel="noreferrer">describe it</a>:  

<blockquote>
  <p>In short, we’ve gathered a few different methods that allow you to
  “triangulate” what feature a neuron has learned, which can help you
  better understand how DNNs work.</p>
</blockquote>

The second common strategy is to visualize the weights (filters). These are usually most interpretable on the first CONV layer which is looking directly at the raw pixel data, but it is possible to also show the filter weights deeper in the network. For example, the first layer usually learns gabor-like filters that basically detect edges and blobs.  

<a href="https://i.stack.imgur.com/D6pXk.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/D6pXk.jpg" alt="first layer filters"></a>  

<h5>Occlusion experiments</h3>

Here's the idea. Suppose that a ConvNet classifies an image as a dog. How can we be certain that it’s actually picking up on the dog in the image as opposed to some contextual cues from the background or some other miscellaneous object?   

<p>One way of investigating which part of the image some classification prediction is coming from is by plotting the probability of the class of interest (e.g. dog class) as a function of the position of an occluder object. 
If we iterate over regions of the image, replace it with all zeros and check the classification result, we can build a 2-dimensional heat map of what's most important for the network on a particular image. This approach has been used in <a href="https://arxiv.org/pdf/1311.2901.pdf" rel="noreferrer">Matthew Zeiler’s Visualizing and Understanding Convolutional Networks</a> (that you refer to in your question):</p>

<a href="https://i.stack.imgur.com/O10WA.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/O10WA.jpg" alt="occlusion experiments"></a>  

<h5>Deconvolution</h3>

Another approach is to synthesize an image that causes a particular neuron to fire, basically what the neuron is looking for. The idea is to compute the gradient with respect to the image, instead of the usual gradient with respect to the weights. So you pick a layer, set the gradient there to be all zero except for one for one neuron and backprop to the image.   

Deconv actually does something called <em>guided backpropagation</em> to make a nicer looking image, but it's just a detail.  

<h5>Similar approaches to other neural networks</h3>

Highly recommend <a href="http://karpathy.github.io/2015/05/21/rnn-effectiveness/" rel="noreferrer">this post by Andrej Karpathy</a>, in which he plays a lot with Recurrent Neural Networks (RNN). In the end, he applies a similar technique to see what the neurons actually learn:  

<blockquote>
  <p>The neuron highlighted in this image seems to get very excited about
  URLs and turns off outside of the URLs. The LSTM is likely using this
  neuron to remember if it is inside a URL or not.</p>
</blockquote>

<h5>Conclusion</h3>

I've mentioned only a small fraction of results in this area of research. It's pretty active and new methods that shed light to the neural network inner workings appear each year.  

To answer your question, there's always something that scientists don't know yet, but in many cases they have a good picture (literary) of what's going on inside and can answer many particular questions.   

To me the quote from your question simply highlights the importance of research of not only accuracy improvement, but the inner structure of the network as well. As Matt Zieler tells in <a href="https://www.youtube.com/watch?v=ghEmQSxT6tw" rel="noreferrer">this talk</a>, sometimes a good visualization can lead, in turn, to better accuracy.  

#### Answer 2 (score 27)
It depends on what you mean by "know what is happening".  

Conceptually, yes: ANN perform nonlinear regression. The actual expression represented by the weight matrix/activation function(s) of an ANN can be explicitly expanded in symbolic form (e.g. containing sub-expressions such as <span class="math-container">$1/1+e^{1/1+e^{\dots}}$</span>).  

However, if by 'know' you mean <em>predicting the output of some specific (black box) ANN</em>, by some other means, then the obstacle is the presence of chaos in a ANN that has <a href="http://sprott.physics.wisc.edu/pubs/paper234.pdf" rel="nofollow noreferrer">high degrees of freedom</a>.  

Here's also some relatively recent work by Hod Lipson on understanding ANNs through  <a href="http://arxiv.org/pdf/1506.06579.pdf" rel="nofollow noreferrer">visualisation</a>.  

#### Answer 3 (score 13)
Short answer is <strong>no</strong>.  

<em>Model interpretability</em> is a hyper-active and hyper-hot area of current research (think of holy grail, or something), which has been brought forward lately not least due to the (often tremendous) success of deep learning models in  various tasks; these models are currently only black boxes, and we naturally feel uncomfortable about it...  

Here are some general (and recent, as of Dec 2017) resources on the subject:  

<ul>
<li><p>A recent (July 2017) article in Science provides a nice overview of the current status &amp; research: <a href="http://www.sciencemag.org/news/2017/07/how-ai-detectives-are-cracking-open-black-box-deep-learning" rel="nofollow noreferrer">How AI detectives are cracking open the black box of deep learning</a> (no in-text links, but googling names &amp; terms will pay off)</p></li>
<li><p>DARPA itself is currently running a program on <a href="https://www.darpa.mil/program/explainable-artificial-intelligence" rel="nofollow noreferrer">Explainable Artificial Intelligence (XAI)</a></p></li>
<li><p>There was a workshop in NIPS 2016 on <a href="http://nuit-blanche.blogspot.gr/2016/12/nips2016-interpretable-machine-learning.html" rel="nofollow noreferrer">Interpretable Machine Learning for Complex Systems</a>, as well as an <a href="http://people.csail.mit.edu/beenkim/icml_tutorial.html" rel="nofollow noreferrer">ICML 2017 tutorial on Interpretable Machine Learning</a> by <a href="https://beenkim.github.io/" rel="nofollow noreferrer">Been Kim</a> of Google Brain.</p></li>
</ul>

And on a more practical level (code etc):  

<ul>
<li><p>The What-If tool by Google, a brand new (September 2018) feature of the open-source TensorBoard web application, which let users analyze an ML model without writing code (<a href="https://pair-code.github.io/what-if-tool/" rel="nofollow noreferrer">project page</a>, <a href="https://ai.googleblog.com/2018/09/the-what-if-tool-code-free-probing-of.html" rel="nofollow noreferrer">blog post</a>)</p></li>
<li><p>The Layer-wise Relevance Propagation (LRP) toolbox for neural networks (<a href="http://www.jmlr.org/papers/v17/15-618.html" rel="nofollow noreferrer">paper</a>, <a href="http://www.explain-ai.org/" rel="nofollow noreferrer">project page</a>, <a href="https://github.com/sebastian-lapuschkin/lrp_toolbox" rel="nofollow noreferrer">code</a>, <a href="https://github.com/VigneshSrinivasan10/interprettensor" rel="nofollow noreferrer">TF Slim wrapper</a>)</p></li>
<li><p>FairML: Auditing Black-Box Predictive Models, by Cloudera Fast Forward Labs (<a href="http://blog.fastforwardlabs.com/2017/03/09/fairml-auditing-black-box-predictive-models.html" rel="nofollow noreferrer">blog post</a>, <a href="https://arxiv.org/abs/1611.04967" rel="nofollow noreferrer">paper</a>, <a href="https://github.com/adebayoj/fairml" rel="nofollow noreferrer">code</a>)</p></li>
<li><p>LIME: Local Interpretable Model-agnostic Explanations (<a href="https://arxiv.org/abs/1602.04938" rel="nofollow noreferrer">paper</a>, <a href="https://github.com/marcotcr/lime" rel="nofollow noreferrer">code</a>, <a href="https://www.oreilly.com/learning/introduction-to-local-interpretable-model-agnostic-explanations-lime" rel="nofollow noreferrer">blog post</a>, <a href="https://cran.r-project.org/web/packages/lime/index.html" rel="nofollow noreferrer">R port</a>)</p></li>
<li><p>A very recent (November 2017) paper by Geoff Hinton, <a href="https://arxiv.org/abs/1711.09784" rel="nofollow noreferrer">Distilling a Neural Network Into a Soft Decision Tree</a>, with an independent <a href="https://github.com/kimhc6028/soft-decision-tree" rel="nofollow noreferrer">PyTorch implementation</a></p></li>
<li><p>SHAP: A Unified Approach to Interpreting Model Predictions (<a href="https://arxiv.org/abs/1705.07874" rel="nofollow noreferrer">paper</a>, authors' <a href="https://github.com/slundberg/shap" rel="nofollow noreferrer">Python code</a>, <a href="https://github.com/redichh/ShapleyR" rel="nofollow noreferrer">R package</a>)</p></li>
<li><p>Interpretable Convolutional Neural Networks (<a href="https://arxiv.org/abs/1710.00935" rel="nofollow noreferrer">paper</a>, authors' <a href="https://github.com/zqs1022/interpretableCNN" rel="nofollow noreferrer">code</a>)</p></li>
<li><p>Lucid, a collection of infrastructure and tools for research in neural network interpretability by Google (<a href="https://github.com/tensorflow/lucid" rel="nofollow noreferrer">code</a>; papers: <a href="https://distill.pub/2017/feature-visualization/" rel="nofollow noreferrer">Feature Visualization</a>, <a href="https://distill.pub/2018/building-blocks/" rel="nofollow noreferrer">The Building Blocks of Interpretability</a>)</p></li>
<li><p>Transparecy-by-Design (TbD) networks (<a href="https://arxiv.org/abs/1803.05268" rel="nofollow noreferrer">paper</a>, <a href="https://github.com/davidmascharka/tbd-nets" rel="nofollow noreferrer">code</a>, <a href="https://hub.mybinder.org/user/davidmascharka-tbd-nets-nex18rln/notebooks/full-vqa-example.ipynb" rel="nofollow noreferrer">demo</a>)</p></li>
<li><p>SVCCA: Singular Vector Canonical Correlation Analysis for Deep Learning Dynamics and Interpretability (<a href="https://arxiv.org/abs/1706.05806" rel="nofollow noreferrer">paper</a>, <a href="https://github.com/google/svcca" rel="nofollow noreferrer">code</a>, <a href="https://ai.googleblog.com/2017/11/interpreting-deep-neural-networks-with.html" rel="nofollow noreferrer">Google blog post</a>)</p></li>
<li><p>TCAV: Testing with Concept Activation Vectors (<a href="https://arxiv.org/abs/1711.11279" rel="nofollow noreferrer">ICML 2018 paper</a>, <a href="https://github.com/tensorflow/tcav/" rel="nofollow noreferrer">Tensorflow code</a>)</p></li>
<li><p>Grad-CAM: Visual Explanations from Deep Networks via Gradient-based Localization (<a href="https://arxiv.org/abs/1610.02391" rel="nofollow noreferrer">paper</a>, authors' <a href="https://github.com/ramprs/grad-cam" rel="nofollow noreferrer">Torch code</a>, <a href="https://github.com/Ankush96/grad-cam.tensorflow" rel="nofollow noreferrer">Tensorflow code</a>, <a href="https://github.com/meliketoy/gradcam.pytorch" rel="nofollow noreferrer">PyTorch code</a>, Keras <a href="http://nbviewer.jupyter.org/github/fchollet/deep-learning-with-python-notebooks/blob/master/5.4-visualizing-what-convnets-learn.ipynb" rel="nofollow noreferrer">example notebook</a>)</p></li>
<li><p>Network Dissection: Quantifying Interpretability of Deep Visual Representations, by MIT CSAIL (<a href="http://netdissect.csail.mit.edu/" rel="nofollow noreferrer">project page</a>, <a href="https://github.com/CSAILVision/NetDissect" rel="nofollow noreferrer">Caffe code</a>, <a href="https://github.com/CSAILVision/NetDissect-Lite" rel="nofollow noreferrer">PyTorch port</a>)</p></li>
<li><p>GAN Dissection: Visualizing and Understanding Generative Adversarial Networks, by MIT CSAIL (<a href="https://gandissect.csail.mit.edu/" rel="nofollow noreferrer">project page</a>, with links to paper &amp; code)</p></li>
<li><p>Explain to Fix: A Framework to Interpret and Correct DNN Object Detector Predictions (<a href="https://arxiv.org/abs/1811.08011" rel="nofollow noreferrer">paper</a>, <a href="https://github.com/gudovskiy/e2x" rel="nofollow noreferrer">code</a>)</p></li>
</ul>

Lately, there has been a surge of interest to start building a more theoretical basis for deep learning neural nets. In this context, renowned statistician and compressive sensing pioneer David Donoho has very recently (fall 2017) started offering a course at Stanford, <a href="https://stats385.github.io/" rel="nofollow noreferrer">Theories of Deep Learning (STATS 385)</a>, with almost all the material available online; it is highly recommended...  

<strong>UPDATES</strong>:   

<ul>
<li><a href="https://christophm.github.io/interpretable-ml-book/" rel="nofollow noreferrer">Interpretable Machine Learning</a>, an online Gitbook by Christoph Molnar with <a href="https://github.com/christophM/iml" rel="nofollow noreferrer">R code</a> (although in mostly covers algorithms other than neural networks)</li>
<li>A <a href="https://twitter.com/ledell/status/995930308947140608" rel="nofollow noreferrer">Twitter thread</a>, linking to several interpretation tools available for R.</li>
<li>A short (4 hrs) online course by Kaggle, <a href="https://www.kaggle.com/learn/machine-learning-explainability" rel="nofollow noreferrer">Machine Learning Explainability</a>, and the accompanying <a href="https://towardsdatascience.com/why-model-explainability-is-the-next-data-science-superpower-b11b6102a5e0" rel="nofollow noreferrer">blog post</a></li>
<li>A new ICML 2018 Tutorial, <a href="http://unsupervised.cs.princeton.edu/deeplearningtutorial.html" rel="nofollow noreferrer">Toward theoretical understanding of deep learning</a>, by Sanjeev Arora</li>
<li>A <strong>whole bunch</strong> of resources in the <a href="https://github.com/jphall663/awesome-machine-learning-interpretability" rel="nofollow noreferrer">Awesome Machine Learning Interpretability repo</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: What's the difference between model-free and model-based reinforcement learning? (score [11526](https://stackoverflow.com/q/4456) in 2019)

#### Question
What's the difference between model-free and model-based reinforcement learning?   

It seems to me that any model-free learner, learning through trial and error, could be reframed as model-based. In that case, when would model-free learners be appropriate?  

#### Answer 2 (score 14)
Model-based reinforcement learning has an agent try to understand the world and create a model to represent it. Here the model is trying to capture 2 functions, the transition function from states <span class="math-container">$T$</span> and the reward function <span class="math-container">$R$</span>. From this model, the agent has a reference and can plan accordingly.   

However, it is not necessary to learn a model, and the agent can instead learn a policy directly using algorithms like Q-learning or policy gradient.   

A simple check to see if an RL algorithm is model-based or model-free is:   

<em>If, after learning, the agent can make predictions about what the next state and reward will be before it takes each action, it's a model-based RL algorithm.</em>  

If it can't, then it’s a model-free algorithm.  

#### Answer 3 (score 9)
<blockquote>
  What's the difference between model-free and model-based reinforcement learning?  
</blockquote>

In Reinforcement Learning, the terms "model-based" and "model-free" do <em>not</em> refer to the use of a neural network or other statistical learning model to predict values, or even to predict next state (although the latter may be used as part of a model-based algorithm and be called a "model" regardless of whether the algorithm is model-based or model-free).  

Instead, the term refers strictly as to whether, whilst during learning or acting, the agent uses predictions of the environment response. The agent can use a single prediction from the model of next reward and next state (a sample), or it can ask the model for the <em>expected</em> next reward, or the full <em>distribution</em> of next states and next rewards. These predictions can be provided entirely outside of the learning agent - e.g. by computer code that understands the rules of a dice or board game. Or they can be learned by the agent, in which case they will be approximate.  

Just because there is a model of the environment implemented, does not mean that a RL agent is "model-based". To qualify as "model-based", the learning algorithms have to explicitly reference the model:   

<ul>
<li><p>Algorithms that purely sample from experience such as Monte Carlo Control, SARSA, Q-learning, Actor-Critic are "model free" RL algorithms. They rely on real samples from the environment and never use generated predictions of next state and next reward to alter behaviour (although they might sample from experience memory, which is close to being a model).</p></li>
<li><p>The archetypical model-based algorithms are Dynamic Programming (Policy Iteration and Value Iteration) or planning algorithms such as MCTS - these all use the model's predictions or distributions of next state and reward in order to calculate optimal actions. Specifically in Dynamic Programming, the model must provide state transition probabilities, and expected reward from any state, action pair. Note this is rarely a learned model.</p></li>
<li><p>Basic TD learning, using state values only, must also be model-based in order to work as a control system and pick actions. In order to pick the best action, it needs to query a model that predicts what will happen on each action, and implement a policy like <span class="math-container">$\pi(s) = \text{argmax}_a \sum_{s',r} p(s',r|s,a)(r + v(s'))$</span> where <span class="math-container">$p(s',r|s,a)$</span> is the probability of receiving reward <span class="math-container">$r$</span> and next state <span class="math-container">$s'$</span> when taking action <span class="math-container">$a$</span> in state <span class="math-container">$s$</span>. That function <span class="math-container">$p(s',r|s,a)$</span> is essentially the model.</p></li>
</ul>

The RL literature differentiates between "model" as a model of the environment for "model-based" and "model-free" learning, and use of statistical learners, such as neural networks.  

In RL, neural networks are often employed to learn and generalise value functions, such as the Q value which predicts total return (sum of discounted rewards) given a state and action pair. Such a trained neural network is often called a "model" in e.g. supervised learning. However, in RL literature, you will see the term "function approximator" used for such a network to avoid ambiguity.  

<blockquote>
  It seems to me that any model-free learner, learning through trial and error, could be reframed as model-based.  
</blockquote>

I think here you are using the general understanding of the word "model" to include any structure that makes useful predictions. That would apply to e.g. table of Q values in SARSA.   

However, as explained above, that's not how the term is used in RL. So although your understanding that RL builds useful internal representations is correct, you are not technically correct that this can be used to re-frame between "model-free" as "model-based", because those terms have a very specific meaning in RL.  

<blockquote>
  In that case, when would model-free learners be appropriate?  
</blockquote>

Generally with current state of art in RL, if you don't have an accurate model provided as part of the problem definition, then model-free approaches are often superior.   

There is lots of interest in agents that build predictive models of the environment, and doing so as a "side effect" (whilst still being a model-free algorithm) can still be useful - it may regularise a neural network or help discover key predictive features that can also be used in policy or value networks. However, model-based agents that learn their own models for planning have a problem that inaccuracy in these models can cause instability (the inaccuracies multiply the further into the future the agent looks). Some promising inroads are being made using <a href="https://deepmind.com/blog/agents-imagine-and-plan/" rel="noreferrer">imagination-based agents</a> and/or mechanisms for deciding when and how much to trust the learned model during planning.  

Right now (in 2018), if you have a real-world problem in an environment without an explicit known model at the start, then the safest bet is to use a model-free approach such as DQN or A3C. That may change as the field is moving fast and new more complex architectures could well be the norm in a few years.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: What is the difference between artificial intelligence and robots? (score [10427](https://stackoverflow.com/q/1462) in 2019)

#### Question
What is the difference between artificial intelligence and robots?  

#### Answer accepted (score 9)
Although there are several definitions of "robot", an essential feature of everything called "robot" is that it is capable of movement. This does not necessarily mean <em>displacement</em>; a robot arm in a factory also moves.  

There is a single exception to this rule,  which is bot-programs like chatbots; I will discuss them later.  

Artificial Intelligence does not need to move; a chess program can be argued to be an AI, but does not move.   

A robot can actually have AI; one of the definitions of robot is that it is a system, capable of <em>autonomous</em> movement. In order to be autonomous, to be able to make decisions of its own, a certain amount of AI may be necessary.   

There is one class of "robots" that does not move, and does not even have physical presence; bot programs, like chatbots, that operate inside systems. I do not consider them robots, because they are not physical devices operating in the real world. A chatbot can be an AI, however - a good chatbot may have some natural language processing to interact with humans in a way that humans find natural.  

To summarize; an AI can exist purely in software. But to be a robot, there must be a moving physical component in the real world.  

#### Answer 2 (score 5)
In the broadest sense, the difference is that non-robotic A(G)I <em>may</em> not be possible because, as per <a href="https://ai.stackexchange.com/questions/1415/what-kind-of-body-if-any-does-intelligence-require">this question</a>, it could be that "Intelligence requires a body".  

More specifically, it could be that there are limitations to what the traditional (well, 1950s style) 'Brain in a vat' notion of an AI is capable of comprehending, in the absence of experience of embodied experience such as force, motion and "the raw, unawshed world".  

#### Answer 3 (score 3)
In a general sense you can say that robot is a piece of hardware, while AI is software (sometimes hardware too).<br>  

<blockquote>
  <p><a href="https://en.wikipedia.org/wiki/Robot" rel="nofollow noreferrer">Wikipedia</a> states Robot as a machine which performs complex set of tasks automatically.<br>
  Machine - A mechanical device basically.<br></p>
</blockquote>

So, technically you can create a robot that doesn't require any kind of complex algorithms to take decisions. A simple line follower doesn't even require a microcontroller. Just some gates are enough. Some other examples of robots are, a robotic arm, automated control systems in industries, etc. If you think about it even the printer in your house is a robot in itself.<br><br>  

<blockquote>
  Artificial Intelligence is a field of Computer Science which deals with developing systems that can perform tasks rationally as if it is using intelligence (of human level) for taking decisions.  
</blockquote>

<p>AI deals with complex algorithms. Some examples of AI are speech recognition, face recognition, natural language processing, etc.
<br>AI don't necessarily need additional hardware. A simple desktop at home will work, while the term robot is used for external hardware that does some autonomous task repeatedly. </p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Measuring Object size using Deep Neural Network (score [9928](https://stackoverflow.com/q/4282) in )

#### Question
I have a large dataset of vehicles with the ground truth of their lengths (Over 100k samples). Is it possible to train a deep network to measure/estimate vehicle length ? I haven't seen any papers related to estimating object size using deep neural network.  

#### Answer 2 (score 4)
Yes! This most certainly can be done. Since you have a labeled dataset, that makes it all the more simple!  

I would take a look at <a href="https://www.pyimagesearch.com/2016/03/28/measuring-size-of-objects-in-an-image-with-opencv/" rel="nofollow noreferrer">this project</a> and that should get you where you need to go.   

The implementation details should be pretty straightforward. Let me know if I can help further.  

#### Answer 3 (score 1)
I think this paper can help you out: <a href="https://arxiv.org/pdf/1612.00496.pdf" rel="nofollow noreferrer">3D Bounding Box Estimation Using Deep Learning and Geometry</a>  

He used 1 VGG-19 (pretrained on ImageNet) to learn the size of cars  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: What are different actions in action space of environment of 'Pong-v0' game from openai gym? (score [9656](https://stackoverflow.com/q/2449) in )

#### Question
Printing actionspace for Pong-v0 gives 'Discrete(6)' as output, i.e.0,1,2,3,4,5 are actions defined in environment as per documentation, but game needs only two controls. Why this discrepency? Further is that necessary to identify which number from 0 to 5 corresponds to which action in gym environment?  

#### Answer 2 (score 5)
You can try the actions yourselves, but if you want another reference, <a href="https://github.com/openai/atari-py/blob/master/doc/manual/manual.pdf" rel="noreferrer">check out the documentation for ALE at GitHub</a>.  

In particular, 0 means no action, 1 means fire, which is why they don't have an effect on the racket.  

Here's a better way:  

```text
env.unwrapped.get_action_meanings()
```

#### Answer 3 (score 3)
You can try to figure out what exactly does an action do using such script:  

```text
action = 0  # modify this!
o = env.reset()
for i in xrange(5): # repeat one action for five times
    o = env.step(action)[0]
IPython.display.display(
    Image.fromarray(
        o[:,140:142]  # extract your bat
    ).resize((300, 300))  # bigger image, easy for visualization
)
```

`action` 0 and 1 seems useless, as nothing happens to the racket.  

`action` 2 &amp; 4 makes the racket go up, and `action` 3 &amp; 5 makes the racket go down.  

The interesting part is, when I run the script above for the same `action`(from 2 to 5) two times, I have different results. Sometimes the racket reaches the top(bottom) border, and sometimes it doesn't. I think there might be some randomness on the speed of the racket, so it might be hard to measure which type of UP(2 or 4) is faster.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How could artificial intelligence harm us? (score [9493](https://stackoverflow.com/q/15449) in 2019)

#### Question
We often hear that artificial intelligence may harm or even kill humans, so it might prove dangerous.  

How could artificial intelligence harm us?  

#### Answer accepted (score 37)
<h5>tl;dr</h2>

There are many <strong>valid</strong> reasons why people might fear (or better <em>be concerned about</em>) AI, not all involve robots and apocalyptic scenarios.   

To better illustrate these concerns, I'll try to split them into three categories.  

<h5>Conscious AI</h2>

This is the type of AI that your question is referring to. A super-intelligent conscious AI that will destroy/enslave humanity. This is mostly brought to us by science-fiction. Some notable Hollywood examples are <em>"The terminator"</em>, <em>"The Matrix"</em>, <em>"Age of Ultron"</em>. The most influential novels were written by Isaac Asimov and are referred to as the <em>"Robot series"</em> (which includes <em>"I, robot"</em>, which was also adapted as a movie).  

The basic premise under most of these works are that AI will evolve to a point where it becomes conscious and will surpass humans in intelligence. While Hollywood movies mainly focus on the robots and the battle between them and humans, not enough emphasis is given to the actual AI (i.e. the "brain" controlling them). As a side note, because of the narrative, this AI is usually portrayed as supercomputer controlling everything (so that the protagonists have a specific target). Not enough exploration has been made on "ambiguous intelligence" (which I think is more realistic).  

In the real world, AI is focused on solving specific tasks! An AI agent that is capable of solving problems from different domains (e.g. understanding speech and processing images and driving and ... - like humans are) is referred to as General Artificial Intelligence and is required for AI being able to "think" and become conscious.    

Realistically, we are a <strong>loooooooong way</strong> from General Artificial Intelligence! That being said there is <strong>no evidence</strong> on why this <strong>can't</strong> be achieved in the future. So currently, even if we are still in the infancy of AI, we have no reason to believe that AI won't evolve to a point where it is more intelligent than humans.  

<h5>Using AI with malicious intent</h2>

<p>Even though an AI conquering the world is a long way from happening there are <strong>several reasons to be concerned with AI today</strong>, that don't involve robots!
The second category I want to focus a bit more on is several malicious uses of today's AI. </p>

I'll focus only on <strong>AI applications that are available today</strong>. Some examples of AI that can be used for malicious intent:  

<ul>
<li><p><a href="https://en.wikipedia.org/wiki/Deepfake" rel="noreferrer">DeepFake</a>: a technique for imposing someones face on an image a video of another person. This has gained popularity recently with celebrity porn and can be used to generate <strong>fake news</strong> and hoaxes. Sources: <a href="https://www.youtube.com/watch?v=gLoI9hAX9dw" rel="noreferrer">1</a>, <a href="https://theoutline.com/post/3179/deepfake-videos-are-freaking-experts-out?zd=1&amp;zi=zw6lhzz2" rel="noreferrer">2</a>, <a href="https://www.nytimes.com/2018/03/04/technology/fake-videos-deepfakes.html" rel="noreferrer">3</a></p></li>
<li><p>With the use of <strong>mass surveillance systems</strong> and <strong>facial recognition</strong> software capable of recognizing <a href="https://www.digitaltrends.com/cool-tech/goodbye-anonymity-latest-surveillance-tech-can-search-up-to-36-million-faces-per-second/" rel="noreferrer">millions of faces per second</a>, AI can be used for mass surveillance. Even though when we think of mass surveillance we think of China, many western cities like <a href="https://www.cctv.co.uk/how-many-cctv-cameras-are-there-in-london/" rel="noreferrer">London</a>, <a href="https://cloudtweaks.com/2019/09/mass-surveillance-adversarial-ai-in-atlanta/" rel="noreferrer">Atlanta</a> and Berlin are among the <a href="https://www.comparitech.com/vpn-privacy/the-worlds-most-surveilled-cities/" rel="noreferrer">most-surveilled cities in the world</a>. China has taken things a step further by adopting the <a href="https://futurism.com/china-social-credit-system-rate-human-value" rel="noreferrer">social credit system</a>, an evaluation system for civilians which seems to be taken straight out of the pages of George Orwell's 1984.</p></li>
<li><p><strong>Influencing</strong> people through <strong>social media</strong>. Aside from recognizing user's tastes with the goal of targeted marketing and add placements (a common practice by many internet companies), AI can be used malisciously to influence people's voting (among other things). Sources: <a href="https://theintercept.com/2018/04/13/facebook-advertising-data-artificial-intelligence-ai/" rel="noreferrer">1</a>, <a href="https://www.martechadvisor.com/articles/machine-learning-ai/the-impact-of-artificial-intelligence-on-social-media/" rel="noreferrer">2</a>, <a href="https://venturebeat.com/2018/04/13/ai-weekly-facebook-fiasco-shows-we-need-a-new-scheme-for-personal-data/" rel="noreferrer">3</a>. </p></li>
<li><p><a href="https://gizmodo.com/hackers-have-already-started-to-weaponize-artificial-in-1797688425" rel="noreferrer">Hacking</a>.</p></li>
<li><p>Military applications, e.g. drone attacks, missile targeting systems.</p></li>
</ul>

<h5>Adverse effects of AI</h2>

This category is pretty subjective, but the development of AI might carry some adverse side-effects. The distinction between this category and the previous is that these effects, while harmful, aren't done intentionally; rather they occur with the development of AI. Some examples are:  

<ul>
<li><p><strong>Jobs becoming redundant</strong>. As AI becomes better, many jobs will be replaced by AI. Unfortunately there are not many things that can be done about this, as most technological developments have this side-effect (e.g. agricultural machinery caused many farmers to lose their jobs, automation replaced many factory workers, computers did the same). </p></li>
<li><p>Reinforcing the <strong>bias in our data</strong>. This is a very interesting category, as AI (and especially Neural Networks) are only as good as the data they are trained on and have a tendency of perpetuating and even enhancing different forms of social biases, already existing in the data. There are many examples of networks exhibiting racist and sexist behavior. Sources: <a href="https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing" rel="noreferrer">1</a>, <a href="https://arxiv.org/abs/1607.06520" rel="noreferrer">2</a>, <a href="https://cacm.acm.org/magazines/2018/6/228035-bias-on-the-web/fulltext" rel="noreferrer">3</a>, <a href="https://read.dukeupress.edu/world-policy-journal/article-abstract/33/4/111/30942/Racist-in-the-MachineThe-Disturbing-Implications?redirectedFrom=fulltext" rel="noreferrer">4</a>.</p></li>
</ul>

#### Answer 2 (score 13)
<h5>Short term</h1>

<ul>
<li><strong>Physical accidents</strong>, e.g. due to industrial machinery, aircraft autopilot, self-driving cars. Especially in the case of <em>unusual situations</em> such as extreme weather or sensor failure. Typically an AI will function poorly under conditions where it has not been extensively tested.</li>
<li><strong>Social impacts</strong> such as reducing job availability, barriers for the underprivileged wrt. loans, insurance, parole.</li>
<li><strong>Recommendation engines</strong> are manipulating us more and more to change our behaviours (as well as reinforce our own "small world" bubbles). Recommendation engines routinely serve up inappropriate content of various sorts to young children, often because content creators (e.g. on YouTube) use the right keyword stuffing to appear to be child-friendly.</li>
<li><strong>Political manipulation...</strong> Enough said, I think.</li>
<li><strong>Plausible deniability of privacy invasion</strong>. Now that AI can read your email and even make phone calls for you, it's easy for someone to have humans act on your personal information and claim that they got a computer to do it.</li>
<li><strong>Turning war into a video game</strong>, that is, replacing soldiers with machines being operated remotely by someone who is not in any danger and is far removed from his/her casualties.</li>
<li><strong>Lack of transparency</strong>. We are trusting machines to make decisions with very little means of getting the justification behind a decision.</li>
<li><strong>Resource consumption and pollution.</strong> This is not just an AI problem, however every improvement in AI is creating more demand for Big Data and together these ram up the need for storage, processing, and networking. On top of the electricity and rare minerals consumption, the infrastructure needs to be disposed of after its several-year lifespan.</li>
<li><strong>Surveillance</strong> — with the ubiquity of smartphones and listening devices, there is a gold mine of data but too much to sift through every piece. Get an AI to sift through it, of course!</li>
<li><strong>Cybersecurity</strong> — cybercriminals are increasingly leveraging AI to attack their targets.</li>
</ul>

Did I mention that <em>all</em> of these are in full swing already?  

<h5>Long Term</h1>

Although there is no clear line between AI and AGI, this section is more about what happens when we go further towards AGI. I see two alternatives:  

<ul>
<li>Either we develop AGI as a result of our improved understanding of the nature of intelligence,</li>
<li>or we slap together something that seems to work but we don't understand very well, much like a lot of machine learning right now.</li>
</ul>

In the first case, if an AI "goes rogue" we can build other AIs to outwit and neutralise it. In the second case, we can't, and we're doomed. AIs will be a new life form and we may go extinct.  

Here are some potential problems:  

<ul>
<li><strong>Copy and paste.</strong> One problem with AGI is that it could quite conceivably run on a desktop computer, which creates a number of problems:

<ul>
<li><strong>Script Kiddies</strong> ­— people could download an AI and set up the parameters in a destructive way. Relatedly,</li>
<li><strong>Criminal or terrorist groups</strong> would be able to configure an AI to their liking. You don't need to find an expert on bomb making or bioweapons if you can download an AI, tell it to do some research and then give you step-by-step instructions.</li>
<li><strong>Self-replicating AI</strong> — there are plenty of computer games about this. AI breaks loose and spreads like a virus. The more processing power, the better able it is to protect itself and spread further.</li>
</ul></li>
<li><strong>Invasion of computing resources</strong>. It is likely that more computing power is beneficial to an AI. An AI might buy or steal server resources, or the resources of desktops and mobile devices. Taken to an extreme, this could mean that all our devices simply became unusable which would wreak havoc on the .world immediately. It could also mean massive electricity consumption (and it would be hard to "pull the plug" because power plants are computer controlled!)</li>
<li><strong>Automated factories.</strong> An AGI wishing to gain more of a physical presence in the world could take over factories to produce robots which could build new factories and essentially create bodies for itself.</li>
<li>These are rather philosophical considerations, but some would argue that AI would destroy what makes us human:

<ul>
<li><strong>Inferiority.</strong> What if plenty of AI entities were smarter, faster, more reliable and more creative than the best humans?</li>
<li><strong>Pointlessness.</strong> With robots replacing the need for physical labour and AIs replacing the need for intellectual labour, we will really have nothing to do. Nobody's going to get the Nobel Prize again because the AI will already be ahead. Why even get educated in the first place?</li>
<li><strong>Monoculture/stagnation</strong> — in various scenarios (such as a single "benevolent dictator" AGI) society could become fixed in a perpetual pattern without new ideas or any sort of change (pleasant though it may be). Basically, <em>Brave New World.</em></li>
</ul></li>
</ul>

I think AGI is coming and we need to be mindful of these problems so that we can minimise them.  

#### Answer 3 (score 8)
In addition to the other answers, I would like to add to nuking cookie factory example:  

Machine learning AIs basically try to fulfill a goal described by humans. For example, humans create an AI running a cookie factory. The goal they implement is to sell as many cookies as possible for the highest profitable margin.  

Now, imagine an AI which is sufficiently powerful. This AI will notice that if he nukes all other cookie factories, everybody has to buy cookies in his factory, making sales rise and profits higher.  

So, the human error here is giving no penalty for using violence in the algorithm. This is easily overlooked because humans didn't expect the algorithm to come to this conclusion.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: Are neural networks prone to catastrophic forgetting? (score [9299](https://stackoverflow.com/q/13289) in 2019)

#### Question
Imagine you show a neural network a picture of a lion 100 times and label with "dangerous", so it learns that lions are dangerous.  

Now imagine that previously you have shown it millions of images of lions and alternatively labeled it as "dangerous" and "not dangerous", such that the probability of a lion being dangerous is 50%.  

But those last 100 times has pushed the neural network into being very positive about regarding the lion as "dangerous", thus ignoring the last million lessons.  

Therefore, it seems  there is a flaw in neural networks, in that they can change their mind too quickly based on recent evidence. Especially if that previous evidence was in the middle.  

Is there a neural network model that keeps track of how much evidence it has seen? (Or would this be equivalent to letting the learning rate decrease by <span class="math-container">$1/T$</span> where <span class="math-container">$T$</span> is the number of trials?)  

#### Answer accepted (score 37)
Yes, indeed, neural networks are very prone to <a href="https://www.sciencedirect.com/science/article/pii/S0079742108605368?via%3Dihub" rel="noreferrer">catastrophic forgetting (or interference)</a>. Currently, this problem is often ignored because neural networks are mainly trained offline (sometimes called <em>batch training</em>), where this problem does not often arise, and not <a href="https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2016-19.pdf" rel="noreferrer">online or incrementally</a>, which is <a href="https://nips.cc/Conferences/2018/Schedule?showEvent=10910" rel="noreferrer">fundamental to the development of <em>artificial general intelligence</em></a>.  

There are some people that work on <em>continual lifelong learning</em> in neural networks, which attempts to adapt neural networks to continual lifelong learning, which is the ability of a model to learn from a stream of data continually, so that they do not completely forget previously acquired knowledge while learning new information. See, for example, the paper <a href="https://www.sciencedirect.com/science/article/pii/S0893608019300231" rel="noreferrer">Continual lifelong learning with neural networks: A review</a> (2019), by German I. Parisi, Ronald Kemker, Jose L. Part, Christopher Kanan, Stefan Wermter, which summarises the problems and existing solutions related to catastrophic forgetting of neural networks.   

#### Answer 2 (score 11)
Yes, the problem of <em>forgetting</em> older training examples is a characteristic of Neural Networks. I wouldn't call it a "flaw" though because it helps them be more adaptive and allows for interesting applications such as transfer learning (if a network remembered old training too well, fine tuning it to new data would be meaningless).  

In practice what you want to do is to mix the training examples for <em>dangerous</em> and <em>not dangerous</em> so that it doesn't see one category in the beginning and one at the end.  

A standard training procedure would work like this:  



```text
for e in epochs:
    shuffle dataset
    for x_batch, y_batch in dataset:
        train neural_network on x_batxh, y_batch
```

Note that the shuffle at every epoch guarantees that the network won't see the same training examples in the same order every epoch and that the classes will be mixed  

Now to answer your question, yes decreasing the learning rate would make the network less prone to <em>forgetting</em> its previous training, but how would this work in a non-online setting? In order for a network to converge it needs multiple epochs of training (i.e. seeing each sample in the dataset many times).  

#### Answer 3 (score 4)
What you are describing sounds like it could be a deliberate case of <a href="http://wiki.fast.ai/index.php/Fine_tuning" rel="nofollow noreferrer">fine-tuning</a>.  

<p>There is a fundamental assumption that makes <a href="https://adventuresinmachinelearning.com/stochastic-gradient-descent/" rel="nofollow noreferrer">minibatch gradient descent</a> work for learning problems: It is assumed that any batch or temporal window of consecutive batches forms a decent approximation of the true <em>global</em> gradient of the error function with respect to any parameterization of the model. If the error surface itself is moving in a big way, that would thwart the purposes of gradient descent--since gradient descent is a local refinement algorithm, all bets are off when you suddenly change the underlying distribution.
In the example you cited, catastrophic forgetting seems like it would be an after-effect of having "forgotten" data points previously seen, and is either a symptom of the distribution having changed, or of under-representation in the data of some important phenomenon, such that it is rarely seen relative to its importance.</p>

Experience replay from reinforcement learning is a relevant concept that transfers well to this domain. Here is <a href="https://arxiv.org/abs/1811.11682" rel="nofollow noreferrer">a paper</a> that explores this concept with respect to catastrophic forgetting. As long as sampling represents the true gradients sufficiently well (look at <a href="https://towardsdatascience.com/handling-imbalanced-datasets-in-deep-learning-f48407a0e758" rel="nofollow noreferrer">training sample balancing</a> for this) and the model has enough parameters, the catastrophic forgetting problem is unlikely to occur. In randomly shuffled datasets with replacement, it is most likely to occur where datapoints of a particular class are so rare that they are unlikely to be included for a long time during training, effectively fine-tuning the model to a different problem until a matching sample is seen again.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Why do we need explainable AI? (score [9204](https://stackoverflow.com/q/14224) in 2019)

#### Question
If the original purpose for developing AI was to help humans in some tasks and that purpose still holds, why should we care about its explainability? For example, in deep learning, as long as the intelligence helps us to the best of their abilities and carefully arrives at its decisions, why would we need to know how its intelligence works?  

#### Answer accepted (score 56)
As argued by <a href="https://arxiv.org/pdf/1610.02391.pdf" rel="noreferrer">Selvaraju et al.</a>, there are three stages of AI evolution, in all of which interpretability is helpful.   

<ol>
<li><p>In the early stages of AI development, when AI is weaker than human performance, transparency can help us <strong>build better models</strong>. It can give a better understanding of how a model works and helps us answer several key questions. For example <em>why</em> a model works in some cases and doesn't in others, <em>why</em> some examples confuse the model more than others, <em>why</em> these types of models work and the others don't, etc.</p></li>
<li><p>When AI is on par with human performance and ML models are starting to be deployed in several industries, it can help build <strong>trust</strong> for these models. I'll elaborate a bit on this later, because I think that it is the most important reason.</p></li>
<li><p>When AI significantly outperforms humans (e.g. AI playing chess or Go), it can help with <strong>machine teaching</strong> (i.e. learning from the machine on how to improve human performance on that specific task).</p></li>
</ol>

<h5>Why is trust so important?</h3>

First, let me give you a couple of examples of industries where <em>trust</em> is paramount:  

<ul>
<li><p>In healthcare, imagine a Deep Neural Net performing diagnosis for a specific disease. A classic <em>black box</em> NN would just output a binary "yes" or "no". Even if it could outperform humans in sheer predictability, it would be utterly useless in practice. What if the doctor disagreed with the model's assessment, shouldn't he know <em>why</em> the model made that prediction; maybe it saw something the doctor missed. Furthermore, if it made a misdiagnosis (e.g. a sick person was classified as healthy and didn't get the proper treatment), who would take responsibility: the model's user? the hospital? the company that designed the model? The legal framework surrounding this is a bit blurry.</p></li>
<li><p>Another example are self-driving cars. The same questions arise: if a car crashes whose fault is it: the driver's? the car manufacturer's? the company that designed the AI? Legal accountability, is key for the development of this industry.</p></li>
</ul>

In fact, this lack of trust, has according to many hindered the <strong>adoption</strong> of AI in many fields (sources: <a href="http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.61.8362&amp;rep=rep1&amp;type=pdf" rel="noreferrer">1</a>, <a href="https://www.researchgate.net/publication/3454453_Autonomy_and_Common_Ground_in_Human-Robot_Interaction_A_Field_Study" rel="noreferrer">2</a>, <a href="https://arxiv.org/abs/1706.07269" rel="noreferrer">3</a>). While there is a running hypothesis that with more transparent, interpretable or explainable systems users will be <strong>better equipped to understand and therefore trust</strong> the intelligent agents (sources: <a href="https://www.arl.army.mil/arlreports/2014/ARL-TR-6905.pdf" rel="noreferrer">1</a>, <a href="https://journals.sagepub.com/doi/10.1177/0018720815621206" rel="noreferrer">2</a>, <a href="http://www.bradhayes.info/papers/hri17.pdf" rel="noreferrer">3</a>).   

In several real world applications you can't just say "it works 94% of the time". You might also need to provide a justification...  

<h5>Government regulations</h3>

Several governments are slowly proceeding to regulate AI and transparency seems to be at the center of all of this.   

The first to move in this direction is the EU, which has set several guidelines where they state that AI should be transparent (sources: <a href="https://ec.europa.eu/digital-single-market/en/news/ethics-guidelines-trustworthy-ai" rel="noreferrer">1</a>, <a href="https://ec.europa.eu/commission/news/artificial-intelligence-2019-apr-08_en" rel="noreferrer">2</a>, <a href="http://www.europarl.europa.eu/news/en/press-room/20190214IPR26425/online-platforms-required-by-law-to-be-more-transparent-with-eu-businesses" rel="noreferrer">3</a>). For instance the GDPR states that if a person's data has been subject to "automated decision-making" or "profiling" systems, then he has a right to access  

<blockquote>
  "meaningful information about the logic involved"  
</blockquote>

(<a href="http://www.privacy-regulation.eu/en/article-15-right-of-access-by-the-data-subject-GDPR.htm" rel="noreferrer">Article 15, EU GDPR</a>)  

<p>Now this is a bit blurry, but there is clearly the intent of requiring some form of explainability from these systems. The general idea the EU is trying to pass is that "if 
 you have an automated decision-making system affecting people's lives then they have a right to know <em>why</em> a certain decision has been made." For example a bank has an AI accepting and declining loan applications, then the applicants have a right to know <em>why</em> their application was rejected.</p>

<h5>To sum up...</h3>

Explainable AIs are necessary because:  

<ul>
<li>It gives us a better understanding, which helps us improve them.</li>
<li>In some cases we can learn from AI how to make better decisions in some tasks.</li>
<li>It helps users <em>trust</em> AI, which which leads to a wider adoption of AI.</li>
<li>Deployed AIs in the (not to distant) future might be required to be more "transparent".</li>
</ul>

#### Answer 2 (score 15)
<blockquote>
  <p>Why do we need explainable AI?
  ... why we need to know "how does its intelligence work?"</p>
</blockquote>

Because anyone with access to the equipment, enough skill, and enough time, can force the system to make a decision that is unexpected. The owner of the equipment, or 3rd parties, relying on the decision without an explanation as to why it is correct would be at a disadvantage.  

Examples - Someone <strong><em>might</em></strong> discover:  

<ul>
<li><p>People whom are named John Smith and request heart surgery on: Tuesday mornings, Wednesday afternoons, or Fridays on odd days and months have a 90% chance of moving to the front of the line.</p></li>
<li><p>Couples whom have the male's last name an odd letter in the first half of the alphabet and apply for a loan with a spouse whose first name begins with a letter from the beginning of the alphabet are 40% more likely to receive the loan if they have fewer than 5 bad entries in their credit history.</p></li>
<li><p>etc.</p></li>
</ul>

Notice that the above examples <em>ought not</em> to be determining factors in regards to the question being asked, yet it's possible for an adversary (with their own equipment, or knowledge of the algorithm) to exploit it.  

<strong>Source papers</strong>:  

<ul>
<li><p>"<a href="https://arxiv.org/abs/1908.08705" rel="noreferrer">AdvHat: Real-world adversarial attack on ArcFace Face ID system</a>" (Aug 23 2019) by Stepan Komkov and Aleksandr Petiushko</p>

<ul>
<li>Creating a sticker and placing it on your hat fools facial recognition system.</li>
</ul></li>
<li><p>"<a href="https://arxiv.org/abs/1906.03444" rel="noreferrer">Defending against Adversarial Attacks through Resilient Feature Regeneration</a>" (Jun 8 2019), by Tejas Borkar, Felix Heide, and Lina Karam</p>

<ul>
<li><blockquote>
  "Deep neural network (DNN) predictions have been shown to be vulnerable to carefully crafted adversarial perturbations. Specifically, so-called universal adversarial perturbations are image-agnostic perturbations that can be added to any image and can fool a target network into making erroneous predictions. Departing from existing adversarial defense strategies, which work in the image domain, we present a novel defense which operates in the DNN feature domain and effectively defends against such universal adversarial attacks. Our approach identifies pre-trained convolutional features that are most vulnerable to adversarial noise and deploys defender units which transform (regenerate) these DNN filter activations into noise-resilient features, guarding against unseen adversarial perturbations.".  
</blockquote></li>
</ul></li>
<li><p>"<a href="https://arxiv.org/abs/1710.08864" rel="noreferrer">One pixel attack for fooling deep neural networks</a>" (May 3 2019), by Jiawei Su, Danilo Vasconcellos Vargas, and Sakurai Kouichi</p>

<ul>
<li>Altering <strong>one pixel</strong> can cause these errors:</li>
</ul>

<blockquote>
  <p><a href="https://i.stack.imgur.com/X9yf8.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/X9yf8.jpg" alt="Figure 1"></a><br>
  <sub>Fig. 1. One-pixel attacks created with the proposed algorithm that successfully fooled three types of DNNs trained on CIFAR-10 dataset: The All convolutional network (AllConv), Network in network (NiN) and VGG. The original class labels are in black color while the target class labels and the corresponding confidence are given below.</sub></p>
  
  &nbsp;  
  
  <p><a href="https://i.stack.imgur.com/6RdaP.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/6RdaP.jpg" alt="Figure 2"></a><br>
  <sub>Fig. 2. One-pixel attacks on ImageNet dataset where the modified pixels are highlighted with red circles. The original class labels are in black color while the target class labels and their corresponding confidence are given below.</sub></p>
</blockquote></li>
</ul>

Without an explanation as to how and why a decision is arrived at the decision can't be absolutely relied upon.  

#### Answer 3 (score 8)
If you're a bank, hospital or any other entity that uses predictive analytics to make a decision about actions that have huge impact on people's lives, you would not make important decisions just because Gradient Boosted trees told you to do so. Firstly, because it's risky and the underlying model might be wrong and, secondly, because in some cases it is illegal - see <a href="https://en.wikipedia.org/wiki/Right_to_explanation" rel="noreferrer">Right to explanation</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: What is the concept of Tensorflow Bottlenecks? (score [9085](https://stackoverflow.com/q/4864) in 2018)

#### Question
What is the <a href="https://www.tensorflow.org/tutorials/image_retraining" rel="noreferrer">concept</a> and how does one calculate Bottleneck values? How do these values help image classification? Please explain in simple words.  

#### Answer accepted (score 17)
The bottleneck in a neural network is just a layer with less neurons then the layer below or above it. Having such a layer encourages the network to compress feature representations to best fit in the available space, in order to get the best loss during training.  

In a CNN (such as Google's Inception network), bottleneck layers are added to reduce the number of feature maps (aka "channels") in the network, which otherwise tend to increase in each layer. This is achieved by using 1x1 convolutions with less output channels than input channels.  

You don't usually calculate weights for bottleneck layers directly, the training process handles that, as for all other weights. Selecting a good size for a bottleneck layer is something you have to guess, and then experiment, in order to find network architectures that work well. The goal here is usually finding a network that generalises well to new images, and bottleneck layers help by reducing the number of parameters in the network whilst still allowing it to be deep and represent many feature maps.  

#### Answer 2 (score 7)
Imagine, you want to re-compute the last layer of a pre-trained model :   

```text
Input->[Freezed-Layers]->[Last-Layer-To-Re-Compute]->Output
```

To train <em>[Last-Layer-To-Re-Compute]</em>, you need to evaluate outputs of <em>[Freezed-Layers]</em> multiple times for a given input data. In order to save time, you can compute these ouputs <strong>only once</strong>.  

```text
Input#1->[Freezed-Layers]->Bottleneck-Features-Of-Input#1
```

Then, you store all <em>Bottleneck-Features-Of-Input#i</em> and directly use them to train [Last-Layer-To-Re-Compute].  

Explanations from the "cache_bottlenecks" function of the "image_retraining" example :   

<blockquote>
  <p>Because we're likely to read the same image multiple times (if there are no
      distortions applied during training) it can speed things up a lot if we
      calculate the bottleneck layer values once for each image during
      preprocessing, and then just read those cached values repeatedly during
      training.</p>
</blockquote>

#### Answer 3 (score 4)
Tensorflow bottleneck is the last pre prosessing phase before the actual training with data recognitions start. It is a phase where a data structure is formed from each training image that the final phase of training can take place and distinguish the image from every other image used in training material. Somewhat like a fingerprint of the image.  

It is involved to the re-training command and as the name suggests, this is the main time consumer of the command execution. The amount of training material may have to be compromized if this bottleneck seems too time consuming.  

As it is a command line command, I don't know the exact algorithm. Algorithm is public in code in Github but is supposedly so complicated (execution time is very long by definition) that I believe I cannot just write it down in this type of answer.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: What is a Dynamic Computational Graph? (score [9046](https://stackoverflow.com/q/3801) in 2017)

#### Question
Frameworks like <a href="http://pytorch.org" rel="noreferrer">PyTorch</a> and TensorFlow through <a href="https://research.googleblog.com/2017/02/announcing-tensorflow-fold-deep.html" rel="noreferrer">TensorFlow Fold</a> support Dynamic Computational Graphs and are receiving attention from data scientists.  

However, there seems to be a lack of resource to aid in understanding Dynamic Computational Graphs.  

The advantage of Dynamic Computational Graphs appears to include the ability to adapt to a varying quantities in input data.  It seems like there may be automatic selection of the number of layers, the number of neurons in each layer, the activation function, and other NN parameters, depending on each input set instance during the training.  Is this an accurate characterization?  

What are the advantages of dynamic models over static models?  Is that why DCGs are receiving much attention?  In summary, what are DCGs and what are the pros and cons their use?  

#### Answer accepted (score 8)
<strong>Two Short Answers</strong>  

The short answer from a theoretical perspective is that ...  

<blockquote>
  A Dynamic Computational Graph is a mutable system represented as a directed graph of data flow between operations.  It can be visualized as shapes containing text connected by arrows, whereby the vertices (shapes) represent operations on the data flowing along the edges (arrows).  
</blockquote>

Note that such a graph defines dependencies in the data flow but not necessarily the temporal order of the application of operations, which can become ambiguous in the retention of state in vertices or cycles in the graph without an additional mechanism to specify temporal precedence.  

The short answer from an applications development perspective is that ...  

<blockquote>
  A Dynamic Computational Graph framework is a system of libraries, interfaces, and components that provide a flexible, programmatic, run time interface that facilitates the construction and modification of systems by connecting a finite but perhaps extensible set of operations.  
</blockquote>

<strong>The PyTorch Framework</strong>  

PyTorch is the integration of the Torch framework with the Python language and data structuring. Torch competes with Theano, TensorFlow, and other dynamic computational system construction frameworks.  

<hr>

<blockquote>
  &mdash;&mdash;&mdash; &nbsp; <strong><em>Additional Approaches to Understanding</em></strong> &nbsp; &mdash;&mdash;&mdash;  
</blockquote>

<strong>Arbitrary Computational Structures of Arbitrary Discrete Tensors</strong>  

One of the components that can be used to construct a computational system is an element designed to be interconnected to create neural networks.  The availability of these supports the construction deep learning and back propagating neural networks.  A wide variety of other systems involving the assembly of components that work with potentially multidimensional data in arbitrarily defined computational structures can also be constructed.  

The data can be scalar values, such as floating point numbers, integers, or strings, or orthogonal aggregations of these, such as vectors, matrices, cubes, or hyper-cubes.  The operations on the generalization of these data forms are discrete tensors and the structures created from the assembly of tensor operations into working systems are data flows.  

<strong>Points of Reference for Understanding the Dynamic Computation Concept</strong>  

Dynamic Computational Graphs are not a particularly new concept, even though the term is relatively new.  The interest in DCGs among computer scientists is not as new as the term Data Scientist.  Nonetheless, the question correctly states that there are few well written resources available (other than code examples) from which one can learn the overall concept surrounding their emergence and use.  

One possible point of reference for beginning to understand DCGs is the Command design pattern which is one of the many design patterns popularized by the proponents of object oriented design.  The Command design pattern considers operations as computation units the details of which are hidden from the command objects that trigger them.  The Command design pattern is often used in conjunction with the Interpreter design pattern.  

In the case of DCGs, the Composite and Facade design patterns are also involved to facilitate the definition plug-and-play discrete tensor operations that can be assembled together in patterns to form systems.  

This particular combination of design patterns to form systems is actually a software abstraction that largely resemble the radical idea that led to the emergence of the Von Neumann architecture, central to most computers today.  Von Neumann's contribution to the emergence of the computer is the idea of permitting arbitrary algorithms containing Boolean logic, arithmetic, and branching to be represented and stored as data -- a program.  

Another forerunner of DCGs are expression engines.  Expression engines can be as simple as arithmetic engines and as complex as applications such as Mathematica.  A rules engine is a little like DCGs except that rules engines are declarative and meta-rules for rules engines operate on those declarations.  

<strong>Programs Manipulating Programs</strong>  

What these have in common with DCGs is that the flow of data and operations to be applied can be defined at run time.  As with DCGs, some of these software libraries and applications have APIs or other mechanisms to permit operations to be applied to on functional details.  It is essentially the idea of a program permitting the manipulation of another program.  

Another reference point for understanding this principle at a primitive level is the switch-case statement available in some computer languages.  It is a source code structure whereby the programmer essentially expresses, "We're not sure what must be done, but the value of this variable will tell the real time execution model what to do from a set of possibilities."  

The switch-case statement is an abstraction that extends the idea of deferring the decision as to the direction of computation until run time.  It is the software version of what is done inside the control unit of a contemporary CPU and an extension of the concept of deferring some algorithm details.  A table of functors (function pointers) in C or polymorphism in C++, Java, or Python are other primitive examples.  

Dynamic Computation takes the abstraction further.  They defers most if not all of the specification of computations and the relationships between them to run time.   This comprehensive generalization broadens the possibilities of functional modification at run time.  

<strong>Directed Graph Representation of Computation</strong>  

That's what the Dynamic Computational model is.  Now for the Graph part.  

Once one decides to defer the choice of operations to be preformed until run time, a structure is required to hold the operations, their dependency relationships, and perhaps mapping parameters.  Such a representation is more than a syntactic tree (such as a tree representing the hierarchy of source code).  Unlike an assembly language program or machine code, it must be easily and arbitrarily mutable.  It must contain more information than a data flow graph and much more than a memory map.  What must that data structure that specifies the computational structure look like?  

Fortunately any arbitrary, finite, bounded algorithm can be represented as a directed graph of dependencies between specified operations.  In such a graph, the vertices (often represented as nodes of various shapes when displayed) represent operations performed on the data and the edges (often represented as arrows when displayed) are digital representations of information originating resulting from some operation (or system input) and upon which other operations (or system output) depend.  

Keep in mind that the directed graph is neither an algorithm (in that a precise sequence of operations is specified) nor a declaration (in that data can be explicitly stored and loops, branches, functions, and modules may be definable and nested).  

Most of these Dynamic Computational Graph frameworks and libraries permit the components to do computations on the component input that support machine learning.  Vertices in the directed graph can be simulations of neurons for the construction of a neural net or components that support differential calculus.  These frameworks present possibilities of constructs that can be used for deep learning in a more generalized sense.  

<strong>In the Context of Computer History</strong>  

Again, nothing mentioned thus far is new to computer science.  LISP permits computational schematics to be modified by other algorithms.  And generalized input dimensionality and numerocity is built into a number of longstanding plug-and-play interfaces and protocols.  The idea of a framework for learning dates back to the same mid Twentieth Century period too.  

What is new and gaining in popularity is a particular combination of integrated features and the associated set of terminology, an aggregation of existing terminology for each of the features, leading to a wider base for comprehension by those already studying for and working in the software industry.  

<ul>
<li>Contemporary (trendy) flavor of API interfaces</li>
<li>Object orientation</li>
<li>Discrete tensor support</li>
<li>The directed graph abstraction</li>
<li>Interoperability with popular languages and packages that support big data, data mining, machine learning, and statistical analysis</li>
<li>Support for arbitrary and systematic neural network construction</li>
<li>The possibility of dynamic neural network structural adaptation (which facilitates experimentation on neural plasticity)</li>
</ul>

Many of these frameworks support adaptability to changing input dimensionality (number of dimensions and the range of each).  

<strong>Similarity to Abstract Symbol Trees in Compilers</strong>  

A dependency graph of inputs and outputs of operations also appears within abstract symbol trees (AST), which some of the more progressive compilers construct during the interpretation of the source code structure.  The AST is then used to generate assembler instructions or machine instructions in the process of linking with libraries and forming an executable.  The AST is a directed graph that represents the structure of data, operations performed, and the control flow specified by the source code.  

The data flow is simply the set of dependencies between operations, which must be inherent in the AST for the AST to be used to create execution instructions in assembler or machine code that precisely follows the algorithm specified in the source code.  

Dynamic Computational Graph frameworks, unlike switch-case statements or AST models in compilers, can be manipulated in real time, optimized, tuned (as in the case of plastic artificial nets), inverted, transformed by tensors, decimated, modified to add or remove entropy, mutated according to a set of rules, or otherwise translated into derivative forms.  They can be stored as files or streams and then retrieved from them.  

This is a trivial concept for LISP programmers or those that understand the nature of John von Neumann's recommendation to store operational specifications as data.  In this later sense, a program is a data stream to instruct, through a compiler and operating system, a dynamic computational system implemented in VLSI digital circuitry.  

<strong>Achieving Adaptable Dimensionality and Numerocity</strong>  

In the question is the comment that one doesn't, "Need to have data set -- that all the instances within it have the same, fixed number of inputs." That statement does not promote accurate comprehension.  There are clearer ways to say what is true about input adaptability.  

The interface between a DCG and other components of an overall system must be defined, but these interfaces may have dynamic dimensionality or numerocity built into them.  It is a matter of abstraction.  

For instance, a discrete tensor object type presents a specific software interface, yet a tensor is a dynamic mathematical concept around which a common interface can be used.  A discrete tensor may be a scalar, a vector, a matrix, a cube, or a hyper-cube, and the range of dependent variables for each dimension may be variable.  

It can be the case that the quantity of nodes in a layer of the system defined in a Dynamic Computational Graph can be a function of the number of inputs of a particular type, and that too can be a computation deferred to run time.  

The framework may be programmed to select layer structure (an extension of the switch-case paradigm again) or calculate parameters defining the structure sizes and depth or activation.  However these sophisticated features are not what qualifies the framework as a Dynamic Computational Graph framework.  

<strong>What Qualifies a Framework to Support Dynamic Computational Graphs?</strong>  

To qualify as a Dynamic Computational Graph framework, the framework must merely support the deferring of the determination of algorithm to run time, therefore opening the door to a plethora of operations on the computational dependencies and data flow at run time.  The basics of the operations deferred must include the specification, manipulation, execution, and storage of the directed graphs that represent systems of operations.  

If the specification of the algorithm is NOT deferred until run time but is compiled into the executable designed for a specific operating system with only the traditional flexibility provided by low level languages such as if-then-else, switch-case, polymorphism, arrays of functors, and variable length strings, it is considered a static algorithm.  

If the operations, the dependencies between them, the data flow, the dimensionality of the data within the flow, and the adaptability of the system to the input numerocity and dimensionality are all variable at run time in a way to create a highly adaptive system, then the algorithm is dynamic in these ways.  

Again, LISP programs that operate on LISP programs, rules engines with meta-rule capabilities, expression engines, discrete tensor object libraries, and even relatively simple Command design patterns are all dynamic in some sense, deferring some characteristics to run time.  DCGs are flexible and comprehensive in their capabilities to support arbitrary computational constructs in such a way to create a rich environment for deep learning experimentation and systems implementation.  

<strong>When to Use Dynamic Computational Graphs</strong>  

The pros and cons of DCGs are entirely problem specific.  If you investigate the various dynamic programming concepts above and others that may be closely tied to them in the associated literature, it will become obvious whether you need a Dynamic Computational Graph or not.  

In general, if you need to represent an arbitrary and changing model of computation to facilitate the implementation of the deep learning system, mathematical manipulation system, adaptive system, or other flexible and complex software construct that maps to the DCG paradigm well, then a proof of concept using a Dynamic Computatonal Graph framework is a good first step in defining your software architecture for the problem's solution.  

Not all learning software uses DCG's, but they are often a good choice, when the systematic and possibly continuous manipulation of an arbitrary computational structure is a run time requirement.  

#### Answer 2 (score 1)
In short, dynamic computation graphs can solve some problems that static ones cannot, or are inefficient due to not allowing training in batches.  

To be more specific, modern neural network training is usually done in <strong>batches</strong>, i.e. processing more than one data instance at a time. Some researchers choose batch size like 32, 128 while others use batch size larger than 10,000. Single-instance training is usually very slow because it cannot benefit from hardware parallelism.   

For example, in Natural Language Processing, researchers want to train neural networks with sentences of different lengths. Using static computation graphs, they would usually have to first do <strong>padding</strong>, i.e. adding meaningless symbols to the beginning or end of shorter sentences to make all sentences of the same length. This operation complicates the training a lot (e.g. need masking, re-define evaluation metrics, waste a significant amount of computation time on those padded symbols).  With a dynamic computation graph, padding is no longer needed (or only needed within each batch).  

A more complicated example would be to (use neural network to) process the sentences based on its parsing trees. Since each sentence has its own parsing tree, they each requires a different computation graph, which means training with a static computation graph can only allow single-instance training. An example similar to this is the <a href="https://ai.stanford.edu/~ang/papers/icml11-ParsingWithRecursiveNeuralNetworks.pdf" rel="nofollow noreferrer">Recursive Neural Networks</a>.  

#### Answer 3 (score 0)
Dynamic Computational Graphs are simply modified CGs with a higher level of abstraction. The word 'Dynamic' explains it all: how data flows through the graph depends on the input structure,i.e the DCG structure is mutable and not static. One of its important applications is in NLP neural networks.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: What are bottleneck features? (score [8397](https://stackoverflow.com/q/3089) in 2019)

#### Question
In the blog post <a href="https://blog.keras.io/building-powerful-image-classification-models-using-very-little-data.html" rel="nofollow noreferrer">Building powerful image classification models using very little data</a>, bottleneck features are mentioned. What are the bottleneck features? Do they change with the architecture that is used? Are they the final output of convolutional layers before the fully-connected layer? Why are they called so?  

#### Answer 2 (score 9)
<blockquote>
  In the blog post <a href="https://blog.keras.io/building-powerful-image-classification-models-using-very-little-data.html" rel="nofollow noreferrer">Building powerful image classification models using very little data</a>, bottleneck features are mentioned. What are the bottleneck features?  
</blockquote>

It's clearly written in the link you gave <em>the "bottleneck features" from the VGG16 model: the last activation maps before the fully-connected layers</em>.  

<blockquote>
  Do they change with the architecture that is used?  
</blockquote>

Sure. The author most likely used a pre-trained model (trained on a large data and now used only as a feature extractor)    

<blockquote>
  Are they the final output of convolutional layers before the fully-connected layer?  
</blockquote>

Yes.    

<blockquote>
  Why are they called so?  
</blockquote>

Given the input size to VGG, the feature maps of HxW dimensions are getting twice smaller after every max-pool operation. HxW is the smallest on the last convolutional layer.  

#### Answer 3 (score 6)
First, we need to talk about transfer learning. Imagine you trained a neuronal network over a dataset of images to detect cats, you can use part of the training you have done to work over another detecting something else. That's known as transfer learning.  

To do transfer learning, you will remove the last fully connected layer from the model and plug in your layers there. The "truncated" model output is going to be the features that will fill your "model". Those are the bottleneck features.  

VGG16 is a pretrain-model over ImageNet catalog that has very good accuracy. In the post you shared, is using that model as a base to detect cat and dogs with a higher accuracy.  

Bottleneck features depends on the model. In this case, we are using VGG16. There are others pre-trained models like VGG19, ResNet-50  

It's like you are cutting a model and adding your own layers. Mainly, the output layer to decide what you want to detect, the final output.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: Teach a Neural Network to play a card game (score [8148](https://stackoverflow.com/q/4048) in 2018)

#### Question
I am currently writing an engine to play a card game, as there is no engine yet for this particular game.  

I am hoping to be able to introduce a neural net to the game afterwards, and have it learn to play the game.  

I'm writing the engine in such a way that is helpful for an AI player. There are choice points, and at those points, a list of valid options is presented. Random selection would be able to play the game (albeit not well).  

I have learned a lot about neural networks (mostly NEAT and HyperNEAT) and even built my own implementation. I am still unsure how best build an AI that can take into account all the variables in one of these types of games. Is there a common approach? I know that Keldon wrote a good AI for RftG which has a decent amount of complexity, I am not sure how he managed to build such an AI.  

Any advice? Is it feasible? Are there any good examples of this? How were the inputs mapped?  

EDIT: I have looked online and learned how neural networks work and usually how they pertain to image recognition or steering a simple agent. I'm not sure if or how I would apply it to making selections with cards which have a complex synergy. Any direction towards what I should be looking into would be greatly appreciated.  

About the game: The game is similar to Magic: The Gathering. There is a commander which has health and abilities. Players have an energy pool which they use to put minions and spells on the board. Minions have health, attack values, costs, etc. Cards also have abilities, these are not easily enumerated. Cards are played from the hand, new cards are drawn from a deck. These are all aspects it would be helpful for the neural network to consider.   

#### Answer 2 (score 3)
I think you raise a good question, especially WRT to how the NNs inputs &amp; outputs are mapped onto the mechanics of a card game like MtG where the available actions vary greatly with context.   

I don't have a really satisfying answer to offer, but I have played Keldon's Race for the Galaxy NN-based AI - agree that it's excellent- and have looked into how it tackled this problem.  

The latest code for Keldon's AI is now searchable and browseable on <a href="https://github.com/bnordli/rftg" rel="nofollow noreferrer">github</a>.  

The ai code is in one <a href="https://github.com/bnordli/rftg/blob/master/src/ai.c" rel="nofollow noreferrer">file</a>. It uses 2 distinct NNs, one for "evaluating hand and active cards" and the other for "predicting role choices".  

What you'll notice is that it uses a fair amount on non-NN code to model the game mechanics. Very much a hybrid solution.   

The mapping of game state into the evaluation NN is done <a href="https://github.com/bnordli/rftg/blob/master/src/ai.c#L1942" rel="nofollow noreferrer">here</a>. Various relevant features are one-hot-encoded, eg the number of goods that can be sold that turn.  

<hr>

Another excellent case study in mapping a complex game into a NN is the Starcraft II Learning Environment created by Deepmind in collaboration with Blizzard Entertainment. This <a href="https://deepmind.com/documents/110/sc2le.pdf" rel="nofollow noreferrer">paper</a> gives an overview of how a game of Starcraft is mapped onto a set of features that a NN can interpret, and how actions can be issued by a NN agent to the game simulation.  

#### Answer 3 (score 2)
This is completely feasible, but the way the inputs are mapped would greatly depend on the type of card game, and how it's played.  

I'll take into account a few possibilities:  

<ol>
<li>Does time matter in this game? Would a past move influence a future one? In this case, you'd be better off using Recurrent Neural Networks (LSTMs, GRUs, etc.).</li>
<li><p>Would you like the Neural Network to learn off of data you collect, or learn on its own? If on its own, how? If you collect data of yourself playing the game tens or hundreds of times, feed it into the Neural Net, and make it learn from you, then you're doing something called "Behavioural Cloning". However, if you'd like the NN to learn on its own, you can do this 2 ways:</p>

a) <strong>Reinforcement Learning</strong> - RL allows the Neural Net to learn by playing against itself <em>lots</em> of times.  

b) <strong>NEAT/Genetic Algorithm</strong> - NEAT allows the Neural Net to learn by using a genetic algorithm.  </li>
</ol>

However, again, in order to get more specific as to how the Neural Net's inputs and outputs should be encoded, I'd have to know more about the card game itself.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: What is self-supervised learning in machine learning? (score [8113](https://stackoverflow.com/q/10623) in 2019)

#### Question
What is self-supervised learning in machine learning? How is it different from supervised learning?  

#### Answer 2 (score 12)
Self-supervised learning (or self-supervision) is a relatively recent learning technique (in machine learning) where the training data is autonomously (or automatically) labelled. It is still supervised learning, but the datasets do not need to be manually labelled by a human, but they can e.g. be labelled by finding and exploiting the relations (or correlations) between different input signals (that is, input coming from different sensor modalities).   

A natural advantage and consequence of self-supervised learning is that it can more easily (with respect to e.g. supervised learning) be performed in an online fashion (given that data can be gathered and labelled without human intervention), where models can be updated or trained completely from scratch. Therefore, self-supervised learning should also be well suited for changing environments, data and, in general, situations.  

For example, consider a robot which is equipped with a <em>proximity sensor</em> (which is a <em>short-range</em> sensor capable of detecting objects in front of the robot at short distances) and a <em>camera</em> (which is <em>long-range</em> sensor, but which does not provide a direct way of detecting objects). You can also assume that this robot is capable of performing <a href="https://en.wikipedia.org/wiki/Odometry" rel="noreferrer">odometry</a>. An example of such a robot is <a href="https://github.com/jeguzzi/mighty-thymio" rel="noreferrer">Mighty Thymio</a>.   

Consider now the task of detecting objects in front of the robot at longer ranges than the range the proximity sensor allows. In general, we could train a CNN to achieve that. However, to train such CNN, in supervised learning, we would first need a labelled dataset, which contains labelled images (or videos), where the labels could e.g. be "object in the image" or "no object in the image". In supervised learning, this dataset would need to be manually labelled by a human, which clearly would require a lot of work.  

To overcome this issue, we can use a self-supervised learning approach. In this example, the basic idea is to associate the output of the proximity sensors at a time step <span class="math-container">$t' &gt; t$</span> with the output of the camera at time step <span class="math-container">$t$</span> (a smaller time step than <span class="math-container">$t'$</span>).  

More specifically, suppose that the robot is <em>initially</em> at coordinates <span class="math-container">$(x, y)$</span> (on the plane), at time step <span class="math-container">$t$</span>. At this point, we still do not have enough info to label the output of the camera (at the same time step <span class="math-container">$t$</span>). Suppose now that, at time <span class="math-container">$t'$</span>, the robot is at position <span class="math-container">$(x', y')$</span>. At time step <span class="math-container">$t'$</span>, the output of the proximity sensor will e.g. be "object in front of the robot" or "no object in front of the robot". Without loss of generality, suppose that the output of the proximity sensor at <span class="math-container">$t' &gt; t$</span> is "no object in front of the robot", then the label associated with the output of the camera (an image frame) at time <span class="math-container">$t$</span> will be "no object in front of the robot".  

For more details about this specific example, have a look at the paper <a href="https://arxiv.org/abs/1809.07207" rel="noreferrer"><em>Learning Long-range Perception using Self-Supervision from Short-Range Sensors and Odometry</em></a> by Mirko Nava, Jérôme Guzzi, R. Omar Chavez-Garcia, Luca M. Gambardella and Alessandro Giusti.  

<em>Note that self-supervised learning is defined slightly differently depending on the context or area, which can, for example, be robotics, reinforcement learning or representation (or feature) learning. More precisely, the definition given above is used in robotics. See, for example, also this paper <a href="https://arxiv.org/pdf/1708.07860.pdf" rel="noreferrer">Multi-task Self-Supervised Visual Learning</a>. For a slightly different definition of self-supervised learning, see, for example, the paper <a href="https://arxiv.org/pdf/1806.01260.pdf" rel="noreferrer">Digging Into Self-Supervised Monocular Depth Estimation</a>.</em>  

For another introduction to self-supervised learning, have a look at this web article: <a href="https://hackernoon.com/self-supervised-learning-gets-us-closer-to-autonomous-learning-be77e6c86b5a" rel="noreferrer">https://hackernoon.com/self-supervised-learning-gets-us-closer-to-autonomous-learning-be77e6c86b5a</a>. In this article, the author also compares self-supervised learning to unsupervised learning, semi-supervised learning and reinforcement learning.  

There is also a curated list of links to papers where this learning approach is used at the following URL: <a href="https://github.com/jason718/awesome-self-supervised-learning" rel="noreferrer">https://github.com/jason718/awesome-self-supervised-learning</a>.  

#### Answer 3 (score 3)
Self-supervised learning is when you use some parts of the samples as labels for a task that requires a good degree of comprehension to be solved. I'll emphasize these two key points, before giving an example:  

<ul>
<li><p><em>Labels are extracted from the sample</em>, so they can be generated automatically, with some very simple algorithm (maybe just random selection).</p></li>
<li><p><em>The task requires understanding</em>. This means that, in order to predict the output, the model has to extract some good patterns from the data, generating on the process a good representation.</p></li>
</ul>

A very common case for semi-supervised learning takes place in natural language processing, when you need to solve a task but have few labeled data. In such cases, you need to learn a good representation or language model, so you take sentences and give your network self-supervision tasks like these:  

<ul>
<li><p>Ask the network to predict the next word in a sentence (which you know because you took it away).</p></li>
<li><p>Mask a word and ask the network to predict which word goes there (which you know because you had to mask it).</p></li>
<li><p>Change the word for a random one (that probably doesn't make sense) and ask the network which word is wrong.</p></li>
</ul>

As you can see, these tasks are fairly simple to formulate and the labels are part of the same sample, but they require a certain understanding of the context to be solved.  

And it's always like this: alter your data in some way, generating the label in the process, and ask the model something related to that transformation. If the task requires enough understanding of the data, you'll have success.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: keras ValueError: Error when checking model target: expected activation_4 to have shape (None, 19) but got array with shape (100, 1) (score [8004](https://stackoverflow.com/q/2928) in )

#### Question
I'm trying to create simple keras NN which will learn to make addition on numbers between 0 and 10. But I am getting the error:   

```text
ValueError: Error when checking model target: expected activation_4 to have shape (None, 19) but got array with shape (100, 1)
```

here is my code:  

```text
from keras.models import Sequential
from keras.layers import Dense, Activation
import numpy as np

keras.optimizers.SGD(lr=0.01, momentum=0.0, decay=0.0, nesterov=False)

model = Sequential()
model.add(Dense(output_dim=50, input_dim=2))
model.add(Activation("relu"))
model.add(Dense(output_dim=50))
model.add(Activation("softmax"))
model.add(Dense(output_dim=50))
model.add(Activation("softmax"))
model.add(Dense(output_dim=19))
model.add(Activation("softmax"))

model.compile(loss='categorical_crossentropy', optimizer='sgd', metrics=['accuracy'])

x = []
y = []

for i in range(0, 10):
    for j in range(0, 10):
        x.append((i, j))
        y.append(i + j)

x = np.array(x)
y = np.array(y)
print(x)
print(y)

model.fit(x, y, nb_epoch=5, batch_size=32)
```

how to fix that?  

#### Answer accepted (score 0)
Try to use the model like this, for example:  

```text
model = Sequential() 
model.add(Dense(50, input_shape=(2,))) 
model.add(Activation("relu")) 
model.add(Dense(50, activation='softmax')) 
model.add(Dense(1, activation='linear')) 
model.compile(optimizer='sgd', loss='mse', metrics=["accuracy"])
```

<p><br/>
This means that first layer will have <strong>50</strong> neurons and can receive data in form of matrix with <strong>2</strong> columns and an unspecified number of rows.
So you can prepare your data in this form – 2 numbers for <em>adding</em> in each row.</p>

```text
Dense(50, input_shape=(2,))
```

<p><br/>
At the end, you need a layer with 1 neuron and the `'linear'` activation, because you expect one simple number as a result.</p>

```text
Dense(1, activation='linear')
```

<p><br/>
And finally, use `'mse'` loss function or something similar. `'categorical_crossentropy'` is needed for classification tasks, not regression as needed for you.
See: <a href="https://keras.io/objectives/" rel="nofollow noreferrer">https://keras.io/objectives/</a></p>

#### Answer 2 (score 0)
You shouldn't use Softmax as an activation function in intermediate layers. Softmax is used to represent a categorical distribution, and should be applied at the point where one makes a categorical prediction (usually the final layer of the network).  

Consider replacing you activation function in all layers except the last one with 'relu' or 'sigmoid'.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: What is the time complexity for training a neural network using back-propagation? (score [7846](https://stackoverflow.com/q/5728) in 2019)

#### Question
Suppose that a NN contains <span class="math-container">$n$</span> hidden layers, <span class="math-container">$m$</span> training examples, <span class="math-container">$x$</span> features, and <span class="math-container">$n_i$</span> nodes in each layer. What is the time complexity to train this NN using back-propagation?   

I have a basic idea about how they find the time complexity of algorithms, but here there are 4 different factors to consider here i.e. iterations, layers, nodes in each layer, training examples, and maybe more factors. I found an answer <a href="https://www.researchgate.net/post/What_is_the_time_complexity_of_Multilayer_Perceptron_MLP_and_other_neural_networks" rel="nofollow noreferrer">here</a> but it was not clear enough.  

Are there other factors, apart from those I mentioned above, that influence the time complexity of the training algorithm of a NN?  

#### Answer accepted (score 8)
<em>I haven't seen an answer from a trusted source, but I'll try to answer this myself, with a simple example (with my current knowledge).</em>  

In general, note that training a MLP using back-propagation is usually implemented with matrices.  

<h5>Time complexity of matrix multiplication</h3>

The time complexity of matrix multiplication for <span class="math-container">$M_{ij} * M_{jk}$</span> is simply <span class="math-container">$\mathcal{O}(i*j*k)$</span>.   

Notice that we are assuming simplest multiplication algorithm here: there exists some other algorithms with somewhat better time complexity.  

<h5>Feedforward pass algorithm</h3>

Feedforward propagation algorithm is as follows.   

First, to go from layer <span class="math-container">$i$</span> to <span class="math-container">$j$</span>, you do  

<span class="math-container">$$S_j = W_{ji}*Z_i$$</span>  

Then you apply the activation function  

<span class="math-container">$$Z_j = f(S_j)$$</span>  

If we have <span class="math-container">$N$</span> layers (including input and output layer), this will run <span class="math-container">$N-1$</span> times.  

<h5>Example</h3>

As an example, let's compute the time complexity for the forward pass algorithm for a MLP with <span class="math-container">$4$</span> layers, where <span class="math-container">$i$</span> denotes the number of nodes of the input layer, <span class="math-container">$j$</span> the number of nodes in the second layer, <span class="math-container">$k$</span> the number of nodes in the third layer and <span class="math-container">$l$</span> the number of nodes in the output layer.  

Since there are <span class="math-container">$4$</span> layers, you need <span class="math-container">$3$</span> matrices to represent weights between these layers. Let's denote them by <span class="math-container">$W_{ji}$</span>, <span class="math-container">$W_{kj}$</span> and <span class="math-container">$W_{lk}$</span>, where <span class="math-container">$W_{ji}$</span> is a matrix with <span class="math-container">$j$</span> rows and <span class="math-container">$i$</span> columns (<span class="math-container">$W_{ji}$</span> thus contains the weights going from layer <span class="math-container">$i$</span> to layer <span class="math-container">$j$</span>).  

Assume you have <span class="math-container">$t$</span> training examples. For propagating from layer <span class="math-container">$i$</span> to <span class="math-container">$j$</span>, we have first  

<span class="math-container">$$S_{jt} = W_{ji} * Z_{it}$$</span>  

and this operation (i.e. matrix multiplcation) has <span class="math-container">$\mathcal{O}(j*i*t)$</span> time complexity. Then we apply the activation function  

<p><span class="math-container">$$
Z_{jt} = f(S_{jt})
$$</span></p>

and this has <span class="math-container">$\mathcal{O}(j*t)$</span> time complexity, because it is an element-wise operation.  

So, in total, we have  

<span class="math-container">$$\mathcal{O}(j*i*t + j*t) = \mathcal{O}(j*t*(t + 1)) = \mathcal{O}(j*i*t)$$</span>  

Using same logic, for going <span class="math-container">$j \to k$</span>, we have <span class="math-container">$\mathcal{O}(k*j*t)$</span>, and, for <span class="math-container">$k \to l$</span>, we have <span class="math-container">$\mathcal{O}(l*k*t)$</span>.  

In total, the time complexity for feedforward propagation will be  

<span class="math-container">$$\mathcal{O}(j*i*t + k*j*t + l*k*t) = \mathcal{O}(t*(ij + jk + kl))$$</span>  

I'm not sure if this can be simplified further or not. Maybe it's just <span class="math-container">$\mathcal{O}(t*i*j*k*l)$</span>, but I'm  not sure.  

<h5>Back-propagation algorithm</h3>

The back-propagation algorithm proceeds as follows. Starting from the output layer <span class="math-container">$l \to k$</span>, we compute the error signal, <span class="math-container">$E_{lt}$</span>, a matrix containing the error signals for nodes at layer <span class="math-container">$l$</span>  

<p><span class="math-container">$$
E_{lt} = f'(S_{lt}) \odot {(Z_{lt} - O_{lt})}
$$</span></p>

where <span class="math-container">$\odot$</span> means element-wise multiplication. Note that <span class="math-container">$E_{lt}$</span> has <span class="math-container">$l$</span> rows and <span class="math-container">$t$</span> columns: it simply means each column is the error signal for training example <span class="math-container">$t$</span>.  

We then compute the "delta weights", <span class="math-container">$D_{lk} \in \mathbb{R}^{l \times k}$</span> (between layer <span class="math-container">$l$</span> and layer <span class="math-container">$k$</span>)  

<p><span class="math-container">$$
D_{lk} = E_{lt} * Z_{tk}
$$</span></p>

where <span class="math-container">$Z_{tk}$</span> is the transpose of <span class="math-container">$Z_{kt}$</span>.  

We then adjust the weights  

<p><span class="math-container">$$
W_{lk} = W_{lk} - D_{lk}
$$</span></p>

For <span class="math-container">$l \to k$</span>, we thus have the time complexity <span class="math-container">$\mathcal{O}(lt + lt + ltk + lk) = \mathcal{O}(l*t*k)$</span>.  

Now, going back from <span class="math-container">$k \to j$</span>. We first have  

<p><span class="math-container">$$
E_{kt} = f'(S_{kt}) \odot (W_{kl} * E_{lt})
$$</span></p>

Then  

<p><span class="math-container">$$
D_{kj} = E_{kt} * Z_{tj}
$$</span>    </p>

And then  

<span class="math-container">$$W_{kj} = W_{kj} - D_{kj}$$</span>  

where <span class="math-container">$W_{kl}$</span> is the transpose of <span class="math-container">$W_{lk}$</span>. For <span class="math-container">$k \to j$</span>, we have the time complexity <span class="math-container">$\mathcal{O}(kt + klt + ktj + kj) = \mathcal{O}(k*t(l+j))$</span>.  

And finally, for <span class="math-container">$j \to i$</span>, we have <span class="math-container">$\mathcal{O}(j*t(k+i))$</span>. In total, we have  

<span class="math-container">$$\mathcal{O}(ltk + tk(l + j) + tj (k + i)) = \mathcal{O}(t*(lk + kj + ji))$$</span>  

which is same as feedforward pass algorithm. Since they are same, the total time complexity for one epoch will be <span class="math-container">$$O(t*(ij + jk + kl)).$$</span>  

This time complexity is then multiplied by number of iterations (epochs). So, we have <span class="math-container">$$O(n*t*(ij + jk + kl)),$$</span> where <span class="math-container">$n$</span> is number of iterations.  

<h5>Notes</h3>

Note that these matrix operations can greatly be paralelized by GPUs.  

<h5>Conclusion</h3>

We tried to find the time complexity for training a neural network that has 4 layers with respectively <span class="math-container">$i$</span>, <span class="math-container">$j$</span>, <span class="math-container">$k$</span> and <span class="math-container">$l$</span> nodes, with <span class="math-container">$t$</span> training examples and <span class="math-container">$n$</span> epochs. The result was <span class="math-container">$\mathcal{O}(nt*(ij + jk + kl))$</span>.  

We assumed the simplest form of matrix multiplication that has cubic time complexity. We used batch gradient descent algorithm. The results for stochastic and mini-batch gradient descent should be same. (Let me know if you think the otherwise: note that batch gradient descent is the general form, with little modification, it becomes stochastic or mini-batch)  

Also, if you use momentum optimization, you will have same time complexity, because the extra matrix operations required are all element-wise operations, hence they will not affect the time complexity of the algorithm.  

I'm not sure what the results would be using other optimizers such as RMSprop.  

<h5>Sources</h3>

The following article <a href="http://briandolhansky.com/blog/2014/10/30/artificial-neural-networks-matrix-form-part-5" rel="nofollow noreferrer">http://briandolhansky.com/blog/2014/10/30/artificial-neural-networks-matrix-form-part-5</a> describes an implementation using matrices. Although this implementation is using "row major", the time complexity is not affected by this.  

If you're not familiar with back-propagation, check this article:  

<a href="http://briandolhansky.com/blog/2013/9/27/artificial-neural-networks-backpropagation-part-4" rel="nofollow noreferrer">http://briandolhansky.com/blog/2013/9/27/artificial-neural-networks-backpropagation-part-4</a>  

#### Answer 2 (score 2)
For the evaluation of a single pattern, you need to process all weights and all neurons. Given that every neuron has at least one weight, we can ignore them, and have <span class="math-container">$\mathcal{O}(w)$</span> where <span class="math-container">$w$</span> is the number of weights, i.e., <span class="math-container">$n * n_i$</span>, assuming full connectivity between your layers.  

The back-propagation has the same complexity as the forward evaluation (just look at the formula).  

So, the complexity for learning <span class="math-container">$m$</span> examples, where each gets repeated <span class="math-container">$e$</span> times, is <span class="math-container">$\mathcal{O}(w*m*e)$</span>.  

The bad news is that there's no formula telling you what number of epochs <span class="math-container">$e$</span> you need.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How to "combine" two images for CNN input (classification task)? (score [7547](https://stackoverflow.com/q/3288) in )

#### Question
For a classification task (I'm showing a pair of exactly two images to a CNN that should answer with 0 -> fake pair or 1 -> real pair) I am struggling to figure out how to design the input.  

At the moment the network's architecture looks like this:  

```text
image-1                       image-2
   |                             |
conv layer                    conv layer
   |                             |
   _______________ _______________
                  |
            flattened vector
                  |
          fully-connected layer
                  |
           reshape to 2D image
                  |
              conv layer
                  |
              conv layer
                  |
              conv layer
                  |
            flattened vector
                  |
                output
```

The conv layers have a `2x2` stride, thus halfing the images' dimensions. I would have used the first fully-connected layer as the first layer, but then the size of it doesn't fit in my GPU's VRAM. Thus, I have the first conv layers halfing the size of the images first, then combining the information with a fully-connected layer and then doing the actual classification with conv layers for the combined image information.  

My very first idea was to simply add the information up, like `(image-1 + image-2) / 2`...but this is not a good idea, since it heavily mixes up image information.  

The next try was to concatenate the images to have one single image of size 400x100 instead of two 200x100 images. However, the results of this approach were quite unstable. I think because in the center of the big, concatenated image convolutions would convolve information of both images (right border of `image-1` / left border of `image-2`), which again mixes up image information in not really senseful way.  

My last approach was the current architecture, simply leaving the combination of `image-1` and `image-2` up to one fully-connected layer. This works - kind of (the results show a nice convergence, but could be better).  

What is a reasonable, "state-of-the-art" way to combine two images for a CNN's input?  

I clearly can not simply increase the batch size and fit the images there, since the pairs are related to each other and this relationship would get lost if I simply feed just one image at a time and increase the batch size.  

#### Answer accepted (score 1)
You can combine the image output using concatenation. Please refer to this paper:  

<a href="http://ivpl.eecs.northwestern.edu/sites/default/files/07444187.pdf" rel="nofollow noreferrer">http://ivpl.eecs.northwestern.edu/sites/default/files/07444187.pdf</a>  

You can have a look at the Figure 2. And if you are using caffe, there is a layer called Concat layer. You can use it for your purpose.  

I am not fully clear about what you want to do. But like you said, if you want to pass the image values from the first layer to some layers. Try reading about skip architectures.  

If you want to use this network as real/fake finder, you can take the difference between two images and convert it to classification problem.  

Hope it helps.  

#### Answer 2 (score 1)
I'm not sure what you mean by pairs. But a common pattern for dealing w/ pair-wise ranking is a siamese network:  

<a href="https://i.stack.imgur.com/3zG0B.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/3zG0B.png" alt="enter image description here"></a>  

Where A and B are a a pos, negative pair and then the Feature Generation Block is a CNN architecture which outputs a feature vector for each image (cut off the softmax) and then the network tried to maximise the regression loss between the two images. The two networks share the same parameters and thus in the end you have one model which can accurately disambiguate between a positive or negative pair.  

#### Answer 3 (score 0)
<a href="https://ai.stackexchange.com/a/5187/23994]">eggie5</a> actually has a good solution for you. This approach is a tried and tested way to solve the same problem you are trying to solve.    

However, if you still want to concatenate the images and do this your way, you should <strong>concatenate the images along the channel dimension</strong>.  

For example, by combining two <span class="math-container">$200\times 100 \times c$</span> feature vectors (where c is the number of channels) you should get a single <span class="math-container">$200\times 100 \times 2c$</span> feature vector.   

<p>The kernels of the next convolution look through all the channels of the feature vector <span class="math-container">$x \times x$</span> pixels at a time.<br>
If we combine along the channel dimension, it becomes easier for the network to compare pixel values at corresponding positions in both images. Since the objective is to predict similarity or dissimilarity, this is ideal for us.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: Are the dialogs at Sophia's (the robot) appearings scripted? (score [7543](https://stackoverflow.com/q/4375) in 2018)

#### Question
I talk about the robot from: <a href="http://www.hansonrobotics.com/robot/sophia/" rel="nofollow noreferrer">Hanson Robotics</a>, which was <a href="https://techcrunch.com/2017/10/26/saudi-arabia-robot-citizen-sophia/" rel="nofollow noreferrer">granted the right to citizenship from Saudi Arabia</a>.  

I have found the following articles:  

<h5>Your new friend is a humanoid robot</h1>

source: <a href="http://www.theaustralian.com.au/life/say-hello-to-your-new-friend-sophia-the-humanoid-robot/news-story/070299a8d11b7d636848f1b8dd753530" rel="nofollow noreferrer">theaustralian.com.au</a>  

<blockquote>
  Like Amazon Echo, Google Assistant and Siri, <strong>Sophia can ask and answer questions about discrete pieces of information</strong>, such as what types of movies and songs she likes, the weather and whether robots should exterminate humans.  
  
  But her general knowledge is behind these players and she doesn’t do maths. <strong>Her answers are mostly scripted</strong> and, it seems, from my observation, her answer are derived from algorithmically crunching the language you use.  
  
  Sometimes answers are close to the topic of the question, but off beam. Sometimes she just changes the subject and asks you a question instead.  
  
  She has no artificial notion of self. <strong>She can’t say where she was yesterday, whether she remembers you from before</strong>, and doesn’t seem to amass data of past interactions with you that can form the basis of an ongoing association.  
  
  Questions such as: <em>“What have you seen in Australia?”</em>, <em>“Where were you yesterday?”</em>, <em>“Who did you meet last week?”</em> and <em>“Do you like Australia?”</em> are beyond her.  
</blockquote>

<hr>

<h5>Why Sophia the robot is not what it seems</h1>

source: <a href="http://www.smh.com.au/comment/why-sophia-the-robot-is-not-what-it-seems-20171030-gzbi3p.html" rel="nofollow noreferrer">smh.com.au</a>  

<blockquote>
  You can often fool this sort of software by introducing noise. That could be literal noise – machines aren't great at filtering out background noise, as anyone with a hearing aid will tell you – or it could be noise in the sense of irrelevant information or limited context. You could ask <strong>"what do you think of humans?"</strong> and then follow up with <strong>"can you tell more about it?"</strong> The second question requires the robot to define "it", remember what it said last time, and come up with something new.  
  
  In the case of the ABC interview, <strong>the questions were sent to Sophia's team ahead of time so they were possibly pre-scripted</strong>. Just like an interview with a human celebrity!  
</blockquote>

<hr>

<h5>Pretending to give a robot citizenship helps no one</h1>

source: <a href="https://www.theverge.com/2017/10/30/16552006/robot-rights-citizenship-saudi-arabia-sophia" rel="nofollow noreferrer">theverge.com</a>  

<blockquote>
  Sophia is essentially a cleverly built puppet designed to exploit our cultural expectations of what a robot looks and sounds like. It can hold a stilted conversation, yes, but its one-liners seem to be prewritten responses to key words. (As Piers Morgan commented during an interview with Sophia, <strong>“Obviously these are programmed answers.”</strong>)  
</blockquote>

<hr>

Updates:  

<ul>
<li><a href="https://qz.com/1121547/how-smart-is-the-first-robot-citizen/" rel="nofollow noreferrer">Inside the mechanical brain of the world’s first robot citizen</a></li>
<li><a href="https://buildabuddha.quora.com/Sophia-the-Uncanny-Robot-AI-Is-Not-What-You-Think" rel="nofollow noreferrer">Sophia, the Uncanny Robot AI, Is Not What You Think.</a></li>
<li><a href="https://www.quora.com/How-much-of-Robot-Sophia%E2%80%99s-speech-is-likely-scripted-with-your-understanding-of-the-progress-in-NLP" rel="nofollow noreferrer">How much of Robot Sophia’s speech is likely scripted with your understanding of the progress in NLP?</a></li>
</ul>

#### Answer accepted (score 11)
Sophia uses <a href="https://arxiv.org/abs/1709.07791" rel="nofollow noreferrer">ChatScript</a>.  

You can read about what ChatScript can do <a href="https://github.com/bwilcox-1234/ChatScript/blob/master/WIKI/OVERVIEWS-AND-TUTORIALS/What-is-ChatScript.md" rel="nofollow noreferrer">here</a>.  

<blockquote>
  <p>ChatScript keeps track of conversations with each user; can record
  where it is in a conversational flow and what facts it has learned
  about a user (you have to tell it what facts to try to learn). You can
  optionally keep logs of the conversations (either on a ChatScript
  server or locally on a freestanding device).</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Is it possible to train a neural network incrementally? (score [7540](https://stackoverflow.com/q/3981) in 2019)

#### Question
I would like to train a neural network where the output classes are not (all) defined from the start. More and more classes will be introduced later based on incoming data. This means that, every time I introduce a new class, I would need to retrain the NN.  

How can I train a NN incrementally, that is, without forgetting the previously acquired information during the previous training phases?  

#### Answer accepted (score 10)
I'd like to add to what's been said already that your question touches upon an important notion in machine learning called <em>transfer learning</em>. In practice, very few people train an entire convolutional network from scratch (with random initialization), because it is time consuming and relatively rare to have a dataset of sufficient size.   

Modern ConvNets take 2-3 weeks to train across multiple GPUs on ImageNet. So it is common to see people release their final ConvNet checkpoints for the benefit of others who can use the networks for fine-tuning. For example, the Caffe library has a <a href="https://github.com/BVLC/caffe/wiki/Model-Zoo" rel="noreferrer">Model Zoo</a> where people share their network weights.  

When you need a ConvNet for image recognition, no matter what your application domain is, you should consider taking an existing network, for example <a href="http://www.robots.ox.ac.uk/~vgg/research/very_deep/" rel="noreferrer">VGGNet</a> is a common choice.  

There are a few things to keep in mind when performing <em>transfer learning</em>:  

<ul>
<li><p>Constraints from pretrained models. Note that if you wish to use a pretrained network, you may be slightly constrained in terms of the architecture you can use for your new dataset. For example, you can’t arbitrarily take out Conv layers from the pretrained network. However, some changes are straight-forward: due to parameter sharing, you can easily run a pretrained network on images of different spatial size. This is clearly evident in the case of Conv/Pool layers because their forward function is independent of the input volume spatial size (as long as the strides “fit”).</p></li>
<li><p>Learning rates. It’s common to use a smaller learning rate for ConvNet weights that are being fine-tuned, in comparison to the (randomly-initialized) weights for the new linear classifier that computes the class scores of your new dataset. This is because we expect that the ConvNet weights are relatively good, so we don’t wish to distort them too quickly and too much (especially while the new Linear Classifier above them is being trained from random initialization).</p></li>
</ul>

Additional reference if you are interested in this topic: <a href="https://arxiv.org/abs/1411.1792" rel="noreferrer">How transferable are features in deep neural networks?</a>  

#### Answer 2 (score 6)
Here is one way you could do that.  

After training your network, you can save its weights to disk. This allows you to load this weights when new data becomes available and continue training pretty much from where your last training left off. However, since this new data might come with additional classes, you now do <a href="https://stats.stackexchange.com/q/193082/82135">pre-training or fine-tuning</a> on the network with weights previously saved. The only thing you have to do, at this point, is make the last layer(s) accommodate the new classes that have now been introduced with the arrival of your new dataset, most importantly include the extra classes (e.g., if your last layer initially had 10 classes, and now you have found 2 more classes, as part of your pre-training/fine-tuning, you replace it with 12 classes). In short, repeat this circle :   

<a href="https://i.stack.imgur.com/8HHw7.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/8HHw7.png" alt="Repeat"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: 1070 ti or 1060 6GB for deep learning (score [7498](https://stackoverflow.com/q/5114) in 2018)

#### Question
Before I start I want to let you know that I am completely new to the field of deep learning! Since I need a new graphics card either way (gaming you know) I am thinking about buying the GTX 1060 with 6GB or the 1070 ti with 8GB. Because I am not rich, basically I am a pretty poor student ;), I don't want to waste my money. I don't need deep learning for my studies I just want to dive into this topic because of personal interest. What I want to say is that I can wait a little bit longer and don't need the results as quick as possible.  

<p>So here is my question:
Can I do deep learning with the 1060 (6GB seem to be very limiting according to some websites) or the 1070 ti? Is the 1070 ti overkill for a person hobby deep learner?</p>

Or should I wait for the new generation Nvidia graphics card?  

Thank you very much in advance!  

#### Answer 2 (score 7)
Regarding specific choices I can't recommend, but if you are completely new, you should probably learn/code some more until you get a GPU. There is a lot to learn in machine learning before GPU speedups make a significant difference, and until then doing the computations on any old CPU would be just fine, especially if you are just starting since you won't be doing anything too complex. You will know when computational resources are your main bottleneck, and until then it shouldn't really matter too much.   

Or, you could also rent computing power from say, <a href="https://aws.amazon.com/machine-learning/amis/" rel="noreferrer">AWS</a> or <a href="https://cloud.google.com/products/" rel="noreferrer">Google</a>  

#### Answer 3 (score 5)
Given that you're a student doing this out of personal interest and wanting to do some gaming on the side, I'd suggest the GTX 1060 6GB since at present the GTX 1070Ti is overpriced due to crypto miners (this will date the answer, but for reference the 1060 is going for ~GBP340, the 1070Ti for ~GBP600; two other options are the 1050Ti 4GB for ~GBP160 or the vanilla 1080 at ~GBP650).   

<a href="http://timdettmers.com/2017/04/09/which-gpu-for-deep-learning/" rel="noreferrer">'Which GPU...'</a> by Tim Dettmers is very helpful, as is <a href="https://blog.slavv.com/picking-a-gpu-for-deep-learning-3d4795c273b9" rel="noreferrer">'Picking a GPU...'</a> by Slav Ivanov, especially the summaries at the end for different use cases. As you're not looking at spending a huge amount of money, the 1060 seems like a good compromise as the 1050Ti might just leave you with a disappointing gaming experience. Finding a used 1070 is also suggested, but you'd need to be comfortable with that.   

Other answers have mentioned the cloud, but that doesn't help with your gaming. If you want to save some cash while you're waiting for the next gen of cards, take advantage of your student status on <a href="https://aws.amazon.com/education/awseducate/" rel="noreferrer">AWS educate</a> or <a href="https://imagine.microsoft.com/en-us" rel="noreferrer">Azure on MS Imagine</a> - the <a href="https://education.github.com/pack" rel="noreferrer">GitHub student dev pack</a> is a good package.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Could a neural network detect primes? (score [7385](https://stackoverflow.com/q/3389) in 2017)

#### Question
I am not looking for an efficient way to find primes (which of course is a <a href="https://en.wikipedia.org/wiki/AKS_primality_test" rel="noreferrer">solved problem</a>). This is more of a "what if" question.   

So, in theory: Could you train a neural network to predict whether or not a given number n is composite or prime? How would such a network be laid out?  

#### Answer accepted (score 11)
Early success on prime number testing via artificial networks is presented in <a href="https://cloudfront.escholarship.org/dist/prd/content/qt5sg7n4ww/qt5sg7n4ww.pdf" rel="noreferrer"><em>A Compositional Neural-network Solution to Prime-number Testing</em>, László Egri, Thomas R. Shultz, 2006</a>.  The knowledge-based cascade-correlation (KBCC) network approach showed the most promise, although the practicality of this approach is eclipsed by other prime detection algorithms that usually begin by checking the least significant bit, immediately reducing the search by half, and then searching based other theorems and heuristics up to $floor(\sqrt{x})$.  However the work was continued with <a href="http://www.psych.mcgill.ca/perpg/fac/shultz/personal/Recent_Publications_files/kbcc06.pdf" rel="noreferrer"><em>Knowledge Based Learning with KBCC</em>, Shultz et. al. 2006</a>  

There are actually multiple sub-questions in this question.  First, let's write a more formal version of the question: "Can an artificial network of some type converge during training to a behavior that will accurately test whether the input ranging from $0$ to $2^n-1$, where $n$ is the number of bits in the integer representation, represents a prime number?"  

<ol>
<li>Can it by simply memorizing the primes over the range of integers?</li>
<li>Can it by learning to factor and apply the definition of a prime?</li>
<li>Can it by learning a known algorithm?</li>
<li>Can it by developing a novel algorithm of its own during training?</li>
</ol>

The direct answer is yes, and it has already been done according to 1. above, but it was done by over-fitting, not learning a prime number detection method.  We know the human brain contains a neural network that can accomplish 2., 3., and 4., so if artificial networks are developed to the degree most think they can be, then the answer is yes for those.  There exists no counter-proof to exclude any of them from the range of possibilities as of this answer's writing.  

It is not surprising that work has been done to train artificial networks on prime number testing because of the importance of primes in discrete mathematics, its application to cryptography, and, more specifically, to cryptanalysis.  We can identify the importance of digital network detection of prime numbers in the research and development of intelligent digital security in works like <a href="https://www.researchgate.net/profile/Michael_Vrahatis/publication/228790268_A_first_study_of_the_neural_network_approach_to_the_RSA_cryptosystem/links/0fcfd50e4b1dad4c70000000.pdf" rel="noreferrer"><em>A First Study of the Neural Network Approach in the RSA Cryptosystem</em>, G.c. Meletius et. al., 2002</a>.  The tie of cryptography to the security of our respective nations is also the reason why not all of the current research in this area will be public.  Those of us that may have the clearance and exposure can only speak of what is not classified.  

On the civilian end, ongoing work in what is called novelty detection is an important direction of research.  Those like Markos Markou and Sameer Singh are <a href="https://www.sciencedirect.com/science/article/pii/S0165168403002020" rel="noreferrer">approaching novelty detection from the signal processing side</a>, and it is obvious to those that understand that artificial networks are essentially digital signal processors that have multi-point self tuning capabilities can see how their work applies directly to this question.  Markou and Singh write, "There are a multitude of applications where novelty detection is extremely important including signal processing, computer vision, pattern recognition, data mining, and robotics."  

On the cognitive mathematics side, the development of a mathematics of surprise, such as <a href="https://infoscience.epfl.ch/record/223460/files/EPFL_TH7418.pdf" rel="noreferrer"><em>Learning with Surprise: Theory and Applications</em> (thesis), Mohammadjavad Faraji, 2016</a> may further what Ergi and Shultz began.    

#### Answer 2 (score 1)
I'm an undergraduate researcher at Prairie View A&amp;M university. I figured I would comment, because I just spent a few weeks tweaking a MLPRegressor model to predict the nth prime number. It recently stumbled into a super low minima, where the first 1000 extrapolations outside of the training data produced error less than .02 percent. Even at 300000 primes out, it was about .5 percent off. My model was simple: 10 hidden layers, trained on a single processor for less than 2 hours.  

To me, it begs the question, "Is there a reasonable function that produces the nth prime number?" Right now the algorithms become computationally very taxing for extreme n. Check out the time gaps between the most recent largest primes discovered. Some of them are years apart. I know it's been proven that if such a function exists, it will not be polynomial.   

#### Answer 3 (score 1)
I'm an undergraduate researcher at Prairie View A&amp;M university. I figured I would comment, because I just spent a few weeks tweaking a MLPRegressor model to predict the nth prime number. It recently stumbled into a super low minima, where the first 1000 extrapolations outside of the training data produced error less than .02 percent. Even at 300000 primes out, it was about .5 percent off. My model was simple: 10 hidden layers, trained on a single processor for less than 2 hours.  

To me, it begs the question, "Is there a reasonable function that produces the nth prime number?" Right now the algorithms become computationally very taxing for extreme n. Check out the time gaps between the most recent largest primes discovered. Some of them are years apart. I know it's been proven that if such a function exists, it will not be polynomial.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Applications of Bayes' Theorem (score [7301](https://stackoverflow.com/q/2738) in 2017)

#### Question
How is Bayes' Theorem used in artificial intelligence and machine learning? As an high school student I will be writing an essay about it, and I want to be able to explain Bayes' Theorem, its general use, and how it is used in AI or ML.  

#### Answer 2 (score 3)
<p>Bayes theorem states the probability of some event B occurring provided the prior knowledge of another event(s) A, given that B is dependent on event A (even partially).<br>
A real-world application example will be weather forecasting. Naive Bayes is a powerful algorithm for predictive modelling weather forecast. The temperature of a place is dependent on the pressure at that place, percentage of the humidity, speed and direction of the wind, previous records on temperature, turbulence on different atmospheric layers, and many other things. So when you have certain kind of data, you process them certain kind of algorithms to predict one particular result (or the future). The algorithms employed rely heavily on Bayesian network and the theorem.<br><br>
The given paragraph is introduction to Bayesian networks, given in the book, Artificial Intelligence – A Modern Approach:<br></p>

<blockquote>
  Bayesian network formalism was invented to allow efficient representation of, and rigorous reasoning with, uncertain knowledge. This approach largely overcomes many problems of the probabilistic reasoning systems to the 1960s and 70s; it now dominates AI research on uncertain reasoning and expert systems. The approach allows for learning from experience, and it combines the best of classical AI and neural nets.  
</blockquote>

<p><br>There are many other applications, especially in medical science. Like predicting a particular disease based on the symptoms and physical condition of the patient. There are many algorithms currently in use that are based on this theorem, like binary and multi-class classifier, for example, email spam filters.
There are many things in this topic.I have added some links below that might help, and let me know if you need any kind of other help.</p>

<p>Helpful Links<br>
 1. <a href="http://machinelearningmastery.com/naive-bayes-for-machine-learning/" rel="nofollow noreferrer">First</a><br>
 2. <a href="https://en.wikipedia.org/wiki/Naive_Bayes_classifier" rel="nofollow noreferrer">Second</a></p>

#### Answer 3 (score 2)
<p>It helps in improving the efficiency in solving real world problems. When Air France flight disappeared in Atlantic Ocean in 2009 then Scientists developed a Bayesian model to predict the location of the plane. The model took in factors such as the expected flight plan, weather, ocean currents and other external factors. The model then mapped a probability to a 50 mile radius around the expected crash zone. Each point within the 50 mile circle was assigned a probability of the plane being located there. The he model used a large data set of information that was updated continuously as the search team entered results everyday after search a specific location. Within days of implementing this model, the plane was found. This shows how statistical models and theory can help improve efficiency in solving real world problems.
<a href="http://blogs.cornell.edu/info2040/2015/11/20/bayes-theorem-a-real-world-application/" rel="nofollow noreferrer">Link for article</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: What is the difference between an agent function and an agent program? (score [7101](https://stackoverflow.com/q/1756) in 2019)

#### Question
What is the difference between an agent function and an agent program (with respect to the percept sequence)?  

In the book <em>"Artificial Intelligence: A modern approach"</em>,  

<blockquote>
  <p>The agent function, notionally speaking, takes as input the entire
  percept sequence up to that point, whereas the agent program takes the
  current percept only.</p>
</blockquote>

Why does the agent program only take current percept. Isn't the agent program just an implementation of the agent function?  

#### Answer 2 (score 6)
It looks as if 'function' is being used here in the mathematical (or functional programming) sense of 'pure function', i.e. it is without state or side-effects. Hence the function cannot store previous percepts anywhere, so the entire historical percept sequence is considered to be passed to the function each time.  

In contrast, the notion of 'program' appears to allow state/side-effects, so it is assumed that earlier percepts are memoized as needed (or that they otherwise updated the variables used within the program).  

The 'function' notion is the conceptually cleaner one, in that the 'program' version can always be abstracted to the functional one. Which aspects of percept history happen to be cached by the 'program' version is merely an implementation detail.  

#### Answer 3 (score -2)
<blockquote>
  The agent function is an abstract mathematical description; the agent program is a concrete implementation, running within some physical system.  
</blockquote>

<p>Artificial Intelligence
Stuart Russell; Peter Norvig; Stuart J. Russell</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: Concatenate convolution layers with different strides in tensorflow. (score [7085](https://stackoverflow.com/q/2932) in )

#### Question
I am trying to do an inception layer, but it only works if the convolution strides, pool strides and pool size are the same, otherwise I get an error in   

<blockquote>
  tf.concat  
</blockquote>

that Dimesion 1 is not the same. So If I change something in the last three tuples, I get the error.  

```text
conv1 = conv2d_maxpool(x, 64, (5, 5), (1, 1), (2, 2), (2, 2)) 
conv2 = conv2d_maxpool(x, 64, (4, 4), (1, 1), (2, 2), (2, 2)) 
conv3 = conv2d_maxpool(x, 32, (2, 2), (1, 1), (2, 2), (2, 2)) 
conv4 = conv2d_maxpool(x, 32, (1, 1), (1, 1), (2, 2), (2, 2)) 
conv = tf.concat([conv1, conv2, conv3, conv4], 3)
```

For example, this is the error I get if I change the 5x5 filter to have strides 3:  

```text
conv1 = conv2d_maxpool(x, 64, (5, 5), (3, 3), (2, 2), (2, 2))
```

<blockquote>
  <p>Dimension 1 in both shapes must be equal, but are 6 and 16 for
  'concat' (op: 'ConcatV2') with input shapes: [?,6,6,64], [?,16,16,64],
  [?,16,16,32], [?,16,16,32], [].</p>
</blockquote>

This is the conv2d_maxpool function:  

```text
def conv2d_maxpool(x_tensor, conv_num_outputs, conv_ksize, conv_strides, pool_ksize, pool_strides):
    """
    Apply convolution then max pooling to x_tensor
    :param x_tensor: TensorFlow Tensor
    :param conv_num_outputs: Number of outputs for the convolutional layer
    :param conv_strides: Stride 2-D Tuple for convolution
    :param pool_ksize: kernal size 2-D Tuple for pool
    :param pool_strides: Stride 2-D Tuple for pool
    : return: A tensor that represents convolution and max pooling of x_tensor
    """
    # TODO: Implement Function
    weights = tf.Variable(tf.truncated_normal(
        shape = [*conv_ksize, int(x_tensor.get_shape().dims[3]), conv_num_outputs], 
        mean = 0.0, 
        stddev=0.1, 
        dtype=tf.float32))
    bias = tf.Variable(tf.zeros(conv_num_outputs)) 

    conv_layer = tf.nn.conv2d(x_tensor, weights, strides=[1, *conv_strides, 1], padding='SAME')
    conv_layer = tf.nn.bias_add(conv_layer, bias)
    conv_layer = tf.nn.relu(conv_layer)

    conv_layer_max_pool = tf.nn.max_pool(conv_layer, ksize=[1, *pool_ksize, 1], strides=[1, *pool_strides, 1], padding='SAME')

    return conv_layer_max_pool
```

How can I combine convolution filters with different strides and/or different pooling to create an inception layer?  

#### Answer accepted (score 1)
<blockquote>
  Dimension 1 in both shapes must be equal, but are 6 and 16 for 'concat' (op: 'ConcatV2') with input shapes: [?,6,6,64], [?,16,16,64], [?,16,16,32], [?,16,16,32], [].  
</blockquote>

Pablo's answer is correct. Your problem is that the convolved images (output of conv-layers) must match in spatial dimensionality in order to concatenate them. This makes perfectly sense, because how would you combine images of shape 6x6 with images of shape 16x16? You can not.  

Either you have to ensure that the convolutions produce output of equal spatial dimenions, i.e. using the same padding and strides strategy or you have to use `tf.image.resize_images` to down-/upscale the different output to the same spatial dimensionality (or some other down-/upscaling strategy).  

#### Answer 2 (score 2)
Not 100% sure, but the problem is that when you work with different strides, the size of the convolved image change, so you should ensure, that all the convolved images have the same shape before concatenating the output. You can fill with 0s, or considering that the image is periodical in time, so filling with reflections of the image  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: How to train a neural network for a round based board game? (score [6955](https://stackoverflow.com/q/3345) in )

#### Question
<p>I'm wondering how to train a neural network for a round based board game like, tic-tac-toe, chess, risk or any other round based game.
Getting the next move by inference seems to be pretty straight forward, by feeding the game state as input and using the output as the move for the current player.
However training an AI for that purpose doesn't appear to be that straight forward, because:</p>

<ol>
<li>There might not be a rating if a single move is good or not, so training of single moves doesn't seem to be the right choice</li>
<li>Using all game states (inputs) and moves (outputs) of the whole game to train the neural network, doesn't seem to be the right choice as not all moves within a lost game might be bad</li>
</ol>

<p>So I'm wondering how to train a neural network for a round based board game?
I would like to create a neural network for tic-tac-toe using tensorflow.</p>

#### Answer 2 (score 10)
Great question!  NN is very promising for this type of problem: <a href="https://arxiv.org/pdf/1509.01549.pdf" rel="nofollow noreferrer">Giraffe Chess</a>.  Lai's accomplishment <a href="https://www.technologyreview.com/s/541276/deep-learning-machine-teaches-itself-chess-in-72-hours-plays-at-international-master/" rel="nofollow noreferrer">was considered to be a pretty big deal</a>, but unfortunately came just a few months before AlphaGo took the spotlight. <em>(It all turned out well, in that Lai was subsequently hired by DeepMind, <a href="https://motherboard.vice.com/en_us/article/the-chess-engine-that-died-so-alphago-could-live-giraffe-matthew-lai" rel="nofollow noreferrer">although not so well for the Giraffe engine</a>;)</em>  

I've found Lai's approach to be quite helpful, and it is backed by solid results.  

<hr>

You may want to use "<a href="https://en.wikipedia.org/wiki/Sequential_game" rel="nofollow noreferrer">sequential</a>" as opposed to "round based" since sequential is the preferred term in <a href="https://en.wikipedia.org/wiki/Game_theory" rel="nofollow noreferrer">Game Theory</a> and <a href="https://en.wikipedia.org/wiki/Combinatorial_game_theory" rel="nofollow noreferrer">Combinatorial Game Theory</a>, and these are the fields that apply mathematical analysis to games.   

The games you list are further termed "<a href="https://en.wikipedia.org/wiki/Abstract_strategy_game" rel="nofollow noreferrer">abstract</a>" to distinguish them from modern strategy boardgames, or games in general, which utilize a strong theme and are generally less compact than abstract games in terms of mechanics and elements. This carries the caveat that abstract games are not restricted to sequential games or boardgames, or even games specifically, as in the case of puzzles like Sudoku.  

The formal name for this group of games is generally "<a href="https://en.wikipedia.org/wiki/Partisan_game" rel="nofollow noreferrer">partisan</a>, sequential, <a href="http://library.msri.org/books/Book29/contents.html" rel="nofollow noreferrer">deterministic</a>, <a href="https://en.wikipedia.org/wiki/Perfect_information#Examples" rel="nofollow noreferrer">perfect information</a>" with the further categorization of Tic-Tac-Toe as "trivial" (solved and easily solvable) and non-trivial (intractable and unsolved) for games like Chess and Go.   

#### Answer 3 (score 7)
I'm a chess player and my answer will be only on chess.  

Training a neutral network with reinforcement learning isn't new, it has been done many times in the literature.  

I'll briefly explain the common strategies.  

<ul>
<li><p>The purpose of a network is to learn <strong>position evaluation.</strong> We all know a queen is stronger than a bishop, but can we make the network know about it without explicitly programming? What about pawn structure? Does the network understand how to evaluate whether a position is winning or not?</p></li>
<li><p>Now, we know why we need the network, we'll need to design it. The design differs radically between studies. Before deep learning was popular, people were using shallow network. Nowadays, a network with many layers stands out.</p></li>
<li><p>Once we have the network, you'll need to make a chess engine. Neural network can't magically play chess by itself, it needs to connect to a chess engine. Fortunately, we don't need to write position evaluation code because the network can do that for us.</p></li>
<li><p>Now, we have to play games. We could start with some high quality chess databases or instead have our AI agent play games with another player (e.g. itself, another AI agent, or a human). This is known as <strong>reinforcement learning</strong>.</p></li>
<li><p>While we play games, we update the network parameter. This can be done by stochastic gradient descent (or other similar techniques). We repeat our training as long as we want, usually over millions of iterations.</p></li>
<li><p>Finally, we have a trained neutral network model for chess!</p></li>
</ul>

Look at the following resources for details:  

<blockquote>
  <a href="https://chessprogramming.wikispaces.com/Learning" rel="nofollow noreferrer">https://chessprogramming.wikispaces.com/Learning</a>  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Convolutional neural networks with input images of different dimensions - Image segmentation (score [6869](https://stackoverflow.com/q/6274) in )

#### Question
I'm facing the problem of having images of different dimensions as inputs in a segmentation task. Note that the images do not even have the same aspect ratio.  

One common approach that I found in general in deep learning is to crop the images, as it is also suggested <a href="https://datascience.stackexchange.com/questions/16601/reason-for-square-images-for-deep-learning"><strong>here</strong></a>. However, in my case I cannot crop the image and keep its center or something similar since in segmentation I want the output to be of the same dimensions as the input.  

<a href="https://pdfs.semanticscholar.org/d65b/cb276bc6fc9445a78fe26de76a43e09ccd27.pdf" rel="noreferrer"><strong>This</strong></a> paper suggests that in a segmentation task one can feed the same image multiple times to the network but with a different scale and then aggregate the results. If I understand this approach correctly, it would only work if all the input images have the same aspect ratio. Please correct me if I am wrong.  

Another alternative would be to just resize each image to fixed dimensions. I think this was also proposed by the answer to <a href="https://ai.stackexchange.com/questions/2403/dataset-containing-images-of-varying-dimensions-and-orientations"><strong>this</strong></a> question. However, it is not specified in what way images are resized.  

I considered taking the maximum width and height in the dataset and resizing all the images to that fixed size in an attempt to avoid information loss. However, I believe that our network might have difficulties with distorted images as the edges in an image might not be clear. What is possibly the best way to resize your images before feeding them to the network?  

Is there any other option that I am not aware of for solving the problem of having images of different dimensions?  

Also, which of these approaches you think is the best taking into account the computational complexity but also the possible loss of performance by the network?   

I would appreciate if the answers to my questions include some link to a source if there is one. Thank you.  

#### Answer 2 (score 2)
Assuming you have a large dataset, and it's labeled pixel-wise, one hacky way to solve the issue is to preprocess the images to have same dimensions by inserting horizontal and vertical margins according to your desired dimensions, as for labels you add dummy extra output for the margin pixels so when calculating the loss you could mask the margins.  

#### Answer 3 (score 2)
Assuming you have a large dataset, and it's labeled pixel-wise, one hacky way to solve the issue is to preprocess the images to have same dimensions by inserting horizontal and vertical margins according to your desired dimensions, as for labels you add dummy extra output for the margin pixels so when calculating the loss you could mask the margins.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: C# or Python for AI? (score [6771](https://stackoverflow.com/q/8227) in )

#### Question
<p>So guys, I've been seeing a lot of tutorials on the Internet about AI that are mostly done with Python. Apart from these, I've seen C# being used in AI topics but in things like for example "Self-Driving cars", I've seen Python and not C# or any other languages. I wanted to ask, do you recommend that I learn Python? Because I know C# and I wanted to become more professional in it, but, now that I see that Python is being used a lot, I'm getting intrigued in it. Do you recommend Python or other languages or should I keep up with C#?
Just to mention, I'm 14 years old and I have enough time to learn more and it doesn't really matter what I love to do, because, I love coding and AI specially, so, it doesn't really matter. If it's not a waste of time, I should get started, right? If you recommend Python, please tell me which compiler I should use. I don't really know if it has a compiler, but I want to know where I should start from. Thanks.</p>

#### Answer accepted (score 6)
If you're doing deep learning (which I assume you are, if you say you want to learn "AI"), then Python is a MUST. Virtually all the big frameworks are Python wrappers over a C++ core.  

C# has no real deep learning frameworks. There are a couple such as the Microsoft Cognitive Toolkit, but they are on a completely different level from PyTorch or Tensorflow. No serious ML practitioner would do the majority of their research in a framework like that.  

For more information, see: <a href="https://ai.stackexchange.com/questions/3494/why-is-python-the-most-popular-language-in-the-ai-field/3503#3503">Why is Python the most popular language in the AI field?</a>  

#### Answer 2 (score 5)
Corporations, government research, and academia are favoring C, Python, Java, LISP, and R currently.  The trends are not favorable to C# for AI.  

C#'s peak of use was in the 2009 to 2012 range.  By buying GitHub, Microsoft intends to regain some control over development tools and language but has never been particularly successful in either.  Even eclipse is giving way to other open tools or proprietary tools with community versions, and JavaScript and Python are the languages gaining popularity in this decade.  It is not clear whether C# will be very well known as a general purpose programming in ten years.   

C/C++, Java, and JavaScript have stood the test of time.  C/C++ is the language of choice for low level access to dedicated hardware, which is what it was designed by Bell Labs to do.  Java is almost as fast and still very popular, strongly OO, still developing, and with Scala, Groovy, Maven, and Gradle, looking strong for the future.  

Python started slow but has seen continuous rapid growth trend for the last two years because of its MATLAB-ish-ness and syntactic clarity.  JavaScript, with its heavy influence from LISP and Scheme from the birth of AI, will likely enter in greater strength as AI reaches the front end and middle tiers of web applications.  

C# doesn't look hopeful for keep pace.  

#### Answer 3 (score 2)
I agree with Felicity's answer, except the part where he says that "C# doesn't look hopeful for keep pace."  

There are new frameworks such as ML.Net being developed right now and the new version of C# (C# 7.0-8.0) focus on performance while keeping simplicity. I cannot find the link right now, but there was a post on their GitHub explaining their new vision. By the way, the .Net Core performance is really close to C++. For these reasons, I think C# is a language that will be more and more popular within the next years in the AI industry.   

The downside of using C# is that you really need to know the language deeply in order to take full advantage of it. Personally, it took me ~2 years of full-time work to be really good at it while Python only took me two weeks. I think many people in the AI industry doesn't want to spend too much time on learning an language, so they prefer to opt for Python. <strong>But for references, C# is actually MUCH FASTER than Python as of February 4th, 2019.</strong>  

<ul>
<li>Python vs Java (Python loses in every test): <a href="https://benchmarksgame-team.pages.debian.net/benchmarksgame/faster/python.html" rel="nofollow noreferrer">https://benchmarksgame-team.pages.debian.net/benchmarksgame/faster/python.html</a></li>
<li>.Net Core (C#) vs Java (C# wins in every tests): <a href="https://benchmarksgame-team.pages.debian.net/benchmarksgame/faster/csharp.html" rel="nofollow noreferrer">https://benchmarksgame-team.pages.debian.net/benchmarksgame/faster/csharp.html</a></li>
<li>.Net Core (C#) vs C++ (C# loses in every tests, but not by much): <a href="https://benchmarksgame-team.pages.debian.net/benchmarksgame/faster/csharpcore-gpp.html" rel="nofollow noreferrer">https://benchmarksgame-team.pages.debian.net/benchmarksgame/faster/csharpcore-gpp.html</a></li>
<li>.Net Core 2.0 (2.1 is faster) vs other languages in Amazon Lambda: <a href="https://read.acloud.guru/comparing-aws-lambda-performance-of-node-js-python-java-c-and-go-29c1163c2581" rel="nofollow noreferrer">https://read.acloud.guru/comparing-aws-lambda-performance-of-node-js-python-java-c-and-go-29c1163c2581</a></li>
</ul>

Also, I have developed in both languages, and I have found that it is much easier to develop good development practices using C# development tools than Python (this is a personal opinion - it's not a fact)  

Choosing a language for AI development really depends on multiples factors, so giving a general answer here is difficult.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: What is the difference between tree search and graph search? (score [6741](https://stackoverflow.com/q/6426) in 2019)

#### Question
I have read various answers to this question at different places, but I am still missing something.   

What I have understood is that a Graph search holds a closed list, with all expanded nodes, so they don't get explored again. However, if you apply breadth-first-search or uniformed-cost search at a search tree, you do the same. You have to keep the expanded nodes in memory.   

#### Answer 2 (score 6)
Strictly speaking they're the same: a <a href="https://freefeast.info/difference-between/difference-between-trees-and-graphs-trees-vs-graphs/" rel="noreferrer">tree is a graph</a>, but one which among other criteria is minimally connected (only one path between any two nodes) and acyclic (ie no loops).  

So, for searching, algorithms operating on trees can make a certain set of assumptions which allow optimisations not possible on a generalised graph. For example, for tree traversal you know you will visit each node only once (due to the minimal connectivity), but for other graphs you need to keep track of visited nodes if you don't want to process them multiple times (as there could be multiple paths leading to the same nodes).  

#### Answer 3 (score 0)
There is always a lot of confusion about this concept. (And the naming does not help!). The other answers present so far are not correct.  

Firstly, we have to understand that the underlying problem (or search space) is almost always represented as a graph. So, the difference is not whether the problem is a tree (a special kind of graph), or a general graph!  

The distinction instead is how we are traversing to search for our goal state. It also includes whether we are using a list or array (often called the <em>closed list</em>) or not.  

So, the basic <strong>differences</strong> are  

<ol>
<li><p>If doing graph search, keep a "closed" list, that is, a list of nodes where the search has been completed. </p></li>
<li><p>If doing a tree search, we don't keep this closed list.</p></li>
</ol>

The <strong>advantage</strong> of graph search obviously is that if we finish the search of a node, we will never search it again, while we may do so in tree search. The <strong>disadvantage</strong> of graph search is that it uses more memory, which we may or may not have.  

So, there is a <strong>trade-off</strong> between space and time when using graph search as opposed to tree search (or vice-versa).  

Now, about the naming.  

Graph Search is called graph search, because when we observe the traversal structure, we observe a GRAPH, that this node leads us to the other node that we saw before, etc, etc.  

Tree search is called a tree search, because when we observe the traversal structure, we observe a TREE.  We observe a tree, even if the underlying problem structure is a graph.  This is because when we observe a node, we have no recollection of having seen it earlier, we don't store that list, etc.  So, the same node in the underlying problem structure can appear as multiple times (as different nodes) of the tree.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Computationally expensive AI techniques (that are promising) (score [6741](https://stackoverflow.com/q/15986) in 2019)

#### Question
To produce tangible results in the field of ML/AI, one must take theoretical results under the lens of computational complexity.   

Indeed, minimax effectively solves any two-person "board game" with win/loss conditions, but the algorithm quickly becomes untenable for games of large enough size, so it's practically useless asides from toy problems.  

In fact, this issue seems to cut at the heart of intelligence itself: the Frame Problem highlights this by observing that any "intelligent" agent that operates under logical axioms must somehow deal with the explosive growth of computational complexity.  

So we need to deal with computational complexity: but that doesn't mean researchers must limit themselves with practical concerns. In the past, multilayered perceptrons were thought to be intractable (I think), and thus we couldn't evaluate their utility until recently. I've heard that Bayesian techniques are conceptually elegant, but they become computationally intractable once your dataset becomes large, and thus we usually use variational methods to compute the posterior, instead of naively using the exact solution.  

I'm looking for more examples like this: What are examples of "neat" ideas in ML/AI that are impracticable due to computational intractability?  

#### Answer 2 (score 14)
<a href="https://ai.stackexchange.com/a/10377/2444">AIXI</a> is a Bayesian, non-Markov, reinforcement learning and artificial general intelligence agent that is <a href="https://en.wikipedia.org/wiki/Computable_function#Uncomputable_functions_and_unsolvable_problems" rel="noreferrer">incomputable</a>, given the involved <a href="https://en.wikipedia.org/wiki/Kolmogorov_complexity#Uncomputability_of_Kolmogorov_complexity" rel="noreferrer">incomputable Kolmogorov complexity</a>. However, there are approximations of AIXI, such as AIXItl, described in <a href="http://hutter1.net/ai/uaibook.htm" rel="noreferrer">Universal Artificial Intelligence:  Universal Artificial Intelligence: Sequential Decisions based on Algorithmic Probability</a> (2005), by Marcus Hutter (the original author of AIXI), and <a href="https://arxiv.org/abs/0909.0801" rel="noreferrer">MC-AIXI-CTW</a> (which stands for Monte Carlo AIXI Context-Tree Weighting). Here is a Python implementation of MC-AIXI-CTW: <a href="https://github.com/gkassel/pyaixi" rel="noreferrer">https://github.com/gkassel/pyaixi</a>.  

#### Answer 3 (score 11)
To be concrete, <em>exact</em> Bayesian inference is (often) intractable (that is, not polynomially computable) because it involves the computation of an integral over a range of real (or even floating-point) numbers, which is not a polynomial-time operation. More precisely, for example, if you want to find the parameters <span class="math-container">$\mathbf{\theta} \in \Theta$</span> of a model given some data <span class="math-container">$D$</span>, then <a href="https://en.wikipedia.org/wiki/Bayesian_inference" rel="nofollow noreferrer">Bayesian inference is just the application of the Bayes' theorem</a>  

<p><span class="math-container">\begin{align}
p(\mathbf{\theta} \mid D) 
&amp;= \frac{p(D \mid \mathbf{\theta}) p(\mathbf{\theta})}{p(D)} \\
&amp;= \frac{p(D \mid \mathbf{\theta}) p(\mathbf{\theta})}{\int_{\Theta} p(D \mid \mathbf{\theta}^\prime) p(\mathbf{\theta}^\prime) d \mathbf{\theta}^\prime} \\
&amp;= \frac{p(D \mid \mathbf{\theta}) p(\mathbf{\theta})}{\int_{\Theta} p(D, \mathbf{\theta}^\prime) d \mathbf{\theta}^\prime } \tag{1}\label{1}
\end{align}</span></p>

where <span class="math-container">$p(\mathbf{\theta} \mid D)$</span> is the posterior (which is what you want to find or compute), <span class="math-container">$p(D \mid \mathbf{\theta})$</span> is the likelihood of your data given the (fixed) parameters <span class="math-container">$\mathbf{\theta}$</span>, <span class="math-container">$p(\mathbf{\theta})$</span> is the prior and <span class="math-container">$p(D) = \int_{\Theta} p(D \mid \mathbf{\theta}^\prime) p(\mathbf{\theta}^\prime) d \mathbf{\theta}^\prime$</span> is the evidence of the data (which is an integral given that <span class="math-container">$\mathbf{\theta}$</span> is assumed to be a continuous random variable), which is intractable because the integral is over all possible values of <span class="math-container">$\mathbf{\theta}$</span>, that is, <span class="math-container">${\Theta}$</span>. If all terms in \ref{1} were tractable (polynomially computable), then, given more data <span class="math-container">$D$</span>, you could iteratively keep on updating your posterior (which becomes your prior on the next iteration), and exact Bayesian inference would become tractable.  

The <a href="https://en.wikipedia.org/wiki/Variational_Bayesian_methods" rel="nofollow noreferrer">variational Bayesian approach</a> casts the problem of inferring <span class="math-container">$p(\mathbf{\theta} \mid D)$</span> (which requires the computation of the intractable <em>evidence</em> term) as an optimization problem, which <em>approximately</em> finds the posterior, more precisely, it approximates the intractable posterior, <span class="math-container">$p(\mathbf{\theta} \mid D)$</span>, with a tractable one, <span class="math-container">$q(\mathbf{\theta} \mid D)$</span> (the <em>variational distribution</em>). For example, the important <a href="https://arxiv.org/abs/1312.6114" rel="nofollow noreferrer">variational auto-encoder (VAEs)</a> paper (which did not introduce the variational Bayesian approach) uses the variational Bayesian approach to approximate a posterior in the context of neural networks (that represent distributions), so that existing machine (or deep) learning techniques (that is, gradient descent with back-propagation) can be used to learn the parameters of a model.   

The variational Bayesian approach (VBA) becomes always more appealing in machine learning. For example, <a href="https://arxiv.org/abs/1505.05424" rel="nofollow noreferrer">Bayesian neural networks</a> (which can partially solve some of the inherent problems of non-Bayesian neural networks) are usually inspired by the results reported in <a href="https://arxiv.org/abs/1312.6114" rel="nofollow noreferrer">the VAE paper</a>, which shows the feasibility of the VBA in the context of deep learning.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How to classify data which is spiral in shape? (score [6695](https://stackoverflow.com/q/1987) in 2016)

#### Question
I have been messing around in <a href="http://playground.tensorflow.org/#activation=tanh&amp;batchSize=10&amp;dataset=spiral&amp;regDataset=reg-plane&amp;learningRate=0.03&amp;regularizationRate=0&amp;noise=0&amp;networkShape=4,2&amp;seed=0.73263&amp;showTestData=false&amp;discretize=false&amp;percTrainData=50&amp;x=true&amp;y=true&amp;xTimesY=false&amp;xSquared=false&amp;ySquared=false&amp;cosX=false&amp;sinX=false&amp;cosY=false&amp;sinY=false&amp;collectStats=false&amp;problem=classification&amp;initZero=false&amp;hideText=false" rel="noreferrer">tensorflow playground</a>. One of the input data sets is a spiral. No matter what input parameters I choose, no matter how wide and deep the neural network I make, I cannot fit the spiral. How do data scientists fit data of this shape?  

#### Answer accepted (score 10)
There are many approaches to this kind of problem. The most obvious one is to <strong>create new features</strong>. The best features I can come up with is to transform the coordinates to <a href="https://en.wikipedia.org/wiki/Spherical_coordinate_system" rel="noreferrer">spherical coordinates</a>.   

I have not found a way to do it in playground, so I just created a few features that should help with this (sin features). After <a href="http://playground.tensorflow.org/#activation=tanh&amp;batchSize=10&amp;dataset=spiral&amp;regDataset=reg-plane&amp;learningRate=0.03&amp;regularizationRate=0&amp;noise=0&amp;networkShape=4,2&amp;seed=0.73263&amp;showTestData=false&amp;discretize=false&amp;percTrainData=50&amp;x=true&amp;y=true&amp;xTimesY=false&amp;xSquared=false&amp;ySquared=false&amp;cosX=false&amp;sinX=true&amp;cosY=false&amp;sinY=true&amp;collectStats=false&amp;problem=classification&amp;initZero=false&amp;hideText=false" rel="noreferrer">500 iterations</a> it will saturate and will fluctuate at 0.1 score. This suggest that no further improvement will be done and most probably I should make the hidden layer wider or add another layer.  

Not a surprise that after adding <a href="http://playground.tensorflow.org/#activation=tanh&amp;batchSize=10&amp;dataset=spiral&amp;regDataset=reg-plane&amp;learningRate=0.03&amp;regularizationRate=0&amp;noise=0&amp;networkShape=5,2&amp;seed=0.73263&amp;showTestData=false&amp;discretize=false&amp;percTrainData=50&amp;x=true&amp;y=true&amp;xTimesY=false&amp;xSquared=false&amp;ySquared=false&amp;cosX=false&amp;sinX=true&amp;cosY=false&amp;sinY=true&amp;collectStats=false&amp;problem=classification&amp;initZero=false&amp;hideText=false" rel="noreferrer">just one neuron to the hidden layer</a> you easily get 0.013 after 300 iterations. Similar thing happens by adding a new layer (0.017, but after significantly longer 500 iterations. Also no surprise as it is harder to propagate the errors). Most probably you can play with a learning rate or do an adaptive learning to make it faster, but this is not the point here.  

<a href="https://i.stack.imgur.com/tck2s.png" rel="noreferrer"><img src="https://i.stack.imgur.com/tck2s.png" alt="enter image description here"></a>  

#### Answer 2 (score 4)
Ideally neural networks should be able to find out the function out on it's own without us providing the spherical features. After some experimentation I was able to reach a configuration where we do not need anything except <span class="math-container">$X_1$</span> and <span class="math-container">$X_2$</span>. This net converged after about 1500 epochs which is quite long. So the best way might still be to add additional features but I am just trying to say that it is still possible to converge without them.  

<img src="https://i.stack.imgur.com/saZat.jpg" alt="Solution without additional features">  

#### Answer 3 (score 1)
By cheating... `theta` is <span class="math-container">$\arctan(y,x)$</span>, <span class="math-container">$r$</span> is <span class="math-container">$\sqrt{(x^2 + y^2)}$</span>.  

In theory, <span class="math-container">$x^2$</span> and <span class="math-container">$y^2$</span> should work, but, in practice, they somehow failed, even though, occasionally, it works.  

<a href="https://i.stack.imgur.com/mT4Nc.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/mT4Nc.png" alt="enter image description here"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Can LSTM Nets be speed up by GPU? (score [6692](https://stackoverflow.com/q/7090) in 2018)

#### Question
I am training LSTM Nets with Keras on a small mobile GPU. The speed on GPU is slower then on CPU. I found some articles that say that it is hard to train LSTMs (RNNs) on GPUs because the training cannot be parallelized.  

What is your experience? Is LSTM training on large GPUs like 1080 Ti faster then on CPU?  

#### Answer accepted (score 3)
<p>I found that there are cuDNN accelerated cells in Keras for example: <a href="https://keras.io/layers/recurrent/#cudnnlstm" rel="nofollow noreferrer">https://keras.io/layers/recurrent/#cudnnlstm</a>
They very fast. The normal LSTM cells are faster on CPU then on GPU.
Also see here for a comparisem: <a href="https://wiki.eniak.de/ml/geschwindigkeitsvergleich_keras_lstm_und_cudnnlstm" rel="nofollow noreferrer">https://wiki.eniak.de/ml/geschwindigkeitsvergleich_keras_lstm_und_cudnnlstm</a></p>

#### Answer 2 (score 7)
From nvidia www (<a href="https://developer.nvidia.com/discover/lstm" rel="noreferrer">https://developer.nvidia.com/discover/lstm</a>):  

<strong>Accelerating Long Short-Term Memory using GPUs</strong>  

The parallel processing capabilities of GPUs can accelerate the LSTM training and inference processes. GPUs are the de-facto standard for LSTM usage and deliver a 6x speedup during training and <strong>140x higher throughput during inference when compared to CPU implementations</strong>. cuDNN is a GPU-accelerated deep neural network library that supports training of LSTM recurrent neural networks for sequence learning. TensorRT is a deep learning model optimizer and runtime that supports inference of LSTM recurrent neural networks on GPUs. Both cuDNN and TensorRT are part of the NVIDIA Deep Learning SDK.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Are there any applications of reinforcement learning other than games? (score [6514](https://stackoverflow.com/q/3502) in 2018)

#### Question
Is there a way to teach reinforcement learning in applications other than games?   

The only examples I can find on the Internet are of game agents. I understand that VNC's control the input to the games via the reinforcement network. Is it possible to set this up with say a CAD software?  

#### Answer 2 (score 2)
One of the cool examples of reinforcement learning is an autonomous flying helicopter. I had a chance to learn some of the stuff done by Andrew Ng and others recently. Here is the research article <a href="https://people.eecs.berkeley.edu/~jordan/papers/ng-etal03.pdf" rel="nofollow noreferrer">paper</a>. There are other similar papers too. You can google them if you want to learn more.  

You can also see it in action in <a href="https://www.youtube.com/watch?v=VCdxqn0fcnE" rel="nofollow noreferrer">in this youtube video</a>.  

Here is another completely different application <a href="https://www.marutitech.com/businesses-reinforcement-learning/" rel="nofollow noreferrer">in finance apparently.</a>  

#### Answer 3 (score 2)
One of the cool examples of reinforcement learning is an autonomous flying helicopter. I had a chance to learn some of the stuff done by Andrew Ng and others recently. Here is the research article <a href="https://people.eecs.berkeley.edu/~jordan/papers/ng-etal03.pdf" rel="nofollow noreferrer">paper</a>. There are other similar papers too. You can google them if you want to learn more.  

You can also see it in action in <a href="https://www.youtube.com/watch?v=VCdxqn0fcnE" rel="nofollow noreferrer">in this youtube video</a>.  

Here is another completely different application <a href="https://www.marutitech.com/businesses-reinforcement-learning/" rel="nofollow noreferrer">in finance apparently.</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: What is the purpose of an activation function in neural networks? (score [6481](https://stackoverflow.com/q/5493) in 2019)

#### Question
It is said that activation functions in neural networks help introduce <strong><em>non-linearity</em></strong>.  

<ul>
<li>What does this mean?</li>
<li>What does <strong><em>non-linearity</em></strong> mean in this context?</li>
<li>How does the introduction of this <strong><em>non-linearity</em></strong> help?</li>
<li>Are there any other purposes of <strong><em>activation functions</em></strong>?</li>
</ul>

#### Answer accepted (score 11)
Almost all of the functionalities provided by the non-linear activation functions are given by other answers. Let me sum them up:  

<ul>
<li>First, what does non-linearity mean? It means something (a function in this case) which is not linear with respect to a given variable/variables i.e. $f(c1.x1 + c2.x2...cn.xn + b) != c1.f(x1) + c2.f(x2) ... cn.f(xn) + b.$ `</li>
<li>What does non-linearity mean in this context? It means that the Neural Network can successfully approximate functions (up-to a certain error $e$ decided by the user) which does not follow linearity or it can successfully predict the class of a function which is divided by a decision boundary which is not linear.</li>
<li>Why does it help? I hardly think you can find any physical world phenomenon which follows linearity straightforwardly. So you need a non-linear function which can approximate the non-linear phenomenon. Also a good intuition would be any decision boundary or a function is a linear combination of polynomial combinations of the input features (so ultimately non-linear).</li>
<li>Purposes of activation function? In addition to introducing non-linearity every activation function has its own features.</li>
</ul>

<strong>Sigmoid $\frac{1} {(1 + e ^ {-(w1*x1...wn*xn + b)})}$</strong>   

This is one of the most common activation function and is monotonically increasing everywhere. This is generally used at the final output node as it squashes values between 0 and 1 (if output is required to be `0` or `1`).Thus above 0.5 is considered `1` while below 0.5 as `0`, although a different threshold (not `0.5`) maybe set. Its main advantage is that its differentiation is easy and uses already calculated values and supposedly horseshoe crab neurons have this activation function in their neurons.  

<strong>Tanh</strong> $\frac{e ^ {(w1*x1...wn*xn + b)} - e ^ {-(w1*x1...wn*xn + b)})}{(e ^ { (w1*x1...wn*xn + b)} + e ^ {-(w1*x1...wn*xn + b)}}$    

This has an advantage over the sigmoid activation function as it tends to centre the output to 0 which has an effect of better learning on the subsequent layers (acts as a feature normaliser). A nice explanation <a href="https://stats.stackexchange.com/questions/101560/tanh-activation-function-vs-sigmoid-activation-function">here</a>. Negative and positive output values maybe considered as `0` and `1` respectively. Used mostly in RNN's.  

<strong><a href="https://en.wikipedia.org/wiki/Rectifier_(neural_networks)" rel="noreferrer">Re-Lu activation function</a></strong> - This is another very common simple non-linear (linear in positive range and negative range exclusive of each other) activation function which has the advantage of removing the problem of vanishing gradient faced by the above two i.e. gradient tends to `0` as x tends to +infinity or -infinity. <a href="https://ai.stackexchange.com/questions/5601/mathematical-intuition-for-the-use-of-re-lus-in-machine-learning">Here</a> is an answer about Re-Lu's approximation power in-spite of its apparent linearity. ReLu's have a disadvantage of having dead neurons which result in larger NN's.  

Also you can design your own activation functions depending on your specialized problem. You may have a quadratic activation function which will approximate quadratic functions much better. But then, you have to design a cost function which should be somewhat convex in  nature, so that you can optimise it using first order differentials and the NN actually converges to a decent result. This is the main reason why standard activation functions are used. But I believe with proper mathematical tools, there is a huge potential for new and eccentric activation functions.   

For example, say you are trying to approximate a single variable quadratic function say $a.x^2 + c$. This will be best approximated by a quadratic activation $w1.x^2 + b$ where$w1$ and $b$ will be the trainable parameters. But designing a loss function which follows the conventional first order derivative method (gradient descent) can be quite tough for non-monotically increasing function.   

<strong>For Mathematicians:</strong> In the sigmoid activation function $(1 / (1 + e ^ {-(w1*x1...wn*xn + b)})$ we see that $e ^ {-(w1*x1...wn*xn + b)}$ is always <strong>&lt;</strong> `1`. By binomial expansion, or by reverse calculation of the infinite GP series we get $sigmoid(y)$ = $1 + y + y^2.....$. Now in a NN $y = e ^ {-(w1*x1...wn*xn + b)}$. Thus we get all the powers of $y$ which is equal to $e ^ {-(w1*x1...wn*xn + b)}$ thus each power of $y$ can be thought of as a multiplication of several decaying exponentials based on a feature $x$, for eaxmple $y^2 = e^ {-2(w1x1)} * e^ {-2(w2x2)} * e^ {-2(w3x3)} *...... e^ {-2(b)}$. Thus each feature has a say in the scaling of the graph of $y^2$.   

<p>Another way of thinking would be to expand the exponentials according to Taylor Series:
<a href="https://i.stack.imgur.com/rl4XT.png" rel="noreferrer"><img src="https://i.stack.imgur.com/rl4XT.png" alt="enter image description here"></a></p>

So we get a very complex combination, with all the possible polynomial combinations of input variables present. I believe if a Neural Network is structured correctly the NN can fine tune the these polynomial combinations by just modifying the connection weights and selecting polynomial terms maximum useful, and rejecting terms by subtracting output of 2 nodes weighted properly.  

The $tanh$ activation can work in the same way since output of $|tanh| &lt; 1$. I am not sure how Re-Lu's work though, but due to itsrigid structure and probelm of dead neurons werequire larger networks with ReLu's for good approximation.  

But for a formal mathematical proof one has to look at the Universal Approximation Theorem.  

<ul>
<li><a href="http://neuralnetworksanddeeplearning.com/chap4.html" rel="noreferrer">A visual proof that neural nets can compute any function</a></li>
<li><a href="http://mcneela.github.io/machine_learning/2017/03/21/Universal-Approximation-Theorem.html" rel="noreferrer">The Universal Approximation Theorem For Neural Networks- An Elegant Proof</a></li>
</ul>

For non-mathematicians some better insights visit these links:  

<a href="https://www.coursera.org/learn/neural-networks-deep-learning/lecture/4dDC1/activation-functions" rel="noreferrer">Activation Functions by Andrew Ng - for  more formal and scientific answer</a>  

<a href="https://ai.stackexchange.com/questions/3964/how-does-neural-network-classifier-classify-from-just-drawing-a-decision-plane/5225#5225">How does neural network classifier classify from just drawing a decision plane?</a>  

<p><a href="https://ai.stackexchange.com/questions/2526/differentiable-activation-function">Differentiable activation function</a>
<a href="http://neuralnetworksanddeeplearning.com/chap4.html" rel="noreferrer">A visual proof that neural nets can compute any function</a></p>

#### Answer 2 (score 7)
If you only had linear layers in a neural network, all the layers would essentially collapse to one linear layer, and, therefore, a "deep" neural network architecture effectively wouldn't be deep anymore but just a linear classifier.   

<span class="math-container">$$y = f(W_1 W_2 W_3x) = f(Wx)$$</span>  

where <span class="math-container">$W$</span> corresponds to the matrix that represents the network weights and biases for one layer, and <span class="math-container">$f()$</span> to the activation function.  

Now, with the introduction of a non-linear activation unit after every linear transformation, this won't happen anymore.  

<span class="math-container">$$y = f_1( W_1 f_2( W_2f_3( W_3x)))$$</span>  

Each layer can now build up on the results of the preceding non-linear layer which essentially leads to a complex non-linear function that is able to approximate every possible function with the right weighting and enough depth/width.  

#### Answer 3 (score 5)
Let's first talk about <a href="https://en.wikipedia.org/wiki/Linear_map" rel="nofollow noreferrer">linearity</a>. Linearity means the map (a function), <span class="math-container">$f: V \rightarrow W$</span>, used is a linear map, that is, it satisfies the following two conditions   

<ol>
<li><span class="math-container">$f(x + y) = f(x) + f(y), \; x, y \in V$</span> </li>
<li><span class="math-container">$f(c x) = cf(x), \; c \in \mathbb{R}$</span></li>
</ol>

You should be familiar with this definition if you have studied linear algebra in the past.  

However, it's more important to think of linearity in terms of linear separability of data, which means the data can be separated into different classes by drawing a line (or hyperplane, if more than two dimensions), which represents a linear decision boundary, through the data. If we cannot do that, then the data is not linearly separable. Often times, data from a more complex (and thus more relevant) problem setting is not linearly separable, so it is in our interest to model these.  

To model nonlinear decision boundaries of data, we can utilize a neural network that introduces non-linearity. Neural networks classify data that is not linearly separable by transforming data using some nonlinear function (or our activation function), so the resulting transformed points become linearly separable.  

Different activation functions are used for different problem setting contexts. You can read more about that in the book <a href="http://www.deeplearningbook.org" rel="nofollow noreferrer">Deep Learning (Adaptive Computation and Machine Learning series)</a>.  

For an example of non linearly separable data, see the XOR data set.  

<a href="https://i.stack.imgur.com/JdfWD.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/JdfWD.png" alt="enter image description here"></a>  

Can you draw a single line to separate the two classes?  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Is AI living or non-living? (score [6462](https://stackoverflow.com/q/2111) in 2016)

#### Question
I'm a bit confused about the definition of life. Can AI systems be called 'living'? Because they can do most of the things that we can. They can even communicate with one another.   

They are not formed of what we call cells. But, you see, cells are just a collection of several chemical processes which is in turn non-living just like AI is formed of several lines of code.  

#### Answer 2 (score 4)
<p>Artificial intelligence by definition is the intelligence exhibited by machines.  The definition of life in biological terms is the condition that distinguishes organisms from inorganic matter where the distinguishing criteria are the capacity for growth, reproduction, functional activity, and continual change preceding death. Does artificial intelligence "grow"?  Indeed, I can program a machine learning program to grow with every input taken in.  In the loosest sense, we can say that artificial intelligence does grow, but does it biologically? If we look at the definition for growth of a living thing, it means to undergo natural development by increasing in size and changing physically or the progress to maturity.  All living organisms undergo growth.   Even though at the simplest level, cells are a series of chemical processes, cells are a very complicated set of chemical processes that are still not fully understood by scientists across the world.  Every cell has genetic material that can be replicated, excised, used for RNA, proteins, and that is subject to epigenetic regulation. 
<a href="https://i.stack.imgur.com/nczDU.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/nczDU.png" alt="Cell division"></a></p>

Does artificial intelligence undergo the same process of cell division?  No.  If I wanted to, I could write a program that undergoes a simple for-loop (print i from 1 to 100), replicates itself at a certain point (i=50) to produce the same program perhaps with some variation that will execute itself, and terminates (dies) at the end of the for loop.  The program, by an extremely loose definition supported by philosophy but not by biology, lives.  However, in scientific terms (and the correct interpretation), artificial intelligence is not living.  Artificial intelligence can be seen to be similar to viruses which are considered to be acellular and essential to life but not living.  Viruses are encapsulated DNA and RNA that undergo processes of growth, reproduction, and functionality but because they lack the ability to undergo the cell division cycle, are considered non-living.  At the very basis of the scientific definition of life is the cell replication cycle.  Artificial intelligence and viruses are not able to undergo the cell cycle.  Viruses need to infect other cells in order to reproduce but do not have their own, autonomous cycle.  At the end of the day, if you can argue that viruses are alive, you can argue that artificial intelligence is alive as well.  For the scientific definition of life, artificial intelligence must undergo the process of cell division and replication.  Even though artificial intelligence can mimic and help sustain life, no artificial intelligence process is truly alive.   

Do note I did not discuss <a href="http://www.isss.org/primer/asem14ep.html" rel="nofollow noreferrer">living systems</a> in my answer.            

<a href="https://www.ncbi.nlm.nih.gov/books/NBK21685/" rel="nofollow noreferrer">Definition of life</a>  

#### Answer 3 (score 3)
You're unsure about the definition of life (which the other answers clarify) but also most people are unclear about the definition of AI. Do you mean an AI that can accomplish a routine task (such as the path finder in a GPS) or a General AI that is able to find a creative solution to any directive given to it (such an AI does not yet exist and may not ever exist) or do you mean a SENTIENT computer program? <a href="http://alternativemindsets.co.uk/different-types-artificial-intelligence/" rel="nofollow">Here is a simple article introducing some different concepts refered to as AI</a>  

Some people believe that a sentient computer program would be entitled to human rights. Not technically 'alive' in the biological sense, but having self awareness, will, desires, etc. Others disagree and believe that the program is a mere simulation that artificially mimics the actions of a human with a human soul, and is no more human than a washing machine. This is a very deep philosophical and meta-physical debate. For example, in <a href="https://en.wikipedia.org/wiki/A.I._Artificial_Intelligence" rel="nofollow">A.I. the movie</a> the overall message is that an android can simulate the emotion of love in a way that is more loyal and sincere than any human.  

What I find interesting about this purely theoretical debate is that in almost every instance of sci-fi media that deals with the theme, the AI exists inside of a human-like android. But technically, the shape of the robot should be irrelevant.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: What are the differences between greedy best-first and the A* search algorithms? (score [6443](https://stackoverflow.com/q/8681) in 2019)

#### Question
What are the differences between greedy best-first and the A* search algorithms? How is A* better than the greedy best-first search algorithm?  

#### Answer accepted (score 2)
According to the book <a href="http://aima.cs.berkeley.edu/" rel="nofollow noreferrer">Artificial Intelligence: A Modern Approach</a> (3rd edition), by Stuart Russel and Peter Norvig, specifically, section <strong>3.5.1 Greedy best-first search</strong> (p. 92)  

<blockquote>
  Greedy best-first search tries to expand the node that is closest to the goal, on the grounds that this is likely to lead to a solution quickly. Thus, it evaluates nodes by using just the heuristic function; that is, <span class="math-container">$f(n) = h(n)$</span>.  
</blockquote>

In this same section, the authors give an example that shows that greedy best-first search is neither optimal nor complete.  

In section <strong>3.5.2 A* search: Minimizing the total estimated solution cost</strong> of the same book (p. 93), it states  

<blockquote>
  A* search evaluates nodes by combining <span class="math-container">$g(n)$</span>, the cost to reach the node, and <span class="math-container">$h(n)$</span>, the cost to get from the node to the goal <span class="math-container">$$f(n) = g(n) + h(n).$$</span>   
  
  Since <span class="math-container">$g(n)$</span> gives the path cost from the start node to node <span class="math-container">$n$</span>, and <span class="math-container">$h(n)$</span> is the estimated cost of the cheapest path from <span class="math-container">$n$</span> to the goal, we have <span class="math-container">$f(n)$</span> = estimated cost of the cheapest solution through <span class="math-container">$n$</span>.  
  
  Thus, if we are trying to find the cheapest solution, a reasonable thing to try first is the node with the lowest value of <span class="math-container">$g(n) + h(n)$</span>. It turns out that this strategy is more than just reasonable: provided that the heuristic function <span class="math-container">$h(n)$</span> satisfies certain conditions, A* search is both complete and optimal. The algorithm is identical to uniform-cost search except that A* uses <span class="math-container">$g + h$</span> instead of <span class="math-container">$g$</span>  
</blockquote>

#### Answer 2 (score 1)
What you said isn't totally wrong, but the A* algorithm becomes optimal and complete if the heuristic function h is admissible, which means that this function never overestimates the cost of reaching the goal. In that case, the A* algorithm is way better than the greedy search algorithm.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How to create a self-learning AI? (score [6174](https://stackoverflow.com/q/3066) in 2019)

#### Question
Is it possible to create a complex self-learning AI? If it is possible, how do I achieve that?  

#### Answer 2 (score 2)
It has already started , check this   

<a href="http://www.a-i.com/alan1/" rel="nofollow noreferrer">http://www.a-i.com/alan1/</a>  

This may be the beginning level .  

It would take many years to develop something like Jarvis ..  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Why do we need common sense in AI? (score [6103](https://stackoverflow.com/q/13261) in 2019)

#### Question
Let's consider this example:  

<blockquote>
  It's John's birthday, let's buy him a kite.  
</blockquote>

We humans most likely would say the kite is a birthday gift, if asked why it's being bought; and we refer to this reasoning as <em>common sense</em>.  

Why do we need this in artificially intelligent agents? I think it could cause a plethora of problems, since a lot of our human errors are caused by these vague assumptions.  

Imagine an AI ignoring doing certain things because it assumes it has already been done by someone else (or another AI), using its common sense.  

Wouldn't that bring human errors into AI systems?  

#### Answer accepted (score 15)
<a href="https://en.wikipedia.org/wiki/Commonsense_knowledge_(artificial_intelligence)" rel="noreferrer">Common sense knowledge</a> is the collection of premises that everyone, in a certain context (hence common sense knowledge might be a function of the context), takes for granted. There would exist a lot of miscommunication between a human and an AI if the AI did not possess common sense knowledge. Therefore, common sense knowledge is fundamental to <a href="https://en.wikipedia.org/wiki/Human%E2%80%93computer_interaction" rel="noreferrer"><em>human-AI interaction</em></a>.   

There are also premises that every human takes for granted independently of the country, culture or, in general, context. For example, every human (almost since its birth) has a mechanism for reasoning about naive physics, such as space, time and physical interactions. If an AI does not possess this knowledge, then it cannot perform the tasks that require this knowledge.  

Any task that requires a machine to have common sense knowledge (of an <em>average</em> human) is believed to be <a href="http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.369.7112" rel="noreferrer">AI-complete</a>, that is, it requires human-level (or general) intelligence. See section 3 of the article <a href="https://pdfs.semanticscholar.org/59e3/495f4f1e70629e17ddbbce06834626b2a363.pdf" rel="noreferrer">Common Sense Knowledge</a> (2009), by Christian Andrich, Leo Novosel and Bojan Hrnkas.  

Of course, the problems that arise while humans communicate because of different assumptions or premises might also arise between humans and AIs (that possess common sense knowledge).  

#### Answer 2 (score 10)
We need this kind of common sense knowledge if we want to get computers to <em>understand</em> human language. It's easy for a computer program to analyse the grammatical structure of the example you give, but in order to understand its meaning we need to know the possible contexts, which is what you refer to as "common sense" here.  

This was emphasised a lot in Roger Schank <em>et al.</em>'s work on computer understanding of stories, and lead to a lot of research into knowledge representation, scripts, plans, goals. One example from Schank's work is <em>Mary was hungry. She picked up a Michelin Guide.</em> -- this seems like a non-sequitur: if you are hungry, why pick up a book? Until you realise that it is a restaurant guide, and that Mary is presumably planning to go to a restaurant to eat. If you know that going to a restaurant is a potential solution to the problem of being hungry, then you have no problem understanding this story fragment.  

Any story needs common sense to be understood, because no story is completely explicit. Common things are "understood" and aren't explicitly mentioned. Stories relate to human experience, and a story that would make everything explicit would probably read like a computer program. You also need common sense to understand how characters in a story behave, and how they are affected by what is happening. Again, this is very subjective, but it is necessary. Some common sense might be generally applicable, other aspects of it won't be. It's a complex issue, which is why researchers have struggled with it for at least half a century of AI research.  

Of course this would introduce "human errors" into an AI system. All this is very subjective and culture-specific. Going to a restaurant in the USA is different from going to one in France -- this is why going abroad can be a challenge. And my reading of a story will probably be different from yours. But if you want to simulate human intelligence, you cannot do that without potential human "errors".  

#### Answer 3 (score 2)
I'll answer this question in several parts:  

<blockquote>
  Why do AGI systems need to have common sense?  
</blockquote>

Humans in the wild reason and communicate using common sense more than they do with strict logic, you can see this by noting that it is easier to appeal to someone's emotion than logic. So any system that seeks to replicate human cognition (as in AGI) should also replicate this tendency to use common sense.  

More simply put, we'd wish that our AGI system can speak to us in common sense language simply because that is what we understand best (otherwise we wouldn't understand our friendly AGI would we?). Obtuse theory and strict logic might technically be correct, but don't appeal to our understanding.  

<blockquote>
  Isn't the goal of AGI the create the most cognitively advance system? Why should the "most perfect" AGI system need to deal with such imperfections and impreciseness present in common sense?  
</blockquote>

First, it might only <em>appear</em> to be the case that common sense logic is "irrational". Perhaps there is a consistent mathematical way to model common sense such that all the subtleties of common sense are represented in a rigour fashion.   

Second, the early study of Artificial Intelligence started in the study of cognitive science, where researchers tried to replicate "algorithms of the mind", or more precisely: decidable procedures which replicated human thought. To that extent then, the study of AI isn't to create the "most supreme cognitive agent" but to merely replicate human thought/behavior. Once we can replicate human behavior we can perhaps try to create something super-human by giving it more computational power, but that is not guaranteed.  

<blockquote>
  I still don't see why common sense is needed in AGI systems. Isn't AGI about being the most intelligent and powerful computational system? Why should it care or conform towards the limits of human understanding, which requires common sense?  
</blockquote>

Perhaps then you have a bit of a misaligned understanding of what AGI entails. AGI doesn't mean unbounded computational power (physically impossible due to physical constraints on computation such as <a href="https://en.wikipedia.org/wiki/Bremermann%27s_limit" rel="nofollow noreferrer">Bremermann's limit</a>) or unbounded intelligence (perhaps physically impossible due to the prior constraint). It usually just means artificial "general intelligence", general meaning broad and common.  

Considerations about unbounded agents are studied in more detail in fields such as theoretical computer science (type theory I believe), decision theory, and perhaps even set theory, where we are able to pose questions about agents with unbounded computational power. We might say that there are questions even an AGI system with unbounded power can't answer due to the <a href="https://en.wikipedia.org/wiki/Halting_problem" rel="nofollow noreferrer">Halting Problem</a>, but only if the assumptions on those fields map onto the structure of the given AGI, which might not be true.  

For a better understanding of what AGI might entail and its goals, I might recommend two books: Artificial Intelligence: The Very Idea by John Haugeland for a more pragmatic approach (as pragmatic as AI-philosophy can be, and On the Origin of Objects by Brian Cantwell Smith for a more philosophically inclined approach.  

As a fun aside, the collection of Zen koan's: The Gateless Gate, includes the following passage: (quoted and edited from <a href="https://en.wikipedia.org/wiki/Mu_(negative)#The_Mu-koan" rel="nofollow noreferrer">wikipedia</a>)  

<blockquote>
  A monk asked Zhaozhou, a Chinese Zen master, "Has a dog Buddha-nature or not?" Zhaozhou answered, "Wú"  
</blockquote>

Wú (無) translates to "none", "nonesuch", or "nothing", which can be interpreted as to avoid answering either yes or no. This enlightened individual doesn't seek to strictly answer every question, but just to respond in a way that makes sense. It doesn't really matter as to wether the dog has Buddha-nature or not (whatever Buddha-nature means), so the master defaults to absolve the question rather than resolving it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: What is the actual quality of machine translations? (score [6090](https://stackoverflow.com/q/12659) in 2019)

#### Question
Till today I - as an AI layman - am confused by the promised and achieved improvements of automated translation.   

My impression is: <strong>there is still a very, very far way to go.</strong> Or are there other explanations why the automated translations (offered and provided e.g. by Google) of quite simple Wikipedia articles still read and sound mainly silly, are hardly readable, and only very partially helpful and useful?  

It may depend on personal preferences (concerning readability, helpfulness and usefulness), but <strong>my personal expectations</strong> are disappointed sorely.  

The other way around: Are Google's translations nevertheless readable, helpful and useful <strong>for a majority of users</strong>?  

Or does Google have reasons to <strong>retain its achievements</strong> (and not to show to the users the best they can show)?   

<hr>

Preliminary result: We are still far away from being able to talk with artificial intelligences on an equal footing and understanding - only on the level of strings. So why should we be afraid? Because <a href="https://youtu.be/A4x5NawXfrQ?t=56" rel="nofollow noreferrer">they know more than we know</a> - but we don't know?  

#### Answer 2 (score 21)
Who claimed that machine translation is as good as a human translator? For me, as a professional translator who makes his living on translation for 35 years now, MT means that my daily production of human quality translation has grown by factor 3 to 5, depending on complexity of the source text.  

I cannot agree that the quality of MT goes down with the length of the foreign language input. That used to be true for the old systems with semantic and grammatical analyses. I don't think that I know all of the old systems (I know Systran, a trashy tool from Siemens that was sold from one company to the next like a Danaer's gift, XL8, Personal Translator and Translate), but even a professional system in which I invested 28.000 DM (!!!!) failed miserably.   

For example, the sentence:   

<blockquote>
  On this hot summer day I had to work and it was a pain in the ass.  
</blockquote>

can be translated using several MT tools to German.  

<a href="https://www.linguatec.de/en/translation/personal-translator-professional-20/" rel="noreferrer">Personal Translator 20</a>:  

<blockquote>
  Auf diesem heißen Sommertag musste ich arbeiten, und es war ein Schmerz im Esel.  
</blockquote>

<a href="https://www.online-translator.com/" rel="noreferrer">Prompt</a>:   

<blockquote>
  An diesem heißen Sommertag musste ich arbeiten, und es war ein Schmerz im Esel.  
</blockquote>

<a href="https://www.deepl.com/en/translator" rel="noreferrer">DeepL</a>:   

<blockquote>
  An diesem heißen Sommertag musste ich arbeiten und es war eine Qual.  
</blockquote>

Google:   

<blockquote>
  An diesem heißen Sommertag musste ich arbeiten und es war ein Schmerz im Arsch.  
</blockquote>

Today, Google usually presents me with readable, nearly correct translations and DeepL is even better. Just this morning I translated 3500 words in 3 hours and the result is flawless although the source text was full of mistakes (written by Chinese).  

#### Answer 3 (score 7)
Google's translations <em>can</em> be useful, especially if you know that the translations are not perfect and if you just want to have an initial idea of the meaning of the text (whose Google's translations can sometimes be quite misleading or incorrect). I wouldn't recommend Google's translate (or any other non-human translator) to perform a serious translation, unless it's possibly a common sentence or word, it does not involve very long texts and informal language (or slang), the translations involve the English language or you do not have access to a human translator.  

<a href="https://translate.google.com/" rel="nofollow noreferrer">Google Translate</a> currently uses a <a href="https://arxiv.org/pdf/1609.08144.pdf" rel="nofollow noreferrer">neural machine translation system</a>. To evaluate this model (and similar models), the <a href="https://en.wikipedia.org/wiki/BLEU" rel="nofollow noreferrer">BLEU metric</a> (a scale from <span class="math-container">$0$</span> to <span class="math-container">$100$</span>, where <span class="math-container">$100$</span> corresponds to the human gold-standard translation) and side-by-side evaluations (a human rates the translations) have been used. If you use only the BLEU metric, the machine traslations are quite poor (but the BLEU metric is also not a perfect evaluation metric, because there's often more than one translation of a given sentence). However, GNMT reduces the translation errors compared to <a href="https://en.wikipedia.org/wiki/Statistical_machine_translation" rel="nofollow noreferrer">phrase-based machine translation (PBMT)</a>.   

In the paper <a href="https://arxiv.org/pdf/1901.02918.pdf" rel="nofollow noreferrer">Making AI Meaningful Again</a>, the authors also discuss the difficulty of the task of translation (which is believed to be an <a href="https://ai.stackexchange.com/a/12147/2444">AI-complete problem</a>). They also mention the <a href="https://papers.nips.cc/paper/7181-attention-is-all-you-need.pdf" rel="nofollow noreferrer">transformer</a> (another state-of-the-art machine translation model), which achieves quite poor results (evaluated using the BLEU metric).  

To conclude, machine translation is a hard problem and current machine translation systems definitely do not perform as well as a professional human translator.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: What are the differences between A* and greedy best-first search? (score [6061](https://stackoverflow.com/q/8902) in 2019)

#### Question
What are the differences between the A* algorithm and the greedy best-first search algorithm? Which one should I use? Which algorithm is the better one, and why?  

#### Answer accepted (score 3)
Both algorithms fall into the category of "best-first search" algorithms, which are algorithms that <em>can</em> use both the knowledge acquired so far while exploring the search space, denoted by <span class="math-container">$g(n)$</span>, and a heuristic function, denoted by <span class="math-container">$h(n)$</span>, which estimates the distance to the goal node, for each node <span class="math-container">$n$</span> in the search space (often represented as a graph).   

Each of these search algorithms defines an "evaluation function", for each node <span class="math-container">$n$</span> in the graph (or search space), denoted by <span class="math-container">$f(n)$</span>. This evaluation function is used to determine which node, while searching, is "expanded" first, that is, which node is first removed from the <a href="https://ai.stackexchange.com/q/5949/2444">"fringe" (or "frontier", or "border")</a>, so as to "visit" its children. In general, the difference between the algorithms in the "best-first" category is in the definition of the evaluation function <span class="math-container">$f(n)$</span>.  

In the case of <a href="https://en.wikipedia.org/wiki/Best-first_search#Greedy_BFS" rel="nofollow noreferrer"><em>the greedy BFS algorithm</em></a>, the evaluation function is <span class="math-container">$f(n) = h(n)$</span>, that is, the greedy BFS algorithm first expands the node whose estimated distance to the goal is the smallest. So, greedy BFS does not use the "past knowledge", i.e. <span class="math-container">$g(n)$</span>. Hence its connotation "greedy". In general, the greedy BST algorithm is <strong>not complete</strong>, that is, there is always the risk to take a path that does not bring to the goal. In the greedy BFS algorithm, all nodes on the <em>border</em> (or fringe or frontier) are kept in memory, and nodes that have already been expanded do not need to be stored in memory and can therefore be discarded. In general, the greedy BFS is also <strong>not optimal</strong>, that is, the path found may not be the optimal one. In general, the time complexity is <span class="math-container">$\mathcal{O}(b^m)$</span>, where <span class="math-container">$b$</span> is the (maximum) branching factor and <span class="math-container">$m$</span> is the maximum depth of the search tree. The space complexity is proportional to the number of nodes in the fringe and to the length of the found path.  

In the case of <a href="https://en.wikipedia.org/wiki/A*_search_algorithm" rel="nofollow noreferrer"><em>the A* algorithm</em></a>, the evaluation function is <span class="math-container">$f(n) = g(n) + h(n)$</span>, where <span class="math-container">$h$</span> is an <a href="https://en.wikipedia.org/wiki/Admissible_heuristic" rel="nofollow noreferrer">admissible heuristic function</a>. The "star", often denoted by an asterisk, `*`, refers to the fact that A* uses an admissible heuristic function, which essentially means that A* is <strong>optimal</strong>, that is, it always finds the optimal path between the starting node and the goal node. A* is also <strong>complete</strong> (unless there are infinitely many nodes to explore in the search space). The time complexity is <span class="math-container">$\mathcal{O}(b^m)$</span>. However, A* needs to keep all nodes in memory while searching, not just the ones in the fringe, because A*, essentially, performs an "exhaustive search" (which is "informed", in the sense that it uses a heuristic function).  

In summary, greedy BFS is not complete, not optimal, has a time complexity of <span class="math-container">$\mathcal{O}(b^m)$</span> and a space complexity which can be polynomial. A* is complete, optimal, and it has a time and space complexity of <span class="math-container">$\mathcal{O}(b^m)$</span>. So, in general, A* uses more memory than greedy BFS. A* becomes impractical when the search space is huge. However, A* also guarantees that the found path between the starting node and the goal node is the optimal one and that the algorithm eventually terminates. Greedy BFS, on the other hand, uses less memory, but does not provide the optimality and completeness guarantees of A*. So, which algorithm is the "best" depends on the context, but both are "best"-first searches.   

Note: in practice, you may not use any of these algorithms: you may e.g. use, instead, <a href="https://en.wikipedia.org/wiki/Iterative_deepening_A*" rel="nofollow noreferrer">IDA*</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Can BERT be used for sentence generating tasks? (score [5809](https://stackoverflow.com/q/9141) in 2019)

#### Question
I am a new learner in NLP. I am interested in the sentence generating task. As far as I am concerned, one state-of-the-art method is the <a href="https://github.com/karpathy/char-rnn" rel="noreferrer">CharRNN</a>, which uses RNN to generate a sequence of words.  

However, <a href="https://arxiv.org/abs/1810.04805" rel="noreferrer">BERT</a> has come out several weeks ago and is very powerful. Therefore, I am wondering whether this task can also be done with the help of BERT? I am a new learner in this field, and thank you for any advice!  

#### Answer accepted (score 15)
For newbies, NO.  

Sentence generation requires sampling from a language model, which gives the probability distribution of the next word given previous contexts. But BERT can't do this due to its bidirectional nature.  

<hr>

For advanced researchers, YES.  

You can start with a sentence of all [MASK] tokens, and generate words one by one in arbitrary order (instead of the common left-to-right chain decomposition). Though the text generation quality is hard to control.  

Here's the technical report <a href="https://arxiv.org/abs/1902.04094" rel="nofollow noreferrer">BERT has a Mouth, and It Must Speak: BERT as a Markov Random Field Language Model</a>, its <a href="https://sites.google.com/site/deepernn/home/blog/amistakeinwangchoberthasamouthanditmustspeakbertasamarkovrandomfieldlanguagemodel" rel="nofollow noreferrer">errata</a> and the <a href="https://github.com/nyu-dl/bert-gen" rel="nofollow noreferrer">source code</a>.  

<hr>

In summary:  

<ul>
<li>If you would like to do some research in the area of decoding with
BERT, there is a huge space to explore</li>
<li>If you would like to generate
high quality texts, personally I recommend you to check <a href="https://blog.openai.com/better-language-models/" rel="nofollow noreferrer">GPT-2</a>.</li>
</ul>

#### Answer 2 (score 3)
this experiment by Stephen Mayhew suggests that BERT is lousy at sequential text generation:  

<a href="http://mayhewsw.github.io/2019/01/16/can-bert-generate-text/" rel="nofollow noreferrer">http://mayhewsw.github.io/2019/01/16/can-bert-generate-text/</a>  

<blockquote>
```text
although he had already eaten a large meal, he was still very hungry
```
  
  As before, I masked “hungry” to see what BERT would predict. If it could predict it correctly without any right context, we might be in good shape for generation.  
  
  This failed. BERT predicted “much” as the last word. Maybe this is because BERT thinks the absence of a period means the sentence should continue. Maybe it’s just so used to complete sentences it gets confused. I’m not sure.  
  
  One might argue that we should continue predicting after “much”. Maybe it’s going to produce something meaningful. To that I would say: first, this was meant to be a dead giveaway, and any human would predict “hungry”. Second, I tried it, and it keeps predicting dumb stuff. After “much”, the next token is “,”.  
  
  So, at least using these trivial methods, BERT can’t generate text.  
</blockquote>

#### Answer 3 (score 2)
No. Sentence generating is directly related to language modelling (given the previous words in the sentence, what is the next word). <a href="https://github.com/google-research/bert/issues/35" rel="nofollow noreferrer">Because of bi-directionality of BERT, BERT cannot be used as a language model.</a> If it cannot be used as language model, I don't see how you can generate a sentence using BERT.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Why is A* optimal if the heuristic function is admissible? (score [5469](https://stackoverflow.com/q/6026) in 2019)

#### Question
A heuristic is <strong>admissible</strong> if it <em>never overestimates</em> the true cost to reach the goal node from <span class="math-container">$n$</span>. If a heuristic is <strong>consistent</strong>, then the heuristic value of <span class="math-container">$n$</span> is never greater than the cost of its successor, <span class="math-container">$n'$</span>, plus the successor's heuristic value.   

Why is A*, using tree or graph searches, optimal, if it uses an admissible heuristic?  

#### Answer accepted (score 6)
This is well covered in the corresponding chapter of <a href="http://aima.cs.berkeley.edu/" rel="nofollow noreferrer">Russell &amp; Norvig</a> (chapter 3.5, pages 93 to 99 (Third Edition)). Check that out for more details.  

First, let's review the definitions:   

<hr>

Your definitions of admissible and consistent are correct.  

An <strong>admissible heuristic</strong> is basically just "optimistic". It never overestimates a distance.   

A <strong>consistent heuristic</strong> is one where your prior beliefs about the distances between states are self-consistent. That is, you don't think that it costs 5 from B to the goal, 2 from A to B, and yet 20 from A to the goal. You <em>are</em> allowed to be overly optimistic though. So you could believe that it's 5 from B to the goal, 2 from A to B, and 4 from A to the goal.  

A <strong>tree search</strong> is a general search strategy for searching problems that have a tree structure: that is, it's never possible to "double back" to an earlier state from a later state. This models certain types of games, for instance, like Tic-Tac-Toe. The tree search does not remember which states it has already visited, only the "fringe" of states it hasn't visited yet.  

A <strong>graph search</strong> is a general search strategy for searching graph-structured problems, where it's possible to double back to an earlier state, like in chess (e.g. both players can just move their kings back and forth). To avoid these loops, the graph search also keeps track of the states that it has processed.   

For more on tree vs. graph search, see the good answers on <a href="https://stackoverflow.com/q/10680180/3924118">this Stack Overflow question</a>.  

<hr>

Okay, now let's talk through the intuition behind the proofs.  

We first want to show that   

<blockquote>
  If <span class="math-container">$h(n)$</span> is admissible, A* using tree search is optimal.   
</blockquote>

The usual proof is by contradiction.   

<ol>
<li><p>Assume that A* with tree search and an admissible heuristic was not optimal. </p></li>
<li><p>Being non-optimal means that the first complete path from the start to the goal discovered by A* (call this <span class="math-container">$q$</span>) will be longer than some other path <span class="math-container">$p$</span>, which A* explored up to some state <span class="math-container">$s$</span>, but no further.</p></li>
<li><p>Since the heuristic is admissible, the estimated cost of reaching the goal from <span class="math-container">$s$</span> must be smaller than the true cost.</p></li>
<li><p>By 3, and the fact that we know how much it costs to reach <span class="math-container">$s$</span> along <span class="math-container">$p$</span>, the estimated total cost of <span class="math-container">$p$</span>, and thus the cost to expand <span class="math-container">$s$</span> must be smaller than the true cost of <span class="math-container">$p$</span>. </p></li>
<li><p>Since the true cost of <span class="math-container">$p$</span> is smaller than the cost of <span class="math-container">$q$</span> (by 2), the estimated cost to expand <span class="math-container">$s$</span> must be smaller than the true cost of <span class="math-container">$q$</span>.</p></li>
<li><p>A* always picks the path with the most promising total cost to expand next, and the cost of expanding the goal state is given by the total path length required to reach it. </p></li>
<li><p>5 and 6 form a contradiction, so our assumption in 1 must have been incorrect. Therefore A* must be optimal.</p></li>
</ol>

The graph search proof uses a very similar idea, but accounts for the fact that you might loop back around to earlier states.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How does LSTM in deep reinforcement learning differ from experience replay? (score [5468](https://stackoverflow.com/q/7721) in 2019)

#### Question
In the paper <a href="https://arxiv.org/pdf/1507.06527.pdf" rel="nofollow noreferrer">Deep Recurrent Q-Learning for Partially Observable MDPs</a>, the author processed the Atari game frames with an LSTM layer at the end. My questions are:   

<ul>
<li><p>How does this method differ from the <a href="https://datascience.stackexchange.com/questions/20535/understanding-experience-replay-in-reinforcement-learning">experience replay</a>, as they both use past information in the training? </p></li>
<li><p>What's the typical application of both techniques? </p></li>
<li><p>Can they work together?</p></li>
<li><p>If they can work together, does it mean that the <em>state</em> is no longer a single state but a set of contiguous states?</p></li>
</ul>

#### Answer accepted (score 7)
<blockquote>
  How does this method differ from the experience replay, as they both use past information in the training? What's the typical application of both techniques?  
</blockquote>

Using a recurrent neural network is one way for an agent to build a model of hidden or unobserved state in order to improve its predictions when direct observations do not give enough information, but a <em>history</em> of observations might give better information. Another way is to learn a <a href="https://en.wikipedia.org/wiki/Hidden_Markov_model" rel="nofollow noreferrer">Hidden Markov model</a>. Both of these approaches build an internal representation that is effectively considered part of the state when making a decision by the agent. They are a way to approach solving <a href="https://en.wikipedia.org/wiki/Partially_observable_Markov_decision_process" rel="nofollow noreferrer">POMDPs</a>.   

You can consider using individual frame images from Atari games as state as a POMDP, because each individual frame does not contain information about velocity. Velocity of objects in play is an important concept in many video games. By formulating the problem as a POMDP with individual image inputs, this challenges the agent to find some representation of velocity (or something similar conceptually) from a sequence of images. Technically a NN may also do this using fixed inputs of 4 frames at a time (as per the original DQN Atari paper), but in that case the designers have deliberately "solved" the partially observable part of the problem for the agent in advance, by selecting a better state representation from the start.  

Experience replay solves some different problems:  

<ul>
<li><p>Efficient use of experience, by learning repeatedly from observed transitions. This is important when the agent needs to use a low learning rate, as it does when the environment has stochastic elements or when the agent includes a complex non-linear function approximator like a neural network.</p></li>
<li><p>De-correlating samples to avoid problems with function approximators that work best with i.i.d. data. If you didn't effectively shuffle the dataset, the correlations between each time step could cause significant issues with a feed-forward neural network.</p></li>
</ul>

These two issues are important to learning stability for neural networks in DQN. Without experience replay, often Q-learning with neural networks will fail to converge at all.   

<blockquote>
  Can they work together?  
</blockquote>

Sort of, but not quite directly, because LSTM requires input of multiple related time steps at once, as opposed to randomly sampled individual time steps. However, you could keep a history of longer trajectories, and sample sections from it for the history in order to train a LSTM. This would still achieve the goal of using experience efficiently. Depending on the LSTM architecture, you may need to sample quite long trajectories or even complete episodes in order to do this.  

From comments by Muppet, it seems that is even possible to sample more randomly with individual steps by saving LSTM state. For instance, there is a paper "<a href="https://arxiv.org/pdf/1803.03916.pdf" rel="nofollow noreferrer">Deep reinforcement learning for time series: playing idealized trading games</a>" where the authors get a working system doing this. I have no experience of this approach myself, and there are theoretical reasons why this may not work in all cases, but it is an option.  

<blockquote>
  If they can work together, does it mean that the state is no longer a single state but a set of contiguous states?  
</blockquote>

Not really, the state at any time step is still a single state representation, is separate conceptually from an observation, and is separate conceptually from a <em>trajectory</em> or sequence of states used to train a RNN (other RL approaches such as TD(<span class="math-container">$\lambda$</span>) also require longer trajectories). Using an LSTM implies you have <em>hidden</em> state on each time step (compared to what you are able to observe), and that you hope the LSTM will discover a way to represent it.   

One way to think of this is that the state is the current observation, plus a summary of observation history. The original Atari DQN paper simply used the previous three observations hard-coded as this "summary", which appeared to capture enough information to make predicting value functions reliable.   

The LSTM approach is partly of interest, because it does not rely on human input to decide how to construct state from the observations, but discovers this by itself. One key goal of deep learning is designs and architectures that are much less dependent on human interpretations of the problem (typically these use <em>feature engineering</em> to assist in learning process). An agent that can work directly from raw observations has solved more of the problem by itself without injection of knowledge by the engineers that built it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: max pooling size=2,stride=1 outputs same size (score [5374](https://stackoverflow.com/q/4199) in )

#### Question
While working with darkflow, I encountered something that I can't understand.  

I understand that maxpooling with size=2,stride=2 would decrease the output size to half of its size.  

However, if the max-pooling is size=2,stride=1 then it would simply decrease the width and height of the output by 1 only.  

However, the darkflow model doesn't seem to decrease the output by 1.  

Here is the model structure when I load the example model `tiny-yolo-voc.cfg`.  

```text
Source | Train? | Layer description                | Output size
-------+--------+----------------------------------+---------------
       |        | input                            | (?, 416, 416, 3)
 Init  |  Yep!  | conv 3x3p1_1  +bnorm  leaky      | (?, 416, 416, 16)
 Load  |  Yep!  | maxp 2x2p0_2                     | (?, 208, 208, 16)
 Init  |  Yep!  | conv 3x3p1_1  +bnorm  leaky      | (?, 208, 208, 32)
 Load  |  Yep!  | maxp 2x2p0_2                     | (?, 104, 104, 32)
 Init  |  Yep!  | conv 3x3p1_1  +bnorm  leaky      | (?, 104, 104, 64)
 Load  |  Yep!  | maxp 2x2p0_2                     | (?, 52, 52, 64)
 Init  |  Yep!  | conv 3x3p1_1  +bnorm  leaky      | (?, 52, 52, 128)
 Load  |  Yep!  | maxp 2x2p0_2                     | (?, 26, 26, 128)
 Init  |  Yep!  | conv 3x3p1_1  +bnorm  leaky      | (?, 26, 26, 256)
 Load  |  Yep!  | maxp 2x2p0_2                     | (?, 13, 13, 256)
 Init  |  Yep!  | conv 3x3p1_1  +bnorm  leaky      | (?, 13, 13, 512)
 **Load  |  Yep!  | maxp 2x2p0_1                     | (?, 13, 13, 512)**
 Init  |  Yep!  | conv 3x3p1_1  +bnorm  leaky      | (?, 13, 13, 1024)
 Init  |  Yep!  | conv 3x3p1_1  +bnorm  leaky      | (?, 13, 13, 1024)
 Init  |  Yep!  | conv 1x1p0_1    linear           | (?, 13, 13, 125)
-------+--------+----------------------------------+---------------
```

The bold text part is causing the confusion. My expectation what (?,12,12,512) but it is not. It retains the same size (13,13)  

The corresponding model info from the `.cfg` file is:  

```text
[convolutional]
batch_normalize=1
filters=512
size=3
stride=1
pad=1
activation=leaky

[maxpool]
size=2
stride=1
```

Why is the output height/width not decreasing by 1?  

#### Answer 2 (score 3)
I wondered about the same input/output size problem you described.  

For the stride = 1 / size = 2 maxpool layers the padding option is set to zero by default, therefore one can wonder why the output is still the same size.  

I checked all indices and thats what I observed:  

The implemention of the forward_maxpool_layer-function "adds" a column and a row to the matrix, increasing its width and height by one.  

Lets say we have a 3x3 matrix as follows:  

```text
    1    2    3
    4    5    6
    7    8    9
```

To actually get a 3x3 matrix as an output, something like this is done:  

```text
    1    2    3    -FM
    4    5    6    -FM
    7    8    9    -FM
    -FM  -FM  -FM  -FM

    where FM = FLOAT_MAX
```

They do not literally add a row and a column. If the index is to high, you simply do nothing.  

Hope this helped to clarify stuff. Furthermore I am not a native speaker, so sorry for any mistake!  

#### Answer 3 (score 1)
Darkflow uses padding when applying the pooling layer. Padding is a common mechanism for maxpooling. This allows you to keep the size the same.   

I recommend the chapter "Stride and Padding" from the article <a href="https://adeshpande3.github.io/A-Beginner%27s-Guide-To-Understanding-Convolutional-Neural-Networks-Part-2/" rel="nofollow noreferrer">A Beginner's Guide To Understanding Convolutional Neural Networks (part 2)</a>  to see how padding works in detail.  

Please also note that there have been <a href="https://github.com/thtrieu/darkflow/issues/250" rel="nofollow noreferrer">recent issues</a> with the implementation of padding in darkflow.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: How to handle invalid moves in reinforcement learning? (score [5373](https://stackoverflow.com/q/2980) in 2018)

#### Question
I want to create an AI which can play five-in-a-row/gomoku. As I mentioned in the title, I want to use reinforcement learning for this.   

I use <em>policy gradient</em> method, namely REINFORCE, with baseline. For the value and policy function approximation, I use a <em>neural network</em>. It has convolutional and fully connected layers. All of the layers, except for the output, are shared. The policy's output layer has <span class="math-container">$8 \times 8=64$</span> (the size of the board) output unit and <em>softmax</em> on them. So it is stochastic. But what if the network produces a very high probability for an invalid move? An invalid move is when the agent wants to check a square which has one "X" or "O" in it. I think it can stuck in that game state.   

Could you recommend any solution for this problem?  

My guess is to use the <em>actor-critic</em> method. For an invalid move, we should give a negative reward and pass the turn to the opponent.  

#### Answer accepted (score 10)
Just ignore the invalid moves.  

For exploration it is likely that you won't just execute the move with the highest probability, but instead choose moves randomly based on the outputted probability. If you only punish illegal moves they will still retain some probability (however small) and therefore will be executed from time to time (however seldom). So you will always retain an agent which occasionally makes illegal moves.  

To me it makes more sense to just set the probabilities of all illegal moves to zero and renormalise the output vector before you choose your move.   

#### Answer 2 (score 8)
Usually softmax methods in policy gradient methods using linear function approximation use the following formula to calculate the probability of choosing action <span class="math-container">$a$</span>. Here, weights are <span class="math-container">$\theta$</span>, and the features <span class="math-container">$\phi$</span> is a function of the current state <span class="math-container">$s$</span> and an action from the set of actions <span class="math-container">$A$</span>.   

<p><span class="math-container">$$
\pi(\theta, a) = \frac{e^{\theta \phi(s, a)}}{\sum_{b \in A} e^{\theta \phi(s, b)}}
$$</span></p>

To eliminate illegal moves, one would limit the set of actions to only those that were legal, hence <span class="math-container">$Legal(A)$</span>.  

<p><span class="math-container">$$
\pi(\theta, a) = \frac{e^{\theta \phi(s, a)}}{\sum_{b \in Legal(A)} e^{\theta \phi(s, b)}}, \, a \in Legal(A)
$$</span></p>

In pseudocode the formula may look like this:  

```text
action_probs = Agent.getActionProbs(state)
legal_actions = filterLegalActions(state, action_probs)
best_legal_action = softmax(legal_actions)
```

Whether using linear or non-linear function approximation (your neural network), the idea is to only use the legal moves when computing your softmax. This method means that only valid moves will be given by the agent, which is good if you wanted to change your game later on, and that the difference in value between the limited choice in actions will be easier to discriminate by the agent. It will also be faster as the number of possible actions decreases.  

#### Answer 3 (score 5)
I faced a similar issue recently with Minesweeper.  

The way I solved it was by ignoring the illegal/invalid moves entirely.  

<ol>
<li>Use the Q-network to predict the Q-values for all of your actions (valid and invalid)</li>
<li>Pre-process the Q-values by setting all of the invalid moves to a Q-value of zero/negative number (depends on your scenario)</li>
<li>Use a policy of your choice to select an action from the refined
Q-values (i.e. greedy or Boltzmann)</li>
<li>Execute the selected action and resume your DQN logic</li>
</ol>

Hope this helps.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Complete deep learning text classification with Python example (score [5352](https://stackoverflow.com/q/6724) in )

#### Question
I would like to know if there is a complete text classification with deep learning example, from text file, csv, or other format, to classified output text file, csv, or other. I have seen tens of tutorials and they mostly focus on the model and its performance, but I have not been able to find one that shows how to apply the model to a set of text strings and how to output a document with the classified(labeled) text.  

#### Answer accepted (score 2)
You may look at these github repositories :   

<ol>
<li><a href="https://github.com/dennybritz/cnn-text-classification-tf" rel="nofollow noreferrer">Text classification in NLP with deep learning</a></li>
<li><a href="https://github.com/dennybritz/cnn-text-classification-tf" rel="nofollow noreferrer">Convolutional Neural Networks for Sentence Classification</a></li>
</ol>

#### Answer 2 (score 1)
I believe what you are looking for is this: <a href="https://machinelearningmastery.com/sequence-classification-lstm-recurrent-neural-networks-python-keras/" rel="nofollow noreferrer">https://machinelearningmastery.com/sequence-classification-lstm-recurrent-neural-networks-python-keras/</a>  

The author uses the IMDB dataset to classify movies from comment sentiment (good / bad).  

It includes detailed description of all the steps and provides you with the code to have a LSTM-RNN up and running very fast for the purpose.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Why can't OCR be perceived as a good example of AI? (score [5332](https://stackoverflow.com/q/1396) in 2016)

#### Question
On <a href="https://en.wikipedia.org/wiki/Artificial_intelligence">the wikipedia page</a> about AI, we can read:  

<blockquote>
  Optical character recognition is no longer perceived as an exemplar of "artificial intelligence" having become a routine technology.  
</blockquote>

On the other hand, the <a href="https://en.wikipedia.org/wiki/MNIST_database">MNIST</a> database of handwritten digits is especially designed for training and testing neural networks and their error rates (see: <a href="https://en.wikipedia.org/wiki/MNIST_database#Classifiers">Classifiers</a>).  

So why does the above quote state that OCR is no longer exemplar of AI?  

#### Answer accepted (score 16)
Whenever a problem becomes solvable by a computer, people start arguing that it does not require intelligence. John McCarthy is often quoted: "As soon as it works, no one calls it AI anymore" (<a href="http://cacm.acm.org/magazines/2012/1/144824-artificial-intelligence-past-and-future/fulltext" rel="nofollow noreferrer">Referenced in CACM</a>).  

One of my teachers in college said that in the 1950's, a professor was asked what he thought was intelligent for a machine. The professor reputedly answered that if a vending machine gave him the right change, that would be intelligent.  

Later, playing chess was considered intelligent. However, computers can now defeat grandmasters at chess, and people are no longer saying that it is a form of intelligence.   

Now we have OCR. It's already stated in <a href="https://ai.stackexchange.com/a/1402/66">another answer</a> that our methods do not have the recognition facilities of a 5 year old. As soon as this is achieved, people will say "meh, that's not intelligence, a 5 year old can do that!"  

A psychological bias, a need to state that we are somehow superior to machines, is at the basis of this.  

#### Answer 2 (score 11)
Although OCR is now a mainstream technology, it remains true that none our methods genuinely have the recognition facilities of a 5 year old (claimed success with CAPTCHAs notwithstanding). We don't know how to achieve this using well-understood techniques, so OCR should still rightfully be considered an AI problem.  

<p>To see why this might be so, it is illuminating to read the essay
<a href="https://web.stanford.edu/group/SHR/4-2/text/hofstadter.html">"On seeing A's and seeing AS"</a> by Douglas Hofstadter.</p>

With respect to a point made in another answer, the agent framing is a useful one insofar as it motivates success in increasingly complex environments. However, there are many hard problems (e.g. Bongard) that don't need to be stated in such a fashion.   

#### Answer 3 (score 4)
I'm not sure if predicting MNIST can be really considered as an AI task. AI problems can be usually framed under the context of an agent acting in an environment. Neural nets and machine learning techniques in general do not have to deal with this framing. Classifiers for example, are learning a mapping between two spaces. Though one could argue that you <em>can</em> frame OCR/image classification as an AI problem - the classifier is the agent, each prediction it makes is an action, and it receives rewards based on its classification accuracy - this is rather unnatural and different from problems that are commonly considered AI problems.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Is Prolog still used in AI? (score [5304](https://stackoverflow.com/q/1531) in )

#### Question
According to <a href="http://en.wikipedia.org/wiki/Prolog">Wikipedia</a>,  

<blockquote>
  Prolog is a general-purpose logic programming language associated with artificial intelligence and computational linguistics.  
</blockquote>

Is it still used for AI?  

<hr>

<sub>This is based off of a question on the 2014 closed beta. The author had the UID of 330.</sub>  

#### Answer accepted (score 14)
Remembering that artificial intelligence has been an academic endeavour for the longest time, Prolog was amongst one of the early languages used as part of the study and implementation of it. It has rarely made its way into large commercial applications, having said that, a famous commercial implementation is in <a href="http://www.cs.nmsu.edu/ALP/2011/03/natural-language-processing-with-prolog-in-the-ibm-watson-system/" rel="noreferrer">Watson, where prolog is used for NLP</a>.  

The <a href="http://www.ed.ac.uk/informatics/" rel="noreferrer">University of Edinburgh</a> contributed to the language and it was sometimes referred to as "Edinburgh Prolog". It is <a href="http://www.inf.ed.ac.uk/teaching/courses/lp/" rel="noreferrer">still used in academic teachings</a> there as part of the artificial intelligence course.  

The reason why Prolog is considered powerful in AI is because the language allows for easy management of recursive methods, and pattern matching.  

To quote <a href="http://www-03.ibm.com/innovation/us/watson/research-team/systems.html" rel="noreferrer">Adam Lally from the IBM Thomas J. Watson Research Center</a>, and <a href="http://www3.cs.stonybrook.edu/~pfodor/" rel="noreferrer">Paul Fodor from Stony Brook University</a>:  

<blockquote>
  the Prolog language is very expressive allowing recursive rules to represent reachability in parse trees and the operation of negation-as-failure to check the absence of conditions.  
</blockquote>

#### Answer 2 (score 11)
Yes, as mentioned in other answers, Prolog is actually used in IBM Watson.  Prolog doesn't get much "hype" and "buzz" these days, but it is absolutely still used.  As always, it has certain specific areas where it shines, and specific techniques that map well to its use.  Specifically, things like <a href="https://en.wikipedia.org/wiki/Inductive_logic_programming" rel="noreferrer">Inductive Logic Programming</a>, <a href="https://en.wikipedia.org/wiki/Constraint_logic_programming" rel="noreferrer">Constraint Logic Programming</a>, <a href="https://en.wikipedia.org/wiki/Answer_set_programming" rel="noreferrer">Answer Set Programming</a> and some <a href="https://en.wikipedia.org/wiki/Natural_language_processing" rel="noreferrer">NLP</a> applications may involve extensive use of Prolog.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: What are the latest 'hot' research topics for deep learning and AI? (score [5271](https://stackoverflow.com/q/5763) in 2018)

#### Question
I did my Master's thesis on Deep Generative Models and I'm currently looking for a new subject.  

<strong>Q:</strong> What are the "hottest" research topics that are taking a lot of attention of the deep learning community lately?  

A few clarifications:  

<ul>
<li>I did look through similar questions and none of them answered my
question.</li>
<li>I come from a pure mathematical background, I only
transitioned into deep learning a year ago, and my research on
generative models was mostly theoretical. Which means, most of my
work revolved around structured probabilistic models, and approximate
inference. That said, I have yet to explore real world applications of deep learning.</li>
<li>I did my homework before posing the question. My goal was to get ai SE's input on the matter and see what people are working on.</li>
</ul>

#### Answer accepted (score 5)
The hot topics of today might be the cold, wet ashes of tomorrow.  For instance, the convergence speed of CNN and LSTM approaches, especially in combination, have diverted considerable attention away from basic RNN designs.  

Similarly, the cold topics of today might be the burning embers of tomorrow. Of course, some of the cold topics will stay cold.  The sweet spot may be to identify those that are getting warmer and are likely to be sustainable building blocks future technology.  

<strong>Residual Attention Networks</strong>  

Residual attention networks, like LSTM networks, are an improvement over RNNs using a different approach.  Because attention networks are designed to conserve resources, they either converge faster or with less demand on hardware and network to support parallel execution.  

<ul>
<li><a href="http://openaccess.thecvf.com/content_cvpr_2017/papers/Wang_Residual_Attention_Network_CVPR_2017_paper.pdf" rel="nofollow noreferrer"><em>Residual Attention Network for Image Classification</em>, Fei Wang et al, 2017</a></li>
<li><a href="http://openaccess.thecvf.com/content_cvpr_2017/papers/Fu_Look_Closer_to_CVPR_2017_paper.pdf" rel="nofollow noreferrer"><em>Look Closer to See Better: Recurrent Attention Convolutional Neural
Network for Fine-grained Image Recognition</em>, Jianlong Fu et all, 2017</a></li>
<li><a href="https://ieeexplore.ieee.org/abstract/document/7974787/" rel="nofollow noreferrer"><em>VideoWhisper: Toward Discriminative Unsupervised Video Feature Learning With Attention-Based Recurrent Neural Networks</em>, Na Zhao, 2017</a></li>
<li><a href="https://arxiv.org/abs/1701.07149" rel="nofollow noreferrer"><em>Hierarchical Recurrent Attention Network for Response Generation
Chen Xing</em>, Wei Wu et al, 2017</a></li>
</ul>

<strong>Automated Development of Non-Cartesian Models</strong>  

Research into the automation of modelling is key to many AI applications.  Some of the algorithms under development do not simply extract tensors of features (arrays, matrices, cubes, and hyper-cubes), but develop graph models, directed or associative, with or without cycles permitted.  

<ul>
<li><a href="https://www.researchgate.net/profile/Zahra_Gharaee/publication/311373779_Hierarchical_Self-Organizing_Maps_System_for_Action_Classification/links/58c91c2b45851591df49e99b/Hierarchical-Self-Organizing-Maps-System-for-Action-Classification.pdf" rel="nofollow noreferrer"><em>Hierarchical Self-organizing Maps System for Action Classification</em>
Z Gharaee, P Gärdenfors, M Johnsson, ICAART, 2017</a></li>
<li><a href="http://dspace.library.uvic.ca/bitstream/handle/1828/8833/Castaneda_Lorena_PhD_2017.pdf" rel="nofollow noreferrer"><em>Runtime Modelling for User-Centric Smart Cyber-Physical-Human Applications</em>, Lorena Castañeda Bueno, 2017</a></li>
<li><a href="https://doi.org/10.1371/journal.pone.0118394" rel="nofollow noreferrer"><em>Probing the Topological Properties of Complex Networks Modeling Short Written Texts</em>, Diego R. Amancio, 2015</a></li>
<li><a href="http://sisinflab.poliba.it/publications/2017/RTMDPMD17/Schema-summarization%20in%20Linked-Data-based%20feature%20selection%20for%20recommender%20systems.pdf" rel="nofollow noreferrer"><em>Schema-summarization in Linked-Data-based feature selection for recommender systems</em>, Azzurra Ragone et. al., 2017</a></li>
</ul>

<strong>Signal Topologies That Support Equilibria</strong>  

Many ignore the importance of GANs, not because they can do interesting things with images but because of how they deviate from the simple topology of signal path where convergence on a trained set of parameters is achieved over a one-dimensional array of layers and blocks of layers.  

The discriminative and generative components in GAN design are described in some detail in <a href="https://ai.stackexchange.com/questions/3488/understanding-gan-loss-function/7130#7130">another AI Stack Exchange question on *Understanding the GAN Loss FUnction</a>.  Although the generation of images from the GAN approach and its conceptual children demonstrate a new capability in the artificial network space, the breadth of this multi-network significance may not be immediately obvious.  It is not a stack in depth of layers, but a stack of two deep networks in a figure-eight topology, conceptually much like a Möbius strip.  

This topology creates a balance between two networks, the generative (G) and the discriminative (D).  Its designer termed it an adversarial relationship because G and D play opposing roles.  However, their action in the system is actually collaborative, creating a balance that is much like a chemical equilibrium or symbiosis in biology, so that a specific objective is achieved.  This may reveal the most promising direction in AI today.  

Designing signal topologies that support additional forms of collaboration and symbiosis between networks, where each network is a component that learns its roll in conjunction with other component networks, so that the aggregate system learns its function can synthesize forms of artificial intelligence that DNNs cannot.  

Rules based systems and deep networks are one dimensional in terms of signal flow.  By themselves may never approximate the most notable features of the human brain.  

<strong>Parallel Processing Using GPUs as DSPs</strong>  

VLSI implementations of spiking networks is important, and there are now implementations such as <a href="https://github.com/Hananel-Hazan/bindsnet" rel="nofollow noreferrer">https://github.com/Hananel-Hazan/bindsnet</a> that leverage GPU hardware acceleration to investigate them without access to the VLSI chips being developed by large corporations.  

<strong>Speech Recognition and Synthesis for End-to-End TTS</strong>  

The recent emergence of excellence in synthesis using systems such as Google's WaveNet have opened the door to more accurate TTS (text to sound) applications, such that it is probably a good time to become an expert in voice recording for use in training example sets but a bad time to start a custom speech production house using live speakers.  

<strong>Automated Vehicles</strong>  

Automated vehicles of various types need experts in vehicle physics, automotive manufacture, aeronautics, and consumer products for a wide range of vehicle types with strong economic and safety incentives driving semi-automation and full automation.  

<ul>
<li>Mars landers</li>
<li>Consumer drones</li>
<li>Industrial drones</li>
<li>Military drones</li>
<li>Passenger aircraft</li>
<li>Passenger automobiles</li>
<li>Limos</li>
<li>Trains</li>
<li>Wheel chairs</li>
<li>Delivery vehicles</li>
<li>Automated food distribution</li>
<li>Nuclear plant repair robots</li>
<li>Electrical distribution repair robots</li>
</ul>

<strong>Summary</strong>  

It may be difficult to discover in advance what of hot technologies in AI will remain dominant in five years or which of the warming technologies will be blazing hot then, but the above are solid technologies showing significant early promise and for which there are high business, industrial, and consumer demands.  

#### Answer 2 (score 1)
Well, there're certainly a lot of areas where you can contribute in research. Since you're saying you did a Master Thesis in deep Generative models, I assume you're comfortable in Machine and Deep Learning.  

Digital Epidemiology is one of the areas where you can certainly apply deep learning. It's still a relatively new field compared to other branches of computational biology. An example would be to see the impact of online digital record on the prediction and further prevalence of diseases.   

Such online record can be received from different search engines, social media sites, and sometimes Government agencies. For Example, you can see <a href="https://trends.google.com/trends/explore?q=skin%20cancer" rel="nofollow noreferrer">here</a> an example of search term "Skin Cancer" and the corresponding record shows the interest of this term across the Globe, this data can be used to find new Hypotheses. For example, if the data shows that we have more interest from a specific region of the world/country, that may show that the specific disease is more common in that region/part/country of the world. Similar hypotheses can be built, drawn and tested. And For sure,deep learning can improve the accuracy of traditional models used in validation of such Hypotheses.  

Another interesting area of research may be the comparison of Long Short Term Neural Networks against the traditional time series models. I don't believe there exists a mature research on this area. Maybe you can start from this good blog <a href="https://machinelearningmastery.com/time-series-prediction-lstm-recurrent-neural-networks-python-keras/" rel="nofollow noreferrer">here</a>.  

Signal Processing maybe another very interesting, and also very practical area to build and validate theories on top of Deep Learning models. However, Mathematics in Signal Processing can be pretty hard to get. All of these options, however will require you to work in a team with people from the specific domains. That is if you want to produce high quality research.  

Other areas may be NLP , especially the case of language translation from Hindi to Urdu or Persian, online digital marketing, behavioral sciences, manufacturing and investment. Specific areas of research maybe improved further if you know experts from these fields.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How could self-driving cars make ethical decisions about who to kill? (score [5183](https://stackoverflow.com/q/111) in 2019)

#### Question
Obviously, self-driving cars aren't perfect, so imagine that the Google car (as an example) got into a difficult situation.  

Here are a few examples of unfortunate situations caused by a set of events:  

<ul>
<li>The car is heading toward a crowd of 10 people crossing the road, so it cannot stop in time, but it can avoid killing 10 people by hitting the wall (killing the passengers),</li>
<li>Avoiding killing the rider of the motorcycle considering that the probability of survival is greater for the passenger of the car,</li>
<li>Killing an animal on the street in favour of a human being,</li>
<li>Changing lanes to crash into another car to avoid killing a dog,</li>
</ul>

And here are a few dilemmas:  

<ul>
<li>Does the algorithm recognize the difference between a human being and an animal?</li>
<li>Does the size of the human being or animal matter?</li>
<li>Does it count how many passengers it has vs. people in the front?</li>
<li>Does it "know" when babies/children are on board?</li>
<li>Does it take into the account the age (e.g. killing the older first)?</li>
</ul>

How would an algorithm decide what should it do from the technical perspective? Is it being aware of above (counting the probability of kills), or not (killing people just to avoid its own destruction)?  

Related articles:  

<ul>
<li><a href="https://www.technologyreview.com/s/542626/why-self-driving-cars-must-be-programmed-to-kill/" rel="noreferrer">Why Self-Driving Cars Must Be Programmed to Kill</a></li>
<li><a href="https://www.technologyreview.com/s/539731/how-to-help-self-driving-cars-make-ethical-decisions/" rel="noreferrer">How to Help Self-Driving Cars Make Ethical Decisions</a></li>
</ul>

#### Answer accepted (score 54)
<blockquote>
  How could self-driving cars make ethical decisions about who to kill?  
</blockquote>

It shouldn't. Self-driving cars are not moral agents. Cars fail in predictable ways. Horses fail in predictable ways.   

<blockquote>
  <p>the car is heading toward a crowd of 10 people crossing the road, so
  it cannot stop in time, but it can avoid killing 10 people by hitting
  the wall (killing the passengers),</p>
</blockquote>

In this case, the car should slam on the brakes. If the 10 people die, that's just unfortunate. We simply cannot <em>trust</em> all of our beliefs about what is taking place outside the car. What if those 10 people are really robots made to <em>look</em> like people? What if they're <em>trying</em> to kill you?  

<blockquote>
  <p>avoiding killing the rider of the motorcycle considering that the
  probability of survival is greater for the passenger of the car,</p>
</blockquote>

Again, hard-coding these kinds of sentiments into a vehicle opens the rider of the vehicle up to all kinds of attacks, including <em>"fake"</em> motorcyclists. Humans are <em>barely</em> equipped to make these decisions on their own, if at all. When it doubt, just slam on the brakes.  

<blockquote>
  killing animal on the street in favour of human being,  
</blockquote>

Again, just hit the brakes. What if it was a baby? What if it was a bomb?  

<blockquote>
  changing lanes to crash into another car to avoid killing a dog,  
</blockquote>

Nope. The dog was in the wrong place at the wrong time. The other car wasn't. Just slam on the brakes, as safely as possible.  

<blockquote>
  Does the algorithm recognize the difference between a human being and an animal?  
</blockquote>

Does a human? Not always. What if the human has a gun? What if the animal has large teeth? Is there no context?  

<blockquote>
  <ul>
  <li>Does the size of the human being or animal matter?</li>
  <li>Does it count how many passengers it has vs. people in the front?</li>
  <li>Does it "know" when babies/children are on board?</li>
  <li>Does it take into the account the age (e.g. killing the older first)?</li>
  </ul>
</blockquote>

Humans can't agree on these things. If you ask a cop what to do in any of these situations, the answer won't be, "You should have swerved left, weighed all the relevant parties in your head, assessed the relevant ages between all parties, then veered slightly right, and you would have saved 8% more lives." No, the cop will just say, "You should have brought the vehicle to a stop, as quickly and safely as possible." Why? Because cops know people normally aren't equipped to deal with high-speed crash scenarios.  

Our target for "self-driving car" should not be 'a moral agent on par with a human.' It should be an agent with the reactive complexity of cockroach, which fails predictably.  

#### Answer 2 (score 48)
The answer to a lot of those questions depends on how the device is programmed. A computer capable of driving around and recognizing where the road goes is likely to have the ability to visually distinguish a human from an animal, whether that be based on outline, image, or size. With sufficiently sharp image recognition, it might be able to count the number and kind of people in another vehicle. It could even use existing data on the likelihood of injury to people in different kinds of vehicles.  

Ultimately, people disagree on the ethical choices involved. Perhaps there could be "ethics settings" for the user/owner to configure, like "consider life count only" vs. "younger lives are more valuable." I personally would think it's not terribly controversial that a machine should damage itself before harming a human, but people disagree on how important pet lives are. If explicit kill-this-first settings make people uneasy, the answers could be determined from a questionnaire given to the user.  

#### Answer 3 (score 26)
Personally, I think this might be an overhyped issue. Trolley problems only occur when the situation is optimized to prevent "3rd options".  

A car has brakes, does it not? "But what if the brakes don't work?" Well, then <strong>the car is not allowed to drive at all.</strong> Even in regular traffic, human operators are taught that your speed should be limited as such that you can stop within the area you can see. Solutions like these will reduce the possibility of a trolley problem.  

As for animals... if there is no explicit effort to deal with humans on the road I think animals will be treated the same. This sounds implausible - roadkill happens often and human "roadkill" is unwanted, but animals are a lot smaller and harder to see than humans, so I think detecting humans will be easier, preventing a lot of the accidents.  

In other cases (bugs, faults while driving, multiple failures stacked onto each other), perhaps accidents will occur, they'll be analysed, and vehicles will be updated to avoid causing similar situations.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: What are the limitations of the hill climbing algorithm and how to overcome them? (score [5170](https://stackoverflow.com/q/8986) in 2019)

#### Question
What are the limitations of the <em>hill climbing algorithm</em>? How can we overcome these limitations?  

#### Answer accepted (score 6)
As @nbro has already said that Hill Climbing is a family of <strong>local search algorithms</strong>. So, when you said Hill Climbing in the question I have assumed you are talking about the standard hill climbing. The standard version of hill climb has some limitations and often gets stuck in the following scenario:  

<ul>
<li>Local Maxima: Hill-climbing algorithm reaching on the vicinity a local maximum value, gets drawn towards the peak and gets stuck there, <em>having no other place to go</em>.</li>
<li>Ridges: These are <em>sequences of local maxima</em>, making it difficult for the algorithm to navigate.</li>
<li>Plateaux: This is a <em>flat state-space region</em>. As there is no uphill to go, algorithm often gets lost in the plateau.
<br></li>
</ul>

To resolve these issues many variants of hill climb algorithms have been developed. These are most commonly used:  

<ul>
<li><strong>Stochastic Hill Climbing</strong> selects at random from the uphill moves. The probability of selection varies with the steepness of the uphill move.</li>
<li><strong>First-Choice Climbing</strong> implements the above one by generating successors randomly until a better one is found.</li>
<li><strong>Random-restart hill climbing</strong> searches from randomly generated initial moves until the goal state is reached.</li>
</ul>

<p>The success of hill climb algorithms depends on the architecture of the state-space landscape. Whenever there are few maxima and plateaux the variants of hill climb searching algorithms work very fine. But in real-world problems have a landscape that looks more like a widely scattered family of balding porcupines on a flat floor, with miniature porcupines living on the tip of each porcupine needle (as described in the 4th Chapter of the book Artificial Intelligence: A Modern Approach). NP-Hard problems typically have an exponential number of local maxima to get stuck on.<br>
Given algorithms have been developed to overcome these kinds of issues:</p>

<ul>
<li>Stimulated Annealing</li>
<li>Local Beam Search</li>
<li>Genetic Algorithms</li>
</ul>

Reference <a href="https://rads.stackoverflow.com/amzn/click/0136042597" rel="noreferrer">Book - Artificial Intelligence: A Modern Approach</a>  

#### Answer 2 (score 5)
<a href="https://github.com/aimacode/aima-pseudocode/blob/master/md/Hill-Climbing.md" rel="noreferrer">Hill climbing</a> is not an algorithm, but a family of "local search" algorithms. Specific algorithms which fall into the category of "hill climbing" algorithms are 2-opt, 3-opt, 2.5-opt, 4-opt, or, in general, any N-opt. See chapter 3 of the paper "<a href="http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.92.1635&amp;rep=rep1&amp;type=pdf" rel="noreferrer"><em>The Traveling Salesman Problem: A Case Study in Local Optimization</em></a>" (by David S. Johnson and Lyle A. McGeoch) for more details regarding some of these local search algorithms (applied to the TSP).   

What differentiates one algorithm in this category from the other is the "neighbourhood function" they use (in simple words, the way they find neighbouring solutions to a given solution). Note that, in practice, this is not always the case: often these algorithms have several different implementations.  

The most evident limitation of hill climbing algorithms is due to their nature, that is, they are local search algorithms. Hence they usually just find <em>local</em> maxima (or minima). So, if any of these algorithms has already converged to a local minimum (or maximum) and, in the solution or search space, there is, close to this found solution, a better solution, none of these algorithms will be able to find this better solution. They will basically be trapped.  

Local search algorithms are not usually used alone. They are used as sub-routines of other meta-heuristic algorithms, like simulated annealing, iterated-local search or in any of the ant-colony algorithms. So, to overcome their limitations, we usually do not use them alone, but we use them in conjunction with other algorithms, which have a probabilistic nature and can find global minima or maxima (e.g., any of the ant-colony algorithms).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Why is Sanskrit the best language for AI? (score [5151](https://stackoverflow.com/q/2429) in 2019)

#### Question
According to NASA scientist Rick Briggs, Sanskrit is the best language for AI. I want to know how Sanskrit is useful. What's the problem with other languages? Are they really using Sanskrit in AI programming or going to do so? What part of an AI program requires such language?  

#### Answer 2 (score 14)
Rick Briggs refers to the difficulty an artificial intelligence would have in detecting the true meaning of words spoken or written in one of our natural languages. Take for example an artificial intelligence attempting to determine the meaning of a sarcastic sentence.   

Naturally spoken, the sentence "That's just what I needed today!" can be the expression of very different feelings. In one instance, a happy individual finding an item that had been lost for some time could be excited or cheered up from the event, and exclaim that this moment of triumph was exactly what their day needed to continue to be happy. On the other hand, a disgruntled office employee having a rough day could accidentally worsen his situation by spilling hot coffee on himself, and sarcastically exclaim that this further annoyance was exactly what he needed today. This sentence should in this situation be interpreted as the man expressing that spilling coffee on himself made his bad day worse.  

This is one small example explaining the reason linguistic analysis is difficult for artificial intelligence. When this example is spoken, small tonal fluctuations and indicators are extremely difficult for an AI with a microphone to detect accurately; and if the sentence was simply read, without context how <em>would</em> one example be discernible from the other?  

Rick Briggs suggests that Sanskrit, an ancient form of communication, is a naturally spoken language with mechanics and grammatical rules that would allow an artificial intelligence to more accurately interpret sentences during linguistic analysis. More accurate linguistic analysis would result in an artificial intelligence being able to respond more accurately. You can read more about Rick Brigg's thoughts on the language <a href="http://vedicsciences.net/articles/sanskrit-nasa.html" rel="noreferrer">here</a>.  

#### Answer 3 (score 6)
<p>Adding some to what Christian said. Facts taken from the book, <a href="http://aima.cs.berkeley.edu/" rel="noreferrer">Artificial Intelligence: A Modern Approach</a><br>
<a href="https://en.wikipedia.org/wiki/B._F._Skinner" rel="noreferrer">Burrhus Frederic Skinner</a>, a psychologist and behaviourist, published his book <a href="https://en.wikipedia.org/wiki/Verbal_Behavior" rel="noreferrer">Verbal Behaviour</a> in 1957. His work contains the detailed account of the behaviourist approach to language learning.<br><br>
Noam Chomsky later wrote a review on the book, which for some reason became more famous than the book itself. Chomsky has his own theory of Syntactic Structures for this. He even mentioned that the behaviourist theory did not address the notion of creativity in language as it did not explain how a child could understand and make up sentences that he/she has never heard before. <strong>His theory based on syntactic models are dated back to Indian linguist <a href="https://en.wikipedia.org/wiki/P%C4%81%E1%B9%87ini" rel="noreferrer">Panini</a> (350 B.C.) who was an ancient Sanskrit philologist, grammarian, and a revered scholar</strong>.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Why did ML only become viable after Nvidia's chips were available? (score [4977](https://stackoverflow.com/q/13233) in 2019)

#### Question
I listened to a talk by panel consisted of two influential Chinese scientists: <a href="https://sites.google.com/site/gangwang6/" rel="nofollow noreferrer">Wang Gang</a> and <a href="https://www.crunchbase.com/person/kai-yu#section-overview" rel="nofollow noreferrer">Yu Kai</a> and others.  

When being asked about the biggest bottleneck of the development of artificial intelligence in the near future (3 to 5 years), Yu Kai, who has a background in the hardware industry, said that hardware would be the essential problem and we should pay most of our attention to that. He gave us two examples:  

<ol>
<li>In the early development of the computer, we compare our machines by its chips;</li>
<li>Artificial intelligence which is very popular these years would be almost impossible if not empowered by Nvidia's GPU.</li>
</ol>

The fundamental algorithms existed already in the 1980s and 1990s, but artificial intelligence went through 3 AI winters and was not empirical until we can train models with GPU boosted mega servers.  

Then Dr. Wang commented to his opinions that we should also develop software systems because we cannot build an automatic car even if we have combined all GPUs and computation in the world together.   

Then, as usual, my mind wandered off and I started thinking that what if those who can operate supercomputers in the 1980s and 1990s utilized the then-existing neural network algorithms and train them with tons of scientific data? Some people at that time can obviously attempt to build AI systems we are building now. But why did AI become a hot topic and become empirical until decades later? Is it only a matter of hardware, software and data?  

#### Answer accepted (score 14)
There is a lot of factors for the boom of AI industry. What many people miss though is the boom has mostly been in the Machine Learning part of AI. This can be attributed to various simple reasons along with their comparisons during earlier times:  

<ul>
<li><strong>Mathematics</strong>:  The maths behind ML algorithms are pretty simple and known for a long time (whether it would work or not was not known though). During earlier times it was not possible to implement algorithms which require high precision of numbers, to be calculated on a chip, in an acceptable amount of time. One of the main arithmetic operations division of numbers still takes a lot of cycles in modern processors. Older processors were magnitude times slower than modern processors (more than 100x), this bottleneck made it impossible to train sophisticated models on contemporary processors.</li>
<li><strong>Precision</strong>: Precision in calculations is an important factor in ML algorithms. 32 bit precision in processor was made in the 80's and was probably commercially available in the late 90's (<a href="https://en.wikipedia.org/wiki/Intel_8086" rel="noreferrer">x86</a>), but it was still hella slow than current processors. This resulted in scientists improvising on the precision part and the most basic Perceptron Learning Algorithm invented in the 1960's to train a classifier uses only <span class="math-container">$1$</span>'s and <span class="math-container">$0$</span>'s, so basically a binary classifier. It was run on <a href="https://en.wikipedia.org/wiki/Perceptron" rel="noreferrer">special computers</a>. Although, it is interesting to note that we have come a full circle and Google is now using <a href="https://en.wikipedia.org/wiki/Tensor_processing_unit" rel="noreferrer">TPU's</a> with 8-16 bit accuracy to implement ML models with great success.</li>
<li><strong>Parallelization</strong> : The concept of parallelization of matrix operations is nothing new. It was only when we started to see Deep Learning as just a set of matrix operations we realized that it can be easily parallelized on massively parallel GPU's, still if your ML algorithm is not inherently parallel then it hardly matters whether you use CPU or GPU (e.g. RNN's).</li>
<li><strong>Data</strong>: Probably the biggest cause in the ML boom. The Internet has provided opportunities to collect huge amounts of data from users and also make it available to interested parties. Since an ML algorithm is just a function approximator based on data, therefore data is the single most important thing in a ML algorithm. The more the data the better the performance of your model.</li>
<li><strong>Cost</strong>: The cost of training a ML model has gone down significantly. So using a Supercomputer to train a model might be fine, but was it worth it? Super computers unlike normal PC's are tremendously resource hungry in terms of cooling, space, etc. A recent <a href="https://www.technologyreview.com/s/613630/training-a-single-ai-model-can-emit-as-much-carbon-as-five-cars-in-their-lifetimes/" rel="noreferrer">article</a> on MIT Technology Review points out the carbon footprint of training a Deep Learning model (sub-branch of ML). It is quite a good indicator why it would have been infeasible to train on Supercomputers in earlier times (considering modern processors consume much lesser power and gives higher speeds).
Although, I am not sure but I think earlier supercomputers were specialised in "parallel+very high precision computing" (required for weather, astronomy, military applications, etc) and the "very high precison part" is overkill in Machine Learning scenario.</li>
</ul>

Another important aspect is nowadays everyone has access to powerful computers. Thus, anyone can build new ML models, re-train pre-existing models, modify models, etc. This was quite not possible during earlier times,   

All this factors has led to a huge surge in interest in ML and has caused the boom we are seeing today. Also check out this <a href="https://ai.stackexchange.com/questions/7328/if-digital-values-are-mere-estimates-why-not-return-to-analog-for-ai/">question</a> on how we are moving beyond digital processors.  

#### Answer 2 (score 2)
GPUs were ideal for AI boom becouse  

<ul>
<li>They hit the right time</li>
</ul>

AI has been researched for a LONG time. Almost half a century. However, that was all exploration of how would algorithms work and look. When NV saw that the AI is about to go mainstream, they looked at their GPUs and realized that the huge parellel processing power, with relative ease of programing, is ideal for the era that is to be. Many other people realized that too.  

<ul>
<li>GPUs are sort of general purpose accelerators</li>
</ul>

GPGPU is a concept of using GPU parallel processing for general tasks. You can accelerate graphics, or make your algorithm utalize 1000s of cores available on GPU. That makes GPU awesome target for all kinds of use cases including AI. Given that they are already available and are not too hard to program, its ideal choice for accelerating AI algorithms.  

#### Answer 3 (score 0)
Sorry, but Artificial Intelligence wasn't invented yet. In the FIRST Lego League, the robots aren't able to drive on a simple line, in the DARPA robotics challenge the humanoid robots struggle to open the valve, and the Tesla Autopilot isn't recommended for real traffic situations. The only situation in which deeplearning works is on the powerpoint slides in which the accuracy to detect a cat is 100%, but in reality the normal image search engines doesn't find anything.  

Let us go a step backward: what kind of AI application is available today? Right, nothing. The only control system which is available in reality is the normal refrigerator which holds the temperature at 5 degree, but this has nothing to do with machine learning but with a thermostat.  

The reason why Deeplearning is available everywhere is not because it's a powerful technology for detecting images, but because it's part of the curriculum to teach humans. Deeplearning means, that the human should learn something about statistics, python programming and edge detection algorithm. Not computers will become smarter but students.  

<strong>Books about the subject</strong>  

Even if Deeplearning itself isn't a very powerful technique to control robots, the amount and the quality of books about the subject is great. Since the year 2010 lots of mainstream publications were published which helped to introduce Artificial Intelligence into a larger audience. All of them have something with GPU supported neural networks in the title and they are explaining very well what image recognition, motion planning and speech recognition is. Even if the readers decides not using machine learning at all but realize a robot project with the conventional paradigm he will profit from reading the newly created tutorials.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Is artificial intelligence vulnerable to hacking? (score [4898](https://stackoverflow.com/q/6800) in 2019)

#### Question
The paper <a href="https://arxiv.org/pdf/1511.07528.pdf" rel="nofollow noreferrer"><em>The Limitations of Deep Learning in Adversarial Settings</em></a> explores how neural networks might be corrupted by an attacker who can manipulate the data set that the neural network trains with. The authors experiment with a neural network meant to read handwritten digits, undermining its reading ability by distorting the samples of handwritten digits that the neural network is trained with.  

I'm concerned that malicious actors might try hacking AI. For example  

<ul>
<li>Fooling autonomous vehicles to misinterpret stop signs vs. speed limit.</li>
<li>Bypassing facial recognition, such as the ones for ATM.</li>
<li>Bypassing spam filters.</li>
<li>Fooling sentiment analysis of movie reviews, hotels, etc.</li>
<li>Bypassing anomaly detection engines.</li>
<li>Faking voice commands.</li>
<li>Misclassifying machine learning based-medical predictions.</li>
</ul>

What adversarial effect could disrupt the world? How we can prevent it?  

#### Answer 2 (score 19)
AI is vulnerable from two security perspectives the way I see it:   

<ol>
<li><p>The classic method of exploiting outright programmatic errors to achieve some sort of code execution on the machine that is running the AI or to extract data.</p></li>
<li><p>Trickery through the equivalent of AI optical illusions for the particular form of data that the system is designed to deal with.</p></li>
</ol>

The first has to be mitigated in the same way as any other software. I'm uncertain if AI is any more vulnerable on this front than other software, I'd be inclined to think that the complexity maybe slightly heightens the risk.  

The second is probably best mitigated by both the careful refinement of the system as noted in some of the other answers, but also by making the system more context-sensitive; many adversarial techniques rely on the input being assessed in a vacuum.   

#### Answer 3 (score 7)
<h5>Programmer vs Programmer</h2>

It's a "infinity war": Programmers vs Programmers. All thing can be hackable. Prevention is linked to the level of knowledge of the professional in charge of security and programmers in application security.  

<strong>eg</strong> There are several ways to identify a user trying to mess up the metrics generated by Sentiment Analysis, but there are ways to circumvent those steps as well. It's a pretty boring fight.  

<h5>Agent vs Agent</h2>

An interesting point that @DukeZhou raised is the evolution of this war, involving two artificial intelligence (agents). In that case, the battle is one of the most knowledgeable. Which is the best-trained model, you know?  

However, to achieve perfection in the issue of vulnerability, artificial intelligence or artificial super intelligence surpass the ability to circumvent the human. It is as if the knowledge of all hacks to this day already existed in the mind of this agent and he began to develop new ways of circumventing his own system and developing protection. Complex, right?  

I believe it's hard to have an AI who thinks: "Will the human going to use a photo instead of putting his face to be identified?"  

<h5>How we can prevent it</h2>

Always having a human supervising the machine, and yet it will not be 100% effective. This disregarding the possibility that an agent can improve his own model alone.  

<h5>Conclusion</h2>

So I think the scenario works this way: a programmer tries to circumvent the validations of an AI and the IA developer acquiring knowledge through logs and tests tries to build a smarter and safer model trying to reduce the chances of failure.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How is gradient calculated for middle layer weights? (score [4827](https://stackoverflow.com/q/5580) in 2018)

#### Question
I am trying to understand backpropagation. I used a simple neural network with one input <strong><em>x</em></strong>, one hidden layer <strong><em>h</em></strong> and one output layer <strong>y</strong>, with weight <strong><em>w1</em></strong> connecting <strong><em>x</em></strong> to <strong><em>h</em></strong>, and <strong><em>w2</em></strong> connecting <strong><em>h</em></strong> to <strong><em>y</em></strong>.  

<blockquote>
  x--[w1]--> h --[w2]-->y  
</blockquote>

In my understanding these are the steps happening while we train a neural network:  

<a href="https://i.stack.imgur.com/sGToV.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/sGToV.png" alt="enter image description here"></a>  

I understood most parts of backpropogation, but how do we get the gradients for the middle layer weights `dL/dw1`?  

EDIT  

```text
Latex

\\
Feed \ forwarding \\
h=\sigma (xw_{1}+b) \\ 
{y}'=\sigma (hw_{2}+b) \\ \\
Loss \ function \\ 
L=\frac{1}{2}\sum(y-{y}')^{2} \\ \\ 
Gradient \ calculation \\ \\
\frac{\partial L}{\partial w_{2}}=\frac{\partial {y}'}{\partial w_{2}}\frac{\partial L }{\partial {y}'} \\ \\ 
\frac{\partial L}{\partial w_{1}}= \frac{\partial h}{\partial w_{1}} \frac{\partial {y}'}{\partial h} \frac{\partial L}{\partial {y}'}   \\ \\ % DuttaA's solution
Weight \ update \\ 
w_{i}^{t+1} \leftarrow w_{i}^{t}-\alpha \frac{\partial L}{\partial w_{i}}
```

<p>How should we calculate gradient of a network similar to this?
<a href="https://i.stack.imgur.com/P5fce.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/P5fce.png" alt="enter image description here"></a></p>

is this the correct equation?  

<a href="https://i.stack.imgur.com/aOjdc.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/aOjdc.png" alt="enter image description here"></a>  

Latex format  

```text
\frac{\partial L}{\partial w_{1}}=\frac{\partial h_{1}}{\partial w_{1}}\frac{\partial w_7}{\partial h_{1}}\frac{\partial o_2}{\partial w_{7}}\frac{\partial L}{\partial o_{2}}  + \frac{\partial h_{1}}{\partial w_{1}}\frac{\partial w_5}{\partial h_{1}}\frac{\partial o_1}{\partial w_{5}}\frac{\partial L}{\partial o_{1}}
```

#### Answer accepted (score 2)
So, the main doubt here is about the intuition behind the derivative part of back-propagation learning. First, I would like to point out 2 links about the intuition about how partial derivatives work <a href="https://math.stackexchange.com/questions/62614/chain-rule-intuition">Chain Rule Intuition</a> and <a href="https://math.stackexchange.com/questions/423/intuitive-reasoning-behind-the-chain-rule-in-multiple-variables/426">Intuitive reasoning behind the Chain Rule in multiple variables?</a>.  

Now that we know how the chain rule works, lets see how we can use it in Machine Learning. So basically in machine learning the final output is a function of input variables and the connection weights `f(x_1, x_2...x_n, w_1, w_2...w_n)` where `f` encloses all the activation functions and dot products lying between input and output. The `x_1, x_2...x_n, w_1, w_2...w_n` are called independent variables because they don't affect each other pairwise as well as in groups meaning you cannot find a function `g(x_i..., w_i...) =  h(x_j...,w_j..)`  So basically its a black box from input to output.  

<a href="https://i.stack.imgur.com/TIp3X.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/TIp3X.jpg" alt="enter image description here"></a>  

So now our purpose is to minimize the Loss/Cost function, by changing the parameters that can be 'controlled by us' i.e the weights only, we cannot change the input variables. So this is done by taking the derivative of the cost function w.r.t to the variable that 'can be changed'. <a href="https://www.khanacademy.org/math/multivariable-calculus/multivariable-derivatives/gradient-and-directional-derivatives/v/why-the-gradient-is-the-direction-of-steepest-ascent" rel="nofollow noreferrer">Here</a> is an explanation of why taking derivative and subsequently subtracting it reduces the value of cost function given by 'maximal' amount. Also <a href="https://math.stackexchange.com/questions/462592/trouble-with-gradient-intuition">here</a>.  

Now, to calculate `dL/dw_n` you have to keep few things in mind:  

<ul>
<li>Only differentiate `L` w.r.t to those functions which affect `L`.</li>
<li>And to reach to your end goal of differentiation w.r.t to an independent variable you must differentiate `L` w.r.t to those functions only which are dependent on that particular independent variable.</li>
</ul>

A crude algorithm assuming 'L' also as a normal function (along the lines of activation function, so that I can express the idea recursively) differentiate `f_n` w.r.t to functions in the previous layer say `f_n-1, f_n-2, w_n`. Check which of these functions depend on `w_1`. Only `f_n-1` and `f_n-2` do. Differentiate them again w.r.t to previous layer functions. Check again and go on till you reach `w_1`.  

This approach is the fool-proof version, but it has 2 flaws:  

<ul>
<li>First, `w_n` is not a function. People are making this mistake of assuming `w_n` to be a function due to misinterpretation of a simple NN diagram. To reach`w_1` you don't need to go through `w_n`. But you definitely need to go through the activation functions and dot products. Think of this as painting a wall where color mixing occurs (not over-writing). So you paint the wall with some color (weights) then 2nd color and so on. Is the final product affected by color 1. Yes. Is the 'rate of change' caused by color 1 also affected by color 2. Yes. But does it mean we can find the 'change'of color n w.r.t to color 1? No its meaningless (bad example, couldn't think of a better one)</li>
<li>The second flaw is that this approach is not followed because with experience it is apparent which function affects whom and which independent variable affects which function (saves computation).</li>
</ul>

To answer your question the equation is incorrect and the correct equation will be:  

<a href="https://i.stack.imgur.com/HCun0.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/HCun0.png" alt="enter image description here"></a>  

I have simply followed the algorithm I have given above.  

As for why your equation is wrong, your equation contains the term `dw7/dh1`. Does `w7` vary with `h1`? This means that `w7` is directly related to the input as `h1` is related with the input, but this is not the case for a single iteration(the whole algorithm run makes `wn` dependent on the inputs since you are trying to minimize the loss function w.r.t given inputs and weights, for a different set of inputs you will have different final weights).  

So in a nutshell, the aim of back-propagation is to identify the change in Loss function w.r.t to a given weights. To calculate that you have to make sure in the chain rule of derivative you don't have any meaningless terms like derivative of an independent variable w.r.t to any function. I recommend checking <a href="https://www.khanacademy.org/math/multivariable-calculus/multivariable-derivatives/partial-derivatives/v/partial-derivatives-introduction" rel="nofollow noreferrer">Khan Academy</a> for a better understanding and clarity in concepts as I think the intuitions are hard to provide in a written answer.  

#### Answer 2 (score 0)
I'd recommend studying a bit of calculus, and reading about the <a href="https://www.khanacademy.org/math/ap-calculus-ab/ab-derivative-rules/ab-chain-rule/v/chain-rule-introduction" rel="nofollow noreferrer">chain rule</a>.  <br>  

<p><hr>
Short Explanation: <br></p>

<p>we have f(y) and y(x)<br>
df/dx = df/dy * dy/dx<br>
this is the chain rule, it can be applied many times.<br>
if we have f(y), y(z), z(x)<br>
df/xd = df/dy * dy/dx<br>
dy/dx = dy/dz * dz/dx<br>
so df/xd = df/dy * dy/dz * dz/dx chain!! :)<br></p>

<p>for your example:<br>
dl/dw1 = dl/dy' * dy'/dh * dh/dw1<br></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: What are the current theories on developing a conscious AI? (score [4798](https://stackoverflow.com/q/5274) in 2018)

#### Question
Is most development or theory geared towards the idea that consciousness is an emergent phenomenon? That once we put enough complexity into our system, it will become self-aware? Or is this even a problem that people are attempting to tackle right now?   

#### Answer 2 (score 28)
<p>To answer this question, first we need to know why developing conscious AI is hard. 
The main reason is that there is no mathematically or otherwise rigorous definition of consciousness. 
Sure you have an idea of consciousness as you experience it and we can talk about philosophical zombies but it isn’t a tangible concept that can be broken down and worked on. 
Moreover, the majority of current research in AI is primarily a pragmatic approach in that one is trying to construct a model that can perform well according to some desired cost function. This is a very very big and exciting field and encompasses many research problems and every new finding is based either on mathematical theory or empirical evidence of a new algorithm/model construction/etc. 
Because of this, progress is based on and compared against previous progress as it is the scientific method. </p>

So to answer your question, no one is trying to actually make a “conscious” AI because we don’t know what that word means yet, however that doesn’t stop people talking about it.  

#### Answer 3 (score 7)
<strong>What is consciousness?</strong> There are some real challenges in setting up consciousness as a goal, because we don't have that much scientific understanding yet of how the brain does it or what balance there needs to be between long-term memory, short-term memory, the implicit work of interpretation, the contrasting conscious modes of automatic processing and deliberate processing (Khanemann's S1 and S2). John Kihlstrom (psychology emeritus at Berkeley) has a lecture set on Consciousness available in iTunesU that you might check out. Carnegie-Mellon Uni has a model called ACT-R which directly models conscious behaviours like attention-paying.  

<strong>What might bound our understanding of it?</strong> Philosophy has been considering the question of consciousness for a long time. Personally I like Hegel and Heidegger (philosophers). Both are very difficult to read, but Heidegger (interpreted by Hubert Dreyfus) usefully critiqued the 'Good Old-Fashioned AI' projects of the seventies and pointed out how <strong>much</strong> work there is just interpreting a visual input. Hegel is often maligned, but to see him well interpreted, check out Robert Brandom's talks to LMU on the logic of consciousness and Hegel as an early Sellers-ian pragmatist. If consciousness is to take hold of the truth and the certainty, it undertakes 'a path of doubt, or more properly a highway of despair', along which it never sets itself above correction. There is something about Hegel's treatment of consciousness in recursive terms, without succumbing to a vicious regress, that I think is going to be borne out before the end.  

<strong>Recent developments.</strong> The Deep Learning approaches and pragmatic successes of the present are exciting, but it will be interesting to see how far they can go in integrating and generalising from necessarily the small information sets actual human minds are exposed to.  While Deep Learning and data mining are hugely visible, symbolic approaches are also out there still getting better and more varied. But there is a lack of overarching theoretical interpretation that would allow generalisations.  

<strong>Two big-theory toe-holds.</strong> If I had to pick a project I thought worth attending to, Giulio Tononi (et al) have set up a very nice modernisation of the problem in '<a href="https://en.wikipedia.org/wiki/Integrated_information_theory" rel="noreferrer">Integrated Information Theory</a>' But you might want to extend that with something like <a href="https://en.wikipedia.org/wiki/Rolf_Pfeifer" rel="noreferrer">Rolf Pfeifer</a>'s 'How the body shapes the way we think', because some of the 'integrated information' is implicit in having arms and legs, eyes and nose (put there by the information accumulating work of evolution.) But there's so much good work that has been done - the pros are writing papers faster than I can read them.  

More specific to your question, there are attempts to <a href="https://www.humanbrainproject.eu/en/brain-simulation/" rel="noreferrer">simulate human brains</a> hoping that overall aim will help fund research and produce answers to each para above.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: How do I choose which algorithm is best for something like a checkers board game? (score [4718](https://stackoverflow.com/q/7159) in 2018)

#### Question
I am currently new to artificial intelligence but I am very intrigued by it. I am currently researching three algorithms, namely:  

Minimax, Alpha-beta pruning and Monte Carlo tree search.  

As you may have figured out, these are all tree search algorithms. My question is simple. How do I choose which algorithm is best for something like a checkers board game?  

<p>N.B.
The reason why I only chose these three algorithms was due to time I have available in understanding them. From a little research, I found that these algorithms are basically interweaved into the minimax algorithm. So if I can understand one, then the other two will just fall into place.</p>

#### Answer 2 (score 13)
<strong>tl;dr:</strong>  

<ul>
<li><p>None of these algorithms are practical for modern work, but they are good places to start pedagogically. </p></li>
<li><p>You should always prefer to use Alpha-Beta pruning over bare minimax search.</p></li>
<li><p>You should prefer to use some form of heuristic guided search if you can come up with a useful heuristic. Coming up with a useful heuristic usually requires a lot of domain knowledge.</p></li>
<li><p>You should prefer to use Monte Carlo Tree search when you lack a good heuristic, when computational resources are limited, and when mistakes will not have outsize real-world consequences.</p></li>
</ul>

<strong>More Details:</strong>  

In minimax search, we do not attempt to be very clever. We just use a standard dynamic programming approach. It is easy to figure out the value of difference moves if we're close to the end of the game (since the game will end in the next move, we don't have to look very far ahead). Similarly, if we know what our opponent will do in the last move of the game, it's easy to figure out what we should do in the second last move. Effectively we can treat the second last move as the last move of a shorter game. We can then repeat this process. Using this approach is certain to uncover the best strategies in a standard extensive-form game, but will require us to consider every possible move, which is infeasible for all but the simplest games.  

Alpha-Beta pruning is a strict improvement on Minimax search. It makes use of the fact that some moves are obviously worse than others. For example, in chess, I need not consider any move that would give you the <em>opportunity</em> to put me in checkmate, even if you could do other things from that position. Once I see that a move might lead to a lose, I'm not going to bother thinking about what else might happen from that point. I'll go look at other things. This algorithm is also certain to yield the correct result, and is faster, but still must consider most of the moves in practice.  

There are two common ways you can get around the extreme computational cost of solving these kinds of games exactly:  

<ol>
<li><p>Use a Heuristic (A* search is the usual algorithm for pedagogical purposes, but Quiescence search is a similar idea in 2 player games). This is just a function that gives an <em>estimate</em> of the value of a state of the game. Instead of considering all the moves in a game, you can just consider moves out to some finite distance ahead, and then use the value of the heuristic to judge the value of the states you reached. If your heuristic is consistent (essentially: if it always <em>overestimates</em> the quality of states), then this will still yield the correct answer, but with enormous speedups in practice.</p></li>
<li><p>Use Rollouts (like Monte Carlo Tree Search). Basically, instead of considering every move, run a few thousand simulated games between players acting randomly (this is faster than considering all possible moves). Assign a value to states equal to the average win rate of games starting from it. This may not yield the correct answer, but in some kinds of games, it performs reliably. It is often used as an extension of more exact techniques, rather than being used on its own.</p></li>
</ol>

#### Answer 3 (score 5)
<blockquote>
  N.B The reason why I only chose these three algorithms was due to time I have available in understanding them. From a little research, I found that these algorithms are basically interweaved into the minimax algorithm. So if I can understand one then the other two will just fall into place.  
</blockquote>

<strong>Given this context, I would recommend starting out with Minimax</strong>. Of the three algorithms, Minimax is the easiest to understand.  

<strong>Alpha-Beta</strong>, as others have mentioned in other answers, is a strict improvement on top of Minimax. Minimax is basically a part of the Alpha-Beta implementation, and a good understanding of Alpha-Beta requires starting out with a good understanding of Minimax anyway. If you happen to have time left after understanding and implementing Minimax, I'd recommend moving on to Alpha-Beta afterwards and building that on top of Minimax. Starting out with Alpha-Beta if you do not yet understand Minimax doesn't really make sense.  

<strong>Monte-Carlo Tree Search</strong> is probably a bit more advanced and more complicated to really, deeply understand. In the past decade or so, MCTS really has been growing to be much more popular than the other two, so from that point of view understanding MCTS may be more "useful".   

The connection between Minimax and MCTS is less direct/obvious than the connection between Minimax and Alpha-Beta, but there still is a connection at least on a conceptual level. <strong>I'd argue that having a good understanding of Minimax first is still beneficial before diving into MCTS</strong>; in particular, understanding Minimax and its flaws/weak points can provide useful context / help you understand why MCTS became "necessary" / popular.  

<hr>

To conclude, in my opinion:  

<ul>
<li>Alpha-Beta is strictly better than Minimax, but also strongly related / built on top of Minimax; so, start with Minimax, go for Alpha-Beta afterwards if time permits</li>
<li>MCTS has different strengths/weaknesses, is often better than Alpha-Beta in "modern" problems (but not always), a good understanding of Minimax will likely be beneficial before starting to dive into MCTS</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How is it possible that deep neural networks are so easily fooled? (score [4713](https://stackoverflow.com/q/92) in 2017)

#### Question
The following <a href="http://www.evolvingai.org/fooling" rel="noreferrer">page</a>/<a href="http://www.evolvingai.org/files/DNNsEasilyFooled_cvpr15.pdf" rel="noreferrer">study</a> demonstrates that the deep neural networks are easily fooled by giving high confidence predictions for unrecognisable images, e.g.  

<a href="https://i.stack.imgur.com/7pgrH.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/7pgrH.jpg" alt="Evolved images that are unrecognisable to humans, but that state-of-the-art DNNs trained on ImageNet believe with &gt;= 99.6% certainty to be a familiar object. This result highlights differences between how DNNs and humans recognise objects. Directly and indirectly encoded images"></a>  

<a href="https://i.stack.imgur.com/pBm48.png" rel="noreferrer"><img src="https://i.stack.imgur.com/pBm48.png" alt="Evolving images to match DNN classes produces a tremendous diversity of images. The mean DNN confidence scores for these images is 99.12% for the listed class, meaning that the DNN believes with near-certainty that the image is that type of thing. Shown are images selected to showcase diversity from 5 independent evolutionary runs. The images shed light on what the DNN network cares about, and what it does not, when classifying an image. For example, a school bus is alternating yellow and black lines, but does not need to have a windshield or wheels"></a>  

How this is possible? Can you please explain ideally in plain English?  

#### Answer accepted (score 51)
First up, those images (even the first few) aren't complete trash despite being junk to humans; they're actually finely tuned with various advanced techniques, including another neural network.  

<blockquote>
  The deep neural network is the pre-trained network modeled on AlexNet provided by <a href="https://github.com/BVLC/caffe">Caffe</a>. To evolve images, both the directly encoded and indirectly encoded images, we use the <a href="https://github.com/jbmouret/sferes2">Sferes</a> evolutionary framework. The entire code base to conduct the evolutionary experiments can be download [sic] <a href="https://github.com/Evolving-AI-Lab/fooling">here</a>. The code for the images produced by gradient ascent is available <a href="https://github.com/Evolving-AI-Lab/fooling/tree/master/caffe/ascent">here</a>.  
</blockquote>

Images that are actually random junk were correctly recognized as nothing meaningful:  

<blockquote>
  In response to an unrecognizable image, the networks could have output a low confidence for each of the 1000 classes, instead of an extremely high confidence value for one of the classes. In fact, they do just that for randomly generated images (e.g. those in generation 0 of the evolutionary run)  
</blockquote>

The original goal of the researchers was to use the neural networks to automatically generate images that look like the real things (by getting the recognizer's feedback and trying to change the image to get a more confident result), but they ended up creating the above art. Notice how even in the static-like images there are little splotches - usually near the center - which, it's fair to say, are triggering the recognition.  

<blockquote>
  We were not trying to produce adversarial, unrecognizable images. Instead, we were trying to produce recognizable images, but these unrecognizable images emerged.  
</blockquote>

Evidently, these images had just the right distinguishing features to match what the AI looked for in pictures. The "paddle" image does have a paddle-like shape, the "bagel" is round and the right color, the "projector" image is a camera-lens-like thing, the "computer keyboard" is a bunch of rectangles (like the individual keys), and the "chainlink fence" legitimately looks like a chain-link fence to me.  

<blockquote>
  Figure 8. Evolving images to match DNN classes produces a tremendous diversity of images. Shown are images selected to showcase diversity from 5 evolutionary runs. The diversity suggests that the images are non-random, but that instead evolutions producing [sic] discriminative features of each target class.  
</blockquote>

Further reading: <a href="http://www.evolvingai.org/files/DNNsEasilyFooled_cvpr15.pdf">the original paper</a> (large PDF)  

#### Answer 2 (score 25)
The images that you provided may be unrecognizable for us. They are actually the images that we recognize but evolved using the <a href="https://github.com/sferes2/sferes2" rel="noreferrer">Sferes</a> evolutionary framework.  

While these images are almost impossible for humans to label with anything but abstract arts, the Deep Neural Network will label them to be familiar objects with 99.99% confidence.  

This result highlights differences between how DNNs and humans recognize objects. Images are either directly (or indirectly) encoded  

According to this <a href="https://youtu.be/M2IebCN9Ht4" rel="noreferrer">video</a>  

<blockquote>
  Changing an image originally correctly classified in a way imperceptible to humans can cause the cause DNN to classify it as something else.  
  
  <p>In the image below the number at the bottom are the images are supposed to look like the digits
  But the network believes the images at the top (the one like white noise) are real digits with 99.99% certainty.</p>
</blockquote>

<img src="https://i.stack.imgur.com/Jx1wX.png" alt="enter image description here">  

<blockquote>
  <p>The main reason why these are easily fooled is that Deep Neural Network does not see the world in the same way as human vision. We use the whole image to identify things while DNN depends on the features. As long as DNN detects certain features, it will classify the image as a familiar object it has been trained on.
  The researchers proposed one way to prevent such fooling by adding the fooling images to the dataset in a new class and training DNN on the enlarged dataset. In the experiment, the confidence score decreases significantly for ImageNet AlexNet. It is not easy to fool the retrained DNN this time. But when the researchers applied such method to MNIST LeNet, evolution still produces many unrecognizable images with confidence scores of 99.99%.</p>
</blockquote>

More details <a href="http://www.evolvingai.org/fooling" rel="noreferrer">here</a> and <a href="http://www.kdnuggets.com/2015/01/deep-learning-can-be-easily-fooled.html" rel="noreferrer">here</a>.  

#### Answer 3 (score 13)
All answers here are great, but, for some reason, nothing has been said so far on why this effect <em>should not surprise</em> you. I'll fill the blank.  

Let me start with one requirement that is absolutely essential for this to work: the attacker <em>must know neural network architecture</em> (number of layers, size of each layer, etc). Moreover, in all cases that I examined myself, the attacker knows the snapshot of the model that is used in production, i.e. all weights. In other words, the "source code" of the network isn't a secret.  

<p>You can't fool a neural network if you treat it like a black box. And you can't reuse the same fooling image for different networks. 
In fact, you have to "train" the target network yourself, and here by training I mean to run forward and backprop passes, but specially crafted for another purpose.</p>

<h5>Why is it working at all?</h3>

Now, here's the intuition. Images are very high dimensional: even the space of small 32x32 color images has `3 * 32 * 32 = 3072` dimensions. But the training data set is relatively small and contains real pictures, all of which have some structure and nice statistical properties (e.g. smoothness of color). So the training data set is located on a tiny manifold of this huge space of images.   

The convolutional networks work extremely well on this manifold, but basically, know nothing about the rest of the space. The classification of the points outside of the manifold is just a linear extrapolation based on the points inside the manifold. No wonder that some particular points are extrapolated incorrectly. The attacker only needs a way to navigate to the closest of these points.  

<h5>Example</h3>

Let me give you a concrete example how to fool a neural network. To make it compact, I'm going to use a very simple logistic regression network with one nonlinearity (sigmoid). It takes a 10-dimensional input `x`, computes a single number `p=sigmoid(W.dot(x))`, which is the probability of class 1 (versus class 0).  

<img src="https://i.stack.imgur.com/i3mO7.png" alt="logistic regression">  

Suppose you know `W=(-1, -1, 1, -1, 1, -1, 1, 1, -1, 1)` and start with an input `x=(2, -1, 3, -2, 2, 2, 1, -4, 5, 1)`. A forward pass gives `sigmoid(W.dot(x))=0.0474` or 95% probability that `x` is class 0 example.    

<img src="https://i.stack.imgur.com/V6cNn.png" alt="x and W">  

We'd like to find another example, `y`, which is very close to `x` but is classified by the network as 1. Note that `x` is 10-dimensional, so we have the freedom to nudge 10 values, which is a lot.   

<p>Since `W[0]=-1` is negative, it's better for to have a small `y[0]` to make a total contribution of `y[0]*W[0]` small. Hence, let's make `y[0]=x[0]-0.5=1.5`.
Likewise, `W[2]=1` is positive, so it's better to increase `y[2]` to make `y[2]*W[2]` bigger: `y[2]=x[2]+0.5=3.5`. And so on.</p>

<img src="https://i.stack.imgur.com/8zs12.png" alt="x, W and y">  

The result is `y=(1.5, -1.5, 3.5, -2.5, 2.5, 1.5, 1.5, -3.5, 4.5, 1.5)`, and `sigmoid(W.dot(y))=0.88`. With this one change we improved the class 1 probability from 5% to 88%!  

<h5>Generalization</h3>

If you look closely at the previous example, you'll notice that I knew exactly how to tweak `x` in order to move it to the target class, because I knew the network gradient. What I did was actually a <em>backpropagation</em>, but with respect to the data, instead of weights.  

In general, the attacker starts with target distribution `(0, 0, ..., 1, 0, ..., 0)` (zero everywhere, except for the class it wants to achieve), backpropagates to the data and makes a tiny move in that direction. Network state is not updated.  

Now it should be clear that it's a common feature of feed-forward networks that deal with a small data manifold, no matter how deep it is or the nature of data (image, audio, video or text).  

<h5>Potection</h3>

<p>The simplest way to prevent the system from being fooled is to use an ensemble of neural networks, i.e. a system that aggregates the votes of several networks on each request.
It's much more difficult to backpropagate with respect to several networks simultaneously. The attacker might try to do it sequentially, one network at a time, but the update for one network might easily mess up
with the results obtained for another network. The more networks are used, the more complex an attack becomes.</p>

Another possibility is to smooth the input before passing it to the network.  

<h5>Positive use of the same idea</h3>

You shouldn't think that backpropagation to the image has only negative applications. A very similar technique, called <em>deconvolution</em>, is used for visualization and better understanding what neurons have learned.  

This technique allows synthesizing an image that causes a particular neuron to fire, basically see visually "what the neuron is looking for", which in general makes convolutional neural networks more interpretable.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How do we choose the kernel size depending on the problem? (score [4670](https://stackoverflow.com/q/3321) in 2019)

#### Question
Obviously, finding suitable hyper-parameters for a neural network is a complex task and very problem or domain-specific. However, there should be at least some "rules" that hold most times for filter kernel size?!  

In most cases, intuition should be to go for small kernel filters for detecting high-frequency features and large kernel filters for low-frequency features, right? For example, 3x3 kernel filters for edge detection, color contrast stuff, ... and maybe rather something like 11x11 for whole object detection, when the objects are >= 11x11 pixels.  

Is this "intuition" more or less generally true? How can we decide which kernel filter sizes should be chosen for a specific problem - or even for one specific convolutional layer?  

#### Answer 2 (score 2)
Take a look at <a href="https://cs.nyu.edu/~fergus/papers/zeilerECCV2014.pdf" rel="nofollow noreferrer">this article</a>. It give tools to actually understand what your filters have learn and show what you can do next to optimize your hyper-parameters. Also check more recent articles that seek to provide interpretations of what NN learn.   

#### Answer 3 (score 1)
One key to the answer is in the question, "Even for one specific conv layer."  It is not a good idea to build deep convolution networks on the assumption that a single kernel size most aptly applies to all layers.  When perusing the configurations that proved successful in publications, it becomes apparent that configurations that varying through their layers are more commonly found to be optimal.  

The other key is to understand that two layers of 11x11 kernels have a 21x21 reach, and ten layers of 5x5 kernels have a 41x41 reach.  A mapping from one level of abstraction to the next need not be completed in one layer.  

Generalities regarding kernel sizes exist, but they are functions of the typical input characteristics, the desired output of the network, the computing resources available, resolution, size of the data set, and whether they are still images or movies.  

Regarding input characteristics, consider this case: The images are shot with a large depth of field under poor lighting conditions, such as in security scenarios, so the aperture of the lens is wide open, causing objects at some ranges of distance to be out of focus, or there can be motion blur.  

Under such conditions a single 3x3 kernel will not detect many edges.  If the edge may span five pixels, the choice exists as to how many layers are dedicated to its detection.  What factors affect that choice is based on what other characteristics exist in the input data.  

Expect that as acceleration hardware develops (in VLSI chips dedicated to this purpose) that the computing resource constraints will decrease in priority as a factor in kernel size selection.  Currently, the computation time is significant and forces the decision about how to balance layer count and layer size to be mostly a matter of cost.  

This question begs another question.  Can an oversight machine learner learn how to automatically balance the configuration of deep convolution networks?  It could then be re-executed whenever additional computing resources are provisioned.  It would be surprising if there weren't at least a dozen labs working on exactly this capability.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Policy gradients for multiple continuous actions (score [4537](https://stackoverflow.com/q/4085) in 2019)

#### Question
Question is regarding Deep Reinforcement Learning using Policy Gradients.  

Cutting edge policy gradients algorithms are TRPO (Trusted Region Policy Optimization) and PPO (Proximal Policy Optimization).  

When using single continuous action then normally you would use some random distribution (for example Gaussian) for the loss function. The rough version is:  

$L(\theta) = log(P(a_1)) * A$  

Where $A$ is the advantage of rewards $P(a_1)$ is characterized by $\mu$ and $\sigma^2$ that comes out of neural network like in Pendulum environment here: <a href="https://github.com/leomzhong/DeepReinforcementLearningCourse/blob/69e573cd88faec7e9cf900da8eeef08c57dec0f0/hw4/main.py" rel="noreferrer">https://github.com/leomzhong/DeepReinforcementLearningCourse/blob/69e573cd88faec7e9cf900da8eeef08c57dec0f0/hw4/main.py</a>  

Problem is that I cannot find any paper on 2+ continuous actions using policy gradients (not Actor-critic methods that use a different approach by transferring gradient from Q-Function).   

<p>Do you know how to do this using TRPO for 2 continuous actions in LunarLander environment? 
<a href="https://gym.openai.com/envs/LunarLanderContinuous-v2/" rel="noreferrer">https://gym.openai.com/envs/LunarLanderContinuous-v2/</a></p>

Is following approach correct for policy gradient loss function?  

$L(\theta) = (log(P(a_1))+log(P(a_2)))*A$  

#### Answer accepted (score 6)
As you has said, actions chosen by Actor-Critic typically come from a normal distribution and it is the agent's job to find the appropriate mean and standard deviation based on the the current state. In many cases this one distribution is enough because only 1 continuous action is required. However, as domains such as robotics become more integrated with AI, situations where 2 or more continuous actions are required are a growing problem.  

<p>There are 2 solutions to this problem:
The first and most common is that for every continuous action, there is a separate agent learning its own 1-dimensional mean and standard deviation. Part of its state includes the actions of the other agents as well to give context of what the entire system is doing. We commonly do this in my lab and <a href="https://sites.ualberta.ca/~pilarski/docs/papers/Pilarski_2013_ICORR_Postprint.pdf" rel="nofollow noreferrer">here is a paper which describes this approach</a> with 3 actor-critic agents working together to move a robotic arm. </p>

The second approach is to have one agent find a <a href="https://en.wikipedia.org/wiki/Multivariate_normal_distribution" rel="nofollow noreferrer">multivariate (usually normal) distribution</a> of a policy. Although in theory, this approach could have a more concise policy distribution by "rotating" the distribution based on the co-variance matrix, it means that all of the values of the co-variance matrix must be learned as well. This increases the number of values that must be learned to have $n$ continuous outputs from $2n$ (mean and stddev), to $n+n^2$ ($n$ means and an $n \times n$ co-variance matrix). This drawback has made this approach not as popular in the literature.  

This is a more general answer but should help you and others on their related problems.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: What is the relation between Q-learning and policy gradients methods? (score [4501](https://stackoverflow.com/q/6196) in 2019)

#### Question
As far as I understand, Q-learning and policy gradients (PG) are the two major approaches used to solve RL problems. While Q-learning aims to predict the reward of a certain action taken in a certain state, policy gradients directly predict the action itself.  

However, both approaches appear identical to me, i.e. predicting the maximum reward for an action (Q-learning) is equivalent to predicting the probability of taking the action directly (PG). Is the difference in the way the loss is back-propagated?  

#### Answer 2 (score 18)
<blockquote>
  However, both approaches appear identical to me i.e. predicting the maximum reward for an action (Q-learning) is equivalent to predicting the probability of taking the action directly (PG).  
</blockquote>

Both methods are theoretically driven by the <a href="https://en.wikipedia.org/wiki/Markov_decision_process" rel="noreferrer">Markov Decision Process</a> construct, and as a result use similar notation and concepts. In addition, in simple solvable environments you should expect both methods to result in the same - or at least equivalent - optimal policies.  

However, they are actually different internally. The most fundamental differences between the approaches is in how they approach action selection, both whilst learning, and as the output (the learned policy). In Q-learning, the goal is to learn a single deterministic action from a discrete set of actions by finding the maximum value. With policy gradients, and other direct policy searches, the goal is to learn a map from state to action, which can be stochastic, and works in continuous action spaces.  

As a result, policy gradient methods can solve problems that value-based methods cannot:  

<ul>
<li><p>Large and continuous action space. However, with value-based methods, this can still be approximated with discretisation - and this is not a bad choice, since the mapping function in policy gradient has to be some kind of approximator in practice.</p></li>
<li><p>Stochastic policies. A value-based method cannot solve an environment where the optimal policy is stochastic requiring specific probabilities, such as Scissor/Paper/Stone. That is because there are no trainable parameters in Q-learning that control probabilities of action, the problem formulation in TD learning assumes that a deterministic agent can be optimal.</p></li>
</ul>

However, value-based methods like Q-learning have some advantages too:  

<ul>
<li><p>Simplicity. You can implement Q functions as simple discrete tables, and this gives some guarantees of convergence. There are no tabular versions of policy gradient, because you need a mapping function <span class="math-container">$p(a \mid s, \theta)$</span> which also must have a smooth gradient with respect to <span class="math-container">$\theta$</span>.</p></li>
<li><p>Speed. TD learning methods that bootstrap are often much faster to learn a policy than methods which must purely sample from the environment in order to evaluate progress.</p></li>
</ul>

There are other reasons why you might care to use one or other approach:  

<ul>
<li><p>You may want to know the predicted return whilst the process is running, to help other planning processes associated with the agent.</p></li>
<li><p>The state representation of the problem lends itself more easily to either a value function or a policy function. A value function may turn out to have very simple relationship to the state and the policy function very complex and hard to learn, or <em>vice-versa</em>.</p></li>
</ul>

Some state-of-the-art RL solvers actually use both approaches together, such as Actor-Critic. This combines strengths of value and policy gradient methods.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: What is the fundamental difference between CNN and RNN? (score [4476](https://stackoverflow.com/q/4683) in 2019)

#### Question
What is the fundamental difference between convolutional neural networks and recurrent neural networks? Where are they applied?  

#### Answer 2 (score 6)
Basically, a CNN saves a set of weights and applies them spatially. For example, in a layer, I could have 32 sets of weights (also called feature maps). Each set of weights is a 3x3 block, meaning I have 3x3x32=288 weights for that layer. If you gave me an input image, for each 3x3 map, I slide it across all the pixels in the image, multiplying the regions together. I repeat this for all 32 feature maps, and pass the outputs on. So, I am learning a few weights that I can apply at a lot of locations.  

For an RNN, it is a set of weights applied temporally (through time). An input comes in, and is multiplied by the weight. The networks saves an internal state and puts out some sort of output. Then, the next piece of data comes in, and is multiplied by the weight. However, the internal state that was created from the last piece of data also comes in and is multiplied by a different weight. Those are added and the output comes from an activation applied to the sum, times another weight. The internal state is updated, and the process repeats.  

CNN's work really well for computer vision. At the low levels, you often want to find things like vertical and horizontal lines. Those kinds of things are going to be all over the images, so it makes sense to have weights that you can apply anywhere in the images.  

RNN's are really good for natural language processing. You can imagine that the next word in a sentence will be highly influenced by the ones that came before it, so it makes sense to carry that internal state forward and have a small set of weights that can apply to any input.  

However, there are many more applications. In addition, CNN's have performed well on NLP tasks. There are also more advanced versions of RNN's called LSTM's that you could check out.  

For an explanation of CNN's, go to the <a href="http://cs231n.stanford.edu/syllabus.html" rel="noreferrer">Stanford CS231n course</a>. Especially check out lecture 5. There are full class videos on YouTube.  

For an explanation of RNN's, go <a href="http://www.wildml.com/2015/09/recurrent-neural-networks-tutorial-part-1-introduction-to-rnns/" rel="noreferrer">here</a>.  

#### Answer 3 (score 4)
<strong><a href="https://ai.stackexchange.com/a/12043/2444">Recurrent neural networks</a></strong> (RNNs) are artificial neural networks (ANNs) that have one or more recurrent (or cyclic) connections, as opposed to just having feed-forward connections, like a feed-forward neural network (FFNN).   

These cyclic connections are used to keep track of temporal relations or dependencies between the elements of a sequence. Hence, RNNs are suited for sequence prediction or related tasks.  

In the picture below, you can observe an RNN on the left (that contains only one hidden unit) that is equivalent to the RNN on the right, which is its "unfolded" version. For example, we can observe that <span class="math-container">$\bf h_1$</span> (the hidden unit at time step <span class="math-container">$t=1$</span>) receives both an input <span class="math-container">$\bf x_1$</span> and the value of the hidden unit at the previous time step, that is, <span class="math-container">$\bf h_0$</span>.   

<a href="https://i.stack.imgur.com/7HI1R.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/7HI1R.png" alt="enter image description here"></a>  

The cyclic connections (or the weights of the cyclic edges), like the feed-forward connections, are learned using an optimisation algorithm (like gradient descent) often combined with back-propagation (which is used to compute the gradient of the loss function).  

<strong>Convolutional neural networks</strong> (CNNs) are ANNs that perform one or more <a href="https://en.wikipedia.org/wiki/Convolution" rel="nofollow noreferrer">convolution</a> (or <a href="https://en.wikipedia.org/wiki/Cross-correlation" rel="nofollow noreferrer">cross-correlation</a>) operations (often followed by a <a href="https://en.wikipedia.org/wiki/Downsampling_(signal_processing)" rel="nofollow noreferrer">down-sampling</a> operation).   

<p>The convolution is an operation that takes two functions, <span class="math-container">$\bf f$</span> and <span class="math-container">$\bf h$</span>, as input and produces a third function, <span class="math-container">$\bf g = f \circledast h$</span>, where the symbol <span class="math-container">$\circledast$</span> denotes the convolution operation. In the context of CNNs, the input function <span class="math-container">$\bf f$</span> can e.g. be an image (which can be thought of as a function from 2D coordinates to RGB or grayscale values). The other function <span class="math-container">$\bf h$</span> is called the "kernel" (or filter), which can be thought of as (small and square) matrix (which contains the output of the function <span class="math-container">$\bf 
 h$</span>). <span class="math-container">$\bf f$</span> can also be thought of as a (big) matrix (which contains, for each cell, e.g. its grayscale value).</p>

In the context of CNNs, the <em>convolution</em> operation can be thought of as dot product between the kernel <span class="math-container">$\bf h$</span> (a matrix) and several parts of the input (a matrix).  

In the picture below, we perform an <a href="https://en.wikipedia.org/wiki/Hadamard_product_(matrices)" rel="nofollow noreferrer"><em>element-wise multiplication</em></a> between the kernel <span class="math-container">$\bf h$</span> and part of the input <span class="math-container">$\bf h$</span>, then we sum the elements of the resulting matrix, and that is the value of the convolution operation for that specific part of the input.   

<a href="https://i.stack.imgur.com/EiujB.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/EiujB.png" alt="enter image description here"></a>  

To be more concrete, in the picture above, we are performing the following operation  

<p><span class="math-container">\begin{align}
\sum_{ij}
\left(
\begin{bmatrix}
1 &amp; 0 &amp; 0\\
1 &amp; 1 &amp; 0\\
1 &amp; 1 &amp; 1
\end{bmatrix}
\otimes
\begin{bmatrix}
1 &amp; 0 &amp; 1\\
0 &amp; 1 &amp; 0\\
1 &amp; 0 &amp; 1
\end{bmatrix}
\right)
=
\sum_{ij}
\begin{bmatrix}
1 &amp; 0 &amp; 0\\
0 &amp; 1 &amp; 0\\
1 &amp; 0 &amp; 1
\end{bmatrix}
= 4
\end{align}</span></p>

where <span class="math-container">$\otimes$</span> is the element-wise multiplication and the summation <span class="math-container">$\sum_{ij}$</span> is over all rows <span class="math-container">$i$</span> and columns <span class="math-container">$j$</span> (of the matrices).  

To compute all elements of <span class="math-container">$\bf g$</span>, we can think of the kernel <span class="math-container">$\bf h$</span> as being slided over the matrix <span class="math-container">$\bf f$</span>.  

In general, the kernel function <span class="math-container">$\bf h$</span> can be fixed. However, in the context of CNNs, the kernel <span class="math-container">$\bf h$</span> represents the learnable parameters of the CNN: in other words, during the training procedure (using e.g. gradient descent and back-propagation), this kernel <span class="math-container">$\bf h$</span> (which thus can be thought of as a matrix of weights) changes.   

In the context of CNNs, there is often more than one kernel: in other words, it is often the case that a sequence of kernels <span class="math-container">$\bf h_1, h_2, \dots, h_k$</span> is applied to <span class="math-container">$\bf f$</span> to produce a sequence of convolutions <span class="math-container">$\bf g_1, g_2, \dots, g_k$</span>. Each kernel <span class="math-container">$\bf h_i$</span> is used to "detect different features of the input", so these kernels are different from each other.  

A <em>down-sampling</em> operation is an operation that reduces the input size while attempting to maintain as much information as possible. For example, if the input size is a <span class="math-container">$2 \times 2$</span> matrix <span class="math-container">$\bf f = \begin{bmatrix} 1 &amp; 2 \\ 3 &amp; 0 \end{bmatrix}$</span>, a common down-sampling operation is called the <em>max-pooling</em>, which, in the case of <span class="math-container">$\bf f$</span>, returns <span class="math-container">$3$</span> (the maximum element of <span class="math-container">$\bf f$</span>).  

CNNs are particularly suited to deal with high-dimensional inputs (e.g. images), because, compared to FFNNs, they use a smaller number of learnable parameters (which, in the context of CNNs, are the kernels). So, they are often used to e.g. classify images.  

<strong>What is the fundamental difference between RNNs and CNNs?</strong> RNNs have recurrent connections while CNNs do not necessarily have them. The fundamental operation of a CNN is the convolution operation, which is not present in a standard RNN.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: Which machine learning algorithm can be used for pattern recognition? (score [4422](https://stackoverflow.com/q/2926) in 2019)

#### Question
I need a machine learning algorithm to identify any patterns in a CSV file, which contains details of a cache performance of a CPU workload. More specifically, the CSV file contains columns like `Readhits`, `Readmiss` or `Writehits`.  

Which ML algorithms can I use?  

#### Answer 2 (score 0)
<blockquote>
  I need a machine learning algorithm to identify any patterns in a CSV file  
</blockquote>

You want to do <a href="https://en.wikipedia.org/wiki/Unsupervised_learning" rel="nofollow noreferrer">unsupervised learning</a>. The Wikipedia definition of the same is:  

<blockquote>
  Unsupervised machine learning is the machine learning task of inferring a function to describe hidden structure from "unlabeled" data (a classification or categorization is not included in the observations).  
</blockquote>

I shall recommend you to go through the list of unsupervised learning algorithms <a href="https://en.wikipedia.org/wiki/Unsupervised_learning" rel="nofollow noreferrer">here</a> and use the one which would fit your need.  

If you're starting out, then I would recommend starting with learning the <a href="https://en.wikipedia.org/wiki/K-means_clustering" rel="nofollow noreferrer">K-means clustering algorithm</a>.  

#### Answer 3 (score 0)
<blockquote>
  I need a machine learning algorithm to identify any patterns in a CSV file  
</blockquote>

You want to do <a href="https://en.wikipedia.org/wiki/Unsupervised_learning" rel="nofollow noreferrer">unsupervised learning</a>. The Wikipedia definition of the same is:  

<blockquote>
  Unsupervised machine learning is the machine learning task of inferring a function to describe hidden structure from "unlabeled" data (a classification or categorization is not included in the observations).  
</blockquote>

I shall recommend you to go through the list of unsupervised learning algorithms <a href="https://en.wikipedia.org/wiki/Unsupervised_learning" rel="nofollow noreferrer">here</a> and use the one which would fit your need.  

If you're starting out, then I would recommend starting with learning the <a href="https://en.wikipedia.org/wiki/K-means_clustering" rel="nofollow noreferrer">K-means clustering algorithm</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: What is the fringe in the context of search algorithms? (score [4365](https://stackoverflow.com/q/5949) in 2019)

#### Question
What is the <em>fringe</em> in the context of search algorithms?  

#### Answer accepted (score 7)
In English, the <em>fringe</em> is (also) defined as <em>the outer, marginal, or extreme part of an area, group, or sphere of activity</em>.  

In the context of AI search algorithms, the state (or search) space is usually represented as a graph, where nodes are states and the edges are the connections (or actions) between the corresponding states. If you're performing a tree (or graph) search, then the set of all nodes <em>at the end</em> of all visited paths is called the <em>fringe</em>, <em>frontier</em> or <em>border</em>.  

In the picture below, the grey nodes (the lastly visited nodes of each path) form the fringe.  

<a href="https://i.stack.imgur.com/mtJQj.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/mtJQj.png" alt="enter image description here"></a>  

The video <a href="https://classroom.udacity.com/courses/cs271/lessons/48678875/concepts/486525390923" rel="nofollow noreferrer">Example Route Finding</a> by Peter Norvig also gives some intuition behind this concept.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Which neural network has capabilities of sorting input? (score [4359](https://stackoverflow.com/q/1508) in )

#### Question
I believe normally you can use <a href="https://en.wikipedia.org/wiki/Genetic_programming" rel="nofollow">genetic programming</a> for sorting, however I'd like to check whether it's possible using ANN.  

Given the unsorted text data from input, which neural network is suitable for doing sorting tasks?  

#### Answer accepted (score 2)
Even a simple multilayer perceptron can sort input data to some extent, as you can see <a href="https://github.com/primaryobjects/nnsorting" rel="nofollow">here</a> and <a href="http://yyue.blogspot.com.br/2015/01/a-brief-overview-of-deep-learning.html" rel="nofollow">here</a>.  

However, neural networks for sequential data seem more appropriate, as they can handle sequences of variable lengths. It has been done with an <a href="https://github.com/dmlc/mxnet/tree/master/example/bi-lstm-sort" rel="nofollow">LSTM</a> (Long Short-Term Memory), <a href="https://arxiv.org/pdf/1602.03218.pdf" rel="nofollow">LSTM+HAM</a> (Hierarchical Attentive Memory) and an <a href="https://arxiv.org/pdf/1410.5401v2.pdf" rel="nofollow">NTM</a> (Neural Turing Machine).  

#### Answer 2 (score 2)
You should look at <a href="https://arxiv.org/pdf/1506.03134.pdf" rel="nofollow noreferrer">pointer networks</a>. It is still not perfect for the case, but it should be more applicable than LSTMs and MLPs because they learn in an output space of size equal to the input, rather than a fixed input dim that you would get using LSTMs in sequence to sequence or direct MLP. By design though they are meant for problems with replacement. Sorting when done sequentially is without, so to remedy this in the case of a pointer network, you could mask outputs that have already been chosen before the final normalization step (such as softmax)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Is a genetic algorithm an example of artificial intelligence? (score [4322](https://stackoverflow.com/q/28) in 2019)

#### Question
Since human intelligence presumably is a function of a natural genetic algorithm in nature, is using a genetic algorithm in a computer an example of artificial intelligence? If not, how do they differ? Or perhaps some are and some are not expressing artificial intelligence depending upon the scale of the algorithm and what it evolves into?  

#### Answer accepted (score 4)
<ul>
<li>An ability that is commonly attributed to intelligence is <strong>problem solving</strong>. </li>
<li>Another one is <strong>learning</strong> (improving itself from experience).</li>
<li>Artificial intelligence can be defined as "replicating intelligence, or parts of it, at least in appearance, inside a computer" (dodging the definition of intelligence itself).</li>
<li>Genetic algorithms are computational <strong>problem solving</strong> tools that find and improve solutions (they <strong>learn</strong>).</li>
</ul>

Thus, genetic algorithms are a kind of artificial intelligence.  

Regarding scale, I don't see it as an important factor for defining G.A. as A.I or not. The same way we can simply classify different living forms as more or less intelligent instead of just saying intelligent or not intelligent.  

Finally, let's just make an important distinction: our brains are the product of natural selection, but the brains themselves don't use the same principle in order to achieve intelligence.  

#### Answer 2 (score 2)
Human intelligence is <strong>not</strong> an example of natural genetic algorithms.  

Genetic algorithms have collections of solutions that are collided with each other to make new solutions, eventually returning the best solution. Human intelligence is a network of neurons doing information processing, and almost all of it doesn't behave the same way.  

But that something doesn't behave in the same way that human intelligence does doesn't mean that it's not an AI algorithm; I would include 'genetic algorithms' as a numerical optimization technique, and since optimization and intelligence are deeply linked any numerical optimization technique could be seen as an AI technique.  

#### Answer 3 (score 2)
Human intelligence is <strong>not</strong> an example of natural genetic algorithms.  

Genetic algorithms have collections of solutions that are collided with each other to make new solutions, eventually returning the best solution. Human intelligence is a network of neurons doing information processing, and almost all of it doesn't behave the same way.  

But that something doesn't behave in the same way that human intelligence does doesn't mean that it's not an AI algorithm; I would include 'genetic algorithms' as a numerical optimization technique, and since optimization and intelligence are deeply linked any numerical optimization technique could be seen as an AI technique.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: How to train a chatbot (score [4265](https://stackoverflow.com/q/2475) in )

#### Question
I wanted to started experimenting with neural network and as a toy problem I wished to train one to chat, i.e. implement a chatting bot like cleverbot. Not that clever anyway.  

I looked around for some documentation and I found many tutorial on general tasks, but few on this specific topic. The one I found just exposed the results without giving insights on the implementation. The ones that did, did it pretty shallowy (the tensorflow documentation page on seq2seq is lacking imho).  

Now, I feel I may have understood the principle more or less but I'm not sure and I am not even sure how to start. Thus I will explain how I would tackle the problem and I'd like a feedback on this solution, telling me where I'm mistaken and possibly have any link to detailed explainations and practical knowledge on the process.  

<ol>
<li><p>The dataset I will use for the task is the dump of all my facebook and whatsapp chat history. I don't know how big it will be but possibly still not large enough. The target language is not english, therefore I don't know where to quickly gather meaningful conversation samples.</p></li>
<li><p>I am going to generate a thought vector out of each sentence. Still don't know how actually; I found a nice example for word2vec on deeplearning4j website, but none for sentences. I understood how word vectors are built and why, but I could not find an exhaustive explaination for sentence vectors.</p></li>
<li><p>Using thought vectors as input and output I am going to train the neural network. I don't know how many layers it should have, and which ones have to be lstm layers.</p></li>
<li><p>Then there should be another neural network that is able to transform a thought vector into a sequence of character composing a sentence. I read that I should use padding to make up for different sentence lengths, but I miss how to encode characters (are codepoints enough?).</p></li>
</ol>

#### Answer accepted (score 7)
<p>I would recommend to start by reading <a href="http://karpathy.github.io/2015/05/21/rnn-effectiveness/" rel="noreferrer">this blogpost</a>.
You can probably cannibalise the code to create a RNN that takes in one statement of a dialogue and then proceeds to output the answer to that statement.</p>

That would be the easy version of your project, all without word vectors and thought vectors. You are just inputting characters, so typos don't need to concern you.  

The next more complex step would be to input word vectors instead of characters. That would allow you to generalise to words that aren't part of your training data. And it is probably still just a minor modification of the code.   

If you insist on using thought vectors, you should start reading up on <a href="https://arxiv.org/abs/1406.1078" rel="noreferrer">NN translation</a>. And probably try to get a pre-trained encoder network. Or pre-train it yourself on a large translation corpus for your language.   

With your small training set the best you can do is probably massively overfit until your system recreates your training data verbatim. Using word vectors will allow your system to give the same answer to "I beat the cat today." as you gave in the training data to "I kicked the dog yesterday."   

I'm not sure thought vectors will make a big difference. If you get the decoder to learn at all.   

#### Answer 2 (score 0)
According to your project concept,for starters,I would request you to apply some test driven development techniques. First, try to create a smaller sized database which you can use to handle a small amount of dataset,which can give a desired improvement.  

That said, use that database to create organised tree inline with your data,as nodes.So if a bot starts to generate some feedback,from the database,marked with data points from your specified dataset.And thus the feedback nor answer is the way to the next node in the tree.  

<em>note</em>  : For starters,don't use your large chat history as a whole,because this is a simple task..i.e..too much inputs == Overfitting.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Negative reward (penalty) in policy gradient reinforcement learning (score [4161](https://stackoverflow.com/q/2405) in 2016)

#### Question
I am using policy gradients in my reinforcement learning algorithm, and occasionally my environment provides a severe penalty when a wrong move is made. I'm using a neural network with stochastic gradient decent to learn the policy. To do this, my loss is essentially the cross-entropy loss of the action distribution multiplied by the discounted rewards, where most often the rewards are positive.   

But how do I handle negative rewards? Since the loss will occasionally go negative, it will think these actions are very good, and will strengthen the weights in the direction of the penalties. Is this correct, and if so, what can I do about it?  

<p>Edit:
In thinking about this a little more, SGD doesn't necessarily directly weaken weights, it only strengthens weights in the direction of the gradient and as a side-effect, weights get diminished for other states outside the gradient, correct? So I can simply set reward=0 when the reward is negative, and those states will be ignored in the gradient update. It still seems unproductive to not account for states that are really bad, and it'd be nice to include them somehow. Unless I'm misunderstanding something fundamental here.</p>

#### Answer 2 (score 3)
It depends on your loss function, but you probably need to tweak it.   

If you are using an update rule like `loss = -log(probabilities) * reward`, then your loss is high when you unexpectedly got a large reward—the policy will update to make that action more likely to realize that gain.  

Conversely, if you get a negative reward with high probability, this will result in negative loss—however, in minimizing this loss, the optimizer will attempt to make this loss "even more negative" by making the log probability more negative (i.e. by making the probability of that action less likely)—so it kind of does what we want.   

However, now improbable large negative losses are punished more than the more than likely ones, when we probably want the opposite. Hence, `loss = -log(1-probabilities) * reward` might be more appropriate when the reward is negative.  

#### Answer 3 (score 2)
Cross-entropy loss will always be positive, because the probability is 0~1, -ln(p) will always be positive.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: How to define states in reinforcement learning? (score [4117](https://stackoverflow.com/q/7763) in 2018)

#### Question
I am studying reinforcement learning and the variants of it. I am starting to get an understanding of how the algorithms work and how they apply to an MDP. What I don't understand is the process of defining the states of the MDP. In most examples and tutorials, they represent something simple like a square in a grid or similar.   

For more complex problems, like a robot learning to walk, etc., how do you go about defining those states? Can you use learning or classification algorithms to "learn" those states?  

#### Answer accepted (score 12)
The problem of state representation in Reinforcement Learning (RL) is similar to problems of feature representation, feature selection and feature engineering in supervised or unsupervised learning.  

Literature that teaches the basics of RL tends to use very simple environments so that all states can be enumerated. This simplifies value estimates into basic rolling averages in a table, which are easier to understand and implement. Tabular learning algorithms also have reasonable theoretical guarantees of convergence, which means if you <em>can</em> simplify your problem so that it has, say, less than a few million states, then this is worth trying.  

Most interesting control problems will not fit into that number of states, even if you discretise them. This is due to the "<a href="https://en.wikipedia.org/wiki/Curse_of_dimensionality" rel="noreferrer">curse of dimensionality</a>". For those problems, you will typically represent your state as a vector of different features - e.g. for a robot, various positions, angles, velocities of mechanical parts. As with supervised learning, you may want to treat these for use with a specific learning process. For instance, typically you will want them all to be numeric, and if you want to use a neural network you should also normalise them to a standard range (e.g. -1 to 1).  

In addition to the above concerns which apply for other machine learning, for RL, you also need to be concerned with the <a href="https://en.wikipedia.org/wiki/Markov_property" rel="noreferrer">Markov Property</a> - that the state provides enough information, so that you can accurately predict expected next rewards and next states given an action, without the need for any additional information. This does not need to be perfect, small differences due to e.g. variations in air density or temperature for a wheeled robot will not usually have a large impact on its navigation, and can be ignored. Any factor which is essentially random can also be ignored whilst sticking to RL theory - it may make the agent less optimal overall, but the theory will still work.   

If there are consistent unknown factors that influence result, and could logically be deduced - maybe from history of state or actions - but you have excluded them from the state representation, then you may have a more serious problem, and the agent may fail to learn.  

It is worth noting the difference here between <em>observation</em> and <em>state</em>. An observation is some data that you can collect. E.g. you may have sensors on your robot that feed back the positions of its joints. Because the state should possess the Markov Property, a single raw observation might not be enough data to make a suitable state. If that is the case, you can either apply your domain knowledge in order to construct a better state from available data, or you can try to use techniques designed for <a href="https://en.wikipedia.org/wiki/Partially_observable_Markov_decision_process" rel="noreferrer">partially observable MDPs (POMDPs)</a> - these effectively try to build missing parts of state data statistically. You could use a RNN or hidden markov model (also called a "belief state") for this, and in some way this is using a "<em>learning or classification algorithms to "learn" those states</em>" as you asked.  

Finally, you need to consider the type of approximation model you want to use. A similar approach applies here as for supervised learning:   

<ul>
<li><p>A simple linear regression with features engineered based on domain knowledge can do very well. You may need to work hard on trying different state representations so that the linear approximation works. The advantage is that this simpler approach is more robust against stability issues than non-linear approximation</p></li>
<li><p>A more complex non-linear function approximator, such as a multi-layer neural network. You can feed in a more "raw" state vector and hope that the hidden layers will find some structure or representation that leads to good estimates. In some ways, this too is "<em>learning or classification algorithms to "learn" those states</em>" , but in a different way to a RNN or HMM. This might be a sensible approach if your state was expressed naturally as a screen image - figuring out the feature engineering for image data by hand is very hard.</p></li>
</ul>

The <a href="https://deepmind.com/research/dqn/" rel="noreferrer">Atari DQN work by DeepMind</a> team used a combination of feature engineering and relying on deep neural network to achieve its results. The feature engineering included downsampling the image, reducing it to grey-scale and - importantly for the Markov Property - using four consecutive frames to represent a single state, so that information about velocity of objects was present in the state representation. The DNN then processed the images into higher-level features that could be used to make predictions about state values.  

#### Answer 2 (score 3)
A common early approach to modeling complex problems was <em>discretization</em>. At a basic level, this is splitting a complex and continuous space into a grid. Then you can use any of the classic RL techniques that are designed for discrete, linear, spaces. However, as you might imagine, if you aren't careful, this can cause a lot of trouble!  

Sutton &amp; Barto's classic book <em>Reinforcement Learning</em> has some suggestions for other ways to go about this. One is <em>tile coding</em>, covered in section 9.5.4 of the <a href="https://drive.google.com/file/d/1opPSz5AZ_kVa1uWOdOiveNiBFiEOHjkG/view" rel="nofollow noreferrer">new, second edition</a>. In tile coding, we generate a large number of grids, each with different grid spacing. We then overlay the grids on top of each other. This creates discrete regions non-uniform shapes, and can work well for a variety of problems.  

Section 9.5 also covers a variety of other ways to encode a continuous space into a discrete MDP, including radial-basis functions, and coarse codings. Check it out!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How does the uniform-cost search algorithm work? (score [4087](https://stackoverflow.com/q/8755) in 2018)

#### Question
What is the uniform-cost search algorithm? How does it work? I would appreciate to see a graphical execution of the algorithm. How does the "frontier" evolve in the case of UCS?  

#### Answer accepted (score 2)
Uniform Cost Search is also called the Cheapest First Search. For an example and entire explanation you can directly go to this link: <a href="https://classroom.udacity.com/courses/cs271/lessons/48678875/concepts/487393290923" rel="nofollow noreferrer">Udacity - Uniform Cost Search</a>.  

In <a href="https://ai.stackexchange.com/questions/5949/what-is-the-fringe-in-the-context-of-search-algorithms/5951#5951">this</a> answer I have explained what a frontier is. To put it in simple words you can describe UCS algorithm as 'expanding the frontier only in the direction which will require the minimum cost to travel from initial point among all possible expansions' i.e. adding a point on the graph (which can be reached from the frontier without going through any other point) which has the shortest route from the initial point. We keep on doing this until a path has explored the goal frontier, this path is the cheapest path from the initial point.  

I strongly suggest you check out both the links for examples and better understanding.  

NOTE: I have added a YouTube URL in the comments for those who do not want to sign in.  

#### Answer 2 (score -2)
You are not the first one who is asking what Uniform Cost search (UCS) is. Or to be more precisely, who is asking how it is possible to solve an Artificial Intelligence problem with this search algorithm. The simple answer is: that it's not possible to do any useful thing with UCS, because it has no heuristics. It is a vanilla graph search algorithm, but the term algorithm is perhaps not right, it can be more called a non working piece of code. That means, it is not possible to demonstrate the working of uniform cost search for an example. The only thing what i can provide is to show a non working example.  

The idea is maybe that a graph is searched in a linear fashion from top to bottom, similar to another malfunction technique, called Dijkstra' algorithm. How this can be used in real problems for example to control a robot or to find a path in a maze is easy to explain: there no way in doing so. Uniform cost search is some kind of anti-technology which prevents artificial intelligence. That means, if a general game playing agent is using UCS as their main principle we can 100% sure that the agent will do nothing and never ever solve this kind of games.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Binary classifier that minimizes false positive error (score [4040](https://stackoverflow.com/q/4748) in 2019)

#### Question
I have a binary classification problem, where a false positive error has a very big cost compared to the false negative error.   

Is there a way to design a classifier for such problems (preferably, with an implementation of the algorithm)?    

#### Answer accepted (score 4)
There is no predefined classifier for any problem. Two main features of a classifier is its cost function and its corresponding weight updation formula. Since, your problem statement requires a huge cost for falsely classifying a particular class one approach will be.  

<ul>
<li>You have to define a cost function which will penalize hugely for missclassifying for that class only. So your cost function will be `J` and `J'` put together. You can lookup the cost function of a logistic classifier to see how two separate cost functions are merged together <a href="http://www.holehouse.org/mlclass/06_Logistic_Regression.html" rel="nofollow noreferrer">here</a>.</li>
<li>Second approach can be (assuming you are using supervised learning), the learning rate `alpha` for both the classes should be different. The larger learning rate will be  for the one which is the more important class, since you don't want to classify it improperly(increasing `alpha` compared to the other class will reduce or risk of missclassifying it). Exact learning rate depends from case to case.</li>
</ul>

Thus, I have tailored the two main features of the classifier to solve this problem:  

<ul>
<li>The cost function.</li>
<li>The weight updation scheme (by changing learning rate for different cases).</li>
</ul>

#### Answer 2 (score 3)
@DuttaA has pretty much mentioned the two most appropriate approaches to having this facility. Either the penalty of false positives should be high or the learning rate for the correct class should be high.   

I'll give two real-life examples to help you understand it better.   

Say you have to teach a teen that substance abuse is injurious to health (eg. Frequent smoking is a <strong>negative</strong> habit). But the teen ends up learning from high effects of the drugs that it is good (<strong>false positive</strong>) and gets addicted to it. You would strictly want to avoid this kind of a situation (<strong>false positive error having a very big cost as compared to false negative error</strong>).  

In general, to model the situation when the costs are different, we picture a cost matrix. For a two-class classification problem, the cost matrix would look like:  

<p><a href="https://i.stack.imgur.com/HaVxo.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/HaVxo.png" alt="Cost Matrix"></a>
(courtesy: <a href="http://albahnsen.com/CostSensitiveClassification" rel="nofollow noreferrer">http://albahnsen.com/CostSensitiveClassification</a>)</p>

Now, when designing your cost function, you would want to take into account the weight corresponding to each of the situation. A simple python code would be as follows:  

```text
def weighted_cost(pred, act):
    if pred==P and act==P:
        return C_TP * cost(pred, act)
    if pred==P and act==N:
        return C_FP * cost(pred, act)
    if pred==N and act==P:
        return C_FN * cost(pred, act)
    if pred==N and act==N:
        return C_TN * cost(pred, act)
```

Where, <strong>pred</strong> is the predicted class and <strong>act</strong> is the actual class. Here, <strong>C_TP, C_FP, C_TN, C_FN</strong> represent the weights of true positive, false positive etc. The <strong>cost(pred, act)</strong> function will calculate the loss of one training example. You would want to use the weighted_cost function for finding the loss after one training example.  

The second approach that @DuttaA mentioned was to vary the learning rate. In real life, you can relate this to the situation when you were asked to write a word <strong>multiple times</strong> if you forget its spelling so that you remember it better. In a way, you learn the correct spelling of the word.  

Here, increasing the value of the learning rate <em>(say 4 x alpha)</em> for a class can be viewed as updating the value of the weights <strong>multiple times</strong> <em>(4 times)</em> with the old learning rate <em>(alpha)</em>, similar to what we do by writing the correct spelling of the word multiple times. So, a more important class (in your case it will be the <strong>Negative Class</strong>) should be given more alpha, because a false positive (misclassification of the negative class) has a high penalty. You learn to recognize the correct (negative) class by learning it more number of times (as in the case of learning the spelling of the word).  

Let me know if you need any further clarification.  

#### Answer 3 (score 1)
<p>A funky way of doing this with less overhead is to just over fit the data up to some degree.
The reason is when you try to over fit the data with the classifier the classification bound tends to wrap around the clusters very tightly and with that model you can some times miss classify positive classes as negative(due to high variance) but there are comparatively less situations where you end up miss classifying negative classes as positive.
The level of overfitting that needs to be performed is just based on your FP and FN trade off.</p>

I don't think this as a permanent fix but can come handy up to some extent.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: What is the difference between Actor-Critic and Advantage Actor-Critic? (score [3930](https://stackoverflow.com/q/7390) in 2019)

#### Question
I'm struggling to understand the difference between Actor-Critic and Advantage Actor-Critic.  

At least I know they are different from Asynchronous Advantage Actor-Critic (A3C), as A3C adds asynchronous mechanism that uses multiple worker agents interacting with their own copy of environment and report the gradient to the global agent.   

But what is the difference from the Actor-Critic and Advantage Actor-Critic (A2C)? Is it simply with or without Advantage function? But then, does the Actor-Critic have any other implementation except the use of Advantage function?  

Or maybe are they synonyms and Actor-Critic is just a shorthand for A2C?  

#### Answer accepted (score 7)
Actor-Critic is not just a single algorithm, it should be viewed as a "family" of related techniques. They're all techniques based on the policy gradient theorem, which train some form of critic that computes some form of value estimate to plug into the update rule as a lower-variance replacement for the returns at the end of an episode. They all perform "bootstrapping" by using some sort of prediction of value.  

<strong>Advantage Actor-Critic</strong> specifically uses estimates of the advantage function <span class="math-container">$A(s, a) = V(s) - Q(s, a)$</span> for its bootstrapping, whereas "actor-critic" without the "advantage" qualifier is not specific; it could be a trained <span class="math-container">$V(s)$</span> function, it could be some sort of estimate of <span class="math-container">$Q(s, a)$</span>, it could be a variety of things.   

In practice, the critic of Advantage Actor-Critic methods actually can just be trained to predict <span class="math-container">$V(s)$</span>. Combined with an empirically observed reward <span class="math-container">$r$</span>, they can then compute the advantage estimate <span class="math-container">$A(s, a) = r + \gamma V(s') - V(s)$</span>.  

#### Answer 2 (score 1)
According to Sutton and Barto, they are the same thing. Note 13.5-6 (page 338) of their <em>Reinforcement Learning: An Introduction, 2nd Edition</em> book:  

"Actor–critic methods are sometimes referred to as advantage actor–critic methods in the literature."  

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: When will the number of neurons in AI systems equal the human brain? (score [3883](https://stackoverflow.com/q/2330) in 2016)

#### Question
Based on fitting to historical data and extrapolation, when is it expected that the number of neurons in AI systems will equal those of the human brain?  

I'm interested in a possible direct replication of the human brain, which will need equal numbers of neurons.  

Of course, this assumes neurons which are equally capable as their biological counterparts, which development may happen at a faster or slower rate than the quantitative increase.  

#### Answer 2 (score 11)
Some back of the envelope calculations :  

<blockquote>
  number of neurons in AI systems   
</blockquote>

The number of neurons in AI systems is a little tricky to calculate, Neural Networks and Deep Learning are 2 current AI systems as you call them, specifics are hard to come by (If someone has them please share), but data on parameters do exist, parameters are more analogous to synapses (connections) than neurons (the nodes in between connections) somewhere in the range of 100-160 billion is the current upper number for specialized networks.  

Deriving the number of neurons in AI systems from this number is a stretch since these AIs emulate certain types of connections and sub assemblies of neurons, but let's continue...  

<blockquote>
  equal those of the human brain?  
</blockquote>

So now let's look at the brain, and again this are all contested numbers. Number of neurons ~ 86 Billion, Number of Synapses ~ 150 Trillion, another generalization: average number of synapses per neuron ~ 1,744.  

So now we have something to compare, and I can't stress this enough, these are all wonky numbers, so let's make our life a little easier and divide :  

Number of Synapses (Brain ) : 150 trillion /  Number of parameters AIs : 150 billion = 1,000 or in other words current AIs would have to scale by a factor of one thousand their connections to be on par with the brain...  

Number of Neurons (Brain ) : 86 Billion / Number of Neurons AIs ( 150 billion / 1,744 )  = 86 Million equivalent AI Neurons  

Which makes sense, mathematically at least : you can multiply the factor ( 1000 ) times the current number of equivalent AI Neurons ( 86 million) to get the number of neurons in the human brain (86 Billion)  

<blockquote>
  When ?  
</blockquote>

Well,let's use  moore's law ( number of transistors processing power doubles about every 2 years ) as a rough measure of technological progress:   

```text
     #AI NEURONS            YEAR
     86,000,000             2016
     172,000,000            2018
     344,000,000            2020
     688,000,000            2022
     1,376,000,000          2024
     2,752,000,000          2026
     5,504,000,000          2028
     11,008,000,000         2030
     22,016,000,000         2032
     44,032,000,000         2034
     88,064,000,000         2036


     # NEURONS HUMAN BRAIN 
     86,000,000,000
```

So, if all this made sense to you, somewhere around the year 2035.   

#### Answer 3 (score 7)
Soon enough but that doesn't mean anything at all. In machine learning the word neuron represents a calculation whereas in brain the word neuron represent a specific type of cell which is a biochemical system.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: Traffic signs dataset (score [3830](https://stackoverflow.com/q/8258) in 2018)

#### Question
I'm looking for <strong>annotated</strong> dataset of traffic signs. I was able to find Belgium, German and many more traffic signs datasets. The only problem is these datasets contain only cropped images, like this:  

<a href="https://i.stack.imgur.com/6SJxW.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/6SJxW.png" alt="enter image description here"></a>  

While i need (for YOLO -- You Only Look Once network architecture) not-cropped images.  

<a href="https://i.stack.imgur.com/X6jI3.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/X6jI3.png" alt="enter image description here"></a>  

I've been looking for hours but didn't find dataset like this. Does anybody know about this kind of annotated dataset ?  

<strong>EDIT:</strong>  

I prefer European datasets.  

#### Answer accepted (score 1)
<strong>Direct Answer</strong>  

The <a href="https://btsd.ethz.ch/shareddata/" rel="nofollow noreferrer">Belgium TS Dataset</a> may be helpful, as well as <a href="http://benchmark.ini.rub.de/?section=gtsdb&amp;subsection=dataset" rel="nofollow noreferrer">The German Traffic Sign Detection Benchmark</a>.  

<strong>Additional Notes Based on Question Author's Idea</strong>  

The idea in the question author's addendum of placing signs onto street sides and corners is a good one, but to do it repeatably and in a way that doesn't bias the training is its own research project.  However, it is a good research direction.  What would be of benefit to AV researchers worldwide is a multi-network topology and equilibrium strategy with the objective to create the following data generation features.  

<ul>
<li>Street sign symbol inputs in image form, with or without cropping, as movie frame sequences or single still shots, or from SVG files.</li>
<li>Annotation generation using partially human-labelled data.</li>
<li>3D analysis of sign angle and perspective setting so that the images appear exactly as they would from a vehicle's imaging system.</li>
<li>Matching of lighting between the superimposed sign and the background scene.</li>
<li>Automatic blue-screening for the sign image.</li>
</ul>

This is obviously not a basic data hygiene problem. It is its own AI project, but the return on this research project in terms of furthering the AV technology is immense and may have significant data set statistical advantages over collecting data from the vendors that supply images to Google maps and other Big Data aggregators.  

#### Answer 2 (score 1)
<p>Check this one by <a href="http://cvrr.ucsd.edu/LISA/lisa-traffic-sign-dataset.html" rel="nofollow noreferrer">UCSD</a>.
It contains both video as well as images related to traffic signs. The annotations are present in csv</p>

#### Answer 3 (score 0)
I searched the web but there are no such dataset published but <a href="https://www.mapillary.com/dataset/vistas?pKey=pBBmjuJ8yU1r2ROYRzWmFg&amp;lat=-6.7203390321265175&amp;lng=-76.83556631804362&amp;z=0.3424751357705809" rel="nofollow noreferrer">Check this out</a>   

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: What are the advantages of ReLU vs Leaky ReLU and Parametric ReLU (if any)? (score [3811](https://stackoverflow.com/q/7274) in 2018)

#### Question
I think that the advantage of using Leaky ReLU instead of ReLU is that in this way we cannot have vanishing gradient. Parametric ReLU has the same advantage with the only difference that the slope of the output for negative inputs is a learnable parameter while in the Leaky ReLU it's a hyperparameter.  

However, I'm not able to tell if there are cases where is more convenient to use ReLU instead of Leaky ReLU or Parametric ReLU.  

#### Answer 2 (score 6)
Combining ReLU, the hyper-parameterized<sup>1</sup> leaky variant, and variant with dynamic parametrization during learning confuses two distinct things:  

<ul>
<li>The comparison between ReLU with the leaky variant is closely related to whether there is a need, in the particular ML case at hand, to avoid saturation &mdash; Saturation is thee loss of signal to either zero gradient<sup>2</sup> or the dominance of chaotic noise arising from digital rounding<sup>3</sup>.</li>
<li>The comparison between training-dynamic activation (called <em>parametric</em> in the literature) and training-static activation must be based on whether the non-linear or non-smooth characteristics of activation have any value related to the rate of convergence<sup>4</sup>.</li>
</ul>

The reason ReLU is never parametric is that to make it so would be redundant.  In the negative domain, it is the constant zero.  In the non-negative domain, its derivative is constant.  Since the activation input vector is already attenuated with a vector-matrix product (where the matrix, cube, or hyper-cube contains the attenuation parameters) there is no useful purpose in adding a parameter to vary the constant derivative for the non-negative domain.  

When there is curvature in the activation, it is no longer true that all the coefficients of activation are redundant as parameters.  Their values may considerably alter the training process and thus the speed and reliability of convergence.  

For substantially deep networks, the redundancy reemerges, and there is evidence of this, both in theory and practice in the literature.  

<ul>
<li>In algebraic terms, the disparity between ReLU and parametrically dynamic activations derived from it approaches zero as the depth (in number of layers) approaches infinity.</li>
<li>In descriptive terms, ReLU can accurately approximate functions with curvature<sup>5</sup> if given a sufficient number of layers to do so.</li>
</ul>

That is why the ELU variety, which is advantageous for averting the saturation issues mentioned above for shallower networks is not used for deeper ones.  

So one must decided two things.  

<ul>
<li>Whether parametric activation is helpful is often based on experimentation with several samples from a statistical population.  But there is no need to experiment at all with it if the layer depth is high.</li>
<li>Whether the leaky variant is of value has much to do with the numerical ranges encountered during back propagation.  If the gradient becomes vanishingly small during back propagation at any point during training, a constant portion of the activation curve may be problematic.  In such a scase one of the smooth functions or leaky RelU with it's two non-zero slopes may provide adequate solution.</li>
</ul>

In summary, the choice is never a choice of convenience.  

<hr>

<strong>Footnotes</strong>  

[1] Hyper-parameters are parameters that affect the signaling through the layer that are not part of the attenuation of inputs for that layer.  The attenuation weights are parameters.  Any other parametrization is in the set of hyper-parameters.  This may include learning rate, dampening of high frequencies in the back propagation, and a wide variety of other learning controls that are set for the entire layer, if not the entire network.  

[2] If the gradient is zero, then there cannot be any intelligent adjustment of the parameters because the direction of the adjustment is unknown, and its magnitude must be zero.  Learning stops.  

[3] If chaotic noise, which can arise as the CPU rounds extremely small values to their closest digital representation, dominates the correction signal that is intended to propagate back to the layers, then the correction becomes nonsense and learning stops.  

[4] Rate of convergence is a measure of the speed (either relative to microseconds or relative to the iteration index of the algorithm) in which the result of learning (system behavior) approaches what is considered good enough.  That's usually some specified proximity to some formal acceptance criteria for the convergence (learning).  

[5] Functions with curvature are ones that are not visualized as straight or flat.  A parabola has curvature.  A straight line does not.  The surface of an egg has curvature.  A perfect flat plane does not.  Mathematically, if any of the elements of the Hessian of the function is non-zero, the function has curvature.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Can AI write good jokes yet? (score [3808](https://stackoverflow.com/q/3397) in )

#### Question
Just watched a recent WIRED video on virtual assistants' performance on telling jokes. They're composed by humans, but I'd like to know if AI has gotten good enough to write some.  

#### Answer 2 (score 9)
I dont think the AI has gotten to that point yet. Here is some of the interesting papers on the subject:  

<ul>
<li><p>A paper was recently written that attempted to <a href="http://homepages.inf.ed.ac.uk/s0894589/petrovic13unsupervised.pdf" rel="nofollow noreferrer">generate jokes using unsupervised learning</a>. The jokes are formulaic: they're all of the form "I like my X like I like my Y: Z" where X and Y are nouns, and Z is an adjective that can describe both X and Y. Here are some of the jokes generated in this paper: </p>

```text
I like my relationships like I like my source, open
I like my coffee like I like my war, cold
I like my boys like I like my sectors, bad
```

How funny this jokes are is a matter of personal taste I guess.   </li>
<li><p>Another paper by <a href="http://www.aclweb.org/anthology/N16-1016" rel="nofollow noreferrer">Dario Bertero and Pascale Fung</a> makes use of an LSTM to predict humor from a dataset of the Big Bang theory shows. This is not generating jokes but finding out where the jokes are said in this dataset(so theoretically, the resulting labelled dataset can hopefully be used to train a model to create jokes). </p></li>
<li><p>Yet another paper is that by <a href="https://web.stanford.edu/class/cs224n/reports/2760332.pdf" rel="nofollow noreferrer">He Ren, Quan Yang</a>. Unlike <a href="http://homepages.inf.ed.ac.uk/s0894589/petrovic13unsupervised.pdf" rel="nofollow noreferrer">the first paper mentioned above</a> which was unsupervised, this is a supervised learning model. Their neural network model, generates jokes such as: </p>

```text
Apple is teaming up with Playboy Magazine in the self driving office.
One of the top economy in China , Lady Gaga says today that Obama is legal.
Google Plus has introduced the remains that lowers the age of coffee.
According to a new study , the governor of film welcome the leading actor of Los Angeles area , Donald Trump .
```
</li>
</ul>

<em>My two cent</em>:   

As of this writting, it appears that Multi-layer Recurrent Neural Networks (LSTM, GRU, RNN) for character-level language models are by far the most promising way to go about it. Maybe if you find some really cool data you can come up with some funny jokes, similar to how <a href="http://lewisandquark.tumblr.com/post/159302925452/the-neural-network-generated-pickup-lines-that-are" rel="nofollow noreferrer">Janelle Shane</a> was able to generate what I find to be really funny pickup lines such as:  

```text
Are you a 4loce? Because you’re so hot!
I want to get my heart with you.
You are so beautiful that you know what I mean.
I have a cenver? Because I just stowe must your worms.
Hey baby, I’m swirked to gave ever to say it for drive. 
If I were to ask you out?
You must be a tringle? Cause you’re the only thing here.
I’m not on your wears, but I want to see your start.
You are so beautiful that you make me feel better to see you.
Hey baby, you’re to be a key? Because I can bear your toot?
I don’t know you.
I have to give you a book, because you’re the only thing in your eyes.
Are you a candle? Because you’re so hot of the looks with you.
I want to see you to my heart.
If I had a rose for every time I thought of you, I have a price tighting.
I have a really falling for you.
Your beauty have a fine to me.
Are you a camera? Because I want to see the most beautiful than you.
I had a come to got your heart.
You’re so beautiful that you say a bat on me and baby.
You look like a thing and I love you.
Hello.
```

#### Answer 3 (score 0)
As of now we don't have a satisfying cognitive theory of humor (or at least, one that can evaluate the hilarity of a joke), so a quick survey of the literature seems shows that we don't have much of a clue on how to build a model.  

Because of that, and the fact that existing methods don't seem to reliably produce good jokes free form, there seems to be little reason to believe that ML methods can produce good jokes.   

But of course this is all normative.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Is there any research on the development of attacks against artificial intelligence systems? (score [3800](https://stackoverflow.com/q/15820) in 2019)

#### Question
Is there any research on the development of attacks against artificial intelligence systems?  

For example, is there a way to generate a letter "A", which every human being in this world can recognize but, if it is shown to the state-of-the-art character recognition system, this system will fail to recognize it? Or spoken audio which can be easily recognized by everyone but will fail on the state-of-the-art speech recognition system.   

If there exists such a thing, is this technology a theory-based science (mathematics proved) or an experimental science (randomly add different types of noise and feed into the AI system and see how it works)? Where can I find such material?    

#### Answer 2 (score 25)
Yes, there is some research on this topic, which can be called <a href="https://arxiv.org/abs/1611.01236" rel="noreferrer">adversarial machine learning</a>, which is more an experimental field.  

An <a href="https://arxiv.org/pdf/1312.6199.pdf" rel="noreferrer"><em>adversarial example</em></a> is an input similar to the ones used to train the model, but that leads the model to produce an unexpected outcome. For example, consider an artificial neural network (ANN) trained to distinguish between oranges and apples. You are then given an image of an apple similar to another image used to train the ANN, but that is slightly blurred. Then you pass it to the ANN, which unexpectedly predicts the object to be an orange.  

Several machine learning and optimization methods have been used to detect the boundary behaviour of machine learning models, that is, the unexpected behaviour of the model that produces different outcomes given two slightly different inputs (but that correspond to the same object). For example, evolutionary algorithms have been used to develop tests for self-driving cars. See, for example, <a href="https://dl.acm.org/citation.cfm?id=3330566" rel="noreferrer">Automatically testing self-driving cars with search-based procedural content generation</a> (2019) by Alessio Gambi et al.  

#### Answer 3 (score 11)
Sometimes if the rules used by an AI to identify characters are discovered, and if the rules used by a human being to identify the same characters are different, it is possible to design characters that are recognized by a human being but not recognized by an AI.  However, if the human being and AI both use the same rules, they will recognize the same characters equally well.  

A student I advised once trained a neural network to recognize a set of numerals, then used a genetic algorithm to alter the shapes and connectivity of the numerals so that a human could still recognize them but the neural network could not.  Of course, if he had then re-trained the neural network using the expanded set of numerals, it probably would have been able to recognize the new ones.  

</section>

