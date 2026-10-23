<!--
SPDX-FileCopyrightText: 2026 Mert Torun
SPDX-License-Identifier: MIT
-->

# Project template

A GitHub repository template for my projects. A repository created from it starts with the files each of them carries: a README skeleton, citation metadata in the Citation File Format, licensing information as REUSE defines it, a security policy, contribution notes, an issue form, the sponsor links, Dependabot updates for the pinned actions, workflows for Markdown lint, citation metadata, licensing information and a secret scan, one script that runs these checks on a workstation as the workflows run them, an opt-in pre-commit secret scan, release notes from the commit history, and a social card with the script that renders it. The author, the copyright holder and the contact address in these files are mine; whoever else uses the template replaces them as well.

[![License: MIT](https://img.shields.io/badge/License-MIT-1D4ED8?style=flat)](LICENSE)

## Usage

1. Select **Use this template** on this page and create the new repository.
2. Follow the steps in [`docs/TEMPLATE.md`](docs/TEMPLATE.md): the skeleton `docs/README.template.md` replaces this README, every placeholder is filled, the security policy and the contribution notes are rewritten for the project, and the repository settings are set.
3. Remove `docs/TEMPLATE.md` as its last step says; `tools/check.sh setup`, which the workflow `checks.yml` runs as well, then confirms that no placeholder and no template text is left.

## Contents

| Path | Content | In a new repository |
| --- | --- | --- |
| `README.md` | this page | replaced by the skeleton |
| `docs/README.template.md` | the README skeleton: title, tagline, badge row, and the sections from Overview to Contact | moved over `README.md` and filled |
| `docs/TEMPLATE.md` | the placeholders, the setup steps and the list of repository settings | removed when the setup is done |
| `docs/CITATION.template.cff` | the skeleton of the citation metadata, Citation File Format 1.2.0, without a version; the template itself carries no `CITATION.cff` | moved to `CITATION.cff` and filled; a version is added at the first release |
| `LICENSE` | the MIT License | the year filled |
| `LICENSES/`, `REUSE.toml` | the licence text in the form REUSE 3.3 expects, and the licence and copyright of the files without room for an SPDX comment | extended for every licence and every such file the project adds |
| `SECURITY.md` | the security policy of this template, in five sections | rewritten for the project |
| `CONTRIBUTING.md` | how to report, propose and check a change | rewritten for the project |
| `.github/ISSUE_TEMPLATE/` | an issue form for factual corrections, and a link to the security policy | the repository name filled |
| `.github/workflows/` | `ci.yml`, a build and a release job as stubs, the release created as a draft and published only once its files match the build; `docs.yml`, Markdown lint; `checks.yml`, citation metadata, licensing information and placeholders; `secret-scan.yml`, gitleaks over the history | build and test steps added to `ci.yml` |
| `.github/dependabot.yml` | monthly updates of the pinned actions | the package ecosystems of the project added |
| `.github/FUNDING.yml` | the sponsor links: GitHub Sponsors and Buy Me a Coffee, and the support page once it is online | kept |
| `tools/check.sh` | the checks of the workflows, one per argument, with exit status 0 for a pass, 1 for a finding, 2 for a tool error and 3 for a skipped check | extended by the checks of the project |
| `.githooks/pre-commit` | a gitleaks scan of the staged changes, enabled per clone | kept |
| `cliff.toml` | the git-cliff configuration that lists the commits by type as release notes | kept |
| `.gitleaks.toml` | the gitleaks rules: the default set, and an allowlist for documented placeholders | allowlist extended where needed |
| `.editorconfig`, `.gitattributes`, `.gitignore`, `.markdownlint.jsonc` | editor, git and Markdown lint configuration | trimmed to the toolchain |
| `docs/social/` | the social card of this template as SVG and PNG, and `render.sh`, which renders it with rsvg-convert | the card rewritten and rendered |

## Checks

Besides the stubs of `ci.yml`, every push to `main` and every pull request runs these checks, each through `tools/check.sh`, which runs them on a workstation as well:

- `docs.yml` lints the Markdown files with markdownlint-cli2 and the rules of [`.markdownlint.jsonc`](.markdownlint.jsonc);
- `checks.yml` validates `CITATION.cff`, or in the template its skeleton, with cffconvert and against schema 1.2.0 through a plain YAML loader, checks with reuse that every file carries its licence and copyright, and fails if `README.md` carries a placeholder; in a repository created from the template, it also fails while any file still carries a placeholder or template text;
- `secret-scan.yml` scans the whole history with gitleaks and the rules of [`.gitleaks.toml`](.gitleaks.toml).

Every action is pinned to a full commit SHA, markdownlint-cli2, cffconvert and reuse to a version, and gitleaks to a version and its SHA-256. Each workflow grants its token read access to the contents and nothing more; only the release job of `ci.yml`, which runs on a version tag, raises it to write.

## What it leaves out

- Source code, a build and tests: `ci.yml` holds them as stubs, because they depend on the toolchain of the project.
- Versions: the template has no tags and no releases, and the citation skeleton carries no version. A project adds `version` and `date-released` at its first release.
- A banner image in the README. The social card serves only as the preview image of links, uploaded under the repository settings.
- A code of conduct, a pull request template and `codemeta.json`. A project adds them where it needs them; `codemeta.json` repeats the citation metadata and so needs a check that both agree.
- A changelog file. `cliff.toml` writes the release notes from the commit history when they are needed.

## Licence

Released under the [MIT License](LICENSE).

## Contact

**Mert Torun, M.Sc.**: Verification of Safety-Critical Systems · Information Security  
mtorun0x7cd · Research & Development

- **Email**: [info@mtorun0x7cd.com](mailto:info@mtorun0x7cd.com)
- **LinkedIn**: [linkedin.com/in/mtorun0x7cd](https://www.linkedin.com/in/mtorun0x7cd)
- **ORCID**: [orcid.org/0009-0003-7932-9043](https://orcid.org/0009-0003-7932-9043)
- **GitHub**: [github.com/mtorun0x7cd](https://github.com/mtorun0x7cd)
- **Reddit**: [reddit.com/user/MTORUN0X7CD](https://www.reddit.com/user/MTORUN0X7CD)
- **Buy Me a Coffee**: [buymeacoffee.com/mtorun0x7cd](https://buymeacoffee.com/mtorun0x7cd)
