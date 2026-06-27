<%@ Language="JavaScript"%>
<%
try {
	var arrTests = [
		 {expected:3, actual:(new Array(3)).length}
		,{expected:"true", actual:String(true)}
		,{expected:"false", actual:String(false)}
	];
	
	for (var i = 0; i < arrTests.length; i++) {
		var t = arrTests[i];
		var result = (t.expected === t.actual);
		Response.Write("#" + (i+1) + ": expected=" + t.expected + " actual=" + t.actual + " result=" + result + "\n");
	}
} catch (err) {
	Response.Write("ERROR: " + err.description + "\n");
}
%>