<%@ LANGUAGE = VBScript %>
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">

<html>
<head>
<title> Module 3: Creating Your Own ActiveX Server Components </title>
</head>

<BODY BGCOLOR="#FFFFFF"><FONT FACE="ARIAL,HELVETICA" SIZE="2">
 
<h1><a name="module3writingyourownactivexservercomponents">Module 3: Writing Your Own ActiveX Server Components</a></h1>


<p>Now that <a href="atumd2.asp">Module 2</a> has familiarized you  with the components Active Server Pages (ASP) provides, it&#146;s time to think about creating your own components, components that meet your specific needs.</p>

<p>Suppose that you want to provide access to specific financial functions through your Web site. ASP does not explicitly provide access to such functionality, but getting it is as easy as creating your own ActiveX server component&#151;which you will do in this module. You will call your component from a form that we have provided. </p>

<p><strong><a name="note">Note</a>&#160;&#160;&#160;</strong>To  complete this module you must have installed on your computer:
<ul>
<li>Either the 32-bit version of Microsoft&#174; Visual Basic&#160;4.0 Professional Edition or Visual Basic&#160;4.0 Enterprise Edition development system.
<li>Active Server Pages.
</ul>
</p>
 
<hr>


<h2><a name="creatingthefinancecomponent">Lesson 1: Creating the Finance Component</a></h2>

<p>A component should contain a set of related methods (functions) that provide added value beyond what is in the scripting language that will be calling it. Because VBScript does not provide financial functions, you must give access to the Visual Basic finance functions by using your Finance server component. This server component could expose all of the Visual Basic finance functions including the <strong>DDB</strong> function (double-declining balance), <strong>FV</strong> function (future value), <strong>IPmt</strong> function (interest payment), <strong>IRR</strong> function (internal rate of return), and others. Only the 
implementation of the <strong>FV</strong> function will be documented in this tutorial. </p>

<h3><A NAME="startvisualbasic">Start Visual Basic</A></h3>

<ol>
<li>Click the <strong>Start</strong> button on the taskbar.</li>
<li>Select<strong> Visual Basic&#160;4.0</strong>. </li>
<li>Click <strong>Visual Basic&#160;4.0</strong> in the submenu to run the design environment. </li>
</ol>

<h3><A NAME="learnmoreaboutvisualbasicfinancefunctions">Learn More About Visual Basic Finance Functions</A></h3>

<p>The Visual Basic Help system describes the available functions.

<ol>
<li>Click <strong>Help</strong>. </li>
<li>Select <strong>Search For Help On</strong>.</li>
<li>With the <strong>Index</strong> tab selected, type <strong>finance</strong> as the word to look for.</li>
<li>Double-click the <strong>finance</strong> index entry. </li>
<li>Click <strong>FV Function</strong> to learn more about it.</li>
<li>Close the <strong>Visual Basic Help</strong> dialog box when you have finished reviewing the finance functions.</li>
</ol>
</p>

<h3><A NAME="nametheproject">Name the Project</A></h3>

<p>Visual Basic uses the project name as the first part of the name that is referenced in order to use the server component in an ASP script. 

<ol>
<li>Click <strong>Tools</strong>. </li>
<li>Select <strong>Options</strong>.</li>
<li>Click the <strong>Project</strong> tab. </li>
<li>Double-click the value <strong>Project1 </strong>in the <strong>Project Name</strong> text box. </li>
<li>Type <strong>MS</strong> and click <strong>OK</strong>. </li>
</ol>
</p>

<p>The project is now named MS. Later, you will reference the Finance server component as <FONT FACE="COURIER"><code>MS.Finance</code></FONT> from an ASP script. </p>

<h3><A NAME="removethedefaultform">Remove the Default Form</A></h3>

<p>The next section lays the groundwork for the Finance server component. Methods and properties provide the interface between ActiveX server components and scripts written in Visual Basic and other languages. Because browsers can request a script to run on the server, the executing script can ask for information from a server component and then format and return that information to the browser. The server component must not bring up a dialog box on the server&#146;s screen because the screen will not be displayed on the client browser.</p>

<p>Visual&#160;Basic version&#160;4.0 automatically creates a default form. You will remove this default form from your project because it will not be used.
<ol>
<li>In the <strong>View</strong> menu, select <strong>Project</strong>. </li>
<li>Select <strong>Form1</strong> within the <strong>Project1</strong> project window. </li>
<li>In the <strong>File</strong> menu, select <strong>Remove File</strong>. </li>
</ol>
</p>

<h3><A NAME="addthefinanceclasstotheproject">Add the Finance Class to the Project</A></h3>

<p>In Visual Basic, to create a component with a set of functionality you can call, you define a <em>class</em>. A class groups methods and properties. 
In your project, it will be the place within which you specify your finance methods.
<ol>
<li>From the <strong>Insert</strong> menu, choose <strong>Class Module</strong>. </li>
<li>Press the F4 key to display the property sheet for Class1. </li>
<li>Click the value <strong>0 - Not Creatable</strong> for <strong>Instancing</strong>. </li>
<li>Click the arrow, then select <strong>2 - Creatable MultiUse</strong>. </li>
<li>Triple-click <strong>Class 1</strong> to select the class name. </li>
<li>Type <strong>Finance</strong> to change the class name. </li>
<li>Click <strong>False </strong>for the property <strong>Public</strong>.</li>
<li>Type <strong>t </strong>to select <strong>True</strong> for the property <strong>Public</strong>. </li>
<li>Close the <strong>Finance</strong> property sheet </li>
</ol>
</p>

<h3><A NAME="addthecalcfvfunctiontothefinanceclass">Add the CalcFV Function to the Finance Class</A></h3>

<p>The Finance server component does require some programming code. This code will make the Visual Basic built-in future value function available to languages making use of your component. </p>

<p>Copy and paste the following lines into the Finance Class window:

<FONT FACE="COURIER"><pre>Public Function CalcFV(rate, nper, pmt, Optional pv, Optional whendue) 
CalcFV = FV(rate, nper, pmt, pv, whendue)
End Function</pre></FONT>
</p>

<h3><A NAME="addthecomponentsentrypoint">Add the Component&#146;s Entry Point</A></h3>

<p>All server components require an entry (starting) point. This is the code that will be called when the object is first made available to a 
language. In VBScript, when you use <strong>Server.CreateObject</strong>, an instance is created of an object. When the <strong>Server.CreateObject </strong>statement 
is executed, the <strong>Sub Main</strong> procedure in a server component (created with Visual Basic) is called. </p>

<p>Your finance component does not have to do anything special to initialize itself when it is called. For that reason, you can provide an 
empty (no Visual Basic statements) <strong>Sub</strong> <strong>Main</strong> procedure. 

<ol>
<li>In the <strong>Insert </strong>menu, select <strong>Module</strong>.<br>
</li>
<li>In the <strong>Module&#160;1</strong> window, type <strong>Sub Main.</strong><br>
</li>
<li>Press ENTER.<br>
</li>
</ol>
</p>

<p>This automatically enters the following code:

<FONT FACE="COURIER"><pre>Sub Main()
End Sub</pre></FONT> 
</p>

<h3><A NAME="savethefinanceproject">Save the Finance Project</A></h3>

<p>When you save your work, you will be asked to save all three parts of the Visual Basic project. These include the project file, the class 
module, and the code module.

<ol>
<li>Open the <strong>File </strong>menu.<br><br></li>
<li>Select <strong>Save Project</strong>. <br><br></li>
<li>In the <strong>File name</strong> text box, type <strong><em>DriveLetter</em>:\<%= Request.ServerVariables("SERVER_NAME")%>\winnt\system32\inetsrv\asp\cmpnts\Finance</strong> where you replace <em>DriveLetter</em> with the letter mapped to the appropriate drive on your computer. (If you did not accept the default installation directory, substitute the name of your installation directory  for \winnt\system32.)<br><br></li>
<li>Click the <strong>Save</strong> button. <br><br>
If a previous user has completed this portion of the tutorial, a message will appear stating that the file already exists. Save your version of the file over the older version.
<br><br></li>
<li>Click the <strong>Save</strong> button to save Module1. <br><br>
If a previous user has completed this portion of the tutorial, a message will appear stating that the file already exists. Save your version of the file over the older version.
<br><br></li>
<li>Double-click the value <strong>Project1</strong> in the <strong>File name</strong> text box to select it. <br><br></li>
<li>Type the name <strong>Finance</strong> for the Project file (.vbp).<br><br>
</li>
<li>Click the <strong>Save</strong> button to save the project. <br><br>
If a previous user has completed this portion of the tutorial, a message will appear stating that the file already exists. Save your version of the file over the older version.
</li>
</ol>
</p>

<h3><A NAME="makethecomponentaninprocesscomponent">Make the Component an In-Process Component</A></h3>

<p>Visual Basic allows you to create in-process ActiveX components (formerly called OLE Automation Servers) and out-of-process ActiveX components. An <em>in-process</em> ActiveX component is a dynamic-link library (file name extension .dll) that is loaded by the calling process. An <em>out-of-process</em> ActiveX component is an executable (file name extension .exe) that runs as a separate process from the calling application. Because in-process components are in the same process space as the calling program, they provide better performance than out-of-process components.</p>

<p>To make the Finance server component an in-process ActiveX component

<ol>
<li>Open the <strong>File</strong> menu.</li>
<li>Select <strong>Make OLE DLL File</strong>. </li>
<li>Click the <strong>Options</strong> button. </li>
<li>Select the <strong>Auto Increment</strong> check box. </li>
<li>Click <strong>OK</strong>. </li>
<li>Type <strong><em>DriveLetter</em>:\<%= Request.ServerVariables("SERVER_NAME")%>\winnt\system32\inetsrv\asp\cmpnts\Finance</strong> where you replace <em>DriveLetter</em> with the letter mapped to the appropriate drive on your computer. (If you did not accept the default installation directory, substitute the name of your installation directory  for \winnt\system32.)<br>
If a previous user has completed this portion of the tutorial, a message will appear stating that the file already exists. Save your version of the file over the older version.
</li>
<li> Exit Visual Basic.</li>
</ol>
</p>

<h3><A NAME="registerthefinanceservercomponent">Register the Finance Server Component</A></h3>

<p>All server components must be registered. Windows&#160;NT and Windows&#160;95 make use of the system registry to keep track of what server 
components are available for use. By registering the Finance server component, you make it callable by VBScript and all of the other 
OLE-compatible languages on your computer.

<ol>
<li>Open a command-prompt window.</li>
<li>Type <strong>cd <em>Drive Letter</em>:\<%= Request.ServerVariables("SERVER_NAME")%>\winnt\system32\inetsrv\asp\cmpnts</strong> at the command prompt, where you replace <em>DriveLetter</em> with the letter mapped to the appropriate drive on your computer. (If you did not accept the default installation directory, substitute the name of your installation directory  for \winnt\system32.)</li>
<li>Press the <font size=2><strong>ENTER</strong></font> key. </li>
<li>Type <strong>regsvr32 Finance.dll</strong>. </li>
<li>Press the <font size=2><strong>ENTER</strong></font> key. </li>
<li>Click the <strong>OK</strong> button when a dialog box appears that says <strong>DllRegisterServer in finance.dll succeeded</strong>. </li>
<li> Close the command-prompt window.</li>
</ol>
<hr>
</p>

<h2> <a name="callingthefinancecomponentfromascript">Lesson 2: Calling the Finance Component from a Script</a></h2>

<p>To test the component, you can call the component from Active Server Pages (ASP), Visual&#160;Basic, Microsoft&#174;&#160;Office products that use Visual&#160;Basic for 
Applications, or any other OLE Automation controller.</p>

<p>To call the Finance server component from Active Server Pages by using VBScript, you can use an HTML form as input to calculate the future 
value of a person&#146;s savings plan. </p>

<h3><A NAME="thehtmlform">The HTML Form</A></h3>

<p>An HTML form will be used to gather values that describe a savings plan. These values are assigned variables that are made available to an 
ASP script as part of the <strong>Request</strong> object. You can reference a value from an HTML form. For example, the annual percentage 
rate entered on a form can be referenced by a script using <FONT FACE="COURIER"><strong><code>Request("APR")</code></strong></FONT>. The HTML tag <FONT FACE="COURIER"><code>&lt;INPUT TYPE=TEXT NAME=APR&gt;</code></FONT> provides 
the input field necessary to enter a value. </p>

<p>To send the form to a Microsoft Web server running ASP, the user presses a Submit button. The 
Submit button calls the page indicated by the <FONT FACE="COURIER"><code>ACTION</code></FONT> property of the HTML form tag. The HTML tag for the Submit button (<FONT FACE="COURIER"><code>&lt;INPUT 
TYPE=SUBMIT VALUE=" Calculate Future Value "&gt;</code></FONT>) uses the value for <FONT FACE="COURIER"><code>ACTION</code></FONT> from the HTML form tag (<FONT FACE="COURIER"><code>&lt;FORM METHOD=POST 
ACTION="Finance.asp"&gt;</code></FONT>) to call the ASP page Finance.asp.</p>

<p>We have created the form for you. Use your text editor to open the file Finance.htm in the Lessons directory (<em>Drive Letter</em>:\<%= Request.ServerVariables("SERVER_NAME")%>\Inetpub\Aspsamp\Tutorial\Lessons by default, where you replace <em>DriveLetter</em> with the letter mapped to the appropriate drive on your computer).</p>

<h3><A NAME="thescript">The Script</A></h3>

<p>VBScript is used to call your Finance server component. The script starts by validating the inputs from the HTML form and assigning default values for any values that were not entered on the form. The VBScript <strong>IsNumeric</strong> function is used to test whether or not a numeric (valid) 
value was entered for each of the boxes on the HTML form. </p>

<p><strong>Server.CreateObject</strong> is used to create an instance of (that is, make usable) your Finance component named <FONT FACE="COURIER"><code>MS.Finance</code></FONT>. Once an instance 
of a server component is created, you can make use of its methods and properties. On the script line immediately following 
<strong>Server.CreateObject</strong>, the method <strong>CalcFV</strong> is used to calculate a savings plan&#146;s future value. The result of this calculation is then sent to the browser of the user requesting the information.</p>

<p>To view the script, use a text editor to open the file Finance.asp in the Lessons directory (<em>DriveLetter</em>:\<%= Request.ServerVariables("SERVER_NAME")%>\Inetpub\Aspsamp\Tutorial\Lessons by default, where you replace <em>DriveLetter</em> with the letter mapped to the appropriate drive on your computer).</p>

<h3><A NAME="usingyourbrowsertorunthetest">Using Your Browser to Run the Test</A></h3>

<p>To run the Finance.asp ASP page, open the  Finance.htm  form, which  then calls the Finance.asp script to calculate the future value of the savings plan specified on the HTML form. 

<ol>
<li>Open Finance.htm by pointing  your browser to <a href="http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/finance.htm">http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/finance.htm</a>.</li>
<li>Optionally, enter values for the form inputs in the <strong>Savings Plan</strong> form. <br></li>
<li>Click the <strong>Calculate Future Value</strong> button. The value of your savings plan should appear. </li>
</ol>
</p>

<p>In a relatively short time you have created a useful ActiveX server component. If you need access to other financial functions, you can implement the other financial functions built into Visual Basic as additional methods of your Finance server component. </p>
<hr>
<p align=center><a href="/iasdocs/aspdocs/sdklegal.htm"><em>&#169; 1996 Microsoft Corporation. All rights reserved.</em></a></p>
</FONT>
</body>
</html>
