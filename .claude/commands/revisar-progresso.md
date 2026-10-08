---
description: Analisa as últimas semanas e recomenda continuar, ajustar ou fazer deload, com justificativa
argument-hint: "[período, ex.: '4 semanas'] (padrão: desde o início do ciclo atual)"
---

# /revisar-progresso

Período: `$ARGUMENTS` (padrão: desde o `data_inicio` do plano vigente; mínimo de 2 semanas de dados).

Siga o protocolo do `CLAUDE.md`. Leia o plano vigente completo, `decisoes.md`, `conhecimento.md`, todo o diário do período, as duas últimas avaliações e os exames recentes.

Se o último registro do diário tiver mais de ~7 dias, **pergunte** se houve treinos não registrados antes de calcular a aderência (não presuma que foram perdidos).

Se houver anotações do celular não processadas (blocos sem `- Próxima:`), processe-as primeiro conforme `/registrar-sessao`, ou ao menos considere-as na análise e avise.

## Análise
Calcule a partir dos dados (sem inventar o que não está registrado):

1. **Aderência**: sessões realizadas ÷ planejadas no período (o plano tem `dias_por_semana`). Quais dias são mais perdidos e por quê (motivos registrados).
2. **Cargas, por exercício principal** (os multiarticulares de cada dia): primeira × última sessão do período; tendência (progredindo, estável, regredindo); sessões seguidas sem progresso.
   Apresente em tabela: `Exercício | Início | Atual | Tendência`.
3. **Volume**: séries efetivas por grupamento por semana, realizadas × planejadas (aproximado).
4. **Recuperação**: médias de energia e de sono do diário; dores relatadas e recorrência.
5. **Composição corporal**: se houver avaliações no período ou logo antes e depois, as variações principais (com a ressalva do erro de medida).
6. **Semana do ciclo**: em que semana estamos e quanto falta para o fim previsto.

## Decisão
Recomende **uma** das opções, com uma justificativa de 3–5 linhas ligada aos dados:
- **Continuar**: progressão consistente, aderência boa, recuperação ok.
- **Ajustar**: mudanças pontuais (trocar um exercício, ajustar volume de um grupamento, reduzir dias para caber na rotina, mudar a faixa de repetições). Liste exatamente o que muda.
- **Deload**: critérios da seção 4 do `CLAUDE.md` atingidos (fim do ciclo, estagnação generalizada, fadiga acumulada). Descreva a semana de deload (volume −40–50%, RIR 3–4, mesmos exercícios).
- **Novo ciclo**: fim do mesociclo ou objetivo alterado → sugerir `/montar-treino`.

Se houver alerta de segurança (dor persistente, sintomas, exame pendente), ele vem **antes** da decisão, em destaque.

## Aplicar (só após a aprovação do usuário)
- **Ajustar**: edite o plano em `dados/treinos/` (seção "Ajustes durante o ciclo"), atualize `treino-atual.md` e registre em `decisoes.md`.
- **Deload**: registre em `decisoes.md` e adicione um aviso no topo de `treino-atual.md` (`> Semana de deload até AAAA-MM-DD: ...`). Remova o aviso quando a semana terminar (na próxima interação depois da data).
- **Continuar**: registre em `decisoes.md` só se a revisão tiver sido marcada como formal (ex.: "Revisar em" de uma decisão anterior).
- Registre os padrões novos em `conhecimento.md` (resposta a volume, aderência, recuperação).
- Commit: `decisao: {resumo}` (ex.: `decisao: deload semana 5`) + push.
