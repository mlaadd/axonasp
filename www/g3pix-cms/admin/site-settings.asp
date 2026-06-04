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
        var siteTitle = TrimString(Request.Form("site_title"));
        var siteLogoUrl = TrimString(Request.Form("site_logo_url"));
        var footerText = TrimString(Request.Form("footer_text"));
        var defaultLocale = NormalizeLanguageCode(Request.Form("default_locale"), "en");
        var showSearch = ToInt(Request.Form("show_search"), 1);
        var showHomeMenu = ToInt(Request.Form("show_home_menu"), 1);
        var showLoginMenu = ToInt(Request.Form("show_login_menu"), 1);
        var showAdminMenu = ToInt(Request.Form("show_admin_menu"), 1);
        var showSitemapMenu = ToInt(Request.Form("show_sitemap_menu"), 1);

        if (siteTitle == "") {
            siteTitle = G3PIX_APP_NAME;
        }
        if (siteLogoUrl == "") {
            siteLogoUrl = "/logo_square.svg";
        }
        if (footerText == "") {
            footerText = "G3Pix CMS on AxonASP";
        }
        if (showSearch != 0) {
            showSearch = 1;
        }
        if (showHomeMenu != 0) {
            showHomeMenu = 1;
        }
        if (showLoginMenu != 0) {
            showLoginMenu = 1;
        }
        if (showAdminMenu != 0) {
            showAdminMenu = 1;
        }
        if (showSitemapMenu != 0) {
            showSitemapMenu = 1;
        }

        SaveSettingValue("site_title", siteTitle);
        SaveSettingValue("site_logo_url", siteLogoUrl);
        SaveSettingValue("footer_text", footerText);
        SaveSettingValue("default_locale", defaultLocale);
        SaveSettingValue("show_search", String(showSearch));
        SaveSettingValue("show_home_menu", String(showHomeMenu));
        SaveSettingValue("show_login_menu", String(showLoginMenu));
        SaveSettingValue("show_admin_menu", String(showAdminMenu));
        SaveSettingValue("show_sitemap_menu", String(showSitemapMenu));

        flash = T(lang, "saved_ok");
        flashClass = "success";
    }
}

var formSiteTitle = GetSiteTitle();
var formSiteLogoUrl = GetSettingValue("site_logo_url", "/logo_square.svg");
var formFooterText = GetSettingValue("footer_text", T(lang, "powered_footer"));
var formDefaultLocale = NormalizeLanguageCode(GetSettingValue("default_locale", "en"), "en");
var formShowSearch = ToInt(GetSettingValue("show_search", "1"), 1);

RenderAdminHeader(lang, T(lang, "site_settings") + " | " + T(lang, "site_name"), "site-settings");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "site_settings"))%></h1>
    <p><%=HtmlEncode(T(lang, "admin_dashboard_intro"))%></p>
    <%
if (flash != "") {
%>
    <div class="g3pix-alert <%=flashClass%>"><%=HtmlEncode(flash)%></div>
    <%
}
%>

    <form method="post" action="<%=HtmlEncode(AppUrl("admin/site-settings.asp"))%>">
        <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">

        <div class="g3pix-form-grid">
            <div>
                <label><%=HtmlEncode(T(lang, "site_title_label"))%></label>
                <input type="text" name="site_title" maxlength="200" value="<%=HtmlEncode(formSiteTitle)%>">
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "site_logo_url"))%></label>
                <input type="text" name="site_logo_url" maxlength="400" value="<%=HtmlEncode(formSiteLogoUrl)%>">
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "default_locale"))%></label>
                <select name="default_locale">
                    <option value="en" <%=SelectedAttr(formDefaultLocale == "en")%>>en</option>
                    <option value="pt-BR" <%=SelectedAttr(formDefaultLocale == "pt-BR")%>>pt-BR</option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "show_search"))%></label>
                <select name="show_search">
                    <option value="1" <%=SelectedAttr(formShowSearch == 1)%>><%=HtmlEncode(T(lang, "yes"))%></option>
                    <option value="0" <%=SelectedAttr(formShowSearch == 0)%>><%=HtmlEncode(T(lang, "no"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "show_home_menu"))%></label>
                <select name="show_home_menu">
                    <option value="1" <%=SelectedAttr(ToInt(GetSettingValue("show_home_menu","1"),1) == 1)%>>
                        <%=HtmlEncode(T(lang, "yes"))%></option>
                    <option value="0" <%=SelectedAttr(ToInt(GetSettingValue("show_home_menu","1"),1) == 0)%>>
                        <%=HtmlEncode(T(lang, "no"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "show_login_menu"))%></label>
                <select name="show_login_menu">
                    <option value="1" <%=SelectedAttr(ToInt(GetSettingValue("show_login_menu","1"),1) == 1)%>>
                        <%=HtmlEncode(T(lang, "yes"))%></option>
                    <option value="0" <%=SelectedAttr(ToInt(GetSettingValue("show_login_menu","1"),1) == 0)%>>
                        <%=HtmlEncode(T(lang, "no"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "show_admin_menu"))%></label>
                <select name="show_admin_menu">
                    <option value="1" <%=SelectedAttr(ToInt(GetSettingValue("show_admin_menu","1"),1) == 1)%>>
                        <%=HtmlEncode(T(lang, "yes"))%></option>
                    <option value="0" <%=SelectedAttr(ToInt(GetSettingValue("show_admin_menu","1"),1) == 0)%>>
                        <%=HtmlEncode(T(lang, "no"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "show_sitemap_menu"))%></label>
                <select name="show_sitemap_menu">
                    <option value="1" <%=SelectedAttr(ToInt(GetSettingValue("show_sitemap_menu","1"),1) == 1)%>>
                        <%=HtmlEncode(T(lang, "yes"))%></option>
                    <option value="0" <%=SelectedAttr(ToInt(GetSettingValue("show_sitemap_menu","1"),1) == 0)%>>
                        <%=HtmlEncode(T(lang, "no"))%></option>
                </select>
            </div>
            <div class="full">
                <label><%=HtmlEncode(T(lang, "footer_text"))%></label>
                <textarea name="footer_text" rows="4"><%=HtmlEncode(formFooterText)%></textarea>
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