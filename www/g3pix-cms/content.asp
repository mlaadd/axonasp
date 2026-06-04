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

var slug = SafeSlug(Request.QueryString("slug"));
if (slug == "") {
    slug = "home";
}

var vm = BuildContentViewModel(slug, lang);
var page = vm.page;
if (page == null) {
    Response.Status = "404 Not Found";
    page = {
        id: 0,
        slug: "not-found",
        title: "404",
        excerpt: "",
        content: "<p>" + HtmlEncode(T(lang, "not_found_content")) + "</p>",
        seoTitle: "",
        metaDescription: ""
    };
}

var pageTitle = page.title;
if (TrimString(page.seoTitle) != "") {
    pageTitle = page.seoTitle;
}
var pageMetaDescription = page.metaDescription;
if (TrimString(pageMetaDescription) == "") {
    pageMetaDescription = page.excerpt;
}

var renderedContent = RenderContentWithShortcodes(page.content, lang, 0);
var childPages = [];
if (page.id > 0) {
    childPages = ListChildPages(page.id, lang);
}

RenderPublicHeader(lang, pageTitle + " | " + T(lang, "site_name"), vm.menu, slug, pageMetaDescription);
%>
<article class="g3pix-content">
    <%
if (page.pageType != "home") {
%>
    <h1><%=HtmlEncode(page.title)%></h1>
    <p><%=HtmlEncode(page.excerpt)%></p>
    <%
}
%>
    <div><%=renderedContent%></div>
    <%
if (childPages.length > 0) {
%>
    <section class="g3pix-child-pages">
        <h2><%=HtmlEncode(T(lang, "child_pages"))%></h2>
        <div class="g3pix-grid">
            <%
    var i;
    for (i = 0; i < childPages.length; i++) {
        var childPage = childPages[i];
%>
            <article class="g3pix-card">
                <span class="g3pix-pill"><%=HtmlEncode(childPage.pageType)%></span>
                <h3><%=HtmlEncode(childPage.title)%></h3>
                <p><%=HtmlEncode(childPage.excerpt)%></p>
                <a class="btn btn-secondary"
                    href="<%=HtmlEncode(AppUrl("content.asp"))%>?slug=<%=Server.URLEncode(childPage.slug)%>"><%=HtmlEncode(T(lang, "read_more"))%></a>
            </article>
            <%
    }
%>
        </div>
    </section>
    <%
}
%>
</article>
<%
RenderPublicFooter(lang);
%>