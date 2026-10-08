---
description: Monta um novo plano de treino; só salva após aprovação do usuário
argument-hint: "[pedidos específicos, ex.: 'foco em costas, 3 dias']"
---

# /montar-treino

Pedidos do usuário: `$ARGUMENTS`

Siga o protocolo do `CLAUDE.md` e a seção 4 (Metodologia). Leia perfil, conhecimento, decisões, o plano atual, as últimas 4–8 semanas do diário, a última avaliação e os exames com `fora_referencia`.

## 1. Verificar se há informação suficiente
São necessários: objetivo, nível, dias por semana, minutos por sessão, local e equipamentos, restrições e dores.
- Se faltar algo, **pergunte** (poucas perguntas, de uma vez) antes de propor.
- Se `dados/perfil.md` não existir: sugira `/onboarding` e pare.
- Se `parq_alerta: true` sem `liberacao_medica: sim`, ou se houver exame com encaminhamento pendente: avise em destaque e proponha apenas um plano **conservador** (intensidade moderada, RIR ≥ 3, sem testes máximos), deixando explícito o que fica para depois da liberação.

## 2. Confirmar o momento atual
Em uma mensagem curta, confirme: objetivo do ciclo, dias/tempo disponíveis **agora** e qualquer mudança recente (dor, rotina, viagem). Se o plano anterior existe, resuma em 2–3 linhas como ele foi (aderência, progressões, dores), com base no diário.

## 3. Propor
Apresente o plano **no chat, sem salvar ainda**:
- Divisão e semana tipo.
- Volume semanal por grupamento (séries) e por que esse volume.
- Para cada dia: tabela `Exercício | Séries | Reps | RIR | Descanso`.
- Regra de progressão (padrão: dupla progressão) e critérios de deload.
- Duração do ciclo (4–8 semanas).
- Explique brevemente as escolhas principais, incluindo exercícios evitados por causa do `conhecimento.md`.
- Confira que cada sessão cabe em `minutos_por_sessao` (estimativa: ~3 min por série em multiarticulares e ~2 min em isoladores, já com o descanso).

## 4. Ajustar
Incorpore o feedback e reapresente só o que mudou. Repita até o usuário **aprovar explicitamente**.

## 5. Salvar (só após a aprovação)
1. `dados/treinos/{data_inicio}-{nome-em-slug}.md` a partir de `templates/treino.md`, com `status: ativo`.
2. O plano anterior (se houver): `status: encerrado`.
3. `dados/treino-atual.md` a partir de `templates/treino-atual.md`, com a versão enxuta para celular e `plano: treinos/{arquivo}.md`.
4. `dados/decisoes.md`: nova entrada no topo (`## {hoje} — Novo ciclo: {nome}`, com Decisão, Motivo e Revisar em = data de fim prevista).
5. `dados/conhecimento.md`: preferências ou restrições novas que surgiram na conversa.
6. Se o mês atual ainda não tem diário, não crie agora: ele é criado na primeira sessão.
7. Commit: `treino: {nome do ciclo}` + push.

Encerre com o primeiro treino da semana em destaque e um lembrete de como registrar (`/registrar-sessao` ou anotação no diário pelo Obsidian).
