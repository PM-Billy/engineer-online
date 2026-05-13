---
date: "2026-05-12"
participants: "Billy, Kiro"
topic: "v2.0.0 目录结构重构 + plan/ 完善 + standard/ 完善 + 一致性修复 + CLAUDE.md 合并删除"
previous_session: "session-log-2026-05-11.md"
---

# 会话记录 2026-05-12

## 概览

本日会话围绕项目文档结构的生产级重构展开，从分析现状到完整迁移，最终发布 v2.0.0 和 v2.1.0。共完成 6 项大改进：

| # | 改动 | 性质 | 影响范围 |
|---|---|---|---|
| 1 | 目录结构重构（全英文目录名） | 结构性 | 全部文件 |
| 2 | plan/ 子文档完善（权限码/数据模型/部署拓扑） | 内容补全 | plan/ |
| 3 | standard/ 安全基线完善 | 内容补全 | standard/ |
| 4 | 一致性修复（BR矛盾/版本号/路径/追溯） | 质量修复 | spec/ + tasks/ |
| 5 | CLAUDE.md 合并到 README 后删除 | 精简 | 根目录 |
| 6 | CONTRIBUTING.md 合并到 README 后删除 | 精简 | 根目录 |

---

## 1. 目录结构重构（v2.0.0）

### 决策记录

| 决策点 | 选择 | 理由 |
|---|---|---|
| 目录命名语言 | 全英文 | 与国际惯例一致，AI/工具链友好 |
| 文件名语言 | 保持中文 | 迁移成本低，与历史评审一致 |
| 迁移节奏 | 一个大 PR | 最快最完整 |
| standard/ vs plan/ | 分开 | 按变化频率分层（年 vs 季） |
| 空目录 | 建占位文件 | 保持结构完整 |

### 迁移映射

```
旧路径                              → 新路径
requirement/00-需求总览.md          → spec/00-需求总览.md
requirement/05.*.md                → spec/modules/05.*.md
requirement/多语言文本.md           → spec/多语言文本.md
requirement/需求追溯.md             → spec/需求追溯.md
requirement/demo/*                 → spec/demo/*
source/功能结构.md                  → spec/功能结构.md
source/global/技术架构.md           → standard/技术架构.md
source/global/UI设计规范.md         → standard/UI设计规范.md
source/PRD-TEMPLATE.md             → standard/PRD-TEMPLATE.md
source/global/assets/architecture/ → asset/architecture/
source/global/assets/ui-spec/      → asset/ui-spec/
source/prototype/                  → asset/prototype/
source/业务流程.png + 页面流程.png  → asset/flowchart/
技术方案.md                         → plan/技术方案.md
任务清单.md                         → tasks/任务清单.md
```

### 新增文件

- `index/spec-index.yaml` — 机器可读模块索引
- `CONTRIBUTING.md` — 贡献流程（后合并到 README）
- `.gitignore` — 忽略 .DS_Store 等
- `plan/permission.md` → 后改为 `plan/权限码.md`
- `plan/data-model.md` → 后改为 `plan/数据模型.md`
- `plan/deployment.md` → 后改为 `plan/部署拓扑.md`
- `standard/security-baseline.md` → 后改为 `standard/安全基线.md`

---

## 2. plan/ 子文档完善

从 `plan/技术方案.md` 拆分出 3 份独立 SSOT 文档：

| 文档 | 来源 | 内容 |
|---|---|---|
| `plan/权限码.md` | 技术方案 §5 | 19 条 Permission Code + 角色矩阵 + 实现约定 + 变更流程 |
| `plan/数据模型.md` | 技术方案 §2 | 7 实体 ER + 字段详表 + 索引 + 状态机 + 建库约束 |
| `plan/部署拓扑.md` | 技术方案 §3 | 拓扑图 + 容量规划 + 流量路径 + 环境矩阵 + 扩缩容 + 上线 Checklist |

`plan/技术方案.md` 改为索引式，§2/§3/§5 各保留摘要 + 链接到子文档。

---

## 3. standard/ 安全基线完善

`standard/安全基线.md` 从占位升级为完整文档（11 章）：
- 认证与授权（JWT/网关/服务间/Permission Code）
- 数据安全（传输加密/存储加密/脱敏）
- 输入校验与注入防护（XSS/SQL/CSRF）
- 文件上传安全
- 接口安全（限流/防重放/CORS）
- 日志与审计
- 依赖安全
- 密钥管理
- 安全事件响应
- 安全自检清单
- 变更流程

---

## 4. 一致性修复（v2.1.0）

| 问题 | 修复 |
|---|---|
| BR-5.4-03 采纳规则矛盾 | OQ-03 结论改为"单采纳" |
| 00-需求总览.md 版本号不一致 | 统一为 1.4.0 / 2026-05-11 |
| 任务清单残留 prd/ 路径 | TOOL-04/05/06 修正 |
| 00-需求总览.md §5 模块链接 | 改为 modules/ 相对路径 |
| spec-index.yaml 缺少维度 | 新增 ai_focus_sections |
| Permission Code 计数错误 | 20 → 19 |

---

## 5. CLAUDE.md 处理

- 先合并到 README（新增"AI 工作指引"章节）
- 再缩减为跳转文件
- 最终删除（开发人员不一定使用 Claude）

---

## 6. CONTRIBUTING.md 处理

- 内容合并到 README "变更与维护"章节
- 文件删除

---

## 最终目录结构

```
engineer-online/
├── README.md
├── CHANGELOG.md
├── .gitignore
├── spec/
│   ├── 00-需求总览.md
│   ├── modules/ (9 份 PRD)
│   ├── 多语言文本.md
│   ├── 需求追溯.md
│   ├── 功能结构.md
│   └── demo/
├── standard/
│   ├── 技术架构.md
│   ├── UI设计规范.md
│   ├── PRD-TEMPLATE.md
│   └── 安全基线.md
├── plan/
│   ├── 技术方案.md
│   ├── 权限码.md
│   ├── 数据模型.md
│   └── 部署拓扑.md
├── tasks/
│   └── 任务清单.md
├── prompts/ (8 份模板 + README)
├── asset/
│   ├── architecture/
│   ├── prototype/
│   ├── flowchart/
│   └── ui-spec/
├── index/
│   └── spec-index.yaml
└── _archive/
```

---

## 待办（下次会话）

- [ ] 需求追溯矩阵全面同步（补 5.9 模块 + BR-5.4-14~20 + 修正 5.3 标题长度）
- [ ] 建立 doc lint 脚本（编号唯一性 + 引用完整性）
- [ ] 功能结构.md 与 00-需求总览.md §2 去重（明确单一权威源）
- [ ] 补充中心化错误码注册表
- [ ] 统一时间格式规则为全局规则 GR-TIME-01
- [ ] 补充 cursor 分页响应格式标准定义
- [ ] 确保所有模块 §5.x.10.1 有完整 API sample payload
