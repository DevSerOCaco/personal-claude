---
tipo: exame
data:                      # AAAA-MM-DD (data da coleta/realização)
categoria:                 # sangue | urina | ecg | ergometrico | imagem | outro (igual ao sufixo do arquivo)
titulo:                    # ex.: Hemograma, lipidograma e glicemia
laboratorio:
solicitante:               # médico que pediu, se informado
resultados:                # um item por analito, com a referência DO LAUDO
  - nome:                  # ex.: Colesterol LDL
    valor:                 # número, sem unidade
    unidade:               # ex.: mg/dL
    referencia:            # texto da referência do laudo, ex.: "< 130"
    status:                # normal | acima | abaixo | sem_referencia
fora_referencia: []        # nomes dos itens com status acima/abaixo
encaminhamento:            # recomendação dada (ex.: "levar ao médico antes de aumentar a intensidade")
arquivo_original:          # nome do PDF/imagem de origem, se houver
---

# Exame — {titulo} ({data})

> Registro informativo. **Não é diagnóstico.** Valores fora da referência devem ser avaliados por um médico.

## Observações do laudo
<!-- Transcreva conclusões e observações do laudo, sem interpretar. -->

## Impacto no treino
<!-- O que fica suspenso ou adaptado até a avaliação médica, se for o caso. -->
