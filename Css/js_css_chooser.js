
// Define gGlobal array definitions

a_color_light = [
    '../Css/color_light_material_1',
    '../Css/color_light_solarized',
];

a_color_dark = [
    '../Css/color_dark_material_1',
    '../Css/color_dark_solarized',
    '../Css/color_dark_blue_striking_and_simple',
    '../Css/color_dark_jason23',
];

a_layout = [
    '../Css/js_masonry_desandro.js',
    '../Css/layout_3_column_flex',
    '../Css/layout_grid',
    '../Css/layout_solarized',
];

a_font_safe = [
    'Ubuntu', 
    'IBM Plex Serif',
    'Arial',
    'Source Sans Pro',
    'EB Garamond',
  
];

a_font_test = [
    'Monoton',
    'Alegreya',
    'Yatra One',
];

a_font_cursive_hard = [
    'Great Vibes',
    'Indie Flower',
    'Liu Jian Mao Cao',
    'Tangerine',
];

// Cursive script
a_font_cursive_soft = [
    'Croissant One',
    'Courgette',
    'Redressed',
    'Merienda One',
    'Cookie',
];

a_font_solarized = [
    'Inconsolata',
    'PT Sans',
    'PT Sans Narrow:400,700',
];

// Disable all radio button vith a certain class name
function disableAll (parent) {
    Array.from(document.getElementsByClassName('class_' + parent.id.slice(0, 8)))
        .forEach(function (node) {
            console.log('Disabling ' + node.value + ' from class_' + parent.id.slice(0, 8));
            node.disabled = true;}
        );
}

function onRadioJs(parent, id) {
    console.log('Js ', id, '<- ', parent.id);
    
    // Disable others 
    disableAll(parent);

    // Create link
    if (!document.getElementById(id)){
        console.log('Creating link');
        var script = document.createElement('script');
        script.className = 'class_' + parent.id.slice(0, 8);
        script.type = "text/javascript";
        script.src = id;
        script.onreadystatechange = function () {console.log("JS ready");};
        document.head.appendChild(script);
    }
}

// If press css: color | layout button
function onRadioCss(parent, id) {
    // Catch
    if (id.endsWith('.js')) {
      return onRadioJs(parent, id);
    }

    // Hi
    console.log('Css ', id, '<- ', parent.id);
    
    // Create link
    if (!document.getElementById(id)){
        console.log('Creating link');
        var link = document.createElement('link');
        link.rel  = 'stylesheet';
        link.type = 'text/css';
        link.disabled = true;
        link.media = 'all';
        link.id = id;
        link.className = 'class_' + parent.id.slice(0, 8);
        link.href = id + '.css';
        document.head.appendChild(link);
    }
  
    // Disable others 
    disableAll(parent);
    
    // Enable me
    var css = document.getElementById(id);
    css.disabled = false;
}

// If press font button
function onRadioFont(parent, id){
    console.log('Font ', id, '<- ', parent.id);

    // Create link
    // TODO suffix by cursive
    var link = document.createElement('link');
    link.rel  = 'stylesheet';
    var font_url = "https://fonts.googleapis.com/css?family=";
    font_url += id.replace(/ /g, "+") + "&display=swap";
    link.href = font_url;
    document.head.appendChild(link);
  
    // Body choose font
    document.body.style.fontFamily = id;
}



function addStylesheet(parent, id, onRadioCallback) {
    // Create clickable link
    // 1/ Label
    var label = document.createElement('label');
    label.textContent = id;
    label.className = "container";
    // 2/ Input
    var input = document.createElement('input');
    input.type = 'radio' ;
    input.name = 'radio_' + parent.id.slice(0, 8);
    input.value = id
    input.onchange = function () { onRadioCallback(parent, id); };
    // 3 Span
    var span = document.createElement('span');
    span.className = 'checkmark';
    
    // Append
    label.appendChild(input);
    label.appendChild(span);
    parent.appendChild(document.createElement("br"));
    parent.appendChild(label)
  
}

function prependDiv(name) {
    var name_capital = name.charAt(0).toUpperCase() + name.slice(1);

    // Create div
    var div = document.createElement('div');
    div.id = 'div_' + name;
    var base_style = 'width:400px; float:left;';
    div.style = base_style;
    if (name != 'color_dark' && name != 'font_safe') {
        div.style = base_style + 'overflow:hidden;';
    }
    
    // Create h2
    var h2 = document.createElement('h2');
    h2.innerText = name_capital;
    div.appendChild(h2);

    // Fill radio buttons
    var array = window['a_' + name];
    array.forEach(function (item, index) {
        console.log(name_capital, ':', item, index);
        if (name.startsWith('font')) {
            addStylesheet(div, item, onRadioFont);
        }
        else { 
            addStylesheet(div, item, onRadioCss);
        }
    });

    // Append
    document.body.prepend(div);
}


// Fill radio button (prepending)
function main() {
    // Break
    var h1 = document.createElement('h1');
    h1.innerText = 'End of js_css_chooser.js';
    h1.style = 'clear: both;';
    document.body.prepend(h1);

    // Font
    prependDiv('font_test');
    prependDiv('font_solarized');
    prependDiv('font_cursive_hard');
    prependDiv('font_cursive_soft');
    prependDiv('font_safe');

    // Break
    var h1 = document.createElement('h1');
    h1.innerText = 'Font';
    h1.style = 'clear: both;';
    document.body.prepend(h1);

    // Css
    prependDiv('layout');
    prependDiv('color_light');
    prependDiv('color_dark');

    // Break
    var h1 = document.createElement('h1');
    h1.innerText = 'Color';
    h1.style = 'clear: both;';
    document.body.prepend(h1);
}

window.onload = main;
