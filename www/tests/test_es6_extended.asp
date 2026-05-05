<script runat="server" language="JScript">
    var results = [];

    // Object.assign / keys / values / entries
    var obj = { a: 1 };
    Object.assign(obj, { b: 2 }, { c: 3 });
    results.push("ObjectAssign:" + ((obj.a === 1 && obj.b === 2 && obj.c === 3) ? "PASS" : "FAIL"));
    results.push("ObjectKeys:" + (Object.keys(obj).join(",") === "a,b,c" ? "PASS" : "FAIL:" + Object.keys(obj).join(",")));
    results.push("ObjectValues:" + (Object.values(obj).join(",") === "1,2,3" ? "PASS" : "FAIL:" + Object.values(obj).join(",")));
    var entries = Object.entries(obj);
    var entriesText = entries[0][0] + ":" + entries[0][1] + ";" + entries[1][0] + ":" + entries[1][1] + ";" + entries[2][0] + ":" + entries[2][1];
    results.push("ObjectEntries:" + (entriesText === "a:1;b:2;c:3" ? "PASS" : "FAIL:" + entriesText));

    // Spread operator for arrays
    var src = [3, 4];
    var spread = [1, 2, ...src, 5];
    results.push("ArraySpread:" + (spread.join(",") === "1,2,3,4,5" ? "PASS" : "FAIL:" + spread.join(",")));

    // Array.prototype.find / findIndex
    var f = [2, 6, 9, 12];
    results.push("ArrayFind:" + (f.find(function (x) { return x > 8; }) === 9 ? "PASS" : "FAIL"));
    results.push("ArrayFindIndex:" + (f.findIndex(function (x) { return x > 8; }) === 2 ? "PASS" : "FAIL"));
    results.push("ArrayFindMiss:" + (f.find(function (x) { return x > 99; }) === undefined ? "PASS" : "FAIL"));
    results.push("ArrayFindIndexMiss:" + (f.findIndex(function (x) { return x > 99; }) === -1 ? "PASS" : "FAIL"));

    // Binary and octal numeric literals
    results.push("BinaryLiteral:" + (0b1010 === 10 ? "PASS" : "FAIL"));
    results.push("OctalLiteral:" + (0o744 === 484 ? "PASS" : "FAIL"));

    // Math extensions
    results.push("MathTrunc:" + (Math.trunc(4.9) === 4 ? "PASS" : "FAIL"));
    results.push("MathSignPos:" + (Math.sign(12) === 1 ? "PASS" : "FAIL"));
    results.push("MathSignNeg:" + (Math.sign(-12) === -1 ? "PASS" : "FAIL"));
    results.push("MathSignZero:" + (Math.sign(0) === 0 ? "PASS" : "FAIL"));
    results.push("MathCbrt:" + (Math.cbrt(27) === 3 ? "PASS" : "FAIL"));

    var passed = 0;
    var failed = 0;
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