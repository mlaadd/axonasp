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
var showSearch = IsSearchEnabled();

var searchQuery = "";
var rawSearchQuery = "";
if (showSearch) {
    rawSearchQuery = String(Request.QueryString("q"));
}
if (showSearch && rawSearchQuery != "" && rawSearchQuery != "null") {
    searchQuery = TrimString(rawSearchQuery);
}
var pageNumber = ToInt(Request.QueryString("page"), 1);
var pageSize = 4;

var vm = BuildHomeViewModel(lang, searchQuery, pageNumber, pageSize);
var homePage = vm.homePage;
if (homePage == null) {
    homePage = {
        title: T(lang, "site_name"),
        excerpt: "",
        content: "",
        homeMode: "all",
        homeSectionTitle: T(lang, "published_content"),
        seoTitle: "",
        metaDescription: ""
    };
}

var homeTitle = homePage.title;
if (TrimString(homePage.seoTitle) != "") {
    homeTitle = homePage.seoTitle;
}
var homeMetaDescription = homePage.metaDescription;
if (TrimString(homeMetaDescription) == "") {
    homeMetaDescription = homePage.excerpt;
}

RenderPublicHeader(lang, homeTitle + " | " + T(lang, "site_name"), vm.menu, "home", homeMetaDescription);
%>
<article class="g3pix-content">
    <h1><%=HtmlEncode(homePage.title)%></h1>
    <%
if (TrimString(homePage.excerpt) != "") {
%>
    <p><%=HtmlEncode(homePage.excerpt)%></p>
    <%
}
%>
    <div><%=RenderContentWithShortcodes(homePage.content, lang, 0)%></div>
</article>

<%
if (homePage.homeMode != "none") {
%>
<section>
    <div class="actions-row g3pix-home-section-head">
        <div>
            <h2><%=HtmlEncode(vm.homeSectionTitle)%></h2>
            <p><%=HtmlEncode(T(lang, "results"))%>: <%=vm.totalCount%></p>
        </div>
        <%
if (showSearch) {
%>
        <form method="get" action="<%=HtmlEncode(AppUrl("default.asp"))%>" class="g3pix-form g3pix-home-search">
            <input type="hidden" name="lang" value="<%=HtmlEncode(lang)%>">
            <input type="search" name="q" value="<%=HtmlEncode(searchQuery)%>"
                placeholder="<%=HtmlEncode(T(lang, "search"))%>">
            <button class="btn btn-secondary" type="submit"><%=HtmlEncode(T(lang, "search"))%></button>
        </form>
        <%
}
%>
    </div>
    <div class="g3pix-grid">
        <%
var i;
for (i = 0; i < vm.pages.length; i++) {
    var page = vm.pages[i];
    var pageTypeLabel = page.pageType;
    if (page.pageType == "post") {
        pageTypeLabel = T(lang, "post");
    } else if (page.pageType == "page") {
        pageTypeLabel = T(lang, "page");
    } else if (page.pageType == "home") {
        pageTypeLabel = T(lang, "home");
    }
%>
        <article class="g3pix-card">
            <div class="g3pix-card-meta">
                <span class="g3pix-pill"><%=HtmlEncode(pageTypeLabel)%></span>
                <span><%=HtmlEncode(page.locale)%></span>
            </div>
            <h3><%=HtmlEncode(page.title)%></h3>
            <p><%=HtmlEncode(page.excerpt)%></p>
            <a class="btn btn-secondary"
                href="<%=HtmlEncode(AppUrl("content.asp"))%>?slug=<%=Server.URLEncode(page.slug)%>"><%=HtmlEncode(T(lang, "read_more"))%></a>
        </article>
        <%
}
%>
    </div>
</section>
<%
if (vm.totalPages > 1) {
%>
<nav class="actions-row" aria-label="Pagination">
    <%
    var p;
    for (p = 1; p <= vm.totalPages; p++) {
        var linkUrl = AppUrl("default.asp") + "?lang=" + Server.URLEncode(lang) + "&page=" + p;
        if (searchQuery != "") {
            linkUrl = linkUrl + "&q=" + Server.URLEncode(searchQuery);
        }
        if (p == vm.pageNumber) {
%>
    <span class="pill pill-primary"><%=p%></span>
    <%
        } else {
%>
    <a class="btn btn-secondary" href="<%=HtmlEncode(linkUrl)%>"><%=p%></a>
    <%
        }
    }
%>
</nav>
<%
}
%>
<%
}
%>
<%
RenderPublicFooter(lang);
%>