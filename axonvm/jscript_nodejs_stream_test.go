/*
 * AxonASP Server
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 *
 * Developed by Lucas Guimaraes - G3pix Ltda
 * Contact: https://g3pix.com.br
 * Project URL: https://g3pix.com.br/axonasp
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */
package axonvm

import "testing"

func TestJScriptStreamRequire(t *testing.T) {
	source := jscriptSrc(`
		var stream = require("stream");
		Response.Write(typeof stream === "object" ? "1" : "0");
		Response.Write(typeof stream.Readable === "function" ? "1" : "0");
		Response.Write(typeof stream.Writable === "function" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "111" {
		t.Fatalf("expected '111', got %q", out)
	}
}

func TestJScriptStreamReadablePull(t *testing.T) {
	source := jscriptSrc(`
		var stream = require("stream");
		var r = new stream.Readable({ source: ["a", "b"] });
		var c1 = r.read();
		var c2 = r.read();
		var c3 = r.read();
		var w = new stream.Writable();
		w.write(c1);
		w.write(c2);
		w.end();
		Response.Write(w.getData("utf8") === "ab" ? "1" : "0");
		Response.Write(c3 === null ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "11" {
		t.Fatalf("expected '11', got %q", out)
	}
}

func TestJScriptStreamWritableCollect(t *testing.T) {
	source := jscriptSrc(`
		var stream = require("stream");
		var w = new stream.Writable();
		w.write("ab");
		w.write(Buffer.from("cd"));
		w.end();
		Response.Write(w.getData("utf8") === "abcd" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

func TestJScriptStreamPipeReadableToWritable(t *testing.T) {
	source := jscriptSrc(`
		var stream = require("stream");
		var r = new stream.Readable({ source: ["ax", "on"] });
		var w = new stream.Writable();
		r.pipe(w);
		Response.Write(w.getData("utf8") === "axon" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}

func TestJScriptStreamTransform(t *testing.T) {
	source := jscriptSrc(`
		var stream = require("stream");
		var t = new stream.Transform();
		t._transform = function (chunk) {
			return String(chunk).toUpperCase();
		};
		t.write("ab");
		t.end("cd");
		Response.Write(t.getData("utf8") === "ABCD" ? "1" : "0");
	`)
	out, err := runJScript2(t, source)
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if out != "1" {
		t.Fatalf("expected '1', got %q", out)
	}
}
