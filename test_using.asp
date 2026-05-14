<script runat="server" language="JScript">
	var disposed = false;
	class Resource {
		[Symbol.dispose]() {
			disposed = true;
			Response.Write("Resource disposed\n");
		}
	}

	{
		using res = new Resource();
		Response.Write("Inside block\n");
	}
	Response.Write("Outside block, disposed: " + disposed + "\n");
</script>