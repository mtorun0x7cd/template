# Security policy

## Scope

<!-- TEMPLATE: say what this repository holds and runs, and which versions receive security fixes. -->

This repository is a template for new repositories. It ships no software for use: it holds documentation, configuration, a pre-commit hook and workflows, which every repository created from it inherits. Only the current state of the default branch is maintained; there are no versions.

## What to report privately

<!-- TEMPLATE: list what should not be reported in public for this project. -->

- A secret, a credential or personal data committed to this repository by mistake, in a file or in the history.
- A weakness of the workflows under `.github/` or of the hook under `.githooks/` that could let someone change what this repository, or a repository created from it, runs or publishes.
- An action pinned here at a version with a published vulnerability.

## How to report

<!-- TEMPLATE: keep both routes only where private vulnerability reporting is enabled. -->

Use GitHub's private vulnerability reporting (the tab Security, then Report a vulnerability), or write to [info@mtorun0x7cd.com](mailto:info@mtorun0x7cd.com), naming the file, the problem and how to see it. Do not open a public issue for it.

## What is not a vulnerability

<!-- TEMPLATE: name the design limits and the development-only defaults of the project. -->

The placeholders in the template files are not values. A placeholder that has the form of a credential, such as `<api-token>`, is documented as one in [`.gitleaks.toml`](.gitleaks.toml). A weakness of an action itself belongs to the repository of that action.

## What to expect

<!-- TEMPLATE: state what a reporter can expect, without promising a response time. -->

Reports are read. A reply or a fix is not guaranteed.
