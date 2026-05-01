<%
    ' Captura o tempo inicial
    Dim tempoInicio, tempoFim, totalSegundos
    tempoInicio = Timer

    ' O Loop solicitado
    Dim i
    For i = 1 To 1000000
        ' Apenas iterando. Se você adicionar um Response.Write aqui, 
        ' o tempo será muito maior devido ao buffer do navegador.
    Next

    ' Captura o tempo final
    tempoFim = Timer

    ' Calcula a diferença
    totalSegundos = tempoFim - tempoInicio
    response.write "Tempo gasto para executar o loop: " & totalSegundos & " segundos."
%>