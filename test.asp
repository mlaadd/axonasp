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

<script runat="server" language="JScript">
    // Captura o tempo inicial (em milissegundos)
    var tempoInicio = new Date().getTime();

    // O Loop de 1 a 100.000
    for (var i = 1; i <= 100000; i++) {
        // No JScript, o corpo pode ficar vazio ou com um comentário
    }

    // Captura o tempo final
    var tempoFim = new Date().getTime();

    // Calcula a diferença e converte para segundos
    var totalSegundos = (tempoFim - tempoInicio) / 1000;

    // Exibe os resultados
    Response.Write("<h2>Resultado do Processamento</h2>");
    Response.Write("O loop de 1 a 100.000 foi concluído.<br>");
    Response.Write("Tempo levado: " + totalSegundos + " segundos.");


</script>