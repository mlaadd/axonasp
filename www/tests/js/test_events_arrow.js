console.log("=== require events with arrow callback ===");

function testFeature(name, fn) {
    try {
        fn();
        console.log("[ OK ] " + name);
    } catch(e) {
        console.log("[ERRO] " + name + " -> " + e.message);
    }
}

// Use regular function as callback
testFeature('regular function callback', function() {
    var EventEmitter = require('events');
    console.log("typeof EventEmitter:", typeof EventEmitter);
    var emitter = new EventEmitter();
    var triggered = false;
    emitter.on('test', function() { triggered = true; });
    emitter.emit('test');
    if (!triggered) throw new Error("not triggered");
});

// Use arrow function as callback  
testFeature('arrow function callback', () => {
    const EventEmitter = require('events');
    console.log("typeof EventEmitter (arrow):", typeof EventEmitter);
    const emitter = new EventEmitter();
    let triggered = false;
    emitter.on('test', function() { triggered = true; });
    emitter.emit('test');
    if (!triggered) throw new Error("not triggered");
});
