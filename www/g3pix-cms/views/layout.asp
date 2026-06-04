<%@ Language="JScript" %>
<%
function RenderPublicHeader(lang, pageTitle, menuItems, currentSlug, metaDescription) {
    var cssHref = GetAxonCssHref();
    var customCssText = GetCustomCssText();
    var siteTitle = GetSiteTitle();
    var logoUrl = GetSiteLogoUrl();
    var effectiveTitle = String(pageTitle);
    var titleSep = " | ";
    var sepPos = effectiveTitle.lastIndexOf(titleSep);
    if (sepPos >= 0) {
        effectiveTitle = effectiveTitle.substring(0, sepPos) + titleSep + siteTitle;
    }
%>
<!DOCTYPE html>
<html lang="<%=lang%>">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><%=HtmlEncode(effectiveTitle)%></title>
        <%
    if (TrimString(metaDescription) != "") {
%>
        <meta name="description" content="<%=HtmlEncode(metaDescription)%>">
        <%
    }
%>
        <link rel="canonical" href="<%=HtmlEncode(BuildCanonicalUrl())%>">
        <link rel="alternate" type="application/rss+xml" title="<%=HtmlEncode(T(lang, "rss_subscribe"))%>"
            href="<%=HtmlEncode(GetRssFeedUrl())%>">
        <link rel="stylesheet" href="<%=cssHref%>">
        <link rel="stylesheet" href="<%=HtmlEncode(AppUrl("assets/site.css"))%>">
        <%
    if (TrimString(customCssText) != "") {
%>
        <style>
            <%=customCssText%>
        </style>
        <%
    }
%>
    </head>

    <body class="site-bg g3pix-body">
        <header class="site-header">
            <div class="header-inner">
                <a class="brand" href="<%=HtmlEncode(AppUrl("default.asp"))%>">
                    <img src="<%=HtmlEncode(logoUrl)%>" alt="AxonASP">
                    <span><%=HtmlEncode(siteTitle)%></span>
                </a>
                <button class="nav-toggle" id="g3pix-nav-toggle" type="button"><%=HtmlEncode(T(lang, "menu"))%></button>
                <nav class="nav-shell" id="g3pix-nav-shell">
                    <ul class="nav-menu">
                        <%
    if (IsHomeMenuVisible()) {
%>
                        <li><a href="<%=HtmlEncode(AppUrl("default.asp"))%>"
                                class="<%=ActiveClass(currentSlug == "home")%>"><%=HtmlEncode(T(lang, "home"))%></a>
                        </li>
                        <%
    }
    var i;
    for (i = 0; i < menuItems.length; i++) {
        var menu = menuItems[i];
        var href = menu.url;
        if (href == "") {
            href = AppUrl("content.asp") + "?slug=" + Server.URLEncode(menu.pageSlug);
        }
        var activeClass = "";
        if (menu.pageSlug == currentSlug) {
            activeClass = "active";
        }
%>
                        <li><a href="<%=HtmlEncode(href)%>" target="<%=HtmlEncode(menu.target)%>"
                                class="<%=activeClass%>"><%=HtmlEncode(menu.title)%></a></li>
                        <%
    }
    if (IsLoginMenuVisible()) {
%>
                        <li><a href="<%=HtmlEncode(AppUrl("login.asp"))%>"><%=HtmlEncode(T(lang, "login"))%></a></li>
                        <%
    }
    if (IsAdminMenuVisible()) {
%>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/default.asp"))%>"><%=HtmlEncode(T(lang, "admin"))%></a>
                        </li>
                        <%
    }
%>
                    </ul>
                </nav>
            </div>
        </header>
        <main class="main">
            <%
}

function RenderPublicFooter(lang) {
    var snippets = ListActiveJsSnippets();
    var footerText = GetFooterText(lang);
%>
        </main>
        <footer class="g3pix-footer">
            <div class="footer-inner">

                <span><a href="<%=HtmlEncode(LanguageSwitchUrl("en"))%>">EN</a> | <a
                        href="<%=HtmlEncode(LanguageSwitchUrl("pt-BR"))%>">PT-BR</a>
                    <%
    if (IsSitemapMenuVisible()) {
%>
                    <br><a href="<%=HtmlEncode(AppUrl("sitemap.asp"))%>"><%=HtmlEncode(T(lang, "sitemap"))%></a>
                    <%
    }
%></span>
                <span><%=HtmlEncode(footerText)%></span>
                <span class="footer-theme">
                    <label for="themeSelect" class="footer-theme-label"><%=HtmlEncode(T(lang, "theme"))%></label>
                    <select id="themeSelect" class="theme-select" data-theme-select>
                        <option value="auto"><%=HtmlEncode(T(lang, "theme_auto"))%></option>
                        <option value="light"><%=HtmlEncode(T(lang, "theme_light"))%></option>
                        <option value="dark"><%=HtmlEncode(T(lang, "theme_dark"))%></option>
                    </select>
                </span>
            </div>
        </footer>
        <%
    var i;
    for (i = 0; i < snippets.length; i++) {
        var snippet = snippets[i];
        if (TrimString(snippet.code) != "") {
%>
        <script>
<%=snippet.code %>
        </script>
        <%
        }
    }
%>
        <script src="<%=HtmlEncode(AppUrl("assets/site.js"))%>"></script>
    </body>

</html>
<%
}

function RenderAdminHeader(lang, pageTitle, sectionKey) {
    var cssHref = GetAxonCssHref();
    var siteTitle = GetSiteTitle();
    var logoUrl = GetSiteLogoUrl();
    var effectiveTitle = String(pageTitle);
    var titleSep = " | ";
    var sepPos = effectiveTitle.lastIndexOf(titleSep);
    if (sepPos >= 0) {
        effectiveTitle = effectiveTitle.substring(0, sepPos) + titleSep + siteTitle;
    }
%>
<!DOCTYPE html>
<html lang="<%=lang%>">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><%=HtmlEncode(effectiveTitle)%></title>
        <link rel="canonical" href="<%=HtmlEncode(BuildCanonicalUrl())%>">
        <link rel="alternate" type="application/rss+xml" title="<%=HtmlEncode(T(lang, "rss_subscribe"))%>"
            href="<%=HtmlEncode(GetRssFeedUrl())%>">
        <link rel="stylesheet" href="<%=cssHref%>">
        <link rel="stylesheet" href="<%=HtmlEncode(AppUrl("assets/site.css"))%>">
    </head>

    <body class="site-bg g3pix-admin-body">
        <header class="site-header">
            <div class="header-inner">
                <a class="brand" href="<%=HtmlEncode(AppUrl("admin/default.asp"))%>">
                    <img src="<%=HtmlEncode(logoUrl)%>" alt="AxonASP">
                    <span><%=HtmlEncode(siteTitle)%></span>
                </a>
                <nav class="nav-shell is-open">
                    <ul class="nav-menu">
                        <li><a href="<%=HtmlEncode(AppUrl("admin/default.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "dashboard")%>"><%=HtmlEncode(T(lang, "dashboard"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/pages.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "pages")%>"><%=HtmlEncode(T(lang, "page_management"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/components.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "components")%>"><%=HtmlEncode(T(lang, "component_management"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/users.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "users")%>"><%=HtmlEncode(T(lang, "users"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/menu.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "menu")%>"><%=HtmlEncode(T(lang, "menu_management"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/change-password.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "change-password")%>"><%=HtmlEncode(T(lang, "change_password"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/upload.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "upload")%>"><%=HtmlEncode(T(lang, "image_upload"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/css-editor.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "css-editor")%>"><%=HtmlEncode(T(lang, "css_editor"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/js-snippets.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "js-snippets")%>"><%=HtmlEncode(T(lang, "js_snippets"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("admin/site-settings.asp"))%>"
                                class="<%=ActiveClass(sectionKey == "site-settings")%>"><%=HtmlEncode(T(lang, "site_settings"))%></a>
                        </li>
                        <li><a href="<%=HtmlEncode(AppUrl("logout.asp"))%>"><%=HtmlEncode(T(lang, "logout"))%></a></li>
                    </ul>
                </nav>
            </div>
        </header>
        <main class="main">
            <%
}

function RenderAdminFooter() {
    var siteTitle = GetSiteTitle();
%>
        </main>
        <footer class="g3pix-footer">
            <div class="footer-inner">
                <span><%=HtmlEncode(siteTitle)%></span>
                <span class="footer-theme">
                    <label for="themeSelect" class="footer-theme-label"><%=HtmlEncode(T(lang, "theme"))%></label>
                    <select id="themeSelect" class="theme-select" data-theme-select>
                        <option value="auto"><%=HtmlEncode(T(lang, "theme_auto"))%></option>
                        <option value="light"><%=HtmlEncode(T(lang, "theme_light"))%></option>
                        <option value="dark"><%=HtmlEncode(T(lang, "theme_dark"))%></option>
                    </select>
                </span>
            </div>
        </footer>
        <script src="<%=HtmlEncode(AppUrl("assets/site.js"))%>"></script>
    </body>

</html>
<%
}
%>