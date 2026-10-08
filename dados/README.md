# dados/

Esta é a **base de conhecimento** sobre você: perfil, avaliações, exames, treinos e diário. O Claude lê esta pasta antes de responder e a atualiza ao fim de cada interação.

- **No template público (`personal-claude`) esta pasta fica vazia**, só com este README e o `.gitkeep`. O workflow `.github/workflows/proteger-dados.yml` falha se algo mais for adicionado aqui.
- **No seu repositório privado**, ela é preenchida pelo `/onboarding` e pelos outros comandos, e é versionada normalmente.

Estrutura (detalhes e formatos no `CLAUDE.md`, seção 3; modelos em `templates/`):

```
dados/
├── perfil.md
├── conhecimento.md
├── decisoes.md
├── treino-atual.md
├── avaliacoes/AAAA-MM-DD.md
├── exames/AAAA-MM-DD-tipo.md
├── treinos/AAAA-MM-DD-nome.md
└── diario/AAAA-MM.md
```

Quer ver como fica? Veja o usuário fictício em [`exemplo/dados/`](../exemplo/dados/).

> Ao atualizar seu repositório privado com `scripts/atualizar-template.sh`, esta pasta **nunca** é sobrescrita.
