**Branching Strategies**

Guidelines for consistent, clean Git branch usage in modern Python projects.

**Naming Convention**

```
<type>/<short-description>
```

**Main types**

- feat/     → new feature or enhancement
- fix/      → bug fix
- refactor/ → code restructuring (no behavior change)
- docs/     → documentation updates
- test/     → adding or improving tests
- chore/    → maintenance, tooling, deps
- ci/       → CI/CD pipeline changes
- revert/   → revert a previous commit
- hotfix/   → urgent production fix (direct to main)

**Examples**

```
feat/auth-login
fix/api-rate-limit-crash
refactor/payment-validation
docs/update-readme-install
test/core-add-function
chore/bump-ruff-0.7
ci/add-trivy-scan
hotfix/security-token-leak
```

**Workflow (recommended)**

1. Always branch from `main` (or protected release branch)
2. Use short, descriptive kebab-case names (< 50 chars total)
3. Keep branches focused (one logical change)
4. Delete branch after merge (`git branch -d`)
5. Use PRs for everything — never push directly to `main`

**Long-lived branches (when needed)**

- `main`            → production-ready, latest stable
- `release/vX.Y.Z`  → preparation for tagged release (optional)
- `next`            → integration branch for upcoming major version (rare)

**Quick rules**

- Prefix with Conventional Commit type when it matches intent
- Use `/` separator (never `-` or `_` for type)
- No ticket IDs in branch name (put in PR title/description)
- Rebase or squash-merge to keep history linear

**Why this works well**

- Matches Conventional Commits & semantic-release
- Easy to scan in `git branch -a` / GitHub UI
- Clear ownership of changes before merge
- Minimal long-lived branches → reduces merge hell

Keep it simple. Small PRs. Linear history.
