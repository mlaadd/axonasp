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
	"sync"
	"time"
)

// fsoCacheItem stores cached metadata for one file or directory.
type fsoCacheItem struct {
	stat    os.FileInfo
	entries []os.DirEntry
	expires time.Time
}

// fsoCacheManager handles thread-safe caching of FSO metadata with TTL.
type fsoCacheManager struct {
	mu    sync.RWMutex
	items map[string]*fsoCacheItem
}

// globalFSOCache provides process-wide caching for FSO operations.
var globalFSOCache = &fsoCacheManager{
	items: make(map[string]*fsoCacheItem),
}

// GetStat returns cached FileInfo for a path or performs os.Stat and caches it.
func (c *fsoCacheManager) GetStat(path string) (os.FileInfo, error) {
	c.mu.RLock()
	item, ok := c.items[path]
	c.mu.RUnlock()

	now := time.Now()
	if ok && item.stat != nil && now.Before(item.expires) {
		return item.stat, nil
	}

	info, err := os.Stat(path)
	if err != nil {
		return nil, err
	}

	c.mu.Lock()
	defer c.mu.Unlock()

	// Passive cleanup during writes
	if len(c.items) > 1024 {
		for p, it := range c.items {
			if now.After(it.expires) {
				delete(c.items, p)
			}
		}
	}

	if item, ok = c.items[path]; ok {
		item.stat = info
		item.expires = now.Add(1 * time.Minute)
	} else {
		c.items[path] = &fsoCacheItem{
			stat:    info,
			expires: now.Add(1 * time.Minute),
		}
	}

	return info, nil
}

// GetReadDir returns cached directory entries for a path or performs os.ReadDir and caches it.
func (c *fsoCacheManager) GetReadDir(path string) ([]os.DirEntry, error) {
	c.mu.RLock()
	item, ok := c.items[path]
	c.mu.RUnlock()

	now := time.Now()
	if ok && item.entries != nil && now.Before(item.expires) {
		return item.entries, nil
	}

	entries, err := os.ReadDir(path)
	if err != nil {
		return nil, err
	}

	c.mu.Lock()
	defer c.mu.Unlock()

	// Passive cleanup during writes
	if len(c.items) > 1024 {
		for p, it := range c.items {
			if now.After(it.expires) {
				delete(c.items, p)
			}
		}
	}

	if item, ok = c.items[path]; ok {
		item.entries = entries
		item.expires = now.Add(1 * time.Minute)
	} else {
		c.items[path] = &fsoCacheItem{
			entries: entries,
			expires: now.Add(1 * time.Minute),
		}
	}

	return entries, nil
}
