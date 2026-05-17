<%@Language="JavaScript"%>
<%
Response.Write("Testing Intl.RelativeTimeFormat...\n");

try {
    var rtf = new Intl.RelativeTimeFormat("en", { numeric: "auto" });
    
    Response.Write("en -1 day: " + rtf.format(-1, "day") + "\n");
    Response.Write("en 0 day: " + rtf.format(0, "day") + "\n");
    Response.Write("en 1 day: " + rtf.format(1, "day") + "\n");
    Response.Write("en -2 day: " + rtf.format(-2, "day") + "\n");
    Response.Write("en 2 day: " + rtf.format(2, "day") + "\n");
    
    var rtfPt = new Intl.RelativeTimeFormat("pt", { numeric: "auto" });
    Response.Write("pt -1 day: " + rtfPt.format(-1, "day") + "\n");
    Response.Write("pt 0 day: " + rtfPt.format(0, "day") + "\n");
    Response.Write("pt 1 day: " + rtfPt.format(1, "day") + "\n");
    
    var parts = rtf.formatToParts(-1, "day");
    Response.Write("Parts length: " + parts.length + "\n");
    for (var i = 0; i < parts.length; i++) {
        Response.Write("Part " + i + ": " + parts[i].type + "=" + parts[i].value + "\n");
    }

    var partsAlways = new Intl.RelativeTimeFormat("en", { numeric: "always" }).formatToParts(-1, "day");
    Response.Write("Parts (always) length: " + partsAlways.length + "\n");
    for (var i = 0; i < partsAlways.length; i++) {
        Response.Write("Part " + i + ": " + partsAlways[i].type + "=" + partsAlways[i].value + "\n");
    }

} catch (e) {
    Response.Write("Error: " + e.message + "\n");
}
%>
