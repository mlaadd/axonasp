<%@ Language="JScript" %>
<!--#include file="../includes/config.asp" -->
<!--#include file="../includes/helpers.asp" -->
<!--#include file="../includes/i18n.asp" -->
<!--#include file="../includes/db.asp" -->
<!--#include file="../includes/auth.asp" -->
<!--#include file="../models/menu_model.asp" -->
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
            var menuId = ToInt(Request.Form("id"), 0);
            var title = TrimString(Request.Form("title"));
            var pageSlug = SafeSlug(Request.Form("page_slug"));
            var url = TrimString(Request.Form("url"));
            var target = TrimString(Request.Form("target"));
            var sortOrder = ToInt(Request.Form("sort_order"), 0);
            var isVisible = ToInt(Request.Form("is_visible"), 0);
            var locale = TrimString(Request.Form("locale"));

            if (title == "") {
                flash = T(lang, "required_fields");
                flashClass = "error";
            } else {
                if (target == "") {
                    target = "_self";
                }
                if (locale != "pt-BR" && locale != "en") {
                    locale = "en";
                }
                SaveMenu(menuId, title, pageSlug, url, target, sortOrder, isVisible, locale);
                flash = T(lang, "saved_ok");
                flashClass = "success";
            }
        }

        if (action == "delete") {
            var deleteId = ToInt(Request.Form("id"), 0);
            if (deleteId > 0) {
                DeleteMenu(deleteId);
                flash = T(lang, "deleted_ok");
                flashClass = "success";
            }
        }
    }
}

var editId = ToInt(Request.QueryString("edit"), 0);
var formMenu = {
    id: 0,
    title: "",
    pageSlug: "",
    url: "",
    target: "_self",
    sortOrder: 0,
    isVisible: 1,
    locale: "en"
};

if (editId > 0) {
    var loadedMenu = GetMenuById(editId);
    if (loadedMenu != null) {
        formMenu = loadedMenu;
    }
}

var menus = AdminListMenus();
var formActionUrl = AppUrl("admin/menu.asp");
if (editId > 0) {
    formActionUrl = AppUrl("admin/menu.asp") + "?edit=" + editId;
}
RenderAdminHeader(lang, T(lang, "menu_management") + " | " + T(lang, "site_name"), "menu");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "menu_management"))%></h1>
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
        <input type="hidden" name="id" value="<%=formMenu.id%>">

        <div class="g3pix-form-grid">
            <div>
                <label><%=HtmlEncode(T(lang, "title"))%></label>
                <input type="text" name="title" value="<%=HtmlEncode(formMenu.title)%>" required>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "slug"))%></label>
                <input type="text" name="page_slug" value="<%=HtmlEncode(formMenu.pageSlug)%>">
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "url"))%></label>
                <input type="text" name="url" value="<%=HtmlEncode(formMenu.url)%>">
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "target"))%></label>
                <input type="text" name="target" value="<%=HtmlEncode(formMenu.target)%>">
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "sort_order"))%></label>
                <input type="number" name="sort_order" value="<%=formMenu.sortOrder%>">
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "visible"))%></label>
                <select name="is_visible">
                    <option value="1" <%=SelectedAttr(formMenu.isVisible == 1)%>><%=HtmlEncode(T(lang, "yes"))%>
                    </option>
                    <option value="0" <%=SelectedAttr(formMenu.isVisible == 0)%>><%=HtmlEncode(T(lang, "no"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "locale"))%></label>
                <select name="locale">
                    <option value="en" <%=SelectedAttr(formMenu.locale == "en")%>>en</option>
                    <option value="pt-BR" <%=SelectedAttr(formMenu.locale == "pt-BR")%>>pt-BR</option>
                </select>
            </div>
        </div>

        <div class="actions-row">
            <button class="btn btn-primary" type="submit"><%=HtmlEncode(T(lang, "save"))%></button>
            <a class="btn btn-secondary"
                href="<%=HtmlEncode(AppUrl("admin/menu.asp"))%>"><%=HtmlEncode(T(lang, "cancel"))%></a>
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
                    <th><%=HtmlEncode(T(lang, "url"))%></th>
                    <th><%=HtmlEncode(T(lang, "sort_order"))%></th>
                    <th><%=HtmlEncode(T(lang, "actions"))%></th>
                </tr>
            </thead>
            <tbody>
                <%
var i;
for (i = 0; i < menus.length; i++) {
    var row = menus[i];
%>
                <tr>
                    <td><%=row.id%></td>
                    <td><%=HtmlEncode(row.title)%></td>
                    <td><%=HtmlEncode(row.pageSlug)%></td>
                    <td><%=HtmlEncode(row.url)%></td>
                    <td><%=row.sortOrder%></td>
                    <td>
                        <a class="btn btn-secondary"
                            href="<%=HtmlEncode(AppUrl("admin/menu.asp"))%>?edit=<%=row.id%>"><%=HtmlEncode(T(lang, "edit"))%></a>
                        <form method="post" action="<%=HtmlEncode(AppUrl("admin/menu.asp"))%>">
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