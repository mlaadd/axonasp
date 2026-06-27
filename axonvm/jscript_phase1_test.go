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

func TestJScriptArrayAt(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var arr = [1, 2, 3];
		Response.Write(arr.at(0) + ",");
		Response.Write(arr.at(1) + ",");
		Response.Write(arr.at(-1) + ",");
		Response.Write(arr.at(5) + ",");
		Response.Write("hello".at(0) + ",");
		Response.Write("hello".at(-1));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "1,2,3,undefined,h,o"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptArrayFlat(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var arr = [1, [2, [3, 4]]];
		Response.Write(JSON.stringify(arr.flat()) + "|");
		Response.Write(JSON.stringify(arr.flat(2)));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "[1,2,[3,4]]|[1,2,3,4]"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptArrayFlatMap(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var arr = [1, 2, 3];
		var res = arr.flatMap(x => [x, x * 2]);
		Response.Write(JSON.stringify(res));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "[1,2,2,4,3,6]"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptArrayImmutable(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var arr = [3, 1, 2];
		var sorted = arr.toSorted();
		var reversed = arr.toReversed();
		var spliced = arr.toSpliced(1, 1, 4, 5);
		Response.Write(JSON.stringify(arr) + "|");
		Response.Write(JSON.stringify(sorted) + "|");
		Response.Write(JSON.stringify(reversed) + "|");
		Response.Write(JSON.stringify(spliced));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "[3,1,2]|[1,2,3]|[2,1,3]|[3,4,5,2]"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptObjectFromEntries(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var entries = [["a", 1], ["b", 2]];
		var obj = Object.fromEntries(entries);
		Response.Write(obj.a + "," + obj.b);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "1,2"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

// Phase 1: Type & Prototype Fixes

func TestJScriptTypeOfDateCall(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(typeof Date());
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "string"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptTypeOfNewDate(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(typeof new Date());
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "object"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptTypeOfMath(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(typeof Math);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "object"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptTypeOfParseInt(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(typeof parseInt);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "function"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptInstanceOfObjectLiteral(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(({} instanceof Object) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptInstanceOfNewDateObject(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((new Date() instanceof Object) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptInstanceOfRegExpLiteral(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((/abc/ instanceof RegExp) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptInstanceOfDateConstructor(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((Date instanceof Object) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptTypeOfMathMax(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(typeof Math.max);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "function"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptTypeOfEval(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(typeof eval);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "function"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptInstanceOfDate(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((new Date() instanceof Date) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

// Phase 2: Unary Operators & Type Coercion

func TestJScriptUnaryPlusEmptyString(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(+"" === 0 ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptUnaryPlusBool(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((+true === 1 && +false === 0) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptUnaryPlusArray(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((+[1] === 1 && +[] === 0) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptArrayJoinNullUndefined(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write([1, null, 3].join("-") + "|" + [1, void 0, 3].join("-"));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "1--3|1--3"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptUnaryPlusNumber(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((+"123" === 123 && +"-5" === -5 && +" " === 0) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

// Phase 3: Object.prototype.toString & Math Quirks

func TestJScriptObjectToStringStringWrapper(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(Object.prototype.toString.call(new String("x")));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "[object String]"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptObjectToStringNumberWrapper(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(Object.prototype.toString.call(new Number(1)));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "[object Number]"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptObjectToStringBooleanWrapper(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(Object.prototype.toString.call(new Boolean(false)));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "[object Boolean]"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptMathRoundNegative(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var r1 = Math.round(-1.5);
		var r2 = Math.round(-1.51);
		var r3 = Math.round(-0.5);
		var r4 = Math.round(-0.1);
		Response.Write(r1 + "," + r2 + "," + (1/r3 === -Infinity ? "-0" : r3) + "," + (1/r4 === -Infinity ? "-0" : r4));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "-1,-2,-0,-0"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptMathConstants(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((Math.PI > 3 && Math.PI < 4 && Math.E > 2 && Math.E < 3) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptMathMethods(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((Math.sin(0) === 0 && Math.cos(0) === 1 && Math.tan(0) === 0) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

// Phase 4: Array + Array concatenation

func TestJScriptArrayAddition(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var result = [1, 2] + [3, 4];
		Response.Write(result);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "1,23,4"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

// Phase 5: Eval, Function, wrapper equality, array equality

func TestJScriptArrayEqualsFalse(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(([] == false) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptArrayEqualsZero(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(([] == 0) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptArrayEqualsEmptyString(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(([] == "") ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptInstanceOfWrapperString(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((new String("x") instanceof String) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptStringCoercionEmptyArray(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(String([]) + "|" + String([1, 2]));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "|1,2"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

// Debug: exactly the failing expressions from the integration test

func TestJScriptNeg1Div0EqualsNegInfinity(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((-1 / 0 === -Infinity) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptNewArray3Length(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((new Array(3)).length);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "3"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptAtan2PiOver2(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write((Math.atan2(1, 0) === Math.PI / 2) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptAtan2NegPiOver2(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var v = Math.atan2(-1, 0);
		var pi2 = -Math.PI / 2;
		Response.Write("v=" + v + "|pi2=" + pi2 + "|eq=" + (v === pi2));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "v=-1.5707963267948966|pi2=-1.5707963267948966|eq=true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptMathExpLog(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(Math.exp(0) + "|" + Math.log(1) + "|" + Math.log(0));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "1|0|-Infinity"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptMathExp(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(Math.exp(0));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "1"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptMathLog1(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(Math.log(1));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "0"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptMathLog0(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(Math.log(0));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "-Infinity"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptRoundNeg05Div(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var r = Math.round(-0.5);
		var d = 1 / r;
		Response.Write("r=" + r + "|d=" + d + "|eq=" + (d === -Infinity));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "r=-0|d=-Infinity|eq=true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptRoundNeg01Div(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var r = Math.round(-0.1);
		var d = 1 / r;
		Response.Write("r=" + r + "|d=" + d + "|eq=" + (d === -Infinity));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "r=-0|d=-Infinity|eq=true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptWrapperToStringTag(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(Object.prototype.toString.call(new String("x")) + "|" +
			Object.prototype.toString.call(new Number(1)) + "|" +
			Object.prototype.toString.call(new Boolean(false)));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "[object String]|[object Number]|[object Boolean]"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptArrayNotEqualsItsNegation(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(([] == ![]) ? "true" : "false");
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptEval(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var result = eval("1 + 2");
		Response.Write(result);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "3"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptStringCoercionArray(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		Response.Write(String([]) + "|" + String([1, 2]));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "|1,2"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptArrayAdditionWithObject(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var r1 = [] + {};
		var r2 = {} + [];
		Response.Write(r1 + "|" + r2);
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "[object Object]|[object Object]"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}

func TestJScriptMathAbs(t *testing.T) {
	out, err := runJScript2(t, jscriptSrc(`
		var r1 = Math.abs("-1");
		var r2 = Math.abs("x");
		Response.Write((r1 === 1 && isNaN(r2) ? "true" : "false"));
	`))
	if err != nil {
		t.Fatal(err)
	}
	expected := "true"
	if out != expected {
		t.Errorf("expected %q, got %q", expected, out)
	}
}
