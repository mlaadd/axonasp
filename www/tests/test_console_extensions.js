// AxonASP console extensions test for JavaScript mode
// Run with: .\axonasp-cli.exe -m javascript -r ./www/tests/test_console_extensions.js

function assert(cond, name) {
  if (!cond) {
    throw new Error("[FAIL] " + name);
  }
  console.log("[PASS] " + name);
}

var obj = { name: "AxonASP", version: 2, nested: { ok: true } };
console.dir(obj);

console.time("phase");
for (var i = 0; i < 10000; i++) {
  var tmp = i * i;
}
console.timeEnd("phase");

function c() {
  console.trace("console trace smoke");
}
function b() {
  c();
}
function a() {
  b();
}
a();

assert(true, "console.time/timeEnd/dir/trace executed without runtime errors");

console.log("[PASS] console extensions JavaScript test completed");
