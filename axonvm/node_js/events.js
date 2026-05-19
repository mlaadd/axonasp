/*
 * AxonASP Server - Node.js events module polyfill
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 *
 * Implements the Node.js EventEmitter API as a pure JavaScript polyfill.
 * Exposed via require("events") when Node.js compatibility is enabled.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */
'use strict';

var DEFAULT_MAX_LISTENERS = 10;

// EventEmitter constructor
function EventEmitter() {
  this._events = Object.create(null);
  this._maxListeners = undefined;
}

// Static property: default max listeners before memory-leak warning
EventEmitter.defaultMaxListeners = DEFAULT_MAX_LISTENERS;
EventEmitter.prototype.constructor = EventEmitter;

// Static helper: return the count of listeners for a specific event on an emitter
EventEmitter.listenerCount = function (emitter, event) {
  if (emitter && typeof emitter.listenerCount === 'function') {
    return emitter.listenerCount(event);
  }
  if (!emitter || !emitter._events) return 0;
  var listeners = emitter._events[event];
  if (!listeners) return 0;
  return listeners.length;
};

// Set the maximum number of listeners for this instance
EventEmitter.prototype.setMaxListeners = function (n) {
  if (typeof n !== 'number' || n < 0 || n !== n) {
    throw new TypeError('n must be a non-negative number');
  }
  this._maxListeners = n;
  return this;
};

// Return the maximum number of listeners for this instance
EventEmitter.prototype.getMaxListeners = function () {
  if (this._maxListeners === undefined) {
    return EventEmitter.defaultMaxListeners;
  }
  return this._maxListeners;
};

// Add a listener to the end of the listeners array for the specified event
EventEmitter.prototype.addListener = function (event, listener) {
  if (typeof listener !== 'function') {
    throw new TypeError('The "listener" argument must be of type Function.');
  }

  if (!this._events) {
    this._events = Object.create(null);
  }

  var existing = this._events[event];
  if (!existing) {
    this._events[event] = [listener];
    return this;
  }

  existing.push(listener);

  var max = this._maxListeners === undefined ? EventEmitter.defaultMaxListeners : this._maxListeners;
  if (max > 0 && existing.length > max) {
    var msg = 'MaxListenersExceededWarning: Possible EventEmitter memory leak detected. ' +
      existing.length + ' ' + String(event) + ' listeners added. ' +
      'Use emitter.setMaxListeners() to increase limit.';
    if (typeof console !== 'undefined' && typeof console.warn === 'function') {
      console.warn(msg);
    }
  }

  return this;
};

// Alias for addListener
EventEmitter.prototype.on = EventEmitter.prototype.addListener;

// Add a listener to the beginning of the listeners array for the specified event
EventEmitter.prototype.prependListener = function (event, listener) {
  if (typeof listener !== 'function') {
    throw new TypeError('The "listener" argument must be of type Function.');
  }

  if (!this._events) {
    this._events = Object.create(null);
  }

  var existing = this._events[event];
  if (!existing) {
    this._events[event] = [listener];
    return this;
  }

  existing.unshift(listener);

  var max = this._maxListeners === undefined ? EventEmitter.defaultMaxListeners : this._maxListeners;
  if (max > 0 && existing.length > max) {
    var msg = 'MaxListenersExceededWarning: Possible EventEmitter memory leak detected. ' +
      existing.length + ' ' + String(event) + ' listeners added. ' +
      'Use emitter.setMaxListeners() to increase limit.';
    if (typeof console !== 'undefined' && typeof console.warn === 'function') {
      console.warn(msg);
    }
  }

  return this;
};

// Add a one-time listener to the end of the listeners array
EventEmitter.prototype.once = function (event, listener) {
  if (typeof listener !== 'function') {
    throw new TypeError('The "listener" argument must be of type Function.');
  }

  function onceWrapper() {
    if (onceWrapper._fired) {
      return;
    }
    onceWrapper._fired = true;
    onceWrapper._emitter.removeListener(onceWrapper._event, onceWrapper);
    return onceWrapper._originalListener.apply(this, arguments);
  }

  onceWrapper._emitter = this;
  onceWrapper._event = event;
  onceWrapper._originalListener = listener;
  onceWrapper._fired = false;

  return this.addListener(event, onceWrapper);
};

// Add a one-time listener to the beginning of the listeners array
EventEmitter.prototype.prependOnceListener = function (event, listener) {
  if (typeof listener !== 'function') {
    throw new TypeError('The "listener" argument must be of type Function.');
  }

  function onceWrapper() {
    if (onceWrapper._fired) {
      return;
    }
    onceWrapper._fired = true;
    onceWrapper._emitter.removeListener(onceWrapper._event, onceWrapper);
    return onceWrapper._originalListener.apply(this, arguments);
  }

  onceWrapper._emitter = this;
  onceWrapper._event = event;
  onceWrapper._originalListener = listener;
  onceWrapper._fired = false;

  return this.prependListener(event, onceWrapper);
};

// Remove a listener from the listeners array for the specified event
EventEmitter.prototype.removeListener = function (event, listener) {
  if (typeof listener !== 'function') {
    throw new TypeError('The "listener" argument must be of type Function.');
  }

  if (!this._events) return this;
  var list = this._events[event];
  if (!list || list.length === 0) return this;

  var newList = [];
  var removed = false;

  for (var i = 0; i < list.length; i++) {
    var item = list[i];
    var original = item._originalListener || item;
    if (!removed && (original === listener || item === listener)) {
      removed = true;
      continue;
    }
    newList.push(item);
  }

  if (newList.length === 0) {
    delete this._events[event];
  } else {
    this._events[event] = newList;
  }

  return this;
};

// Alias for removeListener
EventEmitter.prototype.off = EventEmitter.prototype.removeListener;

// Remove all listeners, or those of the specified event
EventEmitter.prototype.removeAllListeners = function (event) {
  if (!this._events) return this;

  if (arguments.length === 0) {
    this._events = Object.create(null);
  } else if (event !== undefined) {
    delete this._events[event];
  }

  return this;
};

// Emit an event, synchronously calling each listener with the supplied arguments
EventEmitter.prototype.emit = function (event) {
  if (!this._events) return false;
  var list = this._events[event];
  if (!list || list.length === 0) {
    if (event === 'error') {
      var err = arguments[1];
      if (err instanceof Error) {
        throw err;
      }
      var e = new Error('Unhandled "error" event');
      e.context = err;
      throw e;
    }
    return false;
  }

  var snapshot = list.slice(0);
  var argCount = arguments.length - 1;
  var args = null;
  var i;

  if (argCount > 4) {
    args = [];
    for (i = 1; i < arguments.length; i++) {
      args.push(arguments[i]);
    }
  }

  for (var j = 0; j < snapshot.length; j++) {
    switch (argCount) {
      case 0:
        snapshot[j].call(this);
        break;
      case 1:
        snapshot[j].call(this, arguments[1]);
        break;
      case 2:
        snapshot[j].call(this, arguments[1], arguments[2]);
        break;
      case 3:
        snapshot[j].call(this, arguments[1], arguments[2], arguments[3]);
        break;
      case 4:
        snapshot[j].call(this, arguments[1], arguments[2], arguments[3], arguments[4]);
        break;
      default:
        snapshot[j].apply(this, args);
        break;
    }
  }

  return true;
};

// Return a copy of the array of listeners for the specified event
EventEmitter.prototype.listeners = function (event) {
  if (!this._events) return [];
  var list = this._events[event];
  if (!list) return [];

  var out = [];
  for (var i = 0; i < list.length; i++) {
    var item = list[i];
    out.push(item._originalListener || item);
  }
  return out;
};

// Return a copy including the raw wrappers (rawListeners)
EventEmitter.prototype.rawListeners = function (event) {
  if (!this._events) return [];
  var list = this._events[event];
  if (!list) return [];
  return list.slice(0);
};

// Return the number of listeners registered for the event
EventEmitter.prototype.listenerCount = function (event) {
  if (!this._events) return 0;
  var list = this._events[event];
  return list ? list.length : 0;
};

// Return an array listing the events for which there are registered listeners
EventEmitter.prototype.eventNames = function () {
  if (!this._events) return [];
  var names = [];
  for (var key in this._events) {
    if (Object.prototype.hasOwnProperty.call(this._events, key)) {
      if (this._events[key] && this._events[key].length > 0) {
        names.push(key);
      }
    }
  }
  return names;
};

// Utility: create a new class that inherits from EventEmitter
function eventEmitterInherits(ctor) {
  ctor.prototype = Object.create(eventEmitterInherits._superPrototype);
  ctor.prototype.constructor = ctor;
}

eventEmitterInherits._superPrototype = EventEmitter.prototype;
EventEmitter.inherits = eventEmitterInherits;

