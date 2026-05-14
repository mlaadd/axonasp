//go:build js && wasm

package main

import (
	"bytes"
	"syscall/js"

	"g3pix.com.br/axonasp/axonvm"
	"g3pix.com.br/axonasp/axonvm/asp"
)

var (
	sharedApplication = asp.NewApplication()
	sharedSession     = asp.NewSession()
)

// executeASP handles the invocation from JS: AxonASP.execute(code)
func executeASP(this js.Value, args []js.Value) interface{} {
	//Create a new Promise to handle async execution
	promiseConstructor := js.Global().Get("Promise")

	return promiseConstructor.New(js.FuncOf(func(this js.Value, promiseArgs []js.Value) interface{} {
		// The resolve and reject functions passed by the Promise constructor
		resolve := promiseArgs[0]
		reject := promiseArgs[1]

		// Start the VM execution in an isolated Goroutine.
		// This allows Go to yield to the browser's event loop
		// during network operations (like HTTP/Fetch) without causing deadlock.
		go func() {
			if len(args) == 0 {
				reject.Invoke("Error: No code provided")
				return
			}
			code := args[0].String()

			compiler := axonvm.NewASPCompiler(code)
			compiler.SetSourceName("/wasm.asp")

			if err := compiler.Compile(); err != nil {
				reject.Invoke("Compile Error: " + err.Error())
				return
			}

			vm := axonvm.AcquireVMFromCompiler(compiler)
			defer vm.Release()

			var outBuf bytes.Buffer
			host := axonvm.NewMockHost()
			host.SetOutput(&outBuf)

			host.SetApplication(sharedApplication)
			host.SetSession(sharedSession)
			vm.SetHost(host)

			runErr := vm.Run()
			host.Response().Flush()
			host.Response().ReleaseBuffer()

			output := outBuf.String()
			if runErr != nil {
				// If you prefer, you can use reject.Invoke() here.
				output += "\nRuntime Error: " + runErr.Error()
			}

			// Resolve Promise
			resolve.Invoke(output)
		}()

		return nil
	}))
}

func main() {
	js.Global().Set("AxonASP", js.ValueOf(map[string]interface{}{
		"execute": js.FuncOf(executeASP),
	}))

	c := make(chan struct{})
	println("G3pix ❖ AxonASP initialized")
	<-c
}
