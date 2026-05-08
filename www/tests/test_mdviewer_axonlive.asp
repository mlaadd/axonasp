<%@ Language="JavaScript" %>
<%
/* Test: MD Viewer AxonLive component pattern */
var AxonLive = Server.CreateObject("G3AXONLIVE");
AxonLive.InitPage();

var sessionID = Session.SessionID;

// Restore persisted component state (survives across async re-executions)
var axl_mdviewer_1_val = AxonLive.GetComponentProperty(sessionID, "axl_mdviewer_1", "val");
if (!axl_mdviewer_1_val) {
    var __mdpath_axl_mdviewer_1 = Server.MapPath("/manual/md/axonasp/welcome.md");
    var __g3files_axl_mdviewer_1 = Server.CreateObject("G3FILES");
    if (__g3files_axl_mdviewer_1.Exists(__mdpath_axl_mdviewer_1)) {
        var __g3md_axl_mdviewer_1 = Server.CreateObject("G3MD");
        __g3md_axl_mdviewer_1.Unsafe = true;
        axl_mdviewer_1_val = __g3md_axl_mdviewer_1.Process(__g3files_axl_mdviewer_1.Read(__mdpath_axl_mdviewer_1, "utf-8"));
    } else { axl_mdviewer_1_val = ""; }
}

if (AxonLive.IsAsyncRequest) {
    var compID  = AxonLive.EventComponentID;
    var evtName = AxonLive.EventName;

    switch (compID) {

    }

    // Persist updated state for the next async call
    AxonLive.SetComponentProperty(sessionID, "axl_mdviewer_1", "val", String(axl_mdviewer_1_val));

    AxonLive.RegisterComponent("axl_mdviewer_1", '<div id="axl_mdviewer_1" style="width:600px;height:400px;position:absolute;top:10px;left:10px;overflow:auto;">' + (axl_mdviewer_1_val || '') + '</div>');

    AxonLive.EndAsyncResponse();
}
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>MD Viewer Test</title>
        <link rel="stylesheet" href="/css/axonasp.css">
    </head>

    <body>
        <div id="main-container">
            <div id="content">
                <div id="axl_mdviewer_1"
                    style="width:600px;height:400px;position:absolute;top:10px;left:10px;overflow:auto;">
                    <%=axl_mdviewer_1_val%></div>
            </div>
        </div>
        <script src="/axonlive/g3axonlive.js"></script>
        <script>
            G3AxonLive.init('<%=Server.HTMLEncode(Session.SessionID)%>');
        </script>
    </body>

</html>