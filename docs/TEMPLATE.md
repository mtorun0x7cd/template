# Using this template

This repository is a project template. When you create a new repository from it,
replace the placeholder tokens below and complete the setup steps. Tokens use the
`{{UPPER_SNAKE}}` form and appear in `README.md`, `CITATION.cff`, `SECURITY.md`,
`LICENSE`, `docs/social_preview.svg`, and `.github/ISSUE_TEMPLATE/config.yml`.

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
   `LICENSE`, `docs/social_preview.svg`, and `.github/ISSUE_TEMPLATE/config.yml`.
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
6. Confirm the licence. MIT is the default and is stated in four places —
   `LICENSE`, the README badge, the README `## License` line, and `CITATION.cff`'s
   `license:` field. A project under a different licence must change all four; the
   value is untokenised, so no `{{...}}` search catches a missed one.
7. Add an allowlist regex for any disclosed demo credential to `.gitleaks.toml`,
   and enable the pre-commit secret scan in the clone with
   `git config core.hooksPath .githooks` (requires the `gitleaks` CLI).
8. Configure repository settings: set the description and the Homepage field to
   `https://mtorun0x7cd.com`; Issues enabled for an active project and disabled
   for an archive; leave Wiki, Projects, and Discussions off unless used. For an
   archive, delete `.github/ISSUE_TEMPLATE/` — with Issues disabled the forms are
   unreachable.
9. Delete `docs/TEMPLATE.md` and the pointer line in `README.md`. Then
   `git grep -I '{{' -- ':!.github/workflows'` must return nothing: `-I` skips the
   binary previews, whose compressed bytes match the pattern by chance, and the
   pathspec skips the workflows, where `${{ ... }}` is GitHub Actions expression
   syntax rather than a placeholder.
