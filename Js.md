* [Js Fuck](Js-Fuck)
* [Js Security](Js-Security)


# Cheat

* XmlHttpRequest
    ```js
    const req = new XMLHttpRequest();
    req.open("GET", "url", true);
    req.send(null);
    console.log(req.responseText);
    ```
    * req.onreadystatechange = function(){console.log("ready")}
    * req.readyState  // === 4 (request finished)
    * req.status  // === 200 (response received)
    * req.(setRequest|getResponse)Header()

* history (window.history)
    * pushState(history.state, "title", "http://url")
    * back()
    * foward()
    * go(1) && go(-1)
    * length

* Save
    ```js
    window.document.execCommand("saveAs", true, "test.txt")
    ```

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

* Change url :
    * Load page on click
        ```html
        <input id="btntest" type="button" value="Check"
        onclick="window.location.href = 'http://www.google.com'" />
        ```
    * `window.open(url)` # open url in new tab
    * `window.navigate("index.html")`  # open url __same__ tab (navigate)
    * `document.location.replace("index.html")`  # open url __same__ tab (replace)
    * `window.location.href` # url
    * `window.location.hostname` # domain name
    * `window.location.pathname` # path and filename of current page
    * `window.location.protocol` # protocl (http:)
    * `window.location.assign` # load document
    
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
* [RegExp](Js-RegExp)

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
