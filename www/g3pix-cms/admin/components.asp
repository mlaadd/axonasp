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
            var slug = SafeSlug(Request.Form("slug"));
            var content = String(Request.Form("content"));
            var status = TrimString(Request.Form("status"));
            var locale = TrimString(Request.Form("locale"));
            var sortOrder = ToInt(Request.Form("sort_order"), 0);

            if (slug == "") {
                flash = T(lang, "required_fields");
                flashClass = "error";
            } else {
                if (status != "published") {
                    status = "draft";
                }
                if (locale != "pt-BR" && locale != "en") {
                    locale = "en";
                }
                SavePage(pageId, slug, slug, "", content, status, locale, 0, "block", 0, sortOrder, "all", "", "", "");
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
    }
}

var editId = ToInt(Request.QueryString("edit"), 0);
var formComponent = {
    id: 0,
    slug: "",
    content: "",
    status: "draft",
    locale: "en",
    sortOrder: 0
};

if (editId > 0) {
    var loadedPage = GetPageById(editId);
    if (loadedPage != null && loadedPage.pageType == "block") {
        formComponent = loadedPage;
    }
}

var allPages = AdminListPages();
var components = [];
var i;
for (i = 0; i < allPages.length; i++) {
    if (allPages[i].pageType == "block") {
        components.push(allPages[i]);
    }
}

var formActionUrl = AppUrl("admin/components.asp");
if (editId > 0) {
    formActionUrl = AppUrl("admin/components.asp") + "?edit=" + editId;
}

RenderAdminHeader(lang, T(lang, "component_management") + " | " + T(lang, "site_name"), "components");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "component_management"))%></h1>
    <p class="g3pix-help"><%=HtmlEncode(T(lang, "content_shortcodes_help"))%></p>
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
        <input type="hidden" name="id" value="<%=formComponent.id%>">

        <div class="g3pix-form-grid">
            <div>
                <label><%=HtmlEncode(T(lang, "slug"))%></label>
                <input type="text" name="slug" value="<%=HtmlEncode(formComponent.slug)%>" maxlength="160" required>
            </div>
            <div class="full">
                <label><%=HtmlEncode(T(lang, "content"))%></label>
                <textarea name="content" rows="9"><%=HtmlEncode(formComponent.content)%></textarea>

            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "status"))%></label>
                <select name="status">
                    <option value="draft" <%=SelectedAttr(formComponent.status == "draft")%>>
                        <%=HtmlEncode(T(lang, "draft"))%></option>
                    <option value="published" <%=SelectedAttr(formComponent.status == "published")%>>
                        <%=HtmlEncode(T(lang, "published"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "locale"))%></label>
                <select name="locale">
                    <option value="en" <%=SelectedAttr(formComponent.locale == "en")%>>en</option>
                    <option value="pt-BR" <%=SelectedAttr(formComponent.locale == "pt-BR")%>>pt-BR</option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "sort_order"))%></label>
                <input type="number" name="sort_order" value="<%=formComponent.sortOrder%>">
            </div>
        </div>

        <div class="actions-row">
            <button class="btn btn-primary" type="submit"><%=HtmlEncode(T(lang, "save"))%></button>
            <a class="btn btn-secondary"
                href="<%=HtmlEncode(AppUrl("admin/components.asp"))%>"><%=HtmlEncode(T(lang, "cancel"))%></a>
        </div>
    </form>
</section>

<section class="g3pix-content">
    <div class="g3pix-table-wrap">
        <table class="g3pix-table">
            <thead>
                <tr>
                    <th><%=HtmlEncode(T(lang, "id"))%></th>
                    <th><%=HtmlEncode(T(lang, "slug"))%></th>
                    <th><%=HtmlEncode(T(lang, "component_shortcode"))%></th>
                    <th><%=HtmlEncode(T(lang, "status"))%></th>
                    <th><%=HtmlEncode(T(lang, "locale"))%></th>
                    <th><%=HtmlEncode(T(lang, "actions"))%></th>
                </tr>
            </thead>
            <tbody>
                <%
for (i = 0; i < components.length; i++) {
    var row = components[i];
%>
                <tr>
                    <td><%=row.id%></td>
                    <td><%=HtmlEncode(row.slug)%></td>
                    <td><code>[g3pix-part slug="<%=HtmlEncode(row.slug)%>"]</code></td>
                    <td><%=HtmlEncode(row.status)%></td>
                    <td><%=HtmlEncode(row.locale)%></td>
                    <td>
                        <a class="btn btn-secondary"
                            href="<%=HtmlEncode(AppUrl("admin/components.asp"))%>?edit=<%=row.id%>"><%=HtmlEncode(T(lang, "edit"))%></a>
                        <form method="post" action="<%=HtmlEncode(AppUrl("admin/components.asp"))%>">
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