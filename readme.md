# Skills Bootstrap

> 一键安装Skills，快速搭建AI Agent本地工作环境。

## 环境要求

运行脚本前请确保以下环境已就绪，脚本会自动检测版本并跳过已满足的项：


| 依赖              | 最低版本   | 检查方式                 | 未满足时                        |
| --------------- | ------ | -------------------- | --------------------------- |
| Node.js         | 18.0.0 | `node -v`            | 手动安装 `brew install node`    |
| npm             | 9.0.0  | `npm -v`             | 随 Node.js 附带                |
| Git             | 2.30.0 | `git --version`      | 手动安装 `brew install git`     |
| Python          | 3.8.0  | `python3 --version`  | 手动安装 `brew install python3` |
| Claude Code CLI | —      | `claude --version`   | 手动安装 `npm install -g @anthropic-ai/claude-code@latest` |
| cc-switch       | —      | `ccswitch --version` | 手动安装 `npm install -g ccswitch@latest` |


## 使用方式

```bash
git clone git@github.com:ssj-rgb/skills-bootstrap.git
cd skills-bootstrap

# 一键安装
./install-skills.sh
```

脚本会**自动安装所有必装 Skills**，已安装的自动跳过。

---

## 必装（脚本安装）


| Skill Name       | 说明                                                            | 发行方       | 分类   | 类型    |
| ---------------- | ------------------------------------------------------------- | --------- | ---- | ----- |
| `skill-creator`  | 元技能 — 创建、修改和优化 Skills，支持从零搭建、编辑已有 Skill、运行评估测试、优化触发描述         | Anthropic | 效率工具 | Skill |
| `find-skills`    | 元技能 — 发现和安装 Skills，当需要寻找特定功能的 Skill 时使用                       | Vercel    | 效率工具 | Skill |
| `docx`           | Word 文档创建/读取/编辑：目录、页码、信头、内容提取、图片替换、修订批注                       | Anthropic | 文档处理 | Skill |
| `pptx`           | PowerPoint 演示文稿创建/读取/编辑：幻灯片排版、模板应用、内容提取与生成                    | Anthropic | 文档处理 | Skill |
| `pdf`            | 全功能 PDF 处理：文本/表格提取、合并/拆分、旋转、水印、创建、表单、加密/解密、OCR                | Anthropic | 文档处理 | Skill |
| `xlsx`           | Excel 电子表格创建/读取/编辑：公式、图表、数据透视表、格式化与数据分析                       | Anthropic | 文档处理 | Skill |
| `humanizer-zh`   | AI 写作去痕工具，识别并修复 24 种 AI 写作痕迹（内容/语言/风格/交流）                     | 藏师傅       | 文档处理 | Skill |
| `mcp-builder`    | 指导创建高质量 MCP 服务器，支持 Python（FastMCP）和 Node/TypeScript（MCP SDK）  | Anthropic | 产品开发 | Skill |
| `webapp-testing` | 通过 Playwright 对 Web 应用进行自动化交互测试，验证前端功能、调试 UI、捕获截图             | Anthropic | 产品开发 | Skill |
| `ui-ux-pro-max`  | UI/UX 设计智能助手，67 种样式、96 种调色板、57 种字体配对、99 条 UX 准则               | uipro     | 产品开发 | npm   |
| `gstack`         | 元技能 — Garry Tan (YC 总裁) 的 28+ 角色化斜杠命令集，将 Claude Code 变为虚拟工程团队 | Garry Tan | 产品开发 | Skill |


---

## 手动安装（按需自行安装）


| Skill Name               | 说明                                                               | 发行方            | 分类   | 类型        | 安装命令                                                                                                      |
| ------------------------ | ---------------------------------------------------------------- | -------------- | ---- | --------- | --------------------------------------------------------------------------------------------------------- |
| `andrej-karpathy-skills` | Karpathy 四条编程准则（编码前思考/简洁优先/精准修改/目标驱动），约 70 行 CLAUDE.md，74k+ Star | forrestchang   | 效率工具 | Plugin    | `/plugin install andrej-karpathy-skills@karpathy-skills`                                                  |
| `agent-reach`            | AI Agent 互联网访问插件，支持 Twitter/X、小红书、B站、Reddit、YouTube 等 13+ 平台     | 攀捻通            | 效率工具 | pip       | `pip install agent-reach && agent-reach install --env=auto`                                               |
| `openhuman`              | 开源桌面 AI 助手，本地记忆系统 + 118 个第三方集成，TokenJuice 节省约 80% token 消耗       | tinyhumansai   | 效率工具 | curl      | `curl -fsSL https://raw.githubusercontent.com/tinyhumansai/openhuman/main/scripts/install.sh | bash`      |
| `codegraph`              | 预索引代码知识图谱，约 35% 更少 token、约 70% 更少工具调用，100% 本地，支持 19+ 语言          | colbymchenry   | 效率工具 | npm       | `npx @colbymchenry/codegraph`                                                                             |
| `superpowers`            | 系统化软件开发方法论，7 阶段工作流（头脑风暴→Worktree→计划→子代理开发→TDD→审查→完成）             | obra           | 产品开发 | Plugin    | `/plugin install superpowers@claude-plugins-official`                                                     |
| `office-hours`           | 产品构思设计思维工具，通过结构化对话帮助打磨产品想法                                       | Meteorite Labs | 产品开发 | git-clone | `git clone https://github.com/MeteoriteLabs/AoA-Skills.git ~/.claude/plugins/aoa-skills`                  |
| `last30days`             | 跨平台研究代理，聚合 Reddit/X/YouTube/HN/Polymarket 等 10+ 平台近 30 天内容       | mvanhorn       | 效率工具 | Skill     | `npx skills add https://github.com/mvanhorn/last30days-skill --skill last30days -y -g`                    |
| `bb-browser`             | Browserbase 浏览器自动化技能集，支持反爬隐身、CAPTCHA 破解、住宅代理、UI 测试               | Browserbase    | 浏览器  | Skill     | `npx skills add browserbase/skills -y -g`                                                                 |
| `playwright-mcp`         | 微软官方 Playwright MCP 服务器，浏览器导航、截图、表单填写、点击交互、JS 执行                 | Microsoft      | 浏览器  | MCP       | `claude mcp add playwright -- npx @playwright/mcp@latest`                                                 |
| `chrome-devtools`        | Chrome DevTools Protocol MCP 服务器，页面操作、网络抓包、性能分析                  | Google         | 浏览器  | MCP       | `claude mcp add chrome-devtools --scope user npx chrome-devtools-mcp@latest`                              |
| `book2skill`             | 将书籍方法论蒸馏为可执行的 Agent Skills，六阶段 RIA-TV++ 流程，已产出 200+ 个 skill      | 仓鼠帝            | 知识蒸馏 | Skill     | `npx skills add https://github.com/kangarooking/cangjie-skill --skill book2skill -y -g`                   |
| `huashu-nuwa`            | 蒸馏公众人物思维方式（心智模型/决策启发式/表达DNA），六路采集→三重验证→构建→质检                     | 花叔             | 知识蒸馏 | Skill     | `npx skills add https://github.com/alchaincyf/nuwa-skill --skill huashu-nuwa -y -g`                       |
| `knowledge-site-creator` | 一句话生成知识学习网站，20-30 个核心概念 + 四种学习模式，一键 Vercel 部署                    | 向阳乔木           | 知识蒸馏 | Skill     | `npx skills add https://github.com/joeseesun/knowledge-site-creator --skill knowledge-site-creator -y -g` |


## 许可

MIT