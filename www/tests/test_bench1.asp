<%
    Dim tempoInicio, tempoFim, totalSegundos
    tempoInicio = Timer
    Dim i
    For i = 1 To 1000000
    Next

    tempoFim = Timer

    totalSegundos = tempoFim - tempoInicio
    response.write "Tempo gasto para executar o loop: " & totalSegundos & " segundos."
%>

<script runat="server" language="JScript">
    // Captura o tempo inicial (em milissegundos)
    var tempoInicio = new Date().getTime();

    // O Loop de 1 a 100.000
    for (var i = 1; i <= 100000; i++) {

    }


    var tempoFim = new Date().getTime();


    var totalSegundos = (tempoFim - tempoInicio) / 1000;


    Response.Write("<h2>Resultado do Processamento</h2>");
    Response.Write("O loop de 1 a 100.000 foi concluído.<br>");
    Response.Write("Tempo levado: " + totalSegundos.toFixed(2) + " segundos.");


</script>