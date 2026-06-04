<%@ Language="JScript" %>
<!--#include file="includes/config.asp" -->
<!--#include file="includes/helpers.asp" -->
<!--#include file="includes/i18n.asp" -->
<!--#include file="includes/db.asp" -->
<!--#include file="includes/auth.asp" -->
<!--#include file="models/page_model.asp" -->
<!--#include file="models/menu_model.asp" -->
<!--#include file="controllers/public_controller.asp" -->
<!--#include file="views/layout.asp" -->
<%
var lang = GetBaseLanguage();
EnsureSchemaAndSeed();

var menuItems = ListPublicMenu(lang);
var pages = ListSitemapPages(lang);
var seen = NewDictionary();

RenderPublicHeader(lang, T(lang, "sitemap") + " | " + T(lang, "site_name"), menuItems, "", "");
%>
<section class="g3pix-content">
    <h1><%=HtmlEncode(T(lang, "sitemap"))%></h1>

    <div class="g3pix-grid">
        <article class="g3pix-card">
            <h2><%=HtmlEncode(T(lang, "menu"))%></h2>
            <ul>
                <%
var i;
for (i = 0; i < menuItems.length; i++) {
    var menu = menuItems[i];
    var menuUrl = TrimString(menu.url);
    if (menuUrl == "") {
        menuUrl = AppUrl("content.asp") + "?slug=" + Server.URLEncode(menu.pageSlug);
    }
    if (!seen.Exists(menuUrl)) {
        seen.Add(menuUrl, true);
%>
                <li><a href="<%=HtmlEncode(menuUrl)%>"><%=HtmlEncode(menu.title)%></a></li>
                <%
    }
}
%>
            </ul>
        </article>

        <article class="g3pix-card">
            <h2><%=HtmlEncode(T(lang, "published_content"))%></h2>
            <ul>
                <li><a href="<%=HtmlEncode(AppUrl("default.asp"))%>"><%=HtmlEncode(T(lang, "home"))%></a></li>
                <%
if (!seen.Exists(AppUrl("default.asp"))) {
    seen.Add(AppUrl("default.asp"), true);
}
%>
                <%
for (i = 0; i < pages.length; i++) {
    var page = pages[i];
    var pageUrl = AppUrl("content.asp") + "?slug=" + Server.URLEncode(page.slug);
    if (page.isHome == 1) {
        pageUrl = AppUrl("default.asp");
    }
    if (!seen.Exists(pageUrl)) {
        seen.Add(pageUrl, true);
%>
                <li><a href="<%=HtmlEncode(pageUrl)%>"><%=HtmlEncode(page.title)%></a></li>
                <%
    }
}
%>
                <li><a href="<%=HtmlEncode(AppUrl("sitemap.asp"))%>"><%=HtmlEncode(T(lang, "sitemap"))%></a></li>
            </ul>
        </article>
    </div>
</section>
<%
RenderPublicFooter(lang);
%>