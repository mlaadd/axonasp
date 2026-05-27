<p align="center">&nbsp;</p>
<form method="Post" ACTION="atumd2.asp#usingtheadrotatorcomponent">
    <input type="hidden" name="Clickme" value="True"><p align="center"><input type="Submit" Value="Show Me"></p>
</form>
<p align="center">
<%If Request.form("Clickme") = "True" then
	set Ad = Server.CreateObject("MSWC.Adrotator")%>
	<%= Ad.GetAdvertisement("/aspsamp/tutorial/lessons/adrot.txt")%></p>
<%end if%>
