<%@ Language="JScript" %>
<%
function GetDashboardStats() {
    var stats = {
        pages: 0,
        menus: 0,
        media: 0
    };

    var db = OpenCmsDb();
    if (db == null) {
        return stats;
    }

    var rs = db.Query("SELECT (SELECT COUNT(1) FROM pages) AS pages_count, (SELECT COUNT(1) FROM menus) AS menu_count, (SELECT COUNT(1) FROM media) AS media_count");
    if (rs != null && rs != "") {
        if (!rs.EOF) {
            stats.pages = ToInt(rs("pages_count"), 0);
            stats.menus = ToInt(rs("menu_count"), 0);
            stats.media = ToInt(rs("media_count"), 0);
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return stats;
}
%>