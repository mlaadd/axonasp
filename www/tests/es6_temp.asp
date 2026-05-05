<script runat="server" language="JScript">
var results = [];
function dbl(x) { return x * 2; }
results.push(dbl(5) === 10 ? "PASS" : "FAIL");
Response.Write(results[0]);
</script>
