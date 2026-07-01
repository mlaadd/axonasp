package axonvm

import (
	"encoding/binary"
	"fmt"
	"testing"
)

func TestDebugBytecode(t *testing.T) {
	source := `<% Sub Inner(a,b,c) : End Sub : Inner 1,2,3 %>`
	compiler := NewASPCompiler(source)
	if err := compiler.Compile(); err != nil {
		t.Fatalf("compile failed: %v", err)
	}
	bc := compiler.Bytecode()
	t.Logf("Bytecode length: %d", len(bc))
	for ip := 0; ip < len(bc); {
		prevIP := ip
		op := OpCode(bc[ip])
		ip++
		if ip+2 <= len(bc) {
			val := int(binary.BigEndian.Uint16(bc[ip:]))
			t.Logf("  %3d: %s (op=%d) [val=%d]", prevIP, op.String(), int(op), val)
			ip += 2
		} else if ip <= len(bc) {
			t.Logf("  %3d: %s (op=%d)", prevIP, op.String(), int(op))
		}
	}

	// Also test with 2 args for comparison
	source2 := `<% Sub Inner(a,b) : End Sub : Inner 1,2 %>`
	compiler2 := NewASPCompiler(source2)
	if err := compiler2.Compile(); err != nil {
		t.Fatalf("compile2 failed: %v", err)
	}
	bc2 := compiler2.Bytecode()
	t.Logf("Bytecode2 length: %d", len(bc2))
	for ip := 0; ip < len(bc2); {
		prevIP := ip
		op := OpCode(bc2[ip])
		ip++
		if ip+2 <= len(bc2) {
			val := int(binary.BigEndian.Uint16(bc2[ip:]))
			t.Logf("  %3d: %s (op=%d) [val=%d]", prevIP, op.String(), int(op), val)
			ip += 2
		} else if ip <= len(bc2) {
			t.Logf("  %3d: %s (op=%d)", prevIP, op.String(), int(op))
		}
	}

	_ = fmt.Sprintf
}
