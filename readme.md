# Skills Bootstrap

> Skill深度用户，快速初始化你的cc skill包。

## 使用方式

```bash
# 克隆仓库
git clone git@github.com:susaijie-rgb/skills-bootstrap.git
cd skills-bootstrap

# 一键安装
./install-skills.sh
```

脚本会**自动安装必装 Skills**，并对可选 Skills 逐个询问确认。

## 必装 Skills（默认安装）

| Skill Name | 说明 | 发行方 | Repo URL | 类型 |
|------------|------|--------|----------|------|
| `skill-creator` | 创建、修改和优化 Skills，支持从零搭建、编辑已有 Skill、运行评估测试、优化触发描述的准确性 | Anthropic | https://github.com/anthropics/skills | Skill |
| `find-skills` | 发现和安装 Skills，当你需要寻找特定功能的 Skill 时使用 | Vercel | https://github.com/vercel-labs/skills | Skill |
| `docx` | 创建、读取、编辑 Word 文档（.docx）：目录、标题、页码、信头等专业排版，内容提取与重组，图片插入/替换，修订与批注 | Anthropic | https://github.com/anthropics/skills | Skill |
| `pptx` | 创建、读取、编辑 PowerPoint 演示文稿（.pptx）：幻灯片排版、模板应用、内容提取与生成 | Anthropic | https://github.com/anthropics/skills | Skill |
| `pdf` | 全功能 PDF 处理：文本/表格提取、合并/拆分、旋转、水印、创建、表单填写、加密/解密、图片提取、OCR | Anthropic | https://github.com/anthropics/skills | Skill |
| `xlsx` | 创建、读取、编辑 Excel 电子表格（.xlsx）：公式、图表、数据透视表、格式化与数据分析 | Anthropic | https://github.com/anthropics/skills | Skill |
| `mcp-builder` | 指导创建高质量 MCP 服务器，让 LLM 通过工具与外部服务交互，支持 Python（FastMCP）和 Node/TypeScript（MCP SDK） | Anthropic | https://github.com/anthropics/skills | Skill |
| `webapp-testing` | 通过 Playwright 对 Web 应用进行自动化交互测试，验证页面行为、UI 交互和功能正确性 | Anthropic | https://github.com/anthropics/skills | Skill |
| `ui-ux-pro-max` | UI/UX 设计智能助手，提供 67 种样式、96 种调色板、57 种字体配对等设计系统支持 | uipro | npm | npm 工具 |

## 可选 Skills（按需）

| Skill Name | 说明 | 发行方 | Repo URL | 类型 |
|------------|------|--------|----------|------|
| `humanizer-zh` | AI 写作去痕工具，识别并修复 24 种 AI 写作痕迹（内容模式、语言语法、风格、交流），消除中文文本中的 AI 生成痕迹 | 藏师傅 | https://github.com/op7418/humanizer-zh | Skill |
| `knowledge-site-creator` | 一句话生成完整知识学习网站，自动产出 20-30 个核心概念（描述+示例+测验），四种学习模式，支持一键 Vercel 部署 | 向阳乔木 | https://github.com/joeseesun/knowledge-site-creator | Skill |
| `book2skill` | 将书籍方法论蒸馏为可执行的 Agent Skills，六阶段 RIA-TV++ 蒸馏流程，已产出 200+ 个可调用 skill | 仓鼠帝 | https://github.com/kangarooking/cangjie-skill | Skill |
| `huashu-nuwa` | 蒸馏任何公众人物的思维方式（心智模型、决策启发式、表达DNA），四步法：六路采集→三重验证→构建Skill→质量验证 | 花叔 女娲skill | https://github.com/alchaincyf/nuwa-skill | Skill |
| `last30days` | AI 跨平台研究代理，聚合 Reddit/X/YouTube/HN/Polymarket 等 10+ 平台近 30 天内容，生成综合摘要 | mvanhorn | https://github.com/mvanhorn/last30days-skill | Skill |
| `chrome-devtools` | MCP 服务器，让 AI Agent 通过 Chrome DevTools Protocol 控制浏览器，支持页面操作、网络抓包、性能分析等 | Google | npm | MCP |

## 手动安装

也可以单独安装某个 Skill：

```bash
# Skill 类
npx skills add <repo_url> --skill <skill_name> -y -g

# npm 工具类
npm install -g uipro-cli && uipro init --ai all --global

# MCP 类
claude mcp add chrome-devtools --scope user npx chrome-devtools-mcp@latest
```

## 许可

MIT
