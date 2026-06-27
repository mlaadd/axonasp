<%@ Language="JavaScript"%>
<%
var pi = Math.PI;
var negPi = -Math.PI;
var negPiDiv2 = -Math.PI / 2;
var expected = -Math.PI / 2;
var atan2 = Math.atan2(-1, 0);
Response.Write("PI=" + pi + "\n");
Response.Write("negPi=" + negPi + "\n");
Response.Write("negPiDiv2=" + negPiDiv2 + "\n");
Response.Write("expected=" + expected + "\n");
Response.Write("atan2=" + atan2 + "\n");
Response.Write("type_atan2=" + typeof atan2 + "\n");
Response.Write("type_expected=" + typeof expected + "\n");
Response.Write("atan2===expected=" + (atan2 === expected) + "\n");
Response.Write("atan2==expected=" + (atan2 == expected) + "\n");
Response.Write("diff=" + (atan2 - expected) + "\n");
Response.Write("abs(diff)<1e-15=" + (Math.abs(atan2 - expected) < 1e-15) + "\n");
%>