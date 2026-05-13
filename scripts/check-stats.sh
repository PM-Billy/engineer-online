#!/usr/bin/env bash
# check-stats.sh — 验证 README 项目统计数字是否与实际一致
#
# 用法：bash scripts/check-stats.sh

set -o pipefail
cd "$(dirname "$0")/.."

EXIT_CODE=0
README="README.md"
MODULES_DIR="requirement/modules"

echo "→ Check: README stats vs actual counts"

# 实际统计
ACTUAL_BR=$(grep -rhoE '^- BR-[0-9]+\.[0-9]+-[0-9]+:' "$MODULES_DIR" 2>/dev/null | sort -u | wc -l | tr -d ' ')
ACTUAL_EX=$(grep -rhoE '\| EX-[0-9]+\.[0-9]+-[0-9]+ \|' "$MODULES_DIR" 2>/dev/null | sort -u | wc -l | tr -d ' ')
ACTUAL_AC=$(grep -rhoE '^- AC-[0-9]+\.[0-9]+-[0-9]+:|^\| AC-[0-9]+\.[0-9]+-[0-9]+' "$MODULES_DIR" 2>/dev/null | grep -oE 'AC-[0-9]+\.[0-9]+-[0-9]+' | sort -u | wc -l | tr -d ' ')
ACTUAL_PERM=$(grep -oE '^\| `[a-z]+:[a-z-]+:[a-z]+`' design/权限设计.md 2>/dev/null | sort -u | wc -l | tr -d ' ')
ACTUAL_MODULES=$(ls "$MODULES_DIR"/05.*.md 2>/dev/null | wc -l | tr -d ' ')

# README 中声明的数字
README_BR=$(grep -oE '业务规则总数.*\| [0-9]+' "$README" | grep -oE '[0-9]+$' || echo "N/A")
README_EX=$(grep -oE '异常处理场景.*\| [0-9]+' "$README" | grep -oE '[0-9]+$' || echo "N/A")
README_AC=$(grep -oE '验收标准总数.*\| [0-9]+' "$README" | grep -oE '[0-9]+$' || echo "N/A")
README_PERM=$(grep -oE 'Permission Code \| [0-9]+' "$README" | grep -oE '[0-9]+$' || echo "N/A")
README_MODULES=$(grep -oE '功能模块数 \| [0-9]+' "$README" | grep -oE '[0-9]+$' || echo "N/A")

check_stat() {
  local name="$1" actual="$2" readme="$3"
  if [ "$actual" != "$readme" ]; then
    echo "❌ $name: README=$readme, actual=$actual"
    EXIT_CODE=1
  else
    echo "   ✓ $name: $actual"
  fi
}

check_stat "功能模块数" "$ACTUAL_MODULES" "$README_MODULES"
check_stat "业务规则 BR" "$ACTUAL_BR" "$README_BR"
check_stat "异常处理 EX" "$ACTUAL_EX" "$README_EX"
check_stat "验收标准 AC" "$ACTUAL_AC" "$README_AC"
check_stat "Permission Code" "$ACTUAL_PERM" "$README_PERM"

if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ README stats match actual counts"
fi

exit $EXIT_CODE
