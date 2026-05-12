<%@ Language="JScript" %>
<%
	Response.Buffer = false;
	
	try {
		Response.Write("Top-level await test:<br>");
		var p = Promise.resolve("top-level result");
		var result = await p;
		Response.Write("Result: " + result + "<br>");
	} catch (e) {
		Response.Write("ERROR: " + e.message + "<br>");
	}
%>