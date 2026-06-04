<%@ Language="JScript" %>
<%
function BuildHomeViewModel(lang, searchQuery, pageNumber, pageSize) {
    var normalizedSearchQuery = "";
    if (searchQuery != null && String(searchQuery) != "" && String(searchQuery) != "null") {
        normalizedSearchQuery = TrimString(searchQuery);
    }
    var homePage = GetHomePage(lang);
    var homeMode = "all";
    if (homePage != null) {
        homeMode = NormalizeHomeMode(homePage.homeMode);
    }
    var pagedPages = ListPublishedContentPaged(lang, normalizedSearchQuery, pageNumber, pageSize, homeMode);
    var homeSectionTitle = T(lang, "published_content");
    if (homePage != null) {
        homeSectionTitle = ResolveHomeListingTitle(homePage, lang);
    }
    return {
        homePage: homePage,
        pages: pagedPages.items,
        totalCount: pagedPages.totalCount,
        totalPages: pagedPages.totalPages,
        pageNumber: pagedPages.pageNumber,
        pageSize: pagedPages.pageSize,
        searchQuery: normalizedSearchQuery,
        homeMode: homeMode,
        homeSectionTitle: homeSectionTitle,
        menu: ListPublicMenu(lang)
    };
}

function BuildContentViewModel(slug, lang) {
    return {
        page: GetPageBySlug(slug, lang),
        children: [],
        menu: ListPublicMenu(lang)
    };
}
%>