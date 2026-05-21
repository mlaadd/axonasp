console.log("=== First require inside function ===");

function testInside() {
    console.log("calling require('events') inside function...");
    var ee = require('events');
    console.log("typeof ee:", typeof ee);
    return ee;
}
var result = testInside();
console.log("result typeof:", typeof result);
console.log("result:", result);
