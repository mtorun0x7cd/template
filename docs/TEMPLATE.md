# Using this template

This repository is a project template. When you create a new repository from it, replace the placeholder tokens below and complete the setup steps. Tokens use the `{{UPPER_SNAKE}}` form and appear in `docs/README.template.md`, `CITATION.cff`, `LICENSE` and `.github/ISSUE_TEMPLATE/config.yml`.

## Placeholder tokens

| Token | Meaning |
| --- | --- |
| `{{PROJECT_NAME}}` | Human-readable project title. |
| `{{TAGLINE}}` | One-line summary shown under the title. |
| `{{STATUS}}` | Status badge text: `WIP`, `Active` or `Inactive`, the three values of repostatus.org this template uses. `WIP` until a first stable, usable release; `Active` claims that release, so a repository holding only a design stays at `WIP`. |
| `{{STATUS_SLUG}}` | The same status in lower case, `wip`, `active` or `inactive`; it completes the badge's link to repostatus.org. |
| `{{YEAR}}` | The years of the work in `LICENSE`, as a comma-separated list: `2026`, or `2021, 2026` for work begun earlier. |
| `{{CONTEXT}}` | Course, thesis, or research context. |
| `{{ABSTRACT}}` | Short abstract, in the README's Overview and in `CITATION.cff`. |
| `{{KEYWORDS}}` | Citation keywords in `CITATION.cff`: replace the whole item `- "{{KEYWORDS}}"` by one quoted item per keyword. |
| `{{REPO_SLUG}}` | Repository name, the `name` half of the `owner/name` slug; the owner is already fixed in the URLs. |

The README skeleton also carries free-form section tokens filled with prose rather than short values: `{{FEATURE}}`, `{{ARCHITECTURE}}`, `{{TECH_STACK}}`, `{{TREE}}`, `{{GETTING_STARTED}}`, `{{DOCUMENTATION}}`, `{{REFERENCES}}`. The Programme row of its Context table names the author's degree programme; remove the row where the project has no academic context.

`CITATION.cff` carries no `version` and no `date-released`. Add both at the first release, taken from its tag, and never before.

Not every placeholder is tokenised. `SECURITY.md` and `CONTRIBUTING.md` are the template's own texts, and each of their sections opens with an HTML comment starting `TEMPLATE:` that says what to write there. `.editorconfig`, `.gitattributes` and `.gitignore` close with guidance comments, and the social card carries the template's own text. A `{{...}}` search does not find these, so the steps below name them explicitly.

## Setup steps

1. Replace the README with the skeleton and put the citation skeleton in place: `git mv -f docs/README.template.md README.md` and `git mv docs/CITATION.template.cff CITATION.cff`. The template itself carries no `CITATION.cff`, so its page offers no citation of a template.
2. Replace every `{{TOKEN}}` across `README.md`, `CITATION.cff`, `LICENSE` and `.github/ISSUE_TEMPLATE/config.yml`.
3. Rewrite `SECURITY.md` and `CONTRIBUTING.md` as statements of fact about this project, section by section, and remove each `TEMPLATE:` comment once its section is written. Prune the trailing guidance comments in `.editorconfig`, `.gitattributes` and `.gitignore` to the toolchain actually present.
4. Set `{{STATUS}}` to `WIP`, `Active` or `Inactive` and `{{STATUS_SLUG}}` to match, and align `CONTRIBUTING.md`: a project in progress or active accepts contributions; an inactive one is kept as a record and takes corrections only.
5. Rewrite the title, the description and the three lines of text in `docs/social/social-card.svg` for the project, render the card with `./docs/social/render.sh` (requires `rsvg-convert`), and commit the SVG and the PNG together. The README shows no banner; the card is only the preview image of links, uploaded in step 8.
6. Add the project's package ecosystems to `.github/dependabot.yml` and the build and test steps to `.github/workflows/ci.yml`.
7. Confirm the licence. MIT is the default and is stated in four places: `LICENSE`, the README badge, the README's Licence section, and the `license:` field of `CITATION.cff`. A project under a different licence must change all four; the value is untokenised, so no `{{...}}` search catches a missed one. Set the year of the `SPDX-FileCopyrightText` line in each file that carries one (`git grep -ln SPDX-FileCopyrightText`) to the years of the project.
8. Configure the repository settings:
   - **Description:** one sentence on what the repository holds, without a dash. **Homepage:** `https://mtorun0x7cd.com`. **Topics:** accurate ones only, at most 20.
   - **Social preview** (Settings, General): upload `docs/social/social-card.png`.
   - **Features** (Settings, General): Wiki, Projects and Discussions off unless used. Issues on for an active project and off for an inactive one; with Issues off, delete `.github/ISSUE_TEMPLATE/`, whose forms are then unreachable. Sponsorships as the project needs them.
   - **Pull requests** (Settings, General): allow squash merging only. GitHub adds rebase-merged commits without a signature, so the signature rule below would refuse them.
   - **Rulesets** (Settings, Rulesets): one on the default branch that restricts deletions, blocks force pushes, requires signed commits and a linear history, with no bypass; one on `refs/tags/v*` that restricts updates and deletions and blocks force pushes, and leaves creations free.
   - **Code security** (Settings, Advanced Security): secret scanning and push protection on, private vulnerability reporting on (`SECURITY.md` names it), Dependabot alerts on.
   - **Releases** (Settings, General): immutable releases on, before the first release exists. The release job of `ci.yml` keeps the order this needs: it creates the release as a draft, attaches the files of `.tmp.nosync/dist/`, checks them against the build and only then publishes the release; a build that leaves `.tmp.nosync/dist/` empty stops it before the draft exists.
   - **Actions** (Settings, Actions, General): require actions to be pinned to a full-length commit SHA; workflow permissions read-only; workflows may not create or approve pull requests; fork pull requests from every outside contributor need approval; artifacts and logs are kept 14 days.
   - **Commits:** messages follow Conventional Commits, in English and ASCII, and are signed.
9. Add an allowlist regex for any disclosed demo credential to `.gitleaks.toml`, and enable the pre-commit secret scan in the clone with `git config core.hooksPath .githooks` (requires the `gitleaks` CLI).
10. Delete this file. Then `git grep -nIE '\{\{[A-Z0-9_]+\}\}|TEMPLATE:|mtorun0x7cd/template' -- ':(exclude).github/workflows/checks.yml'` must return nothing: the pattern matches no GitHub Actions expression such as `${{ github.ref }}`, `-I` skips the PNG, and the excluded workflow names the pattern itself. The workflow `checks.yml` runs the same search on every push of a repository created from the template.
