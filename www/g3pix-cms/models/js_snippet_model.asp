<%@ Language="JScript" %>
<%
function ListJsSnippetsAdmin() {
    var db = OpenCmsDb();
    var items = [];
    if (db == null) {
        return items;
    }

    var rs = db.Query("SELECT id, name, code, is_active, sort_order, created_at, updated_at FROM js_snippets ORDER BY sort_order ASC, id ASC");
    if (rs != null) {
        while (!rs.EOF) {
            items.push({
                id: ToInt(rs("id"), 0),
                name: String(rs("name")),
                code: String(rs("code")),
                isActive: ToInt(rs("is_active"), 1),
                sortOrder: ToInt(rs("sort_order"), 0),
                createdAt: String(rs("created_at")),
                updatedAt: String(rs("updated_at"))
            });
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return items;
}

function GetJsSnippetById(snippetId) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var rs = db.Query("SELECT id, name, code, is_active, sort_order, created_at, updated_at FROM js_snippets WHERE id = ? LIMIT 1", snippetId);
    var item = null;
    if (rs != null) {
        if (!rs.EOF) {
            item = {
                id: ToInt(rs("id"), 0),
                name: String(rs("name")),
                code: String(rs("code")),
                isActive: ToInt(rs("is_active"), 1),
                sortOrder: ToInt(rs("sort_order"), 0),
                createdAt: String(rs("created_at")),
                updatedAt: String(rs("updated_at"))
            };
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return item;
}

function SaveJsSnippet(snippetId, name, code, isActive, sortOrder) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    if (snippetId > 0) {
        db.Exec("UPDATE js_snippets SET name = ?, code = ?, is_active = ?, sort_order = ?, updated_at = datetime('now') WHERE id = ?", name, code, isActive, sortOrder, snippetId);
    } else {
        db.Exec("INSERT INTO js_snippets (name, code, is_active, sort_order, created_at, updated_at) VALUES (?, ?, ?, ?, datetime('now'), datetime('now'))", name, code, isActive, sortOrder);
    }

    CloseCmsDb(db);
    return true;
}

function DeleteJsSnippet(snippetId) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    db.Exec("DELETE FROM js_snippets WHERE id = ?", snippetId);
    CloseCmsDb(db);
    return true;
}
%>