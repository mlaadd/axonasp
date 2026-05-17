<%@ LANGUAGE="JScript" %>
<%
// Test 1: Simple Unicode escape (should work - Phase 2 is done)
var re1 = /\u{0041}/u;
Response.Write("Test 1 - Unicode escape \\u{0041}: ");
Response.Write(re1.test("A") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");

// Test 2: Character class with ASCII range
var re2 = /[a-z]/u;
Response.Write("Test 2 - ASCII range [a-z]: ");
Response.Write(re2.test("hello") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");

// Test 3: Try a minimal Unicode property (single range)
var re3 = /[\u{0041}-\u{005A}]/u;
Response.Write("Test 3 - Unicode range A-Z: ");
Response.Write(re3.test("Hello") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");

// Test 4: Test with literal characters in property range
var re4 = /[A-Z]/u;
Response.Write("Test 4 - Literal A-Z: ");
Response.Write(re4.test("Hello") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");

// Test 5: Now try Unicode property
var re5 = /\p{Letter}/u;
Response.Write("Test 5 - Unicode property \\p{Letter}: ");
Response.Write(re5.test("Hello") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");
%>
