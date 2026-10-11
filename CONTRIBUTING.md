# Contributing

<!-- TEMPLATE: state the stance of the project. An active project takes contributions; a finished one is kept as a record and takes corrections only. -->

This template is maintained by its author. Corrections and proposals are welcome.

## Reporting

- **Security matters** follow [`SECURITY.md`](SECURITY.md).
- **Factual corrections**, such as a broken link or an error in the documentation: open an issue where issues are enabled, or write to the address below.

## Pull requests

Keep a pull request to one subject. Where issues are enabled, open one first for a change large enough to need discussion. Pull requests are squash-merged, so the commits inside one need no signature.

## Commits

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/), in English and ASCII, with the subject in the imperative.

## Checks

The Markdown lint of `docs.yml` runs locally with the same version and rules:

```bash
npx --yes markdownlint-cli2@0.23.3 "**/*.md"
```

The pre-commit hook scans the staged changes for secrets with the rules of `.gitleaks.toml`. Enable it once per clone; it requires the `gitleaks` command line tool:

```bash
git config core.hooksPath .githooks
```

## Contact

Mert Torun, M.Sc.: <info@mtorun0x7cd.com> · <https://mtorun0x7cd.com>
