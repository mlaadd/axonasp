<%@ Language="JavaScript"%>
<%
try {
	var r = Math.atan2(-1, 0) === -Math.PI / 2;
	Response.Write("SUCCESS: r=" + r + "\n");
} catch (err) {
	Response.Write("ERROR: #" + err.number + " " + err.description + "\n");
}
%>