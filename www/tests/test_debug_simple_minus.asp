<%@ Language="JavaScript"%>
<%
// Test simpler forms
try {
	var v1 = Math.atan2(1, 0);
	Response.Write("v1=" + v1 + "\n");
	
	var v2 = -Math.PI;
	Response.Write("v2=" + v2 + "\n");
	
	// simplest: atan2 result compared with -PI
	var a = (Math.atan2(1, 0) === Math.PI / 2);
	Response.Write("a=" + a + "\n");  // should be true
	
	// with negation
	var b = (Math.atan2(-1, 0) === -Math.PI / 2);
	Response.Write("b=" + b + "\n");  // should be true

	var c = (Math.atan2(-1, 0) === (-Math.PI / 2));
	Response.Write("c=" + c + "\n");  // with parens

	var d = (Math.atan2(-1, 0) === -(Math.PI / 2));
	Response.Write("d=" + d + "\n");  // negate after division
	
} catch (err) {
	Response.Write("ERROR: " + err.description + "\n");
}
%>