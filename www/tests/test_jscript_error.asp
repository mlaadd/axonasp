<%@ Language="JScript" %><%
Response.Clear();
Response.Status         = 200;
Response.ContentType    = "text/plain";
Response.CharSet        = "utf-8";
Response.CacheControl   = "max-age=0, no-cache, no-store";

try {
    throw new Error(1, "Hello I'm an error");
}
catch (err) {
    // Testing both Microsoft IIS properties and ECMAScript standard properties
    Response.Write("Thrown: #" + err.number + ", " + err.description + " | ES Message: " + err.message);
}
%>