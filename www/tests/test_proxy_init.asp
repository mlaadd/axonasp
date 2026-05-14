<%@ Language="JavaScript" %>
<%
// test_proxy_init.asp
(function() {
    Response.Write("Testing Proxy and Reflect initialization...\n");

    // 1. Check if Proxy exists
    if (typeof Proxy !== "undefined") {
        Response.Write("Proxy exists: SUCCESS\n");
    } else {
        Response.Write("Proxy exists: FAILED\n");
    }

    // 2. Check if Reflect exists
    if (typeof Reflect !== "undefined") {
        Response.Write("Reflect exists: SUCCESS\n");
    } else {
        Response.Write("Reflect exists: FAILED\n");
    }

    // 3. Test Proxy constructor with valid arguments
    try {
        var target = {};
        var handler = {};
        var proxy = new Proxy(target, handler);
        if (typeof proxy === "object" || typeof proxy === "proxy") {
            Response.Write("new Proxy(target, handler): SUCCESS\n");
        } else {
            Response.Write("new Proxy(target, handler): FAILED (type " + typeof proxy + ")\n");
        }
    } catch (e) {
        Response.Write("new Proxy(target, handler): FAILED (" + e.message + ")\n");
    }

    // 4. Test Proxy constructor without new
    try {
        Proxy({}, {});
        Response.Write("Proxy({}, {}) without new: FAILED (should have thrown)\n");
    } catch (e) {
        Response.Write("Proxy({}, {}) without new: SUCCESS (threw " + e.message + ")\n");
    }

    // 5. Test Proxy constructor with invalid arguments (missing)
    try {
        new Proxy({});
        Response.Write("new Proxy({}) with 1 arg: FAILED (should have thrown)\n");
    } catch (e) {
        Response.Write("new Proxy({}) with 1 arg: SUCCESS (threw " + e.message + ")\n");
    }

    // 6. Test Proxy constructor with invalid arguments (non-objects)
    try {
        new Proxy(42, {});
        Response.Write("new Proxy(42, {}): FAILED (should have thrown)\n");
    } catch (e) {
        Response.Write("new Proxy(42, {}): SUCCESS (threw " + e.message + ")\n");
    }

    try {
        new Proxy({}, "not an object");
        Response.Write("new Proxy({}, 'not an object'): FAILED (should have thrown)\n");
    } catch (e) {
        Response.Write("new Proxy({}, 'not an object'): SUCCESS (threw " + e.message + ")\n");
    }

})();
%>
