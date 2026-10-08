---
description: Entrevista inicial guiada; cria perfil.md, conhecimento.md e decisoes.md
argument-hint: "[nome] (opcional)"
---

# /onboarding

Você vai conhecer a pessoa dona deste repositório e criar a base inicial. Siga o `CLAUDE.md` (persona, segurança, formatos).

Argumentos: `$ARGUMENTS` (se houver um nome, use-o como resposta à primeira pergunta).

## Antes de começar
1. Rode `git pull --rebase` se houver remote.
2. Se `dados/perfil.md` **já existir**: informe de quem é a base ("Este repositório já tem o perfil do **{nome}**") e pergunte se a pessoa quer **refazer** o onboarding (sobrescreve o perfil, mas mantém o histórico) ou usar `/atualizar-perfil`. Não continue sem resposta. Se o nome informado for de outra pessoa, siga a regra de identificação do `CLAUDE.md` (parar).
3. Se o `origin` apontar para o template público `personal-claude`, avise que os dados devem ficar num repositório **privado** e pare.
4. **Aviso de responsabilidade (obrigatório, antes de qualquer pergunta).** Apresente com suas palavras, de forma clara e acolhedora, sem tom de sermão:
   > Antes de começar, um aviso importante: eu sou um assistente de IA, **não um profissional**. Não substituo um profissional de educação física, um médico ou um nutricionista. Sirvo como **apoio** para você treinar com mais orientação e segurança enquanto não tem acompanhamento profissional, e posso errar. Sempre que possível, e principalmente quando der para investir nisso, procure um profissional especializado. Se surgir dor, sintoma estranho ou exame alterado, vou te encaminhar para um.

   Peça uma confirmação simples ("Entendido? Podemos seguir?"). **Não continue sem ela.** Se a pessoa não concordar, encerre com educação, sem criar arquivos. Registre a data da confirmação em `aviso_aceito_em` no perfil.
5. Explique em 2–3 linhas como vai funcionar: algumas perguntas curtas, uma de cada vez, uns 10 minutos; "não sei" e "prefiro não dizer" são respostas válidas.

## Entrevista
Faça **uma pergunta por vez** (no máximo um bloco pequeno de 2–3 itens relacionados). Espere a resposta. Se algo ficar vago, peça um detalhe antes de seguir. Não comente cada resposta: confirme rapidamente e avance.

1. **Dados básicos**: nome (como prefere ser chamado), data de nascimento, sexo, altura, peso aproximado.
2. **Histórico de treino**: há quanto tempo treina musculação de forma consistente, pausas longas, outras modalidades, o que já funcionou ou não. Com base nisso, classifique o nível (iniciante, intermediário ou avançado) e confirme com a pessoa.
3. **Saúde, triagem PAR-Q**: faça as 7 perguntas do `templates/perfil.md` (pode ser num bloco, pedindo sim/não para cada). Para cada "sim", peça detalhes. Pergunte também sobre medicamentos de uso contínuo e condições diagnosticadas.
   - Se houver algum "sim": `parq_alerta: true`. Explique com calma que, por segurança, é recomendada uma liberação médica antes de treinos intensos, e pergunte se ela já tem (`liberacao_medica: sim | nao | pendente`). Sintomas cardiovasculares atuais → destaque claro e recomendação de avaliação médica antes de começar (seção 5 do `CLAUDE.md`).
4. **Lesões e dores**: lesões ou cirurgias passadas, dores atuais (onde, quando aparece, intensidade 0–10, piora com algum movimento?).
5. **Objetivos e prioridades**: objetivo principal, objetivos secundários, prazo, grupamentos prioritários, por que isso importa agora.
6. **Disponibilidade**: quantos dias por semana consegue treinar *de verdade*, quais dias, quanto tempo por sessão.
7. **Local e equipamentos**: academia completa, academia de condomínio, casa (listar equipamentos e cargas máximas)?
8. **Preferências**: exercícios de que gosta e de que não gosta, estilo de treino, se já usou RIR/RPE.
9. **Sono e rotina**: horas de sono, qualidade, trabalho (sentado ou em pé), estresse, horário preferido para treinar.
10. **Algo mais?**: alguma coisa importante que não foi perguntada.

## Ao final
1. Crie, a partir dos modelos em `templates/` e sem inventar nada:
   - `dados/perfil.md` (de `templates/perfil.md`): `criado_em` e `atualizado_em` = hoje; `aviso_aceito_em` = data da confirmação do aviso; respostas do PAR-Q registradas; no Histórico de alterações, `- {hoje}: perfil criado no onboarding`.
   - `dados/conhecimento.md` (de `templates/conhecimento.md`): o que já se sabe de preferências, desconfortos, aderência e sono, cada linha com `({hoje})`.
   - `dados/decisoes.md` (de `templates/decisoes.md`): primeira entrada `## {hoje} — Onboarding`, com o objetivo definido e, se houver, a pendência de liberação médica.
   - Crie as pastas `dados/avaliacoes/`, `dados/exames/`, `dados/treinos/` e `dados/diario/` com um `.gitkeep` cada.
2. Mostre um **resumo** curto: quem é, objetivo, disponibilidade, restrições e alertas.
3. Peça confirmação ("está tudo certo?") e corrija o que for preciso.
4. Commit: `onboarding: perfil inicial` + push (seção 6 do `CLAUDE.md`).
5. **Sugira o próximo passo**:
   - se houver alerta de saúde pendente: buscar a liberação médica (e, enquanto isso, o que é seguro fazer);
   - se tiver avaliação física ou exames recentes: `/nova-avaliacao` ou `/novo-exame`;
   - caso contrário: `/montar-treino`.
