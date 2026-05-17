<%
' AxonASP Server
' Phase 5 – Proxy/Reflect Invariant Tests (ECMAScript 6 §10.5)
' Run with: axonasp-cli.exe -r www/tests/test_proxy_invariants.asp
%>
<script language="javascript" runat="server">
(function() {
    var pass = 0;
    var fail = 0;

    function assert(label, condition) {
        if (condition) {
            Response.Write("[PASS] " + label + "\n");
            pass++;
        } else {
            Response.Write("[FAIL] " + label + "\n");
            fail++;
        }
    }

    function expectError(label, fn, fragment) {
        try {
            fn();
            Response.Write("[FAIL] " + label + " (no error thrown)\n");
            fail++;
        } catch (e) {
            if (e.message.indexOf(fragment) !== -1) {
                Response.Write("[PASS] " + label + "\n");
                pass++;
            } else {
                Response.Write("[FAIL] " + label + " (wrong error: " + e.message + ")\n");
                fail++;
            }
        }
    }

    // -----------------------------------------------------------------------
    // Subphase 5.1 – Trap Validation Engine
    // -----------------------------------------------------------------------

    // get: non-configurable non-writable must return exact value
    expectError("get: non-configurable non-writable wrong value", function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 42, writable: false, configurable: false });
        var p = new Proxy(t, { get: function() { return 99; } });
        var v = p.x;
    }, "invariant");

    // get: same value is OK
    (function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 42, writable: false, configurable: false });
        var p = new Proxy(t, { get: function() { return 42; } });
        assert("get: non-configurable non-writable same value OK", p.x === 42);
    })();

    // get: accessor no getter must return undefined
    expectError("get: non-configurable no-getter accessor must be undefined", function() {
        var t = {};
        Object.defineProperty(t, "x", { set: function(v){}, configurable: false });
        var p = new Proxy(t, { get: function() { return 1; } });
        var v = p.x;
    }, "invariant");

    // has: non-configurable cannot be absent
    expectError("has: non-configurable property cannot be hidden", function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 1, configurable: false });
        var p = new Proxy(t, { has: function() { return false; } });
        return ("x" in p);
    }, "invariant");

    // has: non-extensible target own property cannot be hidden
    expectError("has: non-extensible target own key cannot be hidden", function() {
        var t = { x: 1 };
        Object.preventExtensions(t);
        var p = new Proxy(t, { has: function() { return false; } });
        return ("x" in p);
    }, "invariant");

    // has: configurable property can be hidden
    (function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 1, configurable: true });
        var p = new Proxy(t, { has: function() { return false; } });
        assert("has: configurable property can be hidden", !("x" in p));
    })();

    // set: non-configurable non-writable different value
    expectError("set: non-configurable non-writable different value", function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 42, writable: false, configurable: false });
        var p = new Proxy(t, { set: function() { return true; } });
        p.x = 99;
    }, "invariant");

    // set: same value OK
    (function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 42, writable: false, configurable: false });
        var p = new Proxy(t, { set: function() { return true; } });
        p.x = 42;
        assert("set: non-configurable non-writable same value OK", true);
    })();

    // deleteProperty: non-configurable
    expectError("deleteProperty: cannot delete non-configurable property", function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 1, configurable: false });
        var p = new Proxy(t, { deleteProperty: function() { return true; } });
        delete p.x;
    }, "invariant");

    // ownKeys: must include non-configurable keys
    expectError("ownKeys: must include non-configurable keys", function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 1, configurable: false });
        var p = new Proxy(t, { ownKeys: function() { return []; } });
        Object.getOwnPropertyNames(p);
    }, "invariant");

    // ownKeys: non-extensible target, extra key not allowed
    expectError("ownKeys: non-extensible target cannot add extra keys", function() {
        var t = { a: 1 };
        Object.preventExtensions(t);
        var p = new Proxy(t, { ownKeys: function() { return ["a", "b"]; } });
        Object.getOwnPropertyNames(p);
    }, "invariant");

    // defineProperty: non-extensible target, new property
    // (use Reflect.defineProperty — Object.defineProperty wraps errors differently)
    expectError("defineProperty: non-extensible target, new property", function() {
        var t = {};
        Object.preventExtensions(t);
        var p = new Proxy(t, { defineProperty: function() { return true; } });
        Reflect.defineProperty(p, "x", { value: 1, configurable: true });
    }, "invariant");

    // getOwnPropertyDescriptor: hide non-configurable
    expectError("getOwnPropertyDescriptor: cannot hide non-configurable", function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 1, configurable: false });
        var p = new Proxy(t, { getOwnPropertyDescriptor: function() { return undefined; } });
        Object.getOwnPropertyDescriptor(p, "x");
    }, "invariant");

    // getOwnPropertyDescriptor: report non-configurable as configurable
    expectError("getOwnPropertyDescriptor: cannot report configurable for non-configurable", function() {
        var t = {};
        Object.defineProperty(t, "x", { value: 1, configurable: false, writable: false });
        var p = new Proxy(t, {
            getOwnPropertyDescriptor: function() {
                return { value: 1, configurable: true, writable: false, enumerable: false };
            }
        });
        Object.getOwnPropertyDescriptor(p, "x");
    }, "invariant");

    // -----------------------------------------------------------------------
    // Subphase 5.2 – Prototype & Extensibility Safety
    // -----------------------------------------------------------------------

    // getPrototypeOf: non-extensible must return same prototype
    expectError("getPrototypeOf: non-extensible different prototype", function() {
        var proto = {};
        var t = Object.create(proto);
        Object.preventExtensions(t);
        var different = {};
        var p = new Proxy(t, { getPrototypeOf: function() { return different; } });
        Object.getPrototypeOf(p);
    }, "invariant");

    // getPrototypeOf: same prototype is OK
    (function() {
        var proto = {};
        var t = Object.create(proto);
        Object.preventExtensions(t);
        var p = new Proxy(t, { getPrototypeOf: function(target) { return Object.getPrototypeOf(target); } });
        assert("getPrototypeOf: non-extensible same prototype OK", Object.getPrototypeOf(p) === proto);
    })();

    // setPrototypeOf: non-extensible different prototype
    // (use Reflect.setPrototypeOf — Object.setPrototypeOf wraps errors differently)
    expectError("setPrototypeOf: non-extensible cannot change prototype", function() {
        var proto = {};
        var t = Object.create(proto);
        Object.preventExtensions(t);
        var newProto = {};
        var p = new Proxy(t, { setPrototypeOf: function() { return true; } });
        Reflect.setPrototypeOf(p, newProto);
    }, "invariant");

    // setPrototypeOf: non-extensible same prototype OK
    (function() {
        var proto = {};
        var t = Object.create(proto);
        Object.preventExtensions(t);
        var p = new Proxy(t, { setPrototypeOf: function() { return true; } });
        Object.setPrototypeOf(p, proto);
        assert("setPrototypeOf: non-extensible same prototype OK", true);
    })();

    // preventExtensions: trap returns true but target still extensible
    expectError("preventExtensions: trap true but target still extensible", function() {
        var t = {};
        var p = new Proxy(t, {
            preventExtensions: function(target) {
                // intentionally omit Object.preventExtensions(target)
                return true;
            }
        });
        Object.preventExtensions(p);
    }, "invariant");

    // preventExtensions: well-behaved trap
    (function() {
        var t = {};
        var p = new Proxy(t, {
            preventExtensions: function(target) {
                Object.preventExtensions(target);
                return true;
            }
        });
        Object.preventExtensions(p);
        assert("preventExtensions: well-behaved trap OK", !Object.isExtensible(t));
    })();

    // isExtensible: regression – must match target
    expectError("isExtensible: must match target (regression)", function() {
        var t = {};
        Object.preventExtensions(t);
        var p = new Proxy(t, { isExtensible: function() { return true; } });
        Object.isExtensible(p);
    }, "");

    // -----------------------------------------------------------------------
    Response.Write("\n--- Phase 5 Results: " + pass + " passed, " + fail + " failed ---\n");
})();
</script>
