package main

import (
	"bytes"
	"fmt"
	"g3pix.com.br/axonasp/axonvm"
)

func main() {
	source := `<script runat="server" language="JScript">
var x = 10;
Response.Write(Math.floor(x / 2) + "|");
Response.Write((x / 2) | 0);
</script>`
	compiler := axonvm.NewASPCompiler(source)
	if err := compiler.Compile(); err != nil {
		panic(err)
	}

	bytecode := compiler.Bytecode()
	fmt.Printf("Bytecode length: %d\n", len(bytecode))

	host := axonvm.NewMockHost()
	var output bytes.Buffer
	host.SetOutput(&output)
	host.Response().SetBuffer(false)
	vm := axonvm.NewVM(compiler.Bytecode(), compiler.Constants(), compiler.GlobalsCount())
	vm.SetHost(host)

	if err := vm.Run(); err != nil {
		fmt.Printf("Error: %v\n", err)
	}
	fmt.Printf("Output: %q\n", output.String())
}
