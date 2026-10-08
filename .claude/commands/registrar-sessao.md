---
description: Registra um treino (relato livre ou anotações do celular), compara com a sessão anterior e sugere a próxima progressão
argument-hint: "[relato do treino] (vazio = processar anotações pendentes do diário)"
---

# /registrar-sessao

Relato: `$ARGUMENTS`

Siga o protocolo do `CLAUDE.md`. **Rode `git pull --rebase` primeiro**: as anotações do celular chegam por aí. Leia `treino-atual.md`, o plano completo, `conhecimento.md` e o diário do mês atual e do anterior.

## 1. Identificar o que registrar
- **Com relato** (`$ARGUMENTS` ou mensagem do usuário): é uma sessão nova. Data = hoje, a menos que o usuário diga outra.
- **Sem relato**: procure no diário do mês atual (e do anterior) blocos **sem a linha `- Próxima:`**. São anotações rápidas ainda não processadas. Processe todas, da mais antiga para a mais recente. Se não houver nenhuma, peça o relato.
- Identifique qual dia do plano foi feito (Treino A, B…) pelos exercícios. Na dúvida, pergunte.

## 2. Normalizar
Converta para o formato do diário definido no `CLAUDE.md` (seção 3, diário):
```
## AAAA-MM-DD — Treino X
- Exercício: 4x8 @ 60kg (RIR 2)
- Exercício: 60kg x 10, 10, 9, 8
- Energia: n/5 | Sono: nh | Dor: ...
- Notas: ...
- Próxima: ...
```
- Use os **mesmos nomes de exercício do plano** (ex.: "supino" → "Supino reto com halteres", se é o que está no plano).
- Mantenha o que o usuário disse; não invente cargas, repetições nem RIR. Se faltar algo essencial (ex.: carga), pergunte uma vez; se ele não souber, registre sem.
- Exercício do plano que não foi feito: `- Exercício: não feito (motivo)`, se o motivo for conhecido.
- Arquivo: `dados/diario/AAAA-MM.md`. Se não existir, crie a partir de `templates/diario-mes.md` (`plano` = plano vigente; `sessoes_planejadas` = dias_por_semana × semanas do mês em que o plano esteve vigente, arredondado). Se existir **sem frontmatter** (criado pelo celular), adicione o frontmatter do modelo no topo, preservando o conteúdo.
- Ao processar uma anotação do celular, **substitua o bloco original** pela versão normalizada, no mesmo lugar.
- Mantenha os blocos em ordem cronológica.

## 3. Comparar com a sessão anterior do mesmo treino
Procure a última ocorrência do mesmo dia (ex.: Treino A anterior) e compare exercício por exercício: carga, repetições, RIR. Classifique cada um como **progrediu**, **manteve** ou **regrediu**.

## 4. Sugerir a progressão da próxima sessão
Aplique a regra do plano (padrão: dupla progressão):
- todas as séries no topo da faixa com o RIR alvo → subir a carga (menor incremento disponível) e voltar ao fundo da faixa;
- dentro da faixa → mesma carga, buscar +1 repetição nas séries que ficaram abaixo;
- regrediu → manter a carga e checar sono, energia e dor;
- dor no exercício → não progredir; considerar variação (seção 4 do `CLAUDE.md`).

Escreva a linha `- Próxima:` com a sugestão concreta e curta (ex.: `Próxima: supino 22kg x 8–12; remada manter 50kg, buscar 4x10`).

## 5. Responder ao usuário
Curto, de preferência em até 8 linhas: o que foi registrado, o destaque (recorde, progressão ou alerta) e a próxima progressão. Se a sessão foi processada de anotações, diga quantas foram processadas.

## 6. Sinais de alerta
- Dor relatada: registre e, se for recorrente (ver o diário) ou se piorar, siga a seção 5 do `CLAUDE.md`.
- 3+ sessões sem progressão no mesmo exercício, energia ≤ 2/5 repetida ou várias sessões perdidas: sugira `/revisar-progresso`.
- Sintomas cardiovasculares: siga a seção 5 imediatamente.

## 7. Atualizar a base e commitar
- Atualize `sessoes_realizadas` no frontmatter do mês (conte os blocos realizados, sem contar os "não realizado").
- **Dor ou desconforto novo**: registre já na primeira ocorrência em `conhecimento.md` → "Desconfortos e exercícios a evitar" (ex.: `- (2026-09-29) Joelho E incomodou na última série do agachamento a 85kg — 1ª ocorrência, observar.`). Nas ocorrências seguintes, consolide na mesma linha (contagem e intervalo de datas).
- Fora isso, registre em `conhecimento.md` apenas **padrões** (ex.: rende melhor treinando de manhã; perde o treino de sexta com frequência), consolidando entradas existentes.
- Commit: `diario: treino X AAAA-MM-DD` (várias sessões: `diario: N sessões processadas`) + push.
