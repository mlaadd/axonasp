//go:build windows

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
//This file contains Windows-specific boot logic to handle IIS hosting scenarios. It must be called from the main package to ensure it runs before any other code that might interact with the console.
package axonboot

import (
	"os"
	"syscall"
)

func init() {
	// Check if we're running under IIS (HttpPlatformHandler)
	// If the environment variable doesn't exist, we're in the interactive console (development)
	if os.Getenv("HTTP_PLATFORM_PORT") == "" && os.Getenv("APP_POOL_ID") == "" {
		// Abort the function and let the native STDOUT work freely on the screen
		return
	}

	// If we've reached here, we're running under IIS.
	// Start the ghost redirection to NUL to avoid database panic.
	nul, err := syscall.Open("NUL", syscall.O_RDWR, 0)
	if err == nil {
		kernel32 := syscall.NewLazyDLL("kernel32.dll")
		setStdHandle := kernel32.NewProc("SetStdHandle")

		const (
			stdInput  uintptr = 0xFFFFFFF6
			stdOutput uintptr = 0xFFFFFFF5
			stdError  uintptr = 0xFFFFFFF4
		)

		setStdHandle.Call(stdInput, uintptr(nul))
		setStdHandle.Call(stdOutput, uintptr(nul))
		setStdHandle.Call(stdError, uintptr(nul))

		os.Stdin = os.NewFile(uintptr(nul), "NUL")
		os.Stdout = os.NewFile(uintptr(nul), "NUL")
		os.Stderr = os.NewFile(uintptr(nul), "NUL")
	}
}
