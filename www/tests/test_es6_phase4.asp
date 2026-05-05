<script runat="server" language="JScript">
    var results = [];

    // 1) Object.getOwnPropertyDescriptor / getOwnPropertyDescriptors
    var source = {};
    Object.defineProperty(source, "hidden", {
        value: 42,
        writable: false,
        enumerable: false,
        configurable: false
    });
    source.visible = 7;

    var d1 = Object.getOwnPropertyDescriptor(source, "hidden");
    var descriptors = Object.getOwnPropertyDescriptors(source);

    var descSingleOk = (d1 && d1.value === 42 && d1.writable === false && d1.enumerable === false && d1.configurable === false);
    var descPluralOk = (descriptors.hidden && descriptors.hidden.value === 42 && descriptors.visible && descriptors.visible.value === 7);
    results.push("ObjectDescriptorSingle:" + (descSingleOk ? "PASS" : "FAIL"));
    results.push("ObjectDescriptorPlural:" + (descPluralOk ? "PASS" : "FAIL"));

    // 2) Array.prototype.fill with start/end and negative index behavior
    var fillArr = [1, 2, 3, 4, 5];
    fillArr.fill(9, 1, 4);
    var fillMainOk = (fillArr.join(",") === "1,9,9,9,5");

    var fillNeg = [1, 2, 3, 4];
    fillNeg.fill(8, -2);
    var fillNegOk = (fillNeg.join(",") === "1,2,8,8");

    results.push("ArrayFillRange:" + (fillMainOk ? "PASS" : "FAIL:" + fillArr.join(",")));
    results.push("ArrayFillNegative:" + (fillNegOk ? "PASS" : "FAIL:" + fillNeg.join(",")));

    // 3) Array.prototype.copyWithin with overlap and negative index normalization
    var copyA = [1, 2, 3, 4, 5];
    copyA.copyWithin(0, 3);
    var copyMainOk = (copyA.join(",") === "4,5,3,4,5");

    var copyB = [1, 2, 3, 4, 5];
    copyB.copyWithin(-2, 0, 2);
    var copyNegOk = (copyB.join(",") === "1,2,3,1,2");

    results.push("ArrayCopyWithinMain:" + (copyMainOk ? "PASS" : "FAIL:" + copyA.join(",")));
    results.push("ArrayCopyWithinNegative:" + (copyNegOk ? "PASS" : "FAIL:" + copyB.join(",")));

    // 4) String.prototype.includes position + RegExp TypeError
    var includesPosOk = ("hello world".includes("world", 6) && !"hello world".includes("hello", 1));
    results.push("StringIncludesPosition:" + (includesPosOk ? "PASS" : "FAIL"));

    var includesRegexTypeError = false;
    try {
        "hello".includes(new RegExp("h"));
    } catch (e) {
        includesRegexTypeError = (String(e).indexOf("TypeError") !== -1);
    }
    results.push("StringIncludesRegexTypeError:" + (includesRegexTypeError ? "PASS" : "FAIL"));

    // 5) Number constants read-only behavior
    var beforeEpsilon = Number.EPSILON;
    var beforeMaxSafe = Number.MAX_SAFE_INTEGER;
    Number.EPSILON = 1;
    Number.MAX_SAFE_INTEGER = 1;
    var numberReadonlyOk = (Number.EPSILON === beforeEpsilon && Number.MAX_SAFE_INTEGER === beforeMaxSafe);
    results.push("NumberReadonlyConstants:" + (numberReadonlyOk ? "PASS" : "FAIL"));

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