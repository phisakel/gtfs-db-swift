#!/usr/bin/env bash
set -euo pipefail

CURRENT_TAG="${1:-}"
PREVIOUS_TAG="${2:-}"

if [[ -z "$CURRENT_TAG" ]]; then
  echo "Usage: $0 <current-tag> [previous-tag]" >&2
  exit 1
fi

if [[ -z "$PREVIOUS_TAG" ]]; then
  PREVIOUS_TAG="$(git tag --sort=-creatordate | grep -v "^${CURRENT_TAG}$" | head -n 1 || true)"
fi

RANGE="$CURRENT_TAG"
if [[ -n "$PREVIOUS_TAG" ]]; then
  RANGE="${PREVIOUS_TAG}..${CURRENT_TAG}"
fi

COMMITS="$(git log --no-merges --pretty=format:'%s (%h)' "$RANGE" || true)"
if [[ -z "$COMMITS" ]]; then
  COMMITS="No source changes in this release."
fi

HIGHLIGHTS="$(printf '%s\n' "$COMMITS" | head -n 3)"

printf '## Highlights\n'
printf '%s\n' "$HIGHLIGHTS" | sed 's/^/- /'
printf '\n## What\x27s Changed\n'
printf '%s\n' "$COMMITS" | sed 's/^/- /'

if [[ -n "$PREVIOUS_TAG" ]]; then
  if [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
    printf '\n**Full Changelog**: https://github.com/%s/compare/%s...%s\n' "$GITHUB_REPOSITORY" "$PREVIOUS_TAG" "$CURRENT_TAG"
  else
    printf '\n**Full Changelog**: %s...%s\n' "$PREVIOUS_TAG" "$CURRENT_TAG"
  fi
fi
