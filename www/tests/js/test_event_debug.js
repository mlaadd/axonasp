// Simulate the exact test.js event test behavior
function testFeature(featureName, testFn) {
    try {
        testFn();
        console.log("[ OK ] " + featureName);
    } catch (error) {
        var errMsg = error.message || error.toString();
        console.log("[ERRO] " + featureName + " -> " + errMsg);
    }
}

// First test: regular function (not events)
testFeature('Test: require crypto', function() {
    var crypto = require('crypto');
    console.log("crypto: " + typeof crypto);
});

// Second test: events
testFeature('Test: events on/emit', function() {
    var EventEmitter = require('events');
    console.log("EventEmitter: " + typeof EventEmitter);
    var emitter = new EventEmitter();
    var flag = false;
    emitter.on('data', function() { flag = true; });
    console.log("flag before emit: " + flag);
    emitter.emit('data');
    console.log("flag after emit: " + flag);
    if (!flag) throw new Error("EventEmitter didn't work");
});
