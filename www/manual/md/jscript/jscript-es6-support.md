# Use Modern ES6 Features in AxonASP JScript

## Overview

This page tracks the initial JScript modernization phase for AxonASP. The list below documents the 15 implemented features from the three implementation waves.

---

## 1. Template Literals

**Status:** IMPLEMENTED

Backtick strings support interpolation with `${...}` and multiline text.

```asp
<script runat="server" language="JScript">
var name = "AxonASP";
Response.Write(`Hello ${name}`);
</script>
```

## 2. Object Literal Property Shorthand

**Status:** IMPLEMENTED

Shorthand properties are supported when variable and property names match.

```asp
<script runat="server" language="JScript">
var x = 10;
var y = 20;
var p = { x, y };
Response.Write(p.x + "," + p.y);
</script>
```

## 3. Arrow Functions

**Status:** IMPLEMENTED

Arrow functions support concise and block bodies, with lexical `this` capture.

```asp
<script runat="server" language="JScript">
var add = (a, b) => a + b;
Response.Write(add(2, 3));
</script>
```

## 4. Default Parameter Values

**Status:** IMPLEMENTED

Function parameters can define default values directly in the signature.

```asp
<script runat="server" language="JScript">
function greet(name, msg = "Hello") { return msg + " " + name; }
Response.Write(greet("Team"));
</script>
```

## 5. String Utility Methods

**Status:** IMPLEMENTED

`includes`, `startsWith`, `endsWith`, and `repeat` are available on strings.

```asp
<script runat="server" language="JScript">
var s = "hello world";
Response.Write(s.includes("world") + "|" + s.repeat(2));
</script>
```

## 6. Number Static Utility Methods

**Status:** IMPLEMENTED

`Number.isInteger`, `Number.isNaN`, `Number.isFinite`, `Number.isSafeInteger`, `Number.parseInt`, and `Number.parseFloat` are implemented.

```asp
<script runat="server" language="JScript">
Response.Write(Number.isInteger(10) + "|" + Number.isSafeInteger(9007199254740991));
</script>
```

## 7. Object.assign / keys / values / entries

**Status:** IMPLEMENTED

Object static helpers are available for shallow copy and key/value enumeration.

```asp
<script runat="server" language="JScript">
var o = { a: 1 };
Object.assign(o, { b: 2 });
Response.Write(Object.keys(o).join(",") + "|" + Object.values(o).join(","));
</script>
```

## 8. Spread Operator in Array Literals

**Status:** IMPLEMENTED

Array literals can expand array-like sources with `...`.

```asp
<script runat="server" language="JScript">
var a = [3, 4];
var b = [1, 2, ...a, 5];
Response.Write(b.join(","));
</script>
```

## 9. Array.prototype.find / findIndex

**Status:** IMPLEMENTED

Array search helpers with callback predicates are available.

```asp
<script runat="server" language="JScript">
var arr = [3, 7, 11, 14];
Response.Write(arr.find(function(x){ return x > 10; }) + "|" + arr.findIndex(function(x){ return x > 10; }));
</script>
```

## 10. Binary and Octal Numeric Literals

**Status:** IMPLEMENTED

`0b` and `0o` literal prefixes are supported.

```asp
<script runat="server" language="JScript">
Response.Write(0b1010 + "|" + 0o744);
</script>
```

## 11. Math Extensions

**Status:** IMPLEMENTED

`Math.trunc`, `Math.sign`, and `Math.cbrt` are available.

```asp
<script runat="server" language="JScript">
Response.Write(Math.trunc(4.9) + "|" + Math.sign(-12) + "|" + Math.cbrt(27));
</script>
```

## 12. Symbol Primitive

**Status:** IMPLEMENTED

`Symbol(description)` returns unique values and can be used as collision-safe object keys.

```asp
<script runat="server" language="JScript">
var s1 = Symbol("id");
var s2 = Symbol("id");
var o = {};
o[s1] = 42;
Response.Write((s1 !== s2) + "|" + o[s1]);
</script>
```

## 13. Array.from / Array.of

**Status:** IMPLEMENTED

`Array.from` converts array-like values, and `Array.of` builds arrays from arguments.

```asp
<script runat="server" language="JScript">
var a = Array.from({ length: 2, 0: "x", 1: "y" });
var b = Array.of(7, 8, 9);
Response.Write(a.join("-") + "|" + b.join("-"));
</script>
```

## 14. Rest Parameters

**Status:** IMPLEMENTED

Functions support `...rest` in the final parameter position.

```asp
<script runat="server" language="JScript">
function pack(head, ...rest) { return head + ":" + rest.length; }
Response.Write(pack("h", 1, 2, 3));
</script>
```

## 15. Set and Map Basic Collections

**Status:** IMPLEMENTED

`Set` and `Map` support `add`/`set`, `has`, `delete`, and `clear`.

```asp
<script runat="server" language="JScript">
var s = new Set();
s.add("a");
var m = new Map();
m.set("k", 10);
Response.Write(s.has("a") + "|" + m.has("k"));
</script>
```

## 16. Property Reflection Helpers

**Status:** IMPLEMENTED

`Object.getOwnPropertyDescriptor(obj, prop)` and `Object.getOwnPropertyDescriptors(obj)` are available for descriptor-level introspection.

```asp
<script runat="server" language="JScript">
var o = {};
Object.defineProperty(o, "hidden", {
	value: 10,
	writable: false,
	enumerable: false,
	configurable: false
});
var d = Object.getOwnPropertyDescriptor(o, "hidden");
var all = Object.getOwnPropertyDescriptors(o);
Response.Write(d.value + "|" + all.hidden.writable);
</script>
```

## 17. High-Performance Array In-place Operations

**Status:** IMPLEMENTED

`Array.prototype.fill` and `Array.prototype.copyWithin` are implemented with in-place behavior and relative index normalization.

```asp
<script runat="server" language="JScript">
var buffer = Array.of(0, 0, 0, 0, 0);
buffer.fill(255, 1, 4);
buffer.copyWithin(0, 3);
Response.Write(buffer.join(","));
</script>
```

## 18. Numeric Safety Constants

**Status:** IMPLEMENTED

`Number.EPSILON`, `Number.MAX_SAFE_INTEGER`, and `Number.MIN_SAFE_INTEGER` are available and exposed as read-only constants.

```asp
<script runat="server" language="JScript">
Response.Write(Number.EPSILON + "|" + Number.MAX_SAFE_INTEGER + "|" + Number.MIN_SAFE_INTEGER);
</script>
```

## 19. Enhanced String.includes

**Status:** IMPLEMENTED

`String.prototype.includes(searchString, position)` supports the optional `position` argument and raises TypeError when `searchString` is a RegExp.

```asp
<script runat="server" language="JScript">
var ok = "hello world".includes("world", 6);
var regexError = false;
try {
	"hello".includes(new RegExp("h"));
} catch (e) {
	regexError = String(e).indexOf("TypeError") !== -1;
}
Response.Write(ok + "|" + regexError);
</script>
```

---

## Additional Notes

- `String.prototype.padStart` and `String.prototype.padEnd` are also implemented and available.
- `new Symbol()` correctly raises a TypeError.
- Symbol-keyed object properties are intentionally hidden from `Object.keys`, `Object.values`, and `Object.entries` in this phase to reduce collision risks in legacy code.
- `Object.getOwnPropertyDescriptors` returns descriptor maps for own non-internal properties and follows the same visibility constraints used by this runtime for symbol-keyed internals.
