<%@ Language="JavaScript"%>
<%
// Step by step: what works?
var v1 = -Math.PI / 2;
var v2 = Math.atan2(-1, 0);
Response.Write("v1=" + v1 + " v2=" + v2 + "\n");
Response.Write("eq1=" + (v2 === v1) + "\n");

// Inline
var r = Math.atan2(-1, 0) === -Math.PI / 2;
Response.Write("r=" + r + "\n");
%>