# Use ES6 Features in JScript Scripts

## Overview

AxonASP's JScript engine supports a subset of ECMAScript 6 (ES6) language features in addition to the base ECMAScript 5 (JScript) support. This page documents the supported ES6 additions: template literals, arrow functions, default parameter values, spread in array literals, `Object` static utilities, ES6 `String` methods, ES6 `Number` static methods, binary and octal numeric literals, and `Math` extensions.

All ES6 features described here are available in `<script runat="server" language="JScript">` blocks and in `<% language="JScript" %>` inline blocks.

---

## Template Literals

### Syntax

```javascript
var result = `static text ${expression} more static text`;
```

Template literals are enclosed in backticks (`` ` ``). They support embedded expressions using `${expression}` placeholders and preserve literal newlines.

### Remarks

- All `${expression}` placeholders are evaluated at runtime and coerced to strings using standard JScript string coercion.
- Multiple expressions can be embedded in a single template literal.
- Multi-line template literals preserve embedded newline characters.
- Tagged template literals are not supported. A tagged template (e.g., `` tag`...` ``) resolves to `undefined`.

### Code Example

```javascript
<%
var name = "World";
var count = 42;
var msg = `Hello, ${name}! You have ${count} messages.`;
Response.Write(msg);
// Output: Hello, World! You have 42 messages.

var a = 3, b = 4;
Response.Write(`Sum: ${a + b}`);
// Output: Sum: 7
%>
```

---

## Arrow Functions

### Syntax

```javascript
// Concise body (expression result is implicitly returned)
var fn = (param1, param2) => expression;

// Block body
var fn = (param1, param2) => {
    // statements
    return value;
};
```

### Remarks

- Arrow functions do not create their own `this` binding. The value of `this` is captured **lexically** from the enclosing scope at the time the arrow function is created. This is useful for callbacks inside constructor methods.
- Arrow functions cannot be used as constructors. Using `new` with an arrow function is not supported.
- Single-parameter arrow functions without parentheses (e.g., `x => x * 2`) are supported.
- Arrow functions have an `arguments` object bound to the enclosing function's `arguments`, not their own.

### Code Example

```javascript
<script runat="server" language="JScript">
// Concise arrow function
var square = (x) => x * x;
Response.Write(square(5));
// Output: 25

// Lexical this in a constructor
function Timer() {
    this.seconds = 0;
    this.tick = function() {
        var increment = () => { this.seconds = this.seconds + 1; };
        increment();
    };
}
var t = new Timer();
t.tick();
t.tick();
Response.Write(t.seconds);
// Output: 2
</script>
```

---

## Default Parameter Values

### Syntax

```javascript
function greet(name, message = "Hello") {
    return message + ", " + name + "!";
}
```

### Remarks

- Native default parameter syntax is supported (for example, `function f(a = 10)`).
- The classic guard pattern `if (x === undefined) x = ...` is still supported and remains useful for compatibility-oriented scripts.

### Code Example

```javascript
<script runat="server" language="JScript">
function multiply(a, b = 2) {
    return a * b;
}
Response.Write(multiply(5));      // Output: 10
Response.Write(multiply(5, 3));   // Output: 15
</script>
```

---

## Object Static Utilities

The following `Object` static methods are available.

### `Object.assign(target, ...sources)`

Copies enumerable own properties from each source object into `target`, from left to right, and returns `target`.

### `Object.keys(object)`

Returns an array of enumerable own property names.

### `Object.values(object)`

Returns an array of enumerable own property values.

### `Object.entries(object)`

Returns an array where each item is a two-element `[key, value]` pair for each enumerable own property.

### Remarks

- `Object.assign` skips `null` and `undefined` sources.
- `Object.keys`, `Object.values`, and `Object.entries` throw a JScript `TypeError` when called with `null` or `undefined`.
- Return values are standard JScript arrays (`VTArray` in the VM) and are compatible with existing array operations.

### Code Example

```javascript
<script runat="server" language="JScript">
var target = { a: 1 };
Object.assign(target, { b: 2 }, { c: 3 });

Response.Write(Object.keys(target).join(","));
// Output: a,b,c

Response.Write(Object.values(target).join(","));
// Output: 1,2,3

var e = Object.entries(target);
Response.Write(e[0][0] + ":" + e[0][1]);
// Output: a:1
</script>
```

---

## Spread in Array Literals

### Syntax

```javascript
var out = [1, 2, ...otherArray, 5];
```

### Remarks

- Spread in array literals expands one source array-like value into individual elements.
- `null` and `undefined` spread sources raise a JScript `TypeError`.
- Evaluation order is preserved left to right.

### Code Example

```javascript
<script runat="server" language="JScript">
var src = [3, 4];
var out = [1, 2, ...src, 5];
Response.Write(out.join(","));
// Output: 1,2,3,4,5
</script>
```

---

## Array Search Utilities

### `Array.prototype.find(callback[, thisArg])`

Returns the first element that satisfies `callback`. Returns `undefined` when no element matches.

### `Array.prototype.findIndex(callback[, thisArg])`

Returns the index of the first element that satisfies `callback`. Returns `-1` when no element matches.

### Code Example

```javascript
<script runat="server" language="JScript">
var arr = [3, 7, 11, 14];
Response.Write(arr.find(function (x) { return x > 10; }));
// Output: 11
Response.Write(arr.findIndex(function (x) { return x > 10; }));
// Output: 2
</script>
```

---

## ES6 String Methods

The following methods are available on `String` values.

### `String.prototype.includes(searchString)`

Returns `true` if `searchString` is found anywhere within the string; `false` otherwise. Case-sensitive.

### `String.prototype.startsWith(searchString)`

Returns `true` if the string begins with `searchString`; `false` otherwise. Case-sensitive.

### `String.prototype.endsWith(searchString)`

Returns `true` if the string ends with `searchString`; `false` otherwise. Case-sensitive.

### `String.prototype.repeat(count)`

Returns a new string containing `count` repetitions of the original string. Returns an empty string if `count` is 0.

### `String.prototype.padStart(targetLength, padString)`

Pads the string from the start with `padString` until the total length reaches `targetLength`. If `padString` is not supplied, spaces are used.

### `String.prototype.padEnd(targetLength, padString)`

Pads the string from the end with `padString` until the total length reaches `targetLength`. If `padString` is not supplied, spaces are used.

### Code Example

```javascript
<script runat="server" language="JScript">
var s = "Hello World";

Response.Write(s.includes("World"));     // Output: true
Response.Write(s.startsWith("Hello"));   // Output: true
Response.Write(s.endsWith("World"));     // Output: true
Response.Write("ab".repeat(3));          // Output: ababab
Response.Write("5".padStart(3, "0"));    // Output: 005
Response.Write("5".padEnd(3, "0"));      // Output: 500
</script>
```

---

## ES6 Number Static Methods

The following static methods are available on the `Number` object.

### `Number.isInteger(value)`

Returns `true` only if `value` is a number with no fractional part and is not `Infinity` or `NaN`. Does **not** coerce non-number values; non-numbers return `false`.

### `Number.isNaN(value)`

Returns `true` only if `value` is the numeric `NaN`. Does **not** coerce non-number values; non-numbers always return `false`. This differs from the global `isNaN()` function, which coerces its argument.

### `Number.isFinite(value)`

Returns `true` only if `value` is a finite number. Does **not** coerce non-number values; non-numbers always return `false`.

### `Number.isSafeInteger(value)`

Returns `true` if `value` is an integer in the range `-(2^53 - 1)` to `2^53 - 1` inclusive, and has no fractional part. Does **not** coerce non-number values.

### `Number.parseInt(string, radix)`

Equivalent to the global `parseInt()` function. Parses `string` as an integer in the specified `radix` (2–36). Defaults to base 10.

### `Number.parseFloat(string)`

Equivalent to the global `parseFloat()` function. Parses `string` as a floating-point number.

### Number Constants

The `Number` object exposes the following constants:

| Constant | Value |
|---|---|
| `Number.MAX_SAFE_INTEGER` | 9007199254740991 |
| `Number.MIN_SAFE_INTEGER` | -9007199254740991 |
| `Number.MAX_VALUE` | ~1.7976931348623157e+308 |
| `Number.MIN_VALUE` | ~5e-324 |
| `Number.EPSILON` | ~2.220446049250313e-16 |
| `Number.POSITIVE_INFINITY` | `Infinity` |
| `Number.NEGATIVE_INFINITY` | `-Infinity` |
| `Number.NaN` | `NaN` |

### Code Example

```javascript
<script runat="server" language="JScript">
Response.Write(Number.isInteger(42));          // Output: true
Response.Write(Number.isInteger(42.5));        // Output: false
Response.Write(Number.isInteger("42"));        // Output: false

Response.Write(Number.isNaN(NaN));             // Output: true
Response.Write(Number.isNaN(42));              // Output: false
Response.Write(Number.isNaN("NaN"));           // Output: false

Response.Write(Number.isFinite(100));          // Output: true
Response.Write(Number.isFinite(Infinity));     // Output: false

Response.Write(Number.isSafeInteger(9007199254740991));  // Output: true
Response.Write(Number.isSafeInteger(9007199254740992));  // Output: false

Response.Write(Number.MAX_SAFE_INTEGER);       // Output: 9007199254740991
</script>
```

---

## Binary and Octal Numeric Literals

### Syntax

```javascript
var b = 0b1010; // binary
var o = 0o744;  // octal
```

### Remarks

- Prefix `0b` or `0B` parses base-2 integer literals.
- Prefix `0o` or `0O` parses base-8 integer literals.

### Code Example

```javascript
<script runat="server" language="JScript">
Response.Write(0b1010); // Output: 10
Response.Write(0o744);  // Output: 484
</script>
```

---

## Math Extensions

The following additional methods are available on the `Math` object.

### `Math.trunc(x)`

Returns the integer part of `x` by removing the fractional digits.

### `Math.sign(x)`

Returns `1` for positive values, `-1` for negative values, and `0` for zero. Returns `NaN` for `NaN` input.

### `Math.cbrt(x)`

Returns the cube root of `x`.

### Code Example

```javascript
<script runat="server" language="JScript">
Response.Write(Math.trunc(4.9)); // Output: 4
Response.Write(Math.sign(-12));  // Output: -1
Response.Write(Math.cbrt(27));   // Output: 3
</script>
```
