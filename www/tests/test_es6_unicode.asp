<%@ LANGUAGE="JScript" %>
<%
var passed = true;

// ===== String.fromCodePoint() Tests =====
Response.Write("=== String.fromCodePoint() Tests ===\n");

// Test 1: Single ASCII code point
var test1 = String.fromCodePoint(65);
if (test1 !== "A") {
	passed = false;
	Response.Write("String.fromCodePoint(65) failed: expected 'A', got '" + test1 + "'\n");
} else {
	Response.Write("String.fromCodePoint(65) passed\n");
}

// Test 2: Multiple ASCII code points
var test2 = String.fromCodePoint(65, 66, 67);
if (test2 !== "ABC") {
	passed = false;
	Response.Write("String.fromCodePoint(65, 66, 67) failed: expected 'ABC', got '" + test2 + "'\n");
} else {
	Response.Write("String.fromCodePoint(65, 66, 67) passed\n");
}

// Test 3: Emoji (surrogate pair: 0x1F600)
var test3 = String.fromCodePoint(0x1F600);
if (test3 !== "😀") {
	passed = false;
	Response.Write("String.fromCodePoint(0x1F600) failed: expected emoji, got '" + test3 + "'\n");
} else {
	Response.Write("String.fromCodePoint(0x1F600) passed\n");
}

// Test 4: Mixed ASCII and emoji
var test4 = String.fromCodePoint(65, 0x1F600, 66);
if (test4 !== "A😀B") {
	passed = false;
	Response.Write("String.fromCodePoint(65, 0x1F600, 66) failed: expected 'A😀B', got '" + test4 + "'\n");
} else {
	Response.Write("String.fromCodePoint(65, 0x1F600, 66) passed\n");
}

// Test 5: Round-trip with codePointAt
var test5 = String.fromCodePoint(0x1F600);
var codePoint = test5.codePointAt(0);
if (codePoint !== 0x1F600) {
	passed = false;
	Response.Write("Round-trip fromCodePoint/codePointAt failed: expected 128512, got " + codePoint + "\n");
} else {
	Response.Write("Round-trip fromCodePoint/codePointAt passed\n");
}

// Test 6: Empty call
var test6 = String.fromCodePoint();
if (test6 !== "") {
	passed = false;
	Response.Write("String.fromCodePoint() failed: expected empty string, got '" + test6 + "'\n");
} else {
	Response.Write("String.fromCodePoint() passed\n");
}

// Test 7: Type coercion (truncates float)
var test7 = String.fromCodePoint(65.9);
if (test7 !== "A") {
	passed = false;
	Response.Write("String.fromCodePoint(65.9) failed: expected 'A', got '" + test7 + "'\n");
} else {
	Response.Write("String.fromCodePoint(65.9) passed\n");
}

// ===== String.prototype.codePointAt() Tests =====
Response.Write("\n=== String.prototype.codePointAt() Tests ===\n");

// Test 8: codePointAt on ASCII
var str1 = "ABC";
if (str1.codePointAt(0) !== 65) {
	passed = false;
	Response.Write("'ABC'.codePointAt(0) failed: expected 65, got " + str1.codePointAt(0) + "\n");
} else {
	Response.Write("'ABC'.codePointAt(0) passed\n");
}

// Test 9: codePointAt on emoji
var str2 = "😀";
var cp = str2.codePointAt(0);
if (cp !== 0x1F600) {
	passed = false;
	Response.Write("'😀'.codePointAt(0) failed: expected 128512, got " + cp + "\n");
} else {
	Response.Write("'😀'.codePointAt(0) passed\n");
}

// Test 10: codePointAt on mixed string
var str3 = "A😀B";
if (str3.codePointAt(0) !== 65) {
	passed = false;
	Response.Write("'A😀B'.codePointAt(0) failed: expected 65, got " + str3.codePointAt(0) + "\n");
} else {
	Response.Write("'A😀B'.codePointAt(0) passed\n");
}

if (str3.codePointAt(1) !== 0x1F600) {
	passed = false;
	Response.Write("'A😀B'.codePointAt(1) failed: expected 128512, got " + str3.codePointAt(1) + "\n");
} else {
	Response.Write("'A😀B'.codePointAt(1) passed\n");
}

if (str3.codePointAt(3) !== 66) {
	passed = false;
	Response.Write("'A😀B'.codePointAt(3) failed: expected 66, got " + str3.codePointAt(3) + "\n");
} else {
	Response.Write("'A😀B'.codePointAt(3) passed\n");
}

// ===== Unicode Escape Sequences in String Literals =====
Response.Write("\n=== Unicode Escape Sequences in String Literals ===\n");

// Test 11: \uXXXX escapes (already supported)
var test11 = "Hello \u0041";  // \u0041 = 'A'
if (test11 !== "Hello A") {
	passed = false;
	Response.Write("'Hello \\u0041' failed: expected 'Hello A', got '" + test11 + "'\n");
} else {
	Response.Write("'Hello \\u0041' passed\n");
}

// ===== Summary =====
Response.Write("\n=== Test Summary ===\n");
if (passed) {
	Response.Write("All Phase 1 Unicode tests PASSED!\n");
} else {
	Response.Write("Some Phase 1 Unicode tests FAILED!\n");
}

// Note: The following tests are for Phase 2 and 3 and may not work until those features are implemented:
// - String Code Point Escapes (\u{...} in string literals)
// - RegExp /u flag
// - Unicode property escapes (\p{...})
%>