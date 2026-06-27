<%@ Language="JavaScript"%>
<%
Response.Clear();
try {
	// Replicate the tests around index 162
	var arrTests = [
		// ... earlier tests up to index 160
		 {expected:true, actual:isNaN(parseFloat("px"))}      // #160
		,{expected:"null", actual:String(null)}                  // #161
		,{expected:"undefined", actual:String(void 0)}           // #162
		,{expected:"true", actual:String(true)}                  // #163
		,{expected:"false", actual:String(false)}                // #164
		,{expected:"NaN", actual:String(NaN)}                    // #165
		,{expected:"Infinity", actual:String(Infinity)}          // #166
	];

	var intLoopIndex = 0;
	var intSuccess = 0;
	var intLoopIndexMax = arrTests.length;
	var arrResults = [];

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
	
	Response.Write("Passed: " + intSuccess + "/" + intLoopIndexMax + "\n");
	if (arrResults.length > 0) {
		Response.Write("Failed:\n" + arrResults.join("\n"));
	}
} catch (err) {
	Response.Write("ERROR: #" + err.number + " " + err.description + "\n");
}
%>