<%@ Language="JScript" %>
<%
	Response.Buffer = false;
	
	try {
		Response.Write("Testing Promise.allSettled:<br>");
		var p1 = Promise.resolve(42);
		var p2 = Promise.reject("error");
		Promise.allSettled([p1, p2]).then(function(results) {
			Response.Write("p1 status: " + results[0].status + ", value: " + results[0].value + "<br>");
			Response.Write("p2 status: " + results[1].status + ", reason: " + results[1].reason + "<br>");
		});

		Response.Write("<br>Testing Promise.any (resolve):<br>");
		var p3 = Promise.reject("error 1");
		var p4 = Promise.resolve("success");
		var p5 = Promise.reject("error 2");
		Promise.any([p3, p4, p5]).then(function(val) {
			Response.Write("Resolved with: " + val + "<br>");
		}).catch(function(e) {
			Response.Write("Should not reach here: " + e.message + "<br>");
		});

		Response.Write("<br>Testing Promise.any (reject):<br>");
		var p6 = Promise.reject("error A");
		var p7 = Promise.reject("error B");
		Promise.any([p6, p7]).then(function(val) {
			Response.Write("Should not reach here<br>");
		}).catch(function(e) {
			Response.Write("Rejected with: " + e.message + "<br>");
		});

		Response.Write("<br>Testing Promise.withResolvers:<br>");
		var parts = Promise.withResolvers();
		parts.promise.then(function(val) {
			Response.Write("withResolvers resolved: " + val + "<br>");
		});
		parts.resolve("it works");

	} catch (e) {
		Response.Write("ERROR: " + e.message + "<br>");
	}
%>