<%@ language="JScript" %>
<%
// ---------------------------------------------------------------------------
// Phase 2: Modern Syntax & Operators
// ---------------------------------------------------------------------------

function test(name, code, expected) {
    Response.Write("Testing " + name + ": ");
    var result;
    try {
        result = eval(code);
        if (String(result) === String(expected)) {
            Response.Write("PASS\n");
        } else {
            Response.Write("FAIL (Expected " + expected + ", got " + result + ")\n");
        }
    } catch (e) {
        Response.Write("ERROR (" + e.message + ")\n");
    }
}

// Optional Chaining
var user = { info: { name: "Alice" } };
test("Optional Chaining (Basic)", 'user?.info?.name', "Alice");
test("Optional Chaining (Null)", 'user?.settings?.theme', "undefined");

// Nullish Coalescing
test("Nullish Coalescing (Null)", 'null ?? "ok"', "ok");
test("Nullish Coalescing (Zero)", '0 ?? "fail"', "0");

// Logical Assignment
var a = 0; a ||= 10;
test("Logical OR Assignment", 'a', "10");
var b = null; b ??= 20;
test("Nullish Coalescing Assignment", 'b', "20");

// Exponentiation
test("Exponentiation (2**3)", '2 ** 3', "8");

// BigInt
test("BigInt Addition", '10n + 20n', "30");
test("BigInt Exponentiation", '2n ** 10n', "1024");

Response.Write("\nPHASE 2 TESTS COMPLETED\n");
%>
