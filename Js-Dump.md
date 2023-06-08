```javascript
getHttp(inputUrl).then(
  (onResolved) => {
    const html = convertShowdown(onResolved)
  },
  (onRejected) => {
    var message = (
      "Error: Cannot open file!\n"
      + "Tip: Verify the input URL below, set from the window location parameter\n"
      + "url: " + inputUrl + "\n"
      + "error: " + onRejected
    )
    alert(message)
  }
)

function httpGet(theUrl) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", theUrl, false ); // false for synchronous request
    xmlHttp.send( null );
    return xmlHttp.responseText;
}

function addCss(css){
  const style = document.createElement('style');
  style.textContent = css;
  document.head.append(style);
}


function loadCssFile(filename){
  var fileref=document.createElement("link")
  fileref.setAttribute("rel", "stylesheet")
  fileref.setAttribute("type", "text/css")
  fileref.setAttribute("href", filename)
  document.getElementsByTagName("head")[0].appendChild(fileref)
}

function loadJsFile(filename){
  var fileref=document.createElement('script')
  fileref.setAttribute("type","text/javascript")
  fileref.setAttribute("src", filename)
  document.getElementsByTagName("head")[0].appendChild(fileref)
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function setHead(){
  // Fill the head with all the include
  loadCssFile("/css/color_gruvbox_tin_alma.css")
  loadCssFile("/css/prism_dark_twilight.css")
  loadJsFile("/js/tin-showdown.js")
  loadJsFile("/js/tin-prism-dark.js")
  loadJsFile("https://cdn.jsdelivr.net/npm/marked/marked.min.js")
  console.log("sleep 1")
  await sleep(1000)
  console.log("sleep 2")
}
```
