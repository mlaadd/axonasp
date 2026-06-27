<%@ Language="JavaScript"%>
<%
// Test workaround for the compiler bug
try {
	var a = Math.atan2(1, 0) === Math.PI / 2;
	Response.Write("a=" + a + "\n");
	
	var b = Math.atan2(-1, 0) === -(Math.PI / 2);
	Response.Write("b=" + b + "\n");
	
	var c = Math.atan2(-1, 0) === -Math.PI / 2;
	Response.Write("c=" + c + "\n");
	
	// Test #163
	var d = (3 === (new Array(3)).length);
	Response.Write("d=" + d + "\n");
	
} catch (err) {
	Response.Write("ERROR: " + err.description + "\n");
}
%>