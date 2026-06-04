<%@ Language="JScript" %>
<%
function TrimString(value) {
    if (value == null) {
        return "";
    }
    var str = String(value);
    if (str == "") {
        return "";
    }
    return str.replace(/^\s+|\s+$/g, "");
}

function SafeToString(value) {
    if (value == null) {
        return "";
    }
    return String(value);
}

function HtmlEncode(value) {
    var encodedValue = "";
    if (value != null) {
        encodedValue = String(value);
    }
    return Server.HTMLEncode(encodedValue);
}

function ToInt(value, fallback) {
    var n = parseInt(value, 10);
    if (isNaN(n)) {
        return fallback;
    }
    return n;
}

function IsPostRequest() {
    var method = String(Request.ServerVariables("REQUEST_METHOD"));
    return method.toUpperCase() == "POST";
}

function IsMultipartRequest() {
    var contentType = String(Request.ServerVariables("CONTENT_TYPE"));
    return contentType.toLowerCase().indexOf("multipart/form-data") >= 0;
}

function GetAppRootPath() {
    var root = "/g3pix";
    try {
        if (typeof G3PIX_ROOT_PATH != "undefined") {
            root = TrimString(String(G3PIX_ROOT_PATH));
        }
    } catch (exRoot) {
        root = "/g3pix";
    }

    if (root == "" || root == "/") {
        return "";
    }

    if (root.charAt(0) != "/") {
        root = "/" + root;
    }

    root = root.replace(/\/+$/g, "");
    return root;
}

function AppUrl(relativePath) {
    var value = TrimString(relativePath);
    if (value.indexOf("http://") == 0 || value.indexOf("https://") == 0 || value.indexOf("//") == 0) {
        return value;
    }

    var root = GetAppRootPath();
    if (value == "") {
        if (root == "") {
            return "/";
        }
        return root;
    }

    if (value.charAt(0) == "/") {
        value = value.substring(1);
    }

    if (root == "") {
        return "/" + value;
    }
    return root + "/" + value;
}

function IsAppPath(value) {
    var path = TrimString(value);
    if (path == "") {
        return false;
    }

    var root = GetAppRootPath();
    if (root == "") {
        return path.charAt(0) == "/";
    }

    var lowerPath = path.toLowerCase();
    var lowerRoot = root.toLowerCase();
    return lowerPath == lowerRoot || lowerPath.indexOf(lowerRoot + "/") == 0;
}

function SafeSlug(value) {
    var slug = TrimString(value).toLowerCase();
    slug = slug.replace(/[^a-z0-9\s\-]/g, "");
    slug = slug.replace(/\s+/g, "-");
    slug = slug.replace(/\-+/g, "-");
    slug = slug.replace(/^\-+|\-+$/g, "");
    if (slug == "") {
        slug = "page-" + String(new Date().getTime());
    }
    return slug;
}

function NormalizeLanguageCode(value, fallbackLang) {
    var fallbackValue = TrimString(fallbackLang);
    if (fallbackValue != "" && fallbackValue != "pt-BR" && fallbackValue != "en") {
        fallbackValue = "en";
    }

    var normalized = TrimString(value);
    // Explicitly handle "null" string coercion bug in JScript engine for empty collections
    if (normalized == "" || normalized == "null") {
        return fallbackValue;
    }

    var lower = normalized.toLowerCase();
    if (lower == "pt-br" || lower == "pt_br") {
        return "pt-BR";
    }
    if (lower == "en" || lower == "en-us" || lower == "en_us" || lower == "en-gb" || lower == "en_gb") {
        return "en";
    }
    if (lower.indexOf("pt") == 0) {
        return "pt-BR";
    }
    if (lower.indexOf("en") == 0) {
        return "en";
    }

    return fallbackValue;
}

function GetLanguageFromBrowser(defaultLang) {
    var browserLang = "";
    try {
        browserLang = TrimString(Request.ServerVariables("HTTP_ACCEPT_LANGUAGE"));
    } catch (exBrowserLang) {
        browserLang = "";
    }

    if (browserLang == "") {
        return NormalizeLanguageCode("", defaultLang);
    }

    var parts = browserLang.split(",");
    var i;
    for (i = 0; i < parts.length; i++) {
        var token = TrimString(parts[i]);
        if (token == "") {
            continue;
        }
        var semicolonPos = token.indexOf(";");
        if (semicolonPos >= 0) {
            token = TrimString(token.substring(0, semicolonPos));
        }
        var mapped = NormalizeLanguageCode(token, "");
        if (mapped == "pt-BR" || mapped == "en") {
            return mapped;
        }
    }

    return NormalizeLanguageCode("", defaultLang);
}

function SaveLanguageCookie(lang) {
    try {
        var d = new Date(new Date().getTime() + (365 * 24 * 60 * 60 * 1000));
        Response.Cookies("g3pix_lang") = lang;
        Response.Cookies("g3pix_lang").Path = "/";
        Response.Cookies("g3pix_lang").Expires = d.toUTCString();
    } catch (exCookie) {
    }
}

function ReadLanguageCookie() {
    var cookieVal = "";
    try {
        cookieVal = TrimString(Request.Cookies("g3pix_lang"));
    } catch (exCookieRead) {
        cookieVal = "";
    }
    return NormalizeLanguageCode(cookieVal, "");
}

function GetBaseLanguage() {
    var defaultLang = NormalizeLanguageCode(GetSettingValue("default_locale", "en"), "en");
    var userSet = false;
    var lang = NormalizeLanguageCode(Request.QueryString("lang"), "");
    if (lang != "") {
        userSet = true;
    }

    var sessionLang = "";
    try {
        sessionLang = SafeToString(Session("g3pix_lang"));
    } catch (exSess) {
        sessionLang = "";
    }
    var sessionNormalized = NormalizeLanguageCode(sessionLang, "");

    if (lang == "") {
        if (sessionNormalized != "") {
            lang = sessionNormalized;
        }
    }
    if (lang == "") {
        lang = ReadLanguageCookie();
    }
    if (lang == "") {
        lang = GetLanguageFromBrowser(defaultLang);
    }
    if (lang == "") {
        lang = defaultLang;
    }

    // Only persist when the user explicitly chose, or when no language is stored yet.
    if (userSet || sessionNormalized == "") {
        try {
            Session("g3pix_lang") = lang;
        } catch (exSessSet) {
        }
    }

    if (userSet) {
        SaveLanguageCookie(lang);
    }

    return lang;
}

function RedirectTo(url) {
    Response.Redirect(url);
    Response.End();
}

function IsEmptyObject(value) {
    if (value == null || value == "") {
        return true;
    }
    return false;
}

function NewDictionary() {
    return Server.CreateObject("Scripting.Dictionary");
}

function ActiveClass(conditionValue) {
    if (conditionValue) {
        return "active";
    }
    return "";
}

function SelectedAttr(conditionValue) {
    if (conditionValue) {
        return "selected";
    }
    return "";
}

function YesNoText(conditionValue) {
    if (conditionValue) {
        return "yes";
    }
    return "no";
}

function GetSettingValue(settingKey, fallbackValue) {
    var value = fallbackValue;
    if (typeof OpenCmsDb == "undefined") {
        return value;
    }

    var db = OpenCmsDb();
    if (db == null) {
        return value;
    }

    var rs = db.Query("SELECT setting_value FROM settings WHERE setting_key = ? LIMIT 1", settingKey);
    if (rs != null) {
        if (!rs.EOF) {
            value = String(rs("setting_value"));
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return value;
}

function SaveSettingValue(settingKey, settingValue) {
    if (typeof OpenCmsDb == "undefined") {
        return false;
    }

    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    db.Exec("INSERT OR REPLACE INTO settings (setting_key, setting_value) VALUES (?, ?)", settingKey, String(settingValue));
    CloseCmsDb(db);
    return true;
}

function GetCustomCssText() {
    return GetSettingValue("custom_css", "");
}

function GetSiteTitle() {
    return TrimString(GetSettingValue("site_title", G3PIX_APP_NAME));
}

function GetSiteLogoUrl() {
    var logoUrl = TrimString(GetSettingValue("site_logo_url", "/logo_square.svg"));
    if (logoUrl == "") {
        logoUrl = "/logo_square.svg";
    }
    if (logoUrl.indexOf("http://") == 0 || logoUrl.indexOf("https://") == 0 || logoUrl.indexOf("//") == 0) {
        return logoUrl;
    }
    if (logoUrl.charAt(0) == "/") {
        return logoUrl;
    }
    return AppUrl(logoUrl);
}

function GetFooterText(lang) {
    var fallback = T(lang, "powered_footer");
    return TrimString(GetSettingValue("footer_text", fallback));
}

function IsSearchEnabled() {
    var flag = ToInt(GetSettingValue("show_search", "1"), 1);
    return flag == 1;
}

function BuildSiteBaseUrl() {
    var scheme = "http";
    try {
        var portSecure = TrimString(Request.ServerVariables("SERVER_PORT_SECURE"));
        if (portSecure == "1") {
            scheme = "https";
        }
    } catch (exSecure) {
        scheme = "http";
    }

    var host = "localhost";
    try {
        host = TrimString(Request.ServerVariables("HTTP_HOST"));
        if (host == "") {
            host = TrimString(Request.ServerVariables("SERVER_NAME"));
        }
    } catch (exHost) {
        host = "localhost";
    }
    if (host == "") {
        host = "localhost";
    }

    var root = GetAppRootPath();
    var baseUrl = scheme + "://" + host;
    if (root != "") {
        baseUrl = baseUrl + root;
    }
    return baseUrl;
}

function BuildCanonicalUrl() {
    var baseUrl = BuildSiteBaseUrl();
    var scriptName = "";
    try {
        scriptName = TrimString(Request.ServerVariables("SCRIPT_NAME"));
    } catch (exScript) {
        scriptName = "";
    }
    if (scriptName == "") {
        return baseUrl + "/";
    }
    return baseUrl + scriptName;
}

function GetRssFeedUrl() {
    return AppUrl("rss.asp");
}

function XmlEscape(value) {
    var str = String(value);
    str = str.replace(/&/g, "&amp;");
    str = str.replace(/</g, "&lt;");
    str = str.replace(/>/g, "&gt;");
    str = str.replace(/"/g, "&quot;");
    str = str.replace(/'/g, "&apos;");
    return str;
}

function ListRssItems(lang, limit) {
    var pageSize = ToInt(limit, 20);
    if (pageSize < 1) {
        pageSize = 20;
    }
    if (pageSize > 100) {
        pageSize = 100;
    }
    var result = ListPublishedContentPaged(lang, "", 1, pageSize, "all");
    return result.items;
}

function IsHomeMenuVisible() {
    return ToInt(GetSettingValue("show_home_menu", "1"), 1) == 1;
}

function IsLoginMenuVisible() {
    return ToInt(GetSettingValue("show_login_menu", "1"), 1) == 1;
}

function IsAdminMenuVisible() {
    return ToInt(GetSettingValue("show_admin_menu", "1"), 1) == 1;
}

function IsSitemapMenuVisible() {
    return ToInt(GetSettingValue("show_sitemap_menu", "1"), 1) == 1;
}

function LanguageSwitchUrl(langCode) {
    var currentScript = "";
    try {
        currentScript = TrimString(Request.ServerVariables("SCRIPT_NAME"));
    } catch (exScript) {
        currentScript = "";
    }
    if (currentScript == "") {
        currentScript = AppUrl("default.asp");
    }
    return currentScript + "?lang=" + Server.URLEncode(langCode);
}

function ListActiveJsSnippets() {
    var snippets = [];
    if (typeof OpenCmsDb == "undefined") {
        return snippets;
    }

    var db = OpenCmsDb();
    if (db == null) {
        return snippets;
    }

    var rs = db.Query("SELECT id, name, code, sort_order FROM js_snippets WHERE is_active = 1 ORDER BY sort_order ASC, id ASC");
    if (rs != null) {
        while (!rs.EOF) {
            snippets.push({
                id: ToInt(rs("id"), 0),
                name: String(rs("name")),
                code: String(rs("code")),
                sortOrder: ToInt(rs("sort_order"), 0)
            });
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return snippets;
}
%>