//go:build wasm || lib_g3pdf_disabled

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

// G3PDF is the disabled stub for the G3PDF library.
type G3PDF struct {
	isPersitsMode bool
}

// Persits.Pdf sub-object stubs for disabled builds.
type PdfDocument struct{}
type PdfPage struct{}
type PdfCanvas struct{}
type PdfFont struct{}
type PdfPagesCollection struct{}

func NewG3PDF(ctx *VM) *G3PDF {
	panicLibraryDisabled("g3pdf", "G3PDF library")
	return nil
}

func (p *G3PDF) DispatchPropertyGet(name string) Value {
	return Value{Type: VTEmpty}
}

func (p *G3PDF) DispatchPropertySet(name string, args []Value) bool {
	return false
}

func (p *G3PDF) DispatchMethod(name string, args []Value) Value {
	return Value{Type: VTEmpty}
}

// Persits.Pdf sub-object dispatch stubs

func (d *PdfDocument) DispatchPropertyGet(name string) Value {
	return Value{Type: VTEmpty}
}

func (d *PdfDocument) DispatchPropertySet(name string, args []Value) bool {
	return false
}

func (d *PdfDocument) DispatchMethod(name string, args []Value) Value {
	return Value{Type: VTEmpty}
}

func (p *PdfPage) DispatchPropertyGet(name string) Value {
	return Value{Type: VTEmpty}
}

func (p *PdfPage) DispatchPropertySet(name string, args []Value) bool {
	return false
}

func (p *PdfPage) DispatchMethod(name string, args []Value) Value {
	return Value{Type: VTEmpty}
}

func (c *PdfCanvas) DispatchPropertyGet(name string) Value {
	return Value{Type: VTEmpty}
}

func (c *PdfCanvas) DispatchPropertySet(name string, args []Value) bool {
	return false
}

func (c *PdfCanvas) DispatchMethod(name string, args []Value) Value {
	return Value{Type: VTEmpty}
}

func (f *PdfFont) DispatchPropertyGet(name string) Value {
	return Value{Type: VTEmpty}
}

func (f *PdfFont) DispatchPropertySet(name string, args []Value) bool {
	return false
}

func (f *PdfFont) DispatchMethod(name string, args []Value) Value {
	return Value{Type: VTEmpty}
}

func (pc *PdfPagesCollection) DispatchPropertyGet(name string) Value {
	return Value{Type: VTEmpty}
}

func (pc *PdfPagesCollection) DispatchMethod(name string, args []Value) Value {
	return Value{Type: VTEmpty}
}

// VM dispatch function stubs for Persits.Pdf sub-objects

func (vm *VM) dispatchPdfDocumentMethod(doc *PdfDocument, member string, args []Value) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfDocumentPropertyGet(doc *PdfDocument, member string) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfDocumentPropertySet(doc *PdfDocument, member string, val Value) {}

func (vm *VM) dispatchPdfPageMethod(page *PdfPage, member string, args []Value) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfPagePropertyGet(page *PdfPage, member string) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfPagePropertySet(page *PdfPage, member string, val Value) {}

func (vm *VM) dispatchPdfCanvasMethod(canvas *PdfCanvas, member string, args []Value) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfCanvasPropertyGet(canvas *PdfCanvas, member string) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfCanvasPropertySet(canvas *PdfCanvas, member string, val Value) {}

func (vm *VM) dispatchPdfFontMethod(font *PdfFont, member string, args []Value) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfFontPropertyGet(font *PdfFont, member string) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfFontPropertySet(font *PdfFont, member string, val Value) {}

func (vm *VM) dispatchPdfPagesMethod(pc *PdfPagesCollection, member string, args []Value) Value {
	return Value{Type: VTEmpty}
}
func (vm *VM) dispatchPdfPagesPropertyGet(pc *PdfPagesCollection, member string) Value {
	return Value{Type: VTEmpty}
}

func (vm *VM) cleanupG3PDFResources() {}
