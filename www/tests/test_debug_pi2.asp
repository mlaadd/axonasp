<%@ Language="JavaScript"%>
<%
// Test #234 expression: Math.atan2(1, 0) === Math.PI / 2
Response.Write("T234: " + (Math.atan2(1, 0) === Math.PI / 2) + "\n");

// Test #235 expression: Math.atan2(-1, 0) === -Math.PI / 2
Response.Write("T235: " + (Math.atan2(-1, 0) === -Math.PI / 2) + "\n");

// Combo
Response.Write("COMBO: " + (Math.atan2(1, 0) === Math.PI / 2) + "|" + (Math.atan2(-1, 0) === -Math.PI / 2) + "\n");
%>