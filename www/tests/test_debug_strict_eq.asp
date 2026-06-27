<%@ Language="JavaScript"%>
<%
try {
	var a = Math.atan2(-1, 0);
	var b = -Math.PI / 2;
	
	// Compare variable versions
	Response.Write("var_eq=" + (a === b) + "\n");
	Response.Write("a_type=" + typeof a + " a_val=" + a + "\n");
	Response.Write("b_type=" + typeof b + " b_val=" + b + "\n");
	
	// Now inline
	var r = Math.atan2(-1, 0) === -Math.PI / 2;
	Response.Write("inline=" + r + "\n");
	
	// Test with explicit Number()
	var r2 = Number(Math.atan2(-1, 0)) === Number(-Math.PI / 2);
	Response.Write("explicit_number=" + r2 + "\n");
	
	// Test with explicit String()
	var r3 = String(Math.atan2(-1, 0)) === String(-Math.PI / 2);
	Response.Write("explicit_string=" + r3 + "\n");
	
} catch (err) {
	Response.Write("ERROR: #" + err.number + " " + err.description + "\n");
}
%>