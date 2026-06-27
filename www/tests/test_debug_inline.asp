<%@ Language="JavaScript"%>
<%
// Exact expression from test #235
var r = Math.atan2(-1, 0) === -Math.PI / 2;
Response.Write("r=" + r + "\n");

// Break it down
var r2a = Math.atan2(-1, 0);
var r2b = -Math.PI / 2;
Response.Write("r2=" + (r2a === r2b) + "\n");

// With parens for clarity
var r3 = Math.atan2(-1, 0) === ((-Math.PI) / 2);
Response.Write("r3=" + r3 + "\n");

// Just the values
Response.Write("atan2=" + Math.atan2(-1, 0) + "\n");
Response.Write("negPiDiv2=" + (-Math.PI / 2) + "\n");
%>