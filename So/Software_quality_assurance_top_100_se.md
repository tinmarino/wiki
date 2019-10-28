---
title: Software_quality_assurance <- StackExchange top 100
category: software_quality_assurance
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How to find element using contains in xpath (score [382857](https://stackoverflow.com/q/10342) in 2014)

#### Question
can anyone please help me how to use contains in my xpath? My xpath changes all the time when users are added, so I can't find element using xpath.  

This is my xpath:   

```
.//*[@id='contentText']/table/tbody/tr[2]/td/table/tbody/tr/td[1]/table/tbody/tr[9]/td/table/tbody/tr/td[1]/strong[2]
```

Changes when new user added:   

```
.//*[@id='contentText']/table/tbody/tr[2]/td/table/tbody/tr/td[1]/table/tbody/tr[10]/td/table/tbody/tr/td[1]/strong[2]
```

Please help me how to get it done.  

#### Answer 2 (score 27)
I have tested an ExtJS application. Most of the page element attributes are dynamic. They change not only when you add a new user or something, they change every time when you open the application.   

I have found the xpath expressions I get from the tools (Firebug etc.) is not very useful. Here is why:  

<ol>
<li>hard to read</li>
<li>break easily</li>
<li>hard to debug</li>
</ol>

What I do instead, is rather to spend time looking at the HTML and identify possible unique attributes that are not dynamic and come up with my own expressions. If none of the attributes are static for a certain element, use any other element on the page that does have static attributes with the parent/child/sibling relations to locate.  

I often use "contains", but there are more. Here are some examples:  

<ul>
<li>multiple condition: `//div[@class='bubble-title' and contains(text(), 'Cover')]`</li>
<li>partial match: `//span[contains(text(), 'Assign Rate')]`</li>
<li>starts-with: `//input[starts-with(@id,'reportcombo')`</li>
<li>value has spaces: `//div[./div/div[normalize-space(.)='More Actions...']]`</li>
<li>sibling: `//td[.='LoadType']/following-sibling::td[1]/select"`</li>
<li>more complex: `//td[contains(normalize-space(@class), 'actualcell sajcell-row-lines saj-special x-grid-row-collapsed')]`</li>
</ul>

<a href="http://www.w3schools.com/xml/xsl_functions.asp" rel="noreferrer">Take a look at the W3C XSL Functions page for some more ideas.</a>  

<p>Edit:
Link updated.</p>

#### Answer 3 (score 3)
You should be splitting the xpath to fetch individual tables for clarity sake.  

I suggest the following:  

```
// Get the content or container    
WebElement content = driver.findElement(By.id("contentText"));

//Get the table of users
WebElement tblUsers = content.findElement(By.xpath(".//table/tbody/tr[2]/td/table/tbody/tr/td[1]/table"));

// Get the rows which change always as and when users are added
WebElement allUsers = tblUsers.findElements(By.xpath(".//tbody/tr"));

// Loop through each row of users table
for(WebElement user : allUsers) {

   // Get the username
   WebElement username = user.findElement(By.xpath(".//td/table/tbody/tr/td[1]/strong[2]"));
   System.out.println("Username: " + username.getText());
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How to download a file using Selenium's WebDriver? (score [279090](https://stackoverflow.com/q/2197) in 2017)

#### Question
Basically I want to at least check that a download-able file exists / download link works and preferably get stuff like the file size too.  

Here's an example:  

```
link = self.browser.find_element_by_link_text('link text')
href = link.get_attribute('href')
download = self.browser.get(href)
print download
```

That fourth line prints "None", presumably because I haven't manually clicked the Save button, and even if I had, I doubt WebDriver would be able to "see" the file.  

Any ideas? I'm using Firefox as my browser-under-test, and I understand that the file handling for downloads is somewhat browser and/or OS specific.  

#### Answer accepted (score 19)
As far as I know there is no easy way to make Selenium download files because browsers use native dialogs for it which cannot be controlled by JavaScript, so you need some "hack". Check <a href="http://blog.codecentric.de/en/2010/07/file-downloads-with-selenium-mission-impossible/" rel="noreferrer">this</a>, hope it helps.  

#### Answer 2 (score 29)
Here's a solution. Set Firefox's preferences to save automatically, and not have the downloads window popup.  Then you just grab the file, and it'll download.  

So, something like this:  

```
FirefoxProfile fxProfile = new FirefoxProfile();

fxProfile.setPreference("browser.download.folderList",2);
fxProfile.setPreference("browser.download.manager.showWhenStarting",false);
fxProfile.setPreference("browser.download.dir","c:\\mydownloads");
fxProfile.setPreference("browser.helperApps.neverAsk.saveToDisk","text/csv");

WebDriver driver = new FirefoxDriver(fxProfile);
driver.navigate().to("http://www.foo.com/bah.csv");
```

and given you now have the download directory, never ask to save, and no download manager appearing, automation from this point should be straightforward.  

#### Answer 3 (score 26)
First of all why do you want to download the file?  Are you going to do anything with it?  

The majority of people who want to download files just do it so that they can show an automation framework downloading files because it makes somebody non-technical ooo and ahh.    

You can check the header response to check that you get a 200 OK (or maybe a redirect, depends on your expected outcome) and it will tell you that a file exists.  

Only download files if you are actually going to do something with them, if you are downloading them for the sake of doing it you are wasting test time, network bandwidth and disk space.  

<a href="https://github.com/Ardesco/Ebselen/blob/master/ebselen-core/src/main/java/com/lazerycode/ebselen/customhandlers/FileDownloader.java" rel="nofollow noreferrer">Here is my implementation</a>.  

This finds the link on the page and extracts the url being linked to.  It then uses apache commons to replicate the browser session used by selenium and then download the file.  There are some instances where it won't work (where the link found on the page does not actually link to the download file but a layer to prevent automated file download).  

Generally it works well and is cross platform/cross browser complient.  

The code is:  

```
 /*
  * Copyright (c) 2010-2011 Ardesco Solutions - http://www.ardescosolutions.com
  *
  * Licensed under the Apache License, Version 2.0 (the "License");
  * you may not use this file except in compliance with the License.
  * You may obtain a copy of the License at
  *
  * http://www.apache.org/licenses/LICENSE-2.0
  *
  * Unless required by applicable law or agreed to in writing, software
  * distributed under the License is distributed on an "AS IS" BASIS,
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  */

package com.lazerycode.ebselen.customhandlers;

import com.google.common.annotations.Beta;
import com.lazerycode.ebselen.EbselenCore;
import com.lazerycode.ebselen.handlers.FileHandler;
import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;

import java.io.*;
import java.net.URL;
import java.util.Set;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Beta
public class FileDownloader {

    private static final Logger LOGGER = LoggerFactory.getLogger(EbselenCore.class);
    private WebDriver driver;
    private String downloadPath = System.getProperty("java.io.tmpdir");

    public FileDownloader(WebDriver driverObject) {
        this.driver = driverObject;
    }

    /**
     * Get the current location that files will be downloaded to.
     *
     * @return The filepath that the file will be downloaded to.
     */
    public String getDownloadPath() {
        return this.downloadPath;
    }

    /**
     * Set the path that files will be downloaded to.
     *
     * @param filePath The filepath that the file will be downloaded to.
     */
    public void setDownloadPath(String filePath) {
        this.downloadPath = filePath;
    }


    /**
     * Load in all the cookies WebDriver currently knows about so that we can mimic the browser cookie state
     *
     * @param seleniumCookieSet
     * @return
     */
    private HttpState mimicCookieState(Set<org.openqa.selenium.Cookie> seleniumCookieSet) {
        HttpState mimicWebDriverCookieState = new HttpState();
        for (org.openqa.selenium.Cookie seleniumCookie : seleniumCookieSet) {
            Cookie httpClientCookie = new Cookie(seleniumCookie.getDomain(), seleniumCookie.getName(), seleniumCookie.getValue(), seleniumCookie.getPath(), seleniumCookie.getExpiry(), seleniumCookie.isSecure());
            mimicWebDriverCookieState.addCookie(httpClientCookie);
        }
        return mimicWebDriverCookieState;
    }

    /**
     * Mimic the WebDriver host configuration
     *
     * @param hostURL
     * @return
     */
    private HostConfiguration mimicHostConfiguration(String hostURL, int hostPort) {
        HostConfiguration hostConfig = new HostConfiguration();
        hostConfig.setHost(hostURL, hostPort);
        return hostConfig;
    }

    public String fileDownloader(WebElement element) throws Exception {
        return downloader(element, "href");
    }

    public String imageDownloader(WebElement element) throws Exception {
        return downloader(element, "src");
    }

    public String downloader(WebElement element, String attribute) throws Exception {
        //Assuming that getAttribute does some magic to return a fully qualified URL
        String downloadLocation = element.getAttribute(attribute);
        if (downloadLocation.trim().equals("")) {
            throw new Exception("The element you have specified does not link to anything!");
        }
        URL downloadURL = new URL(downloadLocation);
        HttpClient client = new HttpClient();
        client.getParams().setCookiePolicy(CookiePolicy.RFC_2965);
        client.setHostConfiguration(mimicHostConfiguration(downloadURL.getHost(), downloadURL.getPort()));
        client.setState(mimicCookieState(driver.manage().getCookies()));
        HttpMethod getRequest = new GetMethod(downloadURL.getPath());
        FileHandler downloadedFile = new FileHandler(downloadPath + downloadURL.getFile().replaceFirst("/|\\\\", ""), true);
        try {
            int status = client.executeMethod(getRequest);
            LOGGER.info("HTTP Status {} when getting '{}'", status, downloadURL.toExternalForm());
            BufferedInputStream in = new BufferedInputStream(getRequest.getResponseBodyAsStream());
            int offset = 0;
            int len = 4096;
            int bytes = 0;
            byte[] block = new byte[len];
            while ((bytes = in.read(block, offset, len)) > -1) {
                downloadedFile.getWritableFileOutputStream().write(block, 0, bytes);
            }
            downloadedFile.close();
            in.close();
            LOGGER.info("File downloaded to '{}'", downloadedFile.getAbsoluteFile());
        } catch (Exception Ex) {
            LOGGER.error("Download failed: {}", Ex);
            throw new Exception("Download failed!");
        } finally {
            getRequest.releaseConnection();
        }
        return downloadedFile.getAbsoluteFile();
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How to iterate a list of WebElements and print the values one by one to perform some action (score [252973](https://stackoverflow.com/q/8029) in 2018)

#### Question
```
List<WebElement> allLinks = driver.findElements(By.xpath("//div[@class='datepicker']/div/table/tbody/tr/td/table/tbody[2]/tr/td[@class='' or @class='datepickerSaturday' or @class='datepickerSunday']/a/span"));

Iterator<WebElement> itr = allLinks.iterator();
while(itr.hasNext()) {
    System.out.println(itr.next());
}
```

I want to print the list elements one by one and perform some actions. But I am unable to get the value present in the list.  

This is what I am getting in console:  

<blockquote>
  <p>[[FirefoxDriver: firefox on MAC
  (81e15827-9357-0341-9c72-5b26054f780d)] </p>
</blockquote>

Xpath:-  

```
//div[@class='datepicker']/div/table/tbody/tr/td/table/tbody[2]/tr/td[@class='' or @class='datepickerSaturday' or @class='datepickerSunday']/a/span]
```

#### Answer 2 (score 8)
Here is a good example of how I select from a dropdown menu:  

```
public Boolean selectByText( String text ) {
    WebElement dropDown = driver.findElement( By.xpath( ".//dropdown/path" ) );
    dropDown.click();
    List<WebElement> allOptions = dropDown.findElements(By.xpath(".//option"));
    for ( WebElement we: allOptions) { 
        dropDown.sendKeys( Keys.DOWN ); //simulate visual movement
        sleep(250);       
        if ( we.getText().contains( text ) ) select.selectByVisibleText("Value1");
    }
}
```

#### Answer 3 (score 3)
@sathiya: What kind of list you want to iterate (Dropdown..etc)?  

Below is the method to get data from the table. Hope this will help you.  

```
WebElement table = driver.findElement(By.xpath("your path"));
List<WebElement> rows = table.findElements(By.tagName("your tagName"));
java.util.Iterator<WebElement> i = rows.iterator();
while(i.hasNext()) {
    WebElement row = i.next();
    System.out.println(row.getText());
}
```

For dropdown list iterate you can use below code.  

```
List<WebElement> drop = driver.findElements(By.name("customerId"));
java.util.Iterator<WebElement> i = drop.iterator();
while(i.hasNext()) {
    WebElement row = i.next();
    System.out.println(row.getText());
} 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How do I close the browser window at the end of a Selenium test? (score [195852](https://stackoverflow.com/q/1941) in 2019)

#### Question
I have googled for the answer, but the `.stop()` so frequently mentioned doesn't work for me. The Chrome window the test was running in remains open.  

```
def test_getResults(self):
    sel = selenium('localhost', 4444, "*chrome", 'http://blackpearl/')
    sel.start()
    # do stuff

def tearDown(self):
    sel = selenium('localhost', 4444, "*chrome", 'http://blackpearl/')
    sel.close()
    sel.stop()
```

Any ideas? I'm using Selenium Server 2.8.0 with Python 2.6 and mostly using Chrome 14 windows to test.  

#### Answer 2 (score 20)
You're actually creating a second Selenium session in your tearDown() function. You need to put the session created in setUp() into an instance variable, then close that session in tearDown().  

```
class TestFoo(unittest.TestCase):
    def setUp(self):
        self.selenium = selenium('localhost', 4444, "*chrome", 'http://blackpearl/')
        self.selenium.start()

    def tearDown(self):
        self.selenium.stop()

    def test_bar(self):
        self.selenium.open("/somepage")
        #and so forth
```

#### Answer 3 (score 19)
driver.close() and driver.quit() are two different methods for closing the browser session in Selenium WebDriver.   

driver.close() - It closes the the browser window on which the focus is set.  

driver.quit() – It basically calls driver.dispose method which in turn closes all the browser windows and ends the WebDriver session gracefully.  

You should use driver.quit whenever you want to end the program. It will close all opened browser window and terminates the WebDriver session. If you do not use driver.quit at the end of program, WebDriver session will not close properly and files would not be cleared off memory. This may result in memory leak errors.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: A way to match on text using CSS locators (score [172217](https://stackoverflow.com/q/362) in 2017)

#### Question
<p>So I use xpath locators and slowly converting to CSS.<br>
I haven't found a way to do an exact match based on text.</p>

For example converting `//a[text()='Log Out']`.  

I know you can do `css=a:contains('Log Out')` but I want to match exactly to the text. Also I know I can do `link=Log Out` but looking for a solution with CSS.    

#### Answer accepted (score 22)
```
css=a[text='Log Out'] or a[innertext='Log Out']
```

Can you please try this one out?   

Or if that doesn't work and you still don't want to use xpath because it's slow, you can always try: `link=Log Out`. That's still better then xpath.  

EDIT:  

So i found a possible solution for you mate. If you are trying to find an exact String you could always use Regular expression like this:  

```
css=div:contains("^ab$") 
```

Just replace div with a and there you go. This will find ONLY AB in whatever text div it looks for. OFC if you have more then one links with text AB (which is a bad thing :P ) then it will find them all..  

Try this and see if it helps. :)  

#### Answer 2 (score 4)
This is a nice place for a few CSS selectors.  

<a href="http://net.tutsplus.com/tutorials/html-css-techniques/the-30-css-selectors-you-must-memorize/" rel="nofollow">http://net.tutsplus.com/tutorials/html-css-techniques/the-30-css-selectors-you-must-memorize/</a>  

Thought it might be useful for people following this thread.  

#### Answer 3 (score 0)
For those who are looking to do Selenium css text selections this script might be of some use  

Trick is to select parent of element of one that you are looking for and then search for child that has the text.   

```
public static IWebElement FindByText(this IWebDriver driver, string text)
{
    var list = driver.FindElement(By.CssSelector("#RiskAddressList"));
    var element = ((IJavaScriptExecutor)driver).ExecuteScript(string.Format(" var x = $(arguments[0]).find(\":contains('{0}')\"); return x;", text), list);
    return ((System.Collections.ObjectModel.ReadOnlyCollection<IWebElement>)element)[0];
}
```

this will return first element if there is more than one since it's always one element in my case.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How can I work with file uploads during a Webdriver test? (score [159952](https://stackoverflow.com/q/12851) in )

#### Question
<em>This is a canonical question, intended to provide a comprehensive answer to many related questions</em>  

During the course of a Webdriver test, I want to upload files. However, this opens a native file picker, which Webdriver doesn't seem to support interacting with. How do I interact with it?  

#### Answer accepted (score 33)
<h5>Uploading files using Webdriver</h1>

<em>Note: this answer applies to Selenium 2. Apparently Selenium 3 changed the interface again.</em>  

<h5>Locally</h2>

If the file is on the same machine or a mapped network drive, this is actually really straightforward: You need to "type" the path to the file into the file upload control. Example:  

```
driver = webdriver.Firefox()
element = driver.find_element_by_id("fileUpload")
element.send_keys("C:\myfile.txt")
```

(Code from <a href="https://stackoverflow.com/a/6129464/719165">This SO answer</a>)  

<h5>Using RemoteWebDriver</h2>

In order to enable the transfer of the file from your local machine to the remote machine so it can be uploaded, you need to set what's called a File Detector. Java example:  

```
    driver.setFileDetector(new LocalFileDetector());
    WebElement upload = driver.findElement(By.id("myfile"));
    upload.sendKeys("/Users/sso/the/local/path/to/darkbulb.jpg");
```

(Code from, and more information located at, <a href="https://saucelabs.com/resources/selenium-file-upload" rel="noreferrer">Sauce Labs</a>)  

#### Answer 2 (score 12)
<h5>Upload a file using Robot class</h1>

This method is for handling the Windows File Upload dialog, which cannot be handled using Selenium. Please follow below steps:  

<ul>
<li><p>Click on the `File Upload` / `Choose File` button, so that the File Upload dialog is displayed.</p>

```
driver.findElement(By.id("uploadbutton")).click;
```
</li>
<li><p>Copy your file's absolute path to the clipboard</p>

```
StringSelection ss = new StringSelection("D:/Test/Test1.docx");
Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss, null);
```
</li>
<li><p>Paste the file's absolute path into the `File name` field of the File Upload dialog box</p>

```
//native key strokes for CTRL, V and ENTER keys
Robot robot = new Robot();

robot.keyPress(KeyEvent.VK_CONTROL);
robot.keyPress(KeyEvent.VK_V);
robot.keyRelease(KeyEvent.VK_V);
robot.keyRelease(KeyEvent.VK_CONTROL);
robot.keyPress(KeyEvent.VK_ENTER);
robot.keyRelease(KeyEvent.VK_ENTER);
```
</li>
</ul>

#### Answer 3 (score 11)
<h5>Upload a file using AutoIT</h1>

<h5>About AutoIT:</h2>

AutoIt v3 is a freeware BASIC-like scripting language designed for automating Windows GUI and general scripting. It uses a combination of simulated keystrokes, mouse movement and window/control manipulation in order to automate tasks.  

This method is for handling the Windows File Upload dialog, which cannot be handled using Selenium. Please follow below steps:  

<ul>
<li>Download <a href="https://www.autoitscript.com/site/autoit/"><strong>AutoIT</strong></a></li>
<li>Open  SciTE Script Editor</li>
<li><p>Below script is used to detect the windows file upload dialog</p>

```
WinWaitActive("File Upload") //File Upload is the dialog's title
Send("Full path of the document") 
Send("{ENTER}")
```
</li>
<li>Save the above script file as `Script.au3`</li>
<li>Compile the file from SciTE Editor and you will get an `Script.exe` file</li>
</ul>

<h5>Steps to be followed while running the test:</h3>

<ul>
<li><p>Click on the File Upload / Choose File button, so that the File Upload dialog is displayed.</p>

```
driver.findElement(By.id("uploadbutton")).click;
```
</li>
<li><p>Invoke the `Script.exe` file</p>

```
Runtime.getRuntime().exec("Script.exe");
```
</li>
<li>The `Script.exe` file will handle the file upload</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: What is the correct way to select an \<option> using Selenium's Python WebDriver (score [151609](https://stackoverflow.com/q/1355) in 2012)

#### Question
I would like to select an `<option>` child of a `<select>` using the Python WebDriver.  

I have a reference to the option `WebElement` I wish to select and have tried `select()` and `click()` methods but neither works.  

What is the correct way to select an `<option>`?  

#### Answer accepted (score 41)
The easiest way that I have found was to do something along the lines of:  

```
el = driver.find_element_by_id('id_of_select')
for option in el.find_elements_by_tag_name('option'):
    if option.text == 'The Options I Am Looking For':
        option.click() # select() in earlier versions of webdriver
        break
```

This may have some runtime issues if there are a large number of options, but for us it suffices.  

Also this code will work with multi-select  

```
def multiselect_set_selections(driver, element_id, labels):
    el = driver.find_element_by_id(element_id)
    for option in el.find_elements_by_tag_name('option'):
        if option.text in labels:
            option.click()
```

Then you can transform the following field  

```
# ERROR: Caught exception [ERROR: Unsupported command [addSelection | id=deformField7 | label=ALL]]
```

Into this call  

```
multiselect_set_selections(driver, 'deformField7', ['ALL'])
```

Multiple selection errors like the following:  

```
 # ERROR: Caught exception [ERROR: Unsupported command [addSelection | id=deformField5 | label=Apr]]
 # ERROR: Caught exception [ERROR: Unsupported command [addSelection | id=deformField5 | label=Jun]]
```

Will be fixed with a single call:  

```
multiselect_set_selections(driver, 'deformField5', ['Apr', 'Jun'])
```

#### Answer 2 (score 70)
I think using <a href="https://seleniumhq.github.io/selenium/docs/api/py/webdriver_support/selenium.webdriver.support.select.html" rel="noreferrer">`selenium.webdriver.support.ui.Select`</a> is the cleanest way:  

```
from selenium import webdriver
from selenium.webdriver.support.ui import Select

b = webdriver.Firefox()

# navigate to the page
select = Select(b.find_element_by_id(....))
print select.options
print [o.text for o in select.options] # these are string-s
select.select_by_visible_text(....)
```

Using this approach is also the fastest way. I wrote `fast_multiselect` as analogous function to `multiselect_set_selections`. On a test with 4 calls to `multiselect_set_selections` on lists of about 20 items each, the average running time is 16.992 seconds, where `fast_multiselect` is only 10.441 seconds. Also the latter is much less complicated.  

```
 from selenium.webdriver.support.ui import Select

 def fast_multiselect(driver, element_id, labels):
     select = Select(driver.find_element_by_id(element_id))
     for label in labels:
         select.select_by_visible_text(label)
```

#### Answer 3 (score 8)
Similar to Will's answer, but finds the `<select>` by its element name, and clicks based on the `<option>` text.  

```
from selenium import webdriver
b = webdriver.Firefox()
b.find_element_by_xpath("//select[@name='element_name']/option[text()='option_text']").click()
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: Selenium - sendKeys() not inserting value into textbox (score [145488](https://stackoverflow.com/q/18415) in 2016)

#### Question
I am not able to validate an international number text box in Selenium.  

I have tried earlier by name, class and other locators but it is not inserting the value into the textbox.    

Below is the text box and the corresponding HTML:  

<a href="https://i.stack.imgur.com/GJguu.png" rel="noreferrer"><img src="https://i.stack.imgur.com/GJguu.png" alt="this the textbox"></a>  

<a href="https://i.stack.imgur.com/kzsJY.png" rel="noreferrer"><img src="https://i.stack.imgur.com/kzsJY.png" alt="html content"></a>  

The code I am using is:  

```
driver.findElement(By.name("phone")).sendKeys("(222)222-2222");   
driver.findElement(By.id("ssn")).sendKeys("555-55-5555");
```

#### Answer 2 (score 11)
If `sendkeys()` methods are not working then use following two ways to input text:  

<ol>
<li><p>Before `sendkeys()` use `click()` method to click inside textfield i.e:</p>

```
driver.findElement(By.name("phone")).click();
driver.findElement(By.name("phone")).sendKeys("(222)222-2222");   
driver.findElement(By.id("ssn")).click();
driver.findElement(By.id("ssn")).sendKeys("555-55-5555"); 
```
</li>
<li><p>Second way is to use javascript to input text in texfields like this:</p>

```
WebElement wb = driver.findElement(By.name("phone"));
JavascriptExecutor jse = (JavascriptExecutor)driver;
jse.executeScript("arguments[0].value='(222)222-2222';", wb);
jse.executeScript("document.getElementById('ssn').value='555-55-5555';");
```
</li>
</ol>

Please let me know if that works for you. Webdriver provided the javscript implementation library so that we could use javascript to perform actions on browser which are not possible with with webdriver native API. And in web automation testing services we encountered many such issues where we have to go beyond webdriver native API and have to use javscript methods.    

#### Answer 3 (score 1)
<p>First once clear the input text 
fields and send the input values. Create a reference object for better use:</p>

```
webElement objPh=driver.findElement(By.name("phone"));   
webElement objSSN=driver.findElement(By.name("ssn"));

objPh.clear();   //To clear the phone text field    
objPh.sendkeys("(222)222-2222"); // To send the input values in phone text field

objSSN.clear(); //To clear the phone ssn text field 
objSSN.sendkeys("555-55-5555"); // To send the input values in ssn text field
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Selenium: How to identify the button WebElement (score [143609](https://stackoverflow.com/q/2696) in 2016)

#### Question
In my web page I'm having following two buttons:  

```
<button onclick="addToSelected('newApplicationForm');">Add Strategy</button>

<button onclick="submitAddNewApplication('newApplicationForm');">Submit</button>
```

How do I identify them using methods of the `By` class?  

#### Answer 2 (score 31)
```
By.xpath("//button[contains(.,'Add Strategy')]")
By.xpath("//button[contains(.,'Submit')]")
```

Notice that it is same as:  

```
By.xpath("//button[contains(text(),'Add Strategy')]")
By.xpath("//button[contains(text(),'Submit')]")
```

#### Answer 3 (score 2)
For Example...Login button is available on login screen...  

```
//Click on Login

WebElement click = driver.findElement(By.xpath("//*[@id='btnLogOn']"));

click.click();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How do I work with dropdowns in Selenium Webdriver? (score [139909](https://stackoverflow.com/q/12029) in 2017)

#### Question
This is a canonical question, intended to provide a comprehensive answer to many related questions.  

I understand the basics of working with Selenium Webdriver; I can navigate to pages, click buttons, and type into text boxes. But now I want to do things with dropdown boxes (also known as "Select" boxes).  

How can I perform common tasks like iterating over the options in the dropdown or selecting options from the dropdown?  

#### Answer accepted (score 34)
<h5>Using the Select Utility Class</h1>

The big secret to working with dropdowns is that you don't want to work with them as WebElements, but instead create a Select element for them. The Select class (<a href="http://selenium.googlecode.com/svn/trunk/docs/api/java/org/openqa/selenium/support/ui/Select.html">java</a>  and <a href="http://selenium.googlecode.com/svn/trunk/docs/api/py/webdriver_support/selenium.webdriver.support.select.html">python</a> documentation) includes utility methods that allow you to perform common tasks. We will be working with the following html:  

```
<select id="mySelectID">
    <option value="Value">Option</option>
    <option value="NotValue">Not Option</option>
</select>
```

<h5>Select by option name</h2>

Java:  

```
WebElement mySelectElm = driver.findElement(By.id("mySelectID")); 
Select mySelect= new Select(mySelectElm);
selMySelect.selectByVisibleText("Option");
```

Python:  

```
mySelect = Select(driver.find_element_by_id("mySelectID"))
mySelect.select_by_visible_text("Option")
```

C#:  

```
var mySelectElm = driver.FindElement(By.Id("mySelectID"));
var mySelect = new SelectElement(mySelectElm);
selectElement.SelectByText("Option");
```

<h5>Select by option value</h2>

Java:  

```
WebElement mySelectElm = driver.findElement(By.id("mySelectID")); 
Select mySelect= new Select(mySelectElm);
selMySelect.selectByValue("Value");
```

Python:  

```
mySelect = Select(driver.find_element_by_id("mySelectID"))
mySelect.select_by_value("Value")
```

C#:  

```
var mySelectElm = driver.FindElement(By.Id("mySelectID"));
var mySelect = new SelectElement(mySelectElm);
selectElement.SelectByValue("Value");
```

<h5>Select by index</h2>

Java:  

```
WebElement mySelectElm = driver.findElement(By.id("mySelectID")); 
Select mySelect= new Select(mySelectElm);
selMySelect.selectByIndex(0);
```

Python:  

```
mySelect = Select(driver.find_element_by_id("mySelectID"))
mySelect.select_by_index(0)
```

C#:  

```
var mySelectElm = driver.FindElement(By.Id("mySelectID"));
var mySelect = new SelectElement(mySelectElm);
selectElement.SelectByIndex(0);
```

<h5>Get the selected option</h2>

Java:  

```
WebElement mySelectElm = driver.findElement(By.id("mySelectID")); 
Select mySelect= new Select(mySelectElm);
WebElement option = mySelect.getFirstSelectedOption();
System.out.println(option.getText()); //prints "Option"
```

Python:  

```
mySelect = Select(driver.find_element_by_id("mySelectID"))
option = mySelect.first_selected_option
print option.text  #prints "Option"
```

C#:  

```
var mySelectElm = driver.FindElement(By.Id("mySelectID"));
var mySelect = new SelectElement(mySelectElm);
var option = mySelect.SelectedOption;
Console.write(option.Text); //prints "Option"
```

<h5>Get the list of options</h2>

Java:  

```
WebElement mySelectElm = driver.findElement(By.id("mySelectID")); 
Select mySelect= new Select(mySelectElm);
List<WebElement> options = mySelect.getOptions();
for (WebElement option : options) {
    System.out.println(option.getText()); //Prints "Option", followed by "Not Option"
}
```

Python:  

```
mySelect = Select(driver.find_element_by_id("mySelectID"))
print [o.text for o in mySelect.options] #Prints "Option", followed by "Not Option"
```

C#:  

```
var mySelectElm = driver.FindElement(By.Id("mySelectID"));
var mySelect = new SelectElement(mySelectElm);
var options = mySelect.SelectedOptions;
foreach(var option in options) {
    Console.write(option.Text); //Prints "Option", followed by "Not Option"
}
```

#### Answer 2 (score 8)
<h5>Without the Select class</h1>

Everything I listed in my other answer can, of course, be done with judicious use of selectors. Since the Select class doesn't exist in Ruby (to the best of my knowledge), this is the only way to work with Select options in Ruby.  

Again, the HTML:  

```
<select id="mySelectID">
    <option value="Value">Option</option>
    <option value="NotValue">Not Option</option>
</select>
```

<h5>Select by option name</h2>

<strong>Java, method 1:</strong>  

In this example, we find the option via a complex xpath, then click on it:  

```
WebElement myoption = driver.findElement(By.xpath(
    "//Select[@id='mySelectID']/option[normalize-space(text())='Option']")
);
 myOption.click();
```

<strong>Java, method 2:</strong>  

In this example, we find all the options, iterate over them, and click the one we want. This is useful if you have a more complex criteria.  

```
WebElement mySelectElm = driver.findElement(By.id("mySelectID")); 
Select mySelect= new Select(mySelect);
List<WebElement> options = mySelect.getOptions();
for (WebElement option : options) {
    if (option.getText().equalsIgnoreCase("Option") {
        option.click();
    }
}
```

<strong>Ruby, method 2:</strong>  

Same method as the previous answer, different language:  

```
mySelect=webdriver.find_element(:id,"mySelectID")
options=mySelect.find_elements(:tag_name=>"option")
options.each do |g|
  if g.text == "Option"
  g.click
  break
  end
end
```

<strong>Ruby, method 3:</strong>  

Here we get fancy, using a closure to find the right option instead of a loop:  

```
mySelect = webdriver.find_element(:id,"mySelectID")
option = dropdown.find_elements(:tag_name,"option").detect { |option| option.attribute('text').eql? "Option"}
option.click
```

<h5>Select by option value</h2>

Same basic idea, but we can use CSS to select an option by value instead of mucking about with xpath:  

<strong>Java</strong>  

```
WebElement myoption = driver.findElement(By.cssSelector("#mySelectID option[value='Value']"));
myOption.click();
```

<strong>Ruby</strong>  

```
mySelect = webdriver.find_element(:id,"mySelectID")
option = mySelect.find_element(:css, "option[value='Value']")
option.click
```

<h5>Select by index</h2>

Again, easy to do with css selectors:  

<strong>Java</strong>  

```
WebElement myoption = driver.findElement(By.cssSelector("#mySelectID option:nth-child(1)"));
myOption.click();
```

<strong>Ruby</strong>  

```
mySelect = webdriver.find_element(:id,"mySelectID")
option = mySelect.find_element(:css, "option:nth-child(1)")
option.click
```

<h5>Get the selected option</h2>

Hooray for CSS selectors! For legacy reasons, the selector for "selected" is "checked", like a checkbox:  

<strong>Java:</strong>  

```
WebElement myoption = driver.findElement(By.cssSelector("#mySelectID option:checked"));
System.out.println(myoption.getText()); //prints "Option"
```

<strong>Ruby</strong>  

```
mySelect = webdriver.find_element(:id,"mySelectID")
option = mySelect.find_element(:css, "option:nth-child(1)")
print option.text
```

<h5>Get the list of options</h2>

<strong>Java:</strong>  

```
List<WebElement> options = driver.findElements(By.cssSelector("#mySelectID option"));
for (WebElement option : options) {
    System.out.println(option.getText()); //Prints "Option", followed by "Not Option"
}
```

<strong>Ruby</strong>:  

```
mySelect=webdriver.find_element(:id,"mySelectID")
options=mySelect.find_elements(:tag_name=>"option")
options.each do |g|
  print g.text #Prints "Option", followed by "Not Option"
end
```

#### Answer 3 (score 1)
You can use following methods to handle drop down in selenium.  

```
 1. driver.selectByVisibleText("Text");
 2. driver.selectByIndex(1);
 3. driver.selectByValue("prog");
```

<p>For more details, you can refer <a href="http://www.codealumni.com/handle-drop-selenium-webdriver/" rel="nofollow noreferrer">this post.</a> 
It will definitely help you a lot in resolving your queries. </p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: How to export test cases from test plan in QC (score [131795](https://stackoverflow.com/q/2721) in )

#### Question
We use QC for test management tool in our project. Usually we write test cases &amp; test steps in spreadsheets and load into QC using 'Export to QC' excel add-in. We have a set of test cases already present in QC and they need to be updated.  

Is there a way I can export the test cases (along with test steps for each test case) from QC back to excel so that I can update them to load it back to QC??   

#### Answer 2 (score 3)
This is how I do it:  

<ol>
<li>Login to Quality Center.</li>
<li>Click Test Lab/Test Plan/Wherever you keep your test cases. </li>
<li>After creating the test set, configure the columns to display in the desired order.</li>
<li>Right click within the Test Set list and select Export > All. </li>
<li>Name the Export file and click save.</li>
</ol>

Exporting a test set is a lot easier than exporting from the test plan section, I've found. So if possible, consider bundling the tests, then exporting.  

However if you really want to export from the Test Plan, click View > Test Grid. Then use a column to filter the displayed tests and export as explained above.  

The third option is to export using SQL within Quality Center, but I've never explored that option too much as I've always had success with the first two methods.  

#### Answer 3 (score 1)
there's a sample .vbs (but it was uploaded as .txt) in this forum -> <a href="http://h30499.www3.hp.com/t5/Quality-Center-Support-and-News/Test-Plan-export-from-QC-to-Excel/td-p/4807563" rel="nofollow">http://h30499.www3.hp.com/t5/Quality-Center-Support-and-News/Test-Plan-export-from-QC-to-Excel/td-p/4807563</a>  

I haven't tried it myself though, but I do hope it helps you.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: Selenium: How to click at x,y coordinates? (score [113606](https://stackoverflow.com/q/8535) in 2016)

#### Question
I want to click at x, y coordinates like 52, 216-52, 295.   

<blockquote>
  <em>How can this be done using Selenium? (I am using Mac OSX 10.8.5 with Selenium 2.40.0 and Firefox version 29.0)</em>  
</blockquote>

#### Answer 2 (score 7)
You can move the mouse and click with <a href="http://selenium.googlecode.com/git/docs/api/java/org/openqa/selenium/interactions/Actions.html" rel="noreferrer">Actions</a>, given you have a element to offset from. You cannot click outside the browser content window or control Operating System elements.  

```
moveToElement(WebElement toElement, int xOffset, int yOffset)
Moves the mouse to an offset from the top-left corner of the element.
```

The code (Java) would look like this:  

```
Actions builder = new Actions(driver);   
builder.moveToElement(knownElement, 10, 25).click().build().perform();
```

#### Answer 3 (score 2)
I needed to do this in javascript with protractor:  

```
  browser.actions()
  .mouseMove(
    element(by.css('.material-dialog-container'))
    , -20, -20  // pixel offset from top left
  )
  .click()
  .perform();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How to continue script when element is not found in selenium (score [113415](https://stackoverflow.com/q/14190) in 2015)

#### Question
I am using selenium web driver and appium as this is mobile application automation,  

I am trying to check that if element is there or not and based on that I have put conditions.  

```
 long starttime = System.currentTimeMillis();
 long endtime = starttime + 60*1000; // 60 seconds * 1000 ms/sec;


while(System.currentTimeMillis() < endtime)
{

    notcount = driver.findElement(By.id(AppConstants.notificationcount));

}

if(notcount.equals(null))

{

    System.out.println("No Element found");
}
else
{

    //SOME ANOTHER STEPS
}
```

Here issue is when element is not there , instead to redirect to ELSE part , selenium stops execution and throwing exception.  

I do not want to use List -findelements here as that is taking long time to find element.  

#### Answer accepted (score 13)
Use `findElement<strong>s</strong>` instead of `findElement`.  

`findElements` will return an empty list if no matching elements are found <strong>instead of an exception</strong>.  

To check that an element is present, you could try this  

```
Boolean isPresent = driver.findElements(By.yourLocator).size() > 0
```

This will return true if at least one element is found and false if it does not exist.  

Text copied from: <a href="https://stackoverflow.com/questions/7991522/selenium-webdriver-test-if-element-is-present">https://stackoverflow.com/questions/7991522/selenium-webdriver-test-if-element-is-present</a>  

Another posbility is to use a Try/Catch construction, see this for more info: <a href="https://stackoverflow.com/questions/6521270/webdriver-check-if-an-element-exists">https://stackoverflow.com/questions/6521270/webdriver-check-if-an-element-exists</a>  

#### Answer 2 (score 6)
What you are experiencing is a <strong>fast-fail</strong> type of behavior when you use `.findElement` .   You don't really need to use `.findElements(el)`   to get a soft-fail behavior.  What you could do is something like this instead:  

```
protected void checkElementPresence(final WebDriver driver,final By by,final String errorMsg){
  new WebDriverWaitWithMessage(driver,10).failWith(errorMsg).until(new ExpectedCondition<Boolean>(){
    @Override public Boolean apply(    WebDriver webDriver){
      try {
        return driver.findElement(by).isDisplayed();
      }
 catch (      NoSuchElementException ignored) {
        return false;
      }
catch (      StaleElementReferenceException ignored) {
        return false;
      }
    }
  }
);
```

But requires this support class:  

```
protected static class WebDriverWaitWithMessage extends WebDriverWait {

        private String message;

        public WebDriverWaitWithMessage(WebDriver driver, long timeOutInSeconds) {
            super(driver, timeOutInSeconds);
        }

        public WebDriverWait failWith(String message) {
            if (message == null || message.length() == 0) {
                throw new IllegalArgumentException("Error message must not be null nor empty");
            }
            this.message = message;
            return this;
        }

        @Override
        public <V> V until(Function<? super WebDriver, V> isTrue) {
            if (message == null) {
                return super.until(isTrue);
            } else {
                try {
                    return super.until(isTrue);
                } catch (TimeoutException e) {
                    throw new TimeoutException(message, e);
                }
            }
        }
    }
```

#### Answer 3 (score 2)
(note I haven't tried this in java, but this is how to do it in C#)  

You should place the findelement in a <em>try/catch</em> block, so that if the element is not found you can catch the exception and do the correct thing.  

It would look something like this:  

```
try
{
    driver.FindElement(By.CssSelector("selector"));
} 
catch(NoSuchElementException)
{
    Console.WriteLine("Element does not exist!");
} 
```

<p>Edit:<br>
I will note that it looks like you are trying to implement your own webdriver wait behavior, so maybe look into the first answer here: <a href="https://stackoverflow.com/questions/11736027/webdriver-wait-for-element">https://stackoverflow.com/questions/11736027/webdriver-wait-for-element</a> which explains how to wait for elements with explicit waits in Java.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: Webdriver Check if Checkbox is Set and Set it if Not (score [111150](https://stackoverflow.com/q/5330) in 2017)

#### Question
I am learning Webdriver with JUnit by going through Alan Richardson's <em><a href="http://seleniumsimplified.com/" rel="noreferrer">Selenium Simplified</a></em> book and taking translating the exercises/tests from Selenium RC to Webdriver. So far, this has proven to be an excellent learning experience. But recently I have hit an issue, and cannot solve it despite extensive searching.   

In Selenium RC there is a `selenium.check` command which will check a box if it is empty, or leave it if it is already checked. For example:   

```
selenium.check("//input[@name=’checkboxes[]’ and @value=’cb3’]");
```

If you go to the target website (<a href="http://compendiumdev.co.uk/selenium/basic_html_form.html" rel="noreferrer">http://compendiumdev.co.uk/selenium/basic_html_form.html</a>) you will see there are three check boxes, one of which is checked. I have written some pseudo-code but just can't get into making it work. Here is the pseudo-code:  

```
isChecked = driver.findElement(By.xpath("//input[@type='checkbox']"));

if (isChecked = false) {
    check the box;
} else {
    do nothing;
}
```

I know the boolean `isSelected()` should feature, but I don't know where to go beyond that. All my research has returned partial solutions, but nothing that gets close enough for me to take a leap of faith at the solution.  

#### Answer accepted (score 9)
In the Selenium Simplified course the secret to the selector is really the 'value' not the 'type' as the 'value' identifies the WebElement uniquely on that page, coupled with a type 'just in case'  

```
WebElement checkBox1;
WebElement checkBox3;

checkBox1 = driver.findElement(By.cssSelector("input[value='cb1']"));
checkBox3 = driver.findElement(By.cssSelector("input[value='cb3']"));

if(!checkBox1.isSelected()){
    checkBox1.click();
}

//checkBox3 is selected by default
if(checkBox3.isSelected()){
    checkBox3.click();
}
```

<hr>

Or using `findElements` code.   

You could instead do:  

```
List<WebElement> selectElements= 
driver.findElements(By.cssSelector("input[name='checkboxes[]']"));

selectElements.get(0).click();

if( selectElements.get(2).isSelected()){
    selectElements.get(2).click();
}
```

Or iterate over them:  

```
for(WebElement checkbox : selectElements){
    // uncheck 'em all
    if(checkbox.isSelected()){
      checkbox.click();
    }
}
```

Hope that helps.  

#### Answer 2 (score 7)
It should be as easy as:  

```
IWebElement element = driver.findElement(By.xpath("//input[@type='checkbox']"));
if (!element.Selected)
{
    element.Click();
}
```

#### Answer 3 (score 1)
It is very Simple in C#  

<strong>Example :</strong>  

```
IWebElement chkBox = driver.FindElement(By.Id("some id "));
if (chkBox.Selected) {
  //perform actions 
} else {
  //perform actions
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How to fill CAPTCHA using Test automation? (score [107726](https://stackoverflow.com/q/17022) in 2017)

#### Question
How can I automate "Enter CAPTCHA" using Selenium WebDriver?  

#### Answer accepted (score 51)
<strong>You don't</strong>, that is the whole idea behind a good <a href="https://en.wikipedia.org/wiki/CAPTCHA" rel="nofollow noreferrer">CAPTCHA</a>.  

CAPTCHA stands for:  

<blockquote>
  Completely Automated Public Turing test to tell Computers and Humans Apart  
</blockquote>

So, by definition, resolving a CAPTCHA cannot be automated: Otherwise, it could not tell computers and humans apart and hence fails to be a CAPTCHA.  

How to handle a CAPTCHA in a <strong>test environment</strong>:  

<ol>
<li>If you need to test an application which uses CAPTCHA, then you need to get the development team to build in a workaround/backdoor which is only active in the test environment.</li>
<li>Use a service like <a href="http://www.deathbycaptcha.com" rel="nofollow noreferrer">http://www.deathbycaptcha.com</a> which has an API to return the text of the CAPTCHA for you. The average response is 15 seconds with a result rate of 90% or so they say. Sounds like something to try.</li>
</ol>

#### Answer 2 (score 36)
We cannot automate CAPTCHA, as it is not meant to be automatized.  

<strong>How to deal with CAPTCHA?</strong>  

<ol>
<li><p>Either ask dev team for a workaround, like configure CAPTCHA <strong>in test environment</strong> in such a way it will always accept 1 specific value.</p></li>
<li><p>Ask developer to disable the CAPTCHA module <strong>in testing environment</strong>.</p></li>
<li><p>If your are using custom CAPTCHA module, you can ask developer to generate an API of CAPTCHA generation <strong>for testing environment</strong>.</p></li>
<li><p>You can ask dev team to add CAPTCHA code as `title` in markup, then you can access this title and bypass the CAPTCHA, <strong>but only in the testing environment</strong>.</p></li>
</ol>

Most of the time we go with option 1 or 2.  

<strong>NOTE:</strong> When you do work around for CAPTCHA in test environment, You should always have this point in your checklist to make sure workarounds for CAPTCHA testing are removed before it goes on production.  

#### Answer 3 (score 8)
Here's an example of captcha and a robot to cheat it:  

<a href="https://www.facebook.com/enjuto.mojamuto.oficial/videos/10154051965665810/" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/263mx.png" alt="captcha"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: Running WebDriver without opening actual browser window (score [106269](https://stackoverflow.com/q/2609) in 2012)

#### Question
I've heard rumors that Selenium WebDriver can run without opening a real browser window, meaning it runs in the background.  I am using the C# Client Drivers, FirefoxDriver within the automated tests, and launching a class library project (containing my code) using NUnit.    

<ul>
<li>If so, how can this be done?  </li>
<li>Also, what is the benefit to doing it this way?  </li>
<li>Do you still have to keep the waits (thread.sleep and implicit waits) in the code since the browser isn't open?</li>
</ul>

#### Answer accepted (score 13)
One option is HTMLUnit, which is headless but has its own proprietary JavaScript rendering engine, so it is possible that it will behave differently than existing browsers (If you do use HTMLUnit, don't forget to enable JavaScript when you instantiate it).  

The second option is to use XVFB; this will run the tests in a virtual frame buffer environemt.  This has been reported quite a few times on the Selenium users mailing list as well as the Selenium blog, <a href="http://seleniumhq.wordpress.com/2012/01/25/a-smattering-of-selenium-76/" rel="nofollow noreferrer">see this post</a> for some XVFB implementations.  

Linking directly to the tutorials:  

<ol>
<li><a href="http://fishi.devtail.io/weblog/2015/03/02/functional-headless-ui-testing-django-selenium/" rel="nofollow noreferrer">functional-headless-ui-testing-django-selenium</a>  </li>
<li><a href="http://www.youtube.com/watch?feature=player_embedded&amp;v=DL7gyuqkzzU" rel="nofollow noreferrer">Watch player_embedded</a></li>
</ol>

If you google for Selenium and XVFB you'll find lots more info.  

#### Answer 2 (score 15)
It is quite easy to hide the browser without XVFB. Just <a href="http://phantomjs.org/download.html">install PhantomJS</a>. Then, change this line:  

```
driver = webdriver.Firefox()
```

to:  

```
driver = webdriver.PhantomJS()
```

The rest of your code won't need to be changed and no browser will open. For debugging purposes, use `driver.save_screenshot('screen.png')` at different steps of your code.  

#### Answer 3 (score 4)
You can attempt to run your tests inside an instance of the HtmlUnitDriver.  I attempted to look at the documentation on this, but the chm file inside of the latest release seems to be botched.    

There is also <a href="http://code.google.com/p/webkitdriver/" rel="nofollow">WebkitDriver</a>, but that seems to be Java only for the time being.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: Selenium: reuse existing browser session, instead of opening new windows? (score [99772](https://stackoverflow.com/q/1988) in 2016)

#### Question
This has been asked a million times on the web, but there's no clear cut answer. I tried "-browserSessionReuse" today without any luck; my tests keep spawning new browser windows.  

```
X:\QA\Automation\SELENIUM_SERVER>java -jar selenium-server-standalone-2.8.0.jar -log "log.txt" -browserSessionReuse -forcedBrowserMode "*googlechrome"
<snip>
13:42:25.923 INFO - Will recycle browser sessions when possible.
```

Maybe it's how I'm starting Selenium in my .py files?  

```
sel = selenium('localhost', 4444, "*chrome", 'http://server/')
sel.start()
```

...perhaps I'm doing too many server starts?  

#### Answer accepted (score 16)
<p>This is possible with Selenium 2 and WebDriver. I'm not sure if it is with different versions.  In Selenium 2 with WebDriver you can call `webDriver = new FirefoxDriver()` which spawns a browser, and that browser will stay open for the duration of your testing, or you can choose to close it with `webDriver.Quit()`.<br>
I like to close my browser window between tests so that I know my tests aren't "dirty" with stored session data that could affect how the tests run, but I can see value in some targeted tests, where I want to try a couple different scenarios while keeping the same session going.</p>

#### Answer 2 (score 3)
I have done it in the past by declaring my Selenium driver instance as a static member loaded by the entire test suite.  Then, pass that member as an argument to each test.  Then, I also created some methods to keep track of how many windows are open and make sure that the last window is never closed.    Then, after each test I close all windows except for the last one and redirect the last window to "about:blank".   Then, as my tests run, it reuses the windows.    

I have since then, abandoned this method because I no longer need it, for the following reasons:  

<ol>
<li>Using a static global webdriver object was bad programming practice.  My
driver was part of a Utility class extended by all tests and therefore
my test classes could not extend any other class.  You can get around this
my using Scala and/or JDK1.8 because they have the "defender method" 
interface feature, but since I am using JDK1.7, I needed to do this 
the right way.</li>
<li>Now I close the browser after each test but since I now use "Selenium
Grid" I dont need to worry about the performance impact of re-opening
browsers anymore because I can throw more hardware at the problem and
run multi-threaded.</li>
</ol>

NOTE: <a href="https://github.com/djangofan/WebDriverTestingTemplate/tree/master/google" rel="nofollow">Here is my example of how I do things now</a> but keep in mind that there are now better ways of doing this.  

#### Answer 3 (score 2)
I faced the same issue using TestNG. I had used `@BeforeMethod` and for each method new browser is opened.  

When I changed it to `@BeforeTest` instead of `@BeforeMethod`, that worked for me.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: Trying to find span element by class and text with selenium c# (score [96035](https://stackoverflow.com/q/15690) in 2015)

#### Question
I want to click on Administration panel. The `<span>` contains a class attribute and inner text.  

I get an error saying "unable to locate element". What am I doing wrong?  

HTML:  

```
 <div class="item-inner">
      <span class="title"> Administration </span>
      <i class="icon-arrow"></i>
  </div>
```

C# code  

```
  var admi = driver.FindElement(By.XPath("//span[contains(@class,'title')]  [contains(text(),'Administration')]"));

  admi.Click();
```

#### Answer 2 (score 3)
Try to avoid the use of contains as your method of finding an element.  This will mainly cause you issues later down the line when other elements unintentionally match  

I would suggest you use something more like;  

```
driver.FindElement(By.XPath("//div[@class='item-inner']/span[@class='title']"));
```

This example still isn't ideal, and ideally you should ask your developers to add in a unique ID for you to utilize.  

#### Answer 3 (score 0)
`var admi = driver.FindElement(By.XPath("//span[contains(@class,'title') and contains(text(),'Administration')]"));`  

You were almost there.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: How can I switch to new window using webdriver? (score [93888](https://stackoverflow.com/q/3986) in 2012)

#### Question
I have clicked an image in a slide show and it generates a new window. Once the window opens I need to bring focus on new window and do some stuff. I have attached my code below, but it is not successful.  

```
@Test
public void testCreateAccount() throws Exception{

//OPEN manorama online  url
driver.navigate().to("http://www.manoramaonline.com/cgi-bin/MMOnline.dll/portal/ep/home.do?tabId=0&BV_ID=@@@");

// to click a link inside a slide show

while (!driver
        .findElement(
                By.xpath("/html/body/div[2]/div[2]/div[4]/div/div/div/div/center/div/div[2]/span/div/a/img"))
        .isDisplayed()) {
}
driver.findElement(
        By.xpath("/html/body/div[2]/div[2]/div[4]/div/div/div/div/center/div/div[2]/span/div/a/img"))
        .click();



String newwindowTitle = driver.getTitle();

switchWindow(newwindowTitle);

}

protected static boolean switchWindow(String title) throws IOException {

    String currentWindow = driver.getWindowHandle();
    Set<String> availableWindows = driver.getWindowHandles();
    if (!availableWindows.isEmpty()) {
    for (String windowId : availableWindows) {
    if (driver.switchTo().window(windowId).getTitle().equals(title)) {
    return true;
    } else {
        driver.switchTo().window(currentWindow);
    }}}

    return false;   
    }
```

#### Answer 2 (score 11)
A possibly much simpler solution would be this:  

```
driver.SwitchTo().Window(driver.WindowHandles.Last());
```

.Last() will just switch to the most recently opened window, which should be the one that just opened when you clicked the link.  

#### Answer 3 (score 3)
I think that you're probably over complicating the problem in your switchWindow method.    

If I understand you correctly, all that you want to do is iterate through the open windows, compare the title of each window, and if it's the right one, return true.  

<strong>C# example</strong>  

```
protected static Boolean SwitchWindow(string title)
            {
                var currentWindow = driver.CurrentWindowHandle;
                var availableWindows = new List<string>(driver.WindowHandles);

                foreach (string w in availableWindows)
                {
                    if (w != currentWindow)
                    {
                        driver.SwitchTo().Window(w);
                        if (driver.Title == title)
                            return true;
                        else
                        {
                            driver.SwitchTo().Window(currentWindow);
                        }

                    }
                }
                return false;
            }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: Looking for an excellent example of using a spreadsheet for test case management (score [92029](https://stackoverflow.com/q/5383) in 2016)

#### Question
It is an unfortunate reality of our industry that many testers are stuck using a spreadsheet to manage their test cases.  

<blockquote>
  I wanted to ask (in a community wiki), what are some good techniques and examples that people can share on <strong>how someone can manage test case planning and execution in Excel?</strong>  
</blockquote>

(I know that this does not exactly fit the Q&amp;A style, but I think that the question and answers will be valuable to testers who use spreadsheets as a test case management tool).  

#### Answer accepted (score 7)
I do not have any examples but I can describe an experience, albeit more about written test cases than about using Excel.  

When I started my previous job, test cases were not written down.  Moreover, the IT department was openly hostile to the QA team; asking for a server as a test case repository was a non-starter.  As an intermediate step, I picked an subset of the product and put test cases in a shared Excel spreadsheet.  I think there were four columns: a description of the test case, the tester assigned to it, the pass/fail status, and free-form comments (e.g. for bug IDs).  

The test cases were simple, declarative statements rather than step-by-step instructions, e.g. "Every field honors its minimum and maximum field lengths" or "Field X is mandatory."  

Each release, as the product changed, some of the test cases would need revising, too.  I wanted to keep the old test results for historical purposes, so we made a new copy of the spreadsheet for each release.  

I think we followed that practice for a few releases.  We had limited success.  On one hand, the testers liked having something written down, and they liked being explicit about who was testing what.  On the other hand, many on the team were not accustomed to writing test cases -- although they overlap, writing is a different skill from actual testing.  

After a few releases, we managed to get the IT department to install Mediawiki on a server, so we switched to documenting our test cases there.  We went back to personal communications or email for assigning testers to test cases and for reporting status.  (We used Bugzilla for bug tracking, but we didn't have a formal way to declare which test cases were tested and which were still left to do).  I left that job a few years ago.  As I understand it, they still use my test automation framework, but they stopped using the written test cases altogether.  I think the test cases grew obsolete and there was no one left on the team who was interested in writing.  

#### Answer 2 (score 7)
I made this sample spreadsheet for a project named <strong>Gmail</strong> (download it <a href="https://drive.google.com/file/d/0Bwi5hK7Ra1JkVzdUYU9KRnZPbDg/view?usp=sharing" rel="nofollow noreferrer">here</a>).  

<img src="https://i.stack.imgur.com/eWzf7.png" alt="Test Case Spreadsheet">  

Some comments:  

<ul>
<li><strong>Test Case ID</strong>: use this value to link each bug with one or more Test Case IDs.</li>
<li><strong>Test Case Description</strong>: they may be independent from each other or something like

<ol>
<li>Run Test Case ID 4</li>
<li>Click on "submit"</li>
</ol></li>
<li>The <strong>Status</strong> columns (the ones with the colours) are pretty self-explanatory. The <strong>"Failed"</strong> status should include a link to the issue detected. A failed test case should be linked to one and only one issue in your bugtracker. Otherwise, it's hard to do regression testing.</li>
<li><strong>For every test run there is a column added to the left. The leftmost column should be the most recent test run.</strong> Optionally, you can include the revision under test.</li>
</ul>

<H3>Advantages</H3>  

<ul>
<li>It's easy to show the results in an e-mail, you just copy and paste the spreadsheet and the most recent test run. Also, because you use colours, it's easy to see the overall status of the test run.</li>
<li>It's easy to add more test cases.</li>
</ul>

<H3>Disadvantages</H3>  

<ul>
<li>It's hard to know whether a test case has been written before, i.e. if you're not writing duplicate test cases.</li>
</ul>

#### Answer 3 (score 2)
As a consultant, I am often sent to a client who does not have a test case management tool. It can be a short contract which would not last as long as the time it would take to introduce a test case management tool and teach the users how to use the software.  

With Excel, I can format a basic test case template for use by myself or the client within minutes. This is then used to track what has been tested on a feature (test steps or scenarios), and monitor whether the testing passed or failed. In the case of a failed test, the bug is outlined in a "Notes" column. After a bug fix, the results of the re-run are recorded on a second sheet within the Excel workbook.  

Finally, the spreadsheet can be placed on the network for reference, attached to an email, or printed.   

From my experience this approach helps a client gain confidence in the value of testing, and gives them space to consider which tool they want to use.   

On a final note, I take comfort from the knowledge that the team is now recording their tests, their results, and any bugs somewhere more formal than in an email (as is often the case). This makes testing a process which is repeatable, traceable, and adjustable, whilst also introducing a common point of reference.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: Positive and negative test cases for login page (score [90047](https://stackoverflow.com/q/13957) in 2015)

#### Question
One of the interviewer asked the below question:  

Tell me the best positive and negative test cases for Login page.  

Can anyone provide me with the best answer?  

#### Answer 2 (score 10)
Telling the interviewer <em>what</em> is less important than telling them <em>why</em>. They asked for the two best cases - not just a list of cases. This means that you need to explain to them why these cases are "better" than the many other cases you could have offered up. It doesn't matter if you give good answers if you cannot also explain why they are good answers.  

A great place to start might be to ask what the interviewer means by "best". Does he or she mean, "Most valuable tests if only two tests are written"? "Most interesting"? "Most efficient at uncovering bugs"? "Most valuable in terms of time to implement"? These kinds of questions suggest that the interviewee understands that different people throughout the business may value different things. "Best" from the project owner's perspective may not be the same as "best" from the perspective of the technical lead or the business owner.  

If the interviewer says, pick whatever definition of best makes sense to you (a common response):  

The best positive case is generally the "Happy path" case - the most common case that will happen. If that test case passes, it tells you that your system is basically functioning for the main situation. It also is the test case that covers the broadest swath of the user experience. For this scenario, this would be a valid user logging in with a common username (no fancy characters) and a correct simple password (as simple as the security requirements will allow).   

The best negative case, if time is limited, is nothing more than entering a simple username and an incorrect but also simple password. The basic functionality of a login page is to deny users with incorrect passwords, and that no other behavior matters if the login page cannot do this. If more time is available, I would say that the best test case is fuzzing the password field using any value other than the correct password for a given user, and then checking for successful logins, exceptions, and other inappropriate results. I would want to talk to the developers and business owners to determine what results would be inappropriate.  

I personally would also volunteer to give some other interesting cases, to let the interviewer know that I <em>can</em> come up with, e.g., servers unavailable, edge cases in the registration process, SQL injection, tests to make sure the login process isn't too fast (allows attackers more attempts in less time).  

Honestly, though, the interviewer will be happy with any answer that demonstrates depth of knowledge. Don't just think about technical depth. The answer "entering a valid user with an invalid password" has almost no technical depth - but mentioning the swiftness of implementation and the value of covering the basic functionality of rejecting incorrect passwords demonstrates highly valuable business awareness, and is the kind of answer I would expect from a senior QA engineer. An "interesting" answer that indicates technical depth is what I would expect from a mid-level engineer, and a list of mostly functional test cases is what I would expect from someone who is relatively junior.   

Yes, I do interview QA engineers from time to time.  

#### Answer 3 (score 4)
There are many answers for this question, but first what come's in mind, are:  

<blockquote>
  Positive:  
  
  Data:  login: X password: Y  
  
  <ul>
  <li>User Log in correctly using proprietary data</li>
  </ul>
  
  Negative:  
  
  Data:  
  
  login: [not registered login] V password: Y  
  
  <ul>
  <li>User can't log in with unregistered login</li>
  </ul>
  
  Data:  
  
  login: X password: [Bad password] B  
  
  <ul>
  <li>User can't log in with proprietary login and bad password</li>
  </ul>
  
  Pre condition: System unavailable  
  
  Data:  
  
  login: X password: Y  
  
  <ul>
  <li>User can't log in to system with proprietary login and password (servers are down, no internet connection, etc )</li>
  </ul>
</blockquote>

If I make mistake please someone correct me, but I always use something like this (and much more) and it's work well. Sorry for not formatting text but I'm in work and don't have much time ;)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: How to resolve - "adb server version (32) doesn't match this client (36); killing..." (score [85519](https://stackoverflow.com/q/20524) in )

#### Question
I executed cmd `adb devices` from terminal but instead of getting list of connected devices, I observed below error:  

```
List of devices attached
adb server version (32) doesn't match this client (36); killing...
* daemon started successfully *
```

How can I get list of connected device?  

#### Answer accepted (score 2)
I had the same issue. I realized that I updated all my packages in the SDK manager recently. And having a second look I saw that I had the Android SDK platform tools installed twice (24.0.1 and 23.0.3). After deinstalling the 23.0.3 version everything worked more stable again including Vysor.  

#### Answer 2 (score 4)
Faced this issue on Mac:  

I have tried different solution, But below works for me -  

<ol>
<li>Uninstall "<em>Vysor</em>" plugin if you have installed for Chrome</li>
<li>Under Home folder > find .Android folder and move to trash</li>
<li>Goto, Android sdk > delete/move to trash platform-tools folder</li>
<li>Again install/download from Android SDK Manager</li>
<li>Open terminal -

<ul>
<li>`adb kill-server`</li>
<li>`adb start-server`</li>
</ul></li>
<li>Check `adb devices`, It will work and display you all connected devices.</li>
</ol>

Hope it helps !  

#### Answer 3 (score 1)
Are you using Vysor? You may have installed it as a Chrome plugin. Please uninstall it because it also uses the Android SDK  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: How to export the test cases with design steps from test plan in QC (HP ALM Quality Center 11.52) (score [84844](https://stackoverflow.com/q/9077) in 2017)

#### Question
When I downloaded the test case from the test plan in QC then all the test cases field are downloaded except the test case design steps.  

Can you please give me some solution of this problem?  

#### Answer accepted (score 3)
you can follow below mentioned step to create TCs with Steps.  

<ol>
<li>Go to Test Plan</li>
<li>Select the Folder where your TCs are stored.</li>
<li>Click on Analysis</li>
<li>Click on Report</li>
<li>Select Tests with Design Steps</li>
</ol>

Please refer the screenshot for more details.  

<img src="https://i.stack.imgur.com/cEu6K.jpg" alt="enter image description here">  

#### Answer 2 (score 1)
If you only need a few test cases, the following steps will work:  

<ol>
<li>Select the test cases you need.</li>
<li>Right-Click on them</li>
<li>Choose "Send by Email ..." and again "Send by Email ..."</li>
<li>In the following dialog, there is an area with check boxes that let you include information. </li>
<li>Mark the "Design Steps" check box, type in your email address and hit "Send".</li>
</ol>

<p>You will get one email per test case with a pretty list of test details and the design steps.
I like to use this for working remote, where I don't have access to the HP ALM.</p>

Caution: Calls to other test are not resolved, you just get the name of the called test.  

#### Answer 3 (score 0)
Instead of relying solely on inbuilt ALM options, You can also try developing a macro tool or use an existing one.    

```
http://www.shooter-smith.co.uk/hp-qc-alm-test-case-and-script-download/
```

The one detailed in this site has a neat GUI to select ALM folders and the tool can also be used to download requirements or test sets.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How to get entered text from textbox when value is empty in selenium using java? (score [81760](https://stackoverflow.com/q/18658) in 2016)

#### Question
Just I am trying to get entered text from the text field when value is empty.  

<strong>Below is my HTML:</strong>  

```
<input type="text" style="width: 203px" value="" maxlength="32" name="firstName"/>
```

I tried using getAttribute("value") but it didn't work. Please suggest how to do it using selenium webdriver with java.  

<strong>Also screenshot attached.</strong>  

<a href="https://i.stack.imgur.com/6axoS.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/6axoS.jpg" alt="enter image description here"></a>   

#### Answer 2 (score 3)
When are you trying to get a value? before entering or after entering it in the text field?  

```
  WebElement fName=driver.findElement(By.name("firstName"));
  fName.sendKeys("Admin");
  System.out.println(fName.getText());
```

Above code should return text entered.  

#### Answer 3 (score 1)
<strong><h5>Use following code:</h1></strong>  

```
WebElement firstName = driver.findElement(By.xpath("//input[@name='firstName']"));
String value = firstName.getText();
System.out.println(value);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Selenium test case fails due to page load time (score [79723](https://stackoverflow.com/q/6588) in )

#### Question
<p>I run nearly 30-40 test cases twice a day. And everytime some test case fails due to page load time. Infact i have explicitly mentioned `Thread.sleep("2000");` wherever i feel it takes more time to load. But still some 5-6 testCases fails. How can i make my selenium to wait until the page loads ?? And what would the below code do ?
`driver.manage().timeouts().implicitlyWait(4000, TimeUnit.SECONDS);` 
Will it wait for 4 seconds everytime or it sets the maximum  time limit to 4 secs . I even tried this but it really slowed my test execution. I need some help.</p>

#### Answer 2 (score 9)
Look at the Wait commands rather than sleep - a search on this site or Google will give you lots of examples  

#### Answer 3 (score 8)
You can use WebDriverWait to synch with page load. Something like the following might help  

```
WebDriverWait wait = new WebDriverWait(driver, 15); //you can play with the time integer  to wait for longer than 15 seconds.`
wait.until(ExpectedConditions.titleContains("title")); //if you want to wait for a particular title to show up
```

OR  

```
wait.until(ExpectedConditions.presenseOfElementLocated(ByLocator)); //in case you want to wait for a particular element to appear on the page.`
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: Quicker way to assert that an element does not exist (score [74255](https://stackoverflow.com/q/3481) in )

#### Question
<p>The goal of my test is to assert that a popup does not appear after certain actions.
Previously to test if the popup exist, i have used exception handling.</p>

```
try:

    self.driver.find_element_by_id("fancybox-close").click()

except Exception ('ElementNotVisibleException'):

    print "No popup"
```

This works fine for the test : to assert if popup exists.  

But as soon as i change the goal to : assert if popup does not exist  

the exception handling solution becomes very expensive (exception handling takes a lot of time in python) and a test that would execute in 3 secs now takes up to a minute.  

Is there a way around this? A quicker way to check if an element does not exist using webdriver python binding ?  

#### Answer accepted (score 6)
I haven't used the Python bindings, but as far as I know they should be equivalent to the Java ones.  

If I were you I would try to find the Python equivalents of `findElements()` and  `isDisplayed()` that are available in the Java bindings.  

For example, I would do something similar to this:  

```
// ...
myElementList = driver.findElements(By.Id("fancybox-close"))
if (myElementList.isEmpty()) {
    // The element doesn't exist. findElements, in plural, returns a list of the matching elements, or an empty list if no one is found
else {
    // We know it exists, now we need to know if it's displayed (visible) or not
    if (myElementList[0].isDisplayed()) {
        // This means the element is visible
    else {
        // ...
    }

}
```

Hope it helps  

#### Answer 2 (score 3)
The test is slow not due to slow exception handling, but because driver waits for elements thats are not found. In this case driver waits for the pop-up - maybe it will appear.  

Try to use `self.driver.implicitly_wait(0)`  

This will tell driver not to wait if it cannot find some elements.  

#### Answer 3 (score 2)
Here's another example much like the one from Ignacio, but in C#:  

```
    //Displayed
    public static bool IsElementDisplayed(this IWebDriver driver, By element)
    {
        if (driver.FindElements(element).Count > 0)
        {
            if (driver.FindElement(element).Displayed)
                return true;
            else
                return false;
        }
        else
        {
            return false;
        }
    }

    //Enabled
    public static bool IsElementEnabled(this IWebDriver driver, By element)
    {
        if (driver.FindElements(element).Count > 0)
        {
            if (driver.FindElement(element).Enabled)
                return true;
            else
                return false;
        }
        else
        {
            return false;
        }
    }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: Best free (or very cheap) automation tool for Windows GUI testing? (score [72690](https://stackoverflow.com/q/1094) in 2016)

#### Question
<p>I used to use vTask Studio, but it seems they've abandoned it. No updates in almost a year.<br>
Is there are any other automation tool for Windows GUI testing?</p>

#### Answer 2 (score 12)
You can try <a href="http://sikuli.org/">Sikuli</a>. It is a image recognition tool that you can script it with Python. If the product that you are testing is fairly stable in terms of UI, then it will be a good tool to use.  

#### Answer 3 (score 8)
Windows has the built in <a href="http://msdn.microsoft.com/en-us/library/ms726294%28VS.85%29.aspx">Windows Automation API</a> available. Depending on what you want to do, it could get a little hairy using the APIs.  The <a href="http://testapi.codeplex.com">TestAPI</a> project has some nice wrappers around UIAutomation to simplify the model.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: What is the difference between "testing" and "quality assurance"? (score [70815](https://stackoverflow.com/q/211) in 2017)

#### Question
Is there a difference between `"testing"` and `"quality assurance"`?  If so, what are the main goals of each process?  What are the critical differences?  

#### Answer accepted (score 46)
There is a useful blog post explaining the historical distinctions between Quality Assurance and Quality Control.  I would suggest the latter is an appropriate alias for what we would term "testing"   

<ul>
<li><a href="http://www.testingreflections.com/node/view/827">link</a>   </li>
<li><a href="http://web.archive.org/web/20120807142038/http://www.testingreflections.com/node/view/827">archive.org link</a></li>
</ul>

In essence, the author summarizes that:  

<ul>
<li><p>Quality Assurance - Prevention of faults by inspecting &amp; testing the <strong>process</strong></p></li>
<li><p>Quality Control - Detection of faults by inspecting &amp; testing the <strong>product</strong></p></li>
</ul>

#### Answer 2 (score 23)
I would say it's best described that testing is a subset of QA.  

Your goal of <strong>testing</strong> is to ensure the functional <strong>requirements</strong> and <strong>metrics</strong> are met. This could be computational performance, clicks-per-action, user throughput, feature-completeness, defect rate, etc.  

<strong>Quality-Assurance</strong> is a broader-reaching goal that simply asks "Is the <strong>customer</strong> going to be <strong>happy</strong> with this?" Obviously, you need to meet the metrics and requirements detailed in testing in order to achieve this. But there's a certain emotional aspect that testing can't cover. Is it pretty? Is it innovative? Does it get the job done? (It can meet every requirement and still not get the job done!)  

Disclaimer: This is simply my interpretation of these two concepts. It may differ from those in the SQA community, and may differ from the majority opinion.  

Edit: I bolded three words/phrases per as a tl;dr  

#### Answer 3 (score 7)
There's no such thing as Quality Assurance or Control in Software. (Unfortunately most tester's don't seem to get this.)  

Quality Assurance and Quality Control both come from manufacturing where you can physically assure customers won't receive bad products (or rather reduce the chance they will) by withholding defective ones or fixing the process. This can be done through lean manufacturing, Six Sigma, etc. - Forgive me, I'm not up to date on process and manufacturing improvement!  

This <b>can't</b> usually be done in software. Software development is far more like design which is more intuitive and unique and less like manufacturing where you are producing the same piece over and over again. Testers have no way to assert control or assure quality. Instead of asserting control all we can do is point out the problems we find and work with developers, technical leads, etc. to fix them. Usually we can't force them to fix all of the problems, just one's deemed high enough by consensus of the team (hopefully).   

Since we can't control quality (we usually don't fix bugs), how do we assure quality? We don't! We never know how many defects are left or how severe they may be. So why use titles that don't convey true meaning?   

Software Testing means we learn and explore the system while applying our knowlege, experiences, judgements to find problems.  

Here's a <a href="http://www.developsense.com/blog/2010/05/testers-get-out-of-the-quality-assurance-business/" rel="nofollow noreferrer">good link.</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Webdriver: How to find the element using text() in xpath? (score [70612](https://stackoverflow.com/q/14788) in 2018)

#### Question
I'm new to selenium and HTML. I want to perform click operation for the elements "Users" and "Admins" as one after another. Below mentioned is the HTML code, unfortunately I can't modify it.  

<pre class="lang-html prettyprint-override"><code>&lt;ul id="nav"&gt;
&lt;li class=""&gt;
    &lt;a class="mainmenu" title="List of Users" menuid="nav_0"&gt;
        &lt;span class="title"&gt;Users&lt;/span&gt;
        &lt;span class="arrow"/&gt;
    &lt;/a&gt;
    &lt;ul class="sub-menu"&gt;
        &lt;li&gt;
            &lt;a class="mainmenu" title="List of Admins" menuid="nav_0-sub_0"&gt;Admins&lt;/a&gt;
        &lt;/li&gt;
    &lt;/ul&gt;
&lt;/li&gt;
&lt;li class=""&gt;
    &lt;a class="mainmenu" title="List of Contents" menuid="nav_1"&gt;
        &lt;span class="title"&gt;Contents&lt;/span&gt;
    &lt;/a&gt;
&lt;/li&gt;
&lt;li class=""&gt;
    &lt;a class="mainmenu" title="Repos" menuid="nav_2"&gt;
        &lt;span class="title"&gt;Repository&lt;/span&gt;
    &lt;/a&gt;
&lt;/li&gt;       
</code></pre>

  

I have used XPath like this:  

```
.//*[@id='nav']/li[1]/a[contains(@title, 'List of Users'] 
```

Any other ways to get the element like matching the text value? Because the list elements order is dynamic, so the current position of the element "Users"(`li[1]`) might get change later.  

#### Answer accepted (score 2)
As per given description, it seems that list of users will be maintained in HTML's List Item having common title=List of Users. So you can use something like below code to click on dynamic list items(here, users).  

```
List<WebElement> Userlist = driver.findElements(By.cssSelector("a[title='List of Users']");

for(WebElement ulist : Userlist)
{
    //Do your action, e.g. click() with each user name.
}
```

#### Answer 2 (score 3)
You can try creating xpath with `text()` like these:  

<ol>
<li>`//span[contains(text(),'Users')]`</li>
<li>`//span[contains(text(),'Contents')]`</li>
</ol>

#### Answer 3 (score 1)
To avoid the `li[1]`, just use this XPath. It will still work, even if one of the `li` elements swap their locations in the html file.  

```
//*[@id='nav']/li/a[contains(@title,'List of Users')]
```

If you only have one `<a>` element on the page, you could avoid the `li` part  

```
//a[contains(@title,'List of Users')]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: How to use Xpath 'contains()' function to locate a Web element in Selenium Webdriver? (score [69857](https://stackoverflow.com/q/12100) in )

#### Question
I am a beginner in learning Selenium WebDriver and XPath. I am trying to get the "`<td>`" Element of the Nested Table which Contains string '7-8-9.' Following is the HTML page code:  

```
 <!DOCTYPE html>
    <head>
    <title>Sample</title>
    </head>
    <body>
    <table border = "2">
    <tbody>
    <tr>
    <td>one</td>
    <td>two</td>
    </tr>
    <tr>
    <td>three</td>
    <td>
    <table border = 1">
    <tbody>
    <tr>
    <td>1-2-3</td>
    <td>4-5-6</td>
    </tr>
    <tr>
    <td>7-8-9</td>
    <td>10-11-12</td>
    </tr>
    </tbody>
    </table>
    </td>
    </tr>
    </tbody>
    </table>
    </body>
    </html>
```

this the test code :  

```
WebElement  cell3 =  driver.findElement(By.xpath("//table/tbody/tr[2]/td[2]/table/tbody/tr[2]/td[contains(text() , '1-2-3'))]"));

    System.out.println(cell3.getText());
```

<p>Please help!
thanks</p>

#### Answer 2 (score 3)
<p>First of all, you don't want the `xpath` to do a lot of works. So, be little bit more considerate when you the write `xpath`
You don't need to walk down the whole hierarchy to find the element with `xpath`. Relative xpath would be enough for `selenium`. Read <a href="http://www.toolsqa.com/selenium-webdriver/choosing-effective-xpath/" rel="nofollow">this</a></p>

```
//tbody//td[contains(text(),'1-2-3')]
```

#### Answer 3 (score 1)
For a quick and dirty method that will be fragile and perform poorly, but will allow you to get your test working,  open the page in Firefox, open the development tools, find the element in the source viewer, right click, and there should be an option to create an XPath query.   

Just noticed the "contains" in the question, if that's important then ignore this answer.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: Can I use Selenium to do Desktop Application testing? (score [69195](https://stackoverflow.com/q/9254) in 2016)

#### Question
Is it possible to test desktop applications using selenium? Suppose we have a simple application like gtalk. A desktop application, can we automate that application with selenium.  

#### Answer accepted (score 9)
No, Selenium 2 / WebDriver is for web applications only. But there are other tools to automate desktop application GUI tests.  

<ul>
<li><a href="http://en.wikipedia.org/wiki/List_of_GUI_testing_tools" rel="noreferrer">http://en.wikipedia.org/wiki/List_of_GUI_testing_tools</a></li>
</ul>

You can also search for "desktop application" on this site to find recommended tools.  

#### Answer 2 (score 2)
<a href="https://github.com/2gis/Winium.Desktop" rel="nofollow noreferrer">https://github.com/2gis/Winium.Desktop</a>  

Winium.Desktop is an open source test automation tool for automated testing of Windows application based on WinForms and WPF platforms. Winium.Desktop.Driver implements Selenium Remote WebDriver and listens for JsonWireProtocol commands.  

#### Answer 3 (score 2)
<a href="https://github.com/2gis/Winium.Desktop" rel="nofollow noreferrer">https://github.com/2gis/Winium.Desktop</a>  

Winium.Desktop is an open source test automation tool for automated testing of Windows application based on WinForms and WPF platforms. Winium.Desktop.Driver implements Selenium Remote WebDriver and listens for JsonWireProtocol commands.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: selenium.ElementNotVisibleException: Element is not currently visible (score [68229](https://stackoverflow.com/q/12141) in 2015)

#### Question
I am working on selenium, while running Java code I tried to access a text box from the web page but `selenium.ElementNotVisibleException: Element is not currently visible and so may not be interacted with Command duration or timeout error`.  

HTML code for text field :  

```
 <input style="width: calc(99% - 20px);" class="edit-box eb-big" id="edit-box-big" name="title" placeholder="Job Title *" type="text">
```

JAVA Code to access text field :  

```
driver.findElement(By.name("title")).click();
driver.findElement(By.name("title")).clear();
driver.findElement(By.name("title")).sendKeys("Job Title");
```

Error Tree :  

```
org.openqa.selenium.ElementNotVisibleException: Element is not currently visible and so may not be interacted with
Command duration or timeout: 30.04 seconds
Build info: version: '2.44.0', revision: '76d78cf', time: '2014-10-23 20:03:00'
System info: host: 'Rajesh-PC', ip: '192.168.0.149', os.name: 'Windows 7', os.arch: 'amd64', os.version: '6.1', java.version: '1.8.0_31'
Driver info: org.openqa.selenium.firefox.FirefoxDriver
Capabilities [{applicationCacheEnabled=true, rotatable=false, handlesAlerts=true, databaseEnabled=true, version=35.0.1, platform=WINDOWS, nativeEvents=false, acceptSslCerts=true, webStorageEnabled=true, locationContextEnabled=true, browserName=firefox, takesScreenshot=true, javascriptEnabled=true, cssSelectorsEnabled=true}]
```

I also tried accessing element using xpath, name and css selector but every time I am getting same message.  

Additional html code.  


    
        
            
        
        
            <h5></h2>
            
        
    </p>

```
<!-- card body -->
<div class="card-body inl-blck"></div>

<div class="logo-card-content" name="logo-card-content">

</div>

<div class="body-content" name="body-content"></div>

<input class="edit-box eb-big" id="edit-box-big" name="input-name" type="text" placeholder="Text Box" />

<input class="edit-box" id="empty-edit-box" type="text" placeholder="Text Box" />

<a class="expand-but more-but" id="job-desc-more" name="more-button">More</a>
<a class="expand-but less-but" id="job-desc-less" name="less-button">Less</a>

<div class="key-value" id="key-val-card">
    <div class="card-col-1" name="key"></div>
    <div class="card-col-2" name="value"></div>
</div>

<div class="tags" name="tags"></div>

<div class="slider" id="slider">
    <div class="slider-name" name="slider-name"></div>
    <div class="slider-align">
        <div class="slider-value"></div>
        <div id="slider-type" name="slider-type"></div>
        <div class="slider-value" id="experience-max"></div>
    </div>
</div>

<div class="card-body-title"></div>

<div class="title-card-body" name="title-card-body"></div>

<div class="expandable-list" id="expandable_list">
    <ul class="el-ul">
        <li>
            <div class="el-item" name="el-item">
                <h4 class="el-title" name="card-title"></h4> <h4 class="el-title" name="card-title2"></h4>
                <!-- <span class="el-date light-font" name="card-title-right"></span> 
                <span class="el-date light-font" name="card-title-right_2"></span> -->
```

Inner Section on Div.  



    
    
    
    
    
    
    
    
    





  





    

    
        
        
            
                //here's code for textbox which i would like to access.
                
                
                
            
        
    
    
    
    
    
    
        
    


#### Answer accepted (score 4)
This often happens when there are multiple elements that match your search and one of them is hidden and the other is not.  If it finds the element that is hidden, you will get this error.  I would search through the DOM for any other element with the name "title".  You may need to provide additional information to ensure the identifier is unique and finds only a single element, or use findElements and then select the correct one from the collection.  

An easy way to check if there are multiple elements is to use this in the console tab of the developer tools for your browser, this is the CSS selector for name=title:   

```
$("[name='title']")
```

If it returns multiple elements, you know this is the problem.  If not, let me know and maybe provide the entire (or more) html and I can help figure out what is going on.  

#### Answer 2 (score 0)
Check if:  

<ul>
<li>element is visible in your viewport, if not, try calling <a href="http://selenium-python.readthedocs.org/en/latest/api.html#selenium.webdriver.remote.webdriver.WebDriver.maximize_window" rel="nofollow noreferrer">maximize_window()</a> in order to maximize the current window that webdriver is using,</li>
<li>your element is not appearing twice (under the same selector), and you're selecting the wrong one,</li>
<li>if your element is hidden, then consider making it visible,</li>
<li>if you'd like to change value of hidden element, then use <a href="https://sqa.stackexchange.com/q/3387/2840">`driver.execute_script()`</a> to achieve that.</li>
</ul>

This basically happens, because Selenium is designed to imitate user interaction, so you can't access/change element that normally the user cannot interact with.  

#### Answer 3 (score 0)
Check if:  

<ul>
<li>element is visible in your viewport, if not, try calling <a href="http://selenium-python.readthedocs.org/en/latest/api.html#selenium.webdriver.remote.webdriver.WebDriver.maximize_window" rel="nofollow noreferrer">maximize_window()</a> in order to maximize the current window that webdriver is using,</li>
<li>your element is not appearing twice (under the same selector), and you're selecting the wrong one,</li>
<li>if your element is hidden, then consider making it visible,</li>
<li>if you'd like to change value of hidden element, then use <a href="https://sqa.stackexchange.com/q/3387/2840">`driver.execute_script()`</a> to achieve that.</li>
</ul>

This basically happens, because Selenium is designed to imitate user interaction, so you can't access/change element that normally the user cannot interact with.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: What do I need to start from zero in automated testing? (score [67984](https://stackoverflow.com/q/6742) in 2013)

#### Question
I am new to testing. I need to learn because I have an opportunity to work in this field in the the future. I would like to know what I need to get started. Preferably, I would like to study automated testing. How much time will it take for someone who only knows a little programming and no testing?  

Tools, tutorials, courses (free or YouTube), all information is welcome. In the beginning, I only need to learn the basics, not be an expert.  

#### Answer 2 (score 7)
There are a ton of websites and blogs devoted to testing. You could start there.  

A quick search using Google for something like "software testing" would also be a good way to get started.  

You might choose to start with The Association for Software Testing: <a href="http://www.associationforsoftwaretesting.org/">http://www.associationforsoftwaretesting.org/</a> They have excellent reading and training resources.  

Other useful sites are <a href="http://www.sqaforums.com">http://www.sqaforums.com</a> and <a href="http://www.softwaretestingclub.com/">http://www.softwaretestingclub.com/</a> and of course here at SQA Stack Exchange.  

If you go to my blog at <a href="http://www.allthingsquality.com/">http://www.allthingsquality.com/</a> and click the "What People Are Writing" tab, you'll see a list of recent entries from blogs related to QA and Testing.  

Good luck.  

#### Answer 3 (score 4)
You need to learn many things before being able to work in test automation.  

The skills are ordered from 1 to 13 so that it is easy to understand how they develop:  

13 Test Automation (basic skills)  

12 Learn Page Object Model  

11 Learn Object Oriented Programming in Java  

10 Learn the WebDriver framework  

9 Learn JUNIT                                                              

8 Learn the Java basics  

7 Learn Eclipse  

6 Learn how to create XPATH locators  

5 Use browser plugins (Firebug, Firepath, FireCookie)                       

4 Learn HTML and CSS  

3 Read how the HTTP protocol works, get and post requests  

2 Understand how browsers work  

1 Manual Testing  

<a href="http://test-able.blogspot.ca/2015/08/how-to-learn-test-automation-with-selenium.html" rel="nofollow" title="How To Learn Test Automation With Selenium">See more details on this article: "How to Learn Test Automation With Selenium" on test-able.blogspot.ca</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How to send Basic Authentication headers in Selenium? (score [67482](https://stackoverflow.com/q/12892) in 2017)

#### Question
I'm using `webdriver.Firefox` and I'm trying to send the following custom header:  

```
self.headers = { 'Authorization': 'Basic %s' % b64encode(bytes(self.args.user + ':' + self.args.password, "utf-8")).decode("ascii") }
```

in the following way:  

```
self.driver.get(self.base_url + "/", headers=self.headers)
```

which is similar way as shown <a href="https://stackoverflow.com/q/19524069/55075">here</a>, but I'm guessing it's using completely different driver.  

However I've the error:  

```
TypeError: get() got an unexpected keyword argument 'headers'
```

I've checked the old issue <a href="https://code.google.com/p/selenium/issues/detail?id=2047" rel="nofollow noreferrer">#2047: How to add a header to a request?</a>, but it's closed as duplicate of another <em>Won't Fix</em> issue.  

<strong>Is there any way of simply test the site using Selenium which is behind Basic Authentication?</strong>  

One suggestion is to <a href="http://blog.mogotest.com/2010/06/23/how-to-perform-basic-auth-in-selenium/" rel="nofollow noreferrer">use proxy</a>, however I don't believe such simple functionality doesn't exist.  

Any suggestions?  

#### Answer accepted (score 11)
I've tested using format `http://user:pass@host` and it works.  

So in Python (in `setUp() of MyClass(unittest.TestCase)` class) this should look like:  

```
self.base_url = "http://user:pass@host"
```

In Java based on <a href="https://code.google.com/p/selenium/issues/detail?id=34" rel="nofollow noreferrer">#34 at code.google</a>, the following code should work as well:  

```
public void login(String username, String password){
    WebDriver driver = getDriver();
    String URL = "http:// + username + ":" + password + "@" + "link";
    driver.get(URL);
    driver.manage().window().maximize();
}
```

or:  

```
FirefoxProfile profile = new FirefoxProfile();
profile.setPreference("network.http.phishy-userpass-length", 255);
driver = new FirefoxDriver(profile);
driver.get(http://username:password@www.basicauthprotected.com/);
```

or:  

```
FirefoxProfile profile = new FirefoxProfile();
profile.setPreference("network.http.phishy-userpass-length", 255);
profile.setPreference("network.automatic-ntlm-auth.trusted-uris", "<host>");
driver = new FirefoxDriver();
selenium = new WebDriverBackedSelenium(driver, "http://<user>:<password>@<host>");
```

or:  

```
selenium.start("addCustomRequestHeader=true");
selenium.windowMaximize();
selenium.addCustomRequestHeader( "Authorization","Basic "+"YWRpZGFzOmFkaWRhczEyMyM=" );
```

or eventually by sending keys using `SendKeys()`:  

```
SendKeys("myUser");
SendKeys("{TAB}");
SendKeys("MyPassword");
SendKeys("~"); // Enter
```

or by using <a href="http://seleniumhq.github.io/selenium/docs/api/java/org/openqa/selenium/Alert.html" rel="nofollow noreferrer">Alert</a> API.  

See also: <a href="https://stackoverflow.com/q/5672407/55075">Basic Authentication for FirefoxDriver, ChromeDriver and IEdriver?</a>  

For Chrome, please follow: <a href="https://stackoverflow.com/q/9888323/55075">How to override basic authentication in selenium2 chrome driver?</a>  

However each one of above has some downsides, so the feature needs to be more portable and there are some plans to do that (see: <a href="https://github.com/SeleniumHQ/selenium/issues/453" rel="nofollow noreferrer">#453 at GitHub</a>).  

#### Answer 2 (score 2)
I would like to add one more point:   

If your application is making AJAX requests then this solution will not work directly. The HTTP authentication prompt will be shown. In order to bypass that what can be done is from the test case directly fire the URL for which the Ajax request will be sent by the application later. This will create the HTTP authorization header which will be carried in all subsequent requests including the Ajax requests and the authentication prompt will not be shown thus enabling smooth execution of the test case.   

#### Answer 3 (score 0)
What I did for FirefoxDriver is this approach (this only uses for the base url, not for any further requests to other sites which may require basic authentification):  

<ul>
<li>configuring Firefox not to ask/warn about logging in with basic auth</li>
<li>Passing user and password with the URL: `http://user:pass@host.tld`</li>
</ul>

See <a href="http://paul.wellnerbou.de/2017/07/12/basic-auth-with-geb-and-firefoxdriver/" rel="nofollow noreferrer">here</a> or my <a href="https://github.com/geb/geb-example-gradle/pull/28" rel="nofollow noreferrer">pull request</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: WebDriver: find elements by text (score [67246](https://stackoverflow.com/q/2485) in 2012)

#### Question
I know that WebDriver can locate <em>links</em> through their text, using `find_element_by_link_text` or `find_element_by_partial_link_text`.  

Is it possible to locate any element (such as `li`, `div`, `span`, ...) by text?  

#### Answer accepted (score 19)
Yes.  WebDriver supports using an XPath to locate an element by the text it contains.  For example, the following XPath locates any div containing the string "Hello Justin":  

```
//div[contains(.,'Hello Justin')]
```

#### Answer 2 (score 2)
As User246 mentioned, the xpath support depends on the browser.  I have found a few problems with using XPath cross-browser.  My solution for this problem was to find elements by tag name first, then iterate through the list of elements matching the tag and look for the attributes that I want to match on as well.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How to find element by class name or xPath? (score [66451](https://stackoverflow.com/q/20724) in 2018)

#### Question
<p><a href="https://i.stack.imgur.com/gRNOp.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/gRNOp.png" alt="enter image description here"></a>  I have problems with finding this element: 
 
I tried these finders:</p>

```
IWebElement profilUploadPhoto = driverGC.FindElement(By.XPath("//button[contains(.,'submit')]"));

IWebElement profilUploadPhoto = driverGC.FindElement(By.XPath("//button[contains(.,'btn btn-success')]"));

IWebElement profilUploadPhoto = driverGC.FindElement(By.ClassName("btn btn-success"));

IWebElement profilUploadPhoto = driverGC.FindElement(By.ClassName("glyphicon glyphicon-upload"));
```

I am usually finding elements by CSS selector or ID, but in this case, I can not do this.  

#### Answer accepted (score 3)
can you please try the options below:  

By Xpath:   

```
button[@type='submit']
button[@class='btn btn-success']
button[@type='submit'][@class='btn btn-success']
```

By css selector:  

```
button[type='submit']
button[class='btn btn-success']
button[type='submit'][class='btn btn-success']
```

Any one expression above should locate this element, please tell me if it still does not work.  

#### Answer 2 (score 2)
If the class name is unique in the page then you can use the class name.  

Keep in mind that the class name might not select the selector you need if there are multiple elements with the same class.  

As an alternative check if you have other unique attributes for which you have a method or use a css/Xpath selector.  

If you don't have any other attributes i suggest trying css selector and if you have no luck then Xpath.  

#### Answer 3 (score 1)
My approach would be something along the lines of:  

```
WebElement yourElement
List<WebElement> Elements = driver.findElements(By.tagName("span"));
for(int Counter = 0; Counter < Elements.size(); Counter++){
     if(Elements.get(Counter).getAttribute("class").contains("glyphicon") &&
        Elements.get(Counter).getAttribute("aria-hidden").equals("true")){
          yourElement = Elements(Counter);
          break;
     }
}
```

It allows you to make sure that you've got the exact `Element` you need by adding statements to the boolean equation within the `if` argument. It might be overkill, but at the very least it's a safe approach.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: How FluentWait is different from WebDriverWait? (score [66026](https://stackoverflow.com/q/12866) in 2015)

#### Question
<p>How is the FluentWait is different from WebDriverWait?
I am using WebDriverWait having the polling interval set to : 500 miliseconds. Still, WebDriverWait returns after some delay (i.e. 2 - 3 seconds after the element load is completed)? Any opinion here?</p>

#### Answer 2 (score 19)
<p><strong>Implicit Wait:</strong>
An implicit wait is to tell WebDriver to poll the DOM for a certain amount of time when trying to find an element or elements if they are not immediately available. The default setting is 0. Once set, the implicit wait is set for the life of the WebDriver object instance.</p>

```
WebDriver driver = new FirefoxDriver();
driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
driver.get("http://somedomain/url_that_delays_loading");
WebElement myDynamicElement = driver.findElement(By.id("myDynamicElement"));
```

<strong>When to use:</strong>  Not recommended  

<p><strong>Explicit wait:</strong>
An explicit waits is code you define to wait for a certain condition to occur before proceeding further in the code. WebDriverWait by default calls the ExpectedCondition every 500 milliseconds until it returns successfully.</p>

```
WebDriver driver = new FirefoxDriver();
driver.get("http://somedomain/url_that_delays_loading");
WebElement myDynamicElement = (new WebDriverWait(driver, 10))
  .until(ExpectedConditions.presenceOfElementLocated(By.id("myDynamicElement")));
```

<strong>When to use:</strong>  If element takes a long time to load. Also, used to check property of an element (presence, clickability. etc).   

<p><strong>FluentWait</strong>:
For each FluentWait instance, you can specify:</p>

<ol>
<li>Frequency with which FluentWait has to check the conditions defined.</li>
<li>Ignore specific types of exception waiting such as NoSuchElementExceptions while searching for an element on the page.</li>
<li>Maximum amount of time to wait for a condition</li>
</ol>

<strong>When to use FluentWait</strong>: When you try to test the presence of an element that may appear after every x seconds/minutes (Just an example, this is my guess of where such a thing can be used).  

```
// Waiting 30 seconds for an element to be present on the page, checking
// for its presence once every 5 seconds.
Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
    .withTimeout(30, SECONDS)
    .pollingEvery(5, SECONDS)
    .ignoring(NoSuchElementException.class);

WebElement foo = wait.until(new Function<WebDriver, WebElement>() 
{
  public WebElement apply(WebDriver driver) {
  return driver.findElement(By.id("foo"));
}
});
```

#### Answer 3 (score 2)
Implicit wait: Implicit wait tells web driver to wait on every instance when try to find  element.  It is like global wait for all driver.findelement instance. It will force web driver to wait until element is appeared on page or defined time whatever is earliest. Drawback is it throws exception when element is not loaded on page even in defined time span.  

<strong>Explicit wait:</strong> Explicit wait is of two types:  

1) WebDriverWait  

2) FluentWait  

both are classes and implements Wait interface.  

WebDriverWait is applied on certain element with defined expected condition and time. This wait is only applied to the specified element. This wait can also throw exception when element is not found.  

```
WebDriverWait wait = new WebDriverWait (driver, 20);
wait.until(ExpectedConditions.VisibilityofElementLocated(By.xpath(""//button[@value='Save Changes']"")));
```

<strong>Fluent wait:</strong> Fluent wait is another type of Explicit wait and you can define polling and ignore the exception to continue with script execution in case element is not found.  

```
new FluentWait<WebDriver>(driver).withTimeout(30, TimeUnit.SECONDS).pollingevery(10, TimeUnit.SECONDS).ignoring(NoSuchElementException.class);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: How to compare values from the list or from dropdown list in webdriver (Java)? (score [65359](https://stackoverflow.com/q/7868) in 2014)

#### Question
Below is my code and html code, please let me know how to compare values. When i executed i am getting same result (Mateched) for multiple times. But i want to compare and display result as "Matched" (Only for one time).  

```
public class Ex1 {
private WebDriver d;
@Test
public void testUntitled() throws Exception {
d = new FirefoxDriver();
d.get("http://register.rediff.com/commonreg/index.php?redr=http://portfolio.rediff.com/money/jsp/loginnew.jsp?redr=home");

String[] exp = {"Month", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"}; 
WebElement dropdown = d.findElement(By.id("date_mon"));  
        Select select = new Select(dropdown);  

        List<WebElement> options = select.getOptions();  
        for(WebElement we:options)  
        {  
         for (int i=0; i<exp.length; i++){
             if (we.getText().equals(exp[i])){
             System.out.println("Matched");
             } 
           }
         }  }}
```

Output:  

```
Mateched
Mateched
Mateched
Mateched
Mateched
Mateched
Mateched
Mateched
Mateched
Mateched
Mateched
Mateched
Mateched 
```

Html:  

```
select id="date_mon" onfocus="validateSignupForm(3)" name="date_mon">
<option value="">Month</option>
<option value="01">JAN</option>
<option value="02">FEB</option>
<option value="03">MAR</option>
<option value="04">APR</option>
<option value="05">MAY</option>
<option value="06">JUN</option>
<option value="07">JUL</option>
<option value="08">AUG</option>
<option value="09">SEP</option>
<option value="10">OCT</option>
<option value="11">NOV</option>
<option value="12">DEC</option>
```

#### Answer accepted (score 9)
The reason you are getting so many different matched is because you print it as you go through the loop. My personal suggestion, I like the KISS method, change the code to something like the following:  

```
public class Ex1 {

private WebDriver d;

@Test
public void testUntitled() throws Exception {
    d = new FirefoxDriver();
    d.get("http://register.rediff.com/commonreg/index.php?redr=http://portfolio.rediff.com/money/jsp/loginnew.jsp?redr=home");

    int count = 0;
    String[] exp = {"Month", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
    WebElement dropdown = d.findElement(By.id("date_mon"));
    Select select = new Select(dropdown);

    List<WebElement> options = select.getOptions();
    for (WebElement we : options) {
        for (int i = 0; i < exp.length; i++) {
            if (we.getText().equals(exp[i])) {
                count++;
            }
        }
    }
    if (count == exp.length) {
        System.out.println("matched");
    } else {
        System.out.println("Houston, we have a problem.");
    }
}
}
```

This will just count the amount of matches and then if the total is the total count for the length.   

What I changed on your code:  

Added `int count = 0;`  

changed `System.out.println("Matched");` to `count++;`  

added:  

```
if (count == exp.length) {
    System.out.println("matched");
} else {
    System.out.println("Houston, we have a problem.");
}
```

Per the discussion in the comments, I created a function to perform this  

```
public boolean compareElements(String a,List<WebElement> b) {
    for (WebElement we:b) {
        if (a.equalsIgnoreCase(we.getText())) {
            return true;
        }
    }
    return false;
}
```

Example usage:  

```
for (String e:exp) {
    if (compareElements(e,we)) {
        //code for if it was found
    } else {
        //code if it's not found
    }
}
```

#### Answer 2 (score 0)
```
public class Ex1 {
private WebDriver d;
@Test
public void testUntitled() throws Exception {
d = new FirefoxDriver();
d.get("http://register.rediff.com/commonreg/index.php?redr=http://portfolio.rediff.com/money/jsp/loginnew.jsp?redr=home");

String[] exp = {"Month", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"}; 
WebElement dropdown = d.findElement(By.id("date_mon"));  
        Select select = new Select(dropdown);  

        List<WebElement> options = select.getOptions();
        loop:  
        for(WebElement we:options)  
        {  
         for (int i=0; i<exp.length; i++){
             if (we.getText().equals(exp[i])){
             System.out.println("Matched");
             break loop;
             } 
          }
        }  
      }
    }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Webdriver : How to perform scroll down an element (example div) using selenium? (score [64651](https://stackoverflow.com/q/14837) in 2015)

#### Question
The Scroll element in the page is actually a div with scroll bound to it. Here is the HTML snippet.  

```
<div class="slimScrollBar" style="background: none repeat scroll 0% 0%  rgb(137, 137, 137); width: 12px; position: absolute; border-radius: 0px; z-index: 99; right: 1px; top: -13px; opacity: 0.6; height: 224.835px; display: block;"/> 
```

I have tried with the following code, but it didn't  work out  

```
WebElement scrollArea = driver.findElement(By.cssSelector("div.slimScrollBar"));
JavascriptExecutor js = (JavascriptExecutor) driver; 
js.executeScript("arguments[0].scrollTop = arguments[1];",scrollArea, 250); 
Thread.sleep(1000); 
```

Help is appreciated!  

#### Answer 2 (score 4)
For   <strong>Scroll down</strong>:  

```
WebDriver driver = new FirefoxDriver();
JavascriptExecutor jse = (JavascriptExecutor)driver;
jse.executeScript("window.scrollBy(0,250)", "");
```

or, you can do as follows:  

```
jse.executeScript("scroll(0, 250);");
```

For <strong>Scroll up</strong>:  

```
jse.executeScript("window.scrollBy(0,-250)", "");
```

OR,  

```
jse.executeScript("scroll(0, -250);");
```

#### Answer 3 (score 3)
Some HTML page have internal (custom) scroll bar. We have to handle with little bit different way.  

Javascript is not working here.   

<strong>Solution :</strong>  

```
WebElement scrollArea = driver.findElement(By.cssSelector("div.slimScrollBar"));
```

Create method <strong>scroll_Page</strong> as given below.  

Call this method as `scroll_Page(scrollArea ,100);`  

Where <strong>scrollArea</strong> is your dragged(scroll) element and <strong>100</strong> is scroll points.  

```
public static boolean scroll_Page(WebElement webelement, int scrollPoints)
{
    try
    {               
        Actions dragger = new Actions(driver);
        // drag downwards
        int numberOfPixelsToDragTheScrollbarDown = 10;
        for (int i = 10; i < scrollPoints; i = i + numberOfPixelsToDragTheScrollbarDown)
        {
            dragger.moveToElement(webelement).clickAndHold().moveByOffset(0, numberOfPixelsToDragTheScrollbarDown).release(webelement).build().perform();
        }
        Thread.sleep(500);
        return true;
    }
    catch (Exception e)
    {
        e.printStackTrace();
        return false;
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: How can I reduce the execution speed in webdriver so that I can view properly what is happening on browser? (score [63724](https://stackoverflow.com/q/8451) in 2014)

#### Question
I want to reduce the speed for execution of script so that I can view the execution properly on browser. I want do this in webdriver.   

#### Answer accepted (score 9)
You can try setting implicit wait time. (<a href="http://selenium.googlecode.com/git/docs/api/java/org/openqa/selenium/WebDriver.Timeouts.html">Documentation</a>)    

```
// 5 seconds implicit wait (C# code)
IWebDriver driver = new FirefoxDriver();
driver.Manage().Timeouts().ImplicitlyWait(TimeSpan.FromSeconds(5));
```

#### Answer 2 (score 9)
This is how I would debug a Selenium session to find out what is happening:  

<strong>Step-by-step debugging</strong>: Most <a href="http://en.wikipedia.org/wiki/Integrated_development_environment" rel="nofollow noreferrer">IDE's</a> allow you todo step-by-step debugging, you could set a break point just before the point you want to investigate. This will pause the execution of the test and lets you examine the browser with its own tools. You can step thru each line of code one by one and monitor the behavior. See <a href="https://www.youtube.com/watch?v=AudbOfamfwc" rel="nofollow noreferrer">this video for example</a>  

<strong>Video recording</strong>: Record the test session with a screen-recorder or use one of the online Selenium grids like <a href="https://saucelabs.com/" rel="nofollow noreferrer">Sauce labs</a> or <a href="http://testingbot.com/" rel="nofollow noreferrer">TestingBot</a>, both offer to record of the test session by default and give enough free minutes to analyze most issues. After the recording, you can playback frame by frame.  

<strong>Sleeps</strong>: Like others suggest, you can add a sleep or increase the default wait-times. Personally, I am not a fan of this because you might need to rerun the test a couple of times if the sleep is not long enough.  

#### Answer 3 (score 1)
I've been looking into this quite a lot over the past few days. By far the simplest way to solve this is to create a driver property, rather than a variable and add a wait to the get.  

```
  private IWebDriver _driver;
    public IWebDriver driver
    {
        get{ Thread.Sleep(500);
            return _driver;
        }

        set
        { _driver = value; }
    }
```

This means that anytime your driver is requested, which is anytime you do anything in the browser, it will slow it down by the specified amount.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: Locating element by link text (anchor tag innerHTML) or xpath fails in Selenium 2.0 Webdriver (score [61610](https://stackoverflow.com/q/2414) in 2012)

#### Question
I'm using Selenium 2.0 web driver.  My script keeps failing whenever I try locating something in my page.  It throws an exception whether I locate the element by LinkText or by XPath.  

```
driver.FindElement(By.LinkText("Products")).Click();

Selenium.ProductPricing.TheUntitledTest:
OpenQA.Selenium.NoSuchElementException : Unable to locate element: {"method":"link text","selector":"Products"}

driver.FindElement(By.XPath("//div[@id='nav']/ul/li[1]/a")).Click();

Selenium.ProductPricing.TheUntitledTest:
OpenQA.Selenium.NoSuchElementException : Unable to locate element: {"method":"xpath","selector":"//div[@id='nav']/ul/li[0]/a"}
```

#### Answer accepted (score 1)
Seems like I have to use this line of code before I invoke any click events.  The "clickAndWait" conversion of the Selenium IDE to Webdriver doesn't seem to work properly.  It converts everything to *.Click().  Adding the implicit wait after every click event and setting WAIT_TIME to 3 in my Constants class seems to do the trick.  

```
driver.FindElement(By.CssSelector("input[type=\"submit\"]")).Click();
driver.Manage().Timeouts().ImplicitlyWait(TimeSpan.FromSeconds(Constants.WAIT_TIME));
driver.FindElement(By.LinkText("Products")).Click();
driver.Manage().Timeouts().ImplicitlyWait(TimeSpan.FromSeconds(Constants.WAIT_TIME));
```

#### Answer 2 (score 5)
XPath list indexes are one-based, not zero-based. Try `li[1]`.  

#### Answer 3 (score 1)
A few things to look at.    

<ol>
<li>Are you sure that the LinkText is correct?  Are you missing spaces,
non breaking spaces, etc that may appear in the html but you don't
see as a user?</li>
<li>Are you sure the xpath is correct?</li>
<li>Is this a timing issue?  Are you trying to find the elements before the page is
finished loading or before those elements are loaded?</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: Not able to scroll down page using Selenium webdriver (score [61277](https://stackoverflow.com/q/9655) in 2015)

#### Question
I want to scroll down a page that is coming inside a form, not on the main page.   

I tried this code:  

```
JavascriptExecutor jse = (JavascriptExecutor)driver;
jse.executeScript("window.scrollBy(0,250)", "");
```

<img src="https://i.stack.imgur.com/FAlon.png" alt="enter image description here">  

The above code is not able to pick the scroll bar as it is not in the main page  

#### Answer 2 (score 10)
Please use below code.  

```
driver.get("http://www.flipkart.com/");
driver.manage().window().maximize();
driver.findElement(By.linkText("Trimmer")).click();
WebElement scroll = driver.findElement(By.id("brand"));
scroll.sendKeys(Keys.PAGE_DOWN);
```

#### Answer 3 (score 2)
I would suggest using the ActionChains (Actions in Java) class to do so. I tested the above code in both FF and Chrome and I am able to scroll down using the `Keys.PAGE_DOWN` keystroke.  

```
    driver.get('http://flipkart.com/')

    driver.find_element_by_link_text('Bath Towels').click()



    WebDriverWait(driver,15).until(expected_conditions.presence_of_element_located((By.ID,"offertags")))


    act= ActionChains(driver)
    act.move_to_element(driver.find_element_by_id('offertags')).click()
    act.send_keys(Keys.PAGE_DOWN).perform()
```

I first used the `click( )` method to click on the webelement and then sent the key stroke.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Is it possible to stop page loading on the browser using selenium web-driver? (score [61182](https://stackoverflow.com/q/5663) in 2013)

#### Question
I searched online, but couldn't find anything about how to stop page loading over a browser using `selenium web-driver`.   

Any idea for the same?  

#### Answer 2 (score 9)
This might be useful.  

```
driver.findElement(By.tagName("body")).sendKeys("Keys.ESCAPE");
```

OR  

```
JavascriptExecutor js = (JavascriptExecutor) driver;
js.executeScript("return window.stop");
```

#### Answer 3 (score 5)
If you are using firefox then you can set preference for default timeout:  

```
fp = webdriver.FirefoxProfile()
fp.set_preference("http.response.timeout", 5)
fp.set_preference("dom.max_script_run_time", 5)
driver = webdriver.Firefox(firefox_profile=fp)

driver.get("http://www.google.com/")
```

This will stop page load after 5 seconds.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: What is Selenium's default timeout for page loading? (score [60109](https://stackoverflow.com/q/2606) in 2012)

#### Question
I am using Selenium 2. I have loaded the page using Get command in WebDriver class which is in the package `org.openqa.selenium`. My question is that what is Selenium's default timeout for page loading?  

#### Answer 2 (score 18)
The default `WebDriver` setting for timeouts is never.  `WebDriver` will sit there forever waiting for the page to load.  

The following timeouts are available:  

```
  /**
   * An interface for managing timeout behavior for WebDriver instances.
   */
  interface Timeouts {

    /**
     * Specifies the amount of time the driver should wait when searching for an element if it is
     * not immediately present.
     * <p/>
     * When searching for a single element, the driver should poll the page until the element has
     * been found, or this timeout expires before throwing a {@link NoSuchElementException}. When
     * searching for multiple elements, the driver should poll the page until at least one element
     * has been found or this timeout has expired.
     * <p/>
     * Increasing the implicit wait timeout should be used judiciously as it will have an adverse
     * effect on test run time, especially when used with slower location strategies like XPath.
     * 
     * @param time The amount of time to wait.
     * @param unit The unit of measure for {@code time}.
     * @return A self reference.
     */
    Timeouts implicitlyWait(long time, TimeUnit unit);

    /**
     * Sets the amount of time to wait for an asynchronous script to finish execution before
     * throwing an error. If the timeout is negative, then the script will be allowed to run
     * indefinitely.
     * 
     * @param time The timeout value.
     * @param unit The unit of time.
     * @return A self reference.
     * @see JavascriptExecutor#executeAsyncScript(String, Object...)
     */
    Timeouts setScriptTimeout(long time, TimeUnit unit);

    /**
     * Sets the amount of time to wait for a page load to complete before throwing an error.
     * If the timeout is negative, page loads can be indefinite.
     *
     * @param time The timeout value.
     * @param unit The unit of time.
     * @return
     */
    Timeouts pageLoadTimeout(long time, TimeUnit unit);
  }
```

You can tweak the timeouts by setting `driver.manage().timeouts().pageLoadTimeout()`  

More information here:  

<a href="http://selenium.googlecode.com/svn/trunk/docs/api/java/org/openqa/selenium/WebDriver.Timeouts.html">Selenium Wiki</a>  

#### Answer 3 (score 4)
Apparently there is a timeout. It is 30 minutes long.  

```
SEVERE: Timed out waiting for page load.
Command duration or timeout: 1800.01 seconds
Build info: version: '2.40.0', revision: 'fbe29a9', time: '2014-02-19 20:55:11'
System info: host: 'PurpleMimosa.local', ip: '10.11.11.131', os.name: 'Mac OS X', os.arch: 'x86_64', os.version: '10.9.2', java.version: '1.7.0_51'
Session ID: 11e6b0f4-15f2-7d48-8dbc-2176def7e41f
Driver info: org.openqa.selenium.firefox.FirefoxDriver
Capabilities [{platform=MAC, acceptSslCerts=true, javascriptEnabled=true, cssSelectorsEnabled=true, databaseEnabled=true, browserName=firefox, handlesAlerts=true, browserConnectionEnabled=true, webStorageEnabled=true, nativeEvents=false, rotatable=false, locationContextEnabled=true, applicationCacheEnabled=true, takesScreenshot=true, version=29.0.1}]
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: What Concepts of Java do i need to learn to use Selenium Webdriver? (score [59701](https://stackoverflow.com/q/9584) in )

#### Question
I want to learn Selenium WebDriver automation using Java. I have done manual testing before and want to learn automation. I just know the basics of Core Java.   

Could you please suggest me the Core topics which one would require to perform test automation using Selenium WebDriver?   

What topics on which a tester must concentrate and what topics to ignore in java programming?  

#### Answer 2 (score 7)
<strong>Java</strong>  

My experience is, that the basics of Java suffice to start developing test cases with Selenium 2 / WebDriver. Myself started developing of Selenium test cases with a basic knowledge about Java. The more test cases I wrote and solutions I had to find, the more I leaned about the programming language.  

<strong>Unit Testing Framework (<a href="http://junit.org/">JUnit</a>, <a href="http://testng.org/doc/index.html">TestNG</a>)</strong>  

Write some simple unit tests (without Selenium) to learn the basics of the unit testing frameworks and read the documentation. The more complicated stuff of the framework comes automatically by writing tests with Selenium 2 / WebDriver.  

<strong><a href="http://maven.apache.org/">Apache Maven</a></strong>  

Apache Maven is an Build Management Tool. It can manage dependencies (libraries). But it is also very useful for testing stuff. It exists plugins to create test reports, run tests in parallel or configure the test runs.  

#### Answer 3 (score 1)
The answer to this depends on what level of coding do you wish to do? How complex will your test script be?   

To begin with you might want to learn basic/core java and then keep on improving with practice and seeking help from others to put together complex scripts to test complex software.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: Using Selenium (C#) how do I select an item from a drop-down list (score [58847](https://stackoverflow.com/q/6601) in )

#### Question
I'm using the Selenium IDE to record my initial tests and then export them to c# and then use the webdriver.  Some things that I do from the IDE don't export.    

I am trying to select a State from a drop-down text list.  I don't have much background in HTML and am kind of new to C# also (I've programmed for a couple semesters in Java so far, c# for about a month.)  How would I go about selecting a specific state from the dropdown list?    

#### Answer accepted (score 5)
I'm assuming you're using Firefox?  Right-click the drop-down list and select "Inspect Element".  Get the tag from the information (everything in green following the pound sign).  Then add this to your code where you need to select the element  

```
new SelectElement(driver.FindElement(By.Id("{put your tag information here}"))).SelectByText("{State here}");
```

#### Answer 2 (score 1)
Added to Darain, use Xpath(absolute) for locate element. To get that, use fire path(with fire bug). You will get a xpath for each element.Fire path provides Xpath accurately(some time I get xpath is not working which I get from IDE). You can maintain your own array to get element from drop down by recognizing absolute xpath string. Best idea is to get all elements at a time and use particular one when you need.   

#### Answer 3 (score 0)
First you have to locate the web-element uniquely presented as select list on UI, you can use Firebug for that to find list element's id, name, xpath or css path. Then create SelectElement object passing this element locator attribute. To select an option in the list, you can choose any option like SelectByValue or SelectByText.  

```
using OpenQA.Selenium;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Support.UI;

class SelectingOption
{
    static void Main(string[] args)
    {
        IWebDriver driver = new FirefoxDriver();    //Launch Firefox browser
        driver.Navigate().GoToUrl("http://www.abc.com/"); //Go to application URL

        //Authentication and navigation code to page where select list there

        SelectElement se = new SelectElement(driver.FindElement(By.id("select_element_id"))); //Locating select list
        se.SelectByText("Item1"); //Select item from list having option text as "Item1"

        //se.SelectByValue("Item1"); //Select item from list having option value as "Item1"

        //Following code to selecting item from list

        driver.Quit(); //Quitting the Firefox
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: WebDriver API: 'Failed to send keys because cannot focus element' -- better workaround than using Firefox instead of Chrome? (score [58169](https://stackoverflow.com/q/2023) in 2017)

#### Question
There's a bug in the chromedriver.exe Chrome driver for Selenium's WebDriver API. You can't use send_keys for certain types of inputs, like for the jQuery plugin "`EZPZ Hint`". It works okay on simple forms.  

For now, I'm going to use Firefox and IE instead of Chrome to do my testing, but I'd like to see this issue fixed. Does anyone know of a different workaround that'd allow me to use Chrome instead of switching browsers?  

<a href="https://i.imgur.com/R68e6.png" rel="nofollow noreferrer">Here's input</a> had to use an image because it's generated dynamically and I couldn't copy/paste from Chrome's inspector thing.  

I am using Chrome latest stable (14.0.835.202) and a Python script with a unittest class and nose as the test runner.  

Here's the debugging info:  

```
> Traceback (most recent call last):   File
> "\\server\QA\Automation\COMMON\product\common.py", line 35, in setUp
>     self.web.find_element_by_name("ezpz_hint_dummy_input").send_keys(self.user)
> File
> "C:\Python27\lib\site-packages\selenium-2.8.1-py2.7.egg\selenium\webdriver\remote\webelement.
> py", line 146, in send_keys
>     self._execute(Command.SEND_KEYS_TO_ELEMENT, {'value': typing})   File
> "C:\Python27\lib\site-packages\selenium-2.8.1-py2.7.egg\selenium\webdriver\remote\webelement.
> py", line 194, in _execute
>     return self._parent.execute(command, params)   File "C:\Python27\lib\site-packages\selenium-2.8.1-py2.7.egg\selenium\webdriver\remote\webdriver.p
> y", line 144, in execute
>     self.error_handler.check_response(response)   File "C:\Python27\lib\site-packages\selenium-2.8.1-py2.7.egg\selenium\webdriver\remote\errorhandle
> r.py", line 118, in check_response
>     raise exception_class(message, screen, stacktrace) WebDriverException: Message: 'Message: u\'focusElement execution
> failed;\\n Failed to send keys beca use cannot focus element\'
> \n-------------------- >> begin captured logging <<
> --------------------\ nselenium.webdriver.remote.remote_connection: DEBUG: POST http://127.0.0.1:51178/session {"sessionId ": null,
> "desiredCapabilities": {"platform": "ANY", "browserName": "chrome",
> "version": "", "javascr iptEnabled":
> true}}\nselenium.webdriver.remote.remote_connection: DEBUG: POST
> http://127.0.0.1:51178 /session/c85bcae35e0f07e805ea80c47ed9b75d/url
> {"url": "http://10.0.20.61/product", "sessionId": "c85bc
> ae35e0f07e805ea80c47ed9b75d"}\nselenium.webdriver.remote.remote_connection:
> DEBUG: POST http://127.0
> .0.1:51178/session/c85bcae35e0f07e805ea80c47ed9b75d/element {"using":
> "name", "sessionId": "c85bcae3 5e0f07e805ea80c47ed9b75d", "value":
> "ezpz_hint_dummy_input"}\nselenium.webdriver.remote.remote_conne
> ction: DEBUG: POST
> http://127.0.0.1:51178/session/c85bcae35e0f07e805ea80c47ed9b75d/element/:wdc:1319 220710066/value {"sessionId": "c85bcae35e0f07e805ea80c47ed9b75d",
> "id": ":wdc:1319220710066", "value ": ["send keys stuff here,
> redacted"]}\n--------------------- >> end captured logging <<
```

#### Answer 2 (score 1)
The error message clearly sounds like sends_keys fails because for some reason it cannot set the focus to the input control prior to sending the actual keys to control. A possible work-around could be to click on the input first because this could possibly set the focus to the input control. Then calling sends_keys afterwards could succeed.  

#### Answer 3 (score 1)
The error message clearly sounds like sends_keys fails because for some reason it cannot set the focus to the input control prior to sending the actual keys to control. A possible work-around could be to click on the input first because this could possibly set the focus to the input control. Then calling sends_keys afterwards could succeed.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How to handle dynamic changing ID's In XPath? (score [58017](https://stackoverflow.com/q/18342) in 2016)

#### Question
<p>How to Handle Dynamic Changing IDs In XPath?
for example : </p>

```
//div[@id='post-body-3647323225296998740']/div[1]/form[1]/input[1]
```

In this xpath <strong>id</strong> `"3647323225296998740"` is changing every time when reloading the page.   

Is there any way to handle this type of situation in Selenium?  

#### Answer 2 (score 13)
At this situation We have lots of options-  

<strong>Option 1 :</strong> Look for any other attribute which Is not changing every time In that div node like name, class etc. So If this div node has class attribute then we can write xpath as bellow.   

```
//div[@class='post-body entry-content']/div[1]/form[1]/input[1] 
```

<strong>Option 2 :</strong> We can use absolute xpath (full xpath) where you not need to give any attribute names In xpath.  

```
/html/body/div[3]/div[2]/div[2]/div[2]/div[2]/div[2]/div[2]/div/div[4]/div[1]/div/div/div/div[1]/div/div/div/div[1]/div[2]/div[1]/form[1]/input[1] 
```

<strong>Option 3 :</strong> We can use starts-with function. In this xpath's ID attribute, "post-body-" part remain same every time.  

```
 //div[starts-with(@id,'post-body-')]/div[1]/form[1]/input[1] 
```

<strong>Option 4 :</strong> We can use contains function. Same way you can use contains function as bellow.  

```
 div[contains(@id,'post-body-')]/div[1]/form[1]/input[1]
```

#### Answer 3 (score 5)
<h5>Use other elements and attributes for partial and combination matches</h2>

Generally in these cases of database backed and changing ID's in web element selectors your options are to look for one or more of:  

<ul>
<li>a higher level selector such as the `form` name, e.g. `//form/input[@type='submit']`</li>
<li>a combo of non-unique selectors that together are unique e.g. `//form[@class='new_user']/input[@type='submit']`</li>
<li>a data attribute such as `form[@data-form='new-user']//input`</li>
<li>a partial match using `starts-with` or `contains` against `post-body-` e.g.<br>
`//div[starts-with(@id,'post-body-')]/div[1]/form[1]/input[1]`</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Chrome driver 2.28: "Chrome is being controlled by automated test software" notification. Can it be removed? (score [57274](https://stackoverflow.com/q/26051) in 2017)

#### Question
<p>I have just updated my project with the latest chrome driver (2.28).
When I run the browser through the driver, a yellow notification pops under the URL bar, saying "Chrome is being controlled by automated test software". 
Is there any way to configure Chrome not to show this notification?</p>

I used this code to start the driver:  

```
    ChromeOptions cOptions = new ChromeOptions();
    cOptions.addArguments("test-type");
    cOptions.addArguments("start-maximized");
    cOptions.addArguments("--js-flags=--expose-gc");  
    cOptions.addArguments("--enable-precise-memory-info"); 
    cOptions.addArguments("--disable-popup-blocking");
    cOptions.addArguments("--disable-default-apps"); 
    driver = new ChromeDriver(cOptions);
```

<hr>

<a href="https://i.stack.imgur.com/2mwNN.png" rel="noreferrer"><img src="https://i.stack.imgur.com/2mwNN.png" alt="enter image description here"></a>  

#### Answer 2 (score 17)
Just in case someone sees that post , I added :  

```
cOptions.setExperimentalOption("excludeSwitches", Arrays.asList("enable-automation"));
```

And it caused the driver to crash when calling:   

```
driver().manage().window().maximize();
```

<p>So I had to remove it.
Anyway , Adding :</p>

```
options.addArguments("disable-infobars");
```

<p>solved the original issue.
Thank you all for your help.</p>

#### Answer 3 (score 5)
Solution for Python 3:  

```
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
chrome_options = Options()
chrome_options.add_argument("--disable-infobars")
browser = webdriver.Chrome(executable_path = path_to_chromedriver,chrome_options=chrome_options)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How to change status of all test cases in QC test lab (score [56662](https://stackoverflow.com/q/1474) in 2011)

#### Question
<p>In QC, How to change status of all test cases(including all steps) together.
I need to make a large set of test cases "pass" in one go, hope there would be some query which can do this.</p>

#### Answer accepted (score 6)
I believe QC does not have any way to update test results of multiple test cases all at once. The fastest way to update multiple tests is the following:  

<ul>
<li>Just update one test as passed (Make sure you are in grid view)</li>
<li>Now click on that "passed" cell and it should get highlighted. Now just keep repeating the remaining steps</li>
<li>copy (cntr +c) duh</li>
<li>now hit down arrow to go to the next test</li>
<li>paste</li>
</ul>

<p>You can actually do this very fast once you start doing it. It is easy to update a 100 tests in 3-4 minutes.<br><br>
<strong>Important:</strong> Don't wait for QC to update the results in the UI. Just keep typing them on the keyboard and QC UI will keep loading. At intervals it will keep showing lots of tests being updated at once.</p>

#### Answer 2 (score 3)
One of the good way of use : QC is strong to trace and show what it really append in the project.  

If you need to change the status of a lot of test (with step), normally you must execute (like real time) the run of all your test and put the right status (like this you can challenge the real duration of your test) and QC will trace the status of your step.  

If you only need to put a "Passed" status for a lot of test, because you know that this part is allready test with success or other reason, you can do a "Fast run" for all the test. To do this, for each test set, in the "Execution grid" :  

<ul>
<li>select a test  go in the "Tests" menu (between "View" and "Analysis"
menu)</li>
<li>select "Replace", a new window is open</li>
<li>Select the fields that</li>
<li>you want to change, the actual value and the new value</li>
</ul>

All step will be on "No run" Status, but it's the truth (you don't execute the test) and it doesn't matter because all reporting will trace the status of your test not the status of the step.  

#### Answer 3 (score 2)
<p>Select all the tests in Grid view and Click RUN.  or Select Test Set(LH side block) and Click Run Test Set (RH side block).
Once after manual run window (new pop up like window opens)<br>
Press <kbd>Ctrl</kbd>+<kbd>R</kbd> then<br>
<kbd>Ctrl</kbd>+<kbd>A</kbd> and<br>
<kbd>Ctrl</kbd>+<kbd>Q</kbd></p>

This will Pass all test steps of one test case.  

One by one all test cases will open in the similar fashion and repeat the above 3 steps.  

So far I found this is the easiest way in QC.  

If you can code a small snippet in C or C++ to press the shortcut keys, you are done with all test cases.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: How to switch from one tab to another tab in chrome (score [56537](https://stackoverflow.com/q/26800) in )

#### Question
Please help how to switch from one tab to another tab in chrome and to change focus on child tab.  

#### Answer 2 (score 5)
<blockquote>
  Steps to work with tabs in the same browser:  
</blockquote>

<ol>
<li>Open a new tab using Ctrl + t</li>
<li>Driver control automatically switches to the newly opened tab</li>
<li>Perform the required operations here.</li>
<li>Next switch back to the old tab using Ctrl + Tab. You need to keep pressing this unless you reach the desired tab.</li>
<li>Once the desired tab is reached, then perform the operations in that tab.</li>
</ol>

Get the current window handle and open a new tab using `Ctrl + t`   

```
    driver.get("http://google.com");
    String windowHandle = driver.getWindowHandle();
    driver.findElement(By.cssSelector("body")).sendKeys(Keys.CONTROL +"t");
```

Check the size of the output of `getWindowHandles()`.  

Then Use:  

```
    ArrayList tabs = new ArrayList (driver.getWindowHandles());
    System.out.println(tabs.size());
    driver.switchTo().window(tabs.get(0)); 
```

The control is now in the new tab-  

```
    driver.get("Your application URL");
    //perform other operations on new tab.
```

<blockquote>
  Switch to the old tab using Ctrl + Tab:  
</blockquote>

```
    driver.switchTo().window(mainWindowHandle);
    driver.findElement(By.cssSelector("body")).sendKeys(Keys.CONTROL +"\t");
    driver.switchTo().defaultContent();
```

=============================OR============================  

<blockquote>
  You can perform the steps using Action class too.  
</blockquote>

<strong>for navigating left to right side:</strong>  

```
Actions action= new Actions(driver);
action.keyDown(Keys.CONTROL).sendKeys(Keys.TAB).build().perform();
```

<strong>For navigating right to left:</strong>  

```
Actions action= new Actions(driver);
action.keyDown(Keys.CONTROL).keyDown(Keys.SHIFT).sendKeys(Keys.TAB).build().perform();
```

To get more details <a href="https://stackoverflow.com/questions/12729265/switch-tabs-using-selenium-webdriver-with-java">check here.</a>  

#### Answer 3 (score 0)
On my code I click a button and opens a tab (so it is already on the new tab, I don't need to do something to go to that new tab) and run this so it recognize the new tab and worked:  

```
driver.SwitchTo().Window(driver.WindowHandles.Last());
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How to handle "Time out receiving message from the renderer" in chrome driver? (score [56498](https://stackoverflow.com/q/9007) in )

#### Question
I am new to selenium, I'm facing "Time out receiving message from the renderer" in chrome browser while running test with selenium 2.41 and chrome 2.9x. I have tried many tests to reproduce the issue, but it occurs inconsistently. Is there any specific reasons for this issue?.  

#### Answer accepted (score 2)
Thanks for your responses finally I solved it cutting out some plugins and blocked some third party ads before starting the tests.  

<p>Solution 1:
There are some plugins like flash player which may hangs the browser inconsistently waiting for some resource during test run, try disabling such plugins while starting the test using the chrome switches.
<a href="http://peter.sh/experiments/chromium-command-line-switches/" rel="nofollow">http://peter.sh/experiments/chromium-command-line-switches/</a></p>

<p>Solution 2:
The browser might hang waiting for some third party ads.
Try disabling ads using some ad blocker extension or block the url pattern using the custom proxy configuration. </p>

<p>For inconsistent browser hangs, Try to find which process hangs the browser.
1.Unlike firefox chrome creates separate process for browser, tab, extension and plugins.
2.When the browser hangs check is there any new process(shift+Esc) like Web Worker:blob appended with an  third party url, then follow #2
3.or else if there  are more separate process opened for plugins try #1</p>

#### Answer 2 (score 8)
<p>It looks like this issue has been logged as a bug for Selenium but has not yet been fixed:
<a href="https://code.google.com/p/chromedriver/issues/detail?id=402" rel="noreferrer">Issue 402: webdriver hangs on page load and does not give control back for script execution</a></p>

They are looking for a specific repro, maybe you could help them out by posting your specific repro?  

One person reported that removing any driver timeout options from their code solved the problem:  

```
//driver.manage().timeouts().implicitlyWait(2000, TimeUnit.MILLISECONDS);
//driver.manage().timeouts().pageLoadTimeout(40, TimeUnit.SECONDS);
//driver.manage().timeouts().setScriptTimeout(60, TimeUnit.SECONDS);
```

#### Answer 3 (score 3)
I am not saying this is the solution but I want to share my experience after investigating a day on this. The problem with our site was actually because of the time it took for a third party to load a page source when using Google tagging (GTM).This can be overlooked by adding a chrome extension like Ghostery and block all the tags. Or better you can ask your developers to turn off tagging on pre-prod. With the former approach you can load the chrome profile with Ghostery as below.  

```
DesiredCapabilities capabilitiesChrome = DesiredCapabilities.chrome();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--always-authorize-plugins");
        options.addArguments("load-extension=C:/Users/hemanand.rajamani/AppData/Local/Google/Chrome/User Data/Default/Extensions/mlomiejdfkolichcflejclcbmpeaniij/7.1.0.49_0");
        options.addArguments("user-data-dir=C:/Users/hemanand.rajamani/AppData/Local/Google/Chrome/User Data/Default");
        capabilitiesChrome.setCapability(ChromeOptions.CAPABILITY,options);
        try {
            desiredBrowser = new RemoteWebDriver(new URL("http://" + hubHost + ":" + hubPort + "/wd/hub"),
                    capabilitiesChrome);

        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
```

Hope this helps someone.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: How to determine whether element is clickable or not? (score [56329](https://stackoverflow.com/q/13008) in 2015)

#### Question
My Question is How to check whether the element is clickable or not ?.Is there any method to chat that like isElementVisible() or IsElementPresent() and etc ... Please let me know if one is having a knowledge about this problem. My scripting language is javascript+Node.js and using selenium webdriver  

#### Answer 2 (score 4)
You can click text. It just (usually) doesn't DO anything. Everything that exists CAN be clicked -- you can move your pointer over it and click the mouse. Whether the application does anything with that click event is up to the logic behind the page, which Selenium can't help you with because it doesn't know how your application works.   

An example with clickable text: <a href="https://jsfiddle.net/xqnxkhuw/" rel="nofollow">https://jsfiddle.net/xqnxkhuw/</a> (click the words in the lower-right panel to see it in action)  

So what you're after is really domain knowledge, which we can't help you with.   

#### Answer 3 (score 3)
I do this test as little different way.I am using exception of wait.You can also use more time for wait object.  

```
//Code written in Java
public static boolean isClickable(WebElement webe)      
{
    try
    {
        WebDriverWait wait = new WebDriverWait(yourWebDriver, 5);
        wait.until(ExpectedConditions.elementToBeClickable(webe));
        return true;
    }
    catch (Exception e)
    {
        return false;
    }
}
```

Call this method in your class.  

Example :  

```
boolean bst = className.isClickable("your element");
```

If bst is true then element is clickable otherwise not.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How to switch-handle-close particular popup window, When multiple popups are opened? (score [55400](https://stackoverflow.com/q/8416) in 2016)

#### Question
I know how to switch to single popup window, but I do not know how to switch particular popup window when you have more popup windows.  

<blockquote>
  <strong>Scenario is:</strong> Go to the each and every popup   
</blockquote>

<ol>
<li>Get the title </li>
<li>Perform any action (Click on link) on popup </li>
<li>Close the particular popup.</li>
</ol>

<strong>Test URL:</strong> <a href="http://site2.way2sms.com/content/prehome.jsp" rel="nofollow noreferrer">http://site2.way2sms.com/content/prehome.jsp</a>  

<blockquote>
  <strong>Below is the sample code:</strong>  
</blockquote>

```
  import java.util.concurrent.TimeUnit;
    import org.junit.*;
    import org.openqa.selenium.*;
    import org.openqa.selenium.firefox.FirefoxDriver;

public class PopupRnD {
        @Test
      public void test5() throws Exception {
          WebDriver driver = new FirefoxDriver();
          driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
          driver.get("http://site2.way2sms.com/content/prehome.jsp");

            String mainwindow=driver.getWindowHandle();
            driver.findElement(By.linkText("Contact us")).click();

            for(String winHandle :driver.getWindowHandles()){
                driver.switchTo().window(winHandle);
                if(driver.getTitle().equals("Real Estate | Property in India | Buy/Sale/Rent Properties | MagicBricks")){
System.out.println("You are in required window");
                    break;
                    } else{
            System.out.println("Title of the page after - switchingTo: " + driver.getTitle());
                }
            }
            driver.switchTo().window(mainwindow);
            driver.quit();
    }
      }
```

#### Answer 2 (score 1)
So here's my code. Not much different from your sample code. I have used a Java Set to store the window handles of pop ups(since `driver.getWindowHandles()` returns a set)  

Test url: <a href="http://www.popuptest.com/" rel="nofollow">http://www.popuptest.com/</a>  

```
@Test
public void PopupUsingSet() throws InterruptedException{
driver.get("http://www.popuptest.com/");
driver.findElement(By.xpath("//a[@href='popuptest12.html']")).click();
String CWH=driver.getWindowHandle();
System.out.println("Current Window Handle: "+driver.getWindowHandle());

    //Adding the windowhandles to a set
s.addAll(driver.getWindowHandles());

    //removing CWH from the set as we want to take actions only on the poopups
    s.remove(CWH);

    //iterating over the popups. Going to each popup, getting the title and the src 
   //of the image displayed and closing them        
    Iterator ii= s.iterator();
while(ii.hasNext()){
    //elements inside the set are of the type object, so we convert them to string 
        driver.switchTo().window(ii.next().toString());
    System.out.println(driver.getTitle());
    driver.manage().window().maximize();
    System.out.println(driver.findElement(By.xpath("//img")).getAttribute("src"));
    driver.close();
             }
    //bringing the control back to the main window
    driver.switchTo().window(CWH);
```

Hope this helps. I have not used the Java List because it requires unnecessary effort in splitting the list element into usable window handles.   

Looking at your example code and the one i wrote it's clear that using an advanced for loop is the more efficient method.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: How to handle multiple columns of Data from Excel using Apache POI for Selenium WebDriver (score [54929](https://stackoverflow.com/q/15591) in )

#### Question
I am new to Selenium WebDriver and I am automating an end to end test. My doubt here is, all the data for the test is stored in an excel file which contains more than 15 columns of data. Each @Test annotation (I am using TestNG) requires one or two or three of the column data. Basically I need to split the 15 Columns of data according to the @Test annotations (for each single action). How exactly to do this? Every time using @DataProvider and creating two or three parameters for the same and writing the code to read data seems to be too redundant. Kindly help me here on how to do tackle this in a better way.  

#### Answer 2 (score 1)
Read the complete excel at the start of your test, store the column headers in a array/list and then by using the first row as column header feed your test e.g. in a Test annotation, you require data for Firstname, Lastname and Address columns only.  

Then, in that test write the code to read values of rows below the column Firstname and insert the same into the Firstname field. This way you don't need to care about the order in which your excel has been created i.e. whether Firstname is at the 2nd column or 14th column it doesn't matter. Below is the code for that.  

```
public static void main(String[] args) throws IOException {

        WebDriver driver = new FirefoxDriver();
        driver.get("http://www.google.com"); 
        driver.manage().window().maximize(); 

            FileInputStream file = new FileInputStream("C:\\Dhiman\\Automation\\seleniumtest.xls"); 
            HSSFWorkbook workbook = new HSSFWorkbook(file);
            HSSFSheet sheet = workbook.getSheetAt(0);
            int noOfColumns = sheet.getRow(0).getLastCellNum();
            //System.out.println(noOfColumns);
            String[] Headers = new String[noOfColumns];
            for (int j=0;j<noOfColumns;j++){
                Headers[j] = sheet.getRow(0).getCell(j).getStringCellValue();
            }
                for (int a=0;a<noOfColumns;a++){
                    if(Headers[a].equals("Address")){
                        driver.findElement(By.id("lst-ib")).sendKeys(sheet.getRow(1).getCell(a).getStringCellValue());
                        break;
                        }
}
      workbook.close();
      file.close();
      driver.close();
      System.exit(0);
            }
```

using this need to get the value of 2-3 columns as required by you and can fill the respective field in the application. I haven't used TestNG in my tests, but you will get a clear idea from this implementation.  

#### Answer 3 (score 0)
<p>It is very easy to handle excel data using POI as well as JXL jar in selenium.Mostly for jxl jar/POI you have to use `Dataprovider` in TestNG for easy purpose.
You can find more details in this article ,it has given datadriven framework implemention here .<a href="http://www.wikishown.com/selenium-tutorials/data-driven-framework-with-selenium/" rel="nofollow">Reading data from excel</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: Downloading a file in Internet Explorer through Selenium (score [54391](https://stackoverflow.com/q/3169) in 2012)

#### Question
I have to automate a case in which I have to download an Excel file using Selenium IDE.I have done this in Firefox by using custom profile feature which automatically downloads file and saves it into a user-defined folder. To do the same in Internet Explorer (IE), is there anything in IE like custom profile and preferences? how do I prompt IE to automatically download a file? I am using Java for automation. Kindly help.  

#### Answer 2 (score 9)
<a href="http://ardesco.lazerycode.com/index.php/2012/07/how-to-download-files-with-selenium-and-why-you-shouldnt/">Link to my blog where I discuss this in more detail.</a>  

Inconsistencies here, are you using Selenium IDE or WebDriver with Java?  

Assuming you are using WebDriver with Java and not Selenium IDE(as you state in your post) You can try using:  

```
/*
 * Copyright (c) 2010-2012 Lazery Attack - http://www.lazeryattack.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.lazerycode.selenium.filedownloader;

import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Set;

public class FileDownloader {

    private static final Logger LOG = Logger.getLogger(FileDownloader.class);
    private WebDriver driver;
    private String localDownloadPath = System.getProperty("java.io.tmpdir");
    private boolean followRedirects = true;
    private int httpStatusOfLastDownloadAttempt;

    public FileDownloader(WebDriver driverObject) {
        this.driver = driverObject;
    }

    /**
     * Specify if the FileDownloader class should follow redirects when trying to download a file
     *
     * @param value
     */
    public void followRedirectsWhenDownloading(boolean value) {
        this.followRedirects = value;
    }

    /**
     * Get the current location that files will be downloaded to.
     *
     * @return The filepath that the file will be downloaded to.
     */
    public String localDownloadPath() {
        return this.localDownloadPath;
    }

    /**
     * Set the path that files will be downloaded to.
     *
     * @param filePath The filepath that the file will be downloaded to.
     */
    public void localDownloadPath(String filePath) {
        this.localDownloadPath = filePath;
    }

    /**
     * Download the file specified in the href attribute of a WebElement
     *
     * @param element
     * @return
     * @throws Exception
     */
    public String downloadFile(WebElement element) throws Exception {
        return downloader(element, "href");
    }

    /**
     * Download the image specified in the src attribute of a WebElement
     *
     * @param element
     * @return
     * @throws Exception
     */
    public String downloadImage(WebElement element) throws Exception {
        return downloader(element, "src");
    }

    /**
     * Gets the HTTP status code of the last download file attempt
     *
     * @return
     */
    public int httpStatusOfLastDownloadAttempt() {
        return this.httpStatusOfLastDownloadAttempt;
    }

    /**
     * Load in all the cookies WebDriver currently knows about so that we can mimic the browser cookie state
     *
     * @param seleniumCookieSet
     * @return
     */
    private HttpState mimicCookieState(Set<org.openqa.selenium.Cookie> seleniumCookieSet) {
        HttpState mimicWebDriverCookieState = new HttpState();
        for (org.openqa.selenium.Cookie seleniumCookie : seleniumCookieSet) {
            Cookie httpClientCookie = new Cookie(seleniumCookie.getDomain(), seleniumCookie.getName(), seleniumCookie.getValue(), seleniumCookie.getPath(), seleniumCookie.getExpiry(), seleniumCookie.isSecure());
            mimicWebDriverCookieState.addCookie(httpClientCookie);
        }

        return mimicWebDriverCookieState;
    }

    /**
     * Set the host configuration based upon the URL of the file/image that will be downloaded
     *
     * @param hostURL
     * @param hostPort
     * @return
     */
    private HostConfiguration setHostDetails(String hostURL, int hostPort) {
        HostConfiguration hostConfig = new HostConfiguration();
        hostConfig.setHost(hostURL, hostPort);

        return hostConfig;
    }

    /**
     * Perform the file/image download.
     *
     * @param element
     * @param attribute
     * @return
     * @throws IOException
     * @throws NullPointerException
     */
    private String downloader(WebElement element, String attribute) throws IOException, NullPointerException {
        String fileToDownloadLocation = element.getAttribute(attribute);
        if (fileToDownloadLocation.trim().equals("")) throw new NullPointerException("The element you have specified does not link to anything!");

        URL fileToDownload = new URL(fileToDownloadLocation);
        File downloadedFile = new File(this.localDownloadPath + fileToDownload.getFile().replaceFirst("/|\\\\", ""));
        if (downloadedFile.canWrite() == false) downloadedFile.setWritable(true);

        HttpClient client = new HttpClient();
        client.getParams().setCookiePolicy(CookiePolicy.RFC_2965);
        client.setHostConfiguration(setHostDetails(fileToDownload.getHost(), fileToDownload.getPort()));
        client.setState(mimicCookieState(this.driver.manage().getCookies()));
        HttpMethod getFileRequest = new GetMethod(fileToDownload.getPath());
        getFileRequest.setFollowRedirects(this.followRedirects);
        LOG.info("Follow redirects when downloading: " + this.followRedirects);

        LOG.info("Sending GET request for: " + fileToDownload.toExternalForm());
        this.httpStatusOfLastDownloadAttempt = client.executeMethod(getFileRequest);
        LOG.info("HTTP GET request status: " + this.httpStatusOfLastDownloadAttempt);
        LOG.info("Downloading file: " + downloadedFile.getName());
        FileUtils.copyInputStreamToFile(getFileRequest.getResponseBodyAsStream(), downloadedFile);
        getFileRequest.releaseConnection();

        String downloadedFileAbsolutePath = downloadedFile.getAbsolutePath();
        LOG.info("File downloaded to '" + downloadedFileAbsolutePath + "'");

        return downloadedFileAbsolutePath;
    }

}
```

It's quite easy to use, you just need to supply the WebElement of the Image/Hyperlink that you want to download, so instead of trying to perform a click on the WebElement you would instead pass it in to the FileDownloader Object:  

```
FileDownloader downloadTestFile = new FileDownloader(driver);
driver.get(http://www.mysite.com/downloadPage.html");
WebElement downloadLink = driver.findElement(By.id("fileToDownload"));
String downloadedFileAbsoluteLocation = downloadTestFile.downloadFile(downloadLink);
```

This is all written in Java so it's cross browser/platform compliant.  

<a href="https://github.com/Ardesco/Powder-Monkey/blob/master/src/main/java/com/lazerycode/selenium/filedownloader/FileDownloader.java">Code On Github</a>  

#### Answer 3 (score 5)
I generally use keyboard shortcuts with Robot class in Java in order to emulate what I would do manually. In IE 8, saving a file would be three steps:  

```
1) Click link  or Press Enter key on the link.
2) type S. 
3) Hit Enter.
```

<p>I start with doing the same action manually for the first test case ie. save in a certain folder, cleanup the folder and click the checkbox for close this dialog once download finishes. 
Next, I use the following code :</p>

```
WebElement link = driver.findElement(By.xpath("myxpath"));
clickAndSaveFileIE(link);


public static void clickAndSaveFileIE(WebElement element) throws InterruptedException{
    try {
            Robot robot = new Robot();
        //get the focus on the element..don't use click since it stalls the driver          
       element.sendKeys("");
       //simulate pressing enter            
      robot.keyPress(KeyEvent.VK_ENTER);
     robot.keyRelease(KeyEvent.VK_ENTER);
     //wait for the modal dialog to open            
    Thread.sleep(2000);
   //press s key to save            
   robot.keyPress(KeyEvent.VK_S);
   robot.keyRelease(KeyEvent.VK_S);
   Thread.sleep(2000);
  //press enter to save the file with default name and in default location
    robot.keyPress(KeyEvent.VK_ENTER);
    robot.keyRelease(KeyEvent.VK_ENTER);
 } catch (AWTException e) {

            e.printStackTrace();
        }
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: How to Implement Page Object and Page Factory Pattern in Selenium Webdriver? (score [54367](https://stackoverflow.com/q/9901) in 2016)

#### Question
<blockquote>
  I am a beginner in learning selenium Webdriver. I  am not able to understand how page object and factory models works and how it can be beneficial?   
</blockquote>

Kindly help me explain it with detailed explanation.  

#### Answer accepted (score 14)
<strong>PageObjects</strong>  

The code of automated test cases should be easy to understand and not too complex. If a test fails, we want to know why and this as soon as possible. To allow this exists PageObjects. PageObjects are classes that contains WebElements and every actions associated with those.  

A PageObject looks like this:  

```
class HomePage {

    WebDriver driver;

    public HomePage(WebDriver driver) {
        this.driver = driver;
    }

    // Find a single element
    @FindBy(id="home-menu-entry")
    WebElement homeMenuEntry;

    public void clickHomeMenuEntry() {
        homeMenuEntry.click();
    }

    // Find several elements
    @FindBy(className="menu-entry")
    List<WebElement> menuEntries;

   // More actions and elements
}
```

<strong>Usage of PageFactory and PageObject</strong>  

```
class TestSomething {

    public void testMethod() {

        // Initial driver.

        // Use PageFactory to init elements.
        HomePage hp = PageFactory.initElements(driver, HomePage.class);

        // Use PageObject to execute action.
        hp.clickHomeMenuEntry();

        // Assertions or more actions.

    }

}
```

You also can put the `PageFactory.initElements();` into the constructor and create just an `HomePage` object instead of calling the `PageFactory` method.  

<strong>Important:</strong> If you call `initElements()` all elements will be initialized, not later if you use them.  

<strong>How to organize this?</strong>  

I do the following: Each page has a PageObject, that represent these. But some components of a page are present on many pages. For this case I create for each component additional classes. Example:  

<ul>
<li>Header.class</li>
<li>Footer.class</li>
<li>HomePage.class</li>
<li>ContactPage.class</li>
</ul>

<strong>Useful Links</strong>  

<ul>
<li><a href="https://github.com/SeleniumHQ/selenium/wiki/PageFactory" rel="nofollow noreferrer">https://github.com/SeleniumHQ/selenium/wiki/PageFactory</a></li>
<li><a href="https://github.com/SeleniumHQ/selenium/wiki/PageObjects" rel="nofollow noreferrer">https://github.com/SeleniumHQ/selenium/wiki/PageObjects</a></li>
<li><a href="https://github.com/SeleniumHQ/selenium/wiki/Design-Patterns" rel="nofollow noreferrer">https://github.com/SeleniumHQ/selenium/wiki/Design-Patterns</a></li>
</ul>

#### Answer 2 (score 7)
Page Factory Pattern is like an extension to Page Object Model , but Page Factory is much enhanced model. To start with, we just need to import package `org.openqa.selenium.support.PageFactory`  

<strong>"Factory class can be used to make using Page Objects simpler and easier".</strong>  

We use Page Factory pattern to initialize web elements which are defined in Page Objects.  

We should initialize page objects using `initElements()` method from PageFactory Class as below, Once we call initElements() method, all elements will get initialized. `PageFactory.initElements()` static method takes the driver instance of the given class and the class type, and returns a Page Object with its fields fully initialized.  

```
public HompePage(WebDriver driver) 
{           
   this.driver = driver; 
   PageFactory.initElements(driver, this);
}
```

<p><strong>Now question arise why we use Constructor?</strong><br>
Solution is=>
We should preferably use a constructor which takes a WebDriver instance as its only argument or falling back on a no-arg constructor. An exception will be thrown if the class cannot be instantiated.<br>
Page Factory will initialize every WebElement variable with a reference to a corresponding element on the actual web page based on “locators” defined.</p>

Check below code by <strong>using Simple POM</strong>    

```
public class BasePage 
{
private By username = By.id("username");
private By password = By.id("password");
private By loginBtn = By.name("loginbtn");

   public void userLogin(String userName, String password) 
   {
        driver.findElement(username).sendKeys("testuser");
        driver.findElement(password).sendKeys("testpassword");
        driver.findElement(loginBtn).click();
   }
}
```

<strong>By using using Page Factory:</strong>  

```
public class BasePage {
  @FindBy(id= "username") private WebElement userName;
  @FindBy(id= "password") private WebElement password;
  @FindBy(id= "login") private WebElement loginBtn;

  public void userLogin(String userName, String password) {
    userName.sendKeys(userName);
    password.sendKeys(password);
    loginBtn.click();
  }
}
```

#### Answer 3 (score 3)
<p>In very simple terms, the explanation for page objects is as follows:
A separate class (per page) which lists all the objects in a page and the allowed operations that can be performed by them can be created. And whenever you need to perform any tests on that particular page in your webapp, you write the test to first import the page, and thereafter, perform all the allowed functions on that page to execute your tests.</p>

In effect, there is a clear definition of the page with its objects and actions that can be performed on each object, and a separation of the tests that use those methods.  

<p>A very obvious benefit would be that anyone who looks through the page object class will be able to know what objects reside on that page and what operation can be performed by each object.
A test automation engineer working on contract or new to your project only needs to know the location of the page object class and can help automate tests without having to go through any extensive training.</p>

<p>Hope this gives a bit more clarity on page objects.
Cheers!</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: What are some good open source UI Testing tools for testing Windows GUI? (score [53817](https://stackoverflow.com/q/8802) in )

#### Question
I need a list of some good tools which are open source and meant for automating the UI testing of Windows GUI. Any help will certainly be appreciated.  

#### Answer 2 (score 12)
<strong>Sikilu</strong>:  

<a href="http://www.sikuli.org/">Sikuli</a> automates anything you see on the screen. It uses image recognition to identify and control GUI components. It is useful when there is no easy access to a GUI's internal or source code.  

#### Answer 3 (score 8)
<strong>TestStack White</strong>: (partial open-source)  

<blockquote>
  <p><a href="https://github.com/TestStack/White" rel="noreferrer">White</a> is an open-source framework for automating rich client
  applications based on Win32, WinForms, WPF, Silverlight and SWT (Java)
  platforms. It is .NET based and does not require the use of any
  proprietary scripting languages. Tests/automation programs using White
  can be written with whatever .NET language, IDE and tools you are
  already using. White provides a consistent object-oriented API, hiding
  the complexity of <a href="http://msdn.microsoft.com/en-us/library/ms753107(v=vs.110).aspx" rel="noreferrer">Microsoft's UIAutomation library</a> (on which
  White is based) and windows messages.</p>
</blockquote>

With the free <a href="http://www.visualstudio.com/en-us/products/visual-studio-express-vs.aspx" rel="noreferrer">Visual Studio Express</a> you can create automated tests with the .Net framework. See my example console C# app code to automate notepad.exe below:  

```
using System;
using TestStack.White;
using TestStack.White.InputDevices;
using TestStack.White.UIItems.Finders;
using TestStack.White.UIItems.MenuItems;
using TestStack.White.UIItems.WindowItems;

namespace WhiteTest
{
    class Program {
        static void Main(string[] args) {
            Tests tests = new Tests();
            tests.Notepad();
        }
    }

    class Tests {
        public void Notepad() {
            // Arrange
            Application app = Application.Launch("notepad.exe");
            Window window = app.GetWindow("Untitled - Notepad");

            // Act
            var box = window.Get(SearchCriteria.ByClassName("Edit"));
            Keyboard.Instance.Send("test", box);

            window.MenuBar.MenuItem("File", "Save As...").Click();
            var filename = window.Get(SearchCriteria.ByClassName("Edit"));
            Keyboard.Instance.Send(DateTime.Now.ToString("yyyyMMddHHmmssffff") + "test.txt", filename);
            window.Get(SearchCriteria.ByText("Save")).Click();

            app.Kill();

            // Assert 
            //  file is created in Documents folder
        }
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: What are the main role and responsibilities of a tester? (score [52007](https://stackoverflow.com/q/5097) in 2016)

#### Question
I am new to this field and I have decided my career as software tester. What are the role and responsibilities as an <strong>software tester</strong>  

<blockquote>
  According to my assumption:  
</blockquote>

```
1) Analyzing the Requirements from the client
2) Participating in preparing Test Plans
3) Preparing Test Scenarios,test cases
4) Defect Tracking
5) Preparing Suggestion Documents to improve the quality of the application
6) Communication with the Test Lead / Test Manager
7) Conducting Review Meetings within the Team
```

<blockquote>
  Apart from the above points any other things I need to care about as a software tester?  
</blockquote>

#### Answer accepted (score 5)
Thank you for the opportunity for me to delve into the theory of testing and Quality Assurance. As you seem to be mostly interested in the role of a test specialist in software realization projects, I will keep the scope of my answer in that general area. Please keep in mind that most here is written from my opinion and experience and less based on books.  

<strong>First about quality</strong>   

Before we can start testing we need to understand the concept of Quality. Quality can be defined as the distance between the actual object under test and the customer's expectation of the object. This means that you should be measuring how well the object fits the expectation to determine the quality. To do this, you should be aware of the expectation, which is often captured in requirements. Now you can see that when your requirements are not fitting the expectation, neither will the end result of everyone's efforts.   

<strong>What is testing and why would you do it?</strong>   

In my opinion, testing is more about measuring than it is about suggesting improvement. Everyone has a specialty and the Business Analyst should be very skilled in delivering great requirements and suggesting improvements. This pushes your point 5. out of the window.  

As a tester, you should be clear, in every new project you work, what your assignment is.   

<ul>
<li><p>Are you expected to add to great quality software? Be prepared to meet with the customer to find out his expectations. </p></li>
<li><p>Are you expected to add to a low defect count? Write loads of test cases based on the requirements and specification.</p></li>
</ul>

Find out what type of tester you are and make sure you fit in your team, you will do fine.  

<p>Kind regards,
Koen Prins</p>

#### Answer 2 (score 5)
The two obvious steps that you seem to have missed out:  

<ul>
<li>Perform the tests.  Much may be done auto-magically, but manual testing is still a key aspect at integration and system test levels.</li>
<li>Report the results.  Whilst automated tests may generate a results file, you'll need to interpret and present the results in a format that is appropriate to the audience.</li>
</ul>

As with Developer roles, Testing roles will be about documentation... lots of it!  

#### Answer 3 (score 3)
INHO the testers' responsability is the sameone that all other roles' responsibility: to contribute as much as possible to the success of the project.  

That is, keep an eye on the ROI of every one of your activities. Keep a balance between the cost and benefit the project (and the whole team) will get for those activities. Keep aligned with the project and customer needs.  

<ul>
<li>Every time is harder to get a formal requirements document then, be
flexible. </li>
<li>Probably the customer don´t care about your test cases. How
important are they? Is it possible avoid them all?, some of them? </li>
<li>Sometimes customer needs the software right now, he thinks time to<br>
market is more important than quality. Ask yourself which could be<br>
the best approach for that kind of project.  </li>
<li>It is usual in lots of projects release a new version every week for a huge amount of users. Design your verification strategy for these situations.</li>
<li>Avoid bureaucracy and focus on what really matter.</li>
<li>Work closer with developers, they need your feedback as soon as
possible.</li>
</ul>

Those are the responsibilities.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: List and role of different types of testing environments (score [51874](https://stackoverflow.com/q/1532) in 2013)

#### Question
There are numerous of different testing environments that I have come across with, and ALL of them seem pretty useful and helpful but which ones are necessary.   

For example ... I have seen:  

<ul>
<li>Development</li>
<li>QA == Functional testing of the system </li>
<li>System Integration Testing == Tests the system from end to end</li>
<li>User Acceptance Testing = Allows the user to validate the functionality over time</li>
<li>Production == Production </li>
<li>Production Parallel == A parallel of production to replicate production issues </li>
<li>CCE = Client Certification Environment</li>
</ul>

With a lot of different type of testing that could happen (http://www.guru99.com/types-of-software-testing.html).   

What are the most common set of environments and best practices for each environment?   

#### Answer 2 (score 4)
At the risk of flogging a dead horse, this is one of those context-free questions that is tough to answer without information specific to your needs.  

I won't rehash what people have described about commonly used environments, but I would like to offer a few things to consider.  

As with most things, there are no best practices, there is what is appropriate for the situation you find yourself in. I've worked in companies where you could rapidly clone an entire environment and have as many running as your hardware had the capacity to support. I've worked in other places where the environment was so ponderously large that mimicking the entire thing 1:1 would have been ridiculously expensive. I've seen places with very relaxed development processes and others where things were very rigid and strictly controlled. How we worked within each of those constraints (or sometimes outside of them) differed from one to another.  

Here are some things that might affect what environment(s) you have and what you use them for.  

<ul>
<li>What sort of development style are you using? Are you working in a waterfall environment? an agile one? somewhere in between? </li>
<li>What kind of testing are you looking to do? </li>
<li>How do you update your environment? Do you get builds delivered to you? Do you pull code from the repository?</li>
<li>Are your environments small and self-contained or large and complex?</li>
<li>Are you using individual data sources or do multiple environments share a single db? (I've seen both)</li>
<li>Do developers and testers work very closely together or are they separated (by time, distance, culture...)</li>
<li>Do you mock up any part of your environment? Does that change over time?</li>
<li>How do you release software to production?</li>
</ul>

and so on  

Answer some of these questions, then see what questions you have about different environments (you know, unless you really were looking for a pat answer to an interview question :P )  

#### Answer 3 (score 4)
At the risk of flogging a dead horse, this is one of those context-free questions that is tough to answer without information specific to your needs.  

I won't rehash what people have described about commonly used environments, but I would like to offer a few things to consider.  

As with most things, there are no best practices, there is what is appropriate for the situation you find yourself in. I've worked in companies where you could rapidly clone an entire environment and have as many running as your hardware had the capacity to support. I've worked in other places where the environment was so ponderously large that mimicking the entire thing 1:1 would have been ridiculously expensive. I've seen places with very relaxed development processes and others where things were very rigid and strictly controlled. How we worked within each of those constraints (or sometimes outside of them) differed from one to another.  

Here are some things that might affect what environment(s) you have and what you use them for.  

<ul>
<li>What sort of development style are you using? Are you working in a waterfall environment? an agile one? somewhere in between? </li>
<li>What kind of testing are you looking to do? </li>
<li>How do you update your environment? Do you get builds delivered to you? Do you pull code from the repository?</li>
<li>Are your environments small and self-contained or large and complex?</li>
<li>Are you using individual data sources or do multiple environments share a single db? (I've seen both)</li>
<li>Do developers and testers work very closely together or are they separated (by time, distance, culture...)</li>
<li>Do you mock up any part of your environment? Does that change over time?</li>
<li>How do you release software to production?</li>
</ul>

and so on  

Answer some of these questions, then see what questions you have about different environments (you know, unless you really were looking for a pat answer to an interview question :P )  

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: How to verify two images using Selenium WebDriver? (score [51355](https://stackoverflow.com/q/18340) in 2017)

#### Question
Webdriver does not provide direct any function to image verification, but we can verify images by taking two screenshots of the whole web page using <strong>TakeScreenshot</strong> WebDriver function, one at script creation time and another at execution time.  

I have created a sample script in which first I captured a Google home page screen shot and saved `(input.jpg)` into my project, another screen shot `(output.jpg)` captured on the same page at test execution time and saved into the project. I want to compare both the images if they are not same then test script will fail.  

How should I apply logic in image verification using selenium?  

#### Answer 2 (score 7)
Selenium is a software library to locate elements on web page and interact with them. To deal with images, you need to use different library. Selenium can provide screenshots (images) but you need to use something else to work with such images.  

As a programmer, you need to master more than a single library, and learn to use right tool for the job.  

#### Answer 3 (score 4)
Use <strong>Sikulix API</strong>. Sikuli is a library that will help you compare two images or recognize images when they are displayed on your screen. After the said image is displayed, you can click on the recognized image.  

<a href="http://www.sikulix.com/" rel="nofollow noreferrer">Download Link</a>  

Go for the <a href="https://launchpad.net/sikuli/sikulix/1.1.0" rel="nofollow noreferrer">download link.</a>  

<ol>
<li>Download sikulix-setup-1.1.0.jar</li>
<li>Run the jar file.</li>
<li>Choose below option / or go for whichever option is best suited for you.</li>
</ol>

<a href="https://i.stack.imgur.com/uuwIh.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/uuwIh.png" alt="enter image description here"></a>  

<ol start="5">
<li>Click on Setup Now</li>
<li>Let the setup complete and you will find a file named - sikulixapi.jar. This jar has to be included in your classpath.</li>
</ol>

Sample Code:  

```
Screen screen = new Screen();
//set a timeout for waiting for the image
screen.setAutoWaitTimeout(30000); //default is 10 seconds
//wait for an image to get displayed on the screen and then click on it
screen.wait(new Pattern("img/image.PNG")).click();
//wait for an image with exact match
screen.wait(new Pattern("img/image.PNG").exact()).click();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: How do you test a backend API? (score [50843](https://stackoverflow.com/q/6745) in 2017)

#### Question
I was applying for QA position and the SDET asked me this question:   

<em>How do you test a backend API?</em>   

In the interview.   

I wasn't sure I answered it correctly. Just wondering if I can get some input from someone.  

#### Answer 2 (score 18)
How you approach testing an API depends on a lot of things.  Will the API be a public API that will be consumed by some external people/systems, or is it a part of a larger product's infrastructure?  API is a general term that is sometimes used to describe anything from a COM interface, to a DLL or JAR you can reference, to a REST web service.  Different approaches can be applied to testing these different things.    

Often, if the API is part of your infrastructure you can test it pretty thoroughly through unit testing and the use of the product that consumes it.    

If it is an externally consumable API then you need to be much more thorough because people could use it in different ways than you might expect and send data in much different formats, etc.  It also usually needs to make sense, be intuitive and be well documented if it is externally consumable.  You would also need to be more cautious about what is private and public, which may not be as important for an API that is only used by a single product.  

Testing an API nearly always requires you to create some sort of consumer for testing purposes.  You have to be able to interact with the API.  The consumer is usually very simple - or an existing tool - and driven by automated test cases and not manual user interaction, although I have seen cases where people created a complex GUI app for testing purposes, and cases where the testing was still mostly manual through exercising that app.  

If the API has dependencies, you may choose to mock those dependencies out so you can more thoroughly test all of those interactions and hit all of the positive and negative code paths.  For instance, if the API interacts with a database and has the ability to create, modify and delete data you may want to mock the interaction with the database to more easily test cases such as deleting a record when it does not exist, or when it is the final record, or when it is unable to be deleted because of dependencies or even when the connection to the database is unavailable - you can then see how your API would handle these situations.  

#### Answer 3 (score 5)
Choosing the tool is not the only decision you need to make when testing an API. As for any testing task you need to decide:  

<ol>
<li><strong>What aspects of the program are you testing?</strong> What application features do you want to cover with API testing? Are you going to verify some stateful scenarios (e.g. when user is logged in)? Or maybe you want to verify how an API behaves for different configurations? </li>
<li><strong>What types of problems are you looking for?</strong> What part of application is most probable to fail? In what conditions? Are there functional or performance problem? This should help you understand what are scenarios that are easier/faster/cheaper to test with API instead of using frontend. </li>
<li><strong>How will you tell whether a test passed or failed?</strong> How to evaluate whether a system behave correctly after you made a request to the API? Will you evaluate only explicit API response (e.g. it confirms it has sent an email) or you want also to verify whether it actual did what it says (the email was actually sent your account)? Furthermore, how do you know what is an expected result for a given API call? </li>
<li><strong>What tasks, specifically, will you do?</strong> Depending on the directions taken in the previous answers, you can think of exploratory testing, when you just explore API behaviour, hunt for some particular bugs, or define thorough test cases in advance? Whether you perform the manually or you automate them? Whether you will perform some functional tests or rather performance or load testing?</li>
<li><strong>Who will do the testing</strong>? Will you be the one who will test API, or maybe you will have some people who will write customer applications to test different parts of the API? How much do you know about API related technologies to automate the tests? The answer will help you to choose the right tools to test.</li>
</ol>

Now you probably have too little information to make definitive decisions that could satisfy you, your interviewer and stakeholders in a company. So, you could ask interviewer more questions about the nature of the backend API:  

<ul>
<li>Who or what is the consumer of the API? Front-end tier being a part of SUT or an external client app? Maybe there is no frontend? Is this a public API or internal used only by a few people? The answer will tell you how thoroughly you should test the API?</li>
<li>What scenarios have been covered in end-to-end test with frontend included and what scenarios have not been? What are the challenges when testing via frontend? The answers will guide you to the type of scenarios you should cover and those you should not. For instance, if invalid input validation functionality is implemented only on the backend side, this is one area to stress in API tests.</li>
<li>What technology is used to expose an API? SOAP or REST Web service, RMI, CORBA, command-line, COM, etc. The answer will imply what kind of tool or programming language you should use to implement test cases. </li>
<li>Is there some formal specification for API? Or you need to guess an expected behavior somehow, e.g., from specification for UI?</li>
<li>Does the backend talks to other components in the system? To database? Does it contacts external services? </li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: How to find real world Selenium projects (score [50321](https://stackoverflow.com/q/13983) in 2015)

#### Question
Where can I find sample or real Selenium projects. All the material I can find on github and on internet are basic, and never intermediate or advanced.  

How does a real Selenium project look in real life? How can I find sample code?  

#### Answer 2 (score 12)
The <a href="http://dev.wikia.com" rel="noreferrer">Wikia</a> project has <a href="https://github.com/Wikia/selenium-tests" rel="noreferrer">their Selenium tests</a> online, looks like a little bit more then just examples. It contains a Page object factory and hundreds of tests and looks like it is pretty active with <a href="https://github.com/Wikia/selenium-tests/graphs/commit-activity" rel="noreferrer">multiple commits</a> per day.   

The test cases: <a href="https://github.com/Wikia/selenium-tests/tree/master/src/test/java/com/wikia/webdriver/testcases" rel="noreferrer">https://github.com/Wikia/selenium-tests/tree/master/src/test/java/com/wikia/webdriver/testcases</a>  

I found this when I answered this question: <a href="https://sqa.stackexchange.com/questions/12551/free-sample-selenium-test-suites-code-for-open-source-projects?rq=1">Free/Sample Selenium test suites (code) for Open Source projects</a>  

I would expect more open source projects to have their tests online, maybe you need to look better :)  

#### Answer 3 (score 1)
<blockquote>
  Where can I find sample or real Selenium projects.  
</blockquote>

You can find selenium sample code and projects at the below mentioned links  

<a href="https://code.google.com/p/selenium/wiki/GettingStarted" rel="nofollow">https://code.google.com/p/selenium/wiki/GettingStarted</a>  

<a href="http://examples.javacodegeeks.com/enterprise-java/testng/testng-selenium-integration-example/" rel="nofollow">http://examples.javacodegeeks.com/enterprise-java/testng/testng-selenium-integration-example/</a>  

<a href="http://www.qaautomation.net/?p=263" rel="nofollow">http://www.qaautomation.net/?p=263</a>  

Yes, these are the sample codes, which will help you in getting started with Selenium. Other than this there are several good communities, which will help you in starting up with Selenium.  

<a href="http://qtpselenium.com/samplevideos/selenium/seleniumvideos.php#java_webdriver" rel="nofollow">http://qtpselenium.com/samplevideos/selenium/seleniumvideos.php#java_webdriver</a>  

This link offers a very good set of training videos which will help you a lot in learning Selenium along-with real time project.  

<blockquote>
  <p>All the material I can find on github and on internet are basic, and
  never intermediate or advanced. How does a real Selenium project look
  in real life?</p>
</blockquote>

See, no one is going to post his/her complete real project over a public site to share it with all users, because of multiple reasons (out of which most important is Security) they can't expose the project and all of its scripts.  

Other than that, all the sites/forums are for the guidance and they can tell you the best practices and recipe of creating a test project using Selenium or any other tool. In the last it totally depends upon you which suggestion and framework you are going to choose and then based on the selected ingredients you final dish will have its own look. Selection can be based upon Cost, Manpower, ROI, Skillset and Time available for example if you are using Selenium with Java using a Data Driven model then your project will have a different look if you used Keyword based test model.  

In addition to it with addition of more and more test cases (Simple, Complex etc.) to your project, it will gain shape of a real world project.   

<blockquote>
  How can I find sample code?  
</blockquote>

You can always get the sample code from the different sites as mentioned above, for getting you particular problem or road block solved, but unless you start building your tests you will not know the problems you are going to face (as different projects may have its own challenges). You can post your issues on this site too and you will get an answer on how you can move on with your code issue and with due course of time, you will start refining your test cases and project too as per best practices of Selenium/Automation.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: How to verify a success message using selenium webdriver? (score [50118](https://stackoverflow.com/q/23367) in 2016)

#### Question
<a href="https://i.stack.imgur.com/VzI7D.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/VzI7D.png" alt="enter image description here"></a><a href="https://i.stack.imgur.com/By84a.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/By84a.png" alt="enter image description here"></a>  

I am unable to verify this sucess message. I am trying to use the following code:  

<strong>1.</strong>    

<p><code>String expectedText ="Dear admin, the Institution is deleted successfully!";
Assert.assertEquals("Dear admin, the Institution is deleted      successfully!",expectedText);</code></p>

<strong>2.</strong>   

<p><code>WebElement msg=driver.findElement(By.className("pad margin no-print"));
        String text=msg.getText();
String expectedText = "Dear admin, the Institution is deleted successfully!";
Assert.assertEquals(text,expectedText);</code></p>

<strong>3.</strong>  

`driver.findElement(By.xpath("html/body/div[1]/div/div/div")).getText();`  

#### Answer 2 (score 2)
First two points: I cannot see any "Dear admin" in the message and instead of "assertEquals" try "assertTrue" and "contains". Then try:  

```
String expectedMessage = "The Institution is deleted Successfully!";
String message = driver.findElement(By.xpath("//div[contains(@class,'callout callout-success')]")).getText();
Assert.assertTrue("Your error message", message.contains(expectedMessage));
```

I mentioned try message.contains because I think that the phrase "iMessage" will be also available in message! Check it.  

#### Answer 3 (score 1)
I look to use css first and for the elements and attributes I try to be as specific as needed without being overly specific and tying myself into page structure.  In this case I would consider using:  

```
success_message=driver.findElement(By.css(".content-wrapper .callout-success"))
```

along with  

```
success_message.contains('the text')
```

<p>This assumes that you don't have access to change the HTML source.
If you do have that access I recommend you add semantic markup.  Currently the page markup is mostly about the placement and appearance, e.g. `content-wrapper` and `main-sidebar`.  These things will change over time (both in their usage and names) so  I would look to add attributes about the mean of the content, e.g. a `div#institutions` tag and a `div.feedback_message` tag within it.  Also tag the 'deleted' message itself so you aren't asserting the specific text which may change or be in another language.</p>

Then you can do a find and assert that looks like:  

```
Assert.assertTrue(driver.findElement(By.css(".institutions .feedback .deleted")
```

and you can see how readable that is - essentially " institutions feedback  'deleted' " exists, with no need for additional comments and robust against changes in both the future page layout and also the text used.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Why can't we use Selenium Webdriver to test Angular JS sites? (score [49527](https://stackoverflow.com/q/18438) in )

#### Question
If we look at the Protractor architecture, Protractor uses WebDriver JS to call Selenium Webdriver which ultimately calls browser driver and then browser. Now since Selenium is passing commands to browser driver why can't we just use Selenium to automate Angular pages ?  

#### Answer 2 (score 15)
I do use Webdriver to use Angular pages. So it <strong>IS</strong> possible, and OP's assumption is wrong.  

But it is not easy - not as straightforward as using WebDriver to automate more traditional web pages (which do not use "single page application" concept and DOM manipulation so heavily), where is trivial to add id or name to any element you want.  

Angular uses IDs heavily for interaction and DOM manipulation. As a result, WebDriver tests cannot rely on IDs to locate elements, and locating by name is bit more hassle (non-unique etc). But you can still write tests using WebDriver (that's how Protractor does it after all, under the skin).  

WebDriver tests are Angular-agnostic, they know nothing about Angular and the complicated machinery on the page it uses to manipulate DOM.  

Protractor understands Angular and this allows developers to write Protractor-based tests bit easier - and as always, for the price.   

In this case, price is writing tests in JavaScript, quite quirky language full of hidden traps, which many prefer to avoid :-) For a good summary of the traps, see <a href="https://bonsaiden.github.io/JavaScript-Garden/" rel="noreferrer">JavaScript Garden</a>  

I would assume (based on our experience) developers choose to develop low-level tests in Protractor/JavaScript (to use internals of Angular), but e2e tests in some other less quirky language (in our case, Python), to increase productivity and decrease flakiness. Usually, they already have (or better should have) framework/approach to write e2e tests for non-Angular pages, so pure WebDriver tests for Angular pages are consistent with other e2e tests.  

<strong>Edit (April 2018)</strong>: Angular2+ is a significant if sneaky change over AngularJS. Angular2+ does not support some AngularJS-specific locator strategies anymore (and has no plans to implement them), so there is even less incentives to use JS (beyond JS unit-tests of Angular stuff). So when talking/reading about "the Angular" you need to be aware which version we are talking about, they are significantly different.  

Our current strategy is to implement Angular2+ unit-tests (model, basic manipulation), and also single happy-path UI test in JS. More comprehensive UI tests will be in Python/WebDriver. Yes, it is slight duplication of work (locators are both in JS and Python, but locators are trivial). We prefer Python, have lots of code in it, including testing tools/fixtures, which are easier to call from Python than from JS, so we think it is the best compromise.  

<strong>&lt;/edit></strong>  

That is why I asked OP about any hands-on experience. For any person with hands-on experience with writing both WebDriver and Protractor tests, it is a matter of taste and preferences.  

If someone loves JavaScript, or JavaScript in main/preferred language for the tested application, there is no reason to avoid Protractor. If you prefer NOT to use JavaScript, you know why you want to avoid it, so you do. :-)  

... And I am involved in yet another Holy War, people who do like JavaScript are downvoting this answer, because I am not equally in love with in their preferred language. Even if I explained what are the exact reason I decided to skip over Protractor (and missing on the benefit from some of it's good features), while using WebDriver to test Angular pages, exactly as OP asked. I thought that first paragraph will cover it, but apparently it was not enough. :-/  

#### Answer 3 (score 2)
<strong>Selenium WebDriver is a tool/library that enables automation, whereas Protractor is a Test Runner/Test Framework which defines the design/structure of the automation.</strong>  

If your tests are flaky, it might need deeper analysis to determine the cause of flakiness. I've been automating AngularJS applications using SerenityBDD and Selenium WebDriver for almost over 3 years now. I run ~2000 test cases on 5 VMs using Selenium Grid which are integrated with CI tool. Flakiness on the development branch is high as we test under development features, whereas on the production branch is extremely low as the build is stable.  

Selenium WebDriver might have sync issues with the AngularJS application, but that should not limit/restrict us from functional testing. Flaky tests can be fixed by introducing custom waits, catching known exceptions, soft assertions and retrying failed test steps a couple of extra times to ensure sync.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: how to get the count of elements in list box (score [48563](https://stackoverflow.com/q/9348) in )

#### Question
<p>working on selenium + java,. can any one help me...
I have a drop down list box, and need to get the number of elements in the list box.</p>

```
<select id="id">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
</select>
```

need to get the count, ie, 3..... thanks and in advance  

#### Answer accepted (score 1)
In watir, this can be accomplished in one line:  

```
browser.select_list(:id=> 'id').options.count
```

#### Answer 2 (score 4)
Try this , storing all the Web elements of Select list in a List and then getting its size.   

```
List<WebElement> optionCount = driver.findElements(By.xpath("//select/option"));
System.out.println(optionCount.size());
```

Thanks.  

#### Answer 3 (score 1)
```
WebElement selectElement = driver.findElement(By.id("id"));
Select listBox = new Select(selectElement);
int size1 = listBox.getOptions().size();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: What are the possible test scenario's to test a Text field? (score [48300](https://stackoverflow.com/q/8067) in )

#### Question
Consider the text field accepts alpha-numeric characters. What could be some unique and out of the box test scenario's/cases that could be useful in finding an important defect.  

#### Answer 2 (score 3)
It depends on what the text field is supposed to accept and what it's for.   

If it's meant to accept specific formats of data, your tests will be different than if it's meant to accept free-form data. For example,  text fields are often used for postal code entry. For that, there's likely to be validation that the postal code format matches the official format for the country (USA: xxxxx or xxxxx-xxxx where x is any number, Australia: xxxx where x is any number - those are the only two I know offhand).   

Some other considerations:  

<ul>
<li>Is there a way to get invalid input into the field? Most browsers will allow drag and drop or copy/paste into fields: this is a common way to put invalid data into a field. The key thing is to handle the invalid input gracefully.</li>
<li>Is there a way to override the field length limitations? Copy/paste and drag and drop can do this. I've also seen holding down a key do it, particularly if a control key is involved.</li>
<li>Are there limits on the characters the field should accept? If you're limiting to English alphanumeric, the field needs to handle other characters gracefully.</li>
<li>Special character handling - does the field handle characters that have specific meanings in HTML, JavaScript, the back-end programming language used, SQL? Does it handle leading spaces? <em>Should</em> it handle leading spaces?</li>
</ul>

#### Answer 3 (score 2)
Do you have some requirements at first about text field? There are some basic checks:  

<ul>
<li>Check possibility to input minimum number of symbols</li>
<li>Check possibility to input maximum number of symbols</li>
<li>Can you input uppercase and lowercase together?</li>
<li>Can you input special symbols?</li>
<li>Can you copy and paste inside text field?</li>
<li>Check different unicode symbols</li>
<li>Check cyrillc</li>
<li>Check arabian</li>
</ul>

Etc. I hope this tips could help you.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: Compare screenshots of rendered web pages (score [48270](https://stackoverflow.com/q/2459) in 2017)

#### Question
In my team, we use Selenium for automation of functional testing. We also do a lot of manual regression testing to make sure the appearance of the rendered web pages is ok. I would like to develop a framework, that would allow comparing screenshots of the "base" live web page, and the web page on the test server after applying the software update. I believe this will drastically reduce the amount of manual regression testing we need to do.   

I would like the framework to be able to detect portions of web pages that were rendered differently from each other. An example of such functionality can be <a href="http://expression.microsoft.com/en-us/dd565874" rel="noreferrer">seen here.</a> (first image in the article)  

I have never worked with image processing and would need ideas on what algorithms are already publicly available that would help me with the task. From what I can see, the simple pixel-by-pixel comparison would not work well, because it does not account for the concept of elements.  

Or am I approaching this problem from a completely wrong direction?  

#### Answer accepted (score 17)
I'd take a look at Google QualityBots.  It's generally used for comparing websites on multiple versions of Chrome, but looks very similar to what you are trying to do. I personally haven't had time to try it out myself mainly because of its use of EC2 machines. Other than that, it is open source.  

<ul>
<li><p>Here is an article about it on <a href="http://googletesting.blogspot.com/2011/10/unleash-qualitybots.html">Google's testing Blog</a> </p></li>
<li><p>And the <a href="http://code.google.com/p/qualitybots/">project page</a></p></li>
</ul>

#### Answer 2 (score 9)
<a href="http://www.imagemagick.org/script/index.php" rel="nofollow">Imagemagick</a>, a cross-platform imaging library and command line tool,  has functions that can be used to compare images. A team I worked on circa 2012 used it with pretty good success to determine if two images differ. We had built a GUI with the same library that could pull the two images up side by side and highlight the differences for a human to decide whether the differences are significant.   

#### Answer 3 (score 3)
Here is a tool that will make visual comparison of different versions of your website <a href="https://github.com/bslatkin/dpxdt" rel="nofollow">dpxdt</a>. Here is a video explaining how the tool works and how to use it: <a href="https://www.youtube.com/watch?v=UMnZiTL0tUc" rel="nofollow">The Secret to Safe Continuous Deployment</a>.  

And finally, <a href="http://ruoyusun.com/2013/08/10/implementing-pdiff-with-existing-selenium-tests.html" rel="nofollow">here is a guide</a> how to implement it with Selenium.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: How to get value of text wrapped in paragraph element \<p> with Selenium in Java (score [47877](https://stackoverflow.com/q/26962) in 2019)

#### Question
I have a button, clicking on it generates a number which is wrapped in paragraph text such as `<p>`random number `<p>` , I want to get that random number value and do operations based on number it generates.  

From below I need to get 34,756 number and store it in Java.  

Here is the HTML code for it:  

```
<div class="form-group">
<div class="alert alert-count">
  <p>
  <b>
<!-- react-text: 531 -->
<!-- /react-text -->
<!-- react-text: 532 -->
 34,756
<!-- /react-text -->
</b>
```

  
   <br/>
   <p>
   
   </p>

And the XPath I used is as below:  

```
String count = driver.findElement(By.xpath("//div[@class='alert alert-count']/p).getText();
```

But on console it gives error as:  

<blockquote>
  Exception in thread "main" java.lang.NullPointerException  
</blockquote>

#### Answer 2 (score 2)
Your example code is missing a `"` and a `)` in the `By.xpath`. Guess you would get a syntaxError so your real code might be correct.   

Do you wait for the element, because I think the `findElement` returns no object ( e.g. NULL) when it is not displayed (yet) and called `getText()` on a NULL is not possible , resulting in the `NullPointerException`. Read: <a href="https://stackoverflow.com/questions/20903231/how-to-wait-until-an-element-is-present-in-selenium">https://stackoverflow.com/questions/20903231/how-to-wait-until-an-element-is-present-in-selenium</a>  

Keep in mind findElement does not wait for the element, it just fails instantly.  

#### Answer 3 (score 1)
I think the there is a problem with the provided XPath, you are navigating to the paragraph tag `(<p> tag)` and fetching the text, I suggest you navigate to the bold tag `(<b>tag)` and fetch the respective value, like the following:  

```
String count = driver.findElement(By.xpath("//div[@class='alert alert-count']/p/b")).getText();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: Should I learn Python or Java to get into test automation? I am new to programming (score [46466](https://stackoverflow.com/q/7726) in 2014)

#### Question
Should I learn Python or Java to get into test automation?  

I'm new to programming. Please share your thoughts or links to any useful information.  

#### Answer 2 (score 5)
Since you are looking into Selenium (as a test framework) start with Java, because Googling on "Selenium/Webdriver issue description" will often result in Java examples that you can re-use. There is just more people doing Selenium with Java then Python. Also Selenium it-self is mainly written in Java.  

For a project I would learn the language the application (under test) is written in. As a tester your are often not a hardcore programmer, thus if you need assistance with the test automation its ideal if the team can help you in a language they use on a daily basis and have the most experience with. This will also increase the adoption and extension of your tests by the developers, they will have to maintain/extend the tests in the end probably.  

If your learning preference is from books I suggest "<a href="http://www.goodreads.com/book/show/71672.Thinking_in_Java" rel="nofollow noreferrer">Thinking in Java</a>" each chapter has great programming challenges to make sure you understand and can apply the theory. Also it explains everything in great detail.  

<p><strong>Update</strong>:
Also Java looks a lot C++ and thus also C#. If you look at <a href="https://www.tiobe.com/tiobe-index/" rel="nofollow noreferrer">the most popular languages</a> the C derivatives are most popular. Learning Java will make it easier to switch to other languages.</p>

#### Answer 3 (score 2)
<p>I'm a fan of the Udacity classes:
Computer Science 101: uses (and teaches) Python basic CS concepts, while building a search engine: 
<a href="https://www.udacity.com/course/cs101" rel="nofollow">https://www.udacity.com/course/cs101</a></p>

<p>Software Testing: Teaches testing, by writing Python test code
<a href="https://www.udacity.com/course/cs258" rel="nofollow">https://www.udacity.com/course/cs258</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: What is a good KPI for software QA? (score [46308](https://stackoverflow.com/q/3381) in 2016)

#### Question
How can you measure the efficiency of the QA team?   

What KPIs would you set up?  

#### Answer 2 (score 31)
KPIs can be dangerous - it's very easy to measure the wrong thing or worse, reward the wrong thing. The general rule is that people will do more of the things that get rewarded.  

Some of the things you should consider:  

<ul>
<li>If you use the number of bugs raised by the team, you will see bugs raised for things like misplaced pixels. Modifying this to use the number of bugs above a specified severity level will get your misplaced pixels classified to urgent.</li>
<li>Using the number of bugs tested or cleared as a KPI tends to encourage testers to be less thorough and focus on checking that the bug as described is fixed without touching anything that might affect their statistics.</li>
<li>Throughput of testing per person is equally dangerous: the temptation to test less thoroughly in order to meet the standard set for the indicator will arise.</li>
<li>Any metric you use will be heavily dependent on context - a tester working with a developer who unit tests thoroughly, makes sure his integration is clean and checks that he's doing the right thing will not find many bugs in that developer's work. A project that's had its timeline cut to meet an external deadline will generate more bugs and have more bugs reach the customer than one that's been well-planned and executed without major time or resource stress.</li>
<li>No one metric can capture the complexities of testing. Who is doing the better job, the tester who works through a complex new feature and finds a dozen severe bugs in a week, or the tester who works through a complex new feature and finds one catastrophic bug in that week? The answer is neither: both testers are finding information that needs to be surfaced, but the information they find differs because they're working in different areas with different developers.</li>
<li>Almost no-one has the resources for multiple testers to perform the same tests against the same software. That means that no measurement can capture performance because there is nothing that can be directly compared. There are too many variables involved, including how much pressure the tester is under to finish testing so the software can be released (no, this isn't ideal, but it's how it works in a lot of places).</li>
<li>No matter what measure you use, it's best to use it as an informational tool: this team averages this much testing for this many bugs so if we're going to use them we need to schedule this much time. Using a metric to rank your testers will give you results that are... less than you desired.</li>
</ul>

I hope this list helps you decide what you need to do.  

#### Answer 3 (score 19)
The best KPI's for testing are ones that you wouldn't expect.  

<ul>
<li>Can the team ship with a boring level of predictability ?</li>
<li>Are customers happy ?</li>
<li>Is the product selling ?</li>
<li>Are there very few critical issues found in production ?</li>
<li>Are budgets and schedules being met ?</li>
</ul>

These co-incidenty are 'whole of team' KPI's which testing plays a key part of.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: Navigate to previous page using Selenium (score [46246](https://stackoverflow.com/q/8737) in )

#### Question
I know there's a  

```
driver.navigate().back()
```

but that's not what I'm looking for.  

Let's say a user is on PageA, they click on a submit button which takes them to a submit page. On that page, there are two buttons: change selection and confirm. Confirm takes them to the next page, but change selection takes them back to the page they were on.  

It's not always going to be PageA, a user can be on PageB, PageC, etc. So, I was wondering if there is a way to return the PageFactory of whatever page the user was previously on? I haven't been able to find anything so far  

#### Answer accepted (score 3)
I had a similar issue; I wanted a base class for my PageObjects that abstracted the navigation between pages in the wizard flow. What I ended up doing was, after clicking any link that would navigate to a new page, I grabbed the current URL and constructed a new page instance based on that to return. Something like:  

```
protected PageObject navigate(WebElement button) {
    button.click();
    PageObject nextPage = getPageFromURL(driver.getCurrentUrl());
    PageFactory.initElements(driver, nextPage);
    return nextPage;
}
```

where getPageFromURL has a big lookup table of URLs to PageObject classes. Then I could implement meaningful methods like:  

```
public PageObject clickNext() {
    return navigate(nextButton);
}
```

or:  

```
 public PageObject viewProductDetails(Product p) {
    return navigate(getDetailsButton(p));
}
```

I hope that helps you with architecting a solution!   

#### Answer 2 (score 7)
You can use JavaScript to go back one step in the history of the browser, this should bring you back on the previous page.  

```
driver.executeScript("window.history.go(-1)");
```

See <a href="http://www.mkyong.com/selenium/how-to-execute-javascript-in-selenium-webdriver/" rel="noreferrer">using JavaScript with Selenium</a> and <a href="http://www.w3schools.com/jsref/met_his_back.asp" rel="noreferrer">JavaScript History functions</a> links.  

Also see <a href="https://code.google.com/p/selenium/issues/detail?id=3611" rel="noreferrer">this thread</a> about issue and difference with navigate.back()  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: Selenium: How to access the same session in a new window? (score [45659](https://stackoverflow.com/q/15594) in 2017)

#### Question
I am using selenium webdriver with Java.   

My test needs to verify when you save your login information and close the browser and reopen it then those credentials remain and are saved on a new session. So I want to close the current session and reopen it in order to verify if a cookie persists on the page however Selenium deletes all stored session data so the test case will always fail. Is there any way to prevent Selenium from deleting the stored session data after closing the browser for the specific test case?  

When I do run it I get a no such session error.  

#### Answer accepted (score 15)
Well, I believe you cannot prevent deletion of Session data once you close the browser. But, you can store the cookies of your first instance and copy it to new instances using a `driver.manage().getCookies()` method.  

Before calling `driver.close(`) method in your test, make sure to save the cookies using following piece of code :  

```
Set<Cookie> allCookies = driver.manage().getCookies();
```

The above `allCookies` variable you can define global as you wish.  

So for next instance onward,in the beginning of your test use the below piece of code :  

```
driver = new FirefoxDriver();
for(Cookie cookie : allCookies)
{
    driver.manage().addCookie(cookie);
}
```

Now this will copy all cookies present earlier to this session, so after this proceed with further logic as per your requirements.  

#### Answer 2 (score 1)
Well the session of a web driver instance is over once that particular instance is closed. Thus you can't access the session of the previous instance in a new one. However you can still achieve the session by storing the session value in a variable and then adding the session in the new instance. Look at the below mentioned code for better understanding:  

```
public void useStoredSessionInNewWindow() {
 // initiate web driver and go to an website
 _webDriver = new FirefoxDriver();
 _webDriver.navigate().to("www.abc.com");

 // add code to login in the website

 // store the current session
 Set<Cookie> cookiesInstance1 = _webDriver.manage().getCookies();
 System.out.println("Coockies = "+cookiesInstance1);

 // close the web driver instance
 _webDriver.close();

 // again initiate web driver and go to the same website. This will open the login page
 _webDriver = new FirefoxDriver();
 _webDriver.navigate().to("www.abc.com");

 // add the stored session in the bew web driver instance
 for(Cookie cookie : cookiesInstance1)
 {
  _webDriver.manage().addCookie(cookie);
 }

 // re-visit the page
 _webDriver.navigate().to("www.abc.com");

 // get the current session of new web driver instance
 Set<Cookie> cookiesInstance2 = _webDriver.manage().getCookies();
 System.out.println("Coockies = "+cookiesInstance2);

 // notice that session of previous web driver instanse is achieved
 Assert.assertEquals(cookiesInstance1, cookiesInstance2);

 }
```

Hope this helps :)  

#### Answer 3 (score 0)
you could try using an implicitly specified profile path - then all data that your browser would have saved in a real-life situation when you close the browser will still be saved.  

```
options.addArguments("--user-data-dir=" + PROFILE_PATH);
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Handling browser level authentication using Selenium (score [45145](https://stackoverflow.com/q/2755) in 2012)

#### Question
I am automating an application which contains browser level authentication.  

When I open the application, the browser performs basic authentication, i.e. it prompts for a username and password.  How can I handle this scenario using Selenium?  

#### Answer 2 (score 11)
<p>Use<br>
`http://username:password@site.com/page`<br>
instead of<br>
`http://site.com/page`.</p>

#### Answer 3 (score 3)
Here one method of handling, Create browser profile and check remind password. By calling the profile before the execution, It won't ask you the authentication next time onwards. Let me know if it doesn't work.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: "Element is no longer attached to the DOM” StaleElementReferenceException when selecting HTML table row (score [44623](https://stackoverflow.com/q/3464) in 2012)

#### Question
I am using Selenium 2/WebDriver for automation. I have a table and am trying to select a row in it. When the test runs, I can see the row become highlighted as if it is clicked, but then immediately I get the `"org.openqa.selenium.StaleElementReferenceException: Element is no longer attached to the DOM"` error and the test fails.  

The code is the following:  

```
@Test
public void rowSelection() throws Exception
{
    SeleniumHelper helper = new SeleniumHelper();
    action = new SeleniumActionHelper(driver);

    helper.login();

    String testUrl = navigateToUrl("option/listOptions.xhtml");
    driver.get(testUrl);

    WebElement table = findElementById("tableSection:dataTableWrapped_data");
    List<WebElement> allRows = table.findElements(By.tagName("tr"));
    for (WebElement row : allRows)
        {
            List<WebElement> cells = row.findElements(By.tagName("td"));
            for (WebElement cell : cells)
            {
                WebElement listName = cell.findElement(By.xpath("./* [text()='body_build']"));
                listName.click();
            }
        }
}
```

I have put a `Thread.sleep(2000)` in front and after the `listName.click()` action, but neither has helped. Any help would be greatly appreciated.  

#### Answer accepted (score 6)
I think that your page (or part of it) is reloaded after performing `listName.click()`.   

<p>After reload there is also a table which seems to be same as that one from before reloading but it is not the same one. 
You can count rows/columns in the table and use iterators in your loops. You will need to repeat </p>

```
WebElement table = findElementById("tableSection:dataTableWrapped_data");
List<WebElement> allRows = table.findElements(By.tagName("tr"));
```

after   

```
listName.click();
```

#### Answer 2 (score 2)
<strong>Two reasons for occurrence of Stale element</strong>  

<ol>
<li><p>An element that is found on a web page referenced as a WebElement in WebDriver then the DOM changes (probably due to JavaScript functions) that WebElement goes stale.</p></li>
<li><p>The element has been deleted entirely.</p></li>
</ol>

When you try to interact with the staled WebElement[any above case], the StaleElementException is thrown.  

<strong>Solutions to resolve them:</strong>  

<ol>
<li><strong>Storing locators to your elements instead of references</strong></li>
</ol>

<em>DON'T</em>  

```
driver = webdriver.Firefox();
driver.get("http://www.github.com");
search_input = driver.find_element_by_name('q');

search_input.send_keys('hello world\n'); // Page contents refresh after typing in search results.
time.sleep(5);

search_input.send_keys('hello frank\n'); // StaleElementReferenceException
```

<em>Do</em>   

```
driver = webdriver.Firefox();
driver.get("http://www.github.com");
search_input = lambda: driver.find_element_by_name('q');
search_input().send_keys('hello world\n'); 
time.sleep(5);

search_input().send_keys('hello frank\n') // no stale element exception
```

<ol start="2">
<li><p><strong>Leverage hooks in the JS libraries used</strong></p>

```
# Using Jquery queue to get animation queue length.
animationQueueIs = """
return $.queue( $("#%s")[0], "fx").length;
""" % element_id
wait_until(lambda: self.driver.execute_script(animationQueueIs)==0)
```
</li>
<li><p><strong>Moving your actions into JavaScript injection</strong></p>

```
self.driver.execute_script("$(\"li:contains('Narendra')\").click()");
```
</li>
<li><p><strong>Proactively wait for the element to go stale</strong></p>

```
# Wait till the element goes stale, this means the list has updated
wait_until(lambda: is_element_stale(old_link_reference))
```
</li>
</ol>

This solution, which worked for me, I have mentioned here if you have any additional scenario, which worked for you then comment below or contact me so that we can add into solution list  

#### Answer 3 (score 0)
Any chance we could see the page you are trying to automate?  I can think of one reason, which is that the way the table was developed is that there is javascript that when the element is interacted with rather than modifying the element instead it replaces it with a new element, in which case that element would no longer exist...    

If you use something like firebug in firefox or IE developer tools to view the dom, does the element in question change when hovering over it?  If the developer is in fact replacing the element instead of modifying it's class, that would be a very odd implementation and I would argue you should file a bug and have them change the way it's implemented.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: What programming languages are good for novice testers to learn? (score [43387](https://stackoverflow.com/q/1674) in 2016)

#### Question
I'm looking for a programming language to recommend to a friend considering teaching herself software testing.  I have a friend who is interested in learning software testing, and I believe strongly that today's testers absolutely have to have automation skills if they don't want to hit a glass ceiling after a few years (or become super-star exploratory testers . . . but not everyone wants the stress of <em>having</em> to be a super-star).  

I can't look to my own experiences, because I did a 4-year CSE degree that was geared toward developers, and my education isn't light-weight enough.  I want something relatively easy to learn that will give the tester the greatest bang for their buck in developing good, maintainable automation.  

I know Ruby is used for a couple of test tools - Watir and Cucumber - and something that works with Selenium, WatiN, or Watir would be good.  The two favorite languages locally for developers seem to be Java and C#, and she will be working locally.  Whatever she learns needs to have good resources for novices at programming to self-teach, whether those be books, online tutorials, or online communities.  Something that isn't too expensive to learn would probably be preferred ('free IDEs are available and there are good free tutorials and information to learn from' is ideal).  Also, something that is harder to write bad code in would be good, since I want her to be able to avoid brittle, unmaintainable tests.  She is highly motivated to learn, so a <em>very</em> useful language that will take 6 months of hard work to get a usable level of skill is preferable to a slightly useful language that she could use in a single month.  At the same time, any time she spends learning to program is time she could be spending practicing exploratory testing or learning other great test skills - so ease of learning does matter.  

<blockquote>
  Also - I do realize that programming is one very small piece of being a good tester.  I just have a better handle on self-teaching the rest of the testing skills, since I self-taught myself those areas and can pass on what worked for me or what I wish I'd known.  I don't want anyone to think I believe you can learn to be a good tester by just learning to program; rather, I just don't have a good handle on the easiest way to start programming as a tester since I started testing as a programmer.  
</blockquote>

#### Answer accepted (score 20)
I kind of have the opposite experience: I learned some coding first then became a tester. My advice is that <strong>any</strong> programming/coding experience is beneficial for testing. Any way you can better understand what the application is doing in front of you, the better you can test it. Plus, specific tools and languages come and go in use and popularity: learning the fundamentals will age quite well in the long run.   

Programming languages comes in all shapes and sizes, but have some main things in common (usually) so seeing more is good. Plus if she's willing to learn, then larger ideas such as Object Oriented Programming, web and command scripting, programming style and code reuse will be helpful overall. Definitely look at scripting languages like Python or Perl: they can be indispensable for daily testing tasks.   

As for specific suggestions, Python is a good language to start with. It's easily available and platform independent, which is great in the long run. It also has some mature testing tools (nose, unittest) and a large range of other libraries and tools (BeautifulSoup for HTML processing, Selenium tools). It also has a good community for help, and straightforward syntax. I've also heard good things about Ruby for similar reasons, and maybe the testing tools (Watir in particular) are more mature. I've recently learned a small bit of C#, and it's good as well.  

#### Answer 2 (score 11)
I don't think any specific language is better or worse than any other, although I will say (from experience) that going from Java or any other "pointerless" language to one that does have pointers is not a pleasant experience.  

Apart from that - the important parts of automation and coding are recognizing the problem that the code needs to solve, and being able to express the solution in a way that can be handled with a logical series of steps.   

Object-oriented and data-driven are nice ways to handle the data that drives the steps, but the core is finding the bits the automation has to interact with, and the logic processing.  

My recommendation here would be to pick something that's got a lot of support and wide application, make sure the logical structures are learned (if-else, case statements, the various looping types and so forth), and it won't matter past what's currently most practiced what the language is.  

I learned programming this way, and I've never had much difficulty picking up new languages (I first learned Java, then Javascript with HTML, various other scripting languages, VBScript with ASP.NET, and I'm currently working with a script flavor of Delphi)  

#### Answer 3 (score 9)
I would recommend a slightly different approach. Rather than initially focusing on a particular language, I would recommend focusing on programming concepts.  

Some good books include <em>Programming Langugae Concepts</em> by Carlo Ghezzi, or <em>Prelude to Programming: Concepts and Design</em> by Elizabeth Drake. (Another great book is <em>Programming in the Key of C Sharp</em> by Charles Petzold. It uses C# to teach programming concepts.)  

If someone learns the semantics of basic operations, and the basics of data types, control structures, program design, and data structures then learning a particular language is reduced to learning the syntax for that language.  

You don't learn to think or rationalize ideas by simply learning how to repeat words in another language.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: Components of a Test Plan document? (score [43117](https://stackoverflow.com/q/14385) in 2016)

#### Question
What are the most important components/parts of a well-written test plan document for a testing project. Consider you are testing a Financial web app.  

Is test plan a part of overall test strategy document? Are the 2 documents merged in commercial testing projects.  

Please provide a real world, test plan document , if possible.  

#### Answer 2 (score 6)
<blockquote>
  What are the most important components/parts of a well-written test plan document for a testing project. Consider you are testing a Financial web app.  
</blockquote>

As per IEEE 829 standards, the components of a Test Plan document should be :  

<ul>
<li>Test Plan identifier</li>
<li>References</li>
<li>Introduction</li>
<li>Test Items</li>
<li>Risks </li>
<li>Items to be tested</li>
<li>Features excluded for testing</li>
<li>Testing Approach</li>
<li>Test Pass and Fail Criteria </li>
<li>Resumption/Suspension Criteria</li>
<li>Test deliverables</li>
<li>Test Environment Set Up</li>
<li>Training and Staffing </li>
<li>Team Member Responsibilities</li>
<li>Testing Schedule</li>
<li>Planning for Risks and Contingency Plans</li>
<li>Approvals</li>
</ul>

You can read in detail about this here : <a href="http://www.fit.vutbr.cz/study/courses/ITS/public/ieee829.html" rel="noreferrer">IEEE 829</a>  

However it is not mandatory to include each and every thing mentioned here. I have seen many test plans missing many components from this check list. In commercial companies ( like MNC's) , there is a specified custom format, which is roughly based on these standards ( or any standard that the company follows).  

<blockquote>
  Is test plan a part of overall test strategy document? Are the 2 documents merged in commercial testing projects.  
</blockquote>

A test strategy defines the overall testing approach to be followed during the testing and as such, it should be a different document, a high level definition of the testing that we are going to follow. However, it is not an unfamiliar situation, when test strategy is defined inside the test plan itself ( a practice in my current organization).  

Since we are talking about an overall strategy here, so Test Plan would be an essential part of a test strategy. You can have a single high level Test Strategy document for a project and then have various test plans, which are created as per the test strategy.  

A very good documented example would be <a href="http://www.testingexcellence.com/test-strategy-and-test-plan/" rel="noreferrer">this</a>.  

<blockquote>
  Please provide a real world, test plan document , if possible.  
</blockquote>

You will find a lot of such test plans on internet. A good place would be <a href="http://www.coleyconsulting.co.uk/testplan.htm" rel="noreferrer">this</a>  

#### Answer 3 (score 3)
<p>Below are the components of a test plan, which should be included.
1. <strong>Summary</strong></p>

1.1. <strong>Introduction</strong> - Provide an overview of this document in this section  

1.2. <strong>Scope of testing</strong> - The scope of testing needs to be clearly defined. The plan should define items / features that are in scope or out of scope for the testing phase.   

```
- 1.2.1. **Features To be tested** - All features/use cases which are to be tested

- 1.2.2. **Features Not to be tested** - All features which are not to be tested

- 1.2.3. **References** - SRS, BRD, FRS references used for the scope
```

1.3. <strong>Milestones</strong> - List down all the minor and major milestones along with planned start and end dates  

1.4. <strong>Deliverables</strong> - List down all the deliverables from the testing phase along with their acceptance criteria  

<ol start="2">
<li><p><strong>Resources</strong> - Mention all the physical and non-physical resources that will be used</p>

2.1. <strong>Hardware</strong> - List down the hardware requirements for the testing phase  

2.2. <strong>Environment details</strong> - Provide a list of the various environments that will be used for the testing phase along with their purpose and configuration details.  

2.3. <strong>Testing tools</strong> - Provide a list of the tools that are required for this phase.  

2.4. <strong>Team composition</strong> - List down the names of the team members who will be involved in the testing phase, along with their roles and responsibilities  

2.5. <strong>Training Requirements</strong> - If any skill set or training is required  </li>
<li><p><strong>Test Strategy</strong> - Describe the testing strategy which will be followed in the project. Also, define the different types testing.</p>

3.1. <strong>Types of testing</strong> - List out different types of testing that will be conducted in the testing phase. Elaborate the different testing specifications given by the customer and provide details on how different types of testing would be conducted  

3.2. <strong>Entry and Exit Criteria</strong> - Write down the entry and exit criteria of the testing phase i.e. when you will start testing and when you stop testing.  

3.3. <strong>Suspension and Resumption Criteria</strong> - Use this section to write down the suspension and Resumption during the testing phase.  

3.4. <strong>System Acceptance Criteria</strong> - Use this section to describe the system acceptance criteria based on which the project acceptance will be received  </li>
<li><p><strong>Test Planning</strong></p>

4.1. <strong>Test Schedule</strong> - Use this section to document the detailed test plan. This would include a detailed work breakdown structure (WBS) of all activities related to testing along with resources.  

4.2. <strong>Test Design</strong> - Use this section to document the procedure for preparing test cases. Explain the various fields of the test cases. Expand this section to include the process for review and approval of test cases and how the documents will be shared among stakeholders.  

4.3. <strong>Test Execution</strong> - Use this section to detail the process that will be followed for testing - how testing would be conducted, and how testing results would be captured and shared.  </li>
<li><p><strong>Bug Tracking Process</strong> - Use this section to describe the process for recording bugs found during the various testing cycles and the workflow for tracking these bugs to closure. This section would also provide details as per the sections below.</p>

5.1. <strong>Bug tracking tool</strong> - Detail about the tool being used for defect logging and tracking  

5.2. <strong>Bug reporting</strong> - Provide details of the various fields against which information needs to be entered while reporting a bug.  

5.3. <strong>Bug lifecycle</strong> - For example: New/raised --> open/assigned --> resolved/fixed --> closed/verified. Also, specify who will be responsible for conducting triage meetings and how any conflicts will be resolved.  </li>
<li><p><strong>NFRs Testing</strong> - Use this section to define plan for the Non-functional testing like Performance, Security, Usability etc.</p>

6.1. <strong>Tools used for NFRs</strong> - name of the tools  

6.2. <strong>NFR Goals</strong> - Mention all the goals for performance testing for Response time, Throughput etc.  </li>
<li><p><strong>Risk Management</strong> - Use this section for documenting the risks involved in testing and their Mitigation plan. Assign priority and impact to all risks.</p></li>
<li><p><strong>Reporting and Communication Plan</strong> - Write down the reporting and communication plan for the testing phase. Identify Key contact personnel from both on-site and off-shore teams and representatives from the client side.</p></li>
<li><p><strong>Measurement Plan</strong> - List down the metrics that will be used to track the progress of the testing phase and assess whether the objectives of this phase have been met or not. Like Defect Leakage, Defect Removal Efficiency etc.</p></li>
<li><p><strong>Assumptions and Dependencies</strong> - List out the assumptions and dependencies associated with this phase and any risks that may exist pertaining to these.</p></li>
<li><p><strong>Appendix</strong> - Use this section to provide expansion of abbreviation and attach reference documents and templates</p></li>
</ol>

<strong>Is test plan a part of overall test strategy document?</strong>  

Test Plan and Test Strategy can be separate documents and sometimes they are merged together. This all depends upon the person creating these documents and scope of the application. If project is bigger in size and a complete testing project then it make sense to have different documents, else create a single document for both. <a href="http://www.geekinterview.com/talk/9651-test-strategy-vs-test-plan.html" rel="nofollow">Difference</a> in Test plan and Test strategy document.  

These are the simple steps to be taken care of for creating a <a href="http://www.softwaretestinghelp.com/writing-test-strategy-document-template/" rel="nofollow">Test Strategy</a> document.  

Refer this link for the test plan <a href="http://www.softwaretestinghelp.com/test-plan-sample-softwaretesting-and-quality-assurance-templates/" rel="nofollow">samples and components.</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: How to run all Selenium test cases via batch file (score [42585](https://stackoverflow.com/q/11837) in )

#### Question
I am a noob in Java and automation so please bear with me if I get the terminology wrong.  

I have a class file that can open a browser and navigate to google.com and then closes the browser. There’s another class file that does the same but goes to yahoo.com.  

I can run this from eclipse and everything works fine.  

However,  I need to know if I can run both the test cases one after the other without opening Eclipse and only by using batch files (.bat files) on Windows.  

I would appreciate a clear step by step instruction. Thanks in advance.  

#### Answer 2 (score 3)
I would suggest just exporting a jar file for your project. All the libraries will be packaged together in the jar files(including TestNG) and you can simply double click on the jar file to start your tests. Make a runner file that calls all the tests you have to run one by one.  

External resources (if any), will have to be available for the jar file though. The external resources might include your test data (if any) or Portable browsers (example portable firefox).  

<strong>Steps</strong>:  

<ul>
<li>Right click on Project -> Export -> Runnable jar file</li>
<li>Give a name and file path for the jar file</li>
<li>Select option - <em>Extract required libraries into generated JAR</em></li>
<li>And Finish</li>
</ul>

<strong>Troubleshooting</strong>:  

Check the java version for the machines that you will be running your jar file on. Programs compiled with java 7 will mostly not run if the machine has java 6. Either compile with java 6 or update the jre on the target machines.  

If the jar file does not launch, try using Jarfix.  

#### Answer 3 (score 2)
I'm not sure what testing library (if any) you are using to execute the tests; I'm going to assume jUnit here, because that's what most people use for testing in Java. Similarly, I'm not sure if you're using ant or maven with this project.  

<h5>Using JUnit</h1>

You can invoke the JUnit test runner from the command line using the following:  

`java -cp .:/usr/share/java/junit.jar junit.textui.TestRunner [classname]` for JUnit 3.x, or  

`java -cp .:/usr/share/java/junit.jar org.junit.runner.JUnitCore [classname]` for 4.x  

However, this will only run one class full of tests, and you indicated wanting to run multiple. The way you string together multiple test classes into a single unit to execute in JUnit is by using a <strong>suite</strong>,like follows:  

```
/**
 * All smoke tests in one easy suite!
 *
 */
@RunWith(Suite.class)
@SuiteClasses({ FooSmokeTests.class, 
    BarSmokeTests.class,
    BazSmokeTests.class})
public class AllSmokeTests {

}
```

Then you can run AllSmokeTests (which is the name of my test suite) with either of the above commands (depending on your JUnit version),  and it will execute FooSmokeTests, BarSmokeTests, and BazSmokeTests in turn.   

<h5>Using Maven</h1>

If your project is built with Maven, you can also execute the tests using maven itself. First, ensure that your pom.xml indicates which tests to run:  

```
    <plugin>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>2.12.4</version>
        <executions>
          <execution>
            <id>default-test</id>
            <phase>test</phase>
            <goals>
              <goal>test</goal>
            </goals>
          </execution>   
        </executions>
        <configuration>
          <includes>
            <include>smokeTests/AllSmokeTests.java</include>
          </includes>
        </configuration>
      </plugin>
```

That "include" line tells it to run AllSmokeTests (the suite I made above) by default, and nothing else. You can have multiple includes here to run multiple files, or if you make a suite like I did, you can put the suite here. Or you can put multiple suites. The sky is the limit!  

Then, from the command line, inside the directory where your pom.xml is, just run `mvn test`. This will build and run your tests.  

<h5>Using ant</h1>

I always use Maven for my test projects, but ant should have similar capabilities using the jUnit task. I found the following <a href="https://stackoverflow.com/a/12906335/719165">on StackOverflow</a>:  

```
<property name="target.dir"   value="${basedir}/target"/>
<property name="main.destdir" value="${target.dir}/classes"/>
<property name="test.srcdir"  value="${basedir}/src/test/java"/>
<property name="test.destdir" value="${target.dir}/test-classes"/>
<!-- Execute all classfiles you've compiled in test-classes directory -->
<junit fork="true"
    maxmemory="128m"
    includeAntRuntime="true">
    <classpath>
        <pathelement path="${main.destdir}"/>
        <pathelement path="${test.destdir}"/>
    </classpath>
    <classpath refid="test.classpath"/>
    <formatter type="plain"/>
    <batchtest
        todir="${junit.batchtest.todir}">
        <fileset dir="${test.destdir}"/>
    </batchtest>
</junit>
```

This is set up to run every test class, which is a common setup; presumably, you could also target that to a specific test class and run that, or run multiple.   

<h5>Using vanilla Java</h1>

If you're not using jUnit at all, but just have your code in a method, you can set up a main() method with the signature `public static void main(String [] args)`. Then you can execute the code with something like `java -jar myJar` to execute the main method inside the compiled jar myJar. You might need to edit the manifest if eclipse didn't update it; see <a href="https://docs.oracle.com/javase/tutorial/deployment/jar/appman.html" rel="nofollow noreferrer">this documentation</a> for more details.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: How to send down arrow keys for a drop down? (score [42502](https://stackoverflow.com/q/6290) in 2014)

#### Question


```
selenium.getDriver().findElement(By.id("s2id_customFilter")).sendKeys(Keys.ARROW_DOWN);
```

Am using the above code but it's not working."s2id_customFilter" is the id of the drop down.Am clicking on the id and sending keys but there's no action from selenium.  

My code:  

```
jQueryWebElement filterElement = selenium.jQuery("#s2id_customFilter");
selenium.jQuery(".select2-choice",filterElement).click();
JOptionPane.showMessageDialog(null, "one");
selenium.getDriver().findElement(By.id("s2id_customFilter")).sendKeys(Keys.ARROW‌​_DOWN);
```

#### Answer 2 (score 4)
I really like the answer from the <a href="https://github.com/angular/protractor/issues/1622" rel="nofollow">link</a> Philip Beadle posted in a comment:  

<blockquote>
  <p>It's a bad idea to test the core browser's behaviour as it's not your 
  logic, i.e. you should not need to test that arrow keys work with
  options since that's something your browser implements.</p>
</blockquote>

And some <a href="https://github.com/angular/protractor/" rel="nofollow">Protractor</a> (JavaScript) examples how to handle the drop from the same link:  

```
var options = element(by.id('s2id_customFilter'));
    options.sendKeys('textofyouroption')
```

And another one when the text changes a lot or is dynamic:  

```
var optionsElements = element(by.id('s2id_customFilter')).all(by.tagName('option'));
    optionsElements.count().then(function(count) {
      console.log('I have ' + count + ' options')
    });
    optionsElements.get(1).click(); // click on 2nd option
```

You should be able to do something similar in Java.  

#### Answer 3 (score 0)
For any rubyists, I've found 'pick first option in the dropdown' a powerful way to avoid data combinatorial testing through the UI, once you create unit and integrated tests that do that testing and explain that to the business.  

As a method, e.g. selecting the first school from a test field dropdown  

```
def select_first_school select_id
  find_by_id(select_id).send_keys :arrow_down
  find_by_id(select_id).send_keys :tab
end
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: Exactly how are BDD, TDD, ATDD, Kanban and Scrum different from a waterfall approach? (score [42361](https://stackoverflow.com/q/15263) in 2015)

#### Question
I don't understand the differences between the following terms:  

<ul>
<li>BDD - <a href="https://en.wikipedia.org/wiki/Behavior-driven_development">Behavior-driven development</a></li>
<li>TDD - <a href="https://en.wikipedia.org/wiki/Test-driven_development">Test-driven development</a></li>
<li>ATDD - <a href="https://en.wikipedia.org/wiki/Acceptance_test-driven_development">Acceptance test-driven development</a></li>
<li><a href="https://en.wikipedia.org/wiki/Kanban">Kanban</a></li>
<li><a href="https://en.wikipedia.org/wiki/Scrum_%28software_development%29">Scrum</a> </li>
</ul>

How do these terms work in the agile methodology? What's the difference from the <a href="https://en.wikipedia.org/wiki/Waterfall_model">waterfall</a> approach?  

#### Answer 2 (score 49)
I've seen TDD/BDD/ATDD used interchangeably with Scrum/Kanban/Agile, so the confusion is understandable. Here's my take on the differences:  

<ul>
<li><strong>Waterfall</strong> is a software development methodology where each kind of development activity happens in a separate phase (requirements gathering, design, development, testing...). Typically, waterfall projects work best where the problem the software is intended to solve is fully knowable and clearly defined. Not many software projects meet that criteria - it's the <em>unknown unknowns</em> that cause problems.</li>
<li><strong>Agile</strong> is a software development <em>philosophy</em> that aims to focus more on short cycles with all development activities happening simultaneously (although not on the same parts of the project at the same time - as new requirements are discovered, the team builds them into their design while working on developing and testing areas they designed in previous cycles). There are a number of Agile methodologies including:

<ul>
<li><strong>Scrum</strong>, which focuses on constant communication between team members via frequent short ceremonies. I've often seen Scrum used as the framework for an agile process, with a Kanban board used as the primary tool to communicate progress to people outside the team.</li>
<li><strong>Kanban</strong>, which focuses around the Kanban board (at least in my experience). The board holds the tasks agreed on for an iteration, and team members choose tasks move them to the different state columns as they work. </li>
<li>There are other agile methodologies, but the Scrum/Kanban combination is one of the more common varieties.</li>
</ul></li>
<li><strong>TDD/BDD/ATDD</strong> are software development <em>techniques</em> that can be used in any methodology although aspects of all three are often part of a team's agile approach.

<ul>
<li><strong>TDD</strong> is Test-Driven Development: the idea is that unit tests are written <em>first</em>, then enough code is written to make the tests pass. The pure TDD cycle is to write one failing unit test, then enough code to pass the test. Then a second failing unit test, then enough new code to pass both tests. And so forth.</li>
<li><strong>BDD</strong> is Behavior-Driven Development: this technique operates at a slightly higher level than TDD while still following the basic principle of writing the test, then coding to pass the test. BDD is usually the lowest level that will use the <em>Given-When-Then</em> pattern to describe the test (e.g. "Given that I have logged in, When I click the My Orders link Then I will be directed to the Order List page"). It can be difficult to distinguish between BDD and ATDD - the difference here is subtle.</li>
<li><strong>ATDD</strong> - is Acceptance-Test-Driven Development: this and BDD are often, in my experience, used interchangeably, particularly if the acceptance test is expressed in the Given-When-Then pattern (such as: "Given that I am a logged in user, When I go to My Orders Then I will see a list of all the orders I have made in the system, ordered from the most recent to the oldest.")</li>
</ul></li>
<li>It's not uncommon to see blends of all three techniques used: 

<ul>
<li>User requirements are written as one or more user acceptance tests (that fail)</li>
<li>Each acceptance test is decomposed into one or more behavior tests (that fail).</li>
<li>Each behavior test is decomposed into one or more unit tests (that fail). </li>
<li>At this point coding begins and each level iterates until all the user acceptance tests are passing.</li>
</ul></li>
</ul>

#### Answer 3 (score 7)
Kanban and Scrum are <a href="http://www.agilemanifesto.org/">Agile</a> process frameworks and therefor have short iterative development cycles as compared to the longer separate phases of waterfall projects. Agile projects focus on getting a working product in short iterations, each iteration should deliver a piece of deploy-able product.  

BDD, TDD and ATDD are not development methodologies and can be used in waterfall projects. They are techniques to design requirements and test-cases which can be automated. Often they are used in Agile software development, because they give a fast feedback cycle for requirements and code under development.  

Because Agile development does not have a separate testing phase its important that most if not all testing is automated. Applying BDD or TDD makes sure each new development has automated test coverage and the behavior is safe guarded iteration after iteration. This is why these practices are more important in Agile development than in Waterfall.  

I would read <a href="http://www.jamesshore.com/Agile-Book/">the Art of Agile</a> book, although it describes another Agile flavor <em>eXtreme Programming</em>. It clearly describes technique's like TDD how and why they are used. Another good read is <a href="http://agiletester.ca/">Agile Testing</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: Where can I find good JMeter tutorials? (score [42117](https://stackoverflow.com/q/2546) in 2012)

#### Question
I have just been assigned the tasks of doing some research and doing some JMeter tests of my own to get familiar with performance testing. As I have never used this tool before, I would just like to know where I can find good JMeter tutorials for beginners?  

#### Answer accepted (score 57)
<ol>
<li><p>Looking into <a href="http://jmeter.apache.org/usermanual/index.html" rel="nofollow noreferrer">JMeter User's Manual</a> will be indeed good as first step (Getting Started, Building a Test Plan, Building a Web Test Plan).</p></li>
<li><p>Several step-by-step guidelines about JMeter setup and usage for performance/load testing you can find here:
<br>
<br>- JMeter articles and tutorials:
<br><a href="http://www.jguru.com/article/server-side/load-testing-with-apache-jmeter.html" rel="nofollow noreferrer">Load Testing your Applications with Apache JMeter</a>
<br><a href="http://onjava.com/pub/a/onjava/2003/01/15/jmeter.html" rel="nofollow noreferrer">Using JMeter</a>
<br><a href="http://www.davegardner.me.uk/blog/2010/09/23/effective-load-testing-with-apache-jmeter/" rel="nofollow noreferrer">Effective load testing with Apache JMeter</a>
<br><a href="http://lincolnloop.com/blog/2011/sep/21/load-testing-jmeter-part-1-getting-started/" rel="nofollow noreferrer">Load Testing with JMeter: Getting Started</a>
<br><a href="https://www.urbaninsight.com/2011/07/18/simple-load-test-with-jmeter" rel="nofollow noreferrer">A Simple Load Test with JMeter</a>
<br><a href="http://www.devx.com/webdev/Article/17950" rel="nofollow noreferrer">Load Testing with Apache JMeter</a>
<br><a href="http://blogs.atlassian.com/2008/10/performance_testing_with_jmete/" rel="nofollow noreferrer">Performance testing with JMeter</a>
<br><a href="http://www.informit.com/guides/content.aspx?g=java&amp;seqNum=269" rel="nofollow noreferrer">Your First JMeter Test</a>
<br><a href="http://www.packtpub.com/article/functional-testing-with-jmeter" rel="nofollow noreferrer">Functional Testing with JMeter</a>
<br><a href="http://resources.infosecinstitute.com/tag/jmeter/" rel="nofollow noreferrer">JMeter Resources @ InfoSec Institute</a>
<br><a href="http://www.jmeter.net/" rel="nofollow noreferrer">JMeter Tutorial @ jmeter.net</a>
<br><a href="http://www.tutorialspoint.com/jmeter/" rel="nofollow noreferrer">JMeter Tutorial @ tutorialspoint.com</a>
<br><a href="http://www.youtube.com/watch?v=KI6u5pclYIw" rel="nofollow noreferrer">JMeter: getting started video tutorial</a>
<br><a href="http://www.ibm.com/developerworks/cloud/library/cl-jmeter-restful/" rel="nofollow noreferrer">RESTful API testing with JMeter</a>
<br>
<br><a href="http://blazemeter.com/blog" rel="nofollow noreferrer">Blazemeter Blog</a>
<br><a href="http://www.ubik-ingenierie.com/blog" rel="nofollow noreferrer">Ubik Load Pack Blog</a>
<br>
<br>Some thoughts on stress testing web applications with JMeter: <a href="http://nico.vahlas.eu/2010/03/17/some-thoughts-on-stress-testing-web-applications-with-jmeter-part-1/" rel="nofollow noreferrer">part 1</a>, <a href="http://nico.vahlas.eu/2010/03/30/some-thoughts-on-stress-testing-web-applications-with-jmeter-part-2/" rel="nofollow noreferrer">part 2</a>
<br><a href="http://planet.jboss.org/post/concurrent_high_throughput_performance_testing_with_jmeter" rel="nofollow noreferrer">Concurrent, High Throughput Performance Testing with JMeter</a>
<br>
<br>- More common about load and performance testing:
<br><a href="http://www.wilsonmar.com/perfrpt.htm" rel="nofollow noreferrer">Load, Stress, Performance Test Terms, Deliverables, Profiles and Reports</a>
<br>
<br>- JMeter results analysis:
<br><a href="http://jmeter-plugins.org/" rel="nofollow noreferrer">JMeter Plugins</a> - set of custom graphs in this package; some of them provide better results reporting out-of-box than jmeter's original ones;
<br><a href="http://wiki.apache.org/jmeter/LogAnalysis" rel="nofollow noreferrer">JMeter Wiki: Suggestions and Recipes for Log Analysis</a>
<br><a href="http://rubenlaguna.com/wp/better-jmeter-graphs/" rel="nofollow noreferrer">Better JMeter Graphs</a>
<br><a href="http://www.metaltoad.com/blog/plotting-your-load-test-jmeter" rel="nofollow noreferrer">Plotting your load test with JMeter</a>
<br><a href="http://www.datazoo.de/articles/158/performance-testing-analyzing-jmeter-results" rel="nofollow noreferrer">Performance Testing: Analyzing JMeter Results</a>
<br><a href="http://loadosophia.org/" rel="nofollow noreferrer">Loadosophia.org</a>
<br><a href="https://github.com/afranken/jmeter-analysis-maven-plugin" rel="nofollow noreferrer">JMeter Result Analysis Plugin</a>
<br>
<br>- Cloud / distributed load testing platforms:
<br><a href="http://flood.io/" rel="nofollow noreferrer">flood.io</a>
<br><a href="http://blazemeter.com/" rel="nofollow noreferrer">BlazeMeter</a>
<br><a href="http://redline13.com/" rel="nofollow noreferrer">RedLine13</a>
<br>
<br>- Custom JMeter plugins:
<br><a href="http://jmeter-plugins.org/" rel="nofollow noreferrer">JMeter Plugins</a>
<br><a href="https://github.com/ATLANTBH/jmeter-components/" rel="nofollow noreferrer">AtlantBH Custom JMeter Components</a>
<br><a href="http://www.ubikloadpack.com/" rel="nofollow noreferrer">Ubik Load Pack Plugin</a>
<br><a href="http://code.google.com/p/jmeter-groovy-sampler/" rel="nofollow noreferrer">JMeter Groovy Sampler</a>
<br><a href="https://github.com/smartrics/JMeterRestSampler" rel="nofollow noreferrer">JMeter Rest Sampler</a>
<br><a href="http://code.google.com/p/jmeter-rest-sampler/" rel="nofollow noreferrer">JMeter REST Sampler</a>
<br><a href="https://github.com/jmibanez/jmeter-rmi-plugin" rel="nofollow noreferrer">JMeter RMI Plugin</a>
<br><a href="http://code.google.com/p/jmeter-oauth/" rel="nofollow noreferrer">JMeter Plugin for OAuth Calls</a>
<br><a href="https://github.com/steeltomato/jmeter-amf" rel="nofollow noreferrer">JMeter AMF Plugin</a>
<br><a href="http://code.google.com/p/jmeter-amfsampler/" rel="nofollow noreferrer">JMeter AMF Sampler</a>
<br><a href="http://code.google.com/p/jmeter-amf-visualizer/" rel="nofollow noreferrer">JMeter AMF visualizer</a>
<br><a href="http://swirstatdsample.sourceforge.net/usage.html" rel="nofollow noreferrer">JMeter Sampler for rstatd</a>
<br><a href="http://code.google.com/p/oauth/" rel="nofollow noreferrer">JMeter OAuth Sampler</a>
<br><a href="http://wiki.apache.org/jmeter/MysqlCollectorPlugin" rel="nofollow noreferrer">MysqlCollectorPlugin</a>
<br><a href="http://jmeterdbcollect.sourceforge.net/" rel="nofollow noreferrer">JMeterDBCollector</a>
<br><a href="http://jira.codehaus.org/browse/MOJO-969" rel="nofollow noreferrer">JMeterreport plugin: Nice html reports of funtional testresults</a>
<br><a href="http://rubenlaguna.com/wp/enhanced-jdbc-sampler-for-apache-jmeter-22/" rel="nofollow noreferrer">JMeter JDBC Sampler</a>
<br><a href="http://sourceforge.net/projects/jmstats/" rel="nofollow noreferrer">JMeter Results Analyser</a>
<br><a href="http://sourceforge.net/projects/snmpjmeter/" rel="nofollow noreferrer">SNMP JMeter</a>
<br><a href="http://code.google.com/p/snmppluginjmeter/" rel="nofollow noreferrer">JMeter SNMP Plugin</a>
<br><a href="http://code.google.com/p/jmeter-ssh-sampler/" rel="nofollow noreferrer">JMeter SSH Sampler</a>
<br>
<br>- Integration:
<br><a href="http://jmeter.lazerycode.com/" rel="nofollow noreferrer">JMeter Maven Plugin</a>
<br><a href="https://wiki.jenkins-ci.org/display/JENKINS/Performance+Plugin" rel="nofollow noreferrer">Jenkins Performance Plugin</a>
<br><a href="http://docs.codehaus.org/display/SONAR/JMeter+Plugin" rel="nofollow noreferrer">Sonar JMeter Plugin</a>
<br><a href="https://studio.plugins.atlassian.com/wiki/display/JMETAGG/Bamboo+JMeter+Aggregator+Plugin" rel="nofollow noreferrer">Bamboo JMeter Aggregator Plugin</a>
<br><a href="http://netbeans.org/kb/docs/java/profile-loadgenerator.html" rel="nofollow noreferrer">Using a Load Generator in NetBeans IDE</a>
<br><a href="https://github.com/automatictester/lightning" rel="nofollow noreferrer">Lightning: JMeter performance testing integration with CI infrastructure</a>
<br>
<br>- Books:
<br><a href="http://books.google.by/books/about/Apache_JMeter.html?id=nX8oKIEvUcYC" rel="nofollow noreferrer">Apache JMeter: A Practical Beginner's Guide to Automated Testing and Performance Measurement for Your Websites</a> by Emily H. Halili (<a href="https://www.packtpub.com/networking-and-servers/apache-jmeter" rel="nofollow noreferrer">Packt Publishing</a>)
<br><a href="http://books.google.by/books?id=fpWmv3wPT64C" rel="nofollow noreferrer">Performance Testing With JMeter 2.9</a> by Bayo Erinle (<a href="https://www.packtpub.com/application-development/performance-testing-jmeter-29" rel="nofollow noreferrer">Packt Publishing</a>)
<br><a href="https://books.google.by/books?id=6ditCAAAQBAJ" rel="nofollow noreferrer">Performance Testing with JMeter, 2nd Edition</a> by Bayo Erinle (<a href="https://www.packtpub.com/application-development/performance-testing-jmeter-second-edition" rel="nofollow noreferrer">Packt Publishing</a>)
<br><a href="https://books.google.by/books?id=gJUeBQAAQBAJ" rel="nofollow noreferrer">JMeter Cookbook</a> by Bayo Erinle (<a href="https://www.packtpub.com/application-development/jmeter-cookbook" rel="nofollow noreferrer">Packt Publishing</a>)
<br><a href="https://leanpub.com/maitriser-jmeter-du-test-de-charge-a-devops" rel="nofollow noreferrer">Maîtriser JMeter. Du test de charge à Devops</a> by Antonio Gomes Rodrigues, Bruno Demion (Milamber) and Philippe Mouawad (<a href="https://leanpub.com/maitriser-jmeter-du-test-de-charge-a-devops/read_sample" rel="nofollow noreferrer">sample @ Leanpub</a>)
<br><a href="https://leanpub.com/master-jmeter-from-load-test-to-devops" rel="nofollow noreferrer">Master Apache JMeter : From load testing to DevOps</a> by Antonio Gomes Rodrigues, Bruno Demion and Philippe Mouawad (<a href="https://leanpub.com/master-jmeter-from-load-test-to-devops/read_sample" rel="nofollow noreferrer">sample @ Leanpub</a>)</p></li>
</ol>

Good luck.  

<hr>

<p><strong>UPD.</strong><br>
Please find, use and feel free to extend this <a href="https://aliesbelik.github.io/awesome-jmeter/" rel="nofollow noreferrer">Awesome JMeter</a> collection continued as <a href="https://github.com/aliesbelik/awesome-jmeter" rel="nofollow noreferrer">github repo</a>.</p>

#### Answer 2 (score 8)
I have put together a really simple article of doing performance testing with Jmeter over here - <a href="http://testcy.co.in/performance-testing-jmeter" rel="noreferrer">http://testcy.co.in/performance-testing-jmeter</a>. Even novice users with not much technical knowledge of code can do performance testing using this method.  

For more tutorials, here you go,  

<ol>
<li><p><a href="http://www.tutorialspoint.com/jmeter/jmeter_tutorial.pdf" rel="noreferrer">http://www.tutorialspoint.com/jmeter/jmeter_tutorial.pdf</a></p></li>
<li><p><a href="http://jmeter.apache.org/usermanual/index.html" rel="noreferrer">http://jmeter.apache.org/usermanual/index.html</a></p></li>
<li><p><a href="http://www.roseindia.net/jmeter/" rel="noreferrer">http://www.roseindia.net/jmeter/</a></p></li>
<li><p><a href="http://jmetertutorials.blogspot.in/" rel="noreferrer">http://jmetertutorials.blogspot.in/</a></p></li>
<li><p><a href="http://www.jmeter.net/" rel="noreferrer">http://www.jmeter.net/</a></p></li>
</ol>

Enjoy performance testing :)  

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: Using Selenium Webdriver with Windows Authentication (score [42115](https://stackoverflow.com/q/2277) in )

#### Question
I'm attempting to create some selenium tests for a website that requires windows authentication.  I got my first test up and running fairly easily, but it pauses as soon as the system prompts for credentials.  

Is there a way to provide these credentials that will still allow me to run the tests across all the major browsers?  

#### Answer accepted (score 4)
I ended up creating a custom profile for Firefox and adding the AutoAuth addon.  Not particularly elegant but it works.  Credit goes to the following blog post:  

<a href="http://www.codemiller.com/post/5923640143/overcoming-auth-pop-ups" rel="nofollow">http://www.codemiller.com/post/5923640143/overcoming-auth-pop-ups</a>  

#### Answer 2 (score 4)
For <strong>Firefox</strong> this works:  

<strong>C#</strong>  

```
var profile = new FirefoxProfile();
profile.SetPreference("network.automatic-ntlm-auth.trusted-uris", ".companyname.com");

return new FirefoxDriver(profile);
```

<strong>Python</strong>  

```
from selenium.webdriver import Firefox, FirefoxProfile

profile = FirefoxProfile()
profile.set_preference('network.automatic-ntlm-auth.trusted-uris', '.companyname.com')

return Firefox(firefox_profile=profile)
```

#### Answer 3 (score 4)
For <strong>Firefox</strong> this works:  

<strong>C#</strong>  

```
var profile = new FirefoxProfile();
profile.SetPreference("network.automatic-ntlm-auth.trusted-uris", ".companyname.com");

return new FirefoxDriver(profile);
```

<strong>Python</strong>  

```
from selenium.webdriver import Firefox, FirefoxProfile

profile = FirefoxProfile()
profile.set_preference('network.automatic-ntlm-auth.trusted-uris', '.companyname.com')

return Firefox(firefox_profile=profile)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: Unable to locate element throwing a org.openqa.selenium.NoSuchElementException in TestNG (score [41937](https://stackoverflow.com/q/20186) in 2016)

#### Question
<p>Am unable to click on element after executing a First test second test showing a org.openqa.selenium.NoSuchElementException .
<strong>My code Here:</strong></p>

```
public class snapooh {
WebDriver driver; 

@BeforeTest
public void setup() throws Exception {
     driver =new FirefoxDriver();
     driver.manage().window().maximize();
     driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
     driver.get(" http://192.168.1.10:8080/sptest/home ");
     System.out.println("Page Launched");
     }

@Test
public void login(){
    driver.findElement(By.className("loginBtn")).click();
    driver.findElement(By.id("emailaddress")).sendKeys("abc@snapooh.com");
    driver.findElement(By.id("loginpassword")).sendKeys("87654321");
    driver.findElement(By.id("loginEnter")).click();
  System.out.println("Login button pressed");

}
@Test
public void campaign() throws Exception {
    driver.findElement(By.id("usrUtils")).click();;

      driver.findElement(By.xpath(" .//*[@id='homeMainContainer']/div[1]/div/div/div[1]/div/ul/li[4]/a")).click();
      driver.findElement(By.className("addItem")).click();
      driver.findElement(By.id("campnNameInput")).sendKeys("Hello");
      driver.findElement(By.id("campnClientNameInput")).sendKeys("Hello");
      driver.findElement(By.id("campnDescInput")).sendKeys("Hello");
    //DateWidget Start date and end date

    driver.findElement(By.xpath("  .//*[@id='campnStartInput']")).click();
        WebElement   datepicker = driver.findElement(By.id("ui-datepicker-div"));  
        List<WebElement> rows=  datepicker.findElements(By.tagName("tr"));  
        List<WebElement> columns= datepicker.findElements(By.tagName("td"));  

                        for (WebElement cell: columns){  
                            //Select 20th Date   
                            if (cell.getText().equals("16")){  
                                cell.findElement(By.linkText("16")).click();   
                                    break;
                            }  
                                }   

                        driver.findElement(By.xpath("   .//*[@id='campnEndInput']")).click();
                        WebElement   datepicker1 = driver.findElement(By.id("ui-datepicker-div"));  
                        List<WebElement> rows1=  datepicker1.findElements(By.tagName("tr"));  
                        List<WebElement> columns1= datepicker1.findElements(By.tagName("td"));  
                        for (WebElement cell: columns1){  
                        //Select 20th Date   
                            if (cell.getText().equals("29")){  
                                cell.findElement(By.linkText("29")).click();   
                                    break;
                            }  
                                }   

    driver.findElement(By.id("createAndUpdateCampaign")).click();
    System.out.println("Campaign created");

}


    }
```

<strong>My Error Trace here :</strong>  

```
 org.openqa.selenium.NoSuchElementException: Unable to locate element:   {"method":"id","selector":"usrUtils"}
 Command duration or timeout: 10.08 seconds
 For documentation on this error, please visit:  http://seleniumhq.org/exceptions/no_such_element.html
 Build info: version: '2.53.0', revision: '35ae25b', time: '2016-03-15 17:00:58'
 System info: host: 'Akshay-PC', ip: '192.168.56.1', os.name: 'Windows 7', os.arch: 'x86', os.version: '6.1', java.version: '1.7.0_80'
 *** Element info: {Using=id, value=usrUtils}
 Session ID: d2fcc233-1bb7-435c-ad51-c8958cba421c
 Driver info: org.openqa.selenium.firefox.FirefoxDriver
```

#### Answer 2 (score 4)
You should wait for page load after click on button,so for that write below code :  

```
WebElement element;
Webdriver driver;
WebDriverWait wait = new WebDriverWait(driver, 100);
element= wait.until(ExpectedConditions.elementToBeClickable(By.id("usrUtils")));
```

#### Answer 3 (score 3)
After you clicked `loginenter` button, some wait should be added to reload page. It will provide small delay which is helpful for SeleniumDriver to identify element. I would like to suggest you to add some condition to wait next element. Please try below code snippet  

<pre>
WebElement myDynamicElement = 
(new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("usrUTils")));
</pre>

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: Selenium: Select 2nd item by both class and with certain text? (score [41770](https://stackoverflow.com/q/15588) in 2015)

#### Question
I am creating some test scripts using Selenium WebDriver in C#. The AUT contains a left menu in which the position/ordering of the links depend upon the 'User Preferences' and a lot of factors/configuration from Admin and user side, so XPath is not an option for me.  

I used IDE for recording the same and then generating the code, but by default IDE also used XPath, so I added some commands by myself in recorded script and tried to find the element, with the 'Find' button provided in Selenium IDE. After a couple of tries it worked in IDE, i.e. IDE highlighted the element which I want to find, but when I copied the same code in VSTS it is not working.  

This is the code generated by IDE, I am not able to get the reason why this is working in IDE and not in VSTS code, I haven't seen any other command to show such a behavior.  

```
driver.FindElement(By.CssSelector("span:contains(Issues Management)")).Click();
```

This code throws element not found/similar error when executed in WebDriver but works fine in IDE. I have seen a similar post over <a href="http://www.sqaforums.com/forums/selenium/152218-css-selector-works-ide-but-not-webdriver.html" rel="nofollow">SQAForums</a>, but that too doesn't explain it's reason well. I am using Firefox as a browser for creating these tests.  

HTML of the element is:  

```
<a class="rpLink rpExpandable" title="MyServices" href="#">
<span class="rpOut">
<span class="rpExpandHandle"></span>
<span class="rpText">
Issues Management
<span class="menuItemRole">Container menu item</span>
</span>
</span>
</a>
```

The complexity is there can be multiple elements with the same text 'Issues Management' on the page, but as far as I know they will be under a different section/class name.  

#### Answer 2 (score 1)
<h5>Use [0] for the first instance</h3>

<p>This may be due to the seleniumIDE selecting a first instance by default
You can achieve this manually with:</p>

```
CssSelector("span.rpText:contains(Issues Management)")[0]
```

Also, if the class is unique then use it in the selector, i.e.  

css:  

```
driver.
  FindElement(By.CssSelector("span.rpText:contains(Issues Management)")).Click();
```

xpath:  

```
driver.findElement(By.xpath(
"/descendant::a[@class='post-rpText'][2]:contains('Issues Management')")).click();
```

#### Answer 3 (score 1)
<h5>Use [0] for the first instance</h3>

<p>This may be due to the seleniumIDE selecting a first instance by default
You can achieve this manually with:</p>

```
CssSelector("span.rpText:contains(Issues Management)")[0]
```

Also, if the class is unique then use it in the selector, i.e.  

css:  

```
driver.
  FindElement(By.CssSelector("span.rpText:contains(Issues Management)")).Click();
```

xpath:  

```
driver.findElement(By.xpath(
"/descendant::a[@class='post-rpText'][2]:contains('Issues Management')")).click();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Cannot Instantiate class error - Selenium WebDriver (score [41506](https://stackoverflow.com/q/14680) in 2015)

#### Question
I am facing this `'Cannot insantiate class'` error on running one of my test cases in Selenium webdriver using Java.  

Below is the class of the functionality of the test,  

```
package Pages;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import Lib.lib;

public class KnowledgeBase extends lib{

    By sortBylink = By.xpath("html/body/div[1]/featured-studies-grid/div[2]/featured-studies-toolbar/div/div[2]/div[2]/div/div");
    By featuredOption = By.xpath("html/body/div[1]/featured-studies-grid/div[2]/featured-studies-toolbar/div/div[2]/div[2]/div/ul/li[1]");
    By mostRcnt = By.xpath("html/body/div[1]/featured-studies-grid/div[2]/featured-studies-toolbar/div/div[2]/div[2]/div/ul/li[2]");

    String featOption = driver.findElement(By.xpath("html/body/div[1]/featured-studies-grid/div[2]/featured-studies-toolbar/div/div[2]/div[2]/div/ul/li[1]")).getText();

    String mostRecent = driver.findElement(By.xpath("html/body/div[1]/featured-studies-grid/div[2]/featured-studies-toolbar/div/div[2]/div[2]/div/ul/li[2]")).getText();

    public void initSBy() throws Exception
    {
        driver.findElement(sortBylink).click();
        Thread.sleep(1500);
    }

    public void selectfO() throws Exception
    {
        driver.findElement(featuredOption).click();
        Thread.sleep(5000);
    }

    public void selectMr() throws Exception
    {
        driver.findElement(mostRcnt).click();
        Thread.sleep(5000);
    }

    public void sortBy(String sProp) throws Exception
    {
        this.initSBy();

        if (sProp == "featOption") {

            this.selectfO();

        }

        else if (sProp == "mostRecent"){

            this.selectMr();
        }

        else {

            System.out.println("Incorrect option. Test failed.");
        }
    }


}
```

Below is my Test Case Class  

```
package TestCases;

import org.testng.annotations.Test;

import Lib.lib;
import Pages.KnowledgeBase;
import Pages.LoginPage;

public class sortingTextKB extends lib {

    LoginPage uLogin = new LoginPage();
    KnowledgeBase sortObj = new KnowledgeBase();

    //Logging In
    @Test (priority = 1)
    public void loggingIn() throws Exception
    {
        uLogin.loginToKB("uzii@test.com", "uziiiii");
    }

    //Sorting
    @Test (priority = 2)
    public void sortIn() throws Exception
    {
        sortObj.sortBy("Most Recent");
    }

}
```

Below is my Lib class, that contains the chrome driver configuration  

```
package Lib;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.AfterTest;

public class lib {

    protected static WebDriver driver = null;

    @BeforeTest
    public void chrome_extension()
    {
        System.setProperty("webdriver.chrome.driver", "chromedriver.exe");
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--start-maximized");
        driver = new ChromeDriver(options);
        driver.get("http://www.testsite.com");
    }


    @AfterTest
    public void quit()
    {
        driver.quit();
    }

}
```

When I run my test case class, I am getting the following error,  

```
org.testng.TestNGException: 
Cannot instantiate class TestCases.sortingTextKB
    at org.testng.internal.ObjectFactoryImpl.newInstance(ObjectFactoryImpl.java:38)
    at org.testng.internal.ClassHelper.createInstance1(ClassHelper.java:387)
    at org.testng.internal.ClassHelper.createInstance(ClassHelper.java:299)
    at org.testng.internal.ClassImpl.getDefaultInstance(ClassImpl.java:110)
    at org.testng.internal.ClassImpl.getInstances(ClassImpl.java:186)
    at org.testng.internal.TestNGClassFinder.<init>(TestNGClassFinder.java:120)
    at org.testng.TestRunner.initMethods(TestRunner.java:409)
    at org.testng.TestRunner.init(TestRunner.java:235)
    at org.testng.TestRunner.init(TestRunner.java:205)
    at org.testng.TestRunner.<init>(TestRunner.java:160)
    at org.testng.remote.RemoteTestNG$1.newTestRunner(RemoteTestNG.java:141)
    at org.testng.remote.RemoteTestNG$DelegatingTestRunnerFactory.newTestRunner(RemoteTestNG.java:271)
    at org.testng.SuiteRunner$ProxyTestRunnerFactory.newTestRunner(SuiteRunner.java:561)
    at org.testng.SuiteRunner.init(SuiteRunner.java:157)
    at org.testng.SuiteRunner.<init>(SuiteRunner.java:111)
    at org.testng.TestNG.createSuiteRunner(TestNG.java:1299)
    at org.testng.TestNG.createSuiteRunners(TestNG.java:1286)
    at org.testng.TestNG.runSuitesLocally(TestNG.java:1140)
    at org.testng.TestNG.run(TestNG.java:1057)
    at org.testng.remote.RemoteTestNG.run(RemoteTestNG.java:111)
    at org.testng.remote.RemoteTestNG.initAndRun(RemoteTestNG.java:204)
    at org.testng.remote.RemoteTestNG.main(RemoteTestNG.java:175)
Caused by: java.lang.reflect.InvocationTargetException
    at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
    at sun.reflect.NativeConstructorAccessorImpl.newInstance(Unknown Source)
    at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(Unknown Source)
    at java.lang.reflect.Constructor.newInstance(Unknown Source)
    at org.testng.internal.ObjectFactoryImpl.newInstance(ObjectFactoryImpl.java:29)
    ... 21 more
Caused by: java.lang.NullPointerException
    at Pages.KnowledgeBase.<init>(KnowledgeBase.java:22)
    at TestCases.sortingTextKB.<init>(sortingTextKB.java:12)
    ... 26 more
```

Following is line 22 of `KnowledgeBase` class,  

```
String featOption = driver.findElement(By.xpath("html/body/div[1]/featured-studies-grid/div[2]/featured-studies-toolbar/div/div[2]/div[2]/div/ul/li[1]")).getText();
```

Please let me know why I am facing this `'cannot instantiate class'` error. Thanks  

#### Answer 2 (score 1)
It looks like your `driver` instance is created in one class(`lib`, (should start with Capital letter BTW)) but  you are trying to access it in another class(`KnowledgeBase`).  

If you want to use a class instance in another class, you have options. Some of them are:  

<ol>
<li><strong>Add a getter method</strong>. Add a `public getDriverInstance()` method  in the class where the instance is created that will just return the `driver` instance.</li>
<li><strong>Keep everything in the same class</strong>. Keep the driver initialization method as well as the tests themselves in the same class. That's obviously a messy solution but it will work.</li>
<li><strong>Use a Dependency Injection framework</strong>. You can use a DI framework like Spring, PicoContainer, etc.., which is probably the cleanest solution but has some learning curve to it.</li>
</ol>

#### Answer 3 (score 0)
Can you change:  

```
protected static WebDriver driver = null;
```

to  

```
 public static WebDriver driver;
```

Maybe that works. Just a try.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: How to close pop up window in Selenium webdriver? (score [41016](https://stackoverflow.com/q/5310) in 2012)

#### Question
Below is my Selenium Webdriver script. When I run this script my website is opened but the popup window is also opened. How do I close this popup window so the script can continue?  Take a look on screenshot also.  

```
package com.angara;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class TestAngaraWeb {

   public static void main(String[]args){

      WebDriver driver = new FirefoxDriver();
      driver.get("http://www.angara.com");
      driver.findElement(By.xpath("/html/body/div[6]/div/div[2]/div/div/div/ul/li/a")).click();


   }
}
```

<img src="https://i.stack.imgur.com/CtCFM.png" alt="enter image description here">  

#### Answer 2 (score 4)
As user246 commented, you can write a method to locate the 'X' on the popup and click it if found.  Then you can define a custom method to locate an element on the page, something like this (kind of pseudo code):  

```
myFindElement(String xpath)
{
    try{
        driver.findElement(By.xpath(path))
    }
    catch (ElementNotFoundException e){
        if !closethepopup(){print ('Element not found')}
    }
    catch (GeneralException ge){
    }
}
```

Within your closethepopup() method, you can choose to add some logic to return false if the popup is not found  

#### Answer 3 (score 3)
Try this :  

```
Driver.SwitchTo().frame("Fancybox-frame");

Driver.findElement("enter your xpath to close popup").click();

Driver.SwitchTo().defaultContent();
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: Handling hidden elements in Selenium (score [39914](https://stackoverflow.com/q/25990) in 2017)

#### Question
I have just encountered a question about handling hidden elements in Selenium. I don't understand how they should be handled. I'm also confused about why hidden elements would be used.  

How do I handle hidden elements in Selenium? I'm particularly concerned with handling hidden elements that have the same or almost the same identifiers as a visible element.  

<em>Original text</em>  

<blockquote>
  <p>Today was the first time I was asked about hidden elements in Selenium
  and I never had to deal with them in practice. I watched a video
  tutorial on that and I now get the general idea. To follow up on that
  video I would like to ask, why hidden elements exist to begin with, is
  it flawed design? </p>
  
  <p>Secondly, is it true that they can pose a challenge only if there is
  an identical visible element present and even in this case you don't
  have to resort to identifying non-hidden elements by their coordinates
  not being equal to 0, you just need to carefully inspect it because
  hidden elements are unlikely to have all identifiers identical to
  another visible element?</p>
</blockquote>

#### Answer 2 (score 2)
To click on a hidden element, you can use `execute_script` with the parameter  `"arguments[0].click();"`  

Code example:  

```
element = driver.find_element_by_xpath("//input[@id='firstname']")
driver.execute_script("arguments[0].click();", element)
```

#### Answer 3 (score 1)
Hidden elements are hard to handle: QA script can detect its presence but not more - because user cannot interact with such element either. So presence of a hidden element can signify some status/transition is a page, like throbber/spinner signifies page is loading something.   

Also, hidden elements can contain some info relevant to a test script but not to a user.   

If hidden element has EXACTLY same ID as visible, <strong>locating such element by ID will fail</strong>. Happened to me, and was quite confusing (locating element failed without any good error message, as if element was not present - but it was. There was also <strong>another</strong> element with same ID). Page had to be fixed, removing the extra element (or renaming it).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Selenium 2 element.click() is unreliable (score [39478](https://stackoverflow.com/q/2333) in 2012)

#### Question
I am using Selenium 2 2.16 build.  I've been running into problems where I get a variable response to a `click()` call, where sometimes the click activates the behaviour behind the element (new page loads) and sometimes it does not.  As `click()` doesn't return anything, I can't trap for those occurences where the driver doesn't go to a new page.  

Here's a code snippet :  

```
// Find the User Profile Button
def userProfileButton = driver.findElement(By.className("user"))
assert userProfileButton.isEnabled()
assert userProfileButton.getText() == "Facility Administrator"
userProfileButton.findElement(By.tagName("a")).click()

// Check User Profile page loads
def userProfilePanel = driver.findElement(By.id("profile-panel"))
.... do some tests on the userProfilePanel
```

So I am locating the link, checking it is enabled and has the right name, then clicking on it.  The next step will sometimes time out (I have the driver set to wait up to 10 seconds before timing out), as the new page is not loaded.  Other times, it works fine.  

The page in question is JavaScript based and using Ext JS to do the rendering of the page.  

This is not the only case I have where the `click()` is unreliable. Do other people have similar problems?   

I'd prefer not to use the work around I've seen which is to call `sendkeys(Enter)`, as I'd like to simulate the real user clicks and data entry if at all possible.  

#### Answer 2 (score 5)
Phrase <em>"sometimes works sometimes not"</em> often means that Selenium tried to make an action when that action was unavailable at that time (the easiest method to check is to make long pauses before each action).  

In this case I recommend for you to make your own custom method `WaitWhileProcessing` which commands WebDriver to wait until full page is rendered. How you write that on your custom method depends on your web applications (sometimes you only need to wait until specific page element is loaded).  

#### Answer 3 (score 2)
As long as you make sure the element you want to click is actually ready, then it will work reliably.  There are ways to find elements without throwing exceptions by using try-catch conditions inside of loops.  For example, this method I wrote (which can be simplified depending on what you use if for) will return a WebElement and it makes sure that it's clickable before returning it to you:  

```
/**
 * Example of using finally to "ignore" exceptions from Selenium
 *  findElement() method.
 */
public static WebElement getElementByLocator( final By locator ) {
  driver.manage().timeouts().implicitlyWait( 15, TimeUnit.SECONDS );
  WebElement we = null;
  int tries = 0;
  while ( tries < 4 ) {
    try {
      we = driver.findElement( locator );
      break;
    } catch ( StaleElementReferenceException e ) {                      
      LOGGER.info( "Ignoring stale element exception.");
    } finally { // use finally block to totally ignore exception block
      tries += 1;
    }
  }
  driver.manage().timeouts().implicitlyWait( DEFAULT_IMPLICIT_WAIT, TimeUnit.SECONDS );
  return we;
}
```

NOTE: You can also improve this method by altering it to use the <a href="http://selenium.googlecode.com/git/docs/api/java/org/openqa/selenium/support/ui/FluentWait.html" rel="nofollow">FluentWait</a> class or the Wait class to ignore exceptions rather than handling them explicity (like you see above).  I recommend this, but if you prefer, you can do it organically like I show above.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: How to avoid triggering google captcha while browsing in a selenium-driven browser? (score [39189](https://stackoverflow.com/q/33219) in 2018)

#### Question
<blockquote>
  Preface: my goal is not to solve captcha using automation tools, but to attempt to understand why a browser that is being launched by selenium is being identified as a bot in the first place, and how selenium contributes to this.  
</blockquote>

I use selenium to start up firefox and log onto a website to scrape some data a few times a day.  

Recently the website changed their login system by adding google's reCAPTCHA, and everytime I try to click the checkbox, google determines that I am a bot and asks me to select a bunch of images.    

I started up a regular instance of firefox (that is, without selenium), went to the website, clicked the checkbox, and it determined that I was a human and let me go.  

I then became curious what was the difference between me launching firefox through the executable, and me launching firefox through selenium. I decided to launch firefox using this piece of java code  

```
WebDriver driver = new FirefoxDriver(new FirefoxProfile());
```

So I'm doing nothing much but starting firefox, using selenium. Which of course means a lot of stuff is going on under the hood, but perhaps the selenium instance of firefox is not "human" enough?  

So I tried a few different things to try to look more human:  

<ol>
<li>Maybe I just need to browse. Like a human.</li>
</ol>

There are many theories that talk about things like mouse movement, keyboard strokes, etc. So the browser starts up, I type in the URL, I click a few other links, I come back to the login page, type in username + password, then proceed to click on the captcha box...and I'm a bot.  

<ol start="2">
<li>Maybe I don't have any cookies or browsing history?</li>
</ol>

Selenium by default creates a new profile, so it has no cookies or browsing history. I can specify a custom profile to use, so I simply passed in my own firefox profile stored in `APPDATA/roaming/mozilla/profiles`. I verified that all of the websites that I have saved my credentials were there in the selenium-launched browser, but when I confronted the reCAPTCHA, it determined I was a bot and asked for image selection  

<ol start="3">
<li>Maybe I need to use caching?</li>
</ol>

By default, selenium uses a custom cache path that is cleaned up after the session is over. In firefox you can see this by going to `about:cache` and it will say something like `anonymous6337741624277931373webdriver-profile\cache2`, and there isn't much there.  

So I decided to use my own profile's cache  

```
profile.setPreference("browser.cache.disk.parent_directory", PATH_TO_MY_PROFILE_CACHE);
```

<p>And verified that all of my cached resources are there.
But it didn't make a difference.</p>

<ol start="4">
<li>Maybe I just need to solve the captcha once?</li>
</ol>

Now I'm thinking, OK, so if google thinks I'm a bot, how about I solve the captcha in the selenium-launched browser once, let them know I'm good, and then it won't happen again? Maybe it identifies the browser as a new client, and just needs to know that this new client is not a bot.  

So I solve the captcha and successfully log in. Then I logged out, returned to the login page, entered my credentials, pressed the reCAPTCHA box....and it asked me to solve the image selection problem again!  

At this point I'm thinking, I just solved the captcha successfully half a minute ago, exhibited a bunch of manual human actions, but I'm still being identified as a bot.  

Is there something specific about selenium that's making google identify me as a bot automatically?  

I have used a custom profile, with custom cache path. I use cookies. I have all my regular extensions that I have installed on my profile. My user agent is unspoofed and it's no different from my normal browsing experience. There's nothing in the request headers that would suggest it is any different from a regular browser.  

I would conclude that there is something on selenium's end that is causing me to be identified as a bot, when I'm using the browser as a regular user.   

Perhaps there are specific JS objects that are injected into the DOM that google picks up on?  

#### Answer 2 (score 27)
By definition, resolving a CAPTCHA cannot be automated: Otherwise it could not tell computers and humans apart and hence fails being a CAPTCHA.  

How to handle a CAPTCHA in a test environment:  

<ul>
<li>Use a service like <a href="http://www.deathbycaptcha.com" rel="noreferrer">http://www.deathbycaptcha.com</a> which has an API to return the text of the CAPTCHA for you. Average response is 15 seconds with a result rate of 90% or so they say. Sounds like something to try.</li>
<li>Google officially prevents automated integration testing of any platform using google oauth.  If you're using a gsuite domain for your test accounts, however, you can run your own identity provider to handle the auth</li>
<li>Ask your development team to remove the CAPTCHA field on the test environment.</li>
<li>Ask your development team to make a sandbox like CAPTCHA, that will accept a single input text every time</li>
<li>If your are using custom CAPTCHA module, you can ask developer to generate an API of CAPTCHA generation for testing environment.</li>
<li>You can ask dev team to add CAPTCHA code as title in markup, then you can access this title and bypass the CAPTCHA, but only in the testing environment.</li>
</ul>

Generally if they've added a CAPTCHA to their site, they might have noticed spam attempts to login and such want to mitigate those. Contact the website administrator and mention to them what you've been doing and ask if they'd provide something for you so you can continue what you're doing.  

#### Answer 3 (score 13)
If you are using reCAPTCHA v2, you can bypass it using test keys.   

With these test keys, you will always get No CAPTCHA and all verification requests will pass.  

```
Site key: 6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI
Secret key: 6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe
```

The reCAPTCHA widget will show a warning message to ensure it's not used for production traffic.  

Source: <a href="https://developers.google.com/recaptcha/docs/faq#id-like-to-run-automated-tests-with-recaptcha-v2-what-should-i-do" rel="noreferrer">Google Developer FAQ</a>.  

Of course, this isn't what you'd need on a production site... but for those struggling to bypass Google reCAPTCHA for automation testing, this is ideal.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: How should you interview for QA positions? (score [39107](https://stackoverflow.com/q/55) in 2019)

#### Question
Joel has his "<a href="http://www.joelonsoftware.com/articles/GuerrillaInterviewing3.html">The Guerrilla Guide to Interviewing (version 3.0)</a>", but that's really for programmers.   

How should you go about interviewing testers?  

We ask programmers to program on a whiteboard; how you can you ask testers to test in an interview, in a way that tells you something useful about them?  

#### Answer accepted (score 71)
You can ask people to test on a whiteboard too - draw up a sample dialog, or system, and ask them to discuss what ideas they'd have for testing. I really like <a href="http://www.kaner.com/pdfs/JobsRev6.pdf">Cem Kaner's approach to this</a>.  He goes into some detail about how he conducts test auditions - he tends to give two similar examples, with the first one as a practice run.   

I've found it very revealing to see how different candidates react to being asked to come up with test ideas for a sample dialog. Some run out of ideas very quickly. Some people are very single-track minded, and <em>all</em> their test ideas are along the same lines. Some people ask hardly any questions, and others ask lots. Watching what kind of questions people come up with gives me an insight into what kind of mental model they're building, and what their blind spots are.   

I've also tried giving people an actual app during an interview - I didn't find that much of an improvement on the whiteboard, personally, but it's possible that a better choice of app, or framing, would have helped there.  

I'm not so much of a fan of "test this lightswitch" or "test this pen" questions - I prefer things that are close enough to real that they trigger genuine questions for people. I know some people have difficulty in getting inspired by things that don't seem like authentic problems, and I don't want to disadvantage potentially promising candidates.  

#### Answer 2 (score 30)
We have several portions to our interviews:  

<ul>
<li>Here's a simple, well-known system anyone should know, we like to use elevators. Here is a very basic spec. Talk about some tests you'd run.</li>
<li>We've written the spec so that anyone worth their salt should have a dozen questions about it.</li>
<li>We want to see the different <em>types</em> of tests they come up with, not just the specific issues.</li>
<li>See how curious they are about things. Good testers test everything all the time, including you and your interview process.</li>
</ul>

I like to say (metaphorically) that when you ask a good tester to pick a number between 1 and 10 they'll choose <a href="http://en.wikipedia.org/wiki/Pi">&#960;</a>.  

#### Answer 3 (score 17)
I think it depends on what you want your testers do to. If working in a team environment and collaboration are key aspects of what your test team does, make them solve a testing problem with you. If you want them to write some automation or tools (or at least be able to if they're stuck), you may want to have them write some code (but have them write code to solve a testing problem - not some "interesting" algorithm).  

In general though, I like to take some time before the interview to think, "What would the A+ tester on this team do?". I create a list of attributes, then brainstorm questions that will help me figure out if the candidate has those attributes.  

And finally, where I work, career growth has a huge emphasis, so I probe a bit to make sure the tester I'm hiring has long-term potential (I like to ask, "How do you learn?", as this gives me an indication of how much they <em>want</em> to grow).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: How to run JMeter test plan for specified amount of time? (score [39016](https://stackoverflow.com/q/8378) in )

#### Question
How to run an JMeter test plan that it should be completed in specified time or it should be terminated within that stipulated time? Please throw me light on this question.  

#### Answer accepted (score 6)
It isn't possible at Test Plan level, but there are following options available:  

<ol>
<li>Set `Duration (seconds)` to the desired value for each <a href="http://jmeter.apache.org/usermanual/component_reference.html#Thread_Group" rel="noreferrer">Thread Group</a></li>
<li>Use <a href="http://jmeter.apache.org/usermanual/component_reference.html#Test_Action" rel="noreferrer">Test Action</a> timer to stop all the threads (for example create a separate thread group, add <a href="http://jmeter.apache.org/usermanual/component_reference.html#Constant_Timer" rel="noreferrer">Constant Timer</a> which will sleep desired number of seconds, when the timer all threads will be requested to stop</li>
<li><p>Use <a href="http://blazemeter.com/blog/queen-jmeters-built-componentshow-use-beanshell" rel="noreferrer">Beanshell Sampler</a> anywhere in your script. Relevant Beanshell code to stop the test looks as follows:</p>

```
SampleResult.setStopTest(true); // to ASK threads to stop
SampleResult.setStopTestNow(true); // to TELL threads to stop
```
</li>
</ol>

Using `Duration` or `Stop` doesn't mean that your test plan will end at that moment as threads need some time to gracefully shut down.   

In case of forceful termination threads may produce extra errors which will be reflected in test results.   

Hope this helps.   

#### Answer 2 (score 11)
<p>You can do this by using JMeter Scheduler:
In Thread Group tick the Scheduler and set the value as below:</p>

Start Time and End Time: No need to input. keep them as they are, because they have no significant after entering Duration and Startup delay value. Delay overrides Start Time, and Duration overrides End Time.  

For example, if you want to run the test for 2 min. Input the value as below:  

<p><strong>Duration (seconds):</strong> 120<br>
<strong>Startup delay (seconds):</strong> 0</p>

<a href="https://i.stack.imgur.com/Eww79.png" rel="noreferrer"><img src="https://i.stack.imgur.com/Eww79.png" alt="enter image description here"></a>  

Now it's the time to run the test: Run -> Start  

#### Answer 3 (score 1)
I just applied below configuration and it worked for me.  

<a href="https://i.stack.imgur.com/kqNvb.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/kqNvb.jpg" alt="enter image description here"></a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: How to select or check multiple checkboxes in Selenium? (score [38548](https://stackoverflow.com/q/3292) in 2012)

#### Question
I've got this HTML code  

```
<input type="checkbox" value="abc" name="arr[]><br>
<input type="checkbox" value="abc1" name="arr[]><br>
<input type="checkbox" value="abc2" name="arr[]><br>
```

With this  

```
self.browser.find_element_by_xpath("//input[@name='arr[]']").click()
```

<p>I can check only the first checkbox, but I want check all check box in the same time.
How I can do it?</p>

#### Answer 2 (score 8)
```
checkboxes = self.browser.find_elements_by_xpath("//input[@name='arr[]']")
for checkbox in checkboxes:
    if not checkbox.isSelected():
        checkbox.click()
```

<hr>

(Previous answer):  

I am not yet familiar with the python syntax, but this is what you can do:  

<ol>
<li><p>Return all elements with the given xpath:</p>

<p>`self.browser.find_elements_by_xpath("//input[@name='arr[]']")` <br/>
Note that it is find_elements_by_xpath (plural)</p></li>
<li><p>Loop through the list to check all checkbox</p></li>
</ol>

#### Answer 3 (score 0)
Find element (singular returns only the first element that matches), whereas find_elements returns an iterable list of all matches. As Suchit explained, you can loop through the list.  

<p>You can also select an individual box in the list using the index. For example, to select the second box:
<code>
    driver.find_elements_by_xpath("//input[@name='arr[]']")[1].click()
</code></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How to minimize the browser window which was launched via Selenium Webdriver? (score [38520](https://stackoverflow.com/q/15484) in 2015)

#### Question
How can I minimize the browser window which has been launched via Selenium Webdriver?   

I see that there is a method to maximize (<a href="http://selenium.googlecode.com/svn/trunk/docs/api/java/org/openqa/selenium/remote/RemoteWebDriver.RemoteWebDriverOptions.RemoteWindow.html#maximize%28%29" rel="nofollow">documentation</a>), but I cannot find the converse for minimize.   

I have tried resizing and repositioning the window, however this does not work the same way as minimize.   

Is there a way to do this in Selenium? Or can this only be done through Robot key events (e.g. <kbd>Windows</kbd> + <kbd>D</kbd>) ?  

#### Answer 2 (score 5)
Short answer to your question: Unfortunately, <strong>Selenium</strong> do not provide any built-in function for minimizing the browser window, there is only function for maximizing the window. But there are some work around for doing this.  

<ol>
<li>You want window to be out of sight, then you need to use this code. by using it browser window will be out of your sight and you will not be able to see what is running, but don't worry your test cases will keep on executing. It is tried and tested work around.</li>
</ol>

<a href="https://stackoverflow.com/questions/6643951/how-could-i-start-a-selenium-browserlike-firefox-minimized">Reference Link</a>  

```
driver.manage().window().setPosition(new Point(-2000, 0))
```

<ol start="2">
<li>You can use PhantomJS for running your test cases, download and install it from this <a href="http://phantomjs.org/download.html" rel="nofollow noreferrer">link</a>  and simply change the line </li>
</ol>

`driver = webdriver.Firefox()` to `driver = webdriver.PhantomJS()`  

and you don't need to change any more code. Your browser will run in an hidden mode.  

<a href="https://sqa.stackexchange.com/questions/2609/running-webdriver-without-opening-actual-browser-window">Reference link</a>  

<ol start="3">
<li>Use the Robot class and windows shortcut keys for the same (as already mentioned by you).</li>
</ol>

#### Answer 3 (score 0)
driver.Manage().Window.Minimize();  

This works fine with Chrome, Firefox, IE but fails for 'Edge' driver.   

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Under what circumstances is Sikuli better for test automation than Selenium or Watir? (score [38288](https://stackoverflow.com/q/994) in 2016)

#### Question
The <a href="http://sikuli.org/">Sikuli website</a> says:  

<blockquote>
  <p>Sikuli is a visual technology to automate and test graphical user
  interfaces (GUI) using images (screenshots).</p>
</blockquote>

Under what circumstances is Sikuli a better technology for test automation than Selenium or Watir, which depend on symbolic identifiers or paths for referencing UI elements?  Please consider not only test creation but also test maintenance.  

#### Answer accepted (score 10)
I can come up with some ideas:  

<ul>
<li><p>You are testing for devs who don't know how to give their elements IDs or use other APIs, and won't go back and fix things in a timely fashion.  This is accumulating technical debt - better to get the devs to do it right - but, e.g., on legacy apps designed without a thought toward testability, screenshot testing might be the only reasonable option for creating UI tests.  In fact, this tool might solve an upcoming problem for me along those lines . . .</p></li>
<li><p>You are testing specifically to make sure that the UI stays reasonably similar in appearance.  Normal UI testing doesn't care what the button looks like, and couldn't catch if the image used got deleted by accident or swapped with an old button image.  I've seen other screenshot testing used for these purposes on major apps.</p></li>
<li><p>If you can get really accurate screenshots from the PM, you could make your UI tests before the IDs have been assigned to the elements and also ensure that the final UI matches PM specs, automatically.</p></li>
</ul>

As long as you can assign screenshots to variables and reuse them (so you only have one screenshot of the "Okay" button in the entire test suite), maintenance wouldn't be too bad IMO.  It might even be easier if IDs are still changing and the UI is in extreme flux.  I worked on a project once where devs kept removing IDs by accident, and I had to wait literally weeks before I got a reliable identifier quite regularly.  But UI elements will <em>always</em> have an image, by definition, meaning a 1-minute test fix rather than a 3-week wait where I can't run that test automatically and need to run it manually, or a 15-minute to 1-hour fix to code a work-around function and test it.  

The main difficulty I can think of would arise when there could be two or more similar pieces of UI (e.g., two "Okay" buttons, one on an error and one on a standard configuration screen), but even IDs can have similar issues (do you want "dynamicMenuOption11" or "dynamicMenuOption12"?), and you could probably fix this most of the time just by taking a bigger screenshot (e.g., get the edge of the "Apply" button or error dialogue to identify the right button).  That's an easier fix than coding the ID in, checking other values, and so on, IMO.  

<strong>Edit:</strong>  I do think Tarun brings up a good point about how well Sikuli tolerates changes.  The video claims some sort of "best-fit" matching, but how tolerant is that?  And, if it is <em>too</em> tolerant, could it produce false actions and false passes?    

#### Answer 2 (score 13)
I have actually used Sikuli and believe it is the future for QA automation. The fuzzy logic on image compare is pure genius. You can crank it up to be an exact match or turn it down to lesser. I have ran the same test on multiple browsers/OSes and resolutions without too many issues.   

It is way more robust than the old x,y testing of yesteryear. I created an image.sikuli script that hosts all my images and I just reuse them through out.   

The app I am tasked with testing does not play well with QTP or TestComplete, I am unable to see elements. This seems to be more and more common with applications that are using embedded components. Sikuli bridges that gap, and I find it easier to use than the others (although the IDE is not very good). It does not have the record and playback that some of the other tools promote, but again doing that never produces a repeatable robust automation.  

Selenium also does not do ANY image compare. Although the test may pass, it may look like crap on IE 9. Sikuli can at least do a high level compare on elements, and buttons to make sure they are rendering correctly.  

#### Answer 3 (score 8)
I am not sure it's as easy as saying Sikuli is a better technology for test automation than Selenium or Watir - it's just an alternative.  

On my current project, the front end test team were struggling to test an application using flexmonkium. They had the skills and experience to write tests in flexmonkium, but our application needed to be recompiled with the flexmonkium libraries, otherwise the tests simply couldn't hook into the application. It was not going to be possible to make this happen for quite a while, so the team needed another approach. We choose Sikuli, since it didn't need any hooks into the application under test - it simply works off what is on screen.  

Sikuli has drawbacks (slow, unpredictable, cross browser issues etc.), but in some scenarios, it may be a good choice. You need to make up your own mind.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: How to handle sub child windows(more than 3) using Selenium Web Driver with Java (score [38282](https://stackoverflow.com/q/12094) in 2015)

#### Question
I am using Selenium Webdriver with Java, and I need help handling sub child windows.  

I have to handle four child windows.  

<blockquote>
  <strong><em>Main window- Child window- Grand child - (to reach 5 child windows)</em></strong>  
</blockquote>

I am using code as follows, but facing problem on Grand child were controls are not at all working at any code change instances.   

```
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class Test {
public static void main(String[] args) throws InterruptedException {
    //System.setProperty("webdriver.ie.driver","E:\\Library\\IEDriverServer.exe");
    WebDriver driver = new FirefoxDriver();
    driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
    driver.get("https://70.91.43.177/rcsnewjs");
    driver.get("javascript:document.getElementById('overridelink').click();");
    driver.manage().window().maximize();
    driver.findElement(By.id("txtUserId")).clear();
    driver.findElement(By.id("txtUserId")).sendKeys("rcsadmin");
    driver.findElement(By.id("txtPassword")).sendKeys("delasoft");
    driver.findElement(By.id("btnLogin")).click();
    driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
    driver.findElement(By.id("__tab_TabContainer1_TabPanel3")).click();
    driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
    String MainWindow = driver.getWindowHandle();
    String Childwindow = MainWindow;
    String ChildWindow1 = Childwindow;
    String ChildWindow2 = ChildWindow1;
    try
    {
    driver.findElement(By.id("TabContainer1_TabPanel3_dmwmOutdoorAdvertising_btnAddPermits")).click();
    }
    catch(Exception e)
    {

    }

    for (String Handle : driver.getWindowHandles())
    {
        if (!Childwindow.equals(Handle))
        {
            Childwindow = Handle;
            driver.switchTo().window(Childwindow);
            Thread.sleep(5000);
        }

    }

     try
     {
     driver.findElement(By.id("btnSelectOwner")).click();

     }
     catch(Exception e)
     {

     }

    for (String Handle1 : driver.getWindowHandles())
    {
        if (!ChildWindow1.equals(Handle1))
        {
            ChildWindow1 = Handle1;
            driver.switchTo().window(ChildWindow1);
            Thread.sleep(5000);
        }

    }
      **Code is not reaching here. Which means controls are not working on the above opened window .**

     driver.findElement(By.xpath("html/body/form/div[3]/table/tbody/tr[1]/td/div/table/tbody/tr[4]/td/div/div[2]/div/table/tbody/tr[11]/td[5]/a")).click();
     Thread.sleep(2000);
     driver.switchTo().window(Childwindow);
     Thread.sleep(4000);

}

}
```

<strong>Thanks in advance.</strong>  

#### Answer 2 (score 2)
To switch between windows there are multiple ways to do it. This is what we are using:  

```
public void switchToNewWindow(int windowNumber) {
    Set < String > s = driver.getWindowHandles();   
    Iterator < String > ite = s.iterator();
    int i = 1;
    while (ite.hasNext() && i < 10) {
        String popupHandle = ite.next().toString();
        driver.switchTo().window(popupHandle);
        System.out.println("Window title is : "+driver.getTitle());
        if (i == windowCount) break;
        i++;
    }
}
```

<p>When you call this method just pass the number of windows you want to switch. Say for 2nd window:
switchToNewWindow(2);</p>

<p>For 4th window:
switchToNewWindow(4);</p>

As getting window handle name is quite complex and it doesn't work some time because of spaces and special characters in window titles.  

Working as engineers in automated testing services we have to cope up with dynamic contents on the web pages. Above method will work on all applications because we just need to pass the window number(occurrence number of window).  

Hope this will help you.    

#### Answer 3 (score 2)
To switch between windows there are multiple ways to do it. This is what we are using:  

```
public void switchToNewWindow(int windowNumber) {
    Set < String > s = driver.getWindowHandles();   
    Iterator < String > ite = s.iterator();
    int i = 1;
    while (ite.hasNext() && i < 10) {
        String popupHandle = ite.next().toString();
        driver.switchTo().window(popupHandle);
        System.out.println("Window title is : "+driver.getTitle());
        if (i == windowCount) break;
        i++;
    }
}
```

<p>When you call this method just pass the number of windows you want to switch. Say for 2nd window:
switchToNewWindow(2);</p>

<p>For 4th window:
switchToNewWindow(4);</p>

As getting window handle name is quite complex and it doesn't work some time because of spaces and special characters in window titles.  

Working as engineers in automated testing services we have to cope up with dynamic contents on the web pages. Above method will work on all applications because we just need to pass the window number(occurrence number of window).  

Hope this will help you.    

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: Take screen shots using selenium webdriver (score [37526](https://stackoverflow.com/q/7147) in 2017)

#### Question
How to take screen shot on both test cases "Positive and Negative" results?  

NOTE: Currently, I am working in selenium webdriver (`junit`) and I did not have an idea about how to code for adding methods to take screen shots.  

#### Answer 2 (score 8)
Take the screenshot in the `@After` test tear down method, which is run after every test. This way you will always get a screenshot for both passed and failed tests.  

```
public class TestSample
{
    static WebDriver driver;

    @Before
    public void setUp() {
        //start new webdriver session, for eg using firefox
        driver = new FirefoxDriver();
    } 

    @Test
    public void aTest() {
        driver.get("http://www.google.com/");
        //more test logic  - test might pass or fail at this point
    }

    @After
    public void tearDown() {
        // take the screenshot at the end of every test
        File scrFile = ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
        // now save the screenshto to a file some place
        FileUtils.copyFile(scrFile, new File("c:\\tmp\\screenshot.png"));

    //quit WebDriver session
        driver.quit();
    }
}
```

#### Answer 3 (score 4)
I have <a href="http://apttest.in/how-to-capture-screenshot-in-webdriver-using-java/" rel="nofollow noreferrer">written a blog</a> on how to take screen shots while using webdriver APIs, This is a basic code but it will help you in taking screenshots.  

```
package screenshot_package;

import java.io.File;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class screenshot {

    public static void main(String[] args) {

        WebDriver driver = new FirefoxDriver();
        driver.get("http://apttest.in");

        try{
            //take screenshot and save it in a file
            File screenshot = ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);

            //copy the file to the required path
            FileUtils.copyFile(screenshot,new File("C:\\Users\\\udit\\Desktop\\screenshot.jpeg"));

        }catch(Exception e){
            //if it fails to take screenshot then this block will execute
            System.out.println("Failure to take screenshot "+e);

        }
        finally
        {
            //Whatever happens with the screenshot, driver will quit.
            driver.quit();
        }
    }
}
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How to generate Report Dashboard in Jmeter? (score [36515](https://stackoverflow.com/q/18816) in 2016)

#### Question
<p>Jmeter has come up with a latest release `3.0`.<br>
This is a major release not just bug fixes after almost a decade.<br>
I read that we can generate `Report Dashboard` as well with the latest release. </p>

Tell me how to do it?     

Step by step detailed instructions would be great.  

#### Answer accepted (score 9)
If you already have a .jtl result file you can do it like:  

```
jmeter -g /path/to/jtl/file -o /where/you/want/to/store/dashboard
```

If you would like the dashboard to be generated after the test run, you can <a href="https://www.blazemeter.com/blog/dear-abby-blazemeter-how-do-i-run-jmeter-non-gui-mode" rel="noreferrer">run JMeter in command-line non-GUI mode</a> like:  

```
jmeter -n -t /path/to/testplan -l /path/to/result.jtl -e -o /path/to/dashboard/folder
```

See <a href="http://jmeter.apache.org/usermanual/get-started.html#options" rel="noreferrer">Full list of command-line options</a> for all possible JMeter command-line arguments listed and explained.   

If above steps don't work - add the next lines to <em>user.properties</em> file (lives under "bin" folder of your JMeter installation)   

```
jmeter.save.saveservice.bytes=true
jmeter.save.saveservice.label=true
jmeter.save.saveservice.latency=true
jmeter.save.saveservice.response_code=true
jmeter.save.saveservice.response_message=true
jmeter.save.saveservice.successful=true
jmeter.save.saveservice.thread_counts=true
jmeter.save.saveservice.thread_name=true
jmeter.save.saveservice.time=true
jmeter.save.saveservice.timestamp_format=ms
jmeter.save.saveservice.timestamp_format=yyyy/MM/dd HH:mm:ss
```

JMeter restart will be required in order to pick the properties up.  

For dashboard customisation and tuning refer <a href="http://jmeter.apache.org/usermanual/generating-dashboard.html" rel="noreferrer">Generating Report Dashboard</a> user manual entry.  

#### Answer 2 (score 0)
I have given brief in details how to generate report dashboard in Jmeter in this StackExchange question,please read it and you will generate HTML reports clearly for your test plan.  

<a href="https://stackoverflow.com/questions/38263768/how-do-i-generate-a-dashboard-report-in-jmeter/39998477#39998477">https://stackoverflow.com/questions/38263768/how-do-i-generate-a-dashboard-report-in-jmeter/39998477#39998477</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: Alternatives to HP Quality Center for small business (score [36173](https://stackoverflow.com/q/2554) in 2012)

#### Question
Which are the alternatives today? Not only freeware, but tools affordable for a development team of 3-5 men.  

I like the structure and flexibility of HP QC, so a similar tool would be nice to have.  

#### Answer 2 (score 9)
After doing a few such evaluations myself in the last five years I can share my experience.  

<strong>TL;DR</strong> - Go with <a href="http://www.practitest.com/" rel="nofollow">PractiTest</a>  

Main reasons for my recommendation:  

<ul>
<li>Ease of use</li>
<li>Customisability</li>
<li>Has all the right/needed features to manage a QA process</li>
<li>Integrates well with JIRA and a few other defect trackers</li>
<li>Pricing is affordable and it is a very scalable solution - you can easily add or remove active users as per your needs and only pay for what you use on a monthly basis</li>
<li>Support is simply the best</li>
</ul>

<p><strong>In Length:</strong>
The two top tools found (in 2012 when the question was asked) were <a href="http://smartbear.com/products/qa-tools/test-management" rel="nofollow">QAComplete</a> from SmartBear and <a href="http://www.qmetry.com/" rel="nofollow">QMetry</a>. However, I have since found what I consider to be the perfect test management tool in terms of balance between functionality, usability and price: <a href="http://www.practitest.com/" rel="nofollow">PractiTest</a>. It was developed by people who were heavily involved with QualityCentre and so it comes as no surprises that when looking for a product to substitute QC it nails most of the important functionality. It is also much simpler and easy to use then QC (of course that comes at the expense of some functionality). In one of my last roles we tried <a href="http://www.inflectra.com/SpiraTest/" rel="nofollow">SpiraTest</a> for 6 months with no success (this was around 2013) and eventually moved to PractiTest and it was a huge success. Uptake and satisfaction within the team was phenomenal. I've since used it on another project where likewise I had very good results. This is now my standard recommendation for a QC replacement.</p>

The only thing I must say is that I never used their bug tracking features as we always integrated with JIRA, and so I can't comment on it. I'd say it will do for a small team but anything more than that I would recommend integrating with JIRA.  

<p>Back to <a href="http://smartbear.com/products/qa-tools/test-management" rel="nofollow">QAComplete</a> and <a href="http://www.qmetry.com/" rel="nofollow">QMetry</a>:
They both have strengths and weaknesses so depends on your specific requirements one of them would suit your team more. </p>

For a single tool environment (so requirements and defects managed in the same tool as the test cases) I would recommend QAComplete. It provides most of not all of QC features, it is very user friendly, has a great UI, customisable, allows bulk editing and in general is very easy to use. On the other hand its integration with other tools is luckluster: It only integrates with TestComplete and QTP as automation tools, and even that is not the best integration ever, mostly just results back pass\failed without specifics. It integrates with a few defect management and requirement managemenent tools however it does it in a weird way where everything is copied to the QAComplete db instead of a direct integration.  

<p>QMetry is more rounded, has a good UI, easy to use etc. It's test execution window is far from perfect (all tests are listed on one screen, passing\failing a step is 3 clicks etc.) but everything else about it is pretty good. Where it shines is in integration, especially with Jira (which has complete two way integration - you can even create a test case from a Jira ticket from within Jira!) and with various test automation tools. It also has quite a good custom reporting capability where you can write custom reports to suit your needs.
Where it falls short is in Customer Support where in a few instances our issues were not resolved and we basically did not get confident about it after dealing with them a few times.</p>

Another worthwhile mention (and cheap!) alternative is Spiratest (which is great functionality wise, has great integration with various other tools but has an outdated UI). However due to the clunky UI it didn't end up working out for one of the organisations I used to work for as mentioned above, so definitely demo before committing.  

You may also want to have a look at <strong>TestRail</strong> (good but not as feature rich), <strong>Zephyr</strong> (mostly very good, lacks a central repository of tests functionality, expensive), <strong>TestLodge</strong> (stopped looking at it when I saw there is no breakdown to steps), <strong>Testuff</strong> (didn't feel it was quite mature yet, but this was 1.5 years ago).    

A very interesting conclusion I came out of those tool search adventures with was that <strong><em>QC is actually an excellent tool</em></strong>. Might sound obvious but after excellent experience with TestComplete as an automation tool I was expecting that similarly there would be good alternatives to QC, however all the alternatives were still not as great as QC (even with its numerous shortcomings). However on the price front many of those tools compete very well with the HP offering and in terms of value for money beat QC quite handily.  

Let me know if you have any specific questions about any of the tools and I will try to answer to the best of my experience.  

<strong>Edit 1:</strong> had to remove some hyper links due to limit on new users  

<strong>Edit 2:</strong> updated my answer to include PractiTest  

#### Answer 3 (score 5)
Another alternative could be <a href="http://www.xqual.com" rel="nofollow">XStudio</a>.  It is a free tool and comes with desktop (standalone) version and online version.  We are using this tool in our organization for smaller projects (teams of 3-4 people) and it is satisfying our requirements.  Few of the features that I liked most and are comparative to HP:  

<ol>
<li>Can be integrated with third party defects management tool</li>
<li>Test cases authoring and their execution</li>
<li>Test Cycles management</li>
<li>Reports can be customized using XSLT</li>
<li>Supporting test automation using different technologies (Batch files, Selenium, Renorex etc.)</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: Selenium Webdriver | Unable to locate element error (score [35996](https://stackoverflow.com/q/6016) in 2013)

#### Question
I am trying to run the below code but getting error. Can you please point out the issue?  

```
import java.util.concurrent.TimeUnit;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;


public class SelTe2 {

public static void main(String[] args) {

    FirefoxProfile firefoxProfile = new FirefoxProfile();
    firefoxProfile.setPreference("network.proxy.type", 2);
    firefoxProfile.setPreference("network.proxy.autoconfig_url", "http://wpadhinj.techmahindra.com/wpad.dat");
    firefoxProfile.setPreference("network.proxy.no_proxies_on", "localhost");

    // Open Bing Search Engine
    WebDriver wd = new FirefoxDriver(firefoxProfile);
    wd.get("http://www.bing.com/?cc=in");

    // Search for Kotak and navigate to Net Banking Secure Login 
    WebElement we1 = wd.findElement(By.xpath("//input[contains(@title, 'search')]"));
    we1.sendKeys("kotak");
    we1.sendKeys(Keys.RETURN);
    wd.findElement(By.xpath("//a/strong[text()='Kotak']")).click();
    wd.findElement(By.xpath("//li/a[text()='Net Banking']")).click();
    wd.findElement(By.xpath("//a/img[@title='NetBanking Secure Login']")).click();

    // Switch to child window
    for (String handles : wd.getWindowHandles()) {
        if (!wd.getTitle().contains(wd.getWindowHandle())){
            wd.switchTo().window(handles);
        }
    }

    // Wait for 15 sec. while page loads
    wd.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);

    // Enter Username and Password
    wd.findElement(By.name("Username")).sendKeys("selenium");
    wd.findElement(By.name("Password")).sendKeys("selenium");

    }    
}
```

Error Description: -  

<p><code>Exception in thread "main" org.openqa.selenium.NoSuchElementException: Unable to locate element: {"method":"name","selector":"Username"}
Command duration or timeout: 15.06 seconds
For documentation on this error, please visit: http://seleniumhq.org/exceptions/no_such_element.html
Build info: version: '2.31.0', revision: '1bd294d', time: '2013-02-27 20:53:56'
System info: os.name: 'Windows XP', os.arch: 'x86', os.version: '5.1', java.version: '1.6.0_43'
Session ID: 73e4a32c-9447-4242-a13b-7bc5a9f21406
Driver info: org.openqa.selenium.firefox.FirefoxDriver
Capabilities [{platform=XP, acceptSslCerts=true, javascriptEnabled=true, browserName=firefox, rotatable=false, locationContextEnabled=true, version=20.0.1, cssSelectorsEnabled=true, databaseEnabled=true, handlesAlerts=true, browserConnectionEnabled=true, nativeEvents=true, webStorageEnabled=true, applicationCacheEnabled=true, takesScreenshot=true}]
    at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
    at sun.reflect.NativeConstructorAccessorImpl.newInstance(Unknown Source)
    at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(Unknown Source)
    at java.lang.reflect.Constructor.newInstance(Unknown Source)
    at org.openqa.selenium.remote.ErrorHandler.createThrowable(ErrorHandler.java:187)
    at org.openqa.selenium.remote.ErrorHandler.throwIfResponseFailed(ErrorHandler.java:145)
    at org.openqa.selenium.remote.RemoteWebDriver.execute(RemoteWebDriver.java:554)
    at org.openqa.selenium.remote.RemoteWebDriver.findElement(RemoteWebDriver.java:307)
    at org.openqa.selenium.remote.RemoteWebDriver.findElementByName(RemoteWebDriver.java:380)
    at org.openqa.selenium.By$ByName.findElement(By.java:292)
    at org.openqa.selenium.remote.RemoteWebDriver.findElement(RemoteWebDriver.java:299)
    at SelTe2.main(SelTe2.java:44)
Caused by: org.openqa.selenium.remote.ErrorHandler$UnknownServerException: Unable to locate element: {"method":"name","selector":"Username"}
Build info: version: '2.31.0', revision: '1bd294d', time: '2013-02-27 20:53:56'
System info: os.name: 'Windows XP', os.arch: 'x86', os.version: '5.1', java.version: '1.6.0_43'
Driver info: driver.version: unknown
    at &lt;anonymous class&gt;.FirefoxDriver.prototype.findElementInternal_(file:///C:/DOCUME~1/SS0041~1/LOCALS~1/Temp/anonymous5139644307112851862webdriver-profile/extensions/fxdriver@googlecode.com/components/driver_component.js:8281)
    at &lt;anonymous class&gt;.fxdriver.Timer.prototype.setTimeout/&lt;.notify(file:///C:/DOCUME~1/SS0041~1/LOCALS~1/Temp/anonymous5139644307112851862webdriver-profile/extensions/fxdriver@googlecode.com/components/driver_component.js:382)
</code></p>

#### Answer accepted (score 5)
In your comment you mentioned that the element is within a &lt;frameset> \ &lt;frame>.  To work with any element within a frame, you need to first switch the context of the driver from the main page to that frame:  

`driver.switchTo().frame("foo");`  

In this example "foo" would be the name of the iframe.  You can also do it by index if the frame has no name value.   

<p>If you need to switch back to the main page, outside of the frame you would use:
`driver.switchTo().defaultContent();`</p>

<p>There is a little more detail in the documentation: <a href="http://docs.seleniumhq.org/docs/03_webdriver.jsp">http://docs.seleniumhq.org/docs/03_webdriver.jsp</a>.
Look for switchTo().frame</p>

#### Answer 2 (score 0)
Try using something as follows :-  

```
WebDriverWait wait = new WebDriverWait(driver, 60);// 1 minute 
wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("Username")));
driver.findElement(By.name("Username")).sendKeys("selenium");
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Tools to measuring page rendering time (score [35790](https://stackoverflow.com/q/6196) in 2013)

#### Question
I'm using Jmeter at my organization for performance testing. The application is a secured web portal that provides a lot of reports and documents to its user.   

A major issue that I've run into is measuring the page load times, this is very important for me to measure. Apparently JMeter doesn't support this.   

So my question is what tools can I use to measure the page rendering times? It doesn't have to free, all that I need is a reliable tool. Again, this is for a secure application which requires user authentication.  

#### Answer 2 (score 5)
<strong>There are no tools that can provide you client-side rendering times</strong>. Client side rendering is not a measurable value, unless all of the devices accessing the system are identical in terms of hardware and network access to the SUT.  

<em><strong>However</em></strong>, It is completely viable to do a <strong>stopwatch test</strong> of the total page rendering time, as long as you communicate to the client/whoever you are reporting to that those measurements are an indication only and take note of the configuration you were using when you took your measurements.  

In the past I've had a JMeter test running to apply peak load to the system, and manually I browsed the site using <strong>Fiddler</strong> in "Streaming" mode. By viewing the timeline you can see the client side rendering time which shows up as "gaps" between requests.  

Remember that almost all performance testing tools send network traffic to apply load to a system and therefore will never capture client side render times. Even if they claim to do so, I would be extremely wary.  

#### Answer 3 (score 3)
Check out HTTPWatch <a href="http://www.httpwatch.com/" rel="nofollow">http://www.httpwatch.com/</a>  

It's a really good tool that sounds like it may meet your needs.  

I've used the free "Basic Edition" version for some client-side performance tests and analysis. And I've recommended it to some friends who use the "Professional Edition".   

Good stuff, and one I keep in my Tester's Toolbox <a href="http://www.allthingsquality.com/2010/04/testers-tool-box.html" rel="nofollow">http://www.allthingsquality.com/2010/04/testers-tool-box.html</a>  

</section>

