# Using this template

This repository is a project template. When you create a new repository from it,
replace the placeholder tokens below and complete the setup steps. Tokens use the
`{{UPPER_SNAKE}}` form and appear in `README.md`, `CITATION.cff`, `SECURITY.md`,
`LICENSE`, and `docs/social_preview.svg`.

## Placeholder tokens

| Token | Meaning |
| --- | --- |
| `{{PROJECT_NAME}}` | Human-readable project title. |
| `{{TAGLINE}}` | One-line summary shown under the title. |
| `{{STATUS}}` | Lifecycle badge text: `Active` or `Archived`. |
| `{{YEAR}}` | MIT copyright span in `LICENSE`: the origin year, or `<origin-year>-<current-year>` for work that began earlier (e.g. `2019-2026`). |
| `{{CONTEXT}}` | Course, thesis, or research context. |
| `{{ABSTRACT}}` | Short abstract for `CITATION.cff`. |
| `{{KEYWORDS}}` | Citation keywords, one per line as a `keywords:` sequence item in `CITATION.cff`. |
| `{{BADGE_LABEL}}` | Social-preview badge text; a short label such as `ACADEMIC ARCHIVE`. Long text overflows the fixed-width badge. |
| `{{REPO_SLUG}}` | Repository name — the `name` half of the `owner/name` slug; the owner is already fixed in the URLs. |

The README body also carries free-form section tokens filled with prose rather
than short values: `{{FEATURE}}`, `{{ARCHITECTURE}}`, `{{TECH_STACK}}`, `{{TREE}}`,
`{{GETTING_STARTED}}`, `{{DOCUMENTATION}}`, `{{REFERENCES}}`.

`CITATION.cff` ships without `date-released`; add it only once a release exists,
set from the tag date.

Not every placeholder is tokenised: `SECURITY.md` is instructional prose
throughout, and `.editorconfig`, `.gitattributes`, and `.gitignore` close with
guidance comments. A `{{...}}` search does not find them, so the steps below name
them explicitly.

## Setup steps

1. Replace every `{{TOKEN}}` across `README.md`, `CITATION.cff`, `SECURITY.md`,
   `LICENSE`, and `docs/social_preview.svg`.
2. Rewrite `SECURITY.md`'s four sections — Status, Fitness for use, Known
   limitations, Reporting — as statements of fact about this project, and prune
   the trailing guidance comments in `.editorconfig`, `.gitattributes`, and
   `.gitignore` to the toolchain actually present.
3. Set `{{STATUS}}` to `Active` or `Archived`, and align `CONTRIBUTING.md`
   accordingly: an active project accepts contributions; an archive does not.
4. Replace the placeholder icon group in `docs/social_preview.svg` with a bespoke
   line-art glyph for the project, then regenerate the social-preview images with
   `./docs/render.sh` (requires Node, ImageMagick, and Google Chrome) and upload
   `docs/social_card.png` under the repository's Settings → Social preview.
5. Add the project's dependency ecosystem to `.github/dependabot.yml` and the
   build and test steps to `.github/workflows/ci.yml`.
6. Add stopwords for any disclosed demo credentials to `.gitleaks.toml`.
7. Configure repository settings: Issues enabled for an active project and
   disabled for an archive; leave Wiki and Projects off unless used.
8. Delete `docs/TEMPLATE.md` and the pointer line in `README.md`; `git grep '{{'`
   must then return nothing.
