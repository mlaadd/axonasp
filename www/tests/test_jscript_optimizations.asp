<%@ Language="JScript" %>
<%
	Response.Buffer = false;
	Response.Write("Phase 1: Math Integrations<br>");
	Response.Write(Math.sin(0) + "<br>");
	Response.Write(Math.cos(0) + "<br>");
	Response.Write(Math.floor(1.5) + "<br>");
	Response.Write(Math.min(10, 20) + "<br>");
	Response.Write(Math.max(10, 20) + "<br>");

	Response.Write("Phase 2: Bitwise Fast Paths<br>");
	var x = 10;
	Response.Write(Math.floor(x / 2) + "<br>");
	Response.Write((x / 2) | 0);
	Response.Write("<br>");

	Response.Write("Phase 2: Integer Math Fast Paths<br>");
	let i = 0 | 0;
	let j = i + 1;
	let k = j - 1;
	Response.Write(k + "<br>");
%>