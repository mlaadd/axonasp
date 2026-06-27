<%@ Language="JavaScript"%>
<%
try {
	var arrTests = [
		 {expected:true, actual:Math.atan2(1, 0) === Math.PI / 2}
		,{expected:true, actual:Math.atan2(-1, 0) === -Math.PI / 2}
		,{expected:"true", actual:String(true)}
		,{expected:3, actual:(new Array(3)).length}
		,{expected:true, actual:Math.atan2(-1, 0) === -(Math.PI / 2)}
	];
	
	for (var i = 0; i < arrTests.length; i++) {
		var t = arrTests[i];
		var result = (t.expected === t.actual);
		Response.Write("#" + (i+1) + ": expected=" + typeof t.expected + "(" + t.expected + ") actual=" + typeof t.actual + "(" + t.actual + ") result=" + result + "\n");
	}
} catch (err) {
	Response.Write("ERROR: " + err.description + "\n");
}
%>