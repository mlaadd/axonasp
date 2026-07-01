<%@ Language="JScript" %><%
Response.Clear();
Response.Status			= 200;
Response.ContentType	= "text/plain";
Response.CharSet		= "utf-8";
Response.CacheControl	= "max-age=0, no-cache, no-store";


var strDate		= "Tue Jun 30 12:40:53 UTC+0100 2026";	// --\__ same date
var intDate		= 1782819653000;						// --/
var objDateFromString	= new Date(strDate);
var objDateFromInt		= new Date(intDate);
var arrResults	= [];
var arrTests	= [
	 {expected:strDate,							actual:objDateFromString.toString()}
	,{expected:30,								actual:objDateFromString.getDate()}
	,{expected:2,								actual:objDateFromString.getDay()}
	,{expected:2026,							actual:objDateFromString.getFullYear()}
	,{expected:12,								actual:objDateFromString.getHours()}
	,{expected:0,								actual:objDateFromString.getMilliseconds()}
	,{expected:40,								actual:objDateFromString.getMinutes()}
	,{expected:5,								actual:objDateFromString.getMonth()}
	,{expected:53,								actual:objDateFromString.getSeconds()}
	/* Line 10: */
	,{expected:intDate,							actual:objDateFromString.getTime()}
	,{expected:-60,								actual:objDateFromString.getTimezoneOffset()}
	,{expected:30,								actual:objDateFromString.getUTCDate()}
	,{expected:2,								actual:objDateFromString.getUTCDay()}
	,{expected:2026,							actual:objDateFromString.getUTCFullYear()}
	,{expected:11,								actual:objDateFromString.getUTCHours()}
	,{expected:0,								actual:objDateFromString.getUTCMilliseconds()}
	,{expected:40,								actual:objDateFromString.getUTCMinutes()}
	,{expected:5,								actual:objDateFromString.getUTCMonth()}
	,{expected:53,								actual:objDateFromString.getUTCSeconds()}
	/* Test 20: */
	,{expected:2026,							actual:objDateFromString.getYear()}
	,{expected:intDate,							actual:Date.parse(strDate)}
	,{expected:"Tue Jun 30 2026",				actual:objDateFromString.toDateString()}
	,{expected:"Tue, 30 Jun 2026 11:40:53 UTC",	actual:objDateFromString.toGMTString()}
	,{expected:"30 June 2026",					actual:objDateFromString.toLocaleDateString()}
	,{expected:"30 June 2026 12:40:53",			actual:objDateFromString.toLocaleString()}
	,{expected:"12:40:53",						actual:objDateFromString.toLocaleTimeString()}
	,{expected:strDate,							actual:objDateFromString.toString()}
	,{expected:"12:40:53 UTC+0100",				actual:objDateFromString.toTimeString()}
	,{expected:"Tue, 30 Jun 2026 11:40:53 UTC",	actual:objDateFromString.toUTCString()}
	/* Test 30: */
	,{expected:1782777600000,					actual:Date.UTC(2026, 5, 30)}
	,{expected:1782819653000,					actual:Date.UTC(2026, 5, 30, 11, 40, 53, 0)}
	,{expected:intDate,							actual:objDateFromString.valueOf()}
	,{expected:1779795653000,					actual:(function(d){d.setDate(-5);				return +d})(new Date(intDate))}
	,{expected:1341056453000,					actual:(function(d){d.setFullYear("2012");		return +d})(new Date(intDate))}
	,{expected:1782686453000,					actual:(function(d){d.setHours(-25);			return +d})(new Date(intDate))}
	,{expected:1782819653123,					actual:(function(d){d.setMilliseconds(123); 	return +d})(new Date(intDate))}
	,{expected:1782821273000,					actual:(function(d){d.setMinutes(67);			return +d})(new Date(intDate))}
	,{expected:1816947653000,					actual:(function(d){d.setMonth(18);				return +d})(new Date(intDate))}
	,{expected:1782819510000,					actual:(function(d){d.setSeconds(-90);			return +d})(new Date(intDate))}
	/* Test 40: */
	,{expected:intDate,							actual:(function(d){d.setTime(intDate);			return +d})(new Date(intDate))}
	,{expected:1780659653000,					actual:(function(d){d.setUTCDate(5);			return +d})(new Date(intDate))}
	,{expected:-110636347000,					actual:(function(d){d.setUTCFullYear(1966);		return +d})(new Date(intDate))}
	,{expected:1782736853000,					actual:(function(d){d.setUTCHours(-12);			return +d})(new Date(intDate))}
	,{expected:1782819653999,					actual:(function(d){d.setUTCMilliseconds(999);	return +d})(new Date(intDate))}
	,{expected:1782811853000,					actual:(function(d){d.setUTCMinutes(-90);		return +d})(new Date(intDate))}
	,{expected:1753875653000,					actual:(function(d){d.setUTCMonth(-6);			return +d})(new Date(intDate))}
	,{expected:1782819480000,					actual:(function(d){d.setUTCSeconds(-120);		return +d})(new Date(intDate))}
	,{expected:867670853000,					actual:(function(d){d.setYear(97);				return +d})(new Date(intDate))}
];


// Test Loop
var intLoopIndex	= 0;
var intSuccess		= 0;
var intLoopIndexMax	= arrTests.length;

while (intLoopIndex < intLoopIndexMax) {
	var objTest		= arrTests[intLoopIndex];
	var blnResult	= (objTest.expected === objTest.actual);

	if (blnResult) {
		intSuccess++;
	}
	else {
		arrResults.push("#" + (intLoopIndex+1) + ": Expected = " + objTest.expected + "\t\tActual = " + objTest.actual);
	}

	intLoopIndex++;
} // while()


// Output Results
Response.Write("The following tests apply to an IIS server running in England with the Win 11 Pro OS timezone set to UTC+1. AXON ASP has its axonasp.toml set to `default_timezone = \"UTC+1\"`. Method reference are relative to the JScript 5.6 docs\r\n\r\n");
Response.Write("Tests Total: " + intLoopIndexMax + "\r\n");
Response.Write("Tests Passed: " + intSuccess + "\r\n");
Response.Write("Tests Failed: " + (intLoopIndexMax - intSuccess) + "\r\n\r\n");
Response.Write("Failed tests:\r\n");
Response.Write(arrResults.join("\r\n") || "[None; 😁]");
%>