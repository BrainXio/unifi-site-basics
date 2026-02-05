#!/usr/bin/env bash
# site-docs.sh
# =============================================
# Generates header.md and wrapper.md from templates.
# With --make: also runs terraform-docs to update README.md (or fallback concat if no .tf files)
# Created: February 2026

set -euo pipefail


usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Options:
  --make, -m    Actually generate/update README.md using terraform-docs (or fallback)
                Without this flag, only header.md and wrapper.md are (re)generated.

  --help, -h    Show this help message
EOF
  exit 0
}

MAKE_MODE=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --make|-m)
      MAKE_MODE=true
      shift
      ;;
    --help|-h)
      usage
      ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
done

echo "=== site-docs.sh — README Refresh ==="

# ── Resolve dynamic values ──
if [[ -n "${GITHUB_ACTOR:-}" ]]; then
  ACTOR="$GITHUB_ACTOR"
else
  ACTOR="$(git config user.name 2>/dev/null || echo "github-actor")"
fi

if [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
  REPO="$GITHUB_REPOSITORY"
else
  REPO="${ACTOR}/$(basename "$PWD")"
fi

# ── Determine REF (for ?ref= in module source examples) ──
REF="main"  # ultimate fallback

if [[ -n "${GITHUB_REF:-}" ]]; then
    # GitHub Actions context — parse GITHUB_REF
    if [[ "$GITHUB_REF" == refs/tags/* ]]; then
        REF="${GITHUB_REF#refs/tags/}"
        echo "Detected tag in CI → using REF=$REF"
    elif [[ "$GITHUB_REF" == refs/heads/* ]]; then
        REF="${GITHUB_REF#refs/heads/}"
        echo "Detected branch in CI → using REF=$REF"
    else
        # PRs, workflow_dispatch, etc. → stick with default 'main'
        echo "GITHUB_REF is neither tag nor branch → using fallback REF=$REF"
    fi
else
    # Local / non-CI environment — try git commands
    if git rev-parse --git-dir >/dev/null 2>&1; then
        # We're in a git repo

        # First: check if HEAD is exactly tagged
        if current_tag=$(git describe --exact-match --tags HEAD 2>/dev/null); then
            REF="$current_tag"
            echo "Local detached HEAD is tagged → using REF=$REF"
        else
            # Not on a tag → try current branch
            current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if [[ "$current_branch" != "HEAD" && -n "$current_branch" ]]; then
                REF="$current_branch"
                echo "Local branch detected → using REF=$REF"
            else
                echo "Local detached HEAD with no tag → using fallback REF=$REF"
            fi
        fi
    else
        echo "Not in a git repository → using fallback REF=$REF"
    fi
fi

export GITHUB_ACTOR="$ACTOR"
export GITHUB_REPOSITORY="$REPO"
export PROJECT_TITLE="$(basename "$PWD")"
export GENERATION_TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S %Z')"
export REF="$REF"
echo "GITHUB_REPOSITORY   → $REPO"
echo "PROJECT_TITLE       → $PROJECT_TITLE"
echo "TIMESTAMP           → $GENERATION_TIMESTAMP"
echo "REF                 → $REF"
echo ""

# ── Ensure site/ exists ──
mkdir -p site

# ── Add /site/ to .gitignore if needed ──
if [[ -f ".gitignore" ]] && ! grep -qE '^/?site/?$' ".gitignore"; then
  echo "/site/" >> ".gitignore"
  echo "Added /site/ to .gitignore"
fi

# ── Generate header & wrapper ──
if [[ ! -f "templates/header.md.tpl" ]]; then
  echo "Error: templates/header.md.tpl missing"
  exit 1
fi
if [[ ! -f "templates/wrapper.md.tpl" ]]; then
  echo "Error: templates/wrapper.md.tpl missing"
  exit 1
fi

envsubst < templates/header.md.tpl  > site/header.md
envsubst < templates/wrapper.md.tpl > site/wrapper.md

echo "Generated: site/header.md and site/wrapper.md"

# ── If --make is set, update README.md ──
if $MAKE_MODE; then
  echo -n "Looking for any *.tf files... "
  if find . -type f -name "*.tf" -print -quit | grep -q .; then
    echo "Found → using terraform-docs"

    if ! command -v terraform-docs >/dev/null 2>&1; then
      echo "Error: terraform-docs not found in PATH"
      echo "Run ./dev-setup.sh to install it (or ensure it's in PATH)"
      exit 1
    fi

    terraform-docs markdown table \
      --output-file README.md \
      --header-from site/header.md \
      --footer-from site/wrapper.md \
      --hide requirements \
      .

    if [[ $? -eq 0 ]]; then
      echo "README.md updated via terraform-docs"
    else
      echo "terraform-docs failed"
      exit 1
    fi

  else
    echo "None found → concatenating header + wrapper only"

    cat site/header.md > README.md
    cat site/wrapper.md >> README.md

    echo "README.md created/updated (header + wrapper only)"
  fi
else
  echo "No --make flag → skipping README.md generation/update"
  echo "   (header.md and wrapper.md are ready for terraform-docs/gh-actions)"
fi

echo ""
echo "Done."
echo "Check result: cat README.md   (if --make was used)"
