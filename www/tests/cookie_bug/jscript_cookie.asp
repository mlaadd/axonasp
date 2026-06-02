<%@ Language="JScript" %>
<%
Response.Write("Method: " + Request.ServerVariables("REQUEST_METHOD") + "\n");
var action = Request.QueryString("action") + "";
if (action == "set") {
    Response.Cookies("test_js_cookie") = "js_value";
    Response.Write("Cookie set");
} else if (action == "get") {
    var val = Request.Cookies("test_js_cookie") + "";
    Response.Write("Cookie retrieved: " + val);
} else {
    Response.Write("No action");
}
%>