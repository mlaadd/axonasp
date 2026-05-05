<%@ language="JScript" %><%
// Test: ES6 For...Of Loops

var passed = 0;
var failed = 0;

function check(label, got, expected) {
    if (String(got) === String(expected)) {
        passed++;
        Response.Write("PASS: " + label + "\n");
    } else {
        failed++;
        Response.Write("FAIL: " + label + " - expected: " + expected + " got: " + got + "\n");
    }
}

// 1. Basic array iteration
var result1 = "";
for (var x of [10, 20, 30]) {
    result1 += x + ",";
}
check("basic array", result1, "10,20,30,");

// 2. String iteration
var result2 = "";
for (var ch of "abc") {
    result2 += ch;
}
check("string chars", result2, "abc");

// 3. let declaration
var sum3 = 0;
for (let n of [1, 2, 3, 4]) {
    sum3 += n;
}
check("let declaration sum", sum3, 10);

// 4. break statement
var result4 = "";
for (var x of [1, 2, 3, 4, 5]) {
    if (x === 3) break;
    result4 += x + ",";
}
check("break exits loop", result4, "1,2,");

// 5. continue statement
var result5 = "";
for (var x of [1, 2, 3, 4]) {
    if (x === 2) continue;
    result5 += x + ",";
}
check("continue skips value", result5, "1,3,4,");

// 6. Empty array
var result6 = "ok";
for (var x of []) {
    result6 = "fail";
}
check("empty array no iteration", result6, "ok");

// 7. Nested for...of
var result7 = "";
for (var a of [1, 2]) {
    for (var b of [3, 4]) {
        result7 += a + "" + b + ",";
    }
}
check("nested for-of", result7, "13,14,23,24,");

// 8. const declaration
var result8 = "";
for (const v of ["x", "y", "z"]) {
    result8 += v;
}
check("const declaration", result8, "xyz");

Response.Write("---\n");
Response.Write("Passed: " + passed + " / Failed: " + failed + "\n");
%>