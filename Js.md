* [Js Fuck](Js-Fuck)


# Cheat

* Scroll to bottom of page (dynamically appending content)
    ```html
    <body id='body' onLoad='main()'>
        <div id="top"></div>
        <div id="bottom"></div>
    </body>
    <script>
        document.getElementById('bottom').scrollIntoView();
    </script>
    ```
* Load page on click
    ```html
    <input id="btntest" type="button" value="Check"
    onclick="window.location.href = 'http://www.google.com'" />
    ```
    
* Passing additional parameters to a Promise .then
    P.then( doWork.bind('text', null) );
    P.then( function(data) {return doWork('text', data);} );
    P.then( data => doWork('text', data) );
    
    
# Vars

| keyword | meaning  |
| ---     | ---      |
| var     | function |
| let     | block    |
| []      | global   |
    
# Loop

* Loop 100 times
    for (let i of Array(100).keys()) {
        console.log(i);
    }
    
    
    
# String

* Substring
var str = "Hi";  
var res = str.substring(1,4)  
var res = str.substring(-3)  


# Number

* To Hex
var d = 16;
var s = d.toString(16);
var d = parseInt(s, 16);


# Regex

var str = "Visit W3Schools!";
var n1 = str.search("W3Schools");
var n2 = str.search(/w3schools/i);
var res = str.replace(/w3schools/i, "Microsoft");


# Nodejs
> process.version
> process.versions


# Object
