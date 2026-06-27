<%@ Language="JavaScript"%>
<%
var v = Math.atan2(-1, 0);
var pi2 = -Math.PI / 2;
var d = v - pi2;
Response.Write("atan2(-1,0)=" + v + "\n-PI/2=" + pi2 + "\ndiff=" + d + "\neq=" + (v === pi2) + "\ntype_v=" + typeof v + "\ntype_pi2=" + typeof pi2);
%>