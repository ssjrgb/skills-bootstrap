#!/usr/bin/env bash
set -uo pipefail

echo "================================="
echo "  一键安装推荐全局 Skills"
echo "================================="
echo ""

# 获取已安装的全局 skill 列表
INSTALLED=$(npx skills ls -g --json 2>/dev/null | python3 -c "
import json, sys
data = json.load(sys.stdin)
for item in data:
    print(item['name'])
")

# 必装 Skills (npx skills add 方式)
REQUIRED_SKILLS=(
  "skill-creator|https://github.com/anthropics/skills"
  "find-skills|https://github.com/vercel-labs/skills"
  "docx|https://github.com/anthropics/skills"
  "pptx|https://github.com/anthropics/skills"
  "pdf|https://github.com/anthropics/skills"
  "xlsx|https://github.com/anthropics/skills"
  "mcp-builder|https://github.com/anthropics/skills"
  "webapp-testing|https://github.com/anthropics/skills"
)

# 可选 Skills (安装前逐个确认)  格式: name|desc|repo_url
OPTIONAL_SKILLS=(
  "humanizer-zh|AI 写作去痕, 识别并修复 24 种 AI 写作痕迹|https://github.com/op7418/humanizer-zh"
  "knowledge-site-creator|一句话生成知识学习网站, 四种学习模式|https://github.com/joeseesun/knowledge-site-creator"
  "book2skill|将书籍方法论蒸馏为 Agent Skills, 六阶段 RIA-TV++|https://github.com/kangarooking/cangjie-skill"
  "huashu-nuwa|蒸馏公众人物的思维方式 (心智模型/决策启发式)|https://github.com/alchaincyf/nuwa-skill"
  "last30days|跨平台研究代理, 聚合 Reddit/X/YouTube/HN 等 10+ 平台近 30 天内容|https://github.com/mvanhorn/last30days-skill"
)

# 必装 npm 工具  格式: name|desc|check_cmd|install_cmds (用 ; 分隔多条)
REQUIRED_NPM_TOOLS=(
  "ui-ux-pro-max|UI/UX 设计智能助手, 67 种样式/96 种调色板|uipro|npm install -g uipro-cli;uipro init --ai all --global"
)

# 可选 MCP 工具  格式: name|desc|mcp_name|install_cmd
OPTIONAL_MCP_TOOLS=(
  "chrome-devtools|Chrome DevTools MCP, AI Agent 通过 CDP 控制浏览器|chrome-devtools|claude mcp add chrome-devtools --scope user npx chrome-devtools-mcp@latest"
)

TOTAL=$((${#REQUIRED_SKILLS[@]} + ${#REQUIRED_NPM_TOOLS[@]} + ${#OPTIONAL_SKILLS[@]} + ${#OPTIONAL_MCP_TOOLS[@]}))

# 分别记录结果
SUCCESS_ARR=()
FAIL_ARR=()
USER_SKIPPED_ARR=()

# 安装 skill 函数 (有旧版先删再装)
install_skill() {
  local SKILL="$1"
  local REPO="$2"

  if echo "$INSTALLED" | grep -qxF "$SKILL"; then
    echo "  检测到 $SKILL 已安装, 先删除旧版..."
    npx skills remove "$SKILL" -y -g >/dev/null 2>&1 || true
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

# 安装 npm 工具函数 (有旧版先删再装)
install_npm_tool() {
  local NAME="$1"
  local CHECK_CMD="$2"
  local INSTALL_CMDS="$3"

  if command -v "$CHECK_CMD" &>/dev/null; then
    echo "  检测到 $CHECK_CMD 已安装, 先卸载旧版..."
    npm uninstall -g uipro-cli >/dev/null 2>&1 || true
  fi

  echo "  正在安装 $NAME ..."

  IFS=';' read -ra CMDS <<< "$INSTALL_CMDS"
  ALL_OK=true
  for cmd in "${CMDS[@]}"; do
    CMD_CLEAN=$(echo "$cmd" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    echo "    执行: $CMD_CLEAN"
    LOGFILE=$(mktemp)
    if eval "$CMD_CLEAN" >"$LOGFILE" 2>&1; then
      :
    else
      ALL_OK=false
      REASON=$(grep -v '^[[:space:]]*$' "$LOGFILE" | tail -3 | sed 's/^/    /')
      if [ -z "$REASON" ]; then
        REASON="    未知错误"
      fi
    fi
    rm -f "$LOGFILE"
  done

  if $ALL_OK; then
    echo "  ✓ $NAME 安装成功"
    SUCCESS_ARR+=("$NAME")
  else
    echo "  ✗ $NAME 安装失败"
    echo "$REASON"
    FAIL_ARR+=("${NAME}|${REASON}")
  fi
}

# 安装 MCP 工具函数 (有旧版先删再装)
install_mcp() {
  local NAME="$1"
  local MCP_NAME="$2"
  local INSTALL_CMD="$3"

  if claude mcp list 2>/dev/null | grep -qF "$MCP_NAME"; then
    echo "  检测到 $MCP_NAME 已安装, 先删除旧版..."
    claude mcp remove "$MCP_NAME" --scope user >/dev/null 2>&1 || true
  fi

  echo "  正在安装 $NAME ..."

  LOGFILE=$(mktemp)
  if eval "$INSTALL_CMD" >"$LOGFILE" 2>&1; then
    echo "  ✓ $NAME 安装成功"
    SUCCESS_ARR+=("$NAME")
  else
    REASON=$(grep -v '^[[:space:]]*$' "$LOGFILE" | tail -3 | sed 's/^/    /')
    if [ -z "$REASON" ]; then
      REASON="    未知错误"
    fi
    echo "  ✗ $NAME 安装失败"
    echo "$REASON"
    FAIL_ARR+=("${NAME}|${REASON}")
  fi
  rm -f "$LOGFILE"
}

# ====== 必装 ======
echo "─── 必装 Skills ($((${#REQUIRED_SKILLS[@]} + ${#REQUIRED_NPM_TOOLS[@]})) 个) ───"
echo ""

# npx skills add 方式
for entry in "${REQUIRED_SKILLS[@]}"; do
  SKILL="${entry%%|*}"
  REPO="${entry##*|}"
  install_skill "$SKILL" "$REPO"
  echo ""
done

# npm 方式
for entry in "${REQUIRED_NPM_TOOLS[@]}"; do
  NAME="${entry%%|*}"
  REST="${entry#*|}"
  DESC="${REST%%|*}"
  REST2="${REST#*|}"
  CHECK_CMD="${REST2%%|*}"
  INSTALL_CMDS="${REST2##*|}"
  install_npm_tool "$NAME" "$CHECK_CMD" "$INSTALL_CMDS"
  echo ""
done

# ====== 可选 ======
echo "─── 可选 Skills (${#OPTIONAL_SKILLS[@]} 个) ───"
echo ""

for entry in "${OPTIONAL_SKILLS[@]}"; do
  SKILL="${entry%%|*}"
  REST="${entry#*|}"
  DESC="${REST%%|*}"
  REPO="${REST##*|}"

  ALREADY_INSTALLED=false
  if echo "$INSTALLED" | grep -qxF "$SKILL"; then
    ALREADY_INSTALLED=true
  fi

  read -r -p "  是否安装 ${SKILL} (${DESC})? [y/N] " ANSWER
  case "$ANSWER" in
    [yY]|[yY][eE][sS])
      if $ALREADY_INSTALLED; then
        echo "  检测到 ${SKILL} 已安装, 先删除旧版..."
        npx skills remove "$SKILL" -y -g >/dev/null 2>&1 || true
      fi
      install_skill "$SKILL" "$REPO"
      ;;
    *)
      echo "  ⊘ ${SKILL} 用户跳过"
      USER_SKIPPED_ARR+=("$SKILL")
      ;;
  esac
  echo ""
done

# ====== 可选 MCP ======
echo "─── 可选 MCP 工具 (${#OPTIONAL_MCP_TOOLS[@]} 个) ───"
echo ""

for entry in "${OPTIONAL_MCP_TOOLS[@]}"; do
  NAME="${entry%%|*}"
  REST="${entry#*|}"
  DESC="${REST%%|*}"
  REST2="${REST#*|}"
  MCP_NAME="${REST2%%|*}"
  INSTALL_CMD="${REST2##*|}"

  read -r -p "  是否安装 ${NAME} (${DESC})? [y/N] " ANSWER
  case "$ANSWER" in
    [yY]|[yY][eE][sS])
      install_mcp "$NAME" "$MCP_NAME" "$INSTALL_CMD"
      ;;
    *)
      echo "  ⊘ ${NAME} 用户跳过"
      USER_SKIPPED_ARR+=("$NAME")
      ;;
  esac
  echo ""
done

# ====== 汇总报告 ======
echo "================================="
echo "        安 装 汇 总"
echo "================================="
echo ""

if [ ${#SUCCESS_ARR[@]} -gt 0 ]; then
  echo "✓ 成功安装: ${#SUCCESS_ARR[@]} 个"
  for s in "${SUCCESS_ARR[@]}"; do
    echo "    · $s"
  done
  echo ""
fi

if [ ${#USER_SKIPPED_ARR[@]} -gt 0 ]; then
  echo "⊘ 用户跳过 (可选): ${#USER_SKIPPED_ARR[@]} 个"
  for s in "${USER_SKIPPED_ARR[@]}"; do
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
echo "  总计: $TOTAL  |  成功: ${#SUCCESS_ARR[@]}  |  跳过(用户): ${#USER_SKIPPED_ARR[@]}  |  失败: ${#FAIL_ARR[@]}"
echo "================================="
