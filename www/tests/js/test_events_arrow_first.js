console.log("=== First require inside arrow callback ===");

function runTest(fn) {
    fn();
}

runTest(() => {
    console.log("inside arrow, calling require('events')...");
    const EventEmitter = require('events');
    console.log("typeof EventEmitter:", typeof EventEmitter);
    
    const emitter = new EventEmitter();
    let triggered = false;
    emitter.on('test', function() { triggered = true; });
    emitter.emit('test');
    console.log("triggered:", triggered);
    
    if (!triggered) {
        console.log("FAIL");
    } else {
        console.log("PASS");
    }
});
