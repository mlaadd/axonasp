# 🚀 AXONASP: JSCRIPT ES6 EXPANSION ROADMAP & AGENT INSTRUCTIONS

This document serves as a high-precision prompt and checklist for implementing further ECMAScript 6 (ES6) features into the AxonASP JScript engine.

## 🎯 CORE DIRECTIVES
1.  **Strict Isolation:** Modify ONLY JScript-related files (`axonvm/compiler_jscript.go`, `axonvm/vm_jscript.go`, etc.). DO NOT touch VBScript logic or general VM state that could affect VBScript behavior. If you need to modify the VM, ensure it is strictly for JScript and does not introduce regressions or change the VBScript behavior.
2.  **Performance Axioms:** 
    *   **Zero-Allocation:** Avoid creating new Go objects on the heap during hot paths.
    *   **No Reflection:** Use the established `Value` struct and switch-based dispatch.
    *   **Minimal GC Impact:** Prefer native Go primitives and stack-based operations. Avoid the use of interfaces or any constructs that could trigger GC cycles.
3.  **Validation:** Every step MUST be accompanied by a GoLang test case in `axonvm/jscript_es6_test.go` and a javascript ASP test page in `./www/tests/test_*.asp` that must run with success in `axonasp-cli.exe -r <filename>`. 
4. After implementing the features, update the documentation in `./www/manual/md/javascript/jscript-es6-support.md` to reflect the new capabilities and any limitations.
5. Please think and do your best job. I trust you.

---

## 🛠️ PHASE 3: DESTRUCTURING ASSIGNMENTS (COMPLEX)
**Goal:** Support `const [a, b] = arr;` and `const {x, y} = obj;`

### Tasks:
- [ ] **Compiler Update:** Refactor `compileJScriptLexicalDeclaration` and `compileJScriptAssignment` to handle `jsast.ArrayPattern` and `jsast.ObjectPattern`.
- [ ] **Recursive Unpacking:**
    - For **Arrays**: Iterate the pattern. For each element, emit code to get the value at index `i` from the source and assign it to the target identifier. Handle rest elements `[a, ...rest]`.
    - For **Objects**: Iterate properties. Emit code to get the member by name from the source and assign it to the local variable.
- [ ] **Memory Warning:** Be extremely careful with stack depth. Deeply nested destructuring can exhaust the stack.
- [ ] **Test:** Add comprehensive tests for nested destructuring and default values within patterns.

---

## 🛠️ PHASE 4: ES6 CLASSES (HIGH COMPLEXITY)
**Goal:** Support `class C extends B { constructor() { super(); } method() {} }`

### Tasks:
- [ ] **Compiler Update:** Implement `compileJScriptClassDeclaration`.
- [ ] **Logic:**
    - Classes are NOT hoisted (unlike functions).
    - They are executed in **Strict Mode** by default.
    - Map the `constructor` to a standard JScript function.
    - Map methods to the `.prototype` of the resulting constructor.
- [ ] **Super Binding:** Implement the `super` keyword. This requires the VM to track the "Home Object" of methods to correctly resolve the prototype chain.
- [ ] **Test:** Verify inheritance, static methods, and constructor behavior.

---

## 🛠️ PHASE 5: ASYNC / AWAIT (EXTREME)
**Goal:** Support asynchronous execution without blocking the ASP thread.

### Tasks:
- [ ] **Architectural Change:** This requires the VM to be able to "pause".
- [ ] **State Machine:** The compiler must transform `async` functions into a state machine (similar to how generators work).
- [ ] **Microtask Queue:** Implement a microtask queue in the VM that processes resolved promises before returning control to the ASP engine.
- [ ] **Constraint:** Ensure this does NOT interfere with the synchronous nature of VBScript or standard ASP objects (Response, Request).
- [ ] **Test:** Ensure `Response.Write` works correctly within async contexts.

---

## ✅ FINAL CHECKLIST FOR AGENT
1. **Gofmt:** Did you run `gofmt` on all modified files?
2. **VBScript Check:** Run `go test ./axonvm -run TestVBScript` to ensure zero regressions.
3. **Memory Profile:** Use `go test -bench` to ensure no new allocations were introduced in the JScript execution path.
4. **Error Codes:** Did you use the correct error codes from `jscripterrorcodes.go` for syntax/runtime failures?
5. **Branding:** Ensure all new files follow the G3pix copyright header format.
