// Test 1: Global scope (no wrapper)
console.log("=== Global scope ===");
var events1 = require('events');
console.log("typeof events1: " + typeof events1);

// Test 2: Inside a regular function
console.log("=== Inside function ===");
function testInside() {
    var events2 = require('events');
    console.log("typeof events2: " + typeof events2);
}
testInside();

// Test 3: Inside an IIFE
console.log("=== Inside IIFE ===");
(function() {
    var events3 = require('events');
    console.log("typeof events3: " + typeof events3);
})();

// Test 4: Arrow function
console.log("=== Inside arrow function ===");
var testArrow = () => {
    var events4 = require('events');
    console.log("typeof events4: " + typeof events4);
};
testArrow();

// Test 5: Nested function (more realistic test)
console.log("=== Nested function test (similar to testFeature) ===");
function testFeature(name, fn) {
    try {
        fn();
        console.log("[ OK ] " + name);
    } catch(e) {
        console.log("[ERRO] " + name + " -> " + e.message);
    }
}

testFeature('events inside callback', function() {
    var EventEmitter = require('events');
    console.log("typeof EventEmitter inside testFeature: " + typeof EventEmitter);
    if (typeof EventEmitter !== 'function') {
        throw new Error("EventEmitter is not a function, got: " + typeof EventEmitter);
    }
    var emitter = new EventEmitter();
    var flag = false;
    emitter.on('test', function() { flag = true; });
    emitter.emit('test');
    if (!flag) {
        throw new Error("Listener was not called");
    }
});
