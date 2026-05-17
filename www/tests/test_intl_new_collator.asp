<%@ Language="JScript" %>
<%
function testCollator() {
    Response.Write("Testing Intl.Collator...\n");

    // 1. Basic sort
    var collator = new Intl.Collator("en");
    var arr = ["banana", "Apple", "cherry"];
    arr.sort(collator.compare);
    Response.Write("Sorted: " + arr.join(", ") + "\n");

    // 2. Sensitivity: base
    var cBase = new Intl.Collator("en", { sensitivity: "base" });
    Response.Write("Base sensitivity (a vs A): " + (cBase.compare("a", "A") === 0 ? "Equal" : "Different") + "\n");
    Response.Write("Base sensitivity (a vs á): " + (cBase.compare("a", "á") === 0 ? "Equal" : "Different") + "\n");

    // 3. Sensitivity: accent
    var cAccent = new Intl.Collator("en", { sensitivity: "accent" });
    Response.Write("Accent sensitivity (a vs A): " + (cAccent.compare("a", "A") === 0 ? "Equal" : "Different") + "\n");
    Response.Write("Accent sensitivity (a vs á): " + (cAccent.compare("a", "á") === 0 ? "Equal" : "Different") + "\n");

    // 4. CaseFirst
    var cUpper = new Intl.Collator("en", { caseFirst: "upper" });
    var cLower = new Intl.Collator("en", { caseFirst: "lower" });
    Response.Write("CaseFirst upper (a vs A): " + cUpper.compare("a", "A") + "\n");
    Response.Write("CaseFirst lower (a vs A): " + cLower.compare("a", "A") + "\n");

    // 5. Ignore Punctuation
    var cIgnore = new Intl.Collator("en", { ignorePunctuation: true });
    Response.Write("Ignore punctuation ('a-b' vs 'ab'): " + (cIgnore.compare("a-b", "ab") === 0 ? "Equal" : "Different") + "\n");

    // 6. Numeric
    var cNumeric = new Intl.Collator("en", { numeric: true });
    Response.Write("Numeric sort ('10' vs '2'): " + (cNumeric.compare("10", "2") > 0 ? "10 > 2" : "10 <= 2") + "\n");
}

testCollator();
%>
