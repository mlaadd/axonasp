<script runat="server" language="JScript">
    var results = [];

    // 1) Symbol primitive
    var s1 = Symbol("a");
    var s2 = Symbol("a");
    results.push("SymbolUnique:" + ((s1 !== s2) ? "PASS" : "FAIL"));
    results.push("SymbolTypeof:" + ((typeof s1 === "symbol") ? "PASS" : "FAIL"));

    var symbolCtorError = false;
    try {
        var sx = new Symbol("x");
    } catch (e) {
        symbolCtorError = (String(e).indexOf("TypeError") !== -1);
    }
    results.push("SymbolCtorTypeError:" + (symbolCtorError ? "PASS" : "FAIL"));

    var obj = {};
    obj[s1] = 123;
    obj.visible = 1;
    results.push("SymbolObjectKey:" + ((obj[s1] === 123) ? "PASS" : "FAIL"));
    results.push("SymbolKeyHiddenFromKeys:" + ((Object.keys(obj).join(",") === "visible") ? "PASS" : "FAIL:" + Object.keys(obj).join(",")));

    // 2) Array.from / Array.of
    var aFrom = Array.from({ length: 3, 0: "x", 1: "y", 2: "z" });
    var aOf = Array.of(10, 20, 30);
    results.push("ArrayFrom:" + ((aFrom.join("-") === "x-y-z") ? "PASS" : "FAIL:" + aFrom.join("-")));
    results.push("ArrayOf:" + ((aOf.join("-") === "10-20-30") ? "PASS" : "FAIL:" + aOf.join("-")));

    // 3) Rest parameters
    function gather(first, ...rest) {
        return first + ":" + rest.length + ":" + rest[0] + ":" + rest[1];
    }
    results.push("RestParams:" + ((gather("h", 5, 6) === "h:2:5:6") ? "PASS" : "FAIL:" + gather("h", 5, 6)));

    // 4) Set / Map basics
    var set = new Set();
    set.add("a").add("b");
    var setOk = set.has("a") && set.has("b") && set.delete("a") && !set.has("a");
    set.clear();
    setOk = setOk && !set.has("b");
    results.push("SetBasics:" + (setOk ? "PASS" : "FAIL"));

    var map = new Map();
    map.set("k1", 1).set("k2", 2);
    var mapOk = map.has("k1") && map.has("k2") && map.delete("k1") && !map.has("k1");
    map.clear();
    mapOk = mapOk && !map.has("k2");
    results.push("MapBasics:" + (mapOk ? "PASS" : "FAIL"));

    // 5) String padStart / padEnd
    results.push("PadStart:" + (("7".padStart(3, "0") === "007") ? "PASS" : "FAIL"));
    results.push("PadEnd:" + (("7".padEnd(3, "0") === "700") ? "PASS" : "FAIL"));

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