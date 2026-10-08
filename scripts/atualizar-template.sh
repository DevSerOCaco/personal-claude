#!/usr/bin/env bash
# Traz as melhorias do template público (personal-claude) para um ou mais
# repositórios privados, SEM nunca alterar a pasta dados/.
#
# Uso:
#   ./scripts/atualizar-template.sh [opções] [repo ...]
#
#   repo            caminho de um repositório privado (padrão: diretório atual)
#   -u, --url URL   URL do template (padrão: $PERSONAL_CLAUDE_TEMPLATE_URL ou o
#                   remote "upstream" já configurado em cada repositório)
#   -b, --branch B  branch do template (padrão: main)
#   -p, --push      faz "git push" depois de um merge bem-sucedido
#   -h, --help      mostra esta ajuda
#
# Exemplos:
#   ./scripts/atualizar-template.sh -u https://github.com/voce/personal-claude.git
#   ./scripts/atualizar-template.sh ~/personal-paulo ~/personal-fulano
#
# Como dados/ é protegida:
#   1. .gitattributes com "dados/** merge=ours" + driver "ours" configurado aqui
#      (em conflito de conteúdo, a versão local vence);
#   2. depois do merge, dados/ é restaurada exatamente como estava no HEAD local
#      (cobre arquivos adicionados, alterados ou removidos pelo template).

set -uo pipefail

URL="${PERSONAL_CLAUDE_TEMPLATE_URL:-}"
BRANCH="main"
PUSH=0
REPOS=()

ajuda() { sed -n '2,24p' "$0" | sed 's/^# \{0,1\}//'; }

while [ $# -gt 0 ]; do
  case "$1" in
    -u|--url)    URL="${2:-}"; shift 2 ;;
    -b|--branch) BRANCH="${2:-}"; shift 2 ;;
    -p|--push)   PUSH=1; shift ;;
    -h|--help)   ajuda; exit 0 ;;
    -*)          echo "Opção desconhecida: $1" >&2; ajuda >&2; exit 2 ;;
    *)           REPOS+=("$1"); shift ;;
  esac
done
[ ${#REPOS[@]} -eq 0 ] && REPOS=(".")

ATTR_LINHA='dados/** merge=ours'
MSG_MERGE="chore: atualizar a partir do template"

info()  { printf '  %s\n' "$*"; }
aviso() { printf '  ⚠️  %s\n' "$*"; }
erro()  { printf '  ❌ %s\n' "$*"; }

atualizar_repo() {
  local repo="$1"
  echo
  echo "=== $repo ==="

  if ! git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    erro "não é um repositório git."; return 1
  fi
  cd "$repo" || return 1
  cd "$(git rev-parse --show-toplevel)" || return 1

  if [ -n "$(git status --porcelain)" ]; then
    erro "há alterações não commitadas. Faça commit (ou stash) e rode de novo."; return 1
  fi
  if [ -f "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
    erro "há um merge em andamento. Conclua ou aborte (git merge --abort) antes."; return 1
  fi

  # 1. remote upstream
  if git remote get-url upstream >/dev/null 2>&1; then
    if [ -n "$URL" ] && [ "$(git remote get-url upstream)" != "$URL" ]; then
      aviso "upstream aponta para $(git remote get-url upstream); usando-o (para trocar: git remote set-url upstream URL)."
    fi
  else
    if [ -z "$URL" ]; then
      erro "remote 'upstream' não existe. Informe a URL do template com -u URL ou PERSONAL_CLAUDE_TEMPLATE_URL."; return 1
    fi
    git remote add upstream "$URL"
    info "remote 'upstream' adicionado: $URL"
  fi
  # nunca permitir push para o template a partir de um repositório privado
  git remote set-url --push upstream DESABILITADO-dados-sao-privados

  # 2. proteção de dados/
  git config merge.ours.driver true
  if ! grep -qxF "$ATTR_LINHA" .gitattributes 2>/dev/null; then
    printf '%s\n' "$ATTR_LINHA" >> .gitattributes
    git add .gitattributes
    git commit -q -m "chore: proteger dados/ em merges do template"
    info ".gitattributes criado/atualizado para proteger dados/."
  fi

  # 3. fetch
  if ! git fetch -q upstream "$BRANCH"; then
    erro "falha no fetch de upstream/$BRANCH."; return 1
  fi
  local alvo="upstream/$BRANCH"
  local antes; antes="$(git rev-parse HEAD)"

  # Primeira vez: o repositório criado com "Use this template" não tem histórico em
  # comum com o template. Sem um ancestral comum, todo arquivo que o template mudou
  # viraria conflito. Então localizamos o commit do template que originou o
  # repositório (o mais parecido com o primeiro commit local, ignorando dados/) e o
  # registramos como ancestral com "merge -s ours" (sem alterar nenhum arquivo).
  if ! git merge-base HEAD "$alvo" >/dev/null 2>&1; then
    local raiz origem="" menor="" c n
    raiz="$(git rev-list --max-parents=0 HEAD | tail -n 1)"
    for c in $(git rev-list "$alvo"); do
      n="$(git diff --numstat "$raiz" "$c" -- . ':(exclude)dados' | awk '{s+=$1+$2} END {print s+0}')"
      if [ -z "$menor" ] || [ "$n" -lt "$menor" ]; then menor="$n"; origem="$c"; fi
      [ "$n" -eq 0 ] && break
    done
    git merge -q -s ours --allow-unrelated-histories --no-edit \
      -m "chore: vincular ao histórico do template (${origem:0:7})" "$origem" >/dev/null 2>&1 \
      || { erro "falha ao vincular ao histórico do template."; return 1; }
    info "primeira atualização: repositório vinculado ao commit ${origem:0:7} do template (diferença: $menor linhas)."
  fi

  if git merge-base --is-ancestor "$alvo" HEAD 2>/dev/null; then
    info "✅ já está atualizado com $alvo."; return 0
  fi

  # 4. merge sem commit, para podermos restaurar dados/ antes de concluir
  git merge --no-ff --no-commit -m "$MSG_MERGE" "$alvo" >/dev/null 2>&1

  if [ ! -f "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
    info "✅ nada a mesclar."; return 0
  fi

  # 5. restaurar dados/ exatamente como no HEAD local
  if git cat-file -e "HEAD:dados" 2>/dev/null; then
    git checkout HEAD -- dados 2>/dev/null
  fi
  # remover de dados/ tudo o que não existia no HEAD (arquivos trazidos pelo template)
  comm -13 \
    <(git ls-tree -r --name-only HEAD -- dados | sort -u) \
    <(git ls-files -- dados | sort -u) \
  | while IFS= read -r f; do
      git rm -q --cached -f -- "$f" >/dev/null 2>&1
      rm -f -- "$f"
    done

  # 6. conflitos fora de dados/?
  local conflitos; conflitos="$(git diff --name-only --diff-filter=U)"
  if [ -n "$conflitos" ]; then
    aviso "conflitos fora de dados/ (arquivos que você personalizou e o template também mudou):"
    printf '%s\n' "$conflitos" | sed 's/^/      - /'
    info "Resolva os conflitos, depois: git add <arquivos> && git commit --no-edit"
    info "Ou desista desta atualização: git merge --abort"
    return 1
  fi

  git commit -q --no-edit
  info "✅ merge concluído."

  # 7. resumo
  if ! git diff --quiet "$antes" HEAD -- dados; then
    erro "dados/ mudou no merge — isso não deveria acontecer. Desfazendo (git reset --hard $antes)."
    git reset -q --hard "$antes"; return 1
  fi
  info "dados/ intacta."
  echo "  Resumo das mudanças:"
  git --no-pager diff --stat "$antes" HEAD | sed 's/^/    /'

  if [ "$PUSH" -eq 1 ]; then
    if git push -q; then info "push feito."; else aviso "push falhou; rode 'git push' manualmente."; fi
  else
    info "Revise e depois rode: git push"
  fi
}

falhas=0
for r in "${REPOS[@]}"; do
  dir="$(cd "$r" 2>/dev/null && pwd)" || { echo; echo "=== $r ==="; erro "diretório não encontrado."; falhas=$((falhas+1)); continue; }
  ( atualizar_repo "$dir" ) || falhas=$((falhas+1))
done

echo
if [ "$falhas" -eq 0 ]; then
  echo "Concluído: ${#REPOS[@]} repositório(s) processado(s)."
else
  echo "Concluído com $falhas pendência(s) em ${#REPOS[@]} repositório(s). Veja as mensagens acima."
  exit 1
fi
