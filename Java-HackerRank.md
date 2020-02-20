---
title: Java-HackerRank
category: Java
wiki_css: Css/color_dark_solarized.css, Css/layout_toc.css
header-includes: <script type="text/javascript" src="Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---
<section class="level2">


# Java HackerRank

## Jdb
rlwrap -f . -f tags -e "" jdb 


## Doc I need
* regexp (`pydoc regex`, `perldoc perlreref`))
* printf format (`man 3 printf`)



## Tips

### Phone

```java
// Exit process
System.exit(0);

System.out.println((a & 1) == 0 ?  "EVEN" : "ODD" ); 
// Use StringBuffer for string manipulations, as String in java is immutable

// nb of digit
No. of digits in N = Math.floor(Math.log10(N)) + 1;
BigInteger.valueOf(1235).isProbablePrime

// Enum - String - Int
// // enum → int
yourEnum.ordinal()
// // int → enum
EnumType.values()[someInt]
// // String → enum
EnumType.valueOf(yourString)
// // enum → String
yourEnum.name()



```

### Laptop

```java
// Multiple print
System.out.printf("First Name: %s\nLast Name: %s",firstname, lastname);

// Multiple initialize
String one,two,three;
one = two = three = "";

// Foreach loop
String[] arr = {"Alpha", "Beta", "Gamma", "Delta", "Sigma"};
for (type i : arr) { 
  System.out.println(i);
}

// Repeat string
repeated = new String(new char[n]).replace("\0", s);
// Repeat string java 11
"a".repeat(3)
```


### First tuto

```java
// In/Out from: java.util.*;
Scanner scan = new Scanner(System.in);
int a = scan.nextInt();
String myString = scanner.next();
scanner.close();
System.out.println(a);

// Check int in range
if (0 < i && i < 100) 
if (Math.max(0, i) == Math.min(i, 100))

// Stringify lazy (unaltered)
String.format("%s", d);

// Scanner skip
scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

// Exponent **
Math.pow(2, 10); // 2**10

// Primitive
char, boolean, byte, short, int, long, float, and double
Byte.MIN_VALUE
Short.MIN_VALUE
Integer.MIN_VALUE
Long.MIN_VALUE

// Integer -> String
Integer.toString(42)
String.valueOf(42)

// Array -> String
String[] array = new String[] {"John", "Mary", "Bob"};
System.out.println(Arrays.toString(array));

// Calendar, date formatter (format and parse)
Calendar c = new GregorianCalendar(year, month-1, day);
SimpleDateFormat sdf = new SimpleDateFormat("EEEEEEE");
return sdf.format(c.getTime()).toUpperCase();

// Format currency
String india = NumberFormat.getCurrencyInstance(new Locale("en", "IN")).format(payment);
String france = NumberFormat.getCurrencyInstance(Locale.FRANCE).format(payment);
```

### String tuto

```java
// Ternary operator, multiple declaration
int exp1 = 0, exp2 = 0;
int result = 8 > 10 ? ++exp1 : ++exp2;

// Comparation
String A = "hello", B = "world";
String s_order = (A.compareTo(B) > 0) ? "Yes" : "No";
A.substring(0, 1).toUpperCase() + A.substring(1).toLowerCase()

// Foreach char in a string (loop)
for(char c : s.toCharArray()) {
    // process c
}

// Best anagram solution (sorted array)
char[] word1 = firstWord.toLowerCase().replaceAll("[\\s]", "").toCharArray();
char[] word2 = secondWord.toLowerCase().replaceAll("[\\s]", "").toCharArray();
Arrays.sort(word1);
Arrays.sort(word2);
return Arrays.equals(word1, word2);

// Get variable name
"toto".getClass().getName();

// Match IP (note I escape only the \)
String patten = "((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\\.|$)){4}"
String ip_no_eading_zero "^(?:(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(\\.(?!$)|$)){4}$"

// Delete second (juxtaposed) word
// I failed with String regex =  "(?=\\b(\\w+)\\b(.*)( \\1))";
String regex = "(\\b\\w+\\b)(\\s+\\1\\b)+";
String regex = "\\b(\\w+)(?:\\W+\\1\\b)+";
Pattern p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
input = input.replaceAll(m.group(), m.group(1));

// Full example
// Compile and match regex
String regex =  "\\b(\\w+)(?:\\W+\\1\\b)+"";
Pattern p = Pattern.compile(regex,  Pattern.CASE_INSENSITIVE);
Matcher m = p.matcher(input);
// Check for subsequences of input that match the compiled pattern
while (m.find()) {
    input = input.replaceAll( m.group(1) + m.group(2) + m.group(3), m.group(1) + m.group(2) );
}
// Prints the modified sentence.
return input;

// User name validation
String regularExpression = "^[a-zA-Z][a-zA-Z0-9_]{7,29}$"

// (?:(?!PAT).)* is to patterns as [^CHAR]* is to characters.

// Extracting innnermost tag ....
int count=0;
Pattern r = Pattern.compile("<(.+?)>([^<>]+)</\\1>");
Matcher m = r.matcher(line);
while(m.find()) {
    if (m.group(2).length() !=0) {
        System.out.println(m.group(2));
    count++;
    }
}
if (count == 0) System.out.println("None");

```

### Big Number tuto

```java
// Sort
String[] names = {"Dan", "Bob", "Kris"};
java.util.Collections.sort(java.util.Arrays.asList(names), new java.util.Comparator<String>() {
    @Override
    public int compare(String s1, String s2) {
        // TODO: Argument validation (nullity, length)
        return s1.charAt(1) - s2.charAt(1);//comparision
    }  
});

for (String name : names) System.out.println(name);

// Map
Integer[] boxed = Stream.of(myarray).map(Integer::valueOf).toArray(Integer[]::new);

// Subarray all combination
int allMasks = (1 << N);
for (int i = 1; i < allMasks; i++)
{
    for (int j = 0; j < N; j++)
        if ((i & (1 << j)) > 0) //The j-th element is used
           System.out.print((j + 1) + " ");

    System.out.println();
}

// Scan and add
Scanner in = new Scanner(System.in);
String s_a = in.nextLine(), s_b = in.nextLine();
in.close();

BigInteger a = new BigInteger(s_a), b = new BigInteger(s_b);
System.out.println(a.add(b));
System.out.println(a.multiply(b));
```


### ArrayList tuto

```java
//  Range loop
import java.util.stream.IntStream; 

IntStream.range(0, 3).forEachOrdered(n -> {
    System.out.println(n);
});

// In / Out : full example: 2D array/hourglass
public static void main(String[] args) {
    int[][] a = new int[6][6];
    private static final Scanner scanner = new Scanner(System.in);
    scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

    // In
    for (int i = 0; i < 6; i++) {
        String[] arrRowItems = scanner.nextLine().split(" ");

        for (int j = 0; j < 6; j++) {
            int arrItem = Integer.parseInt(arrRowItems[j]);
            a[i][j] = arrItem;
        }
    }

    scanner.close();

    // Out
    int res = Integer.MIN_VALUE;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            int sum = a[i][j] + a[i][j+1] +a[i][j+2]
                + a[i+1][j+1] + a[i+2][j] + a[i+2][j+1] + a[i+2][j+2];
            if (sum > res){res = sum;}
        }
    }
    System.out.println(res);

}

// In/out till EOF reduced (StdIn)
// Slurp in
Scanner in = new Scanner(System.in);
String s_in = "";
while (in.hasNextLine()) {
    s_in += in.nextLine() + "\n";
}
System.out.println("s_in is: " + s_in + " : over");


// IN/Out till EOF
Scanner in = new Scanner(System.in);
int n=in.nextInt();
in.nextLine();
for(int i=0;i<n;i++) {
  String name=in.nextLine();
  int phone=in.nextInt();
  in.nextLine();
}
while(in.hasNext()) {
  String s=in.nextLine();
}


// Generic methods solution 1
public static < E > void printArray( E[] inputArray ){    
     for ( E element : inputArray ){        
        System.out.println( element );
     }
} 
// Generic methods solution 2
public void printArray(Object[] a){
   for (int i = 0; i < a.length; i++){
       System.out.println(a[i]);
   }
}
// Generic methods solution 3: overloading of course (better)

// Comparator
class Checker implements Comparator<Player>{
    public int compare(Player p1, Player p2){
        if (p1.score != p2.score){
            return p2.score - p1.score; 
        }
        return p1.name.compareTo(p2.name);
    }
}
// The compare() method should return a negative integer in order to pick the first argument.
if(a.score > b.score){ // For decreasing order
    return -1;
}

// Custom sort
ArrayList<Student> studentList = studentList.stream().sorted((f1, f2) -> {
    double res = 0;
    res = f2.getCgpa() - f1.getCgpa();
    if (0 != res) { return (int) Math.signum(res); }

    res = f1.getFname().compareTo(f2.getFname());
    if (0 != res) { return (int) Math.signum(res); }

    return (int) Math.signum(f2.getId() - f1.getId());
}).collect(Collectors.toList());

// Custom sort from 7
class StudentComparator implements Comparator<Student>{
	@Override
	public int compare(Student s1, Student s2) {}
}  
Collections.sort(studentList, new StudentComparator());

// Stream
long i_new = deque.stream()
    .skip(j).limit(m)
    .distinct().count();

// Initilise List ArraList
List<String> list = List.of("A", "B", "C");
List<String> list = Arrays.asList("foo", "bar", "baz");
ArrayList<String> list = new ArrayList<>(List.of("foo", "bar"));
ArrayList<String> list = Stream.of("Buenos Aires", "Córdoba", "La Plata").collect(Collectors.toCollection(ArrayList::new));
List<String> list = new ArrayList<String>(); Collections.addAll(list,"A","B","C","D");

    
```


### Object orientation tuto

```java
// instanceof
if(element instanceof Student) { return; }

```



### Advanced tuto

```java
// MD5 cryptography hash
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5 {
    public static String getMD5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger number = new BigInteger(1, messageDigest);
            String hashtext = number.toString(16);
            // Now we need to zero pad it if you actually want the full 32 chars.
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        }
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) throws NoSuchAlgorithmException {
        System.out.println(getMD5("Javarmi.com"));
    }
}


// Embeded Inner class : Solution -> (static) Inner -> Private
Inner i = new Solution.Inner();
o = i.new Private();
String s_print = String.valueOf(num) + " is ";
s_print += ((Solution.Inner.Private) o).powerof2(num);
System.out.println(s_print);

```


### Exception handling tuto

```java

// Catch multiple exception (separed them with |)
try {
  //.....
} catch ( IllegalArgumentException | SecurityException |
         IllegalAccessException |NoSuchFieldException exc) {
  someCode();
}

// Or
try {
   // This Is The Protected code
} catch (ExceptionType1 e1) {
   // first Catch block
} catch (ExceptionType2 e2) {
   // second Catch block
} catch (ExceptionType3 e3) {
   // third Catch block
}

// Catch full solution
Scanner scan = new Scanner(System.in);

try {
    int x = scan.nextInt();
    int y = scan.nextInt();
    System.out.println(x / y);
} 
catch(InputMismatchException e) {
    // ensure that "java.util.InputMismatchException" is printed only.
    System.out.println(e.getClass().toString().replaceFirst("class ", ""));
}
catch(ArithmeticException e) {
    // Print exception
    System.out.println(e);
}
scan.close();

// Catch all
try {
    System.out.println(my_calculator.power(n, p));
} catch (Exception e) {
    System.out.println(e);
}

// Throws
long power(int n, int p) throws  Exception {
    if (n == 0 && p == 0){
        throw new Exception("n and p should not be zero.");
    }
    if (n < 0 || p < 0){
        throw new Exception("n or p should not be negative.");
    }

    return (long) Math.pow(n, p);
}


```

### Swap variables

```java
public class SwapUsingBitwise {
   public static void main(String[] args) {
      int a = 8 ; int b = 10;
      System.out.println("Before swaping : a = " + a + " b = "+b);
      a = a^b^(b = a);
      System.out.println("After swaping : a = "+ a + " b = "  + b);
   }
}
```

## HackerRank snippets

### LCS longest common subsequence

```java
private Set<Character> lcs(String x, String y) {

    // Create the arr of edition
    int[][] arr = new int[x.length() + 1][y.length() + 1];
    for(int i = 1; i <= x.length(); i++) {
        for (int j = 1; j <= y.length(); j++) {
            if (x.charAt(i - 1) == y.charAt(j - 1))
                arr[i][j] = arr[i - 1][j - 1] + 1;
            else
                arr[i][j] = Math.max(arr[i - 1][j], arr[i][j - 1]);
        }
    }

    // Craft response
    Set<Character> res = new HashSet<Character>();

    // Start the circle of life
    while (true){
        // Helpers
        int len1 = x.length();
        int len2 = y.length();

        // Early return
        if (len1 == 0 || len2 == 0) {
            return res;
        }

        // If same characters, append it
        if (x.charAt(len1 - 1) == y.charAt(len2 - 1)) {
            // Append character to res
            res.add(x.charAt(len1 - 1));

            // Remove it
            x = x.substring(0, len1 - 1);
            y = y.substring(0, len2 - 1);

        } else {
            // Remove char from x
            if (arr[len1 - 1][len2] >= arr[len1][len2 - 1]) {
                x = x.substring(0, len1 - 1);
            }
            // Remove char from y
            if (arr[len1][len2 - 1] >= arr[len1 - 1][len2]) {
                y = y.substring(0, len2 - 1);
            }
        }
    }
}
```


## LinkedList

### InsertNode

```java
static SinglyLinkedListNode insertNodeAtPosition(SinglyLinkedListNode head, int data, int position) {
    SinglyLinkedListNode list = head;
    SinglyLinkedListNode node = new SinglyLinkedListNode(data);
    // Scroll
    for (int i = 1; i<position; i++){
        list = list.next;
    }
    SinglyLinkedListNode next = list.next;
    list.next = node;
    node.next = next;
    return head;
}
```


## Regex

### Saying Hi

In perl:
```perl
/^hi [^d]/i&&print while<>
```

```java
import java.util.stream.IntStream; 
Scanner in = new Scanner(System.in);
int i_line = in.nextInt();

String regex = "(?i)hi [^dD].*";

// Read AND Write loop
IntStream.range(0, i_line+1).forEachOrdered(n -> {
    String s = in.nextLine();
    if(!s.matches(regex)){ return; }
    System.out.println(s);
});
```

### HackerRank Language

```java
import java.util.stream.IntStream; 
Scanner in = new Scanner(System.in);
int i_line = in.nextInt(); in.nextLine();

String regex = "\\d{5} (C|CPP|JAVA|PYTHON|PERL|PHP|RUBY|CSHARP|HASKELL|CLOJURE|BASH|SCALA|ERLANG|CLISP|LUA|BRAINFUCK|JAVASCRIPT|GO|D|OCAML|R|PASCAL|SBCL|DART|GROOVY|OBJECTIVEC)";

// Read AND Write loop
IntStream.range(0, i_line).forEachOrdered(n -> {
    String s = in.nextLine();
    if(s.matches(regex)){
        System.out.println("VALID");
    } else {
        System.out.println("INVALID");
    }
});
```

### Programming Language

```java
Scanner in = new Scanner(System.in);

String lang = "C";
String c_regex = "#include";
String java_regex = "\\s*import.*;";
String quote_regex = "\\s*[{}].*";

// Read AND Write loop
while (in.hasNext()){
  String s = in.nextLine();
  if(s.matches(c_regex)){
      lang = "C";
  } else if(s.matches(java_regex)) {
      lang = "Java";
  }
  if (s.matches(quote_regex)){
      System.out.println(lang);
      return;

  }
}
System.out.println("Python");
```

* Other in Python

```python
code = input()
while True:
    try: code += "\n" + input()
    except: break

if 'import java' in code: print("Java")
elif '#include' in code: print("C")
else: print("Python")
```

* Ugly Python (will almost never work)

```python
import re
import sys

src = ''.join(sys.stdin.readlines())

if 'java' in src:
    print("Java")
elif '#include' in src:
    print("C")
else:
    print("Python")
```

* Ugly regex

```text
C = "(?s).*(#\\s*include\\s*(<\\s*[\\w/]+(\\.\\w+)?\\s*>|\"[\\w/]+(\\.\\w+)?\"\\s*))(?s).*"

JAVA = "(?s).*(^(public\\s+|private\\s+|protected\\s+)*.*\\w+\\(.*?\\)\\s*\\{|import\\s+[\\w\\.\\*]+;)(?s).*"

PYTHON = "(?s).*(^print\\s\".*\"$|^#\\s.*$|def\\s.*$|^if\\s[^()]+:)(?s).*"
```

* Identifier proof solution in js

```javascript
function processData(input) {
    console.log(identifyLanguage(input));
} 

var langPatterns = {
    C: [
        /#(include.*?>|define.*)/g, //cPreprocessor
        /\b(typedef.*?;|struct.*?(?=\s*?\{))/g, //cStruct
        /\b\w+\s*->\s*\w+\b/g, //cPointers
        /[a-zA-Z]+\s+\*\s+([a-zA-Z_]\w*)\s*\([a-zA-Z]*\s*([a-zA-Z_]\w*)\)\s*\{/g, //cFunctionPointerReturn
        /[a-zA-Z]+\s*\*?\s*([a-zA-Z_]\w*)\(.*[a-zA-Z]+\s*\*\s*([a-zA-Z_]\w*).*\)\s*\{/g //cFunctionPointerArg
    ],
    Java: [
        /\bimport\s*.*?;/g, //javaImport
        /(public|private)?\s*class.*?\{/g //javaClass
    ],
    Python: [
        /(class|def|if|while|else|for).*:/g, //pythonKeywords
        /\[((\d+|("|').+\3),)*(\d+|("|').+\5)\]/g, //pythonLists
        /\bprint(\s*("|').+\2|\(.*\))/g, //pythonPrint
        ///True|False/g //pythonBoolean
    ],
}

var identifyLanguage = function (code) {
    return Object.keys(langPatterns).find(lang => 
        langPatterns[lang].some(pattern => 
            pattern.test(code)));
}
```


### Regex Test 

```java
import java.util.regex.*;
public class Solution {    

    public static void main(String[] args) {
        
        Regex_Test tester = new Regex_Test();
        tester.checker("(\\d\\d\\D){2}\\d{4}"); // Use \\ instead of using \ 
    
    }
}

class Regex_Test {

    public void checker(String Regex_Pattern){
    
        Scanner Input = new Scanner(System.in);
        String Test_String = Input.nextLine();
        Pattern p = Pattern.compile(Regex_Pattern);
        Matcher m = p.matcher(Test_String);
        System.out.println(m.find());
    }   
    
}
```


### Detect the domain name

```java
Scanner in = new Scanner(System.in);
int n = in.nextInt(); in.nextLine();

SortedSet<String> matches = new TreeSet<>();
String regex = "https?://(?:ww[w2]\\.)?([a-zA-Z0-9\\.\\-]+)";
Pattern p = Pattern.compile(regex);

for (int i = 0; i < n; i++){
    String s = in.nextLine();
    Matcher m = p.matcher(s);
    while (m.find()) {
        String s_new = m.group(1);
        if (s_new.indexOf('.') < 0){ continue; }
        matches.add(s_new);
    }
}
System.out.println(String.join(";", matches));
```


### Building a Smart IDE: Identifying comments

```java
// Slurp in
Scanner in = new Scanner(System.in);
String s_in = "";
while (in.hasNextLine()) {
    s_in += in.nextLine() + "\n";
}

// Declare regex
String r_single = "//.*";
String r_mult = "/\\*((?!\\*/)[\\s\\S])*\\*/";
String r_comment = r_single + "|" + r_mult;
Pattern p = Pattern.compile(r_comment);
Matcher m = p.matcher(s_in);

// Parse
ArrayList<String> matches = new ArrayList<>();
while (m.find()) {
    String s_new = m.group(0);

    // Trim each line
    Arrays.stream(s_new.split("\n")).forEachOrdered(x -> {
        matches.add(x.trim());
    });
}

// Print
System.out.println(String.join("\n", matches));
```

* Fast java answer (pre trim because you don't care the stdin)

```java
public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    String s;
    for(s="";sc.hasNextLine();s+=sc.nextLine().trim()+'\n');
    Matcher m=Pattern.compile("//.*|/\\*(?s).*?\\*/").matcher(s);
    while(m.find())System.out.println(m.group());
}
```

* Fast python answer

```python
import re
import sys

pat = r'(/\*.*?\*/|//.*?$)'
txt = sys.stdin.read()
# re.sub() for Testcase #4: others will just work with comment
print "\n".join(re.sub('\n\s+', '\n', comment) for comment in re.findall(pat, txt, re.DOTALL|re.MULTILINE))

```

### Detecting Valid Latitude and Longitude Pairs

* My solution, extract they give to code

```java
Scanner in = new Scanner(System.in);
int n = in.nextInt(); in.nextLine();

// Declare regex
// // (X.xxxxx, Y.yyyyyy)
// // (77.11112223331, 149.99999999)
String regex_x = "([+\\-]?(?:0|[1-9]\\d*)(?:\\.\\d+)?)";
String regex_y = regex_x;
String regex = "\\(" + regex_x + ", " + regex_y + "\\)";
Pattern p = Pattern.compile(regex);

// Read & Match & Write
for (int i = 0; i < n; i++){
    String s = in.nextLine();
    Matcher m = p.matcher(s);
    // Search & Check
    if (!m.find()){
        System.out.println("Invalid");
        continue;
    }
    //try {
        String s_x = m.group(1);
        String s_y = m.group(2);
        
        float i_x = Float.valueOf(s_x);
        float i_y = Float.valueOf(s_y);
        // System.out.println("  Retrieved " + s_x + " : " + s_y);

        // Where -90<=X<=+90 and -180<=Y<=180.
        if (-90 <= i_x && i_x <= 90 
            && -180 <= i_y && i_y <= 180){
            System.out.println("Valid");
            continue;
        }
    // } catch (Exception e) { }
    System.out.println("Invalid");
```

* Idea for java regex not so ugly:

```java
"^\\(" + 
"[-+]?(([1-8]?[0-9]|0)(\\.\\d+)?|90(\\.0+)?), " +
"[-+]?((1?[1-7]?[0-9]|10[0-9]|[1-9][0-9]|0)(\\.\\d+)?|180(\\.0+)?)"   +"\\)$"
```

* Python with sub regex

```python
import re

SIGN = '[\+-]?'
DECIMALS = '(\.[0-9]+)?'
ZEROS = '(\.0+)?'

LATITUDE =  f'{SIGN}(90{ZEROS}|[1-8]\d{DECIMALS}|\d{DECIMALS})'
LONGITUDE = f'{SIGN}(180{ZEROS}|1[0-7]\d{DECIMALS}|[1-9]\d{DECIMALS}|\d{DECIMALS})'

REGEX = f'\({LATITUDE}, {LONGITUDE}\)'
pattern = re.compile(REGEX)

def validate(value):
    return pattern.search(value)

for _ in range(int(input())):
    if validate(input()):
        print('Valid')
    else:
        print('Invalid')
```

* python monster

```python
import re

t = re.compile(r"""
    ^\(
    [+-]?((90(\.0+)?)|([1-8][0-9](\.[0-9]+)?)|([0-9](\.[0-9]+)?)),
    \ 
    [+-]?((180(\.0+)?)|((1[0-7][0-9]|[1-9][0-9]|[0-9])(\.[0-9]+)?))
    \)$""", re.X)

for x in range(int(input())):
    if t.match(input()):
        print("Valid")
    else:
        print("Invalid")
```

* Java monster

```java
Scanner scanner = new Scanner(System.in); 
int numberOfInput = Integer.parseInt(scanner.nextLine()); 
String inputSentence = ""; 
String validLatAndLong = "\\([+-]?((90(\\.0+)?)|((([1-8][0-9])|([0-9]))(\\.[0-9]+)?)), [+-]?((180(\\.0+)?)|(((1[0-7][0-9])|([1-9][0-9])|[0-9])(\\.\\d+)?))\\)"; 
for (int i =0; i<numberOfInput; i++) {
    inputSentence = scanner.nextLine(); 
    if (inputSentence.matches(validLatAndLong)) {
        System.out.println("Valid"); 
    } else {
        System.out.println("Invalid"); 
    }
}
```

### HackerRank Tweets

* Case insisitive number of match

```java
int res = 0;

Scanner in = new Scanner(System.in);
int n = in.nextInt(); in.nextLine();

for (int i = 0; i < n; i++){
    String s_line = in.nextLine();
    Matcher m = Pattern.compile("(?i)hackerrank").matcher(s_line);
    while (m.find()){
        res++;
    }
}

System.out.println(String.valueOf(res));
```

### Detect HTML links

* Print href and content

```java
String res = "";
Scanner in = new Scanner(System.in);
int n = in.nextInt(); in.nextLine();

// <a href="http://www.hackerrank.com"><h1><b>HackerRank</b></h1></a>
// Href
String regex = "<a [^>]*href=" + "\"([^\"]*)\""
    // Push to last   + Content  + end
    + "(?:(?!</).)*>" + "([^<>]*)" + "</";
Pattern p = Pattern.compile(regex);

for (int i = 0; i < n; i++){
    String s_line = in.nextLine();

    Matcher m = p.matcher(s_line);
    while (m.find()){
        res += m.group(1) + "," + m.group(2).trim() + "\n"; 
    }
}

System.out.println(res);
```

* JS elegant

```javascript
var regex=/<a.*?href="(.*?)".*?>(.*?)<\/a>/ig;
var output=[];
input.replace(regex,function(_,href,text){ 
    output.push(href.trim()+','+text.replace(/<.*?>/g,'').trim())
});
console.log(output.join('\n'));
```

* Java short

```java
String str = sc.nextLine();           
Pattern p = Pattern.compile("<a\\shref=\"([^\"]++)\"([^<>]*)>(<\\w>)*([^<>]*)<");
Matcher m = p.matcher(str);
while(m.find()) System.out.println(m.group(1).trim()+","+m.group(4).trim());
```


1. `([^\"]++)` is the link you can see that it sits between "" as expected.
2. `([^<>]*)` is anything that comes after the link but still in the 'a' tag. It is immediately followed by a '>' which is closing the 'a' tag.
3. `(<\w>)*` is any additional tags preceding the text. You can see that each such tag is enclose in '< >' e.g
4. `([^<>]*)<")` is the text.as you can see it is anything other than '<>' before the first occurance of '<'.



</section>
