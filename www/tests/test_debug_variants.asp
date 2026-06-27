<%@ Language="JavaScript"%>
<%
// Test various forms of the comparison
var a1 = Math.atan2(-1, 0);
var b1 = -Math.PI / 2;
Response.Write("A: " + (a1 === b1) + "\n");        // true

var a2 = Math.atan2(-1, 0);
Response.Write("B: " + (a2 === -Math.PI / 2) + "\n"); // ?

Response.Write("C: " + (Math.atan2(-1, 0) === (-Math.PI / 2)) + "\n"); // ?

Response.Write("D: " + (Math.atan2(-1, 0) === -Math.PI / 2) + "\n");   // original

Response.Write("E: " + (Math.atan2(-1, 0) === -1.5707963267948966) + "\n"); // ?

var e1 = -Math.PI / 2;
Response.Write("F: " + (Math.atan2(-1, 0) === e1) + "\n"); // ?
%>