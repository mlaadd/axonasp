<%@ Language="JavaScript"%>
<%
// Test 1: Just (new Array(3)).length
var len = (new Array(3)).length;
Response.Write("len=" + len + "\n");

// Test 2: Math.atan2 after Array
var r = Math.atan2(1, 0) === Math.PI / 2;
Response.Write("atan2_1=" + r + "\n");

var r2 = Math.atan2(-1, 0) === -Math.PI / 2;
Response.Write("atan2_2=" + r2 + "\n");
%>