<%@ language="javascript" %>
<%
function assert(name, condition) {
    if (condition) {
        Response.Write("[PASS] " + name + "<br>");
    } else {
        Response.Write("[FAIL] " + name + "<br>");
    }
}

// 1. Named Capture Groups
var re1 = /(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})/;
var match1 = re1.exec("2026-05-14");
assert("Named groups exist", match1 && match1.groups);
assert("Named group year", match1.groups.year === "2026");
assert("Named group month", match1.groups.month === "05");
assert("Named group day", match1.groups.day === "14");

// 2. Lookaround Assertions
var re2 = /(?<=\$)\d+/;
var match2 = re2.exec("Price is $100");
assert("Lookbehind", match2 && match2[0] === "100");

var re3 = /\d+(?=px)/;
var match3 = re3.exec("100px");
assert("Lookahead", match3 && match3[0] === "100");

// 3. Sticky Flag (y)
var re4 = /a/y;
re4.lastIndex = 1;
assert("Sticky match at index 1", re4.exec("ba") !== null);
assert("lastIndex updated after sticky match", re4.lastIndex === 2);
assert("Sticky mismatch at index 2", re4.exec("ba") === null);
assert("lastIndex reset after mismatch", re4.lastIndex === 0);

// 4. Flags Property
var re5 = /abc/gimuy;
assert("Flags property alphabetical", re5.flags === "gimuy");

// 5. String methods
var text = "apple pie, apple juice";
var matches = text.match(/apple(?! pie)/g);
assert("String match global with lookahead", matches && matches.length === 1 && matches[0] === "apple");

var resReplace = "abc".replace(/(?<a>a)/, "$<a>-b");
assert("String replace named group token: " + resReplace, resReplace === "a-bbc");

var resSplit = "a,b,c".split(/,\s*/);
assert("String split regex", resSplit && resSplit.length === 3 && resSplit[1] === "b");

Response.Write("<h3>JScript RegExp ES6+ Phase 5 Complete</h3>");
%>
