<%@ Language=VBScript %>
<%
    ' AxonASP Search Library Test
    ' Demonstrates G3SEARCH indexing and searching capabilities.
    
    Dim search, results, term, i, indexPath, docsPath, msg
    Dim resultRow, resultPath, resultScore
    
    ' Define paths
    indexPath = Server.MapPath("../temp/g3search.index")
    docsPath = Server.MapPath("../manual/md/")
    
    Set search = Server.CreateObject("G3SEARCH")
    search.IndexPath = indexPath
    search.DocsPath = docsPath
    search.Extension = ".md"
    
    ' Handle indexing request
    If Request.Form("action") = "build" Then
        search.BuildIndex()
        msg = "Index built successfully at " & indexPath
    End If
    
    term = Request.Form("term")
%>
<!DOCTYPE html>
<html>

    <head>
        <title>AxonASP Search Test</title>
        <link rel="stylesheet" type="text/css" href="../css/axonasp.css">
        <style>
            #content {
                padding: 20px;
            }

            .search-input {
                padding: 6px;
                border: 1px solid var(--win-border);
                border-radius: var(--radius-sm);
                width: 300px;
                font-family: Tahoma, Verdana, sans-serif;
            }
        </style>
    </head>

    <body>
        <div id="header">
            <div style="padding: 15px; color: white; font-weight: bold; font-size: 1.2em;">
                AxonASP Search - G3SEARCH Engine
            </div>
        </div>

        <div id="main-container">
            <div id="content">
                <div class="window">
                    <div class="window-header">Search Documents</div>
                    <div class="window-body">
                        <% If msg <> "" Then %>
                        <div class="alert alert-success"><%=msg%></div>
                        <% End If %>

                        <form method="POST">
                            <div class="info-banner">
                                <strong>Documents Path:</strong> <%=docsPath%><br>
                                <strong>Index Path:</strong> <%=indexPath%><br>
                                <strong>Extension:</strong> <%=search.Extension%>
                            </div>

                            <div class="actions-row"
                                style="margin-top: 15px; display: flex; align-items: center; gap: 10px;">
                                <input type="text" name="term" value="<%=Server.HTMLEncode(term)%>"
                                    placeholder="Enter search term..." class="search-input">
                                <button type="submit" class="btn btn-primary">Search</button>
                                <button type="submit" name="action" value="build" class="btn btn-secondary">Rebuild
                                    Index</button>
                            </div>
                        </form>

                        <% If term <> "" Then 
                        results = search.Search(term)
                        If IsArray(results) Then
                    %>
                        <h2
                            style="margin-top: 25px; font-size: 1.1em; border-bottom: 1px solid var(--win-blue-light); padding-bottom: 5px;">
                            Search Results for "<%=Server.HTMLEncode(term)%>"
                        </h2>
                        <div class="table-wrap" style="margin-top: 10px;">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Matching Document Path</th>
                                        <th style="width: 140px; text-align: right;">Score</th>
                                        <th style="width: 120px; text-align: center;">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    Dim hasResults
                                    hasResults = False
                                    If UBound(results) >= LBound(results) Then
                                        hasResults = True
                                        For i = LBound(results) To UBound(results)
                                            resultPath = ""
                                            resultScore = ""
                                            resultRow = results(i)

                                            If IsArray(resultRow) Then
                                                If UBound(resultRow) >= 1 Then
                                                    resultPath = CStr(resultRow(0))
                                                    resultScore = CStr(CDbl(resultRow(1)))
                                                End If
                                            Else
                                                ' Backward compatibility with older one-dimensional return payload.
                                                resultPath = CStr(resultRow)
                                            End If
                                    %>
                                    <tr>
                                        <td><%=Server.HTMLEncode(resultPath)%></td>
                                        <td style="text-align: right;"><%=Server.HTMLEncode(resultScore)%></td>
                                        <td style="text-align: center;"><span class="status-v">Found</span></td>
                                    </tr>
                                    <% 
                                        Next 
                                    End If 
                                    
                                    If Not hasResults Then 
                                    %>
                                    <tr>
                                        <td colspan="3"
                                            style="text-align: center; padding: 20px; color: var(--win-border);">
                                            No results found matching your query.
                                        </td>
                                    </tr>
                                    <% End If %>
                                </tbody>
                            </table>
                        </div>
                        <div style="margin-top: 10px; font-size: 0.9em; color: var(--win-border);">
                            <% If hasResults Then %>
                            Total documents found: <%=UBound(results) - LBound(results) + 1%>
                            <% End If %>
                        </div>
                        <% 
                        End If 
                    End If %>
                    </div>
                </div>

                <div class="card" style="margin-top: 20px;">
                    <div class="card-top-blue">G3SEARCH Integration Details</div>
                    <div style="padding: 15px;">
                        <p>The <strong>G3SEARCH</strong> library utilizes the <strong>Bluge</strong> indexing engine to
                            provide full-text search capabilities within the AxonASP environment. It supports recursive
                            document scanning, stored field retrieval, and high-performance querying.</p>
                        <ul style="margin-top: 10px; padding-left: 20px;">
                            <li><strong>BuildIndex:</strong> Scans the target directory and updates the search index.
                            </li>
                            <li><strong>Search:</strong> Performs a match query on indexed document content.</li>
                            <li><strong>Configurable:</strong> Customize the index location, source documents, and file
                                extensions.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div id="status-bar">
            AxonASP Search Library - G3SEARCH Ready
        </div>
    </body>

</html>