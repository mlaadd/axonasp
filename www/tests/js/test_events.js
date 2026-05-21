// Minimal EventEmitter test
(function() {
    console.log("=== Test: require events ===");
    try {
        var events = require('events');
        console.log("require('events') succeeded, type: " + typeof events);
        console.log("events.EventEmitter type: " + typeof events.EventEmitter);
        console.log("events.on type: " + typeof events.on);
    } catch(e) {
        console.log("require('events') failed: " + e.message);
    }

    console.log("=== Test: new EventEmitter ===");
    try {
        var EventEmitter = require('events').EventEmitter;
        var ee = new EventEmitter();
        console.log("new EventEmitter() succeeded");
        console.log("ee._events: " + (ee._events ? "exists" : "null/undefined"));

        // Test on/emit
        var flag1 = false;
        ee.on('test', function() { flag1 = true; });
        console.log("after on('test'): listeners = " + (ee._events && ee._events.test ? ee._events.test.length : 0));
        ee.emit('test');
        console.log("after emit('test'): flag1 = " + flag1);

        if (flag1) {
            console.log("[ OK ] Basic on/emit works");
        } else {
            console.log("[FALTA] Basic on/emit failed: listener not called");
        }
    } catch(e) {
        console.log("EventEmitter test error: " + e.message);
    }

    console.log("=== Test: Arrow function listener ===");
    try {
        var EventEmitter2 = require('events').EventEmitter;
        var ee2 = new EventEmitter2();
        var trigger2 = false;
        ee2.on('evt', () => { trigger2 = true; });
        ee2.emit('evt');
        if (trigger2) {
            console.log("[ OK ] Arrow function listener works");
        } else {
            console.log("[FALTA] Arrow function listener not called");
        }
    } catch(e) {
        console.log("Arrow test error: " + e.message);
    }

    console.log("=== Test: Multiple arguments to emit ===");
    try {
        var EventEmitter3 = require('events').EventEmitter;
        var ee3 = new EventEmitter3();
        var receivedArg = null;
        ee3.on('data', function(arg) { receivedArg = arg; });
        ee3.emit('data', 'hello');
        console.log("receivedArg = " + receivedArg);
        if (receivedArg === 'hello') {
            console.log("[ OK ] Arguments passed correctly");
        } else {
            console.log("[FALTA] Argument not received correctly, got: " + JSON.stringify(receivedArg));
        }
    } catch(e) {
        console.log("Multi-arg test error: " + e.message);
    }

    console.log("\n=== All tests completed ===");
})();
