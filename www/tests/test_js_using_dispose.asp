<script runat="server" language="JScript">
    var trace = [];

    var firstResource = {
        [Symbol.dispose]: function () {
            trace.push("dispose:first");
        }
    };

    var secondResource = {
        [Symbol.dispose]: function () {
            trace.push("dispose:second");
        }
    };

    var thirdResource = {
        [Symbol.asyncDispose]: function () {
            trace.push("asyncDispose:third");
        }
    };

    {
        using first = firstResource;
        using second = secondResource;
        async using third = thirdResource;
        trace.push("inside");
    }

    Response.Write(trace.join("|"));
</script>