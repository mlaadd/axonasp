// Test: require events module directly
var events = require('events');
console.log("typeof events: " + typeof events);
console.log("events is null? " + (events === null));
console.log("events is undefined? " + (events === undefined));

// Try to print the constructor
try {
    console.log("events.EventEmitter: " + typeof events.EventEmitter);
} catch(e) {
    console.log("Error accessing events.EventEmitter: " + e.message);
}

// Now let's check if EventEmitter is globally available
console.log("global EventEmitter: " + typeof EventEmitter);
