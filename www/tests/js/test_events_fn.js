console.log("=== EventEmitter inside function test ===");

function testFeature(name, fn) {
    try {
        fn();
        console.log("[ OK ] " + name);
    } catch(e) {
        console.log("[ERRO] " + name + " -> " + e.message);
    }
}

testFeature('EventEmitter inside callback', () => {
    const EventEmitter = require('events');
    console.log("typeof EventEmitter inside fn:", typeof EventEmitter);
    const emitter = new EventEmitter();
    let triggered = false;
    emitter.on('test', function() { triggered = true; });
    emitter.emit('test');
    console.log("triggered inside fn:", triggered);
    if (!triggered) throw new Error("EventEmitter didn't work");
});
