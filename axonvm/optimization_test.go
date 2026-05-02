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
	"os"
	"path/filepath"
	"testing"
	"time"
)

// TestOptimizationRedimPreserve verifies the O(log N) capacity growth logic.
func TestOptimizationRedimPreserve(t *testing.T) {
	// Create a 1D array: Dim a(2) -> [Empty, Empty, Empty]
	arr := NewVBArray(0, 3)
	arr.Set(0, NewInteger(10))
	arr.Set(1, NewInteger(20))
	arr.Set(2, NewInteger(30))
	val := ValueFromVBArray(arr)

	// ReDim Preserve a(4) -> [10, 20, 30, Empty, Empty]
	// This should trigger a growth. New size is 5.
	// existing cap was 3. newSize (5) > cap (3).
	// newCap = max(5, 3*2) = 6.
	res1, err := vbsAxonRedimPreserveArray([]Value{val, NewInteger(4)})
	if err != nil {
		t.Fatal(err)
	}
	if res1.Type != VTArray || len(res1.Arr.Values) != 5 {
		t.Fatalf("expected length 5, got %d", len(res1.Arr.Values))
	}
	if v, _ := res1.Arr.Get(0); v.Num != 10 {
		t.Errorf("expected 10 at 0, got %v", v)
	}

	// Check capacity growth
	if cap(res1.Arr.Values) < 6 {
		t.Errorf("expected capacity >= 6, got %d", cap(res1.Arr.Values))
	}

	// ReDim Preserve again within capacity: a(5)
	// New size is 6. 6 <= cap (6). Should reuse backing array.
	res2, err := vbsAxonRedimPreserveArray([]Value{res1, NewInteger(5)})
	if err != nil {
		t.Fatal(err)
	}
	if res2.Type != VTArray || len(res2.Arr.Values) != 6 {
		t.Fatalf("expected length 6, got %d", len(res2.Arr.Values))
	}

	// Verify it reused the backing array capacity
	if cap(res2.Arr.Values) != cap(res1.Arr.Values) {
		t.Errorf("expected reused capacity %d, got %d", cap(res1.Arr.Values), cap(res2.Arr.Values))
	}

	// Verify that the old array was NOT affected by growth (since it was a new struct)
	if len(res1.Arr.Values) != 5 {
		t.Errorf("old array length should still be 5, got %d", len(res1.Arr.Values))
	}

	// Verify 2D arrays still work (legacy path)
	// Dim b(1, 1) -> 2x2
	arr2d := NewVBArray(0, 2)
	arr2d.Values[0] = ValueFromVBArray(NewVBArray(0, 2))
	arr2d.Values[1] = ValueFromVBArray(NewVBArray(0, 2))
	val2d := ValueFromVBArray(arr2d)

	// ReDim Preserve b(1, 2) -> 2x3
	res3, err := vbsAxonRedimPreserveArray([]Value{val2d, NewInteger(1), NewInteger(2)})
	if err != nil {
		t.Fatal(err)
	}
	if res3.Type != VTArray || len(res3.Arr.Values) != 2 {
		t.Fatalf("expected length 2 for first dimension, got %d", len(res3.Arr.Values))
	}
	sub, _ := toVBArray(res3.Arr.Values[0])
	if len(sub.Values) != 3 {
		t.Fatalf("expected length 3 for second dimension, got %d", len(sub.Values))
	}
}

// TestOptimizationFSOCache verifies the metadata cache behavior.
func TestOptimizationFSOCache(t *testing.T) {
	tempDir, err := os.MkdirTemp("", "axon_fso_cache_test")
	if err != nil {
		t.Fatal(err)
	}
	defer os.RemoveAll(tempDir)

	filePath := filepath.Join(tempDir, "test.txt")
	os.WriteFile(filePath, []byte("hello"), 0644)

	// Warm up cache
	info1, err := globalFSOCache.GetStat(filePath)
	if err != nil {
		t.Fatal(err)
	}
	if info1.Size() != 5 {
		t.Fatalf("expected size 5, got %d", info1.Size())
	}

	// Modify file on disk
	time.Sleep(10 * time.Millisecond)
	os.WriteFile(filePath, []byte("world!!!"), 0644)

	// Should still return old cached info
	info2, err := globalFSOCache.GetStat(filePath)
	if err != nil {
		t.Fatal(err)
	}
	if info2.Size() != 5 {
		t.Errorf("expected cached size 5, got %d", info2.Size())
	}

	// Manually clear to test refresh
	globalFSOCache.mu.Lock()
	delete(globalFSOCache.items, filePath)
	globalFSOCache.mu.Unlock()

	info3, err := globalFSOCache.GetStat(filePath)
	if err != nil {
		t.Fatal(err)
	}
	if info3.Size() != 8 {
		t.Errorf("expected fresh size 8, got %d", info3.Size())
	}
}
