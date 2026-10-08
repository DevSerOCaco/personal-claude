---
description: Registra uma avaliação física (texto colado, PDF ou imagem) e compara com as anteriores
argument-hint: "[dados colados ou caminho do arquivo]"
---

# /nova-avaliacao

Entrada: `$ARGUMENTS`. Pode ser texto colado, o caminho de um PDF ou imagem, ou nada (nesse caso, peça os dados ou o arquivo).

Siga o protocolo do `CLAUDE.md` (sincronizar, identificar, ler a base).

## Passos
1. **Extrair**: leia o material e preencha o modelo `templates/avaliacao-fisica.md`.
   - Copie os valores exatamente como estão no laudo. Converta unidades se precisar (ex.: g → kg) e diga que converteu.
   - Campos ausentes ficam vazios. **Nunca estime** um valor que não está no material.
   - Se algo estiver ilegível ou ambíguo, pergunte antes de salvar.
   - Data da avaliação: a do laudo. Se não houver, pergunte.
   - Se veio de um arquivo, preencha `arquivo_original` com o nome dele. Não copie o arquivo para o repositório, a menos que o usuário peça.
2. **Mostrar e confirmar**: apresente os valores principais extraídos (peso, % de gordura, massa magra, cintura, braços, coxas) e peça confirmação.
3. **Salvar** em `dados/avaliacoes/AAAA-MM-DD.md`. Se já existir um arquivo com essa data, pergunte se deve substituir.
4. **Comparar** com a avaliação imediatamente anterior e, se houver, com a primeira de todas:

   | Medida | {data anterior} | {data atual} | Variação |
   |---|---|---|---|
   | Peso (kg) | 82,4 | 81,6 | −0,8 |

   - Inclua só as medidas presentes nas duas avaliações.
   - Se os **métodos** forem diferentes (ex.: bioimpedância × dobras), avise que a comparação de % de gordura não é confiável.
   - Escreva a tabela na seção "Comparação com a avaliação anterior" do arquivo.
5. **Comentar a evolução** (3–6 linhas), relacionando-a ao objetivo do perfil, ao plano vigente e à aderência do diário no período. Seja honesto: variações pequenas podem estar dentro do erro de medida. Salve na seção "Comentário".
6. **Segurança**: pressão arterial ≥ 140/90, FC de repouso muito alta ou qualquer observação clínica do laudo → sinalize e recomende avaliação médica (seção 5 do `CLAUDE.md`).
7. **Atualizar a base**: se a avaliação revelou algo duradouro (ex.: assimetria importante, testes de mobilidade limitados), registre em `conhecimento.md`. Se ela motivar uma mudança no plano, sugira `/revisar-progresso` ou `/montar-treino`, sem alterar o plano por conta própria.
8. **Commit**: `avaliacao: AAAA-MM-DD` + push.
