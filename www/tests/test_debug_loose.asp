<%@ Language="JavaScript"%>
<%
// Test loose equality
try {
	var r1 = (Math.atan2(-1, 0) === -Math.PI / 2);
	var r2 = (Math.atan2(-1, 0) == -Math.PI / 2);
	Response.Write("r1=" + r1 + " r2=" + r2 + "\n");
} catch (err) {
	Response.Write("ERROR: " + err.description + "\n");
}
%>