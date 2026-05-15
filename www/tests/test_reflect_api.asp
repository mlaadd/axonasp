<%@ Language="JavaScript" %>
<%
/*
 * AxonASP Reflect and Proxy Trap Test
 */

function assert(condition, message) {
    if (!condition) {
        Response.Write("FAIL: " + message + "<br>");
    } else {
        Response.Write("PASS: " + message + "<br>");
    }
}

// 1. Reflect.defineProperty
var obj1 = {};
var s1 = Reflect.defineProperty(obj1, "a", {value: 42, writable: true});
assert(s1 === true && obj1.a === 42, "Reflect.defineProperty basic");

// 2. Reflect.getOwnPropertyDescriptor
var obj2 = {a: 100};
var d2 = Reflect.getOwnPropertyDescriptor(obj2, "a");
assert(d2.value === 100 && d2.writable === true, "Reflect.getOwnPropertyDescriptor");

// 3. Reflect.getPrototypeOf
var proto3 = {p: 1};
var obj3 = Object.create(proto3);
assert(Reflect.getPrototypeOf(obj3) === proto3, "Reflect.getPrototypeOf");

// 4. Reflect.isExtensible
var obj4 = {};
assert(Reflect.isExtensible(obj4) === true, "Reflect.isExtensible initially true");
Reflect.preventExtensions(obj4);
assert(Reflect.isExtensible(obj4) === false, "Reflect.isExtensible false after preventExtensions");

// 5. Reflect.setPrototypeOf
var obj5 = {};
var proto5 = {z: 999};
Reflect.setPrototypeOf(obj5, proto5);
assert(obj5.z === 999, "Reflect.setPrototypeOf");

// 6. Proxy Traps with Reflect
var target6 = {count: 0};
var p6 = new Proxy(target6, {
    defineProperty: function(t, k, d) {
        if (k === "forbidden") return false;
        return Reflect.defineProperty(t, k, d);
    },
    getPrototypeOf: function(t) {
        return {mocked: true};
    }
});

assert(Reflect.defineProperty(p6, "allowed", {value: 1}) === true, "Proxy defineProperty trap allowed");
assert(target6.allowed === 1, "Proxy defineProperty trap target updated");
assert(Reflect.defineProperty(p6, "forbidden", {value: 1}) === false, "Proxy defineProperty trap forbidden");
assert(Reflect.getPrototypeOf(p6).mocked === true, "Proxy getPrototypeOf trap");

// 7. Object.defineProperty with Proxy
var target7 = {a: 1};
var p7 = new Proxy(target7, {
    defineProperty: function(t, k, d) {
        if (k === "forbidden") return false;
        return Reflect.defineProperty(t, k, d);
    }
});
Object.defineProperty(p7, "a", {value: 2});
assert(target7.a === 2, "Object.defineProperty on Proxy success");
try {
    Object.defineProperty(p7, "forbidden", {value: 3});
    assert(false, "Object.defineProperty on Proxy should have failed");
} catch(e) {
    assert(true, "Object.defineProperty on Proxy failed correctly: " + e.message);
}

// 8. Object.getOwnPropertyDescriptor with Proxy
var p8 = new Proxy({a: 1}, {
    getOwnPropertyDescriptor: function(t, k) {
        return {value: 999, configurable: true, writable: true, enumerable: true};
    }
});
var d8 = Object.getOwnPropertyDescriptor(p8, "any");
assert(d8 && d8.value === 999, "Object.getOwnPropertyDescriptor on Proxy");

// 9. Object.isExtensible / preventExtensions with Proxy
var extensible9 = true;
var p9 = new Proxy({}, {
    isExtensible: function(t) { return extensible9; },
    preventExtensions: function(t) { extensible9 = false; return true; }
});
assert(Object.isExtensible(p9) === true, "Object.isExtensible on Proxy");
Object.preventExtensions(p9);
assert(Object.isExtensible(p9) === false, "Object.preventExtensions on Proxy");

Response.Write("REFLECT AND PROXY TRAP TEST COMPLETED<br>");
%>
