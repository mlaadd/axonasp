// AxonASP EventEmitter integration test
// Run with: .\axonasp-cli.exe -m javascript -r www/tests/test_node_events.js

var EventEmitter = require('events').EventEmitter;
var pass = 0;
var fail = 0;

function assert(cond, name) {
  if (cond) {
    console.log('[PASS] ' + name);
    pass++;
  } else {
    console.log('[FAIL] ' + name);
    fail++;
  }
}

// --- require("events") returns an object with EventEmitter ---
var events = require('events');
assert(typeof events === 'object',                'require("events") returns object');
assert(typeof events.EventEmitter === 'function', 'events.EventEmitter is a function');

// --- Constructor creates a new emitter ---
var ee = new EventEmitter();
assert(typeof ee === 'object', 'new EventEmitter() creates object');

// --- on() + emit() ---
var onResult = null;
ee.on('data', function(v) { onResult = v; });
ee.emit('data', 42);
assert(onResult === 42, 'on() + emit() delivers value');

// --- emit() returns true with listeners, false without ---
assert(ee.emit('data', 1) === true,     'emit() returns true when listeners exist');
assert(ee.emit('noop')    === false,    'emit() returns false when no listeners');

// --- once() fires exactly once ---
var onceCount = 0;
ee.once('ping', function() { onceCount++; });
ee.emit('ping'); ee.emit('ping'); ee.emit('ping');
assert(onceCount === 1, 'once() fires exactly once');

// --- removeListener() / off() ---
var remCount = 0;
function inc() { remCount++; }
ee.on('tick', inc);
ee.on('tick', inc);
ee.removeListener('tick', inc); // removes first copy
ee.emit('tick');
assert(remCount === 1, 'removeListener() removes one copy');

var offFired = false;
function offHandler() { offFired = true; }
ee.on('offTest', offHandler);
ee.off('offTest', offHandler);
ee.emit('offTest');
assert(offFired === false, 'off() is alias for removeListener()');

// --- removeAllListeners() ---
var rAlCount = 0;
ee.on('ral', function() { rAlCount++; });
ee.on('ral', function() { rAlCount++; });
ee.removeAllListeners('ral');
ee.emit('ral');
assert(rAlCount === 0, 'removeAllListeners(event) removes all for that event');

var rAlA = 0, rAlB = 0;
ee.on('a', function() { rAlA++; });
ee.on('b', function() { rAlB++; });
ee.removeAllListeners();
ee.emit('a'); ee.emit('b');
assert(rAlA === 0 && rAlB === 0, 'removeAllListeners() with no args clears everything');

// --- listenerCount() ---
var lcEE = new EventEmitter();
lcEE.on('x', function() {}); lcEE.on('x', function() {});
assert(lcEE.listenerCount('x') === 2, 'listenerCount() returns 2');
assert(lcEE.listenerCount('y') === 0, 'listenerCount() returns 0 for unknown event');

// --- listeners() unwraps once() wrappers ---
var lEE = new EventEmitter();
function lFn1() {} function lFn2() {}
lEE.on('ev', lFn1); lEE.once('ev', lFn2);
var list = lEE.listeners('ev');
assert(list.length === 2,    'listeners() length is 2');
assert(list[0] === lFn1,     'listeners()[0] is fn1');
assert(list[1] === lFn2,     'listeners()[1] is fn2 (unwrapped)');

// --- eventNames() ---
var enEE = new EventEmitter();
enEE.on('alpha', function() {}); enEE.on('beta', function() {});
var names = enEE.eventNames();
assert(names.length === 2,             'eventNames() returns 2 names');
assert(names.indexOf('alpha') !== -1,  'eventNames() contains alpha');
assert(names.indexOf('beta')  !== -1,  'eventNames() contains beta');

// --- setMaxListeners / getMaxListeners ---
var mlEE = new EventEmitter();
mlEE.setMaxListeners(50);
assert(mlEE.getMaxListeners() === 50, 'setMaxListeners/getMaxListeners work');

// --- EventEmitter.defaultMaxListeners ---
assert(EventEmitter.defaultMaxListeners === 10, 'defaultMaxListeners is 10');

// --- EventEmitter.listenerCount() static ---
var slcEE = new EventEmitter();
slcEE.on('q', function() {}); slcEE.on('q', function() {});
assert(EventEmitter.listenerCount(slcEE, 'q') === 2, 'static listenerCount() works');

// --- prependListener() ---
var prependOrder = [];
var prEE = new EventEmitter();
prEE.on('go', function() { prependOrder.push('second'); });
prEE.prependListener('go', function() { prependOrder.push('first'); });
prEE.emit('go');
assert(prependOrder[0] === 'first' && prependOrder[1] === 'second', 'prependListener() prepends');

// --- prependOnceListener() ---
var poOrder = [];
var poEE = new EventEmitter();
poEE.on('ev', function() { poOrder.push('on'); });
poEE.prependOnceListener('ev', function() { poOrder.push('once'); });
poEE.emit('ev'); poEE.emit('ev');
assert(poOrder[0] === 'once', 'prependOnceListener() fires first');
assert(poOrder.length === 3,  'prependOnceListener() fires only once (3 total calls)');

// --- unhandled error event throws ---
var errThrew = false;
try { (new EventEmitter()).emit('error', new Error('boom')); } catch(e) { errThrew = true; }
assert(errThrew, 'unhandled error event throws');

// --- handled error event does NOT throw ---
var errHandled = false;
var errEE = new EventEmitter();
errEE.on('error', function(e) { errHandled = true; });
try { errEE.emit('error', new Error('handled')); } catch(e) { errHandled = false; }
assert(errHandled, 'handled error event does not throw');

// --- multiple emit args ---
var sumResult = 0;
var sumEE = new EventEmitter();
sumEE.on('add', function(a, b, c) { sumResult = a + b + c; });
sumEE.emit('add', 10, 20, 30);
assert(sumResult === 60, 'emit() forwards multiple arguments');

// --- chaining ---
var chainEE = new EventEmitter();
function noop() {}
var r1 = chainEE.on('x', noop);
var r2 = chainEE.once('x', noop);
var r3 = chainEE.removeListener('x', noop);
assert(r1 === chainEE && r2 === chainEE && r3 === chainEE, 'on/once/removeListener chain');

// --- inheritance via EventEmitter.inherits ---
function MyEmitter() { EventEmitter.call(this); }
EventEmitter.inherits(MyEmitter);
var myInst = new MyEmitter();
var myFired = false;
myInst.on('custom', function() { myFired = true; });
myInst.emit('custom');
assert(myFired,                 'inherited emitter fires events');
assert(myInst instanceof MyEmitter, 'instanceof MyEmitter');

// --- node:events prefix ---
var nodeEvents = require('node:events');
assert(typeof nodeEvents.EventEmitter === 'function', 'node:events resolves to same module');

// --- rawListeners() ---
var rawEE = new EventEmitter();
function rawFn() {}
rawEE.once('ev', rawFn);
var raw = rawEE.rawListeners('ev');
assert(raw.length === 1,     'rawListeners() length 1');
assert(raw[0] !== rawFn,     'rawListeners() returns wrapper, not original');
var wrapped2 = rawEE.listeners('ev');
assert(wrapped2[0] === rawFn, 'listeners() returns unwrapped original');

// --- addListener alias ---
var alEE = new EventEmitter();
var alFired = false;
alEE.addListener('tick', function() { alFired = true; });
alEE.emit('tick');
assert(alFired, 'addListener() is alias for on()');

// --- Summary ---
console.log('');
console.log('Results: ' + pass + ' passed, ' + fail + ' failed.');
if (fail > 0) { throw new Error(fail + ' test(s) failed'); }
