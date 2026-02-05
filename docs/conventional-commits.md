**Conventional Commits**

Specification for writing structured, readable commit messages.

**Format**

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Main types** (most common)

- feat → new feature
- fix → bug fix
- docs → documentation only
- style → formatting, missing semicolons (no code change)
- refactor → code change that neither fixes bug nor adds feature
- perf → performance improvement
- test → adding or correcting tests
- build → affecting build system or external dependencies
- ci → CI configuration & scripts
- chore → maintenance tasks, tooling
- revert → revert previous commit

**Examples**

```
feat: add user authentication endpoint

fix(auth): handle expired token gracefully

docs: update installation instructions

refactor: extract payment validation logic

chore(deps): bump requests from 2.28.1 to 2.31.0
```

**With scope**

```
feat(api): implement rate limiting

fix(ui): correct button alignment on mobile
```

**Breaking changes**

Add `!` after type or use footer:

```
feat!: send analytics events to new endpoint

BREAKING CHANGE: removes support for legacy v1 API
```

**Why use it**

- Automatic changelog generation
- Semantic versioning triggers (feat → minor, fix → patch, ! → major)
- Better project history readability
- Tooling integration (pre-commit, release bots, GitHub)

**Quick rule**

Start with type, keep subject < 50–72 chars, use imperative mood ("add", not "added").
