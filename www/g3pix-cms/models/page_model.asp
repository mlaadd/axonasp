<%@ Language="JScript" %>
<%
function NormalizePageType(value) {
    var pageType = TrimString(value).toLowerCase();
    if (pageType != "post" && pageType != "block" && pageType != "home") {
        pageType = "page";
    }
    return pageType;
}

function NormalizeHomeMode(value) {
    var homeMode = TrimString(value).toLowerCase();
    if (homeMode != "posts" && homeMode != "pages" && homeMode != "linked" && homeMode != "none") {
        homeMode = "all";
    }
    return homeMode;
}

function GetPageSelectSql() {
    return "SELECT p.id, p.slug, p.title, p.excerpt, p.content, p.status, p.locale, p.is_home, p.page_type, p.parent_id, COALESCE(parent.title, '') AS parent_title, p.sort_order, p.home_mode, p.home_section_title, p.seo_title, p.meta_description, p.created_at, p.updated_at FROM pages p LEFT JOIN pages parent ON parent.id = p.parent_id";
}

function ReadPageRecord(rs) {
    return {
        id: ToInt(rs("id"), 0),
        slug: String(rs("slug")),
        title: String(rs("title")),
        excerpt: String(rs("excerpt")),
        content: String(rs("content")),
        status: String(rs("status")),
        locale: String(rs("locale")),
        isHome: ToInt(rs("is_home"), 0),
        pageType: NormalizePageType(rs("page_type")),
        parentId: ToInt(rs("parent_id"), 0),
        parentTitle: String(rs("parent_title")),
        sortOrder: ToInt(rs("sort_order"), 0),
        homeMode: NormalizeHomeMode(rs("home_mode")),
        homeSectionTitle: String(rs("home_section_title")),
        seoTitle: String(rs("seo_title")),
        metaDescription: String(rs("meta_description")),
        createdAt: String(rs("created_at")),
        updatedAt: String(rs("updated_at"))
    };
}

function BuildPageSearchFilter(searchQuery) {
    var filter = "";
    if (TrimString(searchQuery) != "") {
        filter = " AND (LOWER(title) LIKE ? OR LOWER(excerpt) LIKE ? OR LOWER(content) LIKE ?)";
    }
    return filter;
}

function BuildPageSearchParams(searchQuery) {
    var params = [];
    var normalizedQuery = TrimString(searchQuery).toLowerCase();
    if (normalizedQuery != "") {
        params.push("%" + normalizedQuery + "%");
        params.push("%" + normalizedQuery + "%");
        params.push("%" + normalizedQuery + "%");
    }
    return params;
}

function RenderContentWithShortcodes(content, lang, depth) {
    var html = String(content);
    if (TrimString(html) == "") {
        return "";
    }

    if (depth > 4) {
        return html;
    }

    return html.replace(/\[(g3pix-(?:page|part|post))\s+slug="([^"]+)"\]/gi, function (fullMatch, shortcodeName, shortcodeSlug) {
        var included = GetReusableContentBySlug(shortcodeSlug, lang, depth + 1);
        if (included == null) {
            return "";
        }
        return included.content;
    });
}

function GetReusableContentBySlug(slug, lang, depth) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var rs = db.Query("SELECT p.id, p.slug, p.title, p.excerpt, p.content, p.status, p.locale, p.is_home, p.page_type, p.parent_id, COALESCE(parent.title, '') AS parent_title, p.sort_order, p.home_mode, p.home_section_title, p.seo_title, p.meta_description, p.created_at, p.updated_at FROM pages p LEFT JOIN pages parent ON parent.id = p.parent_id WHERE p.slug = ? AND p.status = 'published' AND (p.page_type = 'block' OR p.page_type = 'page' OR p.page_type = 'post' OR p.page_type = 'home') ORDER BY CASE WHEN p.locale = ? THEN 0 WHEN p.locale = 'en' THEN 1 ELSE 2 END, datetime(p.updated_at) DESC LIMIT 1", slug, lang);
    var page = null;

    if (rs != null && rs != "") {
        if (!rs.EOF) {
            page = ReadPageRecord(rs);
            page.content = RenderContentWithShortcodes(page.content, lang, depth);
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return page;
}

function GetPageBySlugInternal(slug, lang, includeBlocks) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var allowBlocks = 0;
    if (includeBlocks) {
        allowBlocks = 1;
    }

    var rs = db.Query("SELECT p.id, p.slug, p.title, p.excerpt, p.content, p.status, p.locale, p.is_home, p.page_type, p.parent_id, COALESCE(parent.title, '') AS parent_title, p.sort_order, p.home_mode, p.home_section_title, p.seo_title, p.meta_description, p.created_at, p.updated_at FROM pages p LEFT JOIN pages parent ON parent.id = p.parent_id WHERE p.slug = ? AND p.status = 'published' AND (? = 1 OR p.page_type <> 'block') ORDER BY CASE WHEN p.locale = ? THEN 0 WHEN p.locale = 'en' THEN 1 ELSE 2 END, datetime(p.updated_at) DESC LIMIT 1", slug, allowBlocks, lang);
    var page = null;

    if (rs != null && rs != "") {
        if (!rs.EOF) {
            page = ReadPageRecord(rs);
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return page;
}

function GetHomePage(lang) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var rs = db.Query("SELECT p.id, p.slug, p.title, p.excerpt, p.content, p.status, p.locale, p.is_home, p.page_type, p.parent_id, COALESCE(parent.title, '') AS parent_title, p.sort_order, p.home_mode, p.home_section_title, p.seo_title, p.meta_description, p.created_at, p.updated_at FROM pages p LEFT JOIN pages parent ON parent.id = p.parent_id WHERE p.status = 'published' AND p.is_home = 1 ORDER BY CASE WHEN p.locale = ? THEN 0 WHEN p.locale = 'en' THEN 1 ELSE 2 END, datetime(p.updated_at) DESC LIMIT 1", lang);
    var page = null;

    if (rs != null && rs != "") {
        if (!rs.EOF) {
            page = ReadPageRecord(rs);
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return page;
}

function GetPageBySlug(slug, lang) {
    return GetPageBySlugInternal(slug, lang, false);
}

function GetContentBySlug(slug, lang) {
    return GetPageBySlugInternal(slug, lang, true);
}

function GetPageById(pageId) {
    var db = OpenCmsDb();
    if (db == null) {
        return null;
    }

    var rs = db.Query("SELECT p.id, p.slug, p.title, p.excerpt, p.content, p.status, p.locale, p.is_home, p.page_type, p.parent_id, COALESCE(parent.title, '') AS parent_title, p.sort_order, p.home_mode, p.home_section_title, p.seo_title, p.meta_description, p.created_at, p.updated_at FROM pages p LEFT JOIN pages parent ON parent.id = p.parent_id WHERE p.id = ? LIMIT 1", pageId);
    var page = null;

    if (rs != null && rs != "") {
        if (!rs.EOF) {
            page = ReadPageRecord(rs);
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return page;
}

function ListChildPages(parentId, lang) {
    var db = OpenCmsDb();
    var items = [];
    if (db == null) {
        return items;
    }

    var rs = db.Query("SELECT p.id, p.slug, p.title, p.excerpt, p.content, p.status, p.locale, p.is_home, p.page_type, p.parent_id, COALESCE(parent.title, '') AS parent_title, p.sort_order, p.home_mode, p.home_section_title, p.seo_title, p.meta_description, p.created_at, p.updated_at FROM pages p LEFT JOIN pages parent ON parent.id = p.parent_id WHERE p.status = 'published' AND p.parent_id = ? AND p.page_type <> 'block' ORDER BY CASE WHEN p.locale = ? THEN 0 WHEN p.locale = 'en' THEN 1 ELSE 2 END, p.sort_order ASC, datetime(p.updated_at) DESC, p.title ASC", parentId, lang);
    if (rs != null && rs != "") {
        while (!rs.EOF) {
            items.push(ReadPageRecord(rs));
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return items;
}

function CountPublishedPages(lang, searchQuery) {
    return CountPublishedContent(lang, searchQuery, "all");
}

function CountPublishedContent(lang, searchQuery, contentMode) {
    var db = OpenCmsDb();
    var totalCount = 0;
    if (db == null) {
        return totalCount;
    }

    var normalizedMode = NormalizeHomeMode(contentMode);
    var normalizedSearch = TrimString(searchQuery).toLowerCase();
    var rs = null;

    if (normalizedMode == "linked") {
        if (normalizedSearch == "") {
            rs = db.Query("SELECT COUNT(DISTINCT p.id) AS total_count FROM pages p INNER JOIN menus m ON m.page_slug = p.slug WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type <> 'block' AND m.is_visible = 1 AND (m.locale = ? OR m.locale = 'en') AND (p.locale = ? OR p.locale = 'en')", lang, lang);
        } else {
            var linkedSearchValue = "%" + normalizedSearch + "%";
            rs = db.Query("SELECT COUNT(DISTINCT p.id) AS total_count FROM pages p INNER JOIN menus m ON m.page_slug = p.slug WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type <> 'block' AND m.is_visible = 1 AND (m.locale = ? OR m.locale = 'en') AND (p.locale = ? OR p.locale = 'en') AND (LOWER(p.title) LIKE ? OR LOWER(p.excerpt) LIKE ? OR LOWER(p.content) LIKE ?)", lang, lang, linkedSearchValue, linkedSearchValue, linkedSearchValue);
        }
    } else if (normalizedMode == "posts") {
        if (normalizedSearch == "") {
            rs = db.Query("SELECT COUNT(1) AS total_count FROM pages p WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type = 'post' AND (p.locale = ? OR p.locale = 'en')", lang);
        } else {
            var postSearchValue = "%" + normalizedSearch + "%";
            rs = db.Query("SELECT COUNT(1) AS total_count FROM pages p WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type = 'post' AND (p.locale = ? OR p.locale = 'en') AND (LOWER(p.title) LIKE ? OR LOWER(p.excerpt) LIKE ? OR LOWER(p.content) LIKE ?)", lang, postSearchValue, postSearchValue, postSearchValue);
        }
    } else if (normalizedMode == "pages") {
        if (normalizedSearch == "") {
            rs = db.Query("SELECT COUNT(1) AS total_count FROM pages p WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type = 'page' AND (p.locale = ? OR p.locale = 'en')", lang);
        } else {
            var pageSearchValue = "%" + normalizedSearch + "%";
            rs = db.Query("SELECT COUNT(1) AS total_count FROM pages p WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type = 'page' AND (p.locale = ? OR p.locale = 'en') AND (LOWER(p.title) LIKE ? OR LOWER(p.excerpt) LIKE ? OR LOWER(p.content) LIKE ?)", lang, pageSearchValue, pageSearchValue, pageSearchValue);
        }
    } else {
        if (normalizedSearch == "") {
            rs = db.Query("SELECT COUNT(1) AS total_count FROM pages p WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type <> 'block' AND (p.locale = ? OR p.locale = 'en')", lang);
        } else {
            var allSearchValue = "%" + normalizedSearch + "%";
            rs = db.Query("SELECT COUNT(1) AS total_count FROM pages p WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type <> 'block' AND (p.locale = ? OR p.locale = 'en') AND (LOWER(p.title) LIKE ? OR LOWER(p.excerpt) LIKE ? OR LOWER(p.content) LIKE ?)", lang, allSearchValue, allSearchValue, allSearchValue);
        }
    }

    if (rs != null && rs != "") {
        if (!rs.EOF) {
            totalCount = ToInt(rs("total_count"), 0);
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return totalCount;
}

function ListPublishedPages(lang, limit) {
    var result = ListPublishedContentPaged(lang, "", 1, limit, "all");
    return result.items;
}

function ListPublishedPagesPaged(lang, searchQuery, pageNumber, pageSize) {
    return ListPublishedContentPaged(lang, searchQuery, pageNumber, pageSize, "all");
}

function ListPublishedContentPaged(lang, searchQuery, pageNumber, pageSize, contentMode) {
    var db = OpenCmsDb();
    var items = [];
    var totalCount = 0;
    var totalPages = 0;
    if (db == null) {
        return { items: items, totalCount: totalCount, totalPages: totalPages, pageNumber: pageNumber, pageSize: pageSize };
    }

    var normalizedMode = NormalizeHomeMode(contentMode);
    totalCount = CountPublishedContent(lang, searchQuery, normalizedMode);
    if (pageSize < 1) {
        pageSize = 1;
    }
    if (pageNumber < 1) {
        pageNumber = 1;
    }

    totalPages = Math.ceil(totalCount / pageSize);
    if (totalPages < 1) {
        totalPages = 1;
    }

    var offset = (pageNumber - 1) * pageSize;
    var normalizedSearch = TrimString(searchQuery).toLowerCase();
    var rs = null;

    if (normalizedMode == "linked") {
        if (normalizedSearch == "") {
            rs = db.Query(GetPageSelectSql() + " INNER JOIN menus m ON m.page_slug = p.slug WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type <> 'block' AND m.is_visible = 1 AND (m.locale = ? OR m.locale = 'en') AND (p.locale = ? OR p.locale = 'en') GROUP BY p.id ORDER BY MIN(m.sort_order) ASC, p.sort_order ASC, datetime(p.updated_at) DESC LIMIT ? OFFSET ?", lang, lang, pageSize, offset);
        } else {
            var linkedSearchValue = "%" + normalizedSearch + "%";
            rs = db.Query(GetPageSelectSql() + " INNER JOIN menus m ON m.page_slug = p.slug WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type <> 'block' AND m.is_visible = 1 AND (m.locale = ? OR m.locale = 'en') AND (p.locale = ? OR p.locale = 'en') AND (LOWER(p.title) LIKE ? OR LOWER(p.excerpt) LIKE ? OR LOWER(p.content) LIKE ?) GROUP BY p.id ORDER BY MIN(m.sort_order) ASC, p.sort_order ASC, datetime(p.updated_at) DESC LIMIT ? OFFSET ?", lang, lang, linkedSearchValue, linkedSearchValue, linkedSearchValue, pageSize, offset);
        }
    } else if (normalizedMode == "posts") {
        if (normalizedSearch == "") {
            rs = db.Query(GetPageSelectSql() + " WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type = 'post' AND (p.locale = ? OR p.locale = 'en') ORDER BY p.sort_order ASC, datetime(p.updated_at) DESC LIMIT ? OFFSET ?", lang, pageSize, offset);
        } else {
            var postSearchValue = "%" + normalizedSearch + "%";
            rs = db.Query(GetPageSelectSql() + " WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type = 'post' AND (p.locale = ? OR p.locale = 'en') AND (LOWER(p.title) LIKE ? OR LOWER(p.excerpt) LIKE ? OR LOWER(p.content) LIKE ?) ORDER BY p.sort_order ASC, datetime(p.updated_at) DESC LIMIT ? OFFSET ?", lang, postSearchValue, postSearchValue, postSearchValue, pageSize, offset);
        }
    } else if (normalizedMode == "pages") {
        if (normalizedSearch == "") {
            rs = db.Query(GetPageSelectSql() + " WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type = 'page' AND (p.locale = ? OR p.locale = 'en') ORDER BY p.sort_order ASC, datetime(p.updated_at) DESC LIMIT ? OFFSET ?", lang, pageSize, offset);
        } else {
            var pageSearchValue = "%" + normalizedSearch + "%";
            rs = db.Query(GetPageSelectSql() + " WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type = 'page' AND (p.locale = ? OR p.locale = 'en') AND (LOWER(p.title) LIKE ? OR LOWER(p.excerpt) LIKE ? OR LOWER(p.content) LIKE ?) ORDER BY p.sort_order ASC, datetime(p.updated_at) DESC LIMIT ? OFFSET ?", lang, pageSearchValue, pageSearchValue, pageSearchValue, pageSize, offset);
        }
    } else {
        if (normalizedSearch == "") {
            rs = db.Query(GetPageSelectSql() + " WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type <> 'block' AND (p.locale = ? OR p.locale = 'en') ORDER BY p.sort_order ASC, datetime(p.updated_at) DESC LIMIT ? OFFSET ?", lang, pageSize, offset);
        } else {
            var allSearchValue = "%" + normalizedSearch + "%";
            rs = db.Query(GetPageSelectSql() + " WHERE p.status = 'published' AND p.is_home = 0 AND p.page_type <> 'block' AND (p.locale = ? OR p.locale = 'en') AND (LOWER(p.title) LIKE ? OR LOWER(p.excerpt) LIKE ? OR LOWER(p.content) LIKE ?) ORDER BY p.sort_order ASC, datetime(p.updated_at) DESC LIMIT ? OFFSET ?", lang, allSearchValue, allSearchValue, allSearchValue, pageSize, offset);
        }
    }

    if (rs != null && rs != "") {
        while (!rs.EOF) {
            items.push(ReadPageRecord(rs));
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return { items: items, totalCount: totalCount, totalPages: totalPages, pageNumber: pageNumber, pageSize: pageSize };
}

function AdminListPages() {
    var db = OpenCmsDb();
    var items = [];
    if (db == null) {
        return items;
    }

    var rs = db.Query(GetPageSelectSql() + " ORDER BY p.is_home DESC, p.sort_order ASC, datetime(p.updated_at) DESC, p.title ASC");
    if (rs != null && rs != "") {
        while (!rs.EOF) {
            items.push(ReadPageRecord(rs));
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return items;
}

function SavePage(pageId, slug, title, excerpt, content, status, locale, isHome, pageType, parentId, sortOrder, homeMode, homeSectionTitle, seoTitle, metaDescription) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    var normalizedPageType = NormalizePageType(pageType);
    var normalizedHomeMode = NormalizeHomeMode(homeMode);
    if (pageId <= 0 && normalizedPageType == "home") {
        isHome = 1;
    }
    if (isHome == 1 || normalizedPageType == "home") {
        isHome = 1;
        normalizedPageType = "home";
        parentId = 0;
    }

    if (isHome == 1) {
        db.Exec("UPDATE pages SET is_home = 0, page_type = CASE WHEN page_type = 'home' THEN 'page' ELSE page_type END");
    }

    if (pageId > 0) {
        db.Exec("UPDATE pages SET slug = ?, title = ?, excerpt = ?, content = ?, status = ?, locale = ?, is_home = ?, page_type = ?, parent_id = ?, sort_order = ?, home_mode = ?, home_section_title = ?, seo_title = ?, meta_description = ?, updated_at = datetime('now') WHERE id = ?", slug, title, excerpt, content, status, locale, isHome, normalizedPageType, parentId, sortOrder, normalizedHomeMode, homeSectionTitle, seoTitle, metaDescription, pageId);
    } else {
        db.Exec("INSERT INTO pages (slug, title, excerpt, content, status, locale, is_home, page_type, parent_id, sort_order, home_mode, home_section_title, seo_title, meta_description, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'), datetime('now'))", slug, title, excerpt, content, status, locale, isHome, normalizedPageType, parentId, sortOrder, normalizedHomeMode, homeSectionTitle, seoTitle, metaDescription);
    }

    CloseCmsDb(db);
    return true;
}

function DeletePage(pageId) {
    var db = OpenCmsDb();
    if (db == null) {
        return false;
    }

    db.Exec("UPDATE pages SET parent_id = 0 WHERE parent_id = ?", pageId);
    db.Exec("DELETE FROM pages WHERE id = ?", pageId);
    CloseCmsDb(db);
    return true;
}

function ResolveHomeListingTitle(page, lang) {
    var title = "";
    if (page != null) {
        title = TrimString(page.homeSectionTitle);
        if (title == "") {
            title = TrimString(page.title);
        }
    }

    if (title == "") {
        title = T(lang, "published_content");
    }

    return title;
}

function ListSitemapPages(lang) {
    var db = OpenCmsDb();
    var items = [];
    if (db == null) {
        return items;
    }

    var rs = db.Query(GetPageSelectSql() + " WHERE p.status = 'published' AND p.page_type <> 'block' AND (p.locale = ? OR p.locale = 'en') ORDER BY p.is_home DESC, p.sort_order ASC, datetime(p.updated_at) DESC", lang);
    if (rs != null && rs != "") {
        while (!rs.EOF) {
            items.push(ReadPageRecord(rs));
            rs.MoveNext();
        }
        rs.Close();
    }

    CloseCmsDb(db);
    return items;
}
%>