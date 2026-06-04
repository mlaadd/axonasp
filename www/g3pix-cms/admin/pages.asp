<%@ Language="JScript" %>
<!--#include file="../includes/config.asp" -->
<!--#include file="../includes/helpers.asp" -->
<!--#include file="../includes/i18n.asp" -->
<!--#include file="../includes/db.asp" -->
<!--#include file="../includes/auth.asp" -->
<!--#include file="../models/page_model.asp" -->
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
        var action = TrimString(Request.Form("action"));
        if (action == "save") {
            var pageId = ToInt(Request.Form("id"), 0);
            var title = TrimString(Request.Form("title"));
            var slug = SafeSlug(Request.Form("slug"));
            var excerpt = TrimString(Request.Form("excerpt"));
            var content = String(Request.Form("content"));
            var status = TrimString(Request.Form("status"));
            var locale = TrimString(Request.Form("locale"));
            var isHome = ToInt(Request.Form("is_home"), 0);
            var pageType = TrimString(Request.Form("page_type"));
            var parentId = ToInt(Request.Form("parent_id"), 0);
            var sortOrder = ToInt(Request.Form("sort_order"), 0);
            var homeMode = TrimString(Request.Form("home_mode"));
            var homeSectionTitle = TrimString(Request.Form("home_section_title"));
            var seoTitle = TrimString(Request.Form("seo_title"));
            var metaDescription = TrimString(Request.Form("meta_description"));

            if (title == "" || slug == "") {
                flash = T(lang, "required_fields");
                flashClass = "error";
            } else {
                if (status != "published") {
                    status = "draft";
                }
                if (locale != "pt-BR" && locale != "en") {
                    locale = "en";
                }
                SavePage(pageId, slug, title, excerpt, content, status, locale, isHome, pageType, parentId, sortOrder, homeMode, homeSectionTitle, seoTitle, metaDescription);
                flash = T(lang, "saved_ok");
                flashClass = "success";
            }
        }

        if (action == "delete") {
            var deleteId = ToInt(Request.Form("id"), 0);
            if (deleteId > 0) {
                DeletePage(deleteId);
                flash = T(lang, "deleted_ok");
                flashClass = "success";
            }
        }

        if (action == "set-home") {
            var homeId = ToInt(Request.Form("id"), 0);
            if (homeId > 0) {
                var homeCandidate = GetPageById(homeId);
                if (homeCandidate != null && homeCandidate.pageType != "block") {
                    SavePage(homeCandidate.id, homeCandidate.slug, homeCandidate.title, homeCandidate.excerpt, homeCandidate.content, "published", homeCandidate.locale, 1, homeCandidate.pageType, 0, homeCandidate.sortOrder, homeCandidate.homeMode, homeCandidate.homeSectionTitle, homeCandidate.seoTitle, homeCandidate.metaDescription);
                    flash = T(lang, "saved_ok");
                    flashClass = "success";
                }
            }
        }
    }
}

var editId = ToInt(Request.QueryString("edit"), 0);
var formPage = {
    id: 0,
    title: "",
    slug: "",
    excerpt: "",
    content: "",
    status: "draft",
    locale: "en",
    isHome: 0,
    pageType: "page",
    parentId: 0,
    sortOrder: 0,
    homeMode: "all",
    homeSectionTitle: "",
    seoTitle: "",
    metaDescription: ""
};

if (editId > 0) {
    var loadedPage = GetPageById(editId);
    if (loadedPage != null) {
        formPage = loadedPage;
    }
}

var allPages = AdminListPages();
var pages = [];
var pi;
for (pi = 0; pi < allPages.length; pi++) {
    if (allPages[pi].pageType != "block") {
        pages.push(allPages[pi]);
    }
}
var formActionUrl = AppUrl("admin/pages.asp");
if (editId > 0) {
    formActionUrl = AppUrl("admin/pages.asp") + "?edit=" + editId;
}
RenderAdminHeader(lang, T(lang, "page_management") + " | " + T(lang, "site_name"), "pages");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "page_management"))%></h1>
    <p class="g3pix-help"><%=HtmlEncode(T(lang, "page_editor_help"))%></p>
    <%
if (flash != "") {
%>
    <div class="g3pix-alert <%=flashClass%>"><%=HtmlEncode(flash)%></div>
    <%
}
%>
    <form method="post" action="<%=HtmlEncode(formActionUrl)%>">
        <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">
        <input type="hidden" name="action" value="save">
        <input type="hidden" name="id" value="<%=formPage.id%>">

        <div class="g3pix-form-grid">
            <div>
                <label><%=HtmlEncode(T(lang, "title"))%></label>
                <input type="text" name="title" value="<%=HtmlEncode(formPage.title)%>" maxlength="160" required>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "slug"))%></label>
                <input type="text" name="slug" value="<%=HtmlEncode(formPage.slug)%>" maxlength="160" required>
            </div>
            <div class="full">
                <label><%=HtmlEncode(T(lang, "excerpt"))%></label>
                <textarea name="excerpt" rows="2"><%=HtmlEncode(formPage.excerpt)%></textarea>
            </div>
            <div class="full">
                <label><%=HtmlEncode(T(lang, "content"))%></label>
                <textarea name="content" rows="9"><%=HtmlEncode(formPage.content)%></textarea>
                <p class="g3pix-help"><%=HtmlEncode(T(lang, "content_shortcodes_help"))%></p>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "seo_title"))%></label>
                <input type="text" name="seo_title" value="<%=HtmlEncode(formPage.seoTitle)%>" maxlength="160">
            </div>
            <div class="full">
                <label><%=HtmlEncode(T(lang, "meta_description"))%></label>
                <textarea name="meta_description" rows="3"
                    maxlength="320"><%=HtmlEncode(formPage.metaDescription)%></textarea>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "status"))%></label>
                <select name="status">
                    <option value="draft" <%=SelectedAttr(formPage.status == "draft")%>>
                        <%=HtmlEncode(T(lang, "draft"))%></option>
                    <option value="published" <%=SelectedAttr(formPage.status == "published")%>>
                        <%=HtmlEncode(T(lang, "published"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "locale"))%></label>
                <select name="locale">
                    <option value="en" <%=SelectedAttr(formPage.locale == "en")%>>en</option>
                    <option value="pt-BR" <%=SelectedAttr(formPage.locale == "pt-BR")%>>pt-BR</option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "page_type"))%></label>
                <select name="page_type">
                    <option value="home" <%=SelectedAttr(formPage.pageType == "home")%>><%=HtmlEncode(T(lang, "home"))%>
                    </option>
                    <option value="page" <%=SelectedAttr(formPage.pageType == "page")%>><%=HtmlEncode(T(lang, "page"))%>
                    </option>
                    <option value="post" <%=SelectedAttr(formPage.pageType == "post")%>><%=HtmlEncode(T(lang, "post"))%>
                    </option>
                    <option value="block" <%=SelectedAttr(formPage.pageType == "block")%>>
                        <%=HtmlEncode(T(lang, "block"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "parent_page"))%></label>
                <select name="parent_id">
                    <option value="0" <%=SelectedAttr(formPage.parentId == 0)%>><%=HtmlEncode(T(lang, "no_parent"))%>
                    </option>
                    <%
var parentIndex;
for (parentIndex = 0; parentIndex < pages.length; parentIndex++) {
    var parentRow = pages[parentIndex];
    if (parentRow.id != formPage.id) {
%>
                    <option value="<%=parentRow.id%>" <%=SelectedAttr(formPage.parentId == parentRow.id)%>>
                        <%=HtmlEncode(parentRow.title)%> (<%=HtmlEncode(parentRow.pageType)%>)</option>
                    <%
    }
}
%>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "sort_order"))%></label>
                <input type="number" name="sort_order" value="<%=formPage.sortOrder%>">
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "home_page"))%></label>
                <select name="is_home">
                    <option value="0" <%=SelectedAttr(formPage.isHome == 0)%>><%=HtmlEncode(T(lang, "no"))%></option>
                    <option value="1" <%=SelectedAttr(formPage.isHome == 1)%>><%=HtmlEncode(T(lang, "yes"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "home_listing_mode"))%></label>
                <select name="home_mode">
                    <option value="all" <%=SelectedAttr(formPage.homeMode == "all")%>>
                        <%=HtmlEncode(T(lang, "all_content"))%></option>
                    <option value="posts" <%=SelectedAttr(formPage.homeMode == "posts")%>>
                        <%=HtmlEncode(T(lang, "blog_posts"))%></option>
                    <option value="pages" <%=SelectedAttr(formPage.homeMode == "pages")%>>
                        <%=HtmlEncode(T(lang, "pages_only"))%></option>
                    <option value="linked" <%=SelectedAttr(formPage.homeMode == "linked")%>>
                        <%=HtmlEncode(T(lang, "linked_pages"))%></option>
                    <option value="none" <%=SelectedAttr(formPage.homeMode == "none")%>>
                        <%=HtmlEncode(T(lang, "no_listing"))%></option>
                </select>
            </div>
            <div class="full">
                <label><%=HtmlEncode(T(lang, "home_section_title"))%></label>
                <input type="text" name="home_section_title" value="<%=HtmlEncode(formPage.homeSectionTitle)%>"
                    maxlength="160">
            </div>
        </div>

        <div class="actions-row">
            <button class="btn btn-primary" type="submit"><%=HtmlEncode(T(lang, "save"))%></button>
            <a class="btn btn-secondary"
                href="<%=HtmlEncode(AppUrl("admin/pages.asp"))%>"><%=HtmlEncode(T(lang, "cancel"))%></a>
        </div>
    </form>
</section>

<section class="g3pix-content">
    <div class="g3pix-table-wrap">
        <table class="g3pix-table">
            <thead>
                <tr>
                    <th><%=HtmlEncode(T(lang, "id"))%></th>
                    <th><%=HtmlEncode(T(lang, "title"))%></th>
                    <th><%=HtmlEncode(T(lang, "slug"))%></th>
                    <th><%=HtmlEncode(T(lang, "page_type"))%></th>
                    <th><%=HtmlEncode(T(lang, "parent_page"))%></th>
                    <th><%=HtmlEncode(T(lang, "status"))%></th>
                    <th><%=HtmlEncode(T(lang, "locale"))%></th>
                    <th><%=HtmlEncode(T(lang, "actions"))%></th>
                </tr>
            </thead>
            <tbody>
                <%
var i;
for (i = 0; i < pages.length; i++) {
    var row = pages[i];
%>
                <tr>
                    <td><%=row.id%></td>
                    <td><%=HtmlEncode(row.title)%></td>
                    <td><%=HtmlEncode(row.slug)%></td>
                    <td><%=HtmlEncode(row.pageType)%></td>
                    <td><%=HtmlEncode(row.parentTitle)%></td>
                    <td><%=HtmlEncode(row.status)%></td>
                    <td><%=HtmlEncode(row.locale)%></td>
                    <td>
                        <%
    if (row.isHome == 1) {
%>
                        <span class="g3pix-pill"><%=HtmlEncode(T(lang, "is_homepage"))%></span>
                        <%
    } else if (row.pageType != "block") {
%>
                        <form method="post" action="<%=HtmlEncode(AppUrl("admin/pages.asp"))%>">
                            <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">
                            <input type="hidden" name="action" value="set-home">
                            <input type="hidden" name="id" value="<%=row.id%>">
                            <button class="btn btn-secondary"
                                type="submit"><%=HtmlEncode(T(lang, "set_as_homepage"))%></button>
                        </form>
                        <%
    }
%>
                        <a class="btn btn-secondary"
                            href="<%=HtmlEncode(AppUrl("admin/pages.asp"))%>?edit=<%=row.id%>"><%=HtmlEncode(T(lang, "edit"))%></a>
                        <form method="post" action="<%=HtmlEncode(AppUrl("admin/pages.asp"))%>">
                            <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%=row.id%>">
                            <button class="btn btn-danger" type="submit"><%=HtmlEncode(T(lang, "delete"))%></button>
                        </form>
                    </td>
                </tr>
                <%
}
%>
            </tbody>
        </table>
    </div>
</section>
<%
RenderAdminFooter();
%>