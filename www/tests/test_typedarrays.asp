<%@ Language="JScript" %>
<%
/*
 * AxonASP Server - Typed Arrays & Binary Data Test Page
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 */

// --- ArrayBuffer ---
var buf = new ArrayBuffer(8);
Response.Write("ArrayBuffer.byteLength=" + buf.byteLength + "\n");

// ArrayBuffer.isView
var u8 = new Uint8Array(buf);
Response.Write("ArrayBuffer.isView(Uint8Array)=" + ArrayBuffer.isView(u8) + "\n");
Response.Write("ArrayBuffer.isView({})=" + ArrayBuffer.isView({}) + "\n");

// --- Uint8Array ---
var a = new Uint8Array(4);
a[0] = 10; a[1] = 20; a[2] = 30; a[3] = 40;
Response.Write("Uint8Array[0..3]=" + a[0] + "," + a[1] + "," + a[2] + "," + a[3] + "\n");
Response.Write("Uint8Array.length=" + a.length + "\n");
Response.Write("Uint8Array.byteLength=" + a.byteLength + "\n");
Response.Write("Uint8Array.byteOffset=" + a.byteOffset + "\n");

// --- Uint8ClampedArray ---
var c = new Uint8ClampedArray(2);
c[0] = 300;  // clamped to 255
c[1] = -5;   // clamped to 0
Response.Write("Uint8ClampedArray.clamp(300)=" + c[0] + "\n");
Response.Write("Uint8ClampedArray.clamp(-5)=" + c[1] + "\n");

// --- Int32Array ---
var i32 = new Int32Array([100, -200, 300]);
Response.Write("Int32Array[1]=" + i32[1] + "\n");
Response.Write("Int32Array.byteLength=" + i32.byteLength + "\n");

// --- Float64Array ---
var f64 = new Float64Array(2);
f64[0] = 3.14;
f64[1] = 2.718;
Response.Write("Float64Array[0]=" + f64[0] + "\n");

// --- TypedArray.set ---
var dest = new Uint8Array(4);
dest.set([11, 22, 33, 44]);
Response.Write("TypedArray.set=" + dest[0] + "," + dest[1] + "," + dest[2] + "," + dest[3] + "\n");

// --- TypedArray.fill ---
var filled = new Uint8Array(3);
filled.fill(7);
Response.Write("TypedArray.fill=" + filled[0] + "," + filled[1] + "," + filled[2] + "\n");

// --- TypedArray.subarray ---
var src = new Uint8Array([1, 2, 3, 4, 5]);
var sub = src.subarray(1, 4);
Response.Write("TypedArray.subarray.length=" + sub.length + "\n");
Response.Write("TypedArray.subarray[0]=" + sub[0] + "\n");

// --- ArrayBuffer.slice ---
var buf2 = new ArrayBuffer(6);
var dv2 = new DataView(buf2);
dv2.setUint8(0, 1); dv2.setUint8(1, 2); dv2.setUint8(2, 3);
dv2.setUint8(3, 4); dv2.setUint8(4, 5); dv2.setUint8(5, 6);
var sliced = buf2.slice(2, 5);
var dvSliced = new DataView(sliced);
Response.Write("ArrayBuffer.slice.byteLength=" + sliced.byteLength + "\n");
Response.Write("ArrayBuffer.slice[0]=" + dvSliced.getUint8(0) + "\n");

// --- DataView ---
var db = new ArrayBuffer(16);
var dv = new DataView(db);
dv.setInt8(0, -42);
dv.setUint8(1, 200);
dv.setInt16(2, 0x0102, true);  // little-endian
dv.setInt32(4, 123456789, false); // big-endian
dv.setFloat64(8, 3.14159265, true);
Response.Write("DataView.getInt8=" + dv.getInt8(0) + "\n");
Response.Write("DataView.getUint8=" + dv.getUint8(1) + "\n");
Response.Write("DataView.getInt16(LE)=" + dv.getInt16(2, true) + "\n");
Response.Write("DataView.getInt32(BE)=" + dv.getInt32(4, false) + "\n");
var pi = dv.getFloat64(8, true);
Response.Write("DataView.getFloat64~Pi=" + (pi > 3.14 && pi < 3.15) + "\n");

// --- for..of on typed array ---
var fa = new Uint8Array([10, 20, 30]);
var sum = 0;
for (var v of fa) { sum += v; }
Response.Write("TypedArray.forOf.sum=" + sum + "\n");

// --- Well-Known Symbols ---
Response.Write("typeof Symbol.iterator=" + (typeof Symbol.iterator) + "\n");
Response.Write("typeof Symbol.toStringTag=" + (typeof Symbol.toStringTag) + "\n");
Response.Write("typeof Symbol.species=" + (typeof Symbol.species) + "\n");
Response.Write("typeof Symbol.hasInstance=" + (typeof Symbol.hasInstance) + "\n");
Response.Write("typeof Symbol.toPrimitive=" + (typeof Symbol.toPrimitive) + "\n");

// --- Symbol.for / Symbol.keyFor ---
var s1 = Symbol.for("appKey");
var s2 = Symbol.for("appKey");
Response.Write("Symbol.for.same=" + (s1 === s2) + "\n");
Response.Write("Symbol.keyFor=" + Symbol.keyFor(s1) + "\n");
var sLocal = Symbol("local");
Response.Write("Symbol.keyFor.unregistered=" + (Symbol.keyFor(sLocal) === undefined) + "\n");

Response.Write("DONE\n");
%>