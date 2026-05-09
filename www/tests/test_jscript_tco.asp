<%@ language="VBScript" %>
<script runat="server" language="JScript">
    // ---------------------------------------------------------------------------
    // Tail Call Optimization (TCO) Validation
    // ---------------------------------------------------------------------------

    function report(name, actual, expected) {
        Response.Write("Testing " + name + ": ");
        if (String(actual) === String(expected)) {
            Response.Write("PASS\n");
        } else {
            Response.Write("FAIL (Expected " + expected + ", got " + actual + ")\n");
        }
    }

    function sum(n, acc) {
        if (n === 0) {
            return acc;
        }
        return sum(n - 1, acc + 1);
    }

    function sumInTry(n, acc) {
        try {
            if (n === 0) {
                return acc;
            }
            return sumInTry(n - 1, acc + 1);
        } catch (e) {
            return -1;
        }
    }

    report("Tail recursion depth 100000", sum(100000, 0), 100000);
    report("Try/catch bypass tail call", sumInTry(128, 0), 128);

    Response.Write("\nTCO TESTS COMPLETED\n");
</script>