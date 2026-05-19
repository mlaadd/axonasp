// AxonASP Node.js stream integration test
// Run with: .\axonasp-cli.exe -m javascript -r .\www\tests\test_node_stream.js

var stream = require('stream');
var pass = 0;
var fail = 0;

function assert(cond, name) {
  if (cond) {
    console.log('[PASS] ' + name);
    pass++;
  } else {
    console.log('[FAIL] ' + name);
    fail++;
  }
}

assert(typeof stream === 'object', 'require("stream") returns object');
assert(typeof stream.Readable === 'function', 'Readable constructor exists');
assert(typeof stream.Writable === 'function', 'Writable constructor exists');
assert(typeof stream.Duplex === 'function', 'Duplex constructor exists');
assert(typeof stream.Transform === 'function', 'Transform constructor exists');

var readable = new stream.Readable({ source: ['a', 'x', 'o', 'n'] });
var c1 = readable.read();
var c2 = readable.read();
var c3 = readable.read();
var c4 = readable.read();
var c5 = readable.read();
var readableOut = new stream.Writable();
readableOut.write(c1);
readableOut.write(c2);
readableOut.write(c3);
readableOut.write(c4);
readableOut.end();
assert(readableOut.getData('utf8') === 'axon', 'Readable emits expected chunk sequence');
assert(c5 === null, 'Readable returns null on EOF');

var writable = new stream.Writable();
writable.write('ab');
writable.write(Buffer.from('cd'));
writable.end('ef');
assert(writable.getData('utf8') === 'abcdef', 'Writable stores all bytes');

var pipeReadable = new stream.Readable({ source: ['hello', ' ', 'stream'] });
var pipeWritable = new stream.Writable();
pipeReadable.pipe(pipeWritable);
assert(pipeWritable.getData('utf8') === 'hello stream', 'pipe() transfers readable to writable');

var duplex = new stream.Duplex({ source: ['r1', 'r2'] });
duplex.write('w1');
duplex.end('w2');
assert(duplex.getData('utf8') === 'w1w2', 'Duplex writes and collects data');
var duplexR1 = duplex.read();
var duplexR2 = duplex.read();
var duplexR3 = duplex.read();
var duplexOut = new stream.Writable();
duplexOut.write(duplexR1);
duplexOut.write(duplexR2);
duplexOut.end();
assert(duplexOut.getData('utf8') === 'r1r2', 'Duplex reads chunk sequence');
assert(duplexR3 === null, 'Duplex returns null at EOF');

var transform = new stream.Transform();
transform._transform = function (chunk) {
  return '[' + String(chunk).toUpperCase() + ']';
};
transform.write('go');
transform.end('lang');
assert(transform.getData('utf8') === '[GO][LANG]', 'Transform stores transformed output');

console.log('');
console.log('Results: ' + pass + ' passed, ' + fail + ' failed.');
if (fail > 0) {
  throw new Error(fail + ' test(s) failed');
}
