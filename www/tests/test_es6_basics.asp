<script runat="server" language="JScript">
    // ES6 Feature Tests
    var results = [];

    // ---- Template Literals ----
    var name = "World";
    var greeting = `Hello, ${name}!`;
    results.push("TemplateLit1:" + (greeting === "Hello, World!" ? "PASS" : "FAIL:" + greeting));

    var a = 3, b = 4;
    var expr = `${a} + ${b} = ${a + b}`;
    results.push("TemplateLit2:" + (expr === "3 + 4 = 7" ? "PASS" : "FAIL:" + expr));

    var plain = `plain string`;
    results.push("TemplateLit3:" + (plain === "plain string" ? "PASS" : "FAIL:" + plain));

    // ---- Arrow Functions ----
    var dbl = (x) => x * 2;
    results.push("Arrow1:" + (dbl(5) === 10 ? "PASS" : "FAIL:" + dbl(5)));

    var add = (a, b) => a + b;
    results.push("Arrow2:" + (add(3, 4) === 7 ? "PASS" : "FAIL:" + add(3, 4)));

    var addBlock = (a, b) => { return a + b; };
    results.push("Arrow3:" + (addBlock(10, 20) === 30 ? "PASS" : "FAIL:" + addBlock(10, 20)));

    // Arrow with lexical this
    function Counter() {
        this.count = 0;
        this.inc = function () {
            var fn = () => { this.count = this.count + 1; };
            fn();
        };
    }
    var c = new Counter();
    c.inc();
    c.inc();
    c.inc();
    results.push("ArrowThis:" + (c.count === 3 ? "PASS" : "FAIL:" + c.count));

    // ---- Default Parameters ----
    function greet(name, msg) {
        if (msg === undefined) msg = "Hello";
        return msg + ", " + name + "!";
    }
    results.push("DefaultParam1:" + (greet("World") === "Hello, World!" ? "PASS" : "FAIL:" + greet("World")));
    results.push("DefaultParam2:" + (greet("Alice", "Hi") === "Hi, Alice!" ? "PASS" : "FAIL:" + greet("Alice", "Hi")));

    // ---- ES6 String Methods ----
    var s = "Hello World";
    results.push("StringIncludes1:" + (s.includes("World") === true ? "PASS" : "FAIL"));
    results.push("StringIncludes2:" + (s.includes("xyz") === false ? "PASS" : "FAIL"));
    results.push("StringStartsWith:" + (s.startsWith("Hello") === true ? "PASS" : "FAIL"));
    results.push("StringEndsWith:" + (s.endsWith("World") === true ? "PASS" : "FAIL"));
    results.push("StringRepeat:" + ("ab".repeat(3) === "ababab" ? "PASS" : "FAIL:" + "ab".repeat(3)));

    // ---- ES6 Number Methods ----
    results.push("NumIsInt1:" + (Number.isInteger(42) === true ? "PASS" : "FAIL"));
    results.push("NumIsInt2:" + (Number.isInteger(42.5) === false ? "PASS" : "FAIL"));
    results.push("NumIsInt3:" + (Number.isInteger("42") === false ? "PASS" : "FAIL"));
    results.push("NumIsNaN1:" + (Number.isNaN(NaN) === true ? "PASS" : "FAIL"));
    results.push("NumIsNaN2:" + (Number.isNaN(42) === false ? "PASS" : "FAIL"));
    results.push("NumIsNaN3:" + (Number.isNaN("NaN") === false ? "PASS" : "FAIL"));
    results.push("NumIsFinite1:" + (Number.isFinite(42) === true ? "PASS" : "FAIL"));
    results.push("NumIsFinite2:" + (Number.isFinite(Infinity) === false ? "PASS" : "FAIL"));
    results.push("NumIsFinite3:" + (Number.isFinite("42") === false ? "PASS" : "FAIL"));
    results.push("NumIsSafe1:" + (Number.isSafeInteger(9007199254740991) === true ? "PASS" : "FAIL"));
    results.push("NumIsSafe2:" + (Number.isSafeInteger(9007199254740992) === false ? "PASS" : "FAIL"));
    results.push("NumIsSafe3:" + (Number.isSafeInteger(42.5) === false ? "PASS" : "FAIL"));

    // Output results
    var passed = 0, failed = 0;
    for (var i = 0; i < results.length; i++) {
        if (results[i].indexOf(":PASS") !== -1) {
            passed++;
        } else {
            failed++;
        }
        Response.Write(results[i] + "\n");
    }
    Response.Write("\n=== " + passed + "/" + (passed + failed) + " passed ===\n");
</script>