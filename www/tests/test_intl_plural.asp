<%@ Language="JScript" %>
<%
function testPluralRules() {
    Response.Write("Testing Intl.PluralRules...\n");

    // 1. English Cardinal
    var prEn = new Intl.PluralRules("en");
    Response.Write("en-US (1): " + prEn.select(1) + "\n");
    Response.Write("en-US (2): " + prEn.select(2) + "\n");

    // 2. Portuguese Cardinal
    var prPt = new Intl.PluralRules("pt");
    Response.Write("pt-BR (1): " + prPt.select(1) + "\n");
    Response.Write("pt-BR (2): " + prPt.select(2) + "\n");

    // 3. Polish Cardinal (Complex)
    var prPl = new Intl.PluralRules("pl");
    Response.Write("pl (1): " + prPl.select(1) + "\n");
    Response.Write("pl (2): " + prPl.select(2) + "\n");
    Response.Write("pl (5): " + prPl.select(5) + "\n");

    // 4. English Ordinal
    var prEnOrd = new Intl.PluralRules("en", { type: "ordinal" });
    Response.Write("en-US Ordinal (1): " + prEnOrd.select(1) + "\n");
    Response.Write("en-US Ordinal (2): " + prEnOrd.select(2) + "\n");
    Response.Write("en-US Ordinal (3): " + prEnOrd.select(3) + "\n");
    Response.Write("en-US Ordinal (4): " + prEnOrd.select(4) + "\n");
}

testPluralRules();
%>
