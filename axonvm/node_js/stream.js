/*
 * AxonASP Server - Node.js stream module polyfill
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 *
 * Implements a lightweight Node.js-compatible stream module using native
 * AxonASP hooks exposed through __axon_stream for chunk transfer.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */
'use strict';

var EventEmitter = require('events').EventEmitter;

function toEncoding(value, fallback) {
  if (typeof value === 'string' && value.length > 0) {
    return value;
  }
  return fallback;
}

function Readable(options) {
  EventEmitter.call(this);
  options = options || {};
  this.readable = true;
  this._ended = false;
  this._hook = __axon_stream.createReadable(options.source, options.encoding);
  this._hookId = this._hook.__axon_stream_id;
}

EventEmitter.inherits(Readable);

Readable.prototype.read = function () {
  if (!this._hook) {
    return null;
  }
  var chunk = __axon_stream.pull(this._hookId);
  if (chunk === undefined) {
    if (!this._ended && __axon_stream.eof(this._hookId)) {
      this._ended = true;
      this.readable = false;
      this.emit('end');
    }
    return null;
  }
  this.emit('data', chunk);
  return chunk;
};

Readable.prototype.pipe = function (destination) {
  var chunk;
  while ((chunk = this.read()) !== null) {
    destination.write(chunk);
  }
  destination.end();
  return destination;
};

function Writable(options) {
  EventEmitter.call(this);
  options = options || {};
  this.writable = true;
  this._encoding = toEncoding(options.encoding, 'utf8');
  this._hook = __axon_stream.createWritable();
  this._hookId = this._hook.__axon_stream_id;
}

EventEmitter.inherits(Writable);

Writable.prototype.write = function (chunk, encoding, callback) {
  if (!this._hook) {
    return false;
  }

  var cb = callback;
  var enc = encoding;
  if (typeof enc === 'function') {
    cb = enc;
    enc = undefined;
  }
  enc = toEncoding(enc, this._encoding);

  __axon_stream.write(this._hookId, chunk, enc);
  this.emit('drain');
  if (typeof cb === 'function') {
    cb();
  }
  return true;
};

Writable.prototype.end = function (chunk, encoding, callback) {
  var cb = callback;
  var enc = encoding;
  if (typeof enc === 'function') {
    cb = enc;
    enc = undefined;
  }
  if (typeof chunk === 'function') {
    cb = chunk;
    chunk = undefined;
    enc = undefined;
  }

  enc = toEncoding(enc, this._encoding);
  __axon_stream.end(this._hookId, chunk, enc);
  this.writable = false;
  this.emit('finish');
  if (typeof cb === 'function') {
    cb();
  }
  return this;
};

Writable.prototype.getData = function (encoding) {
  return __axon_stream.readAll(this._hookId, toEncoding(encoding, ''));
};

function Duplex(options) {
  options = options || {};
  EventEmitter.call(this);
  this.readable = true;
  this.writable = true;
  this._encoding = toEncoding(options.encoding, 'utf8');
  this._hook = __axon_stream.createDuplex(options.source, options.encoding);
  this._hookId = this._hook.__axon_stream_id;
}

EventEmitter.inherits(Duplex);

Duplex.prototype.read = Readable.prototype.read;
Duplex.prototype.pipe = Readable.prototype.pipe;
Duplex.prototype.write = Writable.prototype.write;
Duplex.prototype.end = Writable.prototype.end;
Duplex.prototype.getData = Writable.prototype.getData;

function Transform(options) {
  Duplex.call(this, options);
}

EventEmitter.inherits(Transform);

Transform.prototype._transform = function (chunk) {
  return chunk;
};

Transform.prototype.write = function (chunk, encoding, callback) {
  var cb = callback;
  var enc = encoding;
  if (typeof enc === 'function') {
    cb = enc;
    enc = undefined;
  }
  enc = toEncoding(enc, this._encoding);

  var output = this._transform(chunk, enc);
  if (output !== undefined && output !== null) {
    __axon_stream.write(this._hookId, output, enc);
    __axon_stream.enqueue(this._hookId, output, enc);
  }
  if (typeof cb === 'function') {
    cb();
  }
  return true;
};

Transform.prototype.end = function (chunk, encoding, callback) {
  var cb = callback;
  var enc = encoding;
  if (typeof enc === 'function') {
    cb = enc;
    enc = undefined;
  }
  if (typeof chunk === 'function') {
    cb = chunk;
    chunk = undefined;
    enc = undefined;
  }

  enc = toEncoding(enc, this._encoding);
  if (chunk !== undefined && chunk !== null) {
    this.write(chunk, enc);
  }
  __axon_stream.end(this._hookId);
  this.writable = false;
  this.emit('finish');
  if (typeof cb === 'function') {
    cb();
  }
  return this;
};

Transform.prototype.getData = function (encoding) {
  return __axon_stream.readAll(this._hookId, toEncoding(encoding, ''));
};

Transform.prototype.read = function () {
  var chunk = __axon_stream.pull(this._hookId);
  if (chunk === undefined) {
    if (!this._ended && __axon_stream.eof(this._hookId)) {
      this._ended = true;
      this.readable = false;
      this.emit('end');
    }
    return null;
  }
  this.emit('data', chunk);
  return chunk;
};

var Stream = {
  Readable: Readable,
  Writable: Writable,
  Duplex: Duplex,
  Transform: Transform,
  Stream: Duplex
};
