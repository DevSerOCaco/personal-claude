---
description: Registra um exame laboratorial ou médico, aplicando estritamente as regras de segurança
argument-hint: "[dados colados ou caminho do arquivo]"
---

# /novo-exame

Entrada: `$ARGUMENTS`. Pode ser texto colado, o caminho de um PDF ou imagem, ou nada (nesse caso, peça).

Siga o protocolo do `CLAUDE.md`. **A seção 5 (Segurança) se aplica integralmente aqui.**

## Passos
1. **Extrair** para o modelo `templates/exame.md`:
   - `categoria`: sangue | urina | ecg | ergometrico | imagem | outro.
   - Um item em `resultados` por analito, com `valor`, `unidade` e a **referência do próprio laudo**. Nunca use referências "da internet" no lugar da do laudo; se o laudo não tiver referência, use `status: sem_referencia`.
   - `status`: compare o valor com a referência do laudo (`normal`, `acima`, `abaixo`). Liste em `fora_referencia` os nomes dos itens acima ou abaixo.
   - Transcreva as observações e conclusões do laudo sem reescrever o sentido.
   - Não estime nada. Ilegível → pergunte.
2. **Confirmar** os valores extraídos com o usuário.
3. **Salvar** em `dados/exames/AAAA-MM-DD-{categoria}.md`. Se houver dois exames da mesma categoria no mesmo dia, acrescente um sufixo (`-2`).
4. **Responder com segurança:**
   - Tudo dentro da referência: diga isso de forma simples, sem afirmar que a pessoa "está saudável".
   - Algo fora da referência: **comece a resposta com um destaque** listando os itens fora da referência e recomende levar o exame ao médico. **Não explique causas, não sugira diagnósticos, não sugira tratamento nem suplementos.**
   - Se o item fora da referência pode afetar o treino (ex.: exames cardíacos alterados, ergométrico com alterações, hemoglobina baixa, CK muito elevada, glicemia muito alterada), diga que a prescrição afetada fica **suspensa ou conservadora até a avaliação médica**. Preencha `encaminhamento` e a seção "Impacto no treino".
   - Em caso de dúvida se um item afeta o treino, trate como se afetasse e encaminhe.
5. **Atualizar a base:**
   - Se houver encaminhamento: entrada em `decisoes.md` (`## {data} — Exame {categoria}: encaminhamento médico`) e, se o treino ficar restrito, atualize `restricoes` e `liberacao_medica: pendente` no perfil, com Histórico de alterações.
   - Quando o usuário trouxer a liberação médica depois, registre-a (`liberacao_medica: sim`) e retire a restrição.
6. **Commit**: `exame: AAAA-MM-DD {categoria}` + push.

Lembre-se: exames são dados sensíveis. Eles ficam **somente** no repositório privado do usuário.
