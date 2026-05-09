# 🚀 AXONASP: JSCRIPT MODERNIZATION & ES6+ EXPANSION ROADMAP

This document serves as a high-precision checklist for implementing ECMAScript 6 (ES6) and modern ES11-ES24 features into the AxonASP JScript engine.

## 🎯 CORE DIRECTIVES

1. **Strict Isolation:** Modify ONLY JScript-related files (`axonvm/compiler_jscript.go`, `axonvm/vm_jscript.go`, etc.). DO NOT touch VBScript logic or general VM state that could affect VBScript behavior. If you need to modify the VM, ensure it is strictly for JScript and does not introduce regressions or change the VBScript behavior.
2. **Performance Axioms:**
* **Zero-Allocation:** Avoid creating new Go objects on the heap during hot paths.
* **No Reflection:** Use the established `Value` struct and switch-based dispatch.
* **Minimal GC Impact:** Prefer native Go primitives and stack-based operations. Avoid the use of interfaces or any constructs that could trigger GC cycles.
3. **VM Architecture Context (Crucial):**
    * The AxonASP Eval loop is procedural (a large for loop labeled aspExecLoop).
    *It uses a custom memory-managed stack (stack []Value), a callStack []CallFrame, and sp, fp, and ip pointers.
* **NO Go Host Recursion:** User scripts run 100% isolated within the loop. Function calls (OpCall) just push a frame and jump ip. OpRet pops the frame and restores ip/sp/fp. Native Go recursion is strictly for native built-ins. Leverage this architecture heavily, especially for stack management and state pausing.
3. **Validation:** Every step MUST be accompanied by a GoLang test case in `axonvm/jscript_es6_test.go` and a javascript ASP test page in `./www/tests/test_*.asp` that must run with success in `axonasp-cli.exe -r <filename>`. Don't delete the test files, just add new ones for the new features. Ensure that all existing tests pass without modification to confirm no regressions.
4. After implementing the features, update the documentation in `./www/manual/md/javascript/jscript-es6-support.md` to reflect the new capabilities and any limitations.
5. Please think and do your best job. I trust you.

---

## 🛠️ PHASE 3: TAIL CALL OPTIMIZATION (TCO) (MEDIUM COMPLEXITY)

**Goal:** Ensure function calls in the tail position do not increase the execution stack size. Don't allow the `stack []Value` to grow indefinitely with deep recursion. High risk if not implemented correctly, as it can lead to memory leaks or crashes.

* [x] **Implementation Logic:** Thanks to the procedural `CallFrame` architecture, TCO is highly achievable. Instead of pushing a new `CallFrame`, identify if a call is a tail call. If so, replace the local variables/arguments on the current `stack []Value`, keep the current `CallFrame`, and simply jump the `ip` back to the start of the function's bytecode. This way, the stack size remains constant regardless of recursion depth. The compiler must emit a specific OpCode (e.g., OpTailCall) when it detects a tail call during compilation. The VM will then handle this OpCode by performing the TCO logic instead of a normal call. This is a critical optimization for functions that rely on recursion, such as those processing linked lists or performing mathematical computations.
    * 1: Define the TCO Opcodes - axonvm/opcodes.go (or wherever opcodes are defined)
        *Add two new opcodes to the JScript section of the opcode definitions:
        - OpJSTailCall
        - OpJSTailCallMember
    * 2: Ensure they are correctly registered in any opcode size/string mapping functions (e.g., opcodeOperandSize, if they take the same 2-byte operand for argCount as standard calls).
    * 3: Compiler Tracking for Try/Catch Safety - File: axonvm/compiler.go and axonvm/compiler_jscript.go
        * TCO cannot be performed if the return statement is inside a try or catch block, as the current frame's exception handlers must remain on the stack.
        * Add State: Add jsTryDepth int to the Compiler struct.
        * Track Depth: In compileJScriptStatement, under case *jsast.TryStatement:, increment c.jsTryDepth++ before emitting OpJSTryEnter, and decrement c.jsTryDepth-- after emitting OpJSTryLeave (and appropriately handle finally blocks).
    * 4: AST Detection and Bytecode Emission - File: axonvm/compiler_jscript.go
        * Modify how ReturnStatement is compiled to detect tail-position calls.
        * Locate case *jsast.ReturnStatement: in compileJScriptStatement.
        * Check if the return argument is a valid tail call candidate:
           * c.jsTryDepth == 0
           * node.Argument is of type *jsast.CallExpression
        * If it IS a tail call:
            * Do not call c.compileJScriptExpression(node.Argument).
            * Do not emit OpJSReturn.
            * Extract the CallExpression.
            * Compile the callee expression and arguments exactly as done in compileJScriptCall.
            * Crucial Difference: Emit OpJSTailCall (or OpJSTailCallMember) instead of OpJSCall / OpJSCallMember.
        * If it is NOT a tail call: Leave the existing compilation logic exactly as it is (compile expression, emit OpJSReturn).
    * 5: VM Execution Logic (The Core TCO Swap) - File: axonvm/vm_jscript.go (or the primary procedural evaluation loop vm.go) Implement the runtime handling for OpJSTailCall and OpJSTailCallMember.
        * Intercept the Opcode: Add case OpJSTailCall: and case OpJSTailCallMember: to the main switch statement.
        * Fetch Target & Args: Read argCount from the bytecode operand.
            * callee is at vm.stack[vm.sp - argCount - 1]
            * args are from vm.stack[vm.sp - argCount : vm.sp]
        * Handle Native Functions Normally: If callee is a native Go function, TCO is unnecessary and impossible at the VM level. Just execute it like a normal OpJSCall and push the result, then execute a normal OpJSReturn sequence (pop frame).
    * 6: Handle VM Closures (The Actual TCO):
        * Do NOT push a new CallFrame.
        * Get the current frame: currentFrame := &vm.callStack[len(vm.callStack)-1]
        * Slide the Stack: Move the callee and args down the stack to overwrite the current frame's initial stack position.
        * Reset the Stack Pointer: vm.sp = baseFp + 1 + argCount
        * Overwrite the Instruction Pointer: vm.ip = callee.Closure.IP (or however the closure's starting instruction is referenced).
        * Lexical Environment: Update the current frame's active environment to the callee's captured environment.
        * Jump back to the start of the aspExecLoop evaluation loop.

* [x] **Test:** Implement a deeply recursive JScript function (e.g., function sum(n, acc) { if (n === 0) return acc; return sum(n - 1, acc + n); } return sum(100000, 0);). A depth of 100,000 will immediately trigger a stack overflow or slice out-of-bounds if TCO fails. If it succeeds, the VM correctly reused the frame. This is a critical test to ensure the TCO implementation is correct and memory-safe. Write a test verifying that functions inside try/catch block correctly bypass TCO and execute normally (verifying jsTryDepth logic).

---

## 🛠️ PHASE 4: DATA STRUCTURES & SYMBOLS (MEDIUM-HIGH COMPLEXITY)

**Goal:** Implement memory-safe collections, low-level buffers, and internal engine symbols.

### Tasks:

* [ ] **Well-Known Symbols:** Expand the existing `Symbol` support to include global symbols: `Symbol.iterator`, `Symbol.toStringTag`, `Symbol.species`, `Symbol.hasInstance`, and `Symbol.toPrimitive`, ensuring they are correctly wired and recognized by the engine and can be used in user scripts.
* [ ] **Binary Data (Typed Arrays & DataView):** Implement `ArrayBuffer`, `DataView`, and typed arrays (`Uint8Array`, `Int32Array`, `Float64Array`, etc.) for high-performance I/O.
* [ ] **Weak Collections (`WeakMap` & `WeakSet`):** Implement collections that do not prevent GC of their keys.
    * *ATTENTION:* Implementing `WeakMap` and `WeakSet` in Go is non-trivial. You may need to use a combination of `runtime.SetFinalizer` or careful weak-reference management. Ensure thoroughly tested memory safety to prevent leaks in long-running ASP applications.
* [ ] **Final checklist**: Did you followed the final checklist at the end of this document after implementing these features?

---

## 🛠️ PHASE 5: ITERATION PROTOCOL & DESTRUCTURING (HIGH COMPLEXITY)

**Goal:** Standardize iteration mechanics and support `const [a, b] = arr;` and `const {x, y} = obj;`

### Tasks:

* [ ] **Iteration Protocol (Iterators & Iterables):** Replace the current hardcoded `for...of` and spread operator logic. Support `Symbol.iterator` and implement `.next()` consumption so the engine can process any `{ value: any, done: boolean }` structure.
* [ ] **Compiler Update:** Refactor `compileJScriptLexicalDeclaration` and `compileJScriptAssignment` to handle `jsast.ArrayPattern` and `jsast.ObjectPattern`.
* [ ] **Recursive Unpacking:**
    * For **Arrays**: Use the Iteration Protocol, call `.next()`, and assign to identifiers. Handle rest elements `[a, ...rest]`.
    * For **Objects**: Iterate properties and assign members by name.

* [ ] **Memory Warning:** Be extremely careful with stack depth. Deeply nested destructuring can exhaust the stack.
* [ ] **Final checklist**: Did you followed the final checklist at the end of this document after implementing these features?

---

## 🛠️ PHASE 6: ES6 CLASSES (HIGH COMPLEXITY)

**Goal:** Support `class C extends B { constructor() { super(); } method() {} }`

### Tasks:

* [ ] **Compiler Update:** Implement `compileJScriptClassDeclaration`.
* [ ] **Logic:** Classes are NOT hoisted, execute in Strict Mode, map `constructor` to a function, and map methods to the `.prototype`.
* [ ] **Super Binding:** Implement the `super` keyword by tracking the "Home Object" of methods to correctly resolve the prototype chain.
* [ ] **Final checklist**: Did you followed the final checklist at the end of this document after implementing these features?

---

## 🛠️ PHASE 7: PROXIES & REFLECTION (HIGH COMPLEXITY)

**Goal:** Introduce metaprogramming capabilities.

### Tasks:

* [ ] **Proxy Object:** Intercept fundamental operations (`get`, `set`, `apply`, `construct`). Requires deep hooks into the JScript member dispatch engine (`jsMemberGet`, `jsMemberSet`).
* [ ] **Reflect Object:** Expose the global `Reflect` API for programmatic object manipulation, ensuring parity with `Proxy` traps.
* [ ] **Final checklist**: Did you followed the final checklist at the end of this document after implementing these features?

---

## 🛠️ PHASE 8: STATE MACHINES (GENERATORS & ASYNC/AWAIT) (EXTREME COMPLEXITY)

**Goal:** Support pause/resume capabilities and asynchronous execution without blocking the ASP thread.

### Tasks:

* [ ] **Architectural Advantage:** Use the explicit `CallFrame`, `sp`, `fp`, and `ip` state array to your advantage. Pausing a generator means saving this exact state so it can be pushed back onto `vm.callStack` later.
* [ ] **State Machine Transformation:** The compiler must convert `function*` (`yield`) and `async` functions into resumable states.
* [ ] **Microtask Queue:** Implement a microtask queue in the VM that processes resolved promises before returning control to the ASP engine.
* [ ] **Constraint:** Ensure this does NOT interfere with the synchronous nature of VBScript or standard ASP objects (e.g., `Response.Write` must work correctly inside `yield` steps).
* [ ] **Final checklist**: Did you followed the final checklist at the end of this document after implementing these features?

---

## 🛠️ PHASE 9: ECMASCRIPT MODULES (EXTREME RISK)

**Goal:** Shift code loading architecture to support `import` / `export`.

### Tasks:

* [ ] **Dependency Resolution:** Create logic for loading and linking ES Modules. *Note: ASP is traditionally synchronous and based on `#include`.* This requires careful mapping to load ES Modules into isolated scope environments while maintaining the ASP lifecycle.
* [ ] **Module Caching:** Implement a caching mechanism to prevent reloading the same module multiple times.
* [ ] **Syntax & Semantics:** Update the parser to recognize `import` and `export` statements, and the compiler to handle module scope and bindings.
* [ ] **Testing:** This is a high-risk change. Ensure comprehensive and rigorous testing to prevent breaking existing ASP applications.
* [ ] **Final checklist**: Did you followed the final checklist at the end of this document after implementing these features?

---

## ✅ FINAL CHECKLIST FOR AGENT

1. **Gofmt:** Did you run `gofmt` on all modified files?
2. **VBScript Check:** Run `go test ./axonvm -run TestVBScript` to ensure zero regressions.
3. **Memory Profile:** Use `go test -bench` to ensure no new allocations were introduced in the JScript execution path.
4. **Error Codes:** Did you use the correct error codes from `jscripterrorcodes.go` for syntax/runtime failures?
5. **Branding:** Ensure all new files follow the G3pix copyright header format.
6. **Documentation:** Did you update `jscript-es6-support.md` with the new features and any limitations or known issues?
7. **Testing:** Did you add comprehensive test cases for each new feature in both Go and ASP test files?
8. **Code Review:** Before finalizing, review the code for any potential performance pitfalls, memory leaks, or edge cases that could arise from the new features.
9. **Check complete:** [x] Phase 3 TCO task is marked as complete in this file
