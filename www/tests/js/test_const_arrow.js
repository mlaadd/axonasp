// Test with const/let inside arrow function, matching test.js exactly
function testFeature(name, fn) {
    try {
        fn();
        console.log("[ OK ] " + name);
    } catch(error) {
        var errMsg = error.message || error.toString();
        console.log("[ERRO] " + name + " -> " + errMsg);
    }
}

console.log("=== Test 1: crypto ===");
testFeature('crypto test', () => {
    const crypto = require('crypto');
    console.log("crypto type: " + typeof crypto);
});

console.log("=== Test 2: events ===");
testFeature('events test', () => {
    const EE = require('events');
    const inst = new EE();
    let flag = false;
    inst.on('x', () => { flag = true; });
    inst.emit('x');
    if (!flag) throw new Error("EventEmitter didn't work");
});
