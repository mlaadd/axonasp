<%@ Language="JavaScript"%>
<%
try {
	// Compare with literal negation
	var n1 = Math.atan2(-1, 0) === -3.141592653589793 / 2;
	Response.Write("n1=" + n1 + "\n");  // should be true
	
	// Compare with variable negation
	var pi = Math.PI;
	var n2 = Math.atan2(-1, 0) === -pi / 2;
	Response.Write("n2=" + n2 + "\n");  // should be true
	
	// Simple negation of a literal
	var n3 = Math.atan2(-1, 0) === -1.5707963267948966;
	Response.Write("n3=" + n3 + "\n");  // should be true
	
	// negation of Math.PI alone (no division)
	var n4 = Math.atan2(-1, 0) === -Math.PI / 2;
	Response.Write("n4=" + n4 + "\n");  // false bug
	
	// Test if the issue is specifically Math.PI or any member expression
	var x = Math.PI;
	var n5 = Math.atan2(-1, 0) === -x / 2;
	Response.Write("n5=" + n5 + "\n");  // should be true
	
} catch (err) {
	Response.Write("ERROR: " + err.description + "\n");
}
%>