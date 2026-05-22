/*
 * AxonASP Server
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 */
package axonvm

import "testing"

func TestVB6UDT(t *testing.T) {
	source := `<%
	Type Person
		Name As String
		Age As Integer
	End Type

	Dim p As Person
	p.Name = "Lucas"
	p.Age = 30

	Response.Write p.Name & " is " & p.Age & " years old."
	%>`
	out := runVBSAndGetOutput(t, source)
	if out != "Lucas is 30 years old." {
		t.Fatalf("Basic UDT test failed: expected 'Lucas is 30 years old.', got %q", out)
	}
}

func TestVB6NestedUDT(t *testing.T) {
	source := `<%
	Type Address
		City As String
		Zip As Integer
	End Type

	Type User
		Name As String
		Home As Address
	End Type

	Dim u As User
	Dim a As Address
	u.Name = "G3pix"
	a.City = "Floripa"
	a.Zip = 88000
	u.Home = a

	Response.Write u.Name & " in " & u.Home.City & " (" & u.Home.Zip & ")"
	%>`
	out := runVBSAndGetOutput(t, source)
	if out != "G3pix in Floripa (88000)" {
		t.Fatalf("Nested UDT test failed: expected 'G3pix in Floripa (88000)', got %q", out)
	}
}

func TestVB6UDTArray(t *testing.T) {
	source := `<%
	Type Point
		X As Integer
		Y As Integer
	End Type

	Dim pts(2) As Point
	Dim p0 As Point
	Dim p1 As Point
	p0.X = 10
	p0.Y = 20
	p1.X = 30
	p1.Y = 40
	pts(0) = p0
	pts(1) = p1

	Response.Write pts(0).X & "," & pts(0).Y & " | " & pts(1).X & "," & pts(1).Y
	%>`
	// Note: Array of UDTs requires OpInitTypedVar to handle allocation of each element if As Type is set.
	// Current AxonVM might need extra logic for arrays of UDTs.
	// Standard VB6 allocates UDT elements in fixed-size arrays.
	// For now, let's see if this works with dynamic initialization.
	out := runVBSAndGetOutput(t, source)
	if out != "10,20 | 30,40" {
		t.Fatalf("UDT array test failed: expected '10,20 | 30,40', got %q", out)
	}
}
