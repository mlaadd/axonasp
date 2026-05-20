var objs = [{name: "a"}, {name: "b"}, {name: "c"}];
var str = objs.join(",");
console.log("join result: " + str);

var obj = {key: "val"};
var concat = "prefix: " + obj;
console.log("concat with obj: " + concat);

var arr = [{x:1}, {x:2}];
arr.forEach(function(item) {
    console.log("item: " + item);
});
