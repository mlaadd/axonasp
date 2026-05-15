<%@ Language="JScript" %>
<%
/*
 * AxonASP JScript Proxy & Reflect Error Handling Test
 */

Response.Write("<h2>JScript Proxy & Reflect Error Handling Tests</h2>");

try {
    new Proxy(1, {});
    Response.Write("FAIL: Proxy target not object<br>");
} catch(e) {
    Response.Write("PASS: Proxy target not object: " + e.message + "<br>");
}

try {
    Reflect.get(1, "a");
    Response.Write("FAIL: Reflect.get non-object<br>");
} catch(e) {
    Response.Write("PASS: Reflect.get non-object: " + e.message + "<br>");
}

var r = Proxy.revocable({}, {});
r.revoke();
try {
    r.proxy.a;
    Response.Write("FAIL: Proxy revoked get<br>");
} catch(e) {
    Response.Write("PASS: Proxy revoked get: " + e.message + "<br>");
}

Response.Write("<br><strong>Tests Completed.</strong>");
%>
