<%@ Language="JScript" %>
<%
function ListMediaItems() {
    var db = OpenCmsDb();
    var items = [];
    if (db == null) {
        return items;
    }

    var rs = db.Query("SELECT id, file_name, relative_path, mime_type, size_bytes, uploaded_by, created_at FROM media ORDER BY datetime(created_at) DESC");
    if (rs != null) {
        while (!rs.EOF) {
            items.push({
                id: ToInt(rs("id"), 0),
                fileName: String(rs("file_name")),
                relativePath: String(rs("relative_path")),
                mimeType: String(rs("mime_type")),
                sizeBytes: ToInt(rs("size_bytes"), 0),
                uploadedBy: String(rs("uploaded_by")),
                createdAt: String(rs("created_at"))
            });
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return items;
}

function SaveMediaRecord(fileName, relativePath, mimeType, sizeBytes, uploadedBy) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    db.Exec("INSERT INTO media (file_name, relative_path, mime_type, size_bytes, uploaded_by, created_at) VALUES (?, ?, ?, ?, ?, datetime('now'))", fileName, relativePath, mimeType, sizeBytes, uploadedBy);

    CloseCmsDb(db);
    return true;
}

function GetMediaById(mediaId) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var rs = db.Query("SELECT id, file_name, relative_path, mime_type, size_bytes, uploaded_by, created_at FROM media WHERE id = ? LIMIT 1", mediaId);
    var item = null;
    if (rs != null) {
        if (!rs.EOF) {
            item = {
                id: ToInt(rs("id"), 0),
                fileName: String(rs("file_name")),
                relativePath: String(rs("relative_path")),
                mimeType: String(rs("mime_type")),
                sizeBytes: ToInt(rs("size_bytes"), 0),
                uploadedBy: String(rs("uploaded_by")),
                createdAt: String(rs("created_at"))
            };
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return item;
}

function DeleteMediaRecord(mediaId) {
    var item = GetMediaById(mediaId);
    if (item == null) {
        return false;
    }

    if (TrimString(item.relativePath) != "") {
        var fso = Server.CreateObject("Scripting.FileSystemObject");
        try {
            var filePath = Server.MapPath(item.relativePath);
            if (fso.FileExists(filePath)) {
                fso.DeleteFile(filePath, true);
            }
        } catch (exDeleteFile) {
        }
        fso = null;
    }

    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    db.Exec("DELETE FROM media WHERE id = ?", mediaId);
    CloseCmsDb(db);
    return true;
}
%>