<%@ Language="JScript" %>
<!--#include file="includes/config.asp" -->
<!--#include file="includes/helpers.asp" -->
<!--#include file="includes/i18n.asp" -->
<!--#include file="includes/db.asp" -->
<!--#include file="models/page_model.asp" -->
<!--#include file="controllers/public_controller.asp" -->
<%
var lang = GetBaseLanguage();
EnsureSchemaAndSeed();

var siteTitle = GetSiteTitle();
var siteBaseUrl = BuildSiteBaseUrl();
var feedUrl = GetRssFeedUrl();
var feedDescription = GetSettingValue("footer_text", T(lang, "powered_footer"));
var rssItems = ListRssItems(lang, 20);

Response.ContentType = "text/xml";
%>
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
    <channel>
        <title><%=XmlEscape(siteTitle)%></title>
        <link><%=XmlEscape(siteBaseUrl)%></link>
        <description><%=XmlEscape(feedDescription)%></description>
        <language><%=XmlEscape(lang)%></language>
        <atom:link href="<%=XmlEscape(siteBaseUrl)%>/rss.asp" rel="self" type="application/rss+xml" />
        <%
var i;
for (i = 0; i < rssItems.length; i++) {
    var rssItem = rssItems[i];
    var itemLink = siteBaseUrl + "/content.asp?slug=" + Server.URLEncode(rssItem.slug);
    if (rssItem.isHome == 1) {
        itemLink = siteBaseUrl;
    }
    var itemTitle = TrimString(rssItem.title);
    if (itemTitle == "") {
        itemTitle = rssItem.slug;
    }
    var itemDesc = TrimString(rssItem.excerpt);
    if (itemDesc == "") {
        itemDesc = itemTitle;
    }
    var itemDate = TrimString(rssItem.updatedAt);
    if (itemDate == "") {
        itemDate = TrimString(rssItem.createdAt);
    }
    var rssDate = "";
    if (itemDate != "") {
        try {
            var dt = new Date(itemDate.replace(" ", "T") + "Z");
            rssDate = dt.toUTCString();
        } catch (exDt) {
            rssDate = "";
        }
    }
%>
        <item>
            <title><%=XmlEscape(itemTitle)%></title>
            <link><%=XmlEscape(itemLink)%></link>
            <guid isPermaLink="true"><%=XmlEscape(itemLink)%></guid>
            <description><%=XmlEscape(itemDesc)%></description>
            <%
    if (rssDate != "") {
%>
            <pubDate><%=XmlEscape(rssDate)%></pubDate>
            <%
    }
%>
        </item>
        <%
}
%>
    </channel>
</rss>