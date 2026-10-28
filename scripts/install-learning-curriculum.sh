#!/usr/bin/env bash
# Copies learning curriculum rule + skill into ~/.cursor (cloud agent home).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

RULE_SRC="${ROOT}/.cursor/rules/learning-curriculum-mentor.mdc"
SKILL_SRC="${ROOT}/.cursor/skills/learning-curriculum-mentor/SKILL.md"

mkdir -p "${HOME}/.cursor/rules" "${HOME}/.cursor/skills/learning-curriculum-mentor"

cp -f "${RULE_SRC}" "${HOME}/.cursor/rules/learning-curriculum-mentor.mdc"
cp -f "${SKILL_SRC}" "${HOME}/.cursor/skills/learning-curriculum-mentor/SKILL.md"

echo "Learning curriculum synced:"
ls -la "${HOME}/.cursor/rules/learning-curriculum-mentor.mdc"
ls -la "${HOME}/.cursor/skills/learning-curriculum-mentor/SKILL.md"
