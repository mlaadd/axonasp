<%@ Language="JScript" %>
<%
    Response.Write("<h1>Test Reflect API</h1>");

    var errors = [];
    function assertEqual(actual, expected, msg) {
        if (actual !== expected) {
            errors.push(msg + ": expected " + expected + ", got " + actual);
        }
    }

    var obj = {a: 1};

    // Reflect.get
    assertEqual(Reflect.get(obj, 'a'), 1, "Reflect.get existing property");
    assertEqual(Reflect.get(obj, 'b'), undefined, "Reflect.get non-existing property");

    // Reflect.set
    var setRes = Reflect.set(obj, 'b', 2);
    assertEqual(setRes, true, "Reflect.set returns true");
    assertEqual(obj.b, 2, "Reflect.set modifies object");

    // Reflect.has
    assertEqual(Reflect.has(obj, 'a'), true, "Reflect.has existing property");
    assertEqual(Reflect.has(obj, 'c'), false, "Reflect.has non-existing property");

    // Reflect.deleteProperty
    var delRes = Reflect.deleteProperty(obj, 'b');
    assertEqual(delRes, true, "Reflect.deleteProperty returns true");
    assertEqual(obj.b, undefined, "Reflect.deleteProperty modifies object");
    assertEqual(Reflect.has(obj, 'b'), false, "Reflect.has after delete");

    // Reflect.ownKeys
    var keys = Reflect.ownKeys(obj);
    assertEqual(keys.length, 1, "Reflect.ownKeys length");
    assertEqual(keys[0], 'a', "Reflect.ownKeys value");

    // Reflect.apply
    function add(x, y) { return this.val + x + y; }
    var applyRes = Reflect.apply(add, {val: 10}, [1, 2]);
    assertEqual(applyRes, 13, "Reflect.apply");

    // Reflect.construct
    function Person(name) { this.name = name; }
    var p = Reflect.construct(Person, ['John']);
    assertEqual(p.name, 'John', "Reflect.construct");
    assertEqual(p instanceof Person, true, "Reflect.construct instanceof");

    // Reflect with Proxy
    var proxyObj = new Proxy({a: 10}, {
        get: function(target, prop, receiver) {
            if (prop === 'a') return target[prop] * 2;
            return Reflect.get(target, prop, receiver);
        },
        has: function(target, prop) {
            if (prop === 'b') return true;
            return Reflect.has(target, prop);
        }
    });

    assertEqual(Reflect.get(proxyObj, 'a'), 20, "Reflect.get via Proxy");
    assertEqual(Reflect.has(proxyObj, 'b'), true, "Reflect.has via Proxy");

    if (errors.length === 0) {
        Response.Write("<p style='color: green;'>All Reflect tests passed!</p>");
    } else {
        Response.Write("<p style='color: red;'>Errors occurred:</p><ul>");
        for (var i = 0; i < errors.length; i++) {
            Response.Write("<li>" + errors[i] + "</li>");
        }
        Response.Write("</ul>");
    }
%>