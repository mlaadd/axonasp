<%@ Language="JScript" %>
<!--#include file="../includes/config.asp" -->
<!--#include file="../includes/helpers.asp" -->
<!--#include file="../includes/i18n.asp" -->
<!--#include file="../includes/db.asp" -->
<!--#include file="../includes/auth.asp" -->
<!--#include file="../controllers/admin_controller.asp" -->
<!--#include file="../views/layout.asp" -->
<%
var lang = GetBaseLanguage();
EnsureSchemaAndSeed();
EnsureAdminAuthenticated();

var stats = GetDashboardStats();
RenderAdminHeader(lang, T(lang, "dashboard") + " | " + T(lang, "site_name"), "dashboard");
%>
<section class="g3pix-content">
    <h1><%=HtmlEncode(T(lang, "dashboard"))%></h1>
    <p><%=HtmlEncode(T(lang, "admin_dashboard_intro"))%></p>

    <div class="g3pix-admin-grid">
        <div class="g3pix-metric">
            <span><%=HtmlEncode(T(lang, "page_management"))%></span>
            <strong><%=stats.pages%></strong>
        </div>
        <div class="g3pix-metric">
            <span><%=HtmlEncode(T(lang, "menu_management"))%></span>
            <strong><%=stats.menus%></strong>
        </div>
        <div class="g3pix-metric">
            <span><%=HtmlEncode(T(lang, "image_upload"))%></span>
            <strong><%=stats.media%></strong>
        </div>
    </div>

    <div class="actions-row">
        <a class="btn btn-primary"
            href="<%=HtmlEncode(AppUrl("admin/pages.asp"))%>"><%=HtmlEncode(T(lang, "page_management"))%></a>
        <a class="btn btn-secondary"
            href="<%=HtmlEncode(AppUrl("admin/components.asp"))%>"><%=HtmlEncode(T(lang, "component_management"))%></a>
        <a class="btn btn-secondary"
            href="<%=HtmlEncode(AppUrl("admin/menu.asp"))%>"><%=HtmlEncode(T(lang, "menu_management"))%></a>
        <a class="btn btn-secondary"
            href="<%=HtmlEncode(AppUrl("admin/upload.asp"))%>"><%=HtmlEncode(T(lang, "image_upload"))%></a>
        <a class="btn btn-secondary"
            href="<%=HtmlEncode(AppUrl("admin/css-editor.asp"))%>"><%=HtmlEncode(T(lang, "css_editor"))%></a>
        <a class="btn btn-secondary"
            href="<%=HtmlEncode(AppUrl("admin/js-snippets.asp"))%>"><%=HtmlEncode(T(lang, "js_snippets"))%></a>
        <a class="btn btn-secondary"
            href="<%=HtmlEncode(AppUrl("admin/site-settings.asp"))%>"><%=HtmlEncode(T(lang, "site_settings"))%></a>
    </div>
</section>
<%
RenderAdminFooter();
%>