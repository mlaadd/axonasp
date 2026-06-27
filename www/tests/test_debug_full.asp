<%@ Language="JavaScript"%>
<%
var arrResults = [];
var arrTests = [
	 {expected:3,				actual:(new Array(3)).length}
	,{expected:true,			actual:Math.atan2(1, 0) === Math.PI / 2}
	,{expected:true,			actual:Math.atan2(-1, 0) === -Math.PI / 2}
];

var intLoopIndex = 0;
var intSuccess = 0;
var intLoopIndexMax = arrTests.length;

while (intLoopIndex < intLoopIndexMax) {
	var objTest = arrTests[intLoopIndex];
	var blnResult = (objTest.expected === objTest.actual);
	if (blnResult) {
		intSuccess++;
	} else {
		arrResults.push("#" + (intLoopIndex+1) + ": Expected = " + objTest.expected + "\t\tActual = " + objTest.actual);
	}
	intLoopIndex++;
}

Response.Write("Passed: " + intSuccess + "/" + intLoopIndexMax + "\r\n");
if (arrResults.length > 0) {
	Response.Write("Failed:\r\n" + arrResults.join("\r\n"));
} else {
	Response.Write("All passed!");
}
%>