// Initialize events at global scope first
var EE = require('events');
console.log("Global scope EE type: " + typeof EE);

// Now test inside function
function testFeature2(name, fn) {
    try {
        fn();
        console.log("[ OK ] " + name);
    } catch(e) {
        console.log("[ERRO] " + name + " -> " + (e.message || e.toString()));
    }
}

testFeature2('Events inside function', function() {
    var EE2 = require('events');
    console.log("  Inside function EE2 type: " + typeof EE2);
    var inst = new EE2();
    var flag = false;
    inst.on('evt', function() { flag = true; });
    inst.emit('evt');
    if (!flag) throw new Error("Not triggered");
});
