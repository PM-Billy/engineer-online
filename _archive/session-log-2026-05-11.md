# 在线工程师 PRD 模板 — 第四轮迭代会话记录

**日期**：2026-05-11
**参与者**：Billy, Claude
**主题**：v1.4.0 功能结构统一 + 原型路径修正 + 删除问题管理后台发表问题功能
**前序会话**：[session-log-2026-04-27.md](session-log-2026-04-27.md)

---

## 概览

本日会话围绕 `source/功能结构.md` 权威源对齐、文档路径治理和功能裁剪展开，最终发布 v1.4.0。共完成 5 项相互衔接的改进：

| # | 改动 | 性质 | 影响范围 |
|---|------|------|---------|
| 1 | 创建 `CLAUDE.md` | 仓库指引 | 新增文档 |
| 2 | 文档路径引用统一 | 路径治理 | 23 个 markdown 文件 |
| 3 | 按功能结构统一 PRD | 需求对齐 | 8 个 PRD 模块 |
| 4 | 删除问题管理后台发表问题功能 | 功能裁剪 | 05.07 PRD + API + Permission Code |
| 5 | 新增 5.9 用户管理模块 | 范围扩展 | 00-总览.md |

---

## 阶段一：CLAUDE.md 创建

### 1.1 用户请求

Billy 请求分析代码库并创建 `CLAUDE.md`，供未来 Claude Code 实例使用。

### 1.2 关键发现

本仓库为 **Engineer Online 产品的文档与规范仓库**，存放 AI Coding PRD 模板集，**没有可编译的代码、没有包管理器、没有测试**。Claude 据此创建了针对性的 `CLAUDE.md`，包含：

- 仓库性质说明
- 文件结构树
- 文档约定（Front Matter、编号体系）
- 架构概览（三层实现层级）
- 文档间交叉引用规则
- 任务工作流阅读顺序

### 1.3 语言选择

Billy 询问是否可用中文，确认后 `CLAUDE.md` 以中文撰写。

---

## 阶段二：文档目录结构更新

### 2.1 用户请求

Billy 更新了文档目录结构，要求同步更新相关文档中的路径引用。

### 2.2 路径规范化

实际目录结构已从早期 `ai-coding-prd-template/docs/` 演进为根目录下的 `requirement/`、`design/`、`task/` 等。Claude 发现 23 个 markdown 文件中仍残留 `docs/` 路径引用。

**批量替换策略**：
- `docs/requirements/engineer-online/prd/` → `requirement/`
- `docs/requirements/engineer-online/assets/` → `requirement/source/`
- `docs/global/` → `requirement/source/global/`
- `docs/_archive/` → `_archive/`

**难点**：`task/任务清单.md` 中存在反引号包裹的路径（如 `` `docs/requirements/...` ``），grep 初始过滤时因正则未包含反引号而遗漏。后通过扩展匹配模式补全。

---

## 阶段三：按功能结构统一 PRD

### 3.1 用户请求

Billy 在 `requirement/source/功能结构.md` 中定义了权威的功能需求描述，要求以之为准检查并修正 `requirement/` 目录下所有 PRD。同时 `source/flowchart/` 下的流程图已更新，要求检查 PRD 中的 Mermaid 流程图与之一致性。

### 3.2 并行检查策略

Claude 启动 8 个并行子代理，分别检查 8 个模块 PRD 与功能结构文档的差异。每个子代理负责一个模块，输出不一致项清单。

### 3.3 各模块修正摘要

**`05.01-圈子配置.md`**：
- 封面图必填（否 → 是）
- 功能启用选项更新："回复 / 发图片 / 发视频 / 发投票" → "回复 / 图片 / 视频 / 选择车辆 / 车辆累计公里数"
- 删除 `publishable_types` 和 `post_settings` 字段
- 新增 `follow_up_roles`（追问权限）字段
- 权限术语统一："所有用户"→"全部用户"、"车主用户"→"车主"、"停用"→"禁用"

**`05.02-圈子首页.md`**：
- `BR-5.2-03`：k 缩写 → 千分号格式（如 1.2k → 1,200）
- `BR-5.2-02`：回答预览规则改为"最多2条，已采纳优先，时间倒序"

**`05.03-问题发布.md`**：
- 标题限制：5-200 字符 → 5-400 字符
- `EX-5.3-02`：200 → 400 字符上限
- `EX-5.3-04`：视频 50MB → 5MB

**`05.04-问题详情与回答.md`**：
- `BR-5.4-09`：绝对时间 → 相对时间
- `E-11`："仅作者或管理员可见" → "仅作者可见"

**`05.05-搜索.md`**：
- `BR-5.5-03`："未隐藏未删除" → "审核通过且公开状态为公开"
- `BR-5.5-04`：ES time decay `scale=30d` → "365 天衰减至 0.5"，增加 `slop: 2`

**`05.06-消息通知.md`**：
- 触发时机："官方号回答了问题" → "官方号回答审核通过"

**`05.07-问题管理后台.md`**：
- 操作列新增：设为公开 / 取消公开 / 取消热门
- 筛项修正："标题/内容"→"标题"、"发布时间"→"创建时间"

**`05.08-回答管理后台.md`**：
- 回复人昵称搜索："模糊匹配" → "精确搜索"
- 操作列和批量操作新增"推送 UOP"

**`00-总览.md`**：
- 新增 `5.9 用户管理` 模块
- 功能结构与功能结构文档同步
- 模块总数 8 → 9

### 3.4 流程图一致性限制

Billy 更新了 `source/flowchart/` 下的业务流程图和页面流程图。Claude 尝试读取 PNG 图片内容以验证 Mermaid 流程图一致性，但 PNG 为二进制格式无法直接解析文本。最终通过功能结构文档的文本描述作为中间权威源完成对齐。

---

## 阶段四：删除问题管理后台发表问题功能

### 4.1 用户请求

Billy 通知问题管理的原型已修改，去掉了"发表问题"功能，要求同步修改需求文档。同时要求修正所有 PRD 中的原型图片路径。

### 4.2 功能裁剪范围

**`05.07-问题管理后台.md`** 中彻底删除发表问题/代发功能：

1. **删除页面 B**：问题新建/编辑/查看抽屉面板，含全部元素 `E-B-01~E-B-11`
2. **删除业务规则**：`BR-5.7-05`（管理员代发规则）、`BR-5.7-06`（代发标识规则）
3. **删除验收标准**：`AC-5.7-10`（发表问题验收）
4. **删除 API**：`POST /api/v1/admin/questions`（代发/发表问题）
5. **删除 Permission Code**：`question:post-on-behalf:any`
6. **更新 Front Matter**：移除上述 API 和 Permission Code

### 4.3 原型路径修正

所有 PRD 中的原型图片路径统一修正：
- `../assets/prototype/` → `source/prototype/`

---

## 阶段五：CHANGELOG 与归档

### 5.1 CHANGELOG 更新

新增 `[1.4.0] - 2026-05-11` 版本条目，包含：
- **Added**：5.9 用户管理模块
- **Changed**：8 个 PRD 模块的具体修正项、原型路径统一、目录引用修正
- **Removed**：05.07 的发表问题/代发功能及相关 API、Permission Code；05.01 的 `publishable_types` 和 `post_settings` 字段

### 5.2 会话归档

按 `_archive/` 目录已有格式生成本会话记录。

---

## 附录：受影响文件清单

- `CLAUDE.md`（新增）
- `README.md`
- `CHANGELOG.md`
- `requirement/00-总览.md`
- `requirement/05.01-圈子配置.md`
- `requirement/05.02-圈子首页.md`
- `requirement/05.03-问题发布.md`
- `requirement/05.04-问题详情与回答.md`
- `requirement/05.05-搜索.md`
- `requirement/05.06-消息通知.md`
- `requirement/05.07-问题管理后台.md`
- `requirement/05.08-回答管理后台.md`
- `task/任务清单.md`
- `requirement/需求追溯.md`
- `技术方案.md`
- `requirement/source/global/技术架构.md`
- `implement/prompts/Flutter页面.md`
- `implement/prompts/H5详情页.md`
- `implement/prompts/管理后台页面.md`
- `implement/prompts/后端接口与服务.md`
- `implement/prompts/数据库设计.md`
- `implement/prompts/测试用例.md`
- `implement/prompts/API模拟数据.md`
