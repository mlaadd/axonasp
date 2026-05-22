package axonvm

import (
	"fmt"
	"testing"
)

func TestPrintOpcodeValues(t *testing.T) {
	fmt.Printf("OpJSExponentAssign: %d\n", int(OpJSExponentAssign))
	fmt.Printf("OpJSLogicalAndAssign: %d\n", int(OpJSLogicalAndAssign))
	fmt.Printf("OpJSLogicalOrAssign: %d\n", int(OpJSLogicalOrAssign))
	fmt.Printf("OpJSCoalesceAssign: %d\n", int(OpJSCoalesceAssign))
	fmt.Printf("OpJSDefineProperty: %d\n", int(OpJSDefineProperty))
	fmt.Printf("OpJSSetProto: %d\n", int(OpJSSetProto))
	fmt.Printf("OpJSSuperCall: %d\n", int(OpJSSuperCall))
	fmt.Printf("OpJSLoadNewTarget: %d\n", int(OpJSLoadNewTarget))
	fmt.Printf("OpIncLocalInt: %d\n", int(OpIncLocalInt))
	fmt.Printf("OpDecLocalInt: %d\n", int(OpDecLocalInt))
	fmt.Printf("OpNop: %d\n", int(OpNop))
	fmt.Printf("OpJSJumpIfLessFast: %d\n", int(OpJSJumpIfLessFast))
	fmt.Printf("OpExtPrefix: %d\n", int(OpExtPrefix))
	fmt.Printf("ExtOpInitRecord: %d\n", int(ExtOpInitRecord))
	fmt.Printf("ExtOpGetRecordMember: %d\n", int(ExtOpGetRecordMember))
	fmt.Printf("ExtOpSetRecordMember: %d\n", int(ExtOpSetRecordMember))
}
