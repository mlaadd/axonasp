<%@ Language="JScript" %>
<!--#include file="../includes/config.asp" -->
<!--#include file="../includes/helpers.asp" -->
<!--#include file="../includes/i18n.asp" -->
<!--#include file="../includes/db.asp" -->
<!--#include file="../includes/auth.asp" -->
<!--#include file="../views/layout.asp" -->
<%
var lang = GetBaseLanguage();
EnsureSchemaAndSeed();
EnsureAdminAuthenticated();

var flash = "";
var flashClass = "success";

if (IsPostRequest()) {
    var csrf = TrimString(Request.Form("csrf_token"));
    if (!ValidateCsrf(csrf)) {
        flash = T(lang, "csrf_error");
        flashClass = "error";
    } else {
        var customCss = String(Request.Form("custom_css"));
        SaveSettingValue("custom_css", customCss);
        flash = T(lang, "saved_ok");
        flashClass = "success";
    }
}

var customCssText = GetCustomCssText();
RenderAdminHeader(lang, T(lang, "css_editor") + " | " + T(lang, "site_name"), "css-editor");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "css_editor"))%></h1>
    <p><%=HtmlEncode(T(lang, "admin_dashboard_intro"))%></p>
    <%
if (flash != "") {
%>
    <div class="g3pix-alert <%=flashClass%>"><%=HtmlEncode(flash)%></div>
    <%
}
%>
    <form method="post" action="<%=HtmlEncode(AppUrl("admin/css-editor.asp"))%>">
        <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">
        <div class="g3pix-form-grid">
            <div class="full">
                <label><%=HtmlEncode(T(lang, "custom_css"))%></label>
                <textarea name="custom_css" rows="20"><%=HtmlEncode(customCssText)%></textarea>
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