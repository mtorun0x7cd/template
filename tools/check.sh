#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Mert Torun
# SPDX-License-Identifier: MIT
#
# The checks of this repository, one per argument, run the same way on a
# workstation and in the workflows under .github/workflows/, which call this
# script, so that each check is written once.
#
#   tools/check.sh markdown   lint the Markdown files with markdownlint-cli2 and
#                             the rules of .markdownlint.jsonc (needs npx)
#   tools/check.sh readme     README.md carries no {{TOKEN}} placeholder
#   tools/check.sh setup      a repository created from the template keeps no
#                             placeholder, no TEMPLATE: comment, no setup file
#                             and no link to the template; skipped (3) in the
#                             template itself
#   tools/check.sh citation   the citation file holds schema 1.2.0 as a plain
#                             YAML loader reads it (needs PyYAML and jsonschema
#                             in $PYTHON, and the schema of cffconvert or a
#                             schema file in $CFF_SCHEMA)
#   tools/check.sh reuse      every file carries its licence and copyright, as
#                             REUSE 3.3 defines it (needs reuse, or $REUSE)
#   tools/check.sh secrets    gitleaks finds no secret in the history, with the
#                             rules of .gitleaks.toml (needs gitleaks, or
#                             $GITLEAKS)
#   tools/check.sh all        each check above in turn (the default)
#
# Exit status: 0 the check holds; 1 a finding; 2 a tool error: an argument that
# is not understood, a tool that is missing or fails, or a file that cannot be
# read, so that nothing was checked; 3 skipped. A tool error is never reported
# as a finding or as a pass. For "all", 2 beats 1, 1 beats 0, and 3 is
# returned only when every check was skipped. This script writes nothing.

set -uo pipefail

MARKDOWNLINT_VERSION=0.23.3
PYTHON=${PYTHON:-python3}
REUSE=${REUSE:-reuse}
GITLEAKS=${GITLEAKS:-gitleaks}

cd "$(dirname "$0")/.." || exit 2

# The name of this repository on GitHub: from the workflow, or else from the
# address of the remote origin.
repository_name() {
    if [ -n "${GITHUB_REPOSITORY:-}" ]; then
        printf '%s\n' "$GITHUB_REPOSITORY"
        return
    fi
    git remote get-url origin 2>/dev/null | sed -E 's#^.*github\.com[:/]##; s#\.git$##'
}

check_markdown() {
    if ! command -v npx >/dev/null 2>&1; then
        echo "markdown: npx is not installed; nothing was linted" >&2
        return 2
    fi
    local rc=0
    npx --yes "markdownlint-cli2@${MARKDOWNLINT_VERSION}" "**/*.md" || rc=$?
    case $rc in
        0) return 0 ;;
        1) echo "markdown: the files above break a rule of .markdownlint.jsonc" >&2; return 1 ;;
        *) echo "markdown: markdownlint-cli2 failed with exit code $rc" >&2; return 2 ;;
    esac
}

# grep exits 0 on a match, 1 on none and 2 on an error.
check_readme() {
    local rc=0
    grep -nE '\{\{[A-Z0-9_]+\}\}' README.md || rc=$?
    case $rc in
        0) echo "readme: README.md carries the placeholders above" >&2; return 1 ;;
        1) echo "readme: README.md carries no placeholder"; return 0 ;;
        *) echo "readme: grep failed with exit code $rc" >&2; return 2 ;;
    esac
}

# This file names the three patterns it searches for, and checks.yml names the
# template in its condition, so both are left out of the search.
check_setup() {
    if [ "$(repository_name)" = "mtorun0x7cd/template" ]; then
        echo "setup: skipped, this is the template itself"
        return 3
    fi
    local status=0 path rc=0
    for path in docs/TEMPLATE.md docs/README.template.md docs/CITATION.template.cff; do
        if [ -e "$path" ]; then
            echo "setup: $path is still present" >&2
            status=1
        fi
    done
    git grep -nIE '\{\{[A-Z0-9_]+\}\}|TEMPLATE:|mtorun0x7cd/template' -- \
        ':(exclude)tools/check.sh' ':(exclude).github/workflows/checks.yml' || rc=$?
    case $rc in
        0) echo "setup: the lines above still carry template text" >&2; status=1 ;;
        1) ;;
        *) echo "setup: git grep failed with exit code $rc" >&2; return 2 ;;
    esac
    if [ "$status" -eq 0 ]; then
        echo "setup: no placeholder and no template text is left"
    fi
    return "$status"
}

# A plain YAML loader turns an unquoted date into a date object, which the
# schema refuses; this check reads the file the way such a loader does. The
# template carries its skeleton at docs/CITATION.template.cff and no
# CITATION.cff.
check_citation() {
    local cff=CITATION.cff
    if [ ! -f "$cff" ]; then
        cff=docs/CITATION.template.cff
    fi
    "$PYTHON" -B - "$cff" <<'PYEOF'
import json
import os
import pathlib
import sys

try:
    import jsonschema
    import yaml
except ImportError as error:
    print(f"citation: {error}; nothing was checked", file=sys.stderr)
    sys.exit(2)

schema_file = os.environ.get("CFF_SCHEMA")
if not schema_file:
    try:
        import cffconvert
    except ImportError:
        print("citation: neither CFF_SCHEMA nor cffconvert gives the schema; nothing was checked", file=sys.stderr)
        sys.exit(2)
    schema_file = pathlib.Path(cffconvert.__file__).parent / "schemas" / "1.2.0" / "schema.json"
path = pathlib.Path(sys.argv[1])
try:
    schema = json.loads(pathlib.Path(schema_file).read_text(encoding="utf-8"))
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
except (OSError, ValueError, yaml.YAMLError) as error:
    print(f"citation: {error}; nothing was checked", file=sys.stderr)
    sys.exit(2)
try:
    jsonschema.validate(data, schema)
except jsonschema.ValidationError as error:
    print(f"citation: {path} breaks schema 1.2.0: {error.message}", file=sys.stderr)
    sys.exit(1)
print(f"citation: {path} holds schema 1.2.0 as a plain YAML loader reads it")
PYEOF
    local rc=$?
    case $rc in
        0|1) return "$rc" ;;
        *) return 2 ;;
    esac
}

check_reuse() {
    if ! command -v "$REUSE" >/dev/null 2>&1; then
        echo "reuse: $REUSE is not installed; nothing was checked" >&2
        return 2
    fi
    local rc=0
    "$REUSE" lint || rc=$?
    case $rc in
        0) return 0 ;;
        1) echo "reuse: the files above lack licence or copyright information" >&2; return 1 ;;
        *) echo "reuse: reuse failed with exit code $rc" >&2; return 2 ;;
    esac
}

# gitleaks reports a find with the exit code given here, 9, so that any other
# failure is told apart as a tool error.
check_secrets() {
    if ! command -v "$GITLEAKS" >/dev/null 2>&1; then
        echo "secrets: $GITLEAKS is not installed; nothing was scanned" >&2
        return 2
    fi
    local rc=0
    "$GITLEAKS" git --no-banner --redact --exit-code 9 --config .gitleaks.toml . || rc=$?
    case $rc in
        0) return 0 ;;
        9) echo "secrets: gitleaks found a potential secret in the history" >&2; return 1 ;;
        *) echo "secrets: gitleaks failed with exit code $rc" >&2; return 2 ;;
    esac
}

run_all() {
    local worst=0 ran=0 name rc
    for name in markdown readme setup citation reuse secrets; do
        rc=0
        "check_$name" || rc=$?
        echo "== $name: exit $rc"
        if [ "$rc" -ne 3 ]; then
            ran=1
        fi
        if [ "$rc" -eq 2 ]; then
            worst=2
        elif [ "$rc" -eq 1 ] && [ "$worst" -ne 2 ]; then
            worst=1
        fi
    done
    if [ "$ran" -eq 0 ]; then
        return 3
    fi
    return "$worst"
}

if [ "$#" -gt 1 ]; then
    echo "usage: tools/check.sh [markdown|readme|setup|citation|reuse|secrets|all]" >&2
    exit 2
fi
case "${1:-all}" in
    markdown|readme|setup|citation|reuse|secrets) "check_$1" ;;
    all) run_all ;;
    *) echo "usage: tools/check.sh [markdown|readme|setup|citation|reuse|secrets|all]" >&2
       exit 2 ;;
esac
