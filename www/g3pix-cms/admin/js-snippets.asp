<%@ Language="JScript" %>
<!--#include file="../includes/config.asp" -->
<!--#include file="../includes/helpers.asp" -->
<!--#include file="../includes/i18n.asp" -->
<!--#include file="../includes/db.asp" -->
<!--#include file="../includes/auth.asp" -->
<!--#include file="../models/js_snippet_model.asp" -->
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
            var snippetId = ToInt(Request.Form("id"), 0);
            var name = TrimString(Request.Form("name"));
            var code = String(Request.Form("code"));
            var isActive = ToInt(Request.Form("is_active"), 0);
            var sortOrder = ToInt(Request.Form("sort_order"), 0);

            if (name == "" || TrimString(code) == "") {
                flash = T(lang, "required_fields");
                flashClass = "error";
            } else {
                SaveJsSnippet(snippetId, name, code, isActive, sortOrder);
                flash = T(lang, "saved_ok");
                flashClass = "success";
            }
        }

        if (action == "delete") {
            var deleteId = ToInt(Request.Form("id"), 0);
            if (deleteId > 0) {
                DeleteJsSnippet(deleteId);
                flash = T(lang, "deleted_ok");
                flashClass = "success";
            }
        }
    }
}

var editId = ToInt(Request.QueryString("edit"), 0);
var formSnippet = {
    id: 0,
    name: "",
    code: "",
    isActive: 1,
    sortOrder: 0
};

if (editId > 0) {
    var loadedSnippet = GetJsSnippetById(editId);
    if (loadedSnippet != null) {
        formSnippet = loadedSnippet;
    }
}

var formActionUrl = AppUrl("admin/js-snippets.asp");
if (editId > 0) {
    formActionUrl = AppUrl("admin/js-snippets.asp") + "?edit=" + editId;
}

var snippets = ListJsSnippetsAdmin();
RenderAdminHeader(lang, T(lang, "js_snippets") + " | " + T(lang, "site_name"), "js-snippets");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "js_snippets"))%></h1>
    <p><%=HtmlEncode(T(lang, "admin_dashboard_intro"))%></p>
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
        <input type="hidden" name="id" value="<%=formSnippet.id%>">

        <div class="g3pix-form-grid">
            <div>
                <label><%=HtmlEncode(T(lang, "snippet_name"))%></label>
                <input type="text" name="name" maxlength="120" value="<%=HtmlEncode(formSnippet.name)%>" required>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "enabled"))%></label>
                <select name="is_active">
                    <option value="1" <%=SelectedAttr(formSnippet.isActive == 1)%>><%=HtmlEncode(T(lang, "yes"))%>
                    </option>
                    <option value="0" <%=SelectedAttr(formSnippet.isActive == 0)%>><%=HtmlEncode(T(lang, "no"))%>
                    </option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "sort_order"))%></label>
                <input type="number" name="sort_order" value="<%=formSnippet.sortOrder%>">
            </div>
            <div class="full">
                <label><%=HtmlEncode(T(lang, "snippet_code"))%></label>
                <textarea name="code" rows="14" required><%=HtmlEncode(formSnippet.code)%></textarea>
            </div>
        </div>

        <div class="actions-row">
            <button class="btn btn-primary" type="submit"><%=HtmlEncode(T(lang, "save"))%></button>
            <a class="btn btn-secondary"
                href="<%=HtmlEncode(AppUrl("admin/js-snippets.asp"))%>"><%=HtmlEncode(T(lang, "cancel"))%></a>
        </div>
    </form>
</section>

<section class="g3pix-content">
    <h2><%=HtmlEncode(T(lang, "js_snippets"))%></h2>
    <div class="g3pix-table-wrap">
        <table class="g3pix-table">
            <thead>
                <tr>
                    <th><%=HtmlEncode(T(lang, "id"))%></th>
                    <th><%=HtmlEncode(T(lang, "snippet_name"))%></th>
                    <th><%=HtmlEncode(T(lang, "enabled"))%></th>
                    <th><%=HtmlEncode(T(lang, "sort_order"))%></th>
                    <th><%=HtmlEncode(T(lang, "actions"))%></th>
                </tr>
            </thead>
            <tbody>
                <%
var i;
for (i = 0; i < snippets.length; i++) {
    var row = snippets[i];
%>
                <tr>
                    <td><%=row.id%></td>
                    <td><%=HtmlEncode(row.name)%></td>
                    <td><%=HtmlEncode(T(lang, YesNoText(row.isActive == 1)))%></td>
                    <td><%=row.sortOrder%></td>
                    <td>
                        <a class="btn btn-secondary"
                            href="<%=HtmlEncode(AppUrl("admin/js-snippets.asp"))%>?edit=<%=row.id%>"><%=HtmlEncode(T(lang, "edit"))%></a>
                        <form method="post" action="<%=HtmlEncode(AppUrl("admin/js-snippets.asp"))%>">
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