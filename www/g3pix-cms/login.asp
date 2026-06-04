<%@ Language="JScript" %>
<!--#include file="includes/config.asp" -->
<!--#include file="includes/helpers.asp" -->
<!--#include file="includes/i18n.asp" -->
<!--#include file="includes/db.asp" -->
<!--#include file="includes/auth.asp" -->
<!--#include file="models/user_model.asp" -->
<!--#include file="models/menu_model.asp" -->
<!--#include file="controllers/auth_controller.asp" -->
<!--#include file="views/layout.asp" -->
<%
var lang = GetBaseLanguage();
EnsureSchemaAndSeed();

if (IsAuthenticated()) {
    RedirectTo(AppUrl("admin/default.asp"));
}

var loginResult = HandleLoginRequest(lang);
if (loginResult.ok) {
    var nextUrl = TrimString(Request.QueryString("next"));
    if (nextUrl == "") {
        nextUrl = AppUrl("admin/default.asp");
    }
    if (!IsAppPath(nextUrl)) {
        nextUrl = AppUrl("admin/default.asp");
    }
    if (ToInt(Session("g3pix_force_password_change"), 0) == 1) {
        nextUrl = AppUrl("admin/change-password.asp");
    }
    RedirectTo(nextUrl);
}

var menuItems = ListPublicMenu(lang);
RenderPublicHeader(lang, T(lang, "login") + " | " + T(lang, "site_name"), menuItems, "");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "sign_in"))%></h1>
    <p><%=HtmlEncode(T(lang, "admin_dashboard_intro"))%></p>
    <%
if (TrimString(loginResult.message) != "") {
%>
    <div class="g3pix-alert error"><%=HtmlEncode(loginResult.message)%></div>
    <%
}
%>
    <form method="post" action="<%=HtmlEncode(AppUrl("login.asp"))%>" autocomplete="off">
        <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">
        <div class="g3pix-form-grid">
            <div>
                <label for="username"><%=HtmlEncode(T(lang, "username"))%></label>
                <input type="text" id="username" name="username" maxlength="80" required>
            </div>
            <div>
                <label for="password"><%=HtmlEncode(T(lang, "password"))%></label>
                <input type="password" id="password" name="password" maxlength="128" required>
            </div>
        </div>
        <div class="actions-row">
            <button class="btn btn-primary" type="submit"><%=HtmlEncode(T(lang, "sign_in"))%></button>
        </div>
    </form>
</section>
<%
RenderPublicFooter(lang);
%>