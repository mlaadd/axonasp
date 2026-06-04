<%@ Language="JScript" %>
<!--#include file="../includes/config.asp" -->
<!--#include file="../includes/helpers.asp" -->
<!--#include file="../includes/i18n.asp" -->
<!--#include file="../includes/db.asp" -->
<!--#include file="../includes/auth.asp" -->
<!--#include file="../models/user_model.asp" -->
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
        var username = TrimString(Request.Form("username"));
        var displayName = TrimString(Request.Form("display_name"));
        var password = String(Request.Form("password"));
        var role = TrimString(Request.Form("role"));
        var mustChangePassword = ToInt(Request.Form("must_change_password"), 1);

        if (username == "" || displayName == "" || password == "") {
            flash = T(lang, "required_fields");
            flashClass = "error";
        } else if (FindUserByUsername(username) != null) {
            flash = T(lang, "user_exists");
            flashClass = "error";
        } else {
            if (role == "") {
                role = "admin";
            }
            if (role != "admin") {
                role = "admin";
            }
            if (mustChangePassword != 0) {
                mustChangePassword = 1;
            }
            CreateUser(username, displayName, password, role, mustChangePassword);
            flash = T(lang, "saved_ok");
            flashClass = "success";
        }
    }
}

var users = ListUsers();
RenderAdminHeader(lang, T(lang, "users") + " | " + T(lang, "site_name"), "users");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "users"))%></h1>
    <%
if (flash != "") {
%>
    <div class="g3pix-alert <%=flashClass%>"><%=HtmlEncode(flash)%></div>
    <%
}
%>
    <form method="post" action="<%=HtmlEncode(AppUrl("admin/users.asp"))%>">
        <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">
        <div class="g3pix-form-grid">
            <div>
                <label><%=HtmlEncode(T(lang, "username"))%></label>
                <input type="text" name="username" maxlength="80" required>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "display_name"))%></label>
                <input type="text" name="display_name" maxlength="120" required>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "password"))%></label>
                <input type="password" name="password" maxlength="128" required>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "role"))%></label>
                <select name="role">
                    <option value="admin"><%=HtmlEncode(T(lang, "admin_role"))%></option>
                </select>
            </div>
            <div>
                <label><%=HtmlEncode(T(lang, "must_change_password"))%></label>
                <select name="must_change_password">
                    <option value="1"><%=HtmlEncode(T(lang, "yes"))%></option>
                    <option value="0"><%=HtmlEncode(T(lang, "no"))%></option>
                </select>
            </div>
        </div>
        <div class="actions-row">
            <button class="btn btn-primary" type="submit"><%=HtmlEncode(T(lang, "create_user"))%></button>
        </div>
    </form>
</section>

<section class="g3pix-content">
    <div class="g3pix-table-wrap">
        <table class="g3pix-table">
            <thead>
                <tr>
                    <th><%=HtmlEncode(T(lang, "id"))%></th>
                    <th><%=HtmlEncode(T(lang, "username"))%></th>
                    <th><%=HtmlEncode(T(lang, "display_name"))%></th>
                    <th><%=HtmlEncode(T(lang, "role"))%></th>
                    <th><%=HtmlEncode(T(lang, "must_change_password"))%></th>
                    <th><%=HtmlEncode(T(lang, "active"))%></th>
                </tr>
            </thead>
            <tbody>
                <%
var i;
for (i = 0; i < users.length; i++) {
    var row = users[i];
%>
                <tr>
                    <td><%=row.id%></td>
                    <td><%=HtmlEncode(row.username)%></td>
                    <td><%=HtmlEncode(row.displayName)%></td>
                    <td><%=HtmlEncode(row.role)%></td>
                    <td><%=HtmlEncode(T(lang, YesNoText(row.mustChangePassword == 1)))%></td>
                    <td><%=HtmlEncode(T(lang, YesNoText(row.isActive == 1)))%></td>
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