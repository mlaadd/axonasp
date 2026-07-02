<%@Language="JScript" CodePage="65001" EnableSessionState=false%>
<%
try {
	Response.Clear();
	Response.Status			= 200;
	Response.ContentType	= "text/plain";
	Response.CharSet		= "utf-8";
	Response.CacheControl	= "max-age=0, no-cache, no-store";

	// Test with: ./?category=books&tag=scifi&tag=thriller
	var objRQ = Request.QueryString;
	if (objRQ.Count == 0) {
		Response.Redirect("test_jscript_collection.asp?category=books&tag=scifi&tag=thriller");
		Response.End();
	}
	var arrResults	= [];
	var arrTests	= [
		 {expected:"category=books&tag=scifi&tag=thriller",	actual:String(objRQ)}
		,{expected:2,					actual:objRQ.Count}
		,{expected:2,					actual:objRQ.Count()}
		,{expected:1,					actual:objRQ("category").Count}
		,{expected:1,					actual:objRQ("category").Count()}
		,{expected:2,					actual:objRQ("tag").Count}
		,{expected:2,					actual:objRQ("tag").Count()}
		,{expected:"scifi, thriller",	actual:objRQ("tag").Item}
		,{expected:"scifi, thriller",	actual:objRQ("tag").Item()}
		,{expected:"scifi",				actual:objRQ("tag").Item(1)}
		,{expected:"thriller",			actual:objRQ("tag").Item(2)}
		,{expected:"category",			actual:objRQ.Key(1)}
		,{expected:"tag",				actual:objRQ.Key(2)}
		,{expected:0,					actual:objRQ("fish").Count}
		,{expected:"undefined",			actual:String(objRQ("fish"))}
		,{expected:"",					actual:objRQ.Key("unknown key")}
		,{expected:"object",			actual:typeof objRQ}
		,{expected:"object",			actual:typeof objRQ("tag")}
		,{expected:"number",			actual:typeof objRQ.Count}
		,{expected:"number",			actual:typeof objRQ("tag").Count}
		,{expected:"number",			actual:typeof objRQ("tag").Count()}
		,{expected:"#-2147467259 - 007~ASP 0105~Index out of range~An array index is out of range.",	actual:(function(objRQ) {
			try{
				objRQ("tag").Item(0);
			}
			catch(err) {
				return "#" + err.number + " - " + err.description;
			}
		})(objRQ)}
		,{expected:"#-2147467259 - 007~ASP 0105~Index out of range~An array index is out of range.",	actual:(function(objRQ) {
			try{
				objRQ("fish").Item(1);
			}
			catch(err) {
				return "#" + err.number + " - " + err.description;
			}
		})(objRQ)}
		,{expected:"category = books, tag = scifi, thriller",	actual:(function(objRQ) {	// Enumerator test
			var objEnum		= new Enumerator(objRQ);
			var arrResult	= [];

			while (!objEnum.atEnd()) {
				var strKeyName	= objEnum.item();
				var varValue	= objRQ.item(strKeyName);

				arrResult.push(strKeyName + " = " + varValue);
				objEnum.moveNext();
			}

			return arrResult.join(", ");
		})(objRQ)}
		,{expected:"#-2146827850 - Object doesn't support this property or method",				actual:(function(objRQ) {
			try{
				objRQ("tag").Key();
			}
			catch(err) {
				return "#" + err.number + " - " + err.description;
			}
		})(objRQ)}
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
	Response.Write("Tests Total: " + intLoopIndexMax + "\r\n");
	Response.Write("Tests Passed: " + intSuccess + "\r\n");
	Response.Write("Tests Failed: " + (intLoopIndexMax - intSuccess) + "\r\n\r\n");
	Response.Write("Failed tests:\r\n");
	Response.Write(arrResults.join("\r\n") || "[None; 😁]");
}
catch (err) {
	Response.Write("Error: #" + err.number + "\r\n" + err.description);
}
%>