<%@ Language="JScript" %>
<%
/*
 * AxonASP Server - JScript Escape Sequences Test Page
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 */

function report(name, ok) {
    Response.Write(name + "=" + ok + "\n");
}

var okNewline = "A\nB".length === 3 && "A\nB".charCodeAt(1) === 10;
var okSingleQuote = 'It\'s' === "It's";
var okDoubleQuote = "\"ok\"" === '"ok"';
var okBackslash = "\\".length === 1 && "\\".charCodeAt(0) === 92;
var okBackspace = "\b".charCodeAt(0) === 8;
var okFormFeed = "\f".charCodeAt(0) === 12;
var okCarriageReturn = "\r".charCodeAt(0) === 13;
var okTab = "\t".charCodeAt(0) === 9;
var okVerticalTab = "\v".charCodeAt(0) === 11;

report("escape_n", okNewline);
report("escape_single_quote", okSingleQuote);
report("escape_double_quote", okDoubleQuote);
report("escape_backslash", okBackslash);
report("escape_b", okBackspace);
report("escape_f", okFormFeed);
report("escape_r", okCarriageReturn);
report("escape_t", okTab);
report("escape_v", okVerticalTab);

var templateValue = `A\nB\tC`;
var okTemplateEscapes = templateValue.length === 5 && templateValue.charCodeAt(1) === 10 && templateValue.charCodeAt(3) === 9;
report("template_escapes", okTemplateEscapes);

var allOk = okNewline && okSingleQuote && okDoubleQuote && okBackslash && okBackspace && okFormFeed && okCarriageReturn && okTab && okVerticalTab && okTemplateEscapes;
Response.Write("DONE=" + allOk + "\n");
%>