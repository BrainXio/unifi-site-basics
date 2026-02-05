**Semantic Versioning 2.0.0**

Specification for meaningful version numbers.

**Format**

```
MAJOR.MINOR.PATCH[-PRE-RELEASE][+BUILD-METADATA]
```

**Rules (core)**

1. Software using SemVer **MUST** have a public API.
2. Normal version: `X.Y.Z` (non-negative integers, no leading zeros).
   - `X` = major
   - `Y` = minor
   - `Z` = patch
3. Once released, components **MUST NOT** change.
4. **MAJOR** increments for incompatible API changes.
5. **MINOR** increments for backward-compatible functionality additions.
6. **PATCH** increments for backward-compatible bug fixes.

**Pre-release**

- Append `-` + dot-separated identifiers (ASCII alphanumerics + hyphen)
- Precedence: numeric identifiers compared numerically, others lexically (left to right)
- Examples: `1.0.0-alpha`, `1.0.0-alpha.1`, `1.0.0-beta.11`, `1.0.0-rc.1`

**Build metadata**

- Append `+` + dot-separated identifiers
- Ignored for precedence
- Examples: `1.0.0+20130313144700`, `1.0.0+build.54321`

**Examples**

```
1.0.0
2.1.0
3.0.0
1.0.0-alpha
1.0.0-alpha.1
1.0.0-beta.2
1.0.0-rc.1+build.123
```

**How to increment (with Conventional Commits mapping)**

- feat → **MINOR** +0.1.0
- fix → **PATCH** +0.0.1
- BREAKING CHANGE / feat! → **MAJOR** +1.0.0
- 0.y.z → unstable, anything allowed

**Why use it**

- Communicates change impact
- Enables automated dependency management
- Compatible with tools expecting SemVer

**Reference**

semver.org/spec/v2.0.0.html
