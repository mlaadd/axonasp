<%@ Language="JavaScript"%>
<%
Response.Write("T1: " + (Math.atan2(-1, 0) === -Math.PI / 2) + "\n");

// Check the actual values and types
function getType(v) {
    if (v === null) return "null";
    if (typeof v === "number") {
        if (v !== v) return "NaN";
        if (v === 1/0) return "Infinity";
        if (v === -1/0) return "-Infinity";
        if (v === 0 && 1/v === -1/0) return "-0";
        return "number";
    }
    return typeof v;
}

var a = Math.atan2(-1, 0);
var b = -Math.PI / 2;
Response.Write("A=" + a + " type=" + getType(a) + "\n");
Response.Write("B=" + b + " type=" + getType(b) + "\n");
Response.Write("strict=" + (a === b) + "\n");
Response.Write("loose=" + (a == b) + "\n");
%>