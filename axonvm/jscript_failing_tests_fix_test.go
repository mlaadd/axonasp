package axonvm

import (
	"testing"
)

// TestJScriptMathPrecedenceFix verifies that unary operations (like negation) on property accessors
// (like Math.PI) do not emit duplicate base-object load instructions, ensuring the execution stack
// remains correct and comparisons succeed.
func TestJScriptMathPrecedenceFix(t *testing.T) {
	aspSrc := jscriptSrc(`
		var a = Math.atan2(-1, 0);
		var b = -Math.PI / 2;
		var direct = (Math.atan2(-1, 0) === -Math.PI / 2);
		Response.Write(direct + "|" + (a === b));
	`)
	out, err := runJScript2(t, aspSrc)
	if err != nil {
		t.Fatal(err)
	}
	if out != "true|true" {
		t.Errorf("expected 'true|true', got %q", out)
	}
}

// TestJScriptUninitializedArrayIndexAccess verifies that accessing uninitialized/empty slots
// in JScript arrays correctly yields 'undefined' and compares strictly to 'undefined'.
func TestJScriptUninitializedArrayIndexAccess(t *testing.T) {
	aspSrc := jscriptSrc(`
		var arr = new Array(3);
		Response.Write((arr[0] === void 0) + "|" + (typeof arr[0]));
	`)
	out, err := runJScript2(t, aspSrc)
	if err != nil {
		t.Fatal(err)
	}
	if out != "true|undefined" {
		t.Errorf("expected 'true|undefined', got %q", out)
	}
}
