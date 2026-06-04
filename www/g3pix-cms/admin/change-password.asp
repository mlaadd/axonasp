<%@ Language="JScript" %>
<!--#include file="../includes/config.asp" -->
<!--#include file="../includes/helpers.asp" -->
<!--#include file="../includes/i18n.asp" -->
<!--#include file="../includes/db.asp" -->
<!--#include file="../includes/auth.asp" -->
<!--#include file="../models/user_model.asp" -->
<!--#include file="../views/layout.asp" -->
<%
var lang = GetBaseLanguage();
EnsureSchemaAndSeed();
EnsureAdminAuthenticated();

var flash = "";
var flashClass = "success";
var currentUser = FindUserByUsername(CurrentUserName());

if (currentUser == null) {
    RedirectTo(AppUrl("logout.asp"));
}

if (IsPostRequest()) {
    var csrf = TrimString(Request.Form("csrf_token"));
    if (!ValidateCsrf(csrf)) {
        flash = T(lang, "csrf_error");
        flashClass = "error";
    } else {
        var currentPassword = String(Request.Form("current_password"));
        var newPassword = String(Request.Form("new_password"));
        var confirmPassword = String(Request.Form("confirm_password"));

        if (currentPassword == "" || newPassword == "" || confirmPassword == "") {
            flash = T(lang, "required_fields");
            flashClass = "error";
        } else if (newPassword != confirmPassword) {
            flash = T(lang, "passwords_mismatch");
            flashClass = "error";
        } else {
            var verifier = Server.CreateObject("G3CRYPTO");
            var currentValid = verifier.VerifyPassword(currentPassword, currentUser.passwordHash);
            verifier = null;

            if (!currentValid) {
                flash = T(lang, "invalid_login");
                flashClass = "error";
            } else {
                UpdateCurrentUserPassword(currentUser.id, newPassword);
                Session("g3pix_force_password_change") = 0;
                flash = T(lang, "password_updated");
                flashClass = "success";
            }
        }
    }
}

RenderAdminHeader(lang, T(lang, "change_password") + " | " + T(lang, "site_name"), "change-password");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "change_password"))%></h1>
    <p><%=HtmlEncode(T(lang, "admin_dashboard_intro"))%></p>
    <%
if (flash != "") {
%>
    <div class="g3pix-alert <%=flashClass%>"><%=HtmlEncode(flash)%></div>
    <%
}
%>
    <form method="post" action="<%=HtmlEncode(AppUrl("admin/change-password.asp"))%>">
        <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">
        <div class="g3pix-form-grid">
            <div>
                <label><%=HtmlEncode(T(lang, "current_password"))%></label>
                <input type="password" name="current_password" required>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "new_password"))%></label>
                <input type="password" name="new_password" required>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "confirm_password"))%></label>
                <input type="password" name="confirm_password" required>
            </div>
        </div>
        <div class="actions-row">
            <button class="btn btn-primary" type="submit"><%=HtmlEncode(T(lang, "save"))%></button>
        </div>
    </form>
</section>
<%
RenderAdminFooter();
%>