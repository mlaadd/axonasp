<%@ LANGUAGE = VBScript %>
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">

<html>
<head>
<title>Module 1: Creating ASP Pages</title>
</head>

<BODY BGCOLOR="#FFFFFF"><FONT FACE="ARIAL,HELVETICA" SIZE="2">
<h1><a name="module1">Module 1: Creating ASP Pages</a></h1>
<p>In this module, you will learn some ASP basics by creating your own ASP pages (.asp files). You will find the example files you are to use in these lessons in the Tutorial\Lessons directory in your Active Server Pages samples directory (<%= Request.ServerVariables("SERVER_NAME")%>\InetPub\ASPSamp\Tutorial by default). Save the files you create in the Tutorial\Lessons directory as well.</p>

<p><Strong>Note</Strong>&#160;&#160;&#160; You must have either a Web server with Active Server Pages installed, or Write and Execute permissions on a remote directory share of a Web server with Active Server Pages installed, in order to save and view your work in this module.
 <hr>
</p>

<h2><a name="creatingasimpleactivexpage">Lesson 1: Creating a Simple ASP Page</a></h2>

<p>The best way to learn about ASP pages is to write your own. To create an ASP page, use a text editor to insert script commands into an HTML page. Saving the page with an .asp file name extension tells ASP to process the script commands. To view the results of a script, simply open the page in a Web browser. In this lesson, you will create the popular &#147;Hello World!&#148; script by copying HTML and ASP scripting commands from this tutorial into a text editor. You can then view the script&#146;s output with your browser after you save the file in the text editor. </p>

<p>The following HTML commands create a simple page with the words &#147;Hello World!&#148; in a large font:
<FONT FACE="COURIER"><pre>&lt;HTML&gt; 
&lt;BODY&gt;
&lt;FONT SIZE=7&gt; 
Hello World!&lt;BR&gt; 
&lt;/FONT&gt; 
&lt;/BODY&gt;
&lt;/HTML&gt; </pre></FONT>
</p>

<p>Suppose you wanted to repeat this text several times, increasing the font size with each repetition. You could repeat the font tags and HTML text, giving it a different font size with each repetition. When a browser opens the HTML page, the line will be displayed several times. </p>
<p>
Alternatively, you could use ASP to generate this same content in a more efficient manner.
</p>

<h3><A NAME="createandsaveapage">Create and Save a Page</A></h3>

<ol>
<li>Start a text editor (such as Notepad) or a word processor (such as Microsoft&#174; Word). Position the text editor window and the 
browser window so that you can see both.<br><br>

<li>Copy and paste the following HTML tags at the beginning of the file:
<FONT FACE="COURIER"><pre>&lt;HTML&gt;
&lt;BODY&gt; </pre></FONT>

<li>Save the document as <FONT FACE="COURIER"><code>Hello.asp</code></FONT> in the Lessons directory (<%= Request.ServerVariables("SERVER_NAME")%>\InetPub\ASPSamp\Tutorial\Lessons by default). Be sure to save the file in text format if you are using a word processor, including WordPad. ASP  pages must have the .asp extension to work properly.<br><br>

If another user has previously completed this portion of the tutorial, a message will appear stating that the file Hello.asp already exists, and asking if you want to replace it. If this happens, replace the older version of Hello.asp with your newer version.<br><br> 

<li>Start a new line after the <FONT FACE="COURIER"><code>&lt;BODY&gt;</code></FONT> tag and copy and paste the following script command: <p><FONT FACE="COURIER"><CODE>&lt;% For i = 3 To 7 %&gt; </CODE></FONT>
<p>Script commands are enclosed within <FONT FACE="COURIER"><code>&lt;%</code></FONT> and <FONT FACE="COURIER"><code>%&gt;</code></FONT> characters (also called <em>delimiters</em>). Text within the delimiters is processed as a script command. Any text following the closing delimiter is simply displayed as HTML text in the browser. This script command begins a VBScript loop that controls the number of times the phrase "Hello World" is displayed. The first time through the loop, the counter (<FONT FACE="COURIER"><code>i</code></FONT>) is set to 3. The second time the loop is repeated, the counter is set to 4. The loop is repeated until the counter exceeds 7. <br><br>

<li>Press ENTER, then copy and paste the following line: <p><FONT FACE="COURIER"><CODE>&lt;FONT SIZE=&lt;% = i %&gt;&gt; </CODE></FONT>
<p>Each time through the loop, the font size is set to the current value of the counter (<FONT FACE="COURIER"><code>i</code></FONT>). Thus, the first time the text is displayed, the 
font size is 3. The second time, the font size is 4. The last time, the font size is 7. Note that a script command can be enclosed within an HTML tag. </p>

<li>Press ENTER, then copy and paste the following lines: <FONT FACE="COURIER">
<pre>Hello World!&lt;BR&gt; 
&lt;% Next %&gt;
&lt;/BODY&gt;
&lt;/HTML&gt;</pre></FONT>

<p>The VBScript <strong>Next</strong> expression repeats the loop (until the counter exceeds 7). </p>
</li>

<li>The complete file (Hello.asp) should now contain the following script:
<FONT FACE="COURIER"><pre>&lt;HTML&gt;
&lt;BODY&gt;
&lt;% For i = 3 To 7 %&gt; 
&lt;FONT SIZE=&lt;% = i %&gt;&gt; 
Hello World!&lt;BR&gt; 
&lt;% Next %&gt; 
&lt;/BODY&gt; 
&lt;/HTML&gt;
</pre></FONT>
</li>

<li>Save your changes. Be sure to save your file in text format and be sure the file name extension is .asp. 
<br><br>

<p>Some text editors automatically change the file name extension to .txt when you choose <Strong>Text Format </Strong> in the <Strong>Save</Strong> dialog box. If this 
happens, replace the .txt extension with the .asp extension before you click <strong>Save</strong>. </p></li>

<li>Exit your text editor. A browser might not be able to read an HTML page that is open in a text editor. </li><br><br>

<li>To view the results of your work (after which you can return to this Tutorial by clicking the Back button in your browser), point your browser to <a href="http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/hello.asp"> http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/hello.asp</a>. 

<br><br>You should see a Web page with &#147;Hello World!&#148; displayed five times, each time in a larger font size.
</ol>

<p>Congratulations! You have completed your first ASP page. As you have learned, the process of creating an ASP page is simple. You can use any text editor to create HTML content and ASP script commands (enclosed in <FONT FACE="COURIER"><code>&lt;%</code></FONT> and <FONT FACE="COURIER"><code>%&gt; </code></FONT> delimiters) as long as you give your files an .asp file name extension. To test a page and see the results, you open the page in a Web browser (or refresh a 
previously opened page).
<hr>
</p>

<h2><a name="creatinganhtmlform">Lesson 2: Creating an HTML Form</a></h2>

<p>A common use of  intranet and Internet server applications is to process a form submitted by a browser. Previously, you needed to write a program to process the data submitted by the form. With ASP, you can embed scripts written in VBScript or JScript directly into an HTML file to process the form. ASP reads the scripts, performs the commands, and returns the results to the browser.</p>

<p>In this lesson, you will create an ASP page that processes the data a user submits by way of an HTML form.</p>

<p>To see how the .asp file works, fill in the form below. You can use the TAB key to move around the form. Click the <Strong><a name="script1">Submit </a></Strong> button to send your data to the Web server and have it processed by ASP.

<hr>
<!--#include file="script1.asp" -->
<hr>

<h4>Create the Form</h4>

<p>We have created a form to request user information; you can find it in the file Form.htm in the Lessons directory:

<FONT FACE="COURIER"><pre>&lt;HTML&gt;
&lt;HEAD&gt;&lt;TITLE&gt;Order&lt;/TITLE&gt;&lt;/HEAD&gt;

&lt;BODY&gt;
&lt;H2&gt;Sample Order Form&lt;/H2&gt;
&lt;P&gt;
Please provide the following information, then click Submit:

&lt;FORM METHOD="POST" ACTION="response.asp"&gt;
&lt;P&gt;
First Name: &lt;INPUT NAME="fname" SIZE="48"&gt;
&lt;P&gt;
Last Name: &lt;INPUT NAME="lname" SIZE="48"&gt;
&lt;P&gt;
Title: &lt;INPUT NAME="title" TYPE=RADIO VALUE="mr"&gt;Mr.
&lt;INPUT NAME="title" TYPE=RADIO VALUE="ms"&gt;Ms.

&lt;P&gt;&lt;INPUT TYPE=SUBMIT&gt;&lt;INPUT TYPE=RESET&gt;
&lt;/FORM&gt;

&lt;/BODY&gt;

&lt;/HTML&gt;</pre></FONT>
</p>

<p>Like all forms, this one sends the data to the Web server as pairs of variables and values. For example, the name the user types in the 
<FONT FACE="COURIER"><code>First Name</code></FONT> text box is assigned to the variable named <FONT FACE="COURIER"><code>fname</code></FONT>. ASP provides built-in objects that you can use to access the 
variable names and values submitted by a form. </p>

<h3><A NAME="createtheaspresponsepage">Create the ASP Response Page</A></h3>

<ol>
<li>Use your text editor to open the Response.asp file in the Lessons directory (<%= Request.ServerVariables("SERVER_NAME")%>\InetPub\ASPSamp\Tutorial\Lessons by default). 

<br><br>This file contains the HTML page that the Web server returns to the client browser. You will add ASP script commands to this page to process the information from the form. <br><br></li>

<li>Search for the words "Tutorial Lesson" and copy and paste the following lines of script underneath the comment: 
<FONT FACE="COURIER"><pre>&lt;% 
Title = Request.Form("title") </pre></FONT>

If another user has previously completed this portion of the tutorial, this script command will already be in place underneath the "Tutorial Lesson" comment. Paste the copied script over the existing script.  

<br><br>Your form transmits three pieces of information to ASP:

<ul>
<li><font face="courier"><CODE>fname</CODE></FONT>
<li><font face="courier"><CODE>lname</CODE></FONT>
<li><font face="courier"><CODE>title</CODE></FONT>
</ul>

<p>
ASP stores information submitted by way of HTML forms in the <b>Forms</b> collection of the <b>Request</b> object. (You can learn more about objects and forms in <a href="/iasdocs/aspdocs/guide/asgovr.htm ">Scripting Guide</a> and <a href="/iasdocs/aspdocs/ref/obj/introbj.htm"> Object Reference</a>). To retrieve information from the <Strong>Request</Strong> object, you type the following: 
<FONT FACE="COURIER"><code>Request.<em>collection-name</em> ("<em>property-name</em>")</code></FONT>. Thus, <FONT FACE="COURIER"><code>Request.Form ("title")</code></FONT> retrieves <FONT FACE="COURIER"><code>mr</code></FONT> or  <FONT FACE="COURIER"><code>ms</code></FONT>, depending on the value the user submitted. <br><br></li>

<li>Copy and paste the following lines of script following the line you inserted in Step 2: <FONT FACE="COURIER">
<pre>    
LastName = Request.Form("lname")
If Title = "mr" Then 
%&gt;  
Mr. &lt;%= LastName %&gt;  
&lt;% ElseIf Title = "ms" Then %&gt; 
Ms. &lt;%= LastName %&gt; 
</pre></FONT>
</p>

<p> If another user has previously completed this portion of the tutorial, these lines of script will already be in place. Paste the copied lines of script over the existing script.</p>

<p>The VBScript <strong>If...Then</strong> statement performs two different actions depending on the value of <FONT FACE="COURIER"><code>Title</code></FONT>. If <FONT FACE="COURIER"><code>Title</code></FONT> is <FONT FACE="COURIER"><code>mr</code></FONT>, the user 
will be addressed as &#147;Mr.&#148; If <FONT FACE="COURIER"><code>Title</code></FONT> is <FONT FACE="COURIER"><code>ms</code></FONT>, the user will be addressed as &#147;Ms.&#148; You display the value of a variable by using the expression <FONT FACE="COURIER"><code>&lt;%= <em>variable-name</em> %&gt;</code></FONT>.</p>

<li>To display both the first and last name if the user did not choose a title, copy and paste the following lines of script following the line you inserted in Step&nbsp;3:<FONT FACE="COURIER"><pre>&lt;% Else %&gt;
&lt;%= Request.Form("fname") &amp; " " &amp; LastName %&gt;
&lt;% End If %&gt; 
</pre></FONT>

<p>If another user has previously completed this portion of the tutorial, these lines of script will already be in place. Paste the copied script over the existing script.</p>

<p>The ampersand (<FONT FACE="COURIER"><CODE>&amp;</CODE></FONT>) joins the values of the variables into one string. The <strong>End If</strong> statement ends the conditional statement.</p></li>

<li>Save your changes to Response.asp and exit the text editor. Be sure your text editor does not replace the .asp extension.<br><br></li>

<li>To verify that the form you've created works (after which you can return to this Tutorial by clicking Back in your browser), point your browser to <a href="http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/form.htm">http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/form.htm</a></li>
</ol>

<p>Congratulations! You have activated your first HTML form. To learn about ActiveX server components, go on to <a href="atumd2.asp">Module 2: Using ActiveX Server Components</a>. </p>
<hr>
<p align=center><a href="/iasdocs/aspdocs/sdklegal.htm"><em>&#169; 1996 Microsoft Corporation. All rights reserved.</em></a></p>
</FONT>
</body>

</html>
