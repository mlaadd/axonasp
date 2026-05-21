// Test exactly like the full test.js pattern
function testFeature(name, fn) {
    try {
        fn();
        console.log("[ OK ] " + name);
    } catch(error) {
        var errMsg = error.message || error.toString();
        console.log("[ERRO] " + name + " -> " + errMsg);
    }
}

console.log("=== Test 1: crypto first ===");
testFeature('crypto test', function() {
    var c = require('crypto');
    console.log("crypto: " + typeof c);
});

console.log("=== Test 2: events ===");
testFeature('events test', function() {
    var EE = require('events');
    console.log("typeof EE: " + typeof EE);
    var inst = new EE();
    var flag = false;
    inst.on('x', function() { flag = true; });
    inst.emit('x');
    if (!flag) throw new Error("EventEmitter didn't work");
});

console.log("=== Test 3: events again ===");
testFeature('events test 2', function() {
    var EE = require('events');
    console.log("typeof EE2: " + typeof EE);
    var inst = new EE();
    var flag = false;
    inst.on('y', function() { flag = true; });
    inst.emit('y');
    if (!flag) throw new Error("EventEmitter didn't work 2");
});
