<%@ Language="JavaScript" %>
<%
// test_proxy_get_set.asp
(function() {
    Response.Write("Testing Proxy get and set traps...\n");

    // 1. Basic get trap
    var target = { a: 1, b: 2 };
    var handler = {
        get: function(target, prop, receiver) {
            if (prop === "a") return target[prop] * 10;
            return "intercepted " + prop;
        }
    };
    var proxy = new Proxy(target, handler);
    
    Response.Write("proxy.a (intercepted): " + proxy.a + "\n");
    if (proxy.a === 10) {
        Response.Write("Basic get trap (a): SUCCESS\n");
    } else {
        Response.Write("Basic get trap (a): FAILED\n");
    }

    Response.Write("proxy.b (intercepted): " + proxy.b + "\n");
    if (proxy.b === "intercepted b") {
        Response.Write("Basic get trap (b): SUCCESS\n");
    } else {
        Response.Write("Basic get trap (b): FAILED\n");
    }

    // 2. Basic set trap
    var setLog = [];
    var target2 = { x: 0 };
    var handler2 = {
        set: function(target, prop, value, receiver) {
            setLog.push(prop + "=" + value);
            target[prop] = value;
            return true;
        }
    };
    var proxy2 = new Proxy(target2, handler2);
    proxy2.x = 42;
    proxy2.y = "hello";

    Response.Write("setLog: " + setLog.join(",") + "\n");
    if (target2.x === 42 && target2.y === "hello" && setLog.length === 2) {
        Response.Write("Basic set trap: SUCCESS\n");
    } else {
        Response.Write("Basic set trap: FAILED\n");
    }

    // 3. Forwarding (no trap)
    var proxy3 = new Proxy({ z: 99 }, {});
    if (proxy3.z === 99) {
        Response.Write("Forwarding get: SUCCESS\n");
    } else {
        Response.Write("Forwarding get: FAILED\n");
    }
    proxy3.w = 100;
    if (proxy3.w === 100) {
        Response.Write("Forwarding set: SUCCESS\n");
    } else {
        Response.Write("Forwarding set: FAILED\n");
    }

    // 4. Strict mode enforcement
    (function() {
        "use strict";
        var handlerStrict = {
            set: function() { return false; }
        };
        var proxyStrict = new Proxy({}, handlerStrict);
        try {
            proxyStrict.fail = 1;
            Response.Write("Strict mode set returning false: FAILED (should have thrown)\n");
        } catch (e) {
            Response.Write("Strict mode set returning false: SUCCESS (threw " + e.message + ")\n");
        }
    })();

    // 5. Receiver argument check
    var receiverCheck = null;
    var handler3 = {
        get: function(target, prop, receiver) {
            receiverCheck = receiver;
            return target[prop];
        }
    };
    var proxy4 = new Proxy({ val: "ok" }, handler3);
    var dummy = proxy4.val;
    if (receiverCheck === proxy4) {
        Response.Write("Receiver in get trap: SUCCESS\n");
    } else {
        Response.Write("Receiver in get trap: FAILED\n");
    }

    // 6. Indexed access
    var handler4 = {
        get: function(target, prop) {
            return "index " + prop;
        }
    };
    var proxy5 = new Proxy([], handler4);
    if (proxy5[0] === "index 0" && proxy5["some"] === "index some") {
        Response.Write("Indexed get trap: SUCCESS\n");
    } else {
        Response.Write("Indexed get trap: FAILED (got " + proxy5[0] + ")\n");
    }

})();
%>
