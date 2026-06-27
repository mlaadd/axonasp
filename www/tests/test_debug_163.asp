<%@ Language="JavaScript"%>
<%
var r1 = (3 === (new Array(3)).length);
var r2 = (Math.atan2(1, 0) === Math.PI / 2);
var r3 = (Math.atan2(-1, 0) === -Math.PI / 2);
Response.Write("test163=" + r1 + "\ntest234=" + r2 + "\ntest235=" + r3);
%>