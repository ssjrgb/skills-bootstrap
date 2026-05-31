#!/usr/bin/env bash
set -uo pipefail

echo "================================="
echo "  一键安装推荐全局 Skills"
echo "================================="
echo ""

# =============================================
# 前置环境检查
# =============================================
echo "─── 前置环境检查 ───"
echo ""

PRE_ENV_OK=0
PRE_ENV_FAIL=0

# 版本比较函数: 返回 0 表示 $1 >= $2
version_ge() {
  printf '%s\n%s\n' "$2" "$1" | sort -V -C 2>/dev/null
}

# 提取版本号
extract_version() {
  echo "$1" | grep -oE '[0-9]+(\.[0-9]+)+' | head -1
}

# --- Node.js ---
NODE_MIN="18.0.0"
if command -v node &>/dev/null; then
  NODE_VER=$(extract_version "$(node -v 2>/dev/null)")
  if [ -n "$NODE_VER" ] && version_ge "$NODE_VER" "$NODE_MIN"; then
    echo "  ✓ Node.js $NODE_VER (要求 >= $NODE_MIN)"
    ((PRE_ENV_OK++))
  else
    echo "  ⚠ Node.js ${NODE_VER:-未检测到版本} < $NODE_MIN, 需升级"
    ((PRE_ENV_FAIL++))
  fi
else
  echo "  ✗ Node.js 未安装 (要求 >= $NODE_MIN)"
  echo "    请安装: brew install node 或访问 https://nodejs.org"
  ((PRE_ENV_FAIL++))
fi

# --- npm ---
NPM_MIN="9.0.0"
if command -v npm &>/dev/null; then
  NPM_VER=$(extract_version "$(npm -v 2>/dev/null)")
  if [ -n "$NPM_VER" ] && version_ge "$NPM_VER" "$NPM_MIN"; then
    echo "  ✓ npm $NPM_VER (要求 >= $NPM_MIN)"
    ((PRE_ENV_OK++))
  else
    echo "  ⚠ npm ${NPM_VER:-未检测到版本} < $NPM_MIN, 需升级"
    ((PRE_ENV_FAIL++))
  fi
else
  echo "  ✗ npm 未安装 (随 Node.js 一起安装)"
  ((PRE_ENV_FAIL++))
fi

# --- Git ---
GIT_MIN="2.30.0"
if command -v git &>/dev/null; then
  GIT_VER=$(extract_version "$(git --version 2>/dev/null)")
  if [ -n "$GIT_VER" ] && version_ge "$GIT_VER" "$GIT_MIN"; then
    echo "  ✓ Git $GIT_VER (要求 >= $GIT_MIN)"
    ((PRE_ENV_OK++))
  else
    echo "  ⚠ Git ${GIT_VER:-未检测到版本} < $GIT_MIN, 需升级"
    ((PRE_ENV_FAIL++))
  fi
else
  echo "  ✗ Git 未安装 (要求 >= $GIT_MIN)"
  echo "    请安装: brew install git 或访问 https://git-scm.com"
  ((PRE_ENV_FAIL++))
fi

# --- Python ---
PY_MIN="3.8.0"
if command -v python3 &>/dev/null; then
  PY_VER=$(extract_version "$(python3 --version 2>/dev/null)")
  if [ -n "$PY_VER" ] && version_ge "$PY_VER" "$PY_MIN"; then
    echo "  ✓ Python $PY_VER (要求 >= $PY_MIN)"
    ((PRE_ENV_OK++))
  else
    echo "  ⚠ Python ${PY_VER:-未检测到版本} < $PY_MIN, 需升级"
    ((PRE_ENV_FAIL++))
  fi
elif command -v python &>/dev/null; then
  PY_VER=$(extract_version "$(python --version 2>/dev/null)")
  if [ -n "$PY_VER" ] && version_ge "$PY_VER" "$PY_MIN"; then
    echo "  ✓ Python $PY_VER (要求 >= $PY_MIN)"
    ((PRE_ENV_OK++))
  else
    echo "  ⚠ Python ${PY_VER:-未检测到版本} < $PY_MIN, 需升级"
    ((PRE_ENV_FAIL++))
  fi
else
  echo "  ✗ Python 未安装 (要求 >= $PY_MIN)"
  echo "    请安装: brew install python3 或访问 https://python.org"
  ((PRE_ENV_FAIL++))
fi

# --- Claude Code CLI ---
if command -v claude &>/dev/null; then
  CLAUDE_VER=$(extract_version "$(claude --version 2>/dev/null)")
  if [ -n "$CLAUDE_VER" ]; then
    echo "  ✓ Claude Code CLI $CLAUDE_VER"
  else
    echo "  ✓ Claude Code CLI (已安装)"
  fi
  ((PRE_ENV_OK++))
else
  echo "  ✗ Claude Code CLI 未安装"
  echo "    手动安装: npm install -g @anthropic-ai/claude-code@latest"
  ((PRE_ENV_FAIL++))
fi

# --- cc-switch ---
if command -v ccswitch &>/dev/null; then
  CCS_VER=$(extract_version "$(ccswitch --version 2>/dev/null || echo '0.0.0')")
  if [ -n "$CCS_VER" ] && [ "$CCS_VER" != "0.0.0" ]; then
    echo "  ✓ cc-switch $CCS_VER"
  else
    echo "  ✓ cc-switch (已安装)"
  fi
  ((PRE_ENV_OK++))
elif command -v ccs &>/dev/null; then
  echo "  ✓ cc-switch (ccs) 已安装"
  ((PRE_ENV_OK++))
else
  echo "  ⚠ cc-switch 未安装 (可选工具)"
  echo "    手动安装: npm install -g ccswitch@latest"
fi

echo ""
echo "  前置检查: 通过 $PRE_ENV_OK, 失败 $PRE_ENV_FAIL"
echo ""

if [ "$PRE_ENV_FAIL" -gt 0 ]; then
  echo "  ⚠ 有 $PRE_ENV_FAIL 项前置条件未满足, 请完成安装后再重新运行脚本"
  echo ""
fi

# =============================================
# Skills 安装
# =============================================

# 获取已安装的全局 skill 列表
INSTALLED=$(npx skills ls -g --json 2>/dev/null | python3 -c "
import json, sys
data = json.load(sys.stdin)
for item in data:
    print(item['name'])
")

# 必装 Skills (npx skills add 方式)
REQUIRED_SKILLS=(
  # 效率工具
  "skill-creator|https://github.com/anthropics/skills"
  "find-skills|https://github.com/vercel-labs/skills"
  # 文档处理
  "docx|https://github.com/anthropics/skills"
  "pptx|https://github.com/anthropics/skills"
  "pdf|https://github.com/anthropics/skills"
  "xlsx|https://github.com/anthropics/skills"
  # 产品开发
  "mcp-builder|https://github.com/anthropics/skills"
  "webapp-testing|https://github.com/anthropics/skills"
)

TOTAL=${#REQUIRED_SKILLS[@]}

# 分别记录结果
SUCCESS_ARR=()
SKIPPED_ARR=()
FAIL_ARR=()

# 安装 skill 函数 (已安装则跳过)
install_skill() {
  local SKILL="$1"
  local REPO="$2"

  if echo "$INSTALLED" | grep -qxF "$SKILL"; then
    echo "  ⏭  $SKILL 已安装, 跳过"
    SKIPPED_ARR+=("$SKILL")
    return 0
  fi

  echo "  正在安装 $SKILL ..."

  LOGFILE=$(mktemp)
  if npx skills add "$REPO" --skill "$SKILL" -y -g >"$LOGFILE" 2>&1; then
    echo "  ✓ $SKILL 安装成功"
    SUCCESS_ARR+=("$SKILL")
  else
    REASON=$(grep -v '^[[:space:]]*$' "$LOGFILE" | tail -3 | sed 's/^/    /')
    if [ -z "$REASON" ]; then
      REASON="    未知错误"
    fi
    echo "  ✗ $SKILL 安装失败"
    echo "$REASON"
    FAIL_ARR+=("${SKILL}|${REASON}")
  fi
  rm -f "$LOGFILE"
}

# ====== 必装 ======
echo "─── 必装 Skills (${#REQUIRED_SKILLS[@]} 个) ───"
echo ""

# npx skills add 方式
for entry in "${REQUIRED_SKILLS[@]}"; do
  SKILL="${entry%%|*}"
  REPO="${entry##*|}"
  install_skill "$SKILL" "$REPO"
  echo ""
done

# ====== 汇总报告 ======
echo "================================="
echo "        安 装 汇 总"
echo "================================="
echo ""

echo "  前置环境: 通过 $PRE_ENV_OK 项"
echo ""

if [ ${#SKIPPED_ARR[@]} -gt 0 ]; then
  echo "⏭  跳过 (已安装): ${#SKIPPED_ARR[@]} 个"
  for s in "${SKIPPED_ARR[@]}"; do
    echo "    · $s"
  done
  echo ""
fi

if [ ${#SUCCESS_ARR[@]} -gt 0 ]; then
  echo "✓ 成功安装: ${#SUCCESS_ARR[@]} 个"
  for s in "${SUCCESS_ARR[@]}"; do
    echo "    · $s"
  done
  echo ""
fi

if [ ${#FAIL_ARR[@]} -gt 0 ]; then
  echo "✗ 安装失败: ${#FAIL_ARR[@]} 个"
  for entry in "${FAIL_ARR[@]}"; do
    SKILL="${entry%%|*}"
    REASON="${entry#*|}"
    echo "    · $SKILL"
    echo "$REASON"
  done
  echo ""
fi

echo "─────────────────────────────────"
echo "  总计: $TOTAL  |  成功: ${#SUCCESS_ARR[@]}  |  跳过(已安装): ${#SKIPPED_ARR[@]}  |  失败: ${#FAIL_ARR[@]}"
echo "================================="
