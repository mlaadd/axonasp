<%@ language="JScript" %><%
// Test: ES6 Computed Property Names { [expr]: value }

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

// 1. Simple variable key
var key = "name";
var o1 = { [key]: "Alice" };
check("simple variable key", o1.name, "Alice");

// 2. Expression key
var prefix = "greet";
var o2 = { [prefix + "_en"]: "Hello", [prefix + "_fr"]: "Bonjour" };
check("expression key en", o2.greet_en, "Hello");
check("expression key fr", o2.greet_fr, "Bonjour");

// 3. Mixed static and computed keys
var k = "dynamic";
var o3 = { static: 1, [k]: 2 };
check("mixed static key", o3.static, 1);
check("mixed computed key", o3.dynamic, 2);

// 4. Numeric computed key
var idx = 0;
var o4 = { [idx]: "zero" };
check("numeric computed key", o4[0], "zero");

// 5. Method value with computed key
var methodKey = "sayHello";
var o5 = {
    [methodKey]: function() { return "hi"; }
};
check("method value with computed key", o5.sayHello(), "hi");

Response.Write("---\n");
Response.Write("Passed: " + passed + " / Failed: " + failed + "\n");
%>