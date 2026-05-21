// First require inside a regular function (no try/catch wrapper)
function testEvents() {
    var EE = require('events');
    console.log("First call inside function: " + typeof EE);
}
testEvents();

// Second call also inside function
function testEvents2() {
    var EE2 = require('events');
    console.log("Second call inside function: " + typeof EE2);
}
testEvents2();
