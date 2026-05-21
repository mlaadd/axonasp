console.log("=== require events inside function ===");

// Call require at global scope first
var globalEE = require('events');
console.log("global require('events'):", typeof globalEE);

// Now inside a function
function testInside() {
    var ee = require('events');
    console.log("inside function require('events'):", typeof ee);
    return ee;
}
var result = testInside();
console.log("result typeof:", typeof result);
