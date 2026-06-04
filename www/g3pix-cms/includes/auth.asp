<%@ Language="JScript" %>
<%
function IsAuthenticated() {
    var userId = ToInt(Session("g3pix_user_id"), 0);
    if (userId <= 0) {
        return false;
    }
    return true;
}

function CurrentUserName() {
    var userName = TrimString(Session("g3pix_user_name"));
    if (userName == "") {
        return "";
    }
    return String(userName);
}

function CurrentUserId() {
    return ToInt(Session("g3pix_user_id"), 0);
}

function LoginUser(userId, userName) {
    Session("g3pix_user_id") = userId;
    Session("g3pix_user_name") = userName;
}

function LoginUserWithFlags(userId, userName, role, mustChangePassword) {
    Session("g3pix_user_id") = userId;
    Session("g3pix_user_name") = userName;
    Session("g3pix_user_role") = role;
    Session("g3pix_force_password_change") = mustChangePassword;
}

function LogoutUser() {
    Session("g3pix_user_id") = "";
    Session("g3pix_user_name") = "";
    Session("g3pix_user_role") = "";
    Session("g3pix_force_password_change") = "";
    Session("g3pix_csrf") = "";
}

function EnsureAdminAuthenticated() {
    if (!IsAuthenticated()) {
        RedirectTo(AppUrl("login.asp") + "?next=" + Server.URLEncode(Request.ServerVariables("URL")));
    }

    var currentUrl = String(Request.ServerVariables("URL"));
    var passwordChangeRequired = ToInt(Session("g3pix_force_password_change"), 0);
    var changePasswordPath = AppUrl("admin/change-password.asp");
    if (passwordChangeRequired == 1 && currentUrl.toLowerCase().indexOf(changePasswordPath.toLowerCase()) < 0) {
        RedirectTo(changePasswordPath);
    }
}

function GetCsrfToken() {
    var token = Session("g3pix_csrf");
    if (token == null || token == "") {
        var crypto = Server.CreateObject("G3CRYPTO");
        token = crypto.RandomHex(16);
        Session("g3pix_csrf") = token;
        crypto = null;
    }
    return String(token);
}

function ValidateCsrf(token) {
    if (token == null || token == "") {
        return false;
    }
    var expected = Session("g3pix_csrf");
    if (expected == null || expected == "") {
        return false;
    }
    return String(token) == String(expected);
}

function CurrentUserRole() {
    var role = TrimString(Session("g3pix_user_role"));
    if (role == "") {
        return "";
    }
    return String(role);
}
%>