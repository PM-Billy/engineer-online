# Engineer Online — Spec Coding 需求输入规范文档集

> **用途**：本文档集作为标准化的 Spec Coding 需求输入，包含完整的 PRD、技术架构、UI 规范、任务清单与可复用的角色 Prompt 模板。
> **目标**：让 AI 编码助手能精确理解需求并生成高质量代码；让产品经理输出结构统一的 PRD；让开发者快速理解需求并进入 spec coding。
> **版本**：2.3.0（详见 [CHANGELOG.md](CHANGELOG.md)）
> **维护人**：Billy

---

## 📁 文档结构

```
engineer-online/
├── README.md                          ← 你正在读的文件（文档索引与导读）
├── CHANGELOG.md                       ← 版本变更记录
├── .gitignore
│
├── requirement/                              ← 需求规范（L3 模块级，按迭代变化）
│   ├── 00-需求总览.md                      产品概述/术语表/角色权限/全局规则/NFR
│   ├── modules/                        功能模块 PRD
│   │   ├── 05.01-圈子管理(管理后台).md         [平台层] 圈子（Group）管理与配置
│   │   ├── 05.02-圈子首页.md               [在线工程师层] 圈子首页问题列表
│   │   ├── 05.03-问题发布.md               [在线工程师层] 提问页
│   │   ├── 05.04-问题详情.md               [在线工程师层] 详情/回答/回复/投票/采纳
│   │   ├── 05.05-搜索.md                  [在线工程师层] 关键词搜索
│   │   ├── 05.06-消息通知.md               [在线工程师层] 消息中心
│   │   ├── 05.07-问题管理（管理后台）.md        [平台层] 问题审核/管理
│   │   ├── 05.08-回答管理（管理后台）.md        [平台层] 回答审核/推送
│   │   └── 05.09-用户管理（管理后台）.md        [平台层] 用户管理/官方号设置
│   ├── 多语言文本.md                    用户端中/英/泰 + 后台中/英 UI 文本字典
│   ├── 功能结构.md                      功能结构权威源
│   └── demo/                           原型演示（HTML）
│
├── standard/                          ← 组织级规范（L1，跨项目复用，按年变化）
│   ├── 技术架构.md                      技术架构与编码规范
│   ├── UI设计规范.md                    UI 设计规范与组件库规格
│   ├── PRD-TEMPLATE.md                 PRD 模板
│   └── 安全基线.md                      安全基线规范
│
├── design/                              ← 方案设计（L2，按季变化）
│   ├── 技术方案.md                      字段类型 ER / Permission Code / 部署拓扑 / 技术决策
│   ├── 权限设计.md                        Permission Code 完整注册表（SSOT）
│   ├── 数据模型.md                      ER + 字段类型 + 索引 + 状态机（SSOT）
│   ├── 错误码.md                        错误码注册表（SSOT）
│   ├── UI设计.md                        业务组件 + 页面模板
│   └── 部署设计.md                      物理部署 + 容量规划 + 上线 Checklist
│
├── tasks/                             ← 任务级规范（L4，按天变化）
│   ├── 任务清单.md                      开发任务清单（含 Spec Coding 分配建议）
│   └── 追溯矩阵.csv                    BR → EX → AC → 任务 → API 全链路追溯（SSOT）
│
├── .kiro/skills/                       ← Kiro Skills（7 个角色模板）
├── .claude/skills/                     ← Claude Code Skills（7 个角色模板）
│
├── asset/                             ← 所有图片与资源
│   ├── architecture/                   架构图
│   ├── prototype/                      UI 原型截图
│   ├── flowchart/                      业务/页面流程图
│   └── ui-spec/                        UI 规范图
│
├── spec-index.yaml                    ← 机器可读索引（AI 友好）
│
└── _archive/                          ← 历史会话记录与备份（仅作参考）
```

---

## 🚪 快速入口

| 使用者 | 推荐入口 | 用途 |
|------|---------|------|
| 接到开发任务的成员 | `tasks/任务清单.md` | 找到任务编号、输入文档、依赖和验收标准 |
| 产品 / 项目成员 | `requirement/00-需求总览.md` | 先理解产品边界、角色、流程、全局规则 |
| 具体开发角色 | `.kiro/skills/` | 在 Kiro 聊天中输入 `#` 选择对应角色 Skill |
| AI 编码助手 | `spec-index.yaml` | 一次读入建立全局模块索引 |

---

## 🔗 标准开发路径（推荐）

| 步骤 | 文档 | 目的 |
|------|------|------|
| 1 | `tasks/任务清单.md` | 确认任务编号、角色、依赖、输入文档、验收标准 |
| 2 | `requirement/modules/05.01~05.09` | 打开对应模块 PRD，理解页面、流程、BR / EX / AC |
| 3 | `requirement/00-需求总览.md` | 补看术语、角色权限、全局规则、NFR |
| 4 | `design/` 下相关文档 | 后端查 `权限设计.md` / `数据模型.md` / `错误码.md`；前端查 `UI设计.md`；运维查 `部署设计.md`；索引见 `技术方案.md` |
| 5 | `standard/技术架构.md` | 查项目级技术栈、接口规范、错误码、安全与性能要求 |
| 6 | `standard/UI设计规范.md` | 前端任务补看页面模板、组件规格、Design Token |
| 7 | `requirement/多语言文本.md` | 前端任务补看 UI 文案和 i18n key |
| 8 | `.kiro/skills/` | 在 Kiro 中用 `#flutter-dev` 等 Skill 触发 AI 生成代码 |
| 9 | `tasks/追溯矩阵.csv` | 改需求或补规则时定位影响范围 |

---

## 🤖 Spec Coding 使用方式

### Skill 驱动（推荐）

在 Kiro 聊天中输入 `#` 选择对应角色 Skill：

```
#flutter-dev 请完成任务 QLIST-04（首页页面）
```

```
#h5-dev 请完成任务 QDETAIL-05（详情页）
```

```
#backend-dev 请完成任务 QPOST-02（问题创建 API）
```

### 通用 Prompt 模板

```
请基于以下文档完成开发任务 [{任务编号}]：

- 任务来源：tasks/任务清单.md 中的 {任务编号}
- PRD 需求：requirement/modules/{对应模块}.md
- 产品总览：requirement/00-需求总览.md（特别是 1.4 术语、1.5 角色权限、6 全局规则）
- 方案设计：design/（后端必看 `权限设计.md` + `数据模型.md` + `错误码.md`；前端必看 `UI设计.md`）
- 技术规范：standard/技术架构.md 的 {章节}
- UI 规范：standard/UI设计规范.md 的 {章节}
- 多语言文本：requirement/多语言文本.md
- API 契约样例：参考 5.x.10.1 节

请严格遵循文档中的：
1. 数据对象字段定义和命名规范
2. 业务规则（BR-x.x-xx）
3. 异常处理（EX-x.x-xx）
4. 验收标准（AC-x.x-xx）
5. Design Token（颜色、字体、间距、圆角）
6. Permission Code（鉴权码）
7. i18n key（UI 文本）

输出末尾请按对应 prompt 模板的"自检清单"逐项汇报。
```

### 文档间的交叉引用关系

```
PRD 功能模块 → 驱动 → 技术架构（API / 数据库 / 缓存设计）
PRD 页面描述 → 驱动 → UI 规范（组件规格 / 样式 Token）
PRD 验收标准 → 驱动 → 任务清单（测试用例生成）
PRD 全局规则 → 驱动 → Permission Code → 鉴权拦截器
PRD i18n key → 驱动 → 前端 locales/*.json
PRD Traceability → 支持 → 变更影响分析
技术架构 + UI 规范 → 驱动 → 任务清单（具体开发任务）
```

---

## 🤖 AI 工作指引

### 仓库性质

本仓库是 **Engineer Online 产品的文档与规范仓库**，用于存放 Spec Coding PRD 模板集。仓库中**没有可编译的代码、没有包管理器、没有测试**。内容包括产品需求文档、技术设计方案、任务清单以及供 AI 生成代码时使用的 Prompt 模板。实际的代码开发在其它仓库中进行。

### 文档分层

| 层级 | 目录 | 变化频率 | 内容 |
|---|---|---|---|
| L1 组织级 | `standard/` | 年 | 技术栈、编码规范、UI 规范、安全基线 |
| L2 项目级 | `design/` | 季 | 本次需求的 ER、Permission Code、部署、技术决策 |
| L3 模块级 | `requirement/` | 迭代 | 功能 PRD（BR/EX/AC/API）、i18n、追溯 |
| L4 任务级 | `tasks/` | 天 | 任务卡、依赖、估时 |

### 文档约定

#### Front Matter

PRD 文件（`requirement/modules/05.*.md`、`requirement/00-需求总览.md`）均包含 YAML 前置元数据：

```yaml
---
module: "5.4"
title: "问题详情"
priority: "P0"
layer: "engineer-online"
---
```

#### 编号体系补充

**文件名与引用约定**：文件名使用前导零排序（`05.01-xxx.md`），文档内部及交叉引用时省略前导零（`5.1`、`BR-5.1-01`）。

#### Permission Code 格式

格式为 `{资源}:{动作}:{范围}`，例如：`question:create:any`、`answer:accept:own`、`group:manage:any`。完整列表见 `design/权限设计.md`。

### AI 快速入口

读取 `spec-index.yaml` 可一次获取所有模块的路径、依赖、对应 Prompt 模板。

### _archive/ 使用说明

`_archive/` 存放历史会话记录与已废弃文档。出现规则冲突时，以当前规范（`requirement/`、`standard/`、`design/`）为准，`_archive/` 仅用于追溯设计决策理由。

---

## 📐 编号体系速查

| 前缀 | 含义 | 示例 |
|------|------|------|
| BR | 业务规则 | BR-5.2-01 |
| EX | 异常场景 | EX-5.3-01 |
| AC | 验收标准 | AC-5.4-01 |
| GR | 全局规则 | GR-AUTH-01 |
| RR | 角色规则 | RR-01 |
| E | 页面元素（页面内唯一） | E-01 / E-A-01（多页面） |
| SEC | 安全需求 | SEC-01 |
| OPS | 运维需求 | OPS-01 |
| SEO | SEO 需求 | SEO-01 |
| OQ | 待确认事项 | OQ-01 |

> **文件名 vs 编号约定**：文件名前导 0（如 `05.01-xxx.md`）仅用于排序；文档内部及交叉引用使用 `5.1`、`BR-5.1-01`（不带前导 0）。

---

## 🔐 Permission Code 速查

完整列表见 `design/权限设计.md`。命名规则 `{资源}:{动作}:{范围}`：

| 高频码 | 含义 |
|-------|------|
| `question:create:any` | 发布问题 |
| `question:audit:any` | 审核问题（管理员） |
| `answer:create:any` | 回答问题（仅官方号） |
| `answer:accept:own` | 采纳自己问题下的回答 |
| `vote:cast:any` | 投票（赞/踩） |
| `group:manage:any` | 管理圈子 |

---

## 📊 项目统计

| 指标 | 数值 |
|------|------|
| 功能模块数 | 9 个 |
| 业务规则总数 | 88 条 |
| 异常处理场景 | 40 条 |
| 验收标准总数 | 63 条 |
| Permission Code | 19 条 |
| 数据实体 | 7 个（Group, GroupTranslation, Question, Answer, Vote, Notification, AuditLog） |
| i18n key | ~150 条（用户端 zh/en/th，后台 zh/en） |
| 开发任务数 | 87 个 |
| 待确认事项 | 9 关闭 / 1 推迟 / 1 待讨论 |

### 客户端实现技术分布

| 模块 | 实现技术 |
|------|---------|
| 5.2 圈子首页 | 🧩 Flutter 原生 |
| 5.3 问题发布 | 🧩 Flutter 原生 |
| 5.4 问题详情 | 🌐 H5 WebView（Vue 3 + Vant，唯一非原生页面） |
| 5.5 搜索 | 🧩 Flutter 原生 |
| 5.6 消息通知 | 🧩 Flutter 原生 |
| 5.1 / 5.7 / 5.8 / 5.9 | 💻 运营管理后台（Vue 3 + Ant Design Vue） |

---

## ✅ 评审状态

- 模板 spec：✅ 已通过两轮 review
- PRD 内容：🟡 reviewing（V1.1 整改后等待复审）
- 技术架构：🟡 已编写，待联调验证
- UI 规范：🟡 已编写，组件库待落地
- 任务清单：🟡 已分解，待人员认领

---

## 🔄 变更与维护

### 同步更新规则

| 变更点 | 必须同步 |
|---|---|
| 新增/修改业务规则 (BR) | `tasks/追溯矩阵.csv` + `CHANGELOG.md` + 对应 AC |
| 新增鉴权点 | `design/权限设计.md` + `requirement/00-需求总览.md` 权限矩阵 |
| 新增 UI 文本 | `requirement/多语言文本.md`（全部语种） |
| 新增枚举/字段 | `requirement/00-需求总览.md` 术语表 + ER 图 + 相关 API |
| 新增/改模块 | `requirement/00-需求总览.md` + `README.md` |
| 新增/改目录或文件 | `README.md` + `spec-index.yaml` |

### 文档变更流程

1. **发起变更**：在 CHANGELOG.md 底部记录你要改什么（草稿状态）
2. **修改文档**：按上方同步规则修改所有受影响文件
3. **自检**：运行 `bash scripts/check-all.sh`
4. **提交 PR**：标题格式 `docs(scope): 简述`，scope 为 requirement/standard/design/tasks/prompts 之一
5. **Review**：至少 1 人 review 后合并

### 版本号规则

采用 SemVer：
- **Major (X.0.0)**：破坏性规则变更
- **Minor (1.X.0)**：新增模块/规则
- **Patch (1.1.X)**：错字/术语统一/引用修正

### 编号规则

- 编号全局唯一，不可跳号
- 删除的编号不复用
- 新增编号追加到末尾

### 术语规范

使用 `requirement/00-需求总览.md` 术语表中的受控词汇。禁止使用同义词替代。

> 详细评审清单见各 PRD 末尾。
