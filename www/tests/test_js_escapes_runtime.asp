<%@ Language="JScript" %>
<%
var s = "A\nB";
Response.Write((s.length===3) + "|" + (s.charCodeAt(1)===10) + "\n");
var q1 = 'It\'s';
var q2 = "\"ok\"";
var bs = "\\";
Response.Write(q1 + "|" + q2 + "|" + (bs.length===1) + "\n");
var t = "x\ty";
Response.Write((t.charCodeAt(1)===9) + "\n");
var r = "x\ry";
Response.Write((r.charCodeAt(1)===13) + "\n");
var b = "x\by";
Response.Write((b.charCodeAt(1)===8) + "\n");
var f = "x\fy";
Response.Write((f.charCodeAt(1)===12) + "\n");
var v = "x\vy";
Response.Write((v.charCodeAt(1)===11) + "\n");
%>