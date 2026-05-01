import time

# Captura o tempo inicial (em segundos)
tempo_inicio = time.time()

# O Loop de 1 a 100.000
# Usamos 100001 porque o range no Python é exclusivo no final
for i in range(1, 1000001):
    pass  # 'pass' indica que não há ação dentro do loop

# Captura o tempo final
tempo_fim = time.time()

# Calcula a diferença
total_segundos = tempo_fim - tempo_inicio

print(f"Resultado do Processamento")
print(f"O loop de 1 a 100.000 foi concluído.")
print(f"Tempo levado: {total_segundos:.6f} segundos.")