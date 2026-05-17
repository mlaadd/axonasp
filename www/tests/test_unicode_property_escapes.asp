<%@ LANGUAGE="JScript" %>
<%
// Test basic Letter property
var re1 = /\p{Letter}+/u;
Response.Write("Test 1 - Letter property: ");
Response.Write(re1.test("Hello") ? "MATCH" : "NO_MATCH");
Response.Write(" | ");
Response.Write(re1.test("123") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");

// Test Number property  
var re2 = /\p{Number}+/u;
Response.Write("Test 2 - Number property: ");
Response.Write(re2.test("123") ? "MATCH" : "NO_MATCH");
Response.Write(" | ");
Response.Write(re2.test("abc") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");

// Test negated Letter property
var re3 = /\P{Letter}+/u;
Response.Write("Test 3 - Negated Letter property: ");
Response.Write(re3.test("123") ? "MATCH" : "NO_MATCH");
Response.Write(" | ");
Response.Write(re3.test("abc") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");

// Test Punctuation
var re4 = /\p{Punctuation}+/u;
Response.Write("Test 4 - Punctuation property: ");
Response.Write(re4.test("!!!") ? "MATCH" : "NO_MATCH");
Response.Write(" | ");
Response.Write(re4.test("abc") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");

// Test combined in character class
var re5 = /[\p{Letter}\p{Number}]+/u;
Response.Write("Test 5 - Combined in char class: ");
Response.Write(re5.test("abc123") ? "MATCH" : "NO_MATCH");
Response.Write(" | ");
Response.Write(re5.test("!!!") ? "MATCH" : "NO_MATCH");
Response.Write("<br>");
%>
