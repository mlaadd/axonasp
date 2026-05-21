// Reproduce the exact test.js sequence after crypto
function testFeature(name, fn) {
    try {
        fn();
        console.log("[ OK ] " + name);
    } catch(error) {
        var errMsg = error.message || error.toString();
        console.log("[ERRO] " + name + " -> " + errMsg);
    }
}

// Exactly like test.js: crypto first, then events
testFeature('Módulo: crypto', () => {
    const crypto = require('crypto');
    const hash = crypto.createHash('md5').update('axon').digest('hex');
    if (!hash) throw new Error("Falha ao gerar hash com crypto");
});

testFeature('Módulo: events (EventEmitter)', () => {
    const EventEmitter = require('events');
    const emitter = new EventEmitter();
    let triggered = false;
    emitter.on('teste', () => { triggered = true; });
    emitter.emit('teste');
    if (!triggered) throw new Error("EventEmitter didn't work");
});
