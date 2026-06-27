<%@ Language="JavaScript"%>
<%
// Test various forms of -Math.PI
var a = -Math.PI;
Response.Write("a=" + a + "\n");

var b = -(Math.PI);
Response.Write("b=" + b + "\n");

var c = 0 - Math.PI;
Response.Write("c=" + c + "\n");

var d = -Math.PI / 2;
Response.Write("d=" + d + "\n");

var e = -(Math.PI) / 2;
Response.Write("e=" + e + "\n");

var f = (0 - Math.PI) / 2;
Response.Write("f=" + f + "\n");
%>