<%@ Language="JScript" %>
<%
function FindUserByUsername(username) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var rs = db.Query("SELECT id, username, password_hash, display_name, is_active, role, must_change_password FROM users WHERE username = ? LIMIT 1", username);
    var user = null;

    if (rs != null && rs != "") {
        if (!rs.EOF) {
            user = {
                id: rs("id"),
                username: String(rs("username")),
                passwordHash: String(rs("password_hash")),
                displayName: String(rs("display_name")),
                isActive: ToInt(rs("is_active"), 0),
                role: String(rs("role")),
                mustChangePassword: ToInt(rs("must_change_password"), 0)
            };
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return user;
}

function VerifyUserCredentials(username, password) {
    var user = FindUserByUsername(username);
    if (user == null) {
        return null;
    }

    if (user.isActive != 1) {
        return null;
    }

    var crypto = Server.CreateObject("G3CRYPTO");
    var isValid = crypto.VerifyPassword(password, user.passwordHash);
    crypto = null;

    if (!isValid) {
        return null;
    }

    return user;
}

function GetUserById(userId) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var rs = db.Query("SELECT id, username, display_name, is_active, role, must_change_password, created_at FROM users WHERE id = ? LIMIT 1", userId);
    var user = null;
    if (rs != null && rs != "") {
        if (!rs.EOF) {
            user = {
                id: rs("id"),
                username: String(rs("username")),
                displayName: String(rs("display_name")),
                isActive: ToInt(rs("is_active"), 0),
                role: String(rs("role")),
                mustChangePassword: ToInt(rs("must_change_password"), 0),
                createdAt: String(rs("created_at"))
            };
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return user;
}

function ListUsers() {
    var db = OpenCmsDb();
    var items = [];
    if (db == null) {
        return items;
    }

    var rs = db.Query("SELECT id, username, display_name, is_active, role, must_change_password, created_at FROM users ORDER BY id ASC");
    if (rs != null && rs != "") {
        while (!rs.EOF) {
            items.push({
                id: rs("id"),
                username: String(rs("username")),
                displayName: String(rs("display_name")),
                isActive: ToInt(rs("is_active"), 0),
                role: String(rs("role")),
                mustChangePassword: ToInt(rs("must_change_password"), 0),
                createdAt: String(rs("created_at"))
            });
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return items;
}

function CreateUser(username, displayName, password, role, mustChangePassword) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    var crypto = Server.CreateObject("G3CRYPTO");
    var passwordHash = crypto.HashPassword(password);
    crypto = null;

    db.Exec("INSERT INTO users (username, password_hash, display_name, is_active, role, must_change_password, created_at) VALUES (?, ?, ?, ?, ?, ?, datetime('now'))", username, passwordHash, displayName, 1, role, mustChangePassword);
    CloseCmsDb(db);
    return true;
}

function UpdateUserPassword(userId, password, mustChangePassword) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    var crypto = Server.CreateObject("G3CRYPTO");
    var passwordHash = crypto.HashPassword(password);
    crypto = null;

    db.Exec("UPDATE users SET password_hash = ?, must_change_password = ? WHERE id = ?", passwordHash, mustChangePassword, userId);
    CloseCmsDb(db);
    return true;
}

function UpdateCurrentUserPassword(userId, password) {
    return UpdateUserPassword(userId, password, 0);
}
%>