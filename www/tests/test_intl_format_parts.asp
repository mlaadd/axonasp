<%@ Language="JScript" %>
<%
function testFormatToParts() {
    Response.Write("Testing Intl.formatToParts()...\n");

    // 1. DateTimeFormat
    var dtf = new Intl.DateTimeFormat("en-US", { dateStyle: "short", timeStyle: "short" });
    var date = new Date(Date.UTC(2026, 4, 17, 10, 30, 0)); // May 17, 2026
    var dtParts = dtf.formatToParts(date);
    Response.Write("DateTime Parts (en-US):\n");
    for (var i = 0; i < dtParts.length; i++) {
        Response.Write("  " + dtParts[i].type + ": " + dtParts[i].value + "\n");
    }

    // 2. NumberFormat (Currency)
    var nf = new Intl.NumberFormat("pt-BR", { style: "currency", currency: "BRL" });
    var numParts = nf.formatToParts(1234.56);
    Response.Write("\nNumber Parts (pt-BR Currency):\n");
    for (var i = 0; i < numParts.length; i++) {
        Response.Write("  " + numParts[i].type + ": " + numParts[i].value + "\n");
    }

    // 3. NumberFormat (Percent)
    var pf = new Intl.NumberFormat("en-US", { style: "percent", minimumFractionDigits: 1 });
    var pParts = pf.formatToParts(0.4567);
    Response.Write("\nPercent Parts (en-US):\n");
    for (var i = 0; i < pParts.length; i++) {
        Response.Write("  " + pParts[i].type + ": " + pParts[i].value + "\n");
    }
}

testFormatToParts();
%>
