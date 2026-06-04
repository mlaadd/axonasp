<%@ Language="JScript" %>
<!--#include file="../includes/config.asp" -->
<!--#include file="../includes/helpers.asp" -->
<!--#include file="../includes/i18n.asp" -->
<!--#include file="../includes/db.asp" -->
<!--#include file="../includes/auth.asp" -->
<!--#include file="../models/media_model.asp" -->
<!--#include file="../views/layout.asp" -->
<%
var lang = GetBaseLanguage();
EnsureSchemaAndSeed();
EnsureAdminAuthenticated();

function SafeToString(value) {
    try {
        return String(value);
    } catch (ex) {
        return "";
    }
}

function IsDefinedValue(value) {
    return !(value == null);
}

function GetFileExtension(fileName) {
    var name = SafeToString(fileName);
    var dotPos = name.lastIndexOf(".");
    if (dotPos <= 0 || dotPos >= (name.length - 1)) {
        return "";
    }
    return name.substring(dotPos + 1);
}

function BuildSafeServerBaseName(value) {
    var base = TrimString(SafeToString(value)).toLowerCase();
    base = base.replace(/[^a-z0-9\-_\s]/g, "");
    base = base.replace(/\s+/g, "-");
    base = base.replace(/-+/g, "-");
    base = base.replace(/^-+|-+$/g, "");
    return base;
}

function BuildUniqueRelativePath(relativePath, targetFileName) {
    var sourceRelativePath = SafeToString(relativePath);
    var sourceFileName = "";
    var slashPos = sourceRelativePath.lastIndexOf("/");
    if (slashPos >= 0) {
        sourceFileName = sourceRelativePath.substring(slashPos + 1);
    }
    var relativeDir = "";
    if (slashPos >= 0) {
        relativeDir = sourceRelativePath.substring(0, slashPos + 1);
    }

    var fso = Server.CreateObject("Scripting.FileSystemObject");
    var candidateName = SafeToString(targetFileName);
    var candidateRelativePath = relativeDir + candidateName;
    var candidateAbsolutePath = Server.MapPath(candidateRelativePath);

    var suffix = 1;
    while (fso.FileExists(candidateAbsolutePath) && candidateName.toLowerCase() != sourceFileName.toLowerCase()) {
        var dotPos = targetFileName.lastIndexOf(".");
        if (dotPos > 0) {
            candidateName = targetFileName.substring(0, dotPos) + "-" + suffix + targetFileName.substring(dotPos);
        } else {
            candidateName = targetFileName + "-" + suffix;
        }
        candidateRelativePath = relativeDir + candidateName;
        candidateAbsolutePath = Server.MapPath(candidateRelativePath);
        suffix = suffix + 1;
    }

    fso = null;
    return candidateRelativePath;
}

function FormatSizeMb(sizeBytes) {
    var bytes = ToInt(sizeBytes, 0);
    if (bytes <= 0) {
        return "0.00";
    }
    return (bytes / 1048576).toFixed(2);
}

var flash = "";
var flashClass = "success";

if (IsPostRequest()) {
    var action = TrimString(Request.Form("action"));
    var csrf = TrimString(Request.Form("csrf_token"));

    if (action == "delete") {
        if (!ValidateCsrf(csrf)) {
            flash = T(lang, "csrf_error");
            flashClass = "error";
        } else {
            var deleteId = ToInt(Request.Form("id"), 0);
            if (deleteId > 0 && DeleteMediaRecord(deleteId)) {
                flash = T(lang, "deleted_ok");
                flashClass = "success";
            } else {
                flash = T(lang, "upload_fail");
                flashClass = "error";
            }
        }
    } else if (!IsMultipartRequest()) {
        flash = T(lang, "upload_fail");
        flashClass = "error";
    } else {
        var uploader = Server.CreateObject("G3FILEUPLOADER");
        uploader.MaxFileSize = 8388608;
        uploader.SetUseAllowedOnly(false);
        uploader.PreserveOriginalName = true;
        var desiredServerName = "";

        var token = "";
        try {
            token = TrimString(SafeToString(uploader.Form("csrf_token")));
        } catch (exToken) {
            token = "";
        }
        if (token == "") {
            token = TrimString(Request.Form("csrf_token"));
        }

        try {
            desiredServerName = TrimString(SafeToString(uploader.Form("server_file_name")));
        } catch (exServerName) {
            desiredServerName = TrimString(Request.Form("server_file_name"));
        }

        if (!ValidateCsrf(token)) {
            flash = T(lang, "csrf_error");
            flashClass = "error";
        } else {
            var results = uploader.ProcessAll(G3PIX_UPLOAD_DIR);
            var files = [];

            if (IsDefinedValue(results)) {
                try {
                    if (typeof results.length != "undefined") {
                        files = results;
                    }
                } catch (exLen) {
                    try {
                        files = (new VBArray(results)).toArray();
                    } catch (exArray) {
                        files = [];
                    }
                }
            }

            var successCount = 0;
            var i;
            for (i = 0; i < files.length; i++) {
                var item = files[i];
                if (!IsDefinedValue(item)) {
                    continue;
                }

                var ok = false;
                try {
                    ok = item.Item("IsSuccess");
                } catch (exOk) {
                    ok = false;
                }

                if (ok) {
                    var relativePath = SafeToString(item.Item("RelativePath"));
                    var fileName = SafeToString(item.Item("OriginalFileName"));
                    var mimeType = "";
                    var fileSize = 0;
                    var finalFileName = fileName;
                    var finalRelativePath = relativePath;

                    try {
                        mimeType = SafeToString(item.Item("MimeType"));
                    } catch (exMime) {
                        mimeType = "";
                    }

                    try {
                        fileSize = ToInt(item.Item("Size"), 0);
                    } catch (exSize) {
                        fileSize = 0;
                    }

                    if (desiredServerName != "") {
                        var safeBaseName = BuildSafeServerBaseName(desiredServerName);
                        var originalExt = GetFileExtension(fileName);
                        if (safeBaseName != "") {
                            var candidateFileName = safeBaseName;
                            if (originalExt != "") {
                                candidateFileName = safeBaseName + "." + originalExt;
                            }

                            var targetRelativePath = BuildUniqueRelativePath(relativePath, candidateFileName);
                            if (targetRelativePath.toLowerCase() != relativePath.toLowerCase()) {
                                var fsoRename = Server.CreateObject("Scripting.FileSystemObject");
                                try {
                                    var sourcePath = Server.MapPath(relativePath);
                                    var targetPath = Server.MapPath(targetRelativePath);
                                    if (fsoRename.FileExists(sourcePath)) {
                                        fsoRename.MoveFile(sourcePath, targetPath);
                                        finalRelativePath = targetRelativePath;
                                        var slashPosFinal = finalRelativePath.lastIndexOf("/");
                                        if (slashPosFinal >= 0) {
                                            finalFileName = finalRelativePath.substring(slashPosFinal + 1);
                                        } else {
                                            finalFileName = finalRelativePath;
                                        }
                                    }
                                } catch (exRename) {
                                    finalFileName = fileName;
                                    finalRelativePath = relativePath;
                                }
                                fsoRename = null;
                            }
                        }
                    }

                    SaveMediaRecord(finalFileName, finalRelativePath, mimeType, fileSize, CurrentUserName());
                    successCount = successCount + 1;
                }
            }

            if (successCount > 0) {
                flash = T(lang, "upload_ok") + " (" + successCount + ")";
                flashClass = "success";
            } else {
                flash = T(lang, "upload_fail");
                flashClass = "error";
            }
        }

        uploader = null;
    }
}

var media = ListMediaItems();
RenderAdminHeader(lang, T(lang, "image_upload") + " | " + T(lang, "site_name"), "upload");
%>
<section class="g3pix-content g3pix-form">
    <h1><%=HtmlEncode(T(lang, "image_upload"))%></h1>
    <%
if (flash != "") {
%>
    <div class="g3pix-alert <%=flashClass%>"><%=HtmlEncode(flash)%></div>
    <%
}
%>
    <form method="post" action="<%=HtmlEncode(AppUrl("admin/upload.asp"))%>" enctype="multipart/form-data">
        <input type="hidden" name="action" value="upload">
        <input type="hidden" name="csrf_token" value="<%=HtmlEncode(GetCsrfToken())%>">
        <div class="g3pix-form-grid">
            <div class="full">
                <label><%=HtmlEncode(T(lang, "file"))%></label>
                <input type="file" name="file" required>
            </div>
            <div class="full">
                <label><%=HtmlEncode(T(lang, "server_file_name"))%></label>
                <input type="text" name="server_file_name" maxlength="120"
                    placeholder="<%=HtmlEncode(T(lang, "server_file_name_hint"))%>">
            </div>
        </div>
        <div class="actions-row">
            <button class="btn btn-primary" type="submit"><%=HtmlEncode(T(lang, "upload_file"))%></button>
        </div>
    </form>
</section>

<section class="g3pix-content">
    <h2><%=HtmlEncode(T(lang, "upload_result"))%></h2>
    <div class="g3pix-table-wrap">
        <table class="g3pix-table">
            <thead>
                <tr>
                    <th><%=HtmlEncode(T(lang, "id"))%></th>
                    <th><%=HtmlEncode(T(lang, "file"))%></th>
                    <th><%=HtmlEncode(T(lang, "path"))%></th>
                    <th><%=HtmlEncode(T(lang, "mime"))%></th>
                    <th><%=HtmlEncode(T(lang, "size_mb"))%></th>
                    <th><%=HtmlEncode(T(lang, "user"))%></th>
                    <th><%=HtmlEncode(T(lang, "actions"))%></th>
                </tr>
            </thead>
            <tbody>
                <%
var i;
for (i = 0; i < media.length; i++) {
    var row = media[i];
%>
                <tr>
                    <td><%=row.id%></td>
                    <td><%=HtmlEncode(row.fileName)%></td>
                    <td><a href="<%=HtmlEncode(row.relativePath)%>"
                            target="_blank"><%=HtmlEncode(row.relativePath)%></a></td>
                    <td><%=HtmlEncode(row.mimeType)%></td>
                    <td><%=FormatSizeMb(row.sizeBytes)%></td>
                    <td><%=HtmlEncode(row.uploadedBy)%></td>
                    <td>
                        <form method="post" action="<%=HtmlEncode(AppUrl("admin/upload.asp"))%>">
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