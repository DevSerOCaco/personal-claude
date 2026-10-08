---
tipo: avaliacao
data:                      # AAAA-MM-DD (igual ao nome do arquivo)
profissional:              # nome e registro (ex.: CREF/CRN), se houver
local:                     # academia, clínica…
metodo_composicao:         # dobras-pollock7 | dobras-pollock3 | bioimpedancia | dexa | outro
peso_kg:
gordura_pct:
massa_magra_kg:
massa_gorda_kg:
imc:
dobras_mm:                 # deixe vazio o que não foi medido
  peitoral:
  axilar_media:
  triceps:
  subescapular:
  abdominal:
  suprailiaca:
  coxa:
circunferencias_cm:        # _d = direito, _e = esquerdo
  pescoco:
  ombros:
  torax:
  cintura:
  abdome:
  quadril:
  braco_d:                 # relaxado
  braco_e:
  braco_d_contraido:
  braco_e_contraido:
  antebraco_d:
  antebraco_e:
  coxa_d:                  # no ponto indicado em coxa_local
  coxa_e:
  coxa_d_distal:           # logo acima do joelho, se medida
  coxa_e_distal:
  panturrilha_d:
  panturrilha_e:
coxa_local:                # ponto de coxa_d/coxa_e: proximal | medial | outro (só compare coxas medidas no mesmo ponto)
pressao_arterial:          # "120/80" (entre aspas)
fc_repouso_bpm:
testes: []                 # lista de { teste, resultado, unidade, categoria: forca | mobilidade | resistencia }
                           # ex.: - { teste: supino 1RM estimado, resultado: 80, unidade: kg, categoria: forca }
arquivo_original:          # nome do PDF/imagem de origem, se houver
---

# Avaliação física — {data}

## Observações do profissional
<!-- Transcreva o que o laudo diz, sem interpretar. -->

## Comparação com a avaliação anterior
<!-- Tabela | Medida | Anterior (data) | Atual | Variação | preenchida pelo /nova-avaliacao. -->

## Comentário
<!-- Leitura da evolução em relação ao objetivo e ao plano vigente. -->
