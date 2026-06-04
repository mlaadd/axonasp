<%@ Language="JScript" %>
<%
function HandleLoginRequest(lang) {
    var result = {
        ok: false,
        message: ""
    };

    if (!IsPostRequest()) {
        return result;
    }

    var csrfToken = TrimString(Request.Form("csrf_token"));
    if (!ValidateCsrf(csrfToken)) {
        result.message = T(lang, "csrf_error");
        return result;
    }

    var username = TrimString(Request.Form("username"));
    var password = String(Request.Form("password"));

    if (username == "" || password == "") {
        result.message = T(lang, "required_fields");
        return result;
    }

    var user = VerifyUserCredentials(username, password);
    if (user == null) {
        result.message = T(lang, "invalid_login");
        return result;
    }

    LoginUserWithFlags(user.id, user.username, user.role, user.mustChangePassword);
    result.ok = true;
    return result;
}
%>