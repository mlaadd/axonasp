<%@ LANGUAGE = VBScript %>
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">

<html>
<HEAD>
<title>Module 2: Using ActiveX Server Components</title>
</HEAD>
<BODY BGCOLOR="#FFFFFF"><FONT FACE="ARIAL,HELVETICA" SIZE="2">
<h1><a name="module2">Module 2: Using ActiveX Server Components</a></h1>

<p>ActiveX server <I>components</I> extend your scripting capabilities by providing a reusable means of gaining access to information. For example, the Database Access component enables scripts to query databases. Thus, whenever you want to query a database from a script, you can use the Database Access component; you need not write complex scripts to perform this task. You can call components from any script or programming language that supports Automation (ActiveX server components are Automation servers). In this module, you will use ActiveX server components that are included with ASP to activate a sample Web site.</p>

<p>By now, you should be familiar with the basics of writing .asp files. If not, complete <a href="atumd1.asp">Module 1</a> of this tutorial.</p>

<p><Strong>Note</Strong>&#160;&#160;&#160; You must have either a Web server with Active Server Pages installed, or Write and Execute permissions on a remote directory share of a Web server with Active Server Pages installed, in order to save and view your work in this module.
 <hr>
</p>

<h2><a name="usingtheadrotatorcomponent">Lesson 1: Using the Ad Rotator Component</a></h2>

<p>Internet Web sites often provide advertising space. To keep sites visually interesting and to display ads from several advertisers in limited space, you might want to cycle through different advertisements. The Ad Rotator component simplifies the task of displaying each ad in turn and makes it easier to add new ads. In this lesson, you will create a script that calls the Ad Rotator component to rotate through four randomly selected ads. Click the Show Me button below to see an example of an ad you are going to display, then click the button repeatedly to rotate through other ads.

<hr>
<!--#include file="script4.asp" -->
<hr>
</p>

<h3><A NAME="createtheadfile">Create the Ad File</A></h3>

<p>You will create a simple text file to tell the Ad Rotator component which ads to insert and for what percentage of time each ad should be displayed. We have already created a file containing ads from the Adventure Works sample Web site for you. To view it, use your text editor to open the file Adrot.txt in the Lessons directory (<%= Request.ServerVariables("SERVER_NAME")%>\Inetpub\ASPSamp\Tutorial\Lessons by default). </p>

<p>The first line of the file sets the script that will be called when a user clicks on an advertisement; in this case, Adredir.asp. This script enables you to track ad popularity. The following three lines establish the width, height, and border of the ad images.

<FONT FACE="COURIER"><pre>redirect /aspsamp/advworks/adredir.asp
width 460
height 60
border 1</pre></FONT>
</p>

<p>Next, the file contains ad data. For each ad, this includes the image to use, the URL to which to go when a user clicks the ad (after going to Adredir.asp, in this example), the text associated with the image, and the percentage of time this ad is to be displayed:

<FONT FACE="COURIER"><pre>/aspsamp/advworks/multimedia/images/ad_1.gif
http://www.microsoft.com
Astro Mt. Bike Company
20</pre></FONT>
</p>

<p>By maintaining the ad information in a separate file, a different group at your company can update the Adrot.txt file without requiring you to update your ASP page. Different groups can maintain different files of ads for different parts of your site. </p>

<h3><A NAME="createthescript">Create the Script</A></h3>

<ol>
<li>Use your text editor to open the file Ad.asp in the Lessons directory (<%= Request.ServerVariables("SERVER_NAME")%>\Inetpub\ASPSamp\Tutorial\Lessons by default).
<br><br></li>

<li>Search for the words &#147;Tutorial Lesson: Ad Rotator.&#148; You will add your script here.<br><br></li>

<li>Create an instance of the Ad Rotator component and assign it to the variable <FONT FACE="COURIER"><code>Ad</code></FONT> by copying the following script command and pasting it into your text editor (after the 
comment): <FONT FACE="COURIER"><pre>&lt;% Set Ad = Server.CreateObject("MSWC.Adrotator") %&gt; </pre></FONT>

<p>If another user has previously completed this portion of the tutorial, this script command will already be in place. Paste the copied script over the existing script.</p>

<p>Assigning a component instance to a variable enables you to refer to a component later in a script.</p></li>

<li>To fetch an ad from the file, use the <b>GetAdvertisement</b> method of the Ad Rotator component. Add the following command to your script: 
<FONT FACE="COURIER"><pre>&lt;%= Ad.GetAdvertisement("/aspsamp/tutorial/lessons/adrot.txt") %&gt; </pre></FONT>

<p>If another user has previously completed this portion of the tutorial, this script command will already be in place. Paste the copied script over the existing script.</p>

<p>The <b>GetAdvertisement</b> method takes one parameter (the name of the file containing the ad information, in this case Adrot.txt). On the basis of this parameter, the method returns a fully formatted HTML &lt;IMG&gt; tag with the appropriate ad. The variable name you assigned to the Ad Rotator component instance, <b>Ad</b>, precedes the method, <b>GetAdvertisement</b>, and the path for the file Adrot.txt. The equal sign sends the value returned by the method (the actual ad) to the client browser.</p>
</li>

<li>Save changes to Ad.asp in text format and exit your text editor. Be sure your text editor does not replace the .asp file name extension.
<br><br></li>

<li>To verify that the ASP page you&#146;ve created works (after which you can return to this Tutorial by clicking Back in your browser), point your browser to
<a href="http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/ad.asp">http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/ad.asp</a> 
</li>
</ol>

<h3><A NAME="onyourown">On Your Own</A></h3>

<p>The Adventure Works sample site also has an example of the <a href="http://<%= Request.ServerVariables("SERVER_NAME")%>/advworks/excursions/default.asp">Ad Rotator component</a>. Click the <Strong>View ASP Source </Strong> button  to see the script commands that activate the Ad Rotator component.</p> 

<p><Strong>Note</Strong>&#160;&#160;&#160; If  you have not yet visited the Adventure Works sample site, the preceding link will automatically redirect you to the Adventure Works home page (this is a feature of the Adventure Works site). If this happens, use the <Strong> Back </Strong> button on your Web browser to navigate back to the tutorial and follow the link again.     
<hr></p>

<h2><a name="usingthebrowsercapabilitiescomponent">Lesson 2: Using the Browser Capabilities component</a></h2>

<p>Not all browsers support the rapidly expanding array of features available in the hypermedia world: Frames, background sounds, Java applets, and tables are examples of features that some browsers support and others do not. You can use the Browser Capabilities component to present content in formats that are appropriate for the capabilities of specific browsers. For example, if a browser does not support tables, the Browser Capabilities component can display the data in an alternate form such as text. </p>

<p>In this lesson, you will enhance the Ad Rotator script you created in Lesson 2. If a user&#146;s browser supports ActiveX controls, the user sees a set of ads that appear one after another, with a variety of &#147;fade-ins&#148; and &#147;fade-outs.&#148; If the browser does not support ActiveX controls, the user still sees the alternating series of ads that the Ad Rotator component displays. An example of a browser-sensitive rotating ad appears below. (If your browser does not support this technology, you will see the same ads that you saw in <a href="#usingtheadrotatorcomponent">Lesson 1</a>.)</p>

<p>
<hr>
<font color="#FF0000"><strong>Important</strong></font>&#160;&#160;&#160;You must complete <a href="#usingtheadrotatorcomponent">Lesson 1</a> before doing this lesson. 
<hr>
</p>

<!--#include file="script5.asp" -->

<hr>

<h3><A NAME="createthescriptb">Create the Script </A></h3>

<ol>
<li>Start your text editor and open the file Ad.asp in the Lessons directory (<%= Request.ServerVariables("SERVER_NAME")%>\Inetpub\ASPSamp\Tutorial\Lessons by default).
<br><br></li>

<li>Search for the words &#147;Tutorial Lesson: Start Browser Capabilities.&#148; You will add your script below this comment.<br><br></li>

<li>Create an instance of the Browser Capabilities component and assign it the variable <FONT FACE="COURIER"><code>OBJbrowser</code></FONT> by copying the following script command and pasting it into Ad.asp. Be sure to insert the command above the <FONT FACE="COURIER"><code>&lt;% Set Ad...%&gt; </code></FONT>statement: <FONT FACE="COURIER"><pre>&lt;% Set OBJbrowser = Server.CreateObject("MSWC.BrowserType") %&gt;</pre></FONT>

<p>If another user has previously completed this portion of the tutorial, this script command will already be in place. Paste the copied script over the existing script.
</p></li>

<li>Use the VBScript <strong>If...Then...Else</strong> statement to determine whether or not a client browser supports ActiveX controls. If it does, the Ad Billboard control will be used; if the browser does not support ActiveX Controls, the Ad Rotator ActiveX server component on the server will be used. To incorporate this logic, copy the following script and paste it after the <FONT FACE="COURIER"><code>&lt;%&#160;Set&#160;OBJbrowser...%&gt;</code></FONT> 
statement you inserted in Step 2: 
<FONT FACE="COURIER"><pre>&lt;% If OBJbrowser.ActiveXControls = "True" Then %&gt; 
&lt;OBJECT HSPACE="10" WIDTH="460" HEIGHT="60" 
  CODEBASE="/aspsamp/advworks/controls/nboard.cab"  
  DATA="/aspsamp/advworks/controls/billboard.ods"&gt; 
&lt;/OBJECT&gt; 
&lt;% Else %&gt; </pre></FONT>
</p>

<p>If another user has previously completed this portion of the tutorial, these lines of script will already be in place. Paste the copied script over the existing script.
</p>

<p>The Browser Capabilities component&#146;s <strong>ActiveXControls</strong> property determines whether the browser supports ActiveX controls. </p>

<p>You use the <FONT FACE="COURIER"><code>&lt;OBJECT&gt;</code></FONT> tag to insert an ActiveX control into an HTML page. The tag parameters specify the file from which the control reads data. In this example, this control reads compressed images from the Billboard.ods file. </p>

<p>
<strong>Note</strong>
&nbsp;&nbsp;&nbsp;
This control works properly only on <em>x</em>86-compatible computers. To complete this lesson on a non-<em>x</em>86-compatible computer, substitute a control that works properly on your computer.
</p>
</li>

<li>Search for the words &#147;Tutorial Lesson - End Browser Capabilites.&#148; Copy and paste the following script command below the comment to end the 
<strong>If...Then</strong> statement: 
<FONT FACE="COURIER"><pre>&lt;% End If %&gt; </pre></FONT>

<p>If another user has previously completed this portion of the tutorial, this script command will already be in place. Paste the copied script over the existing script.</p></li>

<li>Save changes to Ad.asp as a text file and exit your text editor. Be sure your text editor does not replace the .asp file name extension.
<br><br></li>

<li>To verify that the Active Server Page you&#146;ve created works (after which you can return to this Tutorial by clicking Back in your browser), point your browser to <a href="http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/ad.asp">http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/ad.asp</a>. </li>
</ol>

<p>
<b>Note</b>&#160;&#160;&#160; The file Browscap.ini (found in C:\Winnt\system32\inetsrv\ASP\Cmpnts by default) contains the data necessary for the Browser Capabilities component to recognize a browser and its capabilities. You will need to add new data to this file as new browsers are developed, or if you are using browser-dependent features that are not listed in the default Browscap.ini file.
<hr>
</p>

<h2><a name="usingthedatabaseaccesscomponent">Lesson 3: Using the Database Access Component </a></h2>

<p>The Database Access component uses Active Data Objects (ADO) to provide easy access to information stored in a database (or in another tabular data structure) that complies with the Open Database Connectivity (ODBC) standard. In this lesson, you will connect to a Microsoft&#174; Access customer database and display a listing of its contents. You will learn how to extract data using the SQL <strong><a name="select">SELECT</a></strong> statement and create an HTML table to display the results.</p>

<hr>
<!--#include file="script6.asp" -->
<hr>

<h3><A NAME="identifythedatabase">Identify the Database</A></h3>

<p>Before using a database with the Database Access component, you must identify the database in the ODBC application in Control Panel. 
In this example, you will use a Microsoft&#174; Access database that is provided with the ASP sample Web site.</p>

<ol>
<li>At the computer running your Web server, open <strong>Control Panel</strong>. 
<br><br></li>

<li>Double-click the ODBC icon, and then click <strong>System DSN</strong>.

<p>
There are two types of data sources: <strong>User</strong>, which is available only to you, and <strong>System</strong>, which is available to anyone using the 
computer. Data sources for use with the Web server need to be of the <strong>System</strong> type.
</p>

<li>Click <strong>Add</strong>, choose the <strong>Microsoft Access Driver</strong>, and then click <strong>Finish</strong>.
<br><br></li>

<li>In the <strong>Data Source Name </strong>box, type <b>AWTutorial</b>, and then click <strong>Select</strong>. Select the \AspSamp\AdvWorks\AdvWorks.mdb file 
(in the Inetpub directory by default), and click <strong>OK</strong>.
<br><br></li>

<li>Click <Strong>OK </Strong> to close the dialog boxes. </li>
</ol>

<h3><A NAME="createthecomponentinstance">Create the Component Instance</A></h3>

<ol>
<li>Use your text editor to open the file Database.asp in the Lessons directory (<%= Request.ServerVariables("SERVER_NAME")%>\Inetpub\Aspsamp\Tutorial\Lessons by default).
<br><br></li>

<li>Search for the words &#147;Tutorial Lesson - ADO Connection.&#148; You will copy and paste your script underneath this comment.
<br><br></li>

<li>As always, you need to create an instance of an object in order to use it. Copy and paste the following script command: 
<FONT FACE="COURIER"><pre>&lt;% 
Set OBJdbConnection = Server.CreateObject("ADODB.Connection")  </pre></FONT>

<p>If another user has previously completed this portion of the tutorial, this script command will already be in place. Paste the copied script over the existing script.</p></li>

<li>For the Database Access component, you also need to specify the ODBC <em>data source</em> (the database from which you want data) by opening a connection to the database. Copy and paste the following script command: 
<FONT FACE="COURIER"><pre>OBJdbConnection.Open "AWTutorial" </pre></FONT>

<p>If another user has previously completed this portion of the tutorial, this script command will already be in place. Paste the copied script over the existing script.</p></li>

<li>Use the Database Access component&#146;s <strong>Execute</strong> method to issue a SQL <strong>SELECT</strong>  (<strong>SQLQuery</strong>) to the database and store the returned records in a result set (<FONT FACE="COURIER"><code>RSCustomerList</code></FONT>). Copy and paste the following script commands below the <FONT FACE="COURIER"><code>OBJdbConnection.Open</code></FONT> statement: 

<FONT FACE="COURIER"><pre>SQLQuery = "SELECT * FROM Customers" 
Set RSCustomerList = OBJdbConnection.Execute(SQLQuery) 
%&gt;</pre></FONT>

<p>If another user has previously completed this portion of the tutorial, these lines of script will already be in place. Paste the copied script over the existing script.</p>

<p>You could combine these two lines of script by passing the literal <strong>SELECT</strong> string directly to the <strong>Execute</strong> method rather than
assigning it first to the variable <strong>SQLQuery</strong>. When the SQL SELECT is long, however, it makes the script easier to read if you assign the string to a 
variable name, such as <strong>SQLQuery</strong>, and then pass the variable name on to the <strong>Execute</strong> method. </p>
</li>
</ol>

<h3><A NAME="displaythereturnedresultset">Display the Returned Result Set</A></h3>

<p>You can think of the result set as a table whose structure is determined by the fields specified in the SQL <strong>SELECT</strong> statement. Displaying the 
rows returned by the query, therefore, is as easy as performing a loop through the rows of the result set. In this example, the returned data 
is displayed in HTML table rows. 

<ol>
<li>In Database.asp, find the words &#147;Tutorial Lesson - Display ADO Data,&#148; and copy and paste the following VBScript <strong>Do...Loop</strong> statement underneath the comment: <FONT FACE="COURIER">
<pre>&lt;% Do While Not RScustomerList.EOF %&gt;
  &lt;TR&gt;
  &lt;TD BGCOLOR="f7efde" ALIGN=CENTER&gt; 
    &lt;FONT STYLE="ARIAL NARROW" SIZE=1&gt; 
      &lt;%= RSCustomerList("CompanyName")%&gt; 
    &lt;/FONT&gt;&lt;/TD&gt;
  &lt;TD BGCOLOR="f7efde" ALIGN=CENTER&gt;
    &lt;FONT STYLE="ARIAL NARROW" SIZE=1&gt; 
      &lt;%= RScustomerList("ContactLastName") &amp; ", " %&gt; 
      &lt;%= RScustomerList("ContactFirstName") %&gt; 
    &lt;/FONT&gt;&lt;/TD&gt;
  &lt;TD BGCOLOR="f7efde" ALIGN=CENTER&gt;
    &lt;FONT STYLE="ARIAL NARROW" SIZE=1&gt;
    &lt;A HREF="mailto:"&gt; 
      &lt;%= RScustomerList("ContactLastName")%&gt; 
    &lt;/A&gt;&lt;/FONT&gt;&lt;/TD&gt;
  &lt;TD BGCOLOR="f7efde" ALIGN=CENTER&gt;
    &lt;FONT STYLE="ARIAL NARROW" SIZE=1&gt; 
      &lt;%= RScustomerList("City")%&gt; 
    &lt;/FONT&gt;&lt;/TD&gt;
  &lt;TD BGCOLOR="f7efde" ALIGN=CENTER&gt;
    &lt;FONT STYLE="ARIAL NARROW" SIZE=1&gt; 
      &lt;%= RScustomerList("StateOrProvince")%&gt; 
    &lt;/FONT&gt;&lt;/TD&gt;
  &lt;/TR&gt; </pre></FONT>

<p>If another user has previously completed this portion of the tutorial, these lines of script will already be in place. Paste the copied script over the existing script.</p>

<p>The <strong>Do...Loop</strong> statement repeats a block of statements while a condition is true. The repeated statements can be script commands 
or HTML text and tags. Thus, each time through the loop, you construct a table row (using HTML) and insert returned data (using 
script commands).</p>
</li>

<li>To complete the loop, use the <strong>MoveNext</strong> method to move the row pointer for the result set down one row. Because this 
statement still falls within the <strong>Do...Loop</strong> statement, it is repeated until the end of the file is reached. Copy and paste the following lines of script underneath the comment with the words &#147;Tutorial Lesson - Next Row&#148;: 
<FONT FACE="COURIER"><pre>&lt;% 
RScustomerList.MoveNext 
Loop 
%&gt;</pre></FONT>
</li>

<li>Save changes to Database.asp as a text file and exit your text editor. Be sure your text editor does not replace the .asp file name extension.
<br><br></li>

<li>To verify that the ASP page you&#146;ve created works (after which you can return to this Tutorial by clicking Back in your browser), point your browser to
 <a href="http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/database.asp">http://<%= Request.ServerVariables("SERVER_NAME")%>/aspsamp/tutorial/lessons/database.asp</a>.</li>
</ol>

<h3><A NAME="onyourown2">On Your Own </A></h3>

<p>To see a more complete example of the Database Access component in action, look at the .asp file <a href="http://<%= Request.ServerVariables("SERVER_NAME")%>/advworks/internal/Customer_listing.asp">Customer_Listing.asp</a> in the Adventure Works 
sample site. Click the <Strong>View ASP Source </Strong> button  to see the script commands that construct the customer list.</p>

<p><Strong>Note</Strong>&#160;&#160;&#160; If  you have not yet visited the Adventure Works sample site, the preceding link will automatically redirect you to the Adventure Works home page (this is a feature of the Adventure Works site). If this happens, use the <Strong> Back </Strong> button on your Web browser to navigate back to the tutorial and follow the link again.     
</p>

<p> Now that you&#146;ve used ActiveX server components, you may want to go on to <a href="atumd3.asp">Module 3: Writing Your Own ActiveX Server Components</a>. </p>

<hr>

<p align=center><a href="/iasdocs/aspdocs/sdklegal.htm"><em>&#169; 1996 Microsoft Corporation. All rights reserved.</em></a></p>
</FONT>
</BODY>
</html>
