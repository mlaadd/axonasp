/*
 * AxonASP Server
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 *
 * Developed by Lucas Guimarães - G3pix Ltda
 * Contact: https://g3pix.com.br
 * Project URL: https://g3pix.com.br/axonasp
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * Attribution Notice:
 * If this software is used in other projects, the name "AxonASP Server"
 * must be cited in the documentation or "About" section.
 *
 * Contribution Policy:
 * Modifications to the core source code of AxonASP Server must be
 * made available under this same license terms.
 */
package axonvm

import (
	"testing"
)

// TestJScriptEventEmitterRequire verifies that require("events") returns an object
// containing the EventEmitter constructor.
func TestJScriptEventEmitterRequire(t *testing.T) {
	source := jscriptSrc(`
		var events = require("events");
		Response.Write(typeof events === "object" ? "1" : "0");
		Response.Write(typeof events.EventEmitter === "function" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "11" {
		t.Fatalf("expected '11', got %q", out)
	}
}

// TestJScriptEventEmitterOnEmit verifies that on() registers a listener and emit()
// triggers it with the correct arguments.
func TestJScriptEventEmitterOnEmit(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var received = "";
		ee.on("data", function(msg) { received = msg; });
		ee.emit("data", "hello");
		Response.Write(received === "hello" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterEmitReturnValue verifies emit() returns true when listeners
// exist and false when no listeners are registered.
func TestJScriptEventEmitterEmitReturnValue(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		ee.on("data", function() {});
		Response.Write(ee.emit("data") === true ? "1" : "0");
		Response.Write(ee.emit("unknown") === false ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "11" {
		t.Fatalf("expected '11', got %q", out)
	}
}

// TestJScriptEventEmitterOnce verifies that once() listeners fire exactly once.
func TestJScriptEventEmitterOnce(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var count = 0;
		ee.once("ping", function() { count++; });
		ee.emit("ping");
		ee.emit("ping");
		ee.emit("ping");
		Response.Write(count === 1 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterRemoveListener verifies that removeListener() removes exactly
// one matching listener.
func TestJScriptEventEmitterRemoveListener(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var count = 0;
		function inc() { count++; }
		ee.on("tick", inc);
		ee.on("tick", inc);
		ee.removeListener("tick", inc);
		ee.emit("tick");
		Response.Write(count === 1 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterOff verifies that off() is an alias for removeListener().
func TestJScriptEventEmitterOff(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var fired = false;
		function handler() { fired = true; }
		ee.on("go", handler);
		ee.off("go", handler);
		ee.emit("go");
		Response.Write(fired === false ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterRemoveAllListeners verifies that removeAllListeners() removes
// all listeners for a given event, or all events when called with no arguments.
func TestJScriptEventEmitterRemoveAllListeners(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var a = 0, b = 0;
		ee.on("foo", function() { a++; });
		ee.on("bar", function() { b++; });
		ee.removeAllListeners("foo");
		ee.emit("foo");
		ee.emit("bar");
		Response.Write(a === 0 ? "1" : "0");
		Response.Write(b === 1 ? "1" : "0");
		ee.removeAllListeners();
		ee.emit("bar");
		Response.Write(b === 1 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "111" {
		t.Fatalf("expected '111', got %q", out)
	}
}

// TestJScriptEventEmitterListenerCount verifies that listenerCount() returns the
// correct number of listeners registered for an event.
func TestJScriptEventEmitterListenerCount(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		ee.on("x", function() {});
		ee.on("x", function() {});
		ee.on("x", function() {});
		Response.Write(ee.listenerCount("x") === 3 ? "1" : "0");
		Response.Write(ee.listenerCount("y") === 0 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "11" {
		t.Fatalf("expected '11', got %q", out)
	}
}

// TestJScriptEventEmitterListeners verifies that listeners() returns a copy of the
// listeners array, with once() wrappers returning the original function.
func TestJScriptEventEmitterListeners(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		function fn1() {}
		function fn2() {}
		ee.on("ev", fn1);
		ee.once("ev", fn2);
		var list = ee.listeners("ev");
		Response.Write(list.length === 2 ? "1" : "0");
		Response.Write(list[0] === fn1 ? "1" : "0");
		Response.Write(list[1] === fn2 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "111" {
		t.Fatalf("expected '111', got %q", out)
	}
}

// TestJScriptEventEmitterEventNames verifies that eventNames() returns an array of
// event names for which there are registered listeners.
func TestJScriptEventEmitterEventNames(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		ee.on("alpha", function() {});
		ee.on("beta", function() {});
		var names = ee.eventNames();
		Response.Write(names.length === 2 ? "1" : "0");
		Response.Write(names.indexOf("alpha") !== -1 ? "1" : "0");
		Response.Write(names.indexOf("beta") !== -1 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "111" {
		t.Fatalf("expected '111', got %q", out)
	}
}

// TestJScriptEventEmitterSetGetMaxListeners verifies setMaxListeners/getMaxListeners.
func TestJScriptEventEmitterSetGetMaxListeners(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		ee.setMaxListeners(20);
		Response.Write(ee.getMaxListeners() === 20 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterDefaultMaxListeners verifies EventEmitter.defaultMaxListeners.
func TestJScriptEventEmitterDefaultMaxListeners(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		Response.Write(EventEmitter.defaultMaxListeners === 10 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterStaticListenerCount verifies the static
// EventEmitter.listenerCount(emitter, event) helper.
func TestJScriptEventEmitterStaticListenerCount(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		ee.on("x", function() {});
		ee.on("x", function() {});
		Response.Write(EventEmitter.listenerCount(ee, "x") === 2 ? "1" : "0");
		Response.Write(EventEmitter.listenerCount(ee, "y") === 0 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "11" {
		t.Fatalf("expected '11', got %q", out)
	}
}

// TestJScriptEventEmitterPrependListener verifies that prependListener() adds the
// listener at the front of the array.
func TestJScriptEventEmitterPrependListener(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var order = [];
		ee.on("go", function() { order.push("second"); });
		ee.prependListener("go", function() { order.push("first"); });
		ee.emit("go");
		Response.Write(order[0] === "first" ? "1" : "0");
		Response.Write(order[1] === "second" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "11" {
		t.Fatalf("expected '11', got %q", out)
	}
}

// TestJScriptEventEmitterPrependOnceListener verifies prependOnceListener() fires once
// and at the front of the listener queue.
func TestJScriptEventEmitterPrependOnceListener(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var order = [];
		ee.on("ev", function() { order.push("on"); });
		ee.prependOnceListener("ev", function() { order.push("once"); });
		ee.emit("ev");
		ee.emit("ev");
		Response.Write(order[0] === "once" ? "1" : "0");
		Response.Write(order[1] === "on" ? "1" : "0");
		Response.Write(order.length === 3 ? "1" : "0");
		Response.Write(order[2] === "on" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1111" {
		t.Fatalf("expected '1111', got %q", out)
	}
}

// TestJScriptEventEmitterUnhandledError verifies that emitting "error" without a
// listener throws.
func TestJScriptEventEmitterUnhandledError(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var threw = false;
		try { ee.emit("error", new Error("boom")); } catch(e) { threw = true; }
		Response.Write(threw ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterHandledError verifies that emitting "error" with a listener
// does NOT throw.
func TestJScriptEventEmitterHandledError(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var msg = "";
		ee.on("error", function(err) { msg = err.message; });
		ee.emit("error", new Error("handled"));
		Response.Write(msg === "handled" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterMultipleArgs verifies emit() forwards multiple arguments.
func TestJScriptEventEmitterMultipleArgs(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var sum = 0;
		ee.on("add", function(a, b, c) { sum = a + b + c; });
		ee.emit("add", 1, 2, 3);
		Response.Write(sum === 6 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterChaining verifies that on()/once()/removeListener() return
// the emitter for fluent chaining.
func TestJScriptEventEmitterChaining(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		function noop() {}
		var r1 = ee.on("x", noop);
		var r2 = ee.once("x", noop);
		var r3 = ee.removeListener("x", noop);
		Response.Write(r1 === ee ? "1" : "0");
		Response.Write(r2 === ee ? "1" : "0");
		Response.Write(r3 === ee ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "111" {
		t.Fatalf("expected '111', got %q", out)
	}
}

// TestJScriptEventEmitterInheritance verifies that a class can extend EventEmitter
// using EventEmitter.inherits().
func TestJScriptEventEmitterInheritance(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		function MyEmitter() { EventEmitter.call(this); }
		EventEmitter.inherits(MyEmitter);
		var me = new MyEmitter();
		var fired = false;
		me.on("custom", function() { fired = true; });
		me.emit("custom");
		Response.Write(fired ? "1" : "0");
		Response.Write(me instanceof MyEmitter ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "11" {
		t.Fatalf("expected '11', got %q", out)
	}
}

// TestJScriptEventEmitterRequireNodePrefix verifies that "node:events" resolves to
// the same module as "events".
func TestJScriptEventEmitterRequireNodePrefix(t *testing.T) {
	source := jscriptSrc(`
		var events = require("node:events");
		Response.Write(typeof events.EventEmitter === "function" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterAddListenerAlias verifies that addListener() is an alias
// for on().
func TestJScriptEventEmitterAddListenerAlias(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		var count = 0;
		ee.addListener("tick", function() { count++; });
		ee.emit("tick");
		Response.Write(count === 1 ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

// TestJScriptEventEmitterRawListeners verifies that rawListeners() returns the
// internal wrappers (including once() wrappers).
func TestJScriptEventEmitterRawListeners(t *testing.T) {
	source := jscriptSrc(`
		var EventEmitter = require("events").EventEmitter;
		var ee = new EventEmitter();
		function fn() {}
		ee.once("ev", fn);
		var raw = ee.rawListeners("ev");
		Response.Write(raw.length === 1 ? "1" : "0");
		// raw[0] is the wrapper function, not fn itself
		Response.Write(raw[0] !== fn ? "1" : "0");
		// but listeners() returns the unwrapped original
		var wrapped = ee.listeners("ev");
		Response.Write(wrapped[0] === fn ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "111" {
		t.Fatalf("expected '111', got %q", out)
	}
}

// TestJScriptEventEmitterNodeCompatOff verifies that require("events") throws when
// Node.js compatibility is disabled.
// This is an integration test that requires config teardown — skipped in unit mode.
func TestJScriptEventEmitterNodeCompatOff(t *testing.T) {
	t.Skip("Integration test - requires config teardown/setup")
}
