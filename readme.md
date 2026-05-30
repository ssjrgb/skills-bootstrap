# 仓库说明

通过 `npx skills add` 一键安装 GitHub 仓库中的 Skill，快速扩展工具链。

## 快速开始

```bash
npx skills add <repo_url> --skill <skill_name> -y -g
```

## 参数说明

| 参数 | 含义 | 示例 |
|------|------|------|
| `<repo_url>` | Skill 所在的 GitHub 仓库地址 | `https://github.com/susaijie-rgb/perfectaichz_jnsc` |
| `<skill_name>` | 要安装的 Skill 名称 | `ui-ux-pro-max` |

- **`-y`** — 跳过交互式确认，自动同意安装
- **`-g`** — 全局安装，所有项目均可使用

## 使用示例

```bash
# 安装 UI/UX 设计智能助手
npx skills add https://github.com/susaijie-rgb/perfectaichz_jnsc --skill ui-ux-pro-max -y -g
```

## 其他推荐

> 或直接运行一键安装脚本：`./install-skills.sh`

### 必装

| Skill | 说明 | 安装命令 |
|-------|------|----------|
| `skill-creator` | 创建、修改和优化 Skills，支持从零搭建、编辑已有 Skill、运行评估测试、优化触发描述的准确性 | `npx skills add https://github.com/anthropics/skills --skill skill-creator -y -g` |
| `find-skills` | 发现和安装 Skills，当你需要寻找特定功能的 Skill 时使用 | `npx skills add https://github.com/vercel-labs/skills --skill find-skills -y -g` |
| `docx` | 创建、读取、编辑 Word 文档（.docx）：目录、标题、页码、信头等专业排版，内容提取与重组，图片插入/替换，修订与批注 | `npx skills add https://github.com/anthropics/skills --skill docx -y -g` |
| `pptx` | 创建、读取、编辑 PowerPoint 演示文稿（.pptx）：幻灯片排版、模板应用、内容提取与生成 | `npx skills add https://github.com/anthropics/skills --skill pptx -y -g` |
| `pdf` | 全功能 PDF 处理：文本/表格提取、合并/拆分、旋转、水印、创建、表单填写、加密/解密、图片提取、OCR | `npx skills add https://github.com/anthropics/skills --skill pdf -y -g` |
| `xlsx` | 创建、读取、编辑 Excel 电子表格（.xlsx）：公式、图表、数据透视表、格式化与数据分析 | `npx skills add https://github.com/anthropics/skills --skill xlsx -y -g` |
| `mcp-builder` | 指导创建高质量 MCP 服务器，让 LLM 通过工具与外部服务交互，支持 Python（FastMCP）和 Node/TypeScript（MCP SDK） | `npx skills add https://github.com/anthropics/skills --skill mcp-builder -y -g` |
| `webapp-testing` | 通过 Playwright 对 Web 应用进行自动化交互测试，验证页面行为、UI 交互和功能正确性 | `npx skills add https://github.com/anthropics/skills --skill webapp-testing -y -g` |
| `ui-ux-pro-max` | UI/UX 设计智能助手，提供 67 种样式、96 种调色板、57 种字体配对等设计系统支持 | `npm install -g uipro-cli`<br>`uipro init --ai all --global` |

### 可选安装

| Skill | 说明 | 安装命令 |
|-------|------|----------|
| `humanizer-zh` | AI 写作去痕工具，识别并修复 24 种 AI 写作痕迹（内容模式、语言语法、风格、交流），消除中文文本中的 AI 生成痕迹 | `npx skills add https://github.com/op7418/humanizer-zh --skill humanizer-zh -y -g` |
| `knowledge-site-creator` | 一句话生成完整知识学习网站，自动产出 20-30 个核心概念（描述+示例+测验），四种学习模式，支持一键 Vercel 部署 | `npx skills add https://github.com/joeseesun/knowledge-site-creator --skill knowledge-site-creator -y -g` |
| `book2skill` | 将书籍方法论蒸馏为可执行的 Agent Skills，六阶段 RIA-TV++ 蒸馏流程，已产出 200+ 个可调用 skill | `npx skills add https://github.com/kangarooking/cangjie-skill --skill book2skill -y -g` |
| `huashu-nuwa` | 蒸馏任何公众人物的思维方式（心智模型、决策启发式、表达DNA），四步法：六路采集→三重验证→构建Skill→质量验证 | `npx skills add https://github.com/alchaincyf/nuwa-skill --skill huashu-nuwa -y -g` |
| `last30days` | AI 跨平台研究代理，聚合 Reddit/X/YouTube/HN/Polymarket 等 10+ 平台近 30 天内容，生成综合摘要 | `npx skills add https://github.com/mvanhorn/last30days-skill --skill last30days -y -g` |
| `chrome-devtools` | MCP 服务器，让 AI Agent 通过 Chrome DevTools Protocol 控制浏览器，支持页面操作、网络抓包、性能分析等 | `claude mcp add chrome-devtools --scope user npx chrome-devtools-mcp@latest` |