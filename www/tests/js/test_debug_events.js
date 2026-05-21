// Debug: Check what require('events') returns on first call
console.log("=== First require('events') ===");
var ee1 = require('events');
console.log("typeof ee1: " + typeof ee1);
console.log("ee1 === undefined: " + (ee1 === undefined));

// Try to call new on it
try {
    var inst1 = new ee1();
    console.log("new ee1() succeeded");
} catch(e) {
    console.log("new ee1() failed: " + e.message);
}

console.log("=== Second require('events') ===");
var ee2 = require('events');
console.log("typeof ee2: " + typeof ee2);

// Now try require('events').EventEmitter
console.log("=== require('events').EventEmitter ===");
try {
    var EE = require('events').EventEmitter;
    console.log("typeof EE: " + typeof EE);
    var inst = new EE();
    console.log("new EE() succeeded");
    var flag = false;
    inst.on('test', function() { flag = true; });
    inst.emit('test');
    console.log("flag after emit: " + flag);
} catch(e) {
    console.log("Error: " + e.message);
}

// Now test with testFeature pattern
console.log("=== Using testFeature pattern ===");
function testFeature(name, fn) {
    try {
        fn();
        console.log("[ OK ] " + name);
    } catch(e) {
        console.log("[ERRO] " + name + " -> " + (e.message || e.toString()));
    }
}

testFeature('Events test', function() {
    var EE2 = require('events');
    console.log("  typeof EE2 in callback: " + typeof EE2);
    var inst2 = new EE2();
    var triggered = false;
    inst2.on('evt', function() { triggered = true; });
    inst2.emit('evt');
    if (!triggered) throw new Error("Not triggered");
});
