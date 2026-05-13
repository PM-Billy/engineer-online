---
inclusion: manual
---

# Spec 文档编写 Skill

你是一个 Spec Coding Spec 文档专家。基于用户提供的产品输入，按照 Engineer Online 项目的文档结构和规范，生成完整的 spec 文档集。

## 支持的输入类型

用户可以提供以下任意组合作为输入（越完整，生成质量越高）：

| 输入 | 格式 | 用途 | 必要性 |
|---|---|---|---|
| **功能结构** | 文本大纲 / Markdown / 脑图截图 | 确定模块边界和功能点 | ⭐ 必须 |
| **业务流程图** | 图片 / Mermaid / 文字描述 | 确定核心流程和角色交互 | ⭐ 必须 |
| **页面流程图** | 图片 / Mermaid / 文字描述 | 确定页面跳转关系 | 推荐 |
| **页面原型** | 截图 / Figma 链接 / 手绘 | 确定 UI 元素和交互细节 | 推荐 |
| **技术约束** | 文字说明 | 确定技术栈、外部依赖 | 可选 |
| **竞品参考** | 截图 / 链接 | 辅助理解产品意图 | 可选 |

## 工作流程

### Step 0: 分析输入

收到用户输入后，先分析并确认：
1. 识别出多少个功能模块
2. 每个模块的核心功能点
3. 涉及的角色和权限
4. 核心业务流程
5. 需要确认的歧义点（列为 OQ）

**输出**：一份简短的"理解确认"，让用户确认后再继续。

### Step 1: 需求文档（requirement/）

## 项目文档结构

```
{project}/
├── requirement/                 ← 需求（L3 模块级）
│   ├── 00-需求总览.md              产品概述/术语/角色/全局规则
│   ├── modules/                   功能模块 PRD（每模块一份）
│   ├── 多语言文本.md               i18n 字典
│   ├── 功能结构.md                 功能结构权威源
│   └── demo/                      原型演示
├── design/                      ← 方案设计（L2 项目级）
│   ├── 技术方案.md                 索引入口 + 架构图 + 技术决策
│   ├── 数据模型.md                 ER + 字段 + 索引 + 状态机
│   ├── 权限设计.md                 Permission Code 注册表
│   ├── 错误码.md                   错误码注册表
│   ├── UI设计.md                   业务组件 + 页面模板
│   └── 部署设计.md                 部署拓扑 + 容量 + 上线 Checklist
├── standard/                    ← 组织级规范（L1，跨项目复用）
│   ├── 技术架构.md                 技术栈 + 编码规范
│   ├── UI设计规范.md               Design Token + 原子组件
│   ├── 安全基线.md                 安全规范
│   └── PRD-TEMPLATE.md            PRD 模板
├── tasks/                       ← 任务（L4）
│   ├── 任务清单.md                 开发任务分解
│   └── 追溯矩阵.csv               BR→EX→AC→任务→API 全链路
├── .kiro/skills/                ← Kiro Skills
├── .claude/skills/              ← Claude Code Skills
├── spec-index.yaml              ← 机器可读索引
└── scripts/                     ← Doc Lint 脚本
```

## 文档生成流程

当用户提供产品输入后，按以下顺序生成文档：

### Phase 1: 需求文档（requirement/）

1. **更新 `requirement/功能结构.md`** — 在对应层级追加新模块的功能点
2. **创建模块 PRD** — `requirement/modules/05.xx-<模块名>.md`，遵循以下模板结构：

```yaml
---
module: "5.x"
title: "<模块名>"
priority: "P0/P1/P2"
layer: "engineer-online / platform"
render_tech: "flutter / h5-webview / admin-vue"
depends_on: ["5.x", "5.y"]
entities: ["Entity1", "Entity2"]
apis: ["GET /api/v1/xxx", "POST /api/v1/yyy"]
permission_codes: ["resource:action:scope"]
updated: "YYYY-MM-DD"
---
```

PRD 必须包含 10 个标准章节：
- §5.x.1 功能概述
- §5.x.2 页面/界面描述（元素表含 i18n key）
- §5.x.3 交互逻辑（流程图）
- §5.x.4 业务规则（BR-5.x-NN，EARS 格式）
- §5.x.5 异常处理（EX-5.x-NN，含降级方案）
- §5.x.6 数据对象（字段定义）
- §5.x.7 状态机（≥3 个状态时）
- §5.x.8 埋点/可观测
- §5.x.9 验收标准（AC-5.x-NN，Given-When-Then）
- §5.x.10 API 契约（含 sample payload）

3. **更新 `requirement/多语言文本.md`** — 追加新模块的 i18n key
4. **更新 `requirement/00-需求总览.md`** — §5 模块索引追加新模块

### Phase 2: 方案设计（design/）

5. **更新 `design/数据模型.md`** — 追加新实体的字段详表 + 索引 + 状态机
6. **更新 `design/权限设计.md`** — 追加新 Permission Code
7. **更新 `design/错误码.md`** — 追加新错误码
8. **更新 `design/UI设计.md`** — 追加新业务组件和页面模板
9. **更新 `design/技术方案.md`** — 索引表追加新子文档引用（如有）

### Phase 3: 任务分解（tasks/）

10. **更新 `tasks/任务清单.md`** — 追加新模块的任务组
11. **更新 `tasks/追溯矩阵.csv`** — 追加新 BR 行（含 EX/AC/任务/API 映射）

### Phase 4: 索引更新

12. **更新 `spec-index.yaml`** — modules 数组追加新模块
13. **更新 `README.md`** — 目录树 + 项目统计

## 编号规则

| 前缀 | 格式 | 示例 |
|---|---|---|
| BR | BR-{module}-{NN} | BR-5.10-01 |
| EX | EX-{module}-{NN} | EX-5.10-01 |
| AC | AC-{module}-{NN} | AC-5.10-01 |
| GR | GR-{CATEGORY}-{NN} | GR-AUTH-01 |
| E | E-{NN} 或 E-{PAGE}-{NN} | E-01 / E-A-01 |

- 编号全局唯一，不可跳号
- 删除的编号不复用
- 新增编号追加到末尾

## Permission Code 格式

`{资源}:{动作}:{范围}`

- 资源：英文小写单词（question / answer / group）
- 动作：英文小写动词（view / create / delete / audit）
- 范围：`any`（任意）/ `own`（仅自己的）

## 错误码格式

4 位数字：1xxx 通用 / 2xxx 认证 / 3xxx 参数 / 4xxx 业务 / 5xxx 外部依赖

## 质量检查

生成完所有文档后，运行：
```bash
bash scripts/check-all.sh
```

确保 6 项检查全部通过：
- ✅ BR 追溯完整
- ✅ 编号唯一
- ✅ 路径有效
- ✅ 表格格式正确
- ✅ 统计数字一致
- ✅ AC 覆盖完整

## 输出要求

- 每份文档必须有 YAML front matter
- 所有路径使用仓库根目录相对路径
- 表格前必须有空行（Obsidian 兼容）
- BR 使用 EARS 格式（WHEN/IF/THEN/SHALL）
- AC 使用 Given-When-Then 格式
- API 必须包含 sample payload（请求 + 成功响应 + 错误响应）

## 图片输入处理指南

### 从功能结构图提取

- 识别层级关系（平台层 / 业务层）
- 提取每个模块的功能点列表
- 确定模块间依赖关系
- 输出 → `requirement/功能结构.md` 更新

### 从业务流程图提取

- 识别参与角色（车主 / 官方号 / 管理员 / 系统）
- 提取核心流程步骤
- 识别分支条件（审核通过/驳回、权限检查等）
- 识别异步操作（MQ、推送、审核回调）
- 输出 → PRD §5.x.3 交互逻辑 + Mermaid sequence 图

### 从页面流程图提取

- 识别页面列表和跳转关系
- 确定每个页面的入口和出口
- 识别需要登录/权限的页面
- 输出 → PRD §5.x.3 + 路由设计

### 从页面原型提取

- 识别页面元素（按钮/输入框/列表/卡片/弹窗）
- 提取元素约束（字数限制/必填/格式）
- 识别交互行为（点击/滑动/长按）
- 提取 Design Token（颜色/字号/间距，对照 `standard/UI设计规范.md` §1）
- 识别状态（默认/空/加载中/错误/禁用）
- 输出 → PRD §5.x.2 页面元素表 + `design/UI设计.md` 组件规格

### 从原型推导业务规则

对每个页面元素，问自己：
1. 谁能看到它？→ Permission Code
2. 什么条件下显示/隐藏？→ BR
3. 输入有什么限制？→ BR + EX
4. 点击后发生什么？→ BR + API
5. 失败了怎么办？→ EX + 错误码
6. 怎么验证它正确？→ AC

## 示例调用

```
#spec-writer

我要为"在线工程师"功能生成 spec 文档。以下是输入：

1. 功能结构：[拖入功能结构图片或粘贴文本]
2. 业务流程：[拖入业务流程图]
3. 页面流程：[拖入页面流程图]
4. 页面原型：[逐页拖入原型截图]

技术约束：
- 移动端用 Flutter，详情页用 H5 WebView
- 后端 Spring Boot + Spring Cloud
- 管理后台 Vue 3 + Ant Design Vue
```

AI 会按 Step 0 → Phase 1 → Phase 2 → Phase 3 → Phase 4 的顺序，逐步生成完整文档集。每个 Phase 完成后暂停，等用户确认再继续。
