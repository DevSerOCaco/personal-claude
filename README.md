# personal-claude 🏋️

**Template open source para usar o [Claude Code](https://claude.com/claude-code) como seu personal trainer de musculação.**

O repositório **é** a base de conhecimento sobre você: perfil, avaliações físicas, exames, treinos e diário. O Claude lê essa base antes de cada resposta e a atualiza ao fim de cada interação, então a cada treino ele te conhece um pouco melhor: que exercício incomoda seu ombro, como você responde a mais volume, em que dia você costuma faltar.

Não é um aplicativo. É uma estrutura de arquivos Markdown + instruções para o agente (`CLAUDE.md`), sem nenhuma dependência de runtime.

> [!WARNING]
> **Aviso de responsabilidade.** Esta ferramenta **não substitui médico, nutricionista ou profissional de educação física**. Ela não faz diagnósticos, não prescreve dieta nem suplementação e pode errar. Antes de começar ou intensificar um programa de exercícios, especialmente se você tem alguma condição de saúde, consulte um médico. Diante de dor no peito, falta de ar desproporcional, tontura ou desmaio, **pare o exercício e procure atendimento**. Você é responsável pelo uso que faz das sugestões.

---

## Como funciona

```
┌──────────────────────────┐   "Use this template"   ┌──────────────────────────┐
│  personal-claude         │ ──────────────────────▶ │  personal-<nome>         │
│  (GitHub, PÚBLICO)       │                         │  (GitHub, PRIVADO)       │
│  instruções + modelos    │ ◀─ melhorias (script) ─ │  instruções + dados/     │
│  dados/ sempre vazia     │      só código, nunca   │  ← fonte da verdade      │
└──────────────────────────┘      dados/             └────────────┬─────────────┘
                                                                  │ git pull / push
                       ┌──────────────────────────────────────────┼─────────────────────────┐
                       ▼                                          ▼                         ▼
             ┌───────────────────┐                   ┌───────────────────────┐   ┌───────────────────────┐
             │ Claude Code no PC │                   │ Claude Code web / app │   │ Obsidian no celular   │
             │ (terminal)        │                   │ (celular)             │   │ (academia, offline)   │
             │ conversa, planeja │                   │ conversa, registra    │   │ lê o treino, anota    │
             │ e registra        │                   │                       │   │ no diário             │
             └───────────────────┘                   └───────────────────────┘   └───────────────────────┘
```

- **`personal-claude` (público)**: este template. Nunca contém dados reais.
- **`personal-<nome>` (privado)**: o seu repositório, criado a partir do template. A pasta `dados/` é versionada normalmente, e o GitHub é a fonte da verdade.
- **Claude Code** (CLI, web ou app mobile) abre o repositório privado, lê `dados/`, conversa com você e faz commit das atualizações.
- **Obsidian mobile** (com o plugin Obsidian Git) abre o mesmo repositório para você consultar o treino **offline** na academia e anotar o treino no diário rapidinho.

### O que fica em `dados/`

| Arquivo | Conteúdo |
|---|---|
| `perfil.md` | quem você é: objetivos, disponibilidade, equipamentos, restrições, triagem de saúde |
| `conhecimento.md` | o que o Claude aprendeu sobre você, por tema e com data |
| `decisoes.md` | log das decisões importantes (novo ciclo, deload…) e do porquê |
| `treino-atual.md` | o plano vigente, formatado para ler no celular |
| `treinos/` | todos os planos já prescritos |
| `diario/AAAA-MM.md` | um arquivo por mês, uma sessão por bloco |
| `avaliacoes/` | avaliações físicas (peso, % de gordura, dobras, medidas) |
| `exames/` | exames laboratoriais e médicos |

Todos os arquivos têm frontmatter YAML estruturado (dá para gerar gráficos depois) e seguem os modelos de [`templates/`](templates/). Veja um usuário fictício completo em [`exemplo/dados/`](exemplo/dados/).

---

## Configuração passo a passo

### 1. Crie o seu repositório privado
1. Nesta página do GitHub, clique em **Use this template → Create a new repository**.
2. Nome: `personal-<seu-nome>` (ex.: `personal-paulo`).
3. Marque **Private**. ⚠️ Importante: seus dados de saúde vão ficar aqui.

Ou pelo terminal:
```bash
gh repo create personal-paulo --private --template <usuario>/personal-claude --clone
```

### 2. Clone e faça o onboarding (no PC)
```bash
git clone git@github.com:<usuario>/personal-paulo.git ~/personal-paulo
cd ~/personal-paulo
claude
```
No Claude Code, rode:
```
/onboarding
```
Ele faz uma entrevista curta, uma pergunta por vez: dados básicos, histórico, triagem de saúde (PAR-Q), lesões, objetivos, disponibilidade, equipamentos, preferências e sono. No fim, cria `perfil.md`, `conhecimento.md` e `decisoes.md` e faz o commit. Depois, rode `/montar-treino`.

### 3. Use pelo celular (Claude Code web/app)
1. Abra o Claude Code no app do Claude ou em [claude.ai/code](https://claude.ai/code).
2. Conecte sua conta do GitHub (na primeira vez) e selecione o repositório **`personal-<seu-nome>`** ao iniciar a sessão.
3. Converse normalmente ("fiz o treino A, supino 26kg 10 9 9 8…") ou use os comandos.

> Nas sessões web/mobile, o Claude Code pode trabalhar numa branch própria. Nesse caso, o Claude avisa e abre um PR para a `main`. Faça o merge para que as mudanças cheguem ao PC e ao Obsidian.

### 4. Obsidian no celular (treino offline + diário)
1. Instale o [Obsidian](https://obsidian.md) no celular.
2. Crie um vault vazio chamado `personal-<seu-nome>` e instale o plugin da comunidade **Obsidian Git**.
3. No GitHub, crie um **token de acesso fine-grained** com acesso **somente** a esse repositório e permissão *Contents: Read and write*.
4. No plugin, use **"Clone an existing remote repo"** com a URL HTTPS do seu repositório privado, usuário do GitHub e o token.
5. Configurações recomendadas do plugin:
   - **Pull on startup** (puxar ao abrir): ligado. Assim você sempre vê o treino mais recente.
   - **Auto commit-and-sync** a cada 5–10 minutos, com push: ligado. Assim suas anotações sobem sozinhas.
   - Mensagem de commit: `diario: anotação pelo celular`.
6. Na academia: abra `dados/treino-atual.md` (dica: fixe nos favoritos). Para anotar, abra `dados/diario/AAAA-MM.md` e escreva do jeito mais rápido possível:
   ```
   ## 2026-10-08 — Treino A
   supino 26 10 9 9 8
   remada 52.5 4x10
   energia 4 sono 7h ombro ok
   ```
   Depois o Claude normaliza essas anotações (`/registrar-sessao`).

> Se o arquivo do mês ainda não existir, crie-o com só o título `## data — Treino X`; o Claude completa o frontmatter ao processar.

### 5. Teste antes com os dados fictícios
Quer ver tudo funcionando antes de colocar os seus dados? Num **clone de teste** (não no seu repositório real):
```bash
git clone git@github.com:<usuario>/personal-claude.git ~/teste-personal
cd ~/teste-personal
cp -r exemplo/dados/. dados/
claude
```
Experimente `/registrar-sessao` (há uma anotação do celular pendente em `diario/2026-09.md`) e `/revisar-progresso`. Apague o clone depois. **Não faça push** dele.

---

## Comandos

| Comando | O que faz |
|---|---|
| `/onboarding` | Entrevista inicial guiada; cria seu perfil, conhecimento e decisões |
| `/nova-avaliacao` | Registra uma avaliação física (texto, PDF ou foto) e compara com as anteriores |
| `/novo-exame` | Registra um exame com regras estritas de segurança (sem diagnóstico; encaminha ao médico) |
| `/montar-treino` | Propõe um plano, ajusta com você e só salva após a sua aprovação |
| `/registrar-sessao` | Registra o treino (ou processa as anotações do celular) e sugere a próxima progressão |
| `/revisar-progresso` | Analisa as últimas semanas e recomenda continuar, ajustar ou fazer deload |
| `/atualizar-perfil` | Atualiza objetivos, rotina, disponibilidade ou restrições, mantendo o histórico |

Não precisa decorar: falar em linguagem natural ("chegou minha avaliação", "hoje só tenho 40 minutos") também funciona.

---

## Fluxo do dia a dia

**Antes do treino**
- Abra o `treino-atual.md` no Obsidian (ou pergunte ao Claude "o que eu faço hoje?").
- A linha `Próxima:` da última sessão do mesmo treino, no diário, diz as cargas-alvo.

**Durante o treino**
- Anote no diário pelo Obsidian, do jeito que for mais rápido. Sem formatação, sem pressa.

**Depois do treino**
- No Claude Code (celular ou PC): `/registrar-sessao`. Ele normaliza as anotações, compara com a sessão anterior, sugere a progressão da próxima vez, aprende algo sobre você e faz o commit.

**A cada 3–6 semanas**
- `/revisar-progresso` e, quando o ciclo terminar, `/montar-treino`.
- Fez avaliação ou exame? `/nova-avaliacao` ou `/novo-exame`.

---

## Receber atualizações do template

O template vai melhorar (instruções, comandos, modelos). Para trazer as melhorias para o seu repositório privado **sem nunca tocar em `dados/`**, rode no PC:

```bash
# uma vez por repositório: informar a URL do template
~/personal-paulo/scripts/atualizar-template.sh -u https://github.com/<usuario>/personal-claude.git ~/personal-paulo

# depois disso, basta:
cd ~/personal-paulo && ./scripts/atualizar-template.sh
git push
```

O script:
- adiciona o template como remote `upstream` (com push desabilitado: seus dados **nunca** vão para o público);
- na primeira vez, vincula o seu repositório ao histórico do template (por isso as próximas atualizações são merges normais);
- faz `fetch` e `merge` de `upstream/main` e **restaura `dados/` exatamente como estava** (além de `.gitattributes` com `dados/** merge=ours`);
- mostra um resumo do que mudou. Se você personalizou um arquivo que o template também mudou, ele avisa o conflito para você resolver.

Opções: `-p` faz o push automaticamente; `-b` escolhe outra branch do template; `--help` mostra a ajuda.

---

## Vários usuários com o mesmo Claude Code

O mesmo Claude Code (a mesma conta) pode atender mais de uma pessoa, por exemplo você e alguém da sua casa. **O isolamento é por repositório, não por pasta**: cada pessoa tem o seu próprio repositório privado, e os dados nunca se misturam.

1. **Um repositório privado por pessoa**, todos criados a partir do template: `personal-paulo`, `personal-ana`… Cada pessoa faz o seu próprio `/onboarding`.
2. **Onde ficam os repositórios:**
   - **Opção 1**: todos na conta de quem administra. Mais simples, e quem administra controla tudo.
   - **Opção 2**: cada pessoa com a própria conta no GitHub e o próprio repositório. Quem quiser ajudar é adicionado como colaborador (*Settings → Collaborators*).
3. **No PC:** uma pasta por pessoa. Rode `claude` **dentro da pasta de quem vai treinar**:
   ```bash
   cd ~/personal-ana && claude
   ```
4. **No celular (Claude Code web/app):** escolha o repositório da pessoa ao iniciar a sessão.
5. **No Obsidian:** um vault por repositório (o Obsidian troca de vault pelo menu lateral).
6. **Atualizar todos de uma vez:**
   ```bash
   ./scripts/atualizar-template.sh -p ~/personal-paulo ~/personal-ana
   ```
7. **Verificação de identidade:** no início de cada sessão, o Claude diz em uma linha de quem é a base carregada ("Treinando com a base do **Paulo**"). Se a pessoa se apresentar com outro nome ("aqui é a Ana"), ele **para**, avisa que o repositório é de outra pessoa e não lê nem grava nada. Isso evita registrar o treino da Ana no histórico do Paulo.

---

## Privacidade

- Dados de saúde (exames, avaliações, dores) ficam **somente no seu repositório privado**.
- O template público tem o workflow [`proteger-dados.yml`](.github/workflows/proteger-dados.yml): se alguém commitar qualquer coisa em `dados/` além de `README.md` e `.gitkeep`, a verificação falha. Ele só roda no template (variável `IS_TEMPLATE=true`). No seu repositório privado, ele é ignorado.
- O script de atualização desabilita o push para o template a partir do repositório privado.
- Ative a **autenticação em dois fatores (2FA)** no GitHub. Para o Obsidian, use um token fine-grained restrito ao seu repositório.
- Lembre-se de que as conversas com o Claude seguem as políticas de privacidade da Anthropic e as configurações da sua conta.

---

## Requisitos

- Um plano do Claude que inclua o **Claude Code** (ou acesso via API).
- Conta no **GitHub**.
- **Obsidian** + plugin **Obsidian Git** (opcional, para uso offline na academia).
- `git` e `bash` no PC (para o script de atualização).

---

## Estrutura do template

```
personal-claude/
├── CLAUDE.md                 # instruções do agente (o coração do projeto)
├── AGENTS.md                 # aponta para o CLAUDE.md (outros agentes)
├── .claude/commands/         # /onboarding, /montar-treino, /registrar-sessao…
├── templates/                # modelos com frontmatter comentado
├── dados/                    # SUA base (vazia no template)
├── exemplo/dados/            # usuário fictício completo
├── scripts/atualizar-template.sh
└── .github/workflows/proteger-dados.yml
```

---

## Para quem mantém o template

No repositório **público**:
1. *Settings → General → Template repository*: marcado (ou `gh repo edit --template`).
2. *Settings → Secrets and variables → Actions → Variables*: crie `IS_TEMPLATE` = `true` (ou `gh variable set IS_TEMPLATE --body true`).

---

## Contribuindo

Contribuições são bem-vindas, especialmente melhorias no `CLAUDE.md`, nos comandos e nos modelos.

1. Faça um fork e crie uma branch.
2. **Nunca inclua dados reais.** Para exemplos, use ou amplie o usuário fictício em `exemplo/dados/`.
3. Mantenha a consistência: um campo novo num modelo precisa ser refletido no `CLAUDE.md`, nos comandos que o usam e no exemplo.
4. Tudo em português do Brasil.
5. Abra um PR descrevendo o problema e a mudança.

## Licença

[MIT](LICENSE).
