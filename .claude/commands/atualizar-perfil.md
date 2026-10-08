---
description: Atualiza objetivos, rotina, disponibilidade, equipamentos ou restrições, mantendo histórico
argument-hint: "[o que mudou, ex.: 'agora só posso treinar 3x']"
---

# /atualizar-perfil

Mudança: `$ARGUMENTS` (se vazio, pergunte o que mudou).

Siga o protocolo do `CLAUDE.md`. Se `dados/perfil.md` não existir, sugira `/onboarding` e pare.

## Passos
1. **Entender a mudança**: o que mudou, desde quando, se é temporário (ex.: viagem de 2 semanas) ou permanente. Faça perguntas só se necessário.
   - Mudança **temporária**: não altere o perfil. Registre em `decisoes.md` e, se for o caso, proponha uma adaptação temporária do plano.
2. **Mostrar o antes → depois** de cada campo afetado e confirmar.
3. **Aplicar** em `dados/perfil.md`:
   - Campos do frontmatter (ex.: `dias_por_semana`, `objetivo_principal`, `restricoes`, `equipamentos`) e as seções de texto correspondentes.
   - `atualizado_em` = hoje.
   - Linha no **Histórico de alterações**: `- {hoje}: {campo}: {antes} → {depois} — {motivo}`. **Nunca apague** linhas do histórico.
4. **Saúde**: se a mudança envolve nova dor, lesão, condição, medicamento ou sintoma, aplique a seção 5 do `CLAUDE.md` (sinalizar, encaminhar, atualizar `parq_alerta`, `liberacao_medica` e `restricoes`).
5. **Impacto no plano**: avalie se o plano vigente ainda faz sentido (ex.: o plano tem 4 dias e agora são 3). Se não fizer, diga o que precisaria mudar e sugira `/montar-treino` ou um ajuste via `/revisar-progresso`. **Não altere o plano sem aprovação.**
6. **Conhecimento**: se a mudança revela uma preferência ou um padrão, registre em `conhecimento.md`.
7. **Commit**: `perfil: {resumo}` + push.
