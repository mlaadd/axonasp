<%@ Language="JScript" %>
<%
function ReadMenuRecord(rs) {
    return {
        id: ToInt(rs("id"), 0),
        title: String(rs("title")),
        pageSlug: String(rs("page_slug")),
        url: String(rs("url")),
        target: String(rs("target")),
        sortOrder: ToInt(rs("sort_order"), 0),
        isVisible: ToInt(rs("is_visible"), 0),
        locale: String(rs("locale"))
    };
}

function ListPublicMenu(lang) {
    var db = OpenCmsDb();
    var items = [];
    if (db == null) {
        return items;
    }

    var rs = db.Query("SELECT id, title, page_slug, url, target, sort_order, is_visible, locale FROM menus WHERE is_visible = 1 AND (locale = ? OR locale = 'en') ORDER BY sort_order ASC, id ASC", lang);
    if (rs != null && rs != "") {
        while (!rs.EOF) {
            items.push(ReadMenuRecord(rs));
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return items;
}

function AdminListMenus() {
    var db = OpenCmsDb();
    var items = [];
    if (db == null) {
        return items;
    }

    var rs = db.Query("SELECT id, title, page_slug, url, target, sort_order, is_visible, locale FROM menus ORDER BY sort_order ASC, id ASC");
    if (rs != null && rs != "") {
        while (!rs.EOF) {
            items.push(ReadMenuRecord(rs));
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return items;
}

function GetMenuById(menuId) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var rs = db.Query("SELECT id, title, page_slug, url, target, sort_order, is_visible, locale FROM menus WHERE id = ? LIMIT 1", menuId);
    var item = null;
    if (rs != null && rs != "") {
        if (!rs.EOF) {
            item = ReadMenuRecord(rs);
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return item;
}

function SaveMenu(menuId, title, pageSlug, url, target, sortOrder, isVisible, locale) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    if (menuId > 0) {
        db.Exec("UPDATE menus SET title = ?, page_slug = ?, url = ?, target = ?, sort_order = ?, is_visible = ?, locale = ?, updated_at = datetime('now') WHERE id = ?", title, pageSlug, url, target, sortOrder, isVisible, locale, menuId);
    } else {
        db.Exec("INSERT INTO menus (title, page_slug, url, target, sort_order, is_visible, locale, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))", title, pageSlug, url, target, sortOrder, isVisible, locale);
    }

    CloseCmsDb(db);
    return true;
}

function DeleteMenu(menuId) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    db.Exec("DELETE FROM menus WHERE id = ?", menuId);
    CloseCmsDb(db);
    return true;
}
%>