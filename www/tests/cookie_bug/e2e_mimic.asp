<%@ Language="JScript" %>
<%
// Mimic g3pix setting language
var queryLang = Request.QueryString("lang") + "";
var currentLang = "en"; // default

if (queryLang != "undefined" && queryLang != "") {
    currentLang = queryLang;
    // Set cookie to remember language
    Response.Cookies("g3pix_lang") = currentLang;
    Response.Cookies("g3pix_lang").Expires = "Wed, 02 Jun 2027 00:59:54 GMT";
    Response.Cookies("g3pix_lang").Path = "/";
} else {
    // Read from cookie
    var cookieLang = Request.Cookies("g3pix_lang") + "";
    if (cookieLang != "undefined" && cookieLang != "") {
        currentLang = cookieLang;
    } else {
        // Fallback default and set cookie
        Response.Cookies("g3pix_lang") = currentLang;
        Response.Cookies("g3pix_lang").Expires = "Wed, 02 Jun 2027 00:59:54 GMT";
        Response.Cookies("g3pix_lang").Path = "/";
    }
}

Response.Write("Current Language: " + currentLang);
%>