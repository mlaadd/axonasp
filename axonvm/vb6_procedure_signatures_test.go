/*
 * AxonASP Server
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 *
 * Tests for VB6 advanced procedure signatures: Optional, ParamArray, explicit ByVal.
 */
package axonvm

import "testing"

// TestVB6OptionalWithDefault tests Optional parameter with default value.
func TestVB6OptionalWithDefault(t *testing.T) {
	source := `<%
Function Multiply(a, Optional b = 2)
	Dim result
	result = a * b
	Multiply = result
End Function

Response.Write Multiply(3) & "|"
Response.Write Multiply(3, 4)
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "6|12"
	if out != expected {
		t.Fatalf("Optional with default: expected %q, got %q", expected, out)
	}
}

// TestVB6OptionalStringDefault tests Optional with a string default value.
func TestVB6OptionalStringDefault(t *testing.T) {
	source := `<%
Function Concat(a, Optional b = "default")
	Concat = a & b
End Function

Response.Write Concat("hello_") & "|"
Response.Write Concat("hello_", "world")
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "hello_default|hello_world"
	if out != expected {
		t.Fatalf("Optional string default: expected %q, got %q", expected, out)
	}
}

// TestVB6OptionalIntegerDefault tests Optional with an integer default.
func TestVB6OptionalIntegerDefault(t *testing.T) {
	source := `<%
Function Add(Optional a = 10, Optional b = 20)
	Add = a + b
End Function

Response.Write Add() & "|"
Response.Write Add(1) & "|"
Response.Write Add(1, 2)
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "30|21|3"
	if out != expected {
		t.Fatalf("Optional integer default: expected %q, got %q", expected, out)
	}
}

// TestVB6ParamArray tests that ParamArray collects remaining arguments into an array.
func TestVB6ParamArray(t *testing.T) {
	source := `<%
Function Sum(ParamArray values())
	Dim total, i
	total = 0
	For i = LBound(values) To UBound(values)
		total = total + values(i)
	Next
	Sum = total
End Function

Response.Write Sum(1, 2, 3, 4, 5)
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "15"
	if out != expected {
		t.Fatalf("ParamArray sum: expected %q, got %q", expected, out)
	}
}

// TestVB6ParamArrayEmpty tests that ParamArray receives an empty array when no args are passed.
func TestVB6ParamArrayEmpty(t *testing.T) {
	source := `<%
Function Count(ParamArray values())
	Count = UBound(values) - LBound(values) + 1
End Function

Function IsArrayEmpty(ParamArray values())
	Dim count
	count = UBound(values) - LBound(values) + 1
	If count = 0 Then
		IsArrayEmpty = True
	Else
		IsArrayEmpty = False
	End If
End Function

' Test with empty ParamArray (count of 0 elements)
Response.Write "empty=" & IsArrayEmpty() & "|"
' Test with arguments
Response.Write "count=" & Count(1, 2, 3)
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "empty=True|count=3"
	if out != expected {
		t.Fatalf("ParamArray empty: expected %q, got %q", expected, out)
	}
}

// TestVB6OptionalAsType tests Optional with explicit As Type clause.
func TestVB6OptionalAsType(t *testing.T) {
	source := `<%
Function DoubleIt(Optional x As Integer = 5)
	DoubleIt = x * 2
End Function

Response.Write DoubleIt() & "|"
Response.Write DoubleIt(3)
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "10|6"
	if out != expected {
		t.Fatalf("Optional As Type: expected %q, got %q", expected, out)
	}
}

// TestVB6ByValParameter tests that an explicit ByVal parameter creates a local copy.
func TestVB6ByValParameter(t *testing.T) {
	source := `<%
Dim globalVar
globalVar = 10

Sub TestByVal(ByVal x)
	x = 100  ' This should NOT modify globalVar
End Sub

Call TestByVal(globalVar)
Response.Write globalVar
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "10"
	if out != expected {
		t.Fatalf("ByVal parameter: expected %q (global unchanged), got %q", expected, out)
	}
}

// TestVB6ByRefParameter tests that a ByRef parameter CAN modify the caller's variable.
func TestVB6ByRefParameter(t *testing.T) {
	source := `<%
Dim globalVar
globalVar = 10

Sub TestByRef(ByRef x)
	x = 100  ' This SHOULD modify globalVar
End Sub

Call TestByRef(globalVar)
Response.Write globalVar
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "100"
	if out != expected {
		t.Fatalf("ByRef parameter: expected %q (global changed), got %q", expected, out)
	}
}

// TestVB6ByRefDefault tests that default (no modifier) is ByRef.
func TestVB6ByRefDefault(t *testing.T) {
	source := `<%
Dim globalVar
globalVar = 10

Sub TestDefault(x)
	x = 100  ' Default is ByRef, should modify globalVar
End Sub

Call TestDefault(globalVar)
Response.Write globalVar
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "100"
	if out != expected {
		t.Fatalf("Default ByRef: expected %q (global changed), got %q", expected, out)
	}
}

// TestVB6OptionalAndRequired tests a mix of required and optional parameters.
func TestVB6OptionalAndRequired(t *testing.T) {
	source := `<%
Function FormatMsg(prefix, msg, Optional suffix = "!")
	FormatMsg = prefix & msg & suffix
End Function

Response.Write FormatMsg(">>> ", "Hello") & "|"
Response.Write FormatMsg(">>> ", "Hello", "?")
%>`
	out := runVBSAndGetOutput(t, source)
	expected := ">>> Hello!|>>> Hello?"
	if out != expected {
		t.Fatalf("Optional with required: expected %q, got %q", expected, out)
	}
}

// TestVB6MultipleOptional tests multiple optional parameters.
func TestVB6MultipleOptional(t *testing.T) {
	source := `<%
Function BuildPath(Optional root = "/var", Optional folder = "www", Optional file = "index.html")
	BuildPath = root & "/" & folder & "/" & file
End Function

Response.Write BuildPath() & "|"
Response.Write BuildPath("/home") & "|"
Response.Write BuildPath("/home", "public") & "|"
Response.Write BuildPath("/home", "public", "test.htm")
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "/var/www/index.html|/home/www/index.html|/home/public/index.html|/home/public/test.htm"
	if out != expected {
		t.Fatalf("Multiple optional: expected %q, got %q", expected, out)
	}
}

// TestVB6ParamArrayWithNamedParams tests ParamArray after named parameters.
func TestVB6ParamArrayWithNamedParams(t *testing.T) {
	source := `<%
Function BuildList(prefix, ParamArray items())
	Dim result, i
	result = prefix
	For i = LBound(items) To UBound(items)
		result = result & " " & items(i)
	Next
	BuildList = result
End Function

Response.Write BuildList("items:") & "|"
Response.Write BuildList("items:", 1, 2, 3)
%>`
	out := runVBSAndGetOutput(t, source)
	expected := "items:|items: 1 2 3"
	if out != expected {
		t.Fatalf("ParamArray with named: expected %q, got %q", expected, out)
	}
}
