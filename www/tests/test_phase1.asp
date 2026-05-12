<%@ Language="JScript" %>
<%
	Response.Buffer = false;
	
	try {
		Response.Write("Testing Array Ergonomics:<br>");
		var arr = [1, 2, 3, 4, 5];
		Response.Write("at(-1): " + arr.at(-1) + "<br>");
		Response.Write("findLast(x=>x%2==0): " + arr.findLast(function(x) { return x % 2 == 0; }) + "<br>");
		Response.Write("toReversed(): " + arr.toReversed() + "<br>");
		Response.Write("toSorted((a,b)=>b-a): " + arr.toSorted(function(a,b) { return b-a; }) + "<br>");
		Response.Write("with(0, 10): " + arr.with(0, 10) + "<br>");
		Response.Write("toSpliced(1,2): " + arr.toSpliced(1,2) + "<br>");
		
		var nested = [1, [2, [3]]];
		Response.Write("flat(2): " + nested.flat(2) + "<br>");
		Response.Write("flatMap(x=>[x,x]): " + arr.flatMap(function(x) { return [x, x]; }) + "<br>");

		Response.Write("<br>Testing Object Ergonomics:<br>");
		var obj = { a: 1 };
		Response.Write("hasOwn(a): " + Object.hasOwn(obj, "a") + "<br>");
		Response.Write("hasOwn(b): " + Object.hasOwn(obj, "b") + "<br>");
		var entries = [["foo", "bar"], ["baz", 42]];
		var fromEntries = Object.fromEntries(entries);
		Response.Write("fromEntries.foo: " + fromEntries.foo + "<br>");
		Response.Write("fromEntries.baz: " + fromEntries.baz + "<br>");

		Response.Write("<br>Testing Uint8Array Ergonomics:<br>");
		var u8 = Uint8Array.fromHex("deadbeef");
		Response.Write("fromHex: " + u8[0] + ", " + u8[1] + ", " + u8[2] + ", " + u8[3] + "<br>");
		Response.Write("toHex: " + u8.toHex() + "<br>");
		
		var b64 = Uint8Array.fromBase64("3q2+7w==");
		Response.Write("fromBase64: " + b64.toHex() + "<br>");
		Response.Write("toBase64: " + b64.toBase64() + "<br>");

	} catch (e) {
		Response.Write("ERROR: " + e.message + "<br>");
	}
%>