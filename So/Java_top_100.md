---
title: Java <- StackOverflow top 71
category: java
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How do I convert a String to an int in Java? (score [5767039](https://stackoverflow.com/q/5585779) in 2018)

#### Question
How can I convert a `String` to an `int` in Java?  

My String contains only numbers, and I want to return the number it represents.  

For example, given the string `"1234"` the result should be the number `1234`.  

#### Answer accepted (score 3924)
```java
String myString = "1234";
int foo = Integer.parseInt(myString);
```

If you look at the <a href="https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/lang/Integer.html#parseInt(java.lang.String)" rel="noreferrer">Java Documentation</a> you'll notice the "catch" is that this function can throw a `NumberFormatException`, which of course you have to handle:  

```java
int foo;
try {
   foo = Integer.parseInt(myString);
}
catch (NumberFormatException e)
{
   foo = 0;
}
```

(This treatment defaults a malformed number to `0`, but you can do something else if you like.)  

Alternatively, you can use an `Ints` method from the Guava library, which in combination with Java 8's `Optional`, makes for a powerful and concise way to convert a string into an int:  

```java
import com.google.common.primitives.Ints;

int foo = Optional.ofNullable(myString)
 .map(Ints::tryParse)
 .orElse(0)
```

#### Answer 2 (score 647)
For example, here are two ways:  

```java
Integer x = Integer.valueOf(str);
// or
int y = Integer.parseInt(str);
```

There is a slight difference between these methods:   

<ul>
<li>`valueOf` returns a new or cached instance of `java.lang.Integer`</li>
<li>`parseInt` returns primitive `int`. </li>
</ul>

The same is for all cases: `Short.valueOf`/`parseShort`, `Long.valueOf`/`parseLong`, etc.  

#### Answer 3 (score 233)
Well, a very important point to consider is that the Integer parser throws NumberFormatException as stated in <a href="http://docs.oracle.com/javase/6/docs/api/java/lang/Integer.html#parseInt%28java.lang.String%29" rel="noreferrer">Javadoc</a>.   

```java
int foo;
String StringThatCouldBeANumberOrNot = "26263Hello"; //will throw exception
String StringThatCouldBeANumberOrNot2 = "26263"; //will not throw exception
try {
      foo = Integer.parseInt(StringThatCouldBeANumberOrNot);
} catch (NumberFormatException e) {
      //Will Throw exception!
      //do something! anything to handle the exception.
}

try {
      foo = Integer.parseInt(StringThatCouldBeANumberOrNot2);
} catch (NumberFormatException e) {
      //No problem this time, but still it is good practice to care about exceptions.
      //Never trust user input :)
      //Do something! Anything to handle the exception.
}
```

It is important to handle this exception when trying to get integer values from split arguments or dynamically parsing something.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I declare and initialize an array in Java? (score [4290819](https://stackoverflow.com/q/1200621) in 2017)

#### Question
How do I declare and initialize an array in Java?  

#### Answer accepted (score 2539)
You can either use array declaration or array literal (but only when you declare and affect the variable right away, array literals cannot be used for re-assigning an array).   

For primitive types:   

```java
int[] myIntArray = new int[3];
int[] myIntArray = {1, 2, 3};
int[] myIntArray = new int[]{1, 2, 3};
```

For classes, for example `String`, it's the same:  

```java
String[] myStringArray = new String[3];
String[] myStringArray = {"a", "b", "c"};
String[] myStringArray = new String[]{"a", "b", "c"};
```

The third way of initializing is useful when you declare the array first and then initialize it. The cast is necessary here.  

```java
String[] myStringArray;
myStringArray = new String[]{"a", "b", "c"};
```

#### Answer 2 (score 259)
There are two types of array.<br/>   

<h5>One Dimensional Array</h2>

Syntax for default values:  

```java
int[] num = new int[5];
```

Or (less preferred)  

```java
int num[] = new int[5];
```

Syntax with values given (variable/field initialization):  

```java
int[] num = {1,2,3,4,5};
```

Or (less preferred)  

```java
int num[] = {1, 2, 3, 4, 5};
```

Note: For convenience  int[] num is preferable because it clearly tells that you are talking here about array. Otherwise no difference. Not at all.<br/>  

<h5>Multidimensional array</h2>

<h5>Declaration</h3>

```java
int[][] num = new int[5][2];
```

Or  

```java
int num[][] = new int[5][2];
```

Or  

```java
int[] num[] = new int[5][2];
```

<h5>Initialization</h3>

```java
 num[0][0]=1;
 num[0][1]=2;
 num[1][0]=1;
 num[1][1]=2;
 num[2][0]=1;
 num[2][1]=2;
 num[3][0]=1;
 num[3][1]=2;
 num[4][0]=1;
 num[4][1]=2;
```

Or  

```java
 int[][] num={ {1,2}, {1,2}, {1,2}, {1,2}, {1,2} };
```

<h5>Ragged Array (or Non-rectangular Array)</h3>

```java
 int[][] num = new int[5][];
 num[0] = new int[1];
 num[1] = new int[5];
 num[2] = new int[2];
 num[3] = new int[3];
```

<p>So here we are defining columns explicitly.<br/>
<b>Another Way:</b>  </p>

```java
int[][] num={ {1}, {1,2}, {1,2,3,4,5}, {1,2}, {1,2,3} };
```

<h5>For Accessing:</h2>

```java
for (int i=0; i<(num.length); i++ ) {
    for (int j=0;j<num[i].length;j++)
        System.out.println(num[i][j]);
}
```

Alternatively:  

```java
for (int[] a : num) {
  for (int i : a) {
    System.out.println(i);
  }
}
```

<p>Ragged arrays are multidimensional arrays.<br/>
For explanation see multidimensional array detail at <a href="http://docs.oracle.com/javase/tutorial/java/nutsandbolts/arrays.html" rel="noreferrer">the official java tutorials</a></p>

#### Answer 3 (score 122)
```java
Type[] variableName = new Type[capacity];

Type[] variableName = {comma-delimited values};



Type variableName[] = new Type[capacity]; 

Type variableName[] = {comma-delimited values};
```

is also valid, but I prefer the brackets after the type, because it's easier to see that the variable's type is actually an array.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How do I generate random integers within a specific range in Java? (score [3879757](https://stackoverflow.com/q/363681) in 2019)

#### Question
How do I generate a random `int` value in a specific range?  

I have tried the following, but those do not work:  

<strong>Attempt 1:</strong>  

```java
randomNum = minimum + (int)(Math.random() * maximum);
// Bug: `randomNum` can be bigger than `maximum`.
```

<strong>Attempt 2:</strong>  

```java
Random rn = new Random();
int n = maximum - minimum + 1;
int i = rn.nextInt() % n;
randomNum =  minimum + i;
// Bug: `randomNum` can be smaller than `minimum`.
```

#### Answer 2 (score 3665)
In <strong>Java 1.7 or later</strong>, the standard way to do this is as follows:  

```java
import java.util.concurrent.ThreadLocalRandom;

// nextInt is normally exclusive of the top value,
// so add 1 to make it inclusive
int randomNum = ThreadLocalRandom.current().nextInt(min, max + 1);
```

See <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/ThreadLocalRandom.html#nextInt(int,int)" rel="noreferrer">the relevant JavaDoc</a>.  This approach has the advantage of not needing to explicitly initialize a <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Random.html" rel="noreferrer">java.util.Random</a> instance, which can be a source of confusion and error if used inappropriately.  

However, conversely there is no way to explicitly set the seed so it can be difficult to reproduce results in situations where that is useful such as testing or saving game states or similar.  In those situations, the pre-Java 1.7 technique shown below can be used.  

<strong>Before Java 1.7</strong>, the standard way to do this is as follows:  

```java
import java.util.Random;

/**
 * Returns a pseudo-random number between min and max, inclusive.
 * The difference between min and max can be at most
 * <code>Integer.MAX_VALUE - 1</code>.
 *
 * @param min Minimum value
 * @param max Maximum value.  Must be greater than min.
 * @return Integer between min and max, inclusive.
 * @see java.util.Random#nextInt(int)
 */
public static int randInt(int min, int max) {

    // NOTE: This will (intentionally) not run as written so that folks
    // copy-pasting have to think about how to initialize their
    // Random instance.  Initialization of the Random instance is outside
    // the main scope of the question, but some decent options are to have
    // a field that is initialized once and then re-used as needed or to
    // use ThreadLocalRandom (if using at least Java 1.7).
    // 
    // In particular, do NOT do 'Random rand = new Random()' here or you
    // will get not very good / not very random results.
    Random rand;

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
}
```

See <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Random.html#nextInt(int)" rel="noreferrer">the relevant JavaDoc</a>.  In practice, the <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Random.html" rel="noreferrer">java.util.Random</a> class is often preferable to <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Math.html#random()" rel="noreferrer">java.lang.Math.random()</a>.  

In particular, there is no need to reinvent the random integer generation wheel when there is a straightforward API within the standard library to accomplish the task.  

#### Answer 3 (score 1393)
Note that this approach is more biased and less efficient than a `nextInt` approach, <a href="https://stackoverflow.com/a/738651/360211">https://stackoverflow.com/a/738651/360211</a>  

One standard pattern for accomplishing this is:  

```java
Min + (int)(Math.random() * ((Max - Min) + 1))
```

The <a href="http://en.wikipedia.org/wiki/Java_%28programming_language%29" rel="noreferrer">Java</a> Math library function Math.random() generates a double value in the range `[0,1)`. Notice this range does not include the 1.  

In order to get a specific range of values first, you need to multiply by the magnitude of the range of values you want covered.   

```java
Math.random() * ( Max - Min )
```

This returns a value in the range `[0,Max-Min)`, where 'Max-Min' is not included.  

For example, if you want `[5,10)`, you need to cover five integer values so you use  

```java
Math.random() * 5
```

This would return a value in the range `[0,5)`, where 5 is not included.  

Now you need to shift this range up to the range that you are targeting. You do this by adding the Min value.  

```java
Min + (Math.random() * (Max - Min))
```

You now will get a value in the range `[Min,Max)`. Following our example, that means `[5,10)`:  

```java
5 + (Math.random() * (10 - 5))
```

But, this still doesn't include `Max` and you are getting a double value. In order to get the `Max` value included, you need to add 1 to your range parameter `(Max - Min)` and then truncate the decimal part by casting to an int. This is accomplished via:  

```java
Min + (int)(Math.random() * ((Max - Min) + 1))
```

And there you have it. A random integer value in the range `[Min,Max]`, or per the example `[5,10]`:  

```java
5 + (int)(Math.random() * ((10 - 5) + 1))
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How to split a string in Java (score [3688160](https://stackoverflow.com/q/3481828) in 2018)

#### Question
I have a string, `"004-034556"`, that I want to split into two strings:  

```java
string1="004";
string2="034556";
```

That means the first string will contain the characters before `'-'`, and the second string will contain the characters after `'-'`. I also want to check if the string has `'-'` in it. If not, I will throw an exception. How can I do this?  

#### Answer accepted (score 2767)
Just use the appropriate method: <a href="http://docs.oracle.com/javase/8/docs/api/java/lang/String.html#split-java.lang.String-" rel="noreferrer">`String#split()`</a>.  

```java
String string = "004-034556";
String[] parts = string.split("-");
String part1 = parts[0]; // 004
String part2 = parts[1]; // 034556
```

Note that this takes a <a href="http://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html#sum" rel="noreferrer">regular expression</a>, so remember to escape <a href="http://www.regular-expressions.info/characters.html" rel="noreferrer">special characters</a> if necessary.  

<blockquote>
  <a href="http://www.regular-expressions.info/characters.html" rel="noreferrer">there</a> are 12 characters with special meanings: the backslash `\`, the caret `^`, the dollar sign `$`, the period or dot `.`, the vertical bar or pipe symbol `|`, the question mark `?`, the asterisk or star `*`, the plus sign `+`, the opening parenthesis `(`, the closing parenthesis `)`, and the opening square bracket `[`, the opening curly brace `{`, These special characters are often called "metacharacters".  
</blockquote>

So, if you want to split on e.g. period/dot `.` which means "<a href="http://www.regular-expressions.info/dot.html" rel="noreferrer">any character</a>" in regex, use either <a href="http://www.regular-expressions.info/characters.html" rel="noreferrer">backslash `\`</a> to escape the individual special character like so `split("\\.")`, or use <a href="http://www.regular-expressions.info/charclass.html" rel="noreferrer">character class `[]`</a> to represent literal character(s) like so `split("[.]")`, or use <a href="http://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html#quote-java.lang.String-" rel="noreferrer">`Pattern#quote()`</a> to escape the entire string like so `split(Pattern.quote("."))`.  

```java
String[] parts = string.split(Pattern.quote(".")); // Split on period.
```

To test beforehand if the string contains certain character(s), just use <a href="http://docs.oracle.com/javase/8/docs/api/java/lang/String.html#contains-java.lang.CharSequence-" rel="noreferrer">`String#contains()`</a>.  

```java
if (string.contains("-")) {
    // Split it.
} else {
    throw new IllegalArgumentException("String " + string + " does not contain -");
}
```

Note, this does not take a regular expression. For that, use <a href="http://docs.oracle.com/javase/8/docs/api/java/lang/String.html#matches-java.lang.String-" rel="noreferrer">`String#matches()`</a> instead.  

If you'd like to retain the split character in the resulting parts, then make use of <a href="http://www.regular-expressions.info/lookaround.html" rel="noreferrer">positive lookaround</a>. In case you want to have the split character to end up in left hand side, use positive lookbehind by prefixing `?&lt;=` group on the pattern.  

```java
String string = "004-034556";
String[] parts = string.split("(?<=-)");
String part1 = parts[0]; // 004-
String part2 = parts[1]; // 034556
```

In case you want to have the split character to end up in right hand side, use positive lookahead by prefixing `?=` group on the pattern.  

```java
String string = "004-034556";
String[] parts = string.split("(?=-)");
String part1 = parts[0]; // 004
String part2 = parts[1]; // -034556
```

If you'd like to limit the number of resulting parts, then you can supply the desired number as 2nd argument of `split()` method.   

```java
String string = "004-034556-42";
String[] parts = string.split("-", 2);
String part1 = parts[0]; // 004
String part2 = parts[1]; // 034556-42
```

#### Answer 2 (score 72)
An alternative to processing the string directly would be to use a regular expression with capturing groups. This has the advantage that it makes it straightforward to imply more sophisticated constraints on the input. For example, the following splits the string into two parts, and ensures that both consist only of digits:  

```java
import java.util.regex.Pattern;
import java.util.regex.Matcher;

class SplitExample
{
    private static Pattern twopart = Pattern.compile("(\\d+)-(\\d+)");

    public static void checkString(String s)
    {
        Matcher m = twopart.matcher(s);
        if (m.matches()) {
            System.out.println(s + " matches; first part is " + m.group(1) +
                               ", second part is " + m.group(2) + ".");
        } else {
            System.out.println(s + " does not match.");
        }
    }

    public static void main(String[] args) {
        checkString("123-4567");
        checkString("foo-bar");
        checkString("123-");
        checkString("-4567");
        checkString("123-4567-890");
    }
}
```

As the pattern is fixed in this instance, it can be compiled in advance and stored as a static member (initialised at class load time in the example). The regular expression is:  

```java
(\d+)-(\d+)
```

The parentheses denote the capturing groups; the string that matched that part of the regexp can be accessed by the Match.group() method, as shown. The \d matches and single decimal digit, and the + means "match one or more of the previous expression). The - has no special meaning, so just matches that character in the input. Note that you need to double-escape the backslashes when writing this as a Java string. Some other examples:  

```java
([A-Z]+)-([A-Z]+)          // Each part consists of only capital letters 
([^-]+)-([^-]+)            // Each part consists of characters other than -
([A-Z]{2})-(\d+)           // The first part is exactly two capital letters,
                           // the second consists of digits
```

#### Answer 3 (score 41)
```java
String[] result = yourString.split("-");
if (result.length != 2) 
     throw new IllegalArgumentException("String not in correct format");
```

This will split your string into 2 parts.  The first element in the array will be the part containing the stuff before the `-`, and the 2nd element in the array will contain the part of your string after the `-`.  

If the array length is not 2, then the string was not in the format: `string-string`.  

Check out the `split()` method in the `String` class.  

<blockquote>
  <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#split-java.lang.String-int-" rel="noreferrer">https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#split-java.lang.String-int-</a>  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: Iterate through a HashMap (score [3596326](https://stackoverflow.com/q/1066589) in 2019)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong> <br/>
  <a href="https://stackoverflow.com/questions/46898">How to efficiently iterate over each entry in a 'Map'?</a></p>
</blockquote>



What's the best way to iterate over the items in a <a href="https://docs.oracle.com/javase/10/docs/api/java/util/HashMap.html" rel="nofollow noreferrer">`HashMap`</a>?  

#### Answer accepted (score 3147)
Iterate through the <a href="http://www.java2s.com/Code/JavaAPI/java.util/HashtableentrySet.htm" rel="noreferrer">`entrySet()`</a> like so:  

```java
public static void printMap(Map mp) {
    Iterator it = mp.entrySet().iterator();
    while (it.hasNext()) {
        Map.Entry pair = (Map.Entry)it.next();
        System.out.println(pair.getKey() + " = " + pair.getValue());
        it.remove(); // avoids a ConcurrentModificationException
    }
}
```

Read more about <a href="http://docs.oracle.com/javase/7/docs/api/java/util/Map.html" rel="noreferrer">`Map`</a>.  

#### Answer 2 (score 4558)
If you're only interested in the keys, you can iterate through the <a href="https://docs.oracle.com/javase/1.5.0/docs/api/java/util/Map.html#keySet%28%29" rel="nofollow noreferrer">`keySet()`</a> of the map:  

```java
Map<String, Object> map = ...;

for (String key : map.keySet()) {
    // ...
}
```

If you only need the values, use <a href="https://docs.oracle.com/javase/1.5.0/docs/api/java/util/Map.html#values%28%29" rel="nofollow noreferrer">`values()`</a>:  

```java
for (Object value : map.values()) {
    // ...
}
```

Finally, if you want both the key and value, use <a href="https://docs.oracle.com/javase/1.5.0/docs/api/java/util/Map.html#entrySet%28%29" rel="nofollow noreferrer">`entrySet()`</a>:  

```java
for (Map.Entry<String, Object> entry : map.entrySet()) {
    String key = entry.getKey();
    Object value = entry.getValue();
    // ...
}
```

One caveat: if you want to remove items mid-iteration, you'll need to do so via an Iterator (see <a href="https://stackoverflow.com/questions/1066589/java-iterate-through-hashmap/1066603#1066603">karim79's answer</a>). However, changing item values is OK (see <a href="https://docs.oracle.com/javase/6/docs/api/java/util/Map.Entry.html" rel="nofollow noreferrer">`Map.Entry`</a>).  

#### Answer 3 (score 818)
Extracted from the reference <em><a href="http://www.sergiy.ca/how-to-iterate-over-a-map-in-java">How to Iterate Over a Map in Java</a></em>:  

There are several ways of iterating over a `Map` in Java. Let's go over the most common methods and review their advantages and disadvantages. Since all maps in Java implement the Map interface, the following techniques will work for any map implementation (`HashMap`, `TreeMap`, `LinkedHashMap`, `Hashtable`, etc.)  

<strong>Method #1</strong>: Iterating over entries using a For-Each loop.  

This is the most common method and is preferable in most cases. It should be used if you need both map keys and values in the loop.  

```java
Map<Integer, Integer> map = new HashMap<Integer, Integer>();
for (Map.Entry<Integer, Integer> entry : map.entrySet()) {
    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
}
```

Note that the For-Each loop was introduced in Java 5, so this method is working only in newer versions of the language. Also a For-Each loop will throw `NullPointerException` if you try to iterate over a map that is null, so before iterating you should always check for null references.  

<strong>Method #2</strong>: Iterating over keys or values using a For-Each loop.  

If you need only keys or values from the map, you can iterate over keySet or values instead of entrySet.  

```java
Map<Integer, Integer> map = new HashMap<Integer, Integer>();

// Iterating over keys only
for (Integer key : map.keySet()) {
    System.out.println("Key = " + key);
}

// Iterating over values only
for (Integer value : map.values()) {
    System.out.println("Value = " + value);
}
```

This method gives a slight performance advantage over `entrySet` iteration (about 10% faster) and is more clean.  

<strong>Method #3</strong>: Iterating using Iterator.  

Using Generics:  

```java
Map<Integer, Integer> map = new HashMap<Integer, Integer>();
Iterator<Map.Entry<Integer, Integer>> entries = map.entrySet().iterator();
while (entries.hasNext()) {
    Map.Entry<Integer, Integer> entry = entries.next();
    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
}
```

Without Generics:  

```java
Map map = new HashMap();
Iterator entries = map.entrySet().iterator();
while (entries.hasNext()) {
    Map.Entry entry = (Map.Entry) entries.next();
    Integer key = (Integer)entry.getKey();
    Integer value = (Integer)entry.getValue();
    System.out.println("Key = " + key + ", Value = " + value);
}
```

You can also use same technique to iterate over `keySet` or values.  

This method might look redundant, but it has its own advantages. First of all, it is the only way to iterate over a map in older versions of Java. The other important feature is that it is the only method that allows you to remove entries from the map during iteration by calling `iterator.remove()`. If you try to do this during For-Each iteration you will get "unpredictable results" according to <a href="https://en.wikipedia.org/wiki/Javadoc">Javadoc</a>.  

From a performance point of view this method is equal to a For-Each iteration.  

<strong>Method #4</strong>: Iterating over keys and searching for values (inefficient).  

```java
Map<Integer, Integer> map = new HashMap<Integer, Integer>();
for (Integer key : map.keySet()) {
    Integer value = map.get(key);
    System.out.println("Key = " + key + ", Value = " + value);
}
```

This might look like a cleaner alternative for method #1, but in practice it is pretty slow and inefficient as getting values by a key might be time-consuming (this method in different Map implementations is 20%-200% slower than method #1). If you have FindBugs installed, it will detect this and warn you about inefficient iteration. This method should be avoided.  

<strong>Conclusion:</strong>  

If you need only keys or values from the map, use method #2. If you are stuck with older version of Java (less than 5) or planning to remove entries during iteration, you have to use method #3. Otherwise use method #1.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: Initialization of an ArrayList in one line (score [2834764](https://stackoverflow.com/q/1005073) in 2014)

#### Question
I want to create a list of options for testing purposes. At first, I did this:  

```java
ArrayList<String> places = new ArrayList<String>();
places.add("Buenos Aires");
places.add("Córdoba");
places.add("La Plata");
```

Then I refactored the code as follows:  

```java
ArrayList<String> places = new ArrayList<String>(
    Arrays.asList("Buenos Aires", "Córdoba", "La Plata"));
```

Is there a better way to do this?  

#### Answer accepted (score 1911)
Actually, probably the "best" way to initialize the `ArrayList` is the method you wrote, as it does not need to create a new `List` in any way:  

```java
ArrayList<String> list = new ArrayList<String>();
list.add("A");
list.add("B");
list.add("C");
```

The catch is that there is quite a bit of typing required to refer to that `list` instance.  

There are alternatives, such as making an anonymous inner class with an instance initializer (also known as an "double brace initialization"):  

```java
ArrayList<String> list = new ArrayList<String>() {{
    add("A");
    add("B");
    add("C");
}};
```

However, I'm not too fond of that method because what you end up with is a subclass of `ArrayList` which has an instance initializer, and that class is created just to create one object -- that just seems like a little bit overkill to me.  

What would have been nice was if the <a href="http://mail.openjdk.java.net/pipermail/coin-dev/2009-March/001193.html" rel="noreferrer">Collection Literals proposal</a> for <a href="http://openjdk.java.net/projects/coin" rel="noreferrer">Project Coin</a> was accepted (it was slated to be introduced in Java 7, but it's not likely to be part of Java 8 either.):  

```java
List<String> list = ["A", "B", "C"];
```

Unfortunately it won't help you here, as it will initialize an immutable `List` rather than an `ArrayList`, and furthermore, it's not available yet, if it ever will be.  

#### Answer 2 (score 2033)
It would be simpler if you were to just declare it as a `List` - does it have to be an ArrayList?  

```java
List<String> places = Arrays.asList("Buenos Aires", "Córdoba", "La Plata");
```

Or if you have only one element:  

```java
List<String> places = Collections.singletonList("Buenos Aires");
```

This would mean that `places` is <strong>immutable</strong> (trying to change it will cause an `UnsupportedOperationException` exception to be thrown).  

To make a mutable list that is a concrete `ArrayList` you can create an `ArrayList` from the immutable list:  

```java
ArrayList<String> places = new ArrayList<>(Arrays.asList("Buenos Aires", "Córdoba", "La Plata"));
```

#### Answer 3 (score 796)
<h5>The simple answer</h1>

In Java 10, 11, 12, or later:  

```java
var strings = List.of("foo", "bar", "baz");
```

In Java 9 or later:  

```java
List<String> strings = List.of("foo", "bar", "baz");
```

<p>This will give you an immutable `List`, so it cannot be changed.<br>
Which is what you want in most cases where you're prepopulating it.</p>

<hr>

<h5>Java 8 or earlier:</h1>

```java
List<String> strings = Arrays.asList("foo", "bar", "baz");
```

<p>This will give you a `List` backed by the array, so it cannot change length.<br>
But you can call `List.set`, so it's still mutable.</p>

<hr>

You can make `Arrays.asList` even shorter with a static import:  

```java
List<String> strings = asList("foo", "bar", "baz");
```

The static import:  

```java
import static java.util.Arrays.asList;  
```

<p>Which any modern IDE will suggest and automatically do for you.<br>
For example in IntelliJ IDEA you press `Alt+Enter` and select `Static import method...`.</p>

<hr>

<p>However, i don't recommend shortening the Java 9 `List.of` method, because having just `of` becomes confusing.<br>
`List.of` is already short enough and reads well.</p>

<hr>

<h5>Using `Stream`s</h1>

<p>Why does it have to be a `List`?<br>
With Java 8 or later you can use a `Stream` which is more flexible:</p>

```java
Stream<String> strings = Stream.of("foo", "bar", "baz");
```

You can concatenate `Stream`s:  

```java
Stream<String> strings = Stream.concat(Stream.of("foo", "bar"),
                                       Stream.of("baz", "qux"));
```

Or you can go from a `Stream` to a `List`:  

```java
import static java.util.stream.Collectors.toList;

List<String> strings = Stream.of("foo", "bar", "baz").collect(toList());
```

But preferably, just use the `Stream` without collecting it to a `List`.  

<hr>

<h5>If you <em>really</em> specifically need a `java.util.ArrayList`</h1>

<p>(You probably don't.)<br>
To quote <a href="http://openjdk.java.net/jeps/269" rel="noreferrer">JEP 269</a> (emphasis mine):</p>

<blockquote>
  There is a <strong>small set</strong> of use cases for initializing a mutable collection instance with a predefined set of values. It's usually preferable to have those predefined values be in an immutable collection, and then to initialize the mutable collection via a copy constructor.  
</blockquote>

<hr>

If you want to <em>both</em> prepopulate an `ArrayList` <em>and</em> add to it afterwards (why?), use  

```java
ArrayList<String> strings = new ArrayList<>(List.of("foo", "bar"));
strings.add("baz");
```

or in Java 8 or earlier:  

```java
ArrayList<String> strings = new ArrayList<>(asList("foo", "bar"));
strings.add("baz");
```

or using `Stream`:  

```java
import static java.util.stream.Collectors.toCollection;

ArrayList<String> strings = Stream.of("foo", "bar")
                             .collect(toCollection(ArrayList::new));
strings.add("baz");
```

But again, it's better to just use the `Stream` directly instead of collecting it to a `List`.  

<hr>

<h5>Program to interfaces, not to implementations</h1>

You said you've declared the list as an `ArrayList` in your code, but you should only do that if you're using some member of `ArrayList` that's not in `List`.  

Which you are most likely not doing.  

Usually you should just declare variables by the most general interface that you are going to use (e.g. `Iterable`, `Collection`, or `List`), and initialize them with the specific implementation (e.g. `ArrayList`, `LinkedList` or `Arrays.asList()`).  

Otherwise you're limiting your code to that specific type, and it'll be harder to change when you want to.  

For example, if you're passing an `ArrayList` to a `void method(...)`:  

```java
// Iterable if you just need iteration, for (String s : strings):
void method(Iterable<String> strings) { 
    for (String s : strings) { ... } 
}

// Collection if you also need .size(), .isEmpty(), or .stream():
void method(Collection<String> strings) {
    if (!strings.isEmpty()) { strings.stream()... }
}

// List if you also need .get(index):
void method(List<String> strings) {
    strings.get(...)
}

// Don't declare a specific list implementation
// unless you're sure you need it:
void method(ArrayList<String> strings) {
    ??? // You don't want to limit yourself to just ArrayList
}
```

<hr>

Another example would be always declaring variable an `InputStream` even though it is usually a `FileInputStream` or a `BufferedInputStream`, because one day soon you or somebody else will want to use some other kind of `InputStream`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How do I create a file and write to it in Java? (score [2755644](https://stackoverflow.com/q/2885173) in 2017)

#### Question
What's the simplest way to create and write to a (text) file in Java?  

#### Answer accepted (score 1656)
<em>Note that each of the code samples below may throw `IOException`. Try/catch/finally blocks have been omitted for brevity. See <a href="https://docs.oracle.com/javase/tutorial/essential/exceptions/handling.html" rel="noreferrer">this tutorial</a> for information about exception handling.</em>  

<em>Note that each of the code samples below will overwrite the file if it already exists</em>  

Creating a text file:  

```java
PrintWriter writer = new PrintWriter("the-file-name.txt", "UTF-8");
writer.println("The first line");
writer.println("The second line");
writer.close();
```

Creating a binary file:  

```java
byte data[] = ...
FileOutputStream out = new FileOutputStream("the-file-name");
out.write(data);
out.close();
```

<strong>Java 7+</strong> users can use the <a href="http://docs.oracle.com/javase/7/docs/api/index.html?java/nio/file/Files.html" rel="noreferrer">`Files`</a> class to write to files:  

Creating a text file:  

```java
List<String> lines = Arrays.asList("The first line", "The second line");
Path file = Paths.get("the-file-name.txt");
Files.write(file, lines, StandardCharsets.UTF_8);
//Files.write(file, lines, StandardCharsets.UTF_8, StandardOpenOption.APPEND);
```

Creating a binary file:  

```java
byte data[] = ...
Path file = Paths.get("the-file-name");
Files.write(file, data);
//Files.write(file, data, StandardOpenOption.APPEND);
```

#### Answer 2 (score 400)
In Java 7 and up:  

```java
try (Writer writer = new BufferedWriter(new OutputStreamWriter(
              new FileOutputStream("filename.txt"), "utf-8"))) {
   writer.write("something");
}
```

There are useful utilities for that though:  

<ul>
<li><a href="https://commons.apache.org/proper/commons-io/javadocs/api-release/org/apache/commons/io/FileUtils.html#writeStringToFile(java.io.File,%20java.lang.String,%20java.nio.charset.Charset)" rel="noreferrer">FileUtils.writeStringtoFile(..)</a> from commons-io</li>
<li><a href="http://google.github.io/guava/releases/19.0/api/docs/com/google/common/io/Files.html#write(java.lang.CharSequence,%20java.io.File,%20java.nio.charset.Charset)" rel="noreferrer">Files.write(..)</a> from guava</li>
</ul>

Note also that you <em>can</em> use a `FileWriter`, but it uses the default encoding, which is often a bad idea - it's best to specify the encoding explicitly.  

Below is the original, prior-to-Java 7 answer  

<hr>

```java
Writer writer = null;

try {
    writer = new BufferedWriter(new OutputStreamWriter(
          new FileOutputStream("filename.txt"), "utf-8"));
    writer.write("Something");
} catch (IOException ex) {
    // Report
} finally {
   try {writer.close();} catch (Exception ex) {/*ignore*/}
}
```

See also: <a href="http://docs.oracle.com/javase/tutorial/essential/io/file.html" rel="noreferrer">Reading, Writing, and Creating Files</a> (includes NIO2).  

#### Answer 3 (score 127)
If you already have the content you want to write to the file (and not generated on the fly), the <a href="https://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html">`java.nio.file.Files`</a> addition in Java 7 as part of native I/O provides the simplest and most efficient way to achieve your goals.  

Basically creating and writing to a file is one line only, moreover <strong>one simple method call</strong>!  

The following example creates and writes to 6 different files to showcase how it can be used:  

```java
Charset utf8 = StandardCharsets.UTF_8;
List<String> lines = Arrays.asList("1st line", "2nd line");
byte[] data = {1, 2, 3, 4, 5};

try {
    Files.write(Paths.get("file1.bin"), data);
    Files.write(Paths.get("file2.bin"), data,
            StandardOpenOption.CREATE, StandardOpenOption.APPEND);
    Files.write(Paths.get("file3.txt"), "content".getBytes());
    Files.write(Paths.get("file4.txt"), "content".getBytes(utf8));
    Files.write(Paths.get("file5.txt"), lines, utf8);
    Files.write(Paths.get("file6.txt"), lines, utf8,
            StandardOpenOption.CREATE, StandardOpenOption.APPEND);
} catch (IOException e) {
    e.printStackTrace();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: How does the Java 'for each' loop work? (score [2503583](https://stackoverflow.com/q/85190) in 2018)

#### Question
Consider:  

```java
List<String> someList = new ArrayList<String>();
// add "monkey", "donkey", "skeleton key" to someList
```



```java
for (String item : someList) {
    System.out.println(item);
}
```

What would the equivalent `for` loop look like without using the <em>for each</em> syntax?  

#### Answer accepted (score 1123)
```java
for (Iterator<String> i = someIterable.iterator(); i.hasNext();) {
    String item = i.next();
    System.out.println(item);
}
```

Note that if you need to use `i.remove();` in your loop, or access the actual iterator in some way, you cannot use the `for ( : )` idiom, since the actual iterator is merely inferred.  

As was noted by Denis Bueno, this code works for any object that implements the <a href="http://docs.oracle.com/javase/8/docs/api/java/lang/Iterable.html" rel="noreferrer">`Iterable` interface</a>.  

Also, if the right-hand side of the `for (:)` idiom is an `array` rather than an `Iterable` object, the internal code uses an int index counter and checks against `array.length` instead. See the <a href="http://docs.oracle.com/javase/specs/jls/se8/html/jls-14.html#jls-14.14.2" rel="noreferrer">Java Language Specification</a>.  

#### Answer 2 (score 476)
The construct <em>for each</em> is also valid for arrays. e.g.  

```java
String[] fruits = new String[] { "Orange", "Apple", "Pear", "Strawberry" };

for (String fruit : fruits) {
    // fruit is an element of the `fruits` array.
}
```

which is essentially equivalent of  

```java
for (int i = 0; i < fruits.length; i++) {
    String fruit = fruits[i];
    // fruit is an element of the `fruits` array.
}
```

<p>So, overall summary: <br/>
<a href="https://stackoverflow.com/questions/85190/how-does-the-java-for-each-loop-work/85206#85206">[nsayer]</a> The following is the longer form of what is happening:</p>

<blockquote>
```java
for(Iterator<String> i = someList.iterator(); i.hasNext(); ) {
  String item = i.next();
  System.out.println(item);
}
```
  
  <p>Note that if you need to use
  i.remove(); in your loop, or access
  the actual iterator in some way, you
  cannot use the for( : ) idiom, since
  the actual Iterator is merely
  inferred.</p>
</blockquote>

<a href="https://stackoverflow.com/questions/85190/how-does-the-java-for-each-loop-work/85242#85242">[Denis Bueno]</a>  

<blockquote>
  <p>It's implied by nsayer's answer, but
  it's worth noting that the OP's for(..)
  syntax will work when "someList" is
  anything that implements
  java.lang.Iterable -- it doesn't have
  to be a list, or some collection from
  java.util. Even your own types,
  therefore, can be used with this
  syntax.</p>
</blockquote>

#### Answer 3 (score 150)
The <a href="http://docs.oracle.com/javase/1.5.0/docs/guide/language/foreach.html" rel="noreferrer">`foreach` loop</a>, added in <a href="http://docs.oracle.com/javase/1.5.0/docs/guide/language/index.html" rel="noreferrer">Java 5</a> (also called the &quot;enhanced for loop&quot;), is equivalent to using a <a href="http://docs.oracle.com/javase/7/docs/api/java/util/Iterator.html" rel="noreferrer">`java.util.Iterator`</a>--it's syntactic sugar for the same thing. Therefore, when reading each element, one by one and in order, a `foreach` should always be chosen over an iterator, as it is more convenient and concise.  

<h5>foreach</h3>

```java
for(int i : intList) {
   System.out.println("An element in the list: " + i);
}
```

<h5>Iterator</h3>

```java
Iterator<Integer> intItr = intList.iterator();
while(intItr.hasNext()) {
   System.out.println("An element in the list: " + intItr.next());
}
```

There are situations where you must use an `Iterator` directly. For example, attempting to delete an element while using a `foreach` can (will?) result in a `ConcurrentModificationException`.  

<h5>`foreach` vs. `for`: Basic differences</h2>

The only practical difference between `for` and `foreach` is that, in the case of indexable objects, you do not have access to the index. An example when the basic `for` loop is required:  

```java
for(int i = 0; i < array.length; i++) {
   if(i < 5) {
      // Do something special
   }  else {
      // Do other stuff
   }
}
```

Although you could manually create a separate index int-variable with `foreach`,  

```java
int idx = -1;
for(int i : intArray) {
   idx++;
   ...
}
```

it is not recommended, since <a href="http://www.java-made-easy.com/variable-scope.html" rel="noreferrer">variable-scope</a> is not ideal, and the basic `for` loop is simply the standard and expected format for this use case.  

<h5>`foreach` vs. `for`: Performance</H2>

When accessing collections, a `foreach` is <a href="https://stackoverflow.com/questions/1879255/traditional-for-loop-vs-iterator-in-java">significantly faster</a> than the basic `for` loop's array access. When accessing arrays, however--at least with primitive and wrapper-arrays--access via indexes is dramatically faster.  

<h5>Timing the difference between iterator and index access for primitive int-arrays</h3>

Indexes are 23-<em>40</em> percent faster than iterators when accessing `int` or `Integer` arrays. Here is the output from the testing class at the bottom of this post, which sums the numbers in a 100-element primitive-int array (A is iterator, B is index):  

```java
[C:\java_code\]java TimeIteratorVsIndexIntArray 1000000
Test A: 358,597,622 nanoseconds
Test B: 269,167,681 nanoseconds
B faster by 89,429,941 nanoseconds (24.438799231635727% faster)

[C:\java_code\]java TimeIteratorVsIndexIntArray 1000000
Test A: 377,461,823 nanoseconds
Test B: 278,694,271 nanoseconds
B faster by 98,767,552 nanoseconds (25.666236154695838% faster)

[C:\java_code\]java TimeIteratorVsIndexIntArray 1000000
Test A: 288,953,495 nanoseconds
Test B: 207,050,523 nanoseconds
B faster by 81,902,972 nanoseconds (27.844689860906513% faster)

[C:\java_code\]java TimeIteratorVsIndexIntArray 1000000
Test A: 375,373,765 nanoseconds
Test B: 283,813,875 nanoseconds
B faster by 91,559,890 nanoseconds (23.891659337194227% faster)

[C:\java_code\]java TimeIteratorVsIndexIntArray 1000000
Test A: 375,790,818 nanoseconds
Test B: 220,770,915 nanoseconds
B faster by 155,019,903 nanoseconds (40.75164734599769% faster)

[C:\java_code\]java TimeIteratorVsIndexIntArray 1000000
Test A: 326,373,762 nanoseconds
Test B: 202,555,566 nanoseconds
B faster by 123,818,196 nanoseconds (37.437545972215744% faster)
```

I also ran this for an `Integer` array, and indexes are still the clear winner, but only between 18 and 25 percent faster.  

<h5>For collections, iterators are faster than indexes</h3>

For a `List` of `Integers`, however, iterators are the clear winner. Just change the int-array in the test-class to:  

```java
List<Integer> intList = Arrays.asList(new Integer[] {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100});
```

And make the necessary changes to the test-function (`int[]` to `List&lt;Integer&gt;`, `length` to `size()`, etc.):  

```java
[C:\java_code\]java TimeIteratorVsIndexIntegerList 1000000
Test A: 3,429,929,976 nanoseconds
Test B: 5,262,782,488 nanoseconds
A faster by 1,832,852,512 nanoseconds (34.326681820485675% faster)

[C:\java_code\]java TimeIteratorVsIndexIntegerList 1000000
Test A: 2,907,391,427 nanoseconds
Test B: 3,957,718,459 nanoseconds
A faster by 1,050,327,032 nanoseconds (26.038700083921256% faster)

[C:\java_code\]java TimeIteratorVsIndexIntegerList 1000000
Test A: 2,566,004,688 nanoseconds
Test B: 4,221,746,521 nanoseconds
A faster by 1,655,741,833 nanoseconds (38.71935684115413% faster)

[C:\java_code\]java TimeIteratorVsIndexIntegerList 1000000
Test A: 2,770,945,276 nanoseconds
Test B: 3,829,077,158 nanoseconds
A faster by 1,058,131,882 nanoseconds (27.134122749113843% faster)

[C:\java_code\]java TimeIteratorVsIndexIntegerList 1000000
Test A: 3,467,474,055 nanoseconds
Test B: 5,183,149,104 nanoseconds
A faster by 1,715,675,049 nanoseconds (32.60101667104192% faster)

[C:\java_code\]java TimeIteratorVsIndexIntList 1000000
Test A: 3,439,983,933 nanoseconds
Test B: 3,509,530,312 nanoseconds
A faster by 69,546,379 nanoseconds (1.4816434912159906% faster)

[C:\java_code\]java TimeIteratorVsIndexIntList 1000000
Test A: 3,451,101,466 nanoseconds
Test B: 5,057,979,210 nanoseconds
A faster by 1,606,877,744 nanoseconds (31.269164666060377% faster)
```

In one test they're almost equivalent, but with collections, iterator wins.  

*This post is based on two answers I wrote on Stack Overflow:  

<ul>
<li><p><em><a href="https://stackoverflow.com/questions/22110482/uses-and-syntax-for-for-each-loop-in-java/22110517#22110517">Uses and syntax for for-each loop in Java</a></em></p></li>
<li><p><em><a href="https://stackoverflow.com/questions/22540025/should-i-use-an-iterator-or-a-forloop-to-iterate/22540191#22540191">Should I use an Iterator or a forloop to iterate?</a></em></p></li>
</ul>

Some more information: <em><a href="https://stackoverflow.com/questions/2113216/which-is-more-efficient-a-for-each-loop-or-an-iterator">Which is more efficient, a for-each loop, or an iterator?</a></em>  

<h5>The full testing class</h3>

I created this compare-the-time-it-takes-to-do-any-two-things class after reading <a href="https://stackoverflow.com/questions/180158/how-do-i-time-a-methods-execution-in-java">this question</a> on Stack Overflow:  

```java
import  java.text.NumberFormat;
import  java.util.Locale;

/**
   &lt;P&gt;{@code java TimeIteratorVsIndexIntArray 1000000}&lt;/P&gt;

   @see  &lt;CODE&gt;&lt;A HREF="https://stackoverflow.com/questions/180158/how-do-i-time-a-methods-execution-in-java"&gt;https://stackoverflow.com/questions/180158/how-do-i-time-a-methods-execution-in-java&lt;/A&gt;&lt;/CODE&gt;
 **/
public class TimeIteratorVsIndexIntArray {

    public static final NumberFormat nf = NumberFormat.getNumberInstance(Locale.US);

    public static final void main(String[] tryCount_inParamIdx0) {
        int testCount;

        // Get try-count from a command-line parameter
        try {
           testCount = Integer.parseInt(tryCount_inParamIdx0[0]);
        }
        catch(ArrayIndexOutOfBoundsException | NumberFormatException x) {
           throw  new IllegalArgumentException("Missing or invalid command line parameter: The number of testCount for each test. " + x);
        }

        //Test proper...START
        int[] intArray = new int[] {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100};

        long lStart = System.nanoTime();
        for(int i = 0; i < testCount; i++) {
           testIterator(intArray);
        }

        long lADuration = outputGetNanoDuration("A", lStart);

        lStart = System.nanoTime();
        for(int i = 0; i < testCount; i++) {
           testFor(intArray);
        }

        long lBDuration = outputGetNanoDuration("B", lStart);

        outputGetABTestNanoDifference(lADuration, lBDuration, "A", "B");
    }

    private static final void testIterator(int[] int_array) {
       int total = 0;
       for(int i = 0; i < int_array.length; i++) {
          total += int_array[i];
       }
    }

    private static final void testFor(int[] int_array) {
       int total = 0;
       for(int i : int_array) {
          total += i;
       }
    }
    //Test proper...END

    //Timer testing utilities...START
    public static final long outputGetNanoDuration(String s_testName, long l_nanoStart) {
        long lDuration = System.nanoTime() - l_nanoStart;
        System.out.println("Test " + s_testName + ": " + nf.format(lDuration) + " nanoseconds");
        return  lDuration;
    }

    public static final long outputGetABTestNanoDifference(long l_aDuration, long l_bDuration, String s_aTestName, String s_bTestName) {
        long lDiff = -1;
        double dPct = -1.0;
        String sFaster = null;
        if(l_aDuration > l_bDuration) {
            lDiff = l_aDuration - l_bDuration;
            dPct = 100.00 - (l_bDuration * 100.0 / l_aDuration + 0.5);
            sFaster = "B";
        }
        else {
            lDiff = l_bDuration - l_aDuration;
            dPct = 100.00 - (l_aDuration * 100.0 / l_bDuration + 0.5);
            sFaster = "A";
        }
        System.out.println(sFaster + " faster by " + nf.format(lDiff) + " nanoseconds (" + dPct + "% faster)");
        return  lDiff;
   }

   //Timer testing utilities...END

}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: What does "Could not find or load main class" mean? (score [2477019](https://stackoverflow.com/q/18093928) in 2018)

#### Question
A common problem that new Java developers experience is that their programs fail to run with the error message:  `Could not find or load main class ...`  

What does this mean, what causes it, and how should you fix it?  

#### Answer accepted (score 1128)
<h5>The `java &lt;class-name&gt;` command syntax</h2>

First of all, you need to understand the correct way to launch a program using the `java` (or `javaw`) command.  

The normal syntax<sup>1</sup> is this:  

```java
    java [ <option> ... ] <class-name> [<argument> ...]
```

<p>where `&lt;option&gt;` is a command line option (starting with a "-" character), `&lt;class-name&gt;` is a fully qualified Java class name, and `&lt;argument&gt;` is an arbitrary command line argument that gets passed to your application.<br>
<sup>1 - There is a second syntax for "executable" JAR files which I will describe at the bottom.</sup></p>

The fully qualified name (FQN) for the class is conventionally written as you would in Java source code; e.g.  

```java
    packagename.packagename2.packagename3.ClassName
```

However some versions of the `java` command allow you to use slashes instead of periods; e.g.  

```java
    packagename/packagename2/packagename3/ClassName
```

which (confusingly) looks like a file pathname, but isn't one.  Note that the term <em>fully qualified name</em> is standard Java terminology ... not something I just made up to confuse you :-)  

Here is an example of what a `java` command should look like:  

```java
    java -Xmx100m com.acme.example.ListUsers fred joe bert
```

The above is going to cause the `java` command to do the following:  

<ol>
<li>Search for the compiled version of the `com.acme.example.ListUsers` class.</li>
<li>Load the class.</li>
<li>Check that the class has a `main` method with <em>signature</em>, <em>return type</em> and <em>modifiers</em> given by `public static void main(String[])`.  (Note, the method argument's name is <strong>NOT</strong> part of the signature.)</li>
<li>Call that method passing it the command line arguments ("fred", "joe", "bert") as a `String[]`.</li>
</ol>

<h5>Reasons why Java cannot find the class</h2>

When you get the message "Could not find or load main class ...", that means that the first step has failed.  The `java` command was not able to find the class.  And indeed, the "..." in the message will be the <em>fully qualified class name</em> that `java` is looking for.   

So why might it be unable to find the class?    

<h5>Reason #1 - you made a mistake with the classname argument</h2>

The first likely cause is that you may have provided the wrong class name.  (Or ... the right class name, but in the wrong form.)   Considering the example above, here a variety of <strong>wrong ways</strong> to specify the class name:  

<ul>
<li><p>Example #1 - a simple class name:</p>

```java
java ListUser
```

When the class is declared in a package such as `com.acme.example`, then you must use the full classname <em>including</em> the package name in the `java` command; e.g.   

```java
java com.acme.example.ListUser
```</li>
<li><p>Example #2 - a filename or pathname rather than a class name:</p>

```java
java ListUser.class
java com/acme/example/ListUser.class
```</li>
<li><p>Example #3 - a class name with the casing incorrect:</p>

```java
java com.acme.example.listuser
```</li>
<li><p>Example #4 - a typo</p>

```java
java com.acme.example.mistuser
```</li>
<li><p>Example #5 - a source filename</p>

```java
java ListUser.java
```</li>
<li><p>Example #6 - you forgot the class name entirely</p>

```java
java lots of arguments
```</li>
</ul>

<h5>Reason #2 - the application's classpath is incorrectly specified</h2>

The second likely cause is that the class name is correct, but that the `java` command cannot find the class.  To understand this, you need to understand the concept of the "classpath".  This is explained <em>well</em> by the Oracle documentation:  

<ul>
<li><a href="http://docs.oracle.com/javase/7/docs/technotes/tools/windows/java.html" rel="noreferrer">The `java` command documentation</a></li>
<li><a href="http://docs.oracle.com/javase/7/docs/technotes/tools/windows/classpath.html" rel="noreferrer">Setting the Classpath</a>. </li>
<li>The Java Tutorial - <a href="http://docs.oracle.com/javase/tutorial/essential/environment/paths.html" rel="noreferrer">PATH and CLASSPATH</a></li>
</ul>

So ... if you have specified the class name correctly, the next thing to check is that you have specified the classpath correctly:  

<ol>
<li>Read the three documents linked above.  (Yes ... READ them.  It is important that a Java programmer <em>understands</em> at least the basics of how the Java classpath mechanisms works.)</li>
<li>Look at command line and / or the CLASSPATH environment variable that is in effect when you run the `java` command.  Check that the directory names and JAR file names are correct.</li>
<li>If there are <em>relative</em> pathnames in the classpath, check that they resolve correctly ... from the current directory that is in effect when you run the `java` command.</li>
<li>Check that the class (mentioned in the error message) can be located on the <em>effective</em> classpath.</li>
<li>Note that the classpath syntax is <em>different</em> for Windows versus Linux and Mac OS. (The classpath separator is `;` on Windows and `:` on the others.  If you use the wrong separator for your platform, you won't get an explicit error message.  Instead, you will get a nonexistent file or directory on the path that will be silently ignored.)</li>
</ol>

<h5>Reason #2a - the wrong directory is on the classpath</h2>

When you put a directory on the classpath, it notionally corresponds to the root of the qualified name space.  Classes are located in the directory structure beneath that root, <em>by mapping the fully qualified name to a pathname</em>.  So for example, if "/usr/local/acme/classes" is on the class path, then when the JVM looks for a class called `com.acme.example.Foon`, it will look for a ".class" file with this pathname:  

```java
  /usr/local/acme/classes/com/acme/example/Foon.class
```

If you had put "/usr/local/acme/classes/com/acme/example" on the classpath, then the JVM wouldn't be able to find the class.  

<h5>Reason #2b - the subdirectory path doesn't match the FQN</h2>

If your classes FQN is `com.acme.example.Foon`, then the JVM is going to look for "Foon.class" in the directory "com/acme/example":  

<ul>
<li><p>If your directory structure doesn't match the package naming as per the pattern above, the JVM won't find your class.</p></li>
<li><p>If you attempt <em>rename</em> a class by moving it, that will fail as well ... but the exception stacktrace will be different.  It is liable to say something like this:</p>

```java
Caused by: java.lang.NoClassDefFoundError: <path> (wrong name: <name>)
```

because the FQN in the class file doesn't match what the class loader is expecting to find.  </li>
</ul>

To give a concrete example, supposing that:  

<ul>
<li>you want to run `com.acme.example.Foon` class,</li>
<li>the full file path is `/usr/local/acme/classes/com/acme/example/Foon.class`,</li>
<li>your current working directory is `/usr/local/acme/classes/com/acme/example/`,</li>
</ul>

then:  

```java
# wrong, FQN is needed
java Foon

# wrong, there is no `com/acme/example` folder in the current working directory
java com.acme.example.Foon

# wrong, similar to above
java -classpath . com.acme.example.Foon

# fine; relative classpath set
java -classpath ../../.. com.acme.example.Foon

# fine; absolute classpath set
java -classpath /usr/local/acme/classes com.acme.example.Foon
```

Notes:  

<ul>
<li>The `-classpath` option can be shortened to `-cp` in most Java releases.  Check the respective manual entries for `java`, `javac` and so on.</li>
<li>Think carefully when choosing between absolute and relative pathnames in classpaths.  Remember that a relative pathname may "break" if the current directory changes.  </li>
</ul>

<h5>Reason #2c - dependencies missing from the classpath</h2>

The classpath needs to include all of the <em>other</em> (non-system) classes that your application depends on.  (The system classes are located automatically, and you rarely need to concern yourself with this.)  For the main class to load correctly, the JVM needs to find:  

<ul>
<li>the class itself.</li>
<li>all classes and interfaces in the superclass hierarchy (e.g. see <a href="https://stackoverflow.com/questions/42880748">Java class is present in classpath but startup fails with Error: Could not find or load main class</a>)</li>
<li>all classes and interfaces that are referred to by means of variable or variable declarations, or method call or field access expressions.</li>
</ul>

(Note: the JLS and JVM specifications allow some scope for a JVM to load classes "lazily", and this can affect when a classloader exception is thrown.)  

<h5>Reason #3 - the class has been declared in the wrong package</h2>

<p>It occasionally happens that someone puts a source code file into the
the wrong folder in their source code tree, or they leave out the `package` declaration.  If you do this in an IDE, the IDE's compiler will tell you about this immediately.  Similarly if you use a decent Java build tool, the tool will run `javac` in a way that will detect the problem.  However, if you build your Java code by hand, you can do it in such a way that the compiler doesn't notice the problem, and the resulting ".class" file is not in the place that you expect it to be.</p>

<h5>Still can't find the problem?</h2>

There lots of things to check, and it is easy to miss something.  Try adding the `-Xdiag` option to the `java` command line (as the first thing after `java`).  It will output various things about class loading, and this may offer you clues as to what the real problem is.  

Also, consider possible problems caused by copying and pasting invisible or non-ASCII characters from websites, documents and so on.  And consider "homoglyphs", were two letters or symbols look the same ... but aren't.  

<hr>

<h5>The `java -jar &lt;jar file&gt;` syntax</h2>

The alternative syntax used for "executable" JAR files is as follows:  

```java
  java [ <option> ... ] -jar <jar-file-name> [<argument> ...]
```

e.g.  

```java
  java -Xmx100m -jar /usr/local/acme-example/listuser.jar fred
```

In this case the name of the entry-point class (i.e. `com.acme.example.ListUser`) and the classpath are specified in the MANIFEST of the JAR file.  

<hr>

<h5>IDEs</h2>

A typical Java IDE has support for running Java applications in the IDE JVM itself or in a child JVM.  These are <em>generally</em> immune from this particular exception, because the IDE uses its own mechanisms to construct the runtime classpath, identify the main class and create the `java` command line.  

However it is still possible for this exception to occur, if you do things behind the back of the IDE.  For example, if you have previously set up an Application Launcher for your Java app in Eclipse, and you then moved the JAR file containing the "main" class to a different place in the file system <em>without telling Eclipse</em>, Eclipse would unwittingly launch the JVM with an incorrect classpath.  

In short, if you get this problem in an IDE, check for things like stale IDE state, broken project references or broken launcher configurations.  

It is also possible for an IDE to simply get confused.  IDE's are hugely complicated pieces of software comprising many interacting parts.  Many of these parts adopt various caching strategies in order to make the IDE as a whole responsive.  These can sometimes go wrong, and one possible symptom is problems when launching applications.  If you suspect this could be happening, it is worth restarting your IDE.  

<hr>

<h5>Other References</h2>

<ul>
<li>From the Oracle Java Tutorials - <a href="http://docs.oracle.com/javase/tutorial/getStarted/problems/index.html" rel="noreferrer">Common Problems (and Their Solutions)</a></li>
</ul>

#### Answer 2 (score 228)
If your source code name is HelloWorld.java, your compiled code will be `HelloWorld.class`.  

You will get that error if you call it using:  

```java
java HelloWorld.class
```

Instead, use this:  

```java
java HelloWorld
```

#### Answer 3 (score 128)
<strong>If your classes are in packages</strong> then you have to `cd` to the root directory of your project and run using the fully qualified name of the class (packageName.MainClassName).  

Example:  

My classes are in here:  

```java
D:\project\com\cse\
```

The fully qualified name of my main class is:  

```java
com.cse.Main
```

So I `cd` back to the root project directory:  

```java
D:\project
```

Then issue the `java` command:  

```java
java com.cse.Main
```

<em>This answer is for rescuing newbie java programmers from the frustration caused by a common mistake, I recommend you read the accepted answer for more in depth knowledge about the java classpath.</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How do I efficiently iterate over each entry in a Java Map? (score [2356995](https://stackoverflow.com/q/46898) in 2019)

#### Question
If I have an object implementing the `Map` interface in Java and I wish to iterate over every pair contained within it, what is the most efficient way of going through the map?  

Will the ordering of elements depend on the specific map implementation that I have for the interface?  

#### Answer accepted (score 4782)
```java
Map<String, String> map = ...
for (Map.Entry<String, String> entry : map.entrySet()) {
    System.out.println(entry.getKey() + "/" + entry.getValue());
}
```

#### Answer 2 (score 1069)
To summarize the other answers and combine them with what I know, I found 10 main ways to do this (see below). Also, I wrote some performance tests (see results below). For example, if we want to find the sum of all of the keys and values of a map, we can write:  

<ol>
<li><p>Using <strong>iterator</strong> and <strong>Map.Entry</strong></p>

```java
long i = 0;
Iterator<Map.Entry<Integer, Integer>> it = map.entrySet().iterator();
while (it.hasNext()) {
    Map.Entry<Integer, Integer> pair = it.next();
    i += pair.getKey() + pair.getValue();
}
```</li>
<li><p>Using <strong>foreach</strong> and <strong>Map.Entry</strong></p>

```java
long i = 0;
for (Map.Entry<Integer, Integer> pair : map.entrySet()) {
    i += pair.getKey() + pair.getValue();
}
```</li>
<li><p>Using <strong>forEach</strong> from Java 8</p>

```java
final long[] i = {0};
map.forEach((k, v) -> i[0] += k + v);
```</li>
<li><p>Using <strong>keySet</strong> and <strong>foreach</strong></p>

```java
long i = 0;
for (Integer key : map.keySet()) {
    i += key + map.get(key);
}
```</li>
<li><p>Using <strong>keySet</strong> and <strong>iterator</strong></p>

```java
long i = 0;
Iterator<Integer> itr2 = map.keySet().iterator();
while (itr2.hasNext()) {
    Integer key = itr2.next();
    i += key + map.get(key);
}
```</li>
<li><p>Using <strong>for</strong> and <strong>Map.Entry</strong></p>

```java
long i = 0;
for (Iterator<Map.Entry<Integer, Integer>> entries = map.entrySet().iterator(); entries.hasNext(); ) {
    Map.Entry<Integer, Integer> entry = entries.next();
    i += entry.getKey() + entry.getValue();
}
```</li>
<li><p>Using the Java 8 <strong>Stream API</strong></p>

```java
final long[] i = {0};
map.entrySet().stream().forEach(e -> i[0] += e.getKey() + e.getValue());
```</li>
<li><p>Using the Java 8 <strong>Stream API parallel</strong></p>

```java
final long[] i = {0};
map.entrySet().stream().parallel().forEach(e -> i[0] += e.getKey() + e.getValue());
```</li>
<li><p>Using <strong>IterableMap</strong> of `Apache Collections`</p>

```java
long i = 0;
MapIterator<Integer, Integer> it = iterableMap.mapIterator();
while (it.hasNext()) {
    i += it.next() + it.getValue();
}
```</li>
<li><p>Using <strong>MutableMap</strong> of Eclipse (CS) collections</p>

```java
final long[] i = {0};
mutableMap.forEachKeyValue((key, value) -> {
    i[0] += key + value;
});
```</li>
</ol>

<strong>Perfomance tests</strong> (mode = AverageTime, system = Windows&nbsp;8.1 64-bit, Intel i7-4790 3.60 GHz, 16&nbsp;GB)  

<ol>
<li><p>For a small map (100 elements), score 0.308 is the best</p>

```java
Benchmark                          Mode  Cnt  Score    Error  Units
test3_UsingForEachAndJava8         avgt  10   0.308 ±  0.021  µs/op
test10_UsingEclipseMap             avgt  10   0.309 ±  0.009  µs/op
test1_UsingWhileAndMapEntry        avgt  10   0.380 ±  0.014  µs/op
test6_UsingForAndIterator          avgt  10   0.387 ±  0.016  µs/op
test2_UsingForEachAndMapEntry      avgt  10   0.391 ±  0.023  µs/op
test7_UsingJava8StreamApi          avgt  10   0.510 ±  0.014  µs/op
test9_UsingApacheIterableMap       avgt  10   0.524 ±  0.008  µs/op
test4_UsingKeySetAndForEach        avgt  10   0.816 ±  0.026  µs/op
test5_UsingKeySetAndIterator       avgt  10   0.863 ±  0.025  µs/op
test8_UsingJava8StreamApiParallel  avgt  10   5.552 ±  0.185  µs/op
```</li>
<li><p>For a map with 10000 elements,  score 37.606 is the best</p>

```java
Benchmark                           Mode   Cnt  Score      Error   Units
test10_UsingEclipseMap              avgt   10    37.606 ±   0.790  µs/op
test3_UsingForEachAndJava8          avgt   10    50.368 ±   0.887  µs/op
test6_UsingForAndIterator           avgt   10    50.332 ±   0.507  µs/op
test2_UsingForEachAndMapEntry       avgt   10    51.406 ±   1.032  µs/op
test1_UsingWhileAndMapEntry         avgt   10    52.538 ±   2.431  µs/op
test7_UsingJava8StreamApi           avgt   10    54.464 ±   0.712  µs/op
test4_UsingKeySetAndForEach         avgt   10    79.016 ±  25.345  µs/op
test5_UsingKeySetAndIterator        avgt   10    91.105 ±  10.220  µs/op
test8_UsingJava8StreamApiParallel   avgt   10   112.511 ±   0.365  µs/op
test9_UsingApacheIterableMap        avgt   10   125.714 ±   1.935  µs/op
```</li>
<li><p>For a map with 100000 elements,  score 1184.767 is the best</p>

```java
Benchmark                          Mode   Cnt  Score        Error    Units
test1_UsingWhileAndMapEntry        avgt   10   1184.767 ±   332.968  µs/op
test10_UsingEclipseMap             avgt   10   1191.735 ±   304.273  µs/op
test2_UsingForEachAndMapEntry      avgt   10   1205.815 ±   366.043  µs/op
test6_UsingForAndIterator          avgt   10   1206.873 ±   367.272  µs/op
test8_UsingJava8StreamApiParallel  avgt   10   1485.895 ±   233.143  µs/op
test5_UsingKeySetAndIterator       avgt   10   1540.281 ±   357.497  µs/op
test4_UsingKeySetAndForEach        avgt   10   1593.342 ±   294.417  µs/op
test3_UsingForEachAndJava8         avgt   10   1666.296 ±   126.443  µs/op
test7_UsingJava8StreamApi          avgt   10   1706.676 ±   436.867  µs/op
test9_UsingApacheIterableMap       avgt   10   3289.866 ±  1445.564  µs/op
```</li>
</ol>

Graphs (performance tests depending on map size)  

<a href="https://i.stack.imgur.com/17VGh.png" rel="noreferrer"><img src="https://i.stack.imgur.com/17VGh.png" alt="Enter image description here"></a>  

Table (perfomance tests depending on map size)  

```java
          100     600      1100     1600     2100
test10    0.333    1.631    2.752    5.937    8.024
test3     0.309    1.971    4.147    8.147   10.473
test6     0.372    2.190    4.470    8.322   10.531
test1     0.405    2.237    4.616    8.645   10.707
test2     0.376    2.267    4.809    8.403   10.910
test7     0.473    2.448    5.668    9.790   12.125
test9     0.565    2.830    5.952   13.220   16.965
test4     0.808    5.012    8.813   13.939   17.407
test5     0.810    5.104    8.533   14.064   17.422
test8     5.173   12.499   17.351   24.671   30.403
```

All tests are on <a href="https://github.com/Vedenin/useful-java-links/blob/master/helloworlds/5.0-other-examples/src/main/java/other_examples/IterateThroughHashMapTest.java" rel="noreferrer">GitHub</a>.  

#### Answer 3 (score 272)
In Java 8 you can do it clean and fast using the new lambdas features:  

```java
 Map<String,String> map = new HashMap<>();
 map.put("SomeKey", "SomeValue");
 map.forEach( (k,v) -> [do something with key and value] );

 // such as
 map.forEach( (k,v) -> System.out.println("Key: " + k + ": Value: " + v));
```

The type of `k` and `v` will be inferred by the compiler and there is no need to use `Map.Entry` anymore.  

Easy-peasy!  

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: What's the simplest way to print a Java array? (score [2123014](https://stackoverflow.com/q/409784) in 2019)

#### Question
In Java, arrays don't override `toString()`, so if you try to print one directly, you get the `className` + '@' + the hex of the <a href="https://en.wikipedia.org/wiki/Java_hashCode()" rel="noreferrer">`hashCode`</a> of the array, as defined by `Object.toString()`:  

```java
int[] intArray = new int[] {1, 2, 3, 4, 5};
System.out.println(intArray);     // prints something like '[I@3343c8b3'
```

But usually, we'd actually want something more like `[1, 2, 3, 4, 5]`. What's the simplest way of doing that? Here are some example inputs and outputs:  

```java
// Array of primitives:
int[] intArray = new int[] {1, 2, 3, 4, 5};
//output: [1, 2, 3, 4, 5]

// Array of object references:
String[] strArray = new String[] {"John", "Mary", "Bob"};
//output: [John, Mary, Bob]
```

#### Answer accepted (score 2448)
Since Java 5 you can use <a href="https://docs.oracle.com/javase/9/docs/api/java/util/Arrays.html#toString-int:A-" rel="noreferrer">`Arrays.toString(arr)`</a> or <a href="https://docs.oracle.com/javase/9/docs/api/java/util/Arrays.html#deepToString-java.lang.Object:A-" rel="noreferrer">`Arrays.deepToString(arr)`</a> for arrays within arrays. Note that the `Object[]` version calls `.toString()` on each object in the array. The output is even decorated in the exact way you're asking.  

Examples:  

<ul>
<li><h5>Simple Array:</h3>

```java
String[] array = new String[] {"John", "Mary", "Bob"};
System.out.println(Arrays.toString(array));
```

Output:  

```java
[John, Mary, Bob]
```</li>
<li><h5>Nested Array:</h3>

```java
String[][] deepArray = new String[][] {{"John", "Mary"}, {"Alice", "Bob"}};
System.out.println(Arrays.toString(deepArray));
//output: [[Ljava.lang.String;@106d69c, [Ljava.lang.String;@52e922]
System.out.println(Arrays.deepToString(deepArray));
```

Output:  

```java
[[John, Mary], [Alice, Bob]]
```</li>
<li><h5>`double` Array:</h3>

```java
double[] doubleArray = { 7.0, 9.0, 5.0, 1.0, 3.0 };
System.out.println(Arrays.toString(doubleArray));
```

Output:  

```java
[7.0, 9.0, 5.0, 1.0, 3.0 ]
```</li>
<li><h5>`int` Array:</h3>

```java
int[] intArray = { 7, 9, 5, 1, 3 };
System.out.println(Arrays.toString(intArray));
```

Output:   

```java
[7, 9, 5, 1, 3 ]
```</li>
</ul>

#### Answer 2 (score 340)
Always check the standard libraries first.  Try:  

```java
System.out.println(Arrays.toString(array));
```

or if your array contains other arrays as elements:  

```java
System.out.println(Arrays.deepToString(array));
```

#### Answer 3 (score 102)
This is nice to know, however, as for "always check the standard libraries first" I'd never have stumbled upon the trick of `Arrays.toString( myarray )`  

--since I was concentrating on the type of myarray to see how to do this. I didn't want to have to iterate through the thing: I wanted an easy call to make it come out similar to what I see in the Eclipse debugger and myarray.toString() just wasn't doing it.  

```java
import java.util.Arrays;
.
.
.
System.out.println( Arrays.toString( myarray ) );
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How do I read / convert an InputStream into a String in Java? (score [2007290](https://stackoverflow.com/q/309424) in 2019)

#### Question
If you have a `java.io.InputStream` object, how should you process that object and produce a `String`?  

<hr>

Suppose I have an `InputStream` that contains text data, and I want to convert it to a `String`, so for example I can write that to a log file.  

What is the easiest way to take the `InputStream` and convert it to a `String`?  

```java
public String convertStreamToString(InputStream is) {
    // ???
}
```

#### Answer accepted (score 2401)
A nice way to do this is using <a href="http://commons.apache.org/" rel="noreferrer">Apache commons</a> `<a href="https://commons.apache.org/proper/commons-io/javadocs/api-release/org/apache/commons/io/IOUtils.html" rel="noreferrer">IOUtils</a>` to copy the `InputStream` into a `StringWriter`... something like  

```java
StringWriter writer = new StringWriter();
IOUtils.copy(inputStream, writer, encoding);
String theString = writer.toString();
```

or even  

```java
// NB: does not close inputStream, you'll have to use try-with-resources for that
String theString = IOUtils.toString(inputStream, encoding); 
```

Alternatively, you could use `ByteArrayOutputStream` if you don't want to mix your Streams and Writers  

#### Answer 2 (score 2264)
Here's a way using only the standard Java library (note that the stream is not closed, your mileage may vary).  

```java
static String convertStreamToString(java.io.InputStream is) {
    java.util.Scanner s = new java.util.Scanner(is).useDelimiter("\\A");
    return s.hasNext() ? s.next() : "";
}
```

I learned this trick from <a href="https://community.oracle.com/blogs/pat/2004/10/23/stupid-scanner-tricks" rel="noreferrer">"Stupid Scanner tricks"</a> article. The reason it works is because <a href="http://download.oracle.com/javase/8/docs/api/java/util/Scanner.html" rel="noreferrer">Scanner</a> iterates over tokens in the stream, and in this case we separate tokens using "beginning of the input boundary" (\A), thus giving us only one token for the entire contents of the stream.  

<strong>Note, if you need to be specific about the input stream's encoding, you can provide the second argument to `Scanner` constructor that indicates what character set to use (e.g. "UTF-8").</strong>  

Hat tip goes also to <a href="https://stackoverflow.com/users/68127/jacob-gabrielson">Jacob</a>, who once pointed me to the said article.  

#### Answer 3 (score 2208)
Summarize other answers I found 11 main ways to do this (see below). And I wrote some performance tests (see results below):  

<strong>Ways to convert an InputStream to a String:</strong>  

<ol>
<li><p>Using `IOUtils.toString` (Apache Utils) </p>

```java
String result = IOUtils.toString(inputStream, StandardCharsets.UTF_8);
```</li>
<li><p>Using `CharStreams` (Guava) </p>

```java
String result = CharStreams.toString(new InputStreamReader(
      inputStream, Charsets.UTF_8));
```</li>
<li><p>Using `Scanner` (JDK) </p>

```java
Scanner s = new Scanner(inputStream).useDelimiter("\\A");
String result = s.hasNext() ? s.next() : "";
```</li>
<li><p>Using <strong>Stream API</strong> (Java 8). <strong>Warning</strong>: This solution converts different line breaks (like `\r\n`) to `\n`.</p>

```java
String result = new BufferedReader(new InputStreamReader(inputStream))
  .lines().collect(Collectors.joining("\n"));
```</li>
<li><p>Using <strong>parallel Stream API</strong> (Java 8). <strong>Warning</strong>: This solution converts different line breaks (like `\r\n`) to `\n`.    </p>

```java
String result = new BufferedReader(new InputStreamReader(inputStream)).lines()
   .parallel().collect(Collectors.joining("\n"));
```</li>
<li><p>Using `InputStreamReader` and `StringBuilder` (JDK) </p>

```java
final int bufferSize = 1024;
final char[] buffer = new char[bufferSize];
final StringBuilder out = new StringBuilder();
Reader in = new InputStreamReader(inputStream, "UTF-8");
for (; ; ) {
    int rsz = in.read(buffer, 0, buffer.length);
    if (rsz < 0)
        break;
    out.append(buffer, 0, rsz);
}
return out.toString();
```</li>
<li><p>Using `StringWriter` and `IOUtils.copy` (Apache Commons)</p>

```java
StringWriter writer = new StringWriter();
IOUtils.copy(inputStream, writer, "UTF-8");
return writer.toString();
```</li>
<li><p>Using `ByteArrayOutputStream` and `inputStream.read` (JDK)  </p>

```java
ByteArrayOutputStream result = new ByteArrayOutputStream();
byte[] buffer = new byte[1024];
int length;
while ((length = inputStream.read(buffer)) != -1) {
    result.write(buffer, 0, length);
}
// StandardCharsets.UTF_8.name() > JDK 7
return result.toString("UTF-8");
```</li>
<li><p>Using `BufferedReader` (JDK). <strong>Warning:</strong> This solution converts different line breaks (like `\n\r`) to `line.separator` system property (for example, in Windows to "\r\n").</p>

```java
String newLine = System.getProperty("line.separator");
BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
StringBuilder result = new StringBuilder();
boolean flag = false;
for (String line; (line = reader.readLine()) != null; ) {
    result.append(flag? newLine: "").append(line);
    flag = true;
}
return result.toString();
```</li>
<li><p>Using `BufferedInputStream` and `ByteArrayOutputStream` (JDK) </p>

```java
BufferedInputStream bis = new BufferedInputStream(inputStream);
ByteArrayOutputStream buf = new ByteArrayOutputStream();
int result = bis.read();
while(result != -1) {
    buf.write((byte) result);
    result = bis.read();
}
// StandardCharsets.UTF_8.name() > JDK 7
return buf.toString("UTF-8");
```</li>
<li><p>Using `inputStream.read()` and `StringBuilder` (JDK). <strong>Warning</strong>: This solution has problems with Unicode, for example with Russian text (works correctly only with non-Unicode text)</p>

```java
int ch;
StringBuilder sb = new StringBuilder();
while((ch = inputStream.read()) != -1)
    sb.append((char)ch);
reset();
return sb.toString();
```</li>
</ol>

<strong>Warning</strong>:  

<ol>
<li><p>Solutions 4, 5 and 9 convert different line breaks to one.</p></li>
<li><p>Solution 11 can't work correctly with Unicode text</p></li>
</ol>

<strong>Performance tests</strong>  

Performance tests for small `String` (length = 175), url in <a href="https://github.com/Vedenin/useful-java-links/blob/master/helloworlds/5.0-other-examples/src/main/java/other_examples/ConvertInputStreamToStringBenchmark.java" rel="noreferrer">github</a> (mode = Average Time, system = Linux, score 1,343 is the best):  

```java
              Benchmark                         Mode  Cnt   Score   Error  Units
 8. ByteArrayOutputStream and read (JDK)        avgt   10   1,343 ± 0,028  us/op
 6. InputStreamReader and StringBuilder (JDK)   avgt   10   6,980 ± 0,404  us/op
10. BufferedInputStream, ByteArrayOutputStream  avgt   10   7,437 ± 0,735  us/op
11. InputStream.read() and StringBuilder (JDK)  avgt   10   8,977 ± 0,328  us/op
 7. StringWriter and IOUtils.copy (Apache)      avgt   10  10,613 ± 0,599  us/op
 1. IOUtils.toString (Apache Utils)             avgt   10  10,605 ± 0,527  us/op
 3. Scanner (JDK)                               avgt   10  12,083 ± 0,293  us/op
 2. CharStreams (guava)                         avgt   10  12,999 ± 0,514  us/op
 4. Stream Api (Java 8)                         avgt   10  15,811 ± 0,605  us/op
 9. BufferedReader (JDK)                        avgt   10  16,038 ± 0,711  us/op
 5. parallel Stream Api (Java 8)                avgt   10  21,544 ± 0,583  us/op
```

Performance tests for big `String` (length = 50100), url in <a href="https://github.com/Vedenin/useful-java-links/blob/master/helloworlds/5.0-other-examples/src/main/java/other_examples/ConvertBigStringToInputStreamBenchmark.java" rel="noreferrer">github</a> (mode = Average Time, system = Linux, score 200,715 is the best):  

```java
               Benchmark                        Mode  Cnt   Score        Error  Units
 8. ByteArrayOutputStream and read (JDK)        avgt   10   200,715 ±   18,103  us/op
 1. IOUtils.toString (Apache Utils)             avgt   10   300,019 ±    8,751  us/op
 6. InputStreamReader and StringBuilder (JDK)   avgt   10   347,616 ±  130,348  us/op
 7. StringWriter and IOUtils.copy (Apache)      avgt   10   352,791 ±  105,337  us/op
 2. CharStreams (guava)                         avgt   10   420,137 ±   59,877  us/op
 9. BufferedReader (JDK)                        avgt   10   632,028 ±   17,002  us/op
 5. parallel Stream Api (Java 8)                avgt   10   662,999 ±   46,199  us/op
 4. Stream Api (Java 8)                         avgt   10   701,269 ±   82,296  us/op
10. BufferedInputStream, ByteArrayOutputStream  avgt   10   740,837 ±    5,613  us/op
 3. Scanner (JDK)                               avgt   10   751,417 ±   62,026  us/op
11. InputStream.read() and StringBuilder (JDK)  avgt   10  2919,350 ± 1101,942  us/op
```

<p>Graphs (performance tests depending on Input Stream length in Windows 7 system)<br>
<a href="https://i.stack.imgur.com/AYYhz.png" rel="noreferrer"><img src="https://i.stack.imgur.com/AYYhz.png" alt="enter image description here"></a></p>

Performance test (Average Time) depending on Input Stream length in Windows 7 system:  

```java
 length  182    546     1092    3276    9828    29484   58968

 test8  0.38    0.938   1.868   4.448   13.412  36.459  72.708
 test4  2.362   3.609   5.573   12.769  40.74   81.415  159.864
 test5  3.881   5.075   6.904   14.123  50.258  129.937 166.162
 test9  2.237   3.493   5.422   11.977  45.98   89.336  177.39
 test6  1.261   2.12    4.38    10.698  31.821  86.106  186.636
 test7  1.601   2.391   3.646   8.367   38.196  110.221 211.016
 test1  1.529   2.381   3.527   8.411   40.551  105.16  212.573
 test3  3.035   3.934   8.606   20.858  61.571  118.744 235.428
 test2  3.136   6.238   10.508  33.48   43.532  118.044 239.481
 test10 1.593   4.736   7.527   20.557  59.856  162.907 323.147
 test11 3.913   11.506  23.26   68.644  207.591 600.444 1211.545
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: What is the difference between public, protected, package-private and private in Java? (score [1981495](https://stackoverflow.com/q/215497) in 2018)

#### Question
In Java, are there clear rules on when to use each of access modifiers, namely the default (package private), `public`, `protected` and `private`, while making `class` and `interface` and dealing with inheritance?  

#### Answer accepted (score 5360)
<a href="http://docs.oracle.com/javase/tutorial/java/javaOO/accesscontrol.html" rel="noreferrer">The official tutorial</a> may be of some use to you.  

<pre>
______________________________________________________________
|           │ Class │ Package │ Subclass │ Subclass │ World  |
|           │       │         │(same pkg)│(diff pkg)│        |
|───────────┼───────┼─────────┼──────────┼──────────┼────────|
|public     │   +   │    +    │    +     │     +    │   +    | 
|───────────┼───────┼─────────┼──────────┼──────────┼────────|
|protected  │   +   │    +    │    +     │     +    │        | 
|───────────┼───────┼─────────┼──────────┼──────────┼────────|
|no modifier│   +   │    +    │    +     │          │        | 
|───────────┼───────┼─────────┼──────────┼──────────┼────────|
|private    │   +   │         │          │          │        |
|___________|_______|_________|__________|__________|________|
 + : accessible         blank : not accessible
</pre>

#### Answer 2 (score 442)
(Caveat:  I am not a Java programmer, I am a Perl programmer.  Perl has no formal protections which is perhaps why I understand the problem so well :) )  

<h5>Private</h2>

Like you'd think, only the <strong>class</strong> in which it is declared can see it.  

<h5>Package Private</h2>

Can only be seen and used by the <strong>package</strong> in which it was declared.  This is the default in Java (which some see as a mistake).  

<h5>Protected</h2>

Package Private + can be seen by subclasses or package member.  

<h5>Public</h2>

Everyone can see it.  

<h5><a href="http://martinfowler.com/ieeeSoftware/published.pdf" rel="noreferrer">Published</a></h2>

Visible outside the code I control.  (While not Java syntax, it is important for this discussion).  

C++ defines an additional level called "friend" and the less you know about that the better.  

When should you use what?  The whole idea is encapsulation to hide information.  As much as possible you want to hide the detail of how something is done from your users.  Why?  Because then you can change them later and not break anybody's code.  This lets you optimize, refactor, redesign and fix bugs without worry that someone was using that code you just overhauled.  

So, rule of thumb is to make things only as visible as they have to be.  Start with private and only add more visibility as needed.  Only make public that which is absolutely necessary for the user to know, every detail you make public cramps your ability to redesign the system.  

If you want users to be able to customize behaviors, rather than making internals public so they can override them, it's often a better idea to shove those guts into an object and make that interface public.  That way they can simply plug in a new object.  For example, if you were writing a CD player and wanted the "go find info about this CD" bit customizable, rather than make those methods public you'd put all that functionality into its own object and make just your object getter/setter public.  In this way being stingy about exposing your guts encourages good composition and separation of concerns  

Personally, I stick with just "private" and "public".  Many OO languages just have that.  "Protected" can be handy, but it's really a cheat.  Once an interface is more than private it's outside of your control and you have to go looking in other people's code to find uses.  

This is where the idea of "published" comes in.  Changing an interface (refactoring it) requires that you find all the code which is using it and change that, too.  If the interface is private, well no problem.  If it's protected you have to go find all your subclasses.  If it's public you have to go find all the code which uses your code.  Sometimes this is possible, for example if you're working on corporate code that's for internal use only it doesn't matter if an interface is public.  You can grab all the code out of the corporate repository.  But if an interface is "published", if there is code using it outside your control, then you're hosed.  You must support that interface or risk breaking code.  Even protected interfaces can be considered published (which is why I don't bother with protected).  

Many languages find the hierarchical nature of public/protected/private to be too limiting and not in line with reality.  To that end there is the concept of a <a href="http://en.wikipedia.org/wiki/Trait_class" rel="noreferrer">trait class</a>, but that's another show.  

#### Answer 3 (score 383)
<p>Here's a better version of the table. (Future proof with a column for modules.)
<br /><br /></p>

<a href="https://i.stack.imgur.com/niONO.png" rel="noreferrer"><img src="https://i.stack.imgur.com/niONO.png" alt="Java Access Modifiers"></a>  

<h5></h2>

<h5>Explanations</h2>

<ul>
<li><p>A <strong>private</strong> member (`i`) is <em>only</em> accessible within the same class as it is declared.</p></li>
<li><p>A member with <strong>no access modifier</strong> (`j`) is only accessible within classes in the same package.</p></li>
<li><p>A <strong>protected</strong> member (`k`) is accessible within all classes in the same package <em>and</em> within subclasses in other packages.</p></li>
<li><p>A <strong>public</strong> member (`l`) is accessible to all classes (unless it resides in a <a href="http://openjdk.java.net/projects/jigsaw/spec/sotms/" rel="noreferrer">module</a> that does not export the package it is declared in).</p></li>
</ul>

<hr>

<h5>Which modifier to choose?</h2>

Access modifiers is a tool to help you to prevent accidentally breaking encapsulation<sup>(*)</sup>. Ask yourself if you intend the member to be something that's internal to the class, package, class hierarchy or not internal at all, and choose access level accordingly.  

<strong>Examples:</strong>  

<ul>
<li>A field `long internalCounter` should probably be private since it's mutable and an implementation detail.</li>
<li>A class that should only be instantiated in a factory class (in the same package) should have a package restricted constructor, since it shouldn't be possible to call it directly from outside the package.</li>
<li>An internal `void beforeRender()` method called right before rendering and used as a hook in subclasses should be protected.</li>
<li>A `void saveGame(File dst)` method which is called from the GUI code should be public.</li>
</ul>

<sup>(*) <a href="https://stackoverflow.com/questions/28612420/what-is-encapsulation-exactly">What is Encapsulation exactly?</a></sup>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How do I determine whether an array contains a particular value in Java? (score [1869332](https://stackoverflow.com/q/1128723) in 2019)

#### Question
I have a `String[]` with values like so:  

```java
public static final String[] VALUES = new String[] {"AB","BC","CD","AE"};
```

Given `String s`, is there a good way of testing whether `VALUES` contains `s`?  

#### Answer accepted (score 2795)
```java
Arrays.asList(yourArray).contains(yourValue)
```

Warning: this doesn't work for arrays of primitives (see the comments).  

<hr>

<h5>Since <a href="/questions/tagged/java-8" class="post-tag" title="show questions tagged &#39;java-8&#39;" rel="tag">java-8</a> you can now use Streams.</h2>

```java
String[] values = {"AB","BC","CD","AE"};
boolean contains = Arrays.stream(values).anyMatch("s"::equals);
```

To check whether an array of `int`, `double` or `long` contains a value use `IntStream`, `DoubleStream` or `LongStream` respectively.  

<h5>Example</h2>

```java
int[] a = {1,2,3,4};
boolean contains = IntStream.of(a).anyMatch(x -> x == 4);
```

#### Answer 2 (score 344)
Just to clear the code up to start with. We have (corrected):  

```java
public static final String[] VALUES = new String[] {"AB","BC","CD","AE"};
```

This is a mutable static which FindBugs will tell you is very naughty. It should be private:  

```java
private static final String[] VALUES = new String[] {"AB","BC","CD","AE"};
```

(Note, you can actually drop the `new String[];` bit.)  

So, reference arrays are bad, and in particular here we want a set:  

```java
private static final Set<String> VALUES = new HashSet<String>(Arrays.asList(
     new String[] {"AB","BC","CD","AE"}
));
```

(Paranoid people, such as myself, may feel more at ease if this was wrapped in `Collections.unmodifiableSet` - it could even be made public.)  

"Given String s, is there a good way of testing whether VALUES contains s?"  

```java
VALUES.contains(s)
```

O(1).  

<strong>Update:</strong> Since Java SE 9 we have `Set.of`.  

```java
private static final Set<String> VALUES = Set.of(
    "AB","BC","CD","AE"
);
```

The <strong>right type</strong>, <strong>immutable</strong>, <strong>O(1)</strong> and <strong>concise</strong>. Beautiful.  

(To be a little more on brand, the collections API is predictably still missing immutable collection types and the syntax is still far too verbose, for my tastes.)  

#### Answer 3 (score 194)
You can use `ArrayUtils.contains` from <a href="https://commons.apache.org/proper/commons-lang/" rel="noreferrer">Apache Commons Lang</a>  

<a href="http://commons.apache.org/proper/commons-lang/javadocs/api-release/org/apache/commons/lang3/ArrayUtils.html#contains(java.lang.Object[],%20java.lang.Object)" rel="noreferrer">`public static boolean contains(Object[] array, Object objectToFind)`</a>  

Note that this method returns `false` if the passed array is `null`.  

There are also methods available for primitive arrays of all kinds.  

<h5>Example:</h3>

```java
String[] fieldsToInclude = { "id", "name", "location" };

if ( ArrayUtils.contains( fieldsToInclude, "id" ) ) {
    // Do some stuff.
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: Is Java "pass-by-reference" or "pass-by-value"? (score [1865334](https://stackoverflow.com/q/40480) in 2018)

#### Question
I always thought Java was <strong>pass-by-reference</strong>.  

However, I've seen a couple of blog posts (for example, <a href="http://javadude.com/articles/passbyvalue.htm" rel="noreferrer">this blog</a>) that claim that it isn't.  

I don't think I understand the distinction they're making.   

What is the explanation?  

#### Answer 2 (score 5522)
Java is always <strong>pass-by-value</strong>. Unfortunately, when we pass the value of an object, we are passing the <em>reference</em> to it.  This is confusing to beginners.  

It goes like this:  

```java
public static void main(String[] args) {
    Dog aDog = new Dog("Max");
    Dog oldDog = aDog;

    // we pass the object to foo
    foo(aDog);
    // aDog variable is still pointing to the "Max" dog when foo(...) returns
    aDog.getName().equals("Max"); // true
    aDog.getName().equals("Fifi"); // false
    aDog == oldDog; // true
}

public static void foo(Dog d) {
    d.getName().equals("Max"); // true
    // change d inside of foo() to point to a new Dog instance "Fifi"
    d = new Dog("Fifi");
    d.getName().equals("Fifi"); // true
}
```

In the example above `aDog.getName()` will still return `"Max"`. The value `aDog` within `main` is not changed in the function `foo` with the `Dog` `"Fifi"` as the object reference is passed by value. If it were passed by reference, then the `aDog.getName()` in `main` would return `"Fifi"` after the call to `foo`.  

Likewise:  

```java
public static void main(String[] args) {
    Dog aDog = new Dog("Max");
    Dog oldDog = aDog;

    foo(aDog);
    // when foo(...) returns, the name of the dog has been changed to "Fifi"
    aDog.getName().equals("Fifi"); // true
    // but it is still the same dog:
    aDog == oldDog; // true
}

public static void foo(Dog d) {
    d.getName().equals("Max"); // true
    // this changes the name of d to be "Fifi"
    d.setName("Fifi");
}
```

In the above example, `Fifi` is the dog's name after call to `foo(aDog)` because the object's name was set inside of `foo(...)`. Any operations that `foo` performs on `d` are such that, for all practical purposes, they are performed on `aDog`, but it is <strong>not</strong> possible to change the value of the variable `aDog` itself.  

#### Answer 3 (score 2916)
I just noticed you referenced <a href="http://javadude.com/articles/passbyvalue.htm" rel="noreferrer">my article</a>.  

The Java Spec says that everything in Java is pass-by-value. There is no such thing as "pass-by-reference" in Java.  

The key to understanding this is that something like  

```java
Dog myDog;
```

is <em>not</em> a Dog; it's actually a <em>pointer</em> to a Dog.  

What that means, is when you have  

```java
Dog myDog = new Dog("Rover");
foo(myDog);
```

you're essentially passing the <em>address</em> of the created `Dog` object to the `foo` method.  

(I say essentially because Java pointers aren't direct addresses, but it's easiest to think of them that way)  

Suppose the `Dog` object resides at memory address 42. This means we pass 42 to the method.  

if the Method were defined as  

```java
public void foo(Dog someDog) {
    someDog.setName("Max");     // AAA
    someDog = new Dog("Fifi");  // BBB
    someDog.setName("Rowlf");   // CCC
}
```

let's look at what's happening.  

<ul>
<li>the parameter `someDog` is set to the value 42</li>
<li>at line "AAA"

<ul>
<li>`someDog` is followed to the `Dog` it points to (the `Dog` object at address 42)</li>
<li>that `Dog` (the one at address 42) is asked to change his name to Max</li>
</ul></li>
<li>at line "BBB"

<ul>
<li>a new `Dog` is created. Let's say he's at address 74</li>
<li>we assign the parameter `someDog` to 74 </li>
</ul></li>
<li>at line "CCC"

<ul>
<li>someDog is followed to the `Dog` it points to (the `Dog` object at address 74)</li>
<li>that `Dog` (the one at address 74) is asked to change his name to Rowlf</li>
</ul></li>
<li>then, we return</li>
</ul>

Now let's think about what happens outside the method:  

<em>Did `myDog` change?</em>  

There's the key.  

Keeping in mind that `myDog` is a <em>pointer</em>, and not an actual `Dog`, the answer is NO. `myDog` still has the value 42; it's still pointing to the original `Dog` (but note that because of line "AAA", its name is now "Max" - still the same Dog; `myDog`'s value has not changed.)  

It's perfectly valid to <em>follow</em> an address and change what's at the end of it; that does not change the variable, however.  

Java works exactly like C. You can assign a pointer, pass the pointer to a method, follow the pointer in the method and change the data that was pointed to. However, you cannot change where that pointer points.  

In C++, Ada, Pascal and other languages that support pass-by-reference, you can actually change the variable that was passed.  

If Java had pass-by-reference semantics, the `foo` method we defined above would have changed where `myDog` was pointing when it assigned `someDog` on line BBB.  

Think of reference parameters as being aliases for the variable passed in. When that alias is assigned, so is the variable that was passed in.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How to fix java.lang.UnsupportedClassVersionError: Unsupported major.minor version (score [1810449](https://stackoverflow.com/q/10382929) in 2019)

#### Question
I am trying to use <a href="http://en.wikipedia.org/wiki/Notepad%2B%2B" rel="noreferrer">Notepad++</a> as my all-in-one tool edit, run, compile, etc.  

I have <a href="http://en.wikipedia.org/wiki/Java_Virtual_Machine#Execution_environment" rel="noreferrer">JRE</a> installed, and I have setup my path variable to the `.../bin` directory.  

When I run my "Hello world" in Notepad++, I get this message:  

```java
java.lang.UnsupportedClassVersionError: test_hello_world :
 Unsupported major.minor version 51.0
    at java.lang.ClassLoader.defineClass1(Native Method)
    at java.lang.ClassLoader.defineClassCond(Unknown Source)
       .........................................
```

I think the problem here is about versions; some versions of Java may be old or too new.  

<ol>
<li>How do I fix it?</li>
<li>Should I install the JDK, and setup my path variable to the JDK instead of JRE?</li>
<li>What is the difference between the `PATH` variable in JRE or JDK?</li>
</ol>

#### Answer accepted (score 1903)
The version number shown describes the version of the JRE the class file is compatible with.  

The reported major numbers are:  

```java
Java SE 13 = 57,
Java SE 12 = 56,
Java SE 11 = 55,
Java SE 10 = 54,
Java SE 9 = 53,
Java SE 8 = 52,
Java SE 7 = 51,
Java SE 6.0 = 50,
Java SE 5.0 = 49,
JDK 1.4 = 48,
JDK 1.3 = 47,
JDK 1.2 = 46,
JDK 1.1 = 45
```

(Source: <a href="https://en.wikipedia.org/wiki/Java_class_file#General_layout" rel="noreferrer">Wikipedia</a>)  

To fix the actual problem you should try to either run the Java code with a newer version of Java JRE or specify the target parameter to the Java compiler to instruct the compiler to create code compatible with earlier Java versions.   

For example, in order to generate class files compatible with Java 1.4, use the following command line:  

```java
javac -target 1.4 HelloWorld.java
```

With newer versions of the Java compiler you are likely to get a warning about the bootstrap class path not being set. More information about this error is available in a blog post <em><a href="https://blogs.oracle.com/darcy/entry/bootclasspath_older_source" rel="noreferrer">New javac warning for setting an older source without bootclasspath</a></em>.  

#### Answer 2 (score 356)
`java.lang.UnsupportedClassVersionError` happens because of a higher JDK during compile time and lower JDK during runtime.  

#### Answer 3 (score 114)
In Eclipse, I just went to menu command <em>Window</em> -> <em>Preferences</em> -> <em>Java</em> -> <em>Compiler</em> and then set "Compiler compliance level" to 1.6.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: How to round a number to n decimal places in Java (score [1530287](https://stackoverflow.com/q/153724) in 2017)

#### Question
What I would like is a method to convert a double to a string which rounds using the half-up method - i.e. if the decimal to be rounded is 5, it always rounds up to the previous number. This is the standard method of rounding most people expect in most situations.  

I also would like only significant digits to be displayed - i.e. there should not be any trailing zeroes.  

I know one method of doing this is to use the `String.format` method:  

```java
String.format("%.5g%n", 0.912385);
```

returns:  

```java
0.91239
```

which is great, however it always displays numbers with 5 decimal places even if they are not significant:   

```java
String.format("%.5g%n", 0.912300);
```

returns:  

```java
0.91230
```

Another method is to use the `DecimalFormatter`:  

```java
DecimalFormat df = new DecimalFormat("#.#####");
df.format(0.912385);
```

returns:  

```java
0.91238
```

However as you can see this uses half-even rounding. That is it will round down if the previous digit is even. What I'd like is this:  

```java
0.912385 -> 0.91239
0.912300 -> 0.9123
```

What is the best way to achieve this in Java?  

#### Answer accepted (score 715)
Use <a href="http://docs.oracle.com/javase/8/docs/api/java/text/DecimalFormat.html#setRoundingMode(java.math.RoundingMode)" rel="noreferrer">`setRoundingMode`</a>, set the <a href="http://docs.oracle.com/javase/8/docs/api/java/math/RoundingMode.html" rel="noreferrer">`RoundingMode`</a> explicitly to handle your issue with the half-even round, then use the format pattern for your required output.  

Example:  

```java
DecimalFormat df = new DecimalFormat("#.####");
df.setRoundingMode(RoundingMode.CEILING);
for (Number n : Arrays.asList(12, 123.12345, 0.23, 0.1, 2341234.212431324)) {
    Double d = n.doubleValue();
    System.out.println(df.format(d));
}
```

gives the output:  

```java
12
123.1235
0.23
0.1
2341234.2125
```

#### Answer 2 (score 452)
Assuming `value` is a `double`, you can do:  

```java
(double)Math.round(value * 100000d) / 100000d
```

That's for 5 digits precision. The number of zeros indicate the number of decimals.  

#### Answer 3 (score 186)
```java
new BigDecimal(String.valueOf(double)).setScale(yourScale, BigDecimal.ROUND_HALF_UP);
```

will get you a `BigDecimal`.  To get the string out of it, just call that `BigDecimal`'s `toString` method, or the `toPlainString` method for Java 5+ for a plain format string.    

Sample program:    

```java
package trials;
import java.math.BigDecimal;

public class Trials {

    public static void main(String[] args) {
        int yourScale = 10;
        System.out.println(BigDecimal.valueOf(0.42344534534553453453-0.42324534524553453453).setScale(yourScale, BigDecimal.ROUND_HALF_UP));
    }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Convert ArrayList<String> to String[] array (score [1474844](https://stackoverflow.com/q/5374311) in 2018)

#### Question
I'm working in the android environment and have tried the following code, but it doesn't seem to be working.  

```java
String [] stockArr = (String[]) stock_list.toArray();
```

If I define as follows:  

```java
String [] stockArr = {"hello", "world"};
```

it works. Is there something that I'm missing?  

#### Answer accepted (score 1722)
Use like this.  

```java
List<String> stockList = new ArrayList<String>();
stockList.add("stock1");
stockList.add("stock2");

String[] stockArr = new String[stockList.size()];
stockArr = stockList.toArray(stockArr);

for(String s : stockArr)
    System.out.println(s);
```

#### Answer 2 (score 930)
Try this  

```java
String[] arr = list.toArray(new String[list.size()]);
```

#### Answer 3 (score 300)
What is happening is that `stock_list.toArray()` is creating an `Object[]` rather than a `String[]` and hence the typecast is failing<sup>1</sup>.  

The correct code would be:  

```java
  String [] stockArr = stockList.toArray(new String[stockList.size()]);
```

or even  

```java
  String [] stockArr = stockList.toArray(new String[0]);
```

For more details, refer to the javadocs for the two overloads of `List.toArray`.  

The latter version uses the zero-length array to determine the type of the result array.  (Surprisingly, it is faster to do this than to preallocate ... at least, for recent Java releases.  See <a href="https://stackoverflow.com/a/4042464/139985">https://stackoverflow.com/a/4042464/139985</a> for details.)  

From a technical perspective, the reason for this API behavior / design is that an implementation of the `List&lt;T&gt;.toArray()` method has no information of what the `&lt;T&gt;` is at runtime.  All it knows is that the raw element type is `Object`.  By contrast, in the other case, the array parameter gives the base type of the array.  (If the supplied array is big enough to hold the list elements, it is used.  Otherwise a new array of the same type and a larger size is allocated and returned as the result.)  

<hr>

<sup>1 - In Java, an `Object[]` is not assignment compatible with a `String[]`.  If it was, then you could do this:</sup>  

```java
    Object[] objects = new Object[]{new Cat("fluffy")};
    Dog[] dogs = (Dog[]) objects;
    Dog d = dogs[0];     // Huh???
```

<sup>This is clearly nonsense, and that is why array types are not generally assignment compatible.</sup>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Differences between HashMap and Hashtable? (score [1473992](https://stackoverflow.com/q/40471) in 2019)

#### Question
What are the differences between a <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/HashMap.html" rel="noreferrer">`HashMap`</a> and a <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Hashtable.html" rel="noreferrer">`Hashtable`</a> in Java?  

Which is more efficient for non-threaded applications?  

#### Answer accepted (score 3615)
There are several differences between <a href="http://java.sun.com/javase/7/docs/api/java/util/HashMap.html" rel="noreferrer">`HashMap`</a> and <a href="http://java.sun.com/javase/7/docs/api/java/util/Hashtable.html" rel="noreferrer">`Hashtable`</a> in Java:  

<ol>
<li><p>`Hashtable` is <a href="https://stackoverflow.com/questions/1085709/what-does-synchronized-mean">synchronized</a>, whereas `HashMap` is not. This makes `HashMap` better for non-threaded applications, as unsynchronized Objects typically perform better than synchronized ones.</p></li>
<li><p>`Hashtable` does not allow `null` keys or values.  `HashMap` allows one `null` key and any number of `null` values.</p></li>
<li><p>One of HashMap's subclasses is <a href="http://java.sun.com/javase/7/docs/api/java/util/LinkedHashMap.html" rel="noreferrer">`LinkedHashMap`</a>, so in the event that you'd want predictable iteration order (which is insertion order by default), you could easily swap out the `HashMap` for a `LinkedHashMap`.  This wouldn't be as easy if you were using `Hashtable`.</p></li>
</ol>

Since synchronization is not an issue for you, I'd recommend `HashMap`. If synchronization becomes an issue, you may also look at <a href="http://docs.oracle.com/javase/7/docs/api/java/util/concurrent/ConcurrentHashMap.html" rel="noreferrer">`ConcurrentHashMap`</a>.  

#### Answer 2 (score 644)
Note, that a lot of the answers state that Hashtable is synchronised.  <strong>In practice this buys you very little.</strong>  The synchronization is on the accessor / mutator methods will stop two threads adding or removing from the map concurrently, but in the real world you will often need additional synchronisation.  

A very common idiom is to "check then put" — i.e. look for an entry in the `Map`, and add it if it does not already exist. This is not in any way an atomic operation whether you use `Hashtable` or `HashMap`.  

An equivalently synchronised `HashMap` can be obtained by:  

```java
Collections.synchronizedMap(myMap);
```

But to correctly implement this logic you need <strong>additional synchronisation</strong> of the form:  

```java
synchronized(myMap) {
    if (!myMap.containsKey("tomato"))
        myMap.put("tomato", "red");
}
```

Even iterating over a `Hashtable`'s entries (or a `HashMap` obtained by `Collections.synchronizedMap`) is not thread safe unless you also guard the `Map` from being modified through additional synchronization.  

Implementations of the <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/ConcurrentMap.html" rel="noreferrer">`ConcurrentMap`</a> interface (for example <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/ConcurrentHashMap.html" rel="noreferrer">`ConcurrentHashMap`</a>) solve some of this by including <strong>thread safe check-then-act semantics</strong> such as:  

```java
ConcurrentMap.putIfAbsent(key, value);
```

#### Answer 3 (score 338)
`Hashtable` is considered legacy code. There's nothing about `Hashtable` that can't be done using `HashMap` or derivations of `HashMap`, so for new code, I don't see any justification for going back to `Hashtable`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: Create ArrayList from array (score [1422325](https://stackoverflow.com/q/157944) in 2016)

#### Question
I have an array that is initialized like:  

```java
Element[] array = {new Element(1), new Element(2), new Element(3)};
```

I would like to convert this array into an object of the ArrayList class.  

```java
ArrayList<Element> arraylist = ???;
```

#### Answer accepted (score 4407)
```java
new ArrayList<>(Arrays.asList(array))
```

#### Answer 2 (score 865)
Given:  

```java
Element[] array = new Element[] { new Element(1), new Element(2), new Element(3) };
```

The simplest answer is to do:  

```java
List<Element> list = Arrays.asList(array);
```

This will work fine.  But some caveats:  

<ol>
<li>The list returned from asList has <strong>fixed size</strong>.  So, if you want to be able to add or remove elements from the returned list in your code, you'll need to wrap it in a new `ArrayList`.  Otherwise you'll get an `UnsupportedOperationException`.</li>
<li>The list returned from `asList()` is backed by the original array.  If you modify the original array, the list will be modified as well.  This may be surprising. </li>
</ol>

#### Answer 3 (score 332)
<em><sup>(old thread, but just 2 cents as none mention Guava or other libs and some other details)</sup></em>  

<h5>If You Can, Use Guava</h1>

It's worth pointing out the Guava way, which greatly simplifies these shenanigans:  

<h5>Usage</h2>

<h5>For an Immutable List</h3>

Use the <a href="https://github.com/google/guava/blob/master/guava/src/com/google/common/collect/ImmutableList.java" rel="noreferrer">`ImmutableList`</a> class and its <a href="https://github.com/google/guava/blob/master/guava/src/com/google/common/collect/ImmutableList.java#L101" rel="noreferrer">`of()`</a> and <a href="https://github.com/google/guava/blob/master/guava/src/com/google/common/collect/ImmutableList.java#L225" rel="noreferrer">`copyOf()`</a> factory methods <sup>(elements can't be null)</sup>:  

```java
List<String> il = ImmutableList.of("string", "elements");  // from varargs
List<String> il = ImmutableList.copyOf(aStringArray);      // from array
```

<h5>For A Mutable List</h3>

Use the <a href="https://github.com/google/guava/blob/master/guava/src/com/google/common/collect/Lists.java" rel="noreferrer">`Lists`</a> class and its <a href="https://github.com/google/guava/blob/master/guava/src/com/google/common/collect/Lists.java#L87" rel="noreferrer">`newArrayList()`</a> factory methods:  

```java
List<String> l1 = Lists.newArrayList(anotherListOrCollection);    // from collection
List<String> l2 = Lists.newArrayList(aStringArray);               // from array
List<String> l3 = Lists.newArrayList("or", "string", "elements"); // from varargs
```

Please also note the similar methods for other data structures in other classes, for instance in <a href="https://github.com/google/guava/blob/master/guava/src/com/google/common/collect/Sets.java" rel="noreferrer">`Sets`</a>.  

<h5><a href="http://code.google.com/p/guava-libraries/wiki/GuavaExplained" rel="noreferrer">Why Guava?</a></h2>

The main attraction could be to reduce the clutter due to generics for type-safety, as the use of the Guava <a href="http://code.google.com/p/guava-libraries/wiki/CollectionUtilitiesExplained#Static_constructors" rel="noreferrer">factory methods</a> allow the types to be inferred most of the time. However, this argument holds less water since Java 7 arrived with the new diamond operator.  

But it's not the only reason (and Java 7 isn't everywhere yet): the shorthand syntax is also very handy, and the methods initializers, as seen above, allow to write more expressive code. You do in one Guava call what takes 2 with the current Java Collections.  

<hr>

<h5>If You Can't...</h1>

<h5>For an Immutable List</h2>

Use the JDK's <a href="http://docs.oracle.com/javase/7/docs/api/java/util/Arrays.html" rel="noreferrer">`Arrays`</a> class and its <a href="http://docs.oracle.com/javase/7/docs/api/java/util/Arrays.html#asList%28T...%29" rel="noreferrer">`asList()`</a> factory method, wrapped with a <a href="http://docs.oracle.com/javase/7/docs/api/java/util/Collections.html#unmodifiableList%28java.util.List%29" rel="noreferrer">`Collections.unmodifiableList()`</a>:  

```java
List<String> l1 = Collections.unmodifiableList(Arrays.asList(anArrayOfElements));
List<String> l2 = Collections.unmodifiableList(Arrays.asList("element1", "element2"));
```

Note that the returned type for `asList()` is a `List` using a concrete `ArrayList` implementation, but <strong>it is NOT</strong> `java.util.ArrayList`. It's an inner type, which emulates an `ArrayList` but actually directly references the passed array and makes it "write through" (modifications are reflected in the array).  

It forbids modifications through some of the `List` API's methods by way of simply extending an `AbstractList` (so, adding or removing elements is unsupported), however it allows calls to `set()` to override elements. Thus this list isn't truly immutable and a call to `asList()` should be wrapped with `Collections.unmodifiableList()`.  

See the next step if you need a mutable list.  

<h5>For a Mutable List</h2>

Same as above, but wrapped with an actual `java.util.ArrayList`:  

```java
List<String> l1  = new ArrayList<String>(Arrays.asList(array));    // Java 1.5 to 1.6
List<String> l1b = new ArrayList<>(Arrays.asList(array));          // Java 1.7+
List<String> l2  = new ArrayList<String>(Arrays.asList("a", "b")); // Java 1.5 to 1.6
List<String> l2b = new ArrayList<>(Arrays.asList("a", "b"));       // Java 1.7+
```

<hr>

<h5>For Educational Purposes: The Good ol' Manual Way</h1>

```java
// for Java 1.5+
static <T> List<T> arrayToList(final T[] array) {
  final List<T> l = new ArrayList<T>(array.length);

  for (final T s : array) {
    l.add(s);
  }
  return (l);
}

// for Java < 1.5 (no generics, no compile-time type-safety, boo!)
static List arrayToList(final Object[] array) {
  final List l = new ArrayList(array.length);

  for (int i = 0; i < array.length; i++) {
    l.add(array[i]);
  }
  return (l);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Why is processing a sorted array faster than processing an unsorted array? (score [1410048](https://stackoverflow.com/q/11227809) in 2019)

#### Question
Here is a piece of C++ code that shows some very peculiar behavior. For some strange reason, sorting the data miraculously makes the code almost six times faster:  

```java
#include <algorithm>
#include <ctime>
#include <iostream>

int main()
{
    // Generate data
    const unsigned arraySize = 32768;
    int data[arraySize];

    for (unsigned c = 0; c < arraySize; ++c)
        data[c] = std::rand() % 256;

    // !!! With this, the next loop runs faster.
    std::sort(data, data + arraySize);

    // Test
    clock_t start = clock();
    long long sum = 0;

    for (unsigned i = 0; i < 100000; ++i)
    {
        // Primary loop
        for (unsigned c = 0; c < arraySize; ++c)
        {
            if (data[c] >= 128)
                sum += data[c];
        }
    }

    double elapsedTime = static_cast<double>(clock() - start) / CLOCKS_PER_SEC;

    std::cout << elapsedTime << std::endl;
    std::cout << "sum = " << sum << std::endl;
}
```

<ul>
<li>Without `std::sort(data, data + arraySize);`, the code runs in 11.54 seconds.</li>
<li>With the sorted data, the code runs in 1.93 seconds.</li>
</ul>

<hr>

Initially, I thought this might be just a language or compiler anomaly, so I tried Java:  

```java
import java.util.Arrays;
import java.util.Random;

public class Main
{
    public static void main(String[] args)
    {
        // Generate data
        int arraySize = 32768;
        int data[] = new int[arraySize];

        Random rnd = new Random(0);
        for (int c = 0; c < arraySize; ++c)
            data[c] = rnd.nextInt() % 256;

        // !!! With this, the next loop runs faster
        Arrays.sort(data);

        // Test
        long start = System.nanoTime();
        long sum = 0;

        for (int i = 0; i < 100000; ++i)
        {
            // Primary loop
            for (int c = 0; c < arraySize; ++c)
            {
                if (data[c] >= 128)
                    sum += data[c];
            }
        }

        System.out.println((System.nanoTime() - start) / 1000000000.0);
        System.out.println("sum = " + sum);
    }
}
```

With a similar but less extreme result.  

<hr>

My first thought was that sorting brings the data into the cache, but then I thought how silly that was because the array was just generated.  

<ul>
<li>What is going on?</li>
<li>Why is processing a sorted array faster than processing an unsorted array?</li>
</ul>

The code is summing up some independent terms, so the order should not matter.                         

#### Answer accepted (score 30765)
<strong>You are a victim of <a href="//en.wikipedia.org/wiki/Branch_predictor" rel="noreferrer">branch prediction</a> fail.</strong>  

<hr>

<h5>What is Branch Prediction?</h2>

Consider a railroad junction:  

<p><a href="//commons.wikimedia.org/wiki/File:Entroncamento_do_Transpraia.JPG" rel="noreferrer"><img src="https://i.stack.imgur.com/muxnt.jpg" alt="Image showing a railroad junction"></a>
<sub><a href="//commons.wikimedia.org/wiki/File:Entroncamento_do_Transpraia.JPG" rel="noreferrer">Image</a> by Mecanismo, via Wikimedia Commons. Used under the <a href="//creativecommons.org/licenses/by-sa/3.0/deed.en" rel="noreferrer">CC-By-SA 3.0</a> license.</sub></p>

Now for the sake of argument, suppose this is back in the 1800s - before long distance or radio communication.  

You are the operator of a junction and you hear a train coming. You have no idea which way it is supposed to go. You stop the train to ask the driver which direction they want. And then you set the switch appropriately.  

<em>Trains are heavy and have a lot of inertia. So they take forever to start up and slow down.</em>  

Is there a better way? You guess which direction the train will go!  

<ul>
<li>If you guessed right, it continues on.</li>
<li>If you guessed wrong, the captain will stop, back up, and yell at you to flip the switch. Then it can restart down the other path.</li>
</ul>

<p><strong>If you guess right every time</strong>, the train will never have to stop. <br/>
<strong>If you guess wrong too often</strong>, the train will spend a lot of time stopping, backing up, and restarting.</p>

<hr>

<strong>Consider an if-statement:</strong> At the processor level, it is a branch instruction:  

<img src="https://i.stack.imgur.com/pyfwC.png" alt="Screenshot of compiled code containing an if statement">  

You are a processor and you see a branch. You have no idea which way it will go. What do you do? You halt execution and wait until the previous instructions are complete. Then you continue down the correct path.  

<em>Modern processors are complicated and have long pipelines. So they take forever to "warm up" and "slow down".</em>  

Is there a better way? You guess which direction the branch will go!  

<ul>
<li>If you guessed right, you continue executing.</li>
<li>If you guessed wrong, you need to flush the pipeline and roll back to the branch. Then you can restart down the other path.</li>
</ul>

<p><strong>If you guess right every time</strong>, the execution will never have to stop. <br/>
<strong>If you guess wrong too often</strong>, you spend a lot of time stalling, rolling back, and restarting.</p>

<hr>

This is branch prediction. I admit it's not the best analogy since the train could just signal the direction with a flag. But in computers, the processor doesn't know which direction a branch will go until the last moment.  

So how would you strategically guess to minimize the number of times that the train must back up and go down the other path? You look at the past history! If the train goes left 99% of the time, then you guess left. If it alternates, then you alternate your guesses. If it goes one way every three times, you guess the same...  

<strong><em>In other words, you try to identify a pattern and follow it.</em></strong> This is more or less how branch predictors work.  

Most applications have well-behaved branches. So modern branch predictors will typically achieve >90% hit rates. But when faced with unpredictable branches with no recognizable patterns, branch predictors are virtually useless.  

Further reading: <a href="//en.wikipedia.org/wiki/Branch_predictor" rel="noreferrer">"Branch predictor" article on Wikipedia</a>.  

<hr>

<h5>As hinted from above, the culprit is this if-statement:</h2>

```java
if (data[c] >= 128)
    sum += data[c];
```

Notice that the data is evenly distributed between 0 and 255. When the data is sorted, roughly the first half of the iterations will not enter the if-statement. After that, they will all enter the if-statement.  

This is very friendly to the branch predictor since the branch consecutively goes the same direction many times. Even a simple saturating counter will correctly predict the branch except for the few iterations after it switches direction.  

<strong>Quick visualization:</strong>  

```java
T = branch taken
N = branch not taken

data[] = 0, 1, 2, 3, 4, ... 126, 127, 128, 129, 130, ... 250, 251, 252, ...
branch = N  N  N  N  N  ...   N    N    T    T    T  ...   T    T    T  ...

       = NNNNNNNNNNNN ... NNNNNNNTTTTTTTTT ... TTTTTTTTTT  (easy to predict)
```

However, when the data is completely random, the branch predictor is rendered useless, because it can't predict random data. Thus there will probably be around 50% misprediction (no better than random guessing).  

```java
data[] = 226, 185, 125, 158, 198, 144, 217, 79, 202, 118,  14, 150, 177, 182, 133, ...
branch =   T,   T,   N,   T,   T,   T,   T,  N,   T,   N,   N,   T,   T,   T,   N  ...

       = TTNTTTTNTNNTTTN ...   (completely random - hard to predict)
```

<hr>

<strong>So what can be done?</strong>  

If the compiler isn't able to optimize the branch into a conditional move, you can try some hacks if you are willing to sacrifice readability for performance.  

Replace:  

```java
if (data[c] >= 128)
    sum += data[c];
```

with:  

```java
int t = (data[c] - 128) >> 31;
sum += ~t & data[c];
```

This eliminates the branch and replaces it with some bitwise operations.  

<sub>(Note that this hack is not strictly equivalent to the original if-statement. But in this case, it's valid for all the input values of `data[]`.)</sub>  

<strong>Benchmarks: Core i7 920 @ 3.5 GHz</strong>  

C++ - Visual Studio 2010 - x64 Release  

```java
//  Branch - Random
seconds = 11.777

//  Branch - Sorted
seconds = 2.352

//  Branchless - Random
seconds = 2.564

//  Branchless - Sorted
seconds = 2.587
```

Java - NetBeans 7.1.1 JDK 7 - x64  

```java
//  Branch - Random
seconds = 10.93293813

//  Branch - Sorted
seconds = 5.643797077

//  Branchless - Random
seconds = 3.113581453

//  Branchless - Sorted
seconds = 3.186068823
```

Observations:  

<ul>
<li><strong>With the Branch:</strong> There is a huge difference between the sorted and unsorted data.</li>
<li><strong>With the Hack:</strong> There is no difference between sorted and unsorted data.</li>
<li>In the C++ case, the hack is actually a tad slower than with the branch when the data is sorted.</li>
</ul>

A general rule of thumb is to avoid data-dependent branching in critical loops (such as in this example).  

<hr>

<strong>Update:</strong>  

<ul>
<li><p>GCC 4.6.1 with `-O3` or `-ftree-vectorize` on x64 is able to generate a conditional move. So there is no difference between the sorted and unsorted data - both are fast.</p></li>
<li><p>VC++ 2010 is unable to generate conditional moves for this branch even under `/Ox`.</p></li>
<li><p><a href="https://en.wikipedia.org/wiki/Intel_C%2B%2B_Compiler" rel="noreferrer">Intel C++ Compiler</a> (ICC) 11 does something miraculous. It <a href="https://en.wikipedia.org/wiki/Loop_interchange" rel="noreferrer">interchanges the two loops</a>, thereby hoisting the unpredictable branch to the outer loop. So not only is it immune the mispredictions, it is also twice as fast as whatever VC++ and GCC can generate! In other words, ICC took advantage of the test-loop to defeat the benchmark...</p></li>
<li><p>If you give the Intel compiler the branchless code, it just out-right vectorizes it... and is just as fast as with the branch (with the loop interchange).</p></li>
</ul>

This goes to show that even mature modern compilers can vary wildly in their ability to optimize code...  

#### Answer 2 (score 3958)
<strong>Branch prediction.</strong>  

With a sorted array, the condition `data[c] &gt;= 128` is first `false` for a streak of values, then becomes `true` for all later values. That's easy to predict. With an unsorted array, you pay for the branching cost.  

#### Answer 3 (score 3198)
The reason why performance improves drastically when the data is sorted is that the branch prediction penalty is removed, as explained beautifully in <a href="https://stackoverflow.com/questions/11227809/why-is-it-faster-to-process-a-sorted-array-than-an-unsorted-array/11227902#11227902">Mysticial's answer</a>.  

Now, if we look at the code  

```java
if (data[c] >= 128)
    sum += data[c];
```

we can find that the meaning of this particular `if... else...` branch is to add something when a condition is satisfied. This type of branch can be easily transformed into a <strong>conditional move</strong> statement, which would be compiled into a conditional move instruction: `cmovl`, in an `x86` system. The branch and thus the potential branch prediction penalty is removed.  

In `C`, thus `C++`, the statement, which would compile directly (without any optimization) into the conditional move instruction in `x86`, is the ternary operator `... ? ... : ...`. So we rewrite the above statement into an equivalent one:  

```java
sum += data[c] >=128 ? data[c] : 0;
```

While maintaining readability, we can check the speedup factor.  

On an Intel <a href="http://en.wikipedia.org/wiki/Intel_Core#Core_i7" rel="noreferrer">Core i7</a>-2600K @ 3.4&nbsp;GHz and Visual Studio 2010 Release Mode, the benchmark is (format copied from Mysticial):  

<strong>x86</strong>  

```java
//  Branch - Random
seconds = 8.885

//  Branch - Sorted
seconds = 1.528

//  Branchless - Random
seconds = 3.716

//  Branchless - Sorted
seconds = 3.71
```

<strong>x64</strong>  

```java
//  Branch - Random
seconds = 11.302

//  Branch - Sorted
 seconds = 1.830

//  Branchless - Random
seconds = 2.736

//  Branchless - Sorted
seconds = 2.737
```

The result is robust in multiple tests. We get a great speedup when the branch result is unpredictable, but we suffer a little bit when it is predictable. In fact, when using a conditional move, the performance is the same regardless of the data pattern.  

Now let's look more closely by investigating the `x86` assembly they generate. For simplicity, we use two functions `max1` and `max2`.  

`max1` uses the conditional branch `if... else ...`:  

```java
int max1(int a, int b) {
    if (a > b)
        return a;
    else
        return b;
}
```

`max2` uses the ternary operator `... ? ... : ...`:  

```java
int max2(int a, int b) {
    return a > b ? a : b;
}
```

On a x86-64 machine, `GCC -S` generates the assembly below.  

```java
:max1
    movl    %edi, -4(%rbp)
    movl    %esi, -8(%rbp)
    movl    -4(%rbp), %eax
    cmpl    -8(%rbp), %eax
    jle     .L2
    movl    -4(%rbp), %eax
    movl    %eax, -12(%rbp)
    jmp     .L4
.L2:
    movl    -8(%rbp), %eax
    movl    %eax, -12(%rbp)
.L4:
    movl    -12(%rbp), %eax
    leave
    ret

:max2
    movl    %edi, -4(%rbp)
    movl    %esi, -8(%rbp)
    movl    -4(%rbp), %eax
    cmpl    %eax, -8(%rbp)
    cmovge  -8(%rbp), %eax
    leave
    ret
```

`max2` uses much less code due to the usage of instruction `cmovge`. But the real gain is that `max2` does not involve branch jumps, `jmp`, which would have a significant performance penalty if the predicted result is not right.  

So why does a conditional move perform better?  

In a typical `x86` processor, the execution of an instruction is divided into several stages. Roughly, we have different hardware to deal with different stages. So we do not have to wait for one instruction to finish to start a new one. This is called <strong><a href="http://en.wikipedia.org/wiki/Pipeline_%28computing%29" rel="noreferrer">pipelining</a></strong>.  

In a branch case, the following instruction is determined by the preceding one, so we cannot do pipelining. We have to either wait or predict.  

In a conditional move case, the execution conditional move instruction is divided into several stages, but the earlier stages like `Fetch` and `Decode` does not depend on the result of the previous instruction; only latter stages need the result. Thus, we wait a fraction of one instruction's execution time. This is why the conditional move version is slower than the branch when prediction is easy.  

The book <em><a href="https://rads.stackoverflow.com/amzn/click/com/0136108040" rel="noreferrer" rel="nofollow noreferrer">Computer Systems: A Programmer's Perspective, second edition</a></em> explains this in detail. You can check Section 3.6.6 for <em>Conditional Move Instructions</em>, entire Chapter 4 for <em>Processor Architecture</em>, and Section 5.11.2 for a special treatment for <em>Branch Prediction and Misprediction Penalties</em>.  

Sometimes, some modern compilers can optimize our code to assembly with better performance, sometimes some compilers can't (the code in question is using Visual Studio's native compiler). Knowing the performance difference between branch and conditional move when unpredictable can help us write code with better performance when the scenario gets so complex that the compiler can not optimize them automatically.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How to generate a random alpha-numeric string? (score [1334589](https://stackoverflow.com/q/41107) in 2019)

#### Question
I've been looking for a <em>simple</em> Java algorithm to generate a pseudo-random alpha-numeric string.  In my situation it would be used as a unique session/key identifier that would "likely" be unique over `500K+` generation (my needs don't really require anything much more sophisticated).    

Ideally, I would be able to specify a length depending on my uniqueness needs. For example, a generated string of length 12 might look something like `"AEYGF7K0DM1X"`.    

#### Answer accepted (score 1507)
<h5>Algorithm</h2>

To generate a random string, concatenate characters drawn randomly from the set of acceptable symbols until the string reaches the desired length.  

<h5>Implementation</h2>

Here's some fairly simple and very flexible code for generating random identifiers. <em>Read the information that follows</em> for important application notes.  

```java
import java.security.SecureRandom;
import java.util.Locale;
import java.util.Objects;
import java.util.Random;

public class RandomString {

    /**
     * Generate a random string.
     */
    public String nextString() {
        for (int idx = 0; idx < buf.length; ++idx)
            buf[idx] = symbols[random.nextInt(symbols.length)];
        return new String(buf);
    }

    public static final String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    public static final String lower = upper.toLowerCase(Locale.ROOT);

    public static final String digits = "0123456789";

    public static final String alphanum = upper + lower + digits;

    private final Random random;

    private final char[] symbols;

    private final char[] buf;

    public RandomString(int length, Random random, String symbols) {
        if (length < 1) throw new IllegalArgumentException();
        if (symbols.length() < 2) throw new IllegalArgumentException();
        this.random = Objects.requireNonNull(random);
        this.symbols = symbols.toCharArray();
        this.buf = new char[length];
    }

    /**
     * Create an alphanumeric string generator.
     */
    public RandomString(int length, Random random) {
        this(length, random, alphanum);
    }

    /**
     * Create an alphanumeric strings from a secure generator.
     */
    public RandomString(int length) {
        this(length, new SecureRandom());
    }

    /**
     * Create session identifiers.
     */
    public RandomString() {
        this(21);
    }

}
```

<h5>Usage examples</h2>

Create an insecure generator for 8-character identifiers:  

```java
RandomString gen = new RandomString(8, ThreadLocalRandom.current());
```

Create a secure generator for session identifiers:  

```java
RandomString session = new RandomString();
```

Create a generator with easy-to-read codes for printing. The strings are longer than full alphanumeric strings to compensate for using fewer symbols:  

```java
String easy = RandomString.digits + "ACEFGHJKLMNPQRUVWXYabcdefhijkprstuvwx";
RandomString tickets = new RandomString(23, new SecureRandom(), easy);
```

<h5>Use as session identifiers</h2>

Generating session identifiers that are likely to be unique is not good enough, or you could just use a simple counter. Attackers hijack sessions when predictable identifiers are used.  

There is tension between length and security. Shorter identifiers are easier to guess, because there are fewer possibilities. But longer identifiers consume more storage and bandwidth. A larger set of symbols helps, but might cause encoding problems if identifiers are included in URLs or re-entered by hand.  

The underlying source of randomness, or entropy, for session identifiers should come from a random number generator designed for cryptography. However, initializing these generators can sometimes be computationally expensive or slow, so effort should be made to re-use them when possible.  

<h5>Use as object identifiers</h2>

Not every application requires security. Random assignment can be an efficient way for multiple entities to generate identifiers in a shared space without any coordination or partitioning. Coordination can be slow, especially in a clustered or distributed environment, and splitting up a space causes problems when entities end up with shares that are too small or too big.  

Identifiers generated without taking measures to make them unpredictable should be protected by other means if an attacker might be able to view and manipulate them, as happens in most web applications. There should be a separate authorization system that protects objects whose identifier can be guessed by an attacker without access permission.  

Care must be also be taken to use identifiers that are long enough to make collisions unlikely given the anticipated total number of identifiers. This is referred to as "the birthday paradox." <a href="https://en.wikipedia.org/wiki/Birthday_problem#Square_approximation" rel="noreferrer">The probability of a collision,</a> <em>p</em>, is approximately n<sup>2</sup>/(2q<sup>x</sup>), where <em>n</em> is the number of identifiers actually generated, <em>q</em> is the number of distinct symbols in the alphabet, and <em>x</em> is the length of the identifiers. This should be a very small number, like 2<sup>&#8209;50</sup> or less.  

Working this out shows that the chance of collision among 500k 15-character identifiers is about 2<sup>&#8209;52</sup>, which is probably less likely than undetected errors from cosmic rays, etc.  

<h5>Comparison with UUIDs</h2>

According to their specification, UUIDs are not designed to be unpredictable, and <em>should not</em> be used as session identifiers.  

UUIDs in their standard format take a lot of space: 36 characters for only 122 bits of entropy. (Not all bits of a "random" UUID are selected randomly.) A randomly chosen alphanumeric string packs more entropy in just 21 characters.  

UUIDs are not flexible; they have a standardized structure and layout. This is their chief virtue as well as their main weakness. When collaborating with an outside party, the standardization offered by UUIDs may be helpful. For purely internal use, they can be inefficient.  

#### Answer 2 (score 792)
Java supplies a way of doing this directly. If you don't want the dashes, they are easy to strip out. Just use `uuid.replace("-", "")`  

```java
import java.util.UUID;

public class randomStringGenerator {
    public static void main(String[] args) {
        System.out.println(generateString());
    }

    public static String generateString() {
        String uuid = UUID.randomUUID().toString();
        return "uuid = " + uuid;
    }
}
```

<strong>Output:</strong>  

```java
uuid = 2d7428a6-b58c-4008-8575-f05549f16316
```

#### Answer 3 (score 530)
```java
static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
static SecureRandom rnd = new SecureRandom();

String randomString( int len ){
   StringBuilder sb = new StringBuilder( len );
   for( int i = 0; i < len; i++ ) 
      sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
   return sb.toString();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: Sort a Map<Key, Value> by values (score [1327878](https://stackoverflow.com/q/109383) in 2018)

#### Question
I am relatively new to Java, and often find that I need to sort a `Map&lt;Key, Value&gt;` on the values.  

Since the values are not unique, I find myself converting the `keySet` into an `array`, and sorting that array through <strong>array sort</strong> with a <strong>custom comparator</strong> that sorts on the value associated with the key.  

Is there an easier way?  

#### Answer 2 (score 865)
Here's a generic-friendly version:  

```java
public class MapUtil {
    public static <K, V extends Comparable<? super V>> Map<K, V> sortByValue(Map<K, V> map) {
        List<Entry<K, V>> list = new ArrayList<>(map.entrySet());
        list.sort(Entry.comparingByValue());

        Map<K, V> result = new LinkedHashMap<>();
        for (Entry<K, V> entry : list) {
            result.put(entry.getKey(), entry.getValue());
        }

        return result;
    }
}
```

#### Answer 3 (score 410)
<h5>Important note:</h3>

<strong>This code can break in multiple ways.</strong> If you intend to use the code provided, be sure to read the comments as well to be aware of the implications. For example, values can no longer be retrieved by their key. (`get` always returns `null`.)  

<hr>

It seems much easier than all of the foregoing. Use a TreeMap as follows:  

```java
public class Testing {
    public static void main(String[] args) {
        HashMap<String, Double> map = new HashMap<String, Double>();
        ValueComparator bvc = new ValueComparator(map);
        TreeMap<String, Double> sorted_map = new TreeMap<String, Double>(bvc);

        map.put("A", 99.5);
        map.put("B", 67.4);
        map.put("C", 67.4);
        map.put("D", 67.3);

        System.out.println("unsorted map: " + map);
        sorted_map.putAll(map);
        System.out.println("results: " + sorted_map);
    }
}

class ValueComparator implements Comparator<String> {
    Map<String, Double> base;

    public ValueComparator(Map<String, Double> base) {
        this.base = base;
    }

    // Note: this comparator imposes orderings that are inconsistent with
    // equals.
    public int compare(String a, String b) {
        if (base.get(a) >= base.get(b)) {
            return -1;
        } else {
            return 1;
        } // returning 0 would merge keys
    }
}
```

Output:  

```java
unsorted map: {D=67.3, A=99.5, B=67.4, C=67.4}
results: {D=67.3, B=67.4, C=67.4, A=99.5}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How do I create a Java string from the contents of a file? (score [1307219](https://stackoverflow.com/q/326390) in 2018)

#### Question
I've been using the idiom below for some time now. And it seems to be the most wide-spread, at least on the sites I've visited.  

Is there a better/different way to read a file into a string in Java?  

```java
private String readFile(String file) throws IOException {
    BufferedReader reader = new BufferedReader(new FileReader (file));
    String         line = null;
    StringBuilder  stringBuilder = new StringBuilder();
    String         ls = System.getProperty("line.separator");

    try {
        while((line = reader.readLine()) != null) {
            stringBuilder.append(line);
            stringBuilder.append(ls);
        }

        return stringBuilder.toString();
    } finally {
        reader.close();
    }
}
```

#### Answer 2 (score 1443)
<h5>Read all text from a file</h2>

Java 11 added the <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/nio/file/Files.html#readString(java.nio.file.Path,java.nio.charset.Charset)" rel="noreferrer">readString()</a> method to read small files as a `String`, preserving line terminators:  

```java
String content = Files.readString(path, StandardCharsets.US_ASCII);
```

For versions between Java 7 and 11, here's a compact, robust idiom, wrapped up in a utility method:  

```java
static String readFile(String path, Charset encoding) 
  throws IOException 
{
  byte[] encoded = Files.readAllBytes(Paths.get(path));
  return new String(encoded, encoding);
}
```

<h5>Read lines of text from a file</h2>

Java 7 added a <a href="http://docs.oracle.com/javase/7/docs/api/java/nio/file/Files.html#readAllLines%28java.nio.file.Path,%20java.nio.charset.Charset%29" rel="noreferrer">convenience method to read a file as lines of text,</a> represented as a `List&lt;String&gt;`. This approach is "lossy" because the line separators are stripped from the end of each line.  

```java
List<String> lines = Files.readAllLines(Paths.get(path), encoding);
```

Java 8 added the <a href="https://docs.oracle.com/javase/8/docs/api/java/nio/file/Files.html#lines-java.nio.file.Path-java.nio.charset.Charset-" rel="noreferrer">`Files.lines()`</a> method to produce a `Stream&lt;String&gt;`. Again, this method is lossy because line separators are stripped. If an `IOException` is encountered while reading the file, it is wrapped in an <a href="https://docs.oracle.com/javase/8/docs/api/java/io/UncheckedIOException.html" rel="noreferrer">`UncheckedIOException`</a>, since `Stream` doesn't accept lambdas that throw checked exceptions.  

```java
try (Stream<String> lines = Files.lines(path, encoding)) {
  lines.forEach(System.out::println);
}
```

This `Stream` does need a <a href="https://docs.oracle.com/javase/8/docs/api/java/util/stream/BaseStream.html#close--" rel="noreferrer">`close()`</a> call; this is poorly documented on the API, and I suspect many people don't even notice `Stream` has a `close()` method. Be sure to use an ARM-block as shown.  

If you are working with a source other than a file, you can use the <a href="https://docs.oracle.com/javase/8/docs/api/java/io/BufferedReader.html#lines--" rel="noreferrer">`lines()`</a> method in `BufferedReader` instead.  

<h5>Memory utilization</h2>

The first method, that preserves line breaks, can temporarily require memory several times the size of the file, because for a short time the raw file contents (a byte array), and the decoded characters (each of which is 16 bits even if encoded as 8 bits in the file) reside in memory at once. It is safest to apply to files that you know to be small relative to the available memory.  

The second method, reading lines, is usually more memory efficient, because the input byte buffer for decoding doesn't need to contain the entire file. However, it's still not suitable for files that are very large relative to available memory.  

For reading large files, you need a different design for your program, one that reads a chunk of text from a stream, processes it, and then moves on to the next, reusing the same fixed-sized memory block. Here, "large" depends on the computer specs. Nowadays, this threshold might be many gigabytes of RAM. The third method, using a `Stream&lt;String&gt;` is one way to do this, if your input "records" happen to be individual lines. (Using the `readLine()` method of `BufferedReader` is the procedural equivalent to this approach.)  

<h5>Character encoding</h2>

One thing that is missing from the sample in the original post is the character encoding. There are some special cases where the platform default is what you want, but they are rare, and you should be able justify your choice.  

The <a href="http://docs.oracle.com/javase/7/docs/api/java/nio/charset/StandardCharsets.html" rel="noreferrer">`StandardCharsets`</a> class define some constants for the encodings required of all Java runtimes:  

```java
String content = readFile("test.txt", StandardCharsets.UTF_8);
```

The platform default is available from <a href="http://docs.oracle.com/javase/7/docs/api/java/nio/charset/Charset.html#defaultCharset%28%29" rel="noreferrer">the `Charset` class</a> itself:  

```java
String content = readFile("test.txt", Charset.defaultCharset());
```

<hr>

Note: This answer largely replaces my Java 6 version. The utility of Java 7 safely simplifies the code, and the old answer, which used a mapped byte buffer, prevented the file that was read from being deleted until the mapped buffer was garbage collected. You can view the old version via the "edited" link on this answer.  

#### Answer 3 (score 330)
If you're willing to use an external library, check out <a href="https://commons.apache.org/proper/commons-io/" rel="noreferrer">Apache Commons IO</a> (200KB JAR). It contains an <a href="https://commons.apache.org/proper/commons-io/javadocs/api-release/org/apache/commons/io/FileUtils.html#readFileToString-java.io.File-java.nio.charset.Charset-" rel="noreferrer">`org.apache.commons.io.FileUtils.readFileToString()`</a> method that allows you to read an entire `File` into a `String` with one line of code.  

Example:  

```java
import java.io.*;
import java.nio.charset.*;
import org.apache.commons.io.*;

public String readFile() throws IOException {
    File file = new File("data.txt");
    return FileUtils.readFileToString(file, StandardCharsets.UTF_8);
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: How can I create an executable JAR with dependencies using Maven? (score [1210754](https://stackoverflow.com/q/574594) in 2018)

#### Question
I want to package my project in a single executable JAR for distribution.  

How can I make a Maven project package all dependency JARs into my output JAR?  

#### Answer accepted (score 2196)


```java
<build>
  <plugins>
    <plugin>
      <artifactId>maven-assembly-plugin</artifactId>
      <configuration>
        <archive>
          <manifest>
            <mainClass>fully.qualified.MainClass</mainClass>
          </manifest>
        </archive>
        <descriptorRefs>
          <descriptorRef>jar-with-dependencies</descriptorRef>
        </descriptorRefs>
      </configuration>
    </plugin>
  </plugins>
</build>
```

and you run it with  

```java
mvn clean compile assembly:single
```

<em>Compile goal should be added before assembly:single or otherwise the code on your own project is not included.</em>  

See more details in comments.  

<hr>

Commonly this goal is tied to a build phase to execute automatically. This ensures the JAR is built when executing `mvn install` or performing a deployment/release.  

```java
<plugin>
  <artifactId>maven-assembly-plugin</artifactId>
  <configuration>
    <archive>
      <manifest>
        <mainClass>fully.qualified.MainClass</mainClass>
      </manifest>
    </archive>
    <descriptorRefs>
      <descriptorRef>jar-with-dependencies</descriptorRef>
    </descriptorRefs>
  </configuration>
  <executions>
    <execution>
      <id>make-assembly</id> <!-- this is used for inheritance merges -->
      <phase>package</phase> <!-- bind to the packaging phase -->
      <goals>
        <goal>single</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

#### Answer 2 (score 331)
You can use the dependency-plugin to generate all dependencies in a separate directory before the package phase and then include that in the classpath of the manifest:  

```java
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-dependency-plugin</artifactId>
    <executions>
        <execution>
            <id>copy-dependencies</id>
            <phase>prepare-package</phase>
            <goals>
                <goal>copy-dependencies</goal>
            </goals>
            <configuration>
                <outputDirectory>${project.build.directory}/lib</outputDirectory>
                <overWriteReleases>false</overWriteReleases>
                <overWriteSnapshots>false</overWriteSnapshots>
                <overWriteIfNewer>true</overWriteIfNewer>
            </configuration>
        </execution>
    </executions>
</plugin>
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-jar-plugin</artifactId>
    <configuration>
        <archive>
            <manifest>
                <addClasspath>true</addClasspath>
                <classpathPrefix>lib/</classpathPrefix>
                <mainClass>theMainClass</mainClass>
            </manifest>
        </archive>
    </configuration>
</plugin>
```

Alternatively use `${project.build.directory}/classes/lib` as OutputDirectory to integrate all jar-files into the main jar, but then you will need to add custom classloading code to load the jars.  

#### Answer 3 (score 195)
I blogged about some different ways to do this.  

See <a href="http://jinahya.wordpress.com/2014/05/22/executable-jar-with-apache-maven/" rel="noreferrer">Executable Jar with Apache Maven</a> (WordPress)  

or <a href="https://github.com/jinahya/executable-jar-with-maven-example" rel="noreferrer">executable-jar-with-maven-example</a> (GitHub)  

<h5>Notes</h2>

Those pros and cons are provided by <a href="https://stackoverflow.com/users/363573/stephan">Stephan</a>.  

<hr>

<h5>For Manual Deployment</h2>

<ul>
<li>Pros</li>
<li>Cons

<ul>
<li>Dependencies are out of the final jar.</li>
</ul></li>
</ul>

<h5>Copy Dependencies to a specific directory</h3>

```java
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-dependency-plugin</artifactId>
  <executions>
    <execution>
      <id>copy-dependencies</id>
      <phase>prepare-package</phase>
      <goals>
        <goal>copy-dependencies</goal>
      </goals>
      <configuration>
        <outputDirectory>${project.build.directory}/${project.build.finalName}.lib</outputDirectory>
      </configuration>
    </execution>
  </executions>
</plugin>
```

<h5>Make the Jar Executable and Classpath Aware</h3>

```java
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-jar-plugin</artifactId>
  <configuration>
    <archive>
      <manifest>
        <addClasspath>true</addClasspath>
        <classpathPrefix>${project.build.finalName}.lib/</classpathPrefix>
        <mainClass>${fully.qualified.main.class}</mainClass>
      </manifest>
    </archive>
  </configuration>
</plugin>
```

At this point the `jar` is actually executable with external classpath elements.  

```java
$ java -jar target/${project.build.finalName}.jar
```

<h5>Make Deployable Archives</h3>

<p>The `jar` file is only executable with the sibling `...lib/` directory. We need to make archives to deploy with the directory and its content.


```java
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-antrun-plugin</artifactId>
  <executions>
    <execution>
      <id>antrun-archive</id>
      <phase>package</phase>
      <goals>
        <goal>run</goal>
      </goals>
      <configuration>
        <target>
          <property name="final.name" value="${project.build.directory}/${project.build.finalName}"/>
          <property name="archive.includes" value="${project.build.finalName}.${project.packaging} ${project.build.finalName}.lib/*"/>
          <property name="tar.destfile" value="${final.name}.tar"/>
          <zip basedir="${project.build.directory}" destfile="${final.name}.zip" includes="${archive.includes}" />
          <tar basedir="${project.build.directory}" destfile="${tar.destfile}" includes="${archive.includes}" />
          <gzip src="${tar.destfile}" destfile="${tar.destfile}.gz" />
          <bzip2 src="${tar.destfile}" destfile="${tar.destfile}.bz2" />
        </target>
      </configuration>
    </execution>
  </executions>
</plugin>
```

Now you have `target/${project.build.finalName}.(zip|tar|tar.bz2|tar.gz)` which each contains the `jar` and `lib/*`.  

<hr>

<h5>Apache Maven Assembly Plugin</h2>

<ul>
<li>Pros</li>
<li>Cons

<ul>
<li>No class relocation support (use maven-shade-plugin if class relocation is needed).</li>
</ul></li>
</ul>

```java
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-assembly-plugin</artifactId>
  <executions>
    <execution>
      <phase>package</phase>
      <goals>
        <goal>single</goal>
      </goals>
      <configuration>
        <archive>
          <manifest>
            <mainClass>${fully.qualified.main.class}</mainClass>
          </manifest>
        </archive>
        <descriptorRefs>
          <descriptorRef>jar-with-dependencies</descriptorRef>
        </descriptorRefs>
      </configuration>
    </execution>
  </executions>
</plugin>
```

You have `target/${project.bulid.finalName}-jar-with-dependencies.jar`.  

<hr>

<h5>Apache Maven Shade Plugin</h2>

<ul>
<li>Pros</li>
<li>Cons</li>
</ul>

```java
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-shade-plugin</artifactId>
  <executions>
    <execution>
      <goals>
        <goal>shade</goal>
      </goals>
      <configuration>
        <shadedArtifactAttached>true</shadedArtifactAttached>
        <transformers>
          <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
            <mainClass>${fully.qualified.main.class}</mainClass>
          </transformer>
        </transformers>
      </configuration>
    </execution>
  </executions>
</plugin>
```

You have `target/${project.build.finalName}-shaded.jar`.  

<hr>

<h5>onejar-maven-plugin</h2>

<ul>
<li>Pros</li>
<li>Cons

<ul>
<li>Not actively supported since 2012.</li>
</ul></li>
</ul>

```java
<plugin>
  <!--groupId>org.dstovall</groupId--> <!-- not available on the central -->
  <groupId>com.jolira</groupId>
  <artifactId>onejar-maven-plugin</artifactId>
  <executions>
    <execution>
      <configuration>
        <mainClass>${fully.qualified.main.class}</mainClass>
        <attachToBuild>true</attachToBuild>
        <!-- https://code.google.com/p/onejar-maven-plugin/issues/detail?id=8 -->
        <!--classifier>onejar</classifier-->
        <filename>${project.build.finalName}-onejar.${project.packaging}</filename>
      </configuration>
      <goals>
        <goal>one-jar</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

<hr>

<h5>Spring Boot Maven Plugin</h2>

<ul>
<li>Pros</li>
<li>Cons

<ul>
<li>Add potential unecessary Spring and Spring Boot related classes.</li>
</ul></li>
</ul>

```java
<plugin>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-maven-plugin</artifactId>
  <executions>
    <execution>
      <goals>
        <goal>repackage</goal>
      </goals>
      <configuration>
        <classifier>spring-boot</classifier>
        <mainClass>${fully.qualified.main.class}</mainClass>
      </configuration>
    </execution>
  </executions>
</plugin>
```

You have `target/${project.bulid.finalName}-spring-boot.jar`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: How do you assert that a certain exception is thrown in JUnit 4 tests? (score [1186587](https://stackoverflow.com/q/156503) in 2013)

#### Question
How can I use JUnit4 idiomatically to test that some code throws an exception?  

While I can certainly do something like this:  

```java
@Test
public void testFooThrowsIndexOutOfBoundsException() {
  boolean thrown = false;

  try {
    foo.doStuff();
  } catch (IndexOutOfBoundsException e) {
    thrown = true;
  }

  assertTrue(thrown);
}
```

I recall that there is an annotation or an Assert.xyz or <em>something</em> that is far less kludgy and far more in-the-spirit of JUnit for these sorts of situations.  

#### Answer accepted (score 2269)
`JUnit 4` has support for this:  

```java
@Test(expected = IndexOutOfBoundsException.class)
public void testIndexOutOfBoundsException() {

    ArrayList emptyList = new ArrayList();
    Object o = emptyList.get(0);

}
```

Reference :   

<ul>
<li><a href="https://junit.org/junit4/faq.html#atests_7" rel="noreferrer">JUnit Test-FAQ</a></li>
</ul>

#### Answer 2 (score 1271)
<strong>Edit</strong> Now that JUnit5 has released, the best option would be to use `Assertions.assertThrows()` (see <a href="https://stackoverflow.com/a/46514550/95725">my other answer</a>).  

If you haven't migrated to JUnit 5, but can use JUnit 4.7, you can use the <a href="http://junit.org/javadoc/latest/org/junit/rules/ExpectedException.html" rel="noreferrer">`ExpectedException`</a> Rule:  

```java
public class FooTest {
  @Rule
  public final ExpectedException exception = ExpectedException.none();

  @Test
  public void doStuffThrowsIndexOutOfBoundsException() {
    Foo foo = new Foo();

    exception.expect(IndexOutOfBoundsException.class);
    foo.doStuff();
  }
}
```

This is much better than `@Test(expected=IndexOutOfBoundsException.class)` because the test will fail if `IndexOutOfBoundsException` is thrown before `foo.doStuff()`  

See <a href="http://www.infoq.com/news/2009/07/junit-4.7-rules" rel="noreferrer">this article</a> for details  

#### Answer 3 (score 458)
Be careful using expected exception, because it only asserts that the <strong>method</strong> threw that exception, not a <strong>particular line of code</strong> in the test.  

I tend to use this for testing parameter validation, because such methods are usually very simple, but more complex tests might better be served with:  

```java
try {
    methodThatShouldThrow();
    fail( "My method didn't throw when I expected it to" );
} catch (MyException expectedException) {
}
```

Apply judgement.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: Avoiding != null statements (score [1182090](https://stackoverflow.com/q/271526) in 2018)

#### Question
I use `object != null` a lot to avoid <a href="https://docs.oracle.com/javase/9/docs/api/java/lang/NullPointerException.html" rel="noreferrer">`NullPointerException`</a>.  

Is there a good alternative to this?   

For example:  

```java
if (someobject != null) {
    someobject.doCalc();
}
```

This avoids a `NullPointerException`, when it is unknown if the object is `null` or not.  

Note that the accepted answer may be out of date, see <a href="https://stackoverflow.com/a/2386013/12943">https://stackoverflow.com/a/2386013/12943</a> for a more recent approach.  

#### Answer accepted (score 2570)
This to me sounds like a reasonably common problem that junior to intermediate developers tend to face at some point: they either don't know or don't trust the contracts they are participating in and defensively overcheck for nulls.  Additionally, when writing their own code, they tend to rely on returning nulls to indicate something thus requiring the caller to check for nulls.  

To put this another way, there are two instances where null checking comes up:  

<ol>
<li><p>Where null is a valid response in terms of the contract; and</p></li>
<li><p>Where it isn't a valid response.</p></li>
</ol>

(2) is easy.  Either use `assert` statements (assertions) or allow failure (for example,  <a href="http://docs.oracle.com/javase/6/docs/api/index.html?java/lang/NullPointerException.html" rel="noreferrer">NullPointerException</a>).  Assertions are a highly-underused Java feature that was added in 1.4.  The syntax is:  

```java
assert <condition>
```

or  

```java
assert <condition> : <object>
```

where `&lt;condition&gt;` is a boolean expression and `&lt;object&gt;` is an object whose `toString()` method's output will be included in the error.  

An `assert` statement throws an `Error` (`AssertionError`) if the condition is not true.  By default, Java ignores assertions.  You can enable assertions by passing the option `-ea` to the JVM.  You can enable and disable assertions for individual classes and packages.  This means that you can validate code with the assertions while developing and testing, and disable them in a production environment, although my testing has shown next to no performance impact from assertions.  

Not using assertions in this case is OK because the code will just fail, which is what will happen if you use assertions.  The only difference is that with assertions it might happen sooner, in a more-meaningful way and possibly with extra information, which may help you to figure out why it happened if you weren't expecting it.  

(1) is a little harder.  If you have no control over the code you're calling then you're stuck.  If null is a valid response, you have to check for it.  

If it's code that you do control, however (and this is often the case), then it's a different story.  Avoid using nulls as a response.  With methods that return collections, it's easy: return empty collections (or arrays) instead of nulls pretty much all the time.  

With non-collections it might be harder.  Consider this as an example: if you have these interfaces:  

```java
public interface Action {
  void doSomething();
}

public interface Parser {
  Action findAction(String userInput);
}
```

where Parser takes raw user input and finds something to do, perhaps if you're implementing a command line interface for something.  Now you might make the contract that it returns null if there's no appropriate action.  That leads the null checking you're talking about.  

An alternative solution is to never return null and instead use the <a href="https://en.wikipedia.org/wiki/Null_Object_pattern" rel="noreferrer">Null Object pattern</a>:  

```java
public class MyParser implements Parser {
  private static Action DO_NOTHING = new Action() {
    public void doSomething() { /* do nothing */ }
  };

  public Action findAction(String userInput) {
    // ...
    if ( /* we can't find any actions */ ) {
      return DO_NOTHING;
    }
  }
}
```

Compare:  

```java
Parser parser = ParserFactory.getParser();
if (parser == null) {
  // now what?
  // this would be an example of where null isn't (or shouldn't be) a valid response
}
Action action = parser.findAction(someInput);
if (action == null) {
  // do nothing
} else {
  action.doSomething();
}
```

to  

```java
ParserFactory.getParser().findAction(someInput).doSomething();
```

which is a much better design because it leads to more concise code.  

That said, perhaps it is entirely appropriate for the findAction() method to throw an Exception with a meaningful error message -- especially in this case where you are relying on user input.  It would be much better for the findAction method to throw an Exception than for the calling method to blow up with a simple NullPointerException with no explanation.  

```java
try {
    ParserFactory.getParser().findAction(someInput).doSomething();
} catch(ActionNotFoundException anfe) {
    userConsole.err(anfe.getMessage());
}
```

Or if you think the try/catch mechanism is too ugly, rather than Do Nothing your default action should provide feedback to the user.  

```java
public Action findAction(final String userInput) {
    /* Code to return requested Action if found */
    return new Action() {
        public void doSomething() {
            userConsole.err("Action not found: " + userInput);
        }
    }
}
```

#### Answer 2 (score 595)
If you use (or planning to use) a Java IDE like <a href="https://www.jetbrains.com/idea/" rel="noreferrer">JetBrains IntelliJ IDEA</a>, <a href="https://www.eclipse.org/" rel="noreferrer">Eclipse</a> or <a href="https://netbeans.org/" rel="noreferrer">Netbeans</a> or a tool like findbugs then you can use annotations to solve this problem.  

Basically, you've got `@Nullable` and `@NotNull`.  

You can use in method and parameters, like this:  

```java
@NotNull public static String helloWorld() {
    return "Hello World";
}
```

or  

```java
@Nullable public static String helloWorld() {
    return "Hello World";
}
```

The second example won't compile (in IntelliJ IDEA).  

When you use the first `helloWorld()` function in another piece of code:  

```java
public static void main(String[] args)
{
    String result = helloWorld();
    if(result != null) {
        System.out.println(result);
    }
}
```

Now the IntelliJ IDEA compiler will tell you that the check is useless, since the `helloWorld()` function won't return `null`, ever.  

Using parameter  

```java
void someMethod(@NotNull someParameter) { }
```

if you write something like:  

```java
someMethod(null);
```

This won't compile.  

Last example using `@Nullable`  

```java
@Nullable iWantToDestroyEverything() { return null; }
```

Doing this  

```java
iWantToDestroyEverything().something();
```

And you can be sure that this won't happen. :)  

It's a nice way to let the compiler check something more than it usually does and to enforce your contracts to be stronger. Unfortunately, it's not supported by all the compilers.  

In IntelliJ IDEA 10.5 and on, they added support for any other `@Nullable` `@NotNull` implementations.  

See blog post <em><a href="https://blog.jetbrains.com/idea/2011/03/more-flexible-and-configurable-nullublenotnull-annotations/" rel="noreferrer">More flexible and configurable @Nullable/@NotNull annotations</a></em>.  

#### Answer 3 (score 304)
<h5>If null-values are not allowed</h2>

If your method is called externally, start with something like this:  

```java
public void method(Object object) {
  if (object == null) {
    throw new IllegalArgumentException("...");
  }
```

Then, in the rest of that method, you'll know that `object` is not null.  

If it is an internal method (not part of an API), just document that it cannot be null, and that's it.  

Example:  

```java
public String getFirst3Chars(String text) {
  return text.subString(0, 3);
}
```

However, if your method just passes the value on, and the next method passes it on etc. it could get problematic. In that case you may want to check the argument as above.  

<h5>If null is allowed</h2>

This really depends. If find that I often do something like this:  

```java
if (object == null) {
  // something
} else {
  // something else
}
```

So I branch, and do two completely different things. There is no ugly code snippet, because I really need to do two different things depending on the data. For example, should I work on the input, or should I calculate a good default value?  

<hr>

It's actually rare for me to use the idiom "`if (object != null &amp;&amp; ...`".  

It may be easier to give you examples, if you show examples of where you typically use the idiom.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: How do I fix 'android.os.NetworkOnMainThreadException'? (score [1139887](https://stackoverflow.com/q/6343166) in 2019)

#### Question
I got an error while running my Android project for RssReader.   

Code:  

```java
URL url = new URL(urlToRssFeed);
SAXParserFactory factory = SAXParserFactory.newInstance();
SAXParser parser = factory.newSAXParser();
XMLReader xmlreader = parser.getXMLReader();
RssHandler theRSSHandler = new RssHandler();
xmlreader.setContentHandler(theRSSHandler);
InputSource is = new InputSource(url.openStream());
xmlreader.parse(is);
return theRSSHandler.getFeed();
```

And it shows the below error:  

```java
android.os.NetworkOnMainThreadException
```

How can I fix this issue?  

#### Answer accepted (score 2481)
This exception is thrown when an application attempts to perform a networking operation on its main thread. Run your code in <a href="http://developer.android.com/reference/android/os/AsyncTask.html" rel="noreferrer">`AsyncTask`</a>:  

```java
class RetrieveFeedTask extends AsyncTask<String, Void, RSSFeed> {

    private Exception exception;

    protected RSSFeed doInBackground(String... urls) {
        try {
            URL url = new URL(urls[0]);
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser parser = factory.newSAXParser();
            XMLReader xmlreader = parser.getXMLReader();
            RssHandler theRSSHandler = new RssHandler();
            xmlreader.setContentHandler(theRSSHandler);
            InputSource is = new InputSource(url.openStream());
            xmlreader.parse(is);

            return theRSSHandler.getFeed();
        } catch (Exception e) {
            this.exception = e;

            return null;
        } finally {
            is.close();
        }
    }

    protected void onPostExecute(RSSFeed feed) {
        // TODO: check this.exception
        // TODO: do something with the feed
    }
}
```

How to execute the task:  

In `MainActivity.java` file you can add this line within your `oncreate()` method  

```java
new RetrieveFeedTask().execute(urlToRssFeed);
```

Don't forget to add this to `AndroidManifest.xml` file:  

```java
<uses-permission android:name="android.permission.INTERNET"/>
```

#### Answer 2 (score 640)
<strong>You should almost always run network operations on a thread or as an asynchronous task.</strong>  

But it <em>is</em> possible to remove this restriction and you override the default behavior, if you are willing to accept the consequences.  

Add:  

```java
StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();

StrictMode.setThreadPolicy(policy); 
```

In your class,  

and  

ADD this permission in android manifest.xml file:      

```java
<uses-permission android:name="android.permission.INTERNET"/>
```

Consequences:  

Your app will (in areas of spotty internet connection) become unresponsive and lock up, the user perceives slowness and has to do a force kill, and you risk the activity manager killing your app and telling the user that the app has stopped.  

<p>Android has some good tips on good programming practices to design for responsiveness:
<a href="http://developer.android.com/reference/android/os/NetworkOnMainThreadException.html" rel="noreferrer">http://developer.android.com/reference/android/os/NetworkOnMainThreadException.html</a></p>

#### Answer 3 (score 403)
I solved this problem using a new `Thread`.  

```java
Thread thread = new Thread(new Runnable() {

    @Override
    public void run() {
        try  {
            //Your code goes here
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
});

thread.start(); 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Does Java support default parameter values? (score [1111010](https://stackoverflow.com/q/997482) in 2019)

#### Question
I came across some Java code that had the following structure:  

```java
public MyParameterizedFunction(String param1, int param2)
{
    this(param1, param2, false);
}

public MyParameterizedFunction(String param1, int param2, boolean param3)
{
    //use all three parameters here
}
```

I know that in C++ I can assign a parameter a default value.  For example:  

```java
void MyParameterizedFunction(String param1, int param2, bool param3=false);
```

Does Java support this kind of syntax?  Are there any reasons why this two step syntax is preferable?  

#### Answer accepted (score 884)
No, the structure you found is how Java handles it (that is, with overloading instead of default parameters).  

For constructors, <em><a href="https://en.wikipedia.org/wiki/Joshua_Bloch#Bibliography" rel="noreferrer">See Effective Java: Programming Language Guide's</a></em> Item 1 tip (Consider static factory methods instead of constructors) if the overloading is getting complicated. For other methods, renaming some cases or using a parameter object can help. This is when you have enough complexity that differentiating is difficult. A definite case is where you have to differentiate using the order of parameters, not just number and type.  

#### Answer 2 (score 607)
No, but you can use the <a href="http://en.wikipedia.org/wiki/Builder_pattern" rel="noreferrer">Builder Pattern</a>, as described in <a href="https://stackoverflow.com/questions/222214/managing-constructors-with-many-parameters-in-java-1-4/222295#222295">this Stack Overflow answer</a>.  

As described in the linked answer, the Builder Pattern lets you write code like  

```java
Student s1 = new StudentBuilder().name("Eli").buildStudent();
Student s2 = new StudentBuilder()
                 .name("Spicoli")
                 .age(16)
                 .motto("Aloha, Mr Hand")
                 .buildStudent();
```

in which some fields can have default values or otherwise be optional.  

#### Answer 3 (score 442)
There are several ways to simulate default parameters in Java:  

<ol>
<li><p><strong>Method overloading.</strong></p>

```java
void foo(String a, Integer b) {
    //...
}

void foo(String a) {
    foo(a, 0); // here, 0 is a default value for b
}

foo("a", 2);
foo("a");
```

One of the limitations of this approach is that it doesn't work if you have two optional parameters of the same type and any of them can be omitted.  </li>
<li><p><strong>Varargs.</strong></p>

a) All optional parameters are of the same type:  

```java
void foo(String a, Integer... b) {
    Integer b1 = b.length > 0 ? b[0] : 0;
    Integer b2 = b.length > 1 ? b[1] : 0;
    //...
}

foo("a");
foo("a", 1, 2);
```

b) Types of optional parameters may be different:  

```java
void foo(String a, Object... b) {
    Integer b1 = 0;
    String b2 = "";
    if (b.length > 0) {
      if (!(b[0] instanceof Integer)) { 
          throw new IllegalArgumentException("...");
      }
      b1 = (Integer)b[0];
    }
    if (b.length > 1) {
        if (!(b[1] instanceof String)) { 
            throw new IllegalArgumentException("...");
        }
        b2 = (String)b[1];
        //...
    }
    //...
}

foo("a");
foo("a", 1);
foo("a", 1, "b2");
```

The main drawback of this approach is that if optional parameters are of different types you lose static type checking. Furthermore, if each parameter has different meaning you need some way to distinguish them.  </li>
<li><p><strong>Nulls.</strong> To address the limitations of the previous approaches you can allow null values and then analyse each parameter in a method body:</p>

```java
void foo(String a, Integer b, Integer c) {
    b = b != null ? b : 0;
    c = c != null ? c : 0;
    //...
}

foo("a", null, 2);
```

Now all arguments values must be provided, but the default ones may be null.  </li>
<li><p><strong>Optional class.</strong> This approach is similar to nulls, but uses Java 8 Optional class for parameters that have a default value:</p>

```java
void foo(String a, Optional<Integer> bOpt) {
    Integer b = bOpt.isPresent() ? bOpt.get() : 0;
    //...
}

foo("a", Optional.of(2));
foo("a", Optional.<Integer>absent());
```

Optional makes a method contract explicit for a caller, however, one may find such signature too verbose.  </li>
<li><p><strong>Builder pattern.</strong> The builder pattern is used for constructors and is implemented by introducing a separate Builder class:</p>

```java
 class Foo {
     private final String a; 
     private final Integer b;

     Foo(String a, Integer b) {
       this.a = a;
       this.b = b;
     }

     //...
 }

 class FooBuilder {
   private String a = ""; 
   private Integer b = 0;

   FooBuilder setA(String a) {
     this.a = a;
     return this;
   }

   FooBuilder setB(Integer b) {
     this.b = b;
     return this;
   }

   Foo build() {
     return new Foo(a, b);
   }
 }

 Foo foo = new FooBuilder().setA("a").build();
```</li>
<li><p><strong>Maps.</strong> When the number of parameters is too large and for most of them default values are usually used, you can pass method arguments as a map of their names/values:</p>

```java
void foo(Map<String, Object> parameters) {
    String a = ""; 
    Integer b = 0;
    if (parameters.containsKey("a")) { 
        if (!(parameters.get("a") instanceof Integer)) { 
            throw new IllegalArgumentException("...");
        }
        a = (String)parameters.get("a");
    } else if (parameters.containsKey("b")) { 
        //... 
    }
    //...
}

foo(ImmutableMap.<String, Object>of(
    "a", "a",
    "b", 2, 
    "d", "value")); 
```</li>
</ol>

Please note that you can combine any of these approaches to achieve a desirable result.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How do I break out of nested loops in Java? (score [1078453](https://stackoverflow.com/q/886955) in 2019)

#### Question
I've got a nested loop construct like this:  

```java
for (Type type : types) {
    for (Type t : types2) {
         if (some condition) {
             // Do something and break...
             break; // Breaks out of the inner loop
         }
    }
}
```

Now how can I break out of both loops? I've looked at similar questions, but none concerns Java specifically. I couldn't apply these solutions because most used gotos.  

I don't want to put the inner loop in a different method.  

I don't want to rerun the loops. When breaking I'm finished with the execution of the loop block.  

#### Answer accepted (score 2313)
Like other answerers, I'd definitely <em>prefer</em> to put the loops in a different method, at which point you can just return to stop iterating completely. This answer just shows how the requirements in the question can be met.  

You can use `break` with a label for the outer loop. For example:  

```java
public class Test {
    public static void main(String[] args) {
        outerloop:
        for (int i=0; i < 5; i++) {
            for (int j=0; j < 5; j++) {
                if (i * j > 6) {
                    System.out.println("Breaking");
                    break outerloop;
                }
                System.out.println(i + " " + j);
            }
        }
        System.out.println("Done");
    }
}
```

This prints:  

```java
0 0
0 1
0 2
0 3
0 4
1 0
1 1
1 2
1 3
1 4
2 0
2 1
2 2
2 3
Breaking
Done
```

#### Answer 2 (score 389)
Technically the correct answer is to label the outer loop. In practice if you want to exit at any point inside an inner loop then you would be better off externalizing the code into a method (a static method if needs be) and then call it.  

That would pay off for readability.   

The code would become something like that:   

```java
private static String search(...) 
{
    for (Type type : types) {
        for (Type t : types2) {
            if (some condition) {
                // Do something and break...
                return search;
            }
        }
    }
    return null; 
}
```

Matching the example for the accepted answer:  

```java
 public class Test {
    public static void main(String[] args) {
        loop();
        System.out.println("Done");
    }

    public static void loop() {
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                if (i * j > 6) {
                    System.out.println("Breaking");
                    return;
                }
                System.out.println(i + " " + j);
            }
        }
    }
}
```

#### Answer 3 (score 210)
You can use a named block around the loops:  

```java
search: {
    for (Type type : types) {
        for (Type t : types2) {
            if (some condition) {
                // Do something and break...
                break search;
            }
        }
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: How to get an enum value from a string value in Java? (score [1045192](https://stackoverflow.com/q/604424) in 2018)

#### Question
Say I have an enum which is just  

```java
public enum Blah {
    A, B, C, D
}
```

and I would like to find the enum value of a string, for example `"A"` which would be `Blah.A`. How would it be possible to do this?  

Is the `Enum.valueOf()` the method I need? If so, how would I use this?  

#### Answer accepted (score 2149)
Yes, `Blah.valueOf("A")` will give you `Blah.A`.  

Note that the name must be an <em>exact</em> match, including case: `Blah.valueOf("a")` and `Blah.valueOf("A ")` both throw an `IllegalArgumentException`.  

The static methods `valueOf()` and `values()` are created at compile time and do not appear in source code. They do appear in Javadoc, though; for example, <a href="http://docs.oracle.com/javase/7/docs/api/java/awt/Dialog.ModalityType.html" rel="noreferrer">`Dialog.ModalityType`</a> shows both methods.  

#### Answer 2 (score 818)
Another solution if the text is not the same to the enumeration value:  

```java
public enum Blah {
    A("text1"),
    B("text2"),
    C("text3"),
    D("text4");

    private String text;

    Blah(String text) {
        this.text = text;
    }

    public String getText() {
        return this.text;
    }

    public static Blah fromString(String text) {
        for (Blah b : Blah.values()) {
            if (b.text.equalsIgnoreCase(text)) {
                return b;
            }
        }
        return null;
    }
}
```

#### Answer 3 (score 117)
Here's a nifty utility I use:  

```java
/**
 * A common method for all enums since they can't have another base class
 * @param <T> Enum type
 * @param c enum type. All enums must be all caps.
 * @param string case insensitive
 * @return corresponding enum, or null
 */
public static <T extends Enum<T>> T getEnumFromString(Class<T> c, String string) {
    if( c != null && string != null ) {
        try {
            return Enum.valueOf(c, string.trim().toUpperCase());
        } catch(IllegalArgumentException ex) {
        }
    }
    return null;
}
```

Then in my enum class I usually have this to save some typing:  

```java
public static MyEnum fromString(String name) {
    return getEnumFromString(MyEnum.class, name);
}
```

If your enums are not all caps, just change the `Enum.valueOf` line.  

Too bad I can't use `T.class` for `Enum.valueOf` as `T` is erased.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: Sort ArrayList of custom Objects by property (score [1033206](https://stackoverflow.com/q/2784514) in 2016)

#### Question
I read about sorting ArrayLists using a Comparator but in all of the examples people used `compareTo` which according to some research is a method for Strings.  

<p>I wanted to sort an ArrayList of custom objects by one of their properties: a Date object
(`getStartDay()`). Normally I compare them by `item1.getStartDate().before(item2.getStartDate())` so I was wondering whether I could write something like:</p>

```java
public class CustomComparator {
    public boolean compare(Object object1, Object object2) {
        return object1.getStartDate().before(object2.getStartDate());
    }
}

public class RandomName {
    ...
    Collections.sort(Database.arrayList, new CustomComparator);
    ...
}
```

#### Answer accepted (score 1478)
Since <a href="//docs.oracle.com/javase/8/docs/api/java/util/Date.html" rel="noreferrer">`Date`</a> implements <a href="//docs.oracle.com/javase/8/docs/api/java/lang/Comparable.html" rel="noreferrer">`Comparable`</a>, it has a `compareTo` method just like `String` does.  

So your custom <a href="//docs.oracle.com/javase/8/docs/api/java/util/Comparator.html" rel="noreferrer">`Comparator`</a> could look like this:  

```java
public class CustomComparator implements Comparator<MyObject> {
    @Override
    public int compare(MyObject o1, MyObject o2) {
        return o1.getStartDate().compareTo(o2.getStartDate());
    }
}
```

The `compare()` method must return an `int`, so you couldn't directly return a `boolean` like you were planning to anyway.  

Your sorting code would be just about like you wrote:  

```java
Collections.sort(Database.arrayList, new CustomComparator());
```

A slightly shorter way to write all this, if you don't need to reuse your comparator, is to write it as an inline anonymous class:  

```java
Collections.sort(Database.arrayList, new Comparator<MyObject>() {
    @Override
    public int compare(MyObject o1, MyObject o2) {
        return o1.getStartDate().compareTo(o2.getStartDate());
    }
});
```

<hr>

<h5>Since <a href="/questions/tagged/java-8" class="post-tag" title="show questions tagged &#39;java-8&#39;" rel="tag">java-8</a></h1>

You can now write the last example in a shorter form by using a <a href="//docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html" rel="noreferrer">lambda expression</a> for the `Comparator`:  

```java
Collections.sort(Database.arrayList, 
                        (o1, o2) -> o1.getStartDate().compareTo(o2.getStartDate()));
```

And `List` has a <a href="//docs.oracle.com/javase/8/docs/api/java/util/List.html#sort-java.util.Comparator-" rel="noreferrer">`sort(Comparator)`</a> method, so you can shorten this even further:  

```java
Database.arrayList.sort((o1, o2) -> o1.getStartDate().compareTo(o2.getStartDate()));
```

This is such a common idiom that there's <a href="//docs.oracle.com/javase/8/docs/api/java/util/Comparator.html#comparing-java.util.function.Function-" rel="noreferrer">a built-in method</a> to generate a `Comparator` for a class with a `Comparable` key:  

```java
Database.arrayList.sort(Comparator.comparing(MyObject::getStartDate));
```

All of these are equivalent forms.  

#### Answer 2 (score 191)
Classes that has a natural sort order (a class Number, as an example) should implement the Comparable interface, whilst classes that has no natural sort order (a class Chair, as an example) should be provided with a Comparator (or an anonymous Comparator class).  

Two examples:  

```java
public class Number implements Comparable<Number> {
    private int value;

    public Number(int value) { this.value = value; }
    public int compareTo(Number anotherInstance) {
        return this.value - anotherInstance.value;
    }
}

public class Chair {
    private int weight;
    private int height;

    public Chair(int weight, int height) {
        this.weight = weight;
        this.height = height;
    }
    /* Omitting getters and setters */
}
class ChairWeightComparator implements Comparator<Chair> {
    public int compare(Chair chair1, Chair chair2) {
        return chair1.getWeight() - chair2.getWeight();
    }
}
class ChairHeightComparator implements Comparator<Chair> {
    public int compare(Chair chair1, Chair chair2) {
        return chair1.getHeight() - chair2.getHeight();
    }
}
```

Usage:  

```java
List<Number> numbers = new ArrayList<Number>();
...
Collections.sort(numbers);

List<Chair> chairs = new ArrayList<Chair>();
// Sort by weight:
Collections.sort(chairs, new ChairWeightComparator());
// Sort by height:
Collections.sort(chairs, new ChairHeightComparator());

// You can also create anonymous comparators;
// Sort by color:
Collections.sort(chairs, new Comparator<Chair>() {
    public int compare(Chair chair1, Chair chair2) {
        ...
    }
});
```

#### Answer 3 (score 155)
For sorting an `ArrayList` you could use the following code snippet:  

```java
Collections.sort(studList, new Comparator<Student>(){
    public int compare(Student s1, Student s2) {
        return s1.getFirstName().compareToIgnoreCase(s2.getFirstName());
    }
});
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: How can I concatenate two arrays in Java? (score [1023252](https://stackoverflow.com/q/80476) in 2018)

#### Question
I need to concatenate two `String` arrays in Java.  

```java
void f(String[] first, String[] second) {
    String[] both = ???
}
```

What is the easiest way to do this?  

#### Answer 2 (score 1026)
I found a one-line solution from the good old Apache Commons Lang library.<br> <a href="http://commons.apache.org/proper/commons-lang/javadocs/api-3.1/org/apache/commons/lang3/ArrayUtils.html#addAll%28T%5B%5D,%20T...%29" rel="noreferrer">`ArrayUtils.addAll(T[], T...)`</a>  

Code:  

```java
String[] both = ArrayUtils.addAll(first, second);
```

#### Answer 3 (score 753)
Here's a simple method that will concatenate two arrays and return the result:  

```java
public <T> T[] concatenate(T[] a, T[] b) {
    int aLen = a.length;
    int bLen = b.length;

    @SuppressWarnings("unchecked")
    T[] c = (T[]) Array.newInstance(a.getClass().getComponentType(), aLen + bLen);
    System.arraycopy(a, 0, c, 0, aLen);
    System.arraycopy(b, 0, c, aLen, bLen);

    return c;
}
```

Note that it will not work with primitive data types, only with object types.  

The following slightly more complicated version works with both object and primitive arrays. It does this by using `T` instead of `T[]` as the argument type.  

It also makes it possible to concatenate arrays of two different types by picking the most general type as the component type of the result.  

```java
public static <T> T concatenate(T a, T b) {
    if (!a.getClass().isArray() || !b.getClass().isArray()) {
        throw new IllegalArgumentException();
    }

    Class<?> resCompType;
    Class<?> aCompType = a.getClass().getComponentType();
    Class<?> bCompType = b.getClass().getComponentType();

    if (aCompType.isAssignableFrom(bCompType)) {
        resCompType = aCompType;
    } else if (bCompType.isAssignableFrom(aCompType)) {
        resCompType = bCompType;
    } else {
        throw new IllegalArgumentException();
    }

    int aLen = Array.getLength(a);
    int bLen = Array.getLength(b);

    @SuppressWarnings("unchecked")
    T result = (T) Array.newInstance(resCompType, aLen + bLen);
    System.arraycopy(a, 0, result, 0, aLen);
    System.arraycopy(b, 0, result, aLen, bLen);        

    return result;
}
```

Here is an example:  

```java
Assert.assertArrayEquals(new int[] { 1, 2, 3 }, concatenate(new int[] { 1, 2 }, new int[] { 3 }));
Assert.assertArrayEquals(new Number[] { 1, 2, 3f }, concatenate(new Integer[] { 1, 2 }, new Number[] { 3f }));
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: When to use LinkedList over ArrayList in Java? (score [1008299](https://stackoverflow.com/q/322715) in 2018)

#### Question
I've always been one to simply use:  

```java
List<String> names = new ArrayList<>();
```

I use the interface as the type name for <em>portability</em>, so that when I ask questions such as these I can rework my code.    

When should <a href="https://docs.oracle.com/javase/9/docs/api/java/util/LinkedList.html" rel="noreferrer">`LinkedList`</a> be used over <a href="https://docs.oracle.com/javase/9/docs/api/java/util/ArrayList.html" rel="noreferrer">`ArrayList`</a> and vice-versa?  

#### Answer accepted (score 3214)
<strong>Summary</strong> `ArrayList` with `ArrayDeque` are preferable in <em>many</em> more use-cases than `LinkedList`. If you're not sure&nbsp;&mdash; just start with `ArrayList`.  

<hr>

`LinkedList` and `ArrayList` are two different implementations of the List interface. `LinkedList` implements it with a doubly-linked list. `ArrayList` implements it with a dynamically re-sizing array.  

As with standard linked list and array operations, the various methods will have different algorithmic runtimes.  

For <a href="http://docs.oracle.com/javase/8/docs/api/java/util/LinkedList.html" rel="noreferrer">`LinkedList&lt;E&gt;`</a>  

<ul>
<li>`get(int index)` is <em>O(n)</em> (with <em>n/4</em> steps on average)</li>
<li>`add(E element)` is <em>O(1)</em></li>
<li>`add(int index, E element)` is <em>O(n)</em> (with <em>n/4</em> steps on average),
but <em>O(1)</em> when `index = 0`  &lt;--- main benefit of `LinkedList&lt;E&gt;`</li>
<li>`remove(int index)` is <em>O(n)</em> (with <em>n/4</em> steps on average)</li>
<li>`Iterator.remove()` is <em>O(1)</em>. &lt;--- main benefit of `LinkedList&lt;E&gt;`</li>
<li>`ListIterator.add(E element)` is <em>O(1)</em>  This is one of the main benefits of `LinkedList&lt;E&gt;`</li>
</ul>

<sup>Note: Many of the operations need <em>n/4</em> steps on average, <em>constant</em> number of steps in the best case (e.g. index = 0), and <em>n/2</em> steps in worst case (middle of list)</sup>  

For <a href="http://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html" rel="noreferrer">`ArrayList&lt;E&gt;`</a>  

<ul>
<li>`get(int index)` is <em>O(1)</em>  &lt;--- main benefit of `ArrayList&lt;E&gt;`</li>
<li>`add(E element)` is <em>O(1)</em> amortized, but <em>O(n)</em> worst-case since the array must be resized and copied</li>
<li>`add(int index, E element)` is <em>O(n)</em> (with <em>n/2</em> steps on average)</li>
<li>`remove(int index)` is <em>O(n)</em> (with <em>n/2</em> steps on average)</li>
<li>`Iterator.remove()` is <em>O(n)</em> (with <em>n/2</em> steps on average)</li>
<li>`ListIterator.add(E element)` is <em>O(n)</em> (with <em>n/2</em> steps on average)</li>
</ul>

<sup>Note: Many of the operations need <em>n/2</em> steps on average, <em>constant</em> number of steps in the best case (end of list), <em>n</em> steps in the worst case (start of list)</sup>  

`LinkedList&lt;E&gt;` allows for constant-time insertions or removals <em>using iterators</em>, but only sequential access of elements. In other words, you can walk the list forwards or backwards, but finding a position in the list takes time proportional to the size of the list. Javadoc says <em>"operations that index into the list will traverse the list from the beginning or the end, whichever is closer"</em>, so those methods are <em>O(n)</em> (<em>n/4</em> steps) on average, though <em>O(1)</em> for `index = 0`.  

`ArrayList&lt;E&gt;`, on the other hand, allow fast random read access, so you can grab any element in constant time. But adding or removing from anywhere but the end requires shifting all the latter elements over, either to make an opening or fill the gap. Also, if you add more elements than the capacity of the underlying array, a new array (1.5 times the size) is allocated, and the old array is copied to the new one, so adding to an `ArrayList` is <em>O(n)</em> in the worst case but constant on average.  

So depending on the operations you intend to do, you should choose the implementations accordingly. Iterating over either kind of List is practically equally cheap. (Iterating over an `ArrayList` is technically faster, but unless you're doing something really performance-sensitive, you shouldn't worry about this -- they're both constants.)  

The main benefits of using a `LinkedList` arise when you re-use existing iterators to insert and remove elements. These operations can then be done in <em>O(1)</em> by changing the list locally only. In an array list, the remainder of the array needs to be <em>moved</em> (i.e. copied). On the other side, seeking in a `LinkedList` means following the links in <em>O(n)</em> (<em>n/2</em> steps) for worst case, whereas in an `ArrayList` the desired position can be computed mathematically and accessed in <em>O(1)</em>.  

Another benefit of using a `LinkedList` arise when you add or remove from the head of the list, since those operations are <em>O(1)</em>, while they are <em>O(n)</em> for `ArrayList`. Note that `ArrayDeque` may be a good alternative to `LinkedList` for adding and removing from the head, but it is not a `List`.  

Also, if you have large lists, keep in mind that memory usage is also different. Each element of a `LinkedList` has more overhead since pointers to the next and previous elements are also stored. `ArrayLists` don't have this overhead. However, `ArrayLists` take up as much memory as is allocated for the capacity, regardless of whether elements have actually been added.  

The default initial capacity of an `ArrayList` is pretty small (10 from Java 1.4 - 1.8). But since the underlying implementation is an array, the array must be resized if you add a lot of elements. To avoid the high cost of resizing when you know you're going to add a lot of elements, construct the `ArrayList` with a higher initial capacity.  

#### Answer 2 (score 605)
Thus far, nobody seems to have addressed the memory footprint of each of these lists besides the general consensus that a `LinkedList` is "lots more" than an `ArrayList` so I did some number crunching to demonstrate exactly how much both lists take up for N null references.  

Since references are either 32 or 64 bits (even when null) on their relative systems, I have included 4 sets of data for 32 and 64 bit `LinkedLists` and `ArrayLists`.  

<strong>Note:</strong> The sizes shown for the `ArrayList` lines are for <em>trimmed lists</em> - In practice, the capacity of the backing array in an `ArrayList` is generally larger than its current element count.  

<strong>Note 2:</strong> <em>(thanks BeeOnRope)</em> As CompressedOops is default now from mid JDK6 and up, the values below for 64-bit machines will basically match their 32-bit counterparts, unless of course you specifically turn it off.  

<hr>

<img src="https://i.imgur.com/f83xDyz.png" alt="Graph of LinkedList and ArrayList No. of Elements x Bytes">  

<hr>

The result clearly shows that `LinkedList` is a whole lot more than `ArrayList`, especially with a very high element count. If memory is a factor, steer clear of `LinkedLists`.  

The formulas I used follow, let me know if I have done anything wrong and I will fix it up. 'b' is either 4 or 8 for 32 or 64 bit systems, and 'n' is the number of elements. Note the reason for the mods is because all objects in java will take up a multiple of 8 bytes space regardless of whether it is all used or not.  

<strong>ArrayList:</strong>  

`ArrayList object header + size integer + modCount integer + array reference + (array oject header + b * n) + MOD(array oject, 8) + MOD(ArrayList object, 8) == 8 + 4 + 4 + b + (12 + b * n) + MOD(12 + b * n, 8) + MOD(8 + 4 + 4 + b + (12 + b * n) + MOD(12 + b * n, 8), 8)`  

<strong>LinkedList:</strong>  

`LinkedList object header + size integer + modCount integer + reference to header + reference to footer + (node object overhead + reference to previous element + reference to next element + reference to element) * n) + MOD(node object, 8) * n + MOD(LinkedList object, 8) == 8 + 4 + 4 + 2 * b + (8 + 3 * b) * n + MOD(8 + 3 * b, 8) * n + MOD(8 + 4 + 4 + 2 * b + (8 + 3 * b) * n + MOD(8 + 3 * b, 8) * n, 8)`  

#### Answer 3 (score 226)
`ArrayList` is what you want. `LinkedList` is almost always a (performance) bug.  

Why `LinkedList` sucks:  

<ul>
<li>It uses lots of small memory objects, and therefore impacts performance across the process.</li>
<li>Lots of small objects are bad for cache-locality.</li>
<li>Any indexed operation requires a traversal, i.e. has O(n) performance. This is not obvious in the source code, leading to algorithms O(n) slower than if `ArrayList` was used.</li>
<li>Getting good performance is tricky.</li>
<li>Even when big-O performance is the same as `ArrayList`, it is probably going to be significantly slower anyway.</li>
<li>It's jarring to see `LinkedList` in source because it is probably the wrong choice.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: How to use java.net.URLConnection to fire and handle HTTP requests (score [989794](https://stackoverflow.com/q/2793150) in 2018)

#### Question
Use of <a href="http://docs.oracle.com/javase/8/docs/api/java/net/URLConnection.html" rel="noreferrer">`java.net.URLConnection`</a> is asked about pretty often here, and the <a href="http://download.oracle.com/javase/tutorial/networking/urls/connecting.html" rel="noreferrer">Oracle tutorial</a> is <em>too</em> concise about it.   

That tutorial basically only shows how to fire a GET request and read the response. It doesn't explain anywhere how to use it to among others perform a POST request, set request headers, read response headers, deal with cookies, submit a HTML form, upload a file, etc.   

So, how can I use `java.net.URLConnection` to fire and handle "advanced" HTTP requests?  

#### Answer accepted (score 2660)
<sup><em>First a disclaimer beforehand: the posted code snippets are all basic examples. You'll need to handle trivial `IOException`s and `RuntimeException`s like `NullPointerException`, `ArrayIndexOutOfBoundsException` and consorts yourself.</em></sup>  

<hr>

<h5>Preparing</h3>

We first need to know at least the URL and the charset. The parameters are optional and depend on the functional requirements.  

```java
String url = "http://example.com";
String charset = "UTF-8";  // Or in Java 7 and later, use the constant: java.nio.charset.StandardCharsets.UTF_8.name()
String param1 = "value1";
String param2 = "value2";
// ...

String query = String.format("param1=%s&param2=%s", 
     URLEncoder.encode(param1, charset), 
     URLEncoder.encode(param2, charset));
```

The query parameters must be in `name=value` format and be concatenated by `&amp;`. You would normally also <a href="http://en.wikipedia.org/wiki/Percent-encoding" rel="noreferrer">URL-encode</a> the query parameters with the specified charset using <a href="http://docs.oracle.com/javase/8/docs/api/java/net/URLEncoder.html#encode-java.lang.String-java.lang.String-" rel="noreferrer">`URLEncoder#encode()`</a>.  

<sup>The `String#format()` is just for convenience. I prefer it when I would need the String concatenation operator `+` more than twice.</sup>  

<hr>

<h5>Firing a <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3" rel="noreferrer">HTTP GET</a> request with (optionally) query parameters</h3>

It's a trivial task. It's the default request method.  

```java
URLConnection connection = new URL(url + "?" + query).openConnection();
connection.setRequestProperty("Accept-Charset", charset);
InputStream response = connection.getInputStream();
// ...
```

Any query string should be concatenated to the URL using `?`. The <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.2" rel="noreferrer">`Accept-Charset`</a> header may hint the server what encoding the parameters are in. If you don't send any query string, then you can leave the `Accept-Charset` header away. If you don't need to set any headers, then you can even use the <a href="http://docs.oracle.com/javase/8/docs/api/java/net/URL.html#openStream%28%29" rel="noreferrer">`URL#openStream()`</a> shortcut method.  

```java
InputStream response = new URL(url).openStream();
// ...
```

Either way, if the other side is a <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html" rel="noreferrer">`HttpServlet`</a>, then its <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html#doGet%28javax.servlet.http.HttpServletRequest,%20javax.servlet.http.HttpServletResponse%29" rel="noreferrer">`doGet()`</a> method will be called and the parameters will be available by <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequest.html#getParameter%28java.lang.String%29" rel="noreferrer">`HttpServletRequest#getParameter()`</a>.  

For testing purposes, you can print the response body to stdout as below:  

```java
try (Scanner scanner = new Scanner(response)) {
    String responseBody = scanner.useDelimiter("\\A").next();
    System.out.println(responseBody);
}
```

<hr>

<h5>Firing a <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.5" rel="noreferrer">HTTP POST</a> request with query parameters</h3>

Setting the <a href="http://docs.oracle.com/javase/8/docs/api/java/net/URLConnection.html#setDoOutput%28boolean%29" rel="noreferrer">`URLConnection#setDoOutput()`</a> to `true` implicitly sets the request method to POST. The standard HTTP POST as web forms do is of type `application/x-www-form-urlencoded` wherein the query string is written to the request body.  

```java
URLConnection connection = new URL(url).openConnection();
connection.setDoOutput(true); // Triggers POST.
connection.setRequestProperty("Accept-Charset", charset);
connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + charset);

try (OutputStream output = connection.getOutputStream()) {
    output.write(query.getBytes(charset));
}

InputStream response = connection.getInputStream();
// ...
```

Note: whenever you'd like to submit a HTML form programmatically, don't forget to take the `name=value` pairs of any `&lt;input type="hidden"&gt;` elements into the query string and of course also the `name=value` pair of the `&lt;input type="submit"&gt;` element which you'd like to "press" programmatically (because that's usually been used in the server side to distinguish if a button was pressed and if so, which one).  

You can also cast the obtained <a href="http://docs.oracle.com/javase/8/docs/api/java/net/URLConnection.html" rel="noreferrer">`URLConnection`</a> to <a href="http://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html" rel="noreferrer">`HttpURLConnection`</a> and use its <a href="http://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html#setRequestMethod%28java.lang.String%29" rel="noreferrer">`HttpURLConnection#setRequestMethod()`</a> instead. But if you're trying to use the connection for output you still need to set <a href="http://docs.oracle.com/javase/8/docs/api/java/net/URLConnection.html#setDoOutput%28boolean%29" rel="noreferrer">`URLConnection#setDoOutput()`</a> to `true`.  

```java
HttpURLConnection httpConnection = (HttpURLConnection) new URL(url).openConnection();
httpConnection.setRequestMethod("POST");
// ...
```

Either way, if the other side is a <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html" rel="noreferrer">`HttpServlet`</a>, then its <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html#doPost%28javax.servlet.http.HttpServletRequest,%20javax.servlet.http.HttpServletResponse%29" rel="noreferrer">`doPost()`</a> method will be called and the parameters will be available by <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/ServletRequest.html#getParameter%28java.lang.String%29" rel="noreferrer">`HttpServletRequest#getParameter()`</a>.  

<hr>

<h5>Actually firing the HTTP request</h3>

You can fire the HTTP request explicitly with <a href="http://docs.oracle.com/javase/8/docs/api/java/net/URLConnection.html#connect%28%29" rel="noreferrer">`URLConnection#connect()`</a>, but the request will automatically be fired on demand when you want to get any information about the HTTP response, such as the response body using <a href="http://docs.oracle.com/javase/8/docs/api/java/net/URLConnection.html#getInputStream%28%29" rel="noreferrer">`URLConnection#getInputStream()`</a> and so on. The above examples does exactly that, so the `connect()` call is in fact superfluous.  

<hr>

<h5>Gathering HTTP response information</h3>

<ol>
<li><p><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html" rel="noreferrer">HTTP response status</a>:</p>

You need a <a href="http://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html" rel="noreferrer">`HttpURLConnection`</a> here. Cast it first if necessary.  

```java
int status = httpConnection.getResponseCode();
```</li>
<li><p><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html" rel="noreferrer">HTTP response headers</a>:</p>

```java
for (Entry<String, List<String>> header : connection.getHeaderFields().entrySet()) {
    System.out.println(header.getKey() + "=" + header.getValue());
}
```</li>
<li><p><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17" rel="noreferrer">HTTP response encoding</a>:</p>

When the `Content-Type` contains a `charset` parameter, then the response body is likely text based and we'd like to process the response body with the server-side specified character encoding then.  

```java
String contentType = connection.getHeaderField("Content-Type");
String charset = null;

for (String param : contentType.replace(" ", "").split(";")) {
    if (param.startsWith("charset=")) {
        charset = param.split("=", 2)[1];
        break;
    }
}

if (charset != null) {
    try (BufferedReader reader = new BufferedReader(new InputStreamReader(response, charset))) {
        for (String line; (line = reader.readLine()) != null;) {
            // ... System.out.println(line) ?
        }
    }
} else {
    // It's likely binary content, use InputStream/OutputStream.
}
```</li>
</ol>

<hr>

<h5>Maintaining the session</h3>

The server side session is usually backed by a cookie. Some web forms require that you're logged in and/or are tracked by a session. You can use the <a href="http://docs.oracle.com/javase/8/docs/api/java/net/CookieHandler.html" rel="noreferrer">`CookieHandler`</a> API to maintain cookies. You need to prepare a <a href="http://docs.oracle.com/javase/8/docs/api/java/net/CookieManager.html" rel="noreferrer">`CookieManager`</a> with a <a href="http://docs.oracle.com/javase/8/docs/api/java/net/CookiePolicy.html" rel="noreferrer">`CookiePolicy`</a> of <a href="http://docs.oracle.com/javase/8/docs/api/java/net/CookiePolicy.html#ACCEPT_ALL" rel="noreferrer">`ACCEPT_ALL`</a> before sending all HTTP requests.  

```java
// First set the default cookie manager.
CookieHandler.setDefault(new CookieManager(null, CookiePolicy.ACCEPT_ALL));

// All the following subsequent URLConnections will use the same cookie manager.
URLConnection connection = new URL(url).openConnection();
// ...

connection = new URL(url).openConnection();
// ...

connection = new URL(url).openConnection();
// ...
```

Note that this is known to not always work properly in all circumstances. If it fails for you, then best is to manually gather and set the cookie headers. You basically need to grab all `Set-Cookie` headers from the response of the login or the first `GET` request and then pass this through the subsequent requests.  

```java
// Gather all cookies on the first request.
URLConnection connection = new URL(url).openConnection();
List<String> cookies = connection.getHeaderFields().get("Set-Cookie");
// ...

// Then use the same cookies on all subsequent requests.
connection = new URL(url).openConnection();
for (String cookie : cookies) {
    connection.addRequestProperty("Cookie", cookie.split(";", 2)[0]);
}
// ...
```

The `split(";", 2)[0]` is there to get rid of cookie attributes which are irrelevant for the server side like `expires`, `path`, etc. Alternatively, you could also use `cookie.substring(0, cookie.indexOf(';'))` instead of `split()`.  

<hr>

<h5>Streaming mode</h3>

The <a href="http://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html" rel="noreferrer">`HttpURLConnection`</a> will by default buffer the <em>entire</em> request body before actually sending it, regardless of whether you've set a fixed content length yourself using `connection.setRequestProperty("Content-Length", contentLength);`. This may cause `OutOfMemoryException`s whenever you concurrently send large POST requests (e.g. uploading files). To avoid this, you would like to set the <a href="http://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html#setFixedLengthStreamingMode%28int%29" rel="noreferrer">`HttpURLConnection#setFixedLengthStreamingMode()`</a>.  

```java
httpConnection.setFixedLengthStreamingMode(contentLength);
```

But if the content length is really not known beforehand, then you can make use of chunked streaming mode by setting the <a href="http://docs.oracle.com/javase/8/docs/api/java/net/HttpURLConnection.html#setChunkedStreamingMode%28int%29" rel="noreferrer">`HttpURLConnection#setChunkedStreamingMode()`</a> accordingly. This will set the HTTP <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.41" rel="noreferrer">`Transfer-Encoding`</a> header to `chunked` which will force the request body being sent in chunks. The below example will send the body in chunks of 1KB.  

```java
httpConnection.setChunkedStreamingMode(1024);
```

<hr>

<h5>User-Agent</h3>

It can happen that <a href="https://stackoverflow.com/questions/13670692/403-forbidden-with-java-but-not-web-browser">a request returns an unexpected response, while it works fine with a real web browser</a>. The server side is probably blocking requests based on the <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43" rel="noreferrer">`User-Agent`</a> request header. The `URLConnection` will by default set it to `Java/1.6.0_19` where the last part is obviously the JRE version. You can override this as follows:  

```java
connection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"); // Do as if you're using Chrome 41 on Windows 7.
```

Use the User-Agent string from a <a href="http://www.useragentstring.com/pages/useragentstring.php" rel="noreferrer">recent browser</a>.  

<hr>

<h5>Error handling</h3>

If the HTTP response code is `4nn` (Client Error) or `5nn` (Server Error), then you may want to read the `HttpURLConnection#getErrorStream()` to see if the server has sent any useful error information.  

```java
InputStream error = ((HttpURLConnection) connection).getErrorStream();
```

If the HTTP response code is -1, then something went wrong with connection and response handling. The `HttpURLConnection` implementation is in older JREs somewhat buggy with keeping connections alive. You may want to turn it off by setting the `http.keepAlive` system property to `false`. You can do this programmatically in the beginning of your application by:  

```java
System.setProperty("http.keepAlive", "false");
```

<hr>

<h5>Uploading files</h3>

You'd normally use <a href="http://www.w3.org/TR/html401/interact/forms.html#h-17.13.4.2" rel="noreferrer">`multipart/form-data`</a> encoding for mixed POST content (binary and character data). The encoding is in more detail described in <a href="http://www.faqs.org/rfcs/rfc2388.html" rel="noreferrer">RFC2388</a>.  

```java
String param = "value";
File textFile = new File("/path/to/file.txt");
File binaryFile = new File("/path/to/file.bin");
String boundary = Long.toHexString(System.currentTimeMillis()); // Just generate some unique random value.
String CRLF = "\r\n"; // Line separator required by multipart/form-data.
URLConnection connection = new URL(url).openConnection();
connection.setDoOutput(true);
connection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);

try (
    OutputStream output = connection.getOutputStream();
    PrintWriter writer = new PrintWriter(new OutputStreamWriter(output, charset), true);
) {
    // Send normal param.
    writer.append("--" + boundary).append(CRLF);
    writer.append("Content-Disposition: form-data; name=\"param\"").append(CRLF);
    writer.append("Content-Type: text/plain; charset=" + charset).append(CRLF);
    writer.append(CRLF).append(param).append(CRLF).flush();

    // Send text file.
    writer.append("--" + boundary).append(CRLF);
    writer.append("Content-Disposition: form-data; name=\"textFile\"; filename=\"" + textFile.getName() + "\"").append(CRLF);
    writer.append("Content-Type: text/plain; charset=" + charset).append(CRLF); // Text file itself must be saved in this charset!
    writer.append(CRLF).flush();
    Files.copy(textFile.toPath(), output);
    output.flush(); // Important before continuing with writer!
    writer.append(CRLF).flush(); // CRLF is important! It indicates end of boundary.

    // Send binary file.
    writer.append("--" + boundary).append(CRLF);
    writer.append("Content-Disposition: form-data; name=\"binaryFile\"; filename=\"" + binaryFile.getName() + "\"").append(CRLF);
    writer.append("Content-Type: " + URLConnection.guessContentTypeFromName(binaryFile.getName())).append(CRLF);
    writer.append("Content-Transfer-Encoding: binary").append(CRLF);
    writer.append(CRLF).flush();
    Files.copy(binaryFile.toPath(), output);
    output.flush(); // Important before continuing with writer!
    writer.append(CRLF).flush(); // CRLF is important! It indicates end of boundary.

    // End of multipart/form-data.
    writer.append("--" + boundary + "--").append(CRLF).flush();
}
```

If the other side is a <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html" rel="noreferrer">`HttpServlet`</a>, then its <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html#doPost%28javax.servlet.http.HttpServletRequest,%20javax.servlet.http.HttpServletResponse%29" rel="noreferrer">`doPost()`</a> method will be called and the parts will be available by <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getPart%28java.lang.String%29" rel="noreferrer">`HttpServletRequest#getPart()`</a> (note, thus <strong>not</strong> `getParameter()` and so on!). The `getPart()` method is however relatively new, it's introduced in Servlet 3.0 (Glassfish 3, Tomcat 7, etc). Prior to Servlet 3.0, your best choice is using <a href="http://commons.apache.org/fileupload" rel="noreferrer">Apache Commons FileUpload</a> to parse a `multipart/form-data` request. Also see <a href="https://stackoverflow.com/questions/2422468/upload-big-file-to-servlet/2424824#2424824">this answer</a> for examples of both the FileUpload and the Servelt 3.0 approaches.  

<hr>

<h5>Dealing with untrusted or misconfigured HTTPS sites</h3>

Sometimes you need to connect a HTTPS URL, perhaps because you're writing a web scraper. In that case, you may likely face a `javax.net.ssl.SSLException: Not trusted server certificate` on some HTTPS sites who doesn't keep their SSL certificates up to date, or a `java.security.cert.CertificateException: No subject alternative DNS name matching [hostname] found` or `javax.net.ssl.SSLProtocolException: handshake alert: unrecognized_name` on some misconfigured HTTPS sites.  

The following one-time-run `static` initializer in your web scraper class should make `HttpsURLConnection` more lenient as to those HTTPS sites and thus not throw those exceptions anymore.  

```java
static {
    TrustManager[] trustAllCertificates = new TrustManager[] {
        new X509TrustManager() {
            @Override
            public X509Certificate[] getAcceptedIssuers() {
                return null; // Not relevant.
            }
            @Override
            public void checkClientTrusted(X509Certificate[] certs, String authType) {
                // Do nothing. Just allow them all.
            }
            @Override
            public void checkServerTrusted(X509Certificate[] certs, String authType) {
                // Do nothing. Just allow them all.
            }
        }
    };

    HostnameVerifier trustAllHostnames = new HostnameVerifier() {
        @Override
        public boolean verify(String hostname, SSLSession session) {
            return true; // Just allow them all.
        }
    };

    try {
        System.setProperty("jsse.enableSNIExtension", "false");
        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, trustAllCertificates, new SecureRandom());
        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        HttpsURLConnection.setDefaultHostnameVerifier(trustAllHostnames);
    }
    catch (GeneralSecurityException e) {
        throw new ExceptionInInitializerError(e);
    }
}
```

<hr>

<h5>Last words</h3>

The <a href="http://hc.apache.org/httpcomponents-client-ga/" rel="noreferrer">Apache HttpComponents HttpClient</a> is <em>much</em> more convenient in this all :)  

<ul>
<li><a href="http://hc.apache.org/httpcomponents-client-ga/tutorial/html/" rel="noreferrer">HttpClient Tutorial</a></li>
<li><a href="http://hc.apache.org/httpcomponents-client-ga/examples.html" rel="noreferrer">HttpClient Examples</a></li>
</ul>

<hr>

<h5>Parsing and extracting HTML</h3>

If all you want is parsing and extracting data from HTML, then better use a HTML parser like <a href="http://jsoup.org" rel="noreferrer">Jsoup</a>  

<ul>
<li><a href="https://stackoverflow.com/questions/3152138/what-are-the-pros-and-cons-of-the-leading-java-html-parsers/3154281#3154281">What are the pros/cons of leading HTML parsers in Java</a></li>
<li><a href="https://stackoverflow.com/questions/2835505/how-to-scan-a-website-or-page-for-info-and-bring-it-into-my-program/2835555#2835555">How to scan and extract a webpage in Java</a></li>
</ul>

#### Answer 2 (score 88)
When working with HTTP it's almost always more useful to refer to `HttpURLConnection` rather than the base class `URLConnection` (since `URLConnection` is an abstract class when you ask for `URLConnection.openConnection()` on a HTTP URL that's what you'll get back anyway).  

Then you can instead of relying on `URLConnection#setDoOutput(true)` to implicitly set the request method to <em>POST</em> instead do `httpURLConnection.setRequestMethod("POST")` which some might find more natural (and which also allows you to specify other request methods such as <em>PUT</em>, <em>DELETE</em>, ...).  

It also provides useful HTTP constants so you can do:  

```java
int responseCode = httpURLConnection.getResponseCode();

if (responseCode == HttpURLConnection.HTTP_OK) {
```

#### Answer 3 (score 50)
Inspired by this and other questions on SO, I've created a minimal open source <a href="http://code.google.com/p/basic-http-client/">basic-http-client</a> that embodies most of the techniques found here.  

<a href="https://code.google.com/p/google-http-java-client/">google-http-java-client</a> is also a great open source resource.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: What are the possible values of the Hibernate hbm2ddl.auto configuration and what do they do (score [955696](https://stackoverflow.com/q/438146) in 2019)

#### Question
<p>I really want to know more about the update, export and the values that could be given to `hibernate.hbm2ddl.auto`<br>
I need to know when to use the update and when not? And what is the alternative?</p>

These are changes that could happen over DB:  

<ul>
<li>new tables</li>
<li>new columns in old tables</li>
<li>columns deleted</li>
<li>data type of a column changed</li>
<li>a type of a column changed its attributes</li>
<li>tables dropped</li>
<li>values of a column changed </li>
</ul>

In each case what is the best solution?  

#### Answer 2 (score 1031)
From the <a href="https://docs.jboss.org/hibernate/orm/5.2/userguide/html_single/Hibernate_User_Guide.html#configurations-hbmddl" rel="noreferrer">community documentation</a>:  

<blockquote>
  hibernate.hbm2ddl.auto    Automatically validates or exports schema DDL to the database when the SessionFactory is created. With create-drop, the database schema will be dropped when the SessionFactory is closed explicitly.  
  
  e.g. validate | update | create | create-drop   
</blockquote>

So the list of possible options are,  

<ul>
<li><em>validate</em>: validate the schema, makes no changes to the database.</li>
<li><em>update</em>: update the schema.</li>
<li><em>create</em>: creates the schema, destroying previous data.</li>
<li><em>create-drop</em>: drop the schema when the SessionFactory is closed explicitly, typically when the application is stopped.</li>
</ul>

These options seem intended to be developers tools and not to facilitate any production level databases, you may want to have a look at the following question; <a href="https://stackoverflow.com/questions/221379/hibernate-hbm2ddl-autoupdate-in-production">Hibernate: hbm2ddl.auto=update in production?</a>  

#### Answer 3 (score 190)
There's also the undocumented value of "none" to disable it entirely.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: Difference between wait() and sleep() (score [864573](https://stackoverflow.com/q/1036754) in 2017)

#### Question
What is the difference between a `wait()` and `sleep()` in Threads?  

Is my understanding that a `wait()`-ing Thread is still in running mode and uses CPU cycles but a `sleep()`-ing does not consume any CPU cycles correct?  

Why do we have <em>both</em> `wait()` and `sleep()`: how does their implementation vary at a lower level?  

#### Answer accepted (score 805)
A <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#wait%28%29" rel="noreferrer">`wait`</a> can be "woken up" by another thread calling <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#notify%28%29" rel="noreferrer">`notify`</a> on the monitor which is being waited on whereas a <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#sleep%28long%29" rel="noreferrer">`sleep`</a> cannot. Also a `wait` (and `notify`) must happen in a block `synchronized` on the monitor object whereas `sleep` does not:  

```java
Object mon = ...;
synchronized (mon) {
    mon.wait();
} 
```

At this point the currently executing thread waits <em>and releases the monitor</em>. Another thread may do  

```java
synchronized (mon) { mon.notify(); }
```

(on the same `mon` object) and the first thread (assuming it is the only thread waiting on the monitor) will wake up.   

You can also call <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html#notifyAll%28%29" rel="noreferrer">`notifyAll`</a> if more than one thread is waiting on the monitor – this will wake <em>all of them up</em>. However, only one of the threads will be able to grab the monitor (remember that the `wait` is in a `synchronized` block) and carry on – the others will then be blocked until they can acquire the monitor's lock.  

Another point is that you call `wait` on <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Object.html" rel="noreferrer">`Object`</a> itself (i.e. you wait on an object's monitor) whereas you call `sleep` on <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html" rel="noreferrer">`Thread`</a>.  

Yet another point is that you can get <em>spurious wakeups</em> from `wait` (i.e. the thread which is waiting resumes for no apparent reason). You should <strong>always `wait` whilst spinning on some condition</strong> as follows:    

```java
synchronized {
    while (!condition) { mon.wait(); }
}
```

#### Answer 2 (score 319)
One key difference not yet mentioned is that while sleeping a Thread does <em>not</em> release the locks it holds, while waiting releases the lock on the object that `wait()` is called on.  

```java
synchronized(LOCK) {
    Thread.sleep(1000); // LOCK is held
}


synchronized(LOCK) {
    LOCK.wait(); // LOCK is not held
}
```

#### Answer 3 (score 230)
I found <a href="https://groups.google.com/group/comp.lang.java.programmer/msg/12b19fdb8157883d?dmode=source&amp;hl=en&amp;pli=1" rel="noreferrer">this post</a> helpful. It puts the difference between `Thread.sleep()`, `Thread.yield()`, and `Object.wait()` in human terms. To quote:  

<blockquote>
  <p>It all eventually makes its way down to the OS’s scheduler, which
  hands out timeslices to processes and threads.</p>
  
  <p>`sleep(n)` says <strong><em>“I’m done with my timeslice, and please don’t give me
  another one for at least n milliseconds.”</em></strong> The OS doesn’t even try to
  schedule the sleeping thread until requested time has passed.</p>
  
  <p>`yield()` says <strong><em>“I’m done with my timeslice, but I still have work to
  do.”</em></strong> The OS is free to immediately give the thread another timeslice,
  or to give some other thread or process the CPU the yielding thread
  just gave up.</p>
  
  <p>`wait()` says <strong><em>“I’m done with my timeslice. Don’t give me another
  timeslice until someone calls notify().”</em></strong> As with `sleep()`, the OS won’t
  even try to schedule your task unless someone calls `notify()` (or one of
  a few other wakeup scenarios occurs).</p>
  
  <p>Threads also lose the remainder of their timeslice when they perform
  blocking IO and under a few other circumstances. If a thread works
  through the entire timeslice, the OS forcibly takes control roughly as
  if `yield()` had been called, so that other processes can run.</p>
  
  <p>You rarely need `yield()`, but if you have a compute-heavy app with
  logical task boundaries, inserting a `yield()` <em>might</em> improve system
  responsiveness (at the expense of time — context switches, even just
  to the OS and back, aren’t free). Measure and test against goals you
  care about, as always.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: What's the difference between @Component, @Repository & @Service annotations in Spring? (score [852949](https://stackoverflow.com/q/6827752) in 2017)

#### Question
Can `@Component`, `@Repository` and `@Service` annotations be used interchangeably in Spring or do they provide any particular functionality besides acting as a notation device?  

In other words, if I have a Service class and I change the annotation from `@Service` to `@Component`, will it still behave the same way?   

Or does the annotation also influence the behavior and functionality of the class?  

#### Answer 2 (score 1423)
From <a href="https://docs.spring.io/spring-framework/docs/current/spring-framework-reference/core.html#beans-stereotype-annotations" rel="noreferrer">Spring Documentation</a>:  

<blockquote>
  <p>In Spring 2.0 and later, the `@Repository` annotation is a marker for
  any class that fulfills the role or stereotype (also known as Data
  Access Object or DAO) of a repository. Among the uses of this marker
  is the automatic translation of exceptions.</p>
  
  <p>Spring 2.5 introduces further stereotype annotations: `@Component`,
  `@Service`, and `@Controller`. `@Component` is a generic stereotype for any
  Spring-managed component. `@Repository`, `@Service`, and `@Controller` are
  specializations of `@Component` for more specific use cases, for
  example, in the persistence, service, and presentation layers,
  respectively.</p>
  
  <p>Therefore, you can annotate your component classes with `@Component`,
  but by annotating them with `@Repository`, `@Service`, or `@Controller`
  instead, your classes are more properly suited for processing by tools
  or associating with aspects. For example, these stereotype annotations
  make ideal targets for pointcuts.</p>
  
  <p>Thus, if you are choosing between using `@Component` or `@Service` for
  your service layer, `@Service` is clearly the better choice. Similarly,
  as stated above, `@Repository` is already supported as a marker for
  automatic exception translation in your persistence layer.</p>
</blockquote>

```java
┌────────────┬─────────────────────────────────────────────────────┐
│ Annotation │ Meaning                                             │
├────────────┼─────────────────────────────────────────────────────┤
│ @Component │ generic stereotype for any Spring-managed component │
│ @Repository│ stereotype for persistence layer                    │
│ @Service   │ stereotype for service layer                        │
│ @Controller│ stereotype for presentation layer (spring-mvc)      │
└────────────┴─────────────────────────────────────────────────────┘
```

#### Answer 3 (score 718)
As many of the answers already state what these annotations are used for, we'll here focus on some minor differences among them.    

<blockquote>
  First the <strong>Similarity</strong>     
  
  <p>First point worth highlighting again is that <strong>with respect to scan-auto-detection and dependency injection for BeanDefinition</strong> all these annotations (viz., @Component, @Service,
  @Repository, @Controller) are the same. <strong>We can use one in place
  of another and can still get our way around.</strong></p>
</blockquote>

<hr>

<h5>Differences between @Component, @Repository, @Controller and @Service</h2>

<blockquote>
  <strong>@Component</strong>  
</blockquote>

This is a general-purpose stereotype annotation indicating that the class is a spring component.  

<p><strong><em>What’s special about @Component</em></strong><br>
`&lt;context:component-scan&gt;` only scans `@Component` and does not look for `@Controller`, `@Service` and `@Repository` in general. They are scanned because they themselves are annotated with `@Component`.</p>

Just take a look at `@Controller`, `@Service` and `@Repository` annotation definitions:  

```java
@Component
public @interface Service {
    ….
}
```

   

```java
@Component
public @interface Repository {
    ….
}
```

   

```java
@Component
public @interface Controller {
    …
}
```

Thus, it’s not wrong to say that `@Controller`, `@Service` and `@Repository` are special types of `@Component` annotation. `&lt;context:component-scan&gt;` picks them up and registers their following classes as beans, just as if they were annotated with `@Component`.  

Special type annotations are also scanned, because they themselves are annotated with `@Component` annotation, which means they are also `@Component`s. If we define our own custom annotation and annotate it with `@Component`, it will also get scanned with `&lt;context:component-scan&gt;`  

<hr>

<blockquote>
  <strong>@Repository</strong>  
</blockquote>

This is to indicate that the class defines a data repository.  

<strong><em>What’s special about @Repository?</em></strong>    

In addition to pointing out, that this is an <em>Annotation based Configuration</em>, `@Repository`’s job is to catch platform specific exceptions and re-throw them as one of Spring’s unified unchecked exception. For this, we’re provided with `PersistenceExceptionTranslationPostProcessor`, that we are required to add in our Spring’s application context like this:  

```java
<bean class="org.springframework.dao.annotation.PersistenceExceptionTranslationPostProcessor"/>
```

This bean post processor adds an advisor to any bean that’s annotated with `@Repository` so that any platform-specific exceptions are caught and then re-thrown as one of Spring’s unchecked data access exceptions.  

<hr>

<blockquote>
  <strong>@Controller</strong>  
</blockquote>

The `@Controller` annotation indicates that a particular class serves the role of a controller. The `@Controller` annotation acts as a stereotype for the annotated class, indicating its role.  

<strong><em>What’s special about @Controller?</em></strong>    

<p>We cannot switch this annotation with any other like `@Service` or `@Repository`, even though they look same. 
The dispatcher scans the classes annotated with `@Controller` and detects methods annotated with `@RequestMapping` annotations within them. We can use `@RequestMapping` on/in only those methods whose classes are annotated with `@Controller` and it will <strong>NOT</strong> work with `@Component`, `@Service`, `@Repository` etc...</p>

<sub><em>Note: If a class is already registered as a bean through any alternate method, like through `@Bean` or through `@Component`, `@Service` etc... annotations, then `@RequestMapping` can be picked if the class is also annotated with `@RequestMapping` annotation. But that's a different scenario.</em></sub>  

<hr>

<blockquote>
  <strong>@Service</strong>  
</blockquote>

`@Service` beans hold the business logic and call methods in the repository layer.   

<strong><em>What’s special about @Service?</em></strong>    

Apart from the fact that it's used to indicate, that it's holding the business logic, there’s nothing else noticeable in this annotation; but who knows, Spring may add some additional exceptional in future.  

<hr>

<blockquote>
  <strong><em>What else?</em></strong>  
</blockquote>

Similar to above, in the future Spring may add special functionalities for `@Service`, `@Controller` and `@Repository` based on their layering conventions. Hence, it's always a good idea to respect the convention and use it in line with layers.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: What is reflection and why is it useful? (score [846678](https://stackoverflow.com/q/37628) in 2015)

#### Question
What is reflection, and why is it useful?  

I'm particularly interested in Java, but I assume the principles are the same in any language.  

#### Answer accepted (score 1628)
The name reflection is used to describe code which is able to inspect other code in the same system (or itself).  

For example, say you have an object of an unknown type in Java, and you would like to call a 'doSomething' method on it if one exists. Java's static typing system isn't really designed to support this unless the object conforms to a known interface, but using reflection, your code can look at the object and find out if it has a method called 'doSomething' and then call it if you want to.  

So, to give you a code example of this in Java (imagine the object in question is foo) :  

```java
Method method = foo.getClass().getMethod("doSomething", null);
method.invoke(foo, null);
```

One very common use case in Java is the usage with annotations. JUnit 4, for example, will use reflection to look through your classes for methods tagged with the @Test annotation, and will then call them when running the unit test.  

There are some good reflection examples to get you started at <a href="http://docs.oracle.com/javase/tutorial/reflect/index.html" rel="noreferrer">http://docs.oracle.com/javase/tutorial/reflect/index.html</a>  

And finally, yes, the concepts are pretty much similar in other statically types languages which support reflection (like C#). In dynamically typed languages, the use case described above is less necessary (since the compiler will allow any method to be called on any object, failing at runtime if it does not exist), but the second case of looking for methods which are marked or work in a certain way is still common.  

<strong>Update from a comment:</strong>  

<blockquote>
  <p>The ability to inspect the code in the system and see object types is
  not reflection, but rather Type Introspection. Reflection is then the
  ability to make modifications at runtime by making use of
  introspection. The distinction is necessary here as some languages
  support introspection, but do not support reflection. One such example
  is C++</p>
</blockquote>

#### Answer 2 (score 227)
<blockquote>
  <strong>Reflection</strong> is a language's ability to inspect and dynamically call classes, methods, attributes, etc. at runtime.  
</blockquote>

For example, all objects in Java have the method `getClass()`, which lets you determine the object's class even if you don't know it at compile time (e.g. if you declared it as an `Object`) - this might seem trivial, but such reflection is not possible in less dynamic languages such as `C++`. More advanced uses lets you list and call methods, constructors, etc.  

Reflection is important since it lets you write programs that do not have to "know" everything at compile time, making them more dynamic, since they can be tied together at runtime. The code can be written against known interfaces, but the actual classes to be used can be instantiated using reflection from configuration files.  

Lots of modern frameworks use reflection extensively for this very reason. Most other modern languages use reflection as well, and in scripting languages (such as Python) they are even more tightly integrated, since it feels more natural within the general programming model of those languages.  

#### Answer 3 (score 104)
One of my favorite uses of reflection is the below Java dump method. It takes any object as a parameter and uses the Java reflection API to print out every field name and value.  

```java
import java.lang.reflect.Array;
import java.lang.reflect.Field;

public static String dump(Object o, int callCount) {
    callCount++;
    StringBuffer tabs = new StringBuffer();
    for (int k = 0; k < callCount; k++) {
        tabs.append("\t");
    }
    StringBuffer buffer = new StringBuffer();
    Class oClass = o.getClass();
    if (oClass.isArray()) {
        buffer.append("\n");
        buffer.append(tabs.toString());
        buffer.append("[");
        for (int i = 0; i < Array.getLength(o); i++) {
            if (i < 0)
                buffer.append(",");
            Object value = Array.get(o, i);
            if (value.getClass().isPrimitive() ||
                    value.getClass() == java.lang.Long.class ||
                    value.getClass() == java.lang.String.class ||
                    value.getClass() == java.lang.Integer.class ||
                    value.getClass() == java.lang.Boolean.class
                    ) {
                buffer.append(value);
            } else {
                buffer.append(dump(value, callCount));
            }
        }
        buffer.append(tabs.toString());
        buffer.append("]\n");
    } else {
        buffer.append("\n");
        buffer.append(tabs.toString());
        buffer.append("{\n");
        while (oClass != null) {
            Field[] fields = oClass.getDeclaredFields();
            for (int i = 0; i < fields.length; i++) {
                buffer.append(tabs.toString());
                fields[i].setAccessible(true);
                buffer.append(fields[i].getName());
                buffer.append("=");
                try {
                    Object value = fields[i].get(o);
                    if (value != null) {
                        if (value.getClass().isPrimitive() ||
                                value.getClass() == java.lang.Long.class ||
                                value.getClass() == java.lang.String.class ||
                                value.getClass() == java.lang.Integer.class ||
                                value.getClass() == java.lang.Boolean.class
                                ) {
                            buffer.append(value);
                        } else {
                            buffer.append(dump(value, callCount));
                        }
                    }
                } catch (IllegalAccessException e) {
                    buffer.append(e.getMessage());
                }
                buffer.append("\n");
            }
            oClass = oClass.getSuperclass();
        }
        buffer.append(tabs.toString());
        buffer.append("}\n");
    }
    return buffer.toString();
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: What is a serialVersionUID and why should I use it? (score [845205](https://stackoverflow.com/q/285793) in 2015)

#### Question
Eclipse issues warnings when a `serialVersionUID` is missing.    

<blockquote>
  <p>The serializable class Foo does not declare a static final
  serialVersionUID field of type long</p>
</blockquote>

What is `serialVersionUID` and why is it important?  Please show an example where missing `serialVersionUID` will cause a problem.  

#### Answer accepted (score 2177)
The docs for <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/Serializable.html" rel="noreferrer">`java.io.Serializable`</a> are probably about as good an explanation as you'll get:  

<blockquote>
  <p>The serialization runtime associates with each serializable class a version number, called a `serialVersionUID`, which is used during deserialization to verify that the sender and receiver of a serialized object have loaded classes for that object that are compatible with respect to serialization. If the receiver has loaded a class for the object that has a different `serialVersionUID` than that of the corresponding sender's class, then deserialization will result in an 
  <a href="https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/InvalidClassException.html" rel="noreferrer">`InvalidClassException`</a>. A serializable class can declare its own `serialVersionUID` explicitly by declaring a field named `serialVersionUID` that must be static, final, and of type `long`:</p>

```java
ANY-ACCESS-MODIFIER static final long serialVersionUID = 42L;
```
  
  If a serializable class does not explicitly declare a `serialVersionUID`, then the serialization runtime will calculate a default `serialVersionUID` value for that class based on various aspects of the class, as described in the Java(TM) Object Serialization Specification. However, it is <em>strongly recommended</em> that all serializable classes explicitly declare `serialVersionUID` values, since the default `serialVersionUID` computation is highly sensitive to class details that may vary depending on compiler implementations, and can thus result in unexpected `InvalidClassExceptions` during deserialization. Therefore, to guarantee a consistent `serialVersionUID` value across different java compiler implementations, a serializable class must declare an explicit `serialVersionUID` value. It is also strongly advised that explicit `serialVersionUID` declarations use the private modifier where possible, since such declarations apply only to the immediately declaring class `serialVersionUID` fields are not useful as inherited members.  
</blockquote>

#### Answer 2 (score 452)
If you're serializing just because you have to serialize for the implementation's sake (who cares if you serialize for an `HTTPSession`, for instance...if it's stored or not, you probably don't care about `de-serializing` a form object), then you can ignore this.  

If you're actually using serialization, it only matters if you plan on storing and retrieving objects using serialization directly.  The `serialVersionUID` represents your class version, and you should increment it if the current version of your class is not backwards compatible with its previous version.  

Most of the time, you will probably not use serialization directly.  If this is the case, generate a default `SerialVersionUID` by clicking the quick fix option and don't worry about it.  

#### Answer 3 (score 293)
I can't pass up this opportunity to plug Josh Bloch's book <a href="https://rads.stackoverflow.com/amzn/click/com/0321356683" rel="noreferrer" rel="nofollow noreferrer">Effective Java</a> (2nd Edition).  Chapter 11 is an indispensible resource on Java serialization.  

Per Josh, the automatically-generated UID is generated based on a class name, implemented interfaces, and all public and protected members.  Changing any of these in any way will change the `serialVersionUID`.  So you don't need to mess with them only if you are certain that no more than one version of the class will ever be serialized (either across processes or retrieved from storage at a later time).  

If you ignore them for now, and find later that you need to change the class in some way but maintain compatibility w/ old version of the class, you can use the JDK tool <strong>serialver</strong> to generate the `serialVersionUID` on the <em>old</em> class, and explicitly set that on the new class.  (Depending on your changes you may need to also implement custom serialization by adding `writeObject` and `readObject` methods - see `Serializable` javadoc or aforementioned chapter 11.)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How can I initialise a static Map? (score [808780](https://stackoverflow.com/q/507602) in 2018)

#### Question
How would you initialise a static `Map` in Java?  

<p>Method one: static initialiser <br>
Method two: instance initialiser (anonymous subclass)
or
some other method?</p>

What are the pros and cons of each?  

Here is an example illustrating the two methods:  

```java
import java.util.HashMap;
import java.util.Map;

public class Test {
    private static final Map<Integer, String> myMap = new HashMap<Integer, String>();
    static {
        myMap.put(1, "one");
        myMap.put(2, "two");
    }

    private static final Map<Integer, String> myMap2 = new HashMap<Integer, String>(){
        {
            put(1, "one");
            put(2, "two");
        }
    };
}
```

#### Answer accepted (score 1064)
The instance initialiser is just syntactic sugar in this case, right? I don't see why you need an extra anonymous class just to initialize. And it won't work if the class being created is final.  

You can create an immutable map using a static initialiser too:  

```java
public class Test {
    private static final Map<Integer, String> myMap;
    static {
        Map<Integer, String> aMap = ....;
        aMap.put(1, "one");
        aMap.put(2, "two");
        myMap = Collections.unmodifiableMap(aMap);
    }
}
```

#### Answer 2 (score 426)
I like the <a href="https://github.com/google/guava" rel="noreferrer">Guava</a> way of initialising a static, immutable map:  

```java
static final Map<Integer, String> MY_MAP = ImmutableMap.of(
    1, "one",
    2, "two"
);
```

As you can see, it's very concise (because of the convenient factory methods in <a href="https://google.github.io/guava/releases/snapshot/api/docs/com/google/common/collect/ImmutableMap.html" rel="noreferrer">`ImmutableMap`</a>).  

If you want the map to have more than 5 entries, you can no longer use `ImmutableMap.of()`. Instead, try <a href="https://google.github.io/guava/releases/snapshot/api/docs/com/google/common/collect/ImmutableMap.html#builder--" rel="noreferrer">`ImmutableMap.builder()`</a> along these lines:  

```java
static final Map<Integer, String> MY_MAP = ImmutableMap.<Integer, String>builder()
    .put(1, "one")
    .put(2, "two")
    // ... 
    .put(15, "fifteen")
    .build();
```

To learn more about the benefits of Guava's immutable collection utilities, see <a href="https://code.google.com/p/guava-libraries/wiki/ImmutableCollectionsExplained" rel="noreferrer"><em>Immutable Collections Explained</em> in Guava User Guide</a>.  

(A subset of) Guava used to be called <em>Google Collections</em>. If you aren't using this library in your Java project yet, I <strong>strongly</strong> recommend trying it out! Guava has quickly become one of the most popular and useful free 3rd party libs for Java, as <a href="https://stackoverflow.com/questions/130095/most-useful-free-third-party-java-libraries/132639#132639">fellow SO users agree</a>. (If you are new to it, there are some excellent learning resources behind that link.)  

<hr>

<strong>Update (2015)</strong>: As for <strong>Java 8</strong>, well, I would still use the Guava approach because it is way cleaner than anything else. If you don't want Guava dependency, consider a <a href="https://stackoverflow.com/a/509016/56285">plain old init method</a>. The hack with <a href="https://stackoverflow.com/a/25829097/56285">two-dimensional array and Stream API</a> is pretty ugly if you ask me, and gets uglier if you need to create a Map whose keys and values are not the same type (like `Map&lt;Integer, String&gt;` in the question).  

As for future of Guava in general, with regards to Java 8, Louis Wasserman <a href="https://groups.google.com/d/msg/guava-discuss/fEdrMyNa8tA/F4XFm6-uA6oJ" rel="noreferrer">said this</a> back in 2014, and [<em>update</em>] in 2016 it was announced that <a href="https://groups.google.com/forum/?utm_medium=email&amp;utm_source=footer#!msg/guava-announce/o954PqvaXLY/7ss96X6sAwAJ" rel="noreferrer"><strong>Guava 21 will require and properly support Java 8</strong></a>.  

<hr>

<strong>Update (2016)</strong>: As <a href="https://stackoverflow.com/questions/507602/how-can-i-initialise-a-static-map/34508760#34508760">Tagir Valeev points out</a>, <strong>Java 9</strong> will finally make this clean to do using nothing but pure JDK, by adding <a href="http://openjdk.java.net/jeps/269" rel="noreferrer">convenience factory methods</a> for collections:  

```java
static final Map<Integer, String> MY_MAP = Map.of(
    1, "one", 
    2, "two"
);
```

#### Answer 3 (score 173)
I would use:  

```java
public class Test {
    private static final Map<Integer, String> MY_MAP = createMap();

    private static Map<Integer, String> createMap() {
        Map<Integer, String> result = new HashMap<Integer, String>();
        result.put(1, "one");
        result.put(2, "two");
        return Collections.unmodifiableMap(result);
    }
}
```

<ol>
<li>it avoids anonymous class, which I personally consider to be a bad style, and avoid</li>
<li>it makes creation of map more explicit</li>
<li>it makes map unmodifiable</li>
<li>as MY_MAP is constant, I would name it like constant</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How do I test a private function or a class that has private methods, fields or inner classes? (score [804279](https://stackoverflow.com/q/34571) in 2019)

#### Question
How do I unit test (using xUnit) a class that has internal private methods, fields or nested classes? Or a function that is made private by having <a href="https://stackoverflow.com/questions/1358400/what-is-external-linkage-and-internal-linkage">internal linkage</a> (`static` in C/C++) or is in a private (<a href="https://stackoverflow.com/questions/154469/unnamed-anonymous-namespaces-vs-static-functions">anonymous</a>) namespace?  

It seems bad to change the access modifier for a method or function just to be able to run a test.   

#### Answer accepted (score 1562)
<blockquote>
  <strong>Update:</strong>  
  
  Some 10 years later perhaps the best way to test a private method, or any inaccessible member, is via <strong>`@Jailbreak`</strong> from the <a href="https://manifold.systems" rel="noreferrer">Manifold</a> framework.  

```java
@Jailbreak Foo foo = new Foo();
// Direct, *type-safe* access to *all* foo's members
foo.privateMethod(x, y, z);
foo.privateField = value;
```
  
  This way your code remains type-safe and readable.  No design compromises, no overexposing methods and fields for the sake of tests.  
</blockquote>

If you have somewhat of a legacy <strong>Java</strong> application, and you're not allowed to change the visibility of your methods, the best way to test private methods is to use <a href="http://en.wikipedia.org/wiki/Reflection_%28computer_programming%29" rel="noreferrer">reflection</a>.   

Internally we're using helpers to get/set `private` and `private static` variables as well as invoke `private` and `private static` methods. The following patterns will let you do pretty much anything related to the private methods and fields. Of course, you can't change `private static final` variables through reflection.  

```java
Method method = TargetClass.getDeclaredMethod(methodName, argClasses);
method.setAccessible(true);
return method.invoke(targetObject, argObjects);
```

And for fields:  

```java
Field field = TargetClass.getDeclaredField(fieldName);
field.setAccessible(true);
field.set(object, value);
```

<hr>

<blockquote>
  <p><strong>Notes:</strong><br>
  1. `TargetClass.getDeclaredMethod(methodName, argClasses)` lets you look into `private` methods. The same thing applies for
  `getDeclaredField`.<br>
  2. The `setAccessible(true)` is required to play around with privates.</p>
</blockquote>

#### Answer 2 (score 574)
The best way to test a private method is via another public method. If this cannot be done, then one of the following conditions is true:  

<ol>
<li>The private method is dead code</li>
<li>There is a design smell near the class that you are testing</li>
<li>The method that you are trying to test should not be private</li>
</ol>

#### Answer 3 (score 301)
When I have private methods in a class that are sufficiently complicated that I feel the need to test the private methods directly, that is a code smell: my class is too complicated.    

My usual approach to addressing such issues is to tease out a new class that contains the interesting bits.  Often, this method and the fields it interacts with, and maybe another method or two can be extracted in to a new class.    

The new class exposes these methods as 'public', so they're accessible for unit testing.  The new and old classes are now both simpler than the original class, which is great for me (I need to keep things simple, or I get lost!).  

Note that I'm not suggesting that people create classes without using their brain! The point here is to use the forces of unit testing to help you find good new classes.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: How do I call one constructor from another in Java? (score [798292](https://stackoverflow.com/q/285177) in 2008)

#### Question
Is it possible to call a constructor from another (within the same class, not from a subclass)? If yes how? And what could be the best way to call another constructor (if there are several ways to do it)?  

#### Answer accepted (score 2825)
Yes, it is possible:  

```java
public class Foo {
    private int x;

    public Foo() {
        this(1);
    }

    public Foo(int x) {
        this.x = x;
    }
}
```

To chain to a particular superclass constructor instead of one in the same class, use `super` instead of `this`. Note that <strong>you can only chain to one constructor</strong>, and <strong>it has to be the first statement in your constructor body</strong>.  

See also <a href="https://stackoverflow.com/questions/284896">this related question</a>, which is about C# but where the same principles apply.  

#### Answer 2 (score 233)
Using `this(args)`. The preferred pattern is to work from the smallest constructor to the largest.  

```java
public class Cons {

    public Cons() {
        // A no arguments constructor that sends default values to the largest
        this(madeUpArg1Value,madeUpArg2Value,madeUpArg3Value);
    }

    public Cons(int arg1, int arg2) {
       // An example of a partial constructor that uses the passed in arguments
        // and sends a hidden default value to the largest
        this(arg1,arg2, madeUpArg3Value);
    }

    // Largest constructor that does the work
    public Cons(int arg1, int arg2, int arg3) {
        this.arg1 = arg1;
        this.arg2 = arg2;
        this.arg3 = arg3;
    }
}
```

You can also use a more recently advocated approach of valueOf or just "of":  

```java
public class Cons {
    public static Cons newCons(int arg1,...) {
        // This function is commonly called valueOf, like Integer.valueOf(..)
        // More recently called "of", like EnumSet.of(..)
        Cons c = new Cons(...);
        c.setArg1(....);
        return c;
    }
} 
```

To call a super class, use `super(someValue)`. The call to super must be the first call in the constructor or you will get a compiler error.  

#### Answer 3 (score 195)
[<em>Note: I just want to add one aspect, which I did not see in the other answers: how to overcome limitations of the requirement that this() has to be on the first line).</em>]  

In Java another constructor of the same class can be called from a constructor via `this()`. Note however that `this` has to be on the first line.  

```java
public class MyClass {

  public MyClass(double argument1, double argument2) {
    this(argument1, argument2, 0.0);
  }

  public MyClass(double argument1, double argument2, double argument3) {
    this.argument1 = argument1;
    this.argument2 = argument2;
    this.argument3 = argument3;
  }
}
```

That `this` has to appear on the first line looks like a big limitation, but you can construct the arguments of other constructors via static methods. For example:  

```java
public class MyClass {

  public MyClass(double argument1, double argument2) {
    this(argument1, argument2, getDefaultArg3(argument1, argument2));
  }

  public MyClass(double argument1, double argument2, double argument3) {
    this.argument1 = argument1;
    this.argument2 = argument2;
    this.argument3 = argument3;
  }

  private static double getDefaultArg3(double argument1, double argument2) {
    double argument3 = 0;

    // Calculate argument3 here if you like.

    return argument3;

  }

}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How to add local jar files to a Maven project? (score [786969](https://stackoverflow.com/q/4955635) in 2018)

#### Question
How do I add local jar files (not yet part of the Maven repository) directly in my project's library sources?  

#### Answer accepted (score 592)
Install the JAR into your local Maven repository as follows:  

```java
mvn install:install-file \
   -Dfile=<path-to-file> \
   -DgroupId=<group-id> \
   -DartifactId=<artifact-id> \
   -Dversion=<version> \
   -Dpackaging=<packaging> \
   -DgeneratePom=true
```

Where each refers to:   

`&lt;path-to-file&gt;`: the path to the file to load e.g → `c:\kaptcha-2.3.jar`  

`&lt;group-id&gt;`: the group that the file should be registered under e.g → `com.google.code`  

`&lt;artifact-id&gt;`: the artifact name for the file e.g → `kaptcha`  

`&lt;version&gt;`: the version of the file e.g → `2.3`  

`&lt;packaging&gt;`: the packaging of the file e.g. → `jar`  

<strong>Reference</strong>  

<ul>
<li>Maven FAQ: <a href="http://maven.apache.org/general.html#importing-jars" rel="noreferrer">I have a jar that I want to put into my local repository. How can I copy it in?</a></li>
<li>Maven Install Plugin Usage: <a href="https://maven.apache.org/plugins/maven-install-plugin/usage.html#The_install:install-file_goal" rel="noreferrer">The `install:install-file` goal</a></li>
</ul>

#### Answer 2 (score 1299)
You can add local dependencies directly (as mentioned in <a href="https://stackoverflow.com/questions/4491199/build-maven-project-with-propriatery-libraries-included/4491343#4491343">build maven project with propriatery libraries included</a>) like this:  

```java
<dependency>
    <groupId>com.sample</groupId>
    <artifactId>sample</artifactId>
    <version>1.0</version>
    <scope>system</scope>
    <systemPath>${project.basedir}/src/main/resources/Name_Your_JAR.jar</systemPath>
</dependency>
```

<strong>Update</strong>  

In new releases this feature is marked as deprecated but still working and not removed yet ( You just see warning in the log during maven start). An issue is raised at maven group about this <a href="https://issues.apache.org/jira/browse/MNG-6523" rel="noreferrer">https://issues.apache.org/jira/browse/MNG-6523</a> ( You can participate and describe why this feature is helpful in some cases). I hope this feature remains there!   

If you are asking me, as long as the feature is not removed, I use this to <strong>make dependency to only <em>one</em> naughty jar file</strong> in my project which is not fit in repository. If this feature is removed, well, there are lots of good answers here which I can chose from later!    

#### Answer 3 (score 120)
Firstly, I would like to give credit for this answer to an anonymous Stack Overflow user - I am pretty sure I've seen a similar answer here before - but now I cannot find it.   

The best option for having local JAR files as a dependency is to create a local Maven repository. Such a repository is nothing more than a proper directory structure with pom files in it.   

<p>For my example:
I have my master project on `${master_project}` location and subproject1 is on `${master_project}/${subproject1}`.</p>

<p>Then I create a Maven repository in:
`${master_project}/local-maven-repo`.</p>

In the pom file in subproject1 located at `${master_project}/${subproject1}/pom.xml`, the repository needs to be specified which would take file path as a URL parameter:  

```java
<repositories>
    <repository>
        <id>local-maven-repo</id>
        <url>file:///${project.parent.basedir}/local-maven-repo</url>
    </repository>
</repositories>
```

The dependency can be specified as for any other repository. This makes your pom repository independent. For instance, once the desired JAR is available in Maven central, you just need to delete it from your local repo and it will be pulled from the default repo.   

```java
    <dependency>
        <groupId>org.apache.felix</groupId>
        <artifactId>org.apache.felix.servicebinder</artifactId>
        <version>0.9.0-SNAPSHOT</version>
    </dependency>
```

The last but not least thing to do is to add the JAR file to local repository using -DlocalRepositoryPath switch like so:  

```java
mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file  \
    -Dfile=/some/path/on/my/local/filesystem/felix/servicebinder/target/org.apache.felix.servicebinder-0.9.0-SNAPSHOT.jar \
    -DgroupId=org.apache.felix -DartifactId=org.apache.felix.servicebinder \
    -Dversion=0.9.0-SNAPSHOT -Dpackaging=jar \
    -DlocalRepositoryPath=${master_project}/local-maven-repo
```

Once the JAR file is installed, your Maven repo can be committed to a code repository, and the whole set-up is system independent. (<a href="https://github.com/jjromannet/apache-felix-tutorials" rel="noreferrer">Working example in GitHub</a>).  

I agree that having JARs committed to source code repo is not a good practice, but in real life, quick and dirty solutions are sometimes better than a full blown Nexus repo to host one JAR that you cannot publish.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: Difference between StringBuilder and StringBuffer (score [761903](https://stackoverflow.com/q/355089) in 2016)

#### Question
<p>What is the main difference between `StringBuffer` and `StringBuilder`?
Is there any performance issues when deciding on any one of these?</p>

#### Answer accepted (score 1596)
<a href="http://docs.oracle.com/javase/8/docs/api/java/lang/StringBuffer.html" rel="noreferrer">`StringBuffer`</a> is synchronized, <a href="http://docs.oracle.com/javase/8/docs/api/java/lang/StringBuilder.html" rel="noreferrer">`StringBuilder`</a> is not.  

#### Answer 2 (score 711)
<a href="http://docs.oracle.com/javase/9/docs/api/java/lang/StringBuilder.html" rel="noreferrer">`StringBuilder`</a> is faster than <a href="https://docs.oracle.com/javase/9/docs/api/java/lang/StringBuffer.html" rel="noreferrer">`StringBuffer`</a> because it's not `synchronized`.  

Here's a simple benchmark test:  

```java
public class Main {
    public static void main(String[] args) {
        int N = 77777777;
        long t;

        {
            StringBuffer sb = new StringBuffer();
            t = System.currentTimeMillis();
            for (int i = N; i --> 0 ;) {
                sb.append("");
            }
            System.out.println(System.currentTimeMillis() - t);
        }

        {
            StringBuilder sb = new StringBuilder();
            t = System.currentTimeMillis();
            for (int i = N; i > 0 ; i--) {
                sb.append("");
            }
            System.out.println(System.currentTimeMillis() - t);
        }
    }
}
```

A <a href="http://ideone.com/OpUDPU" rel="noreferrer">test run</a> gives the numbers of `2241 ms` for `StringBuffer` vs `753 ms` for `StringBuilder`.  

#### Answer 3 (score 239)
Basically, `StringBuffer` methods are synchronized while `StringBuilder` are not.  

The operations are "almost" the same, but using synchronized methods in a single thread is overkill.  

That's pretty much about it.  

Quote from <a href="http://docs.oracle.com/javase/8/docs/api/java/lang/StringBuilder.html" rel="noreferrer">StringBuilder API</a>:  

<blockquote>
  This class [StringBuilder] provides an API compatible with StringBuffer, <strong>but with no guarantee of synchronization</strong>. This class is designed for use as a drop-in replacement for StringBuffer in places where the string buffer was being used by a single thread (as is generally the case). Where possible, it is recommended that this class be used in preference to StringBuffer as <strong>it will be faster under most implementations.</strong>  
</blockquote>

So it was made to substitute it.  

The same happened with `Vector` and `ArrayList`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: How to create a generic array in Java? (score [727576](https://stackoverflow.com/q/529085) in 2017)

#### Question
Due to the implementation of Java generics, you can't have code like this:   

```java
public class GenSet<E> {
    private E a[];

    public GenSet() {
        a = new E[INITIAL_ARRAY_LENGTH]; // error: generic array creation
    }
}
```

How can I implement this while maintaining type safety?  

I saw a solution on the Java forums that goes like this:  

```java
import java.lang.reflect.Array;

class Stack<T> {
    public Stack(Class<T> clazz, int capacity) {
        array = (T[])Array.newInstance(clazz, capacity);
    }

    private final T[] array;
}
```

But I really don't get what's going on.  

#### Answer accepted (score 671)
<p>I have to ask a question in return: is your `GenSet` "checked" or "unchecked"?
What does that mean?</p>

<ul>
<li><p><strong>Checked</strong>: <em>strong typing</em>. `GenSet` knows explicitly what type of objects it contains (i.e. its constructor was explicitly called with a `Class&lt;E&gt;` argument, and methods will throw an exception when they are passed arguments that are not of type `E`. See <a href="http://docs.oracle.com/javase/7/docs/api/java/util/Collections.html#checkedCollection%28java.util.Collection,%20java.lang.Class%29" rel="noreferrer">`Collections.checkedCollection`</a>.</p>

-> in that case, you should write:  

```java
public class GenSet<E> {

    private E[] a;

    public GenSet(Class<E> c, int s) {
        // Use Array native method to create array
        // of a type only known at run time
        @SuppressWarnings("unchecked")
        final E[] a = (E[]) Array.newInstance(c, s);
        this.a = a;
    }

    E get(int i) {
        return a[i];
    }
}
```</li>
<li><p><strong>Unchecked</strong>: <em>weak typing</em>. No type checking is actually done on any of the objects passed as argument.</p>

-> in that case, you should write  

```java
public class GenSet<E> {

    private Object[] a;

    public GenSet(int s) {
        a = new Object[s];
    }

    E get(int i) {
        @SuppressWarnings("unchecked")
        final E e = (E) a[i];
        return e;
    }
}
```

Note that the component type of the array should be the <a href="http://docs.oracle.com/javase/tutorial/java/generics/erasure.html" rel="noreferrer"><em>erasure</em></a> of the type parameter:  

```java
public class GenSet<E extends Foo> { // E has an upper bound of Foo

    private Foo[] a; // E erases to Foo, so use Foo[]

    public GenSet(int s) {
        a = new Foo[s];
    }

    ...
}
```</li>
</ul>

All of this results from a known, and deliberate, weakness of generics in Java: it was implemented using erasure, so "generic" classes don't know what type argument they were created with at run time, and therefore can not provide type-safety unless some explicit mechanism (type-checking) is implemented.  

#### Answer 2 (score 192)
You can do this:  

```java
E[] arr = (E[])new Object[INITIAL_ARRAY_LENGTH];
```

This is one of the suggested ways of implementing a generic collection in <em>Effective Java; Item 26</em>.  No type errors, no need to cast the array repeatedly.  <em>However</em> this triggers a warning because it is potentially dangerous, and should be used with caution.  As detailed in the comments, this `Object[]` is now masquerading as our `E[]` type, and can cause unexpected errors or `ClassCastException`s if used unsafely.  

As a rule of thumb, this behavior is safe as long as the cast array is used internally (e.g. to back a data structure), and not returned or exposed to client code.  Should you need to return an array of a generic type to other code, the reflection `Array` class you mention is the right way to go.  

<hr>

Worth mentioning that wherever possible, you'll have a much happier time working with `List`s rather than arrays if you're using generics.  Certainly sometimes you don't have a choice, but using the collections framework is far more robust.  

#### Answer 3 (score 61)
Here's how to use generics to get an array of precisely the type you’re looking for while preserving type safety (as opposed to the other answers, which will either give you back an `Object` array or result in warnings at compile time):  

```java
import java.lang.reflect.Array;  

public class GenSet<E> {  
    private E[] a;  

    public GenSet(Class<E[]> clazz, int length) {  
        a = clazz.cast(Array.newInstance(clazz.getComponentType(), length));  
    }  

    public static void main(String[] args) {  
        GenSet<String> foo = new GenSet<String>(String[].class, 1);  
        String[] bar = foo.a;  
        foo.a[0] = "xyzzy";  
        String baz = foo.a[0];  
    }  
}
```

That compiles without warnings, and as you can see in `main`, for whatever type you declare an instance of `GenSet` as, you can assign `a` to an array of that type, and you can assign an element from `a` to a variable of that type, meaning that the array and the values in the array are of the correct type.  

It works by using class literals as runtime type tokens, as discussed in the <a href="http://download.oracle.com/javase/tutorial/extra/generics/literals.html" rel="noreferrer">Java Tutorials</a>. Class literals are treated by the compiler as instances of `java.lang.Class`. To use one, simply follow the name of a class with `.class`. So, `String.class` acts as a `Class` object representing the class `String`. This also works for interfaces, enums, any-dimensional arrays (e.g. `String[].class`), primitives (e.g. `int.class`), and the keyword `void` (i.e. `void.class`).   

`Class` itself is generic (declared as `Class&lt;T&gt;`, where `T` stands for the type that the `Class` object is representing), meaning that the type of `String.class` is `Class&lt;String&gt;`.  

So, whenever you call the constructor for `GenSet`, you pass in a class literal for the first argument representing an array of the `GenSet` instance's declared type (e.g. `String[].class` for `GenSet&lt;String&gt;`). Note that you won't be able to get an array of primitives, since primitives can't be used for type variables.  

Inside the constructor, calling the method `cast` returns the passed `Object` argument cast to the class represented by the `Class` object on which the method was called. Calling the static method `newInstance` in `java.lang.reflect.Array` returns as an `Object` an array of the type represented by the `Class` object passed as the first argument and of the length specified by the `int` passed as the second argument. Calling the method `getComponentType` returns a `Class` object representing the component type of the array represented by the `Class` object on which the method was called (e.g. `String.class` for `String[].class`, `null` if the `Class` object doesn't represent an array).  

That last sentence isn't entirely accurate. Calling `String[].class.getComponentType()` returns a `Class` object representing the class `String`, but its type is `Class&lt;?&gt;`, not `Class&lt;String&gt;`, which is why you can't do something like the following.  

```java
String foo = String[].class.getComponentType().cast("bar"); // won't compile
```

Same goes for every method in `Class` that returns a `Class` object.  

Regarding Joachim Sauer's comment on <a href="https://stackoverflow.com/questions/529085/java-how-to-generic-array-creation/529094#529094">this answer</a> (I don't have enough reputation to comment on it myself), the example using the cast to `T[]` will result in a warning because the compiler can't guarantee type safety in that case.  

<hr>

Edit regarding Ingo's comments:  

```java
public static <T> T[] newArray(Class<T[]> type, int size) {
   return type.cast(Array.newInstance(type.getComponentType(), size));
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Java inner class and static nested class (score [695972](https://stackoverflow.com/q/70324) in 2019)

#### Question
What is the main difference between an inner class and a static nested class in Java? Does design / implementation play a role in choosing one of these?  

#### Answer accepted (score 1632)
From the <a href="http://java.sun.com/docs/books/tutorial/java/javaOO/nested.html" rel="noreferrer">Java Tutorial</a>:  

<blockquote>
  Nested classes are divided into two categories: static and non-static. Nested classes that are declared static are simply called static nested classes. Non-static nested classes are called inner classes.   
</blockquote>

Static nested classes are accessed using the enclosing class name:  

```java
OuterClass.StaticNestedClass
```

For example, to create an object for the static nested class, use this syntax:  

```java
OuterClass.StaticNestedClass nestedObject = new OuterClass.StaticNestedClass();
```

Objects that are instances of an inner class exist within an instance of the outer class. Consider the following classes:  

```java
class OuterClass {
    ...
    class InnerClass {
        ...
    }
}
```

An instance of InnerClass can exist only within an instance of OuterClass and has direct access to the methods and fields of its enclosing instance.  

To instantiate an inner class, you must first instantiate the outer class. Then, create the inner object within the outer object with this syntax:  

```java
OuterClass.InnerClass innerObject = outerObject.new InnerClass();
```

see: <a href="http://download.oracle.com/javase/tutorial/java/javaOO/nested.html" rel="noreferrer">Java Tutorial - Nested Classes</a>  

For completeness note that there is also such a thing as an <a href="https://stackoverflow.com/questions/20468856/is-it-true-that-every-inner-class-requires-an-enclosing-instance">inner class <em>without</em> an enclosing instance</a>:  

```java
class A {
  int t() { return 1; }
  static A a =  new A() { int t() { return 2; } };
}
```

Here, `new A() { ... }` is an <em>inner class defined in a static context</em> and does not have an enclosing instance.  

#### Answer 2 (score 575)
The <a href="http://java.sun.com/docs/books/tutorial/java/javaOO/nested.html" rel="noreferrer">Java tutorial says</a>:  

<blockquote>
  <p>Terminology: Nested classes are
  divided into two categories: static
  and non-static. Nested classes that
  are declared static are simply called
  static nested classes. Non-static
  nested classes are called inner
  classes.</p>
</blockquote>

In common parlance, the terms "nested" and "inner" are used interchangeably by most programmers, but I'll use the correct term "nested class" which covers both inner and static.  

Classes can be nested <em>ad infinitum</em>, e.g. class A can contain class B which contains class C which contains class D, etc. However, more than one level of class nesting is rare, as it is generally bad design.  

There are three reasons you might create a nested class:  

<ul>
<li>organization: sometimes it seems most sensible to sort a class into the namespace of another class, especially when it won't be used in any other context</li>
<li>access: nested classes have special access to the variables/fields of their containing classes (precisely which variables/fields depends on the kind of nested class, whether inner or static).</li>
<li>convenience: having to create a new file for every new type is bothersome, again, especially when the type will only be used in one context</li>
</ul>

There are <strong>four kinds of nested class in Java</strong>. In brief, they are:  

<ul>
<li><strong>static class</strong>: declared as a static member of another class</li>
<li><strong>inner class</strong>: declared as an instance member of another class</li>
<li><strong>local inner class</strong>: declared inside an instance method of another class</li>
<li><strong>anonymous inner class</strong>: like a local inner class, but written as an expression which returns a one-off object</li>
</ul>

Let me elaborate in more details.  

<br>  

<h5>Static Classes</h2>

Static classes are the easiest kind to understand because they have nothing to do with instances of the containing class.  

A static class is a class declared as a static member of another class. Just like other static members, such a class is really just a hanger on that uses the containing class as its namespace, <em>e.g.</em> the class <em>Goat</em> declared as a static member of class <em>Rhino</em> in the package <em>pizza</em> is known by the name <em>pizza.Rhino.Goat</em>.  

```java
package pizza;

public class Rhino {

    ...

    public static class Goat {
        ...
    }
}
```

Frankly, static classes are a pretty worthless feature because classes are already divided into namespaces by packages. The only real conceivable reason to create a static class is that such a class has access to its containing class's private static members, but I find this to be a pretty lame justification for the static class feature to exist.  

<br>  

<h5>Inner Classes</h2>

An inner class is a class declared as a non-static member of another class:  

```java
package pizza;

public class Rhino {

    public class Goat {
        ...
    }

    private void jerry() {
        Goat g = new Goat();
    }
}
```

Like with a static class, the inner class is known as qualified by its containing class name, <em>pizza.Rhino.Goat</em>, but inside the containing class, it can be known by its simple name. However, every instance of an inner class is tied to a particular instance of its containing class: above, the <em>Goat</em> created in <em>jerry</em>, is implicitly tied to the <em>Rhino</em> instance <em>this</em> in <em>jerry</em>. Otherwise, we make the associated <em>Rhino</em> instance explicit when we instantiate <em>Goat</em>:  

```java
Rhino rhino = new Rhino();
Rhino.Goat goat = rhino.new Goat();
```

(Notice you refer to the inner type as just <em>Goat</em> in the weird <em>new</em> syntax: Java infers the containing type from the <em>rhino</em> part. And, yes <em>new rhino.Goat()</em> would have made more sense to me too.)  

So what does this gain us? Well, the inner class instance has access to the instance members of the containing class instance. These enclosing instance members are referred to inside the inner class <em>via</em> just their simple names, not <em>via</em> <em>this</em> (<em>this</em> in the inner class refers to the inner class instance, not the associated containing class instance):   

```java
public class Rhino {

    private String barry;

    public class Goat {
        public void colin() {
            System.out.println(barry);
        }
    }
}
```

In the inner class, you can refer to <em>this</em> of the containing class as <em>Rhino.this</em>, and you can use <em>this</em> to refer to its members, <em>e.g. Rhino.this.barry</em>.  

<br>  

<h5>Local Inner Classes</h2>

A local inner class is a class declared in the body of a method. Such a class is only known within its containing method, so it can only be instantiated and have its members accessed within its containing method. The gain is that a local inner class instance is tied to and can access the final local variables of its containing method. When the instance uses a final local of its containing method, the variable retains the value it held at the time of the instance's creation, even if the variable has gone out of scope (this is effectively Java's crude, limited version of closures).  

Because a local inner class is neither the member of a class or package, it is not declared with an access level. (Be clear, however, that its own members have access levels like in a normal class.)  

If a local inner class is declared in an instance method, an instantiation of the inner class is tied to the instance held by the containing method's <em>this</em> at the time of the instance's creation, and so the containing class's instance members are accessible like in an instance inner class. A local inner class is instantiated simply <em>via</em> its name, <em>e.g.</em> local inner class <em>Cat</em> is instantiated as <em>new Cat()</em>, not new this.Cat() as you might expect.  

<br>  

<h5>Anonymous Inner Classes</h2>

An anonymous inner class is a syntactically convenient way of writing a local inner class. Most commonly, a local inner class is instantiated at most just once each time its containing method is run. It would be nice, then, if we could combine the local inner class definition and its single instantiation into one convenient syntax form, and it would also be nice if we didn't have to think up a name for the class (the fewer unhelpful names your code contains, the better). An anonymous inner class allows both these things:  

```java
new *ParentClassName*(*constructorArgs*) {*members*}
```

This is an expression returning a new instance of an unnamed class which extends <em>ParentClassName</em>. You cannot supply your own constructor; rather, one is implicitly supplied which simply calls the super constructor, so the arguments supplied must fit the super constructor. (If the parent contains multiple constructors, the “simplest” one is called, “simplest” as determined by a rather complex set of rules not worth bothering to learn in detail--just pay attention to what NetBeans or Eclipse tell you.)  

Alternatively, you can specify an interface to implement:  

```java
new *InterfaceName*() {*members*}
```

Such a declaration creates a new instance of an unnamed class which extends Object and implements <em>InterfaceName</em>. Again, you cannot supply your own constructor; in this case, Java implicitly supplies a no-arg, do-nothing constructor (so there will never be constructor arguments in this case).  

Even though you can't give an anonymous inner class a constructor, you can still do any setup you want using an initializer block (a {} block placed outside any method).  

Be clear that an anonymous inner class is simply a less flexible way of creating a local inner class with one instance. If you want a local inner class which implements multiple interfaces or which implements interfaces while extending some class other than <em>Object</em> or which specifies its own constructor, you're stuck creating a regular named local inner class.  

#### Answer 3 (score 140)
I don't think the real difference became clear in the above answers.   

First to get the terms right:   

<ul>
<li>A nested class is a class which is contained in another class at the source code level.</li>
<li>It is static if you declare it with the <strong>static</strong> modifier.</li>
<li>A non-static nested class is called inner class. (I stay with non-static nested class.)</li>
</ul>

Martin's answer is right so far. However, the actual question is: What is the purpose of declaring a nested class static or not?  

You use <strong>static nested classes</strong> if you just want to keep your classes together if they belong topically together or if the nested class is exclusively used in the enclosing class. There is no semantic difference between a static nested class and every other class.  

<strong>Non-static nested classes</strong> are a different beast. Similar to anonymous inner classes, such nested classes are actually closures. That means they capture their surrounding scope and their enclosing instance and make that accessible. Perhaps an example will clarify that. See this stub of a Container:  

```java
public class Container {
    public class Item{
        Object data;
        public Container getContainer(){
            return Container.this;
        }
        public Item(Object data) {
            super();
            this.data = data;
        }

    }

    public static Item create(Object data){
        // does not compile since no instance of Container is available
        return new Item(data);
    }
    public Item createSubItem(Object data){
        // compiles, since 'this' Container is available
        return new Item(data);
    }
}
```

In this case you want to have a reference from a child item to the parent container. Using a non-static nested class, this works without some work. You can access the enclosing instance of Container with the syntax `Container.this`.  

More hardcore explanations following:  

If you look at the Java bytecodes the compiler generates for an (non-static) nested class it might become even clearer:  

```java
// class version 49.0 (49)
// access flags 33
public class Container$Item {

  // compiled from: Container.java
  // access flags 1
  public INNERCLASS Container$Item Container Item

  // access flags 0
  Object data

  // access flags 4112
  final Container this$0

  // access flags 1
  public getContainer() : Container
   L0
    LINENUMBER 7 L0
    ALOAD 0: this
    GETFIELD Container$Item.this$0 : Container
    ARETURN
   L1
    LOCALVARIABLE this Container$Item L0 L1 0
    MAXSTACK = 1
    MAXLOCALS = 1

  // access flags 1
  public <init>(Container,Object) : void
   L0
    LINENUMBER 12 L0
    ALOAD 0: this
    ALOAD 1
    PUTFIELD Container$Item.this$0 : Container
   L1
    LINENUMBER 10 L1
    ALOAD 0: this
    INVOKESPECIAL Object.<init>() : void
   L2
    LINENUMBER 11 L2
    ALOAD 0: this
    ALOAD 2: data
    PUTFIELD Container$Item.data : Object
    RETURN
   L3
    LOCALVARIABLE this Container$Item L0 L3 0
    LOCALVARIABLE data Object L0 L3 2
    MAXSTACK = 2
    MAXLOCALS = 3
}
```

As you can see the compiler creates a hidden field `Container this$0`. This is set in the constructor which has an additional parameter of type Container to specify the enclosing instance. You can't see this parameter in the source but the compiler implicitly generates it for a nested class.   

Martin's example  

```java
OuterClass.InnerClass innerObject = outerObject.new InnerClass();
```

would so be compiled to a call of something like (in bytecodes)  

```java
new InnerClass(outerObject)
```

For the sake of completeness:  

An anonymous class <strong>is</strong> a perfect example of a non-static nested class which just has no name associated with it and can't be referenced later.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: "implements Runnable" vs "extends Thread" in Java (score [663876](https://stackoverflow.com/q/541487) in 2018)

#### Question
From what time I've spent with threads in Java, I've found these two ways to write threads:  

With `implements Runnable`:  

```java
public class MyRunnable implements Runnable {
    public void run() {
        //Code
    }
}
//Started with a "new Thread(new MyRunnable()).start()" call
```

Or, with `extends Thread`:  

```java
public class MyThread extends Thread {
    public MyThread() {
        super("MyThread");
    }
    public void run() {
        //Code
    }
}
//Started with a "new MyThread().start()" call
```

Is there any significant difference in these two blocks of code ?  

#### Answer accepted (score 1597)
Yes: implements `Runnable` is the preferred way to do it, IMO. You're not really specialising the thread's behaviour.  You're just giving it something to run. That means <a href="http://en.wikipedia.org/wiki/Object_composition" rel="noreferrer">composition</a> is the <em>philosophically</em> "purer" way to go.  

In <em>practical</em> terms, it means you can implement `Runnable` and extend from another class as well.  

#### Answer 2 (score 545)
<strong>tl;dr: implements Runnable is better.  However, the caveat is important</strong>  

In general, I would recommend using something like `Runnable` rather than `Thread` because it allows you to keep your work only loosely coupled with your choice of concurrency.  For example, if you use a `Runnable` and decide later on that this doesn't in fact require it's own `Thread`, you can just call threadA.run().  

<strong>Caveat:</strong> Around here, I strongly discourage the use of raw Threads.  I much prefer the use of <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/Callable.html" rel="noreferrer">Callables</a> and <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/FutureTask.html" rel="noreferrer">FutureTasks</a> (From the javadoc: "A cancellable asynchronous computation").  The integration of timeouts, proper cancelling and the thread pooling of the modern concurrency support are all much more useful to me than piles of raw Threads.  

<strong>Follow-up:</strong> there is a <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/FutureTask.html#FutureTask-java.lang.Runnable-V-" rel="noreferrer">`FutureTask` constructor</a> that allows you to use Runnables (if that's what you are most comfortable with) and still get the benefit of the modern concurrency tools.  <a href="https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/FutureTask.html#FutureTask-java.lang.Runnable-V-" rel="noreferrer">To quote the javadoc</a>:  

If you don't need a particular result, consider using constructions of the form:   

```java
Future<?> f = new FutureTask<Object>(runnable, null)
```

So, if we replace their `runnable` with your `threadA`, we get the following:  

```java
new FutureTask<Object>(threadA, null)
```

Another option that allows you to stay closer to Runnables is a <a href="http://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ThreadPoolExecutor.html" rel="noreferrer">ThreadPoolExecutor</a>.  You can use the <a href="http://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ThreadPoolExecutor.html#execute%28java.lang.Runnable%29" rel="noreferrer">execute</a> method to pass in a Runnable to execute "the given task sometime in the future."  

If you'd like to try using a thread pool, the code fragment above would become something like the following (using the <a href="http://docs.oracle.com/javase/8/docs/api/java/util/concurrent/Executors.html#newCachedThreadPool%28%29" rel="noreferrer">Executors.newCachedThreadPool()</a> factory method):  

```java
ExecutorService es = Executors.newCachedThreadPool();
es.execute(new ThreadA());
```

#### Answer 3 (score 251)
Moral of the story:  

<em>Inherit only if you want to override some behavior.</em>  

Or rather it should be read as:  

<em>Inherit less, interface more.</em>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Why does Java have transient fields? (score [663871](https://stackoverflow.com/q/910374) in 2016)

#### Question
Why does Java have <strong>transient</strong> fields?  

#### Answer accepted (score 1602)
The `transient` keyword in Java is used to indicate that a field should not be  part of the serialization (which means saved, <em>like</em> to a file) process.  

From the <a href="http://docs.oracle.com/javase/specs/jls/se7/html/index.html" rel="noreferrer">Java Language Specification, Java SE 7 Edition</a>, <a href="http://docs.oracle.com/javase/specs/jls/se7/html/jls-8.html#jls-8.3.1.3" rel="noreferrer">Section 8.3.1.3. `transient` Fields</a>:  

<blockquote>
  <p>Variables may be marked `transient` to
  indicate that they are not part of the
  persistent state of an object.</p>
</blockquote>

For example, you may have fields that are derived from other fields, and should only be done so programmatically, rather than having the state be persisted via serialization.   

Here's a `GalleryImage` class which contains an image and a thumbnail derived from the image:  

```java
class GalleryImage implements Serializable
{
    private Image image;
    private transient Image thumbnailImage;

    private void generateThumbnail()
    {
        // Generate thumbnail.
    }

    private void readObject(ObjectInputStream inputStream)
            throws IOException, ClassNotFoundException
    {
        inputStream.defaultReadObject();
        generateThumbnail();
    }    
}
```

In this example, the `thumbnailImage` is a thumbnail image that is generated by invoking the `generateThumbnail` method.  

The `thumbnailImage` field is marked as `transient`, so only the original `image` is serialized rather than persisting both the original image and the thumbnail image. This means that less storage would be needed to save the serialized object. (Of course, this may or may not be desirable depending on the requirements of the system -- this is just an example.)  

At the time of deserialization, the <a href="http://java.sun.com/javase/6/docs/api/java/io/ObjectInputStream.html#readObject()" rel="noreferrer">`readObject`</a> method is called to perform any operations necessary to restore the state of the object back to the state at which the serialization occurred. Here, the thumbnail needs to be generated, so the `readObject` method is overridden so that the thumbnail will be generated by calling the `generateThumbnail` method.  

For additional information, the <a href="http://www.oracle.com/technetwork/articles/java/javaserial-1536170.html" rel="noreferrer">Discover the secrets of the Java Serialization API</a> article (which was originally available on the Sun Developer Network) has a section which discusses the use of and presents a scenario where the `transient` keyword is used to prevent serialization of certain fields.  

#### Answer 2 (score 414)
Before understanding the `transient` keyword, one has to understand the concept of serialization. If the reader knows about serialization, please skip the first point.  

<h5>What is serialization?</h3>

Serialization is the process of making the object's state persistent. That means the state of the object is converted into a stream of bytes to be used for persisting (e.g. storing bytes in a file) or transferring (e.g. sending bytes across a network). In the same way, we can use the deserialization to bring back the object's state from bytes. This is one of the important concepts in Java programming because serialization is mostly used in networking programming. The objects that need to be transmitted through the network have to be converted into bytes. For that purpose, every class or interface must implement the <a href="https://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html" rel="noreferrer">`Serializable`</a> interface. It is a marker interface without any methods.  

<h5>Now what is the `transient` keyword and its purpose?</h3>

By default, all of object's variables get converted into a persistent state. In some cases, you may want to avoid persisting some variables because you don't have the need to persist those variables. So you can declare those variables as `transient`. If the variable is declared as `transient`, then it will not be persisted. That is the main purpose of the `transient` keyword.  

I want to explain the above two points with the following example:  

```java
package javabeat.samples;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

class NameStore implements Serializable{
    private String firstName;
    private transient String middleName;
    private String lastName;

    public NameStore (String fName, String mName, String lName){
        this.firstName = fName;
        this.middleName = mName;
        this.lastName = lName;
    }

    public String toString(){
        StringBuffer sb = new StringBuffer(40);
        sb.append("First Name : ");
        sb.append(this.firstName);
        sb.append("Middle Name : ");
        sb.append(this.middleName);
        sb.append("Last Name : ");
        sb.append(this.lastName);
        return sb.toString();
    }
}

public class TransientExample{
    public static void main(String args[]) throws Exception {
        NameStore nameStore = new NameStore("Steve", "Middle","Jobs");
        ObjectOutputStream o = new ObjectOutputStream(new FileOutputStream("nameStore"));
        // writing to object
        o.writeObject(nameStore);
        o.close();

        // reading from object
        ObjectInputStream in = new ObjectInputStream(new FileInputStream("nameStore"));
        NameStore nameStore1 = (NameStore)in.readObject();
        System.out.println(nameStore1);
    }
}
```

And the output will be the following:  

```java
First Name : Steve
Middle Name : null
Last Name : Jobs
```

<em>Middle Name</em> is declared as `transient`, so it will not be stored in the persistent storage.  

<a href="http://www.javabeat.net/what-is-transient-keyword-in-java/" rel="noreferrer">Source</a>  

#### Answer 3 (score 82)
To allow you to define variables that you don't want to serialize.   

In an object you may have information that you don't want to serialize/persist (perhaps a reference to a parent factory object), or perhaps it doesn't make sense to serialize. Marking these as 'transient' means the serialization mechanism will ignore these fields.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: Why is subtracting these two times (in 1927) giving a strange result? (score [620541](https://stackoverflow.com/q/6841333) in 2018)

#### Question
If I run the following program, which parses two date strings referencing times 1 second apart and compares them:  

```java
public static void main(String[] args) throws ParseException {
    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    String str3 = "1927-12-31 23:54:07";  
    String str4 = "1927-12-31 23:54:08";  
    Date sDt3 = sf.parse(str3);  
    Date sDt4 = sf.parse(str4);  
    long ld3 = sDt3.getTime() /1000;  
    long ld4 = sDt4.getTime() /1000;
    System.out.println(ld4-ld3);
}
```

<strong>The output is:</strong>  

<blockquote>
  353  
</blockquote>

Why is `ld4-ld3` not `1` (as I would expect from the one-second difference in the times), but `353`?  

If I change the dates to times 1 second later:  

```java
String str3 = "1927-12-31 23:54:08";  
String str4 = "1927-12-31 23:54:09";  
```

Then `ld4-ld3` will be `1`.  

<hr>

<strong>Java version:</strong>  

```java
java version "1.6.0_22"
Java(TM) SE Runtime Environment (build 1.6.0_22-b04)
Dynamic Code Evolution Client VM (build 0.2-b02-internal, 19.0-b04-internal, mixed mode)

Timezone(`TimeZone.getDefault()`):

sun.util.calendar.ZoneInfo[id="Asia/Shanghai",
offset=28800000,dstSavings=0,
useDaylight=false,
transitions=19,
lastRule=null]

Locale(Locale.getDefault()): zh_CN
```

#### Answer accepted (score 10528)
It's a time zone change on December 31st in Shanghai.  

See <a href="http://www.timeanddate.com/worldclock/clockchange.html?n=237&amp;year=1927" rel="noreferrer">this page</a> for details of 1927 in Shanghai. Basically at midnight at the end of 1927, the clocks went back 5 minutes and 52 seconds. So "1927-12-31 23:54:08" actually happened twice, and it looks like Java is parsing it as the <em>later</em> possible instant for that local date/time - hence the difference.  

Just another episode in the often weird and wonderful world of time zones.  

<strong>EDIT:</strong> Stop press! History changes...  

The original question would no longer demonstrate quite the same behaviour, if rebuilt with version 2013a of <a href="https://github.com/nodatime/nodatime/blob/master/src/NodaTime.Demo/StackOverflowExamples.cs#L68" rel="noreferrer">TZDB</a>. In 2013a, the result would be 358 seconds, with a transition time of 23:54:03 instead of 23:54:08.  

I only noticed this because I'm collecting questions like this in Noda Time, in the form of <a href="https://github.com/nodatime/nodatime/blob/master/src/NodaTime.Demo/StackOverflowExamples.cs#L68" rel="noreferrer">unit tests</a>... The test has now been changed, but it just goes to show - not even historical data is safe.  

<strong>EDIT:</strong> History has changed again...  

In TZDB 2014f, the time of the change has moved to 1900-12-31, and it's now a mere 343 second change (so the time between `t` and `t+1` is 344 seconds, if you see what I mean).  

<strong>EDIT:</strong> To answer a question around a transition at 1900... it looks like the Java timezone implementation treats <em>all</em> time zones as simply being in their standard time for any instant before the start of 1900 UTC:  

```java
import java.util.TimeZone;

public class Test {
    public static void main(String[] args) throws Exception {
        long startOf1900Utc = -2208988800000L;
        for (String id : TimeZone.getAvailableIDs()) {
            TimeZone zone = TimeZone.getTimeZone(id);
            if (zone.getRawOffset() != zone.getOffset(startOf1900Utc - 1)) {
                System.out.println(id);
            }
        }
    }
}
```

The code above produces no output on my Windows machine. So any time zone which has any offset other than its standard one at the start of 1900 will count that as a transition. TZDB itself has some data going back earlier than that, and doesn't rely on any idea of a "fixed" standard time (which is what `getRawOffset` assumes to be a valid concept) so other libraries needn't introduce this artificial transition.  

#### Answer 2 (score 1553)
You've encountered a <a href="http://timeanddate.com/worldclock/clockchange.html?n=237&amp;year=1927" rel="noreferrer">local time discontinuity</a>:  

<blockquote>
  <p>When local standard time was about to reach Sunday, 1. January 1928,
  00:00:00 clocks were turned backward 0:05:52 hours to Saturday, 31.
  December 1927, 23:54:08 local standard time instead</p>
</blockquote>

This is not particularly strange and has happened pretty much everywhere at one time or another as timezones were switched or changed due to political or administrative actions.  

#### Answer 3 (score 634)
The moral of this strangeness is:  

<ul>
<li>Use dates and times in UTC wherever possible.</li>
<li>If you can not display a date or time in UTC, always indicate the time-zone.</li>
<li>If you can not require an input date/time in UTC, require an explicitly indicated time-zone.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: Comparing Java enum members: == or equals()? (score [614360](https://stackoverflow.com/q/1750435) in 2017)

#### Question
I know that Java enums are compiled to classes with private constructors and a bunch of public static members. When comparing two members of a given enum, I've always used `.equals()`, e.g.  

```java
public useEnums(SomeEnum a)
{
    if(a.equals(SomeEnum.SOME_ENUM_VALUE))
    {
        ...
    }
    ...
}
```

However, I just came across some code that uses the equals operator `==` instead of .equals():  

```java
public useEnums2(SomeEnum a)
{
    if(a == SomeEnum.SOME_ENUM_VALUE)
    {
        ...
    }
    ...
}
```

Which operator is the one I should be using?  

#### Answer accepted (score 1455)
Both are technically correct. If you look at the source code for `.equals()`, it simply defers to `==`.  

I use `==`, however, as that will be null safe.  

#### Answer 2 (score 1052)
<h5>Can `==` be used on `enum`?</h2>

Yes: enums have tight instance controls that allows you to use `==` to compare instances. Here's the guarantee provided by the language specification (emphasis by me):  

<blockquote>
  <h5><a href="https://docs.oracle.com/javase/specs/jls/se9/html/jls-8.html#jls-8.9" rel="noreferrer">JLS 8.9 Enums</a></h3>
  
  An enum type has no instances other than those defined by its enum constants.   
  
  It is a compile-time error to attempt to explicitly instantiate an enum type. The `final clone` method in `Enum` ensures that `enum` constants can never be cloned, and the special treatment by the serialization mechanism ensures that duplicate instances are never created as a result of deserialization. Reflective instantiation of enum types is prohibited. Together, these four things ensure that no instances of an `enum` type exist beyond those defined by the `enum` constants.  
  
  Because there is only one instance of each `enum` constant, <strong>it is permissible to use the `==` operator in place of the `equals` method when comparing two object references if it is known that at least one of them refers to an `enum` constant</strong>. (The `equals` method in `Enum` is a `final` method that merely invokes `super.equals` on its argument and returns the result, thus performing an identity comparison.)  
</blockquote>

This guarantee is strong enough that Josh Bloch recommends, that if you insist on using the singleton pattern, the best way to implement it is to use a single-element `enum` (see: <em>Effective Java 2nd Edition, Item 3: Enforce the singleton property with a private constructor or an enum type</em>; also <a href="https://stackoverflow.com/questions/2912281/thread-safety-in-singleton/">Thread safety in Singleton</a>)  

<hr>

<h5>What are the differences between `==` and `equals`?</h2>

As a reminder, it needs to be said that generally, `==` is NOT a viable alternative to `equals`. When it is, however (such as with `enum`), there are two important differences to consider:  

<h5>`==` never throws `NullPointerException`</h3>

```java
enum Color { BLACK, WHITE };

Color nothing = null;
if (nothing == Color.BLACK);      // runs fine
if (nothing.equals(Color.BLACK)); // throws NullPointerException
```

<h5>`==` is subject to type compatibility check at compile time</h3>

```java
enum Color { BLACK, WHITE };
enum Chiral { LEFT, RIGHT };

if (Color.BLACK.equals(Chiral.LEFT)); // compiles fine
if (Color.BLACK == Chiral.LEFT);      // DOESN'T COMPILE!!! Incompatible types!
```

<hr>

<h5>Should `==` be used when applicable?</h2>

Bloch specifically mentions that immutable classes that have proper control over their instances can guarantee to their clients that `==` is usable. `enum` is specifically mentioned to exemplify.  

<blockquote>
  <em>Item 1: Consider static factory methods instead of constructors</em>  
  
  [...] it allows an immutable class to make the guarantee that no two equal instances exist: `a.equals(b)` if and only if `a==b`. If a class makes this guarantee, then its clients can use the `==` operator instead of the `equals(Object)` method, which may result in improved performance. Enum types provide this guarantee.  
</blockquote>

To summarize, the arguments for using `==` on `enum` are:  

<ul>
<li>It works.</li>
<li>It's faster.</li>
<li>It's safer at run-time.</li>
<li>It's safer at compile-time.</li>
</ul>

#### Answer 3 (score 79)
Using `==` to compare two enum values works because there is only one object for each enum constant.  

On a side note, there is actually no need to use `==` to write null safe code if you write your `equals()` like this:  

```java
public useEnums(SomeEnum a)
{
    if(SomeEnum.SOME_ENUM_VALUE.equals(a))
    {
        ...
    }
    ...
}
```

This is a best practice known as <a href="http://c2.com/cgi/wiki?CompareConstantsFromTheLeft" rel="noreferrer">Compare Constants From The Left</a> that you definitely should follow.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: Creating a memory leak with Java (score [610179](https://stackoverflow.com/q/6470651) in 2019)

#### Question
<p>I just had an interview, and I was asked to create a <strong><em>memory leak</em></strong> with Java.<br>
Needless to say, I felt pretty dumb having no clue on how to even start creating one.</p>

What would an example be?  

#### Answer accepted (score 2210)
Here's a good way to create a true memory leak (objects inaccessible by running code but still stored in memory) in pure Java:  

<ol>
<li>The application creates a long-running thread (or use a thread pool to leak even faster).</li>
<li>The thread loads a class via an (optionally custom) ClassLoader.</li>
<li>The class allocates a large chunk of memory (e.g. `new byte[1000000]`), stores a strong reference to it in a static field, and then stores a reference to itself in a ThreadLocal.  Allocating the extra memory is optional (leaking the Class instance is enough), but it will make the leak work that much faster.</li>
<li>The thread clears all references to the custom class or the ClassLoader it was loaded from.</li>
<li>Repeat.</li>
</ol>

This works because the ThreadLocal keeps a reference to the object, which keeps a reference to its Class, which in turn keeps a reference to its ClassLoader.  The ClassLoader, in turn, keeps a reference to all the Classes it has loaded.  

(It was worse in many JVM implementations, especially prior to Java 7, because Classes and ClassLoaders were allocated straight into permgen and were never GC'd at all. However, regardless of how the JVM handles class unloading, a ThreadLocal will still prevent a Class object from being reclaimed.)  

A variation on this pattern is why application containers (like Tomcat) can leak memory like a sieve if you frequently redeploy applications that happen to use ThreadLocals in any way.  (Since the application container uses Threads as described, and each time you redeploy the application a new ClassLoader is used.)  

<strong>Update</strong>: Since lots of people keep asking for it, <a href="https://gist.github.com/dpryden/b2bb29ee2d146901b4ae" rel="noreferrer">here's some example code that shows this behavior in action</a>.  



#### Answer 2 (score 1176)
<strong>Static field holding object reference [esp final field]</strong>  

```java
class MemorableClass {
    static final ArrayList list = new ArrayList(100);
}
```

<strong>Calling <a href="http://download.oracle.com/javase/6/docs/api/java/lang/String.html#intern%28%29" rel="noreferrer">`String.intern()`</a> on lengthy String</strong>  

```java
String str=readString(); // read lengthy string any source db,textbox/jsp etc..
// This will place the string in memory pool from which you can't remove
str.intern();
```

<strong>(Unclosed) open streams ( file , network etc... )</strong>  

```java
try {
    BufferedReader br = new BufferedReader(new FileReader(inputFile));
    ...
    ...
} catch (Exception e) {
    e.printStacktrace();
}
```

<strong>Unclosed connections</strong>  

```java
try {
    Connection conn = ConnectionFactory.getConnection();
    ...
    ...
} catch (Exception e) {
    e.printStacktrace();
}
```

<strong>Areas that are unreachable from JVM's garbage collector</strong>, such as memory allocated through native methods  

In web applications, some objects are stored in application scope until the application is explicitly stopped or removed.  

```java
getServletContext().setAttribute("SOME_MAP", map);
```

<strong>Incorrect or inappropriate JVM options</strong>, such as the `noclassgc` option on IBM JDK that prevents unused class garbage collection   

See <a href="http://publib.boulder.ibm.com/infocenter/wasinfo/v6r0/index.jsp?topic=/com.ibm.websphere.express.doc/info/exp/ae/tprf_tunejvm.html" rel="noreferrer">IBM jdk settings</a>.  

#### Answer 3 (score 448)
A simple thing to do is to use a HashSet with an incorrect (or non-existent) `hashCode()` or `equals()`, and then keep adding "duplicates".  Instead of ignoring duplicates as it should, the set will only ever grow and you won't be able to remove them.  

If you want these bad keys/elements to hang around you can use a static field like   

```java
class BadKey {
   // no hashCode or equals();
   public final String key;
   public BadKey(String key) { this.key = key; }
}

Map map = System.getProperties();
map.put(new BadKey("key"), "value"); // Memory leak even if your threads die.
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How can I convert a stack trace to a string? (score [568558](https://stackoverflow.com/q/1149703) in 2016)

#### Question
What is the easiest way to convert the result of `Throwable.getStackTrace()` to a string that depicts the stacktrace?  

#### Answer accepted (score 988)
One can use the following method to convert an `Exception` stack trace to `String`. This class is available in <em>Apache commons-lang which is most common dependent library with many popular open sources</em>  

<a href="http://commons.apache.org/proper/commons-lang/javadocs/api-2.6/org/apache/commons/lang/exception/ExceptionUtils.html#getStackTrace(java.lang.Throwable)" rel="noreferrer">`org.apache.commons.lang.exception.ExceptionUtils.getStackTrace(Throwable)`</a>  

#### Answer 2 (score 2127)
Use <a href="https://docs.oracle.com/javase/8/docs/api/java/lang/Throwable.html#printStackTrace-java.io.PrintWriter-" rel="noreferrer">`Throwable.printStackTrace(PrintWriter pw)`</a> to send the stack trace to an appropriate writer.  

```java
import java.io.StringWriter;
import java.io.PrintWriter;

// ...

StringWriter sw = new StringWriter();
PrintWriter pw = new PrintWriter(sw);
e.printStackTrace(pw);
String sStackTrace = sw.toString(); // stack trace as a string
System.out.println(sStackTrace);
```

#### Answer 3 (score 442)
This should work:     

```java
StringWriter sw = new StringWriter();
e.printStackTrace(new PrintWriter(sw));
String exceptionAsString = sw.toString();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: What exactly is Apache Camel? (score [533978](https://stackoverflow.com/q/8845186) in 2016)

#### Question
I don't understand what exactly <a href="http://camel.apache.org/index.html" rel="noreferrer">Camel</a> does.  

If you could give in 101 words an introduction to Camel:  

<ul>
<li>What exactly is it? </li>
<li>How does it interact with an application written in Java? </li>
<li>Is it something that goes together with the server? </li>
<li>Is it an independent program? </li>
</ul>

<strong>Please explain what Camel is.</strong>  

#### Answer accepted (score 678)
If you have 5 to 10 minutes, I generally recommend people to read this <a href="http://java.dzone.com/articles/open-source-integration-apache">Integration with Apache Camel</a> by Jonathan Anstey. It's a well written piece which gives a brief introduction to and overview of some of Camel's concepts, and it implements a use case with code samples. In it, Jonathan writes:  

<blockquote>
  Apache Camel is an open source Java framework that focuses on making integration easier and more accessible to developers. It does this by providing:  
  
  <ul>
  <li>concrete implementations of all the widely used <a href="http://www.enterpriseintegrationpatterns.com/">Enterprise Integration Patterns</a> (EIPs)</li>
  <li>connectivity to a great variety of transports and APIs</li>
  <li>easy to use Domain Specific Languages (DSLs) to wire EIPs and transports together</li>
  </ul>
</blockquote>

There is also a free chapter of <a href="http://manning.com/ibsen/">Camel in Action</a> which introduces Camel in the first chapter. Jonathan is a co-author on that book with me.  

#### Answer 2 (score 1082)
My take to describe this in a more accessible way...  

In order to understand what Apache Camel is, you need to understand what Enterprise Integration Patterns are.  

Let's start with what we presumably already know: The Singleton pattern, the Factory pattern, etc; They are merely ways of organizing your solution to the problem, but they are not solutions themselves. These patterns were analyzed and extracted for the rest of us by the Gang of Four, when they published their book: <a href="http://en.wikipedia.org/wiki/Design_Patterns">Design Patterns</a>. They saved some of us tremendous effort in thinking of how to best structure our code.  

Much like the Gang of Four, Gregor Hohpe and Bobby Woolf authored the book <a href="http://www.eaipatterns.com/">Enterprise Integration Patterns</a> (EIP) in which they propose and document a set of new patterns and <em>blueprints</em> for how we could <em>best</em> design large component-based systems, where components can be running on the same process or in a different machine.  

They basically propose that we structure our system to be <em>message</em> oriented -- where components communicate with each others using messages as inputs and outputs and absolutely nothing else. They show us a complete set of patterns that we may choose from and implement in our different components that will together form the whole system.  

<strong>So what is Apache Camel?</strong>  

Apache Camel offers you the interfaces for the EIPs, the base objects, commonly needed implementations, debugging tools, a configuration system, and many other helpers which will save you a ton of time when you want to implement your solution to follow the EIPs.  

Take MVC. MVC is pretty simple in theory and we could implement it without any framework help. But good MVC frameworks provide us with the structure ready-to-use and have gone the extra mile and thought out all the other "side" things you need when you create a large MVC project and that's why we use them most of the time.  

That's exactly what Apache Camel is for EIPs. <strong>It's a complete production-ready framework for people who want to implement their solution to follow the EIPs.</strong>  

#### Answer 3 (score 652)
Creating a <a href="http://www.bigsoft.co.uk/blog/index.php/2010/10/18/the-whats-and-whys-to-creating-project-descriptions">project description</a> should not be complicated.  

I say:  

<blockquote>
  Apache Camel is messaging technology glue with routing. It joins together messaging start and end points allowing the transference of messages from different sources to different destinations. For example: JMS -> JSON, HTTP -> JMS or funneling FTP -> JMS, HTTP -> JMS, JSON -> JMS  
</blockquote>

Wikipedia says:  

<blockquote>
  Apache Camel is a rule-based routing and mediation engine which provides a Java object based implementation of the Enterprise Integration Patterns using an API (or declarative Java Domain Specific Language) to configure routing and mediation rules. The domain specific language means that Apache Camel can support type-safe smart completion of routing rules in your IDE using regular Java code without huge amounts of XML configuration files; though XML configuration inside Spring is also supported.  
</blockquote>

See? That wasn't hard was it?  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: What is a JavaBean exactly? (score [528745](https://stackoverflow.com/q/3295496) in 2019)

#### Question
I understood, I think, that a "Bean" is a Java class with properties and getters/setters. As much as I understand, it is the equivalent of a C struct. Is that true?  

Also, is there a real <em>syntactic</em> difference between a bean and a regular class? Is there any special definition or an interface?  

Basically, why is there a term for this?  

Also what does the `Serializable` interface mean?   

#### Answer accepted (score 1852)
A JavaBean is just a <a href="http://www.oracle.com/technetwork/java/javase/documentation/spec-136004.html" rel="noreferrer">standard</a>  

<ol>
<li>All properties private (use <a href="http://en.wikipedia.org/wiki/Mutator_method" rel="noreferrer">getters/setters</a>)</li>
<li>A public <a href="http://en.wikipedia.org/wiki/Nullary_constructor" rel="noreferrer">no-argument constructor</a></li>
<li>Implements <a href="http://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html" rel="noreferrer">`Serializable`</a>.</li>
</ol>

That's it. It's just a convention.  Lots of libraries depend on it though.  

With respect to `Serializable`, from the <a href="http://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html" rel="noreferrer">API documentation</a>:  

<blockquote>
  <p>Serializability of a class is enabled by the class implementing the
  java.io.Serializable interface. Classes that do not implement this
  interface will not have any of their state serialized or deserialized.
  All subtypes of a serializable class are themselves serializable. The
  serialization interface has no methods or fields and serves only to
  identify the semantics of being serializable.</p>
</blockquote>

In other words, serializable objects can be written to streams, and hence files, object databases, anything really.    

Also, there is no syntactic difference between a JavaBean and another class -- a class is a JavaBean if it follows the standards.  

There is a term for it because the standard allows libraries to programmatically do things with class instances you define in a predefined way. For example, if a library wants to stream any object you pass into it, it knows it can because your object is serializable (assuming the lib requires your objects be proper JavaBeans).   

#### Answer 2 (score 271)
There's a term for it to make it sound special.  The reality is nowhere near so mysterious.  

Basically, a "Bean":  

<ul>
<li>is a serializable object (that is, it implements <a href="http://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html" rel="noreferrer">`java.io.Serializable`</a>, and does so correctly), that</li>
<li>has "properties" whose getters and setters are just methods with certain names (like, say, `getFoo()` is the getter for the "Foo" property), and </li>
<li>has a public 0-arg constructor (so it can be created at will and configured by setting its properties).</li>
</ul>

Update:  

As for `Serializable`:  That is nothing but a "marker interface" (an interface that doesn't declare any functions) that tells Java that the implementing class consents to (and implies that it is capable of) "serialization" -- a process that converts an instance into a stream of bytes.  Those bytes can be stored in files, sent over a network connection, etc, and have enough info to allow a JVM (at least, one that knows about the object's type) to reconstruct the object later -- possibly in a different instance of the application, or even on a whole other machine!  

Of course, in order to do that, the class has to abide by certain limitations.  Chief among them is that all instance fields must be either primitive types (int, bool, etc), instances of some class that is also serializable, or marked as `transient` so that Java won't try to include them.  (This of course means that `transient` fields will not survive the trip over a stream.  A class that has `transient` fields should be prepared to reinitialize them if necessary.)  

A class that can not abide by those limitations should not implement `Serializable` (and, IIRC, the Java compiler won't even <em>let</em> it do so.)  

#### Answer 3 (score 89)
<p>JavaBeans are Java classes which adhere to an extremely simple coding convention.
All you have to do is to </p>

<ol>
<li>implement `java.io.Serializable` interface - to save the state of an
object    </li>
<li>use a public empty argument constructor - to instantiate the object</li>
<li>provide public getter/setter methods -  to get and set the values of private variables (properties ).</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Download a file with Android, and showing the progress in a ProgressDialog (score [518763](https://stackoverflow.com/q/3028306) in 2014)

#### Question
I am trying to write a simple application that gets updated. For this I need a simple function that can download a file and <em>show the current progress</em> in a `ProgressDialog`. I know how to do the `ProgressDialog`, but I'm not sure how to display the current progress and how to download the file in the first place.  

#### Answer accepted (score 1828)
There are many ways to download files. Following I will post most common ways; it is up to you to decide which method is better for your app.  

<h5>1. Use `AsyncTask` and show the download progress in a dialog</h1>

This method will allow you to execute some background processes and update the UI at the same time (in this case, we'll update a progress bar).  

This is an example code:  

```java
// declare the dialog as a member field of your activity
ProgressDialog mProgressDialog;

// instantiate it within the onCreate method
mProgressDialog = new ProgressDialog(YourActivity.this);
mProgressDialog.setMessage("A message");
mProgressDialog.setIndeterminate(true);
mProgressDialog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
mProgressDialog.setCancelable(true);

// execute this when the downloader must be fired
final DownloadTask downloadTask = new DownloadTask(YourActivity.this);
downloadTask.execute("the url to the file you want to download");

mProgressDialog.setOnCancelListener(new DialogInterface.OnCancelListener() {

    @Override
    public void onCancel(DialogInterface dialog) {
        downloadTask.cancel(true); //cancel the task
    }
});
```

The `AsyncTask` will look like this:  

```java
// usually, subclasses of AsyncTask are declared inside the activity class.
// that way, you can easily modify the UI thread from here
private class DownloadTask extends AsyncTask<String, Integer, String> {

    private Context context;
    private PowerManager.WakeLock mWakeLock;

    public DownloadTask(Context context) {
        this.context = context;
    }

    @Override
    protected String doInBackground(String... sUrl) {
        InputStream input = null;
        OutputStream output = null;
        HttpURLConnection connection = null;
        try {
            URL url = new URL(sUrl[0]);
            connection = (HttpURLConnection) url.openConnection();
            connection.connect();

            // expect HTTP 200 OK, so we don't mistakenly save error report
            // instead of the file
            if (connection.getResponseCode() != HttpURLConnection.HTTP_OK) {
                return "Server returned HTTP " + connection.getResponseCode()
                        + " " + connection.getResponseMessage();
            }

            // this will be useful to display download percentage
            // might be -1: server did not report the length
            int fileLength = connection.getContentLength();

            // download the file
            input = connection.getInputStream();
            output = new FileOutputStream("/sdcard/file_name.extension");

            byte data[] = new byte[4096];
            long total = 0;
            int count;
            while ((count = input.read(data)) != -1) {
                // allow canceling with back button
                if (isCancelled()) {
                    input.close();
                    return null;
                }
                total += count;
                // publishing the progress....
                if (fileLength > 0) // only if total length is known
                    publishProgress((int) (total * 100 / fileLength));
                output.write(data, 0, count);
            }
        } catch (Exception e) {
            return e.toString();
        } finally {
            try {
                if (output != null)
                    output.close();
                if (input != null)
                    input.close();
            } catch (IOException ignored) {
            }

            if (connection != null)
                connection.disconnect();
        }
        return null;
    }
```

The method above (`doInBackground`) runs always on a background thread. You shouldn't do any UI tasks there. On the other hand, the `onProgressUpdate` and `onPreExecute` run on the UI thread, so there you can change the progress bar:  

```java
    @Override
    protected void onPreExecute() {
        super.onPreExecute();
        // take CPU lock to prevent CPU from going off if the user 
        // presses the power button during download
        PowerManager pm = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
        mWakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK,
             getClass().getName());
        mWakeLock.acquire();
        mProgressDialog.show();
    }

    @Override
    protected void onProgressUpdate(Integer... progress) {
        super.onProgressUpdate(progress);
        // if we get here, length is known, now set indeterminate to false
        mProgressDialog.setIndeterminate(false);
        mProgressDialog.setMax(100);
        mProgressDialog.setProgress(progress[0]);
    }

    @Override
    protected void onPostExecute(String result) {
        mWakeLock.release();
        mProgressDialog.dismiss();
        if (result != null)
            Toast.makeText(context,"Download error: "+result, Toast.LENGTH_LONG).show();
        else
            Toast.makeText(context,"File downloaded", Toast.LENGTH_SHORT).show();
    }
```

For this to run, you need the WAKE_LOCK permission.  

```java
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

<h5>2. Download from Service</h1>

The big question here is: <em>how do I update my activity from a service?</em>. In the next example we are going to use two classes you may not be aware of: `ResultReceiver` and `IntentService`. `ResultReceiver` is the one that will allow us to update our thread from a service; `IntentService` is a subclass of `Service` which spawns a thread to do background work from there (you should know that a `Service` runs actually in the same thread of your app; when you extends `Service`, you must manually spawn new threads to run CPU blocking operations).  

Download service can look like this:  

```java
public class DownloadService extends IntentService {
    public static final int UPDATE_PROGRESS = 8344;

    public DownloadService() {
        super("DownloadService");
    }
    @Override
    protected void onHandleIntent(Intent intent) {

        String urlToDownload = intent.getStringExtra("url");
        ResultReceiver receiver = (ResultReceiver) intent.getParcelableExtra("receiver");
        try {

            //create url and connect
            URL url = new URL(urlToDownload);
            URLConnection connection = url.openConnection();
            connection.connect();

            // this will be useful so that you can show a typical 0-100% progress bar
            int fileLength = connection.getContentLength();

            // download the file
            InputStream input = new BufferedInputStream(connection.getInputStream());

            String path = "/sdcard/BarcodeScanner-debug.apk" ;
            OutputStream output = new FileOutputStream(path);

            byte data[] = new byte[1024];
            long total = 0;
            int count;
            while ((count = input.read(data)) != -1) {
                total += count;

                // publishing the progress....
                Bundle resultData = new Bundle();
                resultData.putInt("progress" ,(int) (total * 100 / fileLength));
                receiver.send(UPDATE_PROGRESS, resultData);
                output.write(data, 0, count);
            }

            // close streams 
            output.flush();
            output.close();
            input.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        Bundle resultData = new Bundle();
        resultData.putInt("progress" ,100);

        receiver.send(UPDATE_PROGRESS, resultData);
    }
}
```

Add the service to your manifest:  

```java
<service android:name=".DownloadService"/>
```

And the activity will look like this:  

```java
// initialize the progress dialog like in the first example

// this is how you fire the downloader
mProgressDialog.show();
Intent intent = new Intent(this, DownloadService.class);
intent.putExtra("url", "url of the file to download");
intent.putExtra("receiver", new DownloadReceiver(new Handler()));
startService(intent);
```

Here is were `ResultReceiver` comes to play:  

```java
private class DownloadReceiver extends ResultReceiver{

    public DownloadReceiver(Handler handler) {
        super(handler);
    }

    @Override
    protected void onReceiveResult(int resultCode, Bundle resultData) {

        super.onReceiveResult(resultCode, resultData);

        if (resultCode == DownloadService.UPDATE_PROGRESS) {

            int progress = resultData.getInt("progress"); //get the progress
            dialog.setProgress(progress);

            if (progress == 100) {
                dialog.dismiss();
            }
        }
    }
}
```

<h5>2.1 Use Groundy library</h2>

<a href="http://github.com/casidiablo/groundy" rel="noreferrer"><strong>Groundy</strong></a> is a library that basically helps you run pieces of code in a background service, and it is based on the `ResultReceiver` concept shown above. This library is <strong>deprecated</strong> at the moment. This is how the <strong>whole</strong> code would look like:  

The activity where you are showing the dialog...  

```java
public class MainActivity extends Activity {

    private ProgressDialog mProgressDialog;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        findViewById(R.id.btn_download).setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                String url = ((EditText) findViewById(R.id.edit_url)).getText().toString().trim();
                Bundle extras = new Bundler().add(DownloadTask.PARAM_URL, url).build();
                Groundy.create(DownloadExample.this, DownloadTask.class)
                        .receiver(mReceiver)
                        .params(extras)
                        .queue();

                mProgressDialog = new ProgressDialog(MainActivity.this);
                mProgressDialog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
                mProgressDialog.setCancelable(false);
                mProgressDialog.show();
            }
        });
    }

    private ResultReceiver mReceiver = new ResultReceiver(new Handler()) {
        @Override
        protected void onReceiveResult(int resultCode, Bundle resultData) {
            super.onReceiveResult(resultCode, resultData);
            switch (resultCode) {
                case Groundy.STATUS_PROGRESS:
                    mProgressDialog.setProgress(resultData.getInt(Groundy.KEY_PROGRESS));
                    break;
                case Groundy.STATUS_FINISHED:
                    Toast.makeText(DownloadExample.this, R.string.file_downloaded, Toast.LENGTH_LONG);
                    mProgressDialog.dismiss();
                    break;
                case Groundy.STATUS_ERROR:
                    Toast.makeText(DownloadExample.this, resultData.getString(Groundy.KEY_ERROR), Toast.LENGTH_LONG).show();
                    mProgressDialog.dismiss();
                    break;
            }
        }
    };
}
```

A `GroundyTask` implementation used by <strong>Groundy</strong> to download the file and show the progress:  

```java
public class DownloadTask extends GroundyTask {    
    public static final String PARAM_URL = "com.groundy.sample.param.url";

    @Override
    protected boolean doInBackground() {
        try {
            String url = getParameters().getString(PARAM_URL);
            File dest = new File(getContext().getFilesDir(), new File(url).getName());
            DownloadUtils.downloadFile(getContext(), url, dest, DownloadUtils.getDownloadListenerForTask(this));
            return true;
        } catch (Exception pokemon) {
            return false;
        }
    }
}
```

And just add this to the manifest:  

```java
<service android:name="com.codeslap.groundy.GroundyService"/>
```

It couldn't be easier I think. Just grab the latest jar <a href="https://github.com/casidiablo/groundy/downloads" rel="noreferrer">from Github</a> and you are ready to go. Keep in mind that <strong>Groundy</strong>'s main purpose is to make calls to external REST apis in a background service and post results to the UI with easily. If you are doing something like that in your app, it could be really useful.  

<h5>2.2 Use <a href="https://github.com/koush/ion" rel="noreferrer">https://github.com/koush/ion</a></h2>

<h5>3. Use `DownloadManager` class (`GingerBread` and newer only)</h1>

GingerBread brought a new feature, `DownloadManager`, which allows you to download files easily and delegate the hard work of handling threads, streams, etc. to the system.  

First, let's see a utility method:  

```java
/**
 * @param context used to check the device version and DownloadManager information
 * @return true if the download manager is available
 */
public static boolean isDownloadManagerAvailable(Context context) {

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD) {
        return true;
    }
    return false;
}
```

Method's name explains it all. Once you are sure `DownloadManager` is available, you can do something like this:  

```java
String url = "url you want to download";
DownloadManager.Request request = new DownloadManager.Request(Uri.parse(url));
request.setDescription("Some descrition");
request.setTitle("Some title");
// in order for this if to run, you must use the android 3.2 to compile your app
if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
    request.allowScanningByMediaScanner();
    request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
}
request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, "name-of-the-file.ext");

// get download service and enqueue file
DownloadManager manager = (DownloadManager) getSystemService(Context.DOWNLOAD_SERVICE);
manager.enqueue(request);
```

Download progress will be showing in the notification bar.  

<h5>Final thoughts</h1>

First and second methods are just the tip of the iceberg. There are lots of things you have to keep in mind if you want your app to be robust. Here is a brief list:  

<ul>
<li>You must check whether user has an internet connection available</li>
<li>Make sure you have the right permissions (`INTERNET` and `WRITE_EXTERNAL_STORAGE`); also `ACCESS_NETWORK_STATE` if you want to check internet availability.</li>
<li>Make sure the directory were you are going to download files exist and has write permissions.</li>
<li>If download is too big you may want to implement a way to resume the download if previous attempts failed.</li>
<li>Users will be grateful if you allow them to interrupt the download.</li>
</ul>

Unless you need detailed control of the download process, then consider using `DownloadManager` (3) because it already handles most of the items listed above.  

But also consider that your needs may change. For example, `DownloadManager` <a href="https://stackoverflow.com/questions/35191718">does no response caching</a>. It will blindly download the same big file multiple times. There's no easy way to fix it after the fact. Where if you start with a basic `HttpURLConnection` (1, 2), then all you need is to add an `HttpResponseCache`. So the initial effort of learning the basic, standard tools can be a good investment.  

<blockquote>
  <p>This class was deprecated in API level 26. ProgressDialog is a modal
  dialog, which prevents the user from interacting with the app. Instead
  of using this class, you should use a progress indicator like
  ProgressBar, which can be embedded in your app's UI. Alternatively,
  you can use a notification to inform the user of the task's progress. For more details <a href="https://developer.android.com/reference/android/app/ProgressDialog" rel="noreferrer">Link</a></p>
</blockquote>

#### Answer 2 (score 105)
Don't forget to add permissions to your manifest file if you're gonna be downloading stuff from the internet!  

```java
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.helloandroid"
    android:versionCode="1"
    android:versionName="1.0">

        <uses-sdk android:minSdkVersion="10" />

        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"></uses-permission>
        <uses-permission android:name="android.permission.INTERNET"></uses-permission>
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"></uses-permission>
        <uses-permission android:name="android.permission.READ_PHONE_STATE"></uses-permission>

        <application 
            android:icon="@drawable/icon" 
            android:label="@string/app_name" 
            android:debuggable="true">

        </application>

</manifest>
```

#### Answer 3 (score 31)
Yes the code above will work .But if you are updating your `progressbar` in `onProgressUpdate` of `Asynctask`  and you press back button or finish your activity `AsyncTask` looses its track with your UI .And when you go back to your activity, even if  download is running in background you will see no update on progressbar. So on `OnResume()` try to run a thread like `runOnUIThread` with   a timer task that updates ur `progressbar` with values updating from the `AsyncTask` running background.  

```java
private void updateProgressBar(){
    Runnable runnable = new updateProgress();
    background = new Thread(runnable);
    background.start();
}

public class updateProgress implements Runnable {
    public void run() {
        while(Thread.currentThread()==background)
            //while (!Thread.currentThread().isInterrupted()) {
            try {
                Thread.sleep(1000); 
                Message msg = new Message();
                progress = getProgressPercentage();        
                handler.sendMessage(msg);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            } catch (Exception e) {
        }
    }
}

private Handler handler = new Handler(){
    @Override
    public void handleMessage(Message msg) {
        progress.setProgress(msg.what);
    }
};
```

Don't forget to <strong>Destroy</strong> the thread when ur activity is not visible.  

```java
private void destroyRunningThreads() {
    if (background != null) {
        background.interrupt();
        background=null;
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Does a finally block always get executed in Java? (score [471713](https://stackoverflow.com/q/65035) in 2019)

#### Question
Considering this code, can I be <em>absolutely sure</em> that the `finally` block always executes, no matter what `something()` is?  

```java
try {  
    something();  
    return success;  
}  
catch (Exception e) {   
    return failure;  
}  
finally {  
    System.out.println("I don't know if this will get printed out");
}
```

#### Answer accepted (score 2534)
Yes, `finally` will be called after the execution of the `try` or `catch` code blocks.  

The only times `finally` won't be called are:  

<ol>
<li>If you invoke `System.exit()`</li>
<li>If the JVM crashes first</li>
<li>If the JVM reaches an infinite loop (or some other non-interruptable, non-terminating statement) in the `try` or `catch` block</li>
<li>If the OS forcibly terminates the JVM process; e.g., `kill -9 &lt;pid&gt;` on UNIX</li>
<li>If the host system dies; e.g., power failure, hardware error, OS panic, et cetera</li>
<li>If the `finally` block is going to be executed by a daemon thread and all other non-daemon threads exit before `finally` is called</li>
</ol>

#### Answer 2 (score 527)
Example code:  

```java
public static void main(String[] args) {
    System.out.println(Test.test());
}

public static int test() {
    try {
        return 0;
    }
    finally {
        System.out.println("finally trumps return.");
    }
}
```

Output:  

```java
finally trumps return. 
0
```

#### Answer 3 (score 371)
Also, although it's bad practice, if there is a return statement within the finally block, it will trump any other return from the regular block. That is, the following block would return false:  

```java
try { return true; } finally { return false; }
```

Same thing with throwing exceptions from the finally block.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Iterating through a Collection, avoiding ConcurrentModificationException when removing objects in a loop (score [461129](https://stackoverflow.com/q/223918) in 2019)

#### Question
We all know you can't do this:  

```java
for (Object i : l) {
    if (condition(i)) {
        l.remove(i);
    }
}
```

`ConcurrentModificationException` etc... this apparently works sometimes, but not always. Here's some specific code:  

```java
public static void main(String[] args) {
    Collection<Integer> l = new ArrayList<>();

    for (int i = 0; i < 10; ++i) {
        l.add(4);
        l.add(5);
        l.add(6);
    }

    for (int i : l) {
        if (i == 5) {
            l.remove(i);
        }
    }

    System.out.println(l);
}
```

This, of course, results in:  

```java
Exception in thread "main" java.util.ConcurrentModificationException
```

... even though multiple threads aren't doing it... Anyway.  

What's the best solution to this problem? How can I remove an item from the collection in a loop without throwing this exception?  

I'm also using an arbitrary `Collection` here, not necessarily an `ArrayList`, so you can't rely on `get`.  

#### Answer accepted (score 1563)
<a href="https://docs.oracle.com/javase/9/docs/api/java/util/Iterator.html#remove--" rel="noreferrer">`Iterator.remove()`</a> is safe, you can use it like this:  

```java
List<String> list = new ArrayList<>();

// This is a clever way to create the iterator and call iterator.hasNext() like
// you would do in a while-loop. It would be the same as doing:
//     Iterator<String> iterator = list.iterator();
//     while (iterator.hasNext()) {
for (Iterator<String> iterator = list.iterator(); iterator.hasNext();) {
    String string = iterator.next();
    if (string.isEmpty()) {
        // Remove the current element from the iterator and the list.
        iterator.remove();
    }
}
```

Note that <a href="https://docs.oracle.com/javase/9/docs/api/java/util/Iterator.html#remove--" rel="noreferrer">`Iterator.remove()`</a> is the only safe way to modify a collection during iteration; the behavior is unspecified if the underlying collection is modified <strong>in any other way</strong> while the iteration is in progress.  

Source:<a href="http://docs.oracle.com/javase/tutorial/collections/interfaces/collection.html" rel="noreferrer"> docs.oracle > The Collection Interface</a>  

<hr>

And similarly, if you have a `ListIterator` and want to <em>add</em> items, you can use <a href="http://docs.oracle.com/javase/8/docs/api/java/util/ListIterator.html#add-E-" rel="noreferrer">`ListIterator#add`</a>, for the same reason you can use `Iterator#remove`&nbsp;&mdash; it's designed to allow it.  

<hr>

In your case you tried to remove from a list, but the same restriction applies if trying to `put` into a `Map` while iterating its content.   

#### Answer 2 (score 336)
This works:  

```java
Iterator<Integer> iter = l.iterator();
while (iter.hasNext()) {
    if (iter.next() == 5) {
        iter.remove();
    }
}
```

I assumed that since a foreach loop is syntactic sugar for iterating, using an iterator wouldn't help... but it gives you this `.remove()` functionality.  

#### Answer 3 (score 193)
With Java 8 you can use <a href="http://docs.oracle.com/javase/8/docs/api/java/util/Collection.html#removeIf-java.util.function.Predicate-" rel="noreferrer">the new `removeIf` method</a>. Applied to your example:  

```java
Collection<Integer> coll = new ArrayList<>();
//populate

coll.removeIf(i -> i == 5);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Android SDK installation doesn't find JDK (score [435935](https://stackoverflow.com/q/4382178) in 2018)

#### Question
I'm trying to install the Android SDK on my Windows 7 x64 System. `jdk-6u23-windows-x64.exe` is installed, but the Android SDK setup refuses to proceed because it doesn't find the JDK installation.  

Is this a known issue? And is there a solution?  

<img src="https://i.stack.imgur.com/pZjuL.jpg" alt="SDK Error">  

#### Answer 2 (score 1253)
Press <strong><em>Back</em></strong> when you get the notification and then <strong><em>Next</em></strong>. This time it will find the `JDK`.   

#### Answer 3 (score 280)
Actual SETUP:  

<ul>
<li><strong>OS</strong>: Windows 8.1 </li>
<li><strong>JDK</strong> file: jdk-8u11-windows-x64.exe </li>
<li><strong>ADT</strong> file: installer_r23.0.2-windows.exe</li>
</ul>

Install the `x64 JDK`, and try the back-next option first, and then try setting `JAVA_HOME` like the error message says, but if that doesn't work for you either, then try this:  

Do as it says, set `JAVA_HOME` in your environment variables, but in the path use forward slashes instead of backslashes.  

Seriously.  

For me it failed when `JAVA_HOME` was `C:\Program Files\Java\jdk1.6.0_31` but worked fine when it was `C:/Program Files/Java/jdk1.6.0_31` - drove me nuts!  

If this is not enough, also add to the beginning of the Environment Variable `Path`  <strong>%JAVA_HOME%;</strong>  

Updated values in System Environment Variables:  

<ul>
<li>`JAVA_HOME=C:/Program Files/Java/jdk1.8.0_11`</li>
<li>`JRE_HOME=C:/Program Files/Java/jre8`</li>
<li>`Path=%JAVA_HOME%;C:...`</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: Why is char[] preferred over String for passwords? (score [373132](https://stackoverflow.com/q/8881291) in 2017)

#### Question
In Swing, the password field has a `getPassword()` (returns `char[]`) method instead of the usual `getText()` (returns `String`) method. Similarly, I have come across a suggestion not to use `String` to handle passwords.  

<p>Why does `String` pose a threat to security when it comes to passwords?
It feels inconvenient to use `char[]`.</p>

#### Answer accepted (score 4140)
<strong>Strings are immutable</strong>. That means once you've created the `String`, if another process can dump memory, there's no way (aside from <a href="https://en.wikipedia.org/wiki/Reflection_%28computer_programming%29" rel="noreferrer">reflection</a>) you can get rid of the data before <a href="https://en.wikipedia.org/wiki/Garbage_collection_%28computer_science%29" rel="noreferrer">garbage collection</a> kicks in.  

With an array, you can explicitly wipe the data after you're done with it. You can overwrite the array with anything you like, and the password won't be present anywhere in the system, even before garbage collection.  

So yes, this <em>is</em> a security concern - but even using `char[]` only reduces the window of opportunity for an attacker, and it's only for this specific type of attack.  

As noted in the comments, it's possible that arrays being moved by the garbage collector will leave stray copies of the data in memory. I believe this is implementation-specific - the garbage collector <em>may</em> clear all memory as it goes, to avoid this sort of thing. Even if it does, there's still the time during which the `char[]` contains the actual characters as an attack window.  

#### Answer 2 (score 1182)
While other suggestions here seem valid, there is one other good reason. With plain `String` you have much higher chances of <strong>accidentally printing the password to logs</strong>, monitors or some other insecure place. `char[]` is less vulnerable.  

Consider this:  

```java
public static void main(String[] args) {
    Object pw = "Password";
    System.out.println("String: " + pw);

    pw = "Password".toCharArray();
    System.out.println("Array: " + pw);
}
```

Prints:  

```java
String: Password
Array: [C@5829428e
```

#### Answer 3 (score 665)
To quote an official document, the <a href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#PBEEx">Java Cryptography Architecture guide</a> says this about `char[]` vs. `String` passwords (about password-based encryption, but this is more generally about passwords of course):  

<blockquote>
  <p>It would seem logical to collect and store the password in an object
  of type `java.lang.String`. However, here's the caveat: `Object`s of
  type `String` are immutable, i.e., there are no methods defined that
  allow you to change (overwrite) or zero out the contents of a `String`
  after usage. This feature makes `String` objects unsuitable for
  storing security sensitive information such as user passwords. You
  should always collect and store security sensitive information in a
  `char` array instead.</p>
</blockquote>

<a href="http://www.oracle.com/technetwork/java/seccodeguide-139067.html#2">Guideline 2-2 of the Secure Coding Guidelines for the Java Programming Language, Version 4.0</a> also says something similar (although it is originally in the context of logging):  

<blockquote>
  <em>Guideline 2-2: Do not log highly sensitive information</em>  
  
  <p>Some information, such as Social Security numbers (SSNs) and
  passwords, is highly sensitive. This information should not be kept
  for longer than necessary nor where it may be seen, even by
  administrators. For instance, it should not be sent to log files and
  its presence should not be detectable through searches. Some transient
  data may be kept in mutable data structures, such as char arrays, and
  cleared immediately after use. Clearing data structures has reduced
  effectiveness on typical Java runtime systems as objects are moved in
  memory transparently to the programmer.</p>
  
  <p>This guideline also has implications for implementation and use of
  lower-level libraries that do not have semantic knowledge of the data
  they are dealing with. As an example, a low-level string parsing
  library may log the text it works on. An application may parse an SSN
  with the library. This creates a situation where the SSNs are
  available to administrators with access to the log files.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Why use getters and setters/accessors? (score [367892](https://stackoverflow.com/q/1568091) in 2017)

#### Question
What's the advantage of using getters and setters - that only get and set - instead of simply using public fields for those variables?  

If getters and setters are ever doing more than just the simple get/set, I can figure this one out very quickly, but I'm not 100% clear on how:  

```java
public String foo;
```

is any worse than:  

```java
private String foo;
public void setFoo(String foo) { this.foo = foo; }
public String getFoo() { return foo; }
```

Whereas the former takes a lot less boilerplate code.  

#### Answer accepted (score 915)
<strong>There are actually <em>many good reasons</em> to consider using accessors</strong> rather than directly exposing fields of a class - beyond just the argument of encapsulation and making future changes easier.   

<em>Here are the some of the reasons I am aware of:</em>  

<ul>
<li>Encapsulation of behavior associated with getting or setting the property - this allows additional functionality (like validation) to be added more easily later.</li>
<li>Hiding the internal representation of the property while exposing a property using an alternative representation.</li>
<li>Insulating your public interface from change - allowing the public interface to remain constant while the implementation changes without affecting existing consumers.</li>
<li>Controlling the lifetime and memory management (disposal) semantics of the property - particularly important in non-managed memory environments (like C++ or Objective-C).</li>
<li>Providing a debugging interception point for when a property changes at runtime - debugging when and where a property changed to a particular value can be quite difficult without this in some languages.</li>
<li>Improved interoperability with libraries that are designed to operate against property getter/setters - Mocking, Serialization, and WPF come to mind.</li>
<li>Allowing inheritors to change the semantics of how the property behaves and is exposed by overriding the getter/setter methods.</li>
<li>Allowing the getter/setter to be passed around as lambda expressions rather than values.</li>
<li>Getters and setters can allow different access levels - for example the get may be public, but the set could be protected.</li>
</ul>

#### Answer 2 (score 445)
Because 2 weeks (months, years) from now when you realize that your setter needs to do <strong>more</strong> than just set the value, you'll also realize that the property has been used directly in 238 other classes :-)  

#### Answer 3 (score 344)
A public field is not worse than a getter/setter pair that does nothing except returning the field and assigning to it. First, it's clear that (in most languages) there is no functional difference. Any difference must be in other factors, like maintainability or readability.  

An oft-mentioned advantage of getter/setter pairs, isn't. There's this claim that you can change the implementation and your clients don't have to be recompiled. Supposedly, setters let you add functionality like validation later on and your clients don't even need to know about it. However, adding validation to a setter is a change to its preconditions, <strong>a violation of the previous contract</strong>, which was, quite simply, "you can put anything in here, and you can get that same thing later from the getter".  

So, now that you broke the contract, changing every file in the codebase is something you should want to do, not avoid. If you avoid it you're making the assumption that all the code assumed the contract for those methods was different.  

If that should not have been the contract, then the interface was allowing clients to put the object in invalid states. <em>That's the exact opposite of encapsulation</em> If that field could not really be set to anything from the start, why wasn't the validation there from the start?  

This same argument applies to other supposed advantages of these pass-through getter/setter pairs: if you later decide to change the value being set, you're breaking the contract. If you override the default functionality in a derived class, in a way beyond a few harmless modifications (like logging or other non-observable behaviour), you're breaking the contract of the base class. That is a violation of the Liskov Substitutability Principle, which is seen as one of the tenets of OO.  

If a class has these dumb getters and setters for every field, then it is a class that has no invariants whatsoever, <em>no contract</em>. Is that really object-oriented design? If all the class has is those getters and setters, it's just a dumb data holder, and dumb data holders should look like dumb data holders:  

```java
class Foo {
public:
    int DaysLeft;
    int ContestantNumber;
};
```

Adding pass-through getter/setter pairs to such a class adds no value. Other classes should provide meaningful operations, not just operations that fields already provide. That's how you can define and maintain useful invariants.  

<blockquote>
  <p><strong>Client</strong>: "What can I do with an object of this class?"<br>
  <strong>Designer</strong>: "You can read and write several variables."<br>
  <strong>Client</strong>: "Oh... cool, I guess?"</p>
</blockquote>

There are reasons to use getters and setters, but if those reasons don't exist, making getter/setter pairs in the name of false encapsulation gods is not a good thing. Valid reasons to make getters or setters include the things often mentioned as the potential changes you can make later, like validation or different internal representations. Or maybe the value should be readable by clients but not writable (for example, reading the size of a dictionary), so a simple getter is a nice choice. But those reasons should be there when you make the choice, and not just as a potential thing you may want later. This is an instance of YAGNI (<em>You Ain't Gonna Need It</em>).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Proper use cases for Android UserManager.isUserAGoat()? (score [301207](https://stackoverflow.com/q/13375357) in 2018)

#### Question
<p>I was looking at the new APIs introduced in <a href="http://en.wikipedia.org/wiki/Android_version_history#Android_4.1.2F4.2_Jelly_Bean" rel="noreferrer">Android 4.2</a>.
While looking at the <a href="http://developer.android.com/reference/android/os/UserManager.html" rel="noreferrer">`UserManager`</a> class I came across the following method:</p>

<blockquote>
```java
public boolean isUserAGoat()
```
  
  Used to determine whether the user making this call is subject to teleportations.  
  
  Returns whether the user making this call is a goat.  
</blockquote>

How and when should this be used?  

#### Answer accepted (score 1710)
From their <strong><a href="https://android.googlesource.com/platform/frameworks/base/+/android-5.0.0_r6/core/java/android/os/UserManager.java#433" rel="noreferrer">source</a></strong>, the method used to return `false` until it was changed in API 21.  

```java
/**
 * Used to determine whether the user making this call is subject to
 * teleportations.
 * @return whether the user making this call is a goat 
 */
public boolean isUserAGoat() {
    return false;
}
```

It looks like the method has no real use for us as developers. Someone has previously stated that it might be an <strong><a href="http://en.wikipedia.org/wiki/Easter_egg_(media)" rel="noreferrer">Easter egg</a></strong>.  

In API 21 the implementation was changed to check if there is an installed app with the package `com.coffeestainstudios.goatsimulator`  

```java
/**
 * Used to determine whether the user making this call is subject to
 * teleportations.
 *
 * <p>As of {@link android.os.Build.VERSION_CODES#LOLLIPOP}, this method can
 * now automatically identify goats using advanced goat recognition technology.</p>
 *
 * @return Returns true if the user making this call is a goat.
 */
public boolean isUserAGoat() {
    return mContext.getPackageManager()
            .isPackageAvailable("com.coffeestainstudios.goatsimulator");
}
```

Here is the <a href="https://android.googlesource.com/platform/frameworks/base/+/android-5.0.0_r6/core/java/android/os/UserManager.java#442" rel="noreferrer">source</a> and the <a href="https://android.googlesource.com/platform/frameworks/base/+/e4ab16ad98b183afbf7a21ad7314372de41a8b57%5E%21/#F1" rel="noreferrer">change</a>.  

#### Answer 2 (score 961)
I don't know if this was "the" official use case, but the following produces a warning in Java (that can further produce compile errors if mixed with `return` statements, leading to unreachable code):  

```java
while (1 == 2) { // Note that "if" is treated differently
    System.out.println("Unreachable code");
}
```

However this is legal:  

```java
while (isUserAGoat()) {
    System.out.println("Unreachable but determined at runtime, not at compile time");
}
```

So I often find myself writing a silly utility method for the quickest way to dummy out a code block, then in completing debugging find all calls to it, so provided the implementation doesn't change this can be used for that.  

<a href="http://docs.oracle.com/javase/specs/jls/se7/html/jls-14.html#jls-14.21" rel="noreferrer">JLS</a> points out `if (false)` does not trigger "unreachable code" for the specific reason that this would break support for debug flags, i.e., basically this use case (h/t @auselen). (`static final boolean DEBUG = false;` for instance).  

I replaced `while` for `if`, producing a more obscure use case. I <em>believe</em> you can trip up your IDE, like Eclipse, with this behavior, but this edit is 4 years into the future, and I don't have an Eclipse environment to play with.  

#### Answer 3 (score 745)
This appears to be an inside joke at Google. It's also featured in the Google Chrome task manager. It has no purpose, other than some engineers finding it amusing. Which is a purpose by itself, if you will.  

<ol>
<li>In Chrome, open the Task Manager with <kbd>Shift</kbd>+<kbd>Esc</kbd>. </li>
<li>Right click to add the  `Goats Teleported` column.</li>
<li>Wonder.</li>
</ol>

There is even a huge Chromium bug report about <a href="http://code.google.com/p/chromium/issues/detail?id=31482">too many teleported goats</a>.  

<img src="https://i.stack.imgur.com/1nwdC.png" alt="chrome">    

The following Chromium <a href="http://git.chromium.org/gitweb/?p=chromium.git;a=blob;f=chrome/browser/task_manager/task_manager.cc;h=ad46354259ec8687c8665820f9f53bf89ccc715d;hb=HEAD#l599">source code snippet</a> is stolen from the <a href="http://news.ycombinator.com/item?id=4782574">HN</a> comments.  

```java
int TaskManagerModel::GetGoatsTeleported(int index) const {
  int seed = goat_salt_ * (index + 1);
  return (seed >> 16) & 255;
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: How do servlets work? Instantiation, sessions, shared variables and multithreading (score [282529](https://stackoverflow.com/q/3106452) in 2017)

#### Question
Suppose, I have a webserver which holds numerous servlets. For information passing among those servlets I am setting session and instance variables.  

Now, if 2 or more users send request to this server then what happens to the session variables? Will they all be common for all the users or they will be different for each user. If they are different, then how was the server able to differentiate between different users?  

One more similar question, if there are `n` users accessing a particular servlet, then this servlet gets instantiated only the first time the first user accessed it or does it get instantiated for all the users separately? In other words, what happens to the instance variables?  

#### Answer accepted (score 1770)
<h5>ServletContext</h2>

When the servlet container (like <a href="http://tomcat.apache.org" rel="noreferrer">Apache Tomcat</a>) starts up, it will deploy and load all its web applications. When a web application is loaded, the servlet container creates the <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletContext.html" rel="noreferrer">`ServletContext`</a> once and keeps it in the server's memory. The web app's `web.xml` and all of included `web-fragment.xml` files is parsed, and each `&lt;servlet&gt;`, `&lt;filter&gt;` and `&lt;listener&gt;` found (or each class annotated with `@WebServlet`, `@WebFilter` and `@WebListener` respectively) is instantiated once and kept in the server's memory as well. For each instantiated filter, its `init()` method is invoked with a new <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/FilterConfig.html" rel="noreferrer">`FilterConfig`</a>.  

When a `Servlet` has a `&lt;servlet&gt;&lt;load-on-startup&gt;` or `@WebServlet(loadOnStartup)` value greater than `0`, then its `init()` method is also invoked during startup with a new <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletConfig.html" rel="noreferrer">`ServletConfig`</a>. Those servlets are initialized in the same order specified by that value (`1` is 1st, `2` is 2nd, etc). If the same value is specified for more than one servlet, then each of those servlets is loaded in the same order as they appear in the `web.xml`, `web-fragment.xml`, or `@WebServlet` classloading. In the event the "load-on-startup" value is absent, the `init()` method will be invoked whenever the HTTP request hits that servlet for the very first time.   

When the servlet container is finished with all of the above described initialization steps, then the <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletContextListener.html#contextInitialized-javax.servlet.ServletContextEvent-" rel="noreferrer">`ServletContextListener#contextInitialized()`</a> will be invoked.  

When the servlet container shuts down, it unloads all web applications, invokes the `destroy()` method of all its initialized servlets and filters, and all `ServletContext`, `Servlet`, `Filter` and `Listener` instances are trashed. Finally the <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/ServletContextListener.html#contextDestroyed-javax.servlet.ServletContextEvent-" rel="noreferrer">`ServletContextListener#contextDestroyed()`</a> will be invoked.  

<h5>HttpServletRequest and HttpServletResponse</h2>

The servlet container is attached to a web server that listens for HTTP requests on a certain port number (port 8080 is usually used during development and port 80 in production). When a client (e.g. user with a web browser, or <a href="https://stackoverflow.com/questions/2793150/how-to-use-java-net-urlconnection-to-fire-and-handle-http-requests">programmatically using `URLConnection`</a>) sends an HTTP request, the servlet container creates new <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/http/HttpServletRequest.html" rel="noreferrer">`HttpServletRequest`</a> and <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/http/HttpServletResponse.html" rel="noreferrer">`HttpServletResponse`</a> objects and passes them through any defined `Filter` in the chain and, eventually, the `Servlet` instance.   

In the case of <a href="https://stackoverflow.com/tags/servlet-filters/info">filters</a>, the `doFilter()` method is invoked. When the servlet container's code calls `chain.doFilter(request, response)`, the request and response continue on to the next filter, or hit the servlet if there are no remaining filters.  

In the case of <a href="https://stackoverflow.com/tags/servlets/info">servlets</a>, the `service()` method is invoked. By default, this method determines which one of the `doXxx()` methods to invoke based off of  `request.getMethod()`. If the determined method is absent from the servlet, then an HTTP 405 error is returned in the response.   

The request object provides access to all of the information about the HTTP request, such as its URL, headers, query string and body. The response object provides the ability to control and send the HTTP response the way you want by, for instance, allowing you to set the headers and the body (usually with generated HTML content from a JSP file). When the HTTP response is committed and finished, both the request and response objects are recycled and made available for reuse.  

<h5>HttpSession</h2>

When a client visits the webapp for the first time and/or the <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/http/HttpSession.html" rel="noreferrer">`HttpSession`</a> is obtained for the first time via `request.getSession()`, the servlet container creates a new `HttpSession` object, generates a long and unique ID (which you can get by `session.getId()`), and stores it in the server's memory. The servlet container also sets a <a href="https://javaee.github.io/javaee-spec/javadocs/javax/servlet/http/Cookie.html" rel="noreferrer">`Cookie`</a> in the `Set-Cookie` header of the HTTP response with `JSESSIONID` as its name and the unique session ID as its value.   

As per the <a href="http://www.faqs.org/rfcs/rfc2965.html" rel="noreferrer">HTTP cookie specification</a> (a contract any decent web browser and web server must adhere to), the client (the web browser) is required to send this cookie back in subsequent requests in the `Cookie` header for as long as the cookie is valid (i.e. the unique ID must refer to an unexpired session and the domain and path are correct). Using your browser's built-in HTTP traffic monitor, you can verify that the cookie is valid (press F12 in Chrome / Firefox 23+ / IE9+, and check the <em>Net/Network</em> tab). The servlet container will check the `Cookie` header of every incoming HTTP request for the presence of the cookie with the name `JSESSIONID` and use its value (the session ID) to get the associated `HttpSession` from server's memory.  

The `HttpSession` stays alive until it has been idle (i.e. not used in a request) for more than the timeout value specified in `&lt;session-timeout&gt;`, a setting in `web.xml`. The timeout value defaults to 30 minutes. So, when the client doesn't visit the web app for longer than the time specified, the servlet container trashes the session. Every subsequent request, even with the cookie specified, will not have access to the same session anymore; the servlet container will create a new session.  

On the client side, the session cookie stays alive for as long as the browser instance is running. So, if the client closes the browser instance (all tabs/windows), then the session is trashed on the client's side. In a new browser instance, the cookie associated with the session wouldn't exist, so it would no longer be sent. This causes an entirely new `HttpSession` to be created, with an entirely new session cookie being used.  

<h5>In a nutshell</h2>

<ul>
<li>The `ServletContext` lives for as long as the web app lives. It is shared among <em>all</em> requests in <em>all</em> sessions.</li>
<li>The `HttpSession` lives for as long as the client is interacting with the web app with the same browser instance, and the session hasn't timed out at the server side. It is shared among <em>all</em> requests in the <em>same</em> session.</li>
<li>The `HttpServletRequest` and `HttpServletResponse` live from the time the servlet receives an HTTP request from the client, until the complete response (the web page) has arrived. It is <em>not</em> shared elsewhere.</li>
<li>All `Servlet`, `Filter` and `Listener` instances live as long as the web app lives. They are shared among <em>all</em> requests in <em>all</em> sessions.</li>
<li>Any `attribute` that is defined in `ServletContext`, `HttpServletRequest` and `HttpSession` will live as long as the object in question lives. The object itself represents the "scope" in bean management frameworks such as JSF, CDI, Spring, etc. Those frameworks store their scoped beans as an `attribute` of its closest matching scope.</li>
</ul>

<h5>Thread Safety</h2>

That said, your major concern is possibly <em>thread safety</em>. You should now know that servlets and filters are shared among all requests. That's the nice thing about Java, it's multithreaded and different threads (read: HTTP requests) can make use of the same instance. It would otherwise be too expensive to recreate, `init()` and `destroy()` them for every single request.  

You should also realize that you should <strong>never</strong> assign any request or session scoped data as an <em>instance</em> variable of a servlet or filter. It will be shared among all other requests in other sessions. That's <strong>not</strong> thread-safe! The below example illustrates this:  

```java
public class ExampleServlet extends HttpServlet {

    private Object thisIsNOTThreadSafe;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object thisIsThreadSafe;

        thisIsNOTThreadSafe = request.getParameter("foo"); // BAD!! Shared among all requests!
        thisIsThreadSafe = request.getParameter("foo"); // OK, this is thread safe.
    } 
}
```

<h5>See also:</h3>

<ul>
<li><a href="https://stackoverflow.com/questions/2095397/what-is-the-difference-between-jsf-servlet-and-jsp">What is the difference between JSF, Servlet and JSP?</a></li>
<li><a href="https://stackoverflow.com/questions/1700390/best-option-for-session-management-in-java">Best option for Session management in Java</a></li>
<li><a href="https://stackoverflow.com/questions/4140448/difference-between-and-in-servlet-mapping-url-pattern">Difference between / and /* in servlet mapping url pattern</a></li>
<li><a href="https://stackoverflow.com/questions/2349633/doget-and-dopost-in-servlets">doGet and doPost in Servlets</a></li>
<li><a href="https://stackoverflow.com/questions/8011138/servlet-seems-to-handle-multiple-concurrent-requests-synchronously/">Servlet seems to handle multiple concurrent browser requests synchronously</a></li>
<li><a href="https://stackoverflow.com/questions/9555842/why-servlets-are-not-thread-safe/">Why Servlets are not thread Safe?</a></li>
</ul>

#### Answer 2 (score 424)
<h5>Sessions</h2>

<p><img src="https://i.stack.imgur.com/ABDSX.png" alt="enter image description here">
<img src="https://i.stack.imgur.com/IWAF3.png" alt="enter image description here"></p>

In short: the web server issues a unique identifier to <em>each visitor</em> on his <em>first</em> visit. The visitor must bring back that ID for him to be recognised next time around. This identifier also allows the server to properly segregate objects owned by one session against that of another.  

<h5>Servlet Instantiation</h2>

If <strong>load-on-startup</strong> is <strong>false</strong>:  

<p><img src="https://i.stack.imgur.com/Jjvcb.png" alt="enter image description here">
<img src="https://i.stack.imgur.com/7Bw3x.png" alt="enter image description here"></p>

If <strong>load-on-startup</strong> is <strong>true</strong>:  

<p><img src="https://i.stack.imgur.com/t33bd.png" alt="enter image description here">
<img src="https://i.stack.imgur.com/e7BB7.png" alt="enter image description here"></p>

Once he's on the service mode and on the groove, the <em>same</em> servlet will work on the requests from all other clients.   

<img src="https://i.stack.imgur.com/gqoR4.png" alt="enter image description here">  

Why isn't it a good idea to have one instance per client? Think about this: Will you hire one pizza guy for every order that came? Do that and you'd be out of business in no time.  

It comes with a small risk though. Remember: this single guy holds all the order information in his pocket: so if you're not cautious about <a href="http://tutorials.jenkov.com/java-servlets/servlet-concurrency.html" rel="noreferrer">thread safety on servlets</a>, he may end up giving the wrong order to a certain client.  

#### Answer 3 (score 42)
Session in Java servlets is the same as session in other languages such as PHP.  It is unique to the user.  The server can keep track of it in different ways such as cookies, url rewriting etc.  This <a href="http://java.sun.com/products/servlet/2.2/javadoc/javax/servlet/http/HttpSession.html" rel="noreferrer">Java doc</a> article explains it in the context of Java servlets and indicates that exactly how session is maintained is an implementation detail left to the designers of the server.  The specification only stipulates that it must be maintained as unique to a user across multiple connections to the server.  Check out <a href="http://download.oracle.com/docs/cd/A97336_01/buslog.102/a83726/tecbkgn2.htm" rel="noreferrer">this article from Oracle</a> for more information about both of your questions.  

<strong>Edit</strong> There is an excellent tutorial <a href="http://www.apl.jhu.edu/~hall/java/Servlet-Tutorial/Servlet-Tutorial-Session-Tracking.html" rel="noreferrer">here</a> on how to work with session inside of servlets. And <a href="http://docs.oracle.com/javaee/5/tutorial/doc/bnafd.html" rel="noreferrer">here</a> is a chapter from Sun about Java Servlets, what they are and how to use them.  Between those two articles, you should be able to answer all of your questions.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: Why don't Java's +=, -=, *=, /= compound assignment operators require casting? (score [275111](https://stackoverflow.com/q/8710619) in 2018)

#### Question
Until today, I thought that for example:  

```java
i += j;
```

Was just a shortcut for:  

```java
i = i + j;
```

But if we try this:  

```java
int i = 5;
long j = 8;
```

Then `i = i + j;` will not compile but `i += j;` will compile fine.  

<p>Does it mean that in fact `i += j;` is a shortcut for something like this
`i = (type of i) (i + j)`?</p>

#### Answer accepted (score 2385)
As always with these questions, the JLS holds the answer. In this case <a href="http://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html#jls-15.26.2">§15.26.2 Compound Assignment Operators</a>. An extract:  

<blockquote>
  A compound assignment expression of the form `E1&nbsp;op=&nbsp;E2` is equivalent to `E1&nbsp;=&nbsp;(T)((E1)&nbsp;op&nbsp;(E2))`, where `T` is the type of `E1`, except that `E1` is evaluated only once.  
</blockquote>

An example cited from <a href="http://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html#jls-15.26.2">§15.26.2</a>  

<blockquote>
  [...] the following code is correct:  

```java
short x = 3;
x += 4.6;
```
  
  and results in x having the value 7 because it is equivalent to:  

```java
short x = 3;
x = (short)(x + 4.6);
```
</blockquote>

In other words, your assumption is correct.  

#### Answer 2 (score 471)
A good example of this casting is using *= or /=  

```java
byte b = 10;
b *= 5.7;
System.out.println(b); // prints 57
```

or  

```java
byte b = 100;
b /= 2.5;
System.out.println(b); // prints 40
```

or  

```java
char ch = '0';
ch *= 1.1;
System.out.println(ch); // prints '4'
```

or  

```java
char ch = 'A';
ch *= 1.5;
System.out.println(ch); // prints 'a'
```

#### Answer 3 (score 243)
Very good question. The <a href="http://docs.oracle.com/javase/specs/jls/se7/html/jls-15.html#jls-15.26.2" rel="noreferrer">Java Language specification</a> confirms your suggestion.  

<blockquote>
  For example, the following code is correct:  

```java
short x = 3;
x += 4.6;
```
  
  and results in x having the value 7 because it is equivalent to:  

```java
short x = 3;
x = (short)(x + 4.6);
```
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: How to avoid Java code in JSP files? (score [274966](https://stackoverflow.com/q/3177733) in 2015)

#### Question
I'm new to Java EE and I know that something like the following three lines  

```java
<%= x+1 %>
<%= request.getParameter("name") %>
<%! counter++; %>
```

is an old school way of coding and in JSP version 2 there exists a method to avoid Java code in JSP files. Can someone please tell me the alternative JSP 2 lines, and what this technique is called?  

#### Answer accepted (score 1943)
The use of <em>scriptlets</em> (those `&lt;% %&gt;` things) in <a href="https://stackoverflow.com/tags/jsp/info">JSP</a> is indeed highly discouraged since the birth of <em>taglibs</em> (like <a href="https://stackoverflow.com/tags/jstl/info">JSTL</a>) and <a href="https://stackoverflow.com/tags/el/info">EL</a> (<a href="https://stackoverflow.com/tags/el/info">Expression Language</a>, those `${}` things) way back in 2001.  

The major disadvantages of <em>scriptlets</em> are:  

<ol>
<li><strong>Reusability:</strong> you can't reuse scriptlets.</li>
<li><strong>Replaceability:</strong> you can't make scriptlets abstract.</li>
<li><strong>OO-ability:</strong> you can't make use of inheritance/composition.</li>
<li><strong>Debuggability:</strong> if scriptlet throws an exception halfway, all you get is a blank page.</li>
<li><strong>Testability:</strong> scriptlets are not unit-testable.</li>
<li><strong>Maintainability:</strong> per saldo more time is needed to maintain mingled/cluttered/duplicated code logic.</li>
</ol>

<strike>Sun</strike> Oracle itself also recommends in the <a href="http://www.oracle.com/technetwork/articles/javase/code-convention-138726.html" rel="noreferrer">JSP coding conventions</a> to avoid use of <em>scriptlets</em> whenever the same functionality is possible by (tag) classes. Here are several cites of relevance:  

<blockquote>
  From JSP 1.2 Specification, it is highly recommended that the JSP Standard Tag Library  (JSTL) be used in your web application to help <strong>reduce the need for JSP scriptlets</strong> in your pages. Pages that use JSTL are, in general, easier to read and maintain.   
  
  ...  
  
  Where possible, <strong>avoid JSP scriptlets</strong> whenever tag libraries provide equivalent functionality. This makes pages easier to read and maintain, helps to separate business logic from presentation logic, and will make your pages easier to evolve into JSP 2.0-style pages (JSP 2.0 Specification supports but de-emphasizes the use of scriptlets).  
  
  ...  
  
  In the spirit of adopting the model-view-controller (MVC) design pattern to reduce coupling between the presentation tier from the business logic, <strong>JSP scriptlets should not be used</strong> for writing business logic. Rather, JSP scriptlets are used if necessary to transform data (also called "value objects") returned from processing the client's requests into a proper client-ready format. Even then, this would be better done with a front controller servlet or a custom tag.  
</blockquote>

<hr>

<strong>How to replace <em>scriptlets</em> entirely depends on the sole purpose of the code/logic. More than often this code is to be placed in a fullworthy Java class:</strong>  

<ul>
<li><p>If you want to invoke the <strong>same</strong> Java code on <em>every</em> request, less-or-more regardless of the requested page, e.g. checking if a user is logged in, then implement a <a href="https://stackoverflow.com/tags/servlet-filters/info">filter</a> and write code accordingly in <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/Filter.html#doFilter%28javax.servlet.ServletRequest,%20javax.servlet.ServletResponse,%20javax.servlet.FilterChain%29" rel="noreferrer">`doFilter()`</a> method. E.g.:</p>

```java
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
    if (((HttpServletRequest) request).getSession().getAttribute("user") == null) {
        ((HttpServletResponse) response).sendRedirect("login"); // Not logged in, redirect to login page.
    } else {
        chain.doFilter(request, response); // Logged in, just continue request.
    }
}
```

When mapped on an appropriate `&lt;url-pattern&gt;` covering the JSP pages of interest, then you don't need to copypaste the same piece of code overall JSP pages.  

<hr></li>
<li><p>If you want to invoke some Java code to <strong>preprocess</strong> a request, e.g. preloading some list from a database to display in some table, if necessary based on some query parameters, then implement a <a href="https://stackoverflow.com/tags/servlets/info">servlet</a> and write code accordingly in <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html#doGet%28javax.servlet.http.HttpServletRequest,%20javax.servlet.http.HttpServletResponse%29" rel="noreferrer">`doGet()`</a> method. E.g.:</p>

```java
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        List<Product> products = productService.list(); // Obtain all products.
        request.setAttribute("products", products); // Store products in request scope.
        request.getRequestDispatcher("/WEB-INF/products.jsp").forward(request, response); // Forward to JSP page to display them in a HTML table.
    } catch (SQLException e) {
        throw new ServletException("Retrieving products failed!", e);
    }
}
```

This way dealing with exceptions is easier. The DB is not accessed in the midst of JSP rendering, but far before the JSP is been displayed. You still have the possibility to change the response whenever the DB access throws an exception. In the above example, the default error 500 page will be displayed which you can anyway customize by an `&lt;error-page&gt;` in `web.xml`.  

<hr></li>
<li><p>If you want to invoke some Java code to <strong>postprocess</strong> a request, e.g. processing a form submit, then implement a <a href="https://stackoverflow.com/tags/servlets/info">servlet</a> and write code accordingly in <a href="http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html#doPost%28javax.servlet.http.HttpServletRequest,%20javax.servlet.http.HttpServletResponse%29" rel="noreferrer">`doPost()`</a> method. E.g.:</p>

```java
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    User user = userService.find(username, password);

    if (user != null) {
        request.getSession().setAttribute("user", user); // Login user.
        response.sendRedirect("home"); // Redirect to home page.
    } else {
        request.setAttribute("message", "Unknown username/password. Please retry."); // Store error message in request scope.
        request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response); // Forward to JSP page to redisplay login form with error.
    }
}
```

This way dealing with different result page destinations is easier: redisplaying the form with validation errors in case of an error (in this particular example you can redisplay it using `${message}` in <a href="https://stackoverflow.com/tags/el/info">EL</a>), or just taking to the desired target page in case of success.  

<hr></li>
<li><p>If you want to invoke some Java code to <strong>control</strong> the execution plan and/or the destination of the request and the response, then implement a <a href="https://stackoverflow.com/tags/servlets/info">servlet</a> according to the <a href="https://stackoverflow.com/questions/3541077/design-patterns-web-based-applications/3542297#3542297">MVC's Front Controller Pattern</a>. E.g.:</p>

```java
protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        Action action = ActionFactory.getAction(request);
        String view = action.execute(request, response);

        if (view.equals(request.getPathInfo().substring(1)) {
            request.getRequestDispatcher("/WEB-INF/" + view + ".jsp").forward(request, response);
        } else {
            response.sendRedirect(view);
        }
    } catch (Exception e) {
        throw new ServletException("Executing action failed.", e);
    }
}
```

Or just adopt an MVC framework like <a href="https://stackoverflow.com/tags/jsf/info">JSF</a>, <a href="https://stackoverflow.com/tags/spring-mvc/info">Spring MVC</a>, <a href="https://stackoverflow.com/tags/wicket/info">Wicket</a>, etc so that you end up with just a JSP/Facelets page and a JavaBean class without the need for a custom servlet.  

<hr></li>
<li><p>If you want to invoke some Java code to <strong>control the flow</strong> inside a JSP page, then you need to grab an (existing) flow control taglib like <a href="http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/c/tld-summary.html" rel="noreferrer">JSTL core</a>. E.g. displaying `List&lt;Product&gt;` in a table:</p>

```java
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
...
<table>
    <c:forEach items="${products}" var="product">
        <tr>
            <td>${product.name}</td>
            <td>${product.description}</td>
            <td>${product.price}</td>
        </tr>
    </c:forEach>
</table>
```

With XML-style tags which fit nicely among all that HTML, the code is better readable (and thus better maintainable) than a bunch of scriptlets with various opening and closing braces (<em>"Where the heck does this closing brace belong to?"</em>). An easy aid is to configure your web application to throw an exception whenever <em>scriptlets</em> are still been used by adding the following piece to `web.xml`:  

```java
<jsp-config>
    <jsp-property-group>
        <url-pattern>*.jsp</url-pattern>
        <scripting-invalid>true</scripting-invalid>
    </jsp-property-group>
</jsp-config>
```

In <a href="https://stackoverflow.com/tags/facelets/info">Facelets</a>, the successor of JSP, which is part of the Java EE provided MVC framework <a href="https://stackoverflow.com/tags/jsf/info">JSF</a>, it is already <strong>not</strong> possible to use <em>scriptlets</em>. This way you're automatically forced to do things "the right way".  

<hr></li>
<li><p>If you want to invoke some Java code to <strong>access and display</strong> "backend" data inside a JSP page, then you need to use EL (Expression Language), those `${}` things. E.g. redisplaying submitted input values:</p>

```java
<input type="text" name="foo" value="${param.foo}" />
```

The `${param.foo}` displays the outcome of `request.getParameter("foo")`.  

<hr></li>
<li><p>If you want to invoke some <strong>utility</strong> Java code directly in the JSP page (typically `public static` methods), then you need to define them as EL functions. There's a standard <a href="http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/fn/tld-summary.html" rel="noreferrer">functions taglib</a> in JSTL, but <a href="http://docs.oracle.com/javaee/5/tutorial/doc/bnahq.html#bnaiq" rel="noreferrer">you can also easily create functions yourself</a>. Here's an example how JSTL `fn:escapeXml` is useful to prevent <a href="http://en.wikipedia.org/wiki/Cross-site_scripting" rel="noreferrer">XSS</a> <a href="http://ha.ckers.org/xss.html" rel="noreferrer">attacks</a>.</p>

```java
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
...
<input type="text" name="foo" value="${fn:escapeXml(param.foo)}" />
```

Note that the XSS sensitivity is in no way specifically related to Java/JSP/JSTL/EL/whatever, this problem needs to be taken into account in <strong>every</strong> web application you develop. The problem of <em>scriptlets</em> is that it provides no way of builtin preventions, at least not using the standard Java API. JSP's successor Facelets has already implicit HTML escaping, so you don't need to worry about XSS holes in Facelets.  </li>
</ul>

<h5>See also:</h3>

<ul>
<li><a href="https://stackoverflow.com/questions/2095397/what-is-the-difference-between-jsf-servlet-and-jsp/2097732#2097732">What's the difference between JSP, Servlet and JSF?</a></li>
<li><a href="https://stackoverflow.com/questions/3106452/java-servlet-instantiation-and-session-variables/3106909#3106909">How does Servlet, ServletContext, HttpSession and HttpServletRequest/Response work?</a></li>
<li><a href="https://stackoverflow.com/questions/5003142/jsp-using-mvc-and-jdbc">Basic MVC example with JSP, Servlet and JDBC</a></li>
<li><a href="https://stackoverflow.com/questions/3541077/design-patterns-web-based-applications/">Design patterns in Java web applications</a></li>
<li><a href="http://balusc.blogspot.com/2010/01/hidden-features-of-jspservlet.html" rel="noreferrer">Hidden features of JSP/Servlet</a></li>
</ul>

#### Answer 2 (score 223)
<strong>As a Safeguard: Disable Scriptlets For Good</strong>  

As <a href="https://stackoverflow.com/questions/2188706/how-to-avoid-using-scriptlets-in-my-jsp-page">another question</a> is discussing, you can and always should disable scriptlets in your `web.xml` web application descriptor.  

I would always do that in order to prevent any developer adding scriptlets, especially in bigger companies where you will lose overview sooner or later. The `web.xml` settings look like this:  

```java
<jsp-config>
  <jsp-property-group>
    <url-pattern>*.jsp</url-pattern>
     <scripting-invalid>true</scripting-invalid>
  </jsp-property-group>
</jsp-config>
```

#### Answer 3 (score 107)
<a href="https://jstl.java.net/" rel="noreferrer">JSTL</a> offers tags for conditionals, loops, sets, gets, etc. For example:  

```java
<c:if test="${someAttribute == 'something'}">
   ...
</c:if>
```

JSTL works with request attributes - they are most often set in the request by a Servlet, which <em>forwards</em> to the JSP.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: Fastest way to determine if an integer's square root is an integer (score [262060](https://stackoverflow.com/q/295579) in 2018)

#### Question
I'm looking for the fastest way to determine if a `long` value is a perfect square (i.e. its square root is another integer):   

<ol>
<li>I've done it the easy way, by using the built-in `Math.sqrt()`
function, but I'm wondering if there is a way to do it faster by
restricting yourself to integer-only domain.</li>
<li>Maintaining a lookup table is impractical (since there are about
2<sup>31.5</sup> integers whose square is less than 2<sup>63</sup>).</li>
</ol>

Here is the very simple and straightforward way I'm doing it now:  

```java
public final static boolean isPerfectSquare(long n)
{
  if (n < 0)
    return false;

  long tst = (long)(Math.sqrt(n) + 0.5);
  return tst*tst == n;
}
```

<sub>Note: I'm using this function in many <a href="http://projecteuler.net/" rel="noreferrer">Project Euler</a> problems.  So no one else will ever have to maintain this code.  And this kind of micro-optimization could actually make a difference, since part of the challenge is to do every algorithm in less than a minute, and this function will need to be called millions of times in some problems.</sub>  

<hr>

I've tried the different solutions to the problem:  

<ul>
<li>After exhaustive testing, I found that adding `0.5` to the result of Math.sqrt() is not necessary, at least not on my machine.</li>
<li>The <a href="https://en.wikipedia.org/wiki/Fast_inverse_square_root" rel="noreferrer">fast inverse square root</a> was faster, but it gave incorrect results for n >= 410881.  However, as suggested by <a href="https://stackoverflow.com/users/38426/bobbyshaftoe">BobbyShaftoe</a>, we can use the FISR hack for n &lt; 410881.</li>
<li>Newton's method was a good bit slower than `Math.sqrt()`.  This is probably because `Math.sqrt()` uses something similar to Newton's Method, but implemented in the hardware so it's much faster than in Java.  Also, Newton's Method still required use of doubles.</li>
<li>A modified Newton's method, which used a few tricks so that only integer math was involved, required some hacks to avoid overflow (I want this function to work with all positive 64-bit signed integers), and it was still slower than `Math.sqrt()`.</li>
<li>Binary chop was even slower.  This makes sense because the binary chop will on average require 16 passes to find the square root of a 64-bit number.</li>
<li>According to John's tests, using `or` statements is faster in C++ than using a `switch`, but in Java and C# there appears to be no difference between `or` and `switch`.</li>
<li>I also tried making a lookup table (as a private static array of 64 boolean values).  Then instead of either switch or `or` statement, I would just say `if(lookup[(int)(n&amp;0x3F)]) { test } else return false;`.  To my surprise, this was (just slightly) slower. This is because <a href="https://stackoverflow.com/questions/299079/why-is-this-code-with-several-or-statements-slightly-faster-than-using-a-lookup-t#299205">array bounds are checked in Java</a>. </li>
</ul>

#### Answer accepted (score 686)
I figured out a method that works ~35% faster than your 6bits+Carmack+sqrt code, at least with my CPU (x86) and programming language (C/C++).  Your results may vary, especially because I don't know how the Java factor will play out.  

My approach is threefold:  

<ol>
<li>First, filter out obvious answers.  This includes negative numbers and looking at the last 4 bits.  (I found looking at the last six didn't help.)  I also answer yes for 0.  (In reading the code below, note that my input is `int64 x`.)

```java
if( x < 0 || (x&2) || ((x & 7) == 5) || ((x & 11) == 8) )
    return false;
if( x == 0 )
    return true;```
</li>
<li>Next, check if it's a square modulo 255 = 3 * 5 * 17.  Because that's a product of three distinct primes, only about 1/8 of the residues mod 255 are squares.  However, in my experience, calling the modulo operator (%) costs more than the benefit one gets, so I use bit tricks involving 255 = 2^8-1 to compute the residue.  (For better or worse, I am not using the trick of reading individual bytes out of a word, only bitwise-and and shifts.)
```java
int64 y = x;
y = (y & 4294967295LL) + (y >> 32); 
y = (y & 65535) + (y >> 16);
y = (y & 255) + ((y >> 8) & 255) + (y >> 16);
// At this point, y is between 0 and 511.  More code can reduce it farther.
</pre></code>
To actually check if the residue is a square, I look up the answer in a precomputed table.
```java
if( bad255[y] )
    return false;
// However, I just use a table of size 512
```
</li>
<li>Finally, try to compute the square root using a method similar to <a href="http://en.wikipedia.org/wiki/Hensel%27s_lemma" rel="noreferrer">Hensel's lemma</a>.  (I don't think it's applicable directly, but it works with some modifications.)  Before doing that, I divide out all powers of 2 with a binary search:
```java
if((x & 4294967295LL) == 0)
    x >>= 32;
if((x & 65535) == 0)
    x >>= 16;
if((x & 255) == 0)
    x >>= 8;
if((x & 15) == 0)
    x >>= 4;
if((x & 3) == 0)
    x >>= 2;```
At this point, for our number to be a square, it must be 1 mod 8.
```java
if((x & 7) != 1)
    return false;```
The basic structure of Hensel's lemma is the following.  (Note: untested code; if it doesn't work, try t=2 or 8.)
```java
int64 t = 4, r = 1;
t <<= 1; r += ((x - r * r) & t) >> 1;
t <<= 1; r += ((x - r * r) & t) >> 1;
t <<= 1; r += ((x - r * r) & t) >> 1;
// Repeat until t is 2^33 or so.  Use a loop if you want.```
The idea is that at each iteration, you add one bit onto r, the "current" square root of x; each square root is accurate modulo a larger and larger power of 2, namely t/2.  At the end, r and t/2-r will be square roots of x modulo t/2.  (Note that if r is a square root of x, then so is -r.  This is true even modulo numbers, but beware, modulo some numbers, things can have even more than 2 square roots; notably, this includes powers of 2.)  Because our actual square root is less than 2^32, at that point we can actually just check if r or t/2-r are real square roots.  In my actual code, I use the following modified loop:
```java
int64 r, t, z;
r = start[(x >> 3) & 1023];
do {
    z = x - r * r;
    if( z == 0 )
        return true;
    if( z < 0 )
        return false;
    t = z & (-z);
    r += (z & t) >> 1;
    if( r > (t >> 1) )
        r = t - r;
} while( t <= (1LL << 33) );```
The speedup here is obtained in three ways: precomputed start value (equivalent to ~10 iterations of the loop), earlier exit of the loop, and skipping some t values.  For the last part, I look at `z = r - x * x`, and set t to be the largest power of 2 dividing z with a bit trick.  This allows me to skip t values that wouldn't have affected the value of r anyway.  The precomputed start value in my case picks out the "smallest positive" square root modulo 8192.
</li>
</ol>

Even if this code doesn't work faster for you, I hope you enjoy some of the ideas it contains.  Complete, tested code follows, including the precomputed tables.  

```java
typedef signed long long int int64;

int start[1024] =
{1,3,1769,5,1937,1741,7,1451,479,157,9,91,945,659,1817,11,
1983,707,1321,1211,1071,13,1479,405,415,1501,1609,741,15,339,1703,203,
129,1411,873,1669,17,1715,1145,1835,351,1251,887,1573,975,19,1127,395,
1855,1981,425,453,1105,653,327,21,287,93,713,1691,1935,301,551,587,
257,1277,23,763,1903,1075,1799,1877,223,1437,1783,859,1201,621,25,779,
1727,573,471,1979,815,1293,825,363,159,1315,183,27,241,941,601,971,
385,131,919,901,273,435,647,1493,95,29,1417,805,719,1261,1177,1163,
1599,835,1367,315,1361,1933,1977,747,31,1373,1079,1637,1679,1581,1753,1355,
513,1539,1815,1531,1647,205,505,1109,33,1379,521,1627,1457,1901,1767,1547,
1471,1853,1833,1349,559,1523,967,1131,97,35,1975,795,497,1875,1191,1739,
641,1149,1385,133,529,845,1657,725,161,1309,375,37,463,1555,615,1931,
1343,445,937,1083,1617,883,185,1515,225,1443,1225,869,1423,1235,39,1973,
769,259,489,1797,1391,1485,1287,341,289,99,1271,1701,1713,915,537,1781,
1215,963,41,581,303,243,1337,1899,353,1245,329,1563,753,595,1113,1589,
897,1667,407,635,785,1971,135,43,417,1507,1929,731,207,275,1689,1397,
1087,1725,855,1851,1873,397,1607,1813,481,163,567,101,1167,45,1831,1205,
1025,1021,1303,1029,1135,1331,1017,427,545,1181,1033,933,1969,365,1255,1013,
959,317,1751,187,47,1037,455,1429,609,1571,1463,1765,1009,685,679,821,
1153,387,1897,1403,1041,691,1927,811,673,227,137,1499,49,1005,103,629,
831,1091,1449,1477,1967,1677,697,1045,737,1117,1737,667,911,1325,473,437,
1281,1795,1001,261,879,51,775,1195,801,1635,759,165,1871,1645,1049,245,
703,1597,553,955,209,1779,1849,661,865,291,841,997,1265,1965,1625,53,
1409,893,105,1925,1297,589,377,1579,929,1053,1655,1829,305,1811,1895,139,
575,189,343,709,1711,1139,1095,277,993,1699,55,1435,655,1491,1319,331,
1537,515,791,507,623,1229,1529,1963,1057,355,1545,603,1615,1171,743,523,
447,1219,1239,1723,465,499,57,107,1121,989,951,229,1521,851,167,715,
1665,1923,1687,1157,1553,1869,1415,1749,1185,1763,649,1061,561,531,409,907,
319,1469,1961,59,1455,141,1209,491,1249,419,1847,1893,399,211,985,1099,
1793,765,1513,1275,367,1587,263,1365,1313,925,247,1371,1359,109,1561,1291,
191,61,1065,1605,721,781,1735,875,1377,1827,1353,539,1777,429,1959,1483,
1921,643,617,389,1809,947,889,981,1441,483,1143,293,817,749,1383,1675,
63,1347,169,827,1199,1421,583,1259,1505,861,457,1125,143,1069,807,1867,
2047,2045,279,2043,111,307,2041,597,1569,1891,2039,1957,1103,1389,231,2037,
65,1341,727,837,977,2035,569,1643,1633,547,439,1307,2033,1709,345,1845,
1919,637,1175,379,2031,333,903,213,1697,797,1161,475,1073,2029,921,1653,
193,67,1623,1595,943,1395,1721,2027,1761,1955,1335,357,113,1747,1497,1461,
1791,771,2025,1285,145,973,249,171,1825,611,265,1189,847,1427,2023,1269,
321,1475,1577,69,1233,755,1223,1685,1889,733,1865,2021,1807,1107,1447,1077,
1663,1917,1129,1147,1775,1613,1401,555,1953,2019,631,1243,1329,787,871,885,
449,1213,681,1733,687,115,71,1301,2017,675,969,411,369,467,295,693,
1535,509,233,517,401,1843,1543,939,2015,669,1527,421,591,147,281,501,
577,195,215,699,1489,525,1081,917,1951,2013,73,1253,1551,173,857,309,
1407,899,663,1915,1519,1203,391,1323,1887,739,1673,2011,1585,493,1433,117,
705,1603,1111,965,431,1165,1863,533,1823,605,823,1179,625,813,2009,75,
1279,1789,1559,251,657,563,761,1707,1759,1949,777,347,335,1133,1511,267,
833,1085,2007,1467,1745,1805,711,149,1695,803,1719,485,1295,1453,935,459,
1151,381,1641,1413,1263,77,1913,2005,1631,541,119,1317,1841,1773,359,651,
961,323,1193,197,175,1651,441,235,1567,1885,1481,1947,881,2003,217,843,
1023,1027,745,1019,913,717,1031,1621,1503,867,1015,1115,79,1683,793,1035,
1089,1731,297,1861,2001,1011,1593,619,1439,477,585,283,1039,1363,1369,1227,
895,1661,151,645,1007,1357,121,1237,1375,1821,1911,549,1999,1043,1945,1419,
1217,957,599,571,81,371,1351,1003,1311,931,311,1381,1137,723,1575,1611,
767,253,1047,1787,1169,1997,1273,853,1247,413,1289,1883,177,403,999,1803,
1345,451,1495,1093,1839,269,199,1387,1183,1757,1207,1051,783,83,423,1995,
639,1155,1943,123,751,1459,1671,469,1119,995,393,219,1743,237,153,1909,
1473,1859,1705,1339,337,909,953,1771,1055,349,1993,613,1393,557,729,1717,
511,1533,1257,1541,1425,819,519,85,991,1693,503,1445,433,877,1305,1525,
1601,829,809,325,1583,1549,1991,1941,927,1059,1097,1819,527,1197,1881,1333,
383,125,361,891,495,179,633,299,863,285,1399,987,1487,1517,1639,1141,
1729,579,87,1989,593,1907,839,1557,799,1629,201,155,1649,1837,1063,949,
255,1283,535,773,1681,461,1785,683,735,1123,1801,677,689,1939,487,757,
1857,1987,983,443,1327,1267,313,1173,671,221,695,1509,271,1619,89,565,
127,1405,1431,1659,239,1101,1159,1067,607,1565,905,1755,1231,1299,665,373,
1985,701,1879,1221,849,627,1465,789,543,1187,1591,923,1905,979,1241,181};

bool bad255[512] =
{0,0,1,1,0,1,1,1,1,0,1,1,1,1,1,0,0,1,1,0,1,0,1,1,1,0,1,1,1,1,0,1,
 1,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,1,0,1,1,1,1,0,1,1,1,
 0,1,0,1,1,0,0,1,1,1,1,1,0,1,1,1,1,0,1,1,0,0,1,1,1,1,1,1,1,1,0,1,
 1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1,1,1,0,1,1,1,1,0,0,1,1,1,1,1,1,
 1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,0,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,
 1,1,1,1,1,1,0,1,1,0,1,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,1,
 1,1,1,0,0,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,
 1,0,1,1,1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,
 0,0,1,1,0,1,1,1,1,0,1,1,1,1,1,0,0,1,1,0,1,0,1,1,1,0,1,1,1,1,0,1,
 1,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,1,0,1,1,1,1,0,1,1,1,
 0,1,0,1,1,0,0,1,1,1,1,1,0,1,1,1,1,0,1,1,0,0,1,1,1,1,1,1,1,1,0,1,
 1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,0,1,1,1,0,1,1,1,1,0,0,1,1,1,1,1,1,
 1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,0,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,
 1,1,1,1,1,1,0,1,1,0,1,0,1,1,0,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,1,
 1,1,1,0,0,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,
 1,0,1,1,1,0,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,
 0,0};

inline bool square( int64 x ) {
    // Quickfail
    if( x < 0 || (x&2) || ((x & 7) == 5) || ((x & 11) == 8) )
        return false;
    if( x == 0 )
        return true;

    // Check mod 255 = 3 * 5 * 17, for fun
    int64 y = x;
    y = (y & 4294967295LL) + (y >> 32);
    y = (y & 65535) + (y >> 16);
    y = (y & 255) + ((y >> 8) & 255) + (y >> 16);
    if( bad255[y] )
        return false;

    // Divide out powers of 4 using binary search
    if((x & 4294967295LL) == 0)
        x >>= 32;
    if((x & 65535) == 0)
        x >>= 16;
    if((x & 255) == 0)
        x >>= 8;
    if((x & 15) == 0)
        x >>= 4;
    if((x & 3) == 0)
        x >>= 2;

    if((x & 7) != 1)
        return false;

    // Compute sqrt using something like Hensel's lemma
    int64 r, t, z;
    r = start[(x >> 3) & 1023];
    do {
        z = x - r * r;
        if( z == 0 )
            return true;
        if( z < 0 )
            return false;
        t = z & (-z);
        r += (z & t) >> 1;
        if( r > (t  >> 1) )
            r = t - r;
    } while( t <= (1LL << 33) );

    return false;
}```

#### Answer 2 (score 343)
<img src="https://i.stack.imgur.com/UDUNr.png" alt="">  

I'm pretty late to the party, but I hope to provide a better answer; shorter and (assuming my <a href="https://www.dropbox.com/s/ad4r6oxfcilqkch/IsSquareBenchmark.java?dl=0" rel="noreferrer">benchmark</a> is correct) also much <a href="https://microbenchmarks.appspot.com/runs/185f228a-fd9b-44b4-8a7a-48d12101aece" rel="noreferrer">faster</a>.  

```java
long goodMask; // 0xC840C04048404040 computed below
{
    for (int i=0; i<64; ++i) goodMask |= Long.MIN_VALUE >>> (i*i);
}

public boolean isSquare(long x) {
    // This tests if the 6 least significant bits are right.
    // Moving the to be tested bit to the highest position saves us masking.
    if (goodMask << x >= 0) return false;
    final int numberOfTrailingZeros = Long.numberOfTrailingZeros(x);
    // Each square ends with an even number of zeros.
    if ((numberOfTrailingZeros & 1) != 0) return false;
    x >>= numberOfTrailingZeros;
    // Now x is either 0 or odd.
    // In binary each odd square ends with 001.
    // Postpone the sign test until now; handle zero in the branch.
    if ((x&7) != 1 | x <= 0) return x == 0;
    // Do it in the classical way.
    // The correctness is not trivial as the conversion from long to double is lossy!
    final long tst = (long) Math.sqrt(x);
    return tst * tst == x;
}
```

The first test catches most non-squares quickly. It uses a 64-item table packed in a long, so there's no array access cost (indirection and bounds checks). For a uniformly random `long`, there's a 81.25% probability of ending here.  

The second test catches all numbers having an odd number of twos in their factorization. The method `Long.numberOfTrailingZeros` is very fast as it gets JIT-ed into a single i86 instruction.  

After dropping the trailing zeros, the third test handles numbers ending with 011, 101, or 111 in binary, which are no perfect squares. It also cares about negative numbers and also handles 0.  

<p>The final test falls back to `double` arithmetic. As `double` has only 53 bits mantissa, 
the conversion from `long` to `double` includes rounding for big values. Nonetheless, the test is  correct (unless the <a href="https://math.stackexchange.com/questions/237865/show-that-floating-point-sqrtx-cdot-x-geq-x-for-all-long-x">proof</a> is wrong).</p>

Trying to incorporate the mod255 idea wasn't successful.  

#### Answer 3 (score 129)
You'll have to do some benchmarking.  The best algorithm will depend on the distribution of your inputs.  

Your algorithm may be nearly optimal, but you might want to do a quick check to rule out some possibilities before calling your square root routine.  For example, look at the last digit of your number in hex by doing a bit-wise "and."  Perfect squares can only end in 0, 1, 4, or 9 in base 16,  So for 75% of your inputs (assuming they are uniformly distributed) you can avoid a call to the square root in exchange for some very fast bit twiddling.  

Kip benchmarked the following code implementing the hex trick.  When testing numbers 1 through 100,000,000, this code ran twice as fast as the original.  

```java
public final static boolean isPerfectSquare(long n)
{
    if (n < 0)
        return false;

    switch((int)(n & 0xF))
    {
    case 0: case 1: case 4: case 9:
        long tst = (long)Math.sqrt(n);
        return tst*tst == n;

    default:
        return false;
    }
}
```

When I tested the analogous code in C++, it actually ran slower than the original. However, when I eliminated the switch statement, the hex trick once again make the code twice as fast.  

```java
int isPerfectSquare(int n)
{
    int h = n & 0xF;  // h is the last hex "digit"
    if (h > 9)
        return 0;
    // Use lazy evaluation to jump out of the if statement as soon as possible
    if (h != 2 && h != 3 && h != 5 && h != 6 && h != 7 && h != 8)
    {
        int t = (int) floor( sqrt((double) n) + 0.5 );
        return t*t == n;
    }
    return 0;
}
```

Eliminating the switch statement had little effect on the C# code.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: 'Must Override a Superclass Method' Errors after importing a project into Eclipse (score [250927](https://stackoverflow.com/q/1678122) in 2019)

#### Question
Anytime I have to re-import my projects into Eclipse (if I reinstalled Eclipse, or changed the location of the projects), <strong>almost all</strong> of my overridden methods are not formatted correctly, causing the error:  

<blockquote>
  The method must override a superclass method  
</blockquote>

It may be noteworthy to mention this is with Android projects - for whatever reason, the method argument values are not always populated, so I have to manually populate them myself. For instance:  

```java
list.setOnCreateContextMenuListener(new OnCreateContextMenuListener() {

    //These arguments have their correct names
    public void onCreateContextMenu(ContextMenu menu, View v, 
                                    ContextMenuInfo menuInfo) {                 
    }

});
```

will be initially populated like this:  

```java
list.setOnCreateContextMenuListener(new OnCreateContextMenuListener() {

    //This methods arguments were not automatically provided    
    public void onCreateContextMenu(ContextMenu arg1, View arg2,
                                    ContextMenuInfo arg3) {
    }

});
```

The odd thing is, if I remove my code, and have Eclipse automatically recreate the method, it uses the same argument names I already had, so I don't really know where the problem is, other then it auto-formatting the method for me.  

This becomes quite a pain having to manually recreate ALL my overridden methods by hand. If anyone can explain why this happens or how to fix it .. I would be very happy.  

Maybe it is due to the way I am formatting the methods, which are inside an argument of another method?  

#### Answer accepted (score 1416)
Eclipse is defaulting to Java 1.5 and you have classes implementing interface methods (which in Java 1.6 can be annotated with `@Override`, but in Java 1.5 can only be applied to methods overriding a superclass method).  

Go to your project/IDE preferences and set the Java compiler level to 1.6 and also make sure you select JRE 1.6 to execute your program from Eclipse.  

#### Answer 2 (score 306)
With <strong>Eclipse Galileo</strong> you go to Eclipse -> Preferences menu item, then select Java and Compiler in the dialog.  

Now it still may show compiler compliance level at 1.6, yet you still see this problem.  So now select the link "<em>Configure Project Specific Settings...</em>" and in there you'll see the project is set to 1.5, now change this to 1.6.  You'll need to do this for all affected projects.  

This byzantine menu / dialog interface is typical of Eclipse's poor UI design.    

#### Answer 3 (score 77)
In case this happens to anyone else who tried both alphazero and Paul's method and still didn't work.   

For me, eclipse somehow 'cached' the compile errors even after doing a Project > Clean...  

I had to uncheck Project > Build Automatically, then do a Project > Clean, and then build again.  

<strong>Also, when in doubt, try restarting Eclipse</strong>. This can fix a lot of awkward, unexplainable errors.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Why is printing "B" dramatically slower than printing "#"? (score [228782](https://stackoverflow.com/q/21947452) in 2018)

#### Question
I generated two matrices of `1000` x `1000`:  

<p>First Matrix: `O` and `#`.<br>
Second Matrix: `O` and `B`.</p>

Using the following code, the first matrix took 8.52 seconds to complete:  

```java
Random r = new Random();
for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < 1000; j++) {
        if(r.nextInt(4) == 0) {
            System.out.print("O");
        } else {
            System.out.print("#");
        }
    }

   System.out.println("");
 }
```

With this code, the second matrix took 259.152 seconds to complete:  

```java
Random r = new Random();
for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < 1000; j++) {
        if(r.nextInt(4) == 0) {
            System.out.print("O");
        } else {
            System.out.print("B"); //only line changed
        }
    }

    System.out.println("");
}
```

What is the reason behind the dramatically different run times?  

<hr>

As suggested in the comments, printing only `System.out.print("#");` takes `7.8871` seconds, whereas `System.out.print("B");` gives `still printing...`.  

As others who pointed out that it works for them normally, I tried <a href="http://ideone.com" rel="noreferrer">Ideone.com</a> for instance, and both pieces of code execute at the same speed.  

Test Conditions:  

<ul>
<li>I ran this test from <em>Netbeans 7.2</em>, with the output into its console</li>
<li>I used `System.nanoTime()` for measurements</li>
</ul>

#### Answer accepted (score 3978)
<em>Pure speculation</em> is that you're using a terminal that attempts to do <a href="http://en.wikipedia.org/wiki/Word_wrap" rel="noreferrer">word-wrapping</a> rather than character-wrapping, and treats `B` as a word character but `#` as a non-word character. So when it reaches the end of a line and searches for a place to break the line, it sees a `#` almost immediately and happily breaks there; whereas with the `B`, it has to keep searching for longer, and may have more text to wrap (which may be expensive on some terminals, e.g., outputting backspaces, then outputting spaces to overwrite the letters being wrapped).  

But that's pure speculation.  

#### Answer 2 (score 190)
<p>I performed tests on Eclipse vs Netbeans 8.0.2, both with Java version 1.8;
I used `System.nanoTime()` for measurements.</p>

<h5>Eclipse:</h2>

I got the <strong>same time on both cases</strong> - around <strong>1.564 seconds</strong>.  

<h5>Netbeans:</h2>

<ul>
<li>Using "#": <strong>1.536 seconds</strong></li>
<li>Using "B": <strong>44.164 seconds</strong></li>
</ul>

So, it looks like Netbeans has bad performance on print to console.  

After more research I realized that the problem is <a href="http://en.wikipedia.org/wiki/Line_wrap_and_word_wrap" rel="noreferrer">line-wrapping</a> of the max buffer of Netbeans (it's not restricted to `System.out.println` command), demonstrated by this code:  

```java
for (int i = 0; i < 1000; i++) {
    long t1 = System.nanoTime();
    System.out.print("BBB......BBB"); \\<-contain 1000 "B"
    long t2 = System.nanoTime();
    System.out.println(t2-t1);
    System.out.println("");
}
```

The time results are less then 1 millisecond every iteration except <strong>every fifth iteration</strong>, when the time result is around 225 millisecond. Something like (in nanoseconds):  

```java
BBB...31744
BBB...31744
BBB...31744
BBB...31744
BBB...226365807
BBB...31744
BBB...31744
BBB...31744
BBB...31744
BBB...226365807
.
.
.
```

And so on..  

<h5>Summary:</h2>

<ol>
<li>Eclipse works perfectly with "B"</li>
<li>Netbeans has a line-wrapping problem that can be solved (because the problem does not occur in eclipse)(without adding space after B ("B ")).</li>
</ol>

#### Answer 3 (score 2)
Yes the culprit is definitely word-wrapping. When I tested your two programs, NetBeans IDE 8.2 gave me the following result.  

<ol>
<li>First Matrix: O and # = <strong><em>6.03 seconds</em></strong></li>
<li>Second Matrix: O and B = <strong><em>50.97 seconds</em></strong></li>
</ol>

Looking at your code closely you have used a line break at the end of first loop. But you didn't use any line break in second loop. So you are going to print a word with 1000 characters in the second loop. That causes a word-wrapping problem. If we use a non-word character " " after B, it takes only <strong><em>5.35 seconds</em></strong> to compile the program. And If we use a line break in the second loop after passing 100 values or 50 values, it takes only <strong><em>8.56 seconds</em></strong> and <strong><em>7.05 seconds</em></strong> respectively.   

```java
Random r = new Random();
for (int i = 0; i < 1000; i++) {
        for (int j = 0; j < 1000; j++) {
            if(r.nextInt(4) == 0) {
                System.out.print("O");
            } else {
                System.out.print("B");
            }
            if(j%100==0){               //Adding a line break in second loop      
                System.out.println();
            }                    
        }
System.out.println("");                
}
```

Another advice is that to change settings of NetBeans IDE. First of all, go to NetBeans <strong>Tools</strong> and click <strong>Options</strong>. After that click <strong>Editor</strong> and go to <strong>Formatting</strong> tab. Then select <em>Anywhere</em> in <strong>Line Wrap</strong> Option. It will take almost 6.24% less time to compile the program.   

<a href="https://i.stack.imgur.com/yv2eL.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/yv2eL.jpg" alt="NetBeans Editor Settings"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: Is null check needed before calling instanceof? (score [219704](https://stackoverflow.com/q/2950319) in 2017)

#### Question
Will `null instanceof SomeClass` return `false` or throw a `NullPointerException`?  

#### Answer accepted (score 1727)
No, a null check is not needed before using instanceof.   

The expression `x instanceof SomeClass` is `false` if `x` is `null`.  

From the Java Language Specification, <a href="https://docs.oracle.com/javase/specs/jls/se11/html/jls-15.html#jls-15.20.2" rel="noreferrer">section 15.20.2, "Type comparison operator instanceof"</a>:   

<blockquote>
  <p>"At run time, the result of the
  `instanceof` operator is `true` if the
  value of the <em>RelationalExpression</em> <strong>is
  not `null`</strong> and the reference could be
  cast to the <em>ReferenceType</em>
  without raising a `ClassCastException`.
  Otherwise the result is `false`."</p>
</blockquote>

So if the operand is null, the result is false.  

#### Answer 2 (score 257)
Using a null reference as the first operand to `instanceof` returns `false`.  

#### Answer 3 (score 71)
Very good question indeed. I just tried for myself.  

```java
public class IsInstanceOfTest {

    public static void main(final String[] args) {

        String s;

        s = "";

        System.out.println((s instanceof String));
        System.out.println(String.class.isInstance(s));

        s = null;

        System.out.println((s instanceof String));
        System.out.println(String.class.isInstance(s));
    }
}
```

Prints  

```java
true
true
false
false
```

<strong><a href="http://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html#jls-15.20.2" rel="noreferrer">JLS / 15.20.2. Type Comparison Operator instanceof</a></strong>  

<blockquote>
  At run time, the result of the `instanceof` operator is `true` if the value of the <em>RelationalExpression</em> is not `null` and the reference could be cast to the <em>ReferenceType</em> without raising a `ClassCastException`. Otherwise the result is `false`.  
</blockquote>

<strong><a href="http://docs.oracle.com/javase/8/docs/api/java/lang/Class.html#isInstance-java.lang.Object-" rel="noreferrer">API / Class#isInstance(Object)</a></strong>  

<blockquote>
  If this `Class` object represents an interface, this method returns `true` if the class or any superclass of the specified `Object` argument implements this interface; it returns `false` otherwise. If this `Class` object represents a primitive type, this method returns `false`.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Why does this code using random strings print "hello world"? (score [193430](https://stackoverflow.com/q/15182496) in 2015)

#### Question
<p>The following print statement would print "hello world".
Could anyone explain this?</p>

```java
System.out.println(randomString(-229985452) + " " + randomString(-147909649));
```

And `randomString()` looks like this:  

```java
public static String randomString(int i)
{
    Random ran = new Random(i);
    StringBuilder sb = new StringBuilder();
    while (true)
    {
        int k = ran.nextInt(27);
        if (k == 0)
            break;

        sb.append((char)('`' + k));
    }

    return sb.toString();
}
```

#### Answer accepted (score 901)
When an instance of `java.util.Random` is constructed with a specific seed parameter (in this case `-229985452` or `-147909649`), it follows the random number generation algorithm <em>beginning</em> with that seed value.  

Every `Random` constructed with the same seed will generate the same pattern of numbers every time.  

#### Answer 2 (score 1127)
The other answers explain why, but here is how.  

Given an instance of `Random`:  

```java
Random r = new Random(-229985452)
```

The first 6 numbers that `r.nextInt(27)` generates are:  

```java
8
5
12
12
15
0
```

and the first 6 numbers that `r.nextInt(27)` generates given `Random r = new Random(-147909649)` are:  

```java
23
15
18
12
4
0
```

Then just add those numbers to the integer representation of the character ``` (which is 96):  

```java
8  + 96 = 104 --> h
5  + 96 = 101 --> e
12 + 96 = 108 --> l
12 + 96 = 108 --> l
15 + 96 = 111 --> o

23 + 96 = 119 --> w
15 + 96 = 111 --> o
18 + 96 = 114 --> r
12 + 96 = 108 --> l
4  + 96 = 100 --> d
```

#### Answer 3 (score 276)
I'll just leave it here. Whoever has a lot of (CPU) time to spare, feel free to experiment :) Also, if you have mastered some fork-join-fu to make this thing burn all CPU cores (just threads are boring, right?), please share your code. I would greatly appreciate it.  

```java
public static void main(String[] args) {
    long time = System.currentTimeMillis();
    generate("stack");
    generate("over");
    generate("flow");
    generate("rulez");

    System.out.println("Took " + (System.currentTimeMillis() - time) + " ms");
}

private static void generate(String goal) {
    long[] seed = generateSeed(goal, Long.MIN_VALUE, Long.MAX_VALUE);
    System.out.println(seed[0]);
    System.out.println(randomString(seed[0], (char) seed[1]));
}

public static long[] generateSeed(String goal, long start, long finish) {
    char[] input = goal.toCharArray();
    char[] pool = new char[input.length];
    label:
    for (long seed = start; seed < finish; seed++) {
        Random random = new Random(seed);

        for (int i = 0; i < input.length; i++)
            pool[i] = (char) random.nextInt(27);

        if (random.nextInt(27) == 0) {
            int base = input[0] - pool[0];
            for (int i = 1; i < input.length; i++) {
                if (input[i] - pool[i] != base)
                    continue label;
            }
            return new long[]{seed, base};
        }

    }

    throw new NoSuchElementException("Sorry :/");
}

public static String randomString(long i, char base) {
    System.out.println("Using base: '" + base + "'");
    Random ran = new Random(i);
    StringBuilder sb = new StringBuilder();
    for (int n = 0; ; n++) {
        int k = ran.nextInt(27);
        if (k == 0)
            break;

        sb.append((char) (base + k));
    }

    return sb.toString();
}
```

Output:  

```java
-9223372036808280701
Using base: 'Z'
stack
-9223372036853943469
Using base: 'b'
over
-9223372036852834412
Using base: 'e'
flow
-9223372036838149518
Using base: 'd'
rulez
Took 7087 ms
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Why is executing Java code in comments with certain Unicode characters allowed? (score [73395](https://stackoverflow.com/q/30727515) in 2015)

#### Question
The following code produces the output "Hello World!" (no really, try it).  

```java
public static void main(String... args) {

   // The comment below is not a typo.
   // \u000d System.out.println("Hello World!");
}
```

The reason for this is that the Java compiler parses the Unicode character `\u000d` as a new line and gets transformed into:  

```java
public static void main(String... args) {

   // The comment below is not a typo.
   //
   System.out.println("Hello World!");
}
```

Thus resulting into a comment being "executed".  

Since this can be used to "hide" malicious code or whatever an evil programmer can conceive, <strong>why is it allowed in comments</strong>?  

Why is this allowed by the Java specification?  

#### Answer accepted (score 727)
Unicode decoding takes place before any other lexical translation. The key benefit of this is that it makes it trivial to go back and forth between ASCII and any other encoding. You don't even need to figure out where comments begin and end!  

As stated in <a href="https://docs.oracle.com/javase/specs/jls/se8/html/jls-3.html#jls-3.3">JLS Section 3.3</a> this allows any ASCII based tool to process the source files:  

<blockquote>
  [...] The Java programming language specifies a standard way of transforming a program written in Unicode into ASCII that changes a program into a form that can be processed by ASCII-based tools. [...]  
</blockquote>

This gives a fundamental guarantee for platform independence (independence of supported character sets) which has always been a key goal for the Java platform.   

Being able to write any Unicode character anywhere in the file is a neat feature, and especially important in comments, when documenting code in non-latin languages. The fact that it can interfere with the semantics in such subtle ways is just an (unfortunate) side-effect.  

There are many gotchas on this theme and <a href="http://www.javapuzzlers.com/"><em>Java Puzzlers</em></a> by Joshua Bloch and Neal Gafter included the following variant:  

<blockquote>
  Is this a legal Java program? If so, what does it print?  

```java
\u0070\u0075\u0062\u006c\u0069\u0063\u0020\u0020\u0020\u0020
\u0063\u006c\u0061\u0073\u0073\u0020\u0055\u0067\u006c\u0079
\u007b\u0070\u0075\u0062\u006c\u0069\u0063\u0020\u0020\u0020
\u0020\u0020\u0020\u0020\u0073\u0074\u0061\u0074\u0069\u0063
\u0076\u006f\u0069\u0064\u0020\u006d\u0061\u0069\u006e\u0028
\u0053\u0074\u0072\u0069\u006e\u0067\u005b\u005d\u0020\u0020
\u0020\u0020\u0020\u0020\u0061\u0072\u0067\u0073\u0029\u007b
\u0053\u0079\u0073\u0074\u0065\u006d\u002e\u006f\u0075\u0074
\u002e\u0070\u0072\u0069\u006e\u0074\u006c\u006e\u0028\u0020
\u0022\u0048\u0065\u006c\u006c\u006f\u0020\u0077\u0022\u002b
\u0022\u006f\u0072\u006c\u0064\u0022\u0029\u003b\u007d\u007d
```
</blockquote>

(This program turns out to be a plain "Hello World" program.)  

In the solution to the puzzler, they point out the following:  

<blockquote>
  More seriously, this puzzle serves to reinforce the lessons of the previous three: <strong>Unicode escapes are essential when you need to insert characters that can’t be represented in any other way into your program. Avoid them in all other cases.</strong>  
</blockquote>

<hr>

Source: <a href="http://programming.guide/java/executing-code-in-comments.html">Java: Executing code in comments?!</a>  

#### Answer 2 (score 137)
Since this hasn’t addressed yet, here an explanation, why the translation of Unicode escapes happens before any other source code processing:  

The idea behind it was that it allows lossless translations of Java source code between different character encodings. Today, there is widespread Unicode support, and this doesn’t look like a problem, but back then it wasn’t easy for a developer from a western country to receive some source code from his Asian colleague containing Asian characters, make some changes (including compiling and testing it) and sending the result back, all without damaging something.  

So, Java source code can be written in any encoding and allows a wide range of characters within identifiers, character and `String` literals and comments. Then, in order to transfer it losslessly, all characters not supported by the target encoding are replaced by their Unicode escapes.  

This is a reversible process and the interesting point is that the translation can be done by a tool which doesn’t need to know anything about the Java source code syntax as the translation rule is not dependent on it. This works as the translation to their actual Unicode characters inside the compiler happens independently to the Java source code syntax as well. It implies that you can perform an arbitrary number of translation steps in both directions without ever changing the meaning of the source code.  

This is the reason for another weird feature which hasn’t even mentioned: the `\uuuuuuxxxx` syntax:  

When a translation tool is escaping characters and encounters a sequence that is already an escaped sequence, it should insert an additional `u` into the sequence, converting `\ucafe` to `\uucafe`. The meaning doesn’t change, but when converting into the other direction, the tool should just remove one `u` and replace only sequences containing a single `u` by their Unicode characters. That way, even Unicode escapes are retained in their original form when converting back and forth. I guess, no-one ever used that feature…  

#### Answer 3 (score 103)
I'm going to completely ineffectually add the point, just because I can't help myself and I haven't seen it made yet, that the question is invalid since it contains a hidden premise which is wrong, namely that the code is in a comment!  

In Java source code \u000d is equivalent in every way to an ASCII CR character. It is a line ending, plain and simple, wherever it occurs. The formatting in the question is misleading, what that sequence of characters actually syntactically corresponds to is:  

```java
public static void main(String... args) {
   // The comment below is no typo. 
   // 
 System.out.println("Hello World!");
}
```

IMHO the most correct answer is therefore: the code executes because it isn't in a comment; it's on the next line. "Executing code in comments" is not allowed in Java, just like you would expect.  

Much of the confusion stems from the fact that syntax highlighters and IDEs aren't sophisticated enough to take this situation into account. They either don't process the unicode escapes at all, or they do it after parsing the code instead of before, like `javac` does.  

</section>

