---
title: Ruby <- StackOverflow top 100
category: ruby
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How to write a switch statement in Ruby (score [809157](https://stackoverflow.com/q/948135) in 2018)

#### Question
How do I write a switch statement in Ruby?  

#### Answer accepted (score 2579)
Ruby uses the <a href="http://ruby-doc.com/docs/ProgrammingRuby/html/tut_expressions.html#S5" rel="noreferrer">`case` expression</a> instead.  

```ruby
case x
when 1..5
  "It's between 1 and 5"
when 6
  "It's 6"
when "foo", "bar"
  "It's either foo or bar"
when String
  "You passed a string"
else
  "You gave me #{x} -- I have no idea what to do with that."
end
```

Ruby compares the object in the `when` clause with the object in the `case` clause using the `===` operator. For example, `1..5 === x`, and not `x === 1..5`.   

This allows for sophisticated `when` clauses as seen above. Ranges, classes and all sorts of things can be tested for rather than just equality.  

Unlike `switch` statements in many other languages, Ruby’s `case` does not have <a href="https://en.wikipedia.org/wiki/Switch_statement#Fallthrough" rel="noreferrer">fall-through</a>, so there is no need to end each `when` with a `break`. You can also specify multiple matches in a single `when` clause like `when "foo", "bar"`.  

#### Answer 2 (score 429)
`case...when` behaves a bit unexpectedly when handling classes. This is due to the fact that it uses the `===` operator.  

That operator works as expected with literals, but not with classes:  

```ruby
1 === 1           # => true
Fixnum === Fixnum # => false
```

This means that if you want to do a `case ... when` over an object's class, this will not work:  

```ruby
obj = 'hello'
case obj.class
when String
  print('It is a string')
when Fixnum
  print('It is a number')
else
  print('It is not a string or number')
end
```

Will print "It is not a string or number".  

Fortunately, this is easily solved. The `===` operator has been defined so that it returns `true` if you use it with a class and supply an instance of that class as the second operand:  

```ruby
Fixnum === 1 # => true
```

In short, the code above can be fixed by removing the `.class`:  

```ruby
obj = 'hello'
case obj  # was case obj.class
when String
  print('It is a string')
when Fixnum
  print('It is a number')
else
  print('It is not a string or number')
end
```

I hit this problem today while looking for an answer, and this was the first appearing page, so I figured it would be useful to others in my same situation.  

#### Answer 3 (score 207)
It is done by <a href="http://www.techotopia.com/index.php/The_Ruby_case_Statement" rel="noreferrer">case</a> in Ruby. Also see <a href="http://en.wikipedia.org/wiki/Switch_statement#Ruby" rel="noreferrer">this article on Wikipedia</a>.  

Quoted:  

```ruby
case n
when 0
  puts 'You typed zero'
when 1, 9
  puts 'n is a perfect square'
when 2
  puts 'n is a prime number'
  puts 'n is an even number'
when 3, 5, 7
  puts 'n is a prime number'
when 4, 6, 8
  puts 'n is an even number'
else
  puts 'Only single-digit numbers are allowed'
end
```

Another example:  

```ruby
score = 70

result = case score
   when 0..40 then "Fail"
   when 41..60 then "Pass"
   when 61..70 then "Pass with Merit"
   when 71..100 then "Pass with Distinction"
   else "Invalid Score"
end

puts result
```

On around page 123 (I am using Kindle) of <em>The Ruby Programming Lanugage</em> (1st Edition, O'Reilly), it says the `then` keyword following the `when` clauses can be replaced with a newline or semicolon (just like in the `if then else` syntax). (Ruby 1.8 also allows a colon in place of `then`... But this syntax is no longer allowed in Ruby 1.9.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: Check if a value exists in an array in Ruby (score [802557](https://stackoverflow.com/q/1986386) in 2015)

#### Question
I have a value `'Dog'` and an array `['Cat', 'Dog', 'Bird']`.   

How do I check if it exists in the array without looping through it? Is there a simple way of checking if the value exists, nothing more?  

#### Answer accepted (score 1856)
You're looking for <a href="http://ruby-doc.org/core-2.3.1/Array.html#method-i-include-3F" rel="noreferrer">`include?`</a>:  

```ruby
>> ['Cat', 'Dog', 'Bird'].include? 'Dog'
=> true
```

#### Answer 2 (score 240)
There is an <a href="https://apidock.com/rails/Object/in%3F" rel="noreferrer">`in?` method</a> in `ActiveSupport` (part of Rails) since v3.1, as pointed out by @campaterson. So within Rails, or if you `require 'active_support'`, you can write:  

```ruby
'Unicorn'.in?(['Cat', 'Dog', 'Bird']) # => false
```

OTOH, there is no `in` operator or `#in?` method in Ruby itself, even though it has been proposed before, <a href="http://bugs.ruby-lang.org/issues/3845" rel="noreferrer">in particular by Yusuke Endoh</a> a top notch member of ruby-core.  

As pointed out by others, the reverse method <a href="http://www.ruby-doc.org/core-1.9.3/Array.html#method-i-include-3F" rel="noreferrer">`include?`</a> exists, for all `Enumerable`s including `Array`, `Hash`, `Set`, `Range`:  

```ruby
['Cat', 'Dog', 'Bird'].include?('Unicorn') # => false
```

<hr>

Note that if you have many values in your array, they will all be checked one after the other (i.e. `O(n)`), while that lookup for a hash will be constant time (i.e `O(1)`). So if you array is constant, for example, it is a good idea to use a <a href="http://ruby-doc.org/stdlib-2.2.2/libdoc/set/rdoc/Set.html" rel="noreferrer">Set</a> instead. E.g:  

```ruby
require 'set'
ALLOWED_METHODS = Set[:to_s, :to_i, :upcase, :downcase
                       # etc
                     ]

def foo(what)
  raise "Not allowed" unless ALLOWED_METHODS.include?(what.to_sym)
  bar.send(what)
end
```

A <a href="http://pastie.org/3913273" rel="noreferrer">quick test</a> reveals that calling `include?` on a 10 element `Set` is about 3.5x faster  than calling it on the equivalent `Array` (if the element is not found).  

A final closing note: be wary when using `include?` on a `Range`, there are subtleties, so refer to <a href="http://ruby-doc.org/core-1.9.3/Range.html#method-i-include-3F" rel="noreferrer">the doc</a> and compare with <a href="http://ruby-doc.org/core-1.9.3/Range.html#method-i-cover-3F" rel="noreferrer">`cover?`</a>...  

#### Answer 3 (score 164)
Try  

```ruby
['Cat', 'Dog', 'Bird'].include?('Dog')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How to check whether a string contains a substring in Ruby? (score [684461](https://stackoverflow.com/q/8258517) in 2013)

#### Question
I have a string variable with content as follows:  

```ruby
varMessage =   
            "hi/thsid/sdfhsjdf/dfjsd/sdjfsdn\n"


            "/my/name/is/balaji.so\n"
            "call::myFunction(int const&)\n"
            "void::secondFunction(char const&)\n"
             .
             .
             .
            "this/is/last/line/liobrary.so"
```

in above string i have to find a sub string i.e.  

```ruby
"hi/thsid/sdfhsjdf/dfjsd/sdjfsdn\n"


"/my/name/is/balaji.so\n"
"call::myFunction(int const&)\n"
```

How can I find it? I just need to determine whether the substring is present or not.  

#### Answer accepted (score 1282)
You can use the <a href="https://ruby-doc.org/core-1.9.3/String.html#method-i-include-3F" rel="noreferrer">`include?`</a> method:  

```ruby
my_string = "abcdefg"
if my_string.include? "cde"
   puts "String includes 'cde'"
end
```

#### Answer 2 (score 82)
If case is irrelevant, then a <strong>case-insensitive regular expression</strong> is a good solution:  

```ruby
'aBcDe' =~ /bcd/i  # evaluates as true
```

This will also work for multi-line strings.  

See Ruby's <a href="http://docs.ruby-lang.org/en/trunk/Regexp.html">Regexp</a> class.  

#### Answer 3 (score 41)
You can also do this...  

```ruby
my_string = "Hello world"

if my_string["Hello"]
  puts 'It has "Hello"'
else
  puts 'No "Hello" found'
end

# => 'It has "Hello"'
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How to convert a string to lower or upper case in Ruby (score [638074](https://stackoverflow.com/q/1020568) in 2016)

#### Question
How do I take a string and convert it to lower or upper case in Ruby?  

#### Answer accepted (score 1543)
Ruby has a few methods for changing the case of strings. To convert to lowercase, use `downcase`:  

```ruby
"hello James!".downcase    #=> "hello james!"
```

Similarly, `upcase` capitalizes every letter and `capitalize` capitalizes the first letter of the string but lowercases the rest:  

```ruby
"hello James!".upcase      #=> "HELLO JAMES!"
"hello James!".capitalize  #=> "Hello james!"
"hello James!".titleize    #=> "Hello James!"
```

If you want to modify a string in place, you can add an exclamation point to any of those methods:  

```ruby
string = "hello James!"
string.downcase!
string   #=> "hello james!"
```

Refer to the <a href="http://www.ruby-doc.org/core/String.html" rel="noreferrer">documentation for String</a> for more information.  

#### Answer 2 (score 121)
You can find out all the methods available on a String by opening irb and running:  

```ruby
"MyString".methods.sort
```

And for a list of the methods available for strings in particular:  

```ruby
"MyString".own_methods.sort
```

I use this to find out new and interesting things about objects which I might not otherwise have known existed.  

#### Answer 3 (score 39)
Like @endeR mentioned, if internationalization is a concern, the unicode_utils gem is more than adequate.  

```ruby
$ gem install unicode_utils
$ irb
> require 'unicode_utils'
=> true
> UnicodeUtils.downcase("FEN BİLİMLERİ", :tr)
=> "fen bilimleri"
```

<hr>

String manipulations  in Ruby 2.4 are now unicode-sensitive.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: How to write to file in Ruby? (score [560295](https://stackoverflow.com/q/2777802) in 2016)

#### Question
I need to read the data out of database and then save it in a text file.  

How can I do that in Ruby? Is there any file management system in Ruby?  

#### Answer accepted (score 174)
The Ruby <a href="http://ruby-doc.org/core/classes/File.html" rel="noreferrer">File class</a> will give you the ins and outs of `::new` and `::open` but its parent, the <a href="http://ruby-doc.org/core/classes/IO.html" rel="noreferrer">IO class</a>, gets into the depth of `#read` and `#write`.  

#### Answer 2 (score 904)
Are you looking for the following?  

```ruby
File.open(yourfile, 'w') { |file| file.write("your text") }
```

#### Answer 3 (score 602)
You can use the short version:  

```ruby
File.write('/path/to/file', 'Some glorious content')
```

It returns the length written; see <a href="http://ruby-doc.org/core-1.9.3/IO.html#method-c-write" rel="noreferrer">::write</a> for more details and options.  

To append to the file, if it already exists, use:  

```ruby
File.write('/path/to/file', 'Some glorious content', mode: 'a')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: String concatenation in Ruby (score [536211](https://stackoverflow.com/q/377768) in 2015)

#### Question
I am looking for a more elegant way of concatenating strings in Ruby.  

I have the following line:  

```ruby
source = "#{ROOT_DIR}/" << project << "/App.config"
```

Is there a nicer way of doing this?  

And for that matter what is the difference between `&lt;&lt;` and `+`?  

#### Answer accepted (score 553)
You can do that in several ways:  

<ol>
<li>As you shown with `&lt;&lt;` but that is not the <em>usual</em> way</li>
<li><p>With string interpolation</p>

```ruby
source = "#{ROOT_DIR}/#{project}/App.config"
```</li>
<li><p>with `+`</p>

```ruby
source = "#{ROOT_DIR}/" + project + "/App.config"
```</li>
</ol>

The second method seems to be more efficient in term of memory/speed from what I've seen (not measured though). All three methods will throw an uninitialized constant error when ROOT_DIR is nil.  

When dealing with pathnames, you may want to use `File.join` to avoid messing up with pathname separator.  

In the end, it is a matter of taste.  

#### Answer 2 (score 92)
The `+` operator is the normal concatenation choice, and is probably the fastest way to concatenate strings.  

The difference between `+` and `&lt;&lt;` is that `&lt;&lt;` changes the object on its left hand side, and `+` doesn't.  

```ruby
irb(main):001:0> s = 'a'
=> "a"
irb(main):002:0> s + 'b'
=> "ab"
irb(main):003:0> s
=> "a"
irb(main):004:0> s << 'b'
=> "ab"
irb(main):005:0> s
=> "ab"
```

#### Answer 3 (score 77)
If you are just concatenating paths you can use Ruby's own File.join method.  

```ruby
source = File.join(ROOT_DIR, project, 'App.config')
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: Execute a command line binary with Node.js (score [516439](https://stackoverflow.com/q/20643470) in 2015)

#### Question
I am in the process of porting a CLI library from Ruby over to Node.js. In my code I execute several third party binaries when necessary. I am not sure how best to accomplish this in Node.  

Here's an example in Ruby where I call PrinceXML to convert a file to a PDF:  

```ruby
cmd = system("prince -v builds/pdf/book.html -o builds/pdf/book.pdf")
```

What is the equivalent code in Node?  

#### Answer 2 (score 965)
For even newer version of Node.js (v8.1.4), the events and calls are similar or identical to older versions, but it's encouraged to use the standard newer language features. Examples:  

For buffered, non-stream formatted output (you get it all at once), use <a href="https://nodejs.org/docs/v8.1.4/api/child_process.html#child_process_child_process_exec_command_options_callback" rel="noreferrer">`child_process.exec`</a>:  

```ruby
const { exec } = require('child_process');
exec('cat *.js bad_file | wc -l', (err, stdout, stderr) => {
  if (err) {
    // node couldn't execute the command
    return;
  }

  // the *entire* stdout and stderr (buffered)
  console.log(`stdout: ${stdout}`);
  console.log(`stderr: ${stderr}`);
});
```

You can also use it with Promises:  

```ruby
const util = require('util');
const exec = util.promisify(require('child_process').exec);

async function ls() {
  const { stdout, stderr } = await exec('ls');
  console.log('stdout:', stdout);
  console.log('stderr:', stderr);
}
ls();
```

If you wish to receive the data gradually in chunks (output as a stream), use <a href="https://nodejs.org/docs/v8.1.4/api/child_process.html#child_process_child_process_spawn_command_args_options" rel="noreferrer">`child_process.spawn`</a>:  

```ruby
const { spawn } = require('child_process');
const child = spawn('ls', ['-lh', '/usr']);

// use child.stdout.setEncoding('utf8'); if you want text chunks
child.stdout.on('data', (chunk) => {
  // data from standard output is here as buffers
});

// since these are streams, you can pipe them elsewhere
child.stderr.pipe(dest);

child.on('close', (code) => {
  console.log(`child process exited with code ${code}`);
});
```

Both of these functions have a synchronous counterpart. An example for <a href="https://nodejs.org/docs/v8.1.4/api/child_process.html#child_process_child_process_execsync_command_options" rel="noreferrer">`child_process.execSync`</a>:  

```ruby
const { execSync } = require('child_process');
// stderr is sent to stderr of parent process
// you can set options.stdio if you want it to go elsewhere
let stdout = execSync('ls');
```

As well as <a href="https://nodejs.org/docs/v8.1.4/api/child_process.html#child_process_child_process_spawnsync_command_args_options" rel="noreferrer">`child_process.spawnSync`</a>:  

```ruby
const { spawnSync} = require('child_process');
const child = spawnSync('ls', ['-lh', '/usr']);

console.log('error', child.error);
console.log('stdout ', child.stdout);
console.log('stderr ', child.stderr);
```

<hr>

<strong>Note:</strong> The following code is still functional, but is primarily targeted at users of ES5 and before.  

The module for spawning child processes with Node.js is well documented in the <a href="http://nodejs.org/docs/v5.0.0/api/child_process.html" rel="noreferrer">documentation</a> (v5.0.0). To execute a command and fetch its complete output as a buffer, use <a href="https://nodejs.org/docs/v5.0.0/api/child_process.html#child_process_child_process_exec_command_options_callback" rel="noreferrer">`child_process.exec`</a>:  

```ruby
var exec = require('child_process').exec;
var cmd = 'prince -v builds/pdf/book.html -o builds/pdf/book.pdf';

exec(cmd, function(error, stdout, stderr) {
  // command output is in stdout
});
```

If you need to use handle process I/O with streams, such as when you are expecting large amounts of output, use <a href="https://nodejs.org/docs/v5.0.0/api/child_process.html#child_process_child_process_spawn_command_args_options" rel="noreferrer">`child_process.spawn`</a>:  

```ruby
var spawn = require('child_process').spawn;
var child = spawn('prince', [
  '-v', 'builds/pdf/book.html',
  '-o', 'builds/pdf/book.pdf'
]);

child.stdout.on('data', function(chunk) {
  // output will be here in chunks
});

// or if you want to send output elsewhere
child.stdout.pipe(dest);
```

If you are executing a file rather than a command, you might want to use <a href="https://nodejs.org/docs/v5.0.0/api/child_process.html#child_process_child_process_execfile_file_args_options_callback" rel="noreferrer">`child_process.execFile`</a>, which parameters which are almost identical to `spawn`, but has a fourth callback parameter like `exec` for retrieving output buffers. That might look a bit like this:  

```ruby
var execFile = require('child_process').execFile;
execFile(file, args, options, function(error, stdout, stderr) {
  // command output is in stdout
});
```

<hr>

As of <a href="https://nodejs.org/en/blog/release/v0.11.12/" rel="noreferrer">v0.11.12</a>, Node now supports synchronous `spawn` and `exec`. All of the methods described above are asynchronous, and have a synchronous counterpart. Documentation for them can be found <a href="https://nodejs.org/docs/v5.0.0/api/child_process.html#child_process_synchronous_process_creation" rel="noreferrer">here</a>. While they are useful for scripting, do note that unlike the methods used to spawn child processes asynchronously, the synchronous methods do not return an instance of <a href="https://nodejs.org/docs/v5.0.0/api/child_process.html#child_process_class_childprocess" rel="noreferrer">`ChildProcess`</a>.  

#### Answer 3 (score 234)
  

<h5>Node JS `v12.9.1`, LTS `v10.16.3`, and `v8.16.1`  ---  Aug 2019</h3>

<strong>Async method (Unix):</strong>  

```ruby
'use strict';

const { spawn } = require( 'child_process' );
const ls = spawn( 'ls', [ '-lh', '/usr' ] );

ls.stdout.on( 'data', data => {
    console.log( `stdout: ${data}` );
} );

ls.stderr.on( 'data', data => {
    console.log( `stderr: ${data}` );
} );

ls.on( 'close', code => {
    console.log( `child process exited with code ${code}` );
} );
```

<br/>  

<strong>Async method (Windows):</strong>  

```ruby
'use strict';

const { spawn } = require( 'child_process' );
const dir = spawn( 'dir', [ '.' ] );

dir.stdout.on( 'data', data => console.log( `stdout: ${data}` ) );
dir.stderr.on( 'data', data => console.log( `stderr: ${data}` ) );
dir.on( 'close', code => console.log( `child process exited with code ${code}` ) );
```

<br/>  

<strong>Sync:</strong>  

```ruby
'use strict';

const { spawnSync } = require( 'child_process' );
const ls = spawnSync( 'ls', [ '-lh', '/usr' ] );

console.log( `stderr: ${ls.stderr.toString()}` );
console.log( `stdout: ${ls.stdout.toString()}` );
```

From <a href="https://nodejs.org/api/child_process.html#child_process_child_process_spawn_command_args_options" rel="nofollow noreferrer">Node.js v12.9.1 Documentation</a>  

The same goes for <a href="https://nodejs.org/docs/latest-v10.x/api/child_process.html#child_process_child_process_spawn_command_args_options" rel="nofollow noreferrer">Node.js v10.16.3 Documentation</a> and <a href="https://nodejs.org/docs/latest-v8.x/api/child_process.html#child_process_child_process_spawn_command_args_options" rel="nofollow noreferrer">Node.js v8.16.1 Documentation</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: How to get a random number in Ruby (score [515026](https://stackoverflow.com/q/198460) in 2018)

#### Question
How do I generate a random number between `0` and `n`?  

#### Answer accepted (score 941)
Use <a href="http://www.ruby-doc.org/core-2.1.3/Kernel.html#method-i-rand" rel="noreferrer">`rand(range)`</a>  

From <a href="http://www.codeodor.com/index.cfm/2007/3/25/Ruby-random-numbers/1042" rel="noreferrer">Ruby Random Numbers</a>:  

<blockquote>
  If you needed a random integer to simulate a roll of a six-sided die, you'd use: `1 + rand(6)`. A roll in craps could be simulated with `2 + rand(6) + rand(6)`.  
  
  Finally, if you just need a random float, just call `rand` with no arguments.  
</blockquote>

<hr>

As <a href="https://stackoverflow.com/users/8279/marc-andre-lafortune">Marc-André Lafortune</a> mentions in <a href="https://stackoverflow.com/questions/198460/how-to-get-a-random-number-in-ruby/2773866#2773866">his answer below (go upvote it)</a>, <a href="http://www.ruby-lang.org/en/news/2009/07/20/ruby-1-9-2-preview-1-released/" rel="noreferrer">Ruby 1.9.2 has its own `Random` class</a> (that Marc-André himself <a href="http://redmine.ruby-lang.org/issues/show/3104" rel="noreferrer">helped to debug</a>, hence the <a href="http://redmine.ruby-lang.org/versions/show/11" rel="noreferrer">1.9.2 target</a> for that feature).  

For instance, in this <a href="http://www.eggheadcafe.com/software/aspnet/35817496/random-integer-within-a-r.aspx" rel="noreferrer">game where you need to guess 10 numbers</a>, you can initialize them with:  

```ruby
10.times.map{ 20 + Random.rand(11) } 
#=> [26, 26, 22, 20, 30, 26, 23, 23, 25, 22]
```

Note:   

<ul>
<li><p>Using `Random.new.rand(20..30)` (using `Random.new`) generally would not be a good idea, as explained in detail (again) by <a href="https://stackoverflow.com/users/8279/marc-andre-lafortune">Marc-André Lafortune</a>, in <a href="https://stackoverflow.com/questions/198460/how-to-get-a-random-number-in-ruby/2773866#2773866">his answer</a> (again).</p></li>
<li><p>But if you don't use `Random.new`, then the <a href="http://www.ruby-doc.org/core/classes/Random.src/M000693.html" rel="noreferrer">class method `rand`</a> only takes a `max` value, not a `Range`, as <a href="https://stackoverflow.com/users/66725/banister">banister</a> (energetically) points out in the comment (and as documented in the <a href="http://www.ruby-doc.org/core/classes/Random.html" rel="noreferrer">docs for `Random`</a>).  Only the <a href="http://www.ruby-doc.org/core/classes/Random.src/M000688.html" rel="noreferrer">instance method</a> can take a `Range`, as illustrated by <a href="https://stackoverflow.com/questions/5722881/generate-a-random-number-with-7-digits/5723105#5723105">generate a random number with 7 digits</a>.</p></li>
</ul>

This is why the equivalent of `Random.new.rand(20..30)` would be `20 + Random.rand(11)`, since `Random.rand(int)` returns “a random integer greater than or equal to zero and <em>less than the argument</em>.” `20..30` includes 30, I need to come up with a random number between 0 and 11, excluding 11.  

#### Answer 2 (score 588)
While you can use `rand(42-10) + 10` to get a random number between `10` and `42` (where 10 is inclusive and 42 exclusive), there's a better way since Ruby 1.9.3, where you are able to call:  

```ruby
rand(10...42) # => 13
```

Available for all versions of Ruby by requiring my <a href="http://github.com/marcandre/backports" rel="noreferrer">`backports`</a> gem.  

Ruby 1.9.2 also introduced the `Random` class so you can create your own random number generator objects and has a nice API:  

```ruby
r = Random.new
r.rand(10...42) # => 22
r.bytes(3) # => "rnd"
```

The `Random` class itself acts as a random generator, so you call directly:  

```ruby
Random.rand(10...42) # => same as rand(10...42)
```

<strong><em>Notes on `Random.new`</em></strong>  

In most cases, the simplest is to use `rand` or `Random.rand`. Creating a new random generator each time you want a random number is a <em>really bad idea</em>. If you do this, you will get the random properties of the initial seeding algorithm which are atrocious compared to the properties of the <a href="http://en.wikipedia.org/wiki/Mersenne_twister" rel="noreferrer">random generator itself</a>.  

If you use `Random.new`, you should thus call it <em>as rarely as possible</em>, for example once as `MyApp::Random = Random.new` and use it everywhere else.  

The cases where `Random.new` is helpful are the following:  

<ul>
<li>you are writing a gem and don't want to interfere with the sequence of `rand`/`Random.rand` that the main programs might be relying on</li>
<li>you want separate reproducible sequences of random numbers (say one per thread)</li>
<li>you want to be able to save and resume a reproducible sequence of random numbers (easy as `Random` objects can marshalled)</li>
</ul>

#### Answer 3 (score 46)
If you're not only seeking for a number but also hex or uuid it's worth mentioning that the `SecureRandom` module found its way from `ActiveSupport` to the ruby core in 1.9.2+. So without the need for a full blown framework:  

```ruby
require 'securerandom'

p SecureRandom.random_number(100) #=> 15
p SecureRandom.random_number(100) #=> 88

p SecureRandom.random_number #=> 0.596506046187744
p SecureRandom.random_number #=> 0.350621695741409

p SecureRandom.hex #=> "eb693ec8252cd630102fd0d0fb7c3485"
```

It's documented here: <a href="http://rubydoc.info/stdlib/securerandom/1.9.3/SecureRandom" rel="noreferrer">Ruby 1.9.3 - Module: SecureRandom (lib/securerandom.rb) </a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Calling shell commands from Ruby (score [504395](https://stackoverflow.com/q/2232) in 2015)

#### Question
How do I call shell commands from inside of a Ruby program? How do I then get output from these commands back into Ruby?  

#### Answer accepted (score 1269)
This explanation is based on a commented <a href="http://gist.github.com/4069" rel="noreferrer">Ruby script</a> from a friend of mine. If you want to improve the script, feel free to update it at the link.  

First, note that when Ruby calls out to a shell, it typically calls `/bin/sh`, <em>not</em> Bash. Some Bash syntax is not supported by `/bin/sh` on all systems.  

Here are ways to execute a shell script:  

```ruby
cmd = "echo 'hi'" # Sample string that can be used
```

<ol>
<li><p>`Kernel#`` , commonly called backticks – ``cmd``</p>

This is like many other languages, including Bash, PHP, and Perl.  

Returns the result (i.e. standard output) of the shell command.  

Docs: <a href="http://ruby-doc.org/core/Kernel.html#method-i-60" rel="noreferrer">http://ruby-doc.org/core/Kernel.html#method-i-60</a>  

```ruby
value = `echo 'hi'`
value = `#{cmd}`
```</li>
<li><p>Built-in syntax, `%x( cmd )`</p>

<p>Following the `x` character is a delimiter, which can be any character.
If the delimiter is one of the characters `(`, `[`, `{`, or `&lt;`,
the literal consists of the characters up to the matching closing delimiter,
taking account of nested delimiter pairs. For all other delimiters, the
literal comprises the characters up to the next occurrence of the
delimiter character.  String interpolation `#{ ... }` is allowed.</p>

Returns the result (i.e. standard output) of the shell command, just like the backticks.  

Docs: <a href="http://www.ruby-doc.org/docs/ProgrammingRuby/html/language.html" rel="noreferrer">http://www.ruby-doc.org/docs/ProgrammingRuby/html/language.html</a>  

```ruby
value = %x( echo 'hi' )
value = %x[ #{cmd} ]
```</li>
<li><p>`Kernel#system`</p>

Executes the given command in a subshell.   

Returns `true` if the command was found and run successfully, `false` otherwise.  

Docs: <a href="http://ruby-doc.org/core/Kernel.html#method-i-system" rel="noreferrer">http://ruby-doc.org/core/Kernel.html#method-i-system</a>  

```ruby
wasGood = system( "echo 'hi'" )
wasGood = system( cmd )
```</li>
<li><p>`Kernel#exec`</p>

Replaces the current process by running the given external command.  

Returns none, the current process is replaced and never continues.  

Docs: <a href="http://ruby-doc.org/core/Kernel.html#method-i-exec" rel="noreferrer">http://ruby-doc.org/core/Kernel.html#method-i-exec</a>  

```ruby
exec( "echo 'hi'" )
exec( cmd ) # Note: this will never be reached because of the line above
```</li>
</ol>

<p>Here's some extra advice:
`$?`, which is the same as `$CHILD_STATUS`, accesses the status of the last system executed command if you use the backticks, `system()` or `%x{}`.
You can then access the `exitstatus` and `pid` properties:</p>

```ruby
$?.exitstatus
```

For more reading see:  

<ul>
<li><a href="http://www.elctech.com/blog/i-m-in-ur-commandline-executin-ma-commands" rel="noreferrer">http://www.elctech.com/blog/i-m-in-ur-commandline-executin-ma-commands</a></li>
<li><a href="http://blog.jayfields.com/2006/06/ruby-kernel-system-exec-and-x.html" rel="noreferrer">http://blog.jayfields.com/2006/06/ruby-kernel-system-exec-and-x.html</a></li>
<li><a href="http://tech.natemurray.com/2007/03/ruby-shell-commands.html" rel="noreferrer">http://tech.natemurray.com/2007/03/ruby-shell-commands.html</a></li>
</ul>

#### Answer 2 (score 234)
Here's a flowchart based on <a href="https://stackoverflow.com/a/7263556/2063546">this answer</a>.  See also, <a href="https://stackoverflow.com/a/1402389/2063546">using `script` to emulate a terminal</a>.  

<a href="https://i.stack.imgur.com/1Vuvp.png" rel="noreferrer"><img src="https://i.stack.imgur.com/1Vuvp.png" alt="enter image description here"></a>  



#### Answer 3 (score 158)
The way I like to do this is using the `%x` literal, which makes it easy (and readable!) to use quotes in a command, like so:  

```ruby
directorylist = %x[find . -name '*test.rb' | sort]
```

Which, in this case, will populate file list with all test files under the current directory, which you can process as expected:  

```ruby
directorylist.each do |filename|
  filename.chomp!
  # work with file
end
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: Ruby function to remove all white spaces? (score [503134](https://stackoverflow.com/q/1634750) in 2014)

#### Question
What is the Ruby function to remove <strong>all</strong> white space? Kind of like php's `trim()`?  

#### Answer 2 (score 818)
If you want to remove only leading and trailing whitespace (like PHP's trim) you can use `.strip`, but if you want to remove <strong><em>all</em></strong> whitespace, you can use `.gsub(/\s+/, "")` instead .  

#### Answer 3 (score 478)
```ruby
s = "I have white space".delete(' ')
```

And to emulate PHP's `trim()` function:  

```ruby
s = "   I have leading and trailing white space   ".strip
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: What is the "right" way to iterate through an array in Ruby? (score [497256](https://stackoverflow.com/q/310634) in 2011)

#### Question
PHP, for all its warts, is pretty good on this count. There's no difference between an array and a hash (maybe I'm naive, but this seems obviously right to me), and to iterate through either you just do  

```ruby
foreach (array/hash as $key => $value)
```

In Ruby there are a bunch of ways to do this sort of thing:  

```ruby
array.length.times do |i|
end

array.each

array.each_index

for i in array
```

Hashes make more sense, since I just always use  

```ruby
hash.each do |key, value|
```

Why can't I do this for arrays? If I want to remember just one method, I guess I can use `each_index` (since it makes both the index and value available), but it's annoying to have to do `array[index]` instead of just `value`.  

<hr>

Oh right, I forgot about `array.each_with_index`. However, this one sucks because it goes `|value, key|` and `hash.each` goes `|key, value|`! Is this not insane?  

#### Answer accepted (score 540)
This will iterate through all the elements:  

```ruby
array = [1, 2, 3, 4, 5, 6]
array.each { |x| puts x }
```

Prints:  

```ruby
1
2
3
4
5
6
```

This will iterate through all the elements giving you the value and the index:  

```ruby
array = ["A", "B", "C"]
array.each_with_index {|val, index| puts "#{val} => #{index}" }
```

Prints:  

```ruby
A => 0
B => 1
C => 2
```

I'm not quite sure from your question which one you are looking for.  

#### Answer 2 (score 81)
I think there is no one <em>right</em> way.  There are a lot of different ways to iterate, and each has its own niche.  

<ul>
<li>`each` is sufficient for many usages, since I don't often care about the indexes.  </li>
<li>`each_ with _index` acts like Hash#each - you get the value and the index.</li>
<li>`each_index` - just the indexes.  I don't use this one often. Equivalent to "length.times".</li>
<li>`map` is another way to iterate, useful when you want to transform one array into another.</li>
<li>`select` is the iterator to use when you want to choose a subset.</li>
<li>`inject` is useful for generating sums or products, or collecting a single result. </li>
</ul>

It may seem like a lot to remember, but don't worry, you can get by without knowing all of them.  But as you start to learn and use the different methods, your code will become cleaner and clearer, and you'll be on your way to Ruby mastery.  

#### Answer 3 (score 59)
I'm not saying that `Array` -> `|value,index|` and `Hash` -> `|key,value|` is not insane (see Horace Loeb's comment), but I am saying that there is a sane way to expect this arrangement.  

When I am dealing with arrays, I am focused on the elements in the array (not the index because the index is transitory).  The method is each with index, i.e. each+index, or |each,index|, or `|value,index|`.  This is also consistent with the index being viewed as an optional argument, e.g. |value| is equivalent to |value,index=nil| which is consistent with |value,index|.  

When I am dealing with hashes, I am often more focused on the keys than the values, and I am usually dealing with keys and values in that order, either `key =&gt; value` or `hash[key] = value`.  

If you want duck-typing, then either explicitly use a defined method as Brent Longborough showed, or an implicit method as maxhawkins showed.  

Ruby is all about accommodating the language to suit the programmer, not about the programmer accommodating to suit the language.  This is why there are so many ways.  There are so many ways to think about something.  In Ruby, you choose the closest and the rest of the code usually falls out extremely neatly and concisely.  

As for the original question, "What is the “right” way to iterate through an array in Ruby?", well, I think the core way (i.e. without powerful syntactic sugar or object oriented power) is to do:  

```ruby
for index in 0 ... array.size
  puts "array[#{index}] = #{array[index].inspect}"
end
```

But Ruby is all about powerful syntactic sugar and object oriented power, but anyway here is the equivalent for hashes, and the keys can be ordered or not:  

```ruby
for key in hash.keys.sort
  puts "hash[#{key.inspect}] = #{hash[key].inspect}"
end
```

So, my answer is, "The “right” way to iterate through an array in Ruby depends on you (i.e. the programmer or the programming team) and the project.".  The better Ruby programmer makes the better choice (of which syntactic power and/or which object oriented approach).  The better Ruby programmer continues to look for more ways.  

<hr>

Now, I want to ask another question, "What is the “right” way to iterate through a Range in Ruby backwards?"!  (This question is how I came to this page.)  

It is nice to do (for the forwards):  

```ruby
(1..10).each{|i| puts "i=#{i}" }
```

but I don't like to do (for the backwards):  

```ruby
(1..10).to_a.reverse.each{|i| puts "i=#{i}" }
```

<p>Well, I don't actually mind doing that too much, but when I am teaching going backwards, I want to show my students a nice symmetry (i.e. with minimal difference, e.g. only adding a reverse, or a step -1, but without modifying anything else).
You can do (for symmetry):</p>

```ruby
(a=*1..10).each{|i| puts "i=#{i}" }
```

and  

```ruby
(a=*1..10).reverse.each{|i| puts "i=#{i}" }
```

which I don't like much, but you can't do  

```ruby
(*1..10).each{|i| puts "i=#{i}" }
(*1..10).reverse.each{|i| puts "i=#{i}" }
#
(1..10).step(1){|i| puts "i=#{i}" }
(1..10).step(-1){|i| puts "i=#{i}" }
#
(1..10).each{|i| puts "i=#{i}" }
(10..1).each{|i| puts "i=#{i}" }   # I don't want this though.  It's dangerous
```

You could ultimately do  

```ruby
class Range

  def each_reverse(&block)
    self.to_a.reverse.each(&block)
  end

end
```

but I want to teach pure Ruby rather than object oriented approaches (just yet).  I would like to iterate backwards:  

<ul>
<li>without creating an array (consider 0..1000000000)</li>
<li>working for any Range (e.g. Strings, not just Integers)</li>
<li>without using any extra object oriented power (i.e. no class modification)</li>
</ul>

I believe this is impossible without defining a `pred` method, which means modifying the Range class to use it.  If you can do this please let me know, otherwise confirmation of impossibility would be appreciated though it would be disappointing.  Perhaps Ruby 1.9 addresses this.  

(Thanks for your time in reading this.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How do I get the current absolute URL in Ruby on Rails? (score [464615](https://stackoverflow.com/q/2165665) in 2017)

#### Question
How can I get the current <strong>absolute URL</strong> in my Ruby on Rails view?  

The `request.request_uri` only returns the relative URL.  

#### Answer accepted (score 1412)
<h5>For Rails 3.2 or Rails 4+</h3>

You should use `request.original_url` to get the current URL.  

This method is documented at <a href="http://api.rubyonrails.org/classes/ActionDispatch/Request.html#method-i-original_url" rel="noreferrer">original_url method</a>, but if you're curious, the implementation is:  

```ruby
def original_url
  base_url + original_fullpath
end
```

<hr>

<h5>For Rails 3:</h3>

You can write `"#{request.protocol}#{request.host_with_port}#{request.fullpath}"`, since `request.url` is now deprecated.  

<hr>

<h5>For Rails 2:</h3>

You  can write `request.url` instead of `request.request_uri`.  This combines the protocol (usually http://) with the host, and request_uri to give you the full address.  

#### Answer 2 (score 133)
I think that the Ruby on Rails 3.0 method is now `request.fullpath`.  

#### Answer 3 (score 117)
You could use `url_for(only_path: false)`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to install a gem or updatie RubyGems if it fails with a permissions error (score [459294](https://stackoverflow.com/q/14607193) in 2019)

#### Question
I'm trying to install a gem using `gem install mygem` or update RubyGems using `gem update --system`, and it fails with this error:  

```ruby
ERROR:  While executing gem ... (Gem::FilePermissionError)
You don't have write permissions for the /Library/Ruby/Gems/2.0.0 directory.
```

Does anyone have an idea how to solve this?  

#### Answer accepted (score 310)
<blockquote>
  You don't have write permissions into the /Library/Ruby/Gems/1.8 directory.  
</blockquote>

means exactly that, you don't have permission to write there.  

That is the version of Ruby installed by Apple, for their own use. While it's OK to make minor modifications to that <em>if you know what you're doing</em>, because you are not sure about the permissions problem, I'd say it's not a good idea to continue along that track.  

Instead, I'll strongly suggest you look into using either <a href="https://github.com/sstephenson/rbenv/" rel="noreferrer">rbenv</a> or <a href="https://rvm.io/rvm/install/" rel="noreferrer">RVM</a> to manage a separate Ruby, installed into a sandbox in your home directory, that you can modify/fold/spindle/change without worrying about messing up the system Ruby.  

Between the two, I use rbenv, though I used RVM a lot in the past. rbenv takes a more "hands-off" approach to managing your Ruby installation. RVM has a lot of features and is very powerful, but, as a result is more intrusive. In either case, <em>READ</em> the installation documentation for them a couple times before starting to install whichever you pick.  

#### Answer 2 (score 394)
Try adding `--user-install` instead of using `sudo`:  

```ruby
gem install mygem --user-install
```

#### Answer 3 (score 89)
You really should be using a Ruby version manager.  

Using one properly would prevent and can resolve your permission problem when executing a `gem update` command.  

I recommend <em>rbenv</em>.  

However, even when you use a Ruby version manager, you may still get that same error message.  

If you do, and you are using rbenv, just verify that the `~/.rbenv/shims` directory is before the path for the system Ruby.  

`$ echo $PATH`  will show you the order of your load path.  

If you find that your shims directory comes after your system Ruby bin directory, then edit your `~/.bashrc` file and put this as your last export PATH command:   `export PATH=$HOME/.rbenv/shims:$PATH`  

`$ ruby -v`  shows you what version of Ruby you are using  

This shows that I'm currently using the system version of Ruby (usually not good)  

```ruby
$ ruby -v
ruby 1.8.7 (2012-02-08 patchlevel 358) [universal-darwin12.0]
```

`$ rbenv global 1.9.3-p448`  switches me to a newer, pre-installed version (see references below).  

This shows that I'm using a newer version of Ruby (that likely won't cause the Gem::FilePermissionError)  

```ruby
$ ruby -v
ruby 1.9.3p448 (2013-06-27 revision 41675) [x86_64-darwin12.4.0]
```

You typically should not need to preface a gem command with sudo. If you feel the need to do so, something is probably misconfigured.  

For details about rbenv see the following:  

<ul>
<li><a href="https://github.com/sstephenson/rbenv">https://github.com/sstephenson/rbenv</a></li>
<li><a href="http://robots.thoughtbot.com/post/47273164981/using-rbenv-to-manage-rubies-and-gems">http://robots.thoughtbot.com/post/47273164981/using-rbenv-to-manage-rubies-and-gems</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: What is attr_accessor in Ruby? (score [443423](https://stackoverflow.com/q/4370960) in 2017)

#### Question
I am having a hard time understanding `attr_accessor` in Ruby. Can someone explain this to me?  

#### Answer accepted (score 2266)
Let's say you have a class `Person`.  

```ruby
class Person
end

person = Person.new
person.name # => no method error
```

Obviously we never defined method `name`. Let's do that.  

```ruby
class Person
  def name
    @name # simply returning an instance variable @name
  end
end

person = Person.new
person.name # => nil
person.name = "Dennis" # => no method error
```

Aha, we can read the name, but that doesn't mean we can assign the name. Those are two different methods. The former is called <em>reader</em> and latter is called <em>writer</em>. We didn't create the writer yet so let's do that.  

```ruby
class Person
  def name
    @name
  end

  def name=(str)
    @name = str
  end
end

person = Person.new
person.name = 'Dennis'
person.name # => "Dennis"
```

Awesome. Now we can write and read instance variable `@name` using reader and writer methods. Except, this is done so frequently, why waste time writing these methods every time? We can do it easier.  

```ruby
class Person
  attr_reader :name
  attr_writer :name
end
```

Even this can get repetitive. When you want both reader and writer just use accessor!  

```ruby
class Person
  attr_accessor :name
end

person = Person.new
person.name = "Dennis"
person.name # => "Dennis"
```

Works the same way! And guess what: the instance variable `@name` in our person object will be set just like when we did it manually, so you can use it in other methods.  

```ruby
class Person
  attr_accessor :name

  def greeting
    "Hello #{@name}"
  end
end

person = Person.new
person.name = "Dennis"
person.greeting # => "Hello Dennis"
```

That's it. In order to understand how `attr_reader`, `attr_writer`, and `attr_accessor` methods actually generate methods for you, read other answers, books, ruby docs.   

#### Answer 2 (score 125)
<a href="http://www.ruby-doc.org/core-2.0.0/Module.html#method-i-attr_accessor" rel="noreferrer">attr_accessor</a> is <em>just a method</em>. (The link should provide more insight with how it works - look at the pairs of methods generated, and a tutorial should show you how to use it.)  

The trick is that `class` is <em>not a definition</em> in Ruby (it is "just a definition" in languages like C++ and Java), but it is an <em>expression that evaluates</em>. It is during this evaluation when the `attr_accessor` method is invoked which in turn modifies the current class - remember the implicit receiver: `self.attr_accessor`, where `self` is the "open" class object at this point.  

The need for `attr_accessor` and friends, is, well:  

<ol>
<li><p>Ruby, like Smalltalk, does not allow instance variables to be accessed outside of methods<sup>1</sup> for that object. That is, instance variables cannot be accessed in the `x.y` form as is common in say, Java or even Python. In Ruby `y` is always taken as a message to send (or "method to call"). Thus the `attr_*` methods create wrappers which proxy the instance `@variable` access through dynamically created methods.</p></li>
<li><p>Boilerplate sucks</p></li>
</ol>

Hope this clarifies some of the little details. Happy coding.  

<hr>

<sup>1</sup> This isn't strictly true and there are <a href="https://stackoverflow.com/questions/1074729/get-the-value-of-an-instance-variable-given-its-name">some "techniques" around this</a>, but there is no syntax support for "public instance variable" access.  

#### Answer 3 (score 67)
`attr_accessor` is (as @pst stated) just a method. What it does is create more methods for you.  

So this code here:  

```ruby
class Foo
  attr_accessor :bar
end
```

is equivalent to this code:  

```ruby
class Foo
  def bar
    @bar
  end
  def bar=( new_value )
    @bar = new_value
  end
end
```

You can write this sort of method yourself in Ruby:  

```ruby
class Module
  def var( method_name )
    inst_variable_name = "@#{method_name}".to_sym
    define_method method_name do
      instance_variable_get inst_variable_name
    end
    define_method "#{method_name}=" do |new_value|
      instance_variable_set inst_variable_name, new_value
    end
  end
end

class Foo
  var :bar
end

f = Foo.new
p f.bar     #=> nil
f.bar = 42
p f.bar     #=> 42
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: Parsing a JSON string in Ruby (score [425311](https://stackoverflow.com/q/5410682) in 2016)

#### Question
I have a string that I want to parse in Ruby:  

```ruby
string = '{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}'
```

Is there an easy way to extract the data?  

#### Answer accepted (score 523)
This looks like <a href="http://www.json.org" rel="noreferrer">JavaScript Object Notation (JSON)</a>. You can parse JSON that resides in some variable, e.g. `json_string`, like so:  

```ruby
require 'json'
JSON.parse(json_string)
```

If you’re using an older Ruby, you may need to install the <a href="https://rubygems.org/gems/json" rel="noreferrer">json gem</a>.  

<hr>

There are also other implementations of JSON for Ruby that may fit some use-cases better:  

<ul>
<li><a href="https://rubygems.org/gems/yajl-ruby" rel="noreferrer">YAJL C Bindings for Ruby</a></li>
<li><a href="https://rubygems.org/gems/json-stream" rel="noreferrer">JSON::Stream</a></li>
</ul>

#### Answer 2 (score 200)
Just to extend the answers a bit with what to do with the parsed object:  

```ruby
# JSON Parsing example
require "rubygems"
require "json"

string = '{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}'
parsed = JSON.parse(string) # returns a hash

p parsed["desc"]["someKey"]
p parsed["main_item"]["stats"]["a"]

# Read JSON from a file, iterate over objects
file = open("shops.json")
json = file.read

parsed = JSON.parse(json)

parsed["shop"].each do |shop|
  p shop["id"]
end
```

#### Answer 3 (score 37)
As of Ruby v1.9.3 you don't need to install any Gems in order to parse JSON, simply use `require 'json'`:  

```ruby
require 'json'

json = JSON.parse '{"foo":"bar", "ping":"pong"}'
puts json['foo'] # prints "bar"
```

See <a href="http://ruby-doc.org/stdlib-2.0.0/libdoc/json/rdoc/JSON.html" rel="noreferrer">JSON</a> at Ruby-Doc.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: What Ruby IDE do you prefer? (score [424357](https://stackoverflow.com/q/16991) in 2008)

#### Question
I've been using Eclipse with RDT (not RadRails) a lot lately, and I'm quite happy with it, but I'm wondering if you guys know any decent alternatives. I know NetBeans also supports Ruby these days, but I'm not sure what it has to offer over Eclipse.  

Please, list any features you think are brilliant or useful when suggesting an IDE, makes it easier to compare.  

Also, I said Ruby, not Rails. While Rails support is a plus, I prefer things to be none Rails-centric. It should also be available on Linux and optionally Solaris.  

#### Answer accepted (score 28)
Have you tried <a href="http://www.aptana.com/" rel="nofollow noreferrer">Aptana</a>? It's based on Eclipse and they have a sweet <a href="http://www.aptana.com/rails" rel="nofollow noreferrer">Rails</a> plugin.  

#### Answer 2 (score 76)
<a href="http://jetbrains.com/ruby/index.html" rel="nofollow noreferrer">RubyMine</a> from JetBrains. (Also available as a plugin to <a href="http://jetbrains.com/idea/index.html" rel="nofollow noreferrer">IntelliJ IDEA</a>)  

#### Answer 3 (score 26)
<a href="http://redcareditor.com/" rel="nofollow noreferrer">Redcar</a> has been getting some attention lately, as well. Still early in its life, but it shows promise.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: Checking if a variable is not nil and not zero in ruby (score [422191](https://stackoverflow.com/q/252203) in 2015)

#### Question
I am using the following code to check if a variable is not nil and not zero  

```ruby
if(discount != nil && discount != 0) 
  ...
end
```

Is there a better way to do this?  

#### Answer accepted (score 397)
<pre>
unless discount.nil? || discount == 0
  # ...
end
</pre>

#### Answer 2 (score 40)
```ruby
class Object
  def nil_zero?
    self.nil? || self == 0
  end
end

# which lets you do
nil.nil_zero? # returns true
0.nil_zero?   # returns true
1.nil_zero?   # returns false
"a".nil_zero? # returns false

unless discount.nil_zero?
  # do stuff...
end
```

Beware of the usual disclaimers... great power/responsibility, monkey patching leading to the dark side etc.  

#### Answer 3 (score 28)
<pre>
unless [nil, 0].include?(discount) 
  # ...
end
</pre>

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: How to sum array of numbers in Ruby? (score [412523](https://stackoverflow.com/q/1538789) in 2014)

#### Question
I have an array of integers.  

For example:  

```ruby
array = [123,321,12389]
```

Is there any nice way to get the sum of them?  

I know, that   

```ruby
sum = 0
array.each { |a| sum+=a }
```

would work.  

#### Answer accepted (score 598)
Try this:  

```ruby
array.inject(0){|sum,x| sum + x }
```

<a href="https://ruby-doc.org/core/Enumerable.html#method-i-inject" rel="nofollow noreferrer">See Ruby's Enumerable Documentation</a>  

(note: the `0` base case is needed so that `0` will be returned on an empty array instead of `nil`)  

#### Answer 2 (score 795)
Or try the Ruby 1.9 way:  

```ruby
array.inject(0, :+)
```

Note: the `0` base case is needed otherwise `nil` will be returned on empty arrays:  

```ruby
> [].inject(:+)
nil
> [].inject(0, :+)
0
```

#### Answer 3 (score 280)
```ruby
array.reduce(0, :+)
```

While equivalent to `array.inject(0, :+)`, the term <strong>reduce</strong> is entering a more common vernacular with the rise of <a href="http://en.wikipedia.org/wiki/MapReduce">MapReduce programming models</a>.  

<strong>inject</strong>, <strong>reduce</strong>, <strong>fold</strong>, <strong>accumulate</strong>, and <strong>compress</strong> are all synonymous as a class of <a href="http://en.wikipedia.org/wiki/Reduce_%28higher-order_function%29">folding functions</a>. I find consistency across your code base most important, but since various communities tend to prefer one word over another, it’s nonetheless useful to know the alternatives.  

To emphasize the map-reduce verbiage, here’s a version that is a little bit more forgiving on what ends up in that array.  

```ruby
array.map(&:to_i).reduce(0, :+)
```

Some additional relevant reading:  

<ul>
<li><a href="http://ruby-doc.org/core-1.9.3/Enumerable.html#method-i-inject">http://ruby-doc.org/core-1.9.3/Enumerable.html#method-i-inject</a></li>
<li><a href="http://en.wikipedia.org/wiki/MapReduce">http://en.wikipedia.org/wiki/MapReduce</a></li>
<li><a href="http://en.wikipedia.org/wiki/Fold_(higher-order_function)">http://en.wikipedia.org/wiki/Fold_(higher-order_function)</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Determining type of an object in ruby (score [395964](https://stackoverflow.com/q/15769739) in 2016)

#### Question
I'll use python as an example of what I'm looking for (you can think of it as pseudocode if you don't know Python):  

```ruby
>>> a = 1
>>> type(a)
<type 'int'>
```

I know in ruby I can do :  

```ruby
1.9.3p194 :002 > 1.class
 => Fixnum 
```

But is this the proper way to determine the type of the object?  

#### Answer accepted (score 550)
The proper way to determine the "type" of an object, which is a wobbly term in the Ruby world, is to call `object.class`.  

Since classes can inherit from other classes, if you want to determine if an object is "of a particular type" you might call `object.is_a?(ClassName)` to see if `object` is of type `ClassName` or derived from it.  

Normally type checking is not done in Ruby, but instead objects are assessed based on their ability to respond to particular methods, commonly called "<a href="http://en.wikipedia.org/wiki/Duck_typing" rel="noreferrer">Duck typing</a>". In other words, if it responds to the methods you want, there's no reason to be particular about the type.  

For example, `object.is_a?(String)` is too rigid since another class might implement methods that convert it into a string, or make it behave identically to how String behaves. `object.respond_to?(:to_s)` would be a better way to test that the object in question does what you want.  

#### Answer 2 (score 71)
you could also try: <a href="http://ruby-doc.org/core-2.0/Object.html#method-i-instance_of-3F">`instance_of?`</a>  

```ruby
p 1.instance_of? Fixnum    #=> True
p "1".instance_of? String  #=> True
p [1,2].instance_of? Array #=> True
```

#### Answer 3 (score 40)
Oftentimes in Ruby, you don't actually care what the object's class is, per se, you just care that it responds to a certain method. This is known as <a href="http://en.wikipedia.org/wiki/Duck_typing">Duck Typing</a> and you'll see it in all sorts of Ruby codebases.  

So in many (if not most) cases, its best to use Duck Typing using <a href="http://ruby-doc.org/core-2.0/Object.html#method-i-respond_to-3F">`#respond_to?(method)`</a>:  

```ruby
object.respond_to?(:to_i)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How to generate a random string in Ruby (score [394882](https://stackoverflow.com/q/88311) in 2017)

#### Question
I'm currently generating an 8-character pseudo-random uppercase string for "A" .. "Z":  

```ruby
value = ""; 8.times{value  << (65 + rand(25)).chr}
```

but it doesn't look clean, and it can't be passed as an argument since it isn't a single statement.  To get a mixed-case string "a" .. "z" plus "A" .. "Z", I changed it to:  

```ruby
value = ""; 8.times{value << ((rand(2)==1?65:97) + rand(25)).chr}
```

but it looks like trash.  

Does anyone have a better method?  

#### Answer accepted (score 941)
```ruby
(0...8).map { (65 + rand(26)).chr }.join
```

I spend too much time golfing.  

```ruby
(0...50).map { ('a'..'z').to_a[rand(26)] }.join
```

And a last one that's even more confusing, but more flexible and wastes fewer cycles:  

```ruby
o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
string = (0...50).map { o[rand(o.length)] }.join
```

#### Answer 2 (score 778)
Why not use SecureRandom?  

```ruby
require 'securerandom'
random_string = SecureRandom.hex

# outputs: 5b5cd0da3121fc53b4bc84d0c8af2e81 (i.e. 32 chars of 0..9, a..f)
```

SecureRandom also has methods for:  

<ul>
<li>base64</li>
<li>random_bytes</li>
<li>random_number</li>
</ul>

see: <a href="http://ruby-doc.org/stdlib-1.9.2/libdoc/securerandom/rdoc/SecureRandom.html" rel="noreferrer">http://ruby-doc.org/stdlib-1.9.2/libdoc/securerandom/rdoc/SecureRandom.html</a>  

#### Answer 3 (score 245)
I use this for generating random URL friendly strings with a guaranteed maximum length:  

```ruby
rand(36**length).to_s(36)
```

It generates random strings of lowercase a-z and 0-9. It's not very customizable but it's short and clean.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Begin, Rescue and Ensure in Ruby? (score [391402](https://stackoverflow.com/q/2191632) in 2014)

#### Question
I've recently started programming in Ruby, and I am looking at exception handling.  

I was wondering if `ensure` was the Ruby equivalent of `finally` in C#? Should I have:  

```ruby
file = File.open("myFile.txt", "w")

begin
  file << "#{content} \n"
rescue
  #handle the error here
ensure
  file.close unless file.nil?
end
```

or should I do this?  

```ruby
#store the file
file = File.open("myFile.txt", "w")

begin
  file << "#{content} \n"
  file.close
rescue
  #handle the error here
ensure
  file.close unless file.nil?
end
```

Does `ensure` get called no matter what, even if an exception isn't raised?  

#### Answer accepted (score 1142)
Yes, `ensure` ensures that the code is always evaluated. That's why it's called `ensure`. So, it is equivalent to Java's and C#'s `finally`.  

The general flow of `begin`/`rescue`/`else`/`ensure`/`end` looks like this:  

```ruby
begin
  # something which might raise an exception
rescue SomeExceptionClass => some_variable
  # code that deals with some exception
rescue SomeOtherException => some_other_variable
  # code that deals with some other exception
else
  # code that runs only if *no* exception was raised
ensure
  # ensure that this code always runs, no matter what
  # does not change the final value of the block
end
```

You can leave out `rescue`, `ensure` or `else`. You can also leave out the variables in which case you won't be able to inspect the exception in your exception handling code. (Well, you can always use the global exception variable to access the last exception that was raised, but that's a little bit hacky.) And you can leave out the exception class, in which case all exceptions that inherit from `StandardError` will be caught. (Please note that this does not mean that <em>all</em> exceptions are caught, because there are exceptions which are instances of `Exception` but not `StandardError`. Mostly very severe exceptions that compromise the integrity of the program such as `SystemStackError`, `NoMemoryError`, `SecurityError`, `NotImplementedError`, `LoadError`, `SyntaxError`, `ScriptError`, `Interrupt`, `SignalException` or `SystemExit`.)  

Some blocks form implicit exception blocks. For example, method definitions are implicitly also exception blocks, so instead of writing  

```ruby
def foo
  begin
    # ...
  rescue
    # ...
  end
end
```

you write just  

```ruby
def foo
  # ...
rescue
  # ...
end
```

or  

```ruby
def foo
  # ...
ensure
  # ...
end
```

The same applies to `class` definitions and `module` definitions.  

However, in the specific case you are asking about, there is actually a much better idiom. In general, when you work with some resource which you need to clean up at the end, you do that by passing a block to a method which does all the cleanup for you. It's similar to a `using` block in C#, except that Ruby is actually powerful enough that you don't have to wait for the high priests of Microsoft to come down from the mountain and graciously change their compiler for you. In Ruby, you can just implement it yourself:  

```ruby
# This is what you want to do:
File.open('myFile.txt', 'w') do |file|
  file.puts content
end

# And this is how you might implement it:
def File.open(filename, mode='r', perm=nil, opt=nil)
  yield filehandle = new(filename, mode, perm, opt)
ensure
  filehandle&.close
end
```

And what do you know: this is <em>already</em> available in the core library as `File.open`. But it is a general pattern that you can use in your own code as well, for implementing any kind of resource cleanup (à la `using` in C#) or transactions or whatever else you might think of.  

The only case where this doesn't work, if acquiring and releasing the resource are distributed over different parts of the program. But if it is localized, as in your example, then you can easily use these resource blocks.  

<hr>

BTW: in modern C#, `using` is actually superfluous, because you can implement Ruby-style resource blocks yourself:  

```ruby
class File
{
    static T open<T>(string filename, string mode, Func<File, T> block)
    {
        var handle = new File(filename, mode);
        try
        {
            return block(handle);
        }
        finally
        {
            handle.Dispose();
        }
    }
}

// Usage:

File.open("myFile.txt", "w", (file) =>
{
    file.WriteLine(contents);
});
```

#### Answer 2 (score 34)
FYI, even if an exception is re-raised in the `rescue` section, the `ensure` block will be executed before the code execution continues to the next exception handler. For instance:  

```ruby
begin
  raise "Error!!"
rescue
  puts "test1"
  raise # Reraise exception
ensure
  puts "Ensure block"
end
```

#### Answer 3 (score 14)
If you want to ensure a file is closed you should use the block form of `File.open`:  

```ruby
File.open("myFile.txt", "w") do |file|
  begin
    file << "#{content} \n"
  rescue
  #handle the error here
  end
end
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: Multi-Line Comments in Ruby? (score [387437](https://stackoverflow.com/q/2989762) in 2015)

#### Question
How can I comment multiple lines in Ruby?  

#### Answer accepted (score 1311)
```ruby
#!/usr/bin/env ruby

=begin
Every body mentioned this way
to have multiline comments.

The =begin and =end must be at the beginning of the line or
it will be a syntax error.
=end

puts "Hello world!"

<<-DOC
Also, you could create a docstring.
which...
DOC

puts "Hello world!"

"..is kinda ugly and creates
a String instance, but I know one guy
with a Smalltalk background, who
does this."

puts "Hello world!"

##
# most
# people
# do
# this


__END__

But all forgot there is another option.
Only at the end of a file, of course.
```

<ul>
<li>This is how it looks (via screenshot) - otherwise it's hard to interpret how the above comments will look. <strong>Click to Zoom-in</strong>:</li>
</ul>

<a href="https://i.stack.imgur.com/AnchE.png" rel="noreferrer"><img src="https://i.stack.imgur.com/AnchE.png" alt="Comments in a text-editor"></a>  

#### Answer 2 (score 122)
```ruby
=begin
My 
multiline
comment
here
=end
```

#### Answer 3 (score 54)
Despite the existence of `=begin` and `=end`, the normal and a more correct way to comment is to use `#`'s on each line. If you read the source of any ruby library, you will see that this is the way multi-line comments are done in almost all cases.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: How to install a specific version of a ruby gem? (score [385296](https://stackoverflow.com/q/17026441) in )

#### Question
Using the command-line `gem` tool, how can I install a specific version of a gem?  

#### Answer accepted (score 1085)
Use the `-v` flag:  

```ruby
$ gem install fog -v 1.8
```

#### Answer 2 (score 184)
Use the `--version` parameter (shortcut `-v`):  

```ruby
$ gem install rails -v 0.14.1
```

<hr>

You can also use version comparators like `&gt;=` or `~&gt;`  

```ruby
$ gem install rails -v '~> 0.14.0'
```

<hr>

Or with newer versions of <em>gem</em> even:  

```ruby
$ gem install rails:0.14.4 rubyzip:'< 1'
…
Successfully installed rails-0.14.4
Successfully installed rubyzip-0.9.9
```

#### Answer 3 (score 78)
<p>For installing
`gem install gemname -v versionnumber`</p>

<p>For uninstall
`gem uninstall gemname -v versionnumber`</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How to check if a specific key is present in a hash or not? (score [379134](https://stackoverflow.com/q/4528506) in 2016)

#### Question
I want to check whether the "user" key is present or not in the session hash. How can I do this?  

Note that I don't want to check whether the key's value is nil or not. I just want to check whether the "user" <em>key</em> is present.  

#### Answer accepted (score 893)
`Hash`'s `key?` method tells you whether a given key is present or not.  

```ruby
session.key?("user")
```

#### Answer 2 (score 283)
While `Hash#has_key?` gets the job done, as Matz notes <a href="http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/43765" rel="noreferrer">here</a>, it has been deprecated in favour of `Hash#key?`.  

```ruby
hash.key?(some_key)
```

#### Answer 3 (score 37)
In latest Ruby versions Hash instance has a <a href="http://ruby-doc.org/core-2.1.5/Hash.html#method-i-key-3F">`key?`</a> method:  

```ruby
{a: 1}.key?(:a)
=> true
```

Be sure to use the symbol key or a string key depending on what you have in your hash:  

```ruby
{'a' => 2}.key?(:a)
=> false
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How to remove a key from Hash and get the remaining hash in Ruby/Rails? (score [369464](https://stackoverflow.com/q/6227600) in 2017)

#### Question
To add a new pair to Hash I do:  

```ruby
{:a => 1, :b => 2}.merge!({:c => 3})   #=> {:a => 1, :b => 2, :c => 3}
```

Is there a similar way to delete a key from Hash ?  

This works:  

```ruby
{:a => 1, :b => 2}.reject! { |k| k == :a }   #=> {:b => 2}
```

but I would expect to have something like:  

```ruby
{:a => 1, :b => 2}.delete!(:a)   #=> {:b => 2}
```

It is important that the returning value will be the remaining hash, so I could do things like:  

```ruby
foo(my_hash.reject! { |k| k == my_key })
```

in one line.  

#### Answer accepted (score 701)
<a href="http://api.rubyonrails.org/classes/Hash.html#method-i-except">Rails has an except/except! method</a> that returns the hash with those keys removed. If you're already using Rails, there's no sense in creating your own version of this.   

```ruby
class Hash
  # Returns a hash that includes everything but the given keys.
  #   hash = { a: true, b: false, c: nil}
  #   hash.except(:c) # => { a: true, b: false}
  #   hash # => { a: true, b: false, c: nil}
  #
  # This is useful for limiting a set of parameters to everything but a few known toggles:
  #   @person.update(params[:person].except(:admin))
  def except(*keys)
    dup.except!(*keys)
  end

  # Replaces the hash without the given keys.
  #   hash = { a: true, b: false, c: nil}
  #   hash.except!(:c) # => { a: true, b: false}
  #   hash # => { a: true, b: false }
  def except!(*keys)
    keys.each { |key| delete(key) }
    self
  end
end
```

#### Answer 2 (score 196)
Oneliner plain ruby, it works only with ruby > 1.9.x:  

```ruby
1.9.3p0 :002 > h = {:a => 1, :b => 2}
 => {:a=>1, :b=>2} 
1.9.3p0 :003 > h.tap { |hs| hs.delete(:a) }
 => {:b=>2} 
```

<a href="http://blog.moertel.com/articles/2007/02/07/ruby-1-9-gets-handy-new-method-object-tap" rel="noreferrer">Tap</a> method always return the object on which is invoked...  

Otherwise if you have required `active_support/core_ext/hash` (which is automatically required in every Rails application) you can use one of the following methods depending on your needs:  

```ruby
➜  ~  irb
1.9.3p125 :001 > require 'active_support/core_ext/hash' => true 
1.9.3p125 :002 > h = {:a => 1, :b => 2, :c => 3}
 => {:a=>1, :b=>2, :c=>3} 
1.9.3p125 :003 > h.except(:a)
 => {:b=>2, :c=>3} 
1.9.3p125 :004 > h.slice(:a)
 => {:a=>1} 
```

<a href="http://as.rubyonrails.org/classes/ActiveSupport/CoreExtensions/Hash/Except.html" rel="noreferrer">except</a> uses a blacklist approach, so it removes all the keys listed as args, while <a href="http://as.rubyonrails.org/classes/ActiveSupport/CoreExtensions/Hash/Slice.html" rel="noreferrer">slice</a> uses a whitelist approach, so it removes all keys that aren't listed as arguments. There also exist the bang version of those method (`except!` and `slice!`) which modify the given hash but their return value is different both of them return an hash. It represents the removed keys for `slice!` and the keys that are kept for the `except!`:  

```ruby
1.9.3p125 :011 > {:a => 1, :b => 2, :c => 3}.except!(:a)
 => {:b=>2, :c=>3} 
1.9.3p125 :012 > {:a => 1, :b => 2, :c => 3}.slice!(:a)
 => {:b=>2, :c=>3} 
```

#### Answer 3 (score 169)
Why not just use:  

```ruby
hash.delete(key)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How do you add an array to another array in Ruby and not end up with a multi-dimensional result? (score [347066](https://stackoverflow.com/q/1801516) in 2009)

#### Question
```ruby
somearray = ["some", "thing"]

anotherarray = ["another", "thing"]

somearray.push(anotherarray.flatten!)
```

I expected  

```ruby
["some","thing","another","thing"]
```

#### Answer 2 (score 674)
You've got a workable idea, but the `#flatten!` is in the wrong place -- it flattens its receiver, so you could use it to turn `[1, 2, ['foo', 'bar']]` into `[1,2,'foo','bar']`.  

I'm doubtless forgetting some approaches, but you can <strong>concatenate</strong>:  

```ruby
a1.concat a2
a1 + a2              # creates a new array, as does a1 += a2
```

or <strong>prepend/append</strong>:  

```ruby
a1.push(*a2)         # note the asterisk
a2.unshift(*a1)      # note the asterisk, and that a2 is the receiver
```

or <strong>splice</strong>:  

```ruby
a1[a1.length, 0] = a2
a1[a1.length..0] = a2
a1.insert(a1.length, *a2)
```

or <strong>append and flatten</strong>:  

```ruby
(a1 << a2).flatten!  # a call to #flatten instead would return a new array
```

#### Answer 3 (score 199)
You can just use the `+` operator!  

```ruby
irb(main):001:0> a = [1,2]
=> [1, 2]
irb(main):002:0> b = [3,4]
=> [3, 4]
irb(main):003:0> a + b
=> [1, 2, 3, 4]
```

<p>You can read all about the array class here:
<a href="http://ruby-doc.org/core/classes/Array.html" rel="noreferrer">http://ruby-doc.org/core/classes/Array.html</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: How to drop columns using Rails migration (score [341510](https://stackoverflow.com/q/2831059) in 2019)

#### Question
What's the syntax for dropping a database table column through a Rails migration?  

#### Answer accepted (score 868)
```ruby
remove_column :table_name, :column_name
```

For instance:  

```ruby
remove_column :users, :hobby
```

would remove the hobby Column from the users table.  

#### Answer 2 (score 359)
For older versions of Rails   

```ruby
ruby script/generate migration RemoveFieldNameFromTableName field_name:datatype
```

For Rails 3 and up  

```ruby
rails generate migration RemoveFieldNameFromTableName field_name:datatype
```

#### Answer 3 (score 115)
Rails 4 has been updated, so the change method can be used in the migration to drop a column and the migration will successfully rollback.  Please read the following warning for Rails 3 applications:  

<strong>Rails 3 Warning</strong>  

Please note that when you use this command:  

```ruby
rails generate migration RemoveFieldNameFromTableName field_name:datatype
```

The generated migration will look something like this:  

```ruby
  def up
    remove_column :table_name, :field_name
  end

  def down
    add_column :table_name, :field_name, :datatype
  end
```

Make sure to not use the change method when removing columns from a database table (example of what you don't want in the migration file in Rails 3 apps):  

```ruby
  def change
    remove_column :table_name, :field_name
  end
```

The change method in Rails 3 is not smart when it comes to remove_column, so you will not be able to rollback this migration.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: How to update Ruby Version 2.0.0 to the latest version in Mac OSX Yosemite? (score [341177](https://stackoverflow.com/q/38194032) in 2016)

#### Question
<p>I need to update my ruby version from 2.0.0 to the latest version, I can not use some gems because my version is not updated.
I had used Homebrew to install Ruby some time ago, How can i update my Ruby version?</p>

#### Answer accepted (score 635)
Open your terminal and run  

```ruby
curl -sSL https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
```

When this is complete, <strong>you need to restart your terminal</strong> for the `rvm` command to work.  

Now, run `rvm list known`   

This shows the list of versions of the ruby.  

Now, run `rvm install ruby-2.4.2`  

If you type `ruby -v` in the terminal, you should see `ruby 2.4.2`.  

If it still shows you `ruby 2.0.`, run `rvm use ruby-2.4.2 --default`.  

#### Answer 2 (score 195)
<h5>Brew only solution</h1>

<strong>Update:</strong>  

From the comments (kudos to Maksim Luzik), I haven't tested but seems like a more elegant solution:  

<blockquote>
  After installing ruby through brew, run following command to update the links to the latest ruby installation: `brew link --overwrite ruby`  
</blockquote>

<strong>Original answer:</strong>  

Late to the party, but using brew is enough. It's not necessary to install rvm and for me it just complicated things.  

By `brew install ruby` you're actually installing the latest (currently v2.4.0). However, your path finds 2.0.0 first. To avoid this just change precedence (<a href="https://stackoverflow.com/a/8731098/2628257">source</a>). I did this by changing `~/.profile` and setting:  

`export PATH=/usr/local/bin:$PATH`  

After this I found that bundler gem was still using version 2.0.0, just install it again: `gem install bundler`   

#### Answer 3 (score 95)
I recommend <strong>rbenv</strong>* <a href="https://github.com/rbenv/rbenv" rel="noreferrer">https://github.com/rbenv/rbenv</a>  

* If this meets your criteria: <a href="https://github.com/rbenv/rbenv/wiki/Why-rbenv%3F" rel="noreferrer">https://github.com/rbenv/rbenv/wiki/Why-rbenv?</a>:  

<blockquote>
  <h5>rbenv <em>does…</em></h3>
  
  <ul>
  <li>Provide support for specifying <strong>application-specific Ruby versions</strong>.</li>
  <li>Let you <strong>change the global Ruby version</strong> on a per-user basis.</li>
  <li>Allow you to <strong>override the Ruby version</strong> with an environment   variable.</li>
  </ul>
  
  <h5>In contrast with RVM, rbenv <em>does not…</em></h3>
  
  <ul>
  <li><strong>Need to be loaded into your shell.</strong> Instead, rbenv's shim approach works by adding a directory to your `$PATH`.</li>
  <li><strong>Override shell commands like `cd` or require prompt hacks.</strong> That's dangerous and error-prone.</li>
  <li><strong>Have a configuration file.</strong> There's nothing to configure except which version of Ruby you want to use.</li>
  <li><strong>Install Ruby.</strong> You can build and install Ruby yourself, or use <a href="https://github.com/sstephenson/ruby-build" rel="noreferrer">ruby-build</a> to automate
  the process.</li>
  <li><strong>Manage gemsets.</strong> <a href="http://gembundler.com/" rel="noreferrer">Bundler</a> is a better way to manage application dependencies. If you have projects that are
  not yet using Bundler you can install the
  <a href="https://github.com/jf/rbenv-gemset" rel="noreferrer">rbenv-gemset</a> plugin.</li>
  <li><strong>Require changes to Ruby libraries for compatibility.</strong> The simplicity of rbenv means as long as it's in your `$PATH`,
  <a href="https://rvm.io/integration/bundler/" rel="noreferrer">nothing</a>
  <a href="https://rvm.io/integration/capistrano/" rel="noreferrer">else</a> needs to know about it.</li>
  </ul>
</blockquote>

<hr>

<strong>INSTALLATION</strong>  

Install <strong>Homebrew</strong> <a href="http://brew.sh" rel="noreferrer">http://brew.sh</a>  

Then:  

<pre>
$ brew update
<strike>$ brew install rbenv </strike>
$ brew install rbenv ruby-build

# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile
</pre>

<strike>  

<blockquote>
  <p><em><strong>UPDATE</strong></em><br>
  There's one additional step after `brew install rbenv` Run <code>rbenv
  init</code> and add one line to `.bash_profile` as it states. After that
  reopen your terminal window […] SGI Sep 30 at 12:01
  —<a href="https://stackoverflow.com/users/119770">https://stackoverflow.com/users/119770</a>
  </strike></p>
</blockquote>

<pre>
$ rbenv install --list
Available versions:
 1.8.5-p113
 1.8.5-p114
 […]
 2.3.1
 2.4.0-dev
 jruby-1.5.6
 […]
$ rbenv install 2.3.1
[…]
</pre>

Set the global version:  

<pre>
$ rbenv global 2.3.1
$ ruby -v
ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]
</pre>

Set the local version of your repo by adding `.ruby-version` to your repo's root dir:  

<pre>
$ cd ~/whatevs/projects/new_repo
$ echo "2.3.1" > .ruby-version
</pre>

For MacOS visit this <a href="https://gorails.com/setup/osx/10.12-sierra" rel="noreferrer">link</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: What are all the common ways to read a file in Ruby? (score [330735](https://stackoverflow.com/q/5545068) in 2013)

#### Question
What are all the common ways to read a file in Ruby?  

For instance, here is one method:  

```ruby
fileObj = File.new($fileName, "r")
while (line = fileObj.gets)
  puts(line)
end
fileObj.close
```

I know Ruby is extremely flexible. What are the benefits/drawbacks of each approach?  

#### Answer accepted (score 250)
```ruby
File.open("my/file/path", "r") do |f|
  f.each_line do |line|
    puts line
  end
end
# File is closed automatically at end of block
```

It is also possible to explicitly close file after as above (pass a block to `open` closes it for you):  

```ruby
f = File.open("my/file/path", "r")
f.each_line do |line|
  puts line
end
f.close
```

#### Answer 2 (score 316)
The easiest way if the file isn't too long is:  

```ruby
puts File.read(file_name)
```

Indeed, `IO.read` or `File.read` automatically close the file, so there is no need to use `File.open` with a block.  

#### Answer 3 (score 221)
Be wary of "slurping" files. That's when you read the entire file into memory at once.   

The problem is that it doesn't scale well. You could be developing code with a reasonably sized file, then put it into production and suddenly find you're trying to read files measuring in gigabytes, and your host is freezing up as it tries to read and allocate memory.   

Line-by-line I/O is very fast, and almost always as effective as slurping. It's surprisingly fast actually.  

I like to use:  

```ruby
IO.foreach("testfile") {|x| print "GOT ", x }
```

or  

```ruby
File.foreach('testfile') {|x| print "GOT", x }
```

File inherits from IO, and `foreach` is in IO, so you can use either.  

I have some benchmarks showing the impact of trying to read big files via `read` vs. line-by-line I/O at "<a href="https://stackoverflow.com/q/25189262/128421">Why is &quot;slurping&quot; a file not a good practice?</a>".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: Difference between rake db:migrate db:reset and db:schema:load (score [328333](https://stackoverflow.com/q/10301794) in 2014)

#### Question
The difference between `rake db:migrate` and `rake db:reset` is pretty clear in my head. The thing which I don't understand is how `rake db:schema:load` different from the former two.  

Just to be sure that I am on the same page:  

<ul>
<li>`rake db:migrate` - Runs the migrations which haven't been run yet.</li>
<li>`rake db:reset` - Clears the database (presumably does a `rake db:drop` + `rake db:create` + `rake db:migrate`) and runs migration on a fresh database.</li>
</ul>

Please help to clarify, if my understanding has gone wrong.  

#### Answer accepted (score 1248)
<ul>
<li><strong>db:migrate</strong> runs (single) migrations that have not run yet.</li>
<li><strong>db:create</strong> creates the database</li>
<li><strong>db:drop</strong> deletes the database</li>
<li><p><strong>db:schema:load</strong> creates tables and columns within the (existing) database following schema.rb</p></li>
<li><p><strong>db:setup</strong> does db:create, db:schema:load, db:seed</p></li>
<li><strong>db:reset</strong> does db:drop, db:setup</li>
</ul>

Typically, you would use db:migrate after having made changes to the schema via new migration files (this makes sense only if there is already data in the database). db:schema:load is used when you setup a new instance of your app.  

I hope that helps.  

<hr>

UPDATE for rails 3.2.12:  

I just checked the source and the dependencies are like this now:  

<ul>
<li><strong>db:create</strong> creates the database for the current env</li>
<li><strong>db:create:all</strong> creates the databases for all envs</li>
<li><strong>db:drop</strong> drops the database for the current env</li>
<li><strong>db:drop:all</strong> drops the databases for all envs</li>
<li><strong>db:migrate</strong> runs migrations for the current env that have not run yet</li>
<li><strong>db:migrate:up</strong> runs one specific migration</li>
<li><strong>db:migrate:down</strong> rolls back one specific migration</li>
<li><strong>db:migrate:status</strong> shows current migration status</li>
<li><strong>db:rollback</strong> rolls back the last migration</li>
<li><strong>db:forward</strong> advances the current schema version to the next one</li>
<li><strong>db:seed</strong> (only) runs the db/seed.rb file</li>
<li><strong>db:schema:load</strong> loads the schema into the current env's database</li>
<li><p><strong>db:schema:dump</strong> dumps the current env's schema (and seems to create the db as well)</p></li>
<li><p><strong>db:setup</strong> runs db:schema:load, db:seed</p></li>
<li><strong>db:reset</strong> runs db:drop db:setup</li>
<li><strong>db:migrate:redo</strong> runs (db:migrate:down db:migrate:up) or (db:rollback db:migrate) depending on the specified migration</li>
<li><strong>db:migrate:reset</strong> runs db:drop db:create db:migrate</li>
</ul>

For further information please have a look at <a href="https://github.com/rails/rails/blob/v3.2.12/activerecord/lib/active_record/railties/databases.rake">https://github.com/rails/rails/blob/v3.2.12/activerecord/lib/active_record/railties/databases.rake</a> (for Rails 3.2.x) and <a href="https://github.com/rails/rails/blob/v4.0.5/activerecord/lib/active_record/railties/databases.rake">https://github.com/rails/rails/blob/v4.0.5/activerecord/lib/active_record/railties/databases.rake</a> (for Rails 4.0.x)  

#### Answer 2 (score 21)
<h5>TLDR</h2>

Use    

<ul>
<li>`rake db:migrate` If you wanna make changes to the schema  </li>
<li>`rake db:reset` If you wanna drop the database, reload the schema from `schema.rb`, and reseed the database</li>
<li>`rake db:schema:load` If you wanna reset database to schema as provided in `schema.rb` (This will delete all data)</li>
</ul>

<h5>Explanations</h2>

`rake db:schema:load` will set up the schema as provided in `schema.rb` file. This is useful for a fresh install of app as it doesn't take as much time as `db:migrate`  

<blockquote>
  Important note, `db:schema:load` will <strong>delete</strong> data on server.    
</blockquote>

`rake db:migrate` makes changes to the existing schema. Its like creating versions of schema. `db:migrate` will look in `db/migrate/` for any ruby files and execute the migrations that aren't run yet starting with the oldest. Rails knows which file is the oldest by looking at the timestamp at the beginning of the migration filename. `db:migrate` comes with a benefit that data can also be put in the database. This is actually not a good practice. Its better to use `rake db:seed` to add data.  

`rake db:migrate` provides tasks <a href="https://github.com/rails/rails/blob/master/activerecord/lib/active_record/railties/databases.rake#L93" rel="noreferrer">up</a>, <a href="https://github.com/rails/rails/blob/master/activerecord/lib/active_record/railties/databases.rake#L100" rel="noreferrer">down</a> etc which enables commands like `rake db:rollback` and makes it the most useful command.   

<p>`rake db:reset` does a `db:drop` and `db:setup`<br>
It drops the database, create it again, loads the schema, and initializes with the seed data</p>

<h5>Relevant part of the commands from <a href="https://github.com/rails/rails/blob/master/activerecord/lib/active_record/railties/databases.rake" rel="noreferrer">databases.rake</a></h3>

<hr>

```ruby
namespace :schema do
  desc 'Creates a db/schema.rb file that is portable against any DB supported by Active Record'
  task :dump => [:environment, :load_config] do
    require 'active_record/schema_dumper'
    filename = ENV['SCHEMA'] || File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'schema.rb')
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
    db_namespace['schema:dump'].reenable
  end

  desc 'Loads a schema.rb file into the database'
  task :load => [:environment, :load_config, :check_protected_environments] do
    ActiveRecord::Tasks::DatabaseTasks.load_schema_current(:ruby, ENV['SCHEMA'])
  end
```

<hr>

```ruby
  # desc 'Drops and recreates the database from db/schema.rb for the current environment and loads the seeds.'
  task :reset => [ 'db:drop', 'db:setup' ]
```

<hr>

```ruby
namespace :migrate do
  # desc  'Rollbacks the database one migration and re migrate up (options: STEP=x, VERSION=x).'
  task :redo => [:environment, :load_config] do
    if ENV['VERSION']
      db_namespace['migrate:down'].invoke
      db_namespace['migrate:up'].invoke
    else
      db_namespace['rollback'].invoke
      db_namespace['migrate'].invoke
    end
  end
```

#### Answer 3 (score 2)
As far as I understand, it is going to drop your database and re-create it based on your `db/schema.rb` file. That is why you need to make sure that your `schema.rb` file is always up to date and under version control.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How do I use the conditional operator (? :) in Ruby? (score [327740](https://stackoverflow.com/q/4252936) in 2014)

#### Question
How is the conditional operator (`? :`) used in Ruby?  

For example, is this correct?  

```ruby
<% question = question.size > 20 ? question.question.slice(0, 20)+"..." : question.question %>
```

#### Answer accepted (score 480)
It is the <a href="http://en.wikipedia.org/wiki/Ternary_operation">ternary operator</a>, and it works like in C (the parenthesis are not required). It's an expression that works like:  

```ruby
if_this_is_a_true_value ? then_the_result_is_this : else_it_is_this
```

However, in Ruby, `if` is also an expression so: `if a then b else c end` === `a ? b : c`, except for precedence issues. Both are expressions.  

Examples:  

```ruby
puts (if 1 then 2 else 3 end) # => 2

puts 1 ? 2 : 3                # => 2

x = if 1 then 2 else 3 end
puts x                        # => 2
```

Note that in the first case parenthesis are required (otherwise Ruby is confused because it thinks it is `puts if 1` with some extra junk after it), but they are not required in the last case as said issue does not arise.  

You can use the "long-if" form for readability on multiple lines:  

```ruby
question = if question.size > 20 then
  question.slice(0, 20) + "..."
else 
  question
end
```

#### Answer 2 (score 34)
```ruby
puts true ? "true" : "false"
=> "true"


puts false ? "true" : "false"
=> "false"
```

#### Answer 3 (score 26)
Your use of ERB suggests that you are in Rails.  If so, then consider <a href="http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html#method-i-truncate" rel="noreferrer">`truncate`</a>, a built-in helper which will do the job for you:  

```ruby
<% question = truncate(question, :length=>30) %>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: What does %w(array) mean? (score [326817](https://stackoverflow.com/q/1274675) in 2016)

#### Question
I'm looking at the documentation for FileUtils. I'm confused by the following line:  

```ruby
FileUtils.cp %w(cgi.rb complex.rb date.rb), '/usr/lib/ruby/1.6'
```

What does the `%w` mean? Can you point me to the documentation?   

#### Answer accepted (score 1185)
`%w(foo bar)` is a shortcut for `["foo", "bar"]`. Meaning it's a notation to write an array of strings separated by spaces instead of commas and without quotes around them. You can find a list of ways of writing literals in <a href="http://www.zenspider.com/ruby/quickref.html#types" rel="noreferrer">zenspider's quickref</a>.  

#### Answer 2 (score 448)
I think of `%w()` as a "word array" - the elements are delimited by spaces and it returns an array of strings.  

There are other % literals:  

<ul>
<li>`%r()` is another way to write a regular expression.</li>
<li>`%q()` is another way to write a single-quoted string (and can be multi-line, which is useful)</li>
<li>`%Q()` gives a double-quoted string</li>
<li>`%x()` is a shell command</li>
<li>`%i()` gives an array of symbols (Ruby >= 2.0.0)</li>
<li>`%s()` turns `foo` into a symbol (`:foo`)</li>
</ul>

I don't know any others, but there may be some lurking around in there...  

#### Answer 3 (score 58)
There is also `%s` that allows you to create any symbols, for example:  

```ruby
%s|some words|          #Same as :'some words'
%s[other words]         #Same as :'other words'
%s_last example_        #Same as :'last example'
```

Since Ruby 2.0.0 you also have:  

```ruby
%i( a b c )   # => [ :a, :b, :c ]
%i[ a b c ]   # => [ :a, :b, :c ]
%i_ a b c _   # => [ :a, :b, :c ]
# etc...
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: Checking if a variable is defined? (score [323815](https://stackoverflow.com/q/288715) in 2014)

#### Question
How can I check whether a variable is defined in Ruby?  Is there an `isset`-type method available?  

#### Answer accepted (score 778)
Use the `defined?` keyword (<a href="http://ruby-doc.org/docs/keywords/1.9/Object.html#method-i-defined-3F" rel="noreferrer">documentation</a>). It will return a String with the kind of the item, or `nil` if it doesn’t exist.  

```ruby
>> a = 1
 => 1
>> defined? a
 => "local-variable"
>> defined? b
 => nil
>> defined? nil
 => "nil"
>> defined? String
 => "constant"
>> defined? 1
 => "expression"
```

As skalee commented: "It is worth noting that variable which is set to nil is initialized."  

```ruby
>> n = nil  
>> defined? n
 => "local-variable"
```

#### Answer 2 (score 91)
This is useful if you want to do nothing if it does exist but create it if it doesn't exist.  

```ruby
def get_var
  @var ||= SomeClass.new()
end
```

This only creates the new instance once. After that it just keeps returning the var.  

#### Answer 3 (score 70)
The correct syntax for the above statement is:  

```ruby
if (defined?(var)).nil? # will now return true or false
 print "var is not defined\n".color(:red)
else
 print "var is defined\n".color(:green)
end
```

substituting (`var`) with your variable. This syntax will return a true/false value for evaluation in the if statement.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How to pass command line arguments to a rake task (score [321914](https://stackoverflow.com/q/825748) in 2016)

#### Question
I have a rake task that needs to insert a value into multiple databases.    

I'd like to pass this value into the rake task from the command line, or from <em>another</em> rake task.  

How can I do this?  

#### Answer accepted (score 334)
options and dependencies need to be inside arrays:  

```ruby
namespace :thing do
  desc "it does a thing"
  task :work, [:option, :foo, :bar] do |task, args|
    puts "work", args
  end

  task :another, [:option, :foo, :bar] do |task, args|
    puts "another #{args}"
    Rake::Task["thing:work"].invoke(args[:option], args[:foo], args[:bar])
    # or splat the args
    # Rake::Task["thing:work"].invoke(*args)
  end

end
```

Then  

```ruby
rake thing:work[1,2,3]
=> work: {:option=>"1", :foo=>"2", :bar=>"3"}

rake thing:another[1,2,3]
=> another {:option=>"1", :foo=>"2", :bar=>"3"}
=> work: {:option=>"1", :foo=>"2", :bar=>"3"}
```

<blockquote>
  NOTE: variable `task` is the the task object, not very helpful unless you know/care about Rake internals.   
</blockquote>

<strong>RAILS NOTE:</strong>  

<blockquote>
  If running the task from rails, its best to preload the environment by adding `=&gt; [:environment]` which is a way to setup <em>dependent</em> tasks.   
</blockquote>

```ruby
  task :work, [:option, :foo, :bar] => [:environment] do |task, args|
    puts "work", args
  end
```

#### Answer 2 (score 1117)
You can specify formal arguments in rake by adding symbol arguments to the task call.  For example:  

```ruby
require 'rake'

task :my_task, [:arg1, :arg2] do |t, args|
  puts "Args were: #{args}"
end

task :invoke_my_task do
  Rake.application.invoke_task("my_task[1, 2]")
end

# or if you prefer this syntax...
task :invoke_my_task_2 do
  Rake::Task[:my_task].invoke(3, 4)
end

# a task with prerequisites passes its 
# arguments to it prerequisites
task :with_prerequisite, [:arg1, :arg2] => :my_task #<- name of prerequisite task

# to specify default values, 
# we take advantage of args being a Rake::TaskArguments object
task :with_defaults, :arg1, :arg2 do |t, args|
  args.with_defaults(:arg1 => :default_1, :arg2 => :default_2)
  puts "Args with defaults were: #{args}"
end
```

Then, from the command line:  

<pre>
> rake my_task[1,2]
Args were: {:arg1=>"1", :arg2=>"2"}

> rake "my_task[1, 2]"
Args were: {:arg1=>"1", :arg2=>"2"}

> rake invoke_my_task
Args were: {:arg1=>"1", :arg2=>"2"}

> rake invoke_my_task_2
Args were: {:arg1=>3, :arg2=>4}

> rake with_prerequisite[5,6]
Args were: {:arg1=>"5", :arg2=>"6"}

> rake with_defaults
Args with defaults were: {:arg1=>:default_1, :arg2=>:default_2}

> rake with_defaults['x','y']
Args with defaults were: {:arg1=>"x", :arg2=>"y"}
</pre>

As demonstrated in the second example, if you want to use spaces, the quotes around the target name are necessary to keep the shell from splitting up the arguments at the space.  

Looking at the code in <strong>rake.rb</strong>, it appears that rake does not parse task strings to extract arguments for prerequisites, so you can't do `task :t1 =&gt; "dep[1,2]"`.  The only way to specify different arguments for a prerequisite would be to invoke it explicitly within the dependent task action, as in `:invoke_my_task` and `:invoke_my_task_2`.  

Note that some shells (like zsh) require you to escape the brackets: `rake my_task\['arg1'\]`  

#### Answer 3 (score 327)
In addition to answer by kch (I didn't find how to leave a comment to that, sorry):  

You don't have to specify variables as `ENV` variables before the `rake` command. You can just set them as usual command line parameters like that:  

```ruby
rake mytask var=foo
```

and access those from your rake file as ENV variables like such:  

```ruby
p ENV['var'] # => "foo"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Replace words in a string - Ruby (score [320293](https://stackoverflow.com/q/8381499) in 2018)

#### Question
I have a string in Ruby:  

```ruby
sentence = "My name is Robert"
```

How can I replace any one word in this sentence easily without using complex code or a loop?  

#### Answer accepted (score 51)
You can try using this way :  

```ruby
sentence ["Robert"] = "Roger"
```

Then the sentence will become :  

```ruby
sentence = "My name is Roger" # Robert is replaced with Roger
```

#### Answer 2 (score 467)
```ruby
sentence.sub! 'Robert', 'Joe'
```

Won't cause an exception if the replaced word isn't in the sentence (the `[]=` variant will).  

<h5>How to replace all instances?</h2>

The above replaces only the first instance of "Robert".   

To replace all instances use `gsub`/`gsub!` (ie. "global substitution"):  

```ruby
sentence.gsub! 'Robert', 'Joe'
```

The above will replace all instances of Robert with Joe.  

#### Answer 3 (score 120)
If you're dealing with natural language text and need to replace a word, not just part of a string, you have to add a pinch of regular expressions to your gsub as a plain text substitution can lead to disastrous results:  

```ruby
'mislocated cat, vindicating'.gsub('cat', 'dog')
=> "mislodoged dog, vindidoging"
```

Regular expressions have word boundaries, such as `\b` which matches start or end of a word. Thus,  

```ruby
'mislocated cat, vindicating'.gsub(/\bcat\b/, 'dog')
=> "mislocated dog, vindicating"
```

In Ruby, unlike some other languages like Javascript, word boundaries are UTF-8-compatible, so you can use it for languages with non-Latin or extended Latin alphabets:  

```ruby
'сіль у кисіль, для весіль'.gsub(/\bсіль\b/, 'цукор')
=> "цукор у кисіль, для весіль"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How can I delete one element from an array by value (score [319020](https://stackoverflow.com/q/10034678) in 2019)

#### Question
I have an array of elements in Ruby  

```ruby
[2,4,6,3,8]
```

I need to remove  elements with value `3` for example  

How do I do that?  

#### Answer accepted (score 446)
I think I've figured it out:  

```ruby
a = [2,4,6,3,8]
a.delete(3)
```

#### Answer 2 (score 211)
Borrowing from <strong>Travis</strong> in the comments, this is a better answer:  

<blockquote>
  I personally like `[1, 2, 7, 4, 5] - [7]` which results in `=&gt; [1, 2, 4, 5]` from `irb`  
</blockquote>

<em>I modified his answer seeing that 3 was the third element in his example array. This could lead to some confusion for those who don't realize that 3 is in position 2 in the array.</em>   

#### Answer 3 (score 64)
Another option:  

```ruby
a = [2,4,6,3,8]

a -= [3]
```

which results in  

```ruby
=> [2, 4, 6, 8] 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: Ruby: Can I write multi-line string with no concatenation? (score [313943](https://stackoverflow.com/q/2337510) in 2012)

#### Question
Is there a way to make this look a little better?  

```ruby
conn.exec 'select attr1, attr2, attr3, attr4, attr5, attr6, attr7 ' +
          'from table1, table2, table3, etc, etc, etc, etc, etc, ' +
          'where etc etc etc etc etc etc etc etc etc etc etc etc etc'
```

Like, is there a way to imply concatenation?  

#### Answer accepted (score 552)
There are pieces to this answer that helped me get what I needed (easy multi-line concatenation WITHOUT extra whitespace), but since none of the actual answers had it, I'm compiling them here:  

```ruby
str = 'this is a multi-line string'\
  ' using implicit concatenation'\
  ' to prevent spare \n\'s'

=> "this is a multi-line string using implicit concatenation to eliminate spare
\\n's"
```

As a bonus, here's a version using funny HEREDOC syntax (via <a href="http://graysoftinc.com/ruby-voodoo/working-with-multiline-strings" rel="noreferrer">this link</a>):  

```ruby
p <<END_SQL.gsub(/\s+/, " ").strip
SELECT * FROM     users
         ORDER BY users.id DESC
END_SQL
# >> "SELECT * FROM users ORDER BY users.id DESC"
```

The latter would mostly be for situations that required more flexibility in the processing. I personally don't like it, it puts the processing in a weird place w.r.t. the string (i.e., in front of it, but using instance methods that usually come afterward), but it's there. Note that if you are indenting the last `END_SQL` identifier (which is common, since this is probably inside a function or module), you will need to use the hyphenated syntax (that is, `p &lt;&lt;-END_SQL` instead of `p &lt;&lt;END_SQL`). Otherwise, the indenting whitespace causes the identifier to be interpreted as a continuation of the string.  

This doesn't save much typing, but it looks nicer than using + signs, to me.  

EDIT: Adding one more:  

```ruby
p %{
SELECT * FROM     users
         ORDER BY users.id DESC
}.gsub(/\s+/, " ").strip
# >> "SELECT * FROM users ORDER BY users.id DESC"
```

#### Answer 2 (score 165)
Yes, if you don't mind the extra newlines being inserted:  

```ruby
 conn.exec 'select attr1, attr2, attr3, attr4, attr5, attr6, attr7
            from table1, table2, table3, etc, etc, etc, etc, etc,
            where etc etc etc etc etc etc etc etc etc etc etc etc etc'
```

Alternatively you can use a <a href="http://www.ruby-doc.org/docs/ruby-doc-bundle/Manual/man-1.4/syntax.html#here_doc" rel="noreferrer">heredoc</a>:  

```ruby
conn.exec <<-eos
   select attr1, attr2, attr3, attr4, attr5, attr6, attr7
   from table1, table2, table3, etc, etc, etc, etc, etc,
   where etc etc etc etc etc etc etc etc etc etc etc etc etc
eos
```

#### Answer 3 (score 163)
In ruby 2.0 you can now just use `%`  

For example:  

```ruby
SQL = %{
SELECT user, name
FROM users
WHERE users.id = #{var}
LIMIT #{var2}
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How to execute a Ruby script in Terminal? (score [309118](https://stackoverflow.com/q/8721369) in 2014)

#### Question
I've set everything up that I need on my Mac (Ruby, Rails, Homebrew, Git, etc), and I've even written a small program. Now, how do I execute it in Terminal? I wrote the program in Redcar and saved it as a .rb, but I don't know how to execute it through Terminal. I want to run the program and see if it actually works. How do I do this?   

#### Answer 2 (score 229)
Just call: `ruby your_program.rb`  

or  

<ul>
<li>start your program with `#!/usr/bin/env ruby`,</li>
<li>make your file executable by running `chmod +x your_program.rb`</li>
<li>and do `./your_program.rb some_param`</li>
</ul>

#### Answer 3 (score 32)
<p>Open your terminal and open folder where file is saved.<br>
Ex `/home/User1/program/test.rb`<br></p>

<ol>
<li>Open terminal </li>
<li>`cd /home/User1/program`</li>
<li>`ruby test.rb`</li>
</ol>

format or test.rb  

```ruby
class Test 
  def initialize
   puts "I love India"
  end
end

# initialize object
Test.new
```

<strong>output</strong>  

```ruby
I love India
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: How can I install a local gem? (score [305796](https://stackoverflow.com/q/220176) in 2013)

#### Question
If I download a .gem file to a folder in my computer, can I install it later using `gem install`?  

#### Answer accepted (score 281)
Yup, when you do `gem install`, it will search the current directory first, so if your .gem file is there, it will pick it up. I found it on the <a href="https://guides.rubygems.org/command-reference/#gem-install" rel="noreferrer">gem reference</a>, which you may find handy as well:  

<blockquote>
  <p>gem install will install the named
  gem. It will attempt a local
  installation (i.e. a .gem file in the
  current directory), and if that fails,
  it will attempt to download and
  install the most recent version of the
  gem you want.</p>
</blockquote>

#### Answer 2 (score 323)
Also, you can use `gem install --local path_to_gem/filename.gem`  

This will skip the usual gem repository scan that happens when you leave off `--local`.  

You can find other magic with `gem install --help`.  

#### Answer 3 (score 60)
you can also <strong>use the full filename to your gem file:</strong>  

```ruby
gem install /full/path/to/your.gem
```

this works as well -- it's probably the easiest way  

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: What does the "map" method do in Ruby? (score [305419](https://stackoverflow.com/q/12084507) in 2014)

#### Question
I'm new to programming. Can someone explain what `.map` would do in:  

```ruby
params = (0...param_count).map
```

#### Answer accepted (score 420)
The `map` method takes an enumerable object and a block, and runs the block for each element, outputting each returned value from the block (the original object is unchanged unless you use `map!)`:  

```ruby
[1, 2, 3].map { |n| n * n } #=> [1, 4, 9]
```

`Array` and `Range` are enumerable types. `map` with a block returns an Array.  `map!` mutates the original array.  

Where is this helpful, and what is the difference between `map!` and `each`? Here is an example:  

```ruby
names = ['danil', 'edmund']

# here we map one array to another, convert each element by some rule
names.map! {|name| name.capitalize } # now names contains ['Danil', 'Edmund']

names.each { |name| puts name + ' is a programmer' } # here we just do something with each element
```

The output:  

```ruby
Danil is a programmer
Edmund is a programmer
```

#### Answer 2 (score 64)
`map`, along with `select` and `each` is one of Ruby's workhorses in my code.  

It allows you to run an operation on each of your array's objects and return them all in the same place. An example would be to increment an array of numbers by one:  

```ruby
[1,2,3].map {|x| x + 1 }
#=> [2,3,4]
```

If you can run a single method on your array's elements you can do it in a shorthand-style like so:  

<ol>
<li><p>To do this with the above example you'd have to do something like this</p>

```ruby
class Numeric
  def plusone
    self + 1
  end
end
[1,2,3].map(&:plusone)
#=> [2,3,4]
```</li>
<li><p>To more simply use the ampersand shortcut technique, let's use a different example:</p>

```ruby
["vanessa", "david", "thomas"].map(&:upcase)
#=> ["VANESSA", "DAVID", "THOMAS"]
```</li>
</ol>

Transforming data in Ruby often involves a cascade of `map` operations. Study `map` &amp; `select`, they are some of the most useful Ruby methods in the primary library. They're just as important as `each`.  

(`map` is also an alias for `collect`. Use whatever works best for you conceptually.)  

<strong>More helpful information:</strong>  

If the <a href="http://ruby-doc.org/core-2.2.3/Enumerable.html" rel="noreferrer">Enumerable</a> object you're running `each` or `map` on contains a set of Enumerable elements (hashes, arrays), you can declare each of those elements inside your block pipes like so:  

```ruby
[["audi", "black", 2008], ["bmw", "red", 2014]].each do |make, color, year|
  puts "make: #{make}, color: #{color}, year: #{year}"
end
# Output:
# make: audi, color: black, year: 2008
# make: bmw, color: red, year: 2014
```

In the case of a Hash (also an `Enumerable` object, a Hash is simply an array of tuples with special instructions for the interpreter). The first "pipe parameter" is the key, the second is the value.  

```ruby
{:make => "audi", :color => "black", :year => 2008}.each do |k,v|
    puts "#{k} is #{v}"
end
#make is audi
#color is black
#year is 2008
```

<strong>To answer the actual question:</strong>  

Assuming that `params` is a hash, this would be the best way to map through it: Use two block parameters instead of one to capture the key &amp; value pair for each interpreted tuple in the hash.  

```ruby
params = {"one" => 1, "two" => 2, "three" => 3}
params.each do |k,v|
  puts "#{k}=#{v}"
end
# one=1
# two=2
# three=3
```

#### Answer 3 (score 6)
Using ruby 2.4 you can do the same thing using `transform_values`, this feature extracted from rails to ruby.  

```ruby
h = {a: 1, b: 2, c: 3}

h.transform_values { |v| v * 10 }
 #=> {a: 10, b: 20, c: 30}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How to split a delimited string in Ruby and convert it to an array? (score [301478](https://stackoverflow.com/q/975769) in 2017)

#### Question
I have a string  

`"1,2,3,4"`  

and I'd like to convert it into an array:  

```ruby
[1,2,3,4]
```

How?  

#### Answer accepted (score 401)
```ruby
>> "1,2,3,4".split(",")
=> ["1", "2", "3", "4"]
```

Or for integers:  

```ruby
>> "1,2,3,4".split(",").map { |s| s.to_i }
=> [1, 2, 3, 4]
```

Or for later versions of ruby (>= 1.9 - as pointed out by Alex):  

```ruby
>> "1,2,3,4".split(",").map(&:to_i)
=> [1, 2, 3, 4]
```

#### Answer 2 (score 31)
`"1,2,3,4".split(",")` as strings  

`"1,2,3,4".split(",").map { |s| s.to_i }` as integers  

#### Answer 3 (score 17)
<h5>For `String Integer` without space as `String`</h3>

```ruby
arr = "12345"

arr.split('')

output: ["1","2","3","4","5"]
```

<h5>For `String Integer` with space as `String`</h3>

```ruby
arr = "1 2 3 4 5"

arr.split(' ')

output: ["1","2","3","4","5"]
```

<h5>For `String Integer` without space as `Integer`</h3>

```ruby
arr = "12345"

arr.split('').map(&:to_i)

output: [1,2,3,4,5]
```

<h5>For String</h3>

```ruby
arr = "abc"

arr.split('')

output: ["a","b","c"]
```

<strong>Explanation</strong>:  

<ol>
<li>`arr` -> string which you're going to perform any action.</li>
<li>`split()` -> is an method, which split the input and store it as array.</li>
<li>`''` or `' '` or `','` -> is an value, which is needed to be removed from given string.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How to break out from a ruby block? (score [300787](https://stackoverflow.com/q/1402757) in 2016)

#### Question
Here is `Bar#do_things`:  

```ruby
class Bar   
  def do_things
    Foo.some_method(x) do |x|
      y = x.do_something
      return y_is_bad if y.bad? # how do i tell it to stop and return do_things? 
      y.do_something_else
    end
    keep_doing_more_things
  end
end
```

And here is `Foo#some_method`:   

```ruby
class Foo
  def self.some_method(targets, &block)
    targets.each do |target|
      begin
        r = yield(target)
      rescue 
        failed << target
      end
    end
  end
end
```

I thought about using raise, but I am trying to make it generic, so I don't want to put anything any specific in `Foo`.  

#### Answer accepted (score 723)
Use the keyword  `next`. If you do not want to continue to the next item, use `break`.  

When `next` is used within a block, it causes the block to exit immediately, returning control to the iterator method, which may then begin a new iteration by invoking the block again:  

```ruby
f.each do |line|              # Iterate over the lines in file f
  next if line[0,1] == "#"    # If this line is a comment, go to the next
  puts eval(line)
end
```

When used in a block, `break` transfers control out of the block, out of the iterator that invoked the block, and to the first expression following the invocation of the iterator:  

```ruby
f.each do |line|             # Iterate over the lines in file f
  break if line == "quit\n"  # If this break statement is executed...
  puts eval(line)
end
puts "Good bye"              # ...then control is transferred here
```

And finally, the usage of `return` in a block:  

`return` always causes the enclosing method to return, regardless of how deeply nested within blocks it is (except in the case of lambdas):  

```ruby
def find(array, target)
  array.each_with_index do |element,index|
    return index if (element == target)  # return from find
  end
  nil  # If we didn't find the element, return nil
end
```

#### Answer 2 (score 55)
I wanted to just be able to break out of a block - sort of like a forward goto, not really related to a loop.  In fact, I want to break of of a block that is in a loop without terminating the loop.  To do that, I made the block a one-iteration loop:  

```ruby
for b in 1..2 do
    puts b
    begin
        puts 'want this to run'
        break
        puts 'but not this'
    end while false
    puts 'also want this to run'
end
```

Hope this helps the next googler that lands here based on the subject line.  

#### Answer 3 (score 38)
If you want your block to return a useful value (e.g. when using `#map`, `#inject`, etc.), `next` and `break` also accept an argument.  

Consider the following:  

```ruby
def contrived_example(numbers)
  numbers.inject(0) do |count, x|
    if x % 3 == 0
      count + 2
    elsif x.odd?
      count + 1
    else 
      count
    end
  end
end
```

The equivalent using `next`:  

```ruby
def contrived_example(numbers)
  numbers.inject(0) do |count, x|
    next count if x.even?
    next (count + 2) if x % 3 == 0
    count + 1
  end
end
```

Of course, you could always extract the logic needed into a method and call that from inside your block:  

```ruby
def contrived_example(numbers)
  numbers.inject(0) { |count, x| count + extracted_logic(x) }
end

def extracted_logic(x)
  return 0 if x.even?
  return 2 if x % 3 == 0
  1
end
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: A concise explanation of nil v. empty v. blank in Ruby on Rails (score [298526](https://stackoverflow.com/q/885414) in 2013)

#### Question
I find myself repeatedly looking for a clear definition of the differences of `nil?`, `blank?`, and `empty?` in Ruby on Rails.  Here's the closest I've come:  

<ul>
<li><p>`blank?` objects are false, empty, or a whitespace string. For example, `""`, `" "`, `nil`, `[]`, and `{}` are blank.</p></li>
<li><p>`nil?` objects are instances of NilClass.</p></li>
<li><p>`empty?` objects are class-specific, and the definition varies from class to class. A string is empty if it has no characters, and an array is empty if it contains no items.</p></li>
</ul>

Is there anything missing, or a tighter comparison that can be made?  

#### Answer accepted (score 1394)
`.nil?` can be used on any object and is true if the object is nil.  

`.empty?` can be used on strings, arrays and hashes and returns true if:  

<ul>
<li>String length == 0</li>
<li>Array length == 0</li>
<li>Hash length == 0</li>
</ul>

Running `.empty?` on something that is nil will throw a `NoMethodError`.  

That is where `.blank?` comes in. It is <a href="http://apidock.com/rails/Object/blank%3F" rel="noreferrer">implemented by Rails</a> and will operate on any object as well as work like `.empty?` on strings, arrays and hashes.  

```ruby
nil.blank? == true
false.blank? == true
[].blank? == true
{}.blank? == true
"".blank? == true
5.blank? == false
0.blank? == false
```

`.blank?` also evaluates true on strings which are non-empty but contain only whitespace:  

```ruby
"  ".blank? == true
"  ".empty? == false
```

<a href="http://apidock.com/rails/Object/presence" rel="noreferrer">Rails also provides</a> `.present?`, which returns the negation of `.blank?`.  

Array gotcha: `blank?` will return `false` even if all <em>elements</em> of an array are blank. To determine blankness in this case, use `all?` with `blank?`, for example:  

```ruby
[ nil, '' ].blank? == false
[ nil, '' ].all? &:blank? == true 
```

#### Answer 2 (score 657)
I made this useful table with all the cases:  

<img src="https://i.stack.imgur.com/oXuhJ.png" alt="enter image description here">  

`blank?`, `present?` are provided by Rails.  

#### Answer 3 (score 209)
Just extend Julian's table:  

<a href="https://i.stack.imgur.com/qbe46.png"><img src="https://i.stack.imgur.com/qbe46.png" alt="enter image description here"></a>  

Ref: <a href="http://sibevin.github.io/posts/2014-11-11-103928-rails-empty-vs-blank-vs-nil">empty?blank?nil?傻傻分不清楚</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: Why use Ruby's attr_accessor, attr_reader and attr_writer? (score [296881](https://stackoverflow.com/q/5046831) in 2013)

#### Question
Ruby has this handy and convenient way to share instance variables by using keys like  

```ruby
attr_accessor :var
attr_reader :var
attr_writer :var
```

Why would I choose `attr_reader` or `attr_writer` if I could simply use `attr_accessor`? Is there something like performance (which I doubt)? I guess there is a reason, otherwise they wouldn't have made such keys.  

#### Answer accepted (score 734)
You may use the different accessors to communicate your intent to someone reading your code, and make it easier to write classes which will work correctly no matter how their public API is called.  

```ruby
class Person
  attr_accessor :age
  ...
end
```

Here, I can see that I may both read and write the age.  

```ruby
class Person
  attr_reader :age
  ...
end
```

Here, I can see that I may only read the age.  Imagine that it is set by the constructor of this class and after that remains constant.  If there were a mutator (writer) for age and the class were written assuming that age, once set, does not change, then a bug could result from code calling that mutator.  

But what is happening behind the scenes?  

If you write:  

```ruby
attr_writer :age
```

That gets translated into:  

```ruby
def age=(value)
  @age = value
end
```

If you write:  

```ruby
attr_reader :age
```

That gets translated into:  

```ruby
def age
  @age
end
```

If you write:  

```ruby
attr_accessor :age
```

That gets translated into:  

```ruby
def age=(value)
  @age = value
end

def age
  @age
end
```

Knowing that, here's another way to think about it: If you did not have the attr_... helpers, and had to write the accessors yourself, would you write any more accessors than your class needed?  For example, if age only needed to be read, would you also write a method allowing it to be written?  

#### Answer 2 (score 23)
All of the answers above are correct; `attr_reader` and `attr_writer` are more convenient to write than manually typing the methods they are shorthands for. Apart from that they offer much better performance than writing the method definition yourself. For more info see slide 152 onwards from <a href="http://www.slideshare.net/tenderlove/zomg-why-is-this-code-so-slow/152">this talk</a> (<a href="http://tenderlovemaking.com/RubyConf2010.pdf">PDF</a>) by Aaron Patterson.  

#### Answer 3 (score 15)
Not all attributes of an object are meant to be directly set from outside the class. Having writers for all your instance variables is generally a sign of weak encapsulation and a warning that you're introducing too much coupling between your classes.  

As a practical example: I wrote a design program where you put items inside containers. The item had `attr_reader :container`, but it didn't make sense to offer a writer, since the only time the item's container should change is when it's placed in a new one, which also requires positioning information.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Tell Ruby Program to Wait some amount of time (score [296044](https://stackoverflow.com/q/1329967) in 2016)

#### Question
How do you tell a Ruby program to wait an arbitrary amount of time before moving on to the next line of code?  

#### Answer accepted (score 627)
Like this:  

```ruby
sleep(num_secs)
```

The `num_secs` value can be an integer or float.  

Also, if you're writing this within a Rails app, or have included the ActiveSupport library in your project, you can construct longer intervals using the following convenience syntax:  

```ruby
sleep(4.minutes)
# or, even longer...
sleep(2.hours); sleep(3.days) # etc., etc.
# or shorter
sleep(0.5) # half a second
```

#### Answer 2 (score 112)
Use <a href="http://apidock.com/ruby/Kernel/sleep" rel="noreferrer">sleep</a> like so:  

```ruby
sleep 2
```

That'll sleep for 2 seconds.  

Be careful to give an argument. If you just run `sleep`, the process will sleep forever. (This is useful when you want a thread to sleep until it's woken.)  

#### Answer 3 (score 2)
I find `until` very useful with sleep. example:  

```ruby
> time = Time.now
> sleep 2.seconds until Time.now > time + 10.seconds # breaks when true
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: How to read lines of a file in Ruby (score [287879](https://stackoverflow.com/q/6012930) in 2016)

#### Question
I was trying to use the following code to read lines from a file. But when reading a <a href="http://dl.dropbox.com/u/559353/rss20.xml.txt">file</a>, the contents are all in one line:  

```ruby
line_num=0
File.open('xxx.txt').each do |line|
  print "#{line_num += 1} #{line}"
end
```

But this <a href="http://dl.dropbox.com/u/559353/new.txt">file</a> prints each line separately.  

<hr>

I have to use stdin, like `ruby my_prog.rb &lt; file.txt`, where I can't assume what the line-ending character is that the file uses. How can I handle it?  

#### Answer accepted (score 144)
I believe my answer covers your new concerns about handling any type of line endings since both `"\r\n"` and `"\r"` are converted to Linux standard `"\n"` before parsing the lines.  

To support the `"\r"` EOL character along with the regular `"\n"`, and `"\r\n"` from Windows, here's what I would do:  

```ruby
line_num=0
text=File.open('xxx.txt').read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  print "#{line_num += 1} #{line}"
end
```

Of course this could be a bad idea on very large files since it means loading the whole file into memory.  

#### Answer 2 (score 503)
Ruby does have a method for this:  

```ruby
File.readlines('foo').each do |line|
```

<a href="http://ruby-doc.org/core-1.9.3/IO.html#method-c-readlines" rel="noreferrer">http://ruby-doc.org/core-1.9.3/IO.html#method-c-readlines</a>  

#### Answer 3 (score 372)
```ruby
File.foreach(filename).with_index do |line, line_num|
   puts "#{line_num}: #{line}"
end
```

This will execute the given block for each line in the file without slurping the entire file into memory.  See: <a href="https://ruby-doc.org/core-2.3.1/IO.html#method-c-foreach">IO::foreach</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Rails 4: List of available datatypes (score [277783](https://stackoverflow.com/q/17918117) in 2016)

#### Question
<p>Where can I find a list of data types that can be used in Ruby on Rails 4? 
Such as </p>

<ul>
<li>`text` </li>
<li>`string` </li>
<li>`integer` </li>
<li>`float` </li>
<li>`date`  </li>
</ul>

I keep learning about new ones and I'd love to have a list I could easily refer to.  

#### Answer accepted (score 641)
Here are all the Rails 4 (ActiveRecord migration) datatypes:  

<ul>
<li>`:binary`</li>
<li>`:boolean`</li>
<li>`:date`</li>
<li>`:datetime`</li>
<li>`:decimal`</li>
<li>`:float`</li>
<li>`:integer`</li>
<li>`:bigint`</li>
<li>`:primary_key`</li>
<li>`:references`</li>
<li>`:string`</li>
<li>`:text`</li>
<li>`:time`</li>
<li>`:timestamp`</li>
</ul>

<p>Source: <a href="http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_column" rel="noreferrer">http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_column</a><br>
These are the same as with <a href="https://stackoverflow.com/questions/4685009/rails-3-datatypes">Rails 3</a>.</p>

If you use PostgreSQL, you can also take advantage of these:  

<ul>
<li>`:hstore`</li>
<li>`:json`</li>
<li>`:jsonb`</li>
<li>`:array`</li>
<li>`:cidr_address`</li>
<li>`:ip_address`</li>
<li>`:mac_address`</li>
</ul>

They are stored as strings if you run your app with a not-PostgreSQL database.  

<strong>Edit, 2016-Sep-19:</strong>  

There's <a href="https://github.com/rails/rails/blob/4-2-stable/activerecord/lib/active_record/connection_adapters/postgresql_adapter.rb#L76" rel="noreferrer">a lot more</a> postgres specific datatypes in Rails 4 and <a href="https://github.com/rails/rails/blob/master/activerecord/lib/active_record/connection_adapters/postgresql_adapter.rb#L69" rel="noreferrer">even more</a> in Rails 5.  

#### Answer 2 (score 240)
You might also find it useful to know generally what these data types are used for:  

<ul>
<li>`:string` - is for small data types such as a title. (<a href="https://stackoverflow.com/questions/3354330/difference-between-string-and-text-in-rails">Should you choose string or text?</a>)</li>
<li>`:text` - is for longer pieces of textual data, such as a paragraph of information</li>
<li>`:binary` - is for storing data such as images, audio, or movies.</li>
<li>`:boolean` - is for storing true or false values.</li>
<li>`:date` - store only the date</li>
<li>`:datetime` - store the date and time into a column. </li>
<li>`:time` - is for time only</li>
<li>`:timestamp` - for storing date and time into a column.(<a href="https://stackoverflow.com/questions/409286/datetime-vs-timestamp">What's the difference between datetime and timestamp?</a>)</li>
<li>`:decimal` - is for decimals (<a href="https://stackoverflow.com/questions/813287/how-to-store-decimal-values-in-sql-server">example of how to use decimals</a>).</li>
<li>`:float` - is for decimals. (<a href="https://stackoverflow.com/questions/8514167/float-vs-decimal-in-activerecord">What's the difference between decimal and float?</a>)</li>
<li>`:integer` - is for whole numbers.</li>
<li>`:primary_key` - unique key that can uniquely identify each row in a table</li>
</ul>

There's also references used to create associations. But, <a href="https://stackoverflow.com/questions/6242100/what-is-and-examples-of-using-data-type-references">I'm not sure this is an actual data type</a>.  

New Rails 4 datatypes available in PostgreSQL:   

<ul>
<li>`:hstore` - storing key/value pairs within a single value (<a href="http://www.postgresql.org/docs/9.1/static/hstore.html" rel="noreferrer">learn more about this new data type</a>)</li>
<li>`:array` - an arrangement of numbers or strings in a particular row (<a href="http://reefpoints.dockyard.com/ruby/2012/09/18/rails-4-sneak-peek-postgresql-array-support.html" rel="noreferrer">learn more about it and see examples</a>)</li>
<li>`:cidr_address` - used for IPv4 or IPv6 host addresses</li>
<li>`:inet_address` - used for IPv4 or IPv6 host addresses, same as cidr_address but it also accepts values with nonzero bits to the right of the netmask</li>
<li>`:mac_address` - used for MAC host addresses</li>
</ul>

Learn more about the address datatypes <a href="http://reefpoints.dockyard.com/ruby/2012/05/18/rails-4-sneak-peek-expanded-activerecord-support-for-postgresql-datatype.html" rel="noreferrer">here</a> and <a href="http://blog.remarkablelabs.com/2012/12/a-love-affair-with-postgresql-rails-4-countdown-to-2013" rel="noreferrer">here</a>.   

Also, here's the official guide on migrations: <a href="http://edgeguides.rubyonrails.org/migrations.html" rel="noreferrer">http://edgeguides.rubyonrails.org/migrations.html</a>  

#### Answer 3 (score 155)
It is important to know not only the types but the mapping of these types to the database types, too:  

<img src="https://i.stack.imgur.com/Q0j0x.png" alt="enter image description here">  

<img src="https://i.stack.imgur.com/tuRiZ.png" alt="enter image description here">  

<hr>

Source added - <a href="https://pragprog.com/book/rails4/agile-web-development-with-rails-4">Agile Web Development with Rails 4</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How to Uninstall RVM? (score [277193](https://stackoverflow.com/q/3950260) in 2018)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/3558656/how-to-remove-rvm-ruby-version-manager-from-my-system">How to remove rvm (ruby version manager) from my system?</a>  </p>
</blockquote>



How can I uninstall (or reinstall) RVM on Ubuntu 9.10? I messed up my current installation.  

#### Answer accepted (score 835)
It’s easy; just do the following:  

```ruby
rvm implode
```

or  

```ruby
rm -rf ~/.rvm
```

And don’t forget to remove the script calls in the following files:   

<ul>
<li>`~/.bashrc` </li>
<li>`~/.bash_profile` </li>
<li>`~/.profile`</li>
</ul>

And maybe others depending on whatever shell you’re using.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Why is it bad style to `rescue Exception => e` in Ruby? (score [276074](https://stackoverflow.com/q/10048173) in 2017)

#### Question
Ryan Davis’s <a href="http://www.zenspider.com/ruby/quickref.html#general-tips" rel="noreferrer">Ruby QuickRef</a> says (without explanation):  

<blockquote>
  Don’t rescue Exception. EVER. or I will stab you.  
</blockquote>

Why not? What’s the right thing to do?  

#### Answer accepted (score 1342)
<strong>TL;DR</strong>: Use `StandardError` instead for general exception catching. When the original exception is re-raised (e.g. when rescuing to log the exception only), rescuing `Exception` is probably okay.  

<hr>

`Exception` is the root of <a href="http://rubylearning.com/images/exception.jpg" rel="noreferrer">Ruby's exception hierarchy</a>, so when you `rescue Exception` you rescue from <em>everything</em>, including subclasses such as `SyntaxError`, `LoadError`, and `Interrupt`.  

Rescuing `Interrupt` prevents the user from using <kbd>CTRL</kbd><kbd>C</kbd> to exit the program.  

Rescuing `SignalException` prevents the program from responding correctly to signals. It will be unkillable except by `kill -9`.  

Rescuing `SyntaxError` means that `eval`s that fail will do so silently.  

All of these can be shown by running this program, and trying to <kbd>CTRL</kbd><kbd>C</kbd> or `kill` it:  

```ruby
loop do
  begin
    sleep 1
    eval "djsakru3924r9eiuorwju3498 += 5u84fior8u8t4ruyf8ihiure"
  rescue Exception
    puts "I refuse to fail or be stopped!"
  end
end
```

Rescuing from `Exception` isn't even the default. Doing  

```ruby
begin
  # iceberg!
rescue
  # lifeboats
end
```

does not rescue from `Exception`, it rescues from `StandardError`. You should generally specify something more specific than the default `StandardError`, but rescuing from `Exception` <em>broadens</em> the scope rather than narrowing it, and can have catastrophic results and make bug-hunting extremely difficult.  

<hr>

If you have a situation where you do want to rescue from `StandardError` and you need a variable with the exception, you can use this form:  

```ruby
begin
  # iceberg!
rescue => e
  # lifeboats
end
```

which is equivalent to:  

```ruby
begin
  # iceberg!
rescue StandardError => e
  # lifeboats
end
```

<hr>

One of the few common cases where it’s sane to rescue from `Exception` is for logging/reporting purposes, in which case you should immediately re-raise the exception:  

```ruby
begin
  # iceberg?
rescue Exception => e
  # do some logging
  raise e  # not enough lifeboats ;)
end
```

#### Answer 2 (score 81)
The <em>real</em> rule is: Don't throw away exceptions.  The objectivity of the author of your quote is questionable, as evidenced by the fact that it ends with  

<blockquote>
  or I will stab you  
</blockquote>

Of course, be aware that signals (by default) throw exceptions, and normally long-running processes are terminated through a signal, so catching Exception and not terminating on signal exceptions will make your program very hard to stop.  So don't do this:  

```ruby
#! /usr/bin/ruby

while true do
  begin
    line = STDIN.gets
    # heavy processing
  rescue Exception => e
    puts "caught exception #{e}! ohnoes!"
  end
end
```

No, really, don't do it.  Don't even run that to see if it works.  

However, say you have a threaded server and you want all exceptions to not:  

<ol>
<li>be ignored (the default)</li>
<li>stop the server (which happens if you say `thread.abort_on_exception = true`).  </li>
</ol>

Then this is perfectly acceptable in your connection handling thread:  

```ruby
begin
  # do stuff
rescue Exception => e
  myLogger.error("uncaught #{e} exception while handling connection: #{e.message}")
    myLogger.error("Stack trace: #{backtrace.map {|l| "  #{l}\n"}.join}")
end
```

The above works out to a variation of Ruby's default exception handler, with the advantage that it doesn't also kill your program.  Rails does this in its request handler.  

Signal exceptions are raised in the main thread.  Background threads won't get them, so there is no point in trying to catch them there.  

This is particularly useful in a production environment, where you do <em>not</em> want your program to simply stop whenever something goes wrong. Then you can take the stack dumps in your logs and add to your code to deal with specific exception further down the call chain and in a more graceful manner.  

Note also that there is another Ruby idiom which has much the same effect:  

```ruby
a = do_something rescue "something else"
```

In this line, if `do_something` raises an exception, it is caught by Ruby, thrown away, and `a` is assigned `"something else"`.  

Generally, don't do that, except in special cases where you <em>know</em> you don't need to worry.  One example:  

```ruby
debugger rescue nil
```

The `debugger` function is a rather nice way to set a breakpoint in your code, but if running outside a debugger, and Rails, it raises an exception.  Now theoretically you shouldn't be leaving debug code lying around in your program (pff! nobody does that!)  but you might want to keep it there for a while for some reason, but not continually run your debugger.  

Note:  

<ol>
<li><p>If you've run someone else's program that catches signal exceptions and ignores them, (say the code above) then:</p>

<ul>
<li>in Linux, in a shell, type `pgrep ruby`, or `ps | grep ruby`, look for your offending program's PID, and then run `kill -9 &lt;PID&gt;`.   </li>
<li>in Windows, use the Task Manager (<kbd>CTRL</kbd>-<kbd>SHIFT</kbd>-<kbd>ESC</kbd>), go to the "processes" tab, find your process, right click it and select "End process".</li>
</ul></li>
<li><p>If you are working with someone else's program which is, for whatever reason, peppered with these ignore-exception blocks, then putting this at the top of the mainline is one possible cop-out:</p>

```ruby
%W/INT QUIT TERM/.each { |sig| trap sig,"SYSTEM_DEFAULT" }
```

This causes the program to respond to the normal termination signals by immediately terminating, bypassing exception handlers,  <em>with no cleanup</em>.  So it could cause data loss or similar.  Be careful!  </li>
<li><p>If you need to do this:</p>

```ruby
begin
  do_something
rescue Exception => e
  critical_cleanup
  raise
end
```

you can actually do this:  

```ruby
begin
  do_something
ensure
  critical_cleanup
end
```

In the second case, `critical cleanup` will be called every time, whether or not an exception is thrown.  </li>
</ol>

#### Answer 3 (score 63)
Let's say you are in a car (running Ruby). You recently installed a new steering wheel with the over-the-air upgrade system (which uses `eval`), but you didn't know one of the programmers messed up on syntax.  

You are on a bridge, and realize you are going a bit towards the railing, so you turn left.  

```ruby
def turn_left
  self.turn left:
end
```

oops! That's probably <em>Not Good</em>™, luckily, Ruby raises a `SyntaxError`.  

The car should stop immediately - right?  

Nope.  

```ruby
begin
  #...
  eval self.steering_wheel
  #...
rescue Exception => e
  self.beep
  self.log "Caught #{e}.", :warn
  self.log "Logged Error - Continuing Process.", :info
end
```

<blockquote>
  <strong>beep beep</strong>  
  
  Warning: Caught SyntaxError Exception.  
  
  Info: Logged Error - Continuing Process.  
</blockquote>

You notice something is wrong, and you slam on the emergency breaks (`^C`: `Interrupt`)  

<blockquote>
  <strong>beep beep</strong>  
  
  Warning: Caught Interrupt Exception.  
  
  Info: Logged Error - Continuing Process.  
</blockquote>

Yeah - that didn't help much. You're pretty close to the rail, so you put the car in park (`kill`ing: `SignalException`).  

<blockquote>
  <strong>beep beep</strong>  
  
  Warning: Caught SignalException Exception.  
  
  Info: Logged Error - Continuing Process.  
</blockquote>

At the last second, you pull out the keys (`kill -9`), and the car stops, you slam forward into the steering wheel (the airbag can't inflate because you didn't gracefully stop the program - you terminated it), and the computer in the back of your car slams into the seat in front of it. A half-full can of Coke spills over the papers. The groceries in the back are crushed, and most are covered in egg yolk and milk. The car needs serious repair and cleaning. (Data Loss)   

Hopefully you have insurance (Backups). Oh yeah - because the airbag didn't inflate, you're probably hurt (getting fired, etc).  

<hr>

But wait! There's <del>more</del> reasons why you might want to use `rescue Exception =&gt; e`!  

Let's say you're that car, and you want to make sure the airbag inflates if the car is exceeding its safe stopping momentum.  

```ruby
 begin 
    # do driving stuff
 rescue Exception => e
    self.airbags.inflate if self.exceeding_safe_stopping_momentum?
    raise
 end
```

Here's the exception to the rule: You can catch `Exception` <strong>only if you re-raise the exception</strong>. So, a better rule is to never swallow `Exception`, and always re-raise the error.  

But adding rescue is both easy to forget in a language like Ruby, and putting a rescue statement right before re-raising an issue feels a little non-DRY. And you <strong>do not</strong> want to forget the `raise` statement. And if you do, good luck trying to find that error.  

Thankfully, Ruby is awesome, you can just use the `ensure` keyword, which makes sure the code runs. The `ensure` keyword will run the code no matter what - if an exception is thrown, if one isn't, the only exception being if the world ends (or other unlikely events).  

```ruby
 begin 
    # do driving stuff
 ensure
    self.airbags.inflate if self.exceeding_safe_stopping_momentum?
 end
```

Boom! And that code should run anyways. The only reason you should use `rescue Exception =&gt; e` is if you need access to the exception, or if you only want code to run on an exception. And remember to re-raise the error. Every time.  

Note: As @Niall pointed out, ensure <strong>always</strong> runs. This is good because sometimes your program can lie to you and not throw exceptions, even when issues occur. With critical tasks, like inflating airbags, you need to make sure it happens no matter what. Because of this, checking every time the car stops, whether an exception is thrown or not, is a good idea. Even though inflating airbags is a bit of an uncommon task in most programming contexts, this is actually pretty common with most cleanup tasks.  

<hr>

<h5>TL;DR</h2>

Don't `rescue Exception =&gt; e` (and not re-raise the exception) - or you <em>might</em> drive off a bridge.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Failed to build gem native extension (installing Compass) (score [276002](https://stackoverflow.com/q/22544754) in 2014)

#### Question
When I attempt to install the latest version of compass (<a href="https://rubygems.org/gems/compass/versions/1.0.0.alpha.17">https://rubygems.org/gems/compass/versions/1.0.0.alpha.17</a>), I get the following error.  

```ruby
ERROR:  Error installing compass:
ERROR: Failed to build gem native extension.

 ERROR:  Error installing compass:
  ERROR: Failed to build gem native extension.

    /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/bin/ruby extconf.rb
checking for ffi.h... no
checking for ffi.h in /usr/local/include,/usr/include/ffi... yes
checking for ffi_call() in -lffi... yes
checking for ffi_prep_closure()... yes
checking for ffi_raw_call()... no
checking for rb_thread_blocking_region()... yes
checking for rb_thread_call_with_gvl()... yes
checking for rb_thread_call_without_gvl()... yes
checking for ffi_prep_cif_var()... no
creating extconf.h
creating Makefile

make "DESTDIR=" clean

make "DESTDIR="
compiling AbstractMemory.c
compiling ArrayType.c
compiling Buffer.c
compiling Call.c
Call.c:303:5: warning: implicit declaration of function 'rb_thread_call_without_gvl' is invalid in C99 [-Wimplicit-function-declaration]
    rbffi_thread_blocking_region(call_blocking_function, data, (void *) -1, NULL);
    ^
./Thread.h:78:39: note: expanded from macro 'rbffi_thread_blocking_region'
# define rbffi_thread_blocking_region rb_thread_call_without_gvl
                                      ^
1 warning generated.
compiling ClosurePool.c
compiling DataConverter.c
DataConverter.c:43:1: warning: control may reach end of non-void function [-Wreturn-type]
}
^
1 warning generated.
compiling DynamicLibrary.c
compiling ffi.c
compiling Function.c
Function.c:479:33: warning: incompatible pointer types passing 'VALUE (void *)' to parameter of type 'void *(*)(void *)' [-Wincompatible-pointer-types]
        rb_thread_call_with_gvl(callback_with_gvl, &cb);
                                ^~~~~~~~~~~~~~~~~
Function.c:102:46: note: passing argument to parameter 'func' here
extern void *rb_thread_call_with_gvl(void *(*func)(void *), void *data1);
                                             ^
Function.c:563:9: warning: implicit declaration of function 'rb_thread_call_without_gvl' is invalid in C99 [-Wimplicit-function-declaration]
        rb_thread_call_without_gvl(async_cb_wait, &w, async_cb_stop, &w);
        ^
Function.c:738:1: warning: control reaches end of non-void function [-Wreturn-type]
}
^
3 warnings generated.
compiling FunctionInfo.c
compiling LastError.c
compiling LongDouble.c
compiling MappedType.c
compiling MemoryPointer.c
compiling MethodHandle.c
compiling Platform.c
compiling Pointer.c
compiling Struct.c
compiling StructByReference.c
compiling StructByValue.c
compiling StructLayout.c
compiling Thread.c
compiling Type.c
compiling Types.c
compiling Variadic.c
linking shared-object ffi_c.bundle
clang: error: unknown argument: '-multiply_definedsuppress' [-Wunused-command-line-argument-hard-error-in-future]
clang: note: this will be a hard error (cannot be downgraded to a warning) in the future
make: *** [ffi_c.bundle] Error 1

make failed, exit code 2

Gem files will remain installed in /Library/Ruby/Gems/2.0.0/gems/ffi-1.9.3 for inspection.
Results logged to /Library/Ruby/Gems/2.0.0/extensions/universal-darwin-13/2.0.0/ffi-1.9.3/gem_make.out
```

What's going on here? How do I install the latest compass without error?  

#### Answer 2 (score 555)
Try this, then try to install compass again  

```ruby
apt-get install ruby-dev
```

#### Answer 3 (score 119)
In order to install compass On Mac OS X 10.10 (Yosemite)had to perform the following:  

<strong>1. Set Up Ruby Environment</strong>  

<ul>
<li>Ensure ruby is installed and up to date: `ruby -v`</li>
<li>Update gem's `sudo gem update --system`</li>
</ul>

<strong>2. Set Up MAC Environment</strong>  

Install the <strong>Xcode Command Line Tools</strong> this is the key to install Compass.   

```ruby
xcode-select --install
```

Installing the Xcode Command Line Tools are the key to getting Compass working on OS X  

<strong>3. Install Compass</strong>  

```ruby
sudo gem install compass
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How to get a specific output iterating a hash in Ruby? (score [273875](https://stackoverflow.com/q/1227571) in 2018)

#### Question
I want to get a specific output iterating a Ruby Hash.  

This is the Hash I want to iterate over:  

```ruby
hash = {
  1 => ['a', 'b'], 
  2 => ['c'], 
  3 => ['d', 'e', 'f', 'g'], 
  4 => ['h']
}
```

This is the output I would like to get:  

```ruby
1-----

a

b

2-----

c

3-----

d 

e

f

g

4-----

h
```

In Ruby, how can I get such an output with my Hash ?   

#### Answer 2 (score 313)
```ruby
hash.each do |key, array|
  puts "#{key}-----"
  puts array
end
```

Regarding order I should add, that in 1.8 the items will be iterated in random order (well, actually in an order defined by Fixnum's hashing function), while in 1.9 it will be iterated in the order of the literal.  

#### Answer 3 (score 81)
The most basic way to iterate over a hash is as follows:  

```ruby
hash.each do |key, value|
  puts key
  puts value
end
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How do I parse JSON with Ruby on Rails? (score [272587](https://stackoverflow.com/q/1826727) in 2015)

#### Question
I'm looking for a simple way to parse JSON, extract a value and write it into a database in Rails.  

Specifically what I'm looking for, is a way to extract `shortUrl` from the JSON returned from the bit.ly API:   

```ruby
{
  "errorCode": 0,
  "errorMessage": "",
  "results":
  {
    "http://www.foo.com":
    {
       "hash": "e5TEd",
       "shortKeywordUrl": "",
       "shortUrl": "http://bit.ly/1a0p8G",
       "userHash": "1a0p8G"
    }
  },
  "statusCode": "OK"
}
```

And then take that shortUrl and write it into an ActiveRecord object associated with the long URL.  

This is one of those things that I can think through entirely in concept and when I sit down to execute I realize I've got a lot to learn.   

#### Answer 2 (score 444)
These answers are a bit dated. Therefore I give you:  

```ruby
hash = JSON.parse string
```

Rails should automagically load the `json` module for you, so you <em>don't</em> need  to add `require 'json'`.  

#### Answer 3 (score 187)
Parsing JSON in Rails is quite straightforward:  

```ruby
parsed_json = ActiveSupport::JSON.decode(your_json_string)
```

Let's suppose, the object you want to associate the shortUrl with is a Site object, which has two attributes - short_url and long_url. Than, to get the shortUrl and associate it with  the appropriate Site object, you can do something like:  

```ruby
parsed_json["results"].each do |longUrl, convertedUrl|
  site = Site.find_by_long_url(longUrl)
  site.short_url = convertedUrl["shortUrl"]
  site.save
end
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: What is the difference between print and puts? (score [271853](https://stackoverflow.com/q/5018633) in 2014)

#### Question
For example in this line of code I wrote, `print` and `puts` produce different results.  

```ruby
1.upto(1000).each { |i| print i if i % 2 == 0 }
```

#### Answer accepted (score 368)
`puts` adds a new line to the end of each argument if there is not one already.   

`print` does not add a new line.  

<hr>

<strong>For example:</strong>  

`puts [[1,2,3], [4,5,nil]]` Would return:  

<pre>
1
2
3
4
5
</pre>

<p>Whereas `print [[1,2,3], [4,5,nil]]`
would return:</p>

<pre>[[1,2,3], [4,5,nil]]</pre>

<blockquote><i>Notice how puts does not output the nil value whereas print does.</i></blockquote>

#### Answer 2 (score 61)
<p>A big difference is if you are displaying arrays.
Especially ones with NIL.
For example:</p>

```ruby
print [nil, 1, 2]
```

gives  

```ruby
[nil, 1, 2]
```

but  

```ruby
puts [nil, 1, 2]
```

gives  

```ruby
1
2
```

Note, no appearing nil item (just a blank line) and each item on a different line.  

#### Answer 3 (score 41)
`print` outputs each argument, followed by `$,`, to `$stdout`, followed by `$\`. It is equivalent to `args.join($,) + $\`  

`puts` sets both `$,` and `$\` to "\n" and then does the same thing as `print`. The key difference being that <em>each argument</em> is a new line with `puts`.  

You can `require 'english'` to access those global variables with <a href="http://ruby-doc.org/stdlib-2.0/libdoc/English/rdoc/English.html" rel="noreferrer">user-friendly names</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How to add new item to hash (score [271685](https://stackoverflow.com/q/9571768) in 2018)

#### Question
I'm new to Ruby and don't know how to add new item to already existing hash. For example, first I construct hash:  

```ruby
hash = {item1: 1}
```

after that a want to add item2 so after this I have hash like this:  

```ruby
{item1: 1, item2: 2}
```

I don't know what method to do on hash, could someone help me?  

#### Answer accepted (score 277)
Create the hash:  

```ruby
hash = {:item1 => 1}
```

Add a new item to it:  

```ruby
hash[:item2] = 2
```

#### Answer 2 (score 65)
If you want to add new items from another hash - use `merge` method:  

```ruby
hash = {:item1 => 1}
another_hash = {:item2 => 2, :item3 => 3}
hash.merge(another_hash) # {:item1=>1, :item2=>2, :item3=>3}
```

In your specific case it could be:  

```ruby
hash = {:item1 => 1}
hash.merge({:item2 => 2}) # {:item1=>1, :item2=>2}
```

but it's not wise to use it when you should to add just one element more.  

Pay attention that `merge` will replace the values with the existing keys:  

```ruby
hash = {:item1 => 1}
hash.merge({:item1 => 2}) # {:item1=>2}
```

exactly like `hash[:item1] = 2`  

Also you should pay attention that `merge` method (of course) doesn't effect the original value of hash variable - it returns a new merged hash. If you want to replace the value of the hash variable then use `merge!` instead:  

```ruby
hash = {:item1 => 1}
hash.merge!({:item2 => 2})
# now hash == {:item1=>1, :item2=>2}
```

#### Answer 3 (score 27)
<strong>hash.store(key, value)</strong> - Stores a key-value pair in hash.  

<strong>Example:</strong>  

```ruby
hash   #=> {"a"=>9, "b"=>200, "c"=>4}
hash.store("d", 42) #=> 42
hash   #=> {"a"=>9, "b"=>200, "c"=>4, "d"=>42}
```

<kbd><a href="http://ruby-doc.org/core-2.3.0/Hash.html#method-i-store" rel="noreferrer">Documentation</a></kbd>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: How can I "pretty" format my JSON output in Ruby on Rails? (score [271430](https://stackoverflow.com/q/86653) in 2016)

#### Question
I would like my JSON output in Ruby on Rails to be "pretty" or nicely formatted.   

Right now, I call `to_json` and my JSON is all on one line.  At times this can be difficult to see if there is a problem in the JSON output stream.  

Is there way to configure or a method to make my JSON "pretty" or nicely formatted in Rails?  

#### Answer accepted (score 938)
Use the `pretty_generate()` function, built into later versions of JSON. For example:  

```ruby
require 'json'
my_object = { :array => [1, 2, 3, { :sample => "hash"} ], :foo => "bar" }
puts JSON.pretty_generate(my_object)
```

Which gets you:  

```ruby
{
  "array": [
    1,
    2,
    3,
    {
      "sample": "hash"
    }
  ],
  "foo": "bar"
}
```

#### Answer 2 (score 72)
Thanks to Rack Middleware and Rails 3 you can output pretty JSON for every request without changing any controller of your app. I have written such middleware snippet and I get nicely printed JSON in browser and `curl` output.  

```ruby
class PrettyJsonResponse
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    if headers["Content-Type"] =~ /^application\/json/
      obj = JSON.parse(response.body)
      pretty_str = JSON.pretty_unparse(obj)
      response = [pretty_str]
      headers["Content-Length"] = pretty_str.bytesize.to_s
    end
    [status, headers, response]
  end
end
```

<p>The above code should be placed in `app/middleware/pretty_json_response.rb` of your Rails project.
And the final step is to register the middleware in `config/environments/development.rb`:</p>

```ruby
config.middleware.use PrettyJsonResponse
```

<strong>I don't recommend to use it in `production.rb`</strong>. The JSON reparsing may degrade response time and throughput of your production app. Eventually extra logic such as 'X-Pretty-Json: true' header may be introduced to trigger formatting for manual curl requests on demand.  

(Tested with Rails 3.2.8-5.0.0, Ruby 1.9.3-2.2.0, Linux)  

#### Answer 3 (score 66)
The `&lt;pre&gt;` tag in HTML, used with `JSON.pretty_generate`, will render the JSON pretty in your view. I was so happy when my illustrious boss showed me this:  

```ruby
<% if @data.present? %>
   <pre><%= JSON.pretty_generate(@data) %></pre>
<% end %>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: How to convert a ruby hash object to JSON? (score [265343](https://stackoverflow.com/q/3183786) in 2016)

#### Question
How to convert a ruby hash object to JSON? So I am trying this example below &amp; it doesn't work?  

I was looking at the RubyDoc and obviously `Hash` object doesn't have a `to_json` method. But I am reading on blogs that Rails supports `active_record.to_json` and also supports `hash#to_json`. I can understand `ActiveRecord` is a Rails object, but `Hash` is not native to Rails, it's a pure Ruby object. So in Rails you can do a `hash.to_json`, but not in pure Ruby??  

```ruby
car = {:make => "bmw", :year => "2003"}
car.to_json
```

#### Answer accepted (score 533)
One of the numerous niceties of Ruby is the possibility to extend existing classes with your own methods. That's called "class reopening" or monkey-patching (the meaning of the latter <a href="https://stackoverflow.com/questions/394144/what-does-monkey-patching-exactly-mean-in-ruby">can vary</a>, though).  

So, take a look here:  

```ruby
car = {:make => "bmw", :year => "2003"}
# => {:make=>"bmw", :year=>"2003"}
car.to_json
# NoMethodError: undefined method `to_json' for {:make=>"bmw", :year=>"2003"}:Hash
#   from (irb):11
#   from /usr/bin/irb:12:in `<main>'
require 'json'
# => true
car.to_json
# => "{"make":"bmw","year":"2003"}"
```

As you can see, requiring `json` has magically brought method `to_json` to our `Hash`.  

#### Answer 2 (score 17)
```ruby
require 'json/ext' # to use the C based extension instead of json/pure

puts {hash: 123}.to_json
```

#### Answer 3 (score 1)
You can also use `JSON.generate`:  

```ruby
require 'json'

JSON.generate({ foo: "bar" })
=> "{\"foo\":\"bar\"}"
```

Or its alias, `JSON.unparse`:  

```ruby
require 'json'

JSON.unparse({ foo: "bar" })
=> "{\"foo\":\"bar\"}"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Could not locate Gemfile (score [262557](https://stackoverflow.com/q/3329953) in )

#### Question
I'm certainly no Ruby developer but I have an application on my server using Ruby, Gems, and Bundler. I am trying to install another Ruby on under a different user account but on the same VPS. When I go to run   

```ruby
bundle install
```

I get the following error:  

<blockquote>
  Could not locate Gemfile  
</blockquote>

I could remove the contents of the ./bundle directory so that all Gems are re-fetched to clear the error but will this have an impact on my other application using the same Gems and Bundler? I don't want to risk taking the other app down.  

#### Answer accepted (score 157)
<p>You do not have `Gemfile` in a directory where you run that command.
`Gemfile` is a file containing your `gem` settings for a <em>current</em> program.</p>

#### Answer 2 (score 77)
Make sure you are in the project directory before running `bundle install`.  For example, after running `rails new myproject`, you will want to `cd myproject` before running `bundle install`.  

#### Answer 3 (score 6)
I had the same problem and got it solved by using a different directory.  

<pre>
bash-4.2$ bundle install
Could not locate Gemfile
bash-4.2$ pwd
/home/amit/redmine/redmine-2.2.2-0/apps/redmine
bash-4.2$ cd htdocs/
bash-4.2$ ls
app  config db   extra  Gemfile   lib  plugins  Rakefile     script  tmp
bin  config.ru  doc  files  Gemfile.lock  log  public   README.rdoc  test    vendor
bash-4.2$ cd plugins/
bash-4.2$ bundle install
Using rake (0.9.2.2) 
Using i18n (0.6.0) 
Using multi_json (1.3.6) 
Using activesupport (3.2.11) 
Using builder (3.0.0) 
Using activemodel (3.2.11) 
Using erubis (2.7.0) 
Using journey (1.0.4) 
Using rack (1.4.1) 
Using rack-cache (1.2) 
Using rack-test (0.6.1) 
Using hike (1.2.1) 
Using tilt (1.3.3) 
Using sprockets (2.2.1) 
Using actionpack (3.2.11) 
Using mime-types (1.19) 
Using polyglot (0.3.3) 
Using treetop (1.4.10) 
Using mail (2.4.4) 
Using actionmailer (3.2.11) 
Using arel (3.0.2) 
Using tzinfo (0.3.33) 
Using activerecord (3.2.11) 
Using activeresource (3.2.11) 
Using coderay (1.0.6) 
Using rack-ssl (1.3.2) 
Using json (1.7.5) 
Using rdoc (3.12) 
Using thor (0.15.4) 
Using railties (3.2.11) 
Using jquery-rails (2.0.3) 
Using mysql2 (0.3.11) 
Using net-ldap (0.3.1) 
Using ruby-openid (2.1.8) 
Using rack-openid (1.3.1) 
Using bundler (1.2.3) 
Using rails (3.2.11) 
Using rmagick (2.13.1) 
Your bundle i
</pre>

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Uninstall old versions of Ruby gems (score [255332](https://stackoverflow.com/q/5902488) in 2015)

#### Question
I have several versions of a Ruby gem:  

```ruby
$ gem list
rjb (1.3.4, 1.3.3, 1.1.9)
```

How can I remove old versions but keep the most recent?  

#### Answer accepted (score 616)
```ruby
# remove all old versions of the gem
gem cleanup rjb

# choose which ones you want to remove
gem uninstall rjb

# remove version 1.1.9 only
gem uninstall rjb --version 1.1.9

# remove all versions less than 1.3.4
gem uninstall rjb --version '<1.3.4'
```

#### Answer 2 (score 248)
For removing older versions of <em>all</em> installed gems, following 2 commands are useful:  

```ruby
 gem cleanup --dryrun
```

<p>Above command will preview what gems are going to be removed.
<br><br></p>

```ruby
 gem cleanup
```

Above command will actually remove them.  

#### Answer 3 (score 12)
Try something like `gem uninstall rjb --version 1.3.4`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Pass variables to Ruby script via command line (score [250980](https://stackoverflow.com/q/4244611) in 2014)

#### Question
I've installed RubyInstaller on Windows and I'm running <a href="http://wonko.com/post/ruby_script_to_sync_email_from_any_imap_server_to_gmail" rel="noreferrer">IMAP Sync</a> but I need to use it to sync hundreds of accounts. If I could pass these variables to it via command line I could automate the whole process better.  

```ruby
# Source server connection info.
SOURCE_NAME = 'username@example.com'
SOURCE_HOST = 'mail.example.com'
SOURCE_PORT = 143
SOURCE_SSL  = false
SOURCE_USER = 'username'
SOURCE_PASS = 'password'

# Destination server connection info.
DEST_NAME = 'username@gmail.com'
DEST_HOST = 'imap.gmail.com'
DEST_PORT = 993
DEST_SSL  = true
DEST_USER = 'username@gmail.com'
DEST_PASS = 'password'
```

#### Answer accepted (score 446)
Something like this:  

```ruby
ARGV.each do|a|
  puts "Argument: #{a}"
end
```

then  

```ruby
$ ./test.rb "test1 test2"
```

or  

```ruby
v1 = ARGV[0]
v2 = ARGV[1]
puts v1       #prints test1
puts v2       #prints test2
```

#### Answer 2 (score 186)
Don't reinvent the wheel; check out Ruby's way-cool <a href="http://ruby-doc.org/stdlib/libdoc/optparse/rdoc/OptionParser.html">OptionParser</a> library.  

It offers parsing of flags/switches, parameters with optional or required values, can parse lists of parameters into a single option and can generate your help for you.  

Also, if any of your information being passed in is pretty static, that doesn't change between runs, put it into a YAML file that gets parsed. That way you can have things that change every time on the command-line, and things that change occasionally configured outside your code. That separation of data and code is nice for maintenance.  

Here are some samples to play with:  

```ruby
require 'optparse'
require 'yaml'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on('-n', '--sourcename NAME', 'Source name') { |v| options[:source_name] = v }
  opts.on('-h', '--sourcehost HOST', 'Source host') { |v| options[:source_host] = v }
  opts.on('-p', '--sourceport PORT', 'Source port') { |v| options[:source_port] = v }

end.parse!

dest_options = YAML.load_file('destination_config.yaml')
puts dest_options['dest_name']
```

This is a sample YAML file if your destinations are pretty static:  

```ruby
--- 
dest_name: username@gmail.com
dest_host: imap.gmail.com
dest_port: 993
dest_ssl: true
dest_user: username@gmail.com
dest_pass: password
```

This will let you easily generate a YAML file:  

```ruby
require 'yaml'

yaml = {
  'dest_name' => 'username@gmail.com',
  'dest_host' => 'imap.gmail.com',
  'dest_port' => 993,
  'dest_ssl'  => true,
  'dest_user' => 'username@gmail.com',
  'dest_pass' => 'password'
}

puts YAML.dump(yaml)
```

#### Answer 3 (score 26)
Unfortunately, Ruby does not support such passing mechanism as e.g. AWK:  

```ruby
> awk -v a=1 'BEGIN {print a}'
> 1
```

It means you cannot pass named values into your script directly.  

Using cmd options may help:  

```ruby
> ruby script.rb val_0 val_1 val_2

# script.rb
puts ARGV[0] # => val_0
puts ARGV[1] # => val_1
puts ARGV[2] # => val_2
```

Ruby stores all cmd arguments in the `ARGV` array, the scriptname itself can be captured using the `$PROGRAM_NAME` variable.  

The obvious disadvantage is that you depend on the order of values.  

If you need only Boolean switches use the option `-s` of the Ruby interpreter:  

```ruby
> ruby -s -e 'puts "So do I!" if $agreed' -- -agreed
> So do I!
```

Please note the `--` switch, otherwise Ruby will complain about a nonexistent option `-agreed`, so pass it as a switch to your cmd invokation. You don't need it in the following case:  

```ruby
> ruby -s script_with_switches.rb -agreed
> So do I!
```

The disadvantage is that you mess with global variables and have only logical true/false values.  

You can access values from environment variables:  

```ruby
> FIRST_NAME='Andy Warhol' ruby -e 'puts ENV["FIRST_NAME"]'
> Andy Warhol
```

Drawbacks are present here to, you have to set all the variables before the script invocation (only for your ruby process) or to export them (shells like BASH):  

```ruby
> export FIRST_NAME='Andy Warhol'
> ruby -e 'puts ENV["FIRST_NAME"]'
```

In the latter case, your data will be readable for everybody in the same shell session and for all subprocesses, which can be a serious security implication.  

And at least you can implement an option parser using <a href="http://ruby-doc.org/stdlib-1.9.3/libdoc/getoptlong/rdoc/index.html">getoptlong</a> and <a href="http://ruby-doc.org/stdlib-1.9.3/libdoc/optparse/rdoc/index.html">optparse</a>.  

Happy hacking!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: Is there a "do ... while" loop in Ruby? (score [249266](https://stackoverflow.com/q/136793) in )

#### Question
I'm using this code to let the user enter in names while the program stores them in an array until they enter an empty string (they must press enter after each name):  

```ruby
people = []
info = 'a' # must fill variable with something, otherwise loop won't execute

while not info.empty?
    info = gets.chomp
    people += [Person.new(info)] if not info.empty?
end
```

This code would look much nicer in a do ... while loop:  

```ruby
people = []

do
    info = gets.chomp
    people += [Person.new(info)] if not info.empty?
while not info.empty?
```

In this code I don't have to assign info to some random string.  

Unfortunately this type of loop doesn't seem to exist in Ruby. Can anybody suggest a better way of doing this?  

#### Answer accepted (score 629)
<strong>CAUTION</strong>:  

The `begin &lt;code&gt; end while &lt;condition&gt;` is rejected by Ruby's author Matz. Instead he suggests using `Kernel#loop`, e.g.  

```ruby
loop do 
  # some code here
  break if <condition>
end 
```

Here's <a href="http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/6745" rel="noreferrer">an email exchange</a> in 23 Nov 2005 where Matz states:  

```ruby
|> Don't use it please.  I'm regretting this feature, and I'd like to
|> remove it in the future if it's possible.
|
|I'm surprised.  What do you regret about it?

Because it's hard for users to tell

  begin <code> end while <cond>

works differently from

  <code> while <cond>
```

<a href="http://rosettacode.org/wiki/Loops/Do-while#Ruby" rel="noreferrer">RosettaCode wiki</a> has a similar story:  

<blockquote>
  During November 2005, Yukihiro Matsumoto, the creator of Ruby, regretted this loop feature and suggested using Kernel#loop.  
</blockquote>

#### Answer 2 (score 188)
<blockquote>
  I found the following snippet while reading the source for `Tempfile#initialize` in the Ruby core library:  

```ruby
begin
  tmpname = File.join(tmpdir, make_tmpname(basename, n))
  lock = tmpname + '.lock'
  n += 1
end while @@cleanlist.include?(tmpname) or
  File.exist?(lock) or File.exist?(tmpname)
```
  
  At first glance, I assumed the while modifier would be evaluated before the contents of begin...end, but that is not the case. Observe:  

```ruby
>> begin
?>   puts "do {} while ()" 
>> end while false
do {} while ()
=> nil
```
  
  As you would expect, the loop will continue to execute while the modifier is true.  

```ruby
>> n = 3
=> 3
>> begin
?>   puts n
>>   n -= 1
>> end while n > 0
3
2
1
=> nil
```
  
  While I would be happy to never see this idiom again, begin...end is quite powerful. The following is a common idiom to memoize a one-liner method with no params:  

```ruby
def expensive
  @expensive ||= 2 + 2
end
```
  
  Here is an ugly, but quick way to memoize something more complex:  

```ruby
def expensive
  @expensive ||=
    begin
      n = 99
      buf = "" 
      begin
        buf << "#{n} bottles of beer on the wall\n" 
        # ...
        n -= 1
      end while n > 0
      buf << "no more bottles of beer" 
    end
end
```
</blockquote>

<em>Originally written by <a href="https://twitter.com/jvoorhis" rel="nofollow noreferrer">Jeremy Voorhis</a>.  The content has been copied here because it seems to have been taken down from the originating site.  Copies can also be found in the <a href="http://web.archive.org/web/20080206125158/http://archive.jvoorhis.com/articles/2007/06/13/ruby-hidden-do-while-loop" rel="nofollow noreferrer">Web Archive</a> and at <a href="http://www.artima.com/forums/flat.jsp?forum=123&amp;thread=208036" rel="nofollow noreferrer">Ruby Buzz Forum</a>.  -Bill the Lizard</em>  

#### Answer 3 (score 101)
Like this:  

```ruby
people = []

begin
  info = gets.chomp
  people += [Person.new(info)] if not info.empty?
end while not info.empty?
```

Reference: <a href="http://web.archive.org/web/20080206125158/http://archive.jvoorhis.com/articles/2007/06/13/ruby-hidden-do-while-loop" rel="noreferrer">Ruby's Hidden do {} while () Loop</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Error installing mysql2: Failed to build gem native extension (score [248014](https://stackoverflow.com/q/3608287) in 2017)

#### Question
I am having some problems when trying to install `mysql2` gem for Rails. When I try to install it by running `bundle install` or `gem install mysql2` it gives me the following error:  

<blockquote>
  Error installing mysql2: ERROR: Failed to build gem native extension.  
</blockquote>

How can I fix this and successfully install `mysql2`?  

#### Answer accepted (score 898)
On Ubuntu/Debian and other distributions using aptitude:  

```ruby
sudo apt-get install libmysql-ruby libmysqlclient-dev
```

Package `libmysql-ruby` has been phased out and replaced by `ruby-mysql`. <a href="https://askubuntu.com/a/641953">This</a> is where I found the solution.  

If the above command doesn't work because `libmysql-ruby` cannot be found, the following should be sufficient:  

```ruby
sudo apt-get install libmysqlclient-dev
```

On Red Hat/CentOS and other distributions using yum:  

```ruby
sudo yum install mysql-devel
```

On Mac OS X with <a href="https://brew.sh/" rel="noreferrer">Homebrew</a>:  

```ruby
brew install mysql
```

#### Answer 2 (score 60)
I'm on a mac and use <a href="https://brew.sh/" rel="nofollow noreferrer">homebrew</a> to install open source programs. I did have to install mac Dev tools in order to install homebrew, but after that it was a simple:  

```ruby
brew install mysql
```

to install mysql. I haven't had a mysql gem problem since.  

#### Answer 3 (score 34)
<em>here is a solution for the <strong>windows users</strong>, hope it helps!</em>  

<h5>Using MySQL with Rails 3 on Windows</h2>

<ul>
<li><p><strong>Install railsinstaller</strong> -> <em>www.railsinstaller.org</em> (I installed it to c:\Rails)</p></li>
<li><p><strong>Install MySQL</strong> (I used MySQL 5.5) -> <em>dev.mysql.com/downloads/installer/</em></p></li>
</ul>

<blockquote>
  <p><strong>--- for mySQL installation ---</strong>
  <br /><br /> If you dont already have <strong>these two files</strong> installed you might need them to get your MySQL going<br /><br />
  vcredist_x86.exe -> <a href="http://www.microsoft.com/download/en/details.aspx?id=5555" rel="noreferrer">http://www.microsoft.com/download/en/details.aspx?id=5555</a>
  dotNetFx40_Full_x86_x64.exe -> <a href="http://www.microsoft.com/download/en/details.aspx?id=17718" rel="noreferrer">http://www.microsoft.com/download/en/details.aspx?id=17718</a>
  <br /><br />
  Use default install
  Developer Machine</p>
  
  <p><strong>-MySQL Server Config-</strong><br />
  port: 3306<br />
  windows service name: MySQL55<br />
  mysql root pass: root (you can change this later)<br />
  (username: root)<br />
  <strong>-MySQL Server Config-</strong></p>
  
  <strong>--- for mySQL installation ---</strong>  
</blockquote>

<br />  

<blockquote>
  <p><strong>--- Install the mysql2 Gem ---</strong><br /><br />
  Important: <strong>Do this with Git Bash Command Line</strong>(this was installed with railsinstaller) -> start/Git Bash<br /><br />
  <i><strong>gem install mysql2 -- '--with-mysql-lib="c:\Program Files\MySQL\MySQL Server 5.5\lib" --with-mysql-include="c:\Program Files\MySQL\MySQL Server 5.5\include"'</strong></i>
  <br /><br>
  Now the gem should have installed correctly
  <br /><br>
  Lastly copy the libmysql.dll file from<br />
  C:\Program Files\MySQL\MySQL Server 5.5\lib<br />
  to<br />
  C:\Rails\Ruby1.9.2\bin<br /><br />
  <strong>--- Install the mysql2 Gem ---</strong></p>
</blockquote>

<p><br />
<em>You will now be able to use your Rails app with MySQL, if you are not sure how to create a Rails 3 app with MySQL read on...</em></p>

<hr />

<p><strong>--- Get a Rails 3 app going with MySQL ---</strong><br /><br />
Open command prompt(not Git Bash) -> start/cmd<br />
Navigate to your  folder (c:\Sites)<br />
Create new rails app<br /></p>

```ruby
rails new world
```

<p>Delete the file c:\Sites\world\public\index.html<br />
Edit the file c:\Sites\world\config\routes.rb<br />
add this line -> root :to => 'cities#index'<br /><br /></p>

Open command prompt (generate views and controllers)<br />  

```ruby
rails generate scaffold city ID:integer Name:string CountryCode:string District:string Population:integer
```

<p><br /><br>
Edit the file c:\Sites\world\app\models\city.rb to look like this</p>

```ruby
class City < ActiveRecord::Base
 set_table_name "city"
end
```

Edit the file c:\Sites\world\config\database.yml to look like this  

```ruby
development:
adapter: mysql2
encoding: utf8
database: world
pool: 5
username: root
password: root
socket: /tmp/mysql.sock
```

add to gemfile  

```ruby
gem 'mysql2'
```

<p>Open <strong>command prompt</strong> windows cmd, not Git Bash(run your app!)<br />
Navigate to your app folder (c:\Sites\world)<br /></p>

```ruby
rails s
```

Open your browser here -> <em><a href="http://localhost:3000" rel="noreferrer">http://localhost:3000</a></em>  

<strong>--- Get a Rails 3 app going with MySQL ---</strong>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (score [247830](https://stackoverflow.com/q/4528101) in )

#### Question
I am using <a href="https://github.com/viatropos/authlogic-connect" rel="noreferrer">Authlogic-Connect</a> for third party logins. After running appropriate migrations, Twitter/Google/yahoo logins seem to work fine but the facebook login throws exception:  

```ruby
SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed
```

The dev log shows   

```ruby
OpenSSL::SSL::SSLError (SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed):
  app/controllers/users_controller.rb:37:in `update'
```

Please suggest..  

#### Answer 2 (score 135)
I ran into a similar problem when trying to use the JQuery generator for Rails 3  

I solved it like this:  

<ol>
<li><p><strong>Get the CURL Certificate Authority (CA) bundle.</strong> You can do this with:</p>

<ul>
<li>`sudo port install curl-ca-bundle` [if you are using MacPorts]</li>
<li>or just pull it down directly `wget http://curl.haxx.se/ca/cacert.pem`</li>
</ul></li>
<li><p>Execute the ruby code that is trying to verify  the SSL certification: `SSL_CERT_FILE=/opt/local/etc/certs/cacert.pem rails generate jquery:install`. In your case, you want to either set this as an environment variable somewhere the server picks it up or add something like `ENV['SSL_CERT_FILE'] = /path/to/your/new/cacert.pem` in your environment.rb file.</p></li>
</ol>

You can also just install the CA files (I haven't tried this) to the OS -- there are lengthy instructions <a href="http://gagravarr.org/writing/openssl-certs/others.shtml">here</a> -- this should work in a similar fashion, but I have not tried this personally.  

Basically, the issue you are hitting is that some web service is responding with a certificate signed against a CA that OpenSSL cannot verify.  

#### Answer 3 (score 134)
If you're using RVM on OS X, you probably need to run this:  

```ruby
rvm osx-ssl-certs update all
```

More information here: <a href="http://rvm.io/support/fixing-broken-ssl-certificates" rel="noreferrer">http://rvm.io/support/fixing-broken-ssl-certificates</a>  

And here is the full explanation: <a href="https://github.com/wayneeseguin/rvm/blob/master/help/osx-ssl-certs.md" rel="noreferrer">https://github.com/wayneeseguin/rvm/blob/master/help/osx-ssl-certs.md</a>  

<hr>

<h5>Update</h2>

On Ruby 2.2, you may have to reinstall Ruby from source to fix this. Here's how (replace `2.2.3` with your Ruby version):  

```ruby
rvm reinstall 2.2.3 --disable-binary
```

Credit to <a href="https://stackoverflow.com/a/32363597/4353">https://stackoverflow.com/a/32363597/4353</a> and <a href="https://stackoverflow.com/users/2063319/ian-connor">Ian Connor</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Ruby array to string conversion (score [246800](https://stackoverflow.com/q/3500814) in 2015)

#### Question
I have a ruby array like `['12','34','35','231']`.  

I want to convert it to a string like `'12','34','35','231'`.  

How can I do that?  

#### Answer accepted (score 293)
I'll join the fun with:  

```ruby
['12','34','35','231'].join(', ')
```

<strong>EDIT:</strong>  

```ruby
"'#{['12','34','35','231'].join("', '")}'"
```

Some string interpolation to add the first and last single quote :P  

#### Answer 2 (score 41)
```ruby
> a = ['12','34','35','231']
> a.map { |i| "'" + i.to_s + "'" }.join(",")
=> "'12','34','35','231'"
```

#### Answer 3 (score 29)
try this code  `['12','34','35','231']*","`  

will give you result <strong>"12,34,35,231"</strong>  

I hope this is the result you, let me know  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: How do I pick randomly from an array? (score [244689](https://stackoverflow.com/q/3482149) in 2011)

#### Question
I want to know if there is a much cleaner way of doing this. Basically, I want to pick a random element from an array of variable length.  Normally, I would do it like this:  

```ruby
myArray = ["stuff", "widget", "ruby", "goodies", "java", "emerald", "etc" ]
item = myArray[rand(myarray.length)]
```

Is there something that is more readable / simpler to replace the second line? Or is that the best way to do it. I suppose you could do `myArray.shuffle.first`, but I only saw `#shuffle` a few minutes ago on SO, I haven't actually used it yet.  

#### Answer accepted (score 1089)
Just use <a href="http://ruby-doc.org/core-1.9.3/Array.html#method-i-sample" rel="noreferrer">`Array#sample`</a>:  

```ruby
[:foo, :bar].sample # => :foo, or :bar :-)
```

It is available in Ruby 1.9.1+. To be also able to use it with an earlier version of Ruby, you could  <a href="https://github.com/marcandre/backports" rel="noreferrer">`require "backports/1.9.1/array/sample"`</a>.  

Note that in Ruby 1.8.7 it exists under the unfortunate name `choice`; it was renamed in later version so you shouldn't use that.  

Although not useful in this case, `sample` accepts a number argument in case you want a number of distinct samples.  

#### Answer 2 (score 80)
`myArray.sample(x)` can also help you to get x random elements from the array.  

#### Answer 3 (score 12)
<h5>Random Number of Random Items from an Array</h1>

```ruby
def random_items(array)
  array.sample(1 + rand(array.count))
end
```

<hr>

<h5>Examples of possible results:</h3>

```ruby
my_array = ["one", "two", "three"]
my_array.sample(1 + rand(my_array.count))

=> ["two", "three"]
=> ["one", "three", "two"]
=> ["two"]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Getting output of system() calls in Ruby (score [243524](https://stackoverflow.com/q/690151) in 2015)

#### Question
If I call a command using <a href="http://ruby-doc.org/core-2.2.0/Kernel.html#method-i-system" rel="noreferrer">Kernel#system</a> in Ruby, how do I get its output?  

```ruby
system("ls")
```

#### Answer accepted (score 339)
I'd like to expand &amp; clarify <a href="https://stackoverflow.com/a/690174/56763">chaos's answer</a> a bit.  

If you surround your command with backticks, then you don't need to (explicitly) call system() at all. The backticks execute the command and return the output as a string. You can then assign the value to a variable like so:  

```ruby
output = `ls`
p output
```

or  

```ruby
printf output # escapes newline chars
```

#### Answer 2 (score 238)
Be aware that all the solutions where you pass a string containing user provided values to `system`, `%x[]` etc. are unsafe! Unsafe actually means: the user may trigger code to run in the context and with all permissions of the program.  

As far as I can say only `system` and `Open3.popen3` do provide a secure/escaping variant in Ruby 1.8. In Ruby 1.9 `IO::popen` also accepts an array.  

Simply pass every option and argument as an array to one of these calls.  

If you need not just the exit status but also the result you probably want to use `Open3.popen3`:  

```ruby
require 'open3'
stdin, stdout, stderr, wait_thr = Open3.popen3('usermod', '-p', @options['shadow'], @options['username'])
stdout.gets(nil)
stdout.close
stderr.gets(nil)
stderr.close
exit_code = wait_thr.value
```

Note that the block form will auto-close stdin, stdout and stderr- otherwise they'd have to be <a href="http://www.ruby-doc.org/stdlib-2.0/libdoc/open3/rdoc/Open3.html#method-c-popen3" rel="noreferrer">closed explicitly</a>.  

More information here: <a href="https://stackoverflow.com/questions/4650636/forming-sanitary-shell-commands-or-system-calls-in-ruby">Forming sanitary shell commands or system calls in Ruby</a>  

#### Answer 3 (score 163)
Just for the record, if you want both (output and operation result) you can do:  

```ruby
output=`ls no_existing_file` ;  result=$?.success?
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: How to make a HTTP request using Ruby on Rails? (score [242680](https://stackoverflow.com/q/4581075) in 2017)

#### Question
I would like to take information from another website. Therefore (maybe) I should make a request to that website (in my case a HTTP GET request) and receive the response.   

How can I make this in Ruby on Rails?  

If it is possible, is it a correct approach to use in my controllers?  

#### Answer accepted (score 321)
You can use Ruby's <a href="http://ruby-doc.org/stdlib/libdoc/net/http/rdoc/index.html" rel="noreferrer"><strong>`Net::HTTP`</strong></a> class:  

```ruby
require 'net/http'

url = URI.parse('http://www.example.com/index.html')
req = Net::HTTP::Get.new(url.to_s)
res = Net::HTTP.start(url.host, url.port) {|http|
  http.request(req)
}
puts res.body
```

#### Answer 2 (score 106)
Net::HTTP is built into Ruby, but let's face it, often it's easier <em>not</em> to use its cumbersome 1980s style and try a higher level alternative:  

<ul>
<li><a href="https://github.com/httprb/http" rel="noreferrer">HTTP Gem</a></li>
<li><a href="https://github.com/jnunemaker/httparty" rel="noreferrer">HTTParty</a></li>
<li><a href="https://github.com/rest-client/rest-client" rel="noreferrer">RestClient</a></li>
<li><a href="https://github.com/excon/excon" rel="noreferrer">Excon</a></li>
<li><a href="https://github.com/feedjira/feedjira" rel="noreferrer">Feedjira </a> (RSS only)</li>
</ul>

#### Answer 3 (score 90)
OpenURI is the best; it's as simple as  

```ruby
require 'open-uri'
response = open('http://example.com').read
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: One line if statement not working (score [241210](https://stackoverflow.com/q/3827874) in 2015)

#### Question
```ruby
<%if @item.rigged %>Yes<%else%>No<%end%>
```

I was thinking of something like this?  

```ruby
if @item.rigged ? "Yes" : "No" 
```

But it doesn't work. Ruby has the `||=` but I"m not even sure how to use that thing.   

#### Answer accepted (score 385)
Remove `if` from `if @item.rigged ? "Yes" : "No"`    

Ternary operator has form `condition ? if_true : if_false`  

#### Answer 2 (score 175)
In Ruby, the condition and the `then` part of an `if` expression must be separated by either an expression separator (i.e. `;` or a newline) or the `then` keyword.  

So, all of these would work:  

```ruby
if @item.rigged then 'Yes' else 'No' end

if @item.rigged; 'Yes' else 'No' end

if @item.rigged
  'Yes' else 'No' end
```

There is also a conditional operator in Ruby, but that is completely unnecessary. The conditional operator is needed in C, because it is an operator: in C, `if` is a statement and thus cannot return a value, so if you want to return a value, you need to use something which <em>can</em> return a value. And the only things in C that can return a value are functions and operators, and since it is impossible to make `if` a function in C, you need an operator.  

In Ruby, however, `if` is an expression. In fact, <em>everything</em> is an expression in Ruby, so it <em>already</em> can return a value. There is no need for the conditional operator to even <em>exist</em>, let alone use it.  

BTW: it is customary to name methods which are used to ask a question with a question mark at the end, like this:  

```ruby
@item.rigged?
```

This shows another problem with using the conditional operator in Ruby:  

```ruby
@item.rigged? ? 'Yes' : 'No'
```

It's simply hard to read with the multiple question marks that close to each other.  

#### Answer 3 (score 62)
One line if:  

```ruby
<statement> if <condition>
```

Your case:  

```ruby
"Yes" if @item.rigged

"No" if !@item.rigged # or: "No" unless @item.rigged
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: How to make --no-ri --no-rdoc the default for gem install? (score [237851](https://stackoverflow.com/q/1381725) in 2014)

#### Question
I don't use the RI or RDoc output from the gems I install in my machine or in the servers I handle (I use other means of documentation).  

Every gem I install installs RI and RDoc documentation by default, because I forget to set `--no-ri --no-rdoc`.  

Is there a way to make those two flags the default?  

#### Answer accepted (score 1184)
You just add following line to your local `~/.gemrc` file (it is in your <em>home</em> folder)  

```ruby
gem: --no-document
```

or you can add this line to the global gemrc config file. Here is how to find it (in Linux)  

```ruby
strace gem source 2>&1 | grep gemrc
```

#### Answer 2 (score 486)
From <a href="https://rvm.io/gemsets/basics/">RVM’s documentation</a>:  

<blockquote>
  Just add this line to your `~/.gemrc` or `/etc/gemrc`:  
</blockquote>

```ruby
gem: --no-rdoc --no-ri 
```

<hr>

<strong>Note:</strong> The original answer was:  

```ruby
install: --no-rdoc --no-ri 
update: --no-rdoc --no-ri 
```

This is no longer valid; the RVM docs have since been updated, thus the current answer to only include the `gem` directive is the correct one.  

#### Answer 3 (score 179)
Note that `--no-ri` and `--no-rdoc` have been deprecated according to the new <a href="http://guides.rubygems.org/command-reference/#gem_install" rel="noreferrer">guides</a>. The recommended way is to use `--no-document` in `~/.gemrc` or `/etc/gemrc`.  

```ruby
install: --no-document
update: --no-document
```

or  

```ruby
gem: --no-document
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: How do I update Ruby Gems from behind a Proxy (ISA-NTLM) (score [237459](https://stackoverflow.com/q/4418) in 2016)

#### Question
The firewall I'm behind is running Microsoft ISA server in NTLM-only mode. Hash anyone have success getting their Ruby gems to install/update via Ruby SSPI gem or other method?  

... or am I just being lazy?  

Note: rubysspi-1.2.4 does not work.  

This also works for "igem", part of the IronRuby project  

#### Answer accepted (score 210)
I wasn't able to get mine working from the command-line switch but I have been able to do it just by setting my `HTTP_PROXY` environment variable. (Note that case seems to be important). I have a batch file that has a line like this in it:  

```ruby
SET HTTP_PROXY=http://%USER%:%PASSWORD%@%SERVER%:%PORT%
```

I set the four referenced variables before I get to this line obviously. As an example if my username is "wolfbyte", my password is "secret" and my proxy is called "pigsy" and operates on port 8080:  

```ruby
SET HTTP_PROXY=http://wolfbyte:secret@pigsy:8080
```

You might want to be careful how you manage that because it stores your password in plain text in the machine's session but I don't think it should be too much of an issue.  

#### Answer 2 (score 212)
For the Windows OS, I used Fiddler to work around the issue.  

<ol>
<li>Install/Run Fiddler from www.fiddler2.com</li>
<li><p>Run gem:</p>

```ruby
$ gem install --http-proxy http://localhost:8888 $gem_name
```</li>
</ol>

#### Answer 3 (score 128)
This totally worked:  

```ruby
gem install --http-proxy http://COMPANY.PROXY.ADDRESS $gem_name
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: How do I get the name of a Ruby class? (score [235678](https://stackoverflow.com/q/826210) in 2014)

#### Question
How can I get the class name from an ActiveRecord object?  

I have:  

```ruby
result = User.find(1)
```

I tried:  

```ruby
result.class
# => User(id: integer, name: string ...)
result.to_s
# => #<User:0x3d07cdc>"
```

I need only the class name, in a string (`User` in this case). Is there a method for that?   

I know this is pretty basic, but I searched both Rails' and Ruby's docs, and I couldn't find it.  

#### Answer accepted (score 699)
You want to call <a href="https://www.ruby-doc.org/core/classes/Module.html#M001699" rel="noreferrer">.name</a> on the object's class:  

```ruby
result.class.name
```

#### Answer 2 (score 111)
Here's the correct answer, extracted from comments by Daniel Rikowski and pseidemann.  I'm tired of having to weed through comments to find the right answer...  

If you use Rails (ActiveSupport):  

```ruby
result.class.name.demodulize
```

If you use POR (plain-ol-Ruby):  

```ruby
result.class.name.split('::').last
```

#### Answer 3 (score 34)
Both `result.class.to_s` and `result.class.name` work.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: How do you find a min / max with Ruby? (score [235414](https://stackoverflow.com/q/1359370) in 2012)

#### Question
I want to do something simple and straightforward, like `min(5,10)`, or `Math.max(4,7)`.  Are there functions to this effect in Ruby?  

#### Answer accepted (score 688)
You can do   

```ruby
[5, 10].min
```

or   

```ruby
[4, 7].max
```

They come from the <a href="http://www.ruby-doc.org/core/classes/Enumerable.html" rel="noreferrer">Enumerable module</a>, so anything that includes `Enumerable` will have those methods available.  

v2.4 introduces own `Array#min` and `Array#max`, which are way faster than Enumerable's methods because they skip calling `#each`.  

<strong>EDIT</strong>  

@nicholasklick mentions another option, <a href="http://www.ruby-doc.org/core-2.0/Enumerable.html#method-i-minmax" rel="noreferrer">`Enumerable#minmax`</a>, but this time returning an array of `[min, max]`.  

```ruby
[4, 5, 7, 10].minmax
=> [4, 10]
```

#### Answer 2 (score 51)
You can use   

```ruby
[5,10].min 
```

or    

```ruby
[4,7].max
```

It's a method for Arrays.  

#### Answer 3 (score 22)
All those results generate garbage in a zealous attempt to handle more than two arguments. I'd be curious to see how they perform compared to good 'ol:  

```ruby
def max (a,b)
  a>b ? a : b
end
```

which is by-the-way my official answer to your question. :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: gem install: Failed to build gem native extension (can't find header files) (score [228909](https://stackoverflow.com/q/4304438) in 2016)

#### Question
<p>I am using Fedora 14 and I have MySQL and MySQL server 5.1.42 installed and running.
Now I tried to do this as root user:</p>

```ruby
gem install mysql
```

But I get this error:  

```ruby
Building native extensions.  This could take a while...
ERROR:  Error installing mysql:
    ERROR: Failed to build gem native extension.

/usr/bin/ruby extconf.rb
mkmf.rb can't find header files for ruby at /usr/lib/ruby/ruby.h


Gem files will remain installed in /usr/lib/ruby/gems/1.8/gems/mysql-2.8.1 for inspection.
Results logged to /usr/lib/ruby/gems/1.8/gems/mysql-2.8.1/ext/mysql_api/gem_make.out
```

What's wrong here? In installed ruby 1.8.7. and the latest rubygems 1.3.7.  

#### Answer accepted (score 754)
For those who may be confused by the accepted answer, as I was, you also need to have the ruby headers installed [<strong>ruby-devel</strong>].  

The article that saved my hide is <a href="http://web.archive.org/web/20130313162931/http://www.fedora-tunisia.org/?q=node/44" rel="noreferrer">here</a>.  

And this is the revised solution (note that I'm on Fedora 13):  

```ruby
yum -y install gcc mysql-devel ruby-devel rubygems
gem install -y mysql -- --with-mysql-config=/usr/bin/mysql_config
```

For Debian, and other distributions using Debian style packaging the ruby development headers are installed by:  

```ruby
sudo apt-get install ruby-dev
```

For Ubuntu  the ruby development headers are installed by:  

```ruby
sudo apt-get install ruby-all-dev
```

If you are using a earlier version of ruby (such as 2.2), then you will need to run:  

```ruby
sudo apt-get install ruby2.2-dev
```

(where 2.2 is your desired Ruby version)  

#### Answer 2 (score 91)
Red Hat, Fedora:  

```ruby
yum -y install gcc mysql-devel ruby-devel rubygems
gem install -y mysql -- --with-mysql-config=/usr/bin/mysql_config
```

Debian, Ubuntu:  

```ruby
apt-get install libmysqlclient-dev ruby-dev
gem install mysql
```

Arch Linux:  

```ruby
pacman -S libmariadbclient
gem install mysql
```

#### Answer 3 (score 50)
For anyone reading this in 2015: if you happened to install the package `ruby2.0`, you need to install the matching `ruby2.0-dev` to get the appropriate Ruby headers. The same goes for `ruby2.1` and `ruby2.2`, etc. For example:  

```ruby
$ sudo apt-get install ruby2.2-dev
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: "for" vs "each" in Ruby (score [224935](https://stackoverflow.com/q/3294509) in 2014)

#### Question
I just had a quick question regarding loops in Ruby. Is there a difference between these two ways of iterating through a collection?  

```ruby
# way 1
@collection.each do |item|
  # do whatever
end

# way 2
for item in @collection
  # do whatever
end
```

Just wondering if these are exactly the same or if maybe there's a subtle difference (possibly when `@collection` is nil).  

#### Answer accepted (score 303)
This is the only difference:  

<strong>each:</strong>  

```ruby
irb> [1,2,3].each { |x| }
  => [1, 2, 3]
irb> x
NameError: undefined local variable or method `x' for main:Object
    from (irb):2
    from :0
```

<strong>for:</strong>  

```ruby
irb> for x in [1,2,3]; end
  => [1, 2, 3]
irb> x
  => 3
```

With the `for` loop, the iterator variable still lives after the block is done. With the `each` loop, it doesn't, unless it was already defined as a local variable before the loop started.  

Other than that, `for` is just syntax sugar for the `each` method.  

When `@collection` is `nil` both loops throw an exception:  

<blockquote>
  Exception: undefined local variable or method `@collection' for main:Object  
</blockquote>

#### Answer 2 (score 43)
See "<a href="http://graysoftinc.com/early-steps/the-evils-of-the-for-loop" rel="noreferrer">The Evils of the For Loop</a>" for a good explanation (there's one small difference considering variable scoping).   

Using `each` is <a href="https://github.com/bbatsov/ruby-style-guide#no-for-loops" rel="noreferrer">considered more idiomatic</a> use of Ruby.  

#### Answer 3 (score 29)
Your first example,  

```ruby
@collection.each do |item|
  # do whatever
end
```

<a href="https://github.com/bbatsov/ruby-style-guide#no-for-loops" rel="noreferrer">is more idiomatic</a>. While Ruby supports looping constructs like `for` and `while`, the block syntax is generally preferred.  

Another subtle difference is that any variable you declare within a `for` loop will be available outside the loop, whereas those within an iterator block are effectively private.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Equivalent of "continue" in Ruby (score [223168](https://stackoverflow.com/q/4010039) in 2012)

#### Question
In C and many other languages, there is a `continue` keyword that, when used inside of a loop, jumps to the next iteration of the loop. Is there any equivalent of this `continue` keyword in Ruby?  

#### Answer accepted (score 899)
Yes, it's called `next`.  

```ruby
for i in 0..5
   if i < 2
     next
   end
   puts "Value of local variable is #{i}"
end
```

This outputs the following:  

```ruby
Value of local variable is 2
Value of local variable is 3
Value of local variable is 4
Value of local variable is 5
 => 0..5 
```

#### Answer 2 (score 105)
`next`  

also, look at `redo` which redoes the <em>current</em> iteration.  

#### Answer 3 (score 80)
Writing <a href="https://stackoverflow.com/a/4010063/261542"><em>Ian Purton's</em> answer</a> in a slightly more idiomatic way:  

```ruby
(1..5).each do |x|
  next if x < 2
  puts x
end
```

Prints:  

```ruby
  2
  3
  4
  5
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: What is the difference between include and require in Ruby? (score [221607](https://stackoverflow.com/q/318144) in 2017)

#### Question
My question is similar to "<a href="https://stackoverflow.com/questions/156362/what-is-the-difference-between-include-and-extend-in-ruby">What is the difference between include and extend in Ruby?</a>".  

What's the difference between `require` and `include` in Ruby?  If I just want to use the methods from a module in my class, should I `require` it or `include` it?  

#### Answer accepted (score 538)
<blockquote>
  <p><em>What's the difference between
  "include" and "require" in Ruby?</em></p>
  
  <strong>Answer:</strong>  
  
  <p>The include and require methods do
  very different things.</p>
  
  <p>The require method does what include
  does in most other programming
  languages: run another file. It also
  tracks what you've required in the
  past and won't require the same file
  twice. To run another file without
  this added functionality, you can use
  the load method.</p>
  
  <p>The include method takes all the
  methods from another module and
  includes them into the current module.
  This is a language-level thing as
  opposed to a file-level thing as with
  require. The include method is the
  primary way to "extend" classes with
  other modules (usually referred to as
  mix-ins). For example, if your class
  defines the method "each", you can
  include the mixin module Enumerable
  and it can act as a collection. This
  can be confusing as the include verb
  is used very differently in other
  languages.</p>
</blockquote>

<a href="https://web.archive.org/web/20150405161656/http://ruby.about.com/b/2008/10/23/a-quick-peek-at-ruby-include-vs-require.htm" rel="noreferrer">Source</a>  

So if you just want to use a module, rather than extend it or do a mix-in, then you'll want to use `require`.  

Oddly enough, Ruby's `require` is analogous to C's `include`, while Ruby's `include` is almost nothing like C's `include`.  

#### Answer 2 (score 91)
From the Metaprogramming Ruby book,    

<blockquote>
  <p>The `require()` method is quite similar to `load()`, but it’s meant for
  a different purpose. You use `load()` to execute code, and you use
  `require()` to import libraries.</p>
</blockquote>

#### Answer 3 (score 90)
<p>If you're using a module, that means you're bringing all the methods into your class. 
   If you `extend` a class with a module, that means you're "bringing in" the module's methods as <strong>class</strong> methods.
   If you `include` a class with a  module, that means you're "bringing in" the module's methods as <strong>instance</strong> methods.</p>

EX:  

```ruby
 module A
   def say
     puts "this is module A"
   end
 end

 class B
   include A
 end

 class C
   extend A
 end
```

<p>`B.say`
=> undefined method 'say' for B:Class</p>

<p>`B.new.say`
=> this is module A</p>

<p>`C.say`
=> this is module A</p>

<p>`C.new.say`
=> undefined method 'say' for C:Class</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: Check for array not empty: any? (score [219644](https://stackoverflow.com/q/6245929) in 2012)

#### Question
Is it bad to check if an array is <strong>not</strong> empty by using `any?` method?  

```ruby
a = [1,2,3]

a.any?
=> true

a.clear

a.any?
=> false
```

Or is it better to use `unless a.empty?` ?  

#### Answer accepted (score 224)
`any?` isn't the same as `not empty?` in some cases.  

```ruby
>> [nil, 1].any?
=> true
>> [nil, nil].any?
=> false
```

From the documentation:  

<blockquote>
  <p>If the block is not given, Ruby adds
  an implicit block of {|obj| obj} (that
  is any? will return true if at least
  one of the collection members is not
  false or nil).</p>
</blockquote>

#### Answer 2 (score 74)
<h5>The difference between an array evaluating its values to true or if its empty.</h3>

<p>The method `empty?` comes from the Array class<br>
<a href="http://ruby-doc.org/core-2.0.0/Array.html#method-i-empty-3F">http://ruby-doc.org/core-2.0.0/Array.html#method-i-empty-3F</a></p>

Its used to check if the array contains something or not. This includes things that evaluate to false such as nil and false.   

```ruby
>> a = []
=> []
>> a.empty?
=> true
>> a = [nil, false]
=> [nil, false]
>> a.empty?
=> false
>> a = [nil]
=> [nil]
>> a.empty?
=> false
```

<hr>

<p>The method `any?` comes from the Enumerable module.<br>
<a href="http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-any-3F">http://ruby-doc.org/core-2.0.0/Enumerable.html#method-i-any-3F</a></p>

<p>Its used to evaluate if "any" values in the array evaluates to true. 
Similar methods to this are none? all? and one? where they all just check to see how many times true could be evaluated. which has nothing to do with the count of values found in a array. </p>

case 1  

```ruby
>> a = []
=> []
>> a.any?
=> false
>> a.one?
=> false
>> a.all?
=> true
>> a.none?
=> true
```

case 2  

```ruby
>> a = [nil, true]
=> [nil, true]
>> a.any?
=> true
>> a.one?
=> true
>> a.all?
=> false
>> a.none?
=> false
```

case 3  

```ruby
>> a = [true, true]
=> [true, true]
>> a.any?
=> true
>> a.one?
=> false
>> a.all?
=> true
>> a.none?
=> false
```

#### Answer 3 (score 29)
Prefixing the statement with an exclamation mark will let you know whether the array is not empty. So in your case -   

```ruby
a = [1,2,3]
!a.empty?
=> true
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Get names of all files from a folder with Ruby (score [218927](https://stackoverflow.com/q/1755665) in )

#### Question
I want to get all file names from a folder using Ruby.  

#### Answer accepted (score 495)
You also have the shortcut option of   

```ruby
Dir["/path/to/search/*"]
```

and if you want to find all Ruby files in any folder or sub-folder:   

```ruby
Dir["/path/to/search/**/*.rb"]
```

#### Answer 2 (score 159)
```ruby
Dir.entries(folder)
```

example:  

```ruby
Dir.entries(".")
```

Source: <a href="http://ruby-doc.org/core/classes/Dir.html#method-c-entries" rel="noreferrer">http://ruby-doc.org/core/classes/Dir.html#method-c-entries</a>  

#### Answer 3 (score 89)
The following snippets exactly shows the name of the files inside a directory, skipping subdirectories and `"."`, `".."` dotted folders:  

```ruby
Dir.entries("your/folder").select {|f| !File.directory? f}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: PG::ConnectionBad - could not connect to server: Connection refused (score [217377](https://stackoverflow.com/q/19828385) in 2019)

#### Question
Every time I run my rails 4.0 server, I get this output.   

```ruby
Started GET "/" for 127.0.0.1 at 2013-11-06 23:56:36 -0500

PG::ConnectionBad - could not connect to server: Connection refused
Is the server running on host "localhost" (::1) and accepting
TCP/IP connections on port 5432?
could not connect to server: Connection refused
Is the server running on host "localhost" (127.0.0.1) and accepting
TCP/IP connections on port 5432?
could not connect to server: Connection refused
Is the server running on host "localhost" (fe80::1) and accepting
TCP/IP connections on port 5432?
:
 activerecord (4.0.0) lib/active_record/connection_adapters/postgresql_adapter.rb:825:in `connect'
 activerecord (4.0.0) lib/active_record/connection_adapters/postgresql_adapter.rb:542:in `initialize'
 activerecord (4.0.0) lib/active_record/connection_adapters/postgresql_adapter.rb:41:in `postgresql_connection'
 activerecord (4.0.0) lib/active_record/connection_adapters/abstract/connection_pool.rb:440:in `new_connection'
 activerecord (4.0.0) lib/active_record/connection_adapters/abstract/connection_pool.rb:450:in `checkout_new_connection'
 activerecord (4.0.0) lib/active_record/connection_adapters/abstract/connection_pool.rb:421:in `acquire_connection'
 activerecord (4.0.0) lib/active_record/connection_adapters/abstract/connection_pool.rb:356:in `block in checkout'
 /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/monitor.rb:211:in `mon_synchronize'
 activerecord (4.0.0) lib/active_record/connection_adapters/abstract/connection_pool.rb:355:in `checkout'
 activerecord (4.0.0) lib/active_record/connection_adapters/abstract/connection_pool.rb:265:in `block in connection'
 /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/monitor.rb:211:in `mon_synchronize'
 activerecord (4.0.0) lib/active_record/connection_adapters/abstract/connection_pool.rb:264:in `connection'
 activerecord (4.0.0) lib/active_record/connection_adapters/abstract/connection_pool.rb:546:in `retrieve_connection'
 activerecord (4.0.0) lib/active_record/connection_handling.rb:79:in `retrieve_connection'
 activerecord (4.0.0) lib/active_record/connection_handling.rb:53:in `connection'
 activerecord (4.0.0) lib/active_record/migration.rb:792:in `current_version'
 activerecord (4.0.0) lib/active_record/migration.rb:800:in `needs_migration?'
 activerecord (4.0.0) lib/active_record/migration.rb:379:in `check_pending!'
 activerecord (4.0.0) lib/active_record/migration.rb:366:in `call'
 actionpack (4.0.0) lib/action_dispatch/middleware/callbacks.rb:29:in `block in call'
 activesupport (4.0.0) lib/active_support/callbacks.rb:373:in `_run__1613334440513032208__call__callbacks'
 activesupport (4.0.0) lib/active_support/callbacks.rb:80:in `run_callbacks'
 actionpack (4.0.0) lib/action_dispatch/middleware/callbacks.rb:27:in `call'
 actionpack (4.0.0) lib/action_dispatch/middleware/reloader.rb:64:in `call'
 actionpack (4.0.0) lib/action_dispatch/middleware/remote_ip.rb:76:in `call'
 better_errors (0.9.0) lib/better_errors/middleware.rb:84:in `protected_app_call'
 better_errors (0.9.0) lib/better_errors/middleware.rb:79:in `better_errors_call'
 better_errors (0.9.0) lib/better_errors/middleware.rb:56:in `call'
 actionpack (4.0.0) lib/action_dispatch/middleware/debug_exceptions.rb:17:in `call'
 actionpack (4.0.0) lib/action_dispatch/middleware/show_exceptions.rb:30:in `call'
 railties (4.0.0) lib/rails/rack/logger.rb:38:in `call_app'
 railties (4.0.0) lib/rails/rack/logger.rb:21:in `block in call'
 activesupport (4.0.0) lib/active_support/tagged_logging.rb:67:in `block in tagged'
 activesupport (4.0.0) lib/active_support/tagged_logging.rb:25:in `tagged'
 activesupport (4.0.0) lib/active_support/tagged_logging.rb:67:in `tagged'
 railties (4.0.0) lib/rails/rack/logger.rb:21:in `call'
 quiet_assets (1.0.2) lib/quiet_assets.rb:18:in `call_with_quiet_assets'
 actionpack (4.0.0) lib/action_dispatch/middleware/request_id.rb:21:in `call'
 rack (1.5.2) lib/rack/methodoverride.rb:21:in `call'
 rack (1.5.2) lib/rack/runtime.rb:17:in `call'
 activesupport (4.0.0) lib/active_support/cache/strategy/local_cache.rb:83:in `call'
 rack (1.5.2) lib/rack/lock.rb:17:in `call'
 actionpack (4.0.0) lib/action_dispatch/middleware/static.rb:64:in `call'
 railties (4.0.0) lib/rails/engine.rb:511:in `call'
 railties (4.0.0) lib/rails/application.rb:97:in `call'
 rack (1.5.2) lib/rack/content_length.rb:14:in `call'
 thin (1.5.1) lib/thin/connection.rb:81:in `block in pre_process'
 thin (1.5.1) lib/thin/connection.rb:79:in `pre_process'
 thin (1.5.1) lib/thin/connection.rb:54:in `process'
 thin (1.5.1) lib/thin/connection.rb:39:in `receive_data'
 eventmachine (1.0.3) lib/eventmachine.rb:187:in `run'
 thin (1.5.1) lib/thin/backends/base.rb:63:in `start'
 thin (1.5.1) lib/thin/server.rb:159:in `start'
 rack (1.5.2) lib/rack/handler/thin.rb:16:in `run'
 rack (1.5.2) lib/rack/server.rb:264:in `start'
 railties (4.0.0) lib/rails/commands/server.rb:84:in `start'
 railties (4.0.0) lib/rails/commands.rb:78:in `block in <top (required)>'
 railties (4.0.0) lib/rails/commands.rb:73:in `<top (required)>'
 bin/rails:4:in `<main>'
```

I'm running Mavericks OS X 10.9 so I don't know if that's the problem. I've tried everything I could but nothing seems to work. I've uninstalled and install both postgres and the pg gem multiple times now.   

This is my database.yml file  

```ruby
development:
  adapter: postgresql
  encoding: unicode
  database: metals-directory_development
  pool: 5
  username: 
  password: 
  template: template0
  host: localhost
  port: 5432

test: &test
  adapter: postgresql
  encoding: unicode
  database: metals-directory_test
  pool: 5
  username: 
  password: 
  template: template0
  host: localhost
  port: 5432

staging:
  adapter: postgresql
  encoding: unicode
  database: metals-directory_production
  pool: 5
  username:
  password:
  template: template0
  host: localhost

production:
  adapter: postgresql
  encoding: unicode
  database: metals-directory_production
  pool: 5
  username:
  password:
  template: template0
  host: localhost

cucumber:
  <<: *test
```

#### Answer accepted (score 587)
It could be as simple as a stale <strong>PID file</strong>. It could be failing silently because your computer didn't complete the shutdown process completely which means <strong>postgres</strong> didn't delete the <strong>PID</strong> (process id) file.   

The PID file is used by postgres to make sure only one instance of the server is running at a time. So when it goes to start again, it fails because there is already a <strong>PID</strong> file which tells <strong>postgres</strong> that another instance of the server was started (even though it isn't running, it just didn't get to shutdown and delete the PID).  

<ol>
<li>To fix it remove/rename the PID file. Find the postgres data directory. On macOS using homebrew it is in `/usr/local/var/postgres/`, 
or `/usr/local/var/log/` other systems it might be `/usr/var/postgres/`.</li>
<li>To make sure this is the problem, look at the log file (`server.log`). On the last lines you will see: </li>
</ol>

<blockquote>
  <p>FATAL:  lock file "postmaster.pid" already exists<br>
  HINT:  Is another postmaster (PID 347) running in data directory "/usr/local/var/postgres"?</p>
</blockquote>

<ol start="3">
<li>If so, `rm postmaster.pid`</li>
<li><p>Restart your server. On a mac using launchctl (with homebrew) the following commands will restart the server.</p>

```ruby
launchctl unload homebrew.mxcl.postgresql.plist  
launchctl load -w homebrew.mxcl.postgresql.plist
```

OR on newer versions of <strong>Brew</strong>   

```ruby
brew services restart postgresql
```</li>
</ol>

#### Answer 2 (score 41)
After a lot of searching and analysis, I found a solution if you are using ubuntu just write this command in your terminal and hit enter  

```ruby
sudo service postgresql restart
```

This will restart your PostgreSQL, hope this would behelp for you.  

#### Answer 3 (score 32)
I have managed to solve the problem by following the Chris Slade's answer, but to restart the server, I had to use the following commands:  

```ruby
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

that I found <a href="https://stackoverflow.com/questions/7990539/restarting-postgres-on-mac">here</a> (pjammer's answer down at the bottom)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: How to redirect to a 404 in Rails? (score [217141](https://stackoverflow.com/q/2385799) in 2017)

#### Question
I'd like to 'fake' a 404 page in Rails. In PHP, I would just send a header with the error code as such:  

```ruby
header("HTTP/1.0 404 Not Found");
```

How is that done with Rails?  

#### Answer accepted (score 1035)
Don't render 404 yourself, there's no reason to; Rails has this functionality built in already. If you want to show a 404 page, create a `render_404` method (or `not_found` as I called it) in `ApplicationController` like this:   

```ruby
def not_found
  raise ActionController::RoutingError.new('Not Found')
end
```

Rails also handles `AbstractController::ActionNotFound`, and `ActiveRecord::RecordNotFound` the same way.  

This does two things better:   

<p>1) It uses Rails' built in `rescue_from` handler to render the 404 page, and
2) it interrupts the execution of your code, letting you do nice things like:</p>

```ruby
  user = User.find_by_email(params[:email]) or not_found
  user.do_something!
```

without having to write ugly conditional statements.  

As a bonus, it's also super easy to handle in tests.  For example, in an rspec integration test:  

```ruby
# RSpec 1

lambda {
  visit '/something/you/want/to/404'
}.should raise_error(ActionController::RoutingError)

# RSpec 2+

expect {
  get '/something/you/want/to/404'
}.to raise_error(ActionController::RoutingError)
```

And minitest:  

```ruby
assert_raises(ActionController::RoutingError) do 
  get '/something/you/want/to/404'
end
```

OR refer more info from <a href="https://rubyinrails.com/2018/02/26/rails-render-404-not-found-from-controller-action/" rel="noreferrer">Rails render 404 not found from a controller action</a>  

#### Answer 2 (score 240)
<h5>HTTP 404 Status</h2>

To return a 404 header, just use the `:status` option for the render method.  

```ruby
def action
  # here the code

  render :status => 404
end
```

If you want to render the standard 404 page you can extract the feature in a method.  

```ruby
def render_404
  respond_to do |format|
    format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
    format.xml  { head :not_found }
    format.any  { head :not_found }
  end
end
```

and call it in your action  

```ruby
def action
  # here the code

  render_404
end
```

If you want the action to render the error page and stop, simply use a return statement.  

```ruby
def action
  render_404 and return if params[:something].blank?

  # here the code that will never be executed
end
```

<h5>ActiveRecord and HTTP 404</h2>

Also remember that Rails rescues some ActiveRecord errors, such as the `ActiveRecord::RecordNotFound` displaying the 404 error page.  

It means you don't need to rescue this action yourself  

```ruby
def show
  user = User.find(params[:id])
end
```

`User.find` raises an `ActiveRecord::RecordNotFound` when the user doesn't exist. This is a very powerful feature. Look at the following code  

```ruby
def show
  user = User.find_by_email(params[:email]) or raise("not found")
  # ...
end
```

You can simplify it by delegating to Rails the check. Simply use the bang version.  

```ruby
def show
  user = User.find_by_email!(params[:email])
  # ...
end
```

#### Answer 3 (score 59)
The newly Selected answer submitted by Steven Soroka is close, but not complete.  The test itself hides the fact that this is not returning a true 404 - it's returning a status of 200 - "success".  The original answer was closer, but attempted to render the layout as if no failure had occurred.  This fixes everything:  

```ruby
render :text => 'Not Found', :status => '404'
```

Here's a typical test set of mine for something I expect to return 404, using RSpec and Shoulda matchers:  

```ruby
describe "user view" do
  before do
    get :show, :id => 'nonsense'
  end

  it { should_not assign_to :user }

  it { should respond_with :not_found }
  it { should respond_with_content_type :html }

  it { should_not render_template :show }
  it { should_not render_with_layout }

  it { should_not set_the_flash }
end
```

This healthy paranoia allowed me to spot the content-type mismatch when everything else looked peachy :) I check for all these elements: assigned variables, response code, response content type, template rendered, layout rendered, flash messages.  

I'll skip the content type check on applications that are strictly html...sometimes. After all, "a skeptic checks ALL the drawers" :)  

<a href="http://dilbert.com/strips/comic/1998-01-20/" rel="noreferrer">http://dilbert.com/strips/comic/1998-01-20/</a>  

FYI: I don't recommend testing for things that are happening in the controller, ie "should_raise". What you care about is the output.  My tests above allowed me to try various solutions, and the tests remain the same whether the solution is raising an exception, special rendering, etc.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Remove substring from the string (score [215430](https://stackoverflow.com/q/5367164) in 2011)

#### Question
<p>I am just wondering if there is any method to remove string from another string?
Something like this:</p>

```ruby
class String
  def remove(s)
    self[s.length, self.length - s.length]
  end
end
```

#### Answer accepted (score 249)
You can use the slice method:  

```ruby
a = "foobar"
a.slice! "foo"
=> "foo"
a
=> "bar"
```

<p>there is a non '!' version as well. More info can be seen in the documentation about other versions as well:
<a href="http://www.ruby-doc.org/core/classes/String.html#M001213" rel="noreferrer">http://www.ruby-doc.org/core/classes/String.html#M001213</a></p>

#### Answer 2 (score 153)
<p>How about `str.gsub("subString", "")` 
Check out the <a href="http://www.ruby-doc.org/core/classes/String.html" rel="noreferrer">Ruby Doc</a></p>

#### Answer 3 (score 97)
If it is a the end of the string, you can also use <a href="http://ruby-doc.org/core-2.1.1/String.html#method-i-chomp" rel="noreferrer">`chomp`</a>:  

```ruby
"hello".chomp("llo")     #=> "he"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: Ruby 'require' error: cannot load such file (score [213382](https://stackoverflow.com/q/9750610) in 2014)

#### Question
I've one file, main.rb with the following content:  

```ruby
require "tokenizer.rb"
```

The tokenizer.rb file is in the <em>same directory</em> and its content is:  

```ruby
class Tokenizer
    def self.tokenize(string)
        return string.split(" ")
    end
end
```

If i try to run main.rb I get the following error:  

```ruby
C:\Documents and Settings\my\src\folder>ruby main.rb

C:/Ruby193/lib/ruby/1.9.1/rubygems/custom_require.rb:36:in `require': cannot load such file -- tokenizer.rb (LoadError)
        from C:/Ruby193/lib/ruby/1.9.1/rubygems/custom_require.rb:36:in `require '
        from main.rb:1:in `<main>'
```

I just noticed that if I use `load` instead of `require` everything works fine. What may the problem be here?  

#### Answer accepted (score 183)
I just tried and it works with `require "./tokenizer"`. Hope this helps.  

#### Answer 2 (score 176)
Just do this:  

```ruby
require_relative 'tokenizer'
```

If you put this in a Ruby file that is in the same directory as `tokenizer.rb`, it will work fine no matter what your current working directory (CWD) is.  

<h5>Explanation of why this is the best way</h2>

The other answers claim you should use `require './tokenizer'`, but that is the <em>wrong</em> answer, because it will only work if you run your Ruby process in the same directory that `tokenizer.rb` is in.  Pretty much the only reason to consider using `require` like that would be if you need to support Ruby 1.8, which doesn't have `require_relative`.  

The `require './tokenizer'` answer might work for you today, but it unnecessarily limits the ways in which you can run your Ruby code.  Tomorrow, if you want to move your files to a different directory, or just want to start your Ruby process from a different directory, you'll have to rethink all of those `require` statements.  

Using `require` to access files that are on the load path is a fine thing and Ruby gems do it all the time.  But you shouldn't start the argument to `require` with a `.` unless you are doing something very special and know what you are doing.  

When you write code that makes assumptions about its environment, you should think carefully about what assumptions to make.  In this case, there are up to three different ways to require the `tokenizer` file, and each makes a different assumption:  

<ol>
<li>`require_relative 'path/to/tokenizer'`:  Assumes that the relative path between the two Ruby source files will stay the same.</li>
<li>`require 'path/to/tokenizer'`: Assumes that `path/to/tokenizer` is inside one of the directories on the load path (`$LOAD_PATH`).  This generally requires extra setup, since you have to add something to the load path.</li>
<li>`require './path/to/tokenizer'`: Assumes that the relative path from the Ruby process's current working directory to `tokenizer.rb` is going to stay the same.</li>
</ol>

I think that for most people and most situations, the assumptions made in options #1 and #2 are more likely to hold true over time.  

#### Answer 3 (score 87)
Ruby 1.9 has removed the current directory from the load path, and so you will need to do a relative require on this file, as David Grayson says:  

```ruby
require_relative 'tokenizer'
```

There's no need to suffix it with `.rb`, as Ruby's smart enough to know that's what you mean anyway.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Map and Remove nil values in Ruby (score [211476](https://stackoverflow.com/q/13485468) in 2019)

#### Question
I have a map which either changes a value or sets it to nil. I then want to remove the nil entries from the list. The list doesn't need to be kept.  

This is what I currently have:  

```ruby
# A simple example function, which returns a value or nil
def transform(n)
  rand > 0.5 ? n * 10 : nil }
end

items.map! { |x| transform(x) } # [1, 2, 3, 4, 5] => [10, nil, 30, 40, nil]
items.reject! { |x| x.nil? } # [10, nil, 30, 40, nil] => [10, 30, 40]
```

I'm aware I could just do a loop and conditionally collect in another array like this:  

```ruby
new_items = []
items.each do |x|
    x = transform(x)
    new_items.append(x) unless x.nil?
end
items = new_items
```

But it doesn't seem that idiomatic. Is there a nice way to map a function over a list, removing/excluding the nils as you go?  

#### Answer accepted (score 858)
You could use <a href="https://ruby-doc.org/core-1.9.3/Array.html#method-i-compact" rel="noreferrer">`compact`</a>:  

```ruby
[1, nil, 3, nil, nil].compact
=> [1, 3] 
```

<hr>

I'd like to remind people that if you're getting an array containing nils as the output of a `map` block, and that block tries to conditionally return values, then you've got code smell and need to rethink your logic.   

For instance, if you're doing something that does this:  

```ruby
[1,2,3].map{ |i|
  if i % 2 == 0
    i
  end
}
# => [nil, 2, nil]
```

Then don't. Instead, prior to the `map`, `reject` the stuff you don't want or `select` what you do want:  

```ruby
[1,2,3].select{ |i| i % 2 == 0 }.map{ |i|
  i
}
# => [2]
```

I consider using `compact` to clean up a mess as a last-ditch effort to get rid of things we didn't handle correctly, usually because we didn't know what was coming at us. We should always know what sort of data is being thrown around in our program; Unexpected/unknown data is bad. Anytime I see nils in an array I'm working on, I dig into why they exist, and see if I can improve the code generating the array, rather than allow Ruby to waste time and memory generating nils then sifting through the array to remove them later.   

```ruby
'Just my $%0.2f.' % [2.to_f/100]
```

#### Answer 2 (score 89)
Try using `#reduce` or `#inject`!  

```ruby
[1, 2, 3].reduce([]) { |memo, i|
  if i % 2 == 0
    memo << i
  end

  memo
}
```

I agree with the accepted answer that we shouldn't map and compact, but not for the same reasons!  

I feel deep inside that map-then-compact is equivalent to select-then-map. Consider: a map is a one-to-one function. If you are mapping from some set of values, and you map, then you <em>want</em> one value in the output set for each value in the input set. If you are having to select before-hand, then you probably don't want a map on the set. If you are having to select afterwards (or compact) then you probably don't want a map on the set. In either case you are iterating twice over the entire set, when a reduce only needs to go once.  

Also, in English, you are trying to "reduce a set of integers into a set of even integers".  

#### Answer 3 (score 33)
In your example:  

```ruby
items.map! { |x| process_x url } # [1, 2, 3, 4, 5] => [1, nil, 3, nil, nil]
```

it does not look like the values have changed other than being replaced with `nil`. If that is the case, then:  

```ruby
items.select{|x| process_x url}
```

will suffice.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How to find a hash key containing a matching value (score [209106](https://stackoverflow.com/q/3794039) in 2013)

#### Question
Given I have the below <strong>clients</strong> hash, is there a quick ruby way (without having to write a multi-line script) to obtain the key given I want to match the client_id? E.g. How to get the key for `client_id == "2180"`?  

```ruby
clients = {
  "yellow"=>{"client_id"=>"2178"}, 
  "orange"=>{"client_id"=>"2180"}, 
  "red"=>{"client_id"=>"2179"}, 
  "blue"=>{"client_id"=>"2181"}
}
```

#### Answer accepted (score 168)
You could use <a href="http://rubydoc.info/docs/ruby-core/1.9.2/Enumerable:select" rel="noreferrer">Enumerable#select</a>:  

```ruby
clients.select{|key, hash| hash["client_id"] == "2180" }
#=> [["orange", {"client_id"=>"2180"}]]
```

Note that the result will be an array of all the matching values, where each is an array of the key and value.  

#### Answer 2 (score 394)
<strong>Ruby 1.9</strong> and greater:  

```ruby
hash.key(value) => key
```

<strong>Ruby 1.8</strong>:  

You could use <a href="http://ruby-doc.org/core/classes/Hash.html#M002855" rel="noreferrer">`hash.index`</a>  

<blockquote>
  `hsh.index(value) =&gt; key`    
  
  <p>Returns the key for a given value. If
  not found, returns `nil`.  </p>
  
  <p>`h = { "a" =&gt; 100, "b" =&gt; 200 }`<br>
  `h.index(200)   #=&gt; "b"`<br>
  `h.index(999)   #=&gt; nil`</p>
</blockquote>

So to get `"orange"`, you could just use:  

```ruby
clients.key({"client_id" => "2180"})
```

#### Answer 3 (score 47)
You can invert the hash. `clients.invert["client_id"=&gt;"2180"]` returns `"orange"`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: How do you round a float to two decimal places in jruby (score [208509](https://stackoverflow.com/q/10459901) in 2012)

#### Question
JRuby 1.6.x. How do you round a float to decimal places in jruby.   

```ruby
number = 1.1164
number.round(2)

The above shows the following error
wrong number of arguments (1 for 0)
```

How do I round this to 2 decimal places?  

#### Answer accepted (score 85)
Float#round can take a parameter in Ruby 1.9, not in Ruby 1.8. JRuby defaults to 1.8, but it is capable of <a href="https://stackoverflow.com/questions/4755900/how-to-make-jruby-1-6-default-to-ruby-1-9">running in 1.9 mode</a>.  

#### Answer 2 (score 270)
```ruby
(5.65235534).round(2)
#=> 5.65
```

#### Answer 3 (score 183)
`sprintf('%.2f', number)` is a cryptic, but very powerful way of formatting numbers.  The result is always a string, but since you're rounding I assume you're doing it for presentation purposes anyway. `sprintf` can format any number almost any way you like, and lots more.   

Full sprintf documentation: <a href="http://www.ruby-doc.org/core-2.0.0/Kernel.html#method-i-sprintf">http://www.ruby-doc.org/core-2.0.0/Kernel.html#method-i-sprintf</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: How do I parse a YAML file? (score [208179](https://stackoverflow.com/q/3877004) in 2012)

#### Question
I would like to know how to parse a YAML file with the following contents:  

```ruby
--- 
javascripts: 
- fo_global:
  - lazyload-min
  - holla-min
```

Currently I am trying to parse it this way:  

```ruby
@custom_asset_packages_yml = (File.exists?("#{RAILS_ROOT}/config/asset_packages.yml") ? YAML.load_file("#{RAILS_ROOT}/config/asset_packages.yml") : nil)
    if !@custom_asset_packages_yml.nil?
      @custom_asset_packages_yml['javascripts'].each{ |js|
        js['fo_global'].each{ |script|
         script
        }
      }
    end
```

But it doesn't seem to work and gives me an error that the value is nil.  

```ruby
You have a nil object when you didn't expect it!
You might have expected an instance of Array.
The error occurred while evaluating nil.each
```

If I try this, it puts out the entire string (fo_globallazyload-minholla-min):  

```ruby
if !@custom_asset_packages_yml.nil?
          @custom_asset_packages_yml['javascripts'].each{ |js|
            js['fo_global']
          }
        end
```

#### Answer accepted (score 436)
Maybe I'm missing something, but why try to parse the file? Why not just load the YAML and examine the object(s) that result?  

If your sample YAML is in `some.yml`, then this:  

```ruby
require 'yaml'
thing = YAML.load_file('some.yml')
puts thing.inspect
```

gives me   

```ruby
{"javascripts"=>[{"fo_global"=>["lazyload-min", "holla-min"]}]}
```

#### Answer 2 (score 11)
I had the same problem but also wanted to get the content of the file (after the YAML front-matter).  

This is the best solution I have found:  

```ruby
if (md = contents.match(/^(?<metadata>---\s*\n.*?\n?)^(---\s*$\n?)/m))
  self.contents = md.post_match
  self.metadata = YAML.load(md[:metadata])
end
```

Source and discussion: <a href="https://practicingruby.com/articles/tricks-for-working-with-text-and-files" rel="nofollow noreferrer">https://practicingruby.com/articles/tricks-for-working-with-text-and-files</a>  

#### Answer 3 (score 1)
Here is the one liner i use, from terminal, to test the content of yml file(s):  

```ruby
$ ruby  -r yaml -r pp  -e 'pp YAML.load_file("/Users/za/project/application.yml")'
{"logging"=>
  {"path"=>"/var/logs/",
   "file"=>"TacoCloud.log",
   "level"=>
    {"root"=>"WARN", "org"=>{"springframework"=>{"security"=>"DEBUG"}}}}}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: how to get the current working directory's absolute path from irb (score [207448](https://stackoverflow.com/q/1937743) in 2015)

#### Question
I'm running Ruby on Windows though I don't know if that should make a difference.  All I want to do is get the current working directory's absolute path.  Is this possible from irb?  Apparently from a script it's possible using `File.expand_path(__FILE__)`  

But from irb I tried the following and got a "Permission denied" error:  

```ruby
File.new(Dir.new(".").path).expand
```

#### Answer accepted (score 486)
`Dir.pwd` seems to do the trick.  

<a href="http://ruby-doc.org/core/Dir.html#method-c-pwd" rel="noreferrer">http://ruby-doc.org/core/Dir.html#method-c-pwd</a>  

#### Answer 2 (score 178)
`File.expand_path File.dirname(__FILE__)` will return the directory relative to the file this command is called from.  

But `Dir.pwd` returns the working directory (results identical to executing `pwd` in your terminal)  

#### Answer 3 (score 56)
As for the path relative to the current executing script, since <strong>Ruby 2.0</strong> you can also use  

```ruby
__dir__
```

So this is basically the same as  

```ruby
File.dirname(__FILE__)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: How to upgrade rubygems (score [207239](https://stackoverflow.com/q/13626143) in )

#### Question
I need to upgrade gems to 1.8 i tried installing  the respective debian packages but it seems its not getting upgraded  

```ruby
anujm@test:~$ dpkg -l |grep -i rubygem
ii  rubygems                               1.3.5-1ubuntu2                                  package management framework for Ruby libraries/applications
ii  rubygems-lwes                          0.8.2-1323277262                                LWES rubygems
ii  rubygems1.8                            1.3.5-1ubuntu2                                  package management framework for Ruby libraries/applications
ii  rubygems1.9                            1.3.5-1ubuntu2                                  package management framework for Ruby libraries/applications
anujm@test:~$ 


anujm@test:~$ gem
gem     gem1.8  gem1.9  
anujm@test:~$ sudo gem1.8 install serve
ERROR:  Error installing serve:
        multi_json requires RubyGems version >= 1.3.6
anujm@test:~$
```

#### Answer accepted (score 454)
Install rubygems-update  

```ruby
gem install rubygems-update
update_rubygems
gem update --system
```

run this commands as root or use sudo.  

#### Answer 2 (score 51)
You can update all gems by just performing:  

`sudo gem update`  

#### Answer 3 (score 16)
Or:  

```ruby
gem update `gem outdated | cut -d ' ' -f 1`
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Read binary file as string in Ruby (score [207228](https://stackoverflow.com/q/130948) in 2017)

#### Question
I need an easy way to take a tar file and convert it into a string (and vice versa). Is there a way to do this in Ruby? My best attempt was this:  

```ruby
file = File.open("path-to-file.tar.gz")
contents = ""
file.each {|line|
  contents << line
}
```

I thought that would be enough to convert it to a string, but then when I try to write it back out like this...  

```ruby
newFile = File.open("test.tar.gz", "w")
newFile.write(contents)
```

It isn't the same file. Doing `ls -l` shows the files are of different sizes, although they are pretty close (and opening the file reveals most of the contents intact). Is there a small mistake I'm making or an entirely different (but workable) way to accomplish this?  

#### Answer accepted (score 397)
First, you should open the file as a binary file. Then you can read the entire file in, in one command.  

```ruby
file = File.open("path-to-file.tar.gz", "rb")
contents = file.read
```

That will get you the entire file in a string.  

After that, you probably want to `file.close`. If you don’t do that, `file` won’t be closed until it is garbage-collected, so it would be a slight waste of system resources while it is open.  

#### Answer 2 (score 241)
If you need binary mode, you'll need to do it the hard way:  

```ruby
s = File.open(filename, 'rb') { |f| f.read }
```

If not, shorter and sweeter is:  

```ruby
s = IO.read(filename)
```

#### Answer 3 (score 113)
To avoid leaving the file open, it is best to pass a block to File.open.  This way, the file will be closed after the block executes.  

```ruby
contents = File.open('path-to-file.tar.gz', 'rb') { |f| f.read }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: How to convert a unix timestamp (seconds since epoch) to Ruby DateTime? (score [206812](https://stackoverflow.com/q/7816365) in 2015)

#### Question
How do you convert a Unix timestamp (seconds since epoch) to Ruby DateTime?  

#### Answer accepted (score 336)
`DateTime.strptime` can handle seconds since epoch. The number must be converted to a string:  

```ruby
require 'date'
DateTime.strptime("1318996912",'%s')
```

#### Answer 2 (score 607)
Sorry, brief moment of synapse failure. Here's the real answer.  

```ruby
require 'date'

Time.at(seconds_since_epoch_integer).to_datetime
```

<strong>Brief example</strong> (this takes into account the current system timezone):  

```ruby
$ date +%s
1318996912

$ irb

ruby-1.9.2-p180 :001 > require 'date'
 => true 

ruby-1.9.2-p180 :002 > Time.at(1318996912).to_datetime
 => #<DateTime: 2011-10-18T23:01:52-05:00 (13261609807/5400,-5/24,2299161)> 
```

<strong>Further update</strong> (for UTC):  

```ruby
ruby-1.9.2-p180 :003 > Time.at(1318996912).utc.to_datetime
 => #<DateTime: 2011-10-19T04:01:52+00:00 (13261609807/5400,0/1,2299161)>
```

<strong>Recent Update</strong>: I benchmarked the top solutions in this thread while working on a HA service a week or two ago, and was surprised to find that `Time.at(..)` outperforms `DateTime.strptime(..)` (update: added more benchmarks).  

```ruby
# ~ % ruby -v
#  => ruby 2.1.5p273 (2014-11-13 revision 48405) [x86_64-darwin13.0]

irb(main):038:0> Benchmark.measure do
irb(main):039:1*   ["1318996912", "1318496912"].each do |s|
irb(main):040:2*     DateTime.strptime(s, '%s')
irb(main):041:2>   end
irb(main):042:1> end

=> #<Benchmark ... @real=2.9e-05 ... @total=0.0>

irb(main):044:0> Benchmark.measure do
irb(main):045:1>   [1318996912, 1318496912].each do |i|
irb(main):046:2>     DateTime.strptime(i.to_s, '%s')
irb(main):047:2>   end
irb(main):048:1> end

=> #<Benchmark ... @real=2.0e-05 ... @total=0.0>

irb(main):050:0* Benchmark.measure do
irb(main):051:1*   ["1318996912", "1318496912"].each do |s|
irb(main):052:2*     Time.at(s.to_i).to_datetime
irb(main):053:2>   end
irb(main):054:1> end

=> #<Benchmark ... @real=1.5e-05 ... @total=0.0>

irb(main):056:0* Benchmark.measure do
irb(main):057:1*   [1318996912, 1318496912].each do |i|
irb(main):058:2*     Time.at(i).to_datetime
irb(main):059:2>   end
irb(main):060:1> end

=> #<Benchmark ... @real=2.0e-05 ... @total=0.0>
```

#### Answer 3 (score 61)
<strong>Time Zone Handling</strong>  

I just want to clarify, even though this has been commented so future people don't miss this very important distinction.  

```ruby
DateTime.strptime("1318996912",'%s') # => Wed, 19 Oct 2011 04:01:52 +0000
```

displays a return value in UTC and requires the seconds to be a String and outputs a UTC Time object, whereas  

```ruby
Time.at(1318996912) # => 2011-10-19 00:01:52 -0400
```

displays a return value in the LOCAL time zone, normally requires a FixNum argument, but the Time object itself is still in UTC even though the display is not.   

So even though I passed the same integer to both methods, I seemingly two different results because of how the class' `#to_s` method works. However, as @Eero had to remind me twice of:  

```ruby
Time.at(1318996912) == DateTime.strptime("1318996912",'%s') # => true
```

An equality comparison between the two return values still returns true. Again, this is because the values are basically the same (although different class's, the `#==` method takes care of this for you), but the `#to_s` method prints drastically different strings. Although, if we look at the strings, we can see they are indeed the same time, just printed in different time zones.  

<strong>Method Argument Clarification</strong>  

The docs also say "If a numeric argument is given, the result is in local time." which makes sense, but was a little confusing to me because they don't give any examples of non-integer arguments in the docs. So, for some non-integer argument examples:  

```ruby
Time.at("1318996912")
TypeError: can't convert String into an exact number
```

you can't use a String argument, but you can use a Time argument into `Time.at` and it will return the result in the time zone of the argument:  

```ruby
Time.at(Time.new(2007,11,1,15,25,0, "+09:00"))
=> 2007-11-01 15:25:00 +0900
```

<strong>Benchmarks</strong>  

After a discussion with @AdamEberlin on his answer, I decided to publish slightly changed benchmarks to make everything as equal as possible. Also, I never want to have to build these again so this is as good a place as any to save them.  

Time.at(int).to_datetime ~ 2.8x faster  

```ruby
09:10:58-watsw018:~$ ruby -v
ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin18]
09:11:00-watsw018:~$ irb
irb(main):001:0> require 'benchmark'
=> true
irb(main):002:0> require 'date'
=> true
irb(main):003:0>
irb(main):004:0* format = '%s'
=> "%s"
irb(main):005:0> times = ['1318996912', '1318496913']
=> ["1318996912", "1318496913"]
irb(main):006:0> int_times = times.map(&:to_i)
=> [1318996912, 1318496913]
irb(main):007:0>
irb(main):008:0* datetime_from_strptime = DateTime.strptime(times.first, format)
=> #<DateTime: 2011-10-19T04:01:52+00:00 ((2455854j,14512s,0n),+0s,2299161j)>
irb(main):009:0> datetime_from_time = Time.at(int_times.first).to_datetime
=> #<DateTime: 2011-10-19T00:01:52-04:00 ((2455854j,14512s,0n),-14400s,2299161j)>
irb(main):010:0>
irb(main):011:0* datetime_from_strptime === datetime_from_time
=> true
irb(main):012:0>
irb(main):013:0* Benchmark.measure do
irb(main):014:1*   100_000.times {
irb(main):015:2*     times.each do |i|
irb(main):016:3*       DateTime.strptime(i, format)
irb(main):017:3>     end
irb(main):018:2>   }
irb(main):019:1> end
=> #<Benchmark::Tms:0x00007fbdc18f0d28 @label="", @real=0.8680500000045868, @cstime=0.0, @cutime=0.0, @stime=0.009999999999999998, @utime=0.86, @total=0.87>
irb(main):020:0>
irb(main):021:0* Benchmark.measure do
irb(main):022:1*   100_000.times {
irb(main):023:2*     int_times.each do |i|
irb(main):024:3*       Time.at(i).to_datetime
irb(main):025:3>     end
irb(main):026:2>   }
irb(main):027:1> end
=> #<Benchmark::Tms:0x00007fbdc3108be0 @label="", @real=0.33059399999910966, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.32000000000000006, @total=0.32000000000000006>
```

****edited to not be completely and totally incorrect in every way****  

****added benchmarks****  

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Sorting an array in descending order in Ruby (score [206431](https://stackoverflow.com/q/2642182) in )

#### Question
I have an array of hashes like following  

```ruby
[
  { :foo => 'foo', :bar => 2 },
  { :foo => 'foo', :bar => 3 },
  { :foo => 'foo', :bar => 5 },
]
```

I am trying to sort above array in descending order according to the value of `:bar` in each hash.  

I am using `sort_by` like following to sort above array.  

```ruby
a.sort_by { |h| h[:bar] }
```

However above sorts the array in ascending order. How do I make it sort in descending order?  

One solution was to do following:  

```ruby
a.sort_by { |h| -h[:bar] }
```

But that negative sign does not seem appropriate. Any views?  

#### Answer accepted (score 535)
It's always enlightening to do a benchmark on the various suggested answers. Here's what I found out:  

<pre>
#!/usr/bin/ruby

require &#x27;benchmark&#x27;

ary = []
1000.times { 
  ary &lt;&lt; {:bar =&gt; rand(1000)} 
}

n = 500
Benchmark.bm(20) do |x|
  x.report(&quot;sort&quot;)               { n.times { ary.sort{ |a,b| b[:bar] &lt;=&gt; a[:bar] } } }
  x.report(&quot;sort reverse&quot;)       { n.times { ary.sort{ |a,b| a[:bar] &lt;=&gt; b[:bar] }.reverse } }
  x.report(&quot;sort_by -a[:bar]&quot;)   { n.times { ary.sort_by{ |a| -a[:bar] } } }
  x.report(&quot;sort_by a[:bar]*-1&quot;) { n.times { ary.sort_by{ |a| a[:bar]*-1 } } }
  x.report(&quot;sort_by.reverse!&quot;)   { n.times { ary.sort_by{ |a| a[:bar] }.reverse } }
end

                          user     system      total        real
sort                  3.960000   0.010000   3.970000 (  3.990886)
sort reverse          4.040000   0.000000   4.040000 (  4.038849)
sort_by -a[:bar]      0.690000   0.000000   0.690000 (  0.692080)
sort_by a[:bar]*-1    0.700000   0.000000   0.700000 (  0.699735)
sort_by.reverse!      0.650000   0.000000   0.650000 (  0.654447)
</pre>

I think it's interesting that @Pablo's `sort_by{...}.reverse!` is fastest. Before running the test I thought it would be slower than "`-a[:bar]`" but negating the value turns out to take longer than it does to reverse the entire array in one pass. It's not much of a difference, but every little speed-up helps.  

<hr>

<blockquote>
  Please note that these results are different in Ruby 1.9  
</blockquote>

Here are results for Ruby 1.9.3p194 (2012-04-20 revision 35410) [x86_64-darwin10.8.0]:  

```ruby
                           user     system      total        real
sort                   1.340000   0.010000   1.350000 (  1.346331)
sort reverse           1.300000   0.000000   1.300000 (  1.310446)
sort_by -a[:bar]       0.430000   0.000000   0.430000 (  0.429606)
sort_by a[:bar]*-1     0.420000   0.000000   0.420000 (  0.414383)
sort_by.reverse!       0.400000   0.000000   0.400000 (  0.401275)
```

These are on an old MacBook Pro. Newer, or faster machines, will have lower values, but the relative differences will remain.  

<hr>

Here's a bit updated version on newer hardware and the 2.1.1 version of Ruby:  

```ruby
#!/usr/bin/ruby

require 'benchmark'

puts "Running Ruby #{RUBY_VERSION}"

ary = []
1000.times {
  ary << {:bar => rand(1000)}
}

n = 500

puts "n=#{n}"
Benchmark.bm(20) do |x|
  x.report("sort")               { n.times { ary.dup.sort{ |a,b| b[:bar] <=> a[:bar] } } }
  x.report("sort reverse")       { n.times { ary.dup.sort{ |a,b| a[:bar] <=> b[:bar] }.reverse } }
  x.report("sort_by -a[:bar]")   { n.times { ary.dup.sort_by{ |a| -a[:bar] } } }
  x.report("sort_by a[:bar]*-1") { n.times { ary.dup.sort_by{ |a| a[:bar]*-1 } } }
  x.report("sort_by.reverse")    { n.times { ary.dup.sort_by{ |a| a[:bar] }.reverse } }
  x.report("sort_by.reverse!")   { n.times { ary.dup.sort_by{ |a| a[:bar] }.reverse! } }
end

# >> Running Ruby 2.1.1
# >> n=500
# >>                            user     system      total        real
# >> sort                   0.670000   0.000000   0.670000 (  0.667754)
# >> sort reverse           0.650000   0.000000   0.650000 (  0.655582)
# >> sort_by -a[:bar]       0.260000   0.010000   0.270000 (  0.255919)
# >> sort_by a[:bar]*-1     0.250000   0.000000   0.250000 (  0.258924)
# >> sort_by.reverse        0.250000   0.000000   0.250000 (  0.245179)
# >> sort_by.reverse!       0.240000   0.000000   0.240000 (  0.242340)
```

<hr>

New results running the above code using Ruby 2.2.1 on a more recent Macbook Pro. Again, the exact numbers aren't important, it's their relationships:  

```ruby
Running Ruby 2.2.1
n=500
                           user     system      total        real
sort                   0.650000   0.000000   0.650000 (  0.653191)
sort reverse           0.650000   0.000000   0.650000 (  0.648761)
sort_by -a[:bar]       0.240000   0.010000   0.250000 (  0.245193)
sort_by a[:bar]*-1     0.240000   0.000000   0.240000 (  0.240541)
sort_by.reverse        0.230000   0.000000   0.230000 (  0.228571)
sort_by.reverse!       0.230000   0.000000   0.230000 (  0.230040)
```

#### Answer 2 (score 86)
Just a quick thing, that denotes the intent of descending order.  

```ruby
descending = -1
a.sort_by { |h| h[:bar] * descending }
```

(Will think of a better way in the mean time) ;)  

<hr>

```ruby
a.sort_by { |h| h[:bar] }.reverse!
```

#### Answer 3 (score 52)
You could do:  

```ruby
a.sort{|a,b| b[:bar] <=> a[:bar]}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: Error while installing json gem 'mkmf.rb can't find header files for ruby' (score [200434](https://stackoverflow.com/q/20559255) in 2017)

#### Question
For context, it on a remote server which has a firewall. I'm setting up my environment through a proxy. I have `ruby 1.8.7`. When I try to gem install..  

```ruby
sudo gem install --http-proxy <host address>:<port> json
```

I get the following error:  

```ruby
Building native extensions.  This could take a while...
ERROR:  Error installing json:
        ERROR: Failed to build gem native extension.

/usr/bin/ruby extconf.rb
mkmf.rb can't find header files for ruby at /usr/lib/ruby/ruby.h

Gem files will remain installed in /usr/lib64/ruby/gems/1.8/gems/json-1.8.1 for inspection.
Results logged to /usr/lib64/ruby/gems/1.8/gems/json-1.8.1/ext/json/ext/generator/gem_make.out
```

Since I was unsure what the problem is, I googled and found these  

<ul>
<li><p><a href="https://stackoverflow.com/questions/4304438/gem-install-failed-to-build-gem-native-extension-cant-find-header-files">gem install: Failed to build gem native extension (can&#39;t find header files)</a>  - the instructions here seem to be specific to the gem being installed.</p></li>
<li><p><a href="https://stackoverflow.com/questions/15527092/how-to-install-json-gem-failed-to-build-gem-native-extension">How to install json gem - Failed to build gem native extension</a>   This seems to be slightly different error.</p></li>
</ul>

Any hints? Thanks!  

#### Answer accepted (score 706)
Modern era update, as <a href="https://stackoverflow.com/questions/20559255/error-while-installing-json-gem-mkmf-rb-cant-find-header-files-for-ruby/26225468#26225468">stated by mimoralea</a>:  

<blockquote>
  In case that you are using ruby 2.0 or 2.2 (thanks @patrick-davey).  

```ruby
sudo apt-get install ruby-dev
sudo apt-get install ruby2.0-dev
sudo apt-get install ruby2.2-dev
sudo apt-get install ruby2.3-dev
```
</blockquote>

or, generic way:  

<blockquote>
```ruby
sudo apt-get install ruby`ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]'`-dev
```
</blockquote>

<hr>

The first link you’ve posted is <em>exactly</em> your case: there is no ruby development environment installed. Development env is needed to compile ruby extensions, which are mostly written in `C`. Proxy has nothing to do with the problem: everything is downloaded fine, just compilation fails.  

I would suggest you to install `ruby-dev` (`ruby-devel` for rpm-based distros) package onto you target machine. `gcc` package might be needed as well.  

Try:  

```ruby
$ sudo apt-get install ruby-dev
```

Or, for Redhat distro:  

```ruby
$ sudo yum install ruby-devel
```

Or, for [open]SuSE:  

```ruby
$ sudo zypper install ruby-devel
```

#### Answer 2 (score 74)
In case that you are using ruby 2.0 or 2.2 (thanks @patrick-davey) or 2.3 (thanks @juanitofatas).  

```ruby
sudo apt-get install ruby-dev
sudo apt-get install ruby2.0-dev
sudo apt-get install ruby2.2-dev
sudo apt-get install ruby2.3-dev
```

And you get the pattern here...  

#### Answer 3 (score 20)
I also encountered this problem because I <a href="https://www.brightbox.com/blog/2016/01/06/ruby-2-3-ubuntu-packages/">install Ruby on Ubuntu via brightbox</a>, and I thought ruby-dev is the trunk of ruby. So I did not install. Install ruby2.3-dev fixes it:  

```ruby
sudo apt-get install ruby2.3-dev
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: What is the canonical way to trim a string in Ruby without creating a new string? (score [199484](https://stackoverflow.com/q/1000688) in 2009)

#### Question
This is what I have now - which looks too verbose for the work it is doing.  

```ruby
@title        = tokens[Title].strip! || tokens[Title] if !tokens[Title].nil?
```

<p>Assume tokens is a array obtained by splitting a CSV line.
now the functions like strip! chomp! et. all return nil if the string was not modified</p>

```ruby
"abc".strip!    # => nil
" abc ".strip!  # => "abc"
```

What is the Ruby way to say trim it if it contains extra leading or trailing spaces without creating copies?  

Gets uglier if I want to do `tokens[Title].chomp!.strip!`  

#### Answer accepted (score 260)
I guess what you want is:  

```ruby
@title = tokens[Title]
@title.strip!
```

The <a href="http://ruby-doc.org/core-2.1.5/String.html#method-i-strip" rel="noreferrer">`#strip!`</a> method will return `nil` if it didn't strip anything, and the variable itself if it was stripped.  

According to Ruby standards, a method suffixed with an exclamation mark changes the variable in place.  

Hope this helps.  

<strong>Update:</strong> This is output from `irb` to demonstrate:  

```ruby
>> @title = "abc"
=> "abc"
>> @title.strip!
=> nil
>> @title
=> "abc"
>> @title = " abc "
=> " abc "
>> @title.strip!
=> "abc"
>> @title
=> "abc"
```

#### Answer 2 (score 50)
Btw, now ruby already supports just strip without "!".  

Compare:  

```ruby
p "abc".strip! == " abc ".strip!  # false, because "abc".strip! will return nil
p "abc".strip == " abc ".strip    # true
```

<p>Also it's impossible to `strip` without duplicates. See sources in string.c:


```ruby
static VALUE
rb_str_strip(VALUE str)
{
    str = rb_str_dup(str);
    rb_str_strip_bang(str);
    return str;
}
```

<em>ruby 1.9.3p0 (2011-10-30) [i386-mingw32]</em>  

<p>Update 1:
As I see now -- it was created in 1999 year (see <a href="http://svn.ruby-lang.org/cgi-bin/viewvc.cgi/trunk/string.c?r1=11&amp;r2=372&amp;diff_format=h">rev #372</a> in SVN): </p>

<p>Update2:
`strip!` will not create duplicates — both in 1.9.x, 2.x and trunk versions.</p>

#### Answer 3 (score 8)
There's no need to both strip and chomp as strip will also remove trailing carriage returns - unless you've changed the default record separator and that's what you're chomping.  

Olly's answer already has the canonical way of doing this in Ruby, though if you find yourself doing this a lot you could always define a method for it:  

```ruby
def strip_or_self!(str)
  str.strip! || str
end
```

Giving:  

```ruby
@title = strip_or_self!(tokens[Title]) if tokens[Title]
```

Also keep in mind that the if statement will prevent `@title` from being assigned if the token is nil, which will result in it keeping its previous value. If you want or don't mind `@title` always being assigned you can move the check into the method and further reduce duplication:  

```ruby
def strip_or_self!(str)
  str.strip! || str if str
end
```

As an alternative, if you're feeling adventurous you can define a method on String itself:  

```ruby
class String
  def strip_or_self!
    strip! || self
  end
end
```

Giving one of:  

```ruby
@title = tokens[Title].strip_or_self! if tokens[Title]

@title = tokens[Title] && tokens[Title].strip_or_self!
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How to find where gem files are installed (score [198624](https://stackoverflow.com/q/19072070) in 2019)

#### Question
I can finds gems that are installed using `gem list`, but it doesn't show me where the gems are installed.  

How can I find where the gems are, and how can I know before installing a gem where it will be installed?  

#### Answer accepted (score 329)
Use <a href="http://guides.rubygems.org/command-reference/#gem_environment">`gem environment`</a> to find out about your gem environment:  

```ruby
RubyGems Environment:
  - RUBYGEMS VERSION: 2.1.5
  - RUBY VERSION: 2.0.0 (2013-06-27 patchlevel 247) [x86_64-darwin12.4.0]
  - INSTALLATION DIRECTORY: /Users/ttm/.rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0
  - RUBY EXECUTABLE: /Users/ttm/.rbenv/versions/2.0.0-p247/bin/ruby
  - EXECUTABLE DIRECTORY: /Users/ttm/.rbenv/versions/2.0.0-p247/bin
  - SPEC CACHE DIRECTORY: /Users/ttm/.gem/specs
  - RUBYGEMS PLATFORMS:
    - ruby
    - x86_64-darwin-12
  - GEM PATHS:
     - /Users/ttm/.rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0
     - /Users/ttm/.gem/ruby/2.0.0
  - GEM CONFIGURATION:
     - :update_sources => true
     - :verbose => true
     - :backtrace => false
     - :bulk_threshold => 1000
  - REMOTE SOURCES:
     - https://rubygems.org/
  - SHELL PATH:
     - /Users/ttm/.rbenv/versions/2.0.0-p247/bin
     - /Users/ttm/.rbenv/libexec
     - /Users/ttm/.rbenv/plugins/ruby-build/bin
     - /Users/ttm/perl5/perlbrew/bin
     - /Users/ttm/perl5/perlbrew/perls/perl-5.18.1/bin
     - /Users/ttm/.pyenv/shims
     - /Users/ttm/.pyenv/bin
     - /Users/ttm/.rbenv/shims
     - /Users/ttm/.rbenv/bin
     - /Users/ttm/bin
     - /usr/local/mysql-5.6.12-osx10.7-x86_64/bin
     - /Users/ttm/libsmi/bin
     - /usr/local/bin
     - /usr/bin
     - /bin
     - /usr/sbin
     - /sbin
     - /usr/local/bin
```

Notice the two sections for:  

<ul>
<li>`INSTALLATION DIRECTORY`</li>
<li>`GEM PATHS`</li>
</ul>

#### Answer 2 (score 132)
I found it useful to get a location of the library file with:  

```ruby
gem which *gemname*
```

#### Answer 3 (score 66)
After installing the gems, if you want to know where a particular gem is. Try typing:  

```ruby
 gem list
```

You will be able to see the list of gems you have installed. Now use `bundle show` and name the gem you  want to know the path for, like this:   

```ruby
 bundle show <gemName>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Ruby - test for array (score [197783](https://stackoverflow.com/q/1527888) in )

#### Question
What is the right way to:  

```ruby
is_array("something") # => false         (or 1)

is_array(["something", "else"]) # => true  (or > 1)
```

or to get the count of items in it?  

#### Answer accepted (score 499)
You probably want to use `kind_of?()`.  

```ruby
>> s = "something"
=> "something"
>> s.kind_of?(Array)
=> false
>> s = ["something", "else"]
=> ["something", "else"]
>> s.kind_of?(Array)
=> true
```

#### Answer 2 (score 144)
Are you sure it <strong>needs</strong> to be an array? You may be able to use `respond_to?(method)` so your code would work for similar things that aren't necessarily arrays (maybe some other enumberable thing). If you do actually need an `array`, then the post describing the `Array#kind\_of?` method is best.  

```ruby
['hello'].respond_to?('each')
```

#### Answer 3 (score 56)
Instead of testing for an `Array,` just convert whatever you get into a one-level `Array,` so your code only needs to handle the one case.  

```ruby
t = [*something]     # or...
t = Array(something) # or...
def f *x
    ...
end
```

Ruby has various ways to harmonize an API which can take an object or an Array of objects, so, taking a guess at why you want to know if something <em>is</em> an Array, I have a suggestion.  

The <em>splat</em> operator contains lots of magic <a href="http://blog.honeybadger.io/ruby-splat-array-manipulation-destructuring/" rel="noreferrer">you can look up,</a> or you can just call `Array(something)` which will add an Array wrapper if needed. It's similar to `[*something]` in this one case.  

```ruby
def f x
  p Array(x).inspect
  p [*x].inspect
end
f 1         # => "[1]"
f [1]       # => "[1]"
f [1,2]     # => "[1, 2]"
```

Or, you could use the <em>splat</em> in the parameter declaration and then `.flatten`, giving you a different sort of collector. (For that matter, you could call `.flatten` above, too.)  

```ruby
def f *x
  p x.flatten.inspect
end         # => nil
f 1         # => "[1]"
f 1,2       # => "[1, 2]"
f [1]       # => "[1]"
f [1,2]     # => "[1, 2]"
f [1,2],3,4 # => "[1, 2, 3, 4]"
```

And, thanks <a href="https://stackoverflow.com/users/365596/gregschlom">gregschlom</a>, it's sometimes faster to just use `Array(x)` because when it's already an `Array` it doesn't need to create a new object.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Remove duplicate elements from array in Ruby (score [197438](https://stackoverflow.com/q/8365721) in 2017)

#### Question
I have a Ruby array which contains duplicate elements.  

```ruby
array = [1,2,2,1,4,4,5,6,7,8,5,6]
```

How can I remove all the duplicate elements from this array while retaining all unique elements without using for-loops and iteration?  

#### Answer accepted (score 681)
```ruby
array = array.uniq
```

The <a href="http://www.ruby-doc.org/core-1.9.3/Array.html#method-i-uniq" rel="noreferrer">uniq method</a> removes all duplicate elements and retains all unique elements in the array.  

One of many beauties of Ruby language.  

#### Answer 2 (score 80)
You can also return the intersection.  

```ruby
a = [1,1,2,3]
a & a
```

This will also delete duplicates.  

#### Answer 3 (score 42)
You can remove the duplicate elements with the uniq method:  

```ruby
array.uniq  # => [1, 2, 4, 5, 6, 7, 8]
```

What might also be useful to know is that the uniq method takes a block, so e.g if you a have an array of keys like this:  

```ruby
["bucket1:file1", "bucket2:file1", "bucket3:file2", "bucket4:file2"]
```

and you want to know what are the unique files, you can find it out with:  

```ruby
a.uniq { |f| f[/\d+$/] }.map { |p| p.split(':').last }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: What's the difference between equal?, eql?, ===, and ==? (score [196839](https://stackoverflow.com/q/7156955) in 2014)

#### Question
I am trying to understand the difference between these four methods. I know by default that `==` calls the method `equal?` which returns true when both operands refer to exactly the same object.  

<p>`===` by default also calls `==` which calls `equal?`... okay, so if all these three methods are not overridden, then I guess
`===`, `==` and `equal?` do exactly the same thing?</p>

Now comes `eql?`. What does this do (by default)? Does it make a call to the operand's hash/id?   

Why does Ruby have so many equality signs? Are they supposed to differ in semantics?  

#### Answer accepted (score 765)
I'm going to heavily quote <a href="http://ruby-doc.org/core/Object.html#method-i-eql-3F" rel="noreferrer">the Object documentation</a> here, because I think it has some great explanations. I encourage you to read it, and also the documentation for these methods as they're overridden in other classes, like <a href="http://ruby-doc.org/core/classes/String.html" rel="noreferrer">String</a>.  

<em>Side note: if you want to try these out for yourself on different objects, use something like this:</em>  

```ruby
class Object
  def all_equals(o)
    ops = [:==, :===, :eql?, :equal?]
    Hash[ops.map(&:to_s).zip(ops.map {|s| send(s, o) })]
  end
end

"a".all_equals "a" # => {"=="=>true, "==="=>true, "eql?"=>true, "equal?"=>false}
```

<hr>

<h5>`==` — generic "equality"</h2>

<blockquote>
  At the Object level, `==` returns true only if `obj` and `other` are the same object. Typically, this method is overridden in descendant classes to provide class-specific meaning.  
</blockquote>

This is the most common comparison, and thus the most fundamental place where you (as the author of a class) get to decide if two objects are "equal" or not.  

<h5>`===` — case equality</h2>

<blockquote>
  For class Object, effectively the same as calling `#==`, but typically overridden by descendants to provide meaningful semantics in case statements.  
</blockquote>

This is incredibly useful. Examples of things which have interesting `===` implementations:  

<ul>
<li>Range</li>
<li>Regex</li>
<li>Proc (in Ruby 1.9)</li>
</ul>

So you can do things like:  

```ruby
case some_object
when /a regex/
  # The regex matches
when 2..4
  # some_object is in the range 2..4
when lambda {|x| some_crazy_custom_predicate }
  # the lambda returned true
end
```

See <a href="https://stackoverflow.com/questions/1735717/help-refactoring-this-nasty-ruby-if-else-statement/1735777#1735777">my answer here</a> for a neat example of how `case`+`Regex` can make code a lot cleaner. And of course, by providing your own `===` implementation, you can get custom `case` semantics.  

<h5>`eql?` — `Hash` equality</h2>

<blockquote>
  The `eql?` method returns true if `obj` and `other` refer to the same hash key. This is used by `Hash` to test members for equality. <strong>For objects of class `Object`, `eql?` is synonymous with `==`.</strong> Subclasses normally continue this tradition by aliasing `eql?` to their overridden `==` method, but there are exceptions. `Numeric` types, for example, perform type conversion across `==`, but not across `eql?`, so:  

```ruby
1 == 1.0     #=> true
1.eql? 1.0   #=> false
```
</blockquote>

So you're free to override this for your own uses, or you can override `==` and use `alias :eql? :==` so the two methods behave the same way.  

<h5>`equal?` — identity comparison</h2>

<blockquote>
  Unlike `==`, the `equal?` method should never be overridden by subclasses: it is used to determine object identity (that is, `a.equal?(b)` iff `a` is the same object as `b`).  
</blockquote>

This is effectively pointer comparison.  

#### Answer 2 (score 46)
I love jtbandes answer, but since it is pretty long, I will add my own compact answer:  

<p><strong>`==`, `===`, `eql?`, `equal?`</strong><br>
are 4 comparators, ie. 4 ways to compare 2 objects, in Ruby.<br>
As, in Ruby, all comparators (and most operators) are actually method-calls, you can change, overwrite, and define the semantics of these comparing methods yourself. However, it is important to understand, when Ruby's internal language constructs use which comparator:</p>

<p><strong>`==` (value comparison)</strong><br>
Ruby uses :== everywhere to compare the <strong>values</strong> of 2 objects, eg. Hash-values:</p>

```ruby
{a: 'z'}  ==  {a: 'Z'}    # => false
{a: 1}    ==  {a: 1.0}    # => true
```

<p><strong>`===` (case comparison)</strong><br>
Ruby uses :=== in case/when constructs. The following code snippets are logically identical:</p>

```ruby
case foo
  when bar;  p 'do something'
end

if bar === foo
  p 'do something'
end
```

<p><strong>`eql?` (Hash-key comparison)</strong><br>
Ruby uses :eql? (in combination with the method hash) to compare Hash-keys. In most classes :eql? is identical with :==.<br>
Knowledge about :eql? is only important, when you want to create your own special classes:</p>

```ruby
class Equ
  attr_accessor :val
  alias_method  :initialize, :val=
  def hash()           self.val % 2             end
  def eql?(other)      self.hash == other.hash  end
end

h = {Equ.new(3) => 3,  Equ.new(8) => 8,  Equ.new(15) => 15}    #3 entries, but 2 are :eql?
h.size            # => 2
h[Equ.new(27)]    # => 15
```

Note: The commonly used Ruby-class Set also relies on Hash-key-comparison.  

<p><strong>`equal?` (object identity comparison)</strong><br>
Ruby uses :equal? to check if two objects are identical. This method (of class BasicObject) is not supposed to be overwritten.</p>

```ruby
obj = obj2 = 'a'
obj.equal? obj2       # => true
obj.equal? obj.dup    # => false
```

#### Answer 3 (score 31)
<h5>Equality operators: == and !=</h2>

The == operator, also known as equality or double equal, will return true if both objects are equal and false if they are not.  

```ruby
"koan" == "koan" # Output: => true
```

The != operator, also known as inequality, is the opposite of ==. It will return true if both objects are not equal and false if they are equal.  

```ruby
"koan" != "discursive thought" # Output: => true
```

Note that two arrays with the same elements in a different order are not equal, uppercase and lowercase versions of the same letter are not equal and so on.   

When comparing numbers of different types (e.g., integer and float), if their numeric value is the same, == will return true.  

```ruby
2 == 2.0 # Output: => true
```

<h5>equal?</h2>

Unlike the == operator which tests if both operands are equal, the equal method checks if the two operands refer to the same object. This is the strictest form of equality in Ruby.  

<p>Example:
    a = "zen"
    b = "zen"</p>

```ruby
a.object_id  # Output: => 20139460
b.object_id  # Output :=> 19972120

a.equal? b  # Output: => false
```

In the example above, we have two strings with the same value. However, they are two distinct objects, with different object IDs. Hence, the equal? method will return false.  

Let's try again, only this time b will be a reference to a. Notice that the object ID is the same for both variables, as they point to the same object.  

```ruby
a = "zen"
b = a

a.object_id  # Output: => 18637360
b.object_id  # Output: => 18637360

a.equal? b  # Output: => true
```

<h5>eql?</h2>

In the Hash class, the eql? method it is used to test keys for equality. Some background is required to explain this. In the general context of computing, a hash function takes a string (or a file) of any size and generates a string or integer of fixed size called hashcode, commonly referred to as only hash. Some commonly used hashcode types are MD5, SHA-1, and CRC. They are used in encryption algorithms, database indexing, file integrity checking, etc. Some programming languages, such as Ruby, provide a collection type called hash table. Hash tables are dictionary-like collections which store data in pairs, consisting of unique keys and their corresponding values. Under the hood, those keys are stored as hashcodes. Hash tables are commonly referred to as just hashes. Notice how the word hashcan refer to a hashcode or to a hash table. In the context of Ruby programming, the word hash almost always refers to the dictionary-like collection.  

Ruby provides a built-in method called hash for generating hashcodes. In the example below, it takes a string and returns a hashcode. Notice how strings with the same value always have the same hashcode, even though they are distinct objects (with different object IDs).  

```ruby
"meditation".hash  # Output: => 1396080688894079547
"meditation".hash  # Output: => 1396080688894079547
"meditation".hash  # Output: => 1396080688894079547
```

The hash method is implemented in the Kernel module, included in the Object class, which is the default root of all Ruby objects. Some classes such as Symbol and Integer use the default implementation, others like String and Hash provide their own implementations.   

```ruby
Symbol.instance_method(:hash).owner  # Output: => Kernel
Integer.instance_method(:hash).owner # Output: => Kernel

String.instance_method(:hash).owner  # Output: => String
Hash.instance_method(:hash).owner  # Output: => Hash
```

In Ruby, when we store something in a hash (collection), the object provided as a key (e.g., string or symbol) is converted into and stored as a hashcode. Later, when retrieving an element from the hash (collection), we provide an object as a key, which is converted into a hashcode and compared to the existing keys. If there is a match, the value of the corresponding item is returned. The comparison is made using the eql? method under the hood.   

```ruby
"zen".eql? "zen"    # Output: => true
# is the same as
"zen".hash == "zen".hash # Output: => true
```

In most cases, the eql? method behaves similarly to the == method. However, there are a few exceptions. For instance, eql? does not perform implicit type conversion when comparing an integer to a float.  

```ruby
2 == 2.0    # Output: => true
2.eql? 2.0    # Output: => false
2.hash == 2.0.hash  # Output: => false
```

<h5>Case equality operator: ===</h2>

<h5> </h2>

Many of Ruby's built-in classes, such as String, Range, and Regexp, provide their own implementations of the === operator, also known as case-equality, triple equals or threequals. Because it's implemented differently in each class, it will behave differently depending on the type of object it was called on. Generally, it returns true if the object on the right "belongs to" or "is a member of" the object on the left. For instance, it can be used to test if an object is an instance of a class (or one of its subclasses).  

```ruby
String === "zen"  # Output: => true
Range === (1..2)   # Output: => true
Array === [1,2,3]   # Output: => true
Integer === 2   # Output: => true
```

The same result can be achieved with other methods which are probably best suited for the job. It's usually better to write code that is easy to read by being as explicit as possible, without sacrificing efficiency and conciseness.   

```ruby
2.is_a? Integer   # Output: => true
2.kind_of? Integer  # Output: => true
2.instance_of? Integer # Output: => false
```

Notice the last example returned false because integers such as 2 are instances of the Fixnum class, which is a subclass of the Integer class. The ===, is_a? and instance_of? methods return true if the object is an instance of the given class or any subclasses. The instance_of method is stricter and only returns true if the object is an instance of that exact class, not a subclass.   

The is_a? and kind_of? methods are implemented in the Kernel module, which is mixed in by the Object class. Both are aliases to the same method. Let's verify:  

Kernel.instance_method(:kind_of?) == Kernel.instance_method(:is_a?) # Output: => true  

<h5>Range Implementation of ===</h3>

When the === operator is called on a range object, it returns true if the value on the right falls within the range on the left.  

```ruby
(1..4) === 3  # Output: => true
(1..4) === 2.345 # Output: => true
(1..4) === 6  # Output: => false

("a".."d") === "c" # Output: => true
("a".."d") === "e" # Output: => false
```

Remember that the === operator invokes the === method of the left-hand object. So (1..4) === 3 is equivalent to (1..4).=== 3. In other words, the class of the left-hand operand will define which implementation of the === method will be called, so the operand positions are not interchangeable.   

<h5>Regexp Implementation of ===</h3>

<p>Returns true if the string on the right matches the regular expression on the left.
    /zen/ === "practice zazen today"  # Output: => true
    # is the same as
    "practice zazen today"=~ /zen/</p>

<h5>Implicit usage of the === operator on case/when statements</h3>

This operator is also used under the hood on case/when statements. That is its most common use.  

```ruby
minutes = 15

case minutes
  when 10..20
    puts "match"
  else
    puts "no match"
end

# Output: match
```

In the example above, if Ruby had implicitly used the double equal operator (==), the range 10..20 would not be considered equal to an integer such as 15. They match because the triple equal operator (===) is implicitly used in all case/when statements. The code in the example above is equivalent to:  

```ruby
if (10..20) === minutes
  puts "match"
else
  puts "no match"
end
```

<h5>Pattern matching operators: =~ and !~</h2>

<h5> </h2>

The =~ (equal-tilde) and !~ (bang-tilde) operators are used to match strings and symbols against regex patterns.   

The implementation of the =~ method in the String and Symbol classes expects a regular expression (an instance of the Regexp class) as an argument.   

```ruby
"practice zazen" =~ /zen/   # Output: => 11
"practice zazen" =~ /discursive thought/ # Output: => nil

:zazen =~ /zen/    # Output: => 2
:zazen =~ /discursive thought/  # Output: => nil
```

The implementation in the Regexp class expects a string or a symbol as an argument.   

```ruby
/zen/ =~ "practice zazen"  # Output: => 11
/zen/ =~ "discursive thought" # Output: => nil
```

In all implementations, when the string or symbol matches the Regexp pattern, it returns an integer which is the position (index) of the match. If there is no match, it returns nil. Remember that, in Ruby, any integer value is "truthy" and nil is "falsy", so the =~ operator can be used in if statements and ternary operators.  

```ruby
puts "yes" if "zazen" =~ /zen/ # Output: => yes
"zazen" =~ /zen/?"yes":"no" # Output: => yes
```

Pattern-matching operators are also useful for writing shorter if statements. Example:  

```ruby
if meditation_type == "zazen" || meditation_type == "shikantaza" || meditation_type == "kinhin"
  true
end
Can be rewritten as:
if meditation_type =~ /^(zazen|shikantaza|kinhin)$/
  true
end
```

The !~ operator is the opposite of =~, it returns true when there is no match and false if there is a match.  

More info is available at <a href="http://www.zenruby.info/2016/05/ruby-operators-equality-comparison.html" rel="noreferrer">this blog post</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How do you run a single test/spec file in RSpec? (score [196194](https://stackoverflow.com/q/143925) in 2012)

#### Question
I want to be able to run a single spec file's tests &mdash; for the one file I'm editing, for example.  `rake spec` executes all the specs.  My project is not a Rails project, so `rake spec:doc` doesn't work.  

Don't know if this matters, but here is my directory structure.  

<pre>
./Rakefile
./lib
./lib/cushion.rb
./lib/cushion
./lib/cushion/doc.rb
./lib/cushion/db.rb
./spec
./spec/spec.opts
./spec/spec_helper.rb
./spec/db_spec.rb
</pre>

#### Answer accepted (score 381)
Or you can skip rake and use the 'rspec' command:  

```ruby
rspec path/to/spec/file.rb
```

In your case I think as long as your ./spec/db_spec.rb file includes the appropriate helpers, it should work fine.   

If you're using an older version of rspec it is:  

```ruby
spec path/to/spec/file.rb
```

#### Answer 2 (score 199)
The raw invocation:  

<pre>
rake spec SPEC=spec/controllers/sessions_controller_spec.rb \
          SPEC_OPTS="-e \"should log in with cookie\""
</pre>

Now figure out how to embed this into your editor.  

#### Answer 3 (score 118)
This question is an old one, but it shows up at the top of Google when searching for how to run a single test.  I don't know if it's a recent addition, but to run a single test out of a spec you can do the following:  

```ruby
rspec path/to/spec:<line number>
```

where -line number- is a line number that contains part of your test.  For example, if you had a spec like:  

```ruby
1: 
2: it "should be awesome" do
3:   foo = 3
4:   foo.should eq(3)
5: end
6:
```

Let's say it's saved in spec/models/foo_spec.rb.  Then you would run:  

```ruby
rspec spec/models/foo_spec.rb:2
```

and it would just run that one spec.  In fact, that number could be anything from 2 to 5.  

Hope this helps!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: How to map with index in Ruby? (score [195350](https://stackoverflow.com/q/4697557) in 2015)

#### Question
What is the easiest way to convert   

```ruby
[x1, x2, x3, ... , xN]
```

to  

```ruby
[[x1, 2], [x2, 3], [x3, 4], ... , [xN, N+1]]
```

#### Answer accepted (score 798)
If you're using ruby 1.8.7 or 1.9, you can use the fact that iterator methods like `each_with_index`, when called without a block, return an `Enumerator` object, which you can call `Enumerable` methods like `map` on. So you can do:  

```ruby
arr.each_with_index.map { |x,i| [x, i+2] }
```

In 1.8.6 you can do:  

```ruby
require 'enumerator'
arr.enum_for(:each_with_index).map { |x,i| [x, i+2] }
```

#### Answer 2 (score 245)
Ruby has <a href="http://ruby-doc.org/core-2.2.3/Enumerator.html#method-i-with_index" rel="noreferrer">Enumerator#with_index(offset = 0)</a>, so first convert the array to an enumerator using <a href="http://ruby-doc.org/core-2.3.1/Object.html#method-i-to_enum" rel="noreferrer">Object#to_enum</a> or <a href="http://ruby-doc.org/core-2.2.3/Array.html#method-i-map" rel="noreferrer">Array#map</a>:  

```ruby
[:a, :b, :c].map.with_index(2).to_a
#=> [[:a, 2], [:b, 3], [:c, 4]]
```

#### Answer 3 (score 111)
In ruby 1.9.3 there is a chainable method called `with_index` which can be chained to map.  

For example:  

```ruby
array.map.with_index { |item, index| ... }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Learning Ruby on Rails (score [189430](https://stackoverflow.com/q/55574) in 2011)

#### Question
As it stands now, I'm a Java and C# developer. The more and more I look at Ruby on Rails, the more I really want to learn it.    

What have you found to be the best route to learn RoR?  Would it be easier to develop on Windows, or should I just run a virtual machine with Linux?    

Is there an IDE that can match the robustness of Visual Studio?  Any programs to develop that give a good overhead of what to do? Any good books?    

Seriously, any tips/tricks/rants would be awesome.  

#### Answer accepted (score 205)
I've been moving from C# in my professional career to looking at Ruby and RoR in my personal life, and I've found linux to be slightly more appealing personally for development.  Particularly now that I've started using git, the implementation is cleaner on linux.  

Currently I'm dual booting and getting closer to running Ubuntu full time.  I'm using gedit with various plugins for the development environment. And as of late 2010, I'm making the push to use Vim for development, even over Textmate on OS X.  

A large amount of the Rails developers are using (gasp) Macs, which has actually got me thinking in that direction.  

Although I haven't tried it, <a href="http://www.sapphiresteel.com/" rel="nofollow noreferrer">Ruby in Steel</a> gives you a Ruby IDE inside the Visual Studio world, and <a href="http://www.ironruby.net/" rel="nofollow noreferrer">IronRuby</a> is the .NET flavor of Ruby, if you're interested.  

As far as books are concerned, the <em><a href="http://pragprog.com/titles/ruby3/programming-ruby-3" rel="nofollow noreferrer">Programming Ruby</a></em> (also known as the Pickaxe) book from the Pragmatic Programmers is the de-facto for learning Ruby.  I bit the bullet and purchased that book and <em><a href="http://pragprog.com/book/rails4/agile-web-development-with-rails" rel="nofollow noreferrer">Agile Web Development with Rails</a></em>; both books have been excellent.  

<a href="http://peepcode.com/" rel="nofollow noreferrer">Peepcode</a> screencasts and PDF books have also been great for getting started; at $9 per screencast it's hard to go wrong.  I actually bought a 5-pack.  

Also check out the following:  

<ul>
<li><a href="http://guides.rubyonrails.org/" rel="nofollow noreferrer">Official Rails Guides</a></li>
<li><a href="http://railscasts.com/" rel="nofollow noreferrer">Railscasts</a></li>
<li><a href="http://railsapi.com/" rel="nofollow noreferrer">railsapi.com</a> or <a href="http://apidock.com/rails" rel="nofollow noreferrer">Ruby on Rails - APIdock</a></li>
<li><a href="http://rubyshow.com/" rel="nofollow noreferrer">The Ruby Show</a></li>
<li><a href="http://railsforzombies.org" rel="nofollow noreferrer">Rails for Zombies</a></li>
<li><a href="http://www.softiesonrails.com/" rel="nofollow noreferrer">Softies on Rails</a> - Ruby on Rails for .NET Developers</li>
<li><a href="http://podcast.rubyonrails.org/" rel="nofollow noreferrer">Rails Podcast</a></li>
<li><a href="http://www.codeschool.com/courses/rails-best-practices" rel="nofollow noreferrer">Rails Best Practices</a></li>
</ul>

I've burned through the backlog of Rails and Rails Envy podcasts in the past month and they have provided wonderful insight into lots of topics, even regarding software development in general.  

#### Answer 2 (score 125)
Beware, the rails world is a massively frustrating mess of outdated and inconsistent documentation and examples.  It is maybe one of the fastest moving and most faddish development communities there is.  By the time you learn something it will already have changed.  Even the books are not consistent in which version of rails they are talking about.  Documentation by blogging!  enough said.    

I currently do RoR on windows.  My advice is to avoid windows if you can.  Lots of things don't work and the rails community really really doesn't care about you.  The move to Git has really messed me up since it doesn't work very well on windows.  A lot of gems will fail because of this (Heroku looks like a cool tool - too bad for me it can't handle window's Git setup).  Capistrano is out.  It goes on and annoyingly on.  

Plus, in the back of your mind, you always wonder when something doesn't work "Is it a rails/windows problem?"  I am not sure this is solved by using linux because linux brings its own hassles like constantly having to upgrade all those different dependencies, etc...If that's the kind of thing you enjoy it might be an okay choice for you.  Those days of enjoying system fiddling are behind me and I just want to get on with doing my work.  I am planning on installing ubuntu on a home machine just so i can get familiar with things like capistrano so maybe my opinion will change.  

I'd highly suggest if you are going to do rails dev for any amount of time you seriously consider getting a Mac.  If you value your time and sanity it will pay for itself almost instantly.  Depending on how you value your time 10 hours of debugging windows/linux setup problems and you have spend as much as a Mac costs anyway.  

Rails is a joy compared to what it replaces but it is a bit of a pain in that its proponents skip right past a lot of the boring but important stuff like documentation, compatibility issues and community building.  It is way more powerful than other frameworks like Django but I sometimes look over at the Django documentation and community and sigh like a guy with a wild sexy girlfriend looking at his friend's plain but sane and stable wife.  But then rails adds a feature and I go "Ohhh shiny!"  

IMO the Rails Screencasts are better than the Peepcode screencasts.  RubyPlus also has screencasts, mind you, they are bit rough around the edges.  BuildingWebApps has a free online course that starts doing screencasts halfway through.  

#### Answer 3 (score 96)
Path of least resistance:  

<ul>
<li>Have a simple web project in mind.</li>
<li>Go to <strong>rubyonrails.org</strong> and look at their "Blog in 15 minutes" screencast to get excited.</li>
<li>Get a copy of O'Reilly Media's <strong>Learning Ruby</strong></li>
<li>Get a Mac or Linux box.<br>
(Fewer early Rails frustrations due to the fact that Rails is generally developed on these.)</li>
<li>Get a copy of <strong>Agile Web Development with Rails</strong>.</li>
<li>Get the version of Ruby and Rails described in that book.</li>
<li>Run through that book's first section to get a feel for what it's like.</li>
<li>Go to <strong>railscasts.com</strong> and view at the earliest videos for a closer look.</li>
<li>Buy <strong>The Rails Way</strong> by Obie Fernandez to get a deeper understanding of Rails and what it's doing.</li>
<li>Then upgrade to the newest production version of Rails, and view the latest railscasts.com videos.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: How can I remove RVM (Ruby Version Manager) from my system? (score [188959](https://stackoverflow.com/q/3558656) in 2014)

#### Question
How can I remove RVM (Ruby Version Manager) from my system?  

#### Answer accepted (score 889)
There's a simple command built-in that will pull it:  

```ruby
rvm implode
```

This will remove the `rvm/` directory and all the rubies built within it. In order to remove the final trace of rvm, you need to remove the rvm gem, too:  

```ruby
gem uninstall rvm
```

If you've made modifications to your `PATH` you might want to pull those, too. Check your `.bashrc`, `.profile` and `.bash_profile` files, among other things.  

You may also have an `/etc/rvmrc` file, or one in your home directory `~/.rvmrc` that may need to be removed as well.  

#### Answer 2 (score 54)
If the other answers don’t remove RVM throughly enough for you, <a href="https://rvm.io/support/troubleshooting/" rel="noreferrer">RVM’s Troubleshooting page</a> contains this section:  

<blockquote>
  <h5>How do I completely clean out all traces of RVM from my system, including for system wide installs?</h2>
  
  Here is a custom script which we name as `cleanout-rvm`. While you can definitely use `rvm implode` as a regular user or `rvmsudo rvm implode` for a system wide install, this script is useful as it steps completely outside of RVM and cleans out RVM without using RVM itself, leaving no traces.  
  
  ```ruby
#!/bin/bash
/usr/bin/sudo rm -rf $HOME/.rvm $HOME/.rvmrc /etc/rvmrc /etc/profile.d/rvm.sh /usr/local/rvm /usr/local/bin/rvm
/usr/bin/sudo /usr/sbin/groupdel rvm
/bin/echo "RVM is removed. Please check all .bashrc|.bash_profile|.profile|.zshrc for RVM source lines and delete
or comment out if this was a Per-User installation."
```
</blockquote>

#### Answer 3 (score 31)
When using implode and you see:  

```ruby
Psychologist intervened, cancelling implosion, crisis avoided :)
```

Then you may want to use --force  

```ruby
rvm implode --force
```

Then remove rvm from following locations:  

```ruby
rm -rf /usr/local/rvm
sudo rm /etc/profile.d/rvm.sh
sudo rm /etc/rvmrc
sudo rm ~/.rvmrc
```

Check the following files and remove or comment out references to rvm  

```ruby
~/.bashrc 
~/.bash_profile 
~/.profile 
~/.zshrc
~/.zlogin
```

Comment-out / Remove the following lines from /etc/profile  

```ruby
 source /etc/profile.d/sm.sh
 source /etc/profile.d/rvm.sh
```

/etc/profile is a readonly file so use   

```ruby
sudo vim /etc/profile
```

And after making the change write using a bang!  

```ruby
:w!
```

Finally re-login / restart your terminal.  
</section>

