<CENTER>
<BR>
<%  
Set OBJbrowser = Server.CreateObject("MSWC.BrowserType") 
If OBJbrowser.ActiveXcontrols = "True" and Request.ServerVariables("HTTP_UA_CPU")= "x86" Then 
%> 
 
  <OBJECT CODEBASE="/AdvWorks/Controls/nboard.cab#version=5,0,0,5"
		WIDTH=460
		HEIGHT=60	
		DATA="/AdvWorks/Controls/billboard.ods"
		CLASSID="clsid:6059B947-EC52-11CF-B509-00A024488F73">
  </OBJECT>
 
<% 
Else 
  Set Ad = Server.CreateObject("MSWC.Adrotator") 
%> 
<%= Ad.GetAdvertisement("/aspsamp/tutorial/lessons/adrot.txt") %>
<% End If %>
</CENTER>
