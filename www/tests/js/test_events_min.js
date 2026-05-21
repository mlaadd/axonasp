console.log("=== EventEmitter minimal test ===");

// Test 1: require returns something
var EE = require('events');
console.log("typeof EE:", typeof EE);
console.log("EE:", EE);

// Test 2: new EventEmitter works
var emitter = new EE();
console.log("emitter:", emitter);
console.log("typeof emitter.on:", typeof emitter.on);
console.log("typeof emitter.emit:", typeof emitter.emit);

// Test 3: simple on/emit
var triggered = false;
console.log("triggered before:", triggered);
emitter.on('test', function() { triggered = true; });
console.log("after on, triggered:", triggered);
emitter.emit('test');
console.log("after emit, triggered:", triggered);

if (!triggered) {
    console.log("FAIL: EventEmitter did not trigger");
} else {
    console.log("PASS: EventEmitter works");
}
